Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00ACFE5344
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 20:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbfJYSIm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 14:08:42 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:32870 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733042AbfJYSIl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 14:08:41 -0400
Received: by mail-qk1-f202.google.com with SMTP id o184so2931232qke.0
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2019 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zx/GmBdwVXl5fzQg3LM8CAvYi6dpZSW9jacC09byqgs=;
        b=Y2AsIZxAzYxd5BvTZBDU8UZQJPi2TDb0wmmAZLqLRwwhpbM4wObYKLv4ed8qaJP0o7
         lSDNMXhScl4dwTk3ovW7Ioaw0qsQeFQr/FJstzKmegsfibfzya1ECc6rMNg8h9ELlKjN
         tu5Rpo4uxWwrZ1IRtr0rmv1Xww/ELBYgEHZp8HnFeT82Qb5J/BuT2uHqDHTLLGMkNzpi
         XRfhWfvkER/fDer9ugBp9updtiPJVRdas6WYMqzcQzSu9bb0JTsBHRwVMNACNUmCIfkv
         BjaZL6RSA1pigJscYRJrYLFBW/vBo+haAO3qBpsMa7QuwBGPpyRjdpdcfY2mwvqYbDgT
         EU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zx/GmBdwVXl5fzQg3LM8CAvYi6dpZSW9jacC09byqgs=;
        b=MsyxJQPchxLqkugGxYvqwbG42a0hnGKxEwXz66tuloI56giH31P0+spxi1qLTwPyHE
         q9xA09/ukYkpeTIqPruphjL8vFsZpRSKoOiaYbTKCeWLdGrVNF5IjOmsj2e+6MzJosLT
         2MOepG0kC0uo+EVmaK+eSOam0Jzg5cokqbi2r1l4JVWRs+2Ev0sdZCd7yL7qfPN3lIbH
         /Ba0RL6uyL14US8zJs7bTMAooSOlsK7kBu1OfG3F7MPWY1j434EmZKQ9FqoIlvivBE6M
         VFdxANpJjLpEvarVaHTHkq1EBJJ7ccyAFlAIY+19NjMseQEOenIakbaIvP1/HVkx6WAV
         /1eA==
X-Gm-Message-State: APjAAAXD+6+WVrRnTLhwfH2vyLcK8cSNaEUmHNslhqi8Ngu0E1ZQZ06R
        AxzIIk1Koy8NQzp42X4LTVrvfacvcQ5F
X-Google-Smtp-Source: APXvYqy0vo5GTPS69cbbE/Ny60uucWQcmo0gS/FCMFhiugkqyI7rUq+uAU14GdsfCiH8Nco8+kAbQAGxc2sR
X-Received: by 2002:a0c:d081:: with SMTP id z1mr4632643qvg.119.1572026918379;
 Fri, 25 Oct 2019 11:08:38 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:08:19 -0700
In-Reply-To: <20191025180827.191916-1-irogers@google.com>
Message-Id: <20191025180827.191916-2-irogers@google.com>
Mime-Version: 1.0
References: <20191024190202.109403-1-irogers@google.com> <20191025180827.191916-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v4 1/9] perf tools: add parse events handle error
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Parse event error handling may overwrite one error string with another
creating memory leaks. Introduce a helper routine that warns about
multiple error messages as well as avoiding the memory leak.

A reproduction of this problem can be seen with:
  perf stat -e c/c/
After this change this produces:
WARNING: multiple event parsing errors
event syntax error: 'c/c/'
                       \___ unknown term

valid terms: event,filter_rem,filter_opc0,edge,filter_isoc,filter_tid,filter_loc,filter_nc,inv,umask,filter_opc1,tid_en,thresh,filter_all_op,filter_not_nm,filter_state,filter_nm,config,config1,config2,name,period,percore
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 84 +++++++++++++++++++++-------------
 tools/perf/util/parse-events.h |  2 +
 tools/perf/util/pmu.c          | 30 +++++++-----
 3 files changed, 73 insertions(+), 43 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index db882f630f7e..c516d0cce946 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -182,6 +182,22 @@ static int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
 
 #define MAX_EVENT_LENGTH 512
 
+void parse_events__handle_error(struct parse_events_error *err, int idx,
+				char *str, char *help)
+{
+	char *new_str = NULL;
+
+	if (WARN(!str, "WARNING: failed to provide error string\n")) {
+		free(help);
+		return;
+	}
+	WARN_ONCE(err->str, "WARNING: multiple event parsing errors\n");
+	err->idx = idx;
+	free(err->str);
+	err->str = new_str ?: str;
+	free(err->help);
+	err->help = help;
+}
 
 struct tracepoint_path *tracepoint_id_to_path(u64 config)
 {
@@ -932,11 +948,11 @@ static int check_type_val(struct parse_events_term *term,
 		return 0;
 
 	if (err) {
-		err->idx = term->err_val;
-		if (type == PARSE_EVENTS__TERM_TYPE_NUM)
-			err->str = strdup("expected numeric value");
-		else
-			err->str = strdup("expected string value");
+		parse_events__handle_error(err, term->err_val,
+					type == PARSE_EVENTS__TERM_TYPE_NUM
+					? strdup("expected numeric value")
+					: strdup("expected string value"),
+					NULL);
 	}
 	return -EINVAL;
 }
@@ -972,8 +988,11 @@ static bool config_term_shrinked;
 static bool
 config_term_avail(int term_type, struct parse_events_error *err)
 {
+	char *err_str;
+
 	if (term_type < 0 || term_type >= __PARSE_EVENTS__TERM_TYPE_NR) {
-		err->str = strdup("Invalid term_type");
+		parse_events__handle_error(err, -1,
+					strdup("Invalid term_type"), NULL);
 		return false;
 	}
 	if (!config_term_shrinked)
@@ -992,9 +1011,9 @@ config_term_avail(int term_type, struct parse_events_error *err)
 			return false;
 
 		/* term_type is validated so indexing is safe */
-		if (asprintf(&err->str, "'%s' is not usable in 'perf stat'",
-			     config_term_names[term_type]) < 0)
-			err->str = NULL;
+		if (asprintf(&err_str, "'%s' is not usable in 'perf stat'",
+				config_term_names[term_type]) >= 0)
+			parse_events__handle_error(err, -1, err_str, NULL);
 		return false;
 	}
 }
@@ -1036,17 +1055,20 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
 		CHECK_TYPE_VAL(STR);
 		if (strcmp(term->val.str, "no") &&
-		    parse_branch_str(term->val.str, &attr->branch_sample_type)) {
-			err->str = strdup("invalid branch sample type");
-			err->idx = term->err_val;
+		    parse_branch_str(term->val.str,
+				    &attr->branch_sample_type)) {
+			parse_events__handle_error(err, term->err_val,
+					strdup("invalid branch sample type"),
+					NULL);
 			return -EINVAL;
 		}
 		break;
 	case PARSE_EVENTS__TERM_TYPE_TIME:
 		CHECK_TYPE_VAL(NUM);
 		if (term->val.num > 1) {
-			err->str = strdup("expected 0 or 1");
-			err->idx = term->err_val;
+			parse_events__handle_error(err, term->err_val,
+						strdup("expected 0 or 1"),
+						NULL);
 			return -EINVAL;
 		}
 		break;
@@ -1080,8 +1102,9 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		CHECK_TYPE_VAL(NUM);
 		if ((unsigned int)term->val.num > 1) {
-			err->str = strdup("expected 0 or 1");
-			err->idx = term->err_val;
+			parse_events__handle_error(err, term->err_val,
+						strdup("expected 0 or 1"),
+						NULL);
 			return -EINVAL;
 		}
 		break;
@@ -1089,9 +1112,9 @@ do {									   \
 		CHECK_TYPE_VAL(NUM);
 		break;
 	default:
-		err->str = strdup("unknown term");
-		err->idx = term->err_term;
-		err->help = parse_events_formats_error_string(NULL);
+		parse_events__handle_error(err, term->err_term,
+				strdup("unknown term"),
+				parse_events_formats_error_string(NULL));
 		return -EINVAL;
 	}
 
@@ -1142,9 +1165,9 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 		return config_term_common(attr, term, err);
 	default:
 		if (err) {
-			err->idx = term->err_term;
-			err->str = strdup("unknown term");
-			err->help = strdup("valid terms: call-graph,stack-size\n");
+			parse_events__handle_error(err, term->err_term,
+				strdup("unknown term"),
+				strdup("valid terms: call-graph,stack-size\n"));
 		}
 		return -EINVAL;
 	}
@@ -1323,10 +1346,12 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	pmu = perf_pmu__find(name);
 	if (!pmu) {
-		if (asprintf(&err->str,
+		char *err_str;
+
+		if (asprintf(&err_str,
 				"Cannot find PMU `%s'. Missing kernel support?",
-				name) < 0)
-			err->str = NULL;
+				name) >= 0)
+			parse_events__handle_error(err, -1, err_str, NULL);
 		return -EINVAL;
 	}
 
@@ -2797,13 +2822,10 @@ void parse_events__clear_array(struct parse_events_array *a)
 void parse_events_evlist_error(struct parse_events_state *parse_state,
 			       int idx, const char *str)
 {
-	struct parse_events_error *err = parse_state->error;
-
-	if (!err)
+	if (!parse_state->error)
 		return;
-	err->idx = idx;
-	err->str = strdup(str);
-	WARN_ONCE(!err->str, "WARNING: failed to allocate error string");
+
+	parse_events__handle_error(parse_state->error, idx, strdup(str), NULL);
 }
 
 static void config_terms_list(char *buf, size_t buf_sz)
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 769e07cddaa2..34f58d24a06a 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -124,6 +124,8 @@ struct parse_events_state {
 	struct list_head	  *terms;
 };
 
+void parse_events__handle_error(struct parse_events_error *err, int idx,
+				char *str, char *help);
 void parse_events__shrink_config_terms(void);
 int parse_events__is_hardcoded_term(struct parse_events_term *term);
 int parse_events_term__num(struct parse_events_term **term,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index adbe97e941dd..f9f427d4c313 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1050,9 +1050,9 @@ static int pmu_config_term(struct list_head *formats,
 		if (err) {
 			char *pmu_term = pmu_formats_string(formats);
 
-			err->idx  = term->err_term;
-			err->str  = strdup("unknown term");
-			err->help = parse_events_formats_error_string(pmu_term);
+			parse_events__handle_error(err, term->err_term,
+				strdup("unknown term"),
+				parse_events_formats_error_string(pmu_term));
 			free(pmu_term);
 		}
 		return -EINVAL;
@@ -1080,8 +1080,9 @@ static int pmu_config_term(struct list_head *formats,
 		if (term->no_value &&
 		    bitmap_weight(format->bits, PERF_PMU_FORMAT_BITS) > 1) {
 			if (err) {
-				err->idx = term->err_val;
-				err->str = strdup("no value assigned for term");
+				parse_events__handle_error(err, term->err_val,
+					   strdup("no value assigned for term"),
+					   NULL);
 			}
 			return -EINVAL;
 		}
@@ -1094,8 +1095,9 @@ static int pmu_config_term(struct list_head *formats,
 						term->config, term->val.str);
 			}
 			if (err) {
-				err->idx = term->err_val;
-				err->str = strdup("expected numeric value");
+				parse_events__handle_error(err, term->err_val,
+					strdup("expected numeric value"),
+					NULL);
 			}
 			return -EINVAL;
 		}
@@ -1108,11 +1110,15 @@ static int pmu_config_term(struct list_head *formats,
 	max_val = pmu_format_max_value(format->bits);
 	if (val > max_val) {
 		if (err) {
-			err->idx = term->err_val;
-			if (asprintf(&err->str,
-				     "value too big for format, maximum is %llu",
-				     (unsigned long long)max_val) < 0)
-				err->str = strdup("value too big for format");
+			char *err_str;
+
+			parse_events__handle_error(err, term->err_val,
+				asprintf(&err_str,
+				    "value too big for format, maximum is %llu",
+				    (unsigned long long)max_val) < 0
+				    ? strdup("value too big for format")
+				    : err_str,
+				    NULL);
 			return -EINVAL;
 		}
 		/*
-- 
2.24.0.rc0.303.g954a862665-goog

