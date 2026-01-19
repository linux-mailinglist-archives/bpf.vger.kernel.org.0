Return-Path: <bpf+bounces-79401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0E2D39C6A
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 03:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FEFD3009498
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 02:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BCE239E9A;
	Mon, 19 Jan 2026 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhIbTEk/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3644F2417C6
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790277; cv=none; b=YffaHB/RSMty+AjENK26yOyima7+BlN64fQJ3j6E4fAQBoFucMMF1/NBfMVVG10PsejUhjKA1o8sG40Iy3O5KXdhwnv21kHDrzmydrDKLaTTyYe88RQGHss2ijoelQ3tfx05OG5GCtw84VVtuSdCZHl1ByOvJrVvOkbqK11imRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790277; c=relaxed/simple;
	bh=kZiZh0VonzvzITLYzvii4c3vY29P/G7ZGQFYENdQFRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAVYLyN1upeEuYlp7aIkOrJ2FMGG49oZu1ChnomRxTvcB62GEm5boTzF5Oyw9GYIYAwfsMRsomxKLvpaS9vzscTjOjIZWEM1A5Bo6SlIKCnIcMnW7v32rwqR7jpUX6s2MdawvcQzQnszP2YAfXDFk4lmnzzoOxl5xyBT8eDb+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhIbTEk/; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0c09bb78cso28724105ad.0
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 18:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768790275; x=1769395075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxUe3zmQnPe+Di1h/wXJv+xTJZBq3RUkZe5dfyWfsD8=;
        b=PhIbTEk/ZFNkyY288W7whA2Og2xdC8yDLcHscFrVV1TAEYuYoCbzk4eX2K0Ud/iUUj
         A3MeBehh45bixl6ceJso8lIMBzxGUuHQdkJI6CUJMDhZK9hf5t8xF4DA4o9k6gKNjMNu
         oXmsu9v3zAobp6/+ppH9Gmty4SnCFNtuK/0sGbc4flXrspPGk2jYBOianXhyOMEw4mIH
         Ggk2H3ja3tml/EDO8WMKwNAeTkvyUajVs0i0kuATzKmwtFHB2Of4gwZy1UZtpy0Kr/mj
         Vw+uY7KW1m/+hO8EpvNzC+PzeTE3LU/gMCljKS+99f1ZQb+TY+Wlm5lu2pWrJ8warIeC
         0zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768790275; x=1769395075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxUe3zmQnPe+Di1h/wXJv+xTJZBq3RUkZe5dfyWfsD8=;
        b=f8cTuMNmjuIo47et+JVvEi7CgYEn0mmjNA2u9sz4GmyCCX3IyR/qkYJTpBxV+gkUDi
         9cbHRT51LMWZrIsFEFQjfJ9hsK4Cxcq0A1/YHbUi1vCHeyMMa/tkJkDxvKHuH3BhvB7Y
         PMv1kgpl+Z32g94dky0BNc5NM8BvI2ln+P3kJwd/ZvOCt/m3CSPfNZgi8adtN7uo66Vg
         SC7oMW1h8TPnQr0II9R0cuOyo8O2EFW7Xfi90db/3xPRij0lJMxJeb8b9++ElpnJuU0a
         dfKWQdHTBOS/AbxR1182o6Rt8nqz9FqP8G9q0bDPFhFDuEgCsZGeEccvavNbtdVU5whT
         ZJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0P4YCb1mdhcW++qHQvG0joZmMq1ib+ZMcm8M5veGMMYDG+tRI6J9f1Padzvpj0ihHc0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQ2PHTn3mcKTpQYAIV/GuRzypVH/uYyLMUl/eKkiGcWicK/79
	wUeZ9Z6oQGFM5/OQP1fNsMtuHBE14EBgzxXpYp7NRbrWLx3q1ETNoeQ/
X-Gm-Gg: AY/fxX7dcMa++9Qkr3uDSG2e4YmvmEhfFdcWkVFOq4XSKi1su11bUstTtRsebHDFCMG
	pty/NrY1EWKQSlEwIAfuUUqlAlIbRdoPdw1m17fV1mVUBJnK+EKWSCHkTOhlzxkkYFur2yAgoV7
	iI0O9Ogadl4HwjUvQ0SSoYj6VhmTqUTNw/NctAf5yOSF9BS+kB7uaoNkPEVTQLbUE7FJz9n1qjS
	bbeK2Y1CNXUXKrLSL9x6KrWkhfAXRHLzocaKzl0duuGOQxUftHUbMLO6PRj+dzfbnzMdMl26NjJ
	ulOiK16dtA+Xi8rM6fBBq1vJ8H2knTOZKxrhGHvmns5wyMPJPmlUI62U4Ok7LDTuP4sK4Sto7et
	xFNBU72ewPfBdKfRyv+80pemW1uCXwW+TdXb6j8BsPsZ4dBrAAAcWcUlbZql1qpg+koR6d7MZXP
	WdUhpJUk9z
X-Received: by 2002:a17:902:ec8b:b0:295:55fc:67a0 with SMTP id d9443c01a7336-2a700979c0emr139334475ad.2.1768790275428;
        Sun, 18 Jan 2026 18:37:55 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190c9ee9sm77154645ad.22.2026.01.18.18.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 18:37:55 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org,
	ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: test bpf_get_func_arg() for tp_btf
Date: Mon, 19 Jan 2026 10:37:32 +0800
Message-ID: <20260119023732.130642-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119023732.130642-1-dongml2@chinatelecom.cn>
References: <20260119023732.130642-1-dongml2@chinatelecom.cn>
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


