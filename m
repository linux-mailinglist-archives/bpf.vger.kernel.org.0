Return-Path: <bpf+bounces-78104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D55A4CFE541
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB7AA3008C7E
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513B834D4DE;
	Wed,  7 Jan 2026 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EnwMBMMG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3534D3A1
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796101; cv=none; b=lFeSmFuVyBGTaU6fAnu+fYcc5NDV4XFlV2d3H24Uzuh5jp93fgPCz6Iv6rehK6VMW8ErjnEZ1Uia+qKv7VWDt9TjnR1I1WBFHW1ra97uvLUhRK9AavydjuDTfHvaE6a8TocO0UE2Zb9WUKCQ0GefE3Dn/VPQ//DjnvZrJdL5Tvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796101; c=relaxed/simple;
	bh=NaajF5tLSJC0MVk186WINR7q37KABHcy2kYvLo9rMVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PY8DqbHrRqQCCR09SoCNY1p+zfeiNi1RcHxft5kvGYptKkg22B4rT/1R7Ii+E864GVCnBiSCFnwy2R3MWFhUVtfRiHC+3dToswvLfdALH+y0l1sre6HWtGDSjVsQuS2ipRAqpFgWao+0iIH6AY95hKB0FYHhHmP/LMmy8ARovXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EnwMBMMG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b843d418e37so147518366b.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796098; x=1768400898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyt1pEvTxrkLTTNOpoJZXjB9GHiCuwIadpGr/Kcla8c=;
        b=EnwMBMMGL8haINLqX/qQHtgAmmdQbuKw4Dl+gcSYHKXOxdiQSqqNfXS2+A1G/rbFfH
         yAxG8ETxr01nzfuR8oGjiICoDxTei8gjry/zhqYoG13LDxW5IuVWC10uBHW3qmUqSDqt
         T88L7lPGkiMjFxD70CclE9NaNK38gJZAUhlfjNMwlDaR7MyjkU74j0O6BvS3zN+A5Wio
         MjfEdjDKr+Nq77NjS+sLnQkA36pyDsl6UpZEoTiNuwt+l9ZU60OQWX3SYPC7WiGfq5KV
         LI8hcsG04NOLAUKGFKyJy6A2hpWNHwqgIubN7OkiRn6ALv7AqrydttKcwJsOdXeQJPOJ
         4wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796098; x=1768400898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nyt1pEvTxrkLTTNOpoJZXjB9GHiCuwIadpGr/Kcla8c=;
        b=PmvI+PWhDbpaQcczHJqiWwtG68l8Ic9JHpe5KKckHFN446Km0szd31LkC4fBHEQmv3
         WUQC6M2NSS6jzjO6CxT1Lz3+w75kXl0ZwUjoYAogqKkN5V7WfsxVeFbM9miFcNjp31bX
         3I+zL6P00eot4118Lnu8IB4hShKaYYQ+5oh87hRskLuj2St9Yg57GQzbdF/DQuNANVe0
         jJFr18TjEtpf0S21v5IXh/kVLaHqojv2WrBw129yJ6AzOzFS4ZXcsllAzIgJYzGpSVs7
         i2AHul8jbdTbK0D1e+zzQUAgsvQfTlNg0jcc52D2xZqpb7/+q0TCxQwdEdExdrlAXjYw
         64mg==
X-Gm-Message-State: AOJu0YzYwI16QsNeXH8InR+UMOyIAUI+3kRjgfVH5Fyx7g3eItqonK84
	6VKANlXdVzyFairmrgjhmLRU2VCekg0tW4GLf6HH+dnxufpEoZohah/lffbD653UEyE=
X-Gm-Gg: AY/fxX5lDh2l29y5xbQGRL444o4IUt/TSSiBsC1UkQzJXiaBE7HhbTbicROY+c13Fm7
	OHhnwOX0RoGe497nfOOCW9dVidn3+DpMf28VmtfLmamrGRlcSdd+rS5fisPpW+aBRlgT9CmyiRq
	SEA6RNqsYgNuC88fXJNn9sdwL7Av4P7FLRu2P99Xr+4u7AzD3jGRB+o+01/MUMzDPvC6oJHKUSY
	0cDq08E3NE7S5wAK9vgN/0xhgDBe2D8u5nOhZrY8rI+UXvSWBVywDEIs+irRAGv5BMixw8cZZMk
	mIswFBFpgwFBeO/zgv6CbCsEY+D7m35DZSByMsew9RkqCL4qFPFjnWXpbCV6RQsLokOIC3e9EeL
	FDCHh7ogp4Gz+GyRUjQ2NpwjMg6BSt5SQpldOUHSa/fzziLiXwQ+dcPq5786Fgdw9X8Z7kRzS5G
	6ldJSDxsRFNMuo0F6rx03IcRq3A7pbqo0uiG3Ym2yfhRGBGzF3wHSWQZw7miI=
X-Google-Smtp-Source: AGHT+IEExcKIthsPJDITR8jYbXCRYoJRS+tApF4PYQnCgfrHNXaZtgzMTVY3hb1FfS0AHvszM+Xs1A==
X-Received: by 2002:a17:907:802b:b0:b7a:1bc5:14c9 with SMTP id a640c23a62f3a-b8429b9c13dmr489449566b.32.1767796098132;
        Wed, 07 Jan 2026 06:28:18 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507be64efasm4631150a12.21.2026.01.07.06.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:17 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:07 +0100
Subject: [PATCH bpf-next v3 07/17] veth: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-7-0d461c5e4764@cloudflare.com>
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
points right past the metadata area.

Unlike other drivers, veth calls skb_metadata_set() after eth_type_trans(),
which pulls the Ethernet header and moves skb->data. This violates the
future calling convention.

Adjust the driver to pull the MAC header after calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/veth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 14e6f2a2fb77..1d1dbfa2e5ef 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -874,11 +874,11 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	else
 		skb->data_len = 0;
 
-	skb->protocol = eth_type_trans(skb, rq->dev);
-
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen)
 		skb_metadata_set(skb, metalen);
+
+	skb->protocol = eth_type_trans(skb, rq->dev);
 out:
 	return skb;
 drop:

-- 
2.43.0


