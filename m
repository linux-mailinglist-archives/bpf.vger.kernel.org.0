Return-Path: <bpf+bounces-78105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A87A3CFF3D5
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 18:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88EF633EE251
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 16:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E0234D4ED;
	Wed,  7 Jan 2026 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DlnQabRy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D1034D3AC
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796102; cv=none; b=LoyHr+IzzYanwSFoU0Goe6Jh+ePflUQBJL0VsYrD+j6qzJOz8dVzGntnV3JZYRgK8cu6TU8eZ1Cda6N6muHdUY6jvklKYR+hMakE7T0h0zrnL21futYSsF2ZBPjatFx/ElVftqX8t4lpUQ4AVXjYzxocNLULNgTM0sQ6BhoGtII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796102; c=relaxed/simple;
	bh=1tuE34tqdRZ0Cq/ciIXf0IbqXReLHJ00YT+wtQPddnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ncWu92m85WV7W1TLGvMkJdKV+oET3tprOKCKpTtx5G0tj21CD/1wk7JpcH2wFN1+doe4HWuw7nVz62bDTxeI4c4d9rjad/o38G6oHMq9gSa5GTPx6NhFGJH7pk7zDylG98VB8dCllg7Wvtu1BuQF3OJWoETZ6quqbCI5qhHy0yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DlnQabRy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64dfb22c7e4so1494457a12.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796099; x=1768400899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvsM1sRJWYDcPZakX1MsPvBpIu+3P2Cxb3oshH7eLdY=;
        b=DlnQabRyj5at5r0zIrQ4HSbSWQnhsf0koS8llLJgK6lIbulKZx/LWIyNaewmPLgCp2
         lRdFT4bL491sghJdfJJqVpSL/FGPo4sLyJ4oBp/7VYyQwGlgWZ9e2SctojwXt1w8LnJI
         PG4BkaAMRK3jC/L4GuzdP1nYFd77NfI2hhn0hKF8XWrLTKymYyOWpQmkOqdYefWLyNLG
         EyH/c7JbXEPqkjUS0MrmEi08DlxIM6EjT882CkDj6Vw18JJCm8ozS8d6sDkfjt0EjzYC
         n+9NgICnhXgF91NVu6sHh6VYWgvKhvouJ/G3I5+3j0grXVocXo+gh+cs5pQV9LxHo1Ss
         F0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796099; x=1768400899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bvsM1sRJWYDcPZakX1MsPvBpIu+3P2Cxb3oshH7eLdY=;
        b=XEmTOhUcJqvvJgTZRrp0rxPyqnJACCh8zf2ReHTL3GM4yF+5nGp46pEdjSG9l2zFCG
         6L34mT9ka3F7nP6eIOviRKh7T6huwUewwZAl5gJrAtfR2OWlUvfddBa+r9BsA61L3auH
         3LWlw9nQMiYkdSEaSYegS6ksXL17187OVhZvBEb3jrKX0yMdzFSqj0YzEdCQVaq5OliT
         5NpCNvBcAVJEj5zU5M3whcTdP1xJUrbv3raV1APEaNvXki8QF4J9x+A65FD/GCcaseKD
         M+NmjDPxJ3lH8Ef+NDYr0Pu6acncSJ5K9aNfwcaxZbBr1vnKMa3mmuioR5ph3tjsfpEG
         z69g==
X-Gm-Message-State: AOJu0YyGqd3IQMhaEqdr/pbD1s/ZVYj9cMgA3bC24CifjXfIAQvlvtMn
	Tez+4+5rMGu9kBDPCKQ0t5mN35b4D/rastjn6kvEImCIOHzElj61nwG0XnR+e9Hxujc=
X-Gm-Gg: AY/fxX5tYKUoxwS4J2uZT7gBXaBu3lkkmiQ1wnrUBo4fOT/KblabUN/yOBEKveUX+FT
	F0lD392ImDQBHZaTJYR5rDBQXPGRrj7b12iDYKK+WvGiezYL081QycNGNTr6MrNT//y4KC1B/9Z
	9GufarpLpa66XvnfPUfl6DGSddE8fdYx0KddZb5PLNzz8y5PNh1qkgU9Q6LTcIRHelPcMuxB8/9
	PgojHkSdGrUo1woUrMtd7+Xue5is6Ilx8CNjAjRSEBc7n7y337Npmc3higVATOFKYuvUbo7yJHi
	FGqt8lxbDq/S04FzI63XMdWOrSu8fl71cRttv4+eLn0oq31NnUWLTYtNaRCRAxxc/1LC6QB3b8B
	Qzs3aPvINf2aAnZRT7FNehx3gFBTY2zx3N+fv1BwQPR5YYWzlkreZ4rSf/ESx0HpmTdxrcdk+8C
	vTWnmuf4s3FM7RCSfwf1wLWmOge7FLvvAT0pmCEPsa9I1RkGftAHeiUIUhJFQ=
X-Google-Smtp-Source: AGHT+IEecpe3jiGI8SXIV763BBgyluAV6tRhMtb46iFeU2sSBdZeRQkgSyXlUdzVAnEHk17J/a8jKA==
X-Received: by 2002:a17:907:3c82:b0:b73:9222:6a64 with SMTP id a640c23a62f3a-b8444c5a808mr344054766b.3.1767796099347;
        Wed, 07 Jan 2026 06:28:19 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27bfbfsm520269466b.17.2026.01.07.06.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:18 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:08 +0100
Subject: [PATCH bpf-next v3 08/17] xsk: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-8-0d461c5e4764@cloudflare.com>
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

Adjust AF_XDP to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index fee6d080ee85..f35661305660 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -768,8 +768,8 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen > 0) {
-		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
+		skb_metadata_set(skb, metalen);
 	}
 
 	skb_record_rx_queue(skb, rxq->queue_index);

-- 
2.43.0


