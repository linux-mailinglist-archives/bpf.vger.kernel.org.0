Return-Path: <bpf+bounces-55347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD578A7C2FF
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 19:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410963BC39F
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACC121B185;
	Fri,  4 Apr 2025 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVL+A90f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FC9198E60
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789387; cv=none; b=A1jRpCpNdhUVk8SH4YlfqRVp2oHJS4glE3gk+MI9l0LA054cUmXyVn72JMnRuay7lDOcYX/GZlPdf29Jgmz2IwGBxkPbR052TGGj5aBO2fxlbCYVocS49IFzstVRwdcmM1+kKa0Pn0vfaQgdYakUrVgfzv/27ZmZ/h1J4Qldsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789387; c=relaxed/simple;
	bh=22aH86Q0wVXBcB/q8vctUJAHErCGmolHvGeE1DpYWk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjmWHVAKLxPsNbZrQ0Aie0fd9dya1/zSOpxcb9GhnTC75UbTljpTgF+nrBYjUCQV5A4ljrHE2Iv5l/ZX8G8RB8FjpilDF6v4/n53ciTxxRsFyAkPEoig14pp69LvsrK5JZ4xvZN6IwJmXV/5WD57Eit0TJT7BZ5ivBaehpebk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVL+A90f; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so1027a12.1
        for <bpf@vger.kernel.org>; Fri, 04 Apr 2025 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743789384; x=1744394184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YFrgY2gAlHEmfcXMSaIgv2l0S28YCpkRzIdoCb8QwE=;
        b=pVL+A90fEPkz8BhHDRMdE8wdE31Kt5ByM5/DgHq/wvKVikrZFGLvGmG7dvb+KvSe8x
         JYQ7XCjSk3CLlqwAqVu7hvgYelT/2Sf6Bh4eBuRaxnx/SWtU0Df9Uu/WYbHeRpAR+/r6
         biQQUSRf9POujzDRZGB4XIp38guoGAxBG78xHc1ZrDjrOnDwytAbCMIK8kjh2VPI/1Oo
         xKLikzLTlE84pqhHsJg7l32H8ct2HC87cNUQnt/exafGthkGlc1Fh3Z3KMdknCUH4/KH
         T/fSU5rJZr2WV8lTZrox84tVf19XDC3S6skWn+kvAtDtowNetayEDkjX7Fy6Lh4x1Pjf
         Qucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743789384; x=1744394184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YFrgY2gAlHEmfcXMSaIgv2l0S28YCpkRzIdoCb8QwE=;
        b=se+ogtx8JW5ozovjzsFUIzKrTpPWYn9nIJlf2oVPGlp7fDR4/8RyGEVczJbznIj8k8
         eXKWRA3b+P+w6kd0pPNby3R2Qhk773wmBej4kASCk3MXciEPvqQpZn6ziVCf3CTCYX9R
         mBDb8oM0VHDve+r7EfqfyfsqZWUX+5RaHcRVXO8sUTZIzWxlMRqvEPllXFGWGNSdfTPO
         XkHYEqD5Ec0N/JACE74Oa9ezOnCAe/ps+n9+tgSBJTX6zCGjZhpkwp58+FmXknwGJg2c
         vfNm1e1EczOVVP7GPVSkHo03euOVccq2M7gjSXVw0cd3yDqVkzFyfNnhmrSgzc4p94Aq
         C9Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVZbssPLPG2ilM141c9fiS/U9L4j8YZwXL34vATOf5mtKrY7ZTjEGq4KNbvAxlKeTUhe38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXIEUWzqqiPCrcCbnOwukPR36jrOzt8qLdl1ZxSH+TyVrHvS0
	1nV65tf5bUsGoFVGZK65QS8DigYLUSVusWIO+T65VWxJCr3V7tBmUqfkHI5zbdSx48qfOUr7LW+
	6Nr6df3TBvAFHfe+RZq+aT/Mb0PoZ+N1pyDPJP8J/fppkDR2aG0Uz
X-Gm-Gg: ASbGncvugYblsFdqoD0KVDhi0rk3dPNEQ42OYh3vdjA7D+BXHnVShQh+ToiuOzD2bxG
	vLYyKnLAn+kxuatDuyJ30VZYDnMYiEPYfXZpH5pJu0chniELadwGmU80BIZzRh7YSAeO7wdA+kl
	yo/0cpdu2dTV0FR3eYa6Z5fJlJpPF+Fj+UXGfwzneskKrporVSJOetvj05jC6X
X-Google-Smtp-Source: AGHT+IGNYnu6CmniYalnIwdLfDAkRiwxbYqPLUDw2jIOM+zZA0rSPIHrPSyPb7Aq570qCJLuyBzJskjw5wFAMdqvF90=
X-Received: by 2002:a50:9f6a:0:b0:5e5:606e:d5a8 with SMTP id
 4fb4d7f45d1cf-5f0dc0fc2f2mr273a12.4.1743789383400; Fri, 04 Apr 2025 10:56:23
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404142633.1955847-1-willemdebruijn.kernel@gmail.com>
 <20250404142633.1955847-2-willemdebruijn.kernel@gmail.com>
 <584071a3-10df-443a-ad8c-1fa7bc82d821@iogearbox.net> <CAF=yD-+ccY58AAneA7tLokuUahrj=8cdDtPPopGH0h8mK-hMbQ@mail.gmail.com>
In-Reply-To: <CAF=yD-+ccY58AAneA7tLokuUahrj=8cdDtPPopGH0h8mK-hMbQ@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 4 Apr 2025 10:56:11 -0700
X-Gm-Features: ATxdqUGYeJ236m-e5DWJLDmtwn5Ot8c5nZAkVJohc-Qo4w7SgikttKCOCMHTM58
Message-ID: <CANP3RGdQNt5Qn9APrUh7V+r2RKoBx9KtzpDfres0wf+UZMeedg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	ast@kernel.org, john.fastabend@gmail.com, 
	Willem de Bruijn <willemb@google.com>, Matt Moeller <moeller.matt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 9:34=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Fri, Apr 4, 2025 at 12:11=E2=80=AFPM Daniel Borkmann <daniel@iogearbox=
.net> wrote:
> >
> > Hi Willem,
> >
> > On 4/4/25 4:23 PM, Willem de Bruijn wrote:
> > [...]
> > > v1->v2
> > >    - introduce bfp_skb_load_helper_convert_offset to avoid open codin=
g
> > > ---
> > >   include/linux/filter.h |  3 --
> > >   kernel/bpf/core.c      | 21 -----------
> > >   net/core/filter.c      | 80 +++++++++++++++++++++++----------------=
---
> > >   3 files changed, 44 insertions(+), 60 deletions(-)
> > >
> > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > index f5cf4d35d83e..708ac7e0cd36 100644
> > > --- a/include/linux/filter.h
> > > +++ b/include/linux/filter.h
> > > @@ -1496,9 +1496,6 @@ static inline u16 bpf_anc_helper(const struct s=
ock_filter *ftest)
> > >       }
> > >   }
> > >
> > > -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb=
,
> > > -                                        int k, unsigned int size);
> > > -
> > >   static inline int bpf_tell_extensions(void)
> > >   {
> > >       return SKF_AD_MAX;
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index ba6b6118cf50..0e836b5ac9a0 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -68,27 +68,6 @@
> > >   struct bpf_mem_alloc bpf_global_ma;
> > >   bool bpf_global_ma_set;
> > >
> > > -/* No hurry in this branch
> > > - *
> > > - * Exported for the bpf jit load helper.
> > > - */
> > > -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb=
, int k, unsigned int size)
> > > -{
> > > -     u8 *ptr =3D NULL;
> > > -
> > > -     if (k >=3D SKF_NET_OFF) {
> > > -             ptr =3D skb_network_header(skb) + k - SKF_NET_OFF;
> > > -     } else if (k >=3D SKF_LL_OFF) {
> > > -             if (unlikely(!skb_mac_header_was_set(skb)))
> > > -                     return NULL;
> > > -             ptr =3D skb_mac_header(skb) + k - SKF_LL_OFF;
> > > -     }
> > > -     if (ptr >=3D skb->head && ptr + size <=3D skb_tail_pointer(skb)=
)
> > > -             return ptr;
> > > -
> > > -     return NULL;
> > > -}
> >
> > Wouldn't this break sparc 32bit JIT which still calls into this?
> >
> > arch/sparc/net/bpf_jit_asm_32.S :
> >
> > #define bpf_negative_common(LEN)                        \
> >          save    %sp, -SAVE_SZ, %sp;                     \
> >          mov     %i0, %o0;                               \
> >          mov     r_OFF, %o1;                             \
> >          SIGN_EXTEND(%o1);                               \
> >          call    bpf_internal_load_pointer_neg_helper;   \
> >           mov    (LEN), %o2;                             \
> >          mov     %o0, r_TMP;                             \
> >          cmp     %o0, 0;                                 \
> >          BE_PTR(bpf_error);                              \
> >           restore;
>
> Argh, good catch. Thanks Daniel.
>
> I'll drop the removal of bpf_internal_load_pointer_neg_helper from the pa=
tch.

add a 'deprecated only used by sparc32 comment'

hopefully someone that knows sparc32 assembly can fix it

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

