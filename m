Return-Path: <bpf+bounces-63363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74422B067E2
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 22:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F4E7AB16C
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 20:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5A5274B29;
	Tue, 15 Jul 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/870+Z8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDBC1FDA9E;
	Tue, 15 Jul 2025 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612268; cv=none; b=juUJ9XSjNbWcYrzl1pPIMXR3lWeUyl0xJ6WWIGeJd1hV2W2KZ/dw9ebs/1TKuM9yUwhdZNitNXyeew1aXQ6P62JNtLkHqb1KVm43NKzy32ueldQZ6st/gwXABRENmbIFugs9EsuxWmAOy3bFYCsH6Y0PZQA7Sv+XRFeZAK3EmlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612268; c=relaxed/simple;
	bh=+NHg7CpVR6QykgY6wGysAsan+dQhwgyVX7dBSu3u22M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbzXNXQ6b0Hzx9DlFD9m04dwO5GydQ8Jg4EM+61ut1atCoo6cscVB3bhx9PBM5JYk6EIjj0jKB6T1yCLm7+IWKq1+/5efwZar2O4L9VUftauX0I1VYH/dOhdO6P2K5BN+gJ6d4i5sJnJ0roxNSvNT8FlMI7G2W/T0isY+K4MzUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/870+Z8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-237e6963f63so35443355ad.2;
        Tue, 15 Jul 2025 13:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752612266; x=1753217066; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J40PrKy/s+BZm+RMAnLvAV2lySSbc6BKDGO6tf6c1gw=;
        b=I/870+Z8bGIaWpHyLJJMvyrT4oQr2fzXTDlcnpec85ltDvU69ARGIWQSibVxq2xtcV
         HCUR3oGGxCssjEL7ZIkaPxg+1ApPu+BGucjksisTcZPzszJJdUMAwWIf7V3aF8TWX2iZ
         u5ltofOF6DM+zFzq23u4aW1+DWOWZOr6YedJwXxMZrXZplyKuGxwtzt3N9eouj7zA2ZK
         OesCkyVpiAhwfE4ZWBl3t08kR4GFXxhLmANUnkl/mreTSsohmnc+a7B6WXqf6b21QPZH
         7MxWxdp4tktgzucuNXUV/a2H/tuxIpTgmzO44HXcrDa/6fRk+VWHRGUlQr7SqN/7+gvw
         zg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752612266; x=1753217066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J40PrKy/s+BZm+RMAnLvAV2lySSbc6BKDGO6tf6c1gw=;
        b=JRF/c+p6kSn5noiASZB1XdzCiSVln58wxuysJ25KL8fFNcoq6JPvj5KETKxX0OLwez
         aM9oTQMnX3c+ieqH0TxH8MfVVgAfPO2jywaaC9J0dlhyJ+CDPfi+RB+yDhwe8dyXdc5p
         rsWk5+GpZTBkbkpOE87jks+ar+Hf8B8bo+e88Bu6NxDxNynY6P7kN/qMPxIv768aQSEY
         apu+w9pTu6YKl+PCk7nHCyY1ZXzxVm7D7dBIP+OthQx2wlxrJtnje3qyO+AEPGqnW/NF
         H4xE/uBc0pTvmlavC4LYxAGQNFAmm67xEHxgW+WJsozcoykPvzYMSY6kyMsfcXh6k75G
         Lbdw==
X-Forwarded-Encrypted: i=1; AJvYcCUOdmoBYpg0jUh7DTqcEofH6h3duV3KlhagLfuqK3IbybSpcKWkR6cNUiNEAy8FkP8uC/7C68mE@vger.kernel.org, AJvYcCWKcpWlW56+dypoNrrJcM/aI0KKl9tf9gww7nwhTkPar201B2IAbA2D0uAOs/j2D6z7CYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqJZfiC50HVWC8gRqJMRMsN0Toru0tl8FZPe8NS+gXSGAMeZ/q
	cpwRNUZ9Bt/hXQ3NMtMZXPrWi0yGv3YvChpIBN2OIgDVtd1/a3NEuBw=
X-Gm-Gg: ASbGncuppEtzcI8FQDfoNHHB+hkoLLthfRegv+0/aO/RipihHi/YnhZT5QrvVA/+4xl
	x0Uk6tWpHr2w5BP2Tusf3wtSXqOvtlpyn/e7y6M44tb5ULNpGeFoO3FxZBnkoM504zY/Jafd9yn
	nUXeSgLQkyJyMAzi3bmsWuhyZLEgUflPwdHlaXkKGdvQsNf9Jr9nKQd/z3AtzZWwKFw/kq0wOrZ
	ewcSrcws1c40U/LktMbUpi2baf2MmPb4B2qSrzEyva5CAR8tLhmFMC/EHMbK+klVZpWMcX+iB/A
	cxlgEPD5JWMTuKxudIY7cSvRLOZJRXM6mVnJg6NJkgQw3otDf5LOHMPMxocCM2VUQI88swWgU6H
	Gm+X0UBNG3z52G/A/2QkeD9u1ixq4yHsSuHz3Sctbs2FvUg0F7Tl9y/rEE9k=
X-Google-Smtp-Source: AGHT+IEw+IuhNNp/R17WWY4jBseF2i+zKm/TbYLLe+93CS8X5A6pd+qUBNVgfPAU7wiKzXr6bvuW8A==
X-Received: by 2002:a17:903:ace:b0:234:d7b2:2ac4 with SMTP id d9443c01a7336-23e256b5f75mr2579005ad.17.1752612265803;
        Tue, 15 Jul 2025 13:44:25 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31c9f1ba67csm41666a91.8.2025.07.15.13.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:44:25 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:44:24 -0700
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
Message-ID: <aHa9qLUtD3nR3Xl7@mini-arch>
References: <20250713025756.24601-1-kerneljasonxing@gmail.com>
 <aHUqR5_NoU8BYbz5@mini-arch>
 <CAL+tcoCiL0jjUO8RPiWX-+9VtjQm50ZeM5MQXn3Q6m+yNYryzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCiL0jjUO8RPiWX-+9VtjQm50ZeM5MQXn3Q6m+yNYryzQ@mail.gmail.com>

On 07/15, Jason Xing wrote:
> On Tue, Jul 15, 2025 at 12:03 AM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
> >
> > On 07/13, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > For xsk, it's not needed to validate and check the skb in
> > > validate_xmit_skb_list() in copy mode because xsk_build_skb() doesn't
> > > and doesn't need to prepare those requisites to validate. Xsk is just
> > > responsible for delivering raw data from userspace to the driver.
> >
> > So the __dev_direct_xmit was taken out of af_packet in commit 865b03f21162
> > ("dev: packet: make packet_direct_xmit a common function"). And a call
> > to validate_xmit_skb_list was added in 104ba78c9880 ("packet: on direct_xmit,
> > limit tso and csum to supported devices") to support TSO. Since we don't
> > support tso/vlan offloads in xsk_build_skb, removing validate_xmit_skb_list
> > seems fair.
> 
> Right, if you don't mind, I think I will copy&paste your words in the
> next respin.
> 
> >
> > Although, again, if you care about performance, why not use zerocopy
> > mode?
> 
> I attached the performance impact because I'm working on the different
> modes in xsk to see how it really behaves. You can take it as a kind
> of investigation :)
> 
> I like zc mode, but the fact is that:
> 1) with ixgbe driver, my machine could totally lose connection as long
> as the xsk tries to send packets. I'm still debugging it :(
> 2) some customers using virtio_net don't have a supported host, so
> copy mode is the only one choice.
> 
> >
> > > Skipping numerous checks somehow contributes to the transmission
> > > especially in the extremely hot path.
> > >
> > > Performance-wise, I used './xdpsock -i enp2s0f0np0 -t  -S -s 64' to verify
> > > the guess and then measured on the machine with ixgbe driver. It stably
> > > goes up by 5.48%, which can be seen in the shown below:
> > > Before:
> > >  sock0@enp2s0f0np0:0 txonly xdp-skb
> > >                    pps            pkts           1.00
> > > rx                 0              0
> > > tx                 1,187,410      3,513,536
> > > After:
> > >  sock0@enp2s0f0np0:0 txonly xdp-skb
> > >                    pps            pkts           1.00
> > > rx                 0              0
> > > tx                 1,252,590      2,459,456
> > >
> > > This patch also removes total ~4% consumption which can be observed
> > > by perf:
> > > |--2.97%--validate_xmit_skb
> > > |          |
> > > |           --1.76%--netif_skb_features
> > > |                     |
> > > |                      --0.65%--skb_network_protocol
> > > |
> > > |--1.06%--validate_xmit_xfrm
> >
> > It is a bit surprising that mostly no-op validate_xmit_skb_list takes
> > 4% of the cycles. netif_skb_features taking ~2%? Any idea why? Is
> > it unoptimized kernel? Which driver is it?
> 
> No idea on this one, sorry. I tested with different drivers (like
> i40e) and it turned out to be nearly the same result.

I was trying to follow validate_xmit_skb_list, but too many things
happen in there. Although, without gso/vlan, most of these should
be no-op. Plus you have xfrm compiled in. So still surprising, let's see
if other people have any suggestions.

> One of my machines looks like this:
> # lspci -vv | grep -i ether
> 02:00.0 Ethernet controller: Intel Corporation Ethernet Controller
> 10-Gigabit X540-AT2 (rev 01)
> 02:00.1 Ethernet controller: Intel Corporation Ethernet Controller
> 10-Gigabit X540-AT2 (rev 01)
> # lscpu
> Architecture:                x86_64
>   CPU op-mode(s):            32-bit, 64-bit
>   Address sizes:             46 bits physical, 48 bits virtual
>   Byte Order:                Little Endian
> CPU(s):                      48
>   On-line CPU(s) list:       0-47
> Vendor ID:                   GenuineIntel
>   BIOS Vendor ID:            Intel(R) Corporation
>   Model name:                Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
>     BIOS Model name:         Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
>  CPU @ 2.3GHz
>     BIOS CPU family:         179
>     CPU family:              6
>     Model:                   63
>     Thread(s) per core:      2
>     Core(s) per socket:      12
>     Socket(s):               2
>     Stepping:                2
>     CPU(s) scaling MHz:      96%
>     CPU max MHz:             3100.0000
>     CPU min MHz:             1200.0000
>     BogoMIPS:                4589.31
>     Flags:                   fpu vme de pse tsc msr pae mce cx8 apic
> sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss
> ht tm pbe syscall nx pdpe1gb rdtscp lm constant_ts
>                              c arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor
> ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm p
>                              cid dca sse4_1 sse4_2 x2apic movbe popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm cpuid_fault
> epb intel_ppin ssbd ibrs ibpb stibp tpr_shadow fl
>                              expriority ept vpid ept_ad fsgsbase
> tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm xsaveopt cqm_llc
> cqm_occup_llc dtherm ida arat pln pts vnmi md_clear flush_l
>                              1d
> 
> >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  include/linux/netdevice.h |  4 ++--
> > >  net/core/dev.c            | 10 ++++++----
> > >  net/xdp/xsk.c             |  2 +-
> > >  3 files changed, 9 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index a80d21a14612..2df44c22406c 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -3351,7 +3351,7 @@ u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
> > >                    struct net_device *sb_dev);
> > >
> > >  int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
> > > -int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
> > > +int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id, bool validate);
> > >
> > >  static inline int dev_queue_xmit(struct sk_buff *skb)
> > >  {
> > > @@ -3368,7 +3368,7 @@ static inline int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
> > >  {
> > >       int ret;
> > >
> > > -     ret = __dev_direct_xmit(skb, queue_id);
> > > +     ret = __dev_direct_xmit(skb, queue_id, true);
> > >       if (!dev_xmit_complete(ret))
> > >               kfree_skb(skb);
> > >       return ret;
> >
> > Implementation wise, will it be better if we move a call to validate_xmit_skb_list
> > from __dev_direct_xmit to dev_direct_xmit (and a few other callers of
> > __dev_direct_xmit)? This will avoid the new flag.
> 
> __dev_direct_xmit() helper was developed to serve the xsk type a few
> years ago. For now it has only two callers. If we expect to avoid a
> new parameter, we will also move the dev check[1] as below to the
> callers of __dev_direct_xmit(). Then move validate_xmit_skb_list to
> __dev_direct_xmit(). It's not that concise, I assume? I'm not sure if
> I miss your point.
> 
> [1]
> if (unlikely(!netif_running(dev) ||  !netif_carrier_ok(dev)))
>         goto drop;

We can keep the check in its original place. I don't think the order of
the checks matters? I was thinking something along these (untested)
lines. Avoids one conditional in each path (not that it matters)..

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e6131c529af4..36cdeef6a5e9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3367,8 +3367,15 @@ static inline int dev_queue_xmit_accel(struct sk_buff *skb,
 
 static inline int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 {
+	struct sk_buff *orig_skb = skb;
+	bool again = false;
 	int ret;
 
+	skb = validate_xmit_skb_list(skb, dev, &again);
+	if (skb != orig_skb) {
+		/* dropped_inc and kfree */
+	}
+
 	ret = __dev_direct_xmit(skb, queue_id);
 	if (!dev_xmit_complete(ret))
 		kfree_skb(skb);
diff --git a/net/core/dev.c b/net/core/dev.c
index 26253802f6cd..d3b9a75852fd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4744,19 +4744,13 @@ EXPORT_SYMBOL(__dev_queue_xmit);
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 {
 	struct net_device *dev = skb->dev;
-	struct sk_buff *orig_skb = skb;
 	struct netdev_queue *txq;
 	int ret = NETDEV_TX_BUSY;
-	bool again = false;
 
 	if (unlikely(!netif_running(dev) ||
 		     !netif_carrier_ok(dev)))
 		goto drop;
 
-	skb = validate_xmit_skb_list(skb, dev, &again);
-	if (skb != orig_skb)
-		goto drop;
-
 	skb_set_queue_mapping(skb, queue_id);
 	txq = skb_get_tx_queue(dev, skb);
 

