Return-Path: <bpf+bounces-36614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0299794AFCF
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 20:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B430D282FCB
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 18:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE911422A6;
	Wed,  7 Aug 2024 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKVNWsts"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C394140E4D
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055522; cv=none; b=e1yUTBMyKWjg+infkjdSAv3fV2EwUYnZxDDWDu8I8X4PInhrGghjq0gcruEDNJB+9zmw+gw7Q6AT2K/bfCwyTqkA6YeKZUJ+5PezBLnAManiJkFgr2W+uRhNPYfjVsjE8hHc2H/HEmK0ALeOMPpBzIkbWlsbBi5OYiqHkWBh6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055522; c=relaxed/simple;
	bh=UDOJiRTvMpuD7RD6NM/euJKuUKttLepxfa4C+u3utcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VB8vZjw1WVjMPWNGuE6ZCqsJgJbqF7ET+9mLUKrENfgz5c9pFWH31Do2ZRPGUA3vfYO+S6vIVAM6WiAmgZqiTPTdxx79ykJK22TH6KP60cg2PPy7qhKFeaBEMfFpCc70I7gmOh/5bhhMy9TCi33fRgAczB2cXZEuT3p3FGXQVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKVNWsts; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70930972e19so53107a34.3
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 11:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723055520; x=1723660320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhVlXzW9eweS2OHYJCvRKUDeLzK39AGvAsyg3ZtVVXo=;
        b=jKVNWstsW77ClF4P+8+wh+RpI/MbowBhgDr340PTMnGkC7vLratUO69sngrnCUnCha
         pPP4NAEQ4IOXEwne5PMYccXQQIu/vxuU6Fo8JSVw2Qn46N7bUaa8sInR+QKSLFxMfZxE
         r4UHw85FVgRKdsL4Gl4PstNw4gh7oBBL5SAHJeTjggzqI0/bOiVbA8uXXz7A/jkbDbdo
         Y/QS71BcXUcsohZnkECGu4DRGOluH2ljyygN2pn3fNewdG8qshBB5nQ2lqXlMPARSkDt
         Zum2jKmgqhV6iyC2a0kIvZDbhKInBElmyVBeIsBmocihB37q3JMefkESM7sCPW0sF/8U
         i6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723055520; x=1723660320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhVlXzW9eweS2OHYJCvRKUDeLzK39AGvAsyg3ZtVVXo=;
        b=UFLTETdvl2GWrWdpHVYmnOOHvtaatrLi33YpsncQAcJHqabqnoFFROL4NS4DoBPHCP
         GOUO26UN6I502O9Pf4XPDPN9RVoBhW0cmjsbEHRdgkT9oasZkc/LBGi6jqPCwDAicEXa
         MulVHbVa63xwjv8laHNQTya2UqLTmIWiJTdGRmUdY9wlUwdElyqWwqx3z0ni+rMCWYxD
         3PnIohsUYf8KpKd9ahDBmIuqtY17IPJl0Ng9XPxXxipeFTNkrpByyo+M8ymzRNZmcdE/
         D+zbpdFDtvrpfgtW4nZBG3kxQoZsXZyOOa5k4lLhK6cilcZt/i6pVV5iyyOJF1Rou9Cj
         JWPQ==
X-Gm-Message-State: AOJu0YzL2Jc0XWlqG+jh0XZ5y+oP2hFQ0paYhbJzfeqMtOk/syqz3ad5
	XBPXhHNg6cBEa/sRIua7RnfZyIM1HsWGinqjvAMLy0n0u0X/n/EMdEGFmmPv
X-Google-Smtp-Source: AGHT+IHnziNeJMyvVND3XwBFbPGRvxPkM6tJGCYou66+Yy5AmgjXpU+4B52shgeO5k+67lQu99Ejqg==
X-Received: by 2002:a05:6358:7250:b0:1af:7ea6:c95e with SMTP id e5c5f4694b2df-1af7ea6cce4mr644822155d.4.1723055520143;
        Wed, 07 Aug 2024 11:32:00 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f4188a9sm20106447b3.2.2024.08.07.11.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:31:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 6/6] selftests/bpf: Monitor traffic for select_reuseport.
Date: Wed,  7 Aug 2024 11:31:49 -0700
Message-Id: <20240807183149.764711-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807183149.764711-1-thinker.li@gmail.com>
References: <20240807183149.764711-1-thinker.li@gmail.com>
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


