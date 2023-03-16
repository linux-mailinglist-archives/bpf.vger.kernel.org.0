Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3AA6BC637
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 07:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCPGjf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 02:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCPGje (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 02:39:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9731630D
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 23:39:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id ix20so708177plb.3
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 23:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678948771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2XrPBeehxnDTEmwj3JWmRilfX+TcmTwSvaGxdCXT4pM=;
        b=pOUT3GptljvkipSLI6MlX2R9M8m5PXG9AOGNglAtaFMp+ipoqHciLEnUJD2SihluzU
         zTJQOVxuMHT/qb5hvvjoNdJN3m+y+woMCr9akwL6ZMckk1i+A+mZ6ROUHeXEfduP07zt
         VER+S541KgdPm6rK6KpNFH38o5f97FewySr7AsGm0HcNvk3BROMpVYXBS4ijWTkv4Ny/
         c6YxQBv5hJE/SfeP4EAH0QpVYuAAh0Kp4DAzdxiYHgC9bXn8+XRr6xv438WiQqm5Ceei
         7O+x5N5YCfY8jmt+QY4XGISkZxQ0umKcSB3yufc+CI2saZ4Gzr/GXHJq5zZ1fKh/fZp6
         YB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678948771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XrPBeehxnDTEmwj3JWmRilfX+TcmTwSvaGxdCXT4pM=;
        b=mxnu4tM3ImDhPNTH87NlYrI8SjVfkN+AlePWvOBXRk7xpXiFsUqU/mmTsfhDjFfxZk
         KUuVAoEOBLkBJ88Z3ZryxpX3rnI2olYBRlBd4PeyNF6xNmqw5sLOze5mhLUowgylh9eX
         xbn1uXhbWfLZwKJCkeTq2ATzKypNIrkYY2OaY44ra/ZNpa0WwbsEbQBmbXkIYibqVBVy
         ddvXioOCFCe2YW+5L1h1P50o4YswcqKvvrIN1+E2xP1ry8IsqeZjio3vIe0VM4eYQN3t
         lA8qszYJjS5RAM9qJs5WS01MjSmk2sQhYM5LzStYyXIGZygfK5NGsLO37m9H6V0qeEyg
         17QQ==
X-Gm-Message-State: AO0yUKX16NTEO+8/grhf694Yg3kUpvweX807AQkyqO8FmjrCATS22I3M
        67eord0GGJ0RzWLSBMbyh3TFEEVt3uGu2g==
X-Google-Smtp-Source: AK7set8BAlbZUXVWkfgIxSL7XSJPzBMdNJh2xn2pprthAFn9qbKsOs+V3GP/kfU5b8og2lv72J6SLw==
X-Received: by 2002:a05:6a20:b829:b0:d3:6a3b:7856 with SMTP id fi41-20020a056a20b82900b000d36a3b7856mr2213041pzb.46.1678948771028;
        Wed, 15 Mar 2023 23:39:31 -0700 (PDT)
Received: from localhost (fwdproxy-prn-000.fbsv.net. [2a03:2880:ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id f18-20020aa782d2000000b005dfc8a35793sm4599787pfn.38.2023.03.15.23.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 23:39:30 -0700 (PDT)
From:   Manu Bretelle <chantr4@gmail.com>
To:     chantr4@gmail.com, bpf@vger.kernel.org, andrii@kernel.org,
        mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com
Subject: [PATCH bpf-next] selftests/bpf: add --json-summary option to test_progs
Date:   Wed, 15 Mar 2023 23:39:01 -0700
Message-Id: <20230316063901.3619730-1-chantr4@gmail.com>
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
followed by a list of failed tests/subtests.

A test contains the following fields:
- test_name: the name of the test
- test_number: the number of the test
- message: the log message that was printed by the test.
- failed: A boolean indicating whether the test failed or not. Currently
we only output failed tests, but in the future, successful tests could
be added.

A subtest contains the following fields:
- test_name: same as above
- test_number: sanme as above
- subtest_name: the name of the subtest
- subtest_number: the number of the subtest.
- message: the log message that was printed by the subtest.
- is_subtest: a boolean indicating that the entry is a subtest.
- failed: same as above but for the subtest

```
$ sudo ./test_progs -a $(grep -v '^#' ./DENYLIST.aarch64 | awk '{print
$1","}' | tr -d '\n') -j -J /tmp/test_progs.json
$ jq . < /tmp/test_progs.json | head -n 30
$ head -n 30 /tmp/test_progs.json
{
    "success": 29,
    "success_subtest": 23,
    "skipped": 3,
    "failed": 27,
    "results": [{
            "test_name": "bpf_cookie",
            "test_number": 10,
            "message": "test_bpf_cookie:PASS:skel_open 0 nsec\n",
            "failed": true
        },{
            "test_name": "bpf_cookie",
            "subtest_name": "multi_kprobe_link_api",
            "test_number": 10,
            "subtest_number": 2,
            "message": "kprobe_multi_link_api_subtest:PASS:load_kallsyms
0 nsec\nlibbpf: extern 'bpf_testmod_fentry_test1' (strong): not
resolved\nlibbpf: failed to load object 'kprobe_multi'\nlibbpf: failed
to load BPF skeleton 'kprobe_multi':
-3\nkprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected
error: -3\n",
            "is_subtest": true,
            "failed": true
        },{
            "test_name": "bpf_cookie",
            "subtest_name": "multi_kprobe_attach_api",
            "test_number": 10,
            "subtest_number": 3,
            "message": "libbpf: extern 'bpf_testmod_fentry_test1'
(strong): not resolved\nlibbpf: failed to load object
'kprobe_multi'\nlibbpf: failed to load BPF skeleton 'kprobe_multi':
-3\nkprobe_multi_attach_api_subtest:FAIL:fentry_raw_skel_load unexpected
error: -3\n",
            "is_subtest": true,
            "failed": true
        },{
            "test_name": "bpf_cookie",
            "subtest_name": "lsm",
            "test_number": 10,
```

The file can then be used to print a summary of the test run and list of
failing tests/subtests:

```
$ jq -r < /tmp/test_progs.json '"Success:
\(.success)/\(.success_subtest), Skipped: \(.skipped), Failed:
\(.failed)"'

Success: 29/23, Skipped: 3, Failed: 27
$ jq -r <
/tmp/test_progs.json  '.results[] | if .is_subtest then
"#\(.test_number)/\(.subtest_number) \(.test_name)/\(.subtest_name)"
else "#\(.test_number) \(.test_name)" end'
```

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/testing/selftests/bpf/Makefile      |  4 +-
 tools/testing/selftests/bpf/json_writer.c |  1 +
 tools/testing/selftests/bpf/json_writer.h |  1 +
 tools/testing/selftests/bpf/test_progs.c  | 83 +++++++++++++++++++++--
 tools/testing/selftests/bpf/test_progs.h  |  1 +
 5 files changed, 84 insertions(+), 6 deletions(-)
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
index 6d5e3022c75f..cf56f6a4e1af 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -18,6 +18,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <bpf/btf.h>
+#include "json_writer.h"
 
 static bool verbose(void)
 {
@@ -269,10 +270,22 @@ static void print_subtest_name(int test_num, int subtest_num,
 	fprintf(env.stdout, "\n");
 }
 
+static void jsonw_write_log_message(json_writer_t *w, char *log_buf, size_t log_cnt)
+{
+	// open_memstream (from stdio_hijack_init) ensures that log_bug is terminated by a
+	// null byte. Yet in parralel mode, log_buf will be NULL if there is no message.
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
@@ -296,6 +309,15 @@ static void dump_test_log(const struct prog_test_def *test,
 	if (test_state->log_cnt && print_test)
 		print_test_log(test_state->log_buf, test_state->log_cnt);
 
+	if (w && print_test) {
+		jsonw_start_object(w);
+		jsonw_string_field(w, "test_name", test->test_name);
+		jsonw_uint_field(w, "test_number", test->test_num);
+		jsonw_write_log_message(w, test_state->log_buf, test_state->log_cnt);
+		jsonw_bool_field(w, "failed", true);
+		jsonw_end_object(w);
+	}
+
 	for (i = 0; i < test_state->subtest_num; i++) {
 		subtest_state = &test_state->subtest_states[i];
 		subtest_failed = subtest_state->error_cnt;
@@ -314,6 +336,19 @@ static void dump_test_log(const struct prog_test_def *test,
 				   test->test_name, subtest_state->name,
 				   test_result(subtest_state->error_cnt,
 					       subtest_state->skipped));
+
+		if (w && print_subtest) {
+			jsonw_start_object(w);
+			jsonw_string_field(w, "test_name", test->test_name);
+			jsonw_string_field(w, "subtest_name", subtest_state->name);
+			jsonw_uint_field(w, "test_number", test->test_num);
+			jsonw_uint_field(w, "subtest_number", i+1);
+			jsonw_write_log_message(w, subtest_state->log_buf, subtest_state->log_cnt);
+			jsonw_bool_field(w, "is_subtest", true);
+			jsonw_bool_field(w, "failed", true);
+			jsonw_end_object(w);
+		}
+
 	}
 
 	print_test_result(test, test_state);
@@ -715,6 +750,7 @@ enum ARG_KEYS {
 	ARG_TEST_NAME_GLOB_DENYLIST = 'd',
 	ARG_NUM_WORKERS = 'j',
 	ARG_DEBUG = -1,
+	ARG_JSON_SUMMARY = 'J'
 };
 
 static const struct argp_option opts[] = {
@@ -740,6 +776,7 @@ static const struct argp_option opts[] = {
 	  "Number of workers to run in parallel, default to number of cpus." },
 	{ "debug", ARG_DEBUG, NULL, 0,
 	  "print extra debug information for test_progs." },
+	{ "json-summary", ARG_JSON_SUMMARY, "FILE", 0, "Write report in json format to this file."},
 	{},
 };
 
@@ -870,6 +907,13 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
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
@@ -1017,7 +1061,7 @@ void crash_handler(int signum)
 		stdio_restore();
 	if (env.test) {
 		env.test_state->error_cnt++;
-		dump_test_log(env.test, env.test_state, true, false);
+		dump_test_log(env.test, env.test_state, true, false, NULL);
 	}
 	if (env.worker_id != -1)
 		fprintf(stderr, "[%d]: ", env.worker_id);
@@ -1124,7 +1168,7 @@ static void run_one_test(int test_num)
 
 	stdio_restore();
 
-	dump_test_log(test, state, false, false);
+	dump_test_log(test, state, false, false, NULL);
 }
 
 struct dispatch_data {
@@ -1283,7 +1327,7 @@ static void *dispatch_thread(void *ctx)
 		} while (false);
 
 		pthread_mutex_lock(&stdout_output_lock);
-		dump_test_log(test, state, false, true);
+		dump_test_log(test, state, false, true, NULL);
 		pthread_mutex_unlock(&stdout_output_lock);
 	} /* while (true) */
 error:
@@ -1322,8 +1366,28 @@ static void calculate_summary_and_print_errors(struct test_env *env)
 			fail_cnt++;
 		else
 			succ_cnt++;
+
+	}
+
+	json_writer_t *w = NULL;
+
+	if (env->json) {
+		w = jsonw_new(env->json);
+		if (!w)
+			fprintf(env->stderr, "Failed to create new JSON stream.");
 	}
 
+	if (w) {
+		jsonw_pretty(w, 1);
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
@@ -1340,10 +1404,19 @@ static void calculate_summary_and_print_errors(struct test_env *env)
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

