Return-Path: <bpf+bounces-78472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A38D0D70E
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 15:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAB2F300DD94
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE35346AC5;
	Sat, 10 Jan 2026 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyQt6RlD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8E13469FC
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054398; cv=none; b=nX0U9BraV6U8sIcvs7uMmsNl6vs2ZPgbYnvdSiI+seTzWRIIfXZC17XVo7eCzh1IvxouexO5PhPuJ0rRcW1097KshD7GM/WgMpjiQ2xh97uOkLq45gFyYsPEPz7b/XdWG2isi3wS08BCelGOOiK0wT/+nleF4j9SuKA4c7Dp2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054398; c=relaxed/simple;
	bh=gXCuEnHLqfXsAH6FAwsjxm9SB5MyEaZI5cp68UEcCxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYgjeDHwg+fByWutEjB5FDcMR5zorYqxiVjAqsmYWgGl28XaYHoFxH9CAUAgfoFvgJgheIXPEh1D90cLfwv+FAoc1+uQzjmtWwCmT/irDCS9DMqg8gX+8z1Z508vBFDm9B8pRd102EIKm/8yaluy09gbcYnL3x0bzxDkWuJKhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyQt6RlD; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34ca40c1213so2681421a91.0
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 06:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054396; x=1768659196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0oqk3QUBfKZsQ1aXSAR/rKLECXiTolyzvGw8W9Eifk=;
        b=AyQt6RlDNs+uqwnxX/5qWaa96aotiR0MVIzcR6pJrglwwoPdJ53Wd2DU48qUBwOXOA
         EDsAGialjUClSuMU6DTdbioJpRLpXwNdUQyXnz6vNgq+hZcpXDqtjIdb6cBqCxyoEJrI
         AhVsMXQHJZ0786My6nm7p2n1YHIObRAY+ucfshyEyNegi+zDoqivm6cY4Z5xUxWNbJ7+
         dcYmnnvgZJSW3HWR3gSivLXFzL9OkIcs5tvxOuq5vSsOn4BuPbGjLAWIQBsMDX/vbNTW
         OkA/ft5D0xWn2IwLs+QuddxyZCNUwh/1jC32GiwMrqDl2dD9ugG1ag2lDAiiozzU/4dc
         dtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054396; x=1768659196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0oqk3QUBfKZsQ1aXSAR/rKLECXiTolyzvGw8W9Eifk=;
        b=HQMfwvpUhX47gtDDyPQHf/jHFL1EyYFMkW7MTiF3o+MYGt4sKHHJWQbOyXiwFFwR44
         gg7EvxwTVe82DA/cOccdtD+MomX3uZg52db4MhqpgLvEuqc7eQmPB9SzO+pBhkC4OBJy
         lV3ohptMVpR7qvRLYJW1LhYeIbVBQbBAl/QlrHR3mcLZsU+QzcStNWpBTDa+y+QPXOtO
         67VlMnDTO0IOsTKVNyKwgjNTLmCIvKOOmYBHjXPcMZkiujIVTIVV1gDjo6rr1oIG9DwJ
         pEGIzOJ0Rps0BIHaBLRa1Uk2PqGi87Rm5seYm5ct1GolTdrmte63rh+HEDVa0PYa+2os
         yZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYdaRhzoY3uQ0wjFJz3bvPKalyF51Pz69+79NZAA2tARqbCTMORd0zQ+jLVRTYk/gQerQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvkhRDl/AJhjb6UN2pAJRJFjml29bfZa0amMsI3qgUha6V2A7a
	Of5ih298jK+EseEUXoCxpfVyD7wGQwnsMZqSZXMKKSAosr/lbUVnSl09
X-Gm-Gg: AY/fxX4x2nq3xSX24Jo8wsL/aFl24OqrWJhzHtqxv7yIn4Fe4cZxTOmMvldyWNuE81D
	0xh/TxQLVjCxkCTy1OSQHIGcSe3HKZNlUdWdVAZHyuTquT/m4wtjWSYUI+Ctaz49whQmeTvVx7p
	6gZXkDXgQnW/NJhp5fHiFb3n7MSHRz7KWUpZDxulRy1gBUeVAMnlt5mLTnsWNzHdI8eMxRJ66By
	+311P0VQIJh0QZbaNNZpUoZdVg1hvCGgtB2GhSzJNQvpTzDcfSGJB1XjwA61sk10w+zPRvATSn3
	1xyjMOOlHum+uilzLby5FQav3tZ9K0K05XKtumY+FNxESib1JI4QFSTE/oeLcW5C7KYxgfNfDVG
	XHMY6maLKWwM/yY43sUdAWKqtpRPhqjMRCYnhkdh8uMuPX5JPV1HB0B/YpwaOQYvj42ybp/nhNK
	LNUgJL9/FvuvkQLjE4sQ==
X-Google-Smtp-Source: AGHT+IEm7VhbnMXmVox9xOg+CjqsU7K85YOVbAC/1coBNdKuVTJAf+ZFE4/LT/Ud++6Q8KkUOQoKvg==
X-Received: by 2002:a17:90b:57c4:b0:34c:a211:e52a with SMTP id 98e67ed59e1d1-34f68cae46emr11853633a91.27.1768054396410;
        Sat, 10 Jan 2026 06:13:16 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:13:16 -0800 (PST)
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
Subject: [PATCH bpf-next v9 10/11] selftests/bpf: add testcases for fsession cookie
Date: Sat, 10 Jan 2026 22:11:14 +0800
Message-ID: <20260110141115.537055-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110141115.537055-1-dongml2@chinatelecom.cn>
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
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


