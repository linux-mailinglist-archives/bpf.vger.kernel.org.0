Return-Path: <bpf+bounces-19305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F24B829243
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 02:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE75D2890AB
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 01:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30D17C6;
	Wed, 10 Jan 2024 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/Hep8js"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37261376
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3376ead25e1so2114585f8f.3
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 17:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704851939; x=1705456739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5M3+LBO/KZxNaWEYtB+DLf5AyqFgs/gsvlqVHmxU/Z4=;
        b=e/Hep8jsBAtTkii1NUWZVWlM8alLk4x/1ye/Km6AGHOra/C36S8Viu8CDAEZMZgEZ/
         Vne0FjndOXxuQXYl2f3/VhxdCB/okL3hkv8nptebKPw0HtJh/zeskDFz9LxR9J2qaHQM
         JsAuoTS4KcvtHGMZzHm1GnEaq0C+DkgSA6BZf57huyYvOzJH9kiGURbdPT4vZiahGDO8
         PvyDoxXoWW8wnQcSZk0V1ny5fd2NcTZeU1iB3HITRYTPIwGeCG10C/rZXyWekPRGU1yj
         CJZW5aFIKC/o2SkM1dTOtMyn90/+BJnwn6YPkLpxL44z+hMERNtHt1V37IcW44jACAB2
         6Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704851939; x=1705456739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5M3+LBO/KZxNaWEYtB+DLf5AyqFgs/gsvlqVHmxU/Z4=;
        b=ishcwkQuELxS+f/o0kCGQlmVBfLV2u8IFQ3n4pyM9vqk4wHTcF3KlXdNoGBoSMsQDr
         VGNG+k8TtlU83rKOeTJ/RWhV/4ezUJhQhVD1HQK1e4IGminHvJytjuzZ5eW6KCko/soo
         bTw+DHHWUKGNHmu8DrVvv4dYZ07rqSBD8kDlXu+BNHNMUhUtRtarekCdSC/hP1C9bgOM
         kWWOk6WeznTDgAV3tA2miVFVaKItQrp0VyeUjJLKq5Xbt6rQkYvbiUgBSQd6AWa/MGgf
         4Fr0ZnI4G6W5/ysAmOq8UpmHRIJtQ1clRKx+jteY2DogQjQUa4vvaLYqzFIoN8fNOW13
         V58g==
X-Gm-Message-State: AOJu0Yw8hhAIUUnGswLtcRGXaFO2XpWZlPe29KbHuNEtqsRwtS01cm/X
	zu+RXn/QUC0F6qMiYNyAaO78RQJkYA8zyWP7APs=
X-Google-Smtp-Source: AGHT+IEVGzPfv9QnxvhYodn6ggCsLUsK86rtDX1IxjyaVEg8QSaVWIDFwK+Crw2G1RNXm1kqRbx6kJfp1lplMCOBxIc=
X-Received: by 2002:a5d:4943:0:b0:336:6907:7322 with SMTP id
 r3-20020a5d4943000000b0033669077322mr121762wrs.28.1704851938719; Tue, 09 Jan
 2024 17:58:58 -0800 (PST)
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
 <CAADnVQKRMoBwS+9jhm72Bij1RicJHa8bkYJZTF1bLyySxsYCNg@mail.gmail.com> <CAEf4BzZb8TBsima2nQ721tqvvGpuhtdoGdLoTKtovtQ1M+8yyg@mail.gmail.com>
In-Reply-To: <CAEf4BzZb8TBsima2nQ721tqvvGpuhtdoGdLoTKtovtQ1M+8yyg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Jan 2024 17:58:47 -0800
Message-ID: <CAADnVQLN3TxefCEw_p3ELjactONckNJ4tnmDLiNPMEqsNtkKLA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 7/9] libbpf: implement __arg_ctx fallback logic
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 9:17=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jan 8, 2024 at 5:49=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jan 8, 2024 at 3:45=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > >
> > > > Not artificially, but only when pt_regs in bpf prog doesn't match
> > > > what kernel is passing.
> > > > I think allowing only:
> > > >   handle_event_user(void *ctx __arg_ctx)
> > > > and prog will cast it to pt_regs immediately is less surprising
> > > > and proper C code,
> > > > but
> > > >   handle_event_user(struct pt_regs *ctx __arg_ctx)
> > > > is also ok when pt_regs is indeed what is being passed.
> > > > Which will be the case for x86.
> > > > And will be fine on arm64 too, because
> > > > arch/arm64/include/asm/ptrace.h
> > > > struct pt_regs {
> > > >         union {
> > > >                 struct user_pt_regs user_regs;
> > > >
> > > > but if arm64 ever changes that layout we should start failing to lo=
ad.
> > >
> > > Ok, I'm glad you agreed to allow `struct pt_regs *`. I also will say
> > > that (as it stands right now) passing `struct pt_regs *` is valid on
> > > all architectures, because that's what kernel passes around internall=
y
> > > as context for uprobe, kprobe, and kprobe-multi. See uprobe_prog_run,
> > > kprobe_multi_link_prog_run, and perf_trace_run_bpf_submit, we always
> > > pass real `struct pt_regs *`.
> >
> > Right, but for perf event progs it's actually bpf_user_pt_regs_t:
> > ctx.regs =3D perf_arch_bpf_user_pt_regs(regs);
> > bpf_prog_run(prog, &ctx);
> > yet all such progs are written assuming struct pt_regs
> > which is not correct.
>
> Yes, SEC("perf_event") programs have very different context
> (bpf_perf_event_data, where *pointer to pt_regs* is the first field,
> so it's not compatible even memory layout-wise). So I'm not going to
> allow struct pt_regs there.

Not quite. I don't think we're on the same page.

Technically SEC("perf_event") bpf_prog should see a pointer to:
struct bpf_perf_event_data {
        bpf_user_pt_regs_t regs;
        __u64 sample_period;
        __u64 addr;
};

but a lot of them are written as:
SEC("perf_event")
int handle_pe(struct pt_regs *ctx)

and it's working, because of magic (or ugliness, it depends on pov) that
we do in pe_prog_convert_ctx_access() (that inserts extra load).

The part where I'm saying:
"written assuming struct pt_regs which is not correct".

The incorrect part is that the prog have access only to bpf_user_pt_regs_t
and the prog should be written as:
SEC("perf_event")
int pe_prog(bpf_user_pt_regs_t *ctx)
or as
SEC("perf_event")
int pe_prog(struct bpf_perf_event_data *ctx)

but in generic case not as:
SEC("perf_event")
int pe_prog(struct pt_regs *ctx)

because that is valid only on archs where bpf_user_pt_regs_t =3D=3D pt_regs=
.

> > It's a bit of a mess while strict type checking should make it better.
> >
> > BPF is a strictly typed assembly language and the verifier
> > should not be violating its own promises of type checking when
> > it sees arg_ctx.
> >
> > The reason I was proposing to restrict both kernel and libbpf
> > to 'void *ctx __arg_ctx' is because it's trivial to implement
> > in both.
> > To allow 'struct correct_type *ctx __arg_ctx' generically is much more
> > work.
>
> Yes, it's definitely more complicated (but kernel has full BTF info,
> so maybe not too bad, I need to try). I'll give it a try, if it's too
> bad, we can discuss a fallback plan.

right. the kernel has btf and everything, but as seen in perf_event example
above it's not trivial to do the type match... even in the kernel.
Matching the accurate type in libbpf is imo too much complexity.

> But we should try at least,
> forcing users to do unnecessary void * casts to u64[] or tracepoint
> struct is suboptimal from usability POV.

That part of usability concerns I still don't understand.
Where do you see "suboptimal usability" in the code:

SEC("perf_event")
int pe_prog(void *ctx __arg_ctx)
{
  struct pt_regs *regs =3D ctx;

?
It's a pretty clear interface and the program author knows exactly
what it's doing. It's an explicit cast because the user wrote it.
Clear, unambiguous and no surprises.

Also we shouldn't forget interaction with CO-RE (preserve_access_index)
and upcoming preserve_context_offset.

When people do #include <vmlinux.h> they get unnecessary CO-RE-ed
'struct pt_regs *' and hidden type conversion by libbpf/kernel
is another level of debug complexity.

libbpf doesn't even print what it did in bpf_program_fixup_func_info()
no matter the verbosity flag.

> >
> > > So, I'll add kprobe/multi-kprobe special handling to allows `struct
> > > pt_regs *` then, ok?
> >
> > If you mean to allow 'void *ctx __arg_ctx' in kernel and libbpf and
> > in addition allow 'struct pt_reg *ctx __arg_ctx' for kprobe and other
> > prog types where that's what is being passed then yes.
> > Totally fine with me.
> > These two are easy to enforce in kernel and libbpf.
>
> Ok, great.
>
> >
> > > Yes, of course, sk_buff instead of pt_regs is definitely broken. But
> > > that will be detected even by the compiler.
> >
> > Right. C can do casts, but in bpf asm the verifier promises strict type
> > checking and it goes further and makes safety decisions based on types.
> >
>
> It feels like you are thinking about PTR_TO_BTF_ID only and
> extrapolating that behavior to everything else. You know that it's not
> like that in general.

imo trusted ptr_to_btf_id and ptr_to_ctx are equivalent.
They're fully trusted from the verifier pov and fully correct
from bpf prog pov. So neither should have hidden type casts.

Of course, I remember bpf_rdonly_cast. But this one is untrusted.
It's equivalent to C type cast.

> > > Anyways, I can add special casing for pt_regs and start enforcing
> > > types. A bit hesitant to do that on libbpf side, still, due to that
> > > eager global func behavior, which deviates from kernel, but if you
> > > insist I'll do it.
> >
> > I don't understand this part.
> > Both kernel and libbpf can check
> > if (btf_type_id(ctx) =3D=3D 'struct pt_regs'
> >   && prog_type =3D=3D kprobe) allow such __arg_ctx.
> >
>
> I was thinking about the case where we have __arg_ctx and type doesn't
> match expectation. Should libbpf error out? Or emit a warning and
> proceed without adjusting types? If we do the warning and let verifier
> reject invalid program, I think it will be better and then these
> concerns of mine about lazy vs eager global subprog verification
> behavior are irrelevant.

I think warn in libbpf is fine.
Old kernel will likely fail verification since types won't match
and libbpf warn will serve its purpose,
but for the new kernel both libbpf and kernel will print
two similar looking warns?

>
> > >
> > > (Eduard, I'll add feature detection for the need to rewrite BTF at th=
e
> > > same time, just FYI)
> > >
> > > Keep in mind, though, for non-global subprogs kernel doesn't enforce
> > > any types, so you can really pass sk_buff into pt_regs argument, if
> > > you really want to, but kernel will happily still assume PTR_TO_CTX
> > > (and I'm sure you know this as well, so this is mostly for others and
> > > for completeness).
> >
> > static functions are very different. They're typeless and will stay
> > typeless for some time.
>
> Right. And they are different in how we verify and so on. But from the
> user's perspective they are still just functions and (in my mind at
> least), the less difference between static and global subprogs there
> are, the better.
>
> But anyways, I'll do what we agreed above. I'll proceed with libbpf
> emitting warning and not doing anything for __arg_ctx, unless you feel
> strongly libbpf should error out.

warn is fine. thanks.

