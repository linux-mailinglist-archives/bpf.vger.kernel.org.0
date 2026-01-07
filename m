Return-Path: <bpf+bounces-78102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BABCFE516
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FEDA3069203
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C8F34D3A6;
	Wed,  7 Jan 2026 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XPRELppN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD834CFDE
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796099; cv=none; b=f8xQb5aSzFVFjLW6slRGgzETnovj8EBOSMWEHJPQJVS0qS7XyTmkV5gjn7GEitki1ewpH+/OZSU67aRyKZmiXWgLPhaFGehY30JCPYmcmuC/UJvvuP7lVF4BcscKdx8u96ODqcavCymW6P0tPyXMYe6geKYDBa6qcOBcfDuKUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796099; c=relaxed/simple;
	bh=gpO/s3IET6M0QBXoFLb578gA5Up+AO2D0gt4GSXzoj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRRM0VBLUfpG8uOsW34wSjIrA75YeK4kENnMFxgRCqiRKcOPvXUdRBzUT7b1/Jb/JxwtoPU2yOLfKHLsZpr0RfdcQfcLbCMEvJRZ9PArHjI/TbKQBIT6Ps86L94iYAaAfmn4P9dI7kGkyD8uc6elixJU0WoWXjLo0scHmsCqjao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XPRELppN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b4b35c812so3415769a12.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796096; x=1768400896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMEkNzSHY8m2OSZAYn9MnG4foBQCWrZnpmhHp8FWdLA=;
        b=XPRELppN2RB13QJUodLSThy186s+qopIGQKPzlCGYmwTG868YdNnykU9DepgSV+O7O
         mz7/3CRwPeJi4zv5vdEO9fTo6u29wMWyPesHZatzEZetRxaWMxflAIz7Qxb3g7ZOHWgz
         fg02nYUuqyi0U/cx173HTGUAl6aO3FKBw4tVp6A9IXVTrEem9gbpQtI1PFQCooROPdsw
         H1jGAc/2Sw7fIVKTo0xuCgIgG13ruo1hkE8vk+xRZWDlBC7Nw1r4ygRmFwF3fJktY/vk
         TerI+gzWeShhHXq6v9QBg2mul5Nma2/gjtsz4hfqOMAQKdBI+mw36wuE/KcFeeHmjTdm
         DMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796096; x=1768400896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMEkNzSHY8m2OSZAYn9MnG4foBQCWrZnpmhHp8FWdLA=;
        b=w6LhDDMCpoxrVkyAXHiAwVRaZxQVQGF4x5Id/GL9EmPs2kOso58+q7kZQF8eTTxKrE
         zcT3y+M5vPkYakCYHQSBLE+ZJ3Lr+2AaDoy7c21sApryxyakVOYjg0Fs6B21udTF4bpq
         VvkOP4W5klLRpC2qdSCixhQB5SNePWg0QVPV0bgrDFEm67hh3n4BoAJRP2ul6InCvB90
         Cqn/1TLvH5g2UeLFocKaWXqQKszEmhDWA7G/fOo9XxWXJdBy4FdYPfWGZsQwdcV91q5i
         dH+RS2N4KHv52rqnXx9JDFPq3bodHBELtP2iNnvb1zzlWKJoKiYoLvVT7cOxjKtVzaLh
         DalA==
X-Gm-Message-State: AOJu0YztQTPH+N6zv1HKiOwBQr1bSHXbVPwfv3BcnC/mxe0jFwI9U+ZQ
	t+4DKiaHXpThhHNReg5Q2gPQ97RTTl4T8yfPg2Sl8n2mABtEsyU9QjKgwQ9e5K6gb1Q=
X-Gm-Gg: AY/fxX4ybXcshqMDXCKumP4Y1fIhUdl0xjHCdal0ioQ5mEZYWPTCGgl/o7q7pn85Lko
	6yerTY5JE3Awq5uV3fnq1Efvw8zvZCGXkb9PQrZvgVHzNsJ9P4h9QBAVBnxL1nV+0PEAu9ibiRH
	GIQB7397a3HAhiNPazluMhqufEhsb5/pgk6TW53rVg9IY+54n4Y54sEfxUIayUWsbkTWMFjyvmT
	28bsZJDjn3HJKhYMiswKtBpJtuFigxazWBC+RTTRtUj2sBGwj545inFhmTYYSN7GPe5Q7TsR7it
	h2hNRom4DOgwr5FWu434jXsOzAoiaxuaO5TAMKaCDEy42Ixs/phlE4uJCD2XbMVYlDlkuWWkMpm
	4+Nag7DSbjbiQnBFQ36WL/M7jIi2oggpjwWdcVpSzhNXwXu4uAJZTrk+rjefORujSHgEX2Y69R/
	czU7QwCAarx0ql0YSHuxno/Uf7fP51Cn0wcfwzS2Y7meXABUHsOZB6rH00Xoo=
X-Google-Smtp-Source: AGHT+IEB+UD5y8ywWtlBBElkloGbtwlscAKvyqvwbVfNSR747HP+E5J4G59xBFl6Yd5xQX4XuePbZw==
X-Received: by 2002:a17:907:3f14:b0:b79:e99d:913d with SMTP id a640c23a62f3a-b844533623emr262535566b.42.1767796095898;
        Wed, 07 Jan 2026 06:28:15 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b22c3absm4927510a12.0.2026.01.07.06.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:15 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:05 +0100
Subject: [PATCH bpf-next v3 05/17] ixgbe: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-5-0d461c5e4764@cloudflare.com>
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 7b941505a9d0..69104f432f8d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -228,8 +228,8 @@ static struct sk_buff *ixgbe_construct_skb_zc(struct ixgbe_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


