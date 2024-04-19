Return-Path: <bpf+bounces-27245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A818AB47F
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 19:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FDB5B22939
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 17:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AA113AD26;
	Fri, 19 Apr 2024 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL79kDAn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26921369AA;
	Fri, 19 Apr 2024 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713548512; cv=none; b=ZbYRi1RdmhGDe6J4iHxJC6tLSAN7onFRRzf8zkwtWqG852dWpwwMGZzWSY9ScdquUzrQlZmoisZedNC53GHvxYBILl0H6DSAndw2vUcjGsjgpG0V658JcehjjiB3juzO9Lg53kcyxVgBLjW+QT/oAFiAsBEtgHN8LQ7ujVr8XbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713548512; c=relaxed/simple;
	bh=lJrtztN6TQz6i88xN+28N7ePQw+MLXBc6gynrScAkVc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GN/FnmfzTIiElcmB3AOaQgke/GetB48sOzwgbvq95EgtC8rMQKGOxImROWPB8O8fNZFBf9A7xoaG128VftYBERqPLcr1C7lAXi72nCxcMHcVJhgUWRQgQ41gGr4nW9KLJOw/iQ7ioXzxrPYyfybAzbrJzfuGIglU/vjRAcNFM2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL79kDAn; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78f04924a96so162504385a.0;
        Fri, 19 Apr 2024 10:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713548510; x=1714153310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HlnIddU7CFPtWewK0i4X7PbR5o2iROhw6ft5oejAF8=;
        b=HL79kDAnnm6JE4Hm5ba2mAqHNtNEIcOm+K15ZEpoY9fshHnM1pAPWQH0uW7qE+NuIN
         PDErLlMdZbvgPR0zFjLVnlN86KyjfjhCQ6YQpZhstyAI+OKjevE42U2pJkDnGNdL3Duz
         PhjxRKiVaNdilqyIsxXnkIczw5tg+hCbnPGmTuNuJs17UUy8QL/EYLGZZG8IrNiMD5D2
         6fW1VkU1XEQnlonirkVK5Oz+dL3Xy3euS9LHughgxy/tkObIQ3If41/M5BJq9GZlWyT0
         z2sG2bKSHLM6qJ4s8JZV4viWoS97X+BN1mc2dOj+/Iz8qFMPqig65rI4V01pnJKSXYXO
         IcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713548510; x=1714153310;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6HlnIddU7CFPtWewK0i4X7PbR5o2iROhw6ft5oejAF8=;
        b=qUPVcCgCSl7iAIqcUhuouvtxj/fyQF7bqHxYyIlyCo+eLs4K8XUtYuNaHTFj1NuBib
         xcscMvVr4igIwvxmZZ/RQ7sPIFJQAHAkodk5KHXW1QtMutVvOkzfzsbPEebyJnIjvCZ9
         avvrMKTwO5I7i15KfQfc6Zfpe1HOHL3k1+Lxi4TzBSghDFAzfD1cLP1re1Lv3jbl5P4u
         UxWBMfYhpsIh8mxJsPy5RyB15az1kSzNYN5IpbwDFnrfczAW/weSH7G0Po1GHgpOH5XL
         KmOS3aMtaU2+oPcsKcnevX13eMs7EEo9Te8/cZYBVqECd+9GnO5C6b07IqiDVV+qyK7v
         FsOw==
X-Forwarded-Encrypted: i=1; AJvYcCVB8UVPgIJJgHXKtA8dRfiyjoWA0VY8/Ia9j1TY1G8UjXRAboquYR3tNzFH4gePltmSK9W3vnLWQb6oX4caJku0P+xRJn2EA+ye2tHHccFGXU6CGEvs36qKYvKOGWelLQSaQgssXr4VeCxho76mj8N6CStdxv5Rk05W
X-Gm-Message-State: AOJu0YxtsrGarClLErWsTS5/dqOo8xm3/Q0wv+MuHIaFakz8aHJ48/cn
	3L1GsgjgkG4EI/IpWLdKytDD+A9815XqcL3idWmwvArrfboBrVWfPuUUPA==
X-Google-Smtp-Source: AGHT+IGO1TqS3a01zDyhxqCjY+uubretKH+/O359cCHz0E0PoC2xj9CYxcx0MDOQS7PlMDM+EoGA3w==
X-Received: by 2002:a05:620a:24ca:b0:78f:f61:ca5 with SMTP id m10-20020a05620a24ca00b0078f0f610ca5mr3197278qkn.7.1713548509832;
        Fri, 19 Apr 2024 10:41:49 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id c12-20020a05620a134c00b0078f0ee3fcfbsm1662791qkl.46.2024.04.19.10.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 10:41:49 -0700 (PDT)
Date: Fri, 19 Apr 2024 13:41:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TWFjaWVqIMW7ZW5jenlrb3dza2k=?= <maze@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 yan@cloudflare.com
Message-ID: <6622acdd22168_122c5b2945@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANP3RGfxeKDUmGwSsZrAs88Fmzk50XxN+-MtaJZTp641aOhotA@mail.gmail.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch>
 <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
 <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
 <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch>
 <CANP3RGdrRDERiPFVQ1nZYVtopErjqOQ72qQ_+ijGQiL7bTtcLQ@mail.gmail.com>
 <CANP3RGd+Zd-bx6S-NzeGch_crRK2w0-u6xwSVn71M581uCp9cQ@mail.gmail.com>
 <661f066060ab4_7a39f2945d@willemb.c.googlers.com.notmuch>
 <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
 <662027965bdb1_c8647294b3@willemb.c.googlers.com.notmuch>
 <11395231f8be21718f89981ffe3703da3f829742.camel@mediatek.com>
 <CANP3RGdh24xyH2V7Sa2fs9Ca=tiZNBdKu1qQ8LFHS3sY41CxmA@mail.gmail.com>
 <b24bc70ae2c50dc50089c45afbed34904f3ee189.camel@mediatek.com>
 <66227ce6c1898_116a9b294be@willemb.c.googlers.com.notmuch>
 <CANP3RGfxeKDUmGwSsZrAs88Fmzk50XxN+-MtaJZTp641aOhotA@mail.gmail.com>
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
> On Fri, Apr 19, 2024 at 7:17=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> > > On Wed, 2024-04-17 at 21:15 -0700, Maciej =C5=BBenczykowski wrote:
> > > >
> > > > External email : Please do not click links or open attachments un=
til
> > > > you have verified the sender or the content.
> > > >  On Wed, Apr 17, 2024 at 7:53=E2=80=AFPM Lena Wang (=E7=8E=8B=E5=A8=
=9C) <
> > > > Lena.Wang@mediatek.com> wrote:
> > > > >
> > > > > On Wed, 2024-04-17 at 15:48 -0400, Willem de Bruijn wrote:
> > > > > >
> > > > > > External email : Please do not click links or open attachment=
s
> > > > until
> > > > > > you have verified the sender or the content.
> > > > > >  Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> > > > > > > On Tue, 2024-04-16 at 19:14 -0400, Willem de Bruijn wrote:
> > > > > > > >
> > > > > > > > External email : Please do not click links or open
> > > > attachments
> > > > > > until
> > > > > > > > you have verified the sender or the content.
> > > > > > > >  > > > > Personally, I think bpf_skb_pull_data() should h=
ave
> > > > > > > > automatically
> > > > > > > > > > > > (ie. in kernel code) reduced how much it pulls so=

> > > > that it
> > > > > > > > would pull
> > > > > > > > > > > > headers only,
> > > > > > > > > > >
> > > > > > > > > > > That would be a helper that parses headers to disco=
ver
> > > > > > header
> > > > > > > > length.
> > > > > > > > > >
> > > > > > > > > > Does it actually need to?  Presumably the bpf pull
> > > > function
> > > > > > could
> > > > > > > > > > notice that it is
> > > > > > > > > > a packet flagged as being of type X (UDP GSO FRAGLIST=
)
> > > > and
> > > > > > reduce
> > > > > > > > the pull
> > > > > > > > > > accordingly so that it doesn't pull anything from the=

> > > > non-
> > > > > > linear
> > > > > > > > > > fraglist portion???
> > > > > > > > > >
> > > > > > > > > > I know only the generic overview of what udp gso is, =
not
> > > > any
> > > > > > > > details, so I am
> > > > > > > > > > assuming here that there's some sort of guarantee to =
how
> > > > > > these
> > > > > > > > packets
> > > > > > > > > > are structured...  But I imagine there must be or we
> > > > wouldn't
> > > > > > be
> > > > > > > > hitting these
> > > > > > > > > > issues deeper in the stack?
> > > > > > > > >
> > > > > > > > > Perhaps for a packet of this type we're already guarant=
eed
> > > > the
> > > > > > > > headers
> > > > > > > > > are in the linear portion,
> > > > > > > > > and the pull should simply be ignored?
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > Parsing is better left to the BPF program.
> > > > > > > >
> > > > > > > > I do prefer adding sanity checks to the BPF helpers, over=

> > > > having
> > > > > > to
> > > > > > > > add then in the net hot path only to protect against
> > > > dangerous
> > > > > > BPF
> > > > > > > > programs.
> > > > > > > >
> > > > > > > Is it OK to ignore or decrease pull length for udp gro frag=
list
> > > > > > packet?
> > > > > > > It could save the normal packet and sent to user correctly.=

> > > > > > >
> > > > > > > In common/net/core/filter.c
> > > > > > > static inline int __bpf_try_make_writable(struct sk_buff *s=
kb,
> > > > > > >               unsigned int write_len)
> > > > > > > {
> > > > > > > +if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> > > > > > > +(SKB_GSO_UDP  |SKB_GSO_UDP_L4)) {
> > > > > >
> > > > > > The issue is not with SKB_GSO_UDP_L4, but with SKB_GSO_FRAGLI=
ST.
> > > > > >
> > > > > Current in kernel just UDP uses SKB_GSO_FRAGLIST to do GRO. In
> > > > > udp_offload.c udp4_gro_complete gso_type adds "SKB_GSO_FRAGLIST=
|
> > > > > SKB_GSO_UDP_L4". Here checking these two flags is to limit the
> > > > packet
> > > > > as "UDP + need GSO + fraglist".
> > > > >
> > > > > We could remove SKB_GSO_UDP_L4 check for more packet that may
> > > > addrive
> > > > > skb_segment_list.
> > > > >
> > > > > > > +return 0;
> > > > > >
> > > > > > Failing for any pull is a bit excessive. And would kill a san=
e
> > > > > > workaround of pulling only as many bytes as needed.
> > > > > >
> > > > > > > +     or if (write_len > skb_headlen(skb))
> > > > > > > +write_len =3D skb_headlen(skb);
> > > > > >
> > > > > > Truncating requests would be a surprising change of behavior
> > > > > > for this function.
> > > > > >
> > > > > > Failing for a pull > skb_headlen is arguably reasonable, as
> > > > > > the alternative is that we let it go through but have to drop=

> > > > > > the now malformed packets on segmentation.
> > > > > >
> > > > > >
> > > > > Is it OK as below?
> > > > >
> > > > > In common/net/core/filter.c
> > > > > static inline int __bpf_try_make_writable(struct sk_buff *skb,
> > > > >               unsigned int write_len)
> > > > > {
> > > > > +       if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> > > > > +               SKB_GSO_FRAGLIST) && (write_len >
> > > > skb_headlen(skb))) {
> > > > > +               return 0;
> > > >
> > > > please limit write_len to skb_headlen() instead of just returning=
 0
> > > >
> > >
> > > Hi Maze & Willem,
> > > Maze's advice is:
> > > In common/net/core/filter.c
> > > static inline int __bpf_try_make_writable(struct sk_buff *skb,
> > >               unsigned int write_len)
> > > {
> > > +       if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> > > +               SKB_GSO_FRAGLIST) && (write_len > skb_headlen(skb))=
) {
> > > +               write_len =3D skb_headlen(skb);
> > > +       }
> > >         return skb_ensure_writable(skb, write_len);
> > > }
> > >
> > > Willem's advice is to "Failing for a pull > skb_headlen is arguably=

> > > reasonable...". It prefers to return 0 :
> > > +       if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> > > +               SKB_GSO_FRAGLIST) && (write_len > skb_headlen(skb))=
) {
> > > +               return 0;
> > > +       }
> > >
> > > It seems a bit conflict. However I am not sure if my understanding =
is
> > > right and hope to get your further guide.
> >
> > I did not mean to return 0. But to fail a request that would pull an
> > unsafe amount. The caller must get a clear error signal.
> =

> That's hostile on userspace.
> Currently the caller doesn't even check the error return...

It can, and probably should.

bpf_skb_pull data returns the error code from bpf_try_make_writable:

   return bpf_try_make_writable(skb, len ? : skb_headlen(skb));

> Why would we?  We already have to reload all pointers, and have to do
> and will thus redo checking on those.
> =

> What do you expect the caller to do? Subtract -1 and try again?
> That's hard to do from BPF as it involves looping... and is slow.
> =

> We already try to not pull too much:
> =

> void try_make_writable(struct __sk_buff* skb, int len) {
>   if (len > skb->len) len =3D skb->len;
>   if (skb->data_end - skb->data < len) bpf_skb_pull_data(skb, len);
> }
> =

> Is there at least something like skb->len that has the actually
> pullable length in it?

The above snippet shows that it passes skb_headlen if the caller
passes 0.

But your BPF program does not even need the data writable, so then
it is of little help of course.
 =

> Or are these skb's structured in such a way that there is never a need
> to pull anything,
> because the headers are already always in the linear portion?

That is indeed the case.

So as far as I can see:

A BPF program that just wants to pull the network and transport
headers can diligently pull exactly what is needed. And will not
even observe any data pulled into linear in practice. This is still
advisable rather than trusting that the headers are linear. It may
also be required by the validator? Don't know. But check the return
value.

> =

> > Back to the original report: the issue should already have been fixed=

> > by commit 876e8ca83667 ("net: fix NULL pointer in skb_segment_list").=

> > But that commit is in the kernel for which you report the error.
> >
> > Turns out that the crash is not in skb_segment_list, but later in
> > __udpv4_gso_segment_list_csum. Which unconditionally dereferences
> > udp_hdr(seg).
> >
> > The above fix also mentions skb pull as the culprit, but does not
> > include a BPF program. If this can be reached in other ways, then we
> > do need a stronger test in skb_segment_list, as you propose.
> >
> > I don't want to narrowly check whether udp_hdr is safe. Essentially,
> > an SKB_GSO_FRAGLIST skb layout cannot be trusted at all if even one
> > byte would get pulled.
> =

> --
> Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google



