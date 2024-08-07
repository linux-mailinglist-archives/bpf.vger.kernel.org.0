Return-Path: <bpf+bounces-36613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D04794AFCE
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 20:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C5D283069
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 18:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE9314263B;
	Wed,  7 Aug 2024 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmxPGcRM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9D71422A6
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055521; cv=none; b=eXE+QBt9UVUOfFSxo/V7DTUvryxRPLNyYZLSyaglVwpiZ2t33O83bMe69bob8pnw7L9NtiqS2rm0Q/ypUfnfGmXLBMUOgLtXaaJvqCSQDKpbYMH3FdGgOtT3cg37Od/nK4t4Cw77Z5dP1UIM6G8zlxPEDkgo0k0NUO5zSPpHt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055521; c=relaxed/simple;
	bh=lt3zhKDlu8UvTCkl6aukz24Ib3BOXXhXSbgrEbKi7Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+9Zoe/QgqajRRkYBSclEr4M4xvvKuMM9yvcj5SsKojlxf3YY/W3UieelexSNkVTVmnwSavDvv8oIlsbMlV2ZNT25SmyNzat43HG/L3Uofd6YQ4hNl2b2N2l+8/+lM/BfrY+bFM7H6j/VmDGZ1iEfZIfGcftSq423L0XgqcSqeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmxPGcRM; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-65fdfd7b3deso1479007b3.0
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723055519; x=1723660319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo7BwQAJ9kpUbJUpSG/pXEG7Wy/cwb5sOEuOUxiOOIQ=;
        b=YmxPGcRMcNs9iaFuirghOKnqGykirsAbIlek1VoXftwZDXb8gNtL6jiUXaxrpgf/Aj
         0UL1iGCrh95cTCmVPBOwhurdNjfbz6xzathrwq3BLGfZHSGVVE3UHhpB3Pl+wogdbD0L
         4/qu8ICd0jpqDH71jj/6yOWSPnuFQsq/Gfo/HwDbWlZkyVKIJD5Xldjtdj+kzMawhgEH
         gTV8cvGBc/j5vXxjgvpILkEFslgfoQ/GrAl7Kb8ktsDkfkvydn7ti2aRXjsoll4UnRVT
         Q0oB8uKZG5RSw6BRxJnitxOQSPH5QiWNIUqCR/WgWAIO9PEd5U+Xtv83vvOAv/E1Gsrz
         c4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723055519; x=1723660319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yo7BwQAJ9kpUbJUpSG/pXEG7Wy/cwb5sOEuOUxiOOIQ=;
        b=tFiiO8gVCiMLSGAiGkY465rCIX5f8vijtBbyXzGj4L5ZNfJzw9xlfiPjPTVAxJzQv4
         QQRUPD4S+CfBhCKf+Hp1fEIfRBKJ9xsA+TuZkMRHr0v1ms7WKwDAo4rpOLJOyoK0kDbG
         NyG1Fv5IZEmSu6Lw0OM8vPA2Yl0cnxcbpvrjCiMECjE9qX/MFf7tHkubigB+F1GJc3YO
         UvkQaMDM6YQTa66Kih/jfCR2ATYlPXu0HZxlLZO7p9nCOi/yXe22m/gd4ZmYPi3K9SBv
         51dsfMiPyKDrSPMO67ex4T5kb/V+bUCUy7NQgeyD5O4bwUXih0qP7ygbgjejmH0Zstuv
         +5kA==
X-Gm-Message-State: AOJu0YwZ/S7nG6130da5KRjlgysnipUuoBfHI7cNh4oYSt7TFAcXYmxV
	Yfr1/ZRa5KqluVVpDrbPSbcnVm7CGS5rDHLDRZ3WLbuB6o95S2uZIavxSbg2
X-Google-Smtp-Source: AGHT+IFvjsABt3P7sqspb8yjQed/Bx8k11Qy66T3CUnx3u23P0MYrHN6D88NPXmhZEepvsVZWHqPEQ==
X-Received: by 2002:a0d:dac6:0:b0:633:8b49:f97c with SMTP id 00721157ae682-68963423cfdmr209493497b3.37.1723055519039;
        Wed, 07 Aug 2024 11:31:59 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f4188a9sm20106447b3.2.2024.08.07.11.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:31:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 5/6] selftests/bpf: Monitor traffic for sockmap_listen.
Date: Wed,  7 Aug 2024 11:31:48 -0700
Message-Id: <20240807183149.764711-6-thinker.li@gmail.com>
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

Enable traffic monitor for each subtest of sockmap_listen.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 9ce0e0e0b7da..2c502259ec6f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1925,6 +1925,7 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
 				int family)
 {
 	const char *family_name, *map_name;
+	struct netns_obj *netns;
 	char s[MAX_TEST_NAME];
 
 	family_name = family_str(family);
@@ -1932,8 +1933,15 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
 	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
 	if (!test__start_subtest(s))
 		return;
+
+	netns = netns_new("test", true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		return;
+
 	inet_unix_skb_redir_to_connected(skel, map, family);
 	unix_inet_skb_redir_to_connected(skel, map, family);
+
+	netns_free(netns);
 }
 
 static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
-- 
2.34.1


