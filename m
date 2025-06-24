Return-Path: <bpf+bounces-61384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93AFAE6BA7
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 17:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DC21C430D1
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69D923E336;
	Tue, 24 Jun 2025 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7pH6MpY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B8307488
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779530; cv=none; b=QtkHTkBXH7oZWmkL1JkDxAg4e7SUZGdg+MQPNkf03mMqbGdHN9ndynKwtN/p1ZXRVhRhZ1HCuOIUuTt7ymZtBNSCUa+Ja9icaV/WkCiFxSn6ijbEgxDg+3eXyzVr9/WNi8l+NzIu6pV38pS4IVqxbdHX8D+H/k08FmMwGSZi/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779530; c=relaxed/simple;
	bh=7Yz5/GyWGccwnq59/jhWp5TAs6RACeyroIbgbgsvfQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjzlqLnDwkyAuMgA/+H8CDNUN2Hetoi5S9S3c+4mbS+tmUTX0ayisin/vMwXHlLEORAiUpUsv66A1KtowKO4qEsfweYpB4WY3tYIqGxhvs59iGJQdEyKPuE056XVr5UGmYytl2Fag8mOSYI/c8a95mWDVNzwLTzVsFnhLrx/N9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7pH6MpY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-236377f00a1so8275645ad.3
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750779528; x=1751384328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf8h6+fshEculOKUfWIrz1bm+xF1TCVuyetuOKlcpSo=;
        b=b7pH6MpYxzTU5RaFqsUguCHmdnK4OG86NLkYHpH+gzzzI/JDgyzvF7EzRe5OYhZ1JE
         4ntRtnR5PMQ1imI8DrmKEDx4uhkPyIx19GxPa+Tl2SvVYQeR+364xjEjFC1S4eSOc4Fd
         q++JUXGnTWb4clKllnVB1kw9K2F4GQPCP+8BTqDDniI2Xaw6DRTuutPj2EvdQOzVQJn9
         vnGjRaAFr/3p+7ec+hqRkkSNCqTQxGLn2VyHvpsYbs5Ooo7by8F1ecIbQG0LFvIfp2Jw
         FxDwvqhAi9nMgvZtoibH5GyLbyJoQQW1tyYgk7rDrhh7DWpCNb1I9NQroszHgEiBzV4J
         sMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750779528; x=1751384328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zf8h6+fshEculOKUfWIrz1bm+xF1TCVuyetuOKlcpSo=;
        b=hLlM3qh2uenGhIts0BkjXg5KzD6ZxnzlckEoHuw3LDgmoGSVYmNtK+XgVyV6CGgmlY
         ncczbuEcLwsXChtbQZOTuCqQAU+aPfJFuBGDJDimRV1saQYJluP/K2fsgB55VCnIUT6v
         Su3g7mfXtme02UQiuzXOHuzE864ruF5hWJ/xAFfhv5xconiEbQxYuaL7PHk+x39ZVgYP
         IbYhEXoojY4ULAVIRDI6TTwr1ZbAeGQil4YkgMt+ntpq07IzQf4s8zvEcPZc3HaSw0uY
         OjGVukkYLu8kpGLtBb0JGe7wSiDa3o//5+CYzZiM4oevgK08/nnGlppCfZIU1puBxC9w
         T9gw==
X-Gm-Message-State: AOJu0Yy/QVt4CD3tODBg90h+i5Op9c4uRHO3LaP4/3Faa8HEzCjvtIcZ
	IRNJTRv1woHsOGw/Uc2BgJ/ZRnr1jjg+nwfS1pakyDpeKHY2fL51C86i/+VAHfrCOfjt5MfQEeR
	onA3OotydSZxb2amEIEXckZlNJJ0vtDA=
X-Gm-Gg: ASbGnct0YX1mxSxhygy6kPLkWa/F0O9Rlur7RcrV1YrZp1XVuhF/vyKHb0Ba50OEi+B
	0CC+CA/PBuJA05ZE9u7p9fnrEkVhqER2vy1X75N/hItI/QQcltRKJXcibJGhFUVcGXlngG23Wj9
	Uw/qHN0QOYZmW/cABZ9n/oXhuNABpOn4VyGtBBS+tnMQ==
X-Google-Smtp-Source: AGHT+IGa0QnR6IYXrR8Vin8VOPxFJfC30mtNqNBw7DI6zfCAhIV+FLHJG4wDRGKnjB4Q/pOlTr44Xwnsw/POrustSys=
X-Received: by 2002:a17:90b:5251:b0:313:d79d:87eb with SMTP id
 98e67ed59e1d1-3159d8fece1mr22016429a91.35.1750779527886; Tue, 24 Jun 2025
 08:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609232746.1030044-1-ameryhung@gmail.com> <CAEf4BzbFaPMG4C4h1BX_Wa2gzO-DvCosPFHosCph1u7++KwhPQ@mail.gmail.com>
 <CAMB2axP_shzLPp=aFiuMtea=ALjcMtHe3ddaEBYsDF-hbDH9Rw@mail.gmail.com>
In-Reply-To: <CAMB2axP_shzLPp=aFiuMtea=ALjcMtHe3ddaEBYsDF-hbDH9Rw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Jun 2025 08:38:33 -0700
X-Gm-Features: AX0GCFsBFtlZiuQgtlayVt2EgM-26Lp3_OhSTOqG5Z6JvGuxzkH5pzmyoqcG_7w
Message-ID: <CAEf4BzbCGg6FRMudc7jZUpWWGckfxwLyPGZr2VvGuPeQHbWHSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Save struct_ops instance pointer in bpf_prog_aux
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 3:19=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Thu, Jun 12, 2025 at 4:08=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Jun 9, 2025 at 4:27=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> > >
> > > Allows struct_ops implementors to infer the calling struct_ops instan=
ce
> > > inside a kfunc through prog->aux->this_st_ops. A new field, flags, is
> > > added to bpf_struct_ops. If BPF_STRUCT_OPS_F_THIS_PTR is set in flags=
,
> > > a pointer to the struct_ops structure registered to the kernel (i.e.,
> > > kvalue->data) will be saved to prog->aux->this_st_ops. To access it i=
n
> > > a kfunc, use BPF_STRUCT_OPS_F_THIS_PTR with __prog argument [0]. The
> > > verifier will fixup the argument with a pointer to prog->aux. this_st=
_ops
> > > is protected by rcu and is valid until a struct_ops map is unregister=
ed
> > > updated.
> > >
> > > For a struct_ops map with BPF_STRUCT_OPS_F_THIS_PTR, to make sure all
> > > programs in it have the same this_st_ops, cmpxchg is used. Only if a
> > > program is not already used in another struct_ops map also with
> > > BPF_STRUCT_OPS_F_THIS_PTR can it be assigned to the current struct_op=
s
> > > map.
> > >
> >
> > Have you considered an alternative to storing this_st_ops in
> > bpf_prog_aux by setting it at runtime (in struct_ops trampoline) into
> > bpf_run_ctx (which I think all struct ops programs have set), and then
> > letting any struct_ops kfunc just access it through current (see other
> > uses of bpf_run_ctx, if you are unfamiliar). This would avoid all this
> > business with extra flags and passing bpf_prog_aux as an extra
> > argument.
> >
>
> I didn't know this. Thanks for suggesting an alternative!
>
> > There will be no "only one struct_ops for this BPF program" limitation
> > either: technically, you could have the same BPF program used from two
> > struct_ops maps just fine (even at the same time). Then depending on
> > which struct_ops is currently active, you'd have a corresponding
> > bpf_run_ctx's struct_ops pointer. It feels like a cleaner approach to
> > me.
> >
>
> This is a cleaner approach for struct_ops operators. To make it work
> for kfuncs called in timer callback, I think prog->aux->st_ops is
> still needed, but at least we can unify how to get this_st_ops in
> kfunc, in a way that does not requires adding __prog to every kfuncs.
>
> +enum bpf_run_ctx_type {
> +        BPF_CG_RUN_CTX =3D 0,
> +        BPF_TRACE_RUN_CTX,
> +        BPF_TRAMP_RUN_CTX,
> +        BPF_TIMER_RUN_CTX,
> +};
>
> struct bpf_run_ctx {
> +        enum bpf_run_ctx_type type;
> };
>
> +struct bpf_timer_run_ctx {
> +        struct bpf_prog_aux *aux;
> +};
>
> struct bpf_tramp_run_ctx {
>         ...
> +        void *st_ops;
> };
>
> In bpf_struct_ops_prepare_trampoline(), the st_ops assignment will be
> emitted to the trampoline.
>
> In bpf_timer_cb(), prepare bpf_timer_run_ctx, where st_ops comes from
> prog->aux->this_st_ops and set current->bpf_ctx.
>
> Finally, in kfuncs that want to know the current struct_ops, call this
> new function below:
>
> +void *bpf_struct_ops_current_st_ops(void)
> +{
> +        struct bpf_prog_aux aux;
> +
> +        if (!current->bpf_ctx)
> +                return NULL;
> +
> +        switch(current->bpf_ctx->type) {
> +        case BPF_TRAMP_RUN_CTX:
> +                return (struct bpf_tramp_run_ctx *)(current->bpf_ctx)->s=
t_ops;
> +        case BPF_TIMER_RUN_CTX:
> +                aux =3D (struct bpf_timer_run_ctx *)(current->bpf_ctx)->=
aux;
> +                return rcu_dereference(aux->this_st_ops);
> +        }
> +        return NULL;
> +}
>
> What do you think?

I'm not sure I particularly like different ways to get this st_ops
pointer depending whether we are in an async callback or not. So if
bpf_prog_aux is inevitable, I'd just stick to that. As far as
bpf_run_ctx, though, instead of bpf_run_ctx_type, shall we just put
`struct bpf_prog_aux *` pointer into common struct bpf_run_ctx and
always set it for all program types that support run_ctx?

>
> > And in the trampoline itself it would be a hard-coded single word
> > assignment on the stack, so should be basically a no-op from
> > performance point of view.
> >
> > > [0]
> > > commit bc049387b41f ("bpf: Add support for __prog argument suffix to
> > > pass in prog->aux")
> > > https://lore.kernel.org/r/20250513142812.1021591-1-memxor@gmail.com
> > >
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  include/linux/bpf.h         | 10 ++++++++++
> > >  kernel/bpf/bpf_struct_ops.c | 38 +++++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 48 insertions(+)
> > >
> >
> > [...]

