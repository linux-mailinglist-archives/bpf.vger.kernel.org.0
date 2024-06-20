Return-Path: <bpf+bounces-32649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FAF91158B
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 00:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CA7283556
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 22:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13DA15216E;
	Thu, 20 Jun 2024 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FXV5Q4jd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202C1139CE5
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921964; cv=none; b=MvJMZVcI/lENVy8Tc7Ookrig0jW/nTjrswkiFYElOAO9skMKgU4LT4MtxYv6wpRVX1Wg9KMDDgrpohVUY+n5kCOgPs4tvdyc/HxYOvJ30u6pSkxylVhiIzkQNeAbrpvsJ4Xa8ERH5Dbo2VNkQ+ED/Obc3d2JsvaN2GjXGPKu4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921964; c=relaxed/simple;
	bh=67A6Ac6YQftcvhwDMNA4TWQLwqsK0VkfsMZwmQEXDgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iX7iRTK4jd3O9J58AO5QAepqTwiU/H0CT7UBCCCp/eQp9bUQHWJc6DJAgbOYat3Gah+X18KlOL+/0P3L3MclqQCV5cilCZbI/pMi1qZ1eZiwGgtUHCoGVIlebGyoLiE9QzztXM4REHpTeZ2nA6yu9laq11NC8WiiWTNiEd7R+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FXV5Q4jd; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7955841fddaso125021985a.1
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718921962; x=1719526762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OK8tYlg8joxvSAleL9jkPigjYKgVARJbZCH4f6lw/EE=;
        b=FXV5Q4jdOkNB1z6uft14vTWz7CyW1eFRmOqMlxd6/tKVLcic5MM92UAvJae65oLwuz
         3ljaedH018WXEzXjdXGH6QRGJ8Lm/GbvUPcaigyEXxxqpO3LVG3/6otkntzpp+vhlbbR
         j11sH4KX9maxjyf7DZQJZnQsvlXu3va6YZMRVU5FRu2wLFEM68FWe4L2rn3pSx6X4+rn
         kafmT5pMRV/IxdwuClcd14EFnj09FUU0Ca6UQdg/ouhTRPL0PgXJmC5wkY6m3Zh8QlVB
         Gf3f4+uckR6eCYQlvJbx5UMUVoUxi04exgWpfqwADDepHSUCnqBcutmGwhNuP1t7T2XL
         vm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921962; x=1719526762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OK8tYlg8joxvSAleL9jkPigjYKgVARJbZCH4f6lw/EE=;
        b=dmTn9cHzuPVF7rB0k6NohoQF+m0hlIKGIgVkOzU4Y5XTVrH3U5/sFJCxQRaDe3yJz2
         NBedS1etfVIfd1uwMLRqN3/0N6XUTq66dVTiI0bkH89Puzr8vjTpvzP+XZusA3+cZAha
         GeYGa2DNqRpJm8NZ/m0WTY1wQSxsxvYC6TkxsUzlIjS2Nex6RGdgZB3CvoLTCMYHQ0Zq
         Trv9H20WpO4pQ2vgznhvA9HBj1zUVNZR3i/GzDTrTL5V9kS8jOj8BrD48zdqpRLEN62J
         KjhuTg7ZIcbr05UxYdzmverQCzqjAf8QGonZ7mNFTGjhO3U2zN+sl81t3n87770S/R+V
         ojWw==
X-Forwarded-Encrypted: i=1; AJvYcCX0CGlI4Jw8o388zVmQ2mmVdiwE/95ez1qVR2L1Pa1OnI5DE8PzeF94VLgKQBGywgsCRhyV5Fy+aw0RuD1V+aTkROlD
X-Gm-Message-State: AOJu0YwuIoH+/04PhDgtQrnAVKQF75y6ZgTnwG3Y0agD7FlD8GCiHScV
	8ZW5EKvMbYjmKsIII67KYRnpZ0cB5MxSSloheabEcpcHbAM8xZw2KmV7qmqU3FI=
X-Google-Smtp-Source: AGHT+IFQ0EzdKYHmQwg+zZ/JUI4tnTmadz5hANlPNEhcpyyd7GKGUXhNuPpeaqnT9c/ZhEIbyMJApQ==
X-Received: by 2002:a05:620a:2942:b0:795:890c:3f57 with SMTP id af79cd13be357-79bb365483amr1078233385a.37.1718921962113;
        Thu, 20 Jun 2024 15:19:22 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:19cd::292:40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce91dc4esm17234085a.90.2024.06.20.15.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:19:21 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:19:19 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC net-next 4/9] bnxt: apply XDP offloading fixup when building skb
Message-ID: <f804c22ca168ec3aedb0ee754bfbee71764eb894.1718919473.git.yan@cloudflare.com>
References: <cover.1718919473.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718919473.git.yan@cloudflare.com>

Add a common point to transfer offloading info from XDP context to skb.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7dc00c0d8992..0036c4752f0d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2252,6 +2252,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			}
 		}
 	}
+
+	if (xdp_active)
+		xdp_buff_fixup_skb_offloading(&xdp, skb);
+
 	bnxt_deliver_skb(bp, bnapi, skb);
 	rc = 1;
 
-- 
2.30.2



