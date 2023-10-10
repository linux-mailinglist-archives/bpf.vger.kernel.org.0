Return-Path: <bpf+bounces-11803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A107BF706
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 11:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983AE1C20C80
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 09:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E57171B3;
	Tue, 10 Oct 2023 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDfDsGqt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63A15AEF
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 09:17:51 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F3213D;
	Tue, 10 Oct 2023 02:17:46 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59f6e6b206fso67717217b3.3;
        Tue, 10 Oct 2023 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696929465; x=1697534265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AitLqx6uEsS6SCZM85J15+rmNCaW57KFo5UYsOINuEM=;
        b=lDfDsGqt0K42cF0INpkMDJaCMYoA3jdDOapeTZ+BCmwFbm3JZ7rSUy9G6GHqRMTMsl
         RhtxzReGvG7tI81ybAeyVaLtnWsZV+86E2y4zP25RboDPG8lasYRRc0WDYFYO/cWqPfu
         KUigxnwSNQP0KCbXChCV+FrWE4KYT5IrZTwglJYVZT9IylEOOCH5EqQ1f8RG9dqT82BS
         WE5jYZjgMAUQedQEbd5aUrdnp0xBa3rdqrw+y9pEgvFRoZdTRFb34jJfrB7NcPxsALMY
         Er6yGWO/WwIAmkb4HeHCj5j0YAe0FjYmsk4bQmlBd/Cwx+flQjXmesvwfCdo+EjWmLut
         7aEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696929465; x=1697534265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AitLqx6uEsS6SCZM85J15+rmNCaW57KFo5UYsOINuEM=;
        b=FuacNAfWK0I20e1er/8V1fB2A1WSeVuQsrMAmqNIvLY0N3szlfXkxS/yswEzfmY3A1
         lBb7D+9WZdyHp2frvTxLmrxyDhjYYFtRdTuk5PQJHZ2+avxAZOKFvz4ohFAaMqYYvkXm
         7l2tEOdSXZLxwmY3yzaAMZYfDligE7YzxkoLO865bpEh7261g2XGfIFi+XfxTJhAFH9s
         tv6gV8gY3gm2049oWC6hd48TlzNNEbsTMB5/RxKiL0SmHaxAiAnpurFN+LVXZShXje7y
         u6k3LvG0kLnBF23GLjjTW50KdN87sPyGKg9B9a8ge1A7ih2aJp9MoUslzZ4QKXbtPwFo
         H+bA==
X-Gm-Message-State: AOJu0YyREARpYjtfOuiJVjtSbLOVg1xRhMfO73QIzguSfdRrYJSS/OPt
	rLHJAnjpRTSCJyv3hh3gZ6NKluKd9S+kPI+zXinww1Dxxg==
X-Google-Smtp-Source: AGHT+IGThSA32vMNWFCh69eI2t1Osj3Kr2Vd2YtH2gpzEjDyfaHS8V2MZAACgBbgbBGqePuqAtNHx0flxtEfLlIrrwE=
X-Received: by 2002:a25:cf10:0:b0:d9a:4870:7943 with SMTP id
 f16-20020a25cf10000000b00d9a48707943mr2532397ybg.28.1696929464856; Tue, 10
 Oct 2023 02:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009-jmp-into-reserved-fields-v1-1-d8006e2ac1f6@gmail.com>
 <6524f6f77b896_66abc2084d@john.notmuch> <92f824ec-9538-501c-e63e-8483ffe14bad@iogearbox.net>
In-Reply-To: <92f824ec-9538-501c-e63e-8483ffe14bad@iogearbox.net>
From: Hao Sun <sunhao.th@gmail.com>
Date: Tue, 10 Oct 2023 11:17:33 +0200
Message-ID: <CACkBjsbM8=NLwwEUea21vqCrn-w9cn21gL3BNpU4AupYnuCvJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Detect jumping to reserved code during check_cfg()
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 10:33=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
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

I just wrote a testing tool for the verifier, which uses a test oracle
to capture
incorrect verifier's states, capturing incorrect verifier logs is a
bonus from this.
The bug is captured during testing the testing tool :). I will publish
the work when
I think it's useful enough and ready.

>
> We do have test cases which try to jump into the middle of a double insn =
as can
> be seen that this patch breaks BPF CI with regards to log mismatch below =
(which
> still needs to be adapted, too). Either way, it probably doesn't hurt to =
also add
> the above snippet as a test.
>

Will add a test case for this, and try to fix these broken tests, in patch =
v2.

> Hao, as I understand, the patch here is an usability improvement (not a f=
ix per se)
> where we reject such cases earlier during cfg check rather than at a late=
r point
> where we validate ld_imm instruction. Or are there cases you found which =
were not
> yet captured via current check_ld_imm()?
>

I regard this as a fix, because the verifier log is not correct, since
the program does
not contain any invalid ld_imm64 instructions in this case.

I haven't met other cases not captured via check_ld_imm(), but somehow, I t=
hink
we probably want to convert the check there as an internal bug,
because we already
have bpf_opcode_in_insntable() check in resolve_pseudo_ldimm64(). Once we m=
eet
invalid insn code here, then somewhere else in the verifier is
probably wrong. But
I'm not sure, maybe something like this:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eed7350e15f4..bed97de568a5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14532,8 +14532,8 @@ static int check_ld_imm(struct
bpf_verifier_env *env, struct bpf_insn *insn)
        int err;

        if (BPF_SIZE(insn->code) !=3D BPF_DW) {
-               verbose(env, "invalid BPF_LD_IMM insn\n");
-               return -EINVAL;
+               verbose(env, "verifier internal bug, invalid BPF_LD_IMM\n")=
;
+               return -EFAULT;
        }
        if (insn->off !=3D 0) {
                verbose(env, "BPF_LD_IMM64 uses reserved fields\n");

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

Noted.

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
>
> >>      if (e =3D=3D BRANCH) {
> >>              /* mark branch target for state pruning */
> >>              mark_prune_point(env, w);
> >>

