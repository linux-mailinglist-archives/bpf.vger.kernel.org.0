Return-Path: <bpf+bounces-79568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9C5D3C095
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3040F38943E
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 07:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAF03A7E13;
	Tue, 20 Jan 2026 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lujhPUPm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20553A7855
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894277; cv=none; b=UfZXROBXUiwy3Nu0IhEgjeziB0WiF4TkBmfS2tZOSxDWDGwpC7MhAeOCWJ0N0w1xHe99uWDmwR77L5bs1T6tERqIHOjX0Aowcy1mk9ZWQj8qqCauCrAaApyDUgt5LyXbFl9fuHaL15vQTX/XNuK8oj8XJQGQyXBROWJJ6vu2X8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894277; c=relaxed/simple;
	bh=kZiZh0VonzvzITLYzvii4c3vY29P/G7ZGQFYENdQFRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEP3VfLZk79oQdcScw85xLvf+KO1nYMsmavd7CdepTJfZEGVxPJsuV3wH5xs8JstzSEfVQMuIu8+Zc8r1u3/yOBd8oNHKXTUyOlEtFCVwCJ8L9x5E1CeTyXRRQNs+Suy4Cen3gr9UGbqvayt4AIL+XE3BDEa9MoaZscqaXVr+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lujhPUPm; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso1661717a12.3
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 23:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768894275; x=1769499075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxUe3zmQnPe+Di1h/wXJv+xTJZBq3RUkZe5dfyWfsD8=;
        b=lujhPUPmoO5KBJzWj04R73Gzom9CH9yyg2bTGrtHQoKUjI8hyKPMo38yIXAjFeZ7Dr
         hhyEMo+PEU7GdBYwRvgXpBbTc7T3HfifCxeh/i23JruBoTdXx/y4RpSBwOHc8h/f+A0L
         HJ9F16wH7Y1QuyNnCoun8dzk//Mk76qe8NIP90uFVcMMkSmxyPLP4SZLueubq2/02+dp
         vLd2w4NJL9BRnguImXvsafN8oMamL9Pmr5WvWMjR31r4f8mTvsOty6aHNSxEwNrtCEkm
         LkUXGQLZQY4w7YO7H+hNs8p5hxmNsDo29F2tfR0+WXPRhvtakb7Y9El1ptU6s5Y2qntQ
         BrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768894275; x=1769499075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxUe3zmQnPe+Di1h/wXJv+xTJZBq3RUkZe5dfyWfsD8=;
        b=dSD+jUpdpCUkhFMccLh2OaITEx7y6hA+/ukcMwk7t/qKqm1EZ+Z060KxXX+7HLzTMW
         O9ewSKpDTbQgaozL1p3TBiWaWjLVGQ2Q/CDwIGyovG767ldR5HJfY3PnNdsBzjtKDmmt
         w7bV1KV/MEjYmU/c8OiEHGginYvX+XTf4FBbjEBOFy32QArG1E20ovVNZTuapyYecWFb
         2/oBGPiSC3StcyjOcV7GzG0D1s7o0Ysuwk45werLlkMYQ8KzKfj3RfRfJiGhPKOj3VhT
         k0g/eqTytx4rQF+mSB6b3lmTgSkYHU88wP017H5TDIFsk4JeUE51PfE2NrcJTeYyYxGj
         PgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPapyeR4HQoVSkYszC/opdy1g2CWz+/Vd3RAE+I7DE+lkVXfCTTwFuMoEt1hICFj8laM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs78spaRzeKKwopDgdkFJXIMkmeQStrr5s3uAwjvGhhoDQLaKl
	xCXWik7Nb6hJlxLR4Pk7qwuZuwPDz+mOtFNCpnMhFwLheLDdM0Ok9Wyv
X-Gm-Gg: AY/fxX4J8AgF5+EEiRBMO4Ix7Hj4kpgAAnp9fWD7o0RVLXVOrI62X+j0zO66GQpPlSM
	TaF7PJrYaKDJJVXcYB/+TScLodBmWImQ+mr7giiKMGq8BfWcRqRBiKXodmbBsSsIANDxvBCD3tG
	ho3a53Hja/JyLCVIsgfrveMRGm91rhKnZrpPP90Cd0h9Q3wNL+elJh6U68MApUrp+RnasolzmfS
	uEP0sfpONb7Ci/qR2GbAIkDHSb8kN78yFJP7avn3H0BiFcwdc2YfYPko1fT5Tiz0rCjUFfsJYGK
	ANrLUCvIa702szX+MqdMbwWXeuLaaxx+osxZeZG357hXSBh3XwvkWm+ABv9mLcngq7VEIP+9+kj
	93IEGfKCVUJ7l70PWr31AGVe2qqTMTFNcW5edoM4LPKa8mDa7kKybxqWqMKn2m2SHvpfHLlxJPW
	vCfPfj+/rj
X-Received: by 2002:a05:6a20:12c6:b0:38d:e6f8:fd8c with SMTP id adf61e73a8af0-38e00d7a500mr10849339637.67.1768894275097;
        Mon, 19 Jan 2026 23:31:15 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf2363e5sm10822395a12.4.2026.01.19.23.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:31:14 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
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
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: test bpf_get_func_arg() for tp_btf
Date: Tue, 20 Jan 2026 15:30:46 +0800
Message-ID: <20260120073046.324342-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120073046.324342-1-dongml2@chinatelecom.cn>
References: <20260120073046.324342-1-dongml2@chinatelecom.cn>
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
 .../selftests/bpf/progs/get_func_args_test.c  | 44 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 4 files changed, 61 insertions(+)

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
index e0f34a55e697..5b7233afef05 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -121,3 +121,47 @@ int BPF_PROG(fexit_test, int _a, int *_b, int _ret)
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


