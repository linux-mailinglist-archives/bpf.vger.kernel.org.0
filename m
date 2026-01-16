Return-Path: <bpf+bounces-79198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 488EED2D106
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 543AF3094F9F
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33E131A046;
	Fri, 16 Jan 2026 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj/uzXTq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ADB2FD7B1
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547889; cv=none; b=YrvTx1RtL8zieq7op2+slw7we8hJ1J+gtLSHdm4fefvHhLTOkkTO7vJ7XMukB61W8csxB8902CBIC8eFX4DsD79oGL8oFBbZynYsct4v6pksbmsOTju/szSgNKFbBrRPRfJc5kFUzKjrfsnWVsACHm5Or+TT2tgKvL61Hhxf8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547889; c=relaxed/simple;
	bh=EaAxHhBihNbgSpMWs6VwmPwyGN3Y9pEdX7OYsgkOQdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdXXsqm7q9C1c4DIjwRh86/5yISQGO9vQnqNhZru4N5izZ0YN4bzajf8BSoFzWp+O7QLBLukMoDsXKb28g+d0RwddKdZ6fUcyXBSgaWaYCOI251n+pqNZPNmmW3YOelgIjZHW4ThkKDzSO8pbnJbsFh11EUpspW1fnwrOMxJOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj/uzXTq; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a081c163b0so10017085ad.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 23:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768547886; x=1769152686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W6hsT0Cah8oIHuXixUZEynPv/ALwNuU4vKUiOQ3rA0=;
        b=nj/uzXTq4YLSFoRTfHyQM/TJhdgZeAjN96mraSn09sBGJWKGtN4GyvlautqfKlaXBQ
         +w6bXhVYa1E7/rewQ14DP1W1CcUR/w9FO96FDFyyC8tAuF1yc41z96wAwdrMIZlVSFaW
         9VWe1qLC7ticEVdPxC1PRMcWv/FeWOMZf1nK5OFJfkUHmUgZsis0kPsxgjGyWrvB3O9x
         50vbTbVsnM++rdQhOqa8MtIxyMbG4EhgdkRrhXgg5PwxFJciQkEPBX22wI21e32ekxBp
         se9lXDqcVpRzdUOifuSEGFfv4/Atv6Ufw+XJvd6JBQdO6eZnrqvsupjFA90wWuyCII45
         kdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768547886; x=1769152686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8W6hsT0Cah8oIHuXixUZEynPv/ALwNuU4vKUiOQ3rA0=;
        b=hQAOj/Ncak+QsOl0vlLGiGrIjDP7S1rAu09hD5stie6DjpO8Ci5KZ1hB0sBzC3/cQN
         Zb4qtRWffqxGeWuby7ae8xkbpkr4wTMK1eF0z5h3EZKtsgTTsJ/67VqBLmrk3OVXKt+k
         MP6tMj9TXBAIE+tfjI6srqldvuM8Rid57B1xQZvg5dJ6Eu524fG7hq+PhMXvM7xMAG1v
         mnKOt0aXDurwjJde4udZ331JdVWr3mJfocphWKOcV2xhMqRO5by9vS5+E0En20DuSS/z
         I0vj40U+kSAlAZCqnDhvdJvNbPep/NQiiH2oauKc6bEM9t28jCKt/BZBZ+zviGMbosCw
         jscw==
X-Forwarded-Encrypted: i=1; AJvYcCXx0ysiHK8rZw5nwYb0dsYUOmI+hHCq3PvT2JUiN1fO5oZ2APR0KBfVjLVBJp1lAdHAXD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXwQ3+VKwK0PdyofIAvuWJqYt3dgqCClbITVJcYxZm/UnJTmMH
	s1GDPO0dX24pHMIZw6rcRKBWddrEBYKVPY1aGbsKCKk2e4duC14U1fYl
X-Gm-Gg: AY/fxX4vtPvRz0GAHAacKLe5P6fC4VdrTVrVgomg7aODIJlS+2ibZDyFk/B/zM3VUOq
	olyoB5hAGOyp9eDWlONbOnCTGt/hVjr+M73ZBgeyiQ5FR8HBW6hQ8hTlLC29bS+21pID4PjeglB
	G77NnF9iTje0+NQi7dkugwYJoIj0o7f4QH2pxM9ETckJ9DwhNyuW8rYutiBVWO3Bae9tcxluOXe
	Oje+v4MAzjGOfZCpyYqLDGa9Rf+N1++g9XYter7pqlID2h0h2Rz0IbiC3Z4H/++SkfmkKnXOxz9
	7wAd1q0JRkoeNPHY5jVVrz/YmFbnDOGp3ssvoQTI/rZEudUBTFUuR69OT/sg5/jNRisB4uOTxjD
	/hLypnnv1jTpWuwZC4PcABG2ft0+L+ImA3JLl3cFSVsPMheTLPg3XkW2ewGxK7ouRZ42Q3SPbxE
	JMpUdHAUs=
X-Received: by 2002:a17:903:41c7:b0:297:f8d9:aad7 with SMTP id d9443c01a7336-2a7177dfcb2mr18715785ad.50.1768547886068;
        Thu, 15 Jan 2026 23:18:06 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce2ebsm12508275ad.32.2026.01.15.23.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 23:18:05 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: test bpf_get_func_arg() for tp_btf
Date: Fri, 16 Jan 2026 15:17:39 +0800
Message-ID: <20260116071739.121182-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116071739.121182-1-dongml2@chinatelecom.cn>
References: <20260116071739.121182-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test bpf_get_func_arg() and bpf_get_func_arg_cnt() for tp_btf. The code
is most copied from test1 and test2.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../bpf/prog_tests/get_func_args_test.c       |  3 ++
 .../selftests/bpf/progs/get_func_args_test.c  | 45 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 4 files changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
index 64a9c95d4acf..fadee95d3ae8 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
@@ -33,11 +33,14 @@ void test_get_func_args_test(void)
 
 	ASSERT_EQ(topts.retval >> 16, 1, "test_run");
 	ASSERT_EQ(topts.retval & 0xffff, 1234 + 29, "test_run");
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
 
 	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
 	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
 	ASSERT_EQ(skel->bss->test3_result, 1, "test3_result");
 	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
+	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
+	ASSERT_EQ(skel->bss->test6_result, 1, "test6_result");
 
 cleanup:
 	get_func_args_test__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index e0f34a55e697..4b0dc233d498 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -121,3 +121,48 @@ int BPF_PROG(fexit_test, int _a, int *_b, int _ret)
 	test4_result &= err == 0 && ret == 1234;
 	return 0;
 }
+
+__u64 test5_result = 0;
+SEC("tp_btf/bpf_testmod_fentry_test1_tp")
+int BPF_PROG(tp_test1)
+{
+	__u64 cnt = bpf_get_func_arg_cnt(ctx);
+	__u64 a = 0, z = 0;
+	__s64 err;
+
+	test5_result = cnt == 1;
+
+	err = bpf_get_func_arg(ctx, 0, &a);
+	test5_result &= err == 0 && ((int) a == 1);
+	bpf_printk("cnt=%d a=%d\n", cnt, (int)a);
+
+	/* not valid argument */
+	err = bpf_get_func_arg(ctx, 1, &z);
+	test5_result &= err == -EINVAL;
+
+	return 0;
+}
+
+__u64 test6_result = 0;
+SEC("tp_btf/bpf_testmod_fentry_test2_tp")
+int BPF_PROG(tp_test2)
+{
+	__u64 cnt = bpf_get_func_arg_cnt(ctx);
+	__u64 a = 0, b = 0, z = 0;
+	__s64 err;
+
+	test6_result = cnt == 2;
+
+	/* valid arguments */
+	err = bpf_get_func_arg(ctx, 0, &a);
+	test6_result &= err == 0 && (int) a == 2;
+
+	err = bpf_get_func_arg(ctx, 1, &b);
+	test6_result &= err == 0 && b == 3;
+
+	/* not valid argument */
+	err = bpf_get_func_arg(ctx, 2, &z);
+	test6_result &= err == -EINVAL;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
index aeef86b3da74..45a5e41f3a92 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
@@ -63,6 +63,16 @@ BPF_TESTMOD_DECLARE_TRACE(bpf_testmod_test_writable_bare,
 	sizeof(struct bpf_testmod_test_writable_ctx)
 );
 
+DECLARE_TRACE(bpf_testmod_fentry_test1,
+	TP_PROTO(int a),
+	TP_ARGS(a)
+);
+
+DECLARE_TRACE(bpf_testmod_fentry_test2,
+	TP_PROTO(int a, u64 b),
+	TP_ARGS(a, b)
+);
+
 #endif /* _BPF_TESTMOD_EVENTS_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index bc07ce9d5477..f3698746f033 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -396,11 +396,15 @@ __weak noinline struct file *bpf_testmod_return_ptr(int arg)
 
 noinline int bpf_testmod_fentry_test1(int a)
 {
+	trace_bpf_testmod_fentry_test1_tp(a);
+
 	return a + 1;
 }
 
 noinline int bpf_testmod_fentry_test2(int a, u64 b)
 {
+	trace_bpf_testmod_fentry_test2_tp(a, b);
+
 	return a + b;
 }
 
-- 
2.52.0


