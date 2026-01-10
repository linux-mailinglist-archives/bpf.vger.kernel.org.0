Return-Path: <bpf+bounces-78482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C43ED0DDC1
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 22:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B4103053388
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 21:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004DD2BEC3F;
	Sat, 10 Jan 2026 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RnOo7/zl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20F2C0F72
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 21:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079131; cv=none; b=gvwRVSczfPnQAQ4Okq02L+lhJUs/s6O8A++ijxEYlVJOcKEoMng8BDLR5M+oPbARENbvs1JMiWIAVfgp/xb8rL3s7vQ08dNTrbl6rHLpRgkPIcvOOUfjCYg6SXvGDkhtxBV1qICzQJfN5TsPD8674iI9aAbzsipkxaaRJ36B5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079131; c=relaxed/simple;
	bh=3AKTSUfuvyxS8OlYAqMdvKeirQ3fw+RmiaPyE+M3PO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GsaQV1vdQ+IM/1RdFuG7d7OPnAFcikGbvHwsOkakgIB3qfhsCsaNPBXp2UYGYOuNJSqFlR7Tc1V8wF1ag396i64AjxDIE7LbpNx1WlYz7g7TfLMgPs5mSWOChVCgFlm1KSUy+dhlLuJ6zGSL0+4JmLrfV/UCNg2ijKOQ4E8Vj9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RnOo7/zl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b86f3e88d4dso73645866b.0
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 13:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079126; x=1768683926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=boSDHCNRu6fyxjZsrDAsWl71xR0mK1vjeAbhKjI6fRc=;
        b=RnOo7/zlYqSUUoFaZHZ97hcwh+8ZjrsjYIWDQ3zoawYpOA8jD8GIzs/kXMSqMQMDkM
         7/IPMn4eLt5fOhL/h7G1FhJm4z380dVyrVTE73rmN1NtXC42VvJXDrBh0nWmLSL7mJGN
         cfpRUWfSn1VZmDXKkHzK1+nKIGyBKuY1oyPa7vzd/zZx3hRyVoYFG4ahjqF4q+55XcCT
         1Yz4EE7d31mEjC2m5eoEhc2UC5MdZ4P4dZJ3bOkQKB6620PUjWCgz+ZSYyS9bYBzom46
         0C2opxshuuRt/EzEDFiRiRDIUZVbce+6cVpI3G3GUC3mDA2f1VXbjElVp2dMzoq9KCKG
         S1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079126; x=1768683926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=boSDHCNRu6fyxjZsrDAsWl71xR0mK1vjeAbhKjI6fRc=;
        b=Mwo4T6EsxxaFLD95zY7LeeTMiJ5qbuHQif/S4W+M6kTEgUV4DCeIIyda3QPCLsh4X4
         zXPxMj2IossfK19JcCO6VF64iuar3HKTusHmjnM0weqyL2RPHnTbJ4RZVJcKvZoYebSG
         adYERzobxaOYCX8X7ZQtwHJmkc2vQmEeDmzSMIHJAM38Wt8WjxnLJ3gDD0vfYFuoXgW1
         S7kxjspEd6n2HVUTafnKNhJr4I4A/9BLHQJrhIXCFHFGzOnaBFFDTFiVwH7MIPfLBfQ/
         mJY+LeFqHl7iqZBudnMIqF28Xlh756FHWnU1GX6ZneFfBaWekf6FBRpswY7iEvhjumsJ
         MimA==
X-Forwarded-Encrypted: i=1; AJvYcCVllbIbR0iZK5ddGbrO1Ek2S5sSPXRfVPBNVL+u+uUlEGLa07AS3xFGfDC8UKnscpTmWj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmmphl3SS1kYBw76GNdslX5/q13oaPpK2gGoJ2U6Jy8A6+3u6S
	mSpqDfZGiDpwalBgVlku0IWb7w1yEVzCexIaNeaQKzZ+xKITgMsYYg7AYbc5+4gkxkpWN/pIOyt
	weVmj
X-Gm-Gg: AY/fxX4JtEuCE2PZfKURuCZNBywQTaWxRrBwUqfk6A/vVBU3S/w3Npc9F1XOomPMGLh
	1YRMr3LUwRfY7e2srPNKqnIuxYyGVI2cfbFJ2qp1oK2KjlsUJLiTFS3kDQnm10ar6p9OETL/Kho
	3wwFrhjHue1YJ3B/P5IlMePawa6TXCkhLFQWmVRjZCVsh12Kkx5PXgEB9opX/R9e/gFOr+W3eXe
	RfgEkLLh8lgRFIEN4/EYnFlcp8lvf1skvYMZvDbpJpZSkFebBaySZPt/6/NDjSmnyIEmYnRCn2N
	JvwXSubmZ8onHirhafYo7J7j4SYuVIkzwaJbi3/xCnkuwkJD79G1dhf/ESRUhuA8lfbCI5PStou
	ubR8XeG3yB7MLxYmbfQcvga7MONDhPoNZaReUypQeKnOhX2SzTHtejBqRS4NAwpb9HY/hcKOLdU
	SLdfLcb41ypYaeKxj33KyQkrjjoF7DTGBpQa+krzj659er0acjh/q/DghxEKk=
X-Google-Smtp-Source: AGHT+IEshYDSYgCJqSefNVm4rMDKSWFaQVKh1B8mzv/nYNmn2TNWQjnoEFs5sQkugV6KrgohAKZImQ==
X-Received: by 2002:a17:907:9812:b0:b7c:e758:a79d with SMTP id a640c23a62f3a-b8444f4f40emr1328381166b.37.1768079125661;
        Sat, 10 Jan 2026 13:05:25 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8701e1d467sm130421566b.70.2026.01.10.13.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:25 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:16 +0100
Subject: [PATCH net-next 02/10] bnxt_en: Call skb_metadata_set when
 skb->data points past metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-2-1047878ed1b0@cloudflare.com>
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

Adjust the driver to pull from skb->data before calling skb_metadata_set.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8419d1eb4035..7d0d81d29167 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1440,8 +1440,8 @@ static struct sk_buff *bnxt_copy_xdp(struct bnxt_napi *bnapi,
 		return skb;
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


