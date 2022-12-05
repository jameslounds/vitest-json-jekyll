---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---
<style>
  svg {
    width: 1rem;
    height: 1rem;
    display: inline-block;
    margin-bottom: -4px;
    padding-right: 0.25rem;
  }
</style>
{% include accordion.html %}
<ul class="jekyllcodex_accordion">
  <li>
    {% for testGroup in site.data.results.testResults %}
      <input id="accordion{{ forloop.index }}" type="checkbox"/>
      <label for="accordion{{ forloop.index }}">
        {% if testGroup.status =='passed' %}
          <svg viewBox="0 0 10 10" fill="none" title="All Tests In This File Passed">
            <path d="M 2 6 l 3 2 l 5 -8" fill="none" stroke="#0e8c41"/>
          </svg>
        {% else %}
          <svg viewBox="0 0 10 10" title="Some Tests In This File Failed">
            <path role="button" d="M 8 8 l -6 -6 M 8 2 l -6 6" fill="none" stroke="#ca3d16"/>
          </svg>
        {% endif %}
        {{ testGroup.name | regex_replace: '.*(apps|packages)[/]', '' }}
        <span class="duration">({{ testGroup.endTime | minus : testGroup.startTime }} ms)</span>
      </label>
      <div>
        <ul class="jekyllcodex_accordion">
          {% for test in testGroup.assertionResults %}
            <li>
              <input id="accordion{{ testGroup.startTime }}{{ forloop.index }}" type="checkbox" {% if test.status == 'failed' %}checked="true"{% endif %}/><label for="accordion{{ testGroup.startTime }}{{ forloop.index }}" {% if test.status == 'passed' %}class="no-expand"{% endif %}>
                {% if test.status =='passed' %}
                  <svg viewBox="0 0 10 10" fill="none" title="This Test Passed">
                    <path d="M 2 6 l 3 2 l 5 -8" fill="none" stroke="#0e8c41"/>
                  </svg>
                {% else %}
                  <svg viewBox="0 0 10 10" title="This Test Failed">
                    <path role="button" d="M 8 8 l -6 -6 M 8 2 l -6 6" fill="none" stroke="#ca3d16"/>
                  </svg>
                {% endif %}
                {{ test.ancestorTitles | join: " > "  | remove_first: " > " }} > {{ test.title }}
                <span class="duration">({{ test.duration }} ms)</span>
              </label>
              {% if test.status == 'failed' %}
                <div>
                  <code>{{ test.failureMessages}} at line {{ test.location.line }}:{{ test.location.column }}</code>
                </div>
              {% endif %}
            </li>
          {% endfor %}
        </ul>
      </div>
    {% endfor %}
  </li>
</ul>