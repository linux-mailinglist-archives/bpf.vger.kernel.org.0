Return-Path: <bpf+bounces-19111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA2824E2F
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 06:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5AC2854C3
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 05:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F294B53BF;
	Fri,  5 Jan 2024 05:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHlYgyem"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05A31DFD5
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-336990fb8fbso892003f8f.1
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 21:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704433371; x=1705038171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/F5Bv558nBjCHAzBZNUrymIlbVmbzyR5fnhTxoZ47Y=;
        b=YHlYgyemVMHZoRCO72d8N1PhIkNsw0PUHOSgEgCQeH8De5BZHaLDKm+pkD6238/l2v
         pMrX1SBuywSgyK8u31ebHPj8xqt1qMAhkkNDEZN+dJgZkgT1A83fi+kzpfpkvvhSHcN0
         vONyKqprGY1sRRdyG9+ZIS4F3JICFlWbJak8vMZfKD6oWolXApK3T+IG0B6hNu7nITJx
         kZzXFL1reLiWJd9WBOTqjiZhw0IuX/YOAsu3RsY2SLwUSR5IVqlIpE8HUP0V+WTq00U7
         clQWr6LLnpE7FONPriJ+WncY6pLgbi1ErG1//lj2isPFfnUu6crW+fnk76IP4JE+QoAL
         wReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704433371; x=1705038171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/F5Bv558nBjCHAzBZNUrymIlbVmbzyR5fnhTxoZ47Y=;
        b=CDk61nLuGuCfbut4gH0i6YQLGOERjW2nR8txzbh7qLQLZy6adApN5TLm9AqPOf7Ygx
         XAslOiiLFigEi5WnWJ4Zkbs/e6WfveEI5exYCsyDzE7U+ZbMa5Cr3n2pTWSjtnbfxrFJ
         MqRS5mOVZ8vbc8CDE1vg+/TmInahvC/jXF/jbmSZYnPah6q9d8RUpNSx7hHPyiAeZFot
         yL+Qj8Fk8FdlgfN+E5d5QNeUmgvKochrTSIz581wk0dWNql3kOUgbfB815bkrxSad6wt
         5ExZ6UopkW7k0EhlN6pEIXQtjkDc0XqtWruvjn6OZlg04AByYRdYW009cugkoIt15arU
         GbAw==
X-Gm-Message-State: AOJu0Yy7392tJLEbj651DMMSvf2pnsBtXpNQb6rAVt65gFTpU3dZ9fBB
	Ernc9ntuPJoT9fXzLk97K1VViwGFxN8/6rRxa7s=
X-Google-Smtp-Source: AGHT+IGd0koJIPmMAH/uvHAraQlmkISy3OPT2FEdeLjKuqWpRmAlqVMQ95WNIRrf6biPXDYc/L0JUPzVgzpsrqc2lf8=
X-Received: by 2002:adf:c7d3:0:b0:336:9f70:a708 with SMTP id
 y19-20020adfc7d3000000b003369f70a708mr1294619wrg.107.1704433370688; Thu, 04
 Jan 2024 21:42:50 -0800 (PST)
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
 <CAADnVQKPSXUxT6HLF-hMeVd6zJhNqriFjaqdeNkyj_wRFN8Hdg@mail.gmail.com> <CAEf4BzahccE=CuWk1G05byopvd9b_iwdeF5aeL4TSNR7Cg10ZA@mail.gmail.com>
In-Reply-To: <CAEf4BzahccE=CuWk1G05byopvd9b_iwdeF5aeL4TSNR7Cg10ZA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jan 2024 21:42:39 -0800
Message-ID: <CAADnVQL=eNJN8GkOHGXJAm4=P+=KUJkudX_3hU6TNrpAcAuZ=Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 7/9] libbpf: implement __arg_ctx fallback logic
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 7:58=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 4, 2024 at 5:34=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jan 4, 2024 at 12:58=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > >
> > > My point was that it's hard to accidentally forget to "generalize"
> > > type if you were supporting sk_buff, and suddenly started calling it
> > > with xdp_md.
> > >
> > > From my POV, if I'm a user, and I declare an argument as long and
> > > annotate it as __arg_ctx, then I know what I'm doing and I'd hate for
> > > some smart-ass library to double-guess me dictating what exact
> > > incantation I should specify to make it happy.
> >
> > But that's exactly what's happening!
> > The smart-ass libbpf ignores the type in 'struct sk_buff *skb __arg_ctx=
'
> > and replaces it with whatever is appropriate for prog type.
>
> The only thing that libbpf does in this case is it honors __arg_ctx
> and makes it work *exactly the same* as __arg_ctx natively works on
> the newest kernel. Not more, not less. It doesn't change compilation
> or verification rules. At all.

Here in all previous emails I was talking about both kernel and libbpf.
Both shouldn't be breaking C rules.
Not singling out libbpf.

> Validating f1() func#2...
> 20: R1=3Dctx() R10=3Dfp0
> ; int f1(struct sk_buff *skb)
>
> It's a context.

Ohh. Looks like I screwed it up back then.
        /* only compare that prog's ctx type name is the same as
         * kernel expects. No need to compare field by field.
         * It's ok for bpf prog to do:
         * struct __sk_buff {};
         * int socket_filter_bpf_prog(struct __sk_buff *skb)
         * { // no fields of skb are ever used }
         */
        if (strcmp(ctx_tname, "__sk_buff") =3D=3D 0 && strcmp(tname,
"sk_buff") =3D=3D 0)
                return ctx_type;

See comment. The intent was to allow __sk_buff in prog to
match with __sk_buff in the kernel.
Brainfart.

> Not really, see below. For a long time *we thought* that kernel
> recognizes bpf_user_pt_regs_t, but in reality it wanted `struct
> bpf_user_pt_regs_t` which doesn't even exist in kernel and has nothing
> common with either `struct pt_regs` or `struct user_pt_regs`. I fixed
> that and now the kernel recognizes *both* typedef and struct
> bpf_user_pt_regs_t. And there is no point in using typedef, because
> `struct bpf_user_pt_regs_t` is backwards compatible and that's what
> users actually use in practice.

Hmm.
The test with
__weak int kprobe_typedef_ctx_subprog(bpf_user_pt_regs_t *ctx)

was added back in Feb 2023.
So it was surely working for the last year.

> > __PT_REGS_CAST is arch dependent and typeof makes it seen with
> > correct btf_id and the kernel knows it's PTR_TO_CTX.
>
> TBH, I don't know what btf_id has to do with this, it looks either as
> a distraction or subtle point you are making that I'm missing.
> __PT_REGS_CAST() just does C language cast, there is no BTF or BTF ID
> involved here, so what am I missing?

That was your patch :)
I'm just pointing out the neat trick with typeof to put
the correct type in there,
so it's later seen with proper btf_id and recognized as ctx.
You added it a year ago.

>
> Why not? This is what I don't get. Here's a real piece of code to
> demonstrate what users do in practice:
>
> struct bpf_user_pt_regs_t {}
>
> __hidden int handle_event_user_pt_regs(struct bpf_user_pt_regs_t* ctx) {
>   if (pyperf_prog_cfg.sample_interval > 0) {
>     if (__sync_fetch_and_add(&total_events_count, 1) %
>         pyperf_prog_cfg.sample_interval) {
>       return 0;
>     }
>   }
>
>   return handle_event_helper((struct pt_regs*)ctx, NULL);
> }

I think you're talking about kernel prior to that commit a year ago
that made it possible to drop 'struct'.

> I'm saying that I explicitly do want to be able to declare (in general):>
> int handle_event_user(struct pt_regs *ctx __arg_ctx) { ...}
>
> And this would work both on old and new kernels, with and without
> native __arg_ctx support. And it will be very close to static subprogs
> in the existing code base.
>
> Why do you want to disallow this artificially?

Not artificially, but only when pt_regs in bpf prog doesn't match
what kernel is passing.
I think allowing only:
  handle_event_user(void *ctx __arg_ctx)
and prog will cast it to pt_regs immediately is less surprising
and proper C code,
but
  handle_event_user(struct pt_regs *ctx __arg_ctx)
is also ok when pt_regs is indeed what is being passed.
Which will be the case for x86.
And will be fine on arm64 too, because
arch/arm64/include/asm/ptrace.h
struct pt_regs {
        union {
                struct user_pt_regs user_regs;

but if arm64 ever changes that layout we should start failing to load.

> All the above is already checked and enforced by the compiler. Libbpf
> doesn't subvert it in any way. All that libbpf is doing is saying "ah,
> user, you want this argument to be treated as PTR_TO_CTX, right? Too
> bad host kernel is a bit too old to understand __arg_ctx natively, but
> worry you not, I'll just quickly fix up BTF information that *only
> kernel* uses *only to check type name* (nothing else!), and it will
> look like kernel actually understood __arg_ctx, that's all, happy
> BPF'ing!".

and this way libbpf _may_ introduce a hard to debug bug.
The same mistake the new kernel _may_ do with __arg_ctx with old libbpf.
Both will do a hidden typecast when the bpf prog is
potentially written with different type.

foo(struct pt_regs *ctx __arg_ctx)
Quick git grep shows that it will probably work on all archs
except 'arc' where
arch/arc/include/uapi/asm/bpf_perf_event.h:typedef struct
user_regs_struct bpf_user_pt_regs_t;
and struct pt_regs seems to have a different layout than user_regs_struct.

But when kernel allows sk_buff to be passed into
foo(struct pt_regs *ctx __arg_ctx)
is just broken.

