Return-Path: <bpf+bounces-36600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0630494AF24
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A510C1F228A2
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F42213CFBC;
	Wed,  7 Aug 2024 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDYRoxX+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834AC13E04B
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053065; cv=none; b=JLpF0UHOYlvnECah03WB26Uf1viq5ug2GndXspiNmu4238Wx/HdzNd/MuewkAa7NpZae7WShvs2LzTN9wXP7nClHaVCPHdE0L9Absh+Y+M44Fudfnlr4Rom14Q0iabsCTMZw/tNQ2mX7j7dFRz4IMZyp37nfIuZT15P8kEzVYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053065; c=relaxed/simple;
	bh=UDOJiRTvMpuD7RD6NM/euJKuUKttLepxfa4C+u3utcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iFNZgxtFr6WA2KYz3sZnwpy+v/Axfr+dere/eLMtqbLAPIsQs9nTC0W8VLZlDkfX8VCZbNkx+NdK+Pgt8SZqo/OkiMJIjLxpOrLkgiPeyIUF3lyAopTkB8YBdbkBJ6M7u27fZN9IF7r2tKzfN8d2HqMduZoJXDJFMSclezz/iQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDYRoxX+; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-651da7c1531so1142247b3.0
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723053062; x=1723657862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhVlXzW9eweS2OHYJCvRKUDeLzK39AGvAsyg3ZtVVXo=;
        b=jDYRoxX+Uokb6aSAuszXrTRqnfvu8oPcCvYZ0TX5F7Ys/eZevISIHwJPUIHmiV4HaX
         2AcwZDoMUX00uU0CJcBw5LrKpHB1u8UU2AwAmXjIKydUyqMpK/WGOU//UZeiVyhHJkEe
         hZpOfEhWqJsmwmp9IV8XPdadOhnTfvKSqGZneIIf1a3LbXEVH1CKR2T2zBJdiJNTSDEW
         ZKdsaIQGIgurhJSXYgSjGtbWLRjqNfyR/XtPOZIUEOAOjxjdfwvWtypxzIedKsbftWkC
         5XslBN7/Ust1XvQnX4/5dYwdvTEqpMsKgjb8Iu352M86Hm4wHgeeZpiHBLmOC8n/N+np
         rMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053062; x=1723657862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhVlXzW9eweS2OHYJCvRKUDeLzK39AGvAsyg3ZtVVXo=;
        b=HPpzG5S7KIz2fohT07SypgsBA06+DISPM7M6FI+trBq5hkwSXgD9dOqOq/UJHOFm5E
         /4wfU9Fsnn2VJQLesAN2fkW5NVFB9hEXnzjqlLdo15aNHNwvtv2Hl3A7vyw5g/bE3Hqg
         n31NZhvcq6npTMmpV4G80YAhuLofxpLPNeFprsvp7lBIJvE1C3R9seuvigkKbsmVFbiW
         WPOs7B0yCOgGUIKTSl+U0yYJW9iuNXWu4xzpwqjiFta5Lg1RV3Bd0KR5B9kdpvXW4xs+
         PnWz6PPfsOv5CC0KMRLsynrntgnSALc9OHO9gd3nkYZFexN53n5X3DSrRDufELCI0EaR
         ZtLA==
X-Gm-Message-State: AOJu0YxbNayNfVH+aaP2V1sCP3o3MkpB/uiVlytNHwPVG9E0J8Oebe3u
	SdQZ6EoC/CSHZ+Y83JrmEcBLsZhKQn6ZeHsNOZt20RQ63vhjPJ1sNM8mVFgJ
X-Google-Smtp-Source: AGHT+IHfArpLBbkH8jz4g42ZaMzoaS+e07/xA/41tVMEy48vFJFdrb0p6SgZb2uAEgGO2nHSUArvGQ==
X-Received: by 2002:a0d:ff03:0:b0:654:c11:602f with SMTP id 00721157ae682-68964391576mr224478077b3.40.1723053062515;
        Wed, 07 Aug 2024 10:51:02 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68fcd1727f3sm14988727b3.90.2024.08.07.10.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:51:02 -0700 (PDT)
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
Subject: [RFC bpf-next v6 6/6] selftests/bpf: Monitor traffic for select_reuseport.
Date: Wed,  7 Aug 2024 10:50:52 -0700
Message-Id: <20240807175052.674250-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807175052.674250-1-thinker.li@gmail.com>
References: <20240807175052.674250-1-thinker.li@gmail.com>
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


