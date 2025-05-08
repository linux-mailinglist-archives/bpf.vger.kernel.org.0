Return-Path: <bpf+bounces-57824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 648ECAB06C2
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 01:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B480C1BA20B8
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 23:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A43A2101BD;
	Thu,  8 May 2025 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aenbhw6g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D615A848
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746748145; cv=none; b=LJKv3Ypesqql05P3veqj2gRs/+r56DdS9EqEjMhpVRCBD0ZQrb999mG4HXib1o9iO7fl4TM0ChlDhipdtaoPH0NvNzIKaQA7U/z7JYWGiOmUhSVnsgzJGTWjYr2eEKrP+M31ugGJIH2awTEdkkDCWISBtBYuWX9RXCzB7wF5K0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746748145; c=relaxed/simple;
	bh=33vRaw5G9llZ549OqZpne+zUTmEF2GUXXZX3KQk6kmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akwwX4cIs8JpcwI+2BAq6IIbZ9BmIDHMdMvAAkKaTg73Z++gdkw3gPq28xumQY6qG9jGHFKgP1t0UBwvRCvQKwy9u1GseKIAuyN0sGgw6Z0G+qpzZl38mlvB26cvSf2GLKRU6OpvzcM5H+bIW2Z8MTyl7YqpfDLNxED8qRV34a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aenbhw6g; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ace3b03c043so245239966b.2
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 16:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746748142; x=1747352942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ6n4t4GEIBtDKH66IjXwIO8SJEzOiT9v5pfAMYBtPc=;
        b=Aenbhw6g04I4GRWk85YIW3snaKQl1fiSK3klnROzOCANXRYz+HwEN/S97ffEueToGY
         aNoUZGiF7MXlq47Vab052dzzZDl3QP83hRiSlbYyAOq8cYF3lyIYtsTHr3sk7IVvuWEm
         FqQS2i5znohkBmEZxbBrR7+8sDWWDoK3t4orU2+SmDqH30OZNR2Z3qOXIc/y8q+k8Gnb
         54ypEJFSPjRkPOXB8e9wn9FkZhiqIEHWfipraTmnqOKs8d3FD05uksltQNcldaOe/mq5
         hE8sjekfpbifY1t24308GS2fmMbbgxcTiar0krgkEgaLrqmHz5jL4KoZMD3OqxWLaT+o
         ohQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746748142; x=1747352942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ6n4t4GEIBtDKH66IjXwIO8SJEzOiT9v5pfAMYBtPc=;
        b=moaB9u6C9tG+jJPSEhUZewioiulOXWg/RO2S4i+ymXSrRRmu6eeTRX4Zhe3iXoF3Fr
         DJkzogkv7XkGayOkbX0WV2FssQxecs68c1ihgkbEimEcKExliAcukuuIyjF91y8CeowL
         308eE1VsnxQ234H9j5ymX7TsVHUquuqVBeEzIz5xAWFfOna9IBBgXJ1skpP107WzlG6H
         NV/b11mkr/wzZXcIG/Eq87FgsyxVSYWpugTLAIOSDvpZchqN7pCZLrOA+po+7f2x7Sl3
         gBQhiLH2A9pRhrCQRoTI8lbnoILDosRXPqYvN7dDek7nhlwWI01l6uts0DKB12w4If0E
         bdnQ==
X-Gm-Message-State: AOJu0Yy+IdH1mFI9U7vyVzYL5w/2QvK+r/B6JuGHbTz2FP373SYx06Cl
	kuCPlHJLZT6s6vfXDKCptYLrVfRs/bL7Nxa6GNgjKds6ElbQPDG9JW7AJzC6QExQ3rpJCg734D0
	Azql+aun/nQlBOoVujSFPQabRnF9b2jhc
X-Gm-Gg: ASbGncuxKdOkyrQ37ph2ODYPThvl3insu4w2HPmmXwCuYFEIp4iObuv8FR2ta+uvG+2
	5AlCAYwZFy2Bpz8Qdu4xDyNVm/JikcXbCd8N+1uTFxMTRLLNM4PpR3XrdI9ke36bWhTn4Saf3Wm
	QwDzgiADA58mRISw3nWZOyl6zu/ycqIyIkM6O70s1MAnMbwfKkVbVUzi/I4lrxdI9r4tU=
X-Google-Smtp-Source: AGHT+IFQZ23MOKan11AiL1nOtjbsR5IUnMlhfgHqP6+6DWHPu/nYvJolPv3bEy4/wRRQMyPk/7aMk7XVWMbBrFXyjTI=
X-Received: by 2002:a17:907:a0ca:b0:acf:b8:f5d2 with SMTP id
 a640c23a62f3a-ad219007735mr166074566b.36.1746748142097; Thu, 08 May 2025
 16:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-10-memxor@gmail.com>
 <CAADnVQKgUg38BhTF7dGa05474B+iqVPdwwvZu8Ab0cW00QX4Ag@mail.gmail.com>
In-Reply-To: <CAADnVQKgUg38BhTF7dGa05474B+iqVPdwwvZu8Ab0cW00QX4Ag@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 9 May 2025 01:48:25 +0200
X-Gm-Features: AX0GCFvk5jim8liAQRDKxPE9P8-Wm_pMMUmqd_ubC2UpbYrs1IyX2nEng6nbHMU
Message-ID: <CAP01T74eO188=KtxbTq-j2vgaYyiVf_jtCa4fObQJK9z89CsGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 09/11] libbpf: Add bpf_stream_printk() macro
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 9 May 2025 at 01:42, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 7, 2025 at 10:17=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Introduce a new macro that allows printing data similar to bpf_printk()=
,
> > but to BPF streams. The first argument is the stream ID, the rest of th=
e
> > arguments are same as what one would pass to bpf_printk().
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/stream.c         | 10 +++++++--
> >  tools/lib/bpf/bpf_helpers.h | 44 +++++++++++++++++++++++++++++++------
> >  2 files changed, 45 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> > index eaf0574866b1..d64975486ad1 100644
> > --- a/kernel/bpf/stream.c
> > +++ b/kernel/bpf/stream.c
> > @@ -257,7 +257,12 @@ __bpf_kfunc int bpf_stream_vprintk(struct bpf_stre=
am *stream, const char *fmt__s
> >         return ret;
> >  }
> >
> > -__bpf_kfunc struct bpf_stream *bpf_stream_get(enum bpf_stream_id strea=
m_id, void *aux__ign)
> > +/* Use int vs enum stream_id here, we use this kfunc in bpf_helpers.h,=
 and
> > + * keeping enum stream_id necessitates a complete definition of enum, =
but we
> > + * can't copy it in the header as it may conflict with the definition =
in
> > + * vmlinux.h.
> > + */
> > +__bpf_kfunc struct bpf_stream *bpf_stream_get(int stream_id, void *aux=
__ign)
> >  {
> >         struct bpf_prog_aux *aux =3D aux__ign;
> >
> > @@ -351,7 +356,8 @@ __bpf_kfunc struct bpf_stream_elem *bpf_stream_next=
_elem(struct bpf_stream *stre
> >         return elem;
> >  }
> >
> > -__bpf_kfunc struct bpf_stream *bpf_prog_stream_get(enum bpf_stream_id =
stream_id, u32 prog_id)
> > +/* Use int vs enum bpf_stream_id for consistency with bpf_stream_get. =
*/
> > +__bpf_kfunc struct bpf_stream *bpf_prog_stream_get(int stream_id, u32 =
prog_id)
> >  {
> >         struct bpf_stream *stream;
> >         struct bpf_prog *prog;
> > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> > index a50773d4616e..1a748c21e358 100644
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
> > @@ -314,17 +314,47 @@ enum libbpf_tristate {
> >                           ___param, sizeof(___param));          \
> >  })
> >
> > +struct bpf_stream;
> > +
> > +extern struct bpf_stream *bpf_stream_get(int stream_id, void *aux__ign=
) __weak __ksym;
> > +extern int bpf_stream_vprintk(struct bpf_stream *stream, const char *f=
mt__str, const void *args,
> > +                             __u32 len__sz) __weak __ksym;
> > +
> > +#define __bpf_stream_vprintk(stream, fmt, args...)                    =
         \
> > +({                                                                    =
         \
> > +       static const char ___fmt[] =3D fmt;                            =
           \
> > +       unsigned long long ___param[___bpf_narg(args)];                =
         \
> > +                                                                      =
         \
> > +       _Pragma("GCC diagnostic push")                                 =
         \
> > +       _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")         =
         \
> > +       ___bpf_fill(___param, args);                                   =
         \
> > +       _Pragma("GCC diagnostic pop")                                  =
         \
> > +                                                                      =
         \
> > +       int ___id =3D stream;                                          =
           \
> > +       struct bpf_stream *___sptr =3D bpf_stream_get(___id, NULL);    =
           \
> > +       if (___sptr)                                                   =
         \
> > +               bpf_stream_vprintk(___sptr, ___fmt, ___param, sizeof(__=
_param));\
> > +})
>
> Typically _get() is an acquire kfunc,
> but here:
>
> +BTF_ID_FLAGS(func, bpf_stream_get, KF_RET_NULL)
> ...
> +BTF_ID_FLAGS(func, bpf_prog_stream_get, KF_ACQUIRE | KF_RET_NULL)
>
> This is odd and it makes above sequence look weird too.
>
> This is inconsistent as well:
> bpf_stream_printk(int stream,
> bpf_stream_vprintk(struct bpf_stream *stream,
>
> Existing helpers bpf_trace_printk() and bpf_trace_vprintk()
> are consistent.
>
> Not sure why bpf_stream_get() is needed at all.
>
> Maybe
> #define BPF_STDOUT ((struct bpf_stream *)1)
> #define BPF_STDERR ((struct bpf_stream *)2)
>
> not pretty, but at least api will be consistent.
>
> Other ideas ?

We can take the stream id directly in bpf_stream_vprintk, we have room
for one more argument, that can be hidden prog->aux.
Then we can drop bpf_stream_get.

Alternatively there's a way to call it bpf_stream_self.
I wasn't concerned about inconsistency since bpf_stream_vprintk is not
something people will use directly, you have to stuff arguments as array
of u64 etc. so it's unusable in practice. The main API exposed is
bpf_stream_printk. But I get the concern.

