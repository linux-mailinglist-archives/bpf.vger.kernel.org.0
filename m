Return-Path: <bpf+bounces-78484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EC3D0DDCD
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 22:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB49C305F33F
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 21:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329A52BEFEB;
	Sat, 10 Jan 2026 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HdnkxtTu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD82BE043
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079133; cv=none; b=oWzP/EhxqFFR5hLVFuN4cIJbRBlz1pnnLZJ2IdJ8t9rn5bXtbQdaY6ngjqdASrWjp9HrEngEh//9JJpf+CmhASlHgeSyxbHFc9zyaI8ekcpSEaxonM1gY7avagfgvsDsuMVZhaBzzFFwPsfCZrFB3A1TEzRo0/uPCa/Lne4e3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079133; c=relaxed/simple;
	bh=9NH2qhopx9N1V2kd7MywYZ1ResFz5o6ZKuUu7RYAzsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o1WyloehVMC0AfN3DwFDOVncZHBdamfD6ucjgl3JwgycG0PGi5Nq8PQjGPdE0GxyCq1qu6NffXJ/n0v9Ovcn3vCEqjCmpQ8FTfXGm1h7NmvLcao5eOe/fvpbg/YN/K3My9kZ/YdznwzPbKSYkvgiF98DuV62OZY054uTe5TfviE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HdnkxtTu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b72b495aa81so1005386066b.2
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 13:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079128; x=1768683928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TnUC/TQ0eRLnTNM/gOpI3DULP5gf/J95rnk3NBvNrg=;
        b=HdnkxtTuucxceJpCwGqAgAfr3lY4lNeMipJM9LHngDwCNYlvVOplyQvPkvNZJOYMP0
         FyP7ObWYpPIVSVFFNzBDJGfN9wRP7kPbvajM8+M+R2LvRh0EIs6XZvalDEpJVTccTbwN
         YExHMtkAkuoOg7ljBbNIYcPFhooCPcJ8cpxIJDSq8T5F0ZbHQItyuL1pQWs8krCSJWpk
         ofd7LZaGkmtbBhXxFxG8t/2i1Zuvvc3+izuXj9l1PLx9Fgm6DX8FDzWXpepH0hmHz8ll
         oAoMnXdlWO1nwlc1SJnLgASRHr5/+yY/OmKjD17jtThvVpsCvk4P4zayaFdSHSI6GWUd
         cqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079128; x=1768683928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0TnUC/TQ0eRLnTNM/gOpI3DULP5gf/J95rnk3NBvNrg=;
        b=TQMoYRIcasAsZikJ1Y8K6pqj2ulwHWll584Y02A59vMWbCs1C+98GNTWZYiTvxR2Fp
         0G48lMQhwqjrkVZMflaF51YBTodYQ8LCKmtgsEYRAmoALEmKye75kpi01QkuHixCSDYn
         sbcC+rZXbPoDik9UXOPYajdJ9g6eJpCSpDWjS26bMIfBzrhJ+P562o8wgd/RV1rpp3cG
         cOnJ02UNdtwwtsgg0FRZSzafhrJgrBkz4PiUkgBdNT0V/v5q6bL5f3nD20teEV4qhnCf
         efHXGqF259nNqlHdspMGiXq049POmE3ylpZ6XExE3rFFmC6eTqVG++6YEbMt4KZO/dpz
         yfwA==
X-Forwarded-Encrypted: i=1; AJvYcCUp9Ta3SYf2i0bhkcBTFFQvEpyl/CneryA9wNaybI4GL56MeQetyWDtbpI2DdCDqjwCS1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuqjetn1GBUxXRuRMxxUUmhzNZv8UpWtjxYC+8LEPGUmOLFy3E
	UHHChZwb4oBanAbhazD4D1DDXoRp+XZ18B6g3tRmh0z7FFugfKfnWjQlzp02Ivfh6vL7vzpft5K
	dUMC4
X-Gm-Gg: AY/fxX4DRIOiPPoSGxlDxHTQjlLY8aYkDvlUcF5HjJatpf3T2mmS9zcpbx1zPgHL996
	vslaCU8ES2yHnj5ooCszffJr5VujznMePEziSzEGKMrQnjsJB9m1vWzlPNfvRxWie6bMCeuPeDQ
	CTZnaPSXB1rDL6FY0Fj3qrKTdf4eI8zY+tbgrbXrgJA4IAxa6HDa6W00O1sL1fxpmNHd/mQCDn9
	ZQqBdwmTdSk+RQlugI4Pe/uSaTN/NQP4ojVIWrHfeAN7N6YSGPrjm0eI4RbQBvCpfUImJKA5hNX
	NZHhiihiJOEE5EoT3+5W28KULIjYh6av3nxZqnOVRfPXVwhN9HyxV17DlP4vqB9IBOrqR1hSvJ8
	MlNZjGvVrFTTMadiTErl6agStIRnUQ3cEdLT0+LsczWkNC5d9YlT5tpTEjIZ2t+IPcmlaIfp4Ng
	XsgYagvT6cfjAS2fTHlPiermgaeyWlmaOjnYNHg7kR4mbdnk1ukBp2xJXJdrc=
X-Google-Smtp-Source: AGHT+IHFpJUTXLFWUnnv3h2YytegrKQCwISqD8mtMirbPzcSGIv/sObbMsW2/ceFAmzo69tIkpwihQ==
X-Received: by 2002:a17:907:2da6:b0:b72:134a:48c8 with SMTP id a640c23a62f3a-b8445232b14mr1313892266b.14.1768079128172;
        Sat, 10 Jan 2026 13:05:28 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f61d2774sm243607866b.41.2026.01.10.13.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:27 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:18 +0100
Subject: [PATCH net-next 04/10] igb: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-4-1047878ed1b0@cloudflare.com>
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


