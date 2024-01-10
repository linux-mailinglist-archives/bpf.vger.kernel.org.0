Return-Path: <bpf+bounces-19337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A360A82A0A4
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 20:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22691C22AF3
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 19:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A241F4D596;
	Wed, 10 Jan 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss8EitQ2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6986D4E1A6
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28bf46ea11so790961366b.1
        for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 11:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704913372; x=1705518172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qS8CDMJJik3fKlfTDdsY8tgMC/n4E7zCX5YicbaQSYM=;
        b=Ss8EitQ2feGezquiZeC4dCRxNCy0iKvk6j71m0rb1NiS0RnT2nvcKGPWZS9v2z60tE
         fLLpX81yW0+0eMp6yffn4MHzB/JUafgk352eHd8tdjhPvmW8fkVIvuHF4tXWdH3nB40v
         RQcaV8gvwcLLpk4klG9P+AB430PSiQOvVWpii3AmRTm5QSopJu8SoK2ZwDC9jj9LWpUs
         1NmU+8/SoLxp0MEMeL5OQ3Bzko11pPppAnvKSnXqaMdU0ewp+y9uwRMox0QdaqPwksuy
         hcR2O+FtCxPkaIMEtNwrdFtADyUd6/2ng5aYoHZqHzviupNAD0/KFeEeAbXyJ7bu6Y4Q
         xMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704913372; x=1705518172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qS8CDMJJik3fKlfTDdsY8tgMC/n4E7zCX5YicbaQSYM=;
        b=V6QbTPch2X5bHxuyWenIXJghpM2T8p0B1rMkuhPYKLak9g8WKUGC97opXs9B3+3UOd
         IwpO2/dO8l49+Ac3SRApzVkXIgZxOjc/1ZRIxC9oC4PcQ/NnuvDgAjzK1VoMMGagJ4gX
         pvYZES/CyoL76KjB9IXKj0lQ/WyB1K9yzIvzo1C38V7+a2FeBliEJ2r/k8MuOrPoCOSZ
         HO/6DW3NkJmwpPa0kaCXZgnLG4AjhNoxxnhvsRfXnN17g1ovQWrv2+MjvFnjjrNV/GU1
         V5H0mgEFQJ+ZWK4bIAf90t/oSFc+9quK7kyxPZW/TKokS3mAZy5vkN12oKcZOWop46nl
         5+5g==
X-Gm-Message-State: AOJu0YzWttKGpY3ukxX3DYMTTrP0A1d2dkA02IRiH6ke4geyysgWw/+g
	3ArFoA22N4k9cKKEIQ+uLOKGOylQ6eeHUOlZ5Z8=
X-Google-Smtp-Source: AGHT+IHI6zCCnwdtysWLYjW3xjgah+47EyCkSLkFwSDqxFsR2Q/hTNMP4ID8naSCBBaR1j9QI+1+iygjizXzKs1gNv4=
X-Received: by 2002:a17:906:5584:b0:a2a:b340:7126 with SMTP id
 y4-20020a170906558400b00a2ab3407126mr550479ejp.6.1704913371426; Wed, 10 Jan
 2024 11:02:51 -0800 (PST)
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
 <CAEf4Bza=axzY_BLDEFU63-dsSNSwZs5VLxDKGj+u9L5ze7=NtQ@mail.gmail.com>
 <CAADnVQKRMoBwS+9jhm72Bij1RicJHa8bkYJZTF1bLyySxsYCNg@mail.gmail.com>
 <CAEf4BzZb8TBsima2nQ721tqvvGpuhtdoGdLoTKtovtQ1M+8yyg@mail.gmail.com> <CAADnVQLN3TxefCEw_p3ELjactONckNJ4tnmDLiNPMEqsNtkKLA@mail.gmail.com>
In-Reply-To: <CAADnVQLN3TxefCEw_p3ELjactONckNJ4tnmDLiNPMEqsNtkKLA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jan 2024 11:02:38 -0800
Message-ID: <CAEf4BzZyDAhCNYjeknVuibwU1FV3KtyRGPHUyGdwy0Sj5S-LCw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 7/9] libbpf: implement __arg_ctx fallback logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 5:58=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 9, 2024 at 9:17=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Jan 8, 2024 at 5:49=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Jan 8, 2024 at 3:45=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > >
> > > > > Not artificially, but only when pt_regs in bpf prog doesn't match
> > > > > what kernel is passing.
> > > > > I think allowing only:
> > > > >   handle_event_user(void *ctx __arg_ctx)
> > > > > and prog will cast it to pt_regs immediately is less surprising
> > > > > and proper C code,
> > > > > but
> > > > >   handle_event_user(struct pt_regs *ctx __arg_ctx)
> > > > > is also ok when pt_regs is indeed what is being passed.
> > > > > Which will be the case for x86.
> > > > > And will be fine on arm64 too, because
> > > > > arch/arm64/include/asm/ptrace.h
> > > > > struct pt_regs {
> > > > >         union {
> > > > >                 struct user_pt_regs user_regs;
> > > > >
> > > > > but if arm64 ever changes that layout we should start failing to =
load.
> > > >
> > > > Ok, I'm glad you agreed to allow `struct pt_regs *`. I also will sa=
y
> > > > that (as it stands right now) passing `struct pt_regs *` is valid o=
n
> > > > all architectures, because that's what kernel passes around interna=
lly
> > > > as context for uprobe, kprobe, and kprobe-multi. See uprobe_prog_ru=
n,
> > > > kprobe_multi_link_prog_run, and perf_trace_run_bpf_submit, we alway=
s
> > > > pass real `struct pt_regs *`.
> > >
> > > Right, but for perf event progs it's actually bpf_user_pt_regs_t:
> > > ctx.regs =3D perf_arch_bpf_user_pt_regs(regs);
> > > bpf_prog_run(prog, &ctx);
> > > yet all such progs are written assuming struct pt_regs
> > > which is not correct.
> >
> > Yes, SEC("perf_event") programs have very different context
> > (bpf_perf_event_data, where *pointer to pt_regs* is the first field,
> > so it's not compatible even memory layout-wise). So I'm not going to
> > allow struct pt_regs there.
>
> Not quite. I don't think we're on the same page.
>
> Technically SEC("perf_event") bpf_prog should see a pointer to:
> struct bpf_perf_event_data {
>         bpf_user_pt_regs_t regs;
>         __u64 sample_period;
>         __u64 addr;
> };
>
> but a lot of them are written as:
> SEC("perf_event")
> int handle_pe(struct pt_regs *ctx)
>
> and it's working, because of magic (or ugliness, it depends on pov) that
> we do in pe_prog_convert_ctx_access() (that inserts extra load).

Ah, I didn't know about this part. I checked bpf_perf_event_data_kern
and saw a pointer for regs, but didn't realize it's remapped as an
embedded struct for perf_event programs by verifier.

>
> The part where I'm saying:
> "written assuming struct pt_regs which is not correct".
>
> The incorrect part is that the prog have access only to bpf_user_pt_regs_=
t
> and the prog should be written as:
> SEC("perf_event")
> int pe_prog(bpf_user_pt_regs_t *ctx)
> or as
> SEC("perf_event")
> int pe_prog(struct bpf_perf_event_data *ctx)
>
> but in generic case not as:
> SEC("perf_event")
> int pe_prog(struct pt_regs *ctx)
>
> because that is valid only on archs where bpf_user_pt_regs_t =3D=3D pt_re=
gs.

I guess for perf_event I can just add `struct pt_regs * __arg_ctx`
support if (typeof(struct pt_regs) =3D=3D typeof(bpf_user_pt_regs_t)), or
something along those lines. I'll need to check if that works
correctly.

>
> > > It's a bit of a mess while strict type checking should make it better=
.
> > >
> > > BPF is a strictly typed assembly language and the verifier
> > > should not be violating its own promises of type checking when
> > > it sees arg_ctx.
> > >
> > > The reason I was proposing to restrict both kernel and libbpf
> > > to 'void *ctx __arg_ctx' is because it's trivial to implement
> > > in both.
> > > To allow 'struct correct_type *ctx __arg_ctx' generically is much mor=
e
> > > work.
> >
> > Yes, it's definitely more complicated (but kernel has full BTF info,
> > so maybe not too bad, I need to try). I'll give it a try, if it's too
> > bad, we can discuss a fallback plan.
>
> right. the kernel has btf and everything, but as seen in perf_event examp=
le
> above it's not trivial to do the type match... even in the kernel.
> Matching the accurate type in libbpf is imo too much complexity.
>

Heh, we agree on this. But we disagree on solutions :) But my proposed
solution was to rely on users and compilers, just like we do with
static subprogs :) But you want to restrict it to `void *`. Alright.

> > But we should try at least,
> > forcing users to do unnecessary void * casts to u64[] or tracepoint
> > struct is suboptimal from usability POV.
>
> That part of usability concerns I still don't understand.
> Where do you see "suboptimal usability" in the code:
>
> SEC("perf_event")
> int pe_prog(void *ctx __arg_ctx)
> {
>   struct pt_regs *regs =3D ctx;
>
> ?
> It's a pretty clear interface and the program author knows exactly
> what it's doing. It's an explicit cast because the user wrote it.
> Clear, unambiguous and no surprises.

I'm not saying it's disastrous. But my point is that, say, for
tracepoint, it's natural to want to do this, and that's what users
might do first:

int global_subprog(struct syscall_trace_enter* ctx __arg_ctx) {
    return ctx->args[0];
}

SEC("tracepoint/syscalls/sys_enter_kill")
int tracepoint__syscalls__sys_enter_kill(struct syscall_trace_enter* ctx) {
   ...
   global_subprog(ctx);
   ...
}

And it will be rejected. User will have WTF moment, maybe ask online
or maybe will figure out by themselves that he needs to rewrite
global_subprog as:

int global_subprog(void *ctx __arg_ctx) {
    struct syscall_trace_enter* ctx1 =3D ctx;

    return ctx1->args[0];
}

It works and it's easy to work around. But it's a stumbling point for
global subprog adoption/conversion, I think. While on the other hand
users having to debug issues due to using `struct pt_regs` instead of
`bpf_user_pt_regs_t` is quite theoretical, tbh (because of
PT_REGS_xxx() macros doing the right thing).

>
> Also we shouldn't forget interaction with CO-RE (preserve_access_index)
> and upcoming preserve_context_offset.
>
> When people do #include <vmlinux.h> they get unnecessary CO-RE-ed
> 'struct pt_regs *' and hidden type conversion by libbpf/kernel
> is another level of debug complexity.

This is where I don't get why you keep saying this :) What libbpf is
doing is just rewriting FUNC->FUNC_PROTO declaration just before
loading BTF into kernel. It's a sleight of hand just to make kernel
recognize argument (declaratively) as PTR_TO_CTX.

All the CO-RE relocations, preserve_context_offset, etc, all that is
done *before all this** and are **absolutely irrelevant** to this
whole discussion. Compiler will generate offsets based on original C
types that user specified. Libbpf will do CO-RE relocations based on
original BTF information (with user's original types).

So all the stuff libbpf is doing here for __arg_ctx has no bearing on the a=
bove.

>
> libbpf doesn't even print what it did in bpf_program_fixup_func_info()
> no matter the verbosity flag.
>
> > >
> > > > So, I'll add kprobe/multi-kprobe special handling to allows `struct
> > > > pt_regs *` then, ok?
> > >
> > > If you mean to allow 'void *ctx __arg_ctx' in kernel and libbpf and
> > > in addition allow 'struct pt_reg *ctx __arg_ctx' for kprobe and other
> > > prog types where that's what is being passed then yes.
> > > Totally fine with me.
> > > These two are easy to enforce in kernel and libbpf.
> >
> > Ok, great.
> >
> > >
> > > > Yes, of course, sk_buff instead of pt_regs is definitely broken. Bu=
t
> > > > that will be detected even by the compiler.
> > >
> > > Right. C can do casts, but in bpf asm the verifier promises strict ty=
pe
> > > checking and it goes further and makes safety decisions based on type=
s.
> > >
> >
> > It feels like you are thinking about PTR_TO_BTF_ID only and
> > extrapolating that behavior to everything else. You know that it's not
> > like that in general.
>
> imo trusted ptr_to_btf_id and ptr_to_ctx are equivalent.
> They're fully trusted from the verifier pov and fully correct
> from bpf prog pov. So neither should have hidden type casts.

But my point is that the BPF verifier itself doesn't not treat them
the same today. For context argument, the verifier just assumes valid
PTR_TO_CTX and never looks at BTF information.

But I also think it's ironic that above you suggested this to be totally fi=
ne:

  > int pe_prog(void *ctx __arg_ctx)
  > {
  >   struct pt_regs *regs =3D ctx;

Which is totally a cast, and has no bearing on verifier's PTR_TO_CTX treatm=
ent.

But we are getting a bit philosophical, I propose we put this to rest.

>
> Of course, I remember bpf_rdonly_cast. But this one is untrusted.
> It's equivalent to C type cast.
>
> > > > Anyways, I can add special casing for pt_regs and start enforcing
> > > > types. A bit hesitant to do that on libbpf side, still, due to that
> > > > eager global func behavior, which deviates from kernel, but if you
> > > > insist I'll do it.
> > >
> > > I don't understand this part.
> > > Both kernel and libbpf can check
> > > if (btf_type_id(ctx) =3D=3D 'struct pt_regs'
> > >   && prog_type =3D=3D kprobe) allow such __arg_ctx.
> > >
> >
> > I was thinking about the case where we have __arg_ctx and type doesn't
> > match expectation. Should libbpf error out? Or emit a warning and
> > proceed without adjusting types? If we do the warning and let verifier
> > reject invalid program, I think it will be better and then these
> > concerns of mine about lazy vs eager global subprog verification
> > behavior are irrelevant.
>
> I think warn in libbpf is fine.
> Old kernel will likely fail verification since types won't match
> and libbpf warn will serve its purpose,
> but for the new kernel both libbpf and kernel will print
> two similar looking warns?

I'm going to add feature detection and disable this __arg_ctx
treatment on libbpf side (for new kernels, of course). So yes, on old
kernels verifier will reject argument (because it won't be PTR_TO_CTX)
and we'll have libbpf warning. And on new one any check will be done
directly by verifier and emitted properly in verifier log (which I
think is better than libbpf's warnings, especially taking into account
veristat and tools like that that by default emit only verifier log on
failures).

>
> >
> > > >
> > > > (Eduard, I'll add feature detection for the need to rewrite BTF at =
the
> > > > same time, just FYI)
> > > >
> > > > Keep in mind, though, for non-global subprogs kernel doesn't enforc=
e
> > > > any types, so you can really pass sk_buff into pt_regs argument, if
> > > > you really want to, but kernel will happily still assume PTR_TO_CTX
> > > > (and I'm sure you know this as well, so this is mostly for others a=
nd
> > > > for completeness).
> > >
> > > static functions are very different. They're typeless and will stay
> > > typeless for some time.
> >
> > Right. And they are different in how we verify and so on. But from the
> > user's perspective they are still just functions and (in my mind at
> > least), the less difference between static and global subprogs there
> > are, the better.
> >
> > But anyways, I'll do what we agreed above. I'll proceed with libbpf
> > emitting warning and not doing anything for __arg_ctx, unless you feel
> > strongly libbpf should error out.
>
> warn is fine. thanks.

Alright, cool, will work on this and add it in v2 of [0]. If you get
time, please check that one as well (unless you already did).

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D814516&=
state=3D*

