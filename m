Return-Path: <bpf+bounces-78101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7043CFE50D
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C9253020822
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 14:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8BF34D38E;
	Wed,  7 Jan 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PwnWum4Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4034CFD1
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796098; cv=none; b=rlLq+BkdEtIHblLcs1lIOP3ivlq0XEP/lW+nc+thaQRLmNkOAfK1yvyhl5bf+9v/QkB54TwkosTObSzOooXfr9qmJDt1xjARr522PV42XJ+7BxvY52QSR7ERmDFzCRfENLFIs8pqaUsdWRa4J/V55BIQTwRYEozaKBZoY9l36/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796098; c=relaxed/simple;
	bh=EqBhB6y4nXWzGaTVlNv0CC/SrtIcyYjJWnFdNxvlzoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FM+vJnucwQ2/QN9iqtt3hJ/ffWBLLyOyGWzUjoPLDeNBWJ2VuujnNHTTsZLBwuqZSJfHCZlYPElmibNoeT2ffInMrRrR47fZR2egzV4u91yZrQcWnyKcMYE3YWVbETWSuI5PAttEWvEkAK2owTgLJNjLpV5jDYFMH1fq/SCsx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PwnWum4Y; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so3178219a12.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796095; x=1768400895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEldMdCG0j62Bqlt11G+kGjryDuviTYdgTtDogGixLQ=;
        b=PwnWum4YQxv/4sRr3Wi2yZY9u3+t6iknJBIUtrLoxGDpGeQDjv7YZbUOJJ9wOlkE0c
         /7VIZlSAkJNuVFHe9lpFcdKZPdCsPj7jJuoEmfFgCPA2P38tG72f6sBtkov1DFWYFs9z
         akgEmiPnvSo3xCiwFAeXZuFHHURyn2Uz0JnLfrfRZa68brH7TUgxdy8shO9ygd+Sz1rh
         l3YMoz5FBG55dggmiyU4K+sePSyz9BTJ1e8FVJ5EZpz3t2pQSegTloxICs4x+r9bGrc7
         T0Gzt1dkuETFVuyd4RJgYEwEa2gHcmX8wVdZIzDY3yXn9wC7Lwb7Ieet6fWQ5lBAjE/G
         HbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796095; x=1768400895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eEldMdCG0j62Bqlt11G+kGjryDuviTYdgTtDogGixLQ=;
        b=BuMcrwQDRsP+Jk/N7cByeCuHcrQQj5q9pt8X+wdSCPCIc0cb1BlCYf15tZtZ1RWKhx
         XjaYc9BL/I7v74Z65fyUgzFqMx7LXgouN775ztLh33ZbHFQBDtgAaV1HMoc43ZDUv0/m
         cG/SGUf4l6wsLmCq0DylGn7v4rWZw0jJcVxKUsO6nyCoyuUdn5xr11myO6C52yFFhyaK
         JOwW44eIeXnzHkp3x+fOl16PMW7PsxeBn/NOIJZNdyrYhRSX1mzjYdarbhjlUMcb8YrQ
         9+l38rpwThGbhv+9EM4j+DdWgVuvSFsjIA4HVp+MHGZ62Now3SKHpkP1g9tCALagqXPn
         NrsQ==
X-Gm-Message-State: AOJu0YxR5tFshptaRcQcSnX1HJMoNjrqAbN76E/YnAd2U2/DCxcJtQGA
	e8hMMtsNeFLMFjUUaHS/fSRXCJEta03/Z6Inhig2yZy0Ki4K8S3o3YYWfFrgCCnSuQ4=
X-Gm-Gg: AY/fxX4Uzfdq1ISPT9tFGFXiq0ndjAYZT4Qx+2HEqANzjEUQW5r6TKj3UkFaarmfkpN
	GoW/5EtVvLCkhsP4yHYkiQGeLR/HNSJOFl/PeIqEP30osS8c4cG3bNBfkj9x1E/0TSj4XYxcqys
	YURjSsUozVo2iIAw9mVUTqyoA+V+n/jGUHqnuQ/lxoPs3sgUTWUmObjtFCylc9XPsO4auIeAXvI
	xWE8EkxtYrgPktlTON9mApTfWSGkfr/Wa+ym6WTelwGY8U4HBTIJ6Yx9GOPxgUXZdRj0M15JwJc
	j/YtO1ihuZh04ZZbX5oH9zVmSQTf1eA28x+ZAl3RVaTG9FoD6Bb5xwF9BPc90jUX2eOe4At9alt
	rVC2/uBOCc0+Oq4+bERhIM7AUOLaFGsOAdwIBXV58WXNo+7jIWJICQf/BF91m5k6hlsa9bnO+Fl
	INqeLEAzJu5iSpav4GgLZ1jOqRYM3XarBWVJmmRvnYxKGJ/c2HBBwqDRNITbc=
X-Google-Smtp-Source: AGHT+IFKcPUGIq+mmaMwAEQLCwLx+EsZkE4IjALey6nG5MPGe8BgpahZ8lbyqj5flRXjNA4QXcGT7Q==
X-Received: by 2002:a17:907:7f8d:b0:b84:41c0:94ea with SMTP id a640c23a62f3a-b84451dedf4mr261454066b.23.1767796094756;
        Wed, 07 Jan 2026 06:28:14 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a235c0fsm527821566b.9.2026.01.07.06.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:14 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:04 +0100
Subject: [PATCH bpf-next v3 04/17] igc: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-4-0d461c5e4764@cloudflare.com>
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
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7aafa60ba0c8..ba758399615b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2024,8 +2024,8 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
 	       ALIGN(headlen + metasize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	/* update all of the pointers */
@@ -2752,8 +2752,8 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	if (ctx->rx_ts) {

-- 
2.43.0


