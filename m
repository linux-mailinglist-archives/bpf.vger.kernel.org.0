Return-Path: <bpf+bounces-26996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 817E88A720A
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 19:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2021F22B1D
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12461327EB;
	Tue, 16 Apr 2024 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZWeydN0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9010A22;
	Tue, 16 Apr 2024 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287778; cv=none; b=YCDjJViQYHSYRtDjUe3Iy+U3kG5n6sfddAPgVTrnehSnHBDPE4wYaaoicPA5ITVZTOTYkStJRjiMPdJy435O3mAry3rxq5Ycyd/AhOj8iS4z6of1+za90+iWvSa9rxd0qdV85aYRysW64RErKPspx1hNcvLmMvDMBTCYmo8rf8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287778; c=relaxed/simple;
	bh=n8ReTsBrzbzNDM1bJ3Y4vBVNowqFrcc47uei46T090c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Nm18AvkOnv5IyByrbhcfn6T+R4MKm15trfJkJjb85eVjgGsvpqAvqkCCe2ZOAXcyCEmw4SmRraBRur1L9D4X/vtreSPuFngTdlsETvPazNYCQBZLRSRUmbGBxTGokoT99WjAQKRwRv356ByISZaaY1RSXiH4a2o9mCgvqkKtPS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZWeydN0; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b628c4893so30152086d6.0;
        Tue, 16 Apr 2024 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713287775; x=1713892575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co8MQgeNISibKFBhSCSTMbwBrtJNLOcf4lbHRGmAXfM=;
        b=AZWeydN0kLQVaD2US1MQEzvnObBkRNcyQa61KPG59EPd7YH6Pw4pBT8e2IhUCHL+Nt
         FXKIZyS6zuPoY+KijN6x2IUSE2g7lHGob9t/MR6ReTUMmoJucpCK8gDuCLP8DjWeiQpg
         FzmvV7MbPhDj0s/BgA710ieMyqYN0lpoFJ6BHi/z8st+nKNF5H5q9iWZiqCo39t/3vCB
         9F+g7iP0RO+z9BGLJnHjm5lxLxfGJR1e0LsSoF9yWo95W0wKERrckeLJ9ZmKlCWcQzN5
         F7JltRmoaiiy1DGByyfdhG3jSrhX4k59xIN2a8noIRfoy+wxamVCfjFXc9vVw51syZqf
         Pl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713287775; x=1713892575;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Co8MQgeNISibKFBhSCSTMbwBrtJNLOcf4lbHRGmAXfM=;
        b=q8DCEaclGrRPxLCK2SwiS94D42Hc2L4CMdv3zrmoaIweOaShazayZyuLhZVta7d/BI
         p/z4/4OXgw6cnY3Ylnv/vGlRADHVIzVRbaYXQTX776uYssB58AOiSMwv++jl2TrYiafh
         ZqkJwwPXyQrTtkcloMKBhvzQ5FpQ1G9X8HyuJVOKJDom/Vdqw/Lzc1IZVOfcUzyXJJ1e
         yXc9uPo4QY4vPhhxpys60+6EolKMIwIRg6LA61USwrLWEesx7jgmhRPdfRa+SMi3QDMA
         Qcf7BcZjZhwUT3ccUAsJyev9vSXKROS/jMRTDb2iIMZ9cALAgGbrCEXL4iF6tiMMFRkO
         lOOw==
X-Forwarded-Encrypted: i=1; AJvYcCW2Rc3RhYK1TTDQf1JJK6Cm3FjF/DtqW8z4s5V5whY6wO1EZSNyszaIIzSmXcnEz2+QW9glM8wSYfkGwlkJLPnAPHF5c4rY5GYinUfXnIw/jQLvOf55Cn4Qhw7hw2p5px6PxCNdMKHJHMd9SM4cWS5zm2u/tB/jitOx
X-Gm-Message-State: AOJu0Yy/8SusXuHfwtu789g52nYii4b4FEt/xSV0Ko8aJbs04HvQnY9B
	16piSKh6vSSFmiTduYbB3awsGryzqY+JmYWSwhpeMgowRuNIdSVvgN/LTQ==
X-Google-Smtp-Source: AGHT+IHdhwAdbRDc7XWvejV6sTR5Qi5OKow9KLGF18VdknwADqTT0s97nwXOELds6Bz8pfx6VKAxbw==
X-Received: by 2002:ad4:57d3:0:b0:6a0:439a:7f46 with SMTP id y19-20020ad457d3000000b006a0439a7f46mr15965qvx.27.1713287775530;
        Tue, 16 Apr 2024 10:16:15 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id w25-20020a0ca819000000b0069945cef316sm7531060qva.144.2024.04.16.10.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:16:15 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:16:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TWFjaWVqIMW7ZW5jenlrb3dza2k=?= <maze@google.com>, 
 =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Cc: "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 bpf <bpf@vger.kernel.org>
Message-ID: <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch>
 <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
 <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej =C5=BBenczykowski wrote:
> On Mon, Apr 15, 2024 at 7:14=E2=80=AFPM Lena Wang (=E7=8E=8B=E5=A8=9C) =
<Lena.Wang@mediatek.com> wrote:
> >
> > On Mon, 2024-04-15 at 16:53 -0400, Willem de Bruijn wrote:
> > >
> > > External email : Please do not click links or open attachments unti=
l
> > > you have verified the sender or the content.
> > >  shiming.cheng@ wrote:
> > > > From: Shiming Cheng <shiming.cheng@mediatek.com>
> > > >
> > > > A GRO packet without fraglist is crashed and backtrace is as belo=
w:
> > > >  [ 1100.812205][    C3] CPU: 3 PID: 0 Comm: swapper/3 Tainted:
> > > > G        W  OE      6.6.17-android15-0-g380371ea9bf1 #1
> > > >  [ 1100.812317][    C3]  __udp_gso_segment+0x298/0x4d4
> > > >  [ 1100.812335][    C3]  __skb_gso_segment+0xc4/0x120
> > > >  [ 1100.812339][    C3]  udp_rcv_segment+0x50/0x134
> > > >  [ 1100.812344][    C3]  udp_queue_rcv_skb+0x74/0x114
> > > >  [ 1100.812348][    C3]  udp_unicast_rcv_skb+0x94/0xac
> > > >  [ 1100.812358][    C3]  udp_rcv+0x20/0x30
> > > >
> > > > The reason that the packet loses its fraglist is that in ingress
> > > bpf
> > > > it makes a test pull with to make sure it can read packet headers=

> > > > via direct packet access: In bpf_progs/offload.c
> > > > try_make_writable -> bpf_skb_pull_data -> pskb_may_pull ->
> > > > __pskb_pull_tail  This operation pull the data in fraglist into
> > > linear
> > > > and set the fraglist to null.
> > >
> > > What is the right behavior from BPF with regard to SKB_GSO_FRAGLIST=

> > > skbs?
> > >
> > > Some, like SCTP, cannot be linearized ever, as the do not have a
> > > single gso_size.
> > >
> > > Should this BPF operation just fail?
> > >
> > In most situation for big gso size packet, it indeed fails but BPF
> > doesn't check the result. It seems the udp GRO packet can't be pulled=
/
> > trimed/condensed or else it can't be segmented correctly.
> >
> > As the BPF function comments it doesn't matter if the data pull faile=
d
> > or pull less. It just does a blind best effort pull.
> >
> > A patch to modify bpf pull length is upstreamed to Google before and
> > below are part of Google BPF expert maze's reply:
> > maze@google.com<maze@google.com> #5Apr 13, 2024 02:30AM
> > I *think* if that patch fixes anything, then it's really proving that=

> > there's a bug in the kernel that needs to be fixed instead.
> > It should be legal to call try_make_writable(skb, X) with *any* value=

> > of X.
> >
> > I add maze in loop and we could start more discussion here.
> =

> Personally, I think bpf_skb_pull_data() should have automatically
> (ie. in kernel code) reduced how much it pulls so that it would pull
> headers only,

That would be a helper that parses headers to discover header length.
Parsing is better left to the BPF program.

> and not packet content.
> (This is assuming the rest of the code isn't ready to deal with a longe=
r pull,
> which I think is the case atm.  Pulling too much, and then crashing or =
forcing
> the stack to drop packets because of them being malformed seems wrong..=
.)
> =

> In general it would be nice if there was a way to just say pull all hea=
ders...
> (or possibly all L2/L3/L4 headers)
> You in general need to pull stuff *before* you've even looked at the pa=
cket,
> so that you can look at the packet,
> so it's relatively hard/annoying to pull the correct length from bpf
> code itself.
> =

> > > > BPF needs to modify a proper length to do pull data. However kern=
el
> > > > should also improve the flow to avoid crash from a bpf function
> > > call.
> > > > As there is no split flow and app may not decode the merged UDP
> > > packet,
> > > > we should drop the packet without fraglist in skb_segment_list
> > > here.
> > > >
> > > > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> > > > Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> > > > Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> > > > ---
> > > >  net/core/skbuff.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > index b99127712e67..f68f2679b086 100644
> > > > --- a/net/core/skbuff.c
> > > > +++ b/net/core/skbuff.c
> > > > @@ -4504,6 +4504,9 @@ struct sk_buff *skb_segment_list(struct
> > > sk_buff *skb,
> > > >  if (err)
> > > >  goto err_linearize;
> > > >
> > > > +if (!list_skb)
> > > > +goto err_linearize;
> > > > +

This would catch the case where the entire data frag_list is
linearized, but not a pskb_may_pull that only pulls in part of the
list.

Even with BPF being privileged, the kernel should not crash if BPF
pulls a FRAGLIST GSO skb.

But the check needs to be refined a bit. For a UDP GSO packet, I
think gso_size is still valid, so if the head_skb length does not
match gso_size, it has been messed with and should be dropped.

For a GSO_BY_FRAGS skb, there is no single gso_size, and this pull
may be entirely undetectable as long as frag_list !=3D NULL?


> > > >  skb_shinfo(skb)->frag_list =3D NULL;
> > >
> > > In absense of plugging the issue in BPF, dropping here is the best
> > > we can do indeed, I think.
> > >
> =

> --
> Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google



