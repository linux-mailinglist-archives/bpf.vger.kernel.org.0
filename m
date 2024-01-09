Return-Path: <bpf+bounces-19268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD29828ADB
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 18:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09EB1C243A2
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 17:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D6B3A8F1;
	Tue,  9 Jan 2024 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzDxrDnL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD13A8C7
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2a225e9449so325796566b.0
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 09:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704820637; x=1705425437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnRFCHzaxrtmngXJ5b6i5QZxX+CjROkG+pX+4BRAjzw=;
        b=TzDxrDnLIGGhsiYJ+QYw4NFULYBkoOYSnfZhZT3UNW3FgpDgO7d7rScSif9AZCjmxK
         GKvNHzsZtQ/nimvJw8m7wShjvyGRhunCdBbhhy3ufRssAX44wW6BTJwREc5MoId6Vwyg
         BBdTSLu4J2kufoBVlZuG8QwMORomv1kF77Ayfdywurp3pOMaC3i1jg1+tQ3E0KAzb5xe
         2ZxoRO7g8cRpdFVEoG5SojFUJ3Jpa4Pu742NINKkfxvpw6siMz5tfbLdsd8N/aUbZuP+
         aiY9jD1NT3W2/R1FXOdJECF2Am/D5cHhv2Ljo/OEcfol/AfFAomLgkjg2nvRUTtfGODX
         UG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704820637; x=1705425437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnRFCHzaxrtmngXJ5b6i5QZxX+CjROkG+pX+4BRAjzw=;
        b=RacAML+4wH2viWrGG3WEjSFmErowmcTApHFA6oVjq2tccFPXSGI7vMEEocCn9+/U6U
         zBgjuX5kuDMH4NX3VE1ShUAyXr/gJMp4uRLL6t96JhtBoKz7RFAElDM9iYJHbhjiJLjx
         zxtlhmSDF719FCkwYOTsg3jU2nw997NEQ2Sd7gSwt8Pk/DLszYO2/K41L8ArzbVqakjT
         9Ig6ZR8lbfycOozrMO46cY3aBkJrPlOF2oes8xvQaeIuTc+IcJ7fDguBtNF4BbegOpL6
         qeY1svPNZf3pG9uCVetFzQ5L8iGE/H0ARl3OME74WzOh3LUfPGX6AS688MVIcbnTlvdF
         Tmkw==
X-Gm-Message-State: AOJu0YxaXVa6RSXTjEPLMKgcS/RpeRTtvX8QipO52/DtI2FrV9gaz9H/
	3ED3wPajEPwG4XcwvEndeTlJ6iY534KuSwI+hGxhhtI33mo=
X-Google-Smtp-Source: AGHT+IG9iQHxA7BpxKfAueFCm9i9lyTxXrUg41cplnoXSZ3zlvWwgpWw2y5yW05rHuFSAndufNeaEwTErk/tlBK9ruE=
X-Received: by 2002:a17:906:1404:b0:a27:dac4:a39c with SMTP id
 p4-20020a170906140400b00a27dac4a39cmr733187ejc.32.1704820637100; Tue, 09 Jan
 2024 09:17:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104013847.3875810-1-andrii@kernel.org> <20240104013847.3875810-8-andrii@kernel.org>
 <CAADnVQJn0+fvvbOVnfPFQm=1j+=oFsjy65T2-QY8Ps0pL4nh_A@mail.gmail.com>
 <CAEf4BzYt9yrGUBpSfAR8=vuh7kONFSsFZAKtbg21r4Hoj92gAQ@mail.gmail.com>
 <CAADnVQLOYU67aRyp92S0G8AEVxXRYndb6hWrtHZOH9gr0Q7JEQ@mail.gmail.com>
 <CAEf4BzaSspEa27TtMLRv-V4ipGhVdK9y5Ynu9teYNDp4f0CctA@mail.gmail.com>
 <CAADnVQKPSXUxT6HLF-hMeVd6zJhNqriFjaqdeNkyj_wRFN8Hdg@mail.gmail.com>
 <CAEf4BzahccE=CuWk1G05byopvd9b_iwdeF5aeL4TSNR7Cg10ZA@mail.gmail.com>
 <CAADnVQL=eNJN8GkOHGXJAm4=P+=KUJkudX_3hU6TNrpAcAuZ=Q@mail.gmail.com>
 <CAEf4Bza=axzY_BLDEFU63-dsSNSwZs5VLxDKGj+u9L5ze7=NtQ@mail.gmail.com> <CAADnVQKRMoBwS+9jhm72Bij1RicJHa8bkYJZTF1bLyySxsYCNg@mail.gmail.com>
In-Reply-To: <CAADnVQKRMoBwS+9jhm72Bij1RicJHa8bkYJZTF1bLyySxsYCNg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jan 2024 09:17:04 -0800
Message-ID: <CAEf4BzZb8TBsima2nQ721tqvvGpuhtdoGdLoTKtovtQ1M+8yyg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 7/9] libbpf: implement __arg_ctx fallback logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 5:49=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jan 8, 2024 at 3:45=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > >
> > > Not artificially, but only when pt_regs in bpf prog doesn't match
> > > what kernel is passing.
> > > I think allowing only:
> > >   handle_event_user(void *ctx __arg_ctx)
> > > and prog will cast it to pt_regs immediately is less surprising
> > > and proper C code,
> > > but
> > >   handle_event_user(struct pt_regs *ctx __arg_ctx)
> > > is also ok when pt_regs is indeed what is being passed.
> > > Which will be the case for x86.
> > > And will be fine on arm64 too, because
> > > arch/arm64/include/asm/ptrace.h
> > > struct pt_regs {
> > >         union {
> > >                 struct user_pt_regs user_regs;
> > >
> > > but if arm64 ever changes that layout we should start failing to load=
.
> >
> > Ok, I'm glad you agreed to allow `struct pt_regs *`. I also will say
> > that (as it stands right now) passing `struct pt_regs *` is valid on
> > all architectures, because that's what kernel passes around internally
> > as context for uprobe, kprobe, and kprobe-multi. See uprobe_prog_run,
> > kprobe_multi_link_prog_run, and perf_trace_run_bpf_submit, we always
> > pass real `struct pt_regs *`.
>
> Right, but for perf event progs it's actually bpf_user_pt_regs_t:
> ctx.regs =3D perf_arch_bpf_user_pt_regs(regs);
> bpf_prog_run(prog, &ctx);
> yet all such progs are written assuming struct pt_regs
> which is not correct.

Yes, SEC("perf_event") programs have very different context
(bpf_perf_event_data, where *pointer to pt_regs* is the first field,
so it's not compatible even memory layout-wise). So I'm not going to
allow struct pt_regs there.

> It's a bit of a mess while strict type checking should make it better.
>
> BPF is a strictly typed assembly language and the verifier
> should not be violating its own promises of type checking when
> it sees arg_ctx.
>
> The reason I was proposing to restrict both kernel and libbpf
> to 'void *ctx __arg_ctx' is because it's trivial to implement
> in both.
> To allow 'struct correct_type *ctx __arg_ctx' generically is much more
> work.

Yes, it's definitely more complicated (but kernel has full BTF info,
so maybe not too bad, I need to try). I'll give it a try, if it's too
bad, we can discuss a fallback plan. But we should try at least,
forcing users to do unnecessary void * casts to u64[] or tracepoint
struct is suboptimal from usability POV.

>
> > So, I'll add kprobe/multi-kprobe special handling to allows `struct
> > pt_regs *` then, ok?
>
> If you mean to allow 'void *ctx __arg_ctx' in kernel and libbpf and
> in addition allow 'struct pt_reg *ctx __arg_ctx' for kprobe and other
> prog types where that's what is being passed then yes.
> Totally fine with me.
> These two are easy to enforce in kernel and libbpf.

Ok, great.

>
> > Yes, of course, sk_buff instead of pt_regs is definitely broken. But
> > that will be detected even by the compiler.
>
> Right. C can do casts, but in bpf asm the verifier promises strict type
> checking and it goes further and makes safety decisions based on types.
>

It feels like you are thinking about PTR_TO_BTF_ID only and
extrapolating that behavior to everything else. You know that it's not
like that in general.

> > Anyways, I can add special casing for pt_regs and start enforcing
> > types. A bit hesitant to do that on libbpf side, still, due to that
> > eager global func behavior, which deviates from kernel, but if you
> > insist I'll do it.
>
> I don't understand this part.
> Both kernel and libbpf can check
> if (btf_type_id(ctx) =3D=3D 'struct pt_regs'
>   && prog_type =3D=3D kprobe) allow such __arg_ctx.
>

I was thinking about the case where we have __arg_ctx and type doesn't
match expectation. Should libbpf error out? Or emit a warning and
proceed without adjusting types? If we do the warning and let verifier
reject invalid program, I think it will be better and then these
concerns of mine about lazy vs eager global subprog verification
behavior are irrelevant.

> >
> > (Eduard, I'll add feature detection for the need to rewrite BTF at the
> > same time, just FYI)
> >
> > Keep in mind, though, for non-global subprogs kernel doesn't enforce
> > any types, so you can really pass sk_buff into pt_regs argument, if
> > you really want to, but kernel will happily still assume PTR_TO_CTX
> > (and I'm sure you know this as well, so this is mostly for others and
> > for completeness).
>
> static functions are very different. They're typeless and will stay
> typeless for some time.

Right. And they are different in how we verify and so on. But from the
user's perspective they are still just functions and (in my mind at
least), the less difference between static and global subprogs there
are, the better.

But anyways, I'll do what we agreed above. I'll proceed with libbpf
emitting warning and not doing anything for __arg_ctx, unless you feel
strongly libbpf should error out.

> Compiler can do whatever it wants with them.
> Like in katran case the static function of 6 arguments is optimized
> into 5 args. The types are unknown. The compiler can specialize
> args with constant, partially inline, etc.
> Even if it kept types of args after heavy transformations
> the verifier cannot rely on that for safety or enforce strict types (yet)=
.
> static foo() is like static inline foo().
> kprobe-ing into static func is questionable.
> Only if case of global __weak the types are dependable and that's why
> the verifier treats them differently.
> Hopefully the -Overifiable llvm/gcc proposal will keep moving.
> Then, one day, we can potentially disable some of the transformations
> on static functions that makes types useless. Then the verifier
> will be able to verify them just as globals and enforce strict types.

