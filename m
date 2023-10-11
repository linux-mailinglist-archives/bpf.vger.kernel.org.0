Return-Path: <bpf+bounces-11854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412007C47E8
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 04:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626701C20E2B
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 02:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0700A4688;
	Wed, 11 Oct 2023 02:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCwdqKcy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067F46108
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 02:42:50 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEF49D;
	Tue, 10 Oct 2023 19:42:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso2096154a12.1;
        Tue, 10 Oct 2023 19:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696992167; x=1697596967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=id44sh06sB+VzUBOjFeGvj0/2qgnTKDwavEKyMyAfT8=;
        b=BCwdqKcyDt0sXI1J+5NqANmhZer7jYfnxy2jW2bL/5T75TUoRuBpZKwc3YwnNF6ryV
         vFqyWSuCodt04lgNeezExMwt0BnxiZ9M/MIK1lDVyAMykBZOyFm5EJK+6PTrp9pcx937
         7SNNvCJMU1Ud7jmlUXkfHlEl/1zashQ459GulCIoZOrnt3p56uBSwFGUGUWkHoc0Rc4S
         KHcufuk6H7oTrg+nvdW6IleD5g7hAjEVQPO93mwArRp9BUEHcI76j8rq+RAVi6Rei3PQ
         sBEEyh4O0S+OTDTfSkqRpbQ+2Y9hECkL2yVt1o0kJwvTSf8apU+2F4w/08U14yqMN+/a
         6SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696992167; x=1697596967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=id44sh06sB+VzUBOjFeGvj0/2qgnTKDwavEKyMyAfT8=;
        b=hIh86MIJ3nf6CEiI5zW6Kg4RIF/+PSrD+d6iLL/9+dQgyEx4hCQpCVNhZKtQpoYkpw
         4SBRZhfEW06mfHBb7JxfJYqT2Dk8lYEO/P7H1qisktAY0ZnVjgCD0UoNQPIA5ZNN5hvg
         AzmQ2x9JD2ydCUpp2XUkxqhUB4/nc0J3HHWK0nVwF+PlX9pV/5Fee6iJHhYHOM7Iwd4f
         Scd6z2zH1M3g442UhgrBbjhKLtv3507t35AZ8f3W2RgPpeyq1lF4Mi+ei5LhGTuPQgza
         H9/hZAA7KvVVmWVq3AxCZ5BJJ5PTyEM7BHO37RamgP96yS1LnY/XNwvrLZygRwXUQAcm
         lzMw==
X-Gm-Message-State: AOJu0YwHDGCiP6ji+yPIlHCEjtcBYltOIWhdm4vm6IjrBScT3lsDByIs
	i3iaRNu7AGRLp71lszLjkMTz2LyNjP9k8HgtnT0=
X-Google-Smtp-Source: AGHT+IFXL2f2HcXw1v9fo8Al4YHu9PNbmoZ0LGms3MQSxml82cjRQOQmLoBzCI5tQZLJESozCprpyInq79kn/zKKi9A=
X-Received: by 2002:aa7:c904:0:b0:525:7f37:e87a with SMTP id
 b4-20020aa7c904000000b005257f37e87amr18005344edt.16.1696992166517; Tue, 10
 Oct 2023 19:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009-jmp-into-reserved-fields-v1-1-d8006e2ac1f6@gmail.com>
 <6524f6f77b896_66abc2084d@john.notmuch> <92f824ec-9538-501c-e63e-8483ffe14bad@iogearbox.net>
In-Reply-To: <92f824ec-9538-501c-e63e-8483ffe14bad@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Oct 2023 19:42:35 -0700
Message-ID: <CAEf4Bza2s=JwR8b6d_x+bj5Y7iZ+ZDOMOJRNwcXF1ATWzHCxcA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Detect jumping to reserved code during check_cfg()
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>, Hao Sun <sunhao.th@gmail.com>, 
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

On Tue, Oct 10, 2023 at 1:33=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 10/10/23 9:02 AM, John Fastabend wrote:
> > Hao Sun wrote:
> >> Currently, we don't check if the branch-taken of a jump is reserved co=
de of
> >> ld_imm64. Instead, such a issue is captured in check_ld_imm(). The ver=
ifier
> >> gives the following log in such case:
> >>
> >> func#0 @0
> >> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> >> 0: (18) r4 =3D 0xffff888103436000       ; R4_w=3Dmap_ptr(off=3D0,ks=3D=
4,vs=3D128,imm=3D0)
> >> 2: (18) r1 =3D 0x1d                     ; R1_w=3D29
> >> 4: (55) if r4 !=3D 0x0 goto pc+4        ; R4_w=3Dmap_ptr(off=3D0,ks=3D=
4,vs=3D128,imm=3D0)
> >> 5: (1c) w1 -=3D w1                      ; R1_w=3D0
> >> 6: (18) r5 =3D 0x32                     ; R5_w=3D50
> >> 8: (56) if w5 !=3D 0xfffffff4 goto pc-2
> >> mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
> >> mark_precise: frame0: regs=3Dr5 stack=3D before 6: (18) r5 =3D 0x32
> >> 7: R5_w=3D50
> >> 7: BUG_ld_00
> >> invalid BPF_LD_IMM insn
> >>
> >> Here the verifier rejects the program because it thinks insn at 7 is a=
n
> >> invalid BPF_LD_IMM, but such a error log is not accurate since the iss=
ue
> >> is jumping to reserved code not because the program contains invalid i=
nsn.
> >> Therefore, make the verifier check the jump target during check_cfg().=
 For
> >> the same program, the verifier reports the following log:
> >
> > I think we at least would want a test case for this. Also how did you c=
reate
> > this case? Is it just something you did manually and noticed a strange =
error?
>
> Curious as well.
>
> We do have test cases which try to jump into the middle of a double insn =
as can
> be seen that this patch breaks BPF CI with regards to log mismatch below =
(which
> still needs to be adapted, too). Either way, it probably doesn't hurt to =
also add
> the above snippet as a test.
>
> Hao, as I understand, the patch here is an usability improvement (not a f=
ix per se)
> where we reject such cases earlier during cfg check rather than at a late=
r point
> where we validate ld_imm instruction. Or are there cases you found which =
were not
> yet captured via current check_ld_imm()?
>
> test_verifier failure log :
>
>    #458/u test1 ld_imm64 FAIL
>    Unexpected verifier log!
>    EXP: R1 pointer comparison
>    RES:
>    FAIL
>    Unexpected error message!
>         EXP: R1 pointer comparison
>         RES: jump to reserved code from insn 0 to 2
>    verification time 22 usec
>    stack depth 0
>    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0=
 peak_states 0 mark_read 0
>
>    jump to reserved code from insn 0 to 2
>    verification time 22 usec
>    stack depth 0
>    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0=
 peak_states 0 mark_read 0
>    #458/p test1 ld_imm64 FAIL
>    Unexpected verifier log!
>    EXP: invalid BPF_LD_IMM insn
>    RES:
>    FAIL
>    Unexpected error message!
>         EXP: invalid BPF_LD_IMM insn
>         RES: jump to reserved code from insn 0 to 2
>    verification time 9 usec
>    stack depth 0
>    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0=
 peak_states 0 mark_read 0
>
>    jump to reserved code from insn 0 to 2
>    verification time 9 usec
>    stack depth 0
>    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0=
 peak_states 0 mark_read 0
>    #459/u test2 ld_imm64 FAIL
>    Unexpected verifier log!
>    EXP: R1 pointer comparison
>    RES:
>    FAIL
>    Unexpected error message!
>         EXP: R1 pointer comparison
>         RES: jump to reserved code from insn 0 to 2
>    verification time 11 usec
>    stack depth 0
>    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0=
 peak_states 0 mark_read 0
>
>    jump to reserved code from insn 0 to 2
>    verification time 11 usec
>    stack depth 0
>    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0=
 peak_states 0 mark_read 0
>    #459/p test2 ld_imm64 FAIL
>    Unexpected verifier log!
>    EXP: invalid BPF_LD_IMM insn
>    RES:
>    FAIL
>    Unexpected error message!
>         EXP: invalid BPF_LD_IMM insn
>         RES: jump to reserved code from insn 0 to 2
>    verification time 8 usec
>    stack depth 0
>    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0=
 peak_states 0 mark_read 0
>
>    jump to reserved code from insn 0 to 2
>    verification time 8 usec
>    stack depth 0
>    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0=
 peak_states 0 mark_read 0
>    #460/u test3 ld_imm64 OK
>
> >> func#0 @0
> >> jump to reserved code from insn 8 to 7
> >>
> >> ---
> >>
> >>
> >> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
>
> nit: This needs to be before the "---" line.
>
> >> ---
> >>   kernel/bpf/verifier.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index eed7350e15f4..725ac0b464cf 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e, stru=
ct bpf_verifier_env *env,
> >>   {
> >>      int *insn_stack =3D env->cfg.insn_stack;
> >>      int *insn_state =3D env->cfg.insn_state;
> >> +    struct bpf_insn *insns =3D env->prog->insnsi;
> >>
> >>      if (e =3D=3D FALLTHROUGH && insn_state[t] >=3D (DISCOVERED | FALL=
THROUGH))
> >>              return DONE_EXPLORING;
> >> @@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e, str=
uct bpf_verifier_env *env,
> >>              return -EINVAL;
> >>      }
> >>
> >> +    if (e =3D=3D BRANCH && insns[w].code =3D=3D 0) {
> >> +            verbose_linfo(env, t, "%d", t);
> >> +            verbose(env, "jump to reserved code from insn %d to %d\n"=
, t, w);
> >> +            return -EINVAL;
> >> +    }
>
> Other than that, lgtm.

We do rely quite a lot on verifier not complaining eagerly about some
potentially invalid instructions if it's provable that some portion of
the code won't ever be reached (think using .rodata variables for
feature gating, poisoning intructions due to failed CO-RE relocation,
which libbpf does actively, except it's using a call to non-existing
helper). As such, check_cfg() is a wrong place to do such validity
checks because some of the branches might never be run and validated
in practice.

This seems like a pretty obscure case of fuzzer generated test with
random jumps into the middle of ldimm64 instruction. I think the tool
should be able to avoid this or handle verifier log just fine in such
situations. On the other hand, valid code generated by compilers will
never have such jumps.

So perhaps we can improve existing "invalid BPF_LD_IMM insn" message,
but let's not teach check_cfg() more checks than necessary?

>
> >>      if (e =3D=3D BRANCH) {
> >>              /* mark branch target for state pruning */
> >>              mark_prune_point(env, w);
> >>
>

