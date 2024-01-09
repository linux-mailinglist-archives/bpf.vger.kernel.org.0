Return-Path: <bpf+bounces-19246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4502A827C9F
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 02:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6CC3B22F10
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 01:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878FC186C;
	Tue,  9 Jan 2024 01:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVTjl74t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5BF28E8
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 01:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3373a30af67so2366862f8f.0
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 17:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704764973; x=1705369773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=102W8RXLxO6iL+727mEHcy9G/j8WE1y4nAAxmpBMGAo=;
        b=dVTjl74t6pzmhyd30B9EclsV8pn7wHIJeK3/gXnJlNuFDFLmAI7yfj2GSHgYa2LglI
         b8z2R7LEbAUFNNGo0kLreczu26slkxV02ctv4L/mX3LW8txR/PkIYNP2YV212wz9Jj/s
         cIB3Q41x5KH9n4c6BFKRzL+vHswQKeCuZmy4lJwRjDPLaPCrzNqGnA+8b3nxdMzpSM9d
         DLOekZAqOJjXCBNVxU8ohitaKGU3S3nVkOPOo10Rm9YjhcENzOGuE6VjvL3In5tkfIF7
         RIK97av2zB/jAcOeNJuH83gr9K23fipZkXgVgdllfZzTsNDAFZRvaXpZ7k3aP7urGrzb
         FIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704764973; x=1705369773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=102W8RXLxO6iL+727mEHcy9G/j8WE1y4nAAxmpBMGAo=;
        b=T4ltyq/8FogWG1NRvG8DCshS/stljEP7Le9fzs5B7Ni6DIMXntjThP8lthUy8pK18S
         G+whgjKTnWOHPiop//BL+V/AqeWrrC9faOECsWkF+1ufVfh22goreTL1LujNWMmjJvrN
         ojOzfch8mjpgFfloKJ9BriQzumm+Ln3HPjpMBFSCYzoYHq9NaP5QMUaF/xIhktffnrf7
         76ep5Zxkq9COoFRSd8T6QvAuA+mhMk14UvcIbWwQzvh1Rh/sxUfSwvw7E6auoCAfN6/L
         Q/ukf+rj4EhRPB8mXAiIzN8NFaoe3UsOyAzePCRLgMyaVunqzakkX7xPwaMwKVdQRA+g
         K5YQ==
X-Gm-Message-State: AOJu0YzygRDW/GTr/CWUVyP7+RDrYHpikB574J/1WHMLTPU0ZiScfFup
	H29GU+3gGoOUysm7GId82ZAKQOf4X6azyhFeSzE=
X-Google-Smtp-Source: AGHT+IES06Cli8Mnhwq+zV3RUygJsJyG1kXwtLcHnchqEch/w/GFjx5vWxgaumPPboulP3bbKB90up77LCFr4o4XnwM=
X-Received: by 2002:adf:e486:0:b0:337:5d74:61bc with SMTP id
 i6-20020adfe486000000b003375d7461bcmr99189wrm.27.1704764973401; Mon, 08 Jan
 2024 17:49:33 -0800 (PST)
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
 <CAADnVQL=eNJN8GkOHGXJAm4=P+=KUJkudX_3hU6TNrpAcAuZ=Q@mail.gmail.com> <CAEf4Bza=axzY_BLDEFU63-dsSNSwZs5VLxDKGj+u9L5ze7=NtQ@mail.gmail.com>
In-Reply-To: <CAEf4Bza=axzY_BLDEFU63-dsSNSwZs5VLxDKGj+u9L5ze7=NtQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Jan 2024 17:49:22 -0800
Message-ID: <CAADnVQKRMoBwS+9jhm72Bij1RicJHa8bkYJZTF1bLyySxsYCNg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 7/9] libbpf: implement __arg_ctx fallback logic
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 3:45=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> >
> > Not artificially, but only when pt_regs in bpf prog doesn't match
> > what kernel is passing.
> > I think allowing only:
> >   handle_event_user(void *ctx __arg_ctx)
> > and prog will cast it to pt_regs immediately is less surprising
> > and proper C code,
> > but
> >   handle_event_user(struct pt_regs *ctx __arg_ctx)
> > is also ok when pt_regs is indeed what is being passed.
> > Which will be the case for x86.
> > And will be fine on arm64 too, because
> > arch/arm64/include/asm/ptrace.h
> > struct pt_regs {
> >         union {
> >                 struct user_pt_regs user_regs;
> >
> > but if arm64 ever changes that layout we should start failing to load.
>
> Ok, I'm glad you agreed to allow `struct pt_regs *`. I also will say
> that (as it stands right now) passing `struct pt_regs *` is valid on
> all architectures, because that's what kernel passes around internally
> as context for uprobe, kprobe, and kprobe-multi. See uprobe_prog_run,
> kprobe_multi_link_prog_run, and perf_trace_run_bpf_submit, we always
> pass real `struct pt_regs *`.

Right, but for perf event progs it's actually bpf_user_pt_regs_t:
ctx.regs =3D perf_arch_bpf_user_pt_regs(regs);
bpf_prog_run(prog, &ctx);
yet all such progs are written assuming struct pt_regs
which is not correct.
It's a bit of a mess while strict type checking should make it better.

BPF is a strictly typed assembly language and the verifier
should not be violating its own promises of type checking when
it sees arg_ctx.

The reason I was proposing to restrict both kernel and libbpf
to 'void *ctx __arg_ctx' is because it's trivial to implement
in both.
To allow 'struct correct_type *ctx __arg_ctx' generically is much more
work.

> So, I'll add kprobe/multi-kprobe special handling to allows `struct
> pt_regs *` then, ok?

If you mean to allow 'void *ctx __arg_ctx' in kernel and libbpf and
in addition allow 'struct pt_reg *ctx __arg_ctx' for kprobe and other
prog types where that's what is being passed then yes.
Totally fine with me.
These two are easy to enforce in kernel and libbpf.

> Yes, of course, sk_buff instead of pt_regs is definitely broken. But
> that will be detected even by the compiler.

Right. C can do casts, but in bpf asm the verifier promises strict type
checking and it goes further and makes safety decisions based on types.

> Anyways, I can add special casing for pt_regs and start enforcing
> types. A bit hesitant to do that on libbpf side, still, due to that
> eager global func behavior, which deviates from kernel, but if you
> insist I'll do it.

I don't understand this part.
Both kernel and libbpf can check
if (btf_type_id(ctx) =3D=3D 'struct pt_regs'
  && prog_type =3D=3D kprobe) allow such __arg_ctx.

>
> (Eduard, I'll add feature detection for the need to rewrite BTF at the
> same time, just FYI)
>
> Keep in mind, though, for non-global subprogs kernel doesn't enforce
> any types, so you can really pass sk_buff into pt_regs argument, if
> you really want to, but kernel will happily still assume PTR_TO_CTX
> (and I'm sure you know this as well, so this is mostly for others and
> for completeness).

static functions are very different. They're typeless and will stay
typeless for some time.
Compiler can do whatever it wants with them.
Like in katran case the static function of 6 arguments is optimized
into 5 args. The types are unknown. The compiler can specialize
args with constant, partially inline, etc.
Even if it kept types of args after heavy transformations
the verifier cannot rely on that for safety or enforce strict types (yet).
static foo() is like static inline foo().
kprobe-ing into static func is questionable.
Only if case of global __weak the types are dependable and that's why
the verifier treats them differently.
Hopefully the -Overifiable llvm/gcc proposal will keep moving.
Then, one day, we can potentially disable some of the transformations
on static functions that makes types useless. Then the verifier
will be able to verify them just as globals and enforce strict types.

