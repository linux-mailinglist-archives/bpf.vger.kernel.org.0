Return-Path: <bpf+bounces-49534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0BDA19A0F
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 21:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CFA16A21D
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 20:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEC51C1F22;
	Wed, 22 Jan 2025 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNOAU/UP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCCF1BBBFE
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737579499; cv=none; b=CARkDd8UMKdaFlmGaQUUiGzS8zZS09bNIxXhPVEH3ZMsfcirHcUwVXkUf1XK/YVVM//IjYLTYrqkiZh+tLqwTD11xDJBWQRhWp34u1LDLtWxZYNcTVWTjS2AZTOKgHERtHt3JzibVYQJEy7XaKib3TrIu35pfLepImB89wUZw64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737579499; c=relaxed/simple;
	bh=j3SvFoot4uN0mbJlN+dO5JhFkAlt6Suo7IzxTEjZu6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJQr2I3IPRplnHghvx8MUYm8xrfr77jDzMa9YkbAcuz+6l+X/y+S+9W5CXxNAIiIrELtjoediYOw6fNzwD9N+hg02rZvS3vjSuz4y2NZwU4fgXFlPFx5Rp58GkGoDOZhI66HhWRtnSiRn8qoCLZbBDdiuHX0jyw7+z4yJIYItn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNOAU/UP; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d442f9d285so408a12.1
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 12:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737579496; x=1738184296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qrFKq7bSwHWP1Qe5M7KUc1mcCCLWJA9iKcyrls34GM=;
        b=hNOAU/UPQvh2oG+6xE2Bazm26GwhSChuHGeeB1JQ47KdVfTG6xgzyK/QVG8+BpgmTX
         JFDHkKmhHbMQdVgt2419esq2bazf15OYpMp08MP/yF/aKz9Z1MJuPAEJ02Fu/RuacqC3
         cvy9YY8hOe1gi7al4lAf1rCFp08XMSnDjLiCrumBPp/zK0z/sFqDgcDYwg7lDXkvY9pF
         1qEC6i/03kDTH63A8KlGlYr6cUeiSNQ4EOgVLzOYbHt2zuFD3XxSuWuwQVNTWDlUlzRK
         8kLCeZABupm3Jfg7YSYY1E+SoKeVH7jsbpGlE3AY0RcavJCWwQn8iNJNepD7vFi1ZPbQ
         S2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737579496; x=1738184296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qrFKq7bSwHWP1Qe5M7KUc1mcCCLWJA9iKcyrls34GM=;
        b=pIN7zF6h4UCzsQOKlUfRN4Q94dYK0C/7ag3dp8MKN2H5KOHrKlaMyIbSGkwglzVjEc
         0y8Z7SJAhzscpsda2m2M0AIPDcy+sUs0XnFgtac3l7S94jOXWPMjJfpEJZDG+hpzpgoE
         +9XVw6AUjofqYn0IeMhHRXVshyem9FDEoXvQKYjFk06QA4Ahy/ntE8PL3bHIvMMnWUis
         /bLcJwiZPTK2gCcgwc62q2Ava8Pevd6bx+BGLhu/ebIfgTlt7NWwGIMXlbbdKve13jR4
         udBDTWHqAH+YPXQfySR/GvyW/BXGInyRXpBNLNDUdo83kwXvv9vqiF1f77h0063pA/NI
         wYBA==
X-Forwarded-Encrypted: i=1; AJvYcCWQKU40lAd09LWNFoYsykiByEEDXBiyVgtyi0eUwb8vwlsy96Ft/r7Kzy6p8rMG5TWSl5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9MFnTqbr750sL5CpNihr3Jvyn84nrwLH8GzW2OJeGZsqXjsW
	6GeoqR2v8Y51Y9wXsLc2DwjSt3BE09FSgaJhsonGoHYew7zxmxH5AJohUOzgAVtj3EKpJVGzfxl
	3VjylTF/UfzVEBHi4hb2br0eTSKCmb+y7kmQp
X-Gm-Gg: ASbGnctTnpqiB56csn54xuLEYPjDrUSArPsuLLwKC+KS5jFhTZ3ywmwDpOF4s/2e/3D
	/8ahAcqXggqTzgyRa9fUMUVI8ZddpQqohVIlwNffUv34KpaM6ebXnoUOJUE8sIwl/5Vz5ugM6QR
	ox/ZiOEA==
X-Google-Smtp-Source: AGHT+IGQ81yR89ala+e95+DG8BbiczVdMDRLifX2ZDD3B1UBMMExq88dURe2RLuZHEeiGvHn5xDDLlfz7b5XqkNHXNE=
X-Received: by 2002:a50:aa97:0:b0:5d9:5a5c:f2f9 with SMTP id
 4fb4d7f45d1cf-5dc09f9afcfmr13777a12.7.1737579495782; Wed, 22 Jan 2025
 12:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122200402.3461154-1-maze@google.com> <CANP3RGe_cspCzYe_scA37Hgr0GNbASmN94RRnPRUT1YiBcn=eg@mail.gmail.com>
 <CANP3RGc7-ZkQ2xGtkW00+A+zcWpm4WdMEbSn=UjotBQHzO+f7w@mail.gmail.com>
In-Reply-To: <CANP3RGc7-ZkQ2xGtkW00+A+zcWpm4WdMEbSn=UjotBQHzO+f7w@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Wed, 22 Jan 2025 12:58:02 -0800
X-Gm-Features: AbW1kvY1tJgxFyhp1iZHXBmRZPIitcVNmePNwA-x4HwxIXspz5D5zYsxbmosD6U
Message-ID: <CANP3RGeE4T8a9Mn4+tAKkGU8BaCrt5tu89aQt2dzq4DzNXbb4w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix classic bpf reads from negative offset
 outside of linear skb portion
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Matt Moeller <moeller.matt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 12:28=E2=80=AFPM Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
>
> On Wed, Jan 22, 2025 at 12:16=E2=80=AFPM Maciej =C5=BBenczykowski
> <zenczykowski@gmail.com> wrote:
> >
> > On Wed, Jan 22, 2025 at 12:04=E2=80=AFPM Maciej =C5=BBenczykowski <maze=
@google.com> wrote:
> > >
> > > We're received reports of cBPF code failing to accept DHCP packets.
> > > "BPF filter for DHCP not working (android14-6.1-lts + android-14.0.0_=
r74)"
> > >
> > > The relevant Android code is at:
> > >   https://cs.android.com/android/platform/superproject/main/+/main:pa=
ckages/modules/NetworkStack/jni/network_stack_utils_jni.cpp;l=3D95;drc=3D9d=
f50aef1fd163215dcba759045706253a5624f5
> > > which uses a lot of macros from:
> > >   https://cs.android.com/android/platform/superproject/main/+/main:pa=
ckages/modules/Connectivity/bpf/headers/include/bpf/BpfClassic.h;drc=3Dc58c=
fb7c7da257010346bd2d6dcca1c0acdc8321
> > >
> > > This is widely used and does work on the vast majority of drivers,
> > > but is exposing a core kernel cBPF bug related to driver skb layout.
> > >
> > > Root cause is iwlwifi driver, specifically on (at least):
> > >   Dell 7212: Intel Dual Band Wireless AC 8265
> > >   Dell 7220: Intel Wireless AC 9560
> > >   Dell 7230: Intel Wi-Fi 6E AX211
> > > delivers frames where the UDP destination port is not in the skb line=
ar
> > > portion, while the cBPF code is using SKF_NET_OFF relative addressing=
.
> > >
> > > simplified from above, effectively:
> > >   BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, SKF_NET_OFF)
> > >   BPF_STMT(BPF_LD  | BPF_H | BPF_IND, SKF_NET_OFF + 2)
> > >   BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 68, 1, 0)
> > >   BPF_STMT(BPF_RET | BPF_K, 0)
> > >   BPF_STMT(BPF_RET | BPF_K, 0xFFFFFFFF)
> > > fails to match udp dport=3D68 packets.
> > >
> > > Specifically the 3rd cBPF instruction fails to match the condition:
> >
> > 2nd of course
> >
> > >   if (ptr >=3D skb->head && ptr + size <=3D skb_tail_pointer(skb))
> > > within bpf_internal_load_pointer_neg_helper() and thus returns NULL,
> > > which results in reading -EFAULT.
> > >
> > > This is because bpf_skb_load_helper_{8,16,32} don't include the
> > > "data past headlen do skb_copy_bits()" logic from the non-negative
> > > offset branch in the negative offset branch.
> > >
> > > Note: I don't know sparc assembly, so this doesn't fix sparc...
> > > ideally we should just delete bpf_internal_load_pointer_neg_helper()
> > > This seems to have always been broken (but not pre-git era, since
> > > obviously there was no eBPF helpers back then), but stuff older
> > > than 5.4 is no longer LTS supported anyway, so using 5.4 as fixes tag=
.
> > >
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > > Cc: Willem de Bruijn <willemb@google.com>
> > > Reported-by: Matt Moeller <moeller.matt@gmail.com>
> > > Closes: https://issuetracker.google.com/384636719 [Treble - GKI partn=
er internal]
> > > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> > > Fixes: 219d54332a09 ("Linux 5.4")
> > > ---
> > >  include/linux/filter.h |  2 ++
> > >  kernel/bpf/core.c      | 14 +++++++++
> > >  net/core/filter.c      | 69 +++++++++++++++++-----------------------=
--
> > >  3 files changed, 43 insertions(+), 42 deletions(-)
> > >
> > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > index a3ea46281595..c24d8e338ce4 100644
> > > --- a/include/linux/filter.h
> > > +++ b/include/linux/filter.h
> > > @@ -1479,6 +1479,8 @@ static inline u16 bpf_anc_helper(const struct s=
ock_filter *ftest)
> > >  void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb=
,
> > >                                            int k, unsigned int size);
> > >
> > > +int bpf_internal_neg_helper(const struct sk_buff *skb, int k);
> > > +
> > >  static inline int bpf_tell_extensions(void)
> > >  {
> > >         return SKF_AD_MAX;
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index da729cbbaeb9..994988dabb97 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -89,6 +89,20 @@ void *bpf_internal_load_pointer_neg_helper(const s=
truct sk_buff *skb, int k, uns
> > >         return NULL;
> > >  }
> > >
> > > +int bpf_internal_neg_helper(const struct sk_buff *skb, int k)
> > > +{
> > > +       if (k >=3D 0)
> > > +               return k;
> > > +       if (k >=3D SKF_NET_OFF)
> > > +               return skb->network_header + k - SKF_NET_OFF;
> > > +       if (k >=3D SKF_LL_OFF) {
> > > +               if (unlikely(!skb_mac_header_was_set(skb)))
> > > +                       return -1;
> > > +               return skb->mac_header + k - SKF_LL_OFF;
> > > +       }
> > > +       return -1;
> > > +}
> > > +
> > >  /* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE */
> > >  enum page_size_enum {
> > >         __PAGE_SIZE =3D PAGE_SIZE
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index e56a0be31678..609ef7df71ce 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -221,21 +221,16 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_b=
uff *, skb, u32, a, u32, x)
> > >  BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const=
 void *,
> > >            data, int, headlen, int, offset)
> > >  {
> > > -       u8 tmp, *ptr;
> > > -       const int len =3D sizeof(tmp);
> > > -
> > > -       if (offset >=3D 0) {
> > > -               if (headlen - offset >=3D len)
> > > -                       return *(u8 *)(data + offset);
> > > -               if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > -                       return tmp;
> > > -       } else {
> > > -               ptr =3D bpf_internal_load_pointer_neg_helper(skb, off=
set, len);
> > > -               if (likely(ptr))
> > > -                       return *(u8 *)ptr;
> > > -       }
> > > +       u8 tmp;
> > >
> > > -       return -EFAULT;
> > > +       offset =3D bpf_internal_neg_helper(skb, offset);
> > > +       if (unlikely(offset < 0))
> > > +               return -EFAULT;
> > > +       if (headlen - offset >=3D sizeof(u8))
> > > +               return *(u8 *)(data + offset);
> > > +       if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > +               return -EFAULT;
> > > +       return tmp;
> > >  }
> > >
> > >  BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, s=
kb,
> > > @@ -248,21 +243,16 @@ BPF_CALL_2(bpf_skb_load_helper_8_no_cache, cons=
t struct sk_buff *, skb,
> > >  BPF_CALL_4(bpf_skb_load_helper_16, const struct sk_buff *, skb, cons=
t void *,
> > >            data, int, headlen, int, offset)
> > >  {
> > > -       __be16 tmp, *ptr;
> > > -       const int len =3D sizeof(tmp);
> > > +       __be16 tmp;
> > >
> > > -       if (offset >=3D 0) {
> > > -               if (headlen - offset >=3D len)
> > > -                       return get_unaligned_be16(data + offset);
> > > -               if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > -                       return be16_to_cpu(tmp);
> > > -       } else {
> > > -               ptr =3D bpf_internal_load_pointer_neg_helper(skb, off=
set, len);
> > > -               if (likely(ptr))
> > > -                       return get_unaligned_be16(ptr);
> > > -       }
> > > -
> > > -       return -EFAULT;
> > > +       offset =3D bpf_internal_neg_helper(skb, offset);
> > > +       if (unlikely(offset < 0))
> > > +               return -EFAULT;
> > > +       if (headlen - offset >=3D sizeof(__be16))
> > > +               return get_unaligned_be16(data + offset);
> > > +       if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > +               return -EFAULT;
> > > +       return be16_to_cpu(tmp);
> > >  }
> > >
> > >  BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, =
skb,
> > > @@ -275,21 +265,16 @@ BPF_CALL_2(bpf_skb_load_helper_16_no_cache, con=
st struct sk_buff *, skb,
> > >  BPF_CALL_4(bpf_skb_load_helper_32, const struct sk_buff *, skb, cons=
t void *,
> > >            data, int, headlen, int, offset)
> > >  {
> > > -       __be32 tmp, *ptr;
> > > -       const int len =3D sizeof(tmp);
> > > -
> > > -       if (likely(offset >=3D 0)) {
> > > -               if (headlen - offset >=3D len)
> > > -                       return get_unaligned_be32(data + offset);
> > > -               if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > -                       return be32_to_cpu(tmp);
> > > -       } else {
> > > -               ptr =3D bpf_internal_load_pointer_neg_helper(skb, off=
set, len);
> > > -               if (likely(ptr))
> > > -                       return get_unaligned_be32(ptr);
> > > -       }
> > > +       __be32 tmp;
> > >
> > > -       return -EFAULT;
> > > +       offset =3D bpf_internal_neg_helper(skb, offset);
> > > +       if (unlikely(offset < 0))
> > > +               return -EFAULT;
> > > +       if (headlen - offset >=3D sizeof(__be32))
> > > +               return get_unaligned_be32(data + offset);
> > > +       if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > +               return -EFAULT;
> > > +       return be32_to_cpu(tmp);
> > >  }
> > >
> > >  BPF_CALL_2(bpf_skb_load_helper_32_no_cache, const struct sk_buff *, =
skb,
> > > --
> > > 2.48.1.262.g85cc9f2d1e-goog
> > >
> >
> > Note: this is currently only compile and boot tested.
> > Which doesn't prove all that much ;-)
>
> Furthermore even after cherrypicking this (or a similar style fix)
> into older LTS:
> - sparc jit is (presumably, maybe only 32-bit) still broken, as the
> assembly uses the old function
> - same for mips jit on 5.4/5.10/5.15
> - same for powerpc jit on 5.4/5.10
>
> (but I would guess we don't care)

and Willem points out that:

"skb->network_header is an offset against head, while the
get_unaligned_be16 and skb_copy_bits take an offset relative to data.

I did check yesterday that skb_copy_bits can take negative offsets, in
case a protocol header (e.g., SKF_LL_OFF) is smaller than skb->data."

which makes me think this approach is possibly (likely?) incorrect?
skb offsets always leave me confused...

