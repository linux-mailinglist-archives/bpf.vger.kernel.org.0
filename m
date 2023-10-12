Return-Path: <bpf+bounces-11994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14317C6566
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143981C20A4B
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657C0D2FB;
	Thu, 12 Oct 2023 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWD77S6r"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E0465B
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:23:16 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FFBBA;
	Wed, 11 Oct 2023 23:23:14 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7ba0828efso7894707b3.3;
        Wed, 11 Oct 2023 23:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697091794; x=1697696594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IleMAKg+GPM4xdNPivF/aSxe53FBWLj6oWJi1m12Mt4=;
        b=SWD77S6rVHQCriIEd//myP1vy2py+GOk7PbLDOQciq9ygCSRLUMXZdALOufE51XyJo
         ZOYjhMCivnCFxOHf3ou6uv+xZjYUP3OTYcWISCa1PhQOLC4IjtZswt0HRwxFNKu/dxv2
         6K8M2eQ1olXXw7a/GvoDgY2cEGxyftmt9RCsyosUPNJ7ERVhZLmbhkohV3ksXyLrteDq
         M7RaH1NXcpgFpHNv6NUIPTRYgBNHINtmXDNBdbfFQDFCecWil/0zpW5/OezrXaxr1p3J
         AC4OPlZYa9xsv6X0288NtAlkJpDu5q14ysc8VIT9bdMJKsOjJiOT9UXGieV3kY/SmVuW
         UStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091794; x=1697696594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IleMAKg+GPM4xdNPivF/aSxe53FBWLj6oWJi1m12Mt4=;
        b=hk+PuDX9UHrnjMW8DqEoEk3WnDXw+qd8xqsf6mTaBCoeoqyzVx8Ie+J7nwl415mjxS
         qtH73uY/v/PUU+I5nbahxRdlNFxim0TCSMeZyhtNbZp/dD5RIxDxYaitvZYAfuETT9vb
         X6kkC6Y6ZyFEmIrODaxNoGK5y1BtSHuUzNOMGU+Mv1+gvAIJlV88uyJ3yTIKm0kOHnYT
         5s7lyhtAUqSt5YX8qJMUE2rUsSA2SUHY/OvMsiiaNIi4vMKMoxPNvM6ZR0zk4/3YvuSE
         sjw4GZU1S2kUHek3JlCPTWpJ1Z7YZuA8P+gt5oIMSABc8gZrNbUCIQknVl1wKsEwfhQb
         DE2w==
X-Gm-Message-State: AOJu0Ywpu2X9nKM5p2zHeI6pyOHqVgecmBxSutvo0NEJxFkSHy0Yr/Rt
	FTkKy63NvL7kgLTuI8fYNau3oAIz0/NeBG+XAQ==
X-Google-Smtp-Source: AGHT+IFQ353yTk3+nKKDmFe0eALFrWtMyQLeRj2n4iGQUeDFwe81I4FXFCULAILRECxIujY+EIYFG9l/NxXvHPVCpEA=
X-Received: by 2002:a25:800b:0:b0:d9a:39d9:f4fa with SMTP id
 m11-20020a25800b000000b00d9a39d9f4famr8491995ybk.11.1697091793792; Wed, 11
 Oct 2023 23:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009-jmp-into-reserved-fields-v1-1-d8006e2ac1f6@gmail.com>
 <6524f6f77b896_66abc2084d@john.notmuch> <92f824ec-9538-501c-e63e-8483ffe14bad@iogearbox.net>
 <CAEf4Bza2s=JwR8b6d_x+bj5Y7iZ+ZDOMOJRNwcXF1ATWzHCxcA@mail.gmail.com>
 <CACkBjsZiaXTANv=c5QE3OvcB=KUgdFuMY8O4ft4Q3h6dDNVarg@mail.gmail.com> <79dd71a5-446d-9b05-7d37-40e49bbf04ae@iogearbox.net>
In-Reply-To: <79dd71a5-446d-9b05-7d37-40e49bbf04ae@iogearbox.net>
From: Hao Sun <sunhao.th@gmail.com>
Date: Thu, 12 Oct 2023 08:23:02 +0200
Message-ID: <CACkBjsadVpmppbFE8Dp5eym3DK3zFF2ojvvSpTW3b9PsC6CdgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Detect jumping to reserved code during check_cfg()
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 4:50=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 10/11/23 8:46 AM, Hao Sun wrote:
> > On Wed, Oct 11, 2023 at 4:42=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> On Tue, Oct 10, 2023 at 1:33=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >>> On 10/10/23 9:02 AM, John Fastabend wrote:
> >>>> Hao Sun wrote:
> >>>>> Currently, we don't check if the branch-taken of a jump is reserved=
 code of
> >>>>> ld_imm64. Instead, such a issue is captured in check_ld_imm(). The =
verifier
> >>>>> gives the following log in such case:
> >>>>>
> >>>>> func#0 @0
> >>>>> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> >>>>> 0: (18) r4 =3D 0xffff888103436000       ; R4_w=3Dmap_ptr(off=3D0,ks=
=3D4,vs=3D128,imm=3D0)
> >>>>> 2: (18) r1 =3D 0x1d                     ; R1_w=3D29
> >>>>> 4: (55) if r4 !=3D 0x0 goto pc+4        ; R4_w=3Dmap_ptr(off=3D0,ks=
=3D4,vs=3D128,imm=3D0)
> >>>>> 5: (1c) w1 -=3D w1                      ; R1_w=3D0
> >>>>> 6: (18) r5 =3D 0x32                     ; R5_w=3D50
> >>>>> 8: (56) if w5 !=3D 0xfffffff4 goto pc-2
> >>>>> mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
> >>>>> mark_precise: frame0: regs=3Dr5 stack=3D before 6: (18) r5 =3D 0x32
> >>>>> 7: R5_w=3D50
> >>>>> 7: BUG_ld_00
> >>>>> invalid BPF_LD_IMM insn
> >>>>>
> >>>>> Here the verifier rejects the program because it thinks insn at 7 i=
s an
> >>>>> invalid BPF_LD_IMM, but such a error log is not accurate since the =
issue
> >>>>> is jumping to reserved code not because the program contains invali=
d insn.
> >>>>> Therefore, make the verifier check the jump target during check_cfg=
(). For
> >>>>> the same program, the verifier reports the following log:
> >>>>
> >>>> I think we at least would want a test case for this. Also how did yo=
u create
> >>>> this case? Is it just something you did manually and noticed a stran=
ge error?
> >>>
> >>> Curious as well.
> >>>
> >>> We do have test cases which try to jump into the middle of a double i=
nsn as can
> >>> be seen that this patch breaks BPF CI with regards to log mismatch be=
low (which
> >>> still needs to be adapted, too). Either way, it probably doesn't hurt=
 to also add
> >>> the above snippet as a test.
> >>>
> >>> Hao, as I understand, the patch here is an usability improvement (not=
 a fix per se)
> >>> where we reject such cases earlier during cfg check rather than at a =
later point
> >>> where we validate ld_imm instruction. Or are there cases you found wh=
ich were not
> >>> yet captured via current check_ld_imm()?
> >>>
> >>> test_verifier failure log :
> >>>
> >>>     #458/u test1 ld_imm64 FAIL
> >>>     Unexpected verifier log!
> >>>     EXP: R1 pointer comparison
> >>>     RES:
> >>>     FAIL
> >>>     Unexpected error message!
> >>>          EXP: R1 pointer comparison
> >>>          RES: jump to reserved code from insn 0 to 2
> >>>     verification time 22 usec
> >>>     stack depth 0
> >>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_sta=
tes 0 peak_states 0 mark_read 0
> >>>
> >>>     jump to reserved code from insn 0 to 2
> >>>     verification time 22 usec
> >>>     stack depth 0
> >>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_sta=
tes 0 peak_states 0 mark_read 0
> >>>     #458/p test1 ld_imm64 FAIL
> >>>     Unexpected verifier log!
> >>>     EXP: invalid BPF_LD_IMM insn
> >>>     RES:
> >>>     FAIL
> >>>     Unexpected error message!
> >>>          EXP: invalid BPF_LD_IMM insn
> >>>          RES: jump to reserved code from insn 0 to 2
> >>>     verification time 9 usec
> >>>     stack depth 0
> >>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_sta=
tes 0 peak_states 0 mark_read 0
> >>>
> >>>     jump to reserved code from insn 0 to 2
> >>>     verification time 9 usec
> >>>     stack depth 0
> >>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_sta=
tes 0 peak_states 0 mark_read 0
> >>>     #459/u test2 ld_imm64 FAIL
> >>>     Unexpected verifier log!
> >>>     EXP: R1 pointer comparison
> >>>     RES:
> >>>     FAIL
> >>>     Unexpected error message!
> >>>          EXP: R1 pointer comparison
> >>>          RES: jump to reserved code from insn 0 to 2
> >>>     verification time 11 usec
> >>>     stack depth 0
> >>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_sta=
tes 0 peak_states 0 mark_read 0
> >>>
> >>>     jump to reserved code from insn 0 to 2
> >>>     verification time 11 usec
> >>>     stack depth 0
> >>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_sta=
tes 0 peak_states 0 mark_read 0
> >>>     #459/p test2 ld_imm64 FAIL
> >>>     Unexpected verifier log!
> >>>     EXP: invalid BPF_LD_IMM insn
> >>>     RES:
> >>>     FAIL
> >>>     Unexpected error message!
> >>>          EXP: invalid BPF_LD_IMM insn
> >>>          RES: jump to reserved code from insn 0 to 2
> >>>     verification time 8 usec
> >>>     stack depth 0
> >>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_sta=
tes 0 peak_states 0 mark_read 0
> >>>
> >>>     jump to reserved code from insn 0 to 2
> >>>     verification time 8 usec
> >>>     stack depth 0
> >>>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_sta=
tes 0 peak_states 0 mark_read 0
> >>>     #460/u test3 ld_imm64 OK
> >>>
> >>>>> func#0 @0
> >>>>> jump to reserved code from insn 8 to 7
> >>>>>
> >>>>> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> >>>
> >>> nit: This needs to be before the "---" line.
> >>>
> >>>>> ---
> >>>>>    kernel/bpf/verifier.c | 7 +++++++
> >>>>>    1 file changed, 7 insertions(+)
> >>>>>
> >>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>>>> index eed7350e15f4..725ac0b464cf 100644
> >>>>> --- a/kernel/bpf/verifier.c
> >>>>> +++ b/kernel/bpf/verifier.c
> >>>>> @@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e, s=
truct bpf_verifier_env *env,
> >>>>>    {
> >>>>>       int *insn_stack =3D env->cfg.insn_stack;
> >>>>>       int *insn_state =3D env->cfg.insn_state;
> >>>>> +    struct bpf_insn *insns =3D env->prog->insnsi;
> >>>>>
> >>>>>       if (e =3D=3D FALLTHROUGH && insn_state[t] >=3D (DISCOVERED | =
FALLTHROUGH))
> >>>>>               return DONE_EXPLORING;
> >>>>> @@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e, =
struct bpf_verifier_env *env,
> >>>>>               return -EINVAL;
> >>>>>       }
> >>>>>
> >>>>> +    if (e =3D=3D BRANCH && insns[w].code =3D=3D 0) {
> >>>>> +            verbose_linfo(env, t, "%d", t);
> >>>>> +            verbose(env, "jump to reserved code from insn %d to %d=
\n", t, w);
> >>>>> +            return -EINVAL;
> >>>>> +    }
> >>>
> >>> Other than that, lgtm.
> >>
> >> We do rely quite a lot on verifier not complaining eagerly about some
> >> potentially invalid instructions if it's provable that some portion of
> >> the code won't ever be reached (think using .rodata variables for
> >> feature gating, poisoning intructions due to failed CO-RE relocation,
> >> which libbpf does actively, except it's using a call to non-existing
> >> helper). As such, check_cfg() is a wrong place to do such validity
> >> checks because some of the branches might never be run and validated
> >> in practice.
> >
> > Don't really agree. Jump to the middle of ld_imm64 is just like jumping
> > out of bounds, both break the CFG integrity immediately. For those
> > apparently incorrect  jumps, rejecting early makes everything simple;
> > otherwise, we probably need some rewrite in the end.
>
> Could you elaborate on the 'breaking CFG integrity immediately'? This was
> what I was trying to gather earlier with log improvement vs actual fix.
>
> Do you mean /potentially/ breaking CFG integrity, if, say, we had a doubl=
e
> insn jump in future and there is a back-jump to the 2nd part of the insn?
>

I mean jumping to the middle of ld_imm64 is similar to jumping out-of-bound=
,
both are CFG-related issues and can be handled early in one place.

For the case you mentioned, the current code would handle such an issue in
check_ld_imm64(), and again gives "BAD_LD_IMM" log, which is strange.

> > Also, as you mentioned, libbpf relies on non-existing helpers, not jump
> > to the middle of ld_imm64. It seems better and easier to not leave this
> > hole.
>
> Thanks,
> Daniel

