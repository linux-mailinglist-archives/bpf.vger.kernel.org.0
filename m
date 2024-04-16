Return-Path: <bpf+bounces-26998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D0D8A72AD
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 19:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5BF2838A9
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 17:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E2E137916;
	Tue, 16 Apr 2024 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aooPOqH5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5351353FD
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289915; cv=none; b=H8tgLiqUoIgqPkzTb9JBJF49bk8ckgv4FUZJ2Ywn0KdXrM+2FEnwtBxncCGzeNUSnUdLu20v3oINsmW2WKkQUbRpnJPZTQQfCEh1brXw3ovfdHS++IMNt5VTXsPWVEQyUHfO0AKrcD6PW1zBxf2+t1E8b8TBXGecAM1Q0KRz5Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289915; c=relaxed/simple;
	bh=qGe3SmMXjxC1iIfDHjbD3GIcTV2s5YT9hG3HgrP4AO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAnwc6YX44HM6z0R/84F3qrz58IjzbGw8LGbNbtJrfqXRhQG8Cv3LHZfOjEZ6FtvRGdYWOeOSE89v8SzGjSxXsH01aJgycrpfDit6GFnKsGJpZ/JDBFPUUQBgVSpdOd+ilmdCVG4mcsdfHd0/3POnsfaoKBcqrERavX96F4CnUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aooPOqH5; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so1331a12.1
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713289912; x=1713894712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOqDr/WCGpfqkUsXg0MFPiKAWo47K9ERWPXbL1oLc3c=;
        b=aooPOqH5jID1Kb6bSSz/JvYd/hV/OZfpsGwxJcnFZJYbjXW+qyl4MZ/0TqgJS2R6TO
         y5wodqvV4e+jMxU/YpenGrMjh4o1BFMkJNNBqVtjLyHyTmWwbSXD2dDtHbv6Ea7NcyMO
         YBsmXCTS9ujUr7owTsfEJ9Q5FOb88NhonCGotUj2m6IsHVXrmhqEumrs3up5IBfCCaHz
         w9ufLQswBYVwzwQqEQnglBiN/04TJtkEy9zGyr+BSY1FXwjqNf3ign/MoV41eWB39Wzk
         I1iHrKtSgIB83LN5Y1z/lu/Kzgu25h1wLQb/5jOV5NW8zAyb9QlcjVP2M2NlHCUaa2tT
         8UOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713289912; x=1713894712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOqDr/WCGpfqkUsXg0MFPiKAWo47K9ERWPXbL1oLc3c=;
        b=Xb/Hv8T/btbagnEnG1qX4oBgDts0gv9Rj7zxAMsAnewFwGNj+hn66NYiLSt6lhQyMG
         mCbz6fxglB1+GvTTjpijlJYC5vYS8Ucgwp99tXaooQ/+VogsQDZDnYSxcneTuGhXiMLD
         L3yg/+GLNrweCt7fmcWHekwjUXPAjatkqTJfAgOqJCIlScx8MiNo014N2xwS6h2PGgMs
         mbZAjcfwbpxLH9zVye2PKjkAv0ouFhUrc5hkks7YlpPulK77HcXDKPk8z7rCOTp+Le5T
         atELA5Z30YikAN3KFmrJF6kSvAQnNbjBm4xmBANLrOeN/Evc9AulaWeRGuN45s43Za4X
         aAoA==
X-Forwarded-Encrypted: i=1; AJvYcCU//JKnPYLbGlfyJ6EwvWIWOEmSZNF7mWywgzq6/OBZNNxDR3+8pOACENaseeQfryPbO6+9Xy9v9+pplpZUU76RUmC9
X-Gm-Message-State: AOJu0Yy9VHINYnash+pWrUGNBqAd3FXEtGTLjg0JBcVkeuhXHO5Db4fh
	4kvRC4SjE/UjnWTwVEZ3DVoxKzxNDSp30fNAUkzTzofQ/3Ws3w3VReep8uh0m5xL3qvfFmAlboI
	8BI3zmQqxMWQySqgnuK6jLqqsau/GqCDIhQS5
X-Google-Smtp-Source: AGHT+IHqvcgrOIKnIz7AMTuMekRieW9kUedM/4N6g4H+mGv1zXRkdGKwiX9KQXg87knA8R5V1ssf0ZtqeiJNlPtfHSY=
X-Received: by 2002:a05:6402:2898:b0:570:4ae7:dee6 with SMTP id
 eg24-20020a056402289800b005704ae7dee6mr12327edb.6.1713289911848; Tue, 16 Apr
 2024 10:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch> <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
 <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com> <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch>
In-Reply-To: <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Tue, 16 Apr 2024 10:51:34 -0700
Message-ID: <CANP3RGdrRDERiPFVQ1nZYVtopErjqOQ72qQ_+ijGQiL7bTtcLQ@mail.gmail.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without fraglist
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	=?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 10:16=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Maciej =C5=BBenczykowski wrote:
> > On Mon, Apr 15, 2024 at 7:14=E2=80=AFPM Lena Wang (=E7=8E=8B=E5=A8=9C) =
<Lena.Wang@mediatek.com> wrote:
> > >
> > > On Mon, 2024-04-15 at 16:53 -0400, Willem de Bruijn wrote:
> > > >
> > > > External email : Please do not click links or open attachments unti=
l
> > > > you have verified the sender or the content.
> > > >  shiming.cheng@ wrote:
> > > > > From: Shiming Cheng <shiming.cheng@mediatek.com>
> > > > >
> > > > > A GRO packet without fraglist is crashed and backtrace is as belo=
w:
> > > > >  [ 1100.812205][    C3] CPU: 3 PID: 0 Comm: swapper/3 Tainted:
> > > > > G        W  OE      6.6.17-android15-0-g380371ea9bf1 #1
> > > > >  [ 1100.812317][    C3]  __udp_gso_segment+0x298/0x4d4
> > > > >  [ 1100.812335][    C3]  __skb_gso_segment+0xc4/0x120
> > > > >  [ 1100.812339][    C3]  udp_rcv_segment+0x50/0x134
> > > > >  [ 1100.812344][    C3]  udp_queue_rcv_skb+0x74/0x114
> > > > >  [ 1100.812348][    C3]  udp_unicast_rcv_skb+0x94/0xac
> > > > >  [ 1100.812358][    C3]  udp_rcv+0x20/0x30
> > > > >
> > > > > The reason that the packet loses its fraglist is that in ingress
> > > > bpf
> > > > > it makes a test pull with to make sure it can read packet headers
> > > > > via direct packet access: In bpf_progs/offload.c
> > > > > try_make_writable -> bpf_skb_pull_data -> pskb_may_pull ->
> > > > > __pskb_pull_tail  This operation pull the data in fraglist into
> > > > linear
> > > > > and set the fraglist to null.
> > > >
> > > > What is the right behavior from BPF with regard to SKB_GSO_FRAGLIST
> > > > skbs?
> > > >
> > > > Some, like SCTP, cannot be linearized ever, as the do not have a
> > > > single gso_size.
> > > >
> > > > Should this BPF operation just fail?
> > > >
> > > In most situation for big gso size packet, it indeed fails but BPF
> > > doesn't check the result. It seems the udp GRO packet can't be pulled=
/
> > > trimed/condensed or else it can't be segmented correctly.
> > >
> > > As the BPF function comments it doesn't matter if the data pull faile=
d
> > > or pull less. It just does a blind best effort pull.
> > >
> > > A patch to modify bpf pull length is upstreamed to Google before and
> > > below are part of Google BPF expert maze's reply:
> > > maze@google.com<maze@google.com> #5Apr 13, 2024 02:30AM
> > > I *think* if that patch fixes anything, then it's really proving that
> > > there's a bug in the kernel that needs to be fixed instead.
> > > It should be legal to call try_make_writable(skb, X) with *any* value
> > > of X.
> > >
> > > I add maze in loop and we could start more discussion here.
> >
> > Personally, I think bpf_skb_pull_data() should have automatically
> > (ie. in kernel code) reduced how much it pulls so that it would pull
> > headers only,
>
> That would be a helper that parses headers to discover header length.

Does it actually need to?  Presumably the bpf pull function could
notice that it is
a packet flagged as being of type X (UDP GSO FRAGLIST) and reduce the pull
accordingly so that it doesn't pull anything from the non-linear
fraglist portion???

I know only the generic overview of what udp gso is, not any details, so I =
am
assuming here that there's some sort of guarantee to how these packets
are structured...  But I imagine there must be or we wouldn't be hitting th=
ese
issues deeper in the stack?

> Parsing is better left to the BPF program.
>
> > and not packet content.
> > (This is assuming the rest of the code isn't ready to deal with a longe=
r pull,
> > which I think is the case atm.  Pulling too much, and then crashing or =
forcing
> > the stack to drop packets because of them being malformed seems wrong..=
.)
> >
> > In general it would be nice if there was a way to just say pull all hea=
ders...
> > (or possibly all L2/L3/L4 headers)
> > You in general need to pull stuff *before* you've even looked at the pa=
cket,
> > so that you can look at the packet,
> > so it's relatively hard/annoying to pull the correct length from bpf
> > code itself.
> >
> > > > > BPF needs to modify a proper length to do pull data. However kern=
el
> > > > > should also improve the flow to avoid crash from a bpf function
> > > > call.
> > > > > As there is no split flow and app may not decode the merged UDP
> > > > packet,
> > > > > we should drop the packet without fraglist in skb_segment_list
> > > > here.
> > > > >
> > > > > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> > > > > Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> > > > > Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> > > > > ---
> > > > >  net/core/skbuff.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > > index b99127712e67..f68f2679b086 100644
> > > > > --- a/net/core/skbuff.c
> > > > > +++ b/net/core/skbuff.c
> > > > > @@ -4504,6 +4504,9 @@ struct sk_buff *skb_segment_list(struct
> > > > sk_buff *skb,
> > > > >  if (err)
> > > > >  goto err_linearize;
> > > > >
> > > > > +if (!list_skb)
> > > > > +goto err_linearize;
> > > > > +
>
> This would catch the case where the entire data frag_list is
> linearized, but not a pskb_may_pull that only pulls in part of the
> list.
>
> Even with BPF being privileged, the kernel should not crash if BPF
> pulls a FRAGLIST GSO skb.
>
> But the check needs to be refined a bit. For a UDP GSO packet, I
> think gso_size is still valid, so if the head_skb length does not
> match gso_size, it has been messed with and should be dropped.
>
> For a GSO_BY_FRAGS skb, there is no single gso_size, and this pull
> may be entirely undetectable as long as frag_list !=3D NULL?
>
>
> > > > >  skb_shinfo(skb)->frag_list =3D NULL;
> > > >
> > > > In absense of plugging the issue in BPF, dropping here is the best
> > > > we can do indeed, I think.

