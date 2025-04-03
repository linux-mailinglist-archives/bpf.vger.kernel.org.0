Return-Path: <bpf+bounces-55261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DAFA7A9C3
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 20:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29558171F1D
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 18:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C601252906;
	Thu,  3 Apr 2025 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4INoqj1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477041E87B;
	Thu,  3 Apr 2025 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706482; cv=none; b=TfBBFOBJ+UWuqs+rmuX8JsSIPtHGeym0IInWoF8i8zzYEIxdH6xPH2BYu2WnxvhmLfz40aiUxuMGEWZVqcuarXldmkE9RFedFh1xN7kM0+SSB5MJdP/L1syC7flHQ3merQtgf8yu8KBVy7+K8RoAG3G/HhAVvtPqPqkVI8XKGGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706482; c=relaxed/simple;
	bh=C1FBcDaAVK1uwh+G94FF6tFU7E/4QQ7RC9zYw+17n1c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pADn0JVpOXhlI0og5a2ZW7+4QzlXuL/IKzCB1vFdRM/B4gQCJCPMiaCMas8j42eq8lmM3r743QAg+qsWHI0NsJVt3OlDKdVhZrE2CHCDowSyniViOEi8AqgWFCDdwcIQCJxuJhwjlFalrqL+wDLt14nrQdbXlajBOiy2khIYeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4INoqj1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5ba363f1aso156034585a.0;
        Thu, 03 Apr 2025 11:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743706479; x=1744311279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMHBtl9xVpe2paA6VM6NhRj4hgDpCE/8p2jTkeAf0Ds=;
        b=C4INoqj1VnLKP958SUifjbGY++vGh3f15cmmtMGz3bQLZI37WQVXJHbqcWM2cdHRLI
         3HMwbXOFf0QBmQjiuMRBFZerbTqRdjpfz09evHFslHZVDe9ibveVUSCga+hnCXuklmX8
         jL+xdfy7Q9tE54NUkNZeymdB+mtEP5QjImUhaEBfQNtAYP7SbWoVgpQ88RRJwn7gXJhQ
         L5XvyfJGqurYQavR6ve514r0u1Ihe9GaGxBE2fuB0Yio5o16731kXSrxOLM83Iv6itpW
         hxCa8UjLY43BZK5NH9z/+wW9MITfOgSe045xI/2+SqxjhcIdPKpL+7C17AJzYAUWWOqZ
         JM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743706479; x=1744311279;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FMHBtl9xVpe2paA6VM6NhRj4hgDpCE/8p2jTkeAf0Ds=;
        b=KsBWkDyE3jYU03dFq96FKONBAnqBdPfqK5LpDtXI9aHo++6uBWrMCkQDduhRCJREfy
         9+/a71ivZV+c61rl3vbNpF4s2jBup1b5C9oeJ/nnJB8NieccWk2FgCXJidbhXDOqFeCl
         VpnU3pTfs6h0CAW+Onga7j5DwEGhZOQ/U+jzukMdPE1bK9LM+ReR4fF4x//aMT/CBS4N
         WktUPkclo0ALcBDh39v/OnYmL+P0zAzKmCUBOxz0dr6B00XZTnNsj1G8voXiXPHsQYBB
         uPwacLbidNoq6cw7vjcWdJP2eVZdX432pcEpFxyAglvDDtIrhlm055v+pYSmxerKxb/Q
         HKzg==
X-Forwarded-Encrypted: i=1; AJvYcCUW48xEAVLCBiH0PQBLU/ATC/0RbWRAPKC9SaRZxaDMFULKIgMm4f58ATQmtAikUTpM9hZu+Rrq@vger.kernel.org, AJvYcCXOkKXTcucBkmHHou86p0A4BgpFpMTCmi9pgmskd59vRMEh1V4JaNZbsrV6ClgdpEXXnHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO6ySjQltIx9u3gesDfOWaAzJcJfPY2+JDtjNfFJ9agl8bPyIw
	o26WjgkGAaOWw/1xIg3k3NCdpHW971/fTuZVOiLuaS6Lh9bx09Hl
X-Gm-Gg: ASbGncstSVXHrEbXF2GGH8nynn1mBSoIDig0jvK8TDz1WsWYZ0uaC+p973wS3ImyI8Y
	bqx670NtUtFsQbxnBJPX7OP4VHGb/Yq8kNQRf5/0LND8JcVnyppB8VOrT9PkqYmThcbHYJSlEBJ
	1AEYmj7PNpK2rpfUWaUFFEQMRZFqzHkBAnPqyDxJmto8UOU32yDj3lCzhLIi0wy26DYXvxgkhNH
	1aZyWD18lfviJ/fEQ2GSpd/6DAd0BLMLbGOUjCyz3F7tgZKRsaHJdca2Eg87rBNEyOS4GoAbFpo
	YPLUWCRd34WrlvH56UypoWmthMMtel1RApMWoKf2iFLo1EhbRoO1KMyvFJ7f3EK+6THuG7uuf81
	PIbXV0OdZWfTR8LkBz0KITQ==
X-Google-Smtp-Source: AGHT+IGimAQSATFXuluPG4ZScnHaw1NfaxvDSGwfLcrI5K0t2HAN7GsU2bY+68sJrVrZfDDPo5DHAA==
X-Received: by 2002:a05:620a:319f:b0:7c5:5800:ddba with SMTP id af79cd13be357-7c774d526ecmr51949485a.22.1743706478914;
        Thu, 03 Apr 2025 11:54:38 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76ea9022dsm109068585a.104.2025.04.03.11.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 11:54:38 -0700 (PDT)
Date: Thu, 03 Apr 2025 14:54:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TWFjaWVqIMW7ZW5jenlrb3dza2k=?= <maze@google.com>, 
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 john.fastabend@gmail.com, 
 Willem de Bruijn <willemb@google.com>, 
 Matt Moeller <moeller.matt@gmail.com>
Message-ID: <67eed96e15750_15e1b32945a@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANP3RGe8ZjcX8yGhCPs+Q1x7ijpGKthjawztFiXSeDQazgSrpA@mail.gmail.com>
References: <20250403140846.1268564-1-willemdebruijn.kernel@gmail.com>
 <20250403140846.1268564-2-willemdebruijn.kernel@gmail.com>
 <Z-7DiZWkOQ_n5aXw@mini-arch>
 <67eec501d0d58_14b7b229490@willemb.c.googlers.com.notmuch>
 <Z-7G8cBIW7-dVeH8@mini-arch>
 <CANP3RGe8ZjcX8yGhCPs+Q1x7ijpGKthjawztFiXSeDQazgSrpA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb
 frags
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
> On Thu, Apr 3, 2025 at 10:35=E2=80=AFAM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> >
> > On 04/03, Willem de Bruijn wrote:
> > > Stanislav Fomichev wrote:
> > > > On 04/03, Willem de Bruijn wrote:
> > > > > From: Willem de Bruijn <willemb@google.com>
> > > > >
> > > > > Classic BPF socket filters with SKB_NET_OFF and SKB_LL_OFF fail=
 to
> > > > > read when these offsets extend into frags.
> > > > >
> > > > > This has been observed with iwlwifi and reproduced with tun wit=
h
> > > > > IFF_NAPI_FRAGS. The below straightforward socket filter on UDP =
port,
> > > > > applied to a RAW socket, will silently miss matching packets.
> > > > >
> > > > >     const int offset_proto =3D offsetof(struct ip6_hdr, ip6_nxt=
);
> > > > >     const int offset_dport =3D sizeof(struct ip6_hdr) + offseto=
f(struct udphdr, dest);
> > > > >     struct sock_filter filter_code[] =3D {
> > > > >             BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_AD_OFF + =
SKF_AD_PKTTYPE),
> > > > >             BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, PACKET_HOST, 0,=
 4),
> > > > >             BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_NET_OFF +=
 offset_proto),
> > > > >             BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_UDP, 0,=
 2),
> > > > >             BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, SKF_NET_OFF +=
 offset_dport),
> > > > >
> > > > > This is unexpected behavior. Socket filter programs should be
> > > > > consistent regardless of environment. Silent misses are
> > > > > particularly concerning as hard to detect.
> > > > >
> > > > > Use skb_copy_bits for offsets outside linear, same as done for
> > > > > non-SKF_(LL|NET) offsets.
> > > > >
> > > > > Offset is always positive after subtracting the reference thres=
hold
> > > > > SKB_(LL|NET)_OFF, so is always >=3D skb_(mac|network)_offset. T=
he sum of
> > > > > the two is an offset against skb->data, and may be negative, bu=
t it
> > > > > cannot point before skb->head, as skb_(mac|network)_offset woul=
d too.
> > > > >
> > > > > This appears to go back to when frag support was introduced to
> > > > > sk_run_filter in linux-2.4.4, before the introduction of git.
> > > > >
> > > > > The amount of code change and 8/16/32 bit duplication are unfor=
tunate.
> > > > > But any attempt I made to be smarter saved very few LoC while
> > > > > complicating the code.
> > > > >
> > > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > > Link: https://lore.kernel.org/netdev/20250122200402.3461154-1-m=
aze@google.com/
> > > > > Link: https://elixir.bootlin.com/linux/2.4.4/source/net/core/fi=
lter.c#L244
> > > > > Reported-by: Matt Moeller <moeller.matt@gmail.com>
> > > > > Co-developed-by: Maciej =C5=BBenczykowski <maze@google.com>
> > > > > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> > > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > > ---
> > > > >  include/linux/filter.h |  3 --
> > > > >  kernel/bpf/core.c      | 21 ------------
> > > > >  net/core/filter.c      | 75 +++++++++++++++++++++++-----------=
--------
> > > > >  3 files changed, 42 insertions(+), 57 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > > > index f5cf4d35d83e..708ac7e0cd36 100644
> > > > > --- a/include/linux/filter.h
> > > > > +++ b/include/linux/filter.h
> > > > > @@ -1496,9 +1496,6 @@ static inline u16 bpf_anc_helper(const st=
ruct sock_filter *ftest)
> > > > >   }
> > > > >  }
> > > > >
> > > > > -void *bpf_internal_load_pointer_neg_helper(const struct sk_buf=
f *skb,
> > > > > -                                    int k, unsigned int size);=

> > > > > -
> > > > >  static inline int bpf_tell_extensions(void)
> > > > >  {
> > > > >   return SKF_AD_MAX;
> > > > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > > > index ba6b6118cf50..0e836b5ac9a0 100644
> > > > > --- a/kernel/bpf/core.c
> > > > > +++ b/kernel/bpf/core.c
> > > > > @@ -68,27 +68,6 @@
> > > > >  struct bpf_mem_alloc bpf_global_ma;
> > > > >  bool bpf_global_ma_set;
> > > > >
> > > > > -/* No hurry in this branch
> > > > > - *
> > > > > - * Exported for the bpf jit load helper.
> > > > > - */
> > > > > -void *bpf_internal_load_pointer_neg_helper(const struct sk_buf=
f *skb, int k, unsigned int size)
> > > > > -{
> > > > > - u8 *ptr =3D NULL;
> > > > > -
> > > > > - if (k >=3D SKF_NET_OFF) {
> > > > > -         ptr =3D skb_network_header(skb) + k - SKF_NET_OFF;
> > > > > - } else if (k >=3D SKF_LL_OFF) {
> > > > > -         if (unlikely(!skb_mac_header_was_set(skb)))
> > > > > -                 return NULL;
> > > > > -         ptr =3D skb_mac_header(skb) + k - SKF_LL_OFF;
> > > > > - }
> > > > > - if (ptr >=3D skb->head && ptr + size <=3D skb_tail_pointer(sk=
b))
> > > > > -         return ptr;
> > > > > -
> > > > > - return NULL;
> > > > > -}
> > > > > -
> > > > >  /* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE=
 */
> > > > >  enum page_size_enum {
> > > > >   __PAGE_SIZE =3D PAGE_SIZE
> > > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > > index bc6828761a47..b232b70dd10d 100644
> > > > > --- a/net/core/filter.c
> > > > > +++ b/net/core/filter.c
> > > > > @@ -221,21 +221,24 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struc=
t sk_buff *, skb, u32, a, u32, x)
> > > > >  BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb,=
 const void *,
> > > > >      data, int, headlen, int, offset)
> > > > >  {
> > > > > - u8 tmp, *ptr;
> > > > > + u8 tmp;
> > > > >   const int len =3D sizeof(tmp);
> > > > >
> > > > > - if (offset >=3D 0) {
> > > > > -         if (headlen - offset >=3D len)
> > > > > -                 return *(u8 *)(data + offset);
> > > > > -         if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > > > -                 return tmp;
> > > > > - } else {
> > > > > -         ptr =3D bpf_internal_load_pointer_neg_helper(skb, off=
set, len);
> > > > > -         if (likely(ptr))
> > > > > -                 return *(u8 *)ptr;
> > > >
> > > > [..]
> > > >
> > > > > + if (offset < 0) {
> > > > > +         if (offset >=3D SKF_NET_OFF)
> > > > > +                 offset +=3D skb_network_offset(skb) - SKF_NET=
_OFF;
> > > > > +         else if (offset >=3D SKF_LL_OFF && skb_mac_header_was=
_set(skb))
> > > > > +                 offset +=3D skb_mac_offset(skb) - SKF_LL_OFF;=

> > > > > +         else
> > > > > +                 return -EFAULT;
> > > > >   }
> > > >
> > > > nit: we now repeat the same logic three times, maybe still worth =
it to put it
> > > > into a helper? bpf_resolve_classic_offset or something.
> > >
> > > I definitely tried this in various ways. But since the core logic i=
s
> > > only four lines and there is an early return on error, no helper
> > > really simplifies anything. It just adds a layer of indirection and=

> > > more code in the end.
> >
> > More code, but at least it de-duplicates the logic of translating
> > SKF_XXX_OFF? Something like the following below, but yeah, a matter
> > of preference, up to you.

I see your point. No strong opinion from me. Will revise,
assuming you don't mind the workaround below:

> > static int bpf_skb_resolve_offset(skb, offset) {
> >         if (offset >=3D 0)
> >                 return offset;
> >
> >         if (offset >=3D SKF_NET_OFF)
> >                 offset +=3D skb_network_offset(skb) - SKF_NET_OFF;
> >         else if (offset >=3D SKF_LL_OFF && skb_mac_header_was_set(skb=
))
> >                 offset +=3D skb_mac_offset(skb) - SKF_LL_OFF;
> >
> >         return -1;
> > }
> >
> > BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const =
void *,
> >            data, int, headlen, int, offset)
> > {
> >         offset =3D bpf_skb_resolve_offset(skb, offset);
> >         if (offset < 0)
> >                 return -EFAULT;
> =

> this is incorrect, as offset can be legally negative here.

Yeah, this needs a special case like INT_MIN to communicate error,
or pass-by-value. Exactly the kind of workarounds that gave me pause.

