Return-Path: <bpf+bounces-15592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E977F3771
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 21:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C621C20D89
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 20:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2309855775;
	Tue, 21 Nov 2023 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaZLesun"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B69198A
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 12:30:11 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9fcfd2a069aso399122466b.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 12:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700598609; x=1701203409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaC9cTCxr8fl1DcVVJ2MHPJ0YoO8zbDODwFZQIQqkxA=;
        b=QaZLesun7rNyhfTAk1u4o8Z4PXB/NwZ32rEApu4SToTx1SHQWiK3f1Qg+kbGXGRepr
         pOPYtIoR80vpKib6QyAVCm8hkD1MNDVld17z/1s/fZN7YGVtE/kPfAAzKOqRNMMil2Km
         89MuAJEYlFEdYtFjboLl/rxhG/6OPG6HLv5kRBefZSH2gtcyYkT7kmNGfnMKaTeCSt6Z
         P6p1YZlg5fJuNeiOc7DDwMAxOOk3JP/Cwk5pzMw/pxoOMsuqh6bMqBpmKGTI2mBIDTgU
         wdNllnpozk6cL8TAFRwEkH5YA8kD1OCBVx8vp9niQZgNEzt0CgNQ26Hf1z80P9Y/y+7N
         qNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700598609; x=1701203409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaC9cTCxr8fl1DcVVJ2MHPJ0YoO8zbDODwFZQIQqkxA=;
        b=tqenJ7axCGznTiivFPs0MsHDmfTGvhLLNzenOERTMok0ucQucnpXU1Yt6ButwLQTpb
         9Lc7Y19As8YqCEDnDMC8qgZamRNHldpAHTlnBjEfSmzMSD6xf7dAp7QsdYudXaxWcjD8
         FipAuR4QWxtgKtI00kV50u+emDG5J+54l2bIexIazdPdJxd2CfoepRO8KNykpYkByv0w
         iVYN98kvHnfYyp5eUNbcn41fIwImyM0lafGG7oXEzEOK6c+oZmgXG23K2AndvsRy1alM
         W+uz1xi0bhyh4rASR4C9IcwXVQ0PeZoOgldfdxyvLh2I3aHlQitq4KvqNHw6mP9OKYOE
         /d2A==
X-Gm-Message-State: AOJu0YyJOEAvUAzEn+7Fn+diF2vsEVJzWPiV2/VI+drEY5hWrJo79vN6
	U2dq2QZqRQq0f70K+CIcYWHTjAgnsYjCdIocwUI=
X-Google-Smtp-Source: AGHT+IH57eUPhjIoN68kfOtpD6sHrjlJSIHmyPZgPFOuWE9MBxT+VIHGJkGkto7vudnqsnae3xBG5RsrkP13cLpJydo=
X-Received: by 2002:a17:906:34db:b0:9e4:198e:6c30 with SMTP id
 h27-20020a17090634db00b009e4198e6c30mr29854ejb.45.1700598608904; Tue, 21 Nov
 2023 12:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113235008.127238-1-andreimatei1@gmail.com>
 <CAEf4BzZbXML3oWaHejXRFNAG4NM2vGpsz9axjvOX6wKxEG+ExA@mail.gmail.com> <CACkBjsbWdOVMs7vRXvxi0MCoOAh+skYWFN1douBjkRzeTX=wvg@mail.gmail.com>
In-Reply-To: <CACkBjsbWdOVMs7vRXvxi0MCoOAh+skYWFN1douBjkRzeTX=wvg@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Tue, 21 Nov 2023 15:29:56 -0500
Message-ID: <CABWLsesztKnQosM+bkBq-H5yPvFNc02uh5hrEgwRBAz6ja9Q4g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix tracking of stack size for var-off access
To: Hao Sun <sunhao.th@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 12:16=E2=80=AFPM Hao Sun <sunhao.th@gmail.com> wrot=
e:
>
> On Tue, Nov 21, 2023 at 1:46=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> >
> > It *feels* like this stack depth update *and* growing allocated stack
> > slots should happen somewhere in check_stack_access_within_bounds() or
> > right after it. It shouldn't matter whether we read or write to the
> > stack slot: either way that slot becomes part of the verifier state
> > that we should take into account during state comparison. Eduard not
> > so long ago added a change that allows reading STACK_INVALID slots, so
> > it's completely valid to read something that was never written to (and
> > so grow_stack_state() wasn't called for that slot, as it is
> > implemented right now). So I think we should fix that.
> >
>
> Agree. The following cases are currently confusing to me.

Like Hao, I'm also confused about when reads from unitialized stack slots a=
re
supposed to be allowed and when they're not. For example, the "uninitialize=
d
stack1" test ([0]) seems to check that at least some type of uninitialized =
read
is not permitted. The reason why the respective access is rejected and this
test currently passes is the following check in check_stack_range_initializ=
ed:
[1]. We summarily reject the access to slots beyond state->allocated_stack.=
 If
we were to not reject them there, and instead treat the slots as STACK_INVA=
LID,
then the test's access would be allowed just below, through the combination=
 of
env->allow_uninit_stack and `clobber`.

So, assuming that this tests (and a few others) are sane, Andrii's suggesti=
on
of calling grow_stack_state()/update_stack_depth() in
check_stack_access_within_bounds() does not immediately work: doing so
would change
the behavior in check_stack_range_initialized() and allow the access.

On the other hand, perhaps the test is not sane and the access should be
permitted, in the spirit of allowing reads of uninitialized stack? Perhaps =
the
different treatment of slots beyond state->allocated_stack and STACK_INVALI=
D
slots is not intentional. Though, I am fairly confused about the idea of
allowing such reads in general - don't they allow leaking of kernel memory =
from
the uninit stack to user space? Even if restricted to root, is the leak ok?

To also state the obvious - I'm happy to continue working on this patch and=
 fix
a bug I've caused. However, if someone who actually knows the deal wants to
take over, I'm certainly not attached to anything :).

[0] https://github.com/torvalds/linux/blob/98b1cc82c4affc16f5598d4fa14b1858=
671b2263/tools/testing/selftests/bpf/progs/verifier_basic_stack.c#L28-L44
[1] https://github.com/torvalds/linux/blob/98b1cc82c4affc16f5598d4fa14b1858=
671b2263/kernel/bpf/verifier.c#L7280


>
> The verifier accepts the following program, which goes from #4 to #8
> and directly read the stack at runtime without any previous write:
> func#0 @0
> 0: R1=3Dctx() R10=3Dfp0
> 0: (bf) r6 =3D r10                      ; R6_w=3Dfp0 R10=3Dfp0
> 1: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
> 2: (bf) r3 =3D r0                       ; R0_w=3Dscalar(id=3D1) R3_w=3Dsc=
alar(id=3D1)
> 3: (bf) r8 =3D r0                       ; R0_w=3Dscalar(id=3D1) R8_w=3Dsc=
alar(id=3D1)
> 4: (4e) if w0 & w3 goto pc+3          ; R0_w=3Dscalar(id=3D1) R3_w=3Dscal=
ar(id=3D1)
> 5: (63) *(u32 *)(r6 -196) =3D r3        ; R3_w=3Dscalar(id=3D1) R6_w=3Dfp=
0
> fp-200=3Dmmmm????
> 6: (18) r7 =3D 0x19                     ; R7=3D25
> 8: (61) r7 =3D *(u32 *)(r6 -200)        ; R6=3Dfp0
> R7_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xfffffff=
f))
> fp-200=3Dmmmm????
> 9: (95) exit
>
> from 4 to 8: safe
> verification time 358 usec
> stack depth 200
> processed 10 insns (limit 1000000) max_states_per_insn 0 total_states
> 1 peak_states 1 mark_read 1
>
> The state is pruned, because of this:
> static bool stacksafe(...)
>          ....
>          if (env->allow_uninit_stack &&
>              old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D STACK_MIS=
C)
>              continue;
>
> Yet, the sample direct read would be rejected:
>
> func#0 @0
> 0: R1=3Dctx() R10=3Dfp0
> 0: (bf) r6 =3D r10                      ; R6_w=3Dfp0 R10=3Dfp0
> 1: (61) r7 =3D *(u32 *)(r6 -200)
> invalid read from stack R6 off=3D-200 size=3D4
>
> Eduard, you added support for reading uninit slots, should we also add so=
mething
> like the following:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8c2d31aa3d31..aa861d2da240 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6446,7 +6446,7 @@ static int check_stack_slot_within_bounds(int off,
>  {
>         int min_valid_off;
>
> -       if (t =3D=3D BPF_WRITE)
> +       if (t =3D=3D BPF_WRITE || env->allow_uninit_stack)
>                 min_valid_off =3D -MAX_BPF_STACK;
>         else
>                 min_valid_off =3D -state->allocated_stack;

