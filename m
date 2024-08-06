Return-Path: <bpf+bounces-36515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F378949B06
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 00:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACABE1F210FA
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 22:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB4D17332C;
	Tue,  6 Aug 2024 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgpTDNsg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1B170A02
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982380; cv=none; b=AK518QepMEk1tJqLt0jyz0wQYp/HEzPdPYG7jy3WFvx6Nz1xW7CfSryrwtC50CwdjXAlWmWSffFzOeL63Iy7w2Nly/Lybq4AQ2syiYabaB2Vd50oLpO/FVL1GCUNSKd2edHHtLiRrxE0XJ6YtY2q7UtGgOPJTxf0MTdyrjYGKhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982380; c=relaxed/simple;
	bh=UDOJiRTvMpuD7RD6NM/euJKuUKttLepxfa4C+u3utcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TR6mknTWxyxIHhW/YBL+AasxToWigimDEXCpeMTpoTH+BoRwGM4PJnWJ3+arChs4hzlWmO8raa7uEsF0ZOxdun3tJiP92KZ8kU96tSi85v7wkoHGLY+oPfcAqGV94aZEm/RcL3V7tYrttE+pW7YbjhBgzMeHLGcMRunoLmGECPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgpTDNsg; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-691c85525ebso10331467b3.0
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 15:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722982378; x=1723587178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhVlXzW9eweS2OHYJCvRKUDeLzK39AGvAsyg3ZtVVXo=;
        b=HgpTDNsgsNRnkCEr7NpuCBWDum7w3F0vtxb6cqCO4gMp3dtCmrajJwyYDtqXgwsE0W
         ztdrzlib0KDIYQr5jkttDHiNVCCSlMqPsXiCCVsjrR2GyHDkbfZvYVNEWY/Nm1tk/lhW
         e4u2FhTSKwZ9rxoHV1XzbGf5Bimt7kvs4uGoEsspiIJa0CJaJ/i6ILFwwnZ2n2N640ss
         ELiaEmTsyqpTxDRluuYkQcHpr8dSgDkEbkqL/OnAJH2gL6WdeWdkONgeTGA6g0vtOntu
         a/rGsM8HSRiCLBQjUpBjJ/KLIIIf+WQ9hR54KRs3iY23HpFaU+B/tjI++CEJppreI9e4
         VlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982378; x=1723587178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhVlXzW9eweS2OHYJCvRKUDeLzK39AGvAsyg3ZtVVXo=;
        b=XztIO1NJr8tNnGUp1F/s+RIuw1FPXyotONiJ8W7YNuxLJuG0K/TlZeoGYMSV6YnpVy
         Gg80IBmrWlkf9TznLHRBWuHqN2briCbCyzZukOz0FFLHRSn1Ga1gmrluhUcS2W/b9Ikp
         az9gKQUW9bc8bDLhxmZIV021Li0IMc9f3Bgi7d02EN8vhXdFpgnuh8rWCCG+TT/bZPzm
         0vQ3qHJrQEHhX75HWG7TToKUbjTlRjKizpUZiNe+pByhTzQo/eHozzc+4oQN/HI12FEK
         HaFbv0jtUv1C51++GQ5op/oYexbQWzOOsNXaNhmFL3YRTRNczWrFJ3NK0s87pNjQS0W4
         mYIQ==
X-Gm-Message-State: AOJu0YzyKXCbpceiIkgor4KwMUg8sWyJ7h8lRiTttLFErhZEZy9hMZGU
	+ZMQD5w/mQcdpmAjjDCqAE4BnsJkULlggePu84+E/oJY90uNDdcXkxVjITEK
X-Google-Smtp-Source: AGHT+IE6EIi2TuE6CmvHeDTKl4wyR8Q4Yh6GWcOM0+A5uWmXUWVmofx7eMhBPgxWUBdoGGW2f3LQMA==
X-Received: by 2002:a81:8503:0:b0:646:25c7:178e with SMTP id 00721157ae682-6895f7faaacmr173361377b3.5.1722982377897;
        Tue, 06 Aug 2024 15:12:57 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:cfe6:adb2:c0bb:6a13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a12d138b6sm16990017b3.88.2024.08.06.15.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:12:57 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@fomichev.me,
	geliang@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v5 6/6] selftests/bpf: Monitor traffic for select_reuseport.
Date: Tue,  6 Aug 2024 15:12:43 -0700
Message-Id: <20240806221243.1806879-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806221243.1806879-1-thinker.li@gmail.com>
References: <20240806221243.1806879-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable traffic monitoring for the subtests of select_reuseport.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/prog_tests/select_reuseport.c         | 37 +++++++------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 64c5f5eb2994..5a8fa450eb9d 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -37,9 +37,7 @@ static int sk_fds[REUSEPORT_ARRAY_SIZE];
 static int reuseport_array = -1, outer_map = -1;
 static enum bpf_map_type inner_map_type;
 static int select_by_skb_data_prog;
-static int saved_tcp_syncookie = -1;
 static struct bpf_object *obj;
-static int saved_tcp_fo = -1;
 static __u32 index_zero;
 static int epfd;
 
@@ -193,14 +191,6 @@ static int write_int_sysctl(const char *sysctl, int v)
 	return 0;
 }
 
-static void restore_sysctls(void)
-{
-	if (saved_tcp_fo != -1)
-		write_int_sysctl(TCP_FO_SYSCTL, saved_tcp_fo);
-	if (saved_tcp_syncookie != -1)
-		write_int_sysctl(TCP_SYNCOOKIE_SYSCTL, saved_tcp_syncookie);
-}
-
 static int enable_fastopen(void)
 {
 	int fo;
@@ -793,6 +783,7 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 		TEST_INIT(test_pass_on_err),
 		TEST_INIT(test_detach_bpf),
 	};
+	struct netns_obj *netns;
 	char s[MAX_TEST_NAME];
 	const struct test *t;
 
@@ -808,9 +799,21 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 		if (!test__start_subtest(s))
 			continue;
 
+		netns = netns_new("test", true);
+		if (!ASSERT_OK_PTR(netns, "netns_new"))
+			continue;
+
+		if (CHECK_FAIL(enable_fastopen()))
+			goto out;
+		if (CHECK_FAIL(disable_syncookie()))
+			goto out;
+
 		setup_per_test(sotype, family, inany, t->no_inner_map);
 		t->fn(sotype, family);
 		cleanup_per_test(t->no_inner_map);
+
+out:
+		netns_free(netns);
 	}
 }
 
@@ -850,21 +853,7 @@ void test_map_type(enum bpf_map_type mt)
 
 void serial_test_select_reuseport(void)
 {
-	saved_tcp_fo = read_int_sysctl(TCP_FO_SYSCTL);
-	if (saved_tcp_fo < 0)
-		goto out;
-	saved_tcp_syncookie = read_int_sysctl(TCP_SYNCOOKIE_SYSCTL);
-	if (saved_tcp_syncookie < 0)
-		goto out;
-
-	if (enable_fastopen())
-		goto out;
-	if (disable_syncookie())
-		goto out;
-
 	test_map_type(BPF_MAP_TYPE_REUSEPORT_SOCKARRAY);
 	test_map_type(BPF_MAP_TYPE_SOCKMAP);
 	test_map_type(BPF_MAP_TYPE_SOCKHASH);
-out:
-	restore_sysctls();
 }
-- 
2.34.1


