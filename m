Return-Path: <bpf+bounces-15599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227497F3884
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 22:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7516282344
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 21:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61D442060;
	Tue, 21 Nov 2023 21:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRGpcSDg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CC7A4
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 13:56:11 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00191363c1so307985566b.0
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 13:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700603769; x=1701208569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WIb5dLOASoWXyXQEHW0Tw+CVn81K9SdFMNpdetumo0=;
        b=kRGpcSDgW3dTJ3fRdgLSFoX50TcTuO1p/CkdfrXfJTOpH76qBc9CjlBp3/W8R9hCDc
         9ACqHvotyy/uU9lJ1gHtiZRu4SiE3CyCnkHj8D8pML/Ke03nLX5Kmq5cr02g6FbwnEp0
         GkmNZi54CpxznwjgOfkXXFlPYbH6rPyNlZ4f4IbRMrjv2Ddd2zEmCOvsxgQ6wJMScELc
         93uaMTApfdZhU3qrGgAVa3sX9QBdaQxBY1oUoBpy2w5wOhck2sm9t+TA6jv3V9CMnXT9
         4u/Xay5UgvZET+MtWEOYpites9HmPo6qy96AZsKMAVMYB5H/Z3ODJQT/pOml+f1ITTp/
         25Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700603769; x=1701208569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WIb5dLOASoWXyXQEHW0Tw+CVn81K9SdFMNpdetumo0=;
        b=j3u22voSplm0FGB6lbJsZv/+4hKZAqWm2zjpo72PWMam5W9kS7y3zoDopoiUa7Xw65
         niUvAA2cjAGEJKdskxvEpEujYKTwuqWE02w52sGD9ZlZHRA4uJry/9QBIiRb/fk5SN1K
         qBeSJymIXuHIUIJAA86jGCDOkfRXEMz2H+o5cOCpuGv83/sZNSyKbXiGBKF9jELwkert
         839hOCXxjodB9UklaQSV7+8qzAKLDV2DD5HZq/tX0W/M1SfjmpF8pNQbNvOeMUSYDC69
         9kOPGrMrzuA+HtwOHL3VSIV1PRa9yg2Si10G8qRZUmU/QpJ63AmdDffQyB241HRkUFRj
         98DQ==
X-Gm-Message-State: AOJu0YxH/uFAbKmR5bGwMBM3U2klWu7yI3wSQmHn7kSHTK9yTfPagX4Q
	myXOwRgR9pNvX7qjgmpSqsfHssMLKoOziTtnUyo=
X-Google-Smtp-Source: AGHT+IEaHP1Lji1muohJfCyhOxEz4g/D2+3A69WgUtjVjiQFCUMi+VCiD93arB8hqF7vPrWuHEdUF4gVNqKHklayq2g=
X-Received: by 2002:a17:906:3743:b0:9fe:6546:6cd2 with SMTP id
 e3-20020a170906374300b009fe65466cd2mr130572ejc.32.1700603769122; Tue, 21 Nov
 2023 13:56:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113235008.127238-1-andreimatei1@gmail.com>
 <CAEf4BzZbXML3oWaHejXRFNAG4NM2vGpsz9axjvOX6wKxEG+ExA@mail.gmail.com>
 <CACkBjsbWdOVMs7vRXvxi0MCoOAh+skYWFN1douBjkRzeTX=wvg@mail.gmail.com> <CABWLsesztKnQosM+bkBq-H5yPvFNc02uh5hrEgwRBAz6ja9Q4g@mail.gmail.com>
In-Reply-To: <CABWLsesztKnQosM+bkBq-H5yPvFNc02uh5hrEgwRBAz6ja9Q4g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 Nov 2023 13:55:57 -0800
Message-ID: <CAEf4BzaJ41MJKk71Ex_HmLyhcoe9a_2jhvLiYxcXNSvK=6oNmg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix tracking of stack size for var-off access
To: Andrei Matei <andreimatei1@gmail.com>
Cc: Hao Sun <sunhao.th@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 12:30=E2=80=AFPM Andrei Matei <andreimatei1@gmail.c=
om> wrote:
>
> On Tue, Nov 21, 2023 at 12:16=E2=80=AFPM Hao Sun <sunhao.th@gmail.com> wr=
ote:
> >
> > On Tue, Nov 21, 2023 at 1:46=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > >
> > > It *feels* like this stack depth update *and* growing allocated stack
> > > slots should happen somewhere in check_stack_access_within_bounds() o=
r
> > > right after it. It shouldn't matter whether we read or write to the
> > > stack slot: either way that slot becomes part of the verifier state
> > > that we should take into account during state comparison. Eduard not
> > > so long ago added a change that allows reading STACK_INVALID slots, s=
o
> > > it's completely valid to read something that was never written to (an=
d
> > > so grow_stack_state() wasn't called for that slot, as it is
> > > implemented right now). So I think we should fix that.
> > >
> >
> > Agree. The following cases are currently confusing to me.
>
> Like Hao, I'm also confused about when reads from unitialized stack slots=
 are
> supposed to be allowed and when they're not. For example, the "uninitiali=
zed
> stack1" test ([0]) seems to check that at least some type of uninitialize=
d read
> is not permitted. The reason why the respective access is rejected and th=
is
> test currently passes is the following check in check_stack_range_initial=
ized:
> [1]. We summarily reject the access to slots beyond state->allocated_stac=
k. If
> we were to not reject them there, and instead treat the slots as STACK_IN=
VALID,
> then the test's access would be allowed just below, through the combinati=
on of
> env->allow_uninit_stack and `clobber`.

And that seems like a consistent and sane behavior if
bpf_allow_uninit_stack() is true, so I vote for fixing the test and
make the logic consistent.

>
> So, assuming that this tests (and a few others) are sane, Andrii's sugges=
tion
> of calling grow_stack_state()/update_stack_depth() in
> check_stack_access_within_bounds() does not immediately work: doing so
> would change
> the behavior in check_stack_range_initialized() and allow the access.
>
> On the other hand, perhaps the test is not sane and the access should be
> permitted, in the spirit of allowing reads of uninitialized stack? Perhap=
s the
> different treatment of slots beyond state->allocated_stack and STACK_INVA=
LID

yes, I think this divergence is not intentional, but maybe Eduard
remembers some other quirks and why it is what it is, let's see.

> slots is not intentional. Though, I am fairly confused about the idea of
> allowing such reads in general - don't they allow leaking of kernel memor=
y from
> the uninit stack to user space? Even if restricted to root, is the leak o=
k?

This is guarded by bpf_allow_uninit_stack(), which check CAP_PERFMON.
Once BPF program has CAP_PERFMON, it can do bpf_probe_read_kernel()
and generally can leak whatever kernel memory. So that's why
STACK_INVALID is allowed to be read in such case. There is also
bpf_allow_ptr_leaks() which also checks CAP_PERFMON.

>
> To also state the obvious - I'm happy to continue working on this patch a=
nd fix
> a bug I've caused. However, if someone who actually knows the deal wants =
to
> take over, I'm certainly not attached to anything :).

It would be great if you can finish this, absolutely! Thanks!

>
> [0] https://github.com/torvalds/linux/blob/98b1cc82c4affc16f5598d4fa14b18=
58671b2263/tools/testing/selftests/bpf/progs/verifier_basic_stack.c#L28-L44
> [1] https://github.com/torvalds/linux/blob/98b1cc82c4affc16f5598d4fa14b18=
58671b2263/kernel/bpf/verifier.c#L7280
>
>
> >
> > The verifier accepts the following program, which goes from #4 to #8
> > and directly read the stack at runtime without any previous write:
> > func#0 @0
> > 0: R1=3Dctx() R10=3Dfp0
> > 0: (bf) r6 =3D r10                      ; R6_w=3Dfp0 R10=3Dfp0
> > 1: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
> > 2: (bf) r3 =3D r0                       ; R0_w=3Dscalar(id=3D1) R3_w=3D=
scalar(id=3D1)
> > 3: (bf) r8 =3D r0                       ; R0_w=3Dscalar(id=3D1) R8_w=3D=
scalar(id=3D1)
> > 4: (4e) if w0 & w3 goto pc+3          ; R0_w=3Dscalar(id=3D1) R3_w=3Dsc=
alar(id=3D1)
> > 5: (63) *(u32 *)(r6 -196) =3D r3        ; R3_w=3Dscalar(id=3D1) R6_w=3D=
fp0
> > fp-200=3Dmmmm????
> > 6: (18) r7 =3D 0x19                     ; R7=3D25
> > 8: (61) r7 =3D *(u32 *)(r6 -200)        ; R6=3Dfp0
> > R7_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xfffff=
fff))
> > fp-200=3Dmmmm????
> > 9: (95) exit
> >
> > from 4 to 8: safe
> > verification time 358 usec
> > stack depth 200
> > processed 10 insns (limit 1000000) max_states_per_insn 0 total_states
> > 1 peak_states 1 mark_read 1
> >
> > The state is pruned, because of this:
> > static bool stacksafe(...)
> >          ....
> >          if (env->allow_uninit_stack &&
> >              old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D STACK_M=
ISC)
> >              continue;
> >
> > Yet, the sample direct read would be rejected:
> >
> > func#0 @0
> > 0: R1=3Dctx() R10=3Dfp0
> > 0: (bf) r6 =3D r10                      ; R6_w=3Dfp0 R10=3Dfp0
> > 1: (61) r7 =3D *(u32 *)(r6 -200)
> > invalid read from stack R6 off=3D-200 size=3D4
> >
> > Eduard, you added support for reading uninit slots, should we also add =
something
> > like the following:
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8c2d31aa3d31..aa861d2da240 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6446,7 +6446,7 @@ static int check_stack_slot_within_bounds(int off=
,
> >  {
> >         int min_valid_off;
> >
> > -       if (t =3D=3D BPF_WRITE)
> > +       if (t =3D=3D BPF_WRITE || env->allow_uninit_stack)
> >                 min_valid_off =3D -MAX_BPF_STACK;
> >         else
> >                 min_valid_off =3D -state->allocated_stack;

as I mentioned above, yes, I think the behavior should be consistent
and such accesses should be allowed, just as if it was STACK_INVALID

