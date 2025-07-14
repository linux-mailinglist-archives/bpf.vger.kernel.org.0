Return-Path: <bpf+bounces-63276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85223B04C8F
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 01:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10BD4A50EC
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 23:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D154277CBD;
	Mon, 14 Jul 2025 23:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UACVsaDk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB41DED40;
	Mon, 14 Jul 2025 23:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752537238; cv=none; b=GRklW7kx0CCqFNUq7M3h/CsifnePp8iM1S5+LZ+oJzOKFSS8k6LQaCEUpJu04rkMpiI17OnskR4j2Why99xM4nDsjStNC6PpZDKz3TJHPgZtgkp2IVR5PzDGJ68pDSnAKb1wJb4e5Oe5U0PJKBxaqGtdIIDg/YQXh/16O0xOFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752537238; c=relaxed/simple;
	bh=ITQ0xuQCps8t21CeJaQgW5vJ850xhROlZN0jU1cKPL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFur8v2B1YcXdbQk2eihrURBakNmfcBdCWCO3KBP0NOrIJIGBZ27k8atZR451ZQRVQUxaTXhSwufcWHNiZzzBT+gaYMGsWqd0YJzrE89TVkNhwZTbuTMPXs29bQZESP1spZJhmARztpkP9UU5Vij9jK8llvhh7xsSOngTBV8N18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UACVsaDk; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3dda399db09so42104465ab.3;
        Mon, 14 Jul 2025 16:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752537235; x=1753142035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUU8BDLmz9Ukc56OzweWizTQ6XT6rzOKMr0TMNdaBYE=;
        b=UACVsaDkf+dtXh2/XVWhZfThhlGPlzRYvJjvutk1Jh5NLBE11y3iCInVZK+J5Qslqk
         yqr6rAImjrGO7oMn+RbmijrQKkpICX6dAN/XuEFexOHSSXhosqtgvkbRSXipE74iuOjH
         8tfxUlJbfb39ouFKN8kGkZtOmuJl/vbywY6Ob/BBDFMZTbNjC/iQmrTcjZ4XUUEWZ2j2
         NTSFcDCr+nq/uMO54MTjcMZAVknunYWYA85KcB1yU+cXR+2g4zTHiuAvMcX1rSEhspYN
         ZKR4RwGtJiUrg9V8X0b/pWYDNFsdMWiu5d2LG26Vz+f6Sx3qR5BxTFzhACK6JjxWOR2o
         iuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752537235; x=1753142035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUU8BDLmz9Ukc56OzweWizTQ6XT6rzOKMr0TMNdaBYE=;
        b=WJ5IMldFFVYmgILVI7PUOkK5NEbTco2qlSAtm068dpwN0+MUVhoZmk/TKrZllTv0vy
         vBYVMkEhU9hntwLrQcxY52l7cY+Jc0DC/RQVpm7AGxUfLAQTe9WpZ+RVRyl7U+ThKUFa
         N8oH/hoX57CFiw44NLINA7NvflvMgehc1yZy07XoJOP03GI80ASyAUcE5jzlKR4Dve3l
         /Y6360Vd2jS3CQAnvja0cWrx1PjCS0AbdA4XIQICbd7NwLTKSAYDaJIzMtKTa84J6Isg
         IH58+z7K6OYfVKBe+Q3i5WP+C/7AICMP0du5j9bd25V6LEWffkLl1nK/IhPQg2L9u7PN
         +zTg==
X-Forwarded-Encrypted: i=1; AJvYcCUF3OvxxziMuDMoxNX4l3fRQRjvSpC+PMXUwHW2cnuqMZ/RA8WnuT0Eyrq4B9cuu0SnvZY=@vger.kernel.org, AJvYcCVE4AFsZk3ZNrQjpvPmUmvTzbaa82fnkxRfhQVbqu0e/BWHxZ+26waGckG7otynQGSePyaI5nG6@vger.kernel.org
X-Gm-Message-State: AOJu0YyZDbkVOAYxT8JOUDpj/jMM//PMIRAjKXyTUa83LXKAnIEgdXoG
	QxFOja626Yob4bG47Ruf1UVrjccsEf0qgkBQr5umtuLsFAS2PTtT+h2DRhAgthepGjdKPWy/Pss
	eFQZ6p5rt4fHsf801MDkoWTBG9Uk709Y=
X-Gm-Gg: ASbGncstTTHTnADvPH5rfLDFPTRBM7dDRgaRsHPlwn8Fhui39k3OLp5XOBWZfA0yQla
	7oS0lMcidgioDylk63OarP1cnKPHJ80MNpAx2zHJPEXthNzxCzV1xRGlzwZzuvcymtZSck26Jad
	GACYguRz3F+5q/Od5tZnKx/96y5HjMMQZJiRQZCIWS9QNQvK4QjiaM84WUFRIAEQNQwvXhkQGk4
	/tT09A=
X-Google-Smtp-Source: AGHT+IERGDT7yj54rz9oKoK7+gP8Bb2i/TeVhsBr1govz34Hz4J5xhgoFfgh/npmJ1om1NeBkETzIZtJRY4F94RSbWI=
X-Received: by 2002:a05:6e02:1a02:b0:3df:3464:ab86 with SMTP id
 e9e14a558f8ab-3e279196bd6mr6538365ab.9.1752537235382; Mon, 14 Jul 2025
 16:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713025756.24601-1-kerneljasonxing@gmail.com> <aHUqR5_NoU8BYbz5@mini-arch>
In-Reply-To: <aHUqR5_NoU8BYbz5@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 15 Jul 2025 07:53:19 +0800
X-Gm-Features: Ac12FXwUG92Fj-WyYfKGlq5tw9QRHpt-Y3yAJ7OPa0uNgHSprs6AhRL_uBKbd34
Message-ID: <CAL+tcoCiL0jjUO8RPiWX-+9VtjQm50ZeM5MQXn3Q6m+yNYryzQ@mail.gmail.com>
Subject: Re: [PATCH net-next] xsk: skip validating skb list in xmit path
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 12:03=E2=80=AFAM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 07/13, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > For xsk, it's not needed to validate and check the skb in
> > validate_xmit_skb_list() in copy mode because xsk_build_skb() doesn't
> > and doesn't need to prepare those requisites to validate. Xsk is just
> > responsible for delivering raw data from userspace to the driver.
>
> So the __dev_direct_xmit was taken out of af_packet in commit 865b03f2116=
2
> ("dev: packet: make packet_direct_xmit a common function"). And a call
> to validate_xmit_skb_list was added in 104ba78c9880 ("packet: on direct_x=
mit,
> limit tso and csum to supported devices") to support TSO. Since we don't
> support tso/vlan offloads in xsk_build_skb, removing validate_xmit_skb_li=
st
> seems fair.

Right, if you don't mind, I think I will copy&paste your words in the
next respin.

>
> Although, again, if you care about performance, why not use zerocopy
> mode?

I attached the performance impact because I'm working on the different
modes in xsk to see how it really behaves. You can take it as a kind
of investigation :)

I like zc mode, but the fact is that:
1) with ixgbe driver, my machine could totally lose connection as long
as the xsk tries to send packets. I'm still debugging it :(
2) some customers using virtio_net don't have a supported host, so
copy mode is the only one choice.

>
> > Skipping numerous checks somehow contributes to the transmission
> > especially in the extremely hot path.
> >
> > Performance-wise, I used './xdpsock -i enp2s0f0np0 -t  -S -s 64' to ver=
ify
> > the guess and then measured on the machine with ixgbe driver. It stably
> > goes up by 5.48%, which can be seen in the shown below:
> > Before:
> >  sock0@enp2s0f0np0:0 txonly xdp-skb
> >                    pps            pkts           1.00
> > rx                 0              0
> > tx                 1,187,410      3,513,536
> > After:
> >  sock0@enp2s0f0np0:0 txonly xdp-skb
> >                    pps            pkts           1.00
> > rx                 0              0
> > tx                 1,252,590      2,459,456
> >
> > This patch also removes total ~4% consumption which can be observed
> > by perf:
> > |--2.97%--validate_xmit_skb
> > |          |
> > |           --1.76%--netif_skb_features
> > |                     |
> > |                      --0.65%--skb_network_protocol
> > |
> > |--1.06%--validate_xmit_xfrm
>
> It is a bit surprising that mostly no-op validate_xmit_skb_list takes
> 4% of the cycles. netif_skb_features taking ~2%? Any idea why? Is
> it unoptimized kernel? Which driver is it?

No idea on this one, sorry. I tested with different drivers (like
i40e) and it turned out to be nearly the same result.

One of my machines looks like this:
# lspci -vv | grep -i ether
02:00.0 Ethernet controller: Intel Corporation Ethernet Controller
10-Gigabit X540-AT2 (rev 01)
02:00.1 Ethernet controller: Intel Corporation Ethernet Controller
10-Gigabit X540-AT2 (rev 01)
# lscpu
Architecture:                x86_64
  CPU op-mode(s):            32-bit, 64-bit
  Address sizes:             46 bits physical, 48 bits virtual
  Byte Order:                Little Endian
CPU(s):                      48
  On-line CPU(s) list:       0-47
Vendor ID:                   GenuineIntel
  BIOS Vendor ID:            Intel(R) Corporation
  Model name:                Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
    BIOS Model name:         Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
 CPU @ 2.3GHz
    BIOS CPU family:         179
    CPU family:              6
    Model:                   63
    Thread(s) per core:      2
    Core(s) per socket:      12
    Socket(s):               2
    Stepping:                2
    CPU(s) scaling MHz:      96%
    CPU max MHz:             3100.0000
    CPU min MHz:             1200.0000
    BogoMIPS:                4589.31
    Flags:                   fpu vme de pse tsc msr pae mce cx8 apic
sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss
ht tm pbe syscall nx pdpe1gb rdtscp lm constant_ts
                             c arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor
ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm p
                             cid dca sse4_1 sse4_2 x2apic movbe popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm cpuid_fault
epb intel_ppin ssbd ibrs ibpb stibp tpr_shadow fl
                             expriority ept vpid ept_ad fsgsbase
tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm xsaveopt cqm_llc
cqm_occup_llc dtherm ida arat pln pts vnmi md_clear flush_l
                             1d

>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/linux/netdevice.h |  4 ++--
> >  net/core/dev.c            | 10 ++++++----
> >  net/xdp/xsk.c             |  2 +-
> >  3 files changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index a80d21a14612..2df44c22406c 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -3351,7 +3351,7 @@ u16 dev_pick_tx_zero(struct net_device *dev, stru=
ct sk_buff *skb,
> >                    struct net_device *sb_dev);
> >
> >  int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
> > -int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
> > +int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id, bool validate=
);
> >
> >  static inline int dev_queue_xmit(struct sk_buff *skb)
> >  {
> > @@ -3368,7 +3368,7 @@ static inline int dev_direct_xmit(struct sk_buff =
*skb, u16 queue_id)
> >  {
> >       int ret;
> >
> > -     ret =3D __dev_direct_xmit(skb, queue_id);
> > +     ret =3D __dev_direct_xmit(skb, queue_id, true);
> >       if (!dev_xmit_complete(ret))
> >               kfree_skb(skb);
> >       return ret;
>
> Implementation wise, will it be better if we move a call to validate_xmit=
_skb_list
> from __dev_direct_xmit to dev_direct_xmit (and a few other callers of
> __dev_direct_xmit)? This will avoid the new flag.

__dev_direct_xmit() helper was developed to serve the xsk type a few
years ago. For now it has only two callers. If we expect to avoid a
new parameter, we will also move the dev check[1] as below to the
callers of __dev_direct_xmit(). Then move validate_xmit_skb_list to
__dev_direct_xmit(). It's not that concise, I assume? I'm not sure if
I miss your point.

[1]
if (unlikely(!netif_running(dev) ||  !netif_carrier_ok(dev)))
        goto drop;

Thanks,
Jason

