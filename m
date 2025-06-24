Return-Path: <bpf+bounces-61429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 782EFAE6FE9
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5711897412
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 19:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4872ECD1A;
	Tue, 24 Jun 2025 19:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRKa+aJj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E0F24169B
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794100; cv=none; b=qRFPxiShnZLmaXXoQsPa0U5of+LgWYT6GKmiXpqvlpcTd8P4IYEi//759RADdGRdqO3owFehu93YSMudZ+DujfCFNIMBGI9sS+jRuofdUtaIAB4+dPx9XFtdGG7fguAh4ODgqXwCkEQaM46jDI8lMWN5I/4m6dzRwVAj185q3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794100; c=relaxed/simple;
	bh=S/hLUAQj+POk6bM1pqn5+2et6JqMGmscGBNM48Tq7cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FW1ESycqswAZ1N0UWMfs9sP38A9H1AkECaPcoXv16nDJGLdgcmNJMcYihXws0ScgcgOoRAfDd4AWXRMfZnklwPCA7y1ouujESEWUL2m7vU9vAzRsLKCscOtGQslFtZn2wlWeNOc1X1YegOyG/eZHMrZSRF5fg81hHafrZgOllaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRKa+aJj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2363497cc4dso10064615ad.1
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750794097; x=1751398897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NmiWIz3j14Lmozyrf39Y5JPpzuvzc94+cbgId2GInc=;
        b=cRKa+aJjyJRnk5TU2leVy2SEdhyP14DQJWf9Kn9O4+HVHo5kJC9f0eP+EdOfN+I00s
         aFEXUkrBUFasQgGCZBZO35zMf3k2sIUUUQBr1AXY29vETIVrM1k4tTXzzb96oVIoy9z2
         6p6loIcDKNucdRwW6l9ZsKC6VBtapcqDg2ys7Gcghw/71PHdAejyj1SQzBZ/IU2DxnHJ
         O0scspuSqan1ONz89iKLbPWRUKtgSFDSv7KwYiTc1ZZOcjbWXug9QgPXHPDpTQ9Pkcf0
         IKB2tfuCC0x4i2+HBusCMYS9zU8XTqYDw2hWA8tLuJskmwkVFS4Htqn+Yqop3LT6SreU
         cAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750794097; x=1751398897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NmiWIz3j14Lmozyrf39Y5JPpzuvzc94+cbgId2GInc=;
        b=RZw72DK3ESqfJmXacakolodWWBP6pSFYz/YfyJ97IWFYuw65s3F/8/6bAV7IEq0P1h
         tTjbMyWs6Y7ogwTWwzmqlf+Ke2e+PP1kOjrmuXJ5odfMsaASQhs0smf49vriXIPw8vOU
         gYHMlhJMOkWMwjalGl/E9aMmtfF7ej7jl4Ynr4CL6gbzkvWZAh4smB8nxLkgPOZEdsgM
         SlcdpYqLqw/kzaGxqJObjTr62yHVPKwHvSNPSxFPeW7I8ORuV2QDjvobfjGLJbHV0v3E
         BaiyHHSbu5WElzlH7XHSpOKnlPQbEeNXr03mI4GJS10n66bRbLoUzPMrxYheOgGJd1Es
         qJnA==
X-Forwarded-Encrypted: i=1; AJvYcCUeLftuAF0dE4vJatgY6/yA4sV5GKbSBV+vyn12Whe8o5tGJSOzMy5v2nfrVYEXmHUjVQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcyhX9FdDgkqqtF7LC2mEVeBsRgm3RYSldZMjsevv+LWuc4Jih
	mVwEQROu/57+c9Umna8th7UN70PW+YAYnXkc6nAWHFoPE+MowFJFnE/4w75yiMaepcqsu0M38kW
	KWKnXeDcoSzEFWq/ceTuvfJ9I6Xfy/xU2ufB0
X-Gm-Gg: ASbGncuNBH7jmkGjkYFdIcdsXCcesm7Qhl3A3TLe2J424QdEFfuw46K49J2MZzjsbTJ
	LXtwN6LeZn0k56ck+4o9mFamsFvroJ5vtW2oL+AglpWCBCA4IPwy5XmGHSjVJYQqCw70hwbFBhu
	+6rszHj/2WjKgj03KD2OsesKnASeJBxnzKH5e8kz8SLQ==
X-Google-Smtp-Source: AGHT+IHIlAF40RVxSRNhmWH65I1fHqahREyFBV6YaQTzhKd+lp86bU28dDqrRVikiMCv+XnJ7B9G6lggzhxrYvmzkqQ=
X-Received: by 2002:a17:902:e74d:b0:22e:72fe:5f9c with SMTP id
 d9443c01a7336-2382478a93amr5721125ad.42.1750794097271; Tue, 24 Jun 2025
 12:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609232746.1030044-1-ameryhung@gmail.com> <CAEf4BzbFaPMG4C4h1BX_Wa2gzO-DvCosPFHosCph1u7++KwhPQ@mail.gmail.com>
 <CAMB2axP_shzLPp=aFiuMtea=ALjcMtHe3ddaEBYsDF-hbDH9Rw@mail.gmail.com>
 <CAEf4BzbCGg6FRMudc7jZUpWWGckfxwLyPGZr2VvGuPeQHbWHSw@mail.gmail.com> <CAADnVQKGp++fxK9OELOt5s5fUnYS4E4XCbNOEO8-Fm-+tD3oSA@mail.gmail.com>
In-Reply-To: <CAADnVQKGp++fxK9OELOt5s5fUnYS4E4XCbNOEO8-Fm-+tD3oSA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Jun 2025 12:41:23 -0700
X-Gm-Features: AX0GCFsXW3n1sk0ConNBLHx90z1epR5hSj__dFYyEqx6yK2ge4R22QzbbcXYasg
Message-ID: <CAEf4BzZbW9XfEAUc-ZnjnfYtdzOagE-AY_d3s0hL=N=iCWQGrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Save struct_ops instance pointer in bpf_prog_aux
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 8:59=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jun 24, 2025 at 8:38=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jun 18, 2025 at 3:19=E2=80=AFPM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > On Thu, Jun 12, 2025 at 4:08=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Jun 9, 2025 at 4:27=E2=80=AFPM Amery Hung <ameryhung@gmail.=
com> wrote:
> > > > >
> > > > > Allows struct_ops implementors to infer the calling struct_ops in=
stance
> > > > > inside a kfunc through prog->aux->this_st_ops. A new field, flags=
, is
> > > > > added to bpf_struct_ops. If BPF_STRUCT_OPS_F_THIS_PTR is set in f=
lags,
> > > > > a pointer to the struct_ops structure registered to the kernel (i=
.e.,
> > > > > kvalue->data) will be saved to prog->aux->this_st_ops. To access =
it in
> > > > > a kfunc, use BPF_STRUCT_OPS_F_THIS_PTR with __prog argument [0]. =
The
> > > > > verifier will fixup the argument with a pointer to prog->aux. thi=
s_st_ops
> > > > > is protected by rcu and is valid until a struct_ops map is unregi=
stered
> > > > > updated.
> > > > >
> > > > > For a struct_ops map with BPF_STRUCT_OPS_F_THIS_PTR, to make sure=
 all
> > > > > programs in it have the same this_st_ops, cmpxchg is used. Only i=
f a
> > > > > program is not already used in another struct_ops map also with
> > > > > BPF_STRUCT_OPS_F_THIS_PTR can it be assigned to the current struc=
t_ops
> > > > > map.
> > > > >
> > > >
> > > > Have you considered an alternative to storing this_st_ops in
> > > > bpf_prog_aux by setting it at runtime (in struct_ops trampoline) in=
to
> > > > bpf_run_ctx (which I think all struct ops programs have set), and t=
hen
> > > > letting any struct_ops kfunc just access it through current (see ot=
her
> > > > uses of bpf_run_ctx, if you are unfamiliar). This would avoid all t=
his
> > > > business with extra flags and passing bpf_prog_aux as an extra
> > > > argument.
> > > >
> > >
> > > I didn't know this. Thanks for suggesting an alternative!
> > >
> > > > There will be no "only one struct_ops for this BPF program" limitat=
ion
> > > > either: technically, you could have the same BPF program used from =
two
> > > > struct_ops maps just fine (even at the same time). Then depending o=
n
> > > > which struct_ops is currently active, you'd have a corresponding
> > > > bpf_run_ctx's struct_ops pointer. It feels like a cleaner approach =
to
> > > > me.
> > > >
> > >
> > > This is a cleaner approach for struct_ops operators. To make it work
> > > for kfuncs called in timer callback, I think prog->aux->st_ops is
> > > still needed, but at least we can unify how to get this_st_ops in
> > > kfunc, in a way that does not requires adding __prog to every kfuncs.
> > >
> > > +enum bpf_run_ctx_type {
> > > +        BPF_CG_RUN_CTX =3D 0,
> > > +        BPF_TRACE_RUN_CTX,
> > > +        BPF_TRAMP_RUN_CTX,
> > > +        BPF_TIMER_RUN_CTX,
> > > +};
> > >
> > > struct bpf_run_ctx {
> > > +        enum bpf_run_ctx_type type;
> > > };
> > >
> > > +struct bpf_timer_run_ctx {
> > > +        struct bpf_prog_aux *aux;
> > > +};
> > >
> > > struct bpf_tramp_run_ctx {
> > >         ...
> > > +        void *st_ops;
> > > };
> > >
> > > In bpf_struct_ops_prepare_trampoline(), the st_ops assignment will be
> > > emitted to the trampoline.
> > >
> > > In bpf_timer_cb(), prepare bpf_timer_run_ctx, where st_ops comes from
> > > prog->aux->this_st_ops and set current->bpf_ctx.
> > >
> > > Finally, in kfuncs that want to know the current struct_ops, call thi=
s
> > > new function below:
> > >
> > > +void *bpf_struct_ops_current_st_ops(void)
> > > +{
> > > +        struct bpf_prog_aux aux;
> > > +
> > > +        if (!current->bpf_ctx)
> > > +                return NULL;
> > > +
> > > +        switch(current->bpf_ctx->type) {
> > > +        case BPF_TRAMP_RUN_CTX:
> > > +                return (struct bpf_tramp_run_ctx *)(current->bpf_ctx=
)->st_ops;
> > > +        case BPF_TIMER_RUN_CTX:
> > > +                aux =3D (struct bpf_timer_run_ctx *)(current->bpf_ct=
x)->aux;
> > > +                return rcu_dereference(aux->this_st_ops);
> > > +        }
> > > +        return NULL;
> > > +}
> > >
> > > What do you think?
> >
> > I'm not sure I particularly like different ways to get this st_ops
> > pointer depending whether we are in an async callback or not. So if
> > bpf_prog_aux is inevitable, I'd just stick to that. As far as
> > bpf_run_ctx, though, instead of bpf_run_ctx_type, shall we just put
> > `struct bpf_prog_aux *` pointer into common struct bpf_run_ctx and
> > always set it for all program types that support run_ctx?
>
> No. This is death by a thousand cuts.
> bpf trampoline is getting slower and slower.
> scx's 'this' case is not a common pattern.

ok, no big deal

