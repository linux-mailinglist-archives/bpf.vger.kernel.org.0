Return-Path: <bpf+bounces-79179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDD8D2AFF9
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 04:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C39F9308FE98
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 03:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342ED342CBA;
	Fri, 16 Jan 2026 03:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fynlNjnH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E826CE39
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 03:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535449; cv=none; b=TGlcZqUFBB2D3hzvCNtTNsBuwE/CMh2HoOxVvDi6J/B/KOyJHjWVzmzZMQKm381qy1Afzdq0mYnK05COgJRYu2R+XrnP0TbrmcEOIb4v5BqcUr+fkfV1UjYeFIwcWZgEytcXyrxqsCNhqp0tm6NqQu0M72RxrRUXSvwBdBkHFpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535449; c=relaxed/simple;
	bh=C8w12dJVUxW9Z8sKXrPFoxswnDG3WRw4VXyaktYwfTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxGUTtI0lcvptst9WlyRwGrKFIq62MbTYfnta/NO9Q3RNCCTJ102qDlPPqJLYkHR/vroO6S4/Ip0JJ4VcwNB+3c8OskL01yBNZKksllReiwO11jDQTfcxLo9QEga4qkLLBRlfgWmGL1HYRE19ILApvuXvsqpaRcLdfTaNRC+f0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fynlNjnH; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c03e8ac1da3so606891a12.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 19:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768535447; x=1769140247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmVc6d5RbXlucbiy6rXoophl60FqhGiD4vLZlhVfwjA=;
        b=fynlNjnHS+2xu3waUXG7hat7PW4BSDxWfdEyTznTSVQVEXFXFVixsQWrUf18N4wuTg
         Gdyup/M2TVFA9DN6Ww1W7MXL5uC+Z4Sf4HJDeApCfaoKdjtujbeLxjWDEvTsP7I1RJtR
         abDW5g2TiqtXxALazhHebrCZ1ps1a0IOmFp5CMpdUrIz72ZVtecmiofkbyDHfY2x8M0t
         bViyexOjQ0NMiG8RBUahY2iVGNbUtyX/3+L275cfrzqSEeETIwSaFr85X6XpMUZeUyCs
         2yFfXWXYKltfJxlfjRvmqmGQ8cxb8bAgEXv0GzmVfiYGf2o0TbdPb8SpNBJuekWgx7Ip
         UfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768535447; x=1769140247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WmVc6d5RbXlucbiy6rXoophl60FqhGiD4vLZlhVfwjA=;
        b=RNcQyLCk+w3VpjFUbOlpTe9e2tU17EWTnUWA+O391gbg0dhoZRbGh78E6x0PUUE9vW
         snX2VbgDpuj70ksyaxI2TU9Zf5QiZj6/PjjIMu83yCO+/siPv4rU0jYv/aHAz7hcebG9
         gpGw5aG3k1J3alwVoTSNUVOunhCWq44yiRfwjCsWkgefo4UCMwojbhlN24tKwluvq+Wx
         w6wOB78yUJDNKwek7sg8cMMDIfZcLviPj9ufwpZL6myEZ6sm6RiUxahWGRoKISTCQkM2
         pmoTDfhJL4qKBcwOOLCE6aWoB1xAUh0YT8Uyxw/u4zk6cGO72CicgS/ws/vlwyb1ygra
         55hw==
X-Forwarded-Encrypted: i=1; AJvYcCXwFBaPzVoAFQHkdsuAXaZ2eWCOQFvqocNDtVgrbX4ZREYZpyrmxa1Eh+Pr3UftyERrO+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2va9lY31XfPLIiWUBygR+DJSGJojWgkuaaEol6411yV+peywx
	Ipgrc9r/bZFfejbNxbSsV8BuSBtM2Tbsx72WCzRPrHeg/zsAXiJOKQnm
X-Gm-Gg: AY/fxX7pTRm+xCb+d4LOIBR66ZgYKrFnSWjok4wTowWjf75nQHtp/vMb5KyRQbvmd9O
	enlbZSBi2KthrVUyBzgOn74yT4aFi7i1tCm0LIl42DoJUAQwR5GMQpQWOnFp0WRj9VChmQtCiv1
	ZULlF2Ks6290ZVSvgJcmBxvMBUFVd2K/RH5oc1eHgyHN4eGvKno+PlyM1R8DqFew9lNLvtOP+rR
	bdlcFQNlxcQb0cVN2xSyyH9rWZ7mEqM8oRmQxyc+YSAGTPnRAbSJIWr2Vfqvrj8KoXRemveRWeL
	3nOvPdJeq6UdlD1Oy4F+ZbnHkg71waNV1ADzJhjtAIGh6G18MhRzT7yZQu+OnT2AKrD7A469Of6
	IIPBEDjUvd1TiKtIfoGjHdm5o9m/l9lb8jR9Ix1vBPZsp/Mkr0E6FqEbB0RRZYQiaTuTvRUPbZU
	2T9+KDuEA=
X-Received: by 2002:a05:6a20:939b:b0:38d:eeb9:8f4c with SMTP id adf61e73a8af0-38dfe7feef2mr1768372637.71.1768535447549;
        Thu, 15 Jan 2026 19:50:47 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf37c9d7sm684504a12.35.2026.01.15.19.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 19:50:47 -0800 (PST)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: test bpf_get_func_arg() for tp_btf
Date: Fri, 16 Jan 2026 11:50:24 +0800
Message-ID: <20260116035024.98214-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116035024.98214-1-dongml2@chinatelecom.cn>
References: <20260116035024.98214-1-dongml2@chinatelecom.cn>
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
 .../bpf/prog_tests/get_func_args_test.c       |  1 +
 .../selftests/bpf/progs/get_func_args_test.c  | 44 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 4 files changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
index 64a9c95d4acf..848fab952719 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
@@ -33,6 +33,7 @@ void test_get_func_args_test(void)
 
 	ASSERT_EQ(topts.retval >> 16, 1, "test_run");
 	ASSERT_EQ(topts.retval & 0xffff, 1234 + 29, "test_run");
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
 
 	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
 	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
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


