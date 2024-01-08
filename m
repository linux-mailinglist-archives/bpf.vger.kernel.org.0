Return-Path: <bpf+bounces-19237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7275827BB1
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 00:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A12F2B22EF2
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 23:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7BE56477;
	Mon,  8 Jan 2024 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuRJUA7L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7C56473
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7b273352so2285040e87.1
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 15:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704757521; x=1705362321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWgUXCwyUpKmOR46iBv7OIGjOQ7TxAK5nm8Zf6xnUMc=;
        b=GuRJUA7LtXfXrokXpLaErNNRW1/Iz7fRsvj2jnUmqWI4E4rsGEdUDtKXZHw/3kTtVp
         4RlzAmbcuSN0ZIjdnrt/CJo1USgYaD60XBm0JlaOdYm0R1x/RgqIlMo9VTH/Az9ScmYO
         TODJBejQpKmAJEG7yYc7AniMLzly6nZVWw5GgfMVoCXcWG24XoVbtHm3f26Xusrz5GUv
         uhzbXCohQcmz7SWyAdu5ZK1tP1jpIpDG9ONoI8cI5LXSNZ1pu6uzXcv2IbuiY264tq2x
         RDKSrOyOqJr0k6MvCaBhC/jvnggj2tHgw/ZxEXof78GzSkdb2YMPhhqQuGhSh8vRF6uC
         cl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704757521; x=1705362321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWgUXCwyUpKmOR46iBv7OIGjOQ7TxAK5nm8Zf6xnUMc=;
        b=SgViPI4x/d7BkXOWfTbzh2P/FLCERARIsObFgaxoGVQhKEda3dPgUCI0/kqJ1QP1SP
         YlZUTCZnHYrLzf/FKgQ0iSrDWY2K68FbEqDfMLKvWafSgefjDgK6VpahSgpmVcqaaD0g
         J6+I9yjkiJcNO+OR+BFMutLBwuLI9afFYXJxr9axurx+O/KHSKDnRQJadSA6/Kxi0HbN
         skO+cvCm0eyxE/dpfiV01g/FpklS6KM0k603mwvjsgc8N9Qy6mjnu6dRFIHLQa/XOZHT
         6KnBXbMhCAATB7joMQ8jyNvyJd81FgocQuEu8cQZKVteVD7Hs6LsHFQmsN8zEy5gJ/gf
         27/w==
X-Gm-Message-State: AOJu0YwdVjIh9PDgL/uRiTKHE4ER048MHXfi1ePTK3+Gj9ZoTQwxVlNb
	xA/XMSYkaK+lSkEJ/JWPbNFo2QCgQLjigwuFCtU=
X-Google-Smtp-Source: AGHT+IE5si1CJoVEayVUMsDnIQym7FYdczjUzMfHMOUL/UIxMol29dZXWVlW1MT6BNcXs/0S522Q0nLeWW9CZ2PE2Tk=
X-Received: by 2002:a19:ae11:0:b0:50e:b8d7:41c5 with SMTP id
 f17-20020a19ae11000000b0050eb8d741c5mr1536008lfc.72.1704757521221; Mon, 08
 Jan 2024 15:45:21 -0800 (PST)
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
 <CAEf4BzahccE=CuWk1G05byopvd9b_iwdeF5aeL4TSNR7Cg10ZA@mail.gmail.com> <CAADnVQL=eNJN8GkOHGXJAm4=P+=KUJkudX_3hU6TNrpAcAuZ=Q@mail.gmail.com>
In-Reply-To: <CAADnVQL=eNJN8GkOHGXJAm4=P+=KUJkudX_3hU6TNrpAcAuZ=Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jan 2024 15:45:08 -0800
Message-ID: <CAEf4Bza=axzY_BLDEFU63-dsSNSwZs5VLxDKGj+u9L5ze7=NtQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 7/9] libbpf: implement __arg_ctx fallback logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 9:42=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 4, 2024 at 7:58=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jan 4, 2024 at 5:34=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jan 4, 2024 at 12:58=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > >
> > > > My point was that it's hard to accidentally forget to "generalize"
> > > > type if you were supporting sk_buff, and suddenly started calling i=
t
> > > > with xdp_md.
> > > >
> > > > From my POV, if I'm a user, and I declare an argument as long and
> > > > annotate it as __arg_ctx, then I know what I'm doing and I'd hate f=
or
> > > > some smart-ass library to double-guess me dictating what exact
> > > > incantation I should specify to make it happy.
> > >
> > > But that's exactly what's happening!
> > > The smart-ass libbpf ignores the type in 'struct sk_buff *skb __arg_c=
tx'
> > > and replaces it with whatever is appropriate for prog type.
> >
> > The only thing that libbpf does in this case is it honors __arg_ctx
> > and makes it work *exactly the same* as __arg_ctx natively works on
> > the newest kernel. Not more, not less. It doesn't change compilation
> > or verification rules. At all.
>
> Here in all previous emails I was talking about both kernel and libbpf.
> Both shouldn't be breaking C rules.
> Not singling out libbpf.
>

Ok, I kept doubting which side (or both) we were talking about.

BTW, just as an aside (and I just realized it), identical checks
performed on global subprog by libbpf and kernel are not really
identical (anymore), because of the kernel's lazy global subprog
validation. Libbpf unfortunately doesn't know which global functions
might be dead code, so we need to be careful about being too eager.


> > Validating f1() func#2...
> > 20: R1=3Dctx() R10=3Dfp0
> > ; int f1(struct sk_buff *skb)
> >
> > It's a context.
>
> Ohh. Looks like I screwed it up back then.
>         /* only compare that prog's ctx type name is the same as
>          * kernel expects. No need to compare field by field.
>          * It's ok for bpf prog to do:
>          * struct __sk_buff {};
>          * int socket_filter_bpf_prog(struct __sk_buff *skb)
>          * { // no fields of skb are ever used }
>          */
>         if (strcmp(ctx_tname, "__sk_buff") =3D=3D 0 && strcmp(tname,
> "sk_buff") =3D=3D 0)
>                 return ctx_type;
>
> See comment. The intent was to allow __sk_buff in prog to
> match with __sk_buff in the kernel.
> Brainfart.

Ok, then at least we shouldn't allow sk_buff in new use cases (like
__arg_ctx tag).

>
> > Not really, see below. For a long time *we thought* that kernel
> > recognizes bpf_user_pt_regs_t, but in reality it wanted `struct
> > bpf_user_pt_regs_t` which doesn't even exist in kernel and has nothing
> > common with either `struct pt_regs` or `struct user_pt_regs`. I fixed
> > that and now the kernel recognizes *both* typedef and struct
> > bpf_user_pt_regs_t. And there is no point in using typedef, because
> > `struct bpf_user_pt_regs_t` is backwards compatible and that's what
> > users actually use in practice.
>
> Hmm.
> The test with
> __weak int kprobe_typedef_ctx_subprog(bpf_user_pt_regs_t *ctx)
>
> was added back in Feb 2023.
> So it was surely working for the last year.

right, but I meant even earlier kernels that did support `struct
bpf_user_pt_regs_t *`, but didn't support `bpf_user_pt_regs_t *`.

>
> > > __PT_REGS_CAST is arch dependent and typeof makes it seen with
> > > correct btf_id and the kernel knows it's PTR_TO_CTX.
> >
> > TBH, I don't know what btf_id has to do with this, it looks either as
> > a distraction or subtle point you are making that I'm missing.
> > __PT_REGS_CAST() just does C language cast, there is no BTF or BTF ID
> > involved here, so what am I missing?
>
> That was your patch :)
> I'm just pointing out the neat trick with typeof to put
> the correct type in there,
> so it's later seen with proper btf_id and recognized as ctx.
> You added it a year ago.

ah, ok. TBH, I don't even know (now) why it works, must be some other
quirk in kernel logic? But either way, this might have been
appropriate for selftest, but I wouldn't recommend users to do this,
it relies on "internal macro" __PT_REGS_CAST, so could technically
break (but also is just pure magic). Anyways, see below.

>
> >
> > Why not? This is what I don't get. Here's a real piece of code to
> > demonstrate what users do in practice:
> >
> > struct bpf_user_pt_regs_t {}
> >
> > __hidden int handle_event_user_pt_regs(struct bpf_user_pt_regs_t* ctx) =
{
> >   if (pyperf_prog_cfg.sample_interval > 0) {
> >     if (__sync_fetch_and_add(&total_events_count, 1) %
> >         pyperf_prog_cfg.sample_interval) {
> >       return 0;
> >     }
> >   }
> >
> >   return handle_event_helper((struct pt_regs*)ctx, NULL);
> > }
>
> I think you're talking about kernel prior to that commit a year ago
> that made it possible to drop 'struct'.

yes, exactly. Global funcs were supported way earlier than my fix.

>
> > I'm saying that I explicitly do want to be able to declare (in general)=
:>
> > int handle_event_user(struct pt_regs *ctx __arg_ctx) { ...}
> >
> > And this would work both on old and new kernels, with and without
> > native __arg_ctx support. And it will be very close to static subprogs
> > in the existing code base.
> >
> > Why do you want to disallow this artificially?
>
> Not artificially, but only when pt_regs in bpf prog doesn't match
> what kernel is passing.
> I think allowing only:
>   handle_event_user(void *ctx __arg_ctx)
> and prog will cast it to pt_regs immediately is less surprising
> and proper C code,
> but
>   handle_event_user(struct pt_regs *ctx __arg_ctx)
> is also ok when pt_regs is indeed what is being passed.
> Which will be the case for x86.
> And will be fine on arm64 too, because
> arch/arm64/include/asm/ptrace.h
> struct pt_regs {
>         union {
>                 struct user_pt_regs user_regs;
>
> but if arm64 ever changes that layout we should start failing to load.

Ok, I'm glad you agreed to allow `struct pt_regs *`. I also will say
that (as it stands right now) passing `struct pt_regs *` is valid on
all architectures, because that's what kernel passes around internally
as context for uprobe, kprobe, and kprobe-multi. See uprobe_prog_run,
kprobe_multi_link_prog_run, and perf_trace_run_bpf_submit, we always
pass real `struct pt_regs *`.

So, I'll add kprobe/multi-kprobe special handling to allows `struct
pt_regs *` then, ok?

>
> > All the above is already checked and enforced by the compiler. Libbpf
> > doesn't subvert it in any way. All that libbpf is doing is saying "ah,
> > user, you want this argument to be treated as PTR_TO_CTX, right? Too
> > bad host kernel is a bit too old to understand __arg_ctx natively, but
> > worry you not, I'll just quickly fix up BTF information that *only
> > kernel* uses *only to check type name* (nothing else!), and it will
> > look like kernel actually understood __arg_ctx, that's all, happy
> > BPF'ing!".
>
> and this way libbpf _may_ introduce a hard to debug bug.
> The same mistake the new kernel _may_ do with __arg_ctx with old libbpf.
> Both will do a hidden typecast when the bpf prog is
> potentially written with different type.
>
> foo(struct pt_regs *ctx __arg_ctx)
> Quick git grep shows that it will probably work on all archs
> except 'arc' where
> arch/arc/include/uapi/asm/bpf_perf_event.h:typedef struct
> user_regs_struct bpf_user_pt_regs_t;
> and struct pt_regs seems to have a different layout than user_regs_struct=
.
>
> But when kernel allows sk_buff to be passed into
> foo(struct pt_regs *ctx __arg_ctx)
> is just broken.

Yes, of course, sk_buff instead of pt_regs is definitely broken. But
that will be detected even by the compiler.

Anyways, I can add special casing for pt_regs and start enforcing
types. A bit hesitant to do that on libbpf side, still, due to that
eager global func behavior, which deviates from kernel, but if you
insist I'll do it.

(Eduard, I'll add feature detection for the need to rewrite BTF at the
same time, just FYI)

Keep in mind, though, for non-global subprogs kernel doesn't enforce
any types, so you can really pass sk_buff into pt_regs argument, if
you really want to, but kernel will happily still assume PTR_TO_CTX
(and I'm sure you know this as well, so this is mostly for others and
for completeness).

