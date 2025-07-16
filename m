Return-Path: <bpf+bounces-63489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5BEB07FC8
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 23:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE414A76C2
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 21:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054E82ECD28;
	Wed, 16 Jul 2025 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl01ZQwF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B232EBDFA;
	Wed, 16 Jul 2025 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702025; cv=none; b=Wq6cgEirB7P9icPUOO7iWd7o75nvOcBgLGjGZB/teN4X55cUFOCz1K03IbSqMvM/A5ckLFL7wpZJP6HG9s0gLB4+uAhetJ0qrAURiRr7y3OLWdSqi29mTXGlRz9R0lfcM9gtRDOV+Il/cHjSnBSTfIILNwJsxZD5OIuJXo/Ok+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702025; c=relaxed/simple;
	bh=ZlKXfQv455yg91YrsmtFsEljBkL9R/uXQYppK9PyBqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRpE/O7GZXR7WJ7BHiZ7P5be355pWtz7qqkJrDyWdMyjRO//HAhE28ON8CRXwbSHjny1OVkjmLpRE7i9SHnsCj8xQJuVaE05iA9qAu9jyToCicLRmaF0re0p+fGu7ik3grI+ZChJruT/YOrOv/tC6BUMjvk3qSk1yt5AdVzZa+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl01ZQwF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235e1d710d8so3020285ad.1;
        Wed, 16 Jul 2025 14:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752702023; x=1753306823; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jf2IPw4ijfiVlfOH/gDqjYUtFOByqKxDfpSusFOJE5M=;
        b=Nl01ZQwFbXgZgtHy0f+nV5c3J7gjaAwschD+Ap/7A2gFOF3vkD/YxS9F0d2CBPUomy
         U5hyRtgFOj582p8b9v1NMvTpshxlqUfDeTAVQe2zSnEtgMui5vfNu2OtpAfLkHohISoy
         1DznsmXH4mMGcS8tNlYSzGzgCf8829CrVQWkmm3sQl3DWvkpujLmvj3t69nR4bduz1Y4
         nJPkGEUt+krmC6SF23dvo6PWgfIxmTwn3b1XPvLheG4JA3lFwiXoKuDtmtMZLvSljFEA
         Xul8yGAAegzjGqdJ8v0G3Z74mKzJ8LY4ruG9LmxwdX5/fHJ36yK3B5bMAWpBOLa6nEfS
         /Blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752702023; x=1753306823;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jf2IPw4ijfiVlfOH/gDqjYUtFOByqKxDfpSusFOJE5M=;
        b=S61mR9xYGd7TFmXMUYosxKNFieQpqLbR39W5ZqEQc3H3YgVTncmWebaJqPv6Y16TQ2
         1/OXeIYrCK6JrWpTxikSRzXSwo5M0zOYm7l45voiXRwfaafubKgIhkfd5ohNpyzjQiZx
         LPKw7nSEz0+8hvxDyDaKqGLQHCk9Or8tyvS/Rxjzw5kV8K1WjsO2BcqfDT8jqCGKirUN
         8tr6AbjdoQnSRmkZi10sWiJzMCsKg3O5PK/iCuk1xes2JUZRw+nLdeuH3Hbp6bQqDAGl
         jQF3dpRtbVwcuhB5WCRXuBKEE65KQ9PDLanqlwOXIEI9Qgf4UcBz8/mZekKgkQUmida5
         im4A==
X-Forwarded-Encrypted: i=1; AJvYcCUBIlvd0/u7oLMZ62wGVVxkQjZQeVg9+NFDAi1NUGgm0BmS9cpAh3WgVUAyQUwGiOMxpZoCcdC5@vger.kernel.org, AJvYcCVxeHvSeRQonMKo7uDK+lwrAslfqNA9FeMNQgWUNw5Wrtq02tsb0tM86f8HTeh19Jxl0Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuzOKxtxhZJRmG33CcIlbe6e4Lfg98o6Roft3+KxWZkgVPsUAX
	QfkKkigkprrEfvh/fbEPt/2UXvBFYntSuTCg+BuFhqf2ADM/tIATW0Y=
X-Gm-Gg: ASbGnct+CXvNn3xATYgM79vvLscHjpzhDD27IBcTIbdlqigwT1eieYp1m1xwmc209XU
	TeCn5mmdLZ/4+ytO4JgGFpUTXwegOcJl+WDao7i3Zn7mUwn4kniA7sIqWt68qB1p0hwl1eabcu1
	vFPTvSGbj9U6L1m87XNHXSEt/NaBBmWrcxKit4iYMQLMkN642b9CjzFlE0PHd0WEt4oE3Ym/rNH
	A4JnfwzjVKQf8yjYB5HiS/kEDjvzo7xUsj/0EKlJac8ICxAu7zk0EbHIchhz4RjAaVTseqt2eY8
	AZPUPO6+dcVslz67jj48LEmSf8t+IgChFGxsxsmNqwUeeGXp91yTnwnQJOortRIu2xaAxiZow4M
	F4t6Tmgw2SXybyxkfyb2VatgPBHg7vOIOydycklLexh+ItTi349B8nWZC8J0=
X-Google-Smtp-Source: AGHT+IFtGTYkr9O4B9r3TY1kvPNxEriQiSRehhpcXf2CO+G8ACiij6/axdJFHi7Jyb95yHmO00Vk0Q==
X-Received: by 2002:a17:903:2ac7:b0:235:779:edfe with SMTP id d9443c01a7336-23e3035fd75mr7875935ad.43.1752702022721;
        Wed, 16 Jul 2025 14:40:22 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de4322cd2sm128113005ad.99.2025.07.16.14.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 14:40:22 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:40:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] xsk: skip validating skb list in xmit path
Message-ID: <aHgcRdp8xKIIB7Q_@mini-arch>
References: <20250713025756.24601-1-kerneljasonxing@gmail.com>
 <aHUqR5_NoU8BYbz5@mini-arch>
 <CAL+tcoCiL0jjUO8RPiWX-+9VtjQm50ZeM5MQXn3Q6m+yNYryzQ@mail.gmail.com>
 <aHa9qLUtD3nR3Xl7@mini-arch>
 <CAL+tcoB1aBsB5EtgnrPg-t4CebU2ZFFDp8L-9DjRTeOuYGQ-GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoB1aBsB5EtgnrPg-t4CebU2ZFFDp8L-9DjRTeOuYGQ-GQ@mail.gmail.com>

On 07/16, Jason Xing wrote:
> On Wed, Jul 16, 2025 at 4:44 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 07/15, Jason Xing wrote:
> > > On Tue, Jul 15, 2025 at 12:03 AM Stanislav Fomichev
> > > <stfomichev@gmail.com> wrote:
> > > >
> > > > On 07/13, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > For xsk, it's not needed to validate and check the skb in
> > > > > validate_xmit_skb_list() in copy mode because xsk_build_skb() doesn't
> > > > > and doesn't need to prepare those requisites to validate. Xsk is just
> > > > > responsible for delivering raw data from userspace to the driver.
> > > >
> > > > So the __dev_direct_xmit was taken out of af_packet in commit 865b03f21162
> > > > ("dev: packet: make packet_direct_xmit a common function"). And a call
> > > > to validate_xmit_skb_list was added in 104ba78c9880 ("packet: on direct_xmit,
> > > > limit tso and csum to supported devices") to support TSO. Since we don't
> > > > support tso/vlan offloads in xsk_build_skb, removing validate_xmit_skb_list
> > > > seems fair.
> > >
> > > Right, if you don't mind, I think I will copy&paste your words in the
> > > next respin.
> > >
> > > >
> > > > Although, again, if you care about performance, why not use zerocopy
> > > > mode?
> > >
> > > I attached the performance impact because I'm working on the different
> > > modes in xsk to see how it really behaves. You can take it as a kind
> > > of investigation :)
> > >
> > > I like zc mode, but the fact is that:
> > > 1) with ixgbe driver, my machine could totally lose connection as long
> > > as the xsk tries to send packets. I'm still debugging it :(
> > > 2) some customers using virtio_net don't have a supported host, so
> > > copy mode is the only one choice.
> > >
> > > >
> > > > > Skipping numerous checks somehow contributes to the transmission
> > > > > especially in the extremely hot path.
> > > > >
> > > > > Performance-wise, I used './xdpsock -i enp2s0f0np0 -t  -S -s 64' to verify
> > > > > the guess and then measured on the machine with ixgbe driver. It stably
> > > > > goes up by 5.48%, which can be seen in the shown below:
> > > > > Before:
> > > > >  sock0@enp2s0f0np0:0 txonly xdp-skb
> > > > >                    pps            pkts           1.00
> > > > > rx                 0              0
> > > > > tx                 1,187,410      3,513,536
> > > > > After:
> > > > >  sock0@enp2s0f0np0:0 txonly xdp-skb
> > > > >                    pps            pkts           1.00
> > > > > rx                 0              0
> > > > > tx                 1,252,590      2,459,456
> > > > >
> > > > > This patch also removes total ~4% consumption which can be observed
> > > > > by perf:
> > > > > |--2.97%--validate_xmit_skb
> > > > > |          |
> > > > > |           --1.76%--netif_skb_features
> > > > > |                     |
> > > > > |                      --0.65%--skb_network_protocol
> > > > > |
> > > > > |--1.06%--validate_xmit_xfrm
> > > >
> > > > It is a bit surprising that mostly no-op validate_xmit_skb_list takes
> > > > 4% of the cycles. netif_skb_features taking ~2%? Any idea why? Is
> > > > it unoptimized kernel? Which driver is it?
> > >
> > > No idea on this one, sorry. I tested with different drivers (like
> > > i40e) and it turned out to be nearly the same result.
> >
> > I was trying to follow validate_xmit_skb_list, but too many things
> > happen in there. Although, without gso/vlan, most of these should
> > be no-op. Plus you have xfrm compiled in. So still surprising, let's see
> > if other people have any suggestions.
> >
> > > One of my machines looks like this:
> > > # lspci -vv | grep -i ether
> > > 02:00.0 Ethernet controller: Intel Corporation Ethernet Controller
> > > 10-Gigabit X540-AT2 (rev 01)
> > > 02:00.1 Ethernet controller: Intel Corporation Ethernet Controller
> > > 10-Gigabit X540-AT2 (rev 01)
> > > # lscpu
> > > Architecture:                x86_64
> > >   CPU op-mode(s):            32-bit, 64-bit
> > >   Address sizes:             46 bits physical, 48 bits virtual
> > >   Byte Order:                Little Endian
> > > CPU(s):                      48
> > >   On-line CPU(s) list:       0-47
> > > Vendor ID:                   GenuineIntel
> > >   BIOS Vendor ID:            Intel(R) Corporation
> > >   Model name:                Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
> > >     BIOS Model name:         Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
> > >  CPU @ 2.3GHz
> > >     BIOS CPU family:         179
> > >     CPU family:              6
> > >     Model:                   63
> > >     Thread(s) per core:      2
> > >     Core(s) per socket:      12
> > >     Socket(s):               2
> > >     Stepping:                2
> > >     CPU(s) scaling MHz:      96%
> > >     CPU max MHz:             3100.0000
> > >     CPU min MHz:             1200.0000
> > >     BogoMIPS:                4589.31
> > >     Flags:                   fpu vme de pse tsc msr pae mce cx8 apic
> > > sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss
> > > ht tm pbe syscall nx pdpe1gb rdtscp lm constant_ts
> > >                              c arch_perfmon pebs bts rep_good nopl
> > > xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor
> > > ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm p
> > >                              cid dca sse4_1 sse4_2 x2apic movbe popcnt
> > > tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm cpuid_fault
> > > epb intel_ppin ssbd ibrs ibpb stibp tpr_shadow fl
> > >                              expriority ept vpid ept_ad fsgsbase
> > > tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm xsaveopt cqm_llc
> > > cqm_occup_llc dtherm ida arat pln pts vnmi md_clear flush_l
> > >                              1d
> > >
> > > >
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  include/linux/netdevice.h |  4 ++--
> > > > >  net/core/dev.c            | 10 ++++++----
> > > > >  net/xdp/xsk.c             |  2 +-
> > > > >  3 files changed, 9 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > > > index a80d21a14612..2df44c22406c 100644
> > > > > --- a/include/linux/netdevice.h
> > > > > +++ b/include/linux/netdevice.h
> > > > > @@ -3351,7 +3351,7 @@ u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
> > > > >                    struct net_device *sb_dev);
> > > > >
> > > > >  int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
> > > > > -int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
> > > > > +int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id, bool validate);
> > > > >
> > > > >  static inline int dev_queue_xmit(struct sk_buff *skb)
> > > > >  {
> > > > > @@ -3368,7 +3368,7 @@ static inline int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
> > > > >  {
> > > > >       int ret;
> > > > >
> > > > > -     ret = __dev_direct_xmit(skb, queue_id);
> > > > > +     ret = __dev_direct_xmit(skb, queue_id, true);
> > > > >       if (!dev_xmit_complete(ret))
> > > > >               kfree_skb(skb);
> > > > >       return ret;
> > > >
> > > > Implementation wise, will it be better if we move a call to validate_xmit_skb_list
> > > > from __dev_direct_xmit to dev_direct_xmit (and a few other callers of
> > > > __dev_direct_xmit)? This will avoid the new flag.
> > >
> > > __dev_direct_xmit() helper was developed to serve the xsk type a few
> > > years ago. For now it has only two callers. If we expect to avoid a
> > > new parameter, we will also move the dev check[1] as below to the
> > > callers of __dev_direct_xmit(). Then move validate_xmit_skb_list to
> > > __dev_direct_xmit(). It's not that concise, I assume? I'm not sure if
> > > I miss your point.
> > >
> > > [1]
> > > if (unlikely(!netif_running(dev) ||  !netif_carrier_ok(dev)))
> > >         goto drop;
> >
> > We can keep the check in its original place. I don't think the order of
> > the checks matters? I was thinking something along these (untested)
> > lines. Avoids one conditional in each path (not that it matters)..
> 
> Sorry, in my point of view, one additional flag is really not a big
> deal even though it is on the hot path. A new flag doesn't cause any

[..]

> side effects at all, does it? On the contrary, running on top of the
> following code snippet, if the netdevice is down, dev_direct_xmit()
> will take a lot of time to run validate_xmit_skb_list() before two
> simple device if-statements.

Not sure that's worth optimizing (unless someone actively complains). We want
to send the packets fast, not drop them fast :-)

