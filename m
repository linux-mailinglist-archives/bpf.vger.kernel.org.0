Return-Path: <bpf+bounces-57825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA63AB06CA
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 01:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EFD3A6BC5
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 23:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3346622CBEA;
	Thu,  8 May 2025 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEWk9IOm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E2928E0F
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746748252; cv=none; b=rqe7JGJNh+TygRHcwJA9Iwuie79cc0mljoeG0Ja1C4HrvID2hXWaBIlWqKzPDbzvEk/bFLJkWmyKCtK2KQUq8360GPzLexDHFHCgUDY91YeHUPvIE4p0GEeLLK3uTvfSVmT4axzn1iQi2i7/wUGT8nAKC2kF9NG9Yf18pKflBFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746748252; c=relaxed/simple;
	bh=CtdYmkNzDFP1XFwD37jkd6S3qDDKMab4Rzo/NesFUds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWm/A83fPAuim2e9fyqGmAyQJBHVngEaRQP/a1MF790+OZctKl/livdOXkntTFoJt3B/LxmDwwS0t9L5cmICxAHCWMMbW6z79DfBFLnD3GWIEwmf7ToIyyN6LL5g4NI9BfUiopztZ3/bD+joB7/EJu3hKTlzucLdH6SZqwdEvIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEWk9IOm; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5fbf52aad74so4059165a12.1
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746748249; x=1747353049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5KZw71pd/LX5wxq6gYpNHv5/K26NbpqNDyZKqPh3xI=;
        b=ZEWk9IOmRxq/bZLX9k4Z4oMA3m7I08m7fi8vHlXlnBq3PNI3l5m5HHTB6N0nr3bptA
         PnvNCogRj4zOM0R5/OVbE/LedqL0jS6LUMMP7offZjJD2Q0SUwkPPa6ccVtfIiP8QZdj
         Ms4A4Aood+VPoxwGV9dAaObRvcxnYH0Mgfg4mZRjz2BL04yn1XS1dTUm4kHq4jZyxKdf
         RX9lAr4iSlK6tnLj19lVkklyN8Ja+lbpwG1r+7rnYm98/qJaAx/yBiD7vNokVZ8OFWhJ
         SP5YSGU1ySLzb5qUVCAbAB3FBZci9sLfOn9NtmLx3Qv9em/BkQ2xh+82a1Xb8zEfP1Im
         gT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746748249; x=1747353049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5KZw71pd/LX5wxq6gYpNHv5/K26NbpqNDyZKqPh3xI=;
        b=wLh++i6LOoMsFN56KyoCGkL/vzIoIVP1gTuTc4ZWMxzYQaPU4KVpT5ISj3a64agNju
         /RZnJK0Zubdut+Vp+G4c02aO8qlrLmD56nyTSqDHNCgpSgcJwK+M0vE85dMmJndqCCRR
         M3SXE8LbnMwa8GLPsnRYAGrq/XZI9jgu/E4dsldpaZ4fHeO25TUyjktY+BYleXXeTviH
         Qa3FBM2C288nmfYTtSXaYXlixM8pHNJAzqH13qt5Q4nEAOHhTVItadC35ST8ZHtgSgGL
         o10E4KOqv/QCCswV33cryFM8p0x3rM5pfTWxKsJX/cGQBRyexc+8EOFKz+5+F/pT27VP
         E+NQ==
X-Gm-Message-State: AOJu0Yw8ZgskZba3bYxvgOV0ELmkNIJcglQJbobR0GNWeO8IPdVfepMk
	VNXxmLdn1GxUf7JHDjg7OWZdxk7Ay20AFOuoJpWRgZWMaExJ1yhP4vfYIYIkgLS/FAfu8TtLsyd
	O5yaDvD9TeVAMCyttc8yAWVZnTAk=
X-Gm-Gg: ASbGncu77O7hHCrRqebDe5Or7WgMCFmhlNzmftPbMMqxN7VoFvcb4R6oEmJiQwDQEle
	AXjk1tbjBaQdVA8E/0/+m9crcQ+7gPuMWNW+pyQz0USOgT6LAbR133XZ5VUvX5NKN0oK8Gbxfth
	Z7fLJ4NJlFqlN8kOYSSsRNfsbzDsPj5PM2/8LHsB6heV0jjxpvdF+mrrbw
X-Google-Smtp-Source: AGHT+IFh34ySBIYYo9mO4XTkIUfAQLR2f1ZaI/Zfc54vszFlERD+4mMG8NCZRCHfguQaFfzbNznR+umEwvi3mqtz7KU=
X-Received: by 2002:a17:907:2cc6:b0:ace:e863:cd8e with SMTP id
 a640c23a62f3a-ad1fcb7e462mr491015966b.14.1746748248948; Thu, 08 May 2025
 16:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-10-memxor@gmail.com>
 <CAADnVQKgUg38BhTF7dGa05474B+iqVPdwwvZu8Ab0cW00QX4Ag@mail.gmail.com> <CAP01T74eO188=KtxbTq-j2vgaYyiVf_jtCa4fObQJK9z89CsGQ@mail.gmail.com>
In-Reply-To: <CAP01T74eO188=KtxbTq-j2vgaYyiVf_jtCa4fObQJK9z89CsGQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 9 May 2025 01:50:12 +0200
X-Gm-Features: AX0GCFv8MWh6pCTF-6BUzvMFh1Ok1F2uRtVOs6WMcbLF0VWoBpH7NL5daxgb_Ws
Message-ID: <CAP01T74uU4LExZfefjtMWOyGcHV335g=D3uhK6N0QDTGL+k=TQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 09/11] libbpf: Add bpf_stream_printk() macro
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 9 May 2025 at 01:48, Kumar Kartikeya Dwivedi <memxor@gmail.com> wro=
te:
>
> On Fri, 9 May 2025 at 01:42, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, May 7, 2025 at 10:17=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Introduce a new macro that allows printing data similar to bpf_printk=
(),
> > > but to BPF streams. The first argument is the stream ID, the rest of =
the
> > > arguments are same as what one would pass to bpf_printk().
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  kernel/bpf/stream.c         | 10 +++++++--
> > >  tools/lib/bpf/bpf_helpers.h | 44 +++++++++++++++++++++++++++++++----=
--
> > >  2 files changed, 45 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> > > index eaf0574866b1..d64975486ad1 100644
> > > --- a/kernel/bpf/stream.c
> > > +++ b/kernel/bpf/stream.c
> > > @@ -257,7 +257,12 @@ __bpf_kfunc int bpf_stream_vprintk(struct bpf_st=
ream *stream, const char *fmt__s
> > >         return ret;
> > >  }
> > >
> > > -__bpf_kfunc struct bpf_stream *bpf_stream_get(enum bpf_stream_id str=
eam_id, void *aux__ign)
> > > +/* Use int vs enum stream_id here, we use this kfunc in bpf_helpers.=
h, and
> > > + * keeping enum stream_id necessitates a complete definition of enum=
, but we
> > > + * can't copy it in the header as it may conflict with the definitio=
n in
> > > + * vmlinux.h.
> > > + */
> > > +__bpf_kfunc struct bpf_stream *bpf_stream_get(int stream_id, void *a=
ux__ign)
> > >  {
> > >         struct bpf_prog_aux *aux =3D aux__ign;
> > >
> > > @@ -351,7 +356,8 @@ __bpf_kfunc struct bpf_stream_elem *bpf_stream_ne=
xt_elem(struct bpf_stream *stre
> > >         return elem;
> > >  }
> > >
> > > -__bpf_kfunc struct bpf_stream *bpf_prog_stream_get(enum bpf_stream_i=
d stream_id, u32 prog_id)
> > > +/* Use int vs enum bpf_stream_id for consistency with bpf_stream_get=
. */
> > > +__bpf_kfunc struct bpf_stream *bpf_prog_stream_get(int stream_id, u3=
2 prog_id)
> > >  {
> > >         struct bpf_stream *stream;
> > >         struct bpf_prog *prog;
> > > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.=
h
> > > index a50773d4616e..1a748c21e358 100644
> > > --- a/tools/lib/bpf/bpf_helpers.h
> > > +++ b/tools/lib/bpf/bpf_helpers.h
> > > @@ -314,17 +314,47 @@ enum libbpf_tristate {
> > >                           ___param, sizeof(___param));          \
> > >  })
> > >
> > > +struct bpf_stream;
> > > +
> > > +extern struct bpf_stream *bpf_stream_get(int stream_id, void *aux__i=
gn) __weak __ksym;
> > > +extern int bpf_stream_vprintk(struct bpf_stream *stream, const char =
*fmt__str, const void *args,
> > > +                             __u32 len__sz) __weak __ksym;
> > > +
> > > +#define __bpf_stream_vprintk(stream, fmt, args...)                  =
           \
> > > +({                                                                  =
           \
> > > +       static const char ___fmt[] =3D fmt;                          =
             \
> > > +       unsigned long long ___param[___bpf_narg(args)];              =
           \
> > > +                                                                    =
           \
> > > +       _Pragma("GCC diagnostic push")                               =
           \
> > > +       _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")       =
           \
> > > +       ___bpf_fill(___param, args);                                 =
           \
> > > +       _Pragma("GCC diagnostic pop")                                =
           \
> > > +                                                                    =
           \
> > > +       int ___id =3D stream;                                        =
             \
> > > +       struct bpf_stream *___sptr =3D bpf_stream_get(___id, NULL);  =
             \
> > > +       if (___sptr)                                                 =
           \
> > > +               bpf_stream_vprintk(___sptr, ___fmt, ___param, sizeof(=
___param));\
> > > +})
> >
> > Typically _get() is an acquire kfunc,
> > but here:
> >
> > +BTF_ID_FLAGS(func, bpf_stream_get, KF_RET_NULL)
> > ...
> > +BTF_ID_FLAGS(func, bpf_prog_stream_get, KF_ACQUIRE | KF_RET_NULL)
> >
> > This is odd and it makes above sequence look weird too.
> >
> > This is inconsistent as well:
> > bpf_stream_printk(int stream,
> > bpf_stream_vprintk(struct bpf_stream *stream,
> >
> > Existing helpers bpf_trace_printk() and bpf_trace_vprintk()
> > are consistent.
> >
> > Not sure why bpf_stream_get() is needed at all.
> >
> > Maybe
> > #define BPF_STDOUT ((struct bpf_stream *)1)
> > #define BPF_STDERR ((struct bpf_stream *)2)
> >
> > not pretty, but at least api will be consistent.
> >
> > Other ideas ?
>
> We can take the stream id directly in bpf_stream_vprintk, we have room
> for one more argument, that can be hidden prog->aux.
> Then we can drop bpf_stream_get.

Taking it directly does negate the ability to write into any stream *
one has access to, so there's that.

>
> Alternatively there's a way to call it bpf_stream_self.
> I wasn't concerned about inconsistency since bpf_stream_vprintk is not
> something people will use directly, you have to stuff arguments as array
> of u64 etc. so it's unusable in practice. The main API exposed is
> bpf_stream_printk. But I get the concern.

