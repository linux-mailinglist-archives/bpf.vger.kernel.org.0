Return-Path: <bpf+bounces-58747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E78AC13D9
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 21:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D74B27A6C3D
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 19:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D033263F54;
	Thu, 22 May 2025 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2CGHVcw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59BF1531F0
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940484; cv=none; b=lgXbrLbOiS8GEVJkbmk5fNzc46c3xol+GljlbquON6RlP721laPpr0C4PXhRMnV7BtF8Oxk6DxIa/6ajhL58kZLjPw816UbVLF+B3UtQkaAu289EYP0+/Bzp+5nSwwnpp6+wXoy2vP75OlOiLVVmZj2oeFq4bFNIxfBtW/NBPj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940484; c=relaxed/simple;
	bh=QL63/14Z2ejJzUGRfMCnYgCXwESLliE3tJMMBSXs4Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgJ9v8UdW4uHOK8pQZG8X+Tz+Nz3wb+2UReu3+Gbq55O7eYc7abIorNKV50bc/E/a2CwOpgC3bjDNeMEL254XiHRgnISxEKj7j+nBfelSoKWdCdAHTbd/i6sA+lLhYlg3rFJhdK4hPPTsOVPVahIU2nw/fxXiz3DD3eEQY1pX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2CGHVcw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-442ea341570so59234725e9.1
        for <bpf@vger.kernel.org>; Thu, 22 May 2025 12:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747940481; x=1748545281; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dB99o1i1UB/MpXcrjjScPufVrI6RYvcZzJt4BbuOT4Q=;
        b=d2CGHVcw9nNIccpg9noUTAhwwzclUSH69ib/tjN8Szkhv+kFKLBvjbNYVi2RC0+wm7
         FsouWG2nsYDl3lOAjv+E4fBokHWtTud467PYsATVDEASjOvlIzr/QVrkzshnlyRGSA2T
         qk07loS1yKhkFHEhx7OoyedkhJU9195TodtZC9lP6vEaNcF0xWDSr7JSHbxhG1cQuOl7
         Ba4aAONfTGMgBBZY8YtQe5qEAyncAVFJe8ZH4WRd9VdM2ujgqePwMw3rQXivE7N0Ni4G
         GOtPJR2Y2mfYcUgTUpzUncPl7C9oYO9xppouwZP5LtLlCejc4hdP6xw17cPANVSQpcCg
         aiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747940481; x=1748545281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dB99o1i1UB/MpXcrjjScPufVrI6RYvcZzJt4BbuOT4Q=;
        b=YwNZU522BvDGBImLsPfE+hOhQfzIunAERCx3Ag9mBpi3JwmsT1eck5d1CnvpsMgDrA
         qAB7uq/DbNx9tNg3Y975HecnbJtOBhiufN+Iil0++LG9/hAD+fncjBqJGYm/WD+N2CLk
         /n3dMWXrkPGieLz2NeNmehoOf2ZcxqKrFgkZQbl4EeBIku9vZ8609MGfwAN9Xkol++sC
         5etXtU+XCwK6YDwlEc5kMZuYEVzshWONjtWO+4DMuHCFpyoVqlc5NnegVo5WjUKBn/hL
         4AD28a+Twv4880pZHfXHRogmhk5xlaJjUS6AmVbc8ACl7JoYDahmTAYzet1HbjA2WRRZ
         /w7g==
X-Gm-Message-State: AOJu0Yy20BhDdMGyyGofOH/XWnZr8FXVlhka1HHdgqiSh3EnfObwDkq/
	edU17X4DAK6N37vB8h2GLAqIVZqGV9hr3OFXz51vQGOEZSVnzpxuXQMx
X-Gm-Gg: ASbGncshBf4NMk67c1tBql0iq88y/N95lc7UD8vW7TrU5tofJUIFq2A8GvffCvUnbqG
	8jsk8UF/IUzWCQtvcQOiKbEaFMgalOvM3feJPhXQQPFJjVdyM4JAMxghAW3c0/V/BHnwZ3PQkLs
	aNmL7wM472P+4jA72ydR9A3c564rS7JwLRWXL0WePQ8uOFhoUvO4HUNPtG+Oov4tM4xCYhYT5IL
	f7yaPxOGTnsaqvw2nD993F+A3u3HNoDuruyzXK/YHped0Zpesfc20UNRnHWVxl2Xe27jQQGxMIi
	LWEL+xlRQtop0sMIVXXFVg6dsuwP4Cn17OqMJixAubLSdic3pvSAxeifh3vEAXZKtcNES0NdzYA
	td9PXRq7r/etLBSX00ti9Q991ADzo48XOJ/OfOa2e93sFtqd8
X-Google-Smtp-Source: AGHT+IHOVdSVTO63wYgQFoXO8jv00lueIexkc9b5YNP2CJKyH5xZXwf7zX0zU434iGyusubT4HQrbg==
X-Received: by 2002:a05:600c:3f05:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-442feff018fmr246420755e9.12.1747940480320;
        Thu, 22 May 2025 12:01:20 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d4b1263894d80d05.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d4b1:2638:94d8:d05])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5bd8asm24481422f8f.33.2025.05.22.12.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 12:01:19 -0700 (PDT)
Date: Thu, 22 May 2025 21:01:17 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [RFC PATCH bpf-next] bpf: Support L4 csum update for IPv6
 address changes
Message-ID: <aC90ffX6vpTPH5_F@mail.gmail.com>
References: <aCz84JU60wd8etiT@mail.gmail.com>
 <CAADnVQL8zB_aC8hDDBVuW30mSwc1pu2=04yMiiOfZSZFcEgQEQ@mail.gmail.com>
 <aC5DamQVPviBmNe5@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aC5DamQVPviBmNe5@mail.gmail.com>

On Wed, May 21, 2025 at 11:19:41PM +0200, Paul Chaignon wrote:
> On Tue, May 20, 2025 at 06:07:15PM -0700, Alexei Starovoitov wrote:
> > On Tue, May 20, 2025 at 3:06 PM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> > >
> > > In Cilium, we use bpf_csum_diff + bpf_l4_csum_replace to, among other
> > > things, update the L4 checksum after reverse SNATing IPv6 packets. That
> > > use case is however not currently supported and leads to invalid
> > > skb->csum values in some cases. This patch adds support for IPv6 address
> > > changes in bpf_l4_csum_update via a new flag.
> > >
> > > When calling bpf_l4_csum_replace in Cilium, it ends up calling
> > > inet_proto_csum_replace_by_diff:
> > >
> > >     1:  void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
> > >     2:                                       __wsum diff, bool pseudohdr)
> > >     3:  {
> > >     4:      if (skb->ip_summed != CHECKSUM_PARTIAL) {
> > >     5:          csum_replace_by_diff(sum, diff);
> > >     6:          if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr)
> > >     7:              skb->csum = ~csum_sub(diff, skb->csum);
> > >     8:      } else if (pseudohdr) {
> > >     9:          *sum = ~csum_fold(csum_add(diff, csum_unfold(*sum)));
> > >     10:     }
> > >     11: }
> > >
> > > The bug happens when we're in the CHECKSUM_COMPLETE state. We've just
> > > updated one of the IPv6 addresses. The helper now updates the L4 header
> > > checksum on line 5. Next, it updates skb->csum on line 7. It shouldn't.
> > >
> > > For an IPv6 packet, the updates of the IPv6 address and of the L4
> > > checksum will cancel each other. The checksums are set such that
> > > computing a checksum over the packet including its checksum will result
> > > in a sum of 0. So the same is true here when we update the L4 checksum
> > > on line 5. We'll update it as to cancel the previous IPv6 address
> > > update. Hence skb->csum should remain untouched in this case.
> > 
> > Is ILA broken then?
> > net/ipv6/ila/ila_common.c is using
> > inet_proto_csum_replace_by_diff()
> > 
> > or is it simply doing it differently?
> 
> As far as I can tell, yes, it's affected by the same issue. Maybe nobody
> noticed because 1) it only happens for CHECKSUM_COMPLETE and 2) only the
> adj-transport checksum mode for ILA is affected. That mode doesn't look
> covered in selftests and isn't the one recommended to users.
> 
> With ILA also affected, maybe passing the IPv6 flag to
> inet_proto_csum_replace_by_diff is a better solution. That way we could
> keep using csum_diff + l4_csum_replace.

I was able to reproduce the bug locally on an ILA setup with
adj-transport checksum mode. The tricky part was ensuring
inet_proto_csum_replace_by_diff is called while we're in
CHECKSUM_COMPLETE state, but I imagine that's easier with a proper NIC
doing checksum offload on a server.

Configuration on the target:

$ ip a show dev eth0
14: eth0@if15: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 62:ae:35:9e:0f:8d brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet6 3333:0:0:1::e952/64 scope global 
       valid_lft forever preferred_lft forever
    inet6 fd00:10:244:2::e952/128 scope global nodad 
       valid_lft forever preferred_lft forever
    inet6 fe80::60ae:35ff:fe9e:f8d/64 scope link proto kernel_ll 
       valid_lft forever preferred_lft forever
$ ip ila add loc_match fd00:10:244:2 loc 3333:0:0:1 csum-mode adj-transport ident-type luid dev eth0

Then I hit [fd00:10:244:2::e952]:8000 with a server listening only on
[3333:0:0:1::e952]:8000. With the bug, the SYN packet is dropped with
SKB_DROP_REASON_TCP_CSUM after inet_proto_csum_replace_by_diff changed
skb->csum. pwru trace:

  IFACE   TUPLE                                                        FUNC
  eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  ipv6_rcv
  eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  ip6_rcv_core
  eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  nf_hook_slow
  eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  inet_proto_csum_replace_by_diff
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     tcp_v6_early_demux
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_route_input
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_input
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_input_finish
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_protocol_deliver_rcu
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     raw6_local_deliver
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ipv6_raw_deliver
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     tcp_v6_rcv
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     __skb_checksum_complete
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     kfree_skb_reason(SKB_DROP_REASON_TCP_CSUM)
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_release_head_state
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_release_data
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_free_head
  eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     kfree_skbmem

With the fix, I can see inet_proto_csum_replace_by_diff is not touching
skb->csum and I get a SYN+ACK (after which it fails since I didn't
configure the whole ILA setup).

I'll send a patchset to fix both the ILA and BPF sides. Not sure which
tree I should send it to though?


