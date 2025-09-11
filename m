Return-Path: <bpf+bounces-68147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44673B536C5
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 17:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14881888C10
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78750350824;
	Thu, 11 Sep 2025 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bakg+Cks"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62AC34DCDE
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602710; cv=none; b=fSBMcAGtXN9QTHVxhjthUCDriKfo0Pxf3KwAFSAjNSKc2btwdNlpDbhpxVzlaqjYA9pmH9wIuENOwxPfS48Tgq35oQY+Dctza9ySc46RdE0QcyASa6YOSW7MT0+HdN8Ab4JQ80CKJ2+RKavAbN2NMEye4eTrZ4D6K5yQGAKHc70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602710; c=relaxed/simple;
	bh=mg5rB44SPgtRPdIFkt6qWxj9dOzkC21FpY0e+kBftEc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZFzUA2eCoW8hI/ArclHgBcL3g/24Qn5/0S02WkQSfUNXO2CRgDifXaFzPywG0LemeqIjbVdaDqMLW3dKnM0eSKVs0flBAEwbXiTjD+wYEY5BHyzPc2Q08z5gtC+3ov4nZLfVIY25QX8GioOvzh7xKh9Gsz/gC8ITtigAJRMdcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bakg+Cks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDB1C4CEF0;
	Thu, 11 Sep 2025 14:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757602709;
	bh=mg5rB44SPgtRPdIFkt6qWxj9dOzkC21FpY0e+kBftEc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Bakg+Cks3LXvVDZDusn3IkMz7/URmW7jPb3VoLniePk4r0tZ3uxRMSizbHuZblU/8
	 1GeVlig9GX1BFGAtcfJv1oiPYWzFK+qOPRNbIong4qsgv6/B+z+gbSONS4iLO4m1E1
	 dXyoVNUJ5w2w1etpIvmQqAW3wlPkKDiG+YiX19mTxrwLgqbOlaM+CF1lZJCLYshAyG
	 nJgkHec+r//qeA0saCmwv/Wn41UR6cSrnvF6HL+Mao5LkpgBldQbPlMm6hhuZe1SYM
	 63xsoILWHYs2bWCzEdWEsx7GLneKCisadzcqpEg1Ry73Q5GmiqsfJsHc1Tgu827Scc
	 Vzggn1Ka5wFBQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v7 4/6] selftests: bpf: introduce __stderr and __stdout
Date: Thu, 11 Sep 2025 14:58:03 +0000
Message-ID: <20250911145808.58042-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911145808.58042-1-puranjay@kernel.org>
References: <20250911145808.58042-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __stderr and __stdout to validate the output of BPF streams for bpf
selftests. Similar to __xlated, __jited, etc., __stderr/out can be used
in the BPF progs to compare a string (regex supported) to the output in
the bpf streams.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 10 +++
 tools/testing/selftests/bpf/test_loader.c    | 90 ++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 72c2d72a245e..7905396c9cc4 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -35,6 +35,12 @@
  *                   inside the brackets.
  * __msg_unpriv      Same as __msg but for unprivileged mode.
  *
+ * __stderr          Message expected to be found in bpf stderr stream. The
+ *                   same regex rules apply like __msg.
+ * __stderr_unpriv   Same as __stderr but for unpriveleged mode.
+ * __stdout          Same as __stderr but for stdout stream.
+ * __stdout_unpriv   Same as __stdout but for unpriveleged mode.
+ *
  * __xlated          Expect a line in a disassembly log after verifier applies rewrites.
  *                   Multiple __xlated attributes could be specified.
  *                   Regular expressions could be specified same way as in __msg.
@@ -140,6 +146,10 @@
 #define __caps_unpriv(caps)	__attribute__((btf_decl_tag("comment:test_caps_unpriv=" EXPAND_QUOTE(caps))))
 #define __load_if_JITed()	__attribute__((btf_decl_tag("comment:load_mode=jited")))
 #define __load_if_no_JITed()	__attribute__((btf_decl_tag("comment:load_mode=no_jited")))
+#define __stderr(msg)		__attribute__((btf_decl_tag("comment:test_expect_stderr=" XSTR(__COUNTER__) "=" msg)))
+#define __stderr_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_stderr_unpriv=" XSTR(__COUNTER__) "=" msg)))
+#define __stdout(msg)		__attribute__((btf_decl_tag("comment:test_expect_stdout=" XSTR(__COUNTER__) "=" msg)))
+#define __stdout_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_stdout_unpriv=" XSTR(__COUNTER__) "=" msg)))
 
 /* Define common capabilities tested using __caps_unpriv */
 #define CAP_NET_ADMIN		12
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 9f684d0dc5b4..e065b467d509 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -38,6 +38,10 @@
 #define TEST_TAG_JITED_PFX_UNPRIV "comment:test_jited_unpriv="
 #define TEST_TAG_CAPS_UNPRIV "comment:test_caps_unpriv="
 #define TEST_TAG_LOAD_MODE_PFX "comment:load_mode="
+#define TEST_TAG_EXPECT_STDERR_PFX "comment:test_expect_stderr="
+#define TEST_TAG_EXPECT_STDERR_PFX_UNPRIV "comment:test_expect_stderr_unpriv="
+#define TEST_TAG_EXPECT_STDOUT_PFX "comment:test_expect_stdout="
+#define TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV "comment:test_expect_stdout_unpriv="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xbadcafe
@@ -79,6 +83,8 @@ struct test_subspec {
 	struct expected_msgs expect_msgs;
 	struct expected_msgs expect_xlated;
 	struct expected_msgs jited;
+	struct expected_msgs stderr;
+	struct expected_msgs stdout;
 	int retval;
 	bool execute;
 	__u64 caps;
@@ -139,6 +145,10 @@ static void free_test_spec(struct test_spec *spec)
 	free_msgs(&spec->unpriv.expect_xlated);
 	free_msgs(&spec->priv.jited);
 	free_msgs(&spec->unpriv.jited);
+	free_msgs(&spec->unpriv.stderr);
+	free_msgs(&spec->priv.stderr);
+	free_msgs(&spec->unpriv.stdout);
+	free_msgs(&spec->priv.stdout);
 
 	free(spec->priv.name);
 	free(spec->unpriv.name);
@@ -407,6 +417,10 @@ static int parse_test_spec(struct test_loader *tester,
 	bool xlated_on_next_line = true;
 	bool unpriv_jit_on_next_line;
 	bool jit_on_next_line;
+	bool stderr_on_next_line = true;
+	bool unpriv_stderr_on_next_line = true;
+	bool stdout_on_next_line = true;
+	bool unpriv_stdout_on_next_line = true;
 	bool collect_jit = false;
 	int func_id, i, err = 0;
 	u32 arch_mask = 0;
@@ -598,6 +612,26 @@ static int parse_test_spec(struct test_loader *tester,
 				err = -EINVAL;
 				goto cleanup;
 			}
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDERR_PFX))) {
+			err = push_disasm_msg(msg, &stderr_on_next_line,
+					      &spec->priv.stderr);
+			if (err)
+				goto cleanup;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDERR_PFX_UNPRIV))) {
+			err = push_disasm_msg(msg, &unpriv_stderr_on_next_line,
+					      &spec->unpriv.stderr);
+			if (err)
+				goto cleanup;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX))) {
+			err = push_disasm_msg(msg, &stdout_on_next_line,
+					      &spec->priv.stdout);
+			if (err)
+				goto cleanup;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV))) {
+			err = push_disasm_msg(msg, &unpriv_stdout_on_next_line,
+					      &spec->unpriv.stdout);
+			if (err)
+				goto cleanup;
 		}
 	}
 
@@ -651,6 +685,10 @@ static int parse_test_spec(struct test_loader *tester,
 			clone_msgs(&spec->priv.expect_xlated, &spec->unpriv.expect_xlated);
 		if (spec->unpriv.jited.cnt == 0)
 			clone_msgs(&spec->priv.jited, &spec->unpriv.jited);
+		if (spec->unpriv.stderr.cnt == 0)
+			clone_msgs(&spec->priv.stderr, &spec->unpriv.stderr);
+		if (spec->unpriv.stdout.cnt == 0)
+			clone_msgs(&spec->priv.stdout, &spec->unpriv.stdout);
 	}
 
 	spec->valid = true;
@@ -712,6 +750,20 @@ static void emit_jited(const char *jited, bool force)
 	fprintf(stdout, "JITED:\n=============\n%s=============\n", jited);
 }
 
+static void emit_stderr(const char *stderr, bool force)
+{
+	if (!force && env.verbosity == VERBOSE_NONE)
+		return;
+	fprintf(stdout, "STDERR:\n=============\n%s=============\n", stderr);
+}
+
+static void emit_stdout(const char *bpf_stdout, bool force)
+{
+	if (!force && env.verbosity == VERBOSE_NONE)
+		return;
+	fprintf(stdout, "STDOUT:\n=============\n%s=============\n", bpf_stdout);
+}
+
 static void validate_msgs(char *log_buf, struct expected_msgs *msgs,
 			  void (*emit_fn)(const char *buf, bool force))
 {
@@ -934,6 +986,19 @@ static int get_xlated_program_text(int prog_fd, char *text, size_t text_sz)
 	return err;
 }
 
+/* Read the bpf stream corresponding to the stream_id */
+static int get_stream(int stream_id, int prog_fd, char *text, size_t text_sz)
+{
+	LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
+	int ret;
+
+	ret = bpf_prog_stream_read(prog_fd, stream_id, text, text_sz, &ropts);
+	ASSERT_GT(ret, 0, "stream read");
+	text[ret] = '\0';
+
+	return ret;
+}
+
 /* this function is forced noinline and has short generic name to look better
  * in test_progs output (in case of a failure)
  */
@@ -1108,6 +1173,31 @@ void run_subtest(struct test_loader *tester,
 			PRINT_FAIL("Unexpected retval: %d != %d\n", retval, subspec->retval);
 			goto tobj_cleanup;
 		}
+
+		if (subspec->stderr.cnt) {
+			err = get_stream(2, bpf_program__fd(tprog),
+					 tester->log_buf, tester->log_buf_sz);
+			if (err <= 0) {
+				PRINT_FAIL("Unexpected retval from get_stream(): %d, errno = %d\n",
+					   err, errno);
+				goto tobj_cleanup;
+			}
+			emit_stderr(tester->log_buf, false /*force*/);
+			validate_msgs(tester->log_buf, &subspec->stderr, emit_stderr);
+		}
+
+		if (subspec->stdout.cnt) {
+			err = get_stream(1, bpf_program__fd(tprog),
+					 tester->log_buf, tester->log_buf_sz);
+			if (err <= 0) {
+				PRINT_FAIL("Unexpected retval from get_stream(): %d, errno = %d\n",
+					   err, errno);
+				goto tobj_cleanup;
+			}
+			emit_stdout(tester->log_buf, false /*force*/);
+			validate_msgs(tester->log_buf, &subspec->stdout, emit_stdout);
+		}
+
 		/* redo bpf_map__attach_struct_ops for each test */
 		while (links_cnt > 0)
 			bpf_link__destroy(links[--links_cnt]);
-- 
2.47.3


