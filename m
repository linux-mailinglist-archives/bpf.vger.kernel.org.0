Return-Path: <bpf+bounces-77416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EF6CDC560
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 14:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF18C3014D69
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 13:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16C9347BCC;
	Wed, 24 Dec 2025 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e54ujjhf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC81346FB9
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581796; cv=none; b=uT9KBm5if5OZpotL6mIm7LTVlXhbLBVbfXvxa8JKxkxQUF4yrc3blgEiNrMGHLnV0kBfvoUum8oBZt13RJbKJPf2z4s+zdZlU63UPL54KOG6sNtjyccoDedbBzo0kzmHxDinl2fcHx1yNxTkGV/M1JlCwwnm0vkFYGa7L6e9Uyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581796; c=relaxed/simple;
	bh=7SDJuFphpW3+olwFXj0xPVEig/npNUEHxEDid1Ga1WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtiyQQoPlciwNp0dNwvkPO8x1PF0fONftiU/lyPP6joXq+1uNdhfqyZkJtQQ+MDr/r+ZyEXlOAqnRjIIKiaVUVzyoeLsj5VKAJlUGSfJ3elx+9GZG/yLxlTt8buOvwQ+fg8Cq5cDOCZKTI9b8sUuRQ53nWJAARKwH+q/vkyyfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e54ujjhf; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7ba55660769so4763659b3a.1
        for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 05:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766581794; x=1767186594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h66nM9SmW+4KvKNcMfrx/eUWGHnc/5Crgy2rlwqjCZQ=;
        b=e54ujjhfhAfZrgyRuUUB/fnLE+/329MHOKPZK86MWG16vin7+5wg9p1MIkUQblZtxe
         iC1avUf8lM8HmWD12FBShl07YQm7NJypN/eDozi6B7OtfzPfe5SSEkFW1XSm5zf7n3lW
         bFNZjTEVWxhWHCwn/NzlTKCNySAyF/V3sF9XiFDAtYjAO+u2cIxrSSmFBqDlxD35J4Ej
         4RuCynPLKI6cZpM6JFBnf9P71wuqmcNrc5oJofCB3HJrSEOgCGUvm7ZCvtuKrVRo66nI
         5E6gG3TY36wKHDnJztsA6tu6D8M53gkvlAtPSyAjqXgBYWjJu4Sj2TVbwZnHTfRxHvIq
         eOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581794; x=1767186594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h66nM9SmW+4KvKNcMfrx/eUWGHnc/5Crgy2rlwqjCZQ=;
        b=BqchEJod2ASRm6v8Mu9+eyCI8S4DTDoYXSP2dhZRCOy3KkJEzdR9EkxumWNLfdIUNo
         N/PofrRTB8gBQrmrMwt/izqj+Iex2HkDlu4dCp0KRqZP3Znq0HVtzIu84BeC0CD5rp29
         By0s9Cz7HFW63FC19Nsqm0ld8agVOXREqJ64Nab28SPK/nWk3pKwkOtnX9Zb+/8rsAlt
         pgZ0ryzbnypL1UkcNBgQXT4lLkwo7Sf/Bge1COnbFV7/TP4j3CCvzAuGYPHt2Tq+K2mf
         zHaLm85M1afDWhLkQEnQEma97CMeLD3NVYKzq1+x7x2eaEEz7qCVaDmKJP24B0KG7Lpg
         olKw==
X-Forwarded-Encrypted: i=1; AJvYcCX2finB9zSTn2x0pxbV7E19llBqvE5KGBs86+8ZGhfGCl/u93sAm7Z1Qyf/10Et5suaV1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC7ltPdJvTx+EeypZsLUk+4NpzGdoWcMz1Pgr2/hBeSyb6P/4k
	VWsarAqg5fmKAnKn8Ajz167nF7EQH+/b5pranL1t6nAeUFvbG6LerZ9E
X-Gm-Gg: AY/fxX6tzIA4onAAnmG5v9A6QHqcVo5ym1j+MwwgJrXTqOYXiN/BR+B/HJHTegBiQkA
	R9/XhZ9I40FBSslfoj/r4oz9lWeGnh8omdqwCt9584OfVGyzPl3n1DVufhQxC1lhOuEiOSHY9hj
	nWi3EugFNNqR0Y3VAISGxMA/TQA45V063Wx5SpQzExqqUqJaE6a3KmaMdFn8fXJqvZ+JTriGcgq
	Z3kVAXbLQ/UtLxhUaPmtuQtX73TY/7rBQtdbLTQXuwMFj/bGhbCrNTYP4EWU17FYSUK3+wmyYvQ
	bKRyPn5myW9Y+he8TnXifMQk/VB7++LtDJp5tlX6UROIJ85OPK0d1Fs4Q1+KApXW9D/V8tVmRIO
	Z/j60hwcjuJaie4J50s1FzHMH3frO0KlSvHVzhi0HlJ9BJQI7GXSbOh23Inr0zZ0zJU7nWgJRmj
	5m73LRQlA=
X-Google-Smtp-Source: AGHT+IFg2dw1lbCQhvhHSUK/xEBgEMEUo3jTVgV+JCGMWjyZREF95HQ3ZyvRsYpfI/0QHSvjsunkAA==
X-Received: by 2002:a05:6a00:1ca7:b0:7e8:4471:8dc with SMTP id d2e1a72fcca58-7ff66e5d527mr14511852b3a.61.1766581794132;
        Wed, 24 Dec 2025 05:09:54 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm16841173b3a.32.2025.12.24.05.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:09:53 -0800 (PST)
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
Subject: [PATCH bpf-next v5 09/10] selftests/bpf: add testcases for fsession cookie
Date: Wed, 24 Dec 2025 21:07:34 +0800
Message-ID: <20251224130735.201422-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224130735.201422-1-dongml2@chinatelecom.cn>
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
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


