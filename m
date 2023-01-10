Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F36664EB8
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 23:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjAJWWu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 17:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjAJWWL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 17:22:11 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52517630B
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 14:21:26 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id f8-20020a170902ce8800b00190c6518e21so9192558plg.1
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 14:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kvPH1BN0wc7R6CBYDwvNtRpXbxlXsspJN7UfOLukVhk=;
        b=XtuABPKvMijNQr9fb8jkyGTZ/KLwAHAmMrQd/RXO5du+uXQNtal+CFXdNPElXfFRfq
         Yil7XJbmdb4gkUwZGETai6Xd3/w7NaCTqYiScLj43krV4Tr2qCVjRPs+wN0MoLj3Lnbi
         HYD69GprkAHubvAoU9hkO4t79fGtf7ApeUGgOOofTHQNaYzKRffHUuKJF0vhdivE5JZp
         qlyK2l1QnqzLZso72zbqC0VMrpPUBaXPJraf+c/Jnhrg/MkduX8srZ+oHs3KJ4FW1acv
         5hTxwj6tQUEVMmqcfxqU9iUdy/eUxkc+GC6xYg5qwA9Bnkwlu+5BbOAL19kFVEDTBaAG
         78VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvPH1BN0wc7R6CBYDwvNtRpXbxlXsspJN7UfOLukVhk=;
        b=yC6LDwmMUO5yAS2sQ9mc1OJ8/OW8Mr0o7mjqHmb/zUgnwrjkRSCflOIbXwFBXOJmJm
         oe67SfWXkHbDzCkMC7q70Yz324daVkJ2TRk6yGQFCdfkvJt0ADrE8qoTLfu8Eijcw4kU
         +jwpf97t9WilMACCHRFpIxXGBR9yVBzP6BbFtmEJXl6MVNM1ENRXRyHHcMIhEcELwBRQ
         w+0i4FviLRAS1EtFiokoWQwkizfK0WteODVdIKWWSD6K5yQzIgr9ZXVGW9Y9WVWUmHWy
         7OoAN2S9CvNWKIr1OoB56nwvvis02lZN7IQgLL8l0pw/ZD7ul0s2KKP1mj/PIvBB7Ryw
         14fA==
X-Gm-Message-State: AFqh2kp3oUsj2ptQ4Z9bnc+tfeUR38ACYynwRH+JhPx5ksVECe1emvsm
        ii0U2rL9Bfw6jXDxSd3DiLP6AYkWZb/f
X-Google-Smtp-Source: AMrXdXvrnniASyZKrOQ+MkQJEuuDdxB/fg2o3J0uy7i19QShKpKxfZQ+SqWs2hqFU1HTTOwDbX7aIkA6oKCk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cebf:c37e:8184:56])
 (user=irogers job=sendgmr) by 2002:a05:6a00:1630:b0:586:906e:4dd5 with SMTP
 id e16-20020a056a00163000b00586906e4dd5mr1350224pfc.80.1673389281412; Tue, 10
 Jan 2023 14:21:21 -0800 (PST)
Date:   Tue, 10 Jan 2023 14:20:03 -0800
In-Reply-To: <20230110222003.1591436-1-irogers@google.com>
Message-Id: <20230110222003.1591436-8-irogers@google.com>
Mime-Version: 1.0
References: <20230110222003.1591436-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 7/7] perf llvm: Remove read_from_pipe
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Qi Liu <liuqi115@huawei.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Xin Gao <gaoxin@cdjrlc.com>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stephane Eranian <eranian@google.com>,
        German Gomez <german.gomez@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch to the common run_command_strbuf utility.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/bpf.c       |  12 +--
 tools/perf/tests/llvm.c      |  18 ++--
 tools/perf/tests/llvm.h      |   3 +-
 tools/perf/util/bpf-loader.c |   9 +-
 tools/perf/util/llvm-utils.c | 184 +++++++----------------------------
 tools/perf/util/llvm-utils.h |   6 +-
 6 files changed, 61 insertions(+), 171 deletions(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 17c023823713..b4a6afb41e40 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -13,6 +13,7 @@
 #include <linux/filter.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <api/strbuf.h>
 #include <api/fs/fs.h>
 #include <perf/mmap.h>
 #include "tests.h"
@@ -216,14 +217,13 @@ prepare_bpf(void *obj_buf, size_t obj_buf_sz, const char *name)
 static int __test__bpf(int idx)
 {
 	int ret;
-	void *obj_buf;
-	size_t obj_buf_sz;
+	struct strbuf obj_buf = STRBUF_INIT;
 	struct bpf_object *obj;
 
-	ret = test_llvm__fetch_bpf_obj(&obj_buf, &obj_buf_sz,
+	ret = test_llvm__fetch_bpf_obj(&obj_buf,
 				       bpf_testcase_table[idx].prog_id,
 				       false, NULL);
-	if (ret != TEST_OK || !obj_buf || !obj_buf_sz) {
+	if (ret != TEST_OK || !obj_buf.len) {
 		pr_debug("Unable to get BPF object, %s\n",
 			 bpf_testcase_table[idx].msg_compile_fail);
 		if ((idx == 0) || (ret == TEST_SKIP))
@@ -232,7 +232,7 @@ static int __test__bpf(int idx)
 			return TEST_FAIL;
 	}
 
-	obj = prepare_bpf(obj_buf, obj_buf_sz,
+	obj = prepare_bpf(obj_buf.buf, obj_buf.len,
 			  bpf_testcase_table[idx].name);
 	if ((!!bpf_testcase_table[idx].target_func) != (!!obj)) {
 		if (!obj)
@@ -274,7 +274,7 @@ static int __test__bpf(int idx)
 	}
 
 out:
-	free(obj_buf);
+	strbuf_release(&obj_buf);
 	bpf__clear();
 	return ret;
 }
diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
index 0bc25a56cfef..97090850b7f9 100644
--- a/tools/perf/tests/llvm.c
+++ b/tools/perf/tests/llvm.c
@@ -4,6 +4,7 @@
 #include <string.h>
 #include "tests.h"
 #include "debug.h"
+#include <api/strbuf.h>
 
 #ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/libbpf.h>
@@ -45,8 +46,7 @@ static struct {
 };
 
 int
-test_llvm__fetch_bpf_obj(void **p_obj_buf,
-			 size_t *p_obj_buf_sz,
+test_llvm__fetch_bpf_obj(struct strbuf *obj_buf,
 			 enum test_llvm__testcase idx,
 			 bool force,
 			 bool *should_load_fail)
@@ -83,9 +83,6 @@ test_llvm__fetch_bpf_obj(void **p_obj_buf,
 	if (verbose == 0)
 		verbose = -1;
 
-	*p_obj_buf = NULL;
-	*p_obj_buf_sz = 0;
-
 	if (!llvm_param.clang_bpf_cmd_template)
 		goto out;
 
@@ -106,7 +103,7 @@ test_llvm__fetch_bpf_obj(void **p_obj_buf,
 	clang_opt_old = llvm_param.clang_opt;
 	llvm_param.clang_opt = clang_opt_new;
 
-	err = llvm__compile_bpf("-", p_obj_buf, p_obj_buf_sz);
+	err = llvm__compile_bpf("-", obj_buf);
 
 	llvm_param.clang_bpf_cmd_template = tmpl_old;
 	llvm_param.clang_opt = clang_opt_old;
@@ -127,24 +124,23 @@ test_llvm__fetch_bpf_obj(void **p_obj_buf,
 static int test__llvm(int subtest)
 {
 	int ret;
-	void *obj_buf = NULL;
-	size_t obj_buf_sz = 0;
+	struct strbuf obj_buf = STRBUF_INIT;
 	bool should_load_fail = false;
 
 	if ((subtest < 0) || (subtest >= __LLVM_TESTCASE_MAX))
 		return TEST_FAIL;
 
-	ret = test_llvm__fetch_bpf_obj(&obj_buf, &obj_buf_sz,
+	ret = test_llvm__fetch_bpf_obj(&obj_buf,
 				       subtest, false, &should_load_fail);
 
 	if (ret == TEST_OK && !should_load_fail) {
-		ret = test__bpf_parsing(obj_buf, obj_buf_sz);
+		ret = test__bpf_parsing(obj_buf.buf, obj_buf.len);
 		if (ret != TEST_OK) {
 			pr_debug("Failed to parse test case '%s'\n",
 				 bpf_source_table[subtest].desc);
 		}
 	}
-	free(obj_buf);
+	strbuf_release(&obj_buf);
 
 	return ret;
 }
diff --git a/tools/perf/tests/llvm.h b/tools/perf/tests/llvm.h
index f68b0d9b8ae2..2294b66dd0b6 100644
--- a/tools/perf/tests/llvm.h
+++ b/tools/perf/tests/llvm.h
@@ -22,7 +22,8 @@ enum test_llvm__testcase {
 	__LLVM_TESTCASE_MAX,
 };
 
-int test_llvm__fetch_bpf_obj(void **p_obj_buf, size_t *p_obj_buf_sz,
+struct strbuf;
+int test_llvm__fetch_bpf_obj(struct strbuf *obj_buf,
 			     enum test_llvm__testcase index, bool force,
 			     bool *should_load_fail);
 #ifdef __cplusplus
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 6e9b06cf06ee..f3a5cf490141 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -16,6 +16,7 @@
 #include <linux/zalloc.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <api/strbuf.h>
 #include "debug.h"
 #include "evlist.h"
 #include "bpf-loader.h"
@@ -245,10 +246,14 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 		err = perf_clang__compile_bpf(filename, &obj_buf, &obj_buf_sz);
 		perf_clang__cleanup();
 		if (err) {
+			struct strbuf str_obj_buf = STRBUF_INIT;
+
 			pr_debug("bpf: builtin compilation failed: %d, try external compiler\n", err);
-			err = llvm__compile_bpf(filename, &obj_buf, &obj_buf_sz);
-			if (err)
+			err = llvm__compile_bpf(filename, &str_obj_buf);
+			if (err < 0)
 				return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
+			obj_buf = str_obj_buf.buf;
+			obj_buf_sz = str_obj_buf.len;
 		} else
 			pr_debug("bpf: successful builtin compilation\n");
 		obj = bpf_object__open_mem(obj_buf, obj_buf_sz, &opts);
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 4e8e243a6e4b..8a12160320f3 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -17,7 +17,9 @@
 #include "config.h"
 #include "util.h"
 #include <sys/wait.h>
+#include <api/strbuf.h>
 #include <subcmd/exec-cmd.h>
+#include <subcmd/run-command.h>
 
 #define CLANG_BPF_CMD_DEFAULT_TEMPLATE				\
 		"$CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS "\
@@ -125,92 +127,6 @@ static int search_program_and_warn(const char *def, const char *name,
 	return ret;
 }
 
-#define READ_SIZE	4096
-static int
-read_from_pipe(const char *cmd, void **p_buf, size_t *p_read_sz)
-{
-	int err = 0;
-	void *buf = NULL;
-	FILE *file = NULL;
-	size_t read_sz = 0, buf_sz = 0;
-	char serr[STRERR_BUFSIZE];
-
-	file = popen(cmd, "r");
-	if (!file) {
-		pr_err("ERROR: unable to popen cmd: %s\n",
-		       str_error_r(errno, serr, sizeof(serr)));
-		return -EINVAL;
-	}
-
-	while (!feof(file) && !ferror(file)) {
-		/*
-		 * Make buf_sz always have obe byte extra space so we
-		 * can put '\0' there.
-		 */
-		if (buf_sz - read_sz < READ_SIZE + 1) {
-			void *new_buf;
-
-			buf_sz = read_sz + READ_SIZE + 1;
-			new_buf = realloc(buf, buf_sz);
-
-			if (!new_buf) {
-				pr_err("ERROR: failed to realloc memory\n");
-				err = -ENOMEM;
-				goto errout;
-			}
-
-			buf = new_buf;
-		}
-		read_sz += fread(buf + read_sz, 1, READ_SIZE, file);
-	}
-
-	if (buf_sz - read_sz < 1) {
-		pr_err("ERROR: internal error\n");
-		err = -EINVAL;
-		goto errout;
-	}
-
-	if (ferror(file)) {
-		pr_err("ERROR: error occurred when reading from pipe: %s\n",
-		       str_error_r(errno, serr, sizeof(serr)));
-		err = -EIO;
-		goto errout;
-	}
-
-	err = WEXITSTATUS(pclose(file));
-	file = NULL;
-	if (err) {
-		err = -EINVAL;
-		goto errout;
-	}
-
-	/*
-	 * If buf is string, give it terminal '\0' to make our life
-	 * easier. If buf is not string, that '\0' is out of space
-	 * indicated by read_sz so caller won't even notice it.
-	 */
-	((char *)buf)[read_sz] = '\0';
-
-	if (!p_buf)
-		free(buf);
-	else
-		*p_buf = buf;
-
-	if (p_read_sz)
-		*p_read_sz = read_sz;
-	return 0;
-
-errout:
-	if (file)
-		pclose(file);
-	free(buf);
-	if (p_buf)
-		*p_buf = NULL;
-	if (p_read_sz)
-		*p_read_sz = 0;
-	return err;
-}
-
 static inline void
 force_set_env(const char *var, const char *value)
 {
@@ -244,7 +160,7 @@ version_notice(void)
 );
 }
 
-static int detect_kbuild_dir(char **kbuild_dir)
+static int detect_kbuild_dir(struct strbuf *kbuild_dir)
 {
 	const char *test_dir = llvm_param.kbuild_dir;
 	const char *prefix_dir = "";
@@ -276,10 +192,9 @@ static int detect_kbuild_dir(char **kbuild_dir)
 	if (access(autoconf_path, R_OK) == 0) {
 		free(autoconf_path);
 
-		err = asprintf(kbuild_dir, "%s%s%s", prefix_dir, test_dir,
-			       suffix_dir);
+		err = (int)strbuf_addf(kbuild_dir, "%s%s%s", prefix_dir, test_dir, suffix_dir);
 		if (err < 0)
-			return -ENOMEM;
+			return err;
 		return 0;
 	}
 	pr_debug("%s: Couldn't find \"%s\", missing kernel-devel package?.\n",
@@ -315,7 +230,7 @@ static const char *kinc_fetch_script =
 "rm -rf $TMPDIR\n"
 "exit $RET\n";
 
-void llvm__get_kbuild_opts(char **kbuild_dir, char **kbuild_include_opts)
+void llvm__get_kbuild_opts(struct strbuf *kbuild_dir, struct strbuf *kbuild_include_opts)
 {
 	static char *saved_kbuild_dir;
 	static char *saved_kbuild_include_opts;
@@ -324,22 +239,14 @@ void llvm__get_kbuild_opts(char **kbuild_dir, char **kbuild_include_opts)
 	if (!kbuild_dir || !kbuild_include_opts)
 		return;
 
-	*kbuild_dir = NULL;
-	*kbuild_include_opts = NULL;
-
 	if (saved_kbuild_dir && saved_kbuild_include_opts &&
 	    !IS_ERR(saved_kbuild_dir) && !IS_ERR(saved_kbuild_include_opts)) {
-		*kbuild_dir = strdup(saved_kbuild_dir);
-		*kbuild_include_opts = strdup(saved_kbuild_include_opts);
+		strbuf_addstr(kbuild_dir, saved_kbuild_dir);
+		strbuf_addstr(kbuild_include_opts, saved_kbuild_include_opts);
 
-		if (*kbuild_dir && *kbuild_include_opts)
-			return;
-
-		zfree(kbuild_dir);
-		zfree(kbuild_include_opts);
 		/*
-		 * Don't fall through: it may breaks saved_kbuild_dir and
-		 * saved_kbuild_include_opts if detect them again when
+		 * Don't fallthrough: it may break the saved_kbuild_dir and
+		 * saved_kbuild_include_opts if they are detected again when
 		 * memory is low.
 		 */
 		return;
@@ -361,28 +268,26 @@ void llvm__get_kbuild_opts(char **kbuild_dir, char **kbuild_include_opts)
 		goto errout;
 	}
 
-	pr_debug("Kernel build dir is set to %s\n", *kbuild_dir);
-	force_set_env("KBUILD_DIR", *kbuild_dir);
+	pr_debug("Kernel build dir is set to %s\n", kbuild_dir->buf);
+	force_set_env("KBUILD_DIR", kbuild_dir->buf);
 	force_set_env("KBUILD_OPTS", llvm_param.kbuild_opts);
-	err = read_from_pipe(kinc_fetch_script,
-			     (void **)kbuild_include_opts,
-			     NULL);
+	err = run_command_strbuf(kinc_fetch_script, kbuild_include_opts);
 	if (err) {
 		pr_warning(
 "WARNING:\tunable to get kernel include directories from '%s'\n"
 "Hint:\tTry set clang include options using 'clang-bpf-cmd-template'\n"
 "     \toption in [llvm] section of ~/.perfconfig and set 'kbuild-dir'\n"
 "     \toption in [llvm] to \"\" to suppress this detection.\n\n",
-			*kbuild_dir);
+			kbuild_dir->buf);
 
 		zfree(kbuild_dir);
 		goto errout;
 	}
 
-	pr_debug("include option is set to %s\n", *kbuild_include_opts);
+	pr_debug("include option is set to %s\n", kbuild_include_opts->buf);
 
-	saved_kbuild_dir = strdup(*kbuild_dir);
-	saved_kbuild_include_opts = strdup(*kbuild_include_opts);
+	saved_kbuild_dir = strdup(kbuild_dir->buf);
+	saved_kbuild_include_opts = strdup(kbuild_include_opts->buf);
 
 	if (!saved_kbuild_dir || !saved_kbuild_include_opts) {
 		zfree(&saved_kbuild_dir);
@@ -446,24 +351,23 @@ void llvm__dump_obj(const char *path, void *obj_buf, size_t size)
 	free(obj_path);
 }
 
-int llvm__compile_bpf(const char *path, void **p_obj_buf,
-		      size_t *p_obj_buf_sz)
+int llvm__compile_bpf(const char *path, struct strbuf *obj_buf)
 {
-	size_t obj_buf_sz;
-	void *obj_buf = NULL;
 	int err, nr_cpus_avail;
 	unsigned int kernel_version;
 	char linux_version_code_str[64];
 	const char *clang_opt = llvm_param.clang_opt;
 	char clang_path[PATH_MAX], llc_path[PATH_MAX], abspath[PATH_MAX], nr_cpus_avail_str[64];
 	char serr[STRERR_BUFSIZE];
-	char *kbuild_dir = NULL, *kbuild_include_opts = NULL,
-	     *perf_bpf_include_opts = NULL;
+	char *perf_bpf_include_opts = NULL;
 	const char *template = llvm_param.clang_bpf_cmd_template;
 	char *pipe_template = NULL;
 	const char *opts = llvm_param.opts;
-	char *command_echo = NULL, *command_out;
+	char *command_echo = NULL;
 	char *libbpf_include_dir = system_path(LIBBPF_INCLUDE_DIR);
+	struct strbuf kbuild_dir = STRBUF_INIT;
+	struct strbuf kbuild_include_opts = STRBUF_INIT;
+	struct strbuf command_out = STRBUF_INIT;
 
 	if (path[0] != '-' && realpath(path, abspath) == NULL) {
 		err = errno;
@@ -501,9 +405,9 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 	force_set_env("LINUX_VERSION_CODE", linux_version_code_str);
 	force_set_env("CLANG_EXEC", clang_path);
 	force_set_env("CLANG_OPTIONS", clang_opt);
-	force_set_env("KERNEL_INC_OPTIONS", kbuild_include_opts);
+	force_set_env("KERNEL_INC_OPTIONS", kbuild_include_opts.buf);
 	force_set_env("PERF_BPF_INC_OPTIONS", perf_bpf_include_opts);
-	force_set_env("WORKING_DIR", kbuild_dir ? : ".");
+	force_set_env("WORKING_DIR", kbuild_dir.len ? kbuild_dir.buf : ".");
 
 	if (opts) {
 		err = search_program_and_warn(llvm_param.llc_path, "llc", llc_path);
@@ -549,11 +453,11 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 		SWAP_CHAR('&', '\006');
 		SWAP_CHAR('\a', '"');
 	}
-	err = read_from_pipe(command_echo, (void **) &command_out, NULL);
-	if (err)
+	err = run_command_strbuf(command_echo, &command_out);
+	if (err < 0)
 		goto errout;
 
-	for (char *p = command_out; *p; p++) {
+	for (char *p = command_out.buf; *p; p++) {
 		SWAP_CHAR('\001', '<');
 		SWAP_CHAR('\002', '>');
 		SWAP_CHAR('\003', '"');
@@ -562,10 +466,10 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 		SWAP_CHAR('\006', '&');
 	}
 #undef SWAP_CHAR
-	pr_debug("llvm compiling command : %s\n", command_out);
+	pr_debug("llvm compiling command : %s\n", command_out.buf);
 
-	err = read_from_pipe(template, &obj_buf, &obj_buf_sz);
-	if (err) {
+	err = run_command_strbuf(template, obj_buf);
+	if (err < 0) {
 		pr_err("ERROR:\tunable to compile %s\n", path);
 		pr_err("Hint:\tCheck error message shown above.\n");
 		pr_err("Hint:\tYou can also pre-compile it into .o using:\n");
@@ -574,33 +478,15 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 		goto errout;
 	}
 
-	free(command_echo);
-	free(command_out);
-	free(kbuild_dir);
-	free(kbuild_include_opts);
-	free(perf_bpf_include_opts);
-	free(libbpf_include_dir);
-
-	if (!p_obj_buf)
-		free(obj_buf);
-	else
-		*p_obj_buf = obj_buf;
-
-	if (p_obj_buf_sz)
-		*p_obj_buf_sz = obj_buf_sz;
-	return 0;
+	err = 0;
 errout:
 	free(command_echo);
-	free(kbuild_dir);
-	free(kbuild_include_opts);
-	free(obj_buf);
+	strbuf_release(&command_out);
+	strbuf_release(&kbuild_dir);
+	strbuf_release(&kbuild_include_opts);
 	free(perf_bpf_include_opts);
 	free(libbpf_include_dir);
 	free(pipe_template);
-	if (p_obj_buf)
-		*p_obj_buf = NULL;
-	if (p_obj_buf_sz)
-		*p_obj_buf_sz = 0;
 	return err;
 }
 
diff --git a/tools/perf/util/llvm-utils.h b/tools/perf/util/llvm-utils.h
index 7878a0e3fa98..0ad25e42aa6e 100644
--- a/tools/perf/util/llvm-utils.h
+++ b/tools/perf/util/llvm-utils.h
@@ -56,13 +56,15 @@ struct llvm_param {
 extern struct llvm_param llvm_param;
 int perf_llvm_config(const char *var, const char *value);
 
-int llvm__compile_bpf(const char *path, void **p_obj_buf, size_t *p_obj_buf_sz);
+struct strbuf;
+int llvm__compile_bpf(const char *path, struct strbuf *obj_buf);
 
 /* This function is for test__llvm() use only */
 int llvm__search_clang(void);
 
 /* Following functions are reused by builtin clang support */
-void llvm__get_kbuild_opts(char **kbuild_dir, char **kbuild_include_opts);
+struct strbuf;
+void llvm__get_kbuild_opts(struct strbuf *kbuild_dir, struct strbuf *kbuild_include_opts);
 int llvm__get_nr_cpus(void);
 
 void llvm__dump_obj(const char *path, void *obj_buf, size_t size);
-- 
2.39.0.314.g84b9a713c41-goog

