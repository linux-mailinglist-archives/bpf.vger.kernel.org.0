Return-Path: <bpf+bounces-11866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3437C4AED
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 08:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26441C20E60
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 06:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142661426A;
	Wed, 11 Oct 2023 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub0qmiYD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF65D2E2
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 06:46:51 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A67D9E;
	Tue, 10 Oct 2023 23:46:49 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a505762c9dso79429017b3.2;
        Tue, 10 Oct 2023 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697006808; x=1697611608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYYIViihW/2ykLsxlNp0GKeIrzDIn8ZJ1ct4n1urTnA=;
        b=Ub0qmiYDUARgQVAoNnZCnCu8/mWR3fkmcJYiOwjX+AceA5geHUHL+XlopnYykbbXb3
         aIK7+WQHa/7OF4VXaupoo2KIcYg+cwP3fm1DxMMJf+UTgBXl5O9CSJGbCtDU8+W40beA
         bpEbC0ykJweFzVOBxb2qlaBR4tjexkaCT517rS+xwqPvvo9wKBXGarHb/0uM/M4ttZT1
         pIesjoXeg/BrjofpnZ0nkoFJQz8FRVIjeq18b4RE+kKvRwNHwi415owgODixmTMmpx1L
         YY3alBKYJvX1jThLV5Cs2WsVwnUtDv9exa1D9+lRDfp6S3qy9NfXr1YPZ3vgG7Or3Z3w
         FaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697006808; x=1697611608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYYIViihW/2ykLsxlNp0GKeIrzDIn8ZJ1ct4n1urTnA=;
        b=fSbA5R1lk04LSsm7ZfAY/ofVNOm8KRAwA1AX2GkTMX9bbo7dCCoFYT3sM98HCK9b5k
         OAlP6uV9W6OOWf7+2tXdGaD+j2cuXk+5ProHgu7WppzW4htfam4O90YMjrMiPnrFEldD
         6iGfkf9wehk+wpShcJiIP5Oc+OYHAe9PeTsCxwO3W6AZDyVyXGmNE9Gkne0X4i4HG1l+
         5bxnxGg+9cSU4DK4oyGW1HelkDM4b+vWbPltRJLWo7UnQ2U5THnJ8lzUd8ZVQPRpBJrI
         rMwudiZAsqxw1rJu+zewHY/ErdlkS2NzQrLRxodDMTqBEdZ2O1HZzaSmVDuO/q5sUqWa
         fi6g==
X-Gm-Message-State: AOJu0YwjpvIjGiKKDIJKdrFT7OoPCZnibo0tmyomEoaF6X4tznJt1H9B
	EV1TO4zNjDomOjttoXCzVVEMuw+uTPe42HsThQ==
X-Google-Smtp-Source: AGHT+IG0vJcv9pLsEBAIEkbVnSB//f5y9GEAq0U5gJVJaHfP6BqSwqk3daZzaJuRSC61WK35TjS0IIiXIO8vVqmPg80=
X-Received: by 2002:a25:ae85:0:b0:d9a:4362:67ac with SMTP id
 b5-20020a25ae85000000b00d9a436267acmr5278982ybj.15.1697006808431; Tue, 10 Oct
 2023 23:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009-jmp-into-reserved-fields-v1-1-d8006e2ac1f6@gmail.com>
 <6524f6f77b896_66abc2084d@john.notmuch> <92f824ec-9538-501c-e63e-8483ffe14bad@iogearbox.net>
 <CAEf4Bza2s=JwR8b6d_x+bj5Y7iZ+ZDOMOJRNwcXF1ATWzHCxcA@mail.gmail.com>
In-Reply-To: <CAEf4Bza2s=JwR8b6d_x+bj5Y7iZ+ZDOMOJRNwcXF1ATWzHCxcA@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Wed, 11 Oct 2023 08:46:37 +0200
Message-ID: <CACkBjsZiaXTANv=c5QE3OvcB=KUgdFuMY8O4ft4Q3h6dDNVarg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Detect jumping to reserved code during check_cfg()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
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

On Wed, Oct 11, 2023 at 4:42=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 10, 2023 at 1:33=E2=80=AFAM Daniel Borkmann <daniel@iogearbox=
.net> wrote:
> >
> > On 10/10/23 9:02 AM, John Fastabend wrote:
> > > Hao Sun wrote:
> > >> Currently, we don't check if the branch-taken of a jump is reserved =
code of
> > >> ld_imm64. Instead, such a issue is captured in check_ld_imm(). The v=
erifier
> > >> gives the following log in such case:
> > >>
> > >> func#0 @0
> > >> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > >> 0: (18) r4 =3D 0xffff888103436000       ; R4_w=3Dmap_ptr(off=3D0,ks=
=3D4,vs=3D128,imm=3D0)
> > >> 2: (18) r1 =3D 0x1d                     ; R1_w=3D29
> > >> 4: (55) if r4 !=3D 0x0 goto pc+4        ; R4_w=3Dmap_ptr(off=3D0,ks=
=3D4,vs=3D128,imm=3D0)
> > >> 5: (1c) w1 -=3D w1                      ; R1_w=3D0
> > >> 6: (18) r5 =3D 0x32                     ; R5_w=3D50
> > >> 8: (56) if w5 !=3D 0xfffffff4 goto pc-2
> > >> mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
> > >> mark_precise: frame0: regs=3Dr5 stack=3D before 6: (18) r5 =3D 0x32
> > >> 7: R5_w=3D50
> > >> 7: BUG_ld_00
> > >> invalid BPF_LD_IMM insn
> > >>
> > >> Here the verifier rejects the program because it thinks insn at 7 is=
 an
> > >> invalid BPF_LD_IMM, but such a error log is not accurate since the i=
ssue
> > >> is jumping to reserved code not because the program contains invalid=
 insn.
> > >> Therefore, make the verifier check the jump target during check_cfg(=
). For
> > >> the same program, the verifier reports the following log:
> > >
> > > I think we at least would want a test case for this. Also how did you=
 create
> > > this case? Is it just something you did manually and noticed a strang=
e error?
> >
> > Curious as well.
> >
> > We do have test cases which try to jump into the middle of a double ins=
n as can
> > be seen that this patch breaks BPF CI with regards to log mismatch belo=
w (which
> > still needs to be adapted, too). Either way, it probably doesn't hurt t=
o also add
> > the above snippet as a test.
> >
> > Hao, as I understand, the patch here is an usability improvement (not a=
 fix per se)
> > where we reject such cases earlier during cfg check rather than at a la=
ter point
> > where we validate ld_imm instruction. Or are there cases you found whic=
h were not
> > yet captured via current check_ld_imm()?
> >
> > test_verifier failure log :
> >
> >    #458/u test1 ld_imm64 FAIL
> >    Unexpected verifier log!
> >    EXP: R1 pointer comparison
> >    RES:
> >    FAIL
> >    Unexpected error message!
> >         EXP: R1 pointer comparison
> >         RES: jump to reserved code from insn 0 to 2
> >    verification time 22 usec
> >    stack depth 0
> >    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states=
 0 peak_states 0 mark_read 0
> >
> >    jump to reserved code from insn 0 to 2
> >    verification time 22 usec
> >    stack depth 0
> >    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states=
 0 peak_states 0 mark_read 0
> >    #458/p test1 ld_imm64 FAIL
> >    Unexpected verifier log!
> >    EXP: invalid BPF_LD_IMM insn
> >    RES:
> >    FAIL
> >    Unexpected error message!
> >         EXP: invalid BPF_LD_IMM insn
> >         RES: jump to reserved code from insn 0 to 2
> >    verification time 9 usec
> >    stack depth 0
> >    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states=
 0 peak_states 0 mark_read 0
> >
> >    jump to reserved code from insn 0 to 2
> >    verification time 9 usec
> >    stack depth 0
> >    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states=
 0 peak_states 0 mark_read 0
> >    #459/u test2 ld_imm64 FAIL
> >    Unexpected verifier log!
> >    EXP: R1 pointer comparison
> >    RES:
> >    FAIL
> >    Unexpected error message!
> >         EXP: R1 pointer comparison
> >         RES: jump to reserved code from insn 0 to 2
> >    verification time 11 usec
> >    stack depth 0
> >    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states=
 0 peak_states 0 mark_read 0
> >
> >    jump to reserved code from insn 0 to 2
> >    verification time 11 usec
> >    stack depth 0
> >    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states=
 0 peak_states 0 mark_read 0
> >    #459/p test2 ld_imm64 FAIL
> >    Unexpected verifier log!
> >    EXP: invalid BPF_LD_IMM insn
> >    RES:
> >    FAIL
> >    Unexpected error message!
> >         EXP: invalid BPF_LD_IMM insn
> >         RES: jump to reserved code from insn 0 to 2
> >    verification time 8 usec
> >    stack depth 0
> >    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states=
 0 peak_states 0 mark_read 0
> >
> >    jump to reserved code from insn 0 to 2
> >    verification time 8 usec
> >    stack depth 0
> >    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states=
 0 peak_states 0 mark_read 0
> >    #460/u test3 ld_imm64 OK
> >
> > >> func#0 @0
> > >> jump to reserved code from insn 8 to 7
> > >>
> > >> ---
> > >>
> > >>
> > >> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> >
> > nit: This needs to be before the "---" line.
> >
> > >> ---
> > >>   kernel/bpf/verifier.c | 7 +++++++
> > >>   1 file changed, 7 insertions(+)
> > >>
> > >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > >> index eed7350e15f4..725ac0b464cf 100644
> > >> --- a/kernel/bpf/verifier.c
> > >> +++ b/kernel/bpf/verifier.c
> > >> @@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e, st=
ruct bpf_verifier_env *env,
> > >>   {
> > >>      int *insn_stack =3D env->cfg.insn_stack;
> > >>      int *insn_state =3D env->cfg.insn_state;
> > >> +    struct bpf_insn *insns =3D env->prog->insnsi;
> > >>
> > >>      if (e =3D=3D FALLTHROUGH && insn_state[t] >=3D (DISCOVERED | FA=
LLTHROUGH))
> > >>              return DONE_EXPLORING;
> > >> @@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e, s=
truct bpf_verifier_env *env,
> > >>              return -EINVAL;
> > >>      }
> > >>
> > >> +    if (e =3D=3D BRANCH && insns[w].code =3D=3D 0) {
> > >> +            verbose_linfo(env, t, "%d", t);
> > >> +            verbose(env, "jump to reserved code from insn %d to %d\=
n", t, w);
> > >> +            return -EINVAL;
> > >> +    }
> >
> > Other than that, lgtm.
>
> We do rely quite a lot on verifier not complaining eagerly about some
> potentially invalid instructions if it's provable that some portion of
> the code won't ever be reached (think using .rodata variables for
> feature gating, poisoning intructions due to failed CO-RE relocation,
> which libbpf does actively, except it's using a call to non-existing
> helper). As such, check_cfg() is a wrong place to do such validity
> checks because some of the branches might never be run and validated
> in practice.
>

Don't really agree. Jump to the middle of ld_imm64 is just like jumping
out of bounds, both break the CFG integrity immediately. For those
apparently incorrect  jumps, rejecting early makes everything simple;
otherwise, we probably need some rewrite in the end.

Also, as you mentioned, libbpf relies on non-existing helpers, not jump
to the middle of ld_imm64. It seems better and easier to not leave this
hole.

> This seems like a pretty obscure case of fuzzer generated test with
> random jumps into the middle of ldimm64 instruction. I think the tool
> should be able to avoid this or handle verifier log just fine in such
> situations. On the other hand, valid code generated by compilers will
> never have such jumps.
>
> So perhaps we can improve existing "invalid BPF_LD_IMM insn" message,
> but let's not teach check_cfg() more checks than necessary?
>

Improving that `invalid BPF_LD_IMM` log does not solve the problem, the
issue here is an invalid jump. Also, there could be various causes that mak=
e
the verifier see an invalid BPF_LD_IMM in check_ld_imm().

> >
> > >>      if (e =3D=3D BRANCH) {
> > >>              /* mark branch target for state pruning */
> > >>              mark_prune_point(env, w);
> > >>
> >

