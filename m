Return-Path: <bpf+bounces-78058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6936CFC405
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 07:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71F163019197
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 06:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CF42C3242;
	Wed,  7 Jan 2026 06:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLk4fZ3G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9A2BE7BA
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768354; cv=none; b=kTmQDmYubYnUqWhdFrRIGOhz9Q2io15J/4vHwq5g7fFgZAA6BRU+f9c3WU+fBEkJT1J4KwEWjOw9ZvTFWnhLEO0sKCE60JIeUZp3CdIPxrRMePqCr9k5WLWD9Xu2BcnLCQbtWDCLCxpWjEO7TcMvqp6Tnyt6qQHggOGENQTem1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768354; c=relaxed/simple;
	bh=gXCuEnHLqfXsAH6FAwsjxm9SB5MyEaZI5cp68UEcCxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=le2C4tlfCvBElHRipUSKSdbLL2h87k17x5BA/g7nmGp7vYFqugR22rSeyrIIfHiesFV4YBJYStp+cXOs2qbAbp7ZWh2dT6INUfM6dMawSLfSoEf45/q1G5+jBUsivYcrLjhV6YEAga58bSPvH5nxTLcRWH5w5EeEuzoNzSd/Ugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLk4fZ3G; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78fcb465733so19897717b3.3
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 22:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768351; x=1768373151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0oqk3QUBfKZsQ1aXSAR/rKLECXiTolyzvGw8W9Eifk=;
        b=OLk4fZ3GjbQr2LNTSf/r+QXaDUr5FWJ5THsDhrzOybt6jDt7jiIouDfS7Tpbo8/HMo
         WTzj6NQDmbdLxQTI5Vre77hz1BdhvslwVYAECyrneGFQqMBDeJVp1OX2Tg5kDtvsO9rV
         qb4NeaxZL8RU76nDF0kkX9y1JJqpGRcKPZw/57WAUSKDpiJrmAZpWMpIb46jtxjcVo/m
         uJGSmrwKEVlk83PAiJWSeqzQRBjiq19L+EfRo37QwxkOHX1vuDAZJ4e2ki/oUEn/BGJw
         2BXYK16d5SYvVjvFPbuWddfHfkMREVk1v/Ljrah0hO00t/Tfjk5JGYwFS6x9jHbXgwa4
         DS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768351; x=1768373151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0oqk3QUBfKZsQ1aXSAR/rKLECXiTolyzvGw8W9Eifk=;
        b=wCAUywy6K2zxI8E1+LtTUMPgb3HRY0/b6ncx1VoGhIzjMomoJ3iS2pBhdcLpybUl47
         V+PAenL/8mAFhFVzPaGT6YO5pfIz5Ne/O240tSz1PaTX/b5pGLLyNaF3wK3q6nps9GTw
         DEPLGDDYqCavpe+ClECOgf2NRnUk3JLzp0qFmPWkDBTtmvs6dku3ebuv8cfaFoK/kJ75
         odv0GJ2HtB34Y01fOpxvs8BTOjV40QvJWOSnEiPBtRT9I0p3UsFMSSE6hiZF6MmxagM2
         CfYcLxsMRXDWzvON4DVbh7EY98MYwwf5wCS1Jh7K/Q6CY8HyqxlQtDnOCbEw8Ka3dYs5
         qMIw==
X-Forwarded-Encrypted: i=1; AJvYcCURXCDSXvMhTZOXM6Q4+HWj9Vw4kzEO4oQ/qRY0L3jpagM8pdfePQZ14ze0NBE7LIWWCKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ycAnSDFHa1AjtFGVw86hFx9yIMKSh41DN4sMUTMxPz1C/d6p
	AcZgRp23oYxOeLFva4BYMF1OcDwhj5bR+mRSBdp8YmsS5l1+w7c7gSKi
X-Gm-Gg: AY/fxX5NYT63M3gYnujDXn/gie3wENitiBLzf4BsZ3wQSLCx4PZVc2PIP8zuoA1nY8x
	qP3epkGyoMxLckhA8DdEuMKzLCE2HArJ+Y67jeHPtm0XzNte1cnwbg8cHks1YVcZCDLofrm0sfu
	s2ySnEi/3lcBUebW072qkYle2oi+3st34qf0e2FU6yfYKHJesHApjTJ0x6IOApNnu+pRYxiQ30N
	XA/cVm3Kx1TNyIyNXBRUxUZ5J6ZoEsoCzvkQtX+61/7WVrK8ge/NUR8erwv1yRvLo/bJcelqkLX
	m5pHflr23g3LXGDSQeu12XQJoAZUXp9yJXdTDRA7xDkjBtw/h+/9qhHVHvqSLdgV5KFO6wLDO3s
	eajoHNFOvnUhNBx3fe7d5IZitVgu6AqdNWyY+l14BoJ5uWupycZEpIl617kuyVQZGYImDxss3pL
	1+J+s+9Cw=
X-Google-Smtp-Source: AGHT+IHMifI7034zc2YBt79WxlXBE/YcCt485G3onMhXwhhsMw8KLx2Ddjp8zBhrqNHrFRl6QB+UyA==
X-Received: by 2002:a05:690e:1248:b0:646:7c7a:c5d8 with SMTP id 956f58d0204a3-64716c67bd6mr1480927d50.61.1767768350995;
        Tue, 06 Jan 2026 22:45:50 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm9635047b3.47.2026.01.06.22.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:45:50 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v7 10/11] selftests/bpf: add testcases for fsession cookie
Date: Wed,  7 Jan 2026 14:43:51 +0800
Message-ID: <20260107064352.291069-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107064352.291069-1-dongml2@chinatelecom.cn>
References: <20260107064352.291069-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test session cookie for fsession. Multiple fsession BPF progs is attached
to bpf_fentry_test1() and session cookie is read and write in the
testcase.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- restructure the testcase by combine the testcases for session cookie and
  get_func_ip into one patch
---
 .../selftests/bpf/prog_tests/fsession_test.c  | 25 +++++++
 .../selftests/bpf/progs/fsession_test.c       | 72 +++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
index 83f3953a1ff6..2459f9db1c92 100644
--- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -77,6 +77,29 @@ static void test_fsession_reattach(void)
 	fsession_test__destroy(skel);
 }
 
+static void test_fsession_cookie(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open"))
+		goto cleanup;
+
+	err = bpf_program__set_autoload(skel->progs.test11, true);
+	if (!ASSERT_OK(err, "bpf_program__set_autoload"))
+		goto cleanup;
+
+	err = fsession_test__load(skel);
+	if (!ASSERT_OK(err, "fsession_test__load"))
+		goto cleanup;
+
+	err = fsession_test__attach(skel);
+	ASSERT_EQ(err, -E2BIG, "fsession_cookie");
+cleanup:
+	fsession_test__destroy(skel);
+}
+
 void test_fsession_test(void)
 {
 #if !defined(__x86_64__)
@@ -87,4 +110,6 @@ void test_fsession_test(void)
 		test_fsession_basic();
 	if (test__start_subtest("fsession_reattach"))
 		test_fsession_reattach();
+	if (test__start_subtest("fsession_cookie"))
+		test_fsession_cookie();
 }
diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index f504984d42f2..85e89f7219a7 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -108,3 +108,75 @@ int BPF_PROG(test6, int a)
 		test6_entry_result = (const void *) addr == &bpf_fentry_test1;
 	return 0;
 }
+
+__u64 test7_entry_ok = 0;
+__u64 test7_exit_ok = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test7, int a)
+{
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
+		*cookie = 0xAAAABBBBCCCCDDDDull;
+		test7_entry_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+		return 0;
+	}
+
+	test7_exit_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+	return 0;
+}
+
+__u64 test8_entry_ok = 0;
+__u64 test8_exit_ok = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test8, int a)
+{
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
+		*cookie = 0x1111222233334444ull;
+		test8_entry_ok = *cookie == 0x1111222233334444ull;
+		return 0;
+	}
+
+	test8_exit_ok = *cookie == 0x1111222233334444ull;
+	return 0;
+}
+
+__u64 test9_entry_result = 0;
+__u64 test9_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a, int ret)
+{
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
+		test9_entry_result = a == 1 && ret == 0;
+		*cookie = 0x123456ULL;
+		return 0;
+	}
+
+	test9_exit_result = a == 1 && ret == 2 && *cookie == 0x123456ULL;
+	return 0;
+}
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test10, int a, int ret)
+{
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	*cookie = 0;
+	return 0;
+}
+
+/* This is the 5th cookie, so it should fail */
+SEC("?fsession/bpf_fentry_test1")
+int BPF_PROG(test11, int a, int ret)
+{
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	*cookie = 0;
+	return 0;
+}
-- 
2.52.0


