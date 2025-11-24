Return-Path: <bpf+bounces-75353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60334C818F1
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA063A7CC6
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85511316902;
	Mon, 24 Nov 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WSfYZC2o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FA53161BA
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001757; cv=none; b=T7WKZC6OpnVBzW9KXZXRKjN+oqJapvNNwDb9FyEtTGFSQV6vmzXzW3gg5iG6wMTqSSJUua7wGFHt9g62esSpWIor4Wy3oBc/1xuKFjwjGG1DiNHYWxkEvPs8k1Ude9hyEavYVDHf3RQ5AnwmNaDxL1G3Lgx9VeN145ufIHAAj0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001757; c=relaxed/simple;
	bh=Jw4sZlwfvlCw9U70oFYHFDt2JUDMKantZkYZjOZFw6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BoD+GRSqLQetADwhACEVC7gW3cBVdF7QtZglynI98JSabHAXIjtw6uc4/dU27dsDC4TlZ7Te0g017FY7oNWwk8+wIUAX5dVe5NmSQYr1/7InZa4kBpAOfcSEJt37cRJy2pe+AOZbow3pex/TVULNE1rOGymGkrdlwf/ctL2TzGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WSfYZC2o; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so21173a12.2
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001753; x=1764606553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT0a9okVqQVqG4JPUviJUmT9EW1WnhugEMsAcr4nqg8=;
        b=WSfYZC2o9IYtrkP5kLVbiTx8FFhr5GAP8/74SplmWS+FAaNAZrIEm2ePw77E6FZN/l
         jjMfG7UhuXMuep5mzJSFmxQZc+xdHV3dXEYvKReCV0mBk18kH/3iEq4NhcAJt1KmzW8A
         WuvblIHyqxYPmR1xxEWnJ83517XTda8WiJ58WUmuKnqwc2ZXJtiNQkl/nj89hABEs6iN
         mPe9qP2FiM36Vi/EicA9CYmNGicmTYOd/G1gcZrIyFDTFosrsDzEBQL2/OQ/N+dTZ/B2
         fA7KmwUE4hUdvL7khfrZlXhEn4paqq2B8/VFTXxG02Y20YIAdEhgwieqX4Cz10qns0RA
         P6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001753; x=1764606553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nT0a9okVqQVqG4JPUviJUmT9EW1WnhugEMsAcr4nqg8=;
        b=uadhOSUx5RvH2zeW+774iCujsWM+sbo3vQKhFGPXIuSDGRl+hyYJjBpAT59TnkQKn0
         g3dxS2FFThwfXx6NsUq6jpe5SerEbu42eqDW63heX2RCzjuC33zGG1i0NOCutiUHObyt
         tNUnm7Kkx/Vewp66pLwNedkhJHHaxBYAepkJxf9FhdFhnIapIzsJ4bwVM9+iQNGJgfPI
         a4SZlLvWjDAfo7z2NfJQCnzjJT56vLMB4TwYzDHfbFLVcHUxmdhppWboNMYZsA4EnTSU
         kO93Q+jorbYtDDuBUk2ckzePMPOomccT2CB5gN9qUeRfcbZMC0EupJelnCducJ8XKRXC
         mb8A==
X-Gm-Message-State: AOJu0YzQZiiG5rIQTH5erdBZhAakBPGPsNUtVWe05ECMmZTTkB1aI1r6
	EweFrUz842kR15bWyNud6FjxURAAhFRQL2bCk9YtTu1dj+i+BlvnVIsNYX42IjJ9VEfQVQ5gn4g
	cgnWH
X-Gm-Gg: ASbGncv7B5SKNXiUbYA5vf9F+YX8VU+fwKkCZUx1NJ/JRQRVGNh4iOeuMWC3P02gkIe
	wfZ1xzFZ8SfPNB53xTY+lxNIpqvKfjXcAarUfFHd75lrQZgsyf5Fna20wIKrtulPk94b3EUGXFo
	X2ea68YusqFoow1nuY9UEpsS1yv4t88cQier2A5HW7enVPHKyT9JGha2CiJPeZOBZectHY7aywC
	cDOz4e3JxCAcbPeM2zS4fXYHjrltWjgymT+Zf4LapuH+IiMxTopCrnewooAmiUTKkL35YkNAKui
	v3L2c9SgakK8SHFgD7lHeVS2YDlumJAZ9koOnjmZYXX27nYYytpTns44dZt35c4l1WfQC1DRzyZ
	Wk0uq/Gd9uRzemw0No1MSxgNXkho2cNg8Rzv7BMMFpvXutSt+64Jx0OHDtn7XBvWk6Xgzzd7Pqf
	Ea/NGohriiRYaAd/VtZpOeLIuITl7uH9lmtHdoX3z8chc9+GrDkKaSA64i
X-Google-Smtp-Source: AGHT+IEEmnCNnt5w49ydTTn6t2HeNn4PxEGho4FAfkYth0YmUOYGocOk/Ic7gQ4x6EifblEC6MIjWw==
X-Received: by 2002:a17:906:7314:b0:b72:b433:1bb2 with SMTP id a640c23a62f3a-b76715434bfmr1302008766b.7.1764001753420;
        Mon, 24 Nov 2025 08:29:13 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765f840a30sm1173487066b.58.2025.11.24.08.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:13 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:39 +0100
Subject: [PATCH RFC bpf-next 03/15] igb: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-3-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/intel/igb/igb_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 30ce5fbb5b77..9202da66e32c 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -284,8 +284,8 @@ static struct sk_buff *igb_construct_skb_zc(struct igb_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


