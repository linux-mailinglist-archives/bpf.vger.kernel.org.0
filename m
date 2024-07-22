Return-Path: <bpf+bounces-35207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99BE93879E
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 05:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F08C1C20D93
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 03:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354F14012;
	Mon, 22 Jul 2024 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFwRBWZj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com [209.85.166.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AF21396;
	Mon, 22 Jul 2024 03:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721617733; cv=none; b=RYN+R9IXqzl1KJyGFN0zdj9sxabIpixWO2tHmvOzKdC4R6Yv7fcLT3NWZIPa2bQljwMDouZm6EQtvjcdk4GHETxvKMJEOamYouVozYOPm3dvBXnyqfcKijqDLkms3AzyRQnnvI491J8XNAcm8RHSNibzJw5Hv/6dj4883IDegIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721617733; c=relaxed/simple;
	bh=2/lygQ8AgrsYnLR4/UktwaFOWM8BxrjE8c5cBPx61UE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HviTJbRGm/prUJYjoFtphKJwg6NYXhthIdUNHXgySwrAJepNsIGEL0+qTHSJUVjdK0vmwGep97Z6Yq6BIZUS1JtKd0RofKAS5+lagJK8L2YmaajWPc9QAJU8B22AOJIjTXvrtDsGxWgfTWxFD0wpkx9Bc6h980K/FjjsppnMvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFwRBWZj; arc=none smtp.client-ip=209.85.166.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f194.google.com with SMTP id e9e14a558f8ab-396675b83afso17147845ab.0;
        Sun, 21 Jul 2024 20:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721617731; x=1722222531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5tkzPnSggHqHJjAibf1nmSaGhXCQ7KdsxcKsoBrick=;
        b=gFwRBWZjfeFMQTFd+gKvhQF/jr4X1eTTX0+wiZSJ/efnn6xGswfddayLVyq+rWjVKX
         Zflo0NFZTtM2mf/6YKo89KRtA0IWErLoq8jucZrLv1PPA/tqzMsG6s4WVnt6fk1lenI9
         nLgvNX3/ue4sDAPKUxOQw0c7WAt3ofhBBMuKQJcfIYOdwibZx+ZajLM2B6JogCR79S/i
         djNUeZ5Fn2b8FHeKL+P7eayZa4iNCmtXx0poZ8J16sKg/W5BcOEnTsInR9lkCN+eXr6p
         Z6uLVXr98lwsmKcfGWIJ3zW+huJMLy0GnY1Iscwqp5Wc754RZYO7FoniOxsUNrI1F9PH
         Dbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721617731; x=1722222531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5tkzPnSggHqHJjAibf1nmSaGhXCQ7KdsxcKsoBrick=;
        b=plxvikb5oJRK005H93Xa03wukuZUlZAJyH8Y0ZS916W1b9s8iGAOKMPZkweWLfae5k
         BCntpyUWeAwq6yzKfI2IOrI6w/54QvXt9eEa0BPa9iqwkb5XuLLUIsAf1cTZO1SSxl58
         cvj4GRLpsVL4ILTFN9w27Qch6eev5yoMf/rQJNhFLAN6bzXQlOS22rPz1yaS/sAh+LY2
         /QvwE2kj9VQy7s4iubuSnKD1hE/4EF4nk5pyJOEyoJhEL5XxuyRd/OvjGJRyFVh665vi
         qyBT7SOC46q1yog8FineaSE9HJ5bGS6qg8CelvyTYmnPXnvbcrhJra7NtmpoXYT3HOd7
         cidA==
X-Forwarded-Encrypted: i=1; AJvYcCUhSqlCKcMPmNSBIRI5EXRhzMzU4Th7gPG/Uby2spzkfIrKqSrAlTDivGhYtPT8sXNV/zdAf8ttyJLVQAbpIzFFtslun+zuIF0o7BfEAywvaow3AyzJfle+9oysrYWuDMJk+Ib2SnOIYzPQ2iYzlPgmhkyOSZoE2Krh
X-Gm-Message-State: AOJu0YyImCDYfQG3b1gck2A8l0eOJ+XFDS+HyY8CJaPEEnEoqB6R/u23
	CMIThge9uStoo3UO9s2DgIqVbqpIm8bpYqDOvVKcf860cJwYdbSq
X-Google-Smtp-Source: AGHT+IFXzcPxLWLRXF/VjYUkActxVPpIiLjD64yPfxSfNc18HU6Mo71gn8d8HXUKKSXPe3p0DT90jg==
X-Received: by 2002:a05:6e02:138c:b0:383:5520:cc48 with SMTP id e9e14a558f8ab-398e537cc05mr93029145ab.0.1721617730982;
        Sun, 21 Jul 2024 20:08:50 -0700 (PDT)
Received: from localhost.localdomain ([124.126.229.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff4914b2sm4444973b3a.33.2024.07.21.20.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 20:08:50 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: willemdebruijn.kernel@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	herbert@gondor.apana.org.au,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Fred Li <dracodingfly@gmail.com>
Subject: [PATCH bpf v5] bpf: Fixed segment issue when downgrade gso_size
Date: Mon, 22 Jul 2024 11:08:41 +0800
Message-Id: <20240722030841.93759-1-dracodingfly@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <6689541517901_12869e29412@willemb.c.googlers.com.notmuch>
References: <6689541517901_12869e29412@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linearize skb when downgrad gso_size to prevent triggering
the BUG_ON during segment skb as described in [1].

v5 changes:
 - add bpf subject prefix.
 - adjust message to imperative mood.

v4 changes:
 - add fixed tag.

v3 changes:
 - linearize skb if having frag_list as Willem de Bruijn suggested [2].

[1] https://lore.kernel.org/all/20240626065555.35460-2-dracodingfly@gmail.com/
[2] https://lore.kernel.org/all/668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch/

Fixes: 2be7e212d541 ("bpf: add bpf_skb_adjust_room helper")
Signed-off-by: Fred Li <dracodingfly@gmail.com>
---
 net/core/filter.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index df4578219e82..71396ecfc574 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3525,13 +3525,21 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-		/* Due to header grow, MSS needs to be downgraded. */
-		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
-			skb_decrease_gso_size(shinfo, len_diff);
-
 		/* Header must be checked, and gso_segs recomputed. */
 		shinfo->gso_type |= gso_type;
 		shinfo->gso_segs = 0;
+
+		/* Due to header grow, MSS needs to be downgraded.
+		 * There is BUG_ON when segment the frag_list with
+		 * head_frag true so linearize skb after downgrade
+		 * the MSS.
+		 */
+		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO)) {
+			skb_decrease_gso_size(shinfo, len_diff);
+			if (shinfo->frag_list)
+				return skb_linearize(skb);
+		}
+
 	}
 
 	return 0;
-- 
2.33.0


