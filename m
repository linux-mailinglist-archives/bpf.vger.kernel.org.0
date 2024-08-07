Return-Path: <bpf+bounces-36599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF2E94AF23
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE9B1C20D61
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487A013C8EA;
	Wed,  7 Aug 2024 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF+hxBht"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30413E021
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053063; cv=none; b=EhRwOj3d3qJcbdYmbsntCo3EjP02QJJWYfLh9x+smb1n69VSyhraGw35b3cuMWnOsh1PKP4v26pvLVdBX2EhHI0PXeynYwxptnAlCkm5dUtmTExXk+fr7cGgnBfZIwyW06FRvFYSToRHrgkM50kD5OiW1XvBQO9WG8yhlawmDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053063; c=relaxed/simple;
	bh=lt3zhKDlu8UvTCkl6aukz24Ib3BOXXhXSbgrEbKi7Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mF0t6ZZHtE9knSeUAAKuuNAxW3UJh6+gOmzArVbu2TLaYfajOvprGFRWbyVc3BmJguq/+92+vRvz92I6lXfqX5hvdF7lQDcAq8jTRHqsNFUyzx1IEy1JxP6K+UHssnu1fbnqOrSy3YtPnvqDnEL4QNPz5DqnA5X22eYP0f/3OV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF+hxBht; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6512866fa87so1114807b3.2
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723053061; x=1723657861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo7BwQAJ9kpUbJUpSG/pXEG7Wy/cwb5sOEuOUxiOOIQ=;
        b=VF+hxBhtc6INh5isWlXmqWt9KGQDUUttkLbtAnbcPO0NT7dVI2jhDcKfyMTeJoZgup
         7Ma+BELT2+7DBawJY3TECZK1msJMLb/nDxjrDv2ujQZqeOZsZt+TmSNgivHz1hTo3Lzt
         9IzbhKM6TmY8Q6NGSzqIBBEm6ebFUc2oevn3Shrp5YF9PcKn45CQZRP1b2war520NeVJ
         tIIGEhfm4G+ttp8eWlrKiSYeBtusAciPDJcdoa31DAi1n3/Z80gGvseXbVUzKS8I4p05
         873wyk5vcUkH9YGcAn1Uq8q8lyqr82ey6ZO4bcAff1x2ESAdEFnE4RWNTIxmHTN1/P5r
         +9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053061; x=1723657861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yo7BwQAJ9kpUbJUpSG/pXEG7Wy/cwb5sOEuOUxiOOIQ=;
        b=v95yz8X+i9UkuafqRnzl+XkyuIrn7WM7PI/CXwaMI8WcFcrkuAjEIvnSJDU6TNoxgd
         bfHgykvptJlO1L03sXUm7hgQIQm1eKsIGedhdut7yzG1vtYKaf+OFBsThQALd+TEbIMT
         cB5sCfhC+f9GpmwRpAOGEpCUwQD7JvBRFAhPLmdJT8pXNpesz41kQFK4OqWnkb7UrLvl
         1U+dpnBxYCtmAWi4hKS41/mV4GqR3Pq9UfBMCXBQxaw8U8YGJ6dEEYkWzkDkp7+DZXJ8
         n+e/YY8QF/o/tW2J5FduKDflHzsOb/jII+5xzmp/2ixNS2FAIbJugmp26/Xbqcg8cbgy
         g6Tw==
X-Gm-Message-State: AOJu0YyGkAx1S3PnqAUaJNSTHjgY6faWFUU1asfqetb1iOR8zuBkFs4v
	yC7yaKN0ftO9X2xjhrV6tBTPKek7qrGeCo3YR9ior9idK+UD5LaSW/I8wIys
X-Google-Smtp-Source: AGHT+IGDKkE8tnobKBd21dkp5AJ6+JKQJ1FUEDA1slKuxYbt5ArwlA4/Lhpux0wOINMxSFf4qYebhQ==
X-Received: by 2002:a81:8607:0:b0:648:857c:1530 with SMTP id 00721157ae682-689639ea9bdmr189791957b3.34.1723053061429;
        Wed, 07 Aug 2024 10:51:01 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68fcd1727f3sm14988727b3.90.2024.08.07.10.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:51:01 -0700 (PDT)
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
Subject: [RFC bpf-next v6 5/6] selftests/bpf: Monitor traffic for sockmap_listen.
Date: Wed,  7 Aug 2024 10:50:51 -0700
Message-Id: <20240807175052.674250-6-thinker.li@gmail.com>
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


