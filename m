Return-Path: <bpf+bounces-77777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9F2CF0F1D
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 13:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E9B5305965E
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A762D8DA8;
	Sun,  4 Jan 2026 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4XuCL38"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6F4222575
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529833; cv=none; b=dEd/naxyNkIXAU2SqZz6dH+EhWY9oI2xlfZqLjNmB6b8gsXI1PyMQ9ZK5qYlNiRgRGJJ9h14nhV3ZCSnjZHRKCfi1L+dxIlwl0PCtxVCykOEhOMsB8D9D1Zd62xv2i4t8fHLSM5QBjbJjBsCt7yozXqY8aWckZsWGOzw93OpWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529833; c=relaxed/simple;
	bh=UJTrEvbHHc/LCR7ssI7rQ2WfdPkmcvBgvYjr55P9c74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogr3/mu1YMk2VmOIgkq8tjfI7izexQp4dHjuqMe6S9Etdj7wVSx1uVmP9Gfs/htPl3OCtsiVaIEaZfLmCcRHgGjapyFHwaaYk98zAlwc3ZiHzzOYb+x2cswD8ZrvFTjfcve1eKxR41oz0/fWjqKOypbDsjsWcCFHJ8YjhNVOleE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4XuCL38; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-787d5555274so120802117b3.1
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 04:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529830; x=1768134630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as3rErWMsms+S9eR1OsrQ4sWO/jfg5iKakL+peUOPUQ=;
        b=Y4XuCL38pAHICMYZv49URD20XeaQJdqZ8nG7lK1FANUqBA3xCYq2XtNHbIy/X8qdvq
         WihzWVvp06w18ZRixChG6v6S2zPz9rssXRl/39ZYdt0Hq7eIm/u8zFdsGG1hvzZ3gIL8
         NCeubrcleZmmoWZnhkz8AZ0PhYNRHj9ug3F3UDewcTmOiVI4GAQtJGFD2b89A/3X0ZO5
         EMBaw81CTPdP0mg+X0bdbZOFGLtE0CiUckRXgs39itl1/bgcSmu3fzwiXIvVjIJVgJOY
         bLg/5QnkVR9+lClbqkSPY902kio16s3tQTcYxvF897P1Fyj8zBy+eunP6MlgwX+zqeWh
         49dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529830; x=1768134630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=as3rErWMsms+S9eR1OsrQ4sWO/jfg5iKakL+peUOPUQ=;
        b=JwHynqUxhlj3YK3WY5m3yrsNFi3mS60UnHvBOeoNcY5QcBSbRjK/dMDr0GmPStoiHV
         m7rEP/I2KKYfUJ6OdtGnEytwdc8vdqePNyAbFgsyh2BshmJLBzb6p3bJHPDcuI6SnmSs
         eePn/+Jxo9crxKtVzR5frUNCmakM/3dYzAS/sL/Ru+0mTe8xhZngvDqWyx6ERjJgwlnq
         FvuC4QIWdIpAT0DwJ0q34Q2BGebSfyT7p5I/EEv0tXKvFfmxuGQiUgWwgb908arJN42u
         GXOwC1OjBADVx9UzprLTZ6M6SvVOWdxUxsMC0oYPRTzUTvH819KYgYjnjDzKyxY0be+e
         Z/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfHo0WjS2wIMC9VaTGI2tc30rY0QM+/VFJIDPc/mSa0xihC7ejliiX+tMKYI85MZlt71U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv8huCwhouuDr/jSgoS5lU9tocnnzijqaJmyJl7xQ6OMziqcGW
	kecozvGjGvRBbva4zhYcE/R2nsN+ci5JPGmn1e/dW2dpWZ1yuOBmw8kC
X-Gm-Gg: AY/fxX7o+NOnx2ARsO9Q1SzfZUkf+PYJvHTOECoy5T6q3etDVbIc6SYZ0HdBTUinlWV
	0BhPR+90BSefBMbtSloHbMgu1t6hZnw3vYbUTBEk7bPZyHMpvRdbHLcFA8MEneFs2eEk3AFZJaQ
	LOnaspkZLwp33YqjKUgNhCFTPrhtQsOG6lwXGOrgJpm1dSAzULvknkPbUFPcw+lOhNyHWApG9FY
	zDwmqmdOfwYgcoHEOhGHY7R7ym2J3dm8us/s3mdKZwtMcsF1c3vs/hOXOpjeWRJfIn2X6rBQg9B
	zErAApLPzeHJlBtjNLEmoNDv0mSfp/q6rQuJ55G8u8NG1zl6xX09e4aAQ/GSkDO0cN8U0oX6xFu
	ogXVkmt6GCUVVSeV4SWTDX6lJgOvKncwMrvHoGAce+J4LoiFpDYCGS+vLhsQqKkzwTfwpKHb3bI
	f9lL4RyfY=
X-Google-Smtp-Source: AGHT+IEJ9FbG+KJUSmyqe4GlcGQqpBKjEIjKXafZDNIvaw0YBShwM0FwK00UNy6MiyBtchGBy4NDkA==
X-Received: by 2002:a05:690c:23ca:b0:78f:bcc1:88e0 with SMTP id 00721157ae682-78fbcc18f16mr386621047b3.1.1767529830518;
        Sun, 04 Jan 2026 04:30:30 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:30:30 -0800 (PST)
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
Subject: [PATCH bpf-next v6 09/10] selftests/bpf: add testcases for fsession cookie
Date: Sun,  4 Jan 2026 20:28:13 +0800
Message-ID: <20260104122814.183732-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
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
index b180e339c17f..5630cf3bbd8b 100644
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
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_fsession_is_return(ctx)) {
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
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_fsession_is_return(ctx)) {
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
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_fsession_is_return(ctx)) {
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
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	*cookie = 0;
+	return 0;
+}
+
+/* This is the 5th cookie, so it should fail */
+SEC("?fsession/bpf_fentry_test1")
+int BPF_PROG(test11, int a, int ret)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	*cookie = 0;
+	return 0;
+}
-- 
2.52.0


