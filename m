Return-Path: <bpf+bounces-27012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 176B98A787B
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 01:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 716C4B20C9D
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 23:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481AA13A86B;
	Tue, 16 Apr 2024 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nyqi2uS+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8E14AEE9;
	Tue, 16 Apr 2024 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309283; cv=none; b=m3IGXiZqUi3ZoN+d4v2R/EFHt3LyfaOISo+YeXyLo6aKHZl66hJuwmoqrmtJNofKtLC+TmS0OFoaKwWLRiVUgWyc+4WmwfP1stVCg89WGUsWtZQvPkUqSVJ5JGTixVNukGQAxwdz/Zo64l3q0Tu9H7jae99rKQhJEO9F+0BqGAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309283; c=relaxed/simple;
	bh=Sw2FFGAUztuJzFb3aL9I8gL4fK/+KtIu9O7CvmghvDg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uyxfaw4GsUS6T2ynvs+AlEAOiMaXYqndINziyQSN59VXvqeA1tYqczbPKlb8zWQdj6AB8skV35Acnl8CN1DtdK7+EmMlKTwtCIIS2FBHAn2b0raoT5gEVaPVrmIXTOkJp3bfSPkukbRVy3+43wLFrDyQyZ945M7+i+aJMSYizBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nyqi2uS+; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4375b8b4997so4271571cf.2;
        Tue, 16 Apr 2024 16:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713309281; x=1713914081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjNK5/6z8Zr/0UT33xznjKY1QmMGq1le/CtfMG5Gbxc=;
        b=Nyqi2uS+ZdLv2TXSmKC1amxx09asVwwuB5kS6LtYSwrXFXKr2AsmBYpwmp0BTxusk0
         ZWGeLHY5xj11qb0vk55KEJ2KPPAP1Qk8Gd37ovvhxszqG/WiYDcxPnMopCl5y6PmHGlT
         w2PB47iY80BTCH9Vjo6QNnL1pVWhwi7260ib3rQhVJ5gMdnMRhwjiDBnbSiWSm72l/U1
         MjQ7leEl/DuFNvi1N2X8EK1P0DawlwGah/+FV7np6tG1uvWn5BDR7DhhwvfAGFV4dVA7
         uhky5bN3qR2oCHPW6hcKJpAWPsKQ8jLB9Kj8PdC8qSv2UsSFbzbuKXfR6GkRkoDXnAr8
         b8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713309281; x=1713914081;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GjNK5/6z8Zr/0UT33xznjKY1QmMGq1le/CtfMG5Gbxc=;
        b=G83XzBD7GQS74cr2hWyRLuDLlvlh3R0/BIguH2ZVbeGj1bQBpCk5uaw5xfA9wdCmhQ
         8IU/XrEVbKlAXqacpfibcBHRbJufXiAmSN4AkC7ShwA7HWOMo/GV5byS6e3OG7A/VTxm
         fvNL3j0rzjrspYm7J4tajmIO7kpOQaWLmEOTnzA08QYo1Ixg/iW+BoJob/agxz2o+44L
         y5WUlYN7VtX+8sNsmW4+85JJRDYl0bwdEl7ReNSMXPkIpfubY9m2RkScodjPUZhYK8Xd
         ftOaYHpdvd3rQpaXkBpBCkd1bc3GFzeylZSdwUjeqEan/ROOL+FTHnUQ9NB9TWQKjvhr
         MVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVNmJjD9e5cyfrV03Ejzh7yVtqBw1nFor2qmiaN9P2/yukKaHi4FdpqwIC0ykz2dDuo7gf3OzQB33RIp+PFb34o0uosUiDAdA8GWOpjqvYy0Ye8O6QqZIJCoQdOZFyhzw4UHVi71JkzpprUSvEaKN4qhyOIj1uV8AK
X-Gm-Message-State: AOJu0YyqrWUPvk34B0cAMtog3ce2Yk/3Yed6vT/gSAY89lebuDZwpV8e
	SXldA2G0lqyP3LzHImXe20BszNHsbu9E9O9fFfiuYnAjwDW4bldp
X-Google-Smtp-Source: AGHT+IF58hOX1WlS/m/syvGeLvfJyg5HoIcXnbUOYIlvT8hb89D+rk8llmqyodBgUfwWnLvSzUPwkg==
X-Received: by 2002:a05:622a:507:b0:434:3358:8990 with SMTP id l7-20020a05622a050700b0043433588990mr19527861qtx.21.1713309281086;
        Tue, 16 Apr 2024 16:14:41 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id a19-20020a05622a065300b004367cc4ab01sm6711814qtb.15.2024.04.16.16.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:14:40 -0700 (PDT)
Date: Tue, 16 Apr 2024 19:14:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TWFjaWVqIMW7ZW5jenlrb3dza2k=?= <maze@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 bpf <bpf@vger.kernel.org>
Message-ID: <661f066060ab4_7a39f2945d@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANP3RGd+Zd-bx6S-NzeGch_crRK2w0-u6xwSVn71M581uCp9cQ@mail.gmail.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch>
 <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
 <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
 <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch>
 <CANP3RGdrRDERiPFVQ1nZYVtopErjqOQ72qQ_+ijGQiL7bTtcLQ@mail.gmail.com>
 <CANP3RGd+Zd-bx6S-NzeGch_crRK2w0-u6xwSVn71M581uCp9cQ@mail.gmail.com>
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

> > > > Personally, I think bpf_skb_pull_data() should have automatically=

> > > > (ie. in kernel code) reduced how much it pulls so that it would p=
ull
> > > > headers only,
> > >
> > > That would be a helper that parses headers to discover header lengt=
h.
> >
> > Does it actually need to?  Presumably the bpf pull function could
> > notice that it is
> > a packet flagged as being of type X (UDP GSO FRAGLIST) and reduce the=
 pull
> > accordingly so that it doesn't pull anything from the non-linear
> > fraglist portion???
> >
> > I know only the generic overview of what udp gso is, not any details,=
 so I am
> > assuming here that there's some sort of guarantee to how these packet=
s
> > are structured...  But I imagine there must be or we wouldn't be hitt=
ing these
> > issues deeper in the stack?
> =

> Perhaps for a packet of this type we're already guaranteed the headers
> are in the linear portion,
> and the pull should simply be ignored?
> =

> >
> > > Parsing is better left to the BPF program.

I do prefer adding sanity checks to the BPF helpers, over having to
add then in the net hot path only to protect against dangerous BPF
programs.

In this case, it would be detecting this GSO type and failing the
operation if exceeding skb_headlen().
> > >
> > > > and not packet content.
> > > > (This is assuming the rest of the code isn't ready to deal with a=
 longer pull,
> > > > which I think is the case atm.  Pulling too much, and then crashi=
ng or forcing
> > > > the stack to drop packets because of them being malformed seems w=
rong...)
> > > >
> > > > In general it would be nice if there was a way to just say pull a=
ll headers...
> > > > (or possibly all L2/L3/L4 headers)
> > > > You in general need to pull stuff *before* you've even looked at =
the packet,
> > > > so that you can look at the packet,
> > > > so it's relatively hard/annoying to pull the correct length from =
bpf
> > > > code itself.
> > > >
> > > > > > > BPF needs to modify a proper length to do pull data. Howeve=
r kernel
> > > > > > > should also improve the flow to avoid crash from a bpf func=
tion
> > > > > > call.
> > > > > > > As there is no split flow and app may not decode the merged=
 UDP
> > > > > > packet,
> > > > > > > we should drop the packet without fraglist in skb_segment_l=
ist
> > > > > > here.
> > > > > > >
> > > > > > > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chainin=
g.")
> > > > > > > Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> > > > > > > Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> > > > > > > ---
> > > > > > >  net/core/skbuff.c | 3 +++
> > > > > > >  1 file changed, 3 insertions(+)
> > > > > > >
> > > > > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > > > > index b99127712e67..f68f2679b086 100644
> > > > > > > --- a/net/core/skbuff.c
> > > > > > > +++ b/net/core/skbuff.c
> > > > > > > @@ -4504,6 +4504,9 @@ struct sk_buff *skb_segment_list(stru=
ct
> > > > > > sk_buff *skb,
> > > > > > >  if (err)
> > > > > > >  goto err_linearize;
> > > > > > >
> > > > > > > +if (!list_skb)
> > > > > > > +goto err_linearize;
> > > > > > > +
> > >
> > > This would catch the case where the entire data frag_list is
> > > linearized, but not a pskb_may_pull that only pulls in part of the
> > > list.
> > >
> > > Even with BPF being privileged, the kernel should not crash if BPF
> > > pulls a FRAGLIST GSO skb.
> > >
> > > But the check needs to be refined a bit. For a UDP GSO packet, I
> > > think gso_size is still valid, so if the head_skb length does not
> > > match gso_size, it has been messed with and should be dropped.
> > >
> > > For a GSO_BY_FRAGS skb, there is no single gso_size, and this pull
> > > may be entirely undetectable as long as frag_list !=3D NULL?
> > >
> > >
> > > > > > >  skb_shinfo(skb)->frag_list =3D NULL;
> > > > > >
> > > > > > In absense of plugging the issue in BPF, dropping here is the=
 best
> > > > > > we can do indeed, I think.
> =

> --
> Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google



