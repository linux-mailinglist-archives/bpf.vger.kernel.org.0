Return-Path: <bpf+bounces-67729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B78F7B495F4
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 18:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF577ACD37
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB733128A0;
	Mon,  8 Sep 2025 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWmgwGNs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A01D6BB
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349427; cv=none; b=Lg1xGyX3T6dI4dXE8dGNJnSp2kxrOb2HMHpemh7xfjDFTWnIpla6VMnkG0yoDlN1YhGuahN+dAdi26q0hmvVUE7G7X7UY4yKJp8z4AqqpWjj/io3U96ngRd9T6b3OTq/yum8G5DLFsabq/CNK2x7Y02D4oIuYN53RemKZ7dwHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349427; c=relaxed/simple;
	bh=i5HPQpFxl5jsUa+ZEq3dbcjbcHyGZXqL8pLBSv4PUik=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFivkD/G9rIwNVnjzV13wUBKsaWpfm1fKohvlMOvfcU30+68ID2bIHy0xma4qYH8uBdMrymPG3SmzZ4ncR8yPxQJcDKC1fI+fZugRcnw8opZkuqMQyG187WQMF+n4iZE6lxkhFMqR6oeRm7MwTyXwDlHf2WxlmW6BgH80sp5X5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWmgwGNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AB0C4CEF1;
	Mon,  8 Sep 2025 16:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349427;
	bh=i5HPQpFxl5jsUa+ZEq3dbcjbcHyGZXqL8pLBSv4PUik=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XWmgwGNscCEf6ukkuZDVmQCbZ69UvKm1Yxto9ZJphvDMhKzR8YB5jC6H0wlk3GaCy
	 P3ZIz0FDK5meZR2cmFdeWkkHe9osRFZ2PG2pwAQkZamv5Uh6jC0sIrFbDqp3zAXvP8
	 xdp5JjzMaz9yI+q/iz5ihagaBYrK+XtzooKMthtALfZJ7UdarhHIHvilgLYo+xep9V
	 kMZjf1pDla53C0pR8OScFQlzgwYjIERdjSvx4j+dVlVuOlPH+MCbGlwvqHxzBK5X2+
	 6C8MFzDIJld4ayM2SLUWlMhzUq9xc3qXO/MdzjBbvYVy+xIkNAoeTo3rWnb7R6SUka
	 yZ0U0hTne1dTA==
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
Subject: [PATCH bpf-next v6 4/5] selftests: bpf: introduce __stderr and __stdout
Date: Mon,  8 Sep 2025 16:36:33 +0000
Message-ID: <20250908163638.23150-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908163638.23150-1-puranjay@kernel.org>
References: <20250908163638.23150-1-puranjay@kernel.org>
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
index 72c2d72a245e5..7905396c9cc4e 100644
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
index a9388ac883587..ccf54694da7cc 100644
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


