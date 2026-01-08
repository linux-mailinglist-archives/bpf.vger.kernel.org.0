Return-Path: <bpf+bounces-78186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E60D00B1E
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 03:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5DA3303210F
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 02:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71192BDC29;
	Thu,  8 Jan 2026 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cf2iwqxe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E30C270ED7
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 02:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839207; cv=none; b=cECX7N+WD+Wsmso/CRb+ZyWlXhwuTmeuFtdnzFc5jgQFXSFLQnVvA+64rFPgldfU5xNboQgy0XzTpwnhSgU7jJ+5LSG8ejKQtVQSJ9HBFGWT5gsVsNHXDhiYabDTFXZC2OywxuKTPDV1QrkaYKKkRDKq7UYjngEAZEr+SE65lxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839207; c=relaxed/simple;
	bh=gXCuEnHLqfXsAH6FAwsjxm9SB5MyEaZI5cp68UEcCxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0MEkNAT+nnbzer8/tjE8lG/sm9ZBfcUjlSQJJ+ybFuX/NuEb7RZ6S5djhLAf8RWZ4Cy9I4GltcqPXriSEaHApT5SZBDnN5boSLgwLE8xvaCjNbo2XJ7Ty8iNKfY84HekhdBGWhmDo77USuB/iGo8DXzurTLhnksVJFcjVwHdT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cf2iwqxe; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-640c9c85255so2996464d50.3
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 18:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839203; x=1768444003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0oqk3QUBfKZsQ1aXSAR/rKLECXiTolyzvGw8W9Eifk=;
        b=cf2iwqxeYKYjx47dY1Zt7XddmmI3qpSC3bp3ImKMUpNZnPWKvWJH1ukadANMeS+mas
         bNqJLyDxYN/knQQbQS1XkfWcgLiXpK2NTId3O+OND8lseu4DilEKjD13bCewUXIdtKLH
         bE7Eb6piRQ7Ci1YPQVJ659gWVjeGl/3mEEnTCBeQdMzMyOyzH49S2kBcgT4OXToeiV9Q
         yo+tWUadODL54ZaasrwqbRXEKIfU2CoVL/LNGl164GRbe49lKpv7MxxkYceic59e2pCh
         wJsHZEEv+/VUzSReCAB/FKeqLnSXUK8zx/wmebZAf6upogN9X7e4qqvTyzSZ2q8pOsK4
         rH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839203; x=1768444003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0oqk3QUBfKZsQ1aXSAR/rKLECXiTolyzvGw8W9Eifk=;
        b=XdxlRBL8B1bF0Sh9xIxCEvPHKOqsmXEEPjfvs/teJiDm/2KAdb/pKdZlVDUBex+FIQ
         XWWZbmnx2u4Xm1fser0qOubW0Tlg8Mr2daLoOEk1iPz+giFP2dguymdMWGljIOEUYunK
         QYYejG7QxlvyuK85Q/t/9MWUj2v78Q3gMXqMAMp/ghoVi6lNSTVsM9wxB5r5e6ebTPAM
         9VB3I4qUA1NSqE9jOTmK/lqc8yohnMhmfYPjvE+FDZgfRVDC+yLy4AJ1c+Qycc0lT1Js
         IrtbMHDObpH5IOeaOW3EdcHUlMx3F3bm3/qte9jJOgRq5ltpQfKhB8ETOMqn3zHL/ktU
         J2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWtGdr6HNXf2vmlon17Qqdl1hdu4DaRUc37ly51jrC3z8jZauesbRg0D2lAL/IkvlRB0wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFY0PYLZJaf2XZ1nbEo7hs+hEqav4d6DGWDGtmtehGaYlssJ5V
	Hqk0zZs+7sJ7x3Bd0Hq+SQ7tOeRgwm7ZF2R34byVRoy6yRXIaAjJBDYd
X-Gm-Gg: AY/fxX7jQr9DapcZM4hDUf4uO0ue+4N2JeMMEFL/1CHHDEPk5/fVHskkOT6O77hnH4v
	GQCM3b7GdVm8toOj1u52rT9Z66Arv9kvDVA3potQDgxoDeTa732zYBNXL3YRDNMIAPfIn0m16M/
	yUyCgeE51RC8+RyuvRRk02C8UJ/8/WmWkvhGdOkxbw8pW9SPHmsGJAw4peW+pYHNado9UZS5iRx
	IZwSLhH7xynN5I+C1f+c83gRG688zUkIzP4nkZVymYNiSbyv3apSsmJaLl0mSyp6lLIvYf96b51
	MzO+wnnKVj9Za6Eut0PqUCteDNL3/Z3V+NpWGKW5zQM0MIlg+by2j5VbwG/eY9LK51Slt4n5kI2
	y6r7VRVdMplWnGhLgbnW6IVxd0ezpu2twlWP6PtURLjfERt4WwGQXvbpQB0TD9oDSQiVp5Rs9W1
	ntXpsPyv91p6S3baDCTA==
X-Google-Smtp-Source: AGHT+IFIq4+jbgNkL0gcs4PUxnAvdV4wibta+ry60tyzfR5mmVYRra4oL6AAc5EuAHO7q6A+XELDrg==
X-Received: by 2002:a05:690e:2515:b0:644:60d9:7514 with SMTP id 956f58d0204a3-64716ce7098mr3231908d50.88.1767839203439;
        Wed, 07 Jan 2026 18:26:43 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:26:43 -0800 (PST)
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
Subject: [PATCH bpf-next v8 10/11] selftests/bpf: add testcases for fsession cookie
Date: Thu,  8 Jan 2026 10:24:49 +0800
Message-ID: <20260108022450.88086-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108022450.88086-1-dongml2@chinatelecom.cn>
References: <20260108022450.88086-1-dongml2@chinatelecom.cn>
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


