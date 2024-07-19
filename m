Return-Path: <bpf+bounces-35048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B62937296
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 04:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A14F1C20EEF
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 02:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7010A09;
	Fri, 19 Jul 2024 02:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbHJdevf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E2C13B;
	Fri, 19 Jul 2024 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721357225; cv=none; b=rHRJYuCjRNJ+ya4tFMiZkJfRm/x3MIhXlGD+JAW+TOtLuvZlO7Jq5GOEouq5tot3bIRD6+qapiKc1TdnTL9Ldgl8t9NknutyBYNMmkAn9m4FxyLXNSLWGw2sPsaVZJOHKaHvHX93onMjLQ0gPt7j5U1yDeZGNwreGd/DAHz/fUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721357225; c=relaxed/simple;
	bh=09oA/1MGILVHtDLQKLMrs4vatq7Tvf0hfrVKuBV/mLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KNbFMShRqQCKM9vhLuky4eSOu8Kd4IVSi/iQrnCtYVgHttbWlnwIOXTH77ZLRjL1e4V5sOLJMRumG89+w5OlPxtd9MU0btzOyc0DUU+NbJheXxmXzT9HoTvieKaAWr22U5EnIixzzz9FzZQpQarvs9Y3JWpAg8OYjtokMUpk8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbHJdevf; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-70cdc91b227so400695b3a.2;
        Thu, 18 Jul 2024 19:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721357223; x=1721962023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBtl8tqIPwr4kM7w/vnxS7d5O+npgCgYI2eDxbd6XM4=;
        b=ZbHJdevfgVJNwfLYZa2rkZ+Bh3U4sMCMzXztuzL6xPuUCp25BUmPUTNhMJIpLESQPg
         hbVnBuLqsDXtn5cXarX6VwPiJE4T4td/HfPxwGgonA1eLclVViReYzgojO7/930w4OTD
         9MA7FWIJeYeF5mwF/U4n1HVz5AVaRDGXa34J1OYeg4ZO6P7NU35Q7ecXBcOe+He74ys/
         ObZWtjUutyD+DivenXl4EB+Yf7CRMWizWkMzfWwy4JcZV7XL34QTcRU3k97pbC0VqmVp
         4w2C7hfPbSPRJ2DMaGV+EnfPwMTcEwZPRbqNM/xBlIqHppImfRJuJz0G3Go91qwYyyK9
         D/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721357223; x=1721962023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBtl8tqIPwr4kM7w/vnxS7d5O+npgCgYI2eDxbd6XM4=;
        b=qNNl2PsDugDdLFQwa9tdaHjrAcW7h43VsbUfHgnW4XVVLdEMPudsOXE223YL8LXL+y
         RdtmK8IYBJdnJT1R+P4GwmYzSNFOdqDztSHjZbQq0Em4a67KvIo43UrnnqEHGzVt4FSc
         F4IocsAPR82q3OFEFxkRscy+puU/RTXTwJMOTImP1XzLS/h/4Sh/4AlggoxLWkbrcsFX
         Hi7oPLAIjULoE5nBZvwqHJJ5SoPg2WvmYbyZwCbasfBeX2HOkA87oPh4JYtqUL+BcKxr
         nfhHQwfmvEtZEYENRfwK+nJUEJ7Jvx6mIrb/1LaQiUU2JcsCvVQ5zWikaqz8LhC2W1vd
         QZiw==
X-Forwarded-Encrypted: i=1; AJvYcCUcX4f3w8unL8POVOHNtIp7tNGwkjrnTesnTWs4iHT1C/q+4/+kr7DFEv0FWMVNIpuQqNwHnCvJxx+YITIEjoutnDa7hDcHlJiKRtr3++XTfpnUklFD1kJlDoYprJGb7AZH5gEXRVBQUOyfcYWtG2F8n5vtKKHEnVFw
X-Gm-Message-State: AOJu0YxwgNReaCwI0OsLY4uadJllEWsGbaiQIZv33Z7Bqg1NQoCjgoxL
	gNHp63CamXGzKNa4N30p3k68gF/yRzdwFnDN/r29NAa5aEbsyNmvGCqExZZHSR4=
X-Google-Smtp-Source: AGHT+IGQ/kwJ7FXSWT/EKM6eyqwOSgULG11mnTX4v7BiH0egzCFmJPIlmTX8dyx2+auRzoNxSNI8Rw==
X-Received: by 2002:a05:6a20:d50c:b0:1c0:eabc:86a8 with SMTP id adf61e73a8af0-1c3fdc6f592mr7952542637.5.1721357222916;
        Thu, 18 Jul 2024 19:47:02 -0700 (PDT)
Received: from localhost.localdomain ([240e:604:203:6020:208b:a5de:1b8b:3692])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd64d073c8sm2974995ad.178.2024.07.18.19.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:47:02 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: willemdebruijn.kernel@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dracodingfly@gmail.com,
	herbert@gondor.apana.org.au,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v4] bpf: Fixed a segment issue when downgrade gso_size
Date: Fri, 19 Jul 2024 10:46:53 +0800
Message-Id: <20240719024653.77006-1-dracodingfly@gmail.com>
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

Linearizing skb when downgrade gso_size because it may
trigger the BUG_ON when segment skb as described in [1].

v4 changes:
  add fixed tag.

v3 changes:
  linearize skb if having frag_list as Willem de Bruijn suggested[2].

[1] https://lore.kernel.org/all/20240626065555.35460-2-dracodingfly@gmail.com/
[2] https://lore.kernel.org/all/668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch/

Fixes: 2be7e212d5419 ("bpf: add bpf_skb_adjust_room helper")
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


