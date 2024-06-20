Return-Path: <bpf+bounces-32650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E948391158E
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 00:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4CA1F22FA6
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 22:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583E91534FC;
	Thu, 20 Jun 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BKkMeEDe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F5F1527A5
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921967; cv=none; b=MD5KTtqKpz2JpmBzRtAVHyU5+gsIosLV7G3W29QREHMXM8lWFE6KTLHocC/bOcz9BNlSDVnob+CywEs1SeEM5sTxQujqse3WVoM8XF7XKHaZi4mtXh4S7aYpx7xkSm1/BPiuj8PWzDnva5lVYiBYqCF7/tOBcnJkPLetjkW4kPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921967; c=relaxed/simple;
	bh=F57HceSCarSUFFP4CorQ7f5+Hq22MkL63tl52DzITRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaDEU/Ds4cwTnIunohx5aoy8AhJ1bIeKTTpskcRAyHhXC18YJmUDE7akSnKjDDXllejI+JDUUV0wTTHZ1JqW/4cN8xibCiHOpjfOxaRpD+oava4+7CBrrv1yd//WR1Ax3cZAeLESE5k2mXHn/x9ddl54pWYOUp4TJZnbXUV2E1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BKkMeEDe; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7955dc86cacso85705485a.0
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 15:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718921965; x=1719526765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uOnJGiRbyO/FJXIIwBJKoyy1x0jsuLmmE0P/5OKn6WU=;
        b=BKkMeEDe7+4ayjUJrfnivzyhNx+umSzTdrk3ImQu+QVT4HrhuFKv4PUjgZJaLZjV2V
         JTE9hQUdz3McVLjtB/WNfSon7c65gxdYZCUtjgsIlzAO9CjOLLbfMQyMBQm9XsU9cdzX
         5jyq9WcLRfGDdtOvFzXddrNNHYI6l1GkuTQp/ol6L8Hicv73Bh2pgCnQbU9CK2pxq6de
         Ny5BFoPf1epzyBvB6jyZF+i7niXBGl6RNgZnKKGV8wsEm+rXczaWFGffmiZesG5kS37Z
         QkzihWbu14QgW6smkCBy8SsAwDH+lS9x6mOjYYE3ncqdNKTjBdz0b7/ofoTxxvxBKOHW
         JklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921965; x=1719526765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOnJGiRbyO/FJXIIwBJKoyy1x0jsuLmmE0P/5OKn6WU=;
        b=oeD09+ORSG7iSwBXsicwlV0V5H2UklS65FT7SHzFlZA3lwfML1LIc/7ECYKgp+35HY
         bPaz3AA2oWoK08wc46mbJ36VyAy9CauhLKh33+DPXw+F6tSsZLPKq6EsuU5KhYd8vdeA
         qLIiyzo90CwwM9Bc9DQxAdWnDAAb4OSv9FvLXZG1aoY6eJ14d2W2jQuIG85ZDbnfNQDO
         +LsBpsvpsO+8+VaeHoCRlSqxL2weuiry+5Ns43VVEuO5XHT1nwysZBZjuefb5frgdNZl
         bwTy7lIZvlCV+luPMA9jP4uMhSgU6W9C/otDWyccwqH83x+Gn0TU4ZuTfA4oM3Zluth+
         edrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwuB8071+GI/k31y3IuWYp8u6+gKczdDHPifg4MIANSkf9YBiLOL4cUb0WEmQo1cWdrsQnxM8wuWVlqCNlF2dSaWeF
X-Gm-Message-State: AOJu0Yy6fkeT7vOhGz5ADRRGJgL+rA0Nec5E0F0UxvLqcellIgj+C3Hz
	I+F5zHXFqvCPbWHxx55jHSjZ9dUUpLDApyG1tli/kFj0/dBMlvMM63XGLsStTic=
X-Google-Smtp-Source: AGHT+IF9DmzujCRKuDPqvcTpHJ5tK40LwVxagHzuDnQcW/zjLbmWI370fRf/NDqGQdzoIWlhSdGjVw==
X-Received: by 2002:a0c:db83:0:b0:6b0:4542:e42e with SMTP id 6a1803df08f44-6b501e3f5a3mr78560556d6.28.1718921965457;
        Thu, 20 Jun 2024 15:19:25 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:19cd::292:40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed7ed94sm813456d6.73.2024.06.20.15.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:19:24 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:19:22 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC net-next 5/9] ice: apply XDP offloading fixup when building skb
Message-ID: <a9eba425bfd3bfac7e7be38fe86ad5dbff3ae01f.1718919473.git.yan@cloudflare.com>
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
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 ++
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 6 +++++-
 include/net/xdp_sock_drv.h                | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 8bb743f78fcb..a247306837ed 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1222,6 +1222,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 			hard_start = page_address(rx_buf->page) + rx_buf->page_offset -
 				     offset;
+			xdp_init_buff_minimal(xdp);
 			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
 #if (PAGE_SIZE > 4096)
 			/* At larger PAGE_SIZE, frame_sz depend on len size */
@@ -1287,6 +1288,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 		/* populate checksum, VLAN, and protocol */
 		ice_process_skb_fields(rx_ring, rx_desc, skb);
+		xdp_buff_fixup_skb_offloading(xdp, skb);
 
 		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
 		/* send completed skb up the stack */
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index a65955eb23c0..367658acaab8 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -845,8 +845,10 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	xdp_ring = rx_ring->xdp_ring;
 
-	if (ntc != rx_ring->first_desc)
+	if (ntc != rx_ring->first_desc) {
 		first = *ice_xdp_buf(rx_ring, rx_ring->first_desc);
+		xdp_init_buff_minimal(first);
+	}
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
 		union ice_32b_rx_flex_desc *rx_desc;
@@ -920,6 +922,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 			break;
 		}
 
+		xdp = first;
 		first = NULL;
 		rx_ring->first_desc = ntc;
 
@@ -934,6 +937,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 		vlan_tci = ice_get_vlan_tci(rx_desc);
 
 		ice_process_skb_fields(rx_ring, rx_desc, skb);
+		xdp_buff_fixup_skb_offloading(xdp, skb);
 		ice_receive_skb(rx_ring, skb, vlan_tci);
 	}
 
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 0a5dca2b2b3f..02243dc064c2 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -181,7 +181,7 @@ static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
 	xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
 	xdp->data_meta = xdp->data;
 	xdp->data_end = xdp->data + size;
-	xdp->flags = 0;
+	xdp_init_buff_minimal(xdp);
 }
 
 static inline dma_addr_t xsk_buff_raw_get_dma(struct xsk_buff_pool *pool,
-- 
2.30.2



