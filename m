Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9123F5372CD
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 00:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiE2Why (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 May 2022 18:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiE2Whw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 May 2022 18:37:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE3052503
        for <bpf@vger.kernel.org>; Sun, 29 May 2022 15:37:51 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u23so14255302lfc.1
        for <bpf@vger.kernel.org>; Sun, 29 May 2022 15:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3J6ILANQ56bM6p9u038NVyVMSrQ7vRTvG/6h9ribSM=;
        b=SVU9K5L9pxjQ/9Y7AVPcjDV2J80prVz6cnbssa45RBRQ/z88Lcevz6HSkiJ5lcVmri
         Np/hacQ3I5TnGg5Bqdhkob7c+0oUHKDvufyhHIlIfmOMF1l9u3ra4OYTlez8uCTnpDtB
         CaD7dEkBPLZoCuGeKxxF1PWtiQLZZlMf3+xI/hXM5Y0+xeEYwq2ZWRR4xnjBYSrB5l4A
         mCsASYbkM/+OMcC+DrB4PJdV3uAxjAaszTc8syukgpidPNT0yPkRQzi1+BXIy/HHxGMW
         FgJgCgfsIBPA37yNgiuMIgGpz6jC8xTaq0sUSlntKwelOPJGIhaPYzdak2k9EZw2M4/t
         ddjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3J6ILANQ56bM6p9u038NVyVMSrQ7vRTvG/6h9ribSM=;
        b=2ubYCH3KwX8lPzkgqz8X8PYI6q3mrmKm/grdBRqwSUgMnkyL1pAuFhVsMfyniW05TG
         lWXnPn7zHEHsRJy7U/82eAapWdUsOOpMuQ5TpQsrMylnUNUBt+1jHxfeBOYiB0Wdym1/
         rwBLCnGeHCjVWUO5DoCCsgKIh1kLNTWm7rHFenhBiuT0p75SufD5Oh6LyLmstcyiHIG3
         G9KjflAUgWX6MON8yPQ6w8seV8w1tXOc+BKeP1ty4e1OALtF8yaVbYNLjHasNEtkB/xE
         RcBZKei+7IcioZ/JiXHXI06jcSvvsYDlOLJQrl0euQUQQtA+1reeZNjtkvuO7tycfyxk
         N8ww==
X-Gm-Message-State: AOAM531vaJNFzytcr+E/IdRKc9Ri9OHq13Zb0NOtKlz4M/jYnWVLC97J
        Ncp4KNOd/n84b7dx6xcPLcvy4QPK8Ak=
X-Google-Smtp-Source: ABdhPJyh+OoCp5uw69axD+J3AlItFMZUnW2di9erftfFJrP+b0HFcmgEa353y8OXmbvJoH1vZdZjQA==
X-Received: by 2002:ac2:5bc4:0:b0:478:5e54:fdaa with SMTP id u4-20020ac25bc4000000b004785e54fdaamr29489431lfn.148.1653863869091;
        Sun, 29 May 2022 15:37:49 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id d8-20020ac24c88000000b0047255d211a7sm1962861lfl.214.2022.05.29.15.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 15:37:48 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: allow BTF specs and func infos in test_verifier tests
Date:   Mon, 30 May 2022 01:36:45 +0300
Message-Id: <20220529223646.862464-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220529223646.862464-1-eddyz87@gmail.com>
References: <20220529223646.862464-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BTF and func_info specification for test_verifier tests follows
the same notation as in prog_tests/btf.c tests. E.g.:

  ...
  .func_info = { { 0, 6 }, { 8, 7 } },
  .func_info_cnt = 2,
  .btf_strings = "\0int\0",
  .btf_types = {
    BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
    BTF_PTR_ENC(1),
  },
  ...

The BTF specification is loaded only when specified.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c |   1 -
 tools/testing/selftests/bpf/test_btf.h       |   2 +
 tools/testing/selftests/bpf/test_verifier.c  | 110 ++++++++++++++++---
 3 files changed, 95 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index ba5bde53d418..bebc98bad615 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -34,7 +34,6 @@ static bool always_log;
 #undef CHECK
 #define CHECK(condition, format...) _CHECK(condition, "check", duration, format)
 
-#define BTF_END_RAW 0xdeadbeef
 #define NAME_TBD 0xdeadb33f
 
 #define NAME_NTH(N) (0xfffe0000 | N)
diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selftests/bpf/test_btf.h
index 128989bed8b7..044663c45a57 100644
--- a/tools/testing/selftests/bpf/test_btf.h
+++ b/tools/testing/selftests/bpf/test_btf.h
@@ -4,6 +4,8 @@
 #ifndef _TEST_BTF_H
 #define _TEST_BTF_H
 
+#define BTF_END_RAW 0xdeadbeef
+
 #define BTF_INFO_ENC(kind, kind_flag, vlen)			\
 	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
 
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 13468221d227..b6dfa633bffa 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -59,11 +59,17 @@
 #define MAX_TEST_RUNS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
+#define MAX_FUNC_INFOS	8
+#define MAX_BTF_STRINGS	256
+#define MAX_BTF_TYPES	256
 
 #define INSN_OFF_MASK	((s16)0xFFFF)
 #define INSN_IMM_MASK	((s32)0xFFFFFFFF)
 #define SKIP_INSNS()	BPF_RAW_INSN(0xde, 0xa, 0xd, 0xbeef, 0xdeadbeef)
 
+#define DEFAULT_LIBBPF_LOG_LEVEL	4
+#define VERBOSE_LIBBPF_LOG_LEVEL	1
+
 #define F_NEEDS_EFFICIENT_UNALIGNED_ACCESS	(1 << 0)
 #define F_LOAD_WITH_STRICT_ALIGNMENT		(1 << 1)
 
@@ -154,6 +160,14 @@ struct bpf_test {
 	};
 	enum bpf_attach_type expected_attach_type;
 	const char *kfunc;
+	struct bpf_func_info func_info[MAX_FUNC_INFOS];
+	int func_info_cnt;
+	char btf_strings[MAX_BTF_STRINGS];
+	/* A set of BTF types to load when specified,
+	 * use macro definitions from test_btf.h,
+	 * must end with BTF_END_RAW
+	 */
+	__u32 btf_types[MAX_BTF_TYPES];
 };
 
 /* Note we want this to be 64 bit aligned so that the end of our array is
@@ -683,34 +697,67 @@ static __u32 btf_raw_types[] = {
 	BTF_MEMBER_ENC(71, 13, 128), /* struct prog_test_member __kptr_ref *ptr; */
 };
 
-static int load_btf(void)
+static char bpf_vlog[UINT_MAX >> 8];
+
+static int load_btf_spec(__u32 *types, int types_len,
+			 const char *strings, int strings_len)
 {
 	struct btf_header hdr = {
 		.magic = BTF_MAGIC,
 		.version = BTF_VERSION,
 		.hdr_len = sizeof(struct btf_header),
-		.type_len = sizeof(btf_raw_types),
-		.str_off = sizeof(btf_raw_types),
-		.str_len = sizeof(btf_str_sec),
+		.type_len = types_len,
+		.str_off = types_len,
+		.str_len = strings_len,
 	};
 	void *ptr, *raw_btf;
 	int btf_fd;
 
-	ptr = raw_btf = malloc(sizeof(hdr) + sizeof(btf_raw_types) +
-			       sizeof(btf_str_sec));
+	raw_btf = malloc(sizeof(hdr) + types_len + strings_len);
 
+	ptr = raw_btf;
 	memcpy(ptr, &hdr, sizeof(hdr));
 	ptr += sizeof(hdr);
-	memcpy(ptr, btf_raw_types, hdr.type_len);
+	memcpy(ptr, types, hdr.type_len);
 	ptr += hdr.type_len;
-	memcpy(ptr, btf_str_sec, hdr.str_len);
+	memcpy(ptr, strings, hdr.str_len);
 	ptr += hdr.str_len;
 
-	btf_fd = bpf_btf_load(raw_btf, ptr - raw_btf, NULL);
-	free(raw_btf);
+	LIBBPF_OPTS(bpf_btf_load_opts, opts,
+		    .log_buf = bpf_vlog,
+		    .log_size = sizeof(bpf_vlog),
+		    .log_level = (verbose
+				  ? VERBOSE_LIBBPF_LOG_LEVEL
+				  : DEFAULT_LIBBPF_LOG_LEVEL),
+	);
+
+	btf_fd = bpf_btf_load(raw_btf, ptr - raw_btf, &opts);
 	if (btf_fd < 0)
-		return -1;
-	return btf_fd;
+		printf("Failed to load BTF spec: '%s'\n", strerror(errno));
+
+	free(raw_btf);
+
+	return btf_fd < 0 ? -1 : btf_fd;
+}
+
+static int load_btf(void)
+{
+	return load_btf_spec(btf_raw_types, sizeof(btf_raw_types),
+			     btf_str_sec, sizeof(btf_str_sec));
+}
+
+static int load_btf_for_test(struct bpf_test *test)
+{
+	int types_num = 0;
+
+	while (types_num < MAX_BTF_TYPES &&
+	       test->btf_types[types_num] != BTF_END_RAW)
+		++types_num;
+
+	int types_len = types_num * sizeof(test->btf_types[0]);
+
+	return load_btf_spec(test->btf_types, types_len,
+			     test->btf_strings, sizeof(test->btf_strings));
 }
 
 static int create_map_spin_lock(void)
@@ -789,8 +836,6 @@ static int create_map_kptr(void)
 	return fd;
 }
 
-static char bpf_vlog[UINT_MAX >> 8];
-
 static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 			  struct bpf_insn *prog, int *map_fds)
 {
@@ -1351,10 +1396,23 @@ static bool check_xlated_program(struct bpf_test *test, int fd_prog)
 	return result;
 }
 
+static bool string_ends_with_nl(char *str, int str_len)
+{
+	bool ends_with_nl = false;
+
+	for (int i = 0; i < str_len; ++i) {
+		if (str[i] == 0)
+			break;
+		ends_with_nl = str[i] == '\n';
+	}
+
+	return ends_with_nl;
+}
+
 static void do_test_single(struct bpf_test *test, bool unpriv,
 			   int *passes, int *errors)
 {
-	int fd_prog, expected_ret, alignment_prevented_execution;
+	int fd_prog, btf_fd, expected_ret, alignment_prevented_execution;
 	int prog_len, prog_type = test->prog_type;
 	struct bpf_insn *prog = test->insns;
 	LIBBPF_OPTS(bpf_prog_load_opts, opts);
@@ -1366,8 +1424,10 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	__u32 pflags;
 	int i, err;
 
+	fd_prog = -1;
 	for (i = 0; i < MAX_NR_MAPS; i++)
 		map_fds[i] = -1;
+	btf_fd = -1;
 
 	if (!prog_type)
 		prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
@@ -1400,11 +1460,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 
 	opts.expected_attach_type = test->expected_attach_type;
 	if (verbose)
-		opts.log_level = 1;
+		opts.log_level = VERBOSE_LIBBPF_LOG_LEVEL;
 	else if (expected_ret == VERBOSE_ACCEPT)
 		opts.log_level = 2;
 	else
-		opts.log_level = 4;
+		opts.log_level = DEFAULT_LIBBPF_LOG_LEVEL;
 	opts.prog_flags = pflags;
 
 	if (prog_type == BPF_PROG_TYPE_TRACING && test->kfunc) {
@@ -1422,6 +1482,19 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		opts.attach_btf_id = attach_btf_id;
 	}
 
+	if (test->btf_types[0] != 0) {
+		btf_fd = load_btf_for_test(test);
+		if (btf_fd < 0)
+			goto fail_log;
+		opts.prog_btf_fd = btf_fd;
+	}
+
+	if (test->func_info_cnt != 0) {
+		opts.func_info = test->func_info;
+		opts.func_info_cnt = test->func_info_cnt;
+		opts.func_info_rec_size = sizeof(test->func_info[0]);
+	}
+
 	opts.log_buf = bpf_vlog;
 	opts.log_size = sizeof(bpf_vlog);
 	fd_prog = bpf_prog_load(prog_type, NULL, "GPL", prog, prog_len, &opts);
@@ -1533,6 +1606,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	if (test->fill_insns)
 		free(test->fill_insns);
 	close(fd_prog);
+	close(btf_fd);
 	for (i = 0; i < MAX_NR_MAPS; i++)
 		close(map_fds[i]);
 	sched_yield();
@@ -1540,6 +1614,8 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 fail_log:
 	(*errors)++;
 	printf("%s", bpf_vlog);
+	if (!string_ends_with_nl(bpf_vlog, sizeof(bpf_vlog)))
+		printf("\n");
 	goto close_fds;
 }
 
-- 
2.25.1

