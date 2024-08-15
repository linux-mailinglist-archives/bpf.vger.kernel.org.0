Return-Path: <bpf+bounces-37249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE929528FC
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 07:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2523A2884C6
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 05:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7273815CD52;
	Thu, 15 Aug 2024 05:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/bhlIc9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9156D15E5D0
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699988; cv=none; b=p/l4t+d7s03+XNrc+rGwAFkjVMtFYHfQkQF71QV+KSe19BF7LH2XA/+2qyHkby/w5k+NYuxSG/uISyb5cJ8Ti225hAHo2o7GdCAZ1tOBuS+FNMw5Znu2yDeausVEboFhyhLDWmkLdI+Qwis3G3nhRXv1MVDwsuf9FkucwBYLRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699988; c=relaxed/simple;
	bh=rXUbJGIrxsadZzIjnlocaW9LQ0f44R0awVzeqtLkpA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SwcAF93Ua6fFjaaxWKv8gq8nw5rpaPWFHf5N8wlvybHgr1mV+z0RXDP7d31DTWIpfIQ1ON/CUi2g5WgT6WnDBFTlcJYccB5aLoNau1NkX9NGWEz4+nLat/qDp+Qd8ndnw38quxe59sCJkoM7IsfmugsQ+Vj5uQb/Iv3+J1LsTIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/bhlIc9; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-64b417e1511so6375707b3.3
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 22:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723699985; x=1724304785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6SYxu1ano9lEgDR5oK9KYJzr8DspgfQy+TYUI2HARk=;
        b=f/bhlIc927CR7d6OOdxKRM+KO5zX8lQE7j/EBdg3iVa491n+YNL+XchLnLy//DyHm4
         ZPNme4gU34v8SDAxVEOtK2+0vqEjmg3NZcEJXl51hiZqbVN+jxUFhsVcyCJLAcjR38/H
         RNP9IQmwMz9lNB2FC6ey331kt4hNpsWaPpiKkuO3wrMfnANewwnMbQ2NViE1fx1Dqb4V
         AZocep9Ec2Yt5NjMRlMHFspb3CX66AMs39IaNmehF9DNuWGfi/Pm8M3Qa2E87ocxadU3
         68RtW8+w8Nw8oyWjL4W6zFM3RoXSrOwVpHzRzdO4HhJEqlAoZyYP0SJDb/G+b+Wz6l+o
         K+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723699985; x=1724304785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6SYxu1ano9lEgDR5oK9KYJzr8DspgfQy+TYUI2HARk=;
        b=sk2uwrTxtzSf6X6AQHCAMTRs08o3NEF0bKPfSOJeVGD5LRuEgMDgJ7N3jK0jOmKB0n
         CS0wmnnWnXfveG8PUsWyM1wJ2Hf8bTLIPqF2qbhLdsanzJdbLKieolOYR5RZt2nLPs7s
         RBbT1cNeCL3JhITHvZrVqYVHjAMeYVjeXsRTIs4fYNQrLX92txtbsfHQOoIzHaRaoj+L
         Qb7BliLrM05zPerYQ8XDkAUSpk6MlEHdj/dLTeQqUUllrPUJX1gZPcb21ON1cGZTUSL7
         RQceVxV0GQB/yC2pNnASvpFRLQDM77Pw8PoOz2s9PYSkE3J/9jffAYyv/8UNioG7p/7z
         f6DQ==
X-Gm-Message-State: AOJu0YzVPiAFLe+F1TM8Kmh9Mhf7AKRDJk1ifYwSgHB0BGVUxOm0nwXC
	KsIVTrCn7l9owCa+GMOODp2nO9Bg+8DqPFQI5ULrTniTFF3/N79dogo4doIw
X-Google-Smtp-Source: AGHT+IHkpviueCxPAncVyPEBUvgkQ5l+Mji/G1LSPdhJ9whHcHmPsSlrrB0QY9BNghda6RDsVxUeJA==
X-Received: by 2002:a05:690c:6d0d:b0:627:de70:f2f8 with SMTP id 00721157ae682-6ac9621e021mr68279197b3.14.1723699985422;
        Wed, 14 Aug 2024 22:33:05 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:11c4:fddc:768f:9072])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9da160c7sm1482307b3.118.2024.08.14.22.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 22:33:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 6/6] selftests/bpf: Monitor traffic for select_reuseport.
Date: Wed, 14 Aug 2024 22:32:54 -0700
Message-Id: <20240815053254.470944-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815053254.470944-1-thinker.li@gmail.com>
References: <20240815053254.470944-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable traffic monitoring for the subtests of select_reuseport.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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


