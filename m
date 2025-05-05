Return-Path: <bpf+bounces-57367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A734CAA9CE7
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A763AD22B
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 19:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C8725D90D;
	Mon,  5 May 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLUNr0mY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EDE19C546
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746475091; cv=none; b=gB8HEPjQEEnXc5U/6w9kGa6EkBvK3kEDOMDYcuE6cBYiEU1rURKHANst5iECydOU5hQ4tswXsdit4ekqy2chTrTdeH6SEmjRbRsquOkuUvGpY0Vt9ih3NpvIFyw1owLn6m5w+pgjbQhYw1YE6ZGxZR5nFpWG4rGt8IgIXe5otcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746475091; c=relaxed/simple;
	bh=8lhoHRHIR9QEHJ0ir14R1L//AG98F6ZXGiFHjcnbCPo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VVpAZmqeHnT4zdnj8rsl50uKzaYV19OBdSvmD2/OPDtAgGvfUaaciRLecoJwD3YsQ848zDPnpebZGatPYPYv9wJYmrwgETJn+dHZZpDMNHoLAup//NbhuTrfdxV98lKp/+Q4yfvizsoRAZ2074K1s9g/GOMgKmnie2IAGu2btY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLUNr0mY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so5881452f8f.1
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 12:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746475088; x=1747079888; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X19rq+FvizN6RJmzrdD+7e+qZaFckt1yJp+p0a7PtYo=;
        b=hLUNr0mYmZIGqWsHsfgh0BWyJmXwJEDBt9nUzyoaoJT5pXPNCfSwXu5/DR8MDsPjxv
         O6t8HdroPYXm/NyZaHy+qEvc76MEicGlMc2Unvw/zLYPMGQaZvp3PnfFo3veTj+3BUJU
         O1s/Q/HQDQfiEeias+VJ7nNTnHlGWoGSWaIcQFD6pySK903kCivy2JitlDqzfMGv8R07
         WaaL4dRgqK2AjYXSGYlTMUgP1FeVuyltgdCLB8W6a5eBE8ezgZwYFbTPWloWPQD7YdBM
         4fgbGndsnOH9HuFVr3DfjHGYeev9gwEyUzNEa5K6gLDKwSJgtpQUp4TTSyCC4cpoZBAY
         oKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746475088; x=1747079888;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X19rq+FvizN6RJmzrdD+7e+qZaFckt1yJp+p0a7PtYo=;
        b=Rrk8zRmC1Ovo/LWpCfSMRRoyYH9NCNlJy2IZOcVFLJLfiVZMFSHstyTLMRAQa2e31r
         G4VJ6GKITs1soTvnvBCwoBIoa/HTbN8WORNNWANVq3PsuqB5iL/+g7aZezEvLFT2sddY
         Ha7Fg93IU6OozERVl1yeBDlha5HsvMpGnYmJYnYpXykAlkVhkWIvfbNaho2f29zwGuXG
         +2ubsiG5ndsGUJXNEUOazgMif//yFUrEAVHJh1ereK9ClK/64jR5TDPPXtT9YUw31ptD
         ykjAqtiY7BOh34F8P4Xu3nLnEdkhqAmdKv+NC5xPCMI5xMJaz5VnLnb00Y2w3Wdd6Zbd
         cdSQ==
X-Gm-Message-State: AOJu0YwFPVx7QR+cykVXdfX22vc4EvtOGiq82+7px3XlogxNjtwAzZ/P
	gQmIjtk4TFJFBrB3RgbkBezNuQ/+4y0C0D2r2dsMy4JtP1yx4me8qKsSDc5Z
X-Gm-Gg: ASbGncv7jBEXmfYRDiJ89Vu3wy65bjezguvTJ+FQDJfb3O28dG8ns2jHuhOrqOpjVTD
	bY7eqLJ70QqYrCI3fZNgkbwOJHd4BJnCjWKQIhF8Gi4IzXZYHwIuXzM56dHi+v8AXQSRWZ8HP3I
	aVOknVIs/J81CaQu/nq1V+JLpbiEUvX8o00UPI70IenOv3dwVattjl6vt2BP14pnBbhxESZH3gJ
	6k5hGFDm87Gn67RgjC8XtedVEjFgGu+/52OykVLL5Fxliz8aROlTzoZ+HjlT3z0lQFVjyIwXmbu
	DhXPU4vGga8REWJT5TDYe9rEmEsvDCZH7xExCGRq4a8Kq2cqem+oCHV9ydXuWYOBQ3Snqs8Q3OC
	HdpTbD8VJSQ8egxUdOx4rLwtHa/IcyO18mujzrQ==
X-Google-Smtp-Source: AGHT+IEP7HAWrSKXG4ZpWq8Yuyt3VFHShL5tUT3hPrWxfX6uHr3XgPm3kna8MprqrfEO3Q756/x2OA==
X-Received: by 2002:a5d:588b:0:b0:38d:d371:e04d with SMTP id ffacd0b85a97d-3a09fd9b1c5mr6102488f8f.34.1746475087461;
        Mon, 05 May 2025 12:58:07 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0001c990b81d371cc8.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1c9:90b8:1d37:1cc8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0c25sm11450722f8f.17.2025.05.05.12.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:58:06 -0700 (PDT)
Date: Mon, 5 May 2025 21:58:04 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v2 1/2] bpf: Scrub packet on bpf_redirect_peer
Message-ID: <1728ead5e0fe45e7a6542c36bd4e3ca07a73b7d6.1746460653.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When bpf_redirect_peer is used to redirect packets to a device in
another network namespace, the skb isn't scrubbed. That can lead skb
information from one namespace to be "misused" in another namespace.

As one example, this is causing Cilium to drop traffic when using
bpf_redirect_peer to redirect packets that just went through IPsec
decryption to a container namespace. The following pwru trace shows (1)
the packet path from the host's XFRM layer to the container's XFRM
layer where it's dropped and (2) the number of active skb extensions at
each function.

    NETNS       MARK  IFACE  TUPLE                                FUNC
    4026533547  d00   eth0   10.244.3.124:35473->10.244.2.158:53  xfrm_rcv_cb
                             .active_extensions = (__u8)2,
    4026533547  d00   eth0   10.244.3.124:35473->10.244.2.158:53  xfrm4_rcv_cb
                             .active_extensions = (__u8)2,
    4026533547  d00   eth0   10.244.3.124:35473->10.244.2.158:53  gro_cells_receive
                             .active_extensions = (__u8)2,
    [...]
    4026533547  0     eth0   10.244.3.124:35473->10.244.2.158:53  skb_do_redirect
                             .active_extensions = (__u8)2,
    4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  ip_rcv
                             .active_extensions = (__u8)2,
    4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  ip_rcv_core
                             .active_extensions = (__u8)2,
    [...]
    4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  udp_queue_rcv_one_skb
                             .active_extensions = (__u8)2,
    4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  __xfrm_policy_check
                             .active_extensions = (__u8)2,
    4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  __xfrm_decode_session
                             .active_extensions = (__u8)2,
    4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  security_xfrm_decode_session
                             .active_extensions = (__u8)2,
    4026534999  0     eth0   10.244.3.124:35473->10.244.2.158:53  kfree_skb_reason(SKB_DROP_REASON_XFRM_POLICY)
                             .active_extensions = (__u8)2,

In this case, there are no XFRM policies in the container's network
namespace so the drop is unexpected. When we decrypt the IPsec packet,
the XFRM state used for decryption is set in the skb extensions. This
information is preserved across the netns switch. When we reach the
XFRM policy check in the container's netns, __xfrm_policy_check drops
the packet with LINUX_MIB_XFRMINNOPOLS because a (container-side) XFRM
policy can't be found that matches the (host-side) XFRM state used for
decryption.

This patch fixes this by scrubbing the packet when using
bpf_redirect_peer, as is done on typical netns switches via veth
devices except skb->mark and skb->tstamp are not zeroed.

Fixes: 9aa1206e8f482 ("bpf: Add redirect_peer helper")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v2:
  - Avoid scrubbing skb->mark and skb->tstamp as suggested by Daniel
    because existing applications may already use those.
  - Add second commit to note the above in the helper's description.

 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 79cab4d78dc3..577a4504e26f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2509,6 +2509,7 @@ int skb_do_redirect(struct sk_buff *skb)
 			goto out_drop;
 		skb->dev = dev;
 		dev_sw_netstats_rx_add(dev, skb->len);
+		skb_scrub_packet(skb, false);
 		return -EAGAIN;
 	}
 	return flags & BPF_F_NEIGH ?
-- 
2.43.0


