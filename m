Return-Path: <bpf+bounces-56991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4B2AA3C5A
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 01:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8135E46386F
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 23:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146C12DCB51;
	Tue, 29 Apr 2025 23:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuFwhruQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBEF215764;
	Tue, 29 Apr 2025 23:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969803; cv=none; b=bDKRvMEdYMNIsLIWlFzuw7pV7T0hq1aeAxrMTS+ArqquQEPLmGsOpr/oJ3gaGQ1BeL9wPYiy3V46yCEg8Zfi5wfueq8RfG7rzsYVuMBPHtmVv6mC1UJ/OGV4zzHAr+YHHzq9xgtFbAUHTG8WD0WVmLXInN2JLxd0p9I/nW6fCL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969803; c=relaxed/simple;
	bh=dTDlc0RNRDq6ls57mSLglq8pKgc7tdJz5BTJPM02X4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EeVPxw7iNappOPnfk4ir16BiuM2lfdZsLFLT2sEt7JUPciyNbor/V1ZbBoeHdc0iplI2RU26L/82RSrsB9FZWLFcwS5yl47j7GAX69pdQVWdi6Na9fPsoLaR6dw+qTlZhUFAqBBOhfcbac6x5/ZAuWyNYeMTWVgH02KkPpnZjZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuFwhruQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso5154648f8f.2;
        Tue, 29 Apr 2025 16:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969800; x=1746574600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdcWfFDVkFMcbGeWeLR6ziRht7bZ+Qb5kttylyR1mnw=;
        b=LuFwhruQ2/MYg8rM6zjzs57J2ig9Aa5tz5e+6gwe7r7SJZ0wMme2hisaq5dstgFEpt
         zFDAud4kBFF4SohbEsvL95iGRFOubzktiFDA22rNEPEGVPiXGGZIfG+BPfIH4ZfdqQdF
         xnehxnIiCDqtXIYyDjmzMbUsaemH7GbzOc/wfWMDB1jLVVb8BrxZ00P5f4MNqylDKL6Y
         ljfJvlEzOYRDAFm0I7pA1LKKtKN8wJ+uxx2cTpbKQ3LhCiM2trQ5Ycup/xd0Ls9PePuG
         +C4OHi99isQnhQdz1/YJnDkU69wc5MDLOGlQZM0JKcX5JrTee6bmywpSAO/hWRMQrY+T
         zl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969800; x=1746574600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdcWfFDVkFMcbGeWeLR6ziRht7bZ+Qb5kttylyR1mnw=;
        b=PBL82Bsp2km3mabl3X4E4rJ+hQyry6goLUUOwqMAaTvR9qZNZip4fe78Ead2l/k4I/
         TPigNdU+7Rp/WPJrTkX+tKRFWaJ2Agd+cSi4WqqwEEeCoMtxwy29C4kiff+NP/t7Km+x
         xLG7eCLGxXf3FsA/wwVFEAN8NnfZpNFgIgNSfkyuI8hnt7ehvKnZ63bgueNR/uGHeEp1
         fNW0I6wxmMf9fYZjAbmQPosVpXhrpqfFlQE9J0wu2199ebzG/YGC1fnRRKgvr7aPm3Hs
         ntFnNe1V5HqdE6fVoM+uaUGx2ev/WwO5ymNbDqhcyEsH1/Xsodz6oYcUb1ZYT2xRmwQX
         cRnw==
X-Forwarded-Encrypted: i=1; AJvYcCVDIJSh40ZL+W9cINeya6hcUeHzsuDKxjvW9VEmLWx5QnyRMybewmPjwU8tkGGAeVJwFOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCgOVNZ/plZV50q7AXANGKvBev5B48XNQIh0/8QZJjJbPWunbi
	2mI7hFoR/HQtGulMsv8NrG26vVHAunhAIhlEGQRd6PWd3BooRehIbzzge58gWQxWMqzagi24ypY
	T8aoRDWkSOSD+hTltfpdcb4HBl74zChV9
X-Gm-Gg: ASbGnctHbYaPy2GMbfH6y6FPr5dNoZdf7hRfXur6x8GpFQnvUbypScXZ1IdLtij19PL
	eiy2bQQL4F8pHrpCB9BeeKeJXFiPYHXUEHDvxLR6Twb1EpdMDjBx6X6faHzglb5bDDt6HUHUIWB
	7JWaPELDBLPrpLngBfZBUoIMtaJzefZmL5ZBL6Bw==
X-Google-Smtp-Source: AGHT+IFAjQigHug1u9Cny6toLPEtA9taavhyQrIwp+TOGB4qF7ytXjg4T06T9bltsGKoUlgESG2ZvHMJvCsskn6XXfQ=
X-Received: by 2002:a5d:584f:0:b0:3a0:7a7c:235f with SMTP id
 ffacd0b85a97d-3a08f7c984fmr1004496f8f.40.1745969799926; Tue, 29 Apr 2025
 16:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
 <20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com>
 <CAADnVQJeCC5j4_ss2+G2zjMbAcn=G3JLeAJCBZRC8uzfsVAjMA@mail.gmail.com> <D9FYTORERFI7.36F4WG8G3NHGX@arthurfabre.com>
In-Reply-To: <D9FYTORERFI7.36F4WG8G3NHGX@arthurfabre.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Apr 2025 16:36:28 -0700
X-Gm-Features: ATxdqUHsjcnMvbGw0y-BKgs2qU3xHGG0im9y3FrSvjgq6BDw-DSMeOOiOMxnsyI
Message-ID: <CAADnVQKe3Jfd+pVt868P32-m2a-moP4H7ms_kdZnrYALCxx53Q@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 01/17] trait: limited KV store for packet metadata
To: Arthur Fabre <arthur@arthurfabre.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Yan Zhai <yan@cloudflare.com>, 
	jbrandeburg@cloudflare.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <thoiland@redhat.com>, 
	lbiancon@redhat.com, Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 12:27=E2=80=AFPM Arthur Fabre <arthur@arthurfabre.c=
om> wrote:
>
> On Thu Apr 24, 2025 at 6:22 PM CEST, Alexei Starovoitov wrote:
> > On Tue, Apr 22, 2025 at 6:23=E2=80=AFAM Arthur Fabre <arthur@arthurfabr=
e.com> wrote:
> > >
> > > +/**
> > > + * trait_set() - Set a trait key.
> > > + * @traits: Start of trait store area.
> > > + * @hard_end: Hard limit the trait store can currently grow up again=
st.
> > > + * @key: The key to set.
> > > + * @val: The value to set.
> > > + * @len: The length of the value.
> > > + * @flags: Unused for now. Should be 0.
> > > + *
> > > + * Return:
> > > + * * %0       - Success.
> > > + * * %-EINVAL - Key or length invalid.
> > > + * * %-EBUSY  - Key previously set with different length.
> > > + * * %-ENOSPC - Not enough room left to store value.
> > > + */
> > > +static __always_inline
> > > +int trait_set(void *traits, void *hard_end, u64 key, const void *val=
, u64 len, u64 flags)
> > > +{
> > > +       if (!__trait_valid_key(key) || !__trait_valid_len(len))
> > > +               return -EINVAL;
> > > +
> > > +       struct __trait_hdr *h =3D (struct __trait_hdr *)traits;
> > > +
> > > +       /* Offset of value of this key. */
> > > +       int off =3D __trait_offset(*h, key);
> > > +
> > > +       if ((h->high & (1ull << key)) || (h->low & (1ull << key))) {
> > > +               /* Key is already set, but with a different length */
> > > +               if (__trait_total_length(__trait_and(*h, (1ull << key=
))) !=3D len)
> > > +                       return -EBUSY;
> > > +       } else {
> > > +               /* Figure out if we have enough room left: total leng=
th of everything now. */
> > > +               if (traits + sizeof(struct __trait_hdr) + __trait_tot=
al_length(*h) + len > hard_end)
> > > +                       return -ENOSPC;
> >
> > I'm still not excited about having two metadata-s
> > in front of the packet.
> > Why cannot traits use the same metadata space ?
> >
> > For trait_set() you already pass hard_end and have to check it
> > at run-time.
> > If you add the same hard_end to trait_get/del the kfuncs will deal
> > with possible corruption of metadata by the program.
> > Transition from xdp to skb will be automatic. The code won't care that =
traits
> > are there. It will just copy all metadata from xdp to skb. Corrupted or=
 not.
> > bpf progs in xdp and skb might even use the same kfuncs
> > (or two different sets if the verifier is not smart enough right now).
>
> Good idea, that would solve the corruption problem.
>
> But I think storing metadata at the "end" of the headroom (ie where
> XDP metadata is today) makes it harder to persist in the SKB layer.
> Functions like __skb_push() assume that skb_headroom() bytes are
> available just before skb->data.
>
> They can be updated to move XDP metadata out of the way, but this
> assumption seems pretty pervasive.

The same argument can be flipped.
Why does the skb layer need to push?
If it needs to encapsulate it will forward to tunnel device
to go on the wire. At this point any kind of metadata is going
to be lost on the wire. bpf prog would need to convert
metadata into actual on the wire format or stash it
or send to user space.
I don't see a use case where skb layer would move medadata by N
bytes, populate these N bytes with "???" and pass to next skb layer.
skb layers strip (pop) the header when it goes from ip to tcp to user space=
.
No need to move metadata.

> By using the "front" of the headroom, we can hide that from the rest of
> the SKB code. We could even update skb->head to completely hide the
> space used at the front of the headroom.
> It also avoids the cost of moving the metadata around (but maybe that
> would be insignificant).

That's a theory. Do you actually have skb layers pushing things
while metadata is there?

> XDP metadata also doesn't work well with GRO (see below).
>
> > Ideally we add hweight64 as new bpf instructions then maybe
> > we won't need any kernel changes at all.
> > bpf side will do:
> > bpf_xdp_adjust_meta(xdp, -max_offset_for_largest_key);
> > and then
> > trait_set(xdp->data_meta /* pointer to trait header */, xdp->data /*
> > hard end */, ...);
> > can be implemented as bpf prog.
> >
> > Same thing for skb progs.
> > netfilter/iptable can use another bpf prog to make decisions.
>
> There are (at least) two reasons for wanting the kernel to understand the
> format:
>
> * GRO: With an opaque binary blob, the kernel can either forbid GRO when
>   the metadata differs (like XDP metadata today), or keep the entire blob
>   of one of the packets.
>   But maybe some users will want to keep a KV of the first packet, or
>   the last packet, eg for receive timestamps.
>   With a KV store we can have a sane default option for merging the
>   different KV stores, and even add a per KV policy in the future if
>   needed.

We can have this default for metadata too.
If all bytes in the metadata blob are the same -> let it GRO.

I don't think it's a good idea to extend GRO with bpf to make it "smart".

> * Hardware metadata: metadata exposed from NICs (like the receive
>   timestamp, 4 tuple hash...) is currently only exposed to XDP programs
>   (via kfuncs).
>   But that doesn't expose them to the rest of the stack.
>   Storing them in traits would allow XDP, other BPF programs, and the
>   kernel to access and modify them (for example to into account
>   decapsulating a packet).

Sure. If traits =3D=3D existing metadata bpf prog in xdp can communicate
with bpf prog in skb layer via that "trait" format.
xdp can take tuple hash and store it as key=3D=3D0 in the trait.
The kernel doesn't need to know how to parse that format.

