Return-Path: <bpf+bounces-36817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BCA94DA2B
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 04:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8C1B21EDC
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 02:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBD113211F;
	Sat, 10 Aug 2024 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKch54/E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE25E45979
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723257348; cv=none; b=SDMJp8qnVeO4AIKninhBaGXB7XLbvtmIaVz7PUplo//JLovLf08ikoPDwxNfKuW6I8DG7yTgRP4eR/J5erWM9IfsXK2wtOAdwmkqgFVII/t1TI4N1We2TAHbYzbCM9PQnTFSBLp56CWcO7bktJzL91pYOdv2DTCa6GBKj79exbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723257348; c=relaxed/simple;
	bh=UDOJiRTvMpuD7RD6NM/euJKuUKttLepxfa4C+u3utcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tSIUdX3smDncqhnwq7Htm73uqmFe1Y3+yAvLWvW9PPfvK//y54m98riogEuiae0wiTv1SmVT+PMYZm1jG/ieBHLcGII+5GoXHSYUSyFGm8tzS7JaL16l9npF5KoBly19CLNENnCszH8hTbTULPFT8il877qQdhdjMsYdH/Apwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKch54/E; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-65f7bd30546so19995627b3.1
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 19:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723257345; x=1723862145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhVlXzW9eweS2OHYJCvRKUDeLzK39AGvAsyg3ZtVVXo=;
        b=FKch54/EOggdYdKzR2w4SrmWq+2VuyOLbdpIvrYbmNjXtljWwuyBxnDV2/eDqsWU0e
         jXKPCjc0mbnlmahD0X6MUZsrTSJEtP267HMz91F4KFt+0NTG33TyMg2wu3KgQ57bQJdt
         5sB+pCj/NH0Y3Zp/RXEoqzsV/eiF/OSJUGERHHnvKMW5RNDvGIMnNGc/8A2I1SoEyuCj
         9YVmlfpfzDsGq1Bl32L4fe3gJTW7IdZldBnDvQk+8Z26wUtcmZmoUsJR3Lk6P54U0RmN
         oWIh+O49wvTvGhXqNCjGjhdUWVAJ78n8ta4Zg3cN/ctQxVZElGhGfU3mbCPHa4HzXOUo
         /pHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723257345; x=1723862145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhVlXzW9eweS2OHYJCvRKUDeLzK39AGvAsyg3ZtVVXo=;
        b=eXaLkxhUzlloW5MUxJuJgTtFVvEnTFPxzAifLIXDQM6KYaV4/IS7HiB8nzoeIlx079
         mo7lnrG3f9xsLv8+q6jWM2R4tVRFGjTj8ptxxKXktHO5EUTTunnB1X7sbVHFe8TYbC6o
         hZ4EbYTgK+zojMm32xKAvzSzbH4qVAFdiVwUUyQ2OqcaY1E9F2gSwY6PaDxxZr7w4Yn4
         0Zkp2ESQKxhQxBi7ZD2kO5kaCeoW/gUvc69ZcOnIA64YouxPYDILI+t/cV8rvsGkzX5W
         tYCebDFPnAQa9C6gDt6bC57UF2OjWA/NTRiUjnanAWvYB5N50NC2uvYwRs0Yz3FAAlTD
         qWXw==
X-Gm-Message-State: AOJu0YxQjdH3DRGDBqO0t14m4RZ5Q3V7EXWM8k0tTWut08rCkuEeRp/u
	exXiyVjJq2p+tf7RhUiS/9WcFenV5YP650HB36PtUOUORaOdVFsA9/iqbUzZ
X-Google-Smtp-Source: AGHT+IGphur85Rn0gdTTPJGc2b7Qo5GQm8b6caN8PotGLowY6bcJwUtA7B3getycuFmWBmYzeyY/rg==
X-Received: by 2002:a05:690c:660a:b0:640:aec2:101c with SMTP id 00721157ae682-69edbd6cce3mr30547997b3.2.1723257345399;
        Fri, 09 Aug 2024 19:35:45 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:e383:f1a1:d5c5:1cf2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a451b371sm1280147b3.114.2024.08.09.19.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 19:35:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 6/6] selftests/bpf: Monitor traffic for select_reuseport.
Date: Fri,  9 Aug 2024 19:35:34 -0700
Message-Id: <20240810023534.2458227-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810023534.2458227-1-thinker.li@gmail.com>
References: <20240810023534.2458227-1-thinker.li@gmail.com>
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


