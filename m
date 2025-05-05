Return-Path: <bpf+bounces-57332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB8AA9001
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 11:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAE016D02A
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31C31F8EF6;
	Mon,  5 May 2025 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHmfe31S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958E14A4F9
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438524; cv=none; b=E9F+2eRgo0f5fVEJd6/UmW1sknnglMPAvROrFFOKOMR4pxtS0YXipZqS9Kkar+O3eqzU6vC80pPwWUYg3dZozP31c9RMSV8o5z2g/FR56fuHUZ05y5W3AmpFGPsljQLW6yLH2VAZN4VCayhhYX/TTBc018cNZ3aUtD7tt3gxNpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438524; c=relaxed/simple;
	bh=yORfCNhSfAcM9xy7swzF5iylm6vSVA2BvuUAujHHOcY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yn+sseRlh5lizrNJEJMIO2f3sdPCnbeqe599KX1YX3iJMPf84HRPTR1OiZpbq2jbQcr2A1QLuJ9fAq3D6zjRWW0HoDD90rDwS+87PwrUKJBgd4f+cF0PFc4HuiVa/AujS/MYOyaT1s9fwmFAMSYuJ1+m4CGvKTaa+u2/50QC5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHmfe31S; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso2889360f8f.2
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 02:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746438520; x=1747043320; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E63OdUyicXsMfjYrRoAWWrOJBpXc3MxlQCvJK5Uc+dU=;
        b=SHmfe31SwFZYWQh5e1f7o5KcJ3HqdJzsH0Ldy+d3Ntw3w5g/Xye6qbEFemTydt3CT5
         E3/MCLiCwKvAOVl/IqU0oe6rAppuFFHw5Q09DgqQ1JR55kd1bLLraOSarLTGSR9otQqF
         kkIJj4XOaHxtc38tl+94yT2STygkLVS7KBFZCbVkyOCZduOxoSMuMk/9hq/DH8qKLRaq
         /SV7wCQiX2bvhcOpTFuNIS1yxIkEGFBQ79iwUbXPPrz++l3hcxZyM9QDTR475yicB60B
         M+lr0LwUb8U45N6WGQ+5ovlgJDNE/deEnWJslTiAcfK12jxOoVKENCi+SKrCXijh8t4m
         Qc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746438520; x=1747043320;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E63OdUyicXsMfjYrRoAWWrOJBpXc3MxlQCvJK5Uc+dU=;
        b=OdPc0/IEYzG1gfOxj0hHMaYPILyDnHGzeNaygdjYr/Ouhfq6ppO3dXq8AH0/snSdCo
         UKdZZmOufHUmEIcUKqEb4f6iCh+KSKQQ0rryh/J2gIv1vGYi45hU3AZpYZLe0/u+2rlk
         EzqXB6SFr5Aa6a/NMBcsbZYgYG+UG4evb4Swjs5CQUVyYSvXrTRLg25sM8dT7XQNTHQh
         iu5OK2q57JSnipm0gJ6/K8VvXEFuZOG/l6wAslNOeLU7bk5Mk78c4nqJvEpFn6K5SNmd
         dnvuFaerfrdXA43Tm8csHtFPND1OKEZy5g3Cuf2Q2e34K/C33osXEG7BU/kFI4GwRssI
         Acew==
X-Gm-Message-State: AOJu0YwJnnbIkzeDql4moAn5V4wAFTEo0OCvVWXaegYkxpryMMq1CmrI
	klJxTzeikzcaVS6RTIBG1MAKDUKXAQ+KsTX/5hQOQFkpYFmdtWtN0YURWQTJ
X-Gm-Gg: ASbGncuOkjr7kQ6jNkKdh49f/xr5NTL6cymJhfdKSh1cKL66Bvg+uPCsGep+qq11t+R
	yMDjIoClI74OMpNJ5Pv9ikqLaV8d0CEbJS0cQwDvRo49CTdKGYDjLYuqz5LLSgXeLVOD184f1Qg
	eAfdYIvO4dhSW8omGwL+4tPQg3vx0KdvwluUMLniTtPQ9QaxU2BMqeKY21DYC5Y9PS272wgAput
	x9TvbUeGhrFBd/ZYgxtaONGVSU9YmFStYxutmr2Pvdut78xty6BkNidzZb2S5QCxrnnBZu7ha1/
	afum/yIeoKfeuJ5LvF67fbq/SdvtPoMd8oFDesM3nsH9UVlyEN3uhnfiu2edlBAGmvLzwqYu1It
	3KbBjIMm/HAuGwoQFB0vE9z9T0EME9Vih4M2lcw==
X-Google-Smtp-Source: AGHT+IEEMgrt9WPXrItZ21nJU5z2Xspl/IC0elpbqTkBPASHnAAyQZlSeoZwng1VUusQSyKL9hInWg==
X-Received: by 2002:a5d:64e8:0:b0:3a0:8c46:1763 with SMTP id ffacd0b85a97d-3a09ce29507mr5493375f8f.0.1746438519717;
        Mon, 05 May 2025 02:48:39 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00223db190461203d3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:223d:b190:4612:3d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae7a55sm9727593f8f.45.2025.05.05.02.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:48:38 -0700 (PDT)
Date: Mon, 5 May 2025 11:48:37 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf] bpf: Scrub packet on bpf_redirect_peer
Message-ID: <aBiJdTDs_YP0AYVb@mail.gmail.com>
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
devices.

Fixes: 9aa1206e8f482 ("bpf: Add redirect_peer helper")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 79cab4d78dc3..12b6b8dbeb51 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2509,6 +2509,7 @@ int skb_do_redirect(struct sk_buff *skb)
 			goto out_drop;
 		skb->dev = dev;
 		dev_sw_netstats_rx_add(dev, skb->len);
+		skb_scrub_packet(skb, true);
 		return -EAGAIN;
 	}
 	return flags & BPF_F_NEIGH ?
-- 
2.43.0


