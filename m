Return-Path: <bpf+bounces-55257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE98AA7A962
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 20:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96CE3A7EF6
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9A25333D;
	Thu,  3 Apr 2025 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdaD3uGK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697BA1F1936
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705034; cv=none; b=bi3BIn8tCRMrCEdMqP9p/Blx2nN1UxuSqwazhehdyoJdzUKG3p9m3/o3NH+9Uu9nMR3UMFgZuW9xNnfxprWByOqZeq9DpCTy3HwtfyKe1PIY7YfxjhiH5rTa53QiUYIZON7zqNdQOdJEv1aglyleQZjYpI8QoPZiZns/mIg50JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705034; c=relaxed/simple;
	bh=PkslLZ+LloU6B+v0EstCj9Qw0blZGQA2AGI0/JXULwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1HTgkCQziFgb+cFIRN58gaUMl3E3p0GZ4LOH68HeY8QdnNlmqYGSju32xc4Ne2TvC0TZP6OZ9iQBjhvtf5qrD3lOUeZA4Mu6a8/Vc/OP7fVhrQ72q0VJ157/JdimzwxrA5AFdS2rrtLuoDEDzCkIybhnb0I9iU7plv0o1w/gmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdaD3uGK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so1620a12.0
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 11:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743705031; x=1744309831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYMGgH2/Vqv1R7Ax+V3E+Ngy/7HRiyWg2fEaUXEJVfU=;
        b=gdaD3uGKuP5b+COSrcW5u2sHHjf09/F/AwYc/RtAHgOpxeD1Gj42vfK8yJ6Kt+nx+2
         G/dxLKk5IxQewJq40V422aSd6VA/QtPtoszuJVKxgZ7odvTK0ZAWBoT8hJPHotvxWkKU
         0sqs0cwHGGYuhHLU4b8rYsUVn8c4+wjBnigibQtY6Vz8yGfeXHQU4BOrekTAddKV8ROD
         rwty4CALZSqzmFHXJovcCDl3w8NINyG7rq5gkyJwK2jHwpvU8DIDJevaHMZvVzTtN5Ok
         e40NfAtEdMqhFNzCM5x2JVb5NyDpPlvovk08Q3X9v1xTx5S24e+qYuvt0L6gIxWLsUAi
         tRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743705031; x=1744309831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYMGgH2/Vqv1R7Ax+V3E+Ngy/7HRiyWg2fEaUXEJVfU=;
        b=k+pmPxPQwCrxK625bko9LVjfbCa7TznHqIWC7Oi955XIBIs9ar8o6LF8+amIaXcIJE
         KFSBVEcKHG3oTaBK6xBbCljKOn56R2rJ1C6/R2eYA9tDi8znfET3apl/Y8TkGLAf1oZN
         WhWn9TdY8RzlqYRculZmpfo7XOMlMiK64FDTwG9kcT0JfoZXAigvA58cIR9JK9iMOWK2
         9OctOVrS11CcVDWHtB1l+CvXSydd5SwvkMup18UIUhE4kJLm9wfKHlqgTIuHDTDKdxL1
         IceLwlm4XE7wpKNhkW1jBLtPeZd2GXhKliUHUJ0H+SDUSm8WTik2QFgsro86WzXswbN7
         lGpw==
X-Forwarded-Encrypted: i=1; AJvYcCVIeTMFIYf5rL2LQBTguKFV3YSQePzWBVsTKTqqhdddQUS0cso2TPdw6PixHkl5Ze2Vz5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx89LZbxSMbQzuieF2PkISMVuzNXpqaB0Z7j3BoKn8Ya8Hv2iGg
	aDtFbZvEAebAFifUrlKbQEtR/tinqRHhpej3jqbLMHKJXLVV7Qzg7CsjPt3BWCnihz7XMTw/qA3
	e5p4YRcT5Ri6gwbLP9GeadUgPqntFi0SshCXf
X-Gm-Gg: ASbGnctvcYJSUoRLSPaqPWBktdCR/1OOhXzQZXn0H9ldGbK0TC1cYCermgEqNdWv7uB
	8zS421BaBZhmHtdPWF0yLo/XRsar7T2gOLfKWBKKZIJGw68GM3Fe7F3Vyvs1bccP6nXl8lNgtk0
	qCdA/2pGVdttl31PyxsyOaModXNP+tqcZyKoZsOI3fu3afyO7IAycyHwYk
X-Google-Smtp-Source: AGHT+IGN3xjfeCsv6yU/ijhQ9l/fdxnM1CkdyiU+66cHrRD4FhUygubAdMQnp2osyUBvjMPoNgXxTXybIBkTRkjpgMo=
X-Received: by 2002:a05:6402:1858:b0:5eb:5d50:4fec with SMTP id
 4fb4d7f45d1cf-5f0b32e46b3mr10995a12.0.1743705030162; Thu, 03 Apr 2025
 11:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403140846.1268564-1-willemdebruijn.kernel@gmail.com>
 <20250403140846.1268564-2-willemdebruijn.kernel@gmail.com>
 <Z-7DiZWkOQ_n5aXw@mini-arch> <67eec501d0d58_14b7b229490@willemb.c.googlers.com.notmuch>
 <Z-7G8cBIW7-dVeH8@mini-arch>
In-Reply-To: <Z-7G8cBIW7-dVeH8@mini-arch>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 3 Apr 2025 11:30:18 -0700
X-Gm-Features: AQ5f1JojtrAQfQuBrxXtrkvPht_OtIyL0GibAHcLZ4neOaOKwSrpH4h5ePglz5I
Message-ID: <CANP3RGe8ZjcX8yGhCPs+Q1x7ijpGKthjawztFiXSeDQazgSrpA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, Willem de Bruijn <willemb@google.com>, 
	Matt Moeller <moeller.matt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 10:35=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 04/03, Willem de Bruijn wrote:
> > Stanislav Fomichev wrote:
> > > On 04/03, Willem de Bruijn wrote:
> > > > From: Willem de Bruijn <willemb@google.com>
> > > >
> > > > Classic BPF socket filters with SKB_NET_OFF and SKB_LL_OFF fail to
> > > > read when these offsets extend into frags.
> > > >
> > > > This has been observed with iwlwifi and reproduced with tun with
> > > > IFF_NAPI_FRAGS. The below straightforward socket filter on UDP port=
,
> > > > applied to a RAW socket, will silently miss matching packets.
> > > >
> > > >     const int offset_proto =3D offsetof(struct ip6_hdr, ip6_nxt);
> > > >     const int offset_dport =3D sizeof(struct ip6_hdr) + offsetof(st=
ruct udphdr, dest);
> > > >     struct sock_filter filter_code[] =3D {
> > > >             BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_AD_OFF + SKF_=
AD_PKTTYPE),
> > > >             BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
> > > >             BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_NET_OFF + off=
set_proto),
> > > >             BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_UDP, 0, 2),
> > > >             BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, SKF_NET_OFF + off=
set_dport),
> > > >
> > > > This is unexpected behavior. Socket filter programs should be
> > > > consistent regardless of environment. Silent misses are
> > > > particularly concerning as hard to detect.
> > > >
> > > > Use skb_copy_bits for offsets outside linear, same as done for
> > > > non-SKF_(LL|NET) offsets.
> > > >
> > > > Offset is always positive after subtracting the reference threshold
> > > > SKB_(LL|NET)_OFF, so is always >=3D skb_(mac|network)_offset. The s=
um of
> > > > the two is an offset against skb->data, and may be negative, but it
> > > > cannot point before skb->head, as skb_(mac|network)_offset would to=
o.
> > > >
> > > > This appears to go back to when frag support was introduced to
> > > > sk_run_filter in linux-2.4.4, before the introduction of git.
> > > >
> > > > The amount of code change and 8/16/32 bit duplication are unfortuna=
te.
> > > > But any attempt I made to be smarter saved very few LoC while
> > > > complicating the code.
> > > >
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Link: https://lore.kernel.org/netdev/20250122200402.3461154-1-maze@=
google.com/
> > > > Link: https://elixir.bootlin.com/linux/2.4.4/source/net/core/filter=
.c#L244
> > > > Reported-by: Matt Moeller <moeller.matt@gmail.com>
> > > > Co-developed-by: Maciej =C5=BBenczykowski <maze@google.com>
> > > > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > ---
> > > >  include/linux/filter.h |  3 --
> > > >  kernel/bpf/core.c      | 21 ------------
> > > >  net/core/filter.c      | 75 +++++++++++++++++++++++---------------=
----
> > > >  3 files changed, 42 insertions(+), 57 deletions(-)
> > > >
> > > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > > index f5cf4d35d83e..708ac7e0cd36 100644
> > > > --- a/include/linux/filter.h
> > > > +++ b/include/linux/filter.h
> > > > @@ -1496,9 +1496,6 @@ static inline u16 bpf_anc_helper(const struct=
 sock_filter *ftest)
> > > >   }
> > > >  }
> > > >
> > > > -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *s=
kb,
> > > > -                                    int k, unsigned int size);
> > > > -
> > > >  static inline int bpf_tell_extensions(void)
> > > >  {
> > > >   return SKF_AD_MAX;
> > > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > > index ba6b6118cf50..0e836b5ac9a0 100644
> > > > --- a/kernel/bpf/core.c
> > > > +++ b/kernel/bpf/core.c
> > > > @@ -68,27 +68,6 @@
> > > >  struct bpf_mem_alloc bpf_global_ma;
> > > >  bool bpf_global_ma_set;
> > > >
> > > > -/* No hurry in this branch
> > > > - *
> > > > - * Exported for the bpf jit load helper.
> > > > - */
> > > > -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *s=
kb, int k, unsigned int size)
> > > > -{
> > > > - u8 *ptr =3D NULL;
> > > > -
> > > > - if (k >=3D SKF_NET_OFF) {
> > > > -         ptr =3D skb_network_header(skb) + k - SKF_NET_OFF;
> > > > - } else if (k >=3D SKF_LL_OFF) {
> > > > -         if (unlikely(!skb_mac_header_was_set(skb)))
> > > > -                 return NULL;
> > > > -         ptr =3D skb_mac_header(skb) + k - SKF_LL_OFF;
> > > > - }
> > > > - if (ptr >=3D skb->head && ptr + size <=3D skb_tail_pointer(skb))
> > > > -         return ptr;
> > > > -
> > > > - return NULL;
> > > > -}
> > > > -
> > > >  /* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE */
> > > >  enum page_size_enum {
> > > >   __PAGE_SIZE =3D PAGE_SIZE
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index bc6828761a47..b232b70dd10d 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -221,21 +221,24 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk=
_buff *, skb, u32, a, u32, x)
> > > >  BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, con=
st void *,
> > > >      data, int, headlen, int, offset)
> > > >  {
> > > > - u8 tmp, *ptr;
> > > > + u8 tmp;
> > > >   const int len =3D sizeof(tmp);
> > > >
> > > > - if (offset >=3D 0) {
> > > > -         if (headlen - offset >=3D len)
> > > > -                 return *(u8 *)(data + offset);
> > > > -         if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > > -                 return tmp;
> > > > - } else {
> > > > -         ptr =3D bpf_internal_load_pointer_neg_helper(skb, offset,=
 len);
> > > > -         if (likely(ptr))
> > > > -                 return *(u8 *)ptr;
> > >
> > > [..]
> > >
> > > > + if (offset < 0) {
> > > > +         if (offset >=3D SKF_NET_OFF)
> > > > +                 offset +=3D skb_network_offset(skb) - SKF_NET_OFF=
;
> > > > +         else if (offset >=3D SKF_LL_OFF && skb_mac_header_was_set=
(skb))
> > > > +                 offset +=3D skb_mac_offset(skb) - SKF_LL_OFF;
> > > > +         else
> > > > +                 return -EFAULT;
> > > >   }
> > >
> > > nit: we now repeat the same logic three times, maybe still worth it t=
o put it
> > > into a helper? bpf_resolve_classic_offset or something.
> >
> > I definitely tried this in various ways. But since the core logic is
> > only four lines and there is an early return on error, no helper
> > really simplifies anything. It just adds a layer of indirection and
> > more code in the end.
>
> More code, but at least it de-duplicates the logic of translating
> SKF_XXX_OFF? Something like the following below, but yeah, a matter
> of preference, up to you.
>
> static int bpf_skb_resolve_offset(skb, offset) {
>         if (offset >=3D 0)
>                 return offset;
>
>         if (offset >=3D SKF_NET_OFF)
>                 offset +=3D skb_network_offset(skb) - SKF_NET_OFF;
>         else if (offset >=3D SKF_LL_OFF && skb_mac_header_was_set(skb))
>                 offset +=3D skb_mac_offset(skb) - SKF_LL_OFF;
>
>         return -1;
> }
>
> BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const void=
 *,
>            data, int, headlen, int, offset)
> {
>         offset =3D bpf_skb_resolve_offset(skb, offset);
>         if (offset < 0)
>                 return -EFAULT;

this is incorrect, as offset can be legally negative here.

>
>         ...
> }

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

