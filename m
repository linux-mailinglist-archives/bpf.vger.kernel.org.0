Return-Path: <bpf+bounces-61387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA54AE6BEF
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC031BC63BB
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 16:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68573299AAF;
	Tue, 24 Jun 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPN7MEhX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160054C83
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780793; cv=none; b=fZfUZL/uVcJ9KfcA11XFJn8ESX8mYfP2sB9oYDMP+p+V2n6sypIJW32WrYlImVa69Gd7d8p4ACYFEfZmz/42V/dKBniiYstGhWzTzCduwvzp2lpC2gTVoari/4oVltdP06LnYZleqJlXcokrWE1GrCtrK+S6xD/42+6ZlxGWCjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780793; c=relaxed/simple;
	bh=WSpjcYdve1oK9XbChweV2Jltym/er04HF4dPWXNNx84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bmr25tQGi5DEYS4xb6e9Zdx53W0A1Zgdw2vyMj5l9go7CDLqCjBmwWpSPpET7YEbtOTy1IqxcebaLEfLYyguqCELGFmgNyRcYJcuMufxJmawH81RONGgahnHG1kiG4/VDe//CrIdb5RR5tyTTX5GD1RQ+mhuTzVI6fyue7KSwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPN7MEhX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so5591f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750780789; x=1751385589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK+cMbqbAVYx+rEjsrUKTRwMkJm3OBJIDn6u/jptIc8=;
        b=PPN7MEhXU8L73kaKKeLeRFQDE6UeBOf7Mt75NW9zhxMCg+qK6npNm0OGhFh+Mehrow
         z6T6eFlqgRYkPK5PA8t1KM380i++Jnq/2SNjtrqnGCYcJDYDtAb5jGtvUgFfKZmZJvel
         g6RPWg1FTfQVEsHozHyr2BDCYkvzpmTlPLoWw3Fh97ODhzITb8LMJUlUzJJpIIztW4JM
         cshxfPXX3TiOYBPgFh0YAu1ueeLCWzzRQzHc3YWWr3qjXOdAFwh0ztQ9zsbRji/XKyjG
         PSYQd8wHHa4rD9ul7QzAumYoT52ZW5BbaJwqOVREm+aatrp5EHD/wb9LoAmzENp89BeF
         IUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750780789; x=1751385589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NK+cMbqbAVYx+rEjsrUKTRwMkJm3OBJIDn6u/jptIc8=;
        b=p09v/G4vPuBRaNV4tvVH3amLjYVvZOw2XdlRNPh1vmDYukL0wwaf9MA9lZWOoNhGL+
         3Rl5fRbBrsw/ttuoChkXZvWmKg2VPT6hlCG+TyitDWKYYbmkinfJ/P0L808NY9pfraA0
         gkqhqZ/fJhH3J1R4F85LbWl/BkXsgnLNwjXP/mUSq6Ovi/gDnvg5mVaVsaZnE/I+qZQs
         zosfx3Mv9F7xf0SkWZp2AIicJDw8jtGMyE+xsMBny4KmYOOaUMHIkGAsNQ3h4mMYdMfi
         oss5PmDWP60drk+AovDqiN57idnMpTmNrQHZtb3WZqu27077FaxaBnEIOfxN5LAC8OmK
         XRrA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Zmr03ooG7KniF7vgFx91zBiZCzEec8BhVnzz/dXz15oWWMG2p1QuUt5YxQz9wh8qxgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiogm8GcI1xFFKPoRU5YgsHi/bWOoNVWKhKoRq9Q78wB7jyISS
	q93yGryDAyJ0T6Zq0LF+Pf+F6WmZmY47JmPzeg0qMaT6LqUV0IMm/o+wiSxq3vkNedHpt5UnesT
	18d/ynk7azEkGFg7WSD1ZT0QheJ7ifgo=
X-Gm-Gg: ASbGncu7ZG5JBvqaKlwd0gDgO2yTzPuCJtdNygNBe3sKD5p3giOU4w7Elq3Tjht5FTO
	UvRcJqxt56m+sIeEya/FGoL2UeuBfhExs+L3tmhKpsEkEFFEib3mcvedbk0m9ADkEEJvPcz9kmH
	d91raK4aH4MqbPvYVLJE3iQ8u3cW/MDahAN0GwRTYyusNq2FRtgFx9xVFFDoc=
X-Google-Smtp-Source: AGHT+IFFBhlUgBt6nI/x9dI3jIG4xrmwkSQHRexhdhf1/XbI5eUISpc5rsi0pYt/oeS2pNoMGVi2JKMPA3hHD8TzmkE=
X-Received: by 2002:a05:6000:22c1:b0:3a5:281b:9fac with SMTP id
 ffacd0b85a97d-3a6e71d67famr3474342f8f.17.1750780789126; Tue, 24 Jun 2025
 08:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609232746.1030044-1-ameryhung@gmail.com> <CAEf4BzbFaPMG4C4h1BX_Wa2gzO-DvCosPFHosCph1u7++KwhPQ@mail.gmail.com>
 <CAMB2axP_shzLPp=aFiuMtea=ALjcMtHe3ddaEBYsDF-hbDH9Rw@mail.gmail.com> <CAEf4BzbCGg6FRMudc7jZUpWWGckfxwLyPGZr2VvGuPeQHbWHSw@mail.gmail.com>
In-Reply-To: <CAEf4BzbCGg6FRMudc7jZUpWWGckfxwLyPGZr2VvGuPeQHbWHSw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Jun 2025 08:59:36 -0700
X-Gm-Features: Ac12FXx0xFtTt5LPGwt4utN_P5q3YGAa_jMIdSH_lwcXIC79aBaUu__09IC6M-s
Message-ID: <CAADnVQKGp++fxK9OELOt5s5fUnYS4E4XCbNOEO8-Fm-+tD3oSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Save struct_ops instance pointer in bpf_prog_aux
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 8:38=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jun 18, 2025 at 3:19=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > On Thu, Jun 12, 2025 at 4:08=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Jun 9, 2025 at 4:27=E2=80=AFPM Amery Hung <ameryhung@gmail.co=
m> wrote:
> > > >
> > > > Allows struct_ops implementors to infer the calling struct_ops inst=
ance
> > > > inside a kfunc through prog->aux->this_st_ops. A new field, flags, =
is
> > > > added to bpf_struct_ops. If BPF_STRUCT_OPS_F_THIS_PTR is set in fla=
gs,
> > > > a pointer to the struct_ops structure registered to the kernel (i.e=
.,
> > > > kvalue->data) will be saved to prog->aux->this_st_ops. To access it=
 in
> > > > a kfunc, use BPF_STRUCT_OPS_F_THIS_PTR with __prog argument [0]. Th=
e
> > > > verifier will fixup the argument with a pointer to prog->aux. this_=
st_ops
> > > > is protected by rcu and is valid until a struct_ops map is unregist=
ered
> > > > updated.
> > > >
> > > > For a struct_ops map with BPF_STRUCT_OPS_F_THIS_PTR, to make sure a=
ll
> > > > programs in it have the same this_st_ops, cmpxchg is used. Only if =
a
> > > > program is not already used in another struct_ops map also with
> > > > BPF_STRUCT_OPS_F_THIS_PTR can it be assigned to the current struct_=
ops
> > > > map.
> > > >
> > >
> > > Have you considered an alternative to storing this_st_ops in
> > > bpf_prog_aux by setting it at runtime (in struct_ops trampoline) into
> > > bpf_run_ctx (which I think all struct ops programs have set), and the=
n
> > > letting any struct_ops kfunc just access it through current (see othe=
r
> > > uses of bpf_run_ctx, if you are unfamiliar). This would avoid all thi=
s
> > > business with extra flags and passing bpf_prog_aux as an extra
> > > argument.
> > >
> >
> > I didn't know this. Thanks for suggesting an alternative!
> >
> > > There will be no "only one struct_ops for this BPF program" limitatio=
n
> > > either: technically, you could have the same BPF program used from tw=
o
> > > struct_ops maps just fine (even at the same time). Then depending on
> > > which struct_ops is currently active, you'd have a corresponding
> > > bpf_run_ctx's struct_ops pointer. It feels like a cleaner approach to
> > > me.
> > >
> >
> > This is a cleaner approach for struct_ops operators. To make it work
> > for kfuncs called in timer callback, I think prog->aux->st_ops is
> > still needed, but at least we can unify how to get this_st_ops in
> > kfunc, in a way that does not requires adding __prog to every kfuncs.
> >
> > +enum bpf_run_ctx_type {
> > +        BPF_CG_RUN_CTX =3D 0,
> > +        BPF_TRACE_RUN_CTX,
> > +        BPF_TRAMP_RUN_CTX,
> > +        BPF_TIMER_RUN_CTX,
> > +};
> >
> > struct bpf_run_ctx {
> > +        enum bpf_run_ctx_type type;
> > };
> >
> > +struct bpf_timer_run_ctx {
> > +        struct bpf_prog_aux *aux;
> > +};
> >
> > struct bpf_tramp_run_ctx {
> >         ...
> > +        void *st_ops;
> > };
> >
> > In bpf_struct_ops_prepare_trampoline(), the st_ops assignment will be
> > emitted to the trampoline.
> >
> > In bpf_timer_cb(), prepare bpf_timer_run_ctx, where st_ops comes from
> > prog->aux->this_st_ops and set current->bpf_ctx.
> >
> > Finally, in kfuncs that want to know the current struct_ops, call this
> > new function below:
> >
> > +void *bpf_struct_ops_current_st_ops(void)
> > +{
> > +        struct bpf_prog_aux aux;
> > +
> > +        if (!current->bpf_ctx)
> > +                return NULL;
> > +
> > +        switch(current->bpf_ctx->type) {
> > +        case BPF_TRAMP_RUN_CTX:
> > +                return (struct bpf_tramp_run_ctx *)(current->bpf_ctx)-=
>st_ops;
> > +        case BPF_TIMER_RUN_CTX:
> > +                aux =3D (struct bpf_timer_run_ctx *)(current->bpf_ctx)=
->aux;
> > +                return rcu_dereference(aux->this_st_ops);
> > +        }
> > +        return NULL;
> > +}
> >
> > What do you think?
>
> I'm not sure I particularly like different ways to get this st_ops
> pointer depending whether we are in an async callback or not. So if
> bpf_prog_aux is inevitable, I'd just stick to that. As far as
> bpf_run_ctx, though, instead of bpf_run_ctx_type, shall we just put
> `struct bpf_prog_aux *` pointer into common struct bpf_run_ctx and
> always set it for all program types that support run_ctx?

No. This is death by a thousand cuts.
bpf trampoline is getting slower and slower.
scx's 'this' case is not a common pattern.

