Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54D56BEE5F
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 17:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCQQdP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 12:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjCQQdN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 12:33:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A8737B54
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 09:33:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c18so5834833ple.11
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679070788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i1CdQowh6qnPZs2t9h1ykT1wBiEK6mr+NMigeom1ZdM=;
        b=qK/Dvl+69lNPLMiWbcd+NRmdm7lVJphEsOWNyx2UKxF+ByMmi2lGs2qwZy6mnwm/vQ
         K/JasheVXgSL0aGYuXla77XTcTf+PKOv8P4MjUblDaq/EN7yIQBNBXy2DlaV2/zUcpSu
         OdGwPcay5tAT70Hr13LyJZs7raGSakCilBoNbZFMeRsbch7qTQAB7xavlLfnvpziMtH6
         LYdQ9lAjtc9bWG4wtYLZBb9L4BrBgfkBNovrdSa0VvpiiP3uWYqYicqEVqhH+pNj600a
         X+AE64QdLyFK6ZU/wBbvofpTcWOeey6JEJa//3b59PNcolvzhYdxf/UutZMocKfjAgNV
         endg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679070788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1CdQowh6qnPZs2t9h1ykT1wBiEK6mr+NMigeom1ZdM=;
        b=oJTUmnyAKjTrHxjvCl9vT1bggeW742kbok6ZoafjMQLnNK8zBdtFyGrXnv0md9t9aJ
         MBGr6sjJDjtgXX7HijvdmYlcFQGKRXtQP0CORuNINPMn+t039DxzWrIf3Asr9gYoFDFU
         7nF5yntyVch/gfVb25HaIjMtT2oyUTnhTI5sBRn6PB1JQ2MaDjOuF/fmvj5kU7uQ0YFq
         xfLezIjmUb98hTOufpLjB9t3YAdeT8BmlFUOgzGzDMbOm0Yfh3XvdTsEXdEdqDdkp230
         UXOOi+n7U/BAJVxR0GvDuXxN11oLzreaej0f0lvtdZTd/vEFtIpkEykn/Eqds9w1Gfx9
         sITg==
X-Gm-Message-State: AO0yUKXLa8HqcZG5ilr+KXFtpycpYp0R/7lZ0u2ZAySmFBckzqPetjUR
        kMP5KbJmmazY/LsmpZJwa4I=
X-Google-Smtp-Source: AK7set8UAyUe8xE+VNj8F2p7WcDJcr9nT9EpW/oEMLnehWuQme3ebLYst8nRbqiOmCdiZbvQ2uyu2w==
X-Received: by 2002:a17:90b:1d8e:b0:23d:2027:c355 with SMTP id pf14-20020a17090b1d8e00b0023d2027c355mr9215066pjb.10.1679070787907;
        Fri, 17 Mar 2023 09:33:07 -0700 (PDT)
Received: from localhost (fwdproxy-prn-022.fbsv.net. [2a03:2880:ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id ij14-20020a17090af80e00b0023a71345b26sm1658385pjb.13.2023.03.17.09.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 09:33:07 -0700 (PDT)
From:   Manu Bretelle <chantr4@gmail.com>
To:     chantr4@gmail.com, bpf@vger.kernel.org, andrii@kernel.org,
        mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com
Subject: [PATCH bpf-next v2] selftests/bpf: add --json-summary option to test_progs
Date:   Fri, 17 Mar 2023 09:32:56 -0700
Message-Id: <20230317163256.3809328-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, test_progs outputs all stdout/stderr as it runs, and when it
is done, prints a summary.

It is non-trivial for tooling to parse that output and extract meaningful
information from it.

This change adds a new option, `--json-summary`/`-J` that let the caller
specify a file where `test_progs{,-no_alu32}` can write a summary of the
run in a json format that can later be parsed by tooling.

Currently, it creates a summary section with successes/skipped/failures
followed by a list of failed tests and subtests.

A test contains the following fields:
- name: the name of the test
- number: the number of the test
- message: the log message that was printed by the test.
- failed: A boolean indicating whether the test failed or not. Currently
we only output failed tests, but in the future, successful tests could
be added.
- subtests: A list of subtests associated with this test.

A subtest contains the following fields:
- name: same as above
- number: sanme as above
- message: the log message that was printed by the subtest.
- failed: same as above but for the subtest

An example run and json content below:
```
$ sudo ./test_progs -a $(grep -v '^#' ./DENYLIST.aarch64 | awk '{print
$1","}' | tr -d '\n') -j -J /tmp/test_progs.json
$ jq < /tmp/test_progs.json | head -n 30
{
  "success": 29,
  "success_subtest": 23,
  "skipped": 3,
  "failed": 28,
  "results": [
    {
      "name": "bpf_cookie",
      "number": 10,
      "message": "test_bpf_cookie:PASS:skel_open 0 nsec\n",
      "failed": true,
      "subtests": [
        {
          "name": "multi_kprobe_link_api",
          "number": 2,
          "message": "kprobe_multi_link_api_subtest:PASS:load_kallsyms 0
nsec\nlibbpf: extern 'bpf_testmod_fentry_test1' (strong): not
resolved\nlibbpf: failed to load object 'kprobe_multi'\nlibbpf: failed
to load BPF skeleton 'kprobe_multi':
-3\nkprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected
error: -3\n",
          "failed": true
        },
        {
          "name": "multi_kprobe_attach_api",
          "number": 3,
          "message": "libbpf: extern 'bpf_testmod_fentry_test1'
(strong): not resolved\nlibbpf: failed to load object
'kprobe_multi'\nlibbpf: failed to load BPF skeleton 'kprobe_multi':
-3\nkprobe_multi_attach_api_subtest:FAIL:fentry_raw_skel_load unexpected
error: -3\n",
          "failed": true
        },
        {
          "name": "lsm",
          "number": 8,
          "message": "lsm_subtest:PASS:lsm.link_create 0
nsec\nlsm_subtest:FAIL:stack_mprotect unexpected stack_mprotect: actual
0 != expected -1\n",
          "failed": true
        }
```

The file can then be used to print a summary of the test run and list of
failing tests/subtests:

```
$ jq -r < /tmp/test_progs.json '"Success:
\(.success)/\(.success_subtest), Skipped: \(.skipped), Failed:
\(.failed)"'

Success: 29/23, Skipped: 3, Failed: 28
$ jq -r < /tmp/test_progs.json '.results | map([
    if .failed then "#\(.number) \(.name)" else empty end,
    (
        . as {name: $tname, number: $tnum} | .subtests | map(
            if .failed then "#\($tnum)/\(.number) \($tname)/\(.name)"
else empty end
        )
    )
]) | flatten | .[]' | head -n 20
 #10 bpf_cookie
 #10/2 bpf_cookie/multi_kprobe_link_api
 #10/3 bpf_cookie/multi_kprobe_attach_api
 #10/8 bpf_cookie/lsm
 #15 bpf_mod_race
 #15/1 bpf_mod_race/ksym (used_btfs UAF)
 #15/2 bpf_mod_race/kfunc (kfunc_btf_tab UAF)
 #36 cgroup_hierarchical_stats
 #61 deny_namespace
 #61/1 deny_namespace/unpriv_userns_create_no_bpf
 #73 fexit_stress
 #83 get_func_ip_test
 #99 kfunc_dynptr_param
 #99/1 kfunc_dynptr_param/dynptr_data_null
 #99/4 kfunc_dynptr_param/dynptr_data_null
 #100 kprobe_multi_bench_attach
 #100/1 kprobe_multi_bench_attach/kernel
 #100/2 kprobe_multi_bench_attach/modules
 #101 kprobe_multi_test
 #101/1 kprobe_multi_test/skel_api
```

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
v2:
    * use `test_failed`, `subtest_failed` to populate "failed" field.
    * Move to nested structure where subtests are added to the subtests
        array of a test.
    * removed test/subtest prefixes now that an object identify either
        of them.
    * addressed nits (comment, declaration at top of function)
    * do not pretty output
---
 tools/testing/selftests/bpf/Makefile      |  4 +-
 tools/testing/selftests/bpf/json_writer.c |  1 +
 tools/testing/selftests/bpf/json_writer.h |  1 +
 tools/testing/selftests/bpf/test_progs.c  | 86 +++++++++++++++++++++--
 tools/testing/selftests/bpf/test_progs.h  |  1 +
 5 files changed, 87 insertions(+), 6 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/json_writer.c
 create mode 120000 tools/testing/selftests/bpf/json_writer.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 55811c448eb7..fc092582d16d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -234,6 +234,7 @@ $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
 CGROUP_HELPERS	:= $(OUTPUT)/cgroup_helpers.o
 TESTING_HELPERS	:= $(OUTPUT)/testing_helpers.o
 TRACE_HELPERS	:= $(OUTPUT)/trace_helpers.o
+JSON_WRITER		:= $(OUTPUT)/json_writer.o
 CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
 
 $(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
@@ -559,7 +560,8 @@ TRUNNER_BPF_PROGS_DIR := progs
 TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 			 network_helpers.c testing_helpers.c		\
 			 btf_helpers.c flow_dissector_load.h		\
-			 cap_helpers.c test_loader.c xsk.c disasm.c
+			 cap_helpers.c test_loader.c xsk.c disasm.c \
+			 json_writer.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
diff --git a/tools/testing/selftests/bpf/json_writer.c b/tools/testing/selftests/bpf/json_writer.c
new file mode 120000
index 000000000000..5effa31e2f39
--- /dev/null
+++ b/tools/testing/selftests/bpf/json_writer.c
@@ -0,0 +1 @@
+../../../bpf/bpftool/json_writer.c
\ No newline at end of file
diff --git a/tools/testing/selftests/bpf/json_writer.h b/tools/testing/selftests/bpf/json_writer.h
new file mode 120000
index 000000000000..e0a264c26752
--- /dev/null
+++ b/tools/testing/selftests/bpf/json_writer.h
@@ -0,0 +1 @@
+../../../bpf/bpftool/json_writer.h
\ No newline at end of file
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 6d5e3022c75f..046de4bd80cc 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -18,6 +18,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <bpf/btf.h>
+#include "json_writer.h"
 
 static bool verbose(void)
 {
@@ -269,10 +270,23 @@ static void print_subtest_name(int test_num, int subtest_num,
 	fprintf(env.stdout, "\n");
 }
 
+static void jsonw_write_log_message(json_writer_t *w, char *log_buf, size_t log_cnt)
+{
+	/* open_memstream (from stdio_hijack_init) ensures that log_bug is terminated by a
+	 * null byte. Yet in parallel mode, log_buf will be NULL if there is no message.
+	 */
+	if (log_cnt) {
+		jsonw_string_field(w, "message", log_buf);
+	} else {
+		jsonw_string_field(w, "message", "");
+	}
+}
+
 static void dump_test_log(const struct prog_test_def *test,
 			  const struct test_state *test_state,
 			  bool skip_ok_subtests,
-			  bool par_exec_result)
+			  bool par_exec_result,
+			  json_writer_t *w)
 {
 	bool test_failed = test_state->error_cnt > 0;
 	bool force_log = test_state->force_log;
@@ -296,6 +310,16 @@ static void dump_test_log(const struct prog_test_def *test,
 	if (test_state->log_cnt && print_test)
 		print_test_log(test_state->log_buf, test_state->log_cnt);
 
+	if (w && print_test) {
+		jsonw_start_object(w);
+		jsonw_string_field(w, "name", test->test_name);
+		jsonw_uint_field(w, "number", test->test_num);
+		jsonw_write_log_message(w, test_state->log_buf, test_state->log_cnt);
+		jsonw_bool_field(w, "failed", test_failed);
+		jsonw_name(w, "subtests");
+		jsonw_start_array(w);
+	}
+
 	for (i = 0; i < test_state->subtest_num; i++) {
 		subtest_state = &test_state->subtest_states[i];
 		subtest_failed = subtest_state->error_cnt;
@@ -314,8 +338,24 @@ static void dump_test_log(const struct prog_test_def *test,
 				   test->test_name, subtest_state->name,
 				   test_result(subtest_state->error_cnt,
 					       subtest_state->skipped));
+
+		if (w && print_subtest) {
+			jsonw_start_object(w);
+			jsonw_string_field(w, "name", subtest_state->name);
+			jsonw_uint_field(w, "number", i+1);
+			jsonw_write_log_message(w, subtest_state->log_buf, subtest_state->log_cnt);
+			jsonw_bool_field(w, "failed", subtest_failed);
+			jsonw_end_object(w);
+		}
+
+	}
+
+	if (w && print_test) {
+		jsonw_end_array(w);
+		jsonw_end_object(w);
 	}
 
+
 	print_test_result(test, test_state);
 }
 
@@ -715,6 +755,7 @@ enum ARG_KEYS {
 	ARG_TEST_NAME_GLOB_DENYLIST = 'd',
 	ARG_NUM_WORKERS = 'j',
 	ARG_DEBUG = -1,
+	ARG_JSON_SUMMARY = 'J'
 };
 
 static const struct argp_option opts[] = {
@@ -740,6 +781,7 @@ static const struct argp_option opts[] = {
 	  "Number of workers to run in parallel, default to number of cpus." },
 	{ "debug", ARG_DEBUG, NULL, 0,
 	  "print extra debug information for test_progs." },
+	{ "json-summary", ARG_JSON_SUMMARY, "FILE", 0, "Write report in json format to this file."},
 	{},
 };
 
@@ -870,6 +912,13 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	case ARG_DEBUG:
 		env->debug = true;
 		break;
+	case ARG_JSON_SUMMARY:
+		env->json = fopen(arg, "w");
+		if (env->json == NULL) {
+			perror("Failed to open json summary file");
+			return -errno;
+		}
+		break;
 	case ARGP_KEY_ARG:
 		argp_usage(state);
 		break;
@@ -1017,7 +1066,7 @@ void crash_handler(int signum)
 		stdio_restore();
 	if (env.test) {
 		env.test_state->error_cnt++;
-		dump_test_log(env.test, env.test_state, true, false);
+		dump_test_log(env.test, env.test_state, true, false, NULL);
 	}
 	if (env.worker_id != -1)
 		fprintf(stderr, "[%d]: ", env.worker_id);
@@ -1124,7 +1173,7 @@ static void run_one_test(int test_num)
 
 	stdio_restore();
 
-	dump_test_log(test, state, false, false);
+	dump_test_log(test, state, false, false, NULL);
 }
 
 struct dispatch_data {
@@ -1283,7 +1332,7 @@ static void *dispatch_thread(void *ctx)
 		} while (false);
 
 		pthread_mutex_lock(&stdout_output_lock);
-		dump_test_log(test, state, false, true);
+		dump_test_log(test, state, false, true, NULL);
 		pthread_mutex_unlock(&stdout_output_lock);
 	} /* while (true) */
 error:
@@ -1308,6 +1357,7 @@ static void calculate_summary_and_print_errors(struct test_env *env)
 {
 	int i;
 	int succ_cnt = 0, fail_cnt = 0, sub_succ_cnt = 0, skip_cnt = 0;
+	json_writer_t *w = NULL;
 
 	for (i = 0; i < prog_test_cnt; i++) {
 		struct test_state *state = &test_states[i];
@@ -1322,8 +1372,25 @@ static void calculate_summary_and_print_errors(struct test_env *env)
 			fail_cnt++;
 		else
 			succ_cnt++;
+
+	}
+
+	if (env->json) {
+		w = jsonw_new(env->json);
+		if (!w)
+			fprintf(env->stderr, "Failed to create new JSON stream.");
 	}
 
+	if (w) {
+		jsonw_start_object(w);
+		jsonw_uint_field(w, "success", succ_cnt);
+		jsonw_uint_field(w, "success_subtest", sub_succ_cnt);
+		jsonw_uint_field(w, "skipped", skip_cnt);
+		jsonw_uint_field(w, "failed", fail_cnt);
+		jsonw_name(w, "results");
+		jsonw_start_array(w);
+
+	}
 	/*
 	 * We only print error logs summary when there are failed tests and
 	 * verbose mode is not enabled. Otherwise, results may be incosistent.
@@ -1340,10 +1407,19 @@ static void calculate_summary_and_print_errors(struct test_env *env)
 			if (!state->tested || !state->error_cnt)
 				continue;
 
-			dump_test_log(test, state, true, true);
+			dump_test_log(test, state, true, true, w);
 		}
 	}
 
+	if (w) {
+		jsonw_end_array(w);
+		jsonw_end_object(w);
+		jsonw_destroy(&w);
+	}
+
+	if (env->json)
+		fclose(env->json);
+
 	printf("Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
 	       succ_cnt, sub_succ_cnt, skip_cnt, fail_cnt);
 
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 3cbf005747ed..4b06b8347cd4 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -114,6 +114,7 @@ struct test_env {
 	FILE *stdout;
 	FILE *stderr;
 	int nr_cpus;
+	FILE *json;
 
 	int succ_cnt; /* successful tests */
 	int sub_succ_cnt; /* successful sub-tests */
-- 
2.34.1

