Return-Path: <bpf+bounces-34359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB77A92CA54
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 08:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD711C221F4
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 06:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A974597B;
	Wed, 10 Jul 2024 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrkPFRxd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119291B86FC
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 06:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591332; cv=none; b=kIOkRV4Th46szJgkAvf0cJXPdDGA2d2pr9dTWDRLM453o5MEzR1toM3GeHKK/0HfYRDLAyKewaG2ivAEKoegKro2NUXHi0bLFUCnFxi8wvhDkRBHGuFh/mIh7K2nXS6HK+61lkXcfXBIwTyCTUsskXQRWvdCzonrUI2VGv/hTsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591332; c=relaxed/simple;
	bh=A4LAyPp3vvonMNJ3l+GmqNiuPSwcEVUzU/qxpyEEHcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTXEXeWefQIPBvqq0j1h3BmrEG28A6W3sxCdswr+fsy1b6GMdnYzpBXjGlE3A5BhdM8Tx9nhZNw3VUoT6Dgn+A1cJ4VBsAGBTr9Krg1/7+JxMD6GN9/cDPqjhkfQ3HcqA7ewZ47ttKI1ooReWvtBfibzQNHsaD9qox733XSGxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrkPFRxd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70b0ebd1ef9so3125091b3a.2
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 23:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720591330; x=1721196130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90v1wl7Gb7ZugS1FnwJFha2mOK3M1mARo2kqgu20tac=;
        b=mrkPFRxdLafCTt9rinhq4O08rhdq070St7nemGAn1+KdKdNaLmAub6yMK8RPahmfGo
         7Ozn252SDli+RXqivU0utAfiGx/78gLsTX5z2XFYzmCxgtzsE4k03PuU2e2BYsETrnbi
         86UbqTixHeCAbNIZBU8xQInIvX2j1ziOlDK8MFZEoc6hbCA0nIOzylId3SoX4FfJj0gl
         tyWfkzHt5isCzrSxjXC+4ZAnpj6KvXaGSTeY9XykPBH2NOjZuxdRT0STOVoI3BlgAkM6
         bTz16f7I+xWHuRE19Fkbft2l85hy84Kwjx4iOFQnfXQd4ae6fEVcyiSrjxP10st19ahS
         ELpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720591330; x=1721196130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90v1wl7Gb7ZugS1FnwJFha2mOK3M1mARo2kqgu20tac=;
        b=Zv48GpoKVd28IRpoBI2rRfWJUVGkLhI5M6m0P5SSzK2aAZ/YqVWa/XDTXjH3ztpadZ
         F3Cc82KkIoKc29F1dCL0/gRTEgvhfOwoDAV7rub2RKV7GyX8demqeIm7y8rk5MwNR3n/
         EQTWd3eUrpOmXQ2yh39xv6KNgqugfa4O2JOhqED5vSMTYvaWrAv/UaKMR1rPOot8wwBy
         sGVLvoNMEgNJ+WXYh9PtxdOVXfjNZdG6ukBr5632+kw8dSd71NXGf7yhcZAOB203I3F1
         I14AtslUKOhK//2h8UXD2wqjiP1CqrRu/OqlxA4cziVz5W7OfRzjp8LgIAjCidtWWx22
         6zZw==
X-Gm-Message-State: AOJu0YyNswUq+Nc/lQLZ3TKM1xaAYheYVzgklGZkhvAey9leQPkwBL3j
	CXC/4x4l0wFmcwRhL5BQ2wH1I4O3MFfSGJWeOl6rXZxqA5dFumQfUpIo51NymKTLnPjuEj1Rn4k
	XYzduOFJsQ+1zR7gffBWkIHjYU3I+C+eJ
X-Google-Smtp-Source: AGHT+IG9dFJyhvzfS53SKSFC3xzzGR4lD3egvhzZt3UHGJk5FwOKilPWZTmKTTF1SvJcU1m0AtDp6Qd6NwTcJ2ba+uk=
X-Received: by 2002:a05:6a00:10d5:b0:706:4a38:916f with SMTP id
 d2e1a72fcca58-70b43626910mr5401161b3a.23.1720591329560; Tue, 09 Jul 2024
 23:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704102402.1644916-1-eddyz87@gmail.com> <20240704102402.1644916-3-eddyz87@gmail.com>
 <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com> <7ec55e40e50fd432ba2c5d344c4927ed3a5ab953.camel@gmail.com>
In-Reply-To: <7ec55e40e50fd432ba2c5d344c4927ed3a5ab953.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 23:01:57 -0700
Message-ID: <CAEf4BzY00fv1+13rZHb+5YHdXcwPzYjNDnN3Rq0-o+cwSB=JFw@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, puranjay@kernel.org, jose.marchesi@oracle.com, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 8:00=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2024-07-09 at 16:42 -0700, Andrii Nakryiko wrote:
>
> [...]
>

[...]

> >
> > > +
> > >  };
> > >
> > >  #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF =
program */
> > > @@ -641,6 +650,11 @@ struct bpf_subprog_info {
> > >         u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
> > >         u16 stack_depth; /* max. stack depth used by this function */
> > >         u16 stack_extra;
> > > +       /* stack depth after which slots reserved for
> > > +        * no_caller_saved_registers spills/fills start,
> > > +        * value <=3D nocsr_stack_off belongs to the spill/fill area.
> >
> > are you sure about <=3D (not <), it seems like nocsr_stack_off is
> > exclusive right bound for nocsr stack region (it would be good to call
> > this out explicitly here)
>
> Right, it should be '<', my bad, will update the comment.

See, I do read comments ;)

[...]

>
> > > @@ -4501,6 +4522,23 @@ static int get_reg_width(struct bpf_reg_state =
*reg)
> > >         return fls64(reg->umax_value);
> > >  }
> > >
> > > +/* See comment for mark_nocsr_pattern_for_call() */
> > > +static void check_nocsr_stack_contract(struct bpf_verifier_env *env,=
 struct bpf_func_state *state,
> > > +                                      int insn_idx, int off)
> > > +{
> > > +       struct bpf_subprog_info *subprog =3D &env->subprog_info[state=
->subprogno];
> > > +       struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[insn_id=
x];
> > > +
> > > +       if (subprog->nocsr_stack_off <=3D off || aux->nocsr_pattern)
> > > +               return;
> >
> > can helper call instruction go through this check? E.g., if we do
> > bpf_probe_read_kernel() into stack slot, where do we check that that
> > slot is not overlapping with nocsr spill/fill region?
>
> In check_helper_call() we do check_mem_access() that eventually calls
> one of the check_stack_{read,write}_{fixed,varying}_off().
> The .access_size should be set for bpf_probe_read_kernel()
> because it's argument base type is ARG_PTR_TO_MEM.
> I will add a test case to double-check this.

Ok. Also as I was reading this I didn't yet realize that
aux->nocsr_pattern is not set for call instruction itself, so I was
worried that we might accidentally skip the check. But we don't set
nocsr_pattern for call, so we should be good (but the test never
hurts)

>
> [...]
>
> > > @@ -15951,6 +15993,206 @@ static int visit_func_call_insn(int t, stru=
ct bpf_insn *insns,
> > >         return ret;
> > >  }
> > >
> > > +/* Bitmask with 1s for all caller saved registers */
> > > +#define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
> > > +
> > > +/* Return a bitmask specifying which caller saved registers are
> > > + * modified by a call to a helper.
> > > + * (Either as a return value or as scratch registers).
> > > + *
> > > + * For normal helpers registers R0-R5 are scratched.
> > > + * For helpers marked as no_csr:
> > > + * - scratch R0 if function is non-void;
> > > + * - scratch R1-R5 if corresponding parameter type is set
> > > + *   in the function prototype.
> > > + */
> > > +static u8 get_helper_reg_mask(const struct bpf_func_proto *fn)
> >
> > suggestion: to make this less confusing, here we are returning a mask
> > of registers that are clobbered by the helper, is that right? so
> > get_helper_clobber_mask() maybe?
>
> get_helper_clobber_mask() is a good name, will change.
>
> [...]
>
> > > +/* If 'insn' is a call that follows no_caller_saved_registers contra=
ct
> > > + * and called function is inlined by current jit or verifier,
> > > + * return a mask with 1s corresponding to registers that are scratch=
ed
> > > + * by this call (depends on return type and number of return paramet=
ers).
> >
> > return parameters? was it supposed to be "function parameters/arguments=
"?
>
> My bad.
>
> >
> > > + * Otherwise return ALL_CALLER_SAVED_REGS mask.
> > > + */
> > > +static u32 call_csr_mask(struct bpf_verifier_env *env, struct bpf_in=
sn *insn)
> >
> > you use u8 for get_helper_reg_mask() and u32 here, why not keep them co=
nsistent?
>
> Ok
>
> > similar to the naming nit above, I think we should be a bit more
> > explicit with what "mask" actually means. Is this also clobber mask?
>
> I mean, there is a comment right above the function.
> This function returns a mask of caller saved registers (csr).
> I'll make the name more explicit.
>
> >
> > > +{
> > > +       const struct bpf_func_proto *fn;
> > > +
> > > +       if (bpf_helper_call(insn) &&
> > > +           (verifier_inlines_helper_call(env, insn->imm) || bpf_jit_=
inlines_helper_call(insn->imm)) &&
> > > +           get_helper_proto(env, insn->imm, &fn) =3D=3D 0 &&
> > > +           fn->allow_nocsr)
> > > +               return ~get_helper_reg_mask(fn);
> >
> > hm... I'm a bit confused why we do a negation here? aren't we working
> > with clobbering mask... I'll keep reading for now.
>
> Please read the comment before the function.
>

Believe it or not, but I read it like 10 times and that didn't help me much=
.

+/* If 'insn' is a call that follows no_caller_saved_registers contract
+ * and called function is inlined by current jit or verifier,
+ * return a mask with 1s corresponding to registers that are scratched
+ * by this call (depends on return type and number of return parameters).
+ * Otherwise return ALL_CALLER_SAVED_REGS mask.

"registers that are scratched by this call" would be what
get_helper_reg_mask() returns for the function (at least that's my
reading of the above), and yet you return inverted mask. It doesn't
really help that we return ALL_CALLER_SAVED_REGS as "nope, it's not
nocsr call".

Maybe it would be a bit easier to follow if call_csr_mask() returned
bool and mask as an out parameter in case it's nocsr call. So instead
of special casing ALL_CALLER_SAVED_REGS there would be a nice "not a
nocsr, never mind" and early exit.

Anyways, perhaps I'm just being very dense here, I just found this
particular piece extremely hard to follow intuitively.

> >
> > > +
> > > +       return ALL_CALLER_SAVED_REGS;
> > > +}
>
> [...]
>
> > > +static void mark_nocsr_pattern_for_call(struct bpf_verifier_env *env=
, int t)
> >
> > t is insn_idx, let's not carry over old crufty check_cfg naming
>
> Ok
>
> >
> > > +{
> > > +       struct bpf_insn *insns =3D env->prog->insnsi, *stx, *ldx;
> > > +       struct bpf_subprog_info *subprog;
> > > +       u32 csr_mask =3D call_csr_mask(env, &insns[t]);
> > > +       u32 reg_mask =3D ~csr_mask | ~ALL_CALLER_SAVED_REGS;
> >
> > tbh, I'm lost with all these bitmask and their inversions...
> > call_csr_mask()'s result is basically always used inverted, so why not
> > return inverted mask in the first place?
>
> The mask is initialized as a set of all registers preserved by this call.

ok, maybe it's just a mix of "no csr" and "csr" that confuses me. How
about we call call_csr_mask as get_helper_preserved_mask() or
something like that to "match" get_helper_clobber_mask()?

> Those that are not in mask need a spill/fill pair.
> I'll toss things around to make this more clear.
> (naming, comments, maybe move the '| ~ALL_CALLER_SAVED_REGS' to the call_=
csr_mask()).
>
> >
> > > +       int s, i;
> > > +       s16 off;
> > > +
> > > +       if (csr_mask =3D=3D ALL_CALLER_SAVED_REGS)
> > > +               return;
> > > +
> > > +       for (i =3D 1, off =3D 0; i <=3D ARRAY_SIZE(caller_saved); ++i=
, off +=3D BPF_REG_SIZE) {
> > > +               if (t - i < 0 || t + i >=3D env->prog->len)
> > > +                       break;
> > > +               stx =3D &insns[t - i];
> > > +               ldx =3D &insns[t + i];
> > > +               if (off =3D=3D 0) {
> > > +                       off =3D stx->off;
> > > +                       if (off % BPF_REG_SIZE !=3D 0)
> > > +                               break;
> >
> > kind of ugly that we assume stx before we actually checked that it's
> > STX?... maybe split humongous if below into instruction checking
> > (with code and src_reg) and then off checking separately?
>
> Don't see anything ugly about this, tbh.

you are using stx->off and do `% BPF_REG_SIZE` check on it while that
stx->off field might be meaningless for the instruction (because we
are not yet sure it's STX instruction), that's a bit ugly, IMO

> Can split the 'if' statement, if you think it's hard to read.

it's not about readability for me

>
> >
> > > +               }
> > > +               if (/* *(u64 *)(r10 - off) =3D r[0-5]? */
> > > +                   stx->code !=3D (BPF_STX | BPF_MEM | BPF_DW) ||
> > > +                   stx->dst_reg !=3D BPF_REG_10 ||
> > > +                   /* r[0-5] =3D *(u64 *)(r10 - off)? */
> > > +                   ldx->code !=3D (BPF_LDX | BPF_MEM | BPF_DW) ||
> > > +                   ldx->src_reg !=3D BPF_REG_10 ||
> > > +                   /* check spill/fill for the same reg and offset *=
/
> > > +                   stx->src_reg !=3D ldx->dst_reg ||
> > > +                   stx->off !=3D ldx->off ||
> > > +                   stx->off !=3D off ||
> > > +                   /* this should be a previously unseen register */
> > > +                   BIT(stx->src_reg) & reg_mask)
> >
> > () around & operation?
>
> No need, & has higher priority over ||.
> You can check the AST using
> https://tree-sitter.github.io/tree-sitter/playground .

Oh, I have no doubt you checked that it works correctly. It's just not
a really good habit to rely on C's obscure operation ordering rules
beyond A && B || C (and even then it is arguable). I think the rule of
thumb to not mix bitwise and logic operators without explicit
parenthesis makes sense.

But never mind, I already feel weird complaining about !strcmp(),
every real kernel engineer should memorize operator precedence by
heart.

>
> >
> > > +                       break;
> > > +               reg_mask |=3D BIT(stx->src_reg);
> > > +               env->insn_aux_data[t - i].nocsr_pattern =3D 1;
> > > +               env->insn_aux_data[t + i].nocsr_pattern =3D 1;
> > > +       }
> > > +       if (i =3D=3D 1)
> > > +               return;
> > > +       env->insn_aux_data[t].nocsr_spills_num =3D i - 1;
> > > +       s =3D find_containing_subprog(env, t);
> > > +       /* can't happen */
> >
> > then don't check ;) we leave the state partially set for CSR but not
> > quite. We either should error out completely or just assume
> > correctness of find_containing_subprog, IMO
>
> Ok
>
> >
> > > +       if (WARN_ON_ONCE(s < 0))
> > > +               return;
> > > +       subprog =3D &env->subprog_info[s];
> > > +       subprog->nocsr_stack_off =3D min(subprog->nocsr_stack_off, of=
f);
> >
> > should this be max()? offsets are negative, right? so if nocsr uses -8
> > and -16 as in the example, entire [-16, 0) region is nocsr region
>
> This should be min exactly because stack offsets are negative.
> For the example above the 'off' is initialized as -16 and then
> is incremented by +8 giving final value of -8.
> And I need to select the minimal value used between several patterns.

so let's say I have two nocsr calls in the same subprog

    *(u64 *)(r10 - 8)  =3D r1;
    *(u64 *)(r10 - 16) =3D r2;
    call %[to_be_inlined]
    r2 =3D *(u64 *)(r10 - 16);
    r1 =3D *(u64 *)(r10 - 8);


and then a bit later


    *(u64 *)(r10 - 16)  =3D r1;
    *(u64 *)(r10 - 24) =3D r2;
    call %[to_be_inlined]
    r2 =3D *(u64 *)(r10 - 24);
    r1 =3D *(u64 *)(r10 - 16);


For the first chunk nocsr range is [-16, 0). For the second it's [-24,
-8), right?

Should `*(u64 *)(r10 - 8) =3D 123` somewhere in that subprog (not for
nocsr calls) invalidate this whole nocsr thing? With min you'll
basically have [-24, -8) as nocsr-reserved region, but shouldn't it be
whole [-24, 0)?

Clang shouldn't generate such inconsistent offset, right? But it's
legal, no? And if not, then all the calls should use the same upper
stack boundary and we shouldn't be doing min/max, but rather checking
that they are all consistent.

Or what am I missing again?

>
> >
> > > +}
>
> [...]
>
> > > @@ -20119,6 +20361,48 @@ static int do_misc_fixups(struct bpf_verifie=
r_env *env)
> > >                         goto next_insn;
> > >                 if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> > >                         goto next_insn;
> > > +               /* Remove unnecessary spill/fill pairs, members of no=
csr pattern */
> > > +               if (env->insn_aux_data[i + delta].nocsr_spills_num > =
0) {
> > > +                       u32 j, spills_num =3D env->insn_aux_data[i + =
delta].nocsr_spills_num;
> > > +                       int err;
> > > +
> > > +                       /* don't apply this on a second visit */
> > > +                       env->insn_aux_data[i + delta].nocsr_spills_nu=
m =3D 0;
> > > +
> > > +                       /* check if spill/fill stack access is in exp=
ected offset range */
> > > +                       for (j =3D 1; j <=3D spills_num; ++j) {
> > > +                               if ((insn - j)->off >=3D subprogs[cur=
_subprog].nocsr_stack_off ||
> > > +                                   (insn + j)->off >=3D subprogs[cur=
_subprog].nocsr_stack_off) {
> > > +                                       /* do a second visit of this =
instruction,
> > > +                                        * so that verifier can inlin=
e it
> > > +                                        */
> > > +                                       i -=3D 1;
> > > +                                       insn -=3D 1;
> > > +                                       goto next_insn;
> > > +                               }
> > > +                       }
> >
> > I don't get this loop, can you elaborate? Why are we double-checking
> > anything here, didn't we do this already?
>
> We established probable patterns and probable minimal offset.
> Over the course of program verification we might have invalidated the
> .nocsr_stack_off for a particular subprogram =3D> hence a need for this c=
heck.

Ah, right, we can invalidate it if we detect misuse, makes sense. Missed th=
at.

>
> >
> > > +
> > > +                       /* apply the rewrite:
> > > +                        *   *(u64 *)(r10 - X) =3D rY ; num-times
> > > +                        *   call()                               -> =
call()
> > > +                        *   rY =3D *(u64 *)(r10 - X) ; num-times
> > > +                        */
> > > +                       err =3D verifier_remove_insns(env, i + delta =
- spills_num, spills_num);
> > > +                       if (err)
> > > +                               return err;
> > > +                       err =3D verifier_remove_insns(env, i + delta =
- spills_num + 1, spills_num);
> > > +                       if (err)
> > > +                               return err;
> >
> > why not a single bpf_patch_insn_data()?
>
> bpf_patch_insn_data() assumes that one instruction has to be replaced wit=
h many.
> Here I need to replace many instructions with a single instruction.
> I'd prefer not to tweak bpf_patch_insn_data() for this patch-set.

ah, bpf_patch_insn_data just does bpf_patch_insn_single, somehow I
thought that it does range for range replacement of instructions.
Never mind then (it's a bit sad that we don't have a proper flexible
and powerful patching primitive, though, but oh well).

>
> On the other hand, the do_jit() for x86 removes NOPs (BPF_JA +0),
> so I can probably replace spills/fills with NOPs here instead of
> calling bpf_patch_insn_data() or bpf_remove_insns().

NOPing feels uglier, I think what you have is fine.

>
> > > +
> > > +                       i +=3D spills_num - 1;
> > > +                       /*   ^            ^   do a second visit of th=
is instruction,
> > > +                        *   |            '-- so that verifier can in=
line it
> > > +                        *   '--------------- jump over deleted fills
> > > +                        */
> > > +                       delta -=3D 2 * spills_num;
> > > +                       insn =3D env->prog->insnsi + i + delta;
> > > +                       goto next_insn;
> >
> > why not adjust the state and just fall through, what goto next_insn
> > does that we can't (and next instruction is misleading, so I'd rather
> > fix up and move forward)
>
> I don't like this. The fall-through makes control flow more convoluted.
> To understand what would happen next:
> - with goto next_insn we just start over;
> - with fall-through we need to think about position of this particular
>   'if' statement within the loop.
>

Alright, it's fine. Though I don't see anything wrong with knowing
that we patch up nocsr pattern before we do inlining of calls. And
yes, order is important, so what? I always assumed that the order of
operations in do_misc_fixups() is not arbitrary.

> >
> > > +               }
> > >                 if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
> > >                         ret =3D fixup_kfunc_call(env, insn, insn_buf,=
 i + delta, &cnt);
> > >                         if (ret)
>
> [...]

