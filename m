Return-Path: <bpf+bounces-78487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5111BD0DDE2
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 22:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39D07307D473
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 21:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB132D322F;
	Sat, 10 Jan 2026 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZJoTh+0V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238692C15A2
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079139; cv=none; b=Rh5MckYCuViumdAEpLQISzP6R424nUuyl29QpyjbklruBwiaJrC1YYc+2BHDaSiHPXbjEg9PbFFL5SH30arl+pRO9fOD4GaKGnO4/ZOuvkOpIUFAZozvknQRVubXakDMWEU4fvjX1qsz4Qrro8nHKGfv4eeCgLbh/p9nDFi0Pjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079139; c=relaxed/simple;
	bh=NMdhogUQMVehSS0mf+8AXeIAr4iVGjT6IB0EBPb4Dvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9bahnpyLZZ/u68uFjbp7tqVVTVuP1AlE2ATAwGdqUHILc3AviioOqAHNO2huXWkluoR9zHRiKfYNHjZK9TQGBP6njpKxpcAM6ZhmyyzuJDhLmP9T8lkQcBVBiX15Km9pjNZdvuo0BHaJdqqQFkOaiCkPlFVx/Nxp4kCnEaMU/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZJoTh+0V; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so7620046a12.2
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 13:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079133; x=1768683933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eg4zjCrLlkyG6qsti60/giOUAtyjjkrdEhVln0uD/Xw=;
        b=ZJoTh+0Vpho36AtFkwblfmKmVZ+sweyfb4+TgFhq3DXGE4tuw+IYLPlVIAmXB1IxwK
         BxfVmtAp8nZtoU15RuKjrINdsU2MNDUlqYJpojLWCnVLkXxyRSJ4hfTkYtqb4nUuvv3C
         iZQI9Oi10I0rLHQPE2mbhch2M1aFAvpnaL+Oi4zd7ZjiYAP4T2wJjRD14K1fZm3jsICu
         wfueF0wRInw3iZLNiNcuaw/IzphdJ6tv0gG4gRuqsTOY0lprCCrOl1J4blMuar8IAuFh
         r41r5ZgNzfk8aBT6pgMoynYouzSAx/pu9Z2tIK1d01yUWmv89/r/Vh21nQ5hWnPwvthE
         RGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079133; x=1768683933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eg4zjCrLlkyG6qsti60/giOUAtyjjkrdEhVln0uD/Xw=;
        b=ZJkuhEFXTSwWqrgXUZwA/FqIraxyB6lg3IFLeOZpUaeoPzvf2obTXjobh67Cngghl4
         dpsJ322OpN5BHuSy7dXHXVk5qJHzbDolWBqFlhmbOj4c3lFt9+1mo6HWOWhVPc/sVO6g
         H/giC6XwNrefR+dDPu+IX5rhSTH/DnbKPLH8cA9tATP908WoZnSc4oPhp1Qb9HPlTj3L
         jqShsRLtdZoy0G3VFfwLkQasd8DoRjKFeCECoj9MGis3HW8ADNWZRVU493BnDk/QWnBd
         zM9jEVUr1kFgsD3Nfmc1yu4lD48PqVXHHM/NffXAdNWg3zv+7YES5CeSAQI9UwGPfJKY
         o0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVqA9CGFx0fdKB59dD4Xbtx+9DO3ZWpoUrL3isqXqvHi6Av2K3W5eYeuWeKMirLJ+jenUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpiriV/xYb01FIauBBw9oah123/uhWmVU9PjyPnAZ30hYStXBI
	jte2hMJbZqp5dMRh/OXddhuiQEfqhYCo19obYeEYCmTtfybGFTJYSBRN9cLvHmHLV0M94wYUS+D
	don3W
X-Gm-Gg: AY/fxX5CbeUpoa8olZbh9PfSEUkB6oU1eess6faT8HSbv5midxBSMPB2kMCDu5gOBIP
	cAXi/tfauoUp89RFJ22PEAVjz9EP0XGJlAN1jFGsdBX6AUFpdxPY3+m0A/aNoj38/DDuZAY+3at
	MFrcXstMFEESSbmE9PmtwRmjMAjHQAiaBbC4wzbKtqsPRlHr1I4y9YKDEvZ2O0vKJ5plpEvoBU6
	uf66tzY6GmVnnQgJZ7kEDJ32QHyilLN2SaWOOu9jXPi77YucaVtnNGR/63a1387Y6KLM/ijV7MD
	BZJJL7MF+lqK4Tkg1m4ZhKC63XzZ8VKR9tjs2Xq7B9FbE1hr+RJ9MfVgAu4h7wCXaYezr/UPfCB
	O26EAwx1zMT8yE7z9oCmu+OLonaLupejbcdNNdyyjsd6ET+JRdkK+JjFqHO9JV/SuY2TiwOEf9B
	5pWvCGD50e3Rw/qf8hnAJcw6v/o5D2wq1gMPW+SrrDaf7NglFZkdXFVO62mbw=
X-Google-Smtp-Source: AGHT+IHr5jjLIg7Fc8OxmV32vOhb8biD7VVZIPMdffGLc0JSFUNEJ8LGc6xEjJiUaoLQN5K1DNcPEQ==
X-Received: by 2002:a17:907:1b02:b0:b76:f57f:a2c3 with SMTP id a640c23a62f3a-b84451ef354mr1384718666b.12.1768079133287;
        Sat, 10 Jan 2026 13:05:33 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f912a2ddsm209666266b.71.2026.01.10.13.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:32 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:22 +0100
Subject: [PATCH net-next 08/10] veth: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-8-1047878ed1b0@cloudflare.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org, 
 bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to copy the XDP metadata into an skb extension in skb_metadata_set.

Unlike other drivers, veth calls skb_metadata_set after eth_type_trans,
which pulls the Ethernet header and moves skb->data. This violates the
new contract with skb_metadata.

Adjust the driver to pull the MAC header after calling skb_metadata_set.

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


