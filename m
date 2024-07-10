Return-Path: <bpf+bounces-34406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E6392D523
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 17:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806E21C208BE
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 15:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8C8194AF6;
	Wed, 10 Jul 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja7M/1+i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CC194A73
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625811; cv=none; b=eCfR8oYUUzzN9ADJvnT3/eqcgbVDFq4XRB6w9s2EAGvh+f4dUwh9tr0fDCDnT4JCWGjppL6z1zMHMnoRM2NgQLGwoUTK+l2KCvbntaYmbwvruOOWt33EzdGgUQ0gMyC/fuF9uoDqrUy9ZLyRYPdK3WSEiJ4iutGL1ELKJiFdD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625811; c=relaxed/simple;
	bh=lfG2ChZ09+fyCPWnK8TwGkK23EbDy9rMhcz6VOLKtsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aiea6rwwRNlfLQEYDjC/WLKY2vuy+AvquL0rIfLEddtH7cZLiqr6yXp/uVGPudtptU3L2XeBUCI8IR60HyzBs8iGtzp8CaMe15R+J1HiS5/6ZgDPL4J1QKs+1xf2FKdinkQjwqv6aelqrKUw0KFrBC/5L1RENKgHoF2c1g5Yrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ja7M/1+i; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77e7a6cfa7so433225966b.1
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720625808; x=1721230608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLjKsjF/hDuaomqvdKdgC1LYx1zxvGYj4k7uP6Zs7RI=;
        b=Ja7M/1+iSCje6x/4v9H0Mb7Uz1w/RGfr9IZ9sZQUGN1R1126zmSV6s48RKpNtL53Lb
         c6tGi0fLS//gPfBdJuFyMxuJ6yuhJvBWGMT5rjS4v9180bGCMtvRrG+uyazQpp69+kOn
         5aOWF58VbuOmm4DZ184WTluuJvpng1UOoQdyS3EBrkNLXgQQzZ9ZkYoMrUlK83giIU3A
         8SeZ6KKadDEM00Ib7Yv8tnaftbeLaIpA380ipUyNFMCfIbCZSasg1/qCIPFQJhew6njv
         n4bnH4gIRKrjazs3AS1g80/GIDn+OVxeFY/2M1sp52/BsJvmnoAnmbZsMD9IEBSC42fG
         OTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720625808; x=1721230608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLjKsjF/hDuaomqvdKdgC1LYx1zxvGYj4k7uP6Zs7RI=;
        b=hqPdl4PiJAoJLtSsvnbBww94IJt7ePK42lIRl8N7g7/F18NxlA702uqra0p92pCgEc
         /emXzUCmtLND27o+SCRCCymJuSJPC0uFtbn1kBbhk7xHqIXDzGelFVpzrD90Q5opakLe
         jeMLERyTWzpLylpItH2xF7pCLatlZA3PWQY7R8KN2DFO0duO9b8qYQSCfMZsQcVhejga
         n+ZT7uq80HGvN4QqzgOdZXV9SEu9Q1pEeSq8Gks6k0BakmDStDoqVwYoh5TAus4A1I49
         C+5SfNG/+CZwhjhEeGCYmmcJRFD4fs4Lb4a5YN2v4K1Dhfb2Dft4IGaGLAHyCLHcLVi7
         0gnw==
X-Gm-Message-State: AOJu0YyyTA9lDjyv/ermfmPkJwKgXawhp09GnBJdZVAgjq+fpKyJ5qum
	r5e9UzzhFfLCopRq7+TDHaIDgpMMk4HeWkWOf1X1HL2mWGIvaucrHYS7NcGqnJCFOoKNXxuAKfC
	NQlVwp37gRvNm4OtflCo4ymGQi+c=
X-Google-Smtp-Source: AGHT+IFWWY4RUMczGa56Fl6MAXgwMuSDbRh5ez0cIKYkMUlIR+eMaKrPJjfiv0lI0lKza80j/pdcvqJxEVF5vuJoKBg=
X-Received: by 2002:a17:906:2797:b0:a72:8100:c3e with SMTP id
 a640c23a62f3a-a780b884507mr354302766b.48.1720625807288; Wed, 10 Jul 2024
 08:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704102402.1644916-1-eddyz87@gmail.com> <20240704102402.1644916-3-eddyz87@gmail.com>
 <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com>
 <7ec55e40e50fd432ba2c5d344c4927ed3a5ab953.camel@gmail.com>
 <CAEf4BzY00fv1+13rZHb+5YHdXcwPzYjNDnN3Rq0-o+cwSB=JFw@mail.gmail.com> <de4ed737e56fc6288031191509acc590446f4d24.camel@gmail.com>
In-Reply-To: <de4ed737e56fc6288031191509acc590446f4d24.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 08:36:32 -0700
Message-ID: <CAEf4BzajkXm0_8H3bA4RaYLvK19sz5OeQL0HFWgRGgKKERbrkA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, puranjay@kernel.org, jose.marchesi@oracle.com, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:57=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2024-07-09 at 23:01 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > Right, it should be '<', my bad, will update the comment.
> >
> > See, I do read comments ;)
>
> Yes, sorry about that remark.
>

no worries :)

> [...]
>
> > > > > +/* See comment for mark_nocsr_pattern_for_call() */
> > > > > +static void check_nocsr_stack_contract(struct bpf_verifier_env *=
env, struct bpf_func_state *state,
> > > > > +                                      int insn_idx, int off)
> > > > > +{
> > > > > +       struct bpf_subprog_info *subprog =3D &env->subprog_info[s=
tate->subprogno];
> > > > > +       struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[ins=
n_idx];
> > > > > +
> > > > > +       if (subprog->nocsr_stack_off <=3D off || aux->nocsr_patte=
rn)
> > > > > +               return;
> > > >
> > > > can helper call instruction go through this check? E.g., if we do
> > > > bpf_probe_read_kernel() into stack slot, where do we check that tha=
t
> > > > slot is not overlapping with nocsr spill/fill region?
> > >
> > > In check_helper_call() we do check_mem_access() that eventually calls
> > > one of the check_stack_{read,write}_{fixed,varying}_off().
> > > The .access_size should be set for bpf_probe_read_kernel()
> > > because it's argument base type is ARG_PTR_TO_MEM.
> > > I will add a test case to double-check this.
> >
> > Ok. Also as I was reading this I didn't yet realize that
> > aux->nocsr_pattern is not set for call instruction itself, so I was
> > worried that we might accidentally skip the check. But we don't set
> > nocsr_pattern for call, so we should be good (but the test never
> > hurts)
>
> Well yes, there is a flag check, but call to bpf_probe_read_kernel()
> touching candidate nocsr stack address should disable nocsr rewrites
> for current subprogram.

cool, let's have a test confirming correctness

>
> [...]
>
> > > > > +static u32 call_csr_mask(struct bpf_verifier_env *env, struct bp=
f_insn *insn)
> > > >
> > > > you use u8 for get_helper_reg_mask() and u32 here, why not keep the=
m consistent?
> > >
> > > Ok
> > >
> > > > similar to the naming nit above, I think we should be a bit more
> > > > explicit with what "mask" actually means. Is this also clobber mask=
?
> > >
> > > I mean, there is a comment right above the function.
> > > This function returns a mask of caller saved registers (csr).
> > > I'll make the name more explicit.
> > >
> > > >
> > > > > +{
> > > > > +       const struct bpf_func_proto *fn;
> > > > > +
> > > > > +       if (bpf_helper_call(insn) &&
> > > > > +           (verifier_inlines_helper_call(env, insn->imm) || bpf_=
jit_inlines_helper_call(insn->imm)) &&
> > > > > +           get_helper_proto(env, insn->imm, &fn) =3D=3D 0 &&
> > > > > +           fn->allow_nocsr)
> > > > > +               return ~get_helper_reg_mask(fn);
> > > >
> > > > hm... I'm a bit confused why we do a negation here? aren't we worki=
ng
> > > > with clobbering mask... I'll keep reading for now.
> > >
> > > Please read the comment before the function.
> > >
> >
> > Believe it or not, but I read it like 10 times and that didn't help me =
much.
> >
> > +/* If 'insn' is a call that follows no_caller_saved_registers contract
> > + * and called function is inlined by current jit or verifier,
> > + * return a mask with 1s corresponding to registers that are scratched
> > + * by this call (depends on return type and number of return parameter=
s).
> > + * Otherwise return ALL_CALLER_SAVED_REGS mask.
> >
> > "registers that are scratched by this call" would be what
> > get_helper_reg_mask() returns for the function (at least that's my
> > reading of the above), and yet you return inverted mask. It doesn't
> > really help that we return ALL_CALLER_SAVED_REGS as "nope, it's not
> > nocsr call".
>
> I see, I messed up the comment...
>
> > Maybe it would be a bit easier to follow if call_csr_mask() returned
> > bool and mask as an out parameter in case it's nocsr call. So instead
> > of special casing ALL_CALLER_SAVED_REGS there would be a nice "not a
> > nocsr, never mind" and early exit.
>
> Out parameter seems to be an overkill. I'll change names a little bit
> to make it easier to follow. If for v3 you'd still think that out
> parameter is better I'll switch then.

ok

>
> > Anyways, perhaps I'm just being very dense here, I just found this
> > particular piece extremely hard to follow intuitively.
> >
> > > >
> > > > > +
> > > > > +       return ALL_CALLER_SAVED_REGS;
> > > > > +}
> > >
> > > [...]
> > >
> > > > > +static void mark_nocsr_pattern_for_call(struct bpf_verifier_env =
*env, int t)
> > > > > +{
> > > > > +       struct bpf_insn *insns =3D env->prog->insnsi, *stx, *ldx;
> > > > > +       struct bpf_subprog_info *subprog;
> > > > > +       u32 csr_mask =3D call_csr_mask(env, &insns[t]);
> > > > > +       u32 reg_mask =3D ~csr_mask | ~ALL_CALLER_SAVED_REGS;
> > > >
> > > > tbh, I'm lost with all these bitmask and their inversions...
> > > > call_csr_mask()'s result is basically always used inverted, so why =
not
> > > > return inverted mask in the first place?
> > >
> > > The mask is initialized as a set of all registers preserved by this c=
all.
> >
> > ok, maybe it's just a mix of "no csr" and "csr" that confuses me. How
> > about we call call_csr_mask as get_helper_preserved_mask() or
> > something like that to "match" get_helper_clobber_mask()?
>
> Yes, these two names are good, thank you.
> I'd still call it get_call_preserved_mask() as kfuncs might be added
> at some point.

sure, makes sense

>
> > > Those that are not in mask need a spill/fill pair.
> > > I'll toss things around to make this more clear.
> > > (naming, comments, maybe move the '| ~ALL_CALLER_SAVED_REGS' to the c=
all_csr_mask()).
> > >
> > > >
> > > > > +       int s, i;
> > > > > +       s16 off;
> > > > > +
> > > > > +       if (csr_mask =3D=3D ALL_CALLER_SAVED_REGS)
> > > > > +               return;
> > > > > +
> > > > > +       for (i =3D 1, off =3D 0; i <=3D ARRAY_SIZE(caller_saved);=
 ++i, off +=3D BPF_REG_SIZE) {
> > > > > +               if (t - i < 0 || t + i >=3D env->prog->len)
> > > > > +                       break;
> > > > > +               stx =3D &insns[t - i];
> > > > > +               ldx =3D &insns[t + i];
> > > > > +               if (off =3D=3D 0) {
> > > > > +                       off =3D stx->off;
> > > > > +                       if (off % BPF_REG_SIZE !=3D 0)
> > > > > +                               break;
> > > >
> > > > kind of ugly that we assume stx before we actually checked that it'=
s
> > > > STX?... maybe split humongous if below into instruction checking
> > > > (with code and src_reg) and then off checking separately?
> > >
> > > Don't see anything ugly about this, tbh.
> >
> > you are using stx->off and do `% BPF_REG_SIZE` check on it while that
> > stx->off field might be meaningless for the instruction (because we
> > are not yet sure it's STX instruction), that's a bit ugly, IMO
>
> I can rewrite it like below:
>
>                 if (stx->code !=3D (BPF_STX | BPF_MEM | BPF_DW) ||
>                     ldx->code !=3D (BPF_LDX | BPF_MEM | BPF_DW))

I'd add stx->dst_reg !=3D BPF_REG_10 and ldx->src_reg !=3D BPF_REG_10
checks here and preserve original comments with instruction assembly
form.

(think about this as establishing that we are looking at the correct
shapes of instructions)

>                         break;
>                 off =3D off !=3D 0 ?: stx->off; // or use full 'if' block=
 from the old version
>                 if (stx->dst_reg !=3D BPF_REG_10 ||
>                     ldx->src_reg !=3D BPF_REG_10 ||
>                     /* check spill/fill for the same reg and offset */
>                     stx->src_reg !=3D ldx->dst_reg ||
>                     stx->off !=3D ldx->off ||
>                     stx->off !=3D off ||
>                     (off % BPF_REG_SIZE) !=3D 0 ||
>                     /* this should be a previously unseen register */
>                     (BIT(stx->src_reg) & reg_mask))

and here we are checking all the correctness and additional imposed
semantical invariants knowing full well that we are dealing with
correct STX/LDX shapes

>                         break;
>
> But I'm not sure this adds any actual clarity.

I think it makes sense.

>
> >
> > > Can split the 'if' statement, if you think it's hard to read.
> >
> > it's not about readability for me
> >
> > >
> > > >
> > > > > +               }
> > > > > +               if (/* *(u64 *)(r10 - off) =3D r[0-5]? */
> > > > > +                   stx->code !=3D (BPF_STX | BPF_MEM | BPF_DW) |=
|
> > > > > +                   stx->dst_reg !=3D BPF_REG_10 ||
> > > > > +                   /* r[0-5] =3D *(u64 *)(r10 - off)? */
> > > > > +                   ldx->code !=3D (BPF_LDX | BPF_MEM | BPF_DW) |=
|
> > > > > +                   ldx->src_reg !=3D BPF_REG_10 ||
> > > > > +                   /* check spill/fill for the same reg and offs=
et */
> > > > > +                   stx->src_reg !=3D ldx->dst_reg ||
> > > > > +                   stx->off !=3D ldx->off ||
> > > > > +                   stx->off !=3D off ||
> > > > > +                   /* this should be a previously unseen registe=
r */
> > > > > +                   BIT(stx->src_reg) & reg_mask)
> > > >
> > > > () around & operation?
> > >
> > > No need, & has higher priority over ||.
> > > You can check the AST using
> > > https://tree-sitter.github.io/tree-sitter/playground .
> >
> > Oh, I have no doubt you checked that it works correctly. It's just not
> > a really good habit to rely on C's obscure operation ordering rules
> > beyond A && B || C (and even then it is arguable). I think the rule of
> > thumb to not mix bitwise and logic operators without explicit
> > parenthesis makes sense.
> >
> > But never mind, I already feel weird complaining about !strcmp(),
> > every real kernel engineer should memorize operator precedence by
> > heart.
>
> I assumed you implied incorrect evaluation order.
> Will add parenthesis.
>

thanks

> > > > > +                       break;
> > > > > +               reg_mask |=3D BIT(stx->src_reg);
> > > > > +               env->insn_aux_data[t - i].nocsr_pattern =3D 1;
> > > > > +               env->insn_aux_data[t + i].nocsr_pattern =3D 1;
> > > > > +       }
> > > > > +       if (i =3D=3D 1)
> > > > > +               return;
> > > > > +       env->insn_aux_data[t].nocsr_spills_num =3D i - 1;
> > > > > +       s =3D find_containing_subprog(env, t);
> > > > > +       /* can't happen */
> [...]
> > > > > +       if (WARN_ON_ONCE(s < 0))
> > > > > +               return;
> > > > > +       subprog =3D &env->subprog_info[s];
> > > > > +       subprog->nocsr_stack_off =3D min(subprog->nocsr_stack_off=
, off);
> > > >
> > > > should this be max()? offsets are negative, right? so if nocsr uses=
 -8
> > > > and -16 as in the example, entire [-16, 0) region is nocsr region
> > >
> > > This should be min exactly because stack offsets are negative.
> > > For the example above the 'off' is initialized as -16 and then
> > > is incremented by +8 giving final value of -8.
> > > And I need to select the minimal value used between several patterns.
> >
> > so let's say I have two nocsr calls in the same subprog
> >
> >     *(u64 *)(r10 - 8)  =3D r1;
> >     *(u64 *)(r10 - 16) =3D r2;
> >     call %[to_be_inlined]
> >     r2 =3D *(u64 *)(r10 - 16);
> >     r1 =3D *(u64 *)(r10 - 8);
> >
> >
> > and then a bit later
> >
> >
> >     *(u64 *)(r10 - 16)  =3D r1;
> >     *(u64 *)(r10 - 24) =3D r2;
> >     call %[to_be_inlined]
> >     r2 =3D *(u64 *)(r10 - 24);
> >     r1 =3D *(u64 *)(r10 - 16);
> >
> >
> > For the first chunk nocsr range is [-16, 0). For the second it's [-24,
> > -8), right?
> > Should `*(u64 *)(r10 - 8) =3D 123` somewhere in that subprog (not for
> > nocsr calls) invalidate this whole nocsr thing? With min you'll
> > basically have [-24, -8) as nocsr-reserved region, but shouldn't it be
> > whole [-24, 0)?
> >
> > Clang shouldn't generate such inconsistent offset, right? But it's
> > legal, no? And if not, then all the calls should use the same upper
> > stack boundary and we shouldn't be doing min/max, but rather checking
> > that they are all consistent.
> >
> > Or what am I missing again?
>
> You don't miss anything.
>
> With the current algorithm first call will not be rewritten because of
> the offset check in do_misc_fixups().
> The second call would be rewritten and this is safe to do, because
> verifier knows that range [-24,-8) is only used by nocsr patterns.
> What you suggest is slightly more pessimistic, compared to current
> algorithm.

Ok, I see, this wasn't obvious that you want this behavior. I actually
find it surprising (and so at least let's call this possibility out).

But, tbh, I'd make this stricter. I'd dictate that within a subprogram
all no_csr patterns *should* end with the same stack offset and I
would check for that (so what I mentioned before that instead of min
or max we need assignment and check for equality if we already
assigned it once).

Also, instead of doing that extra nocsr offset check in
do_misc_fixups(), why don't we just reset all no_csr patterns within a
subprogram *if we find a single violation*. Compiler shouldn't ever
emit such code, right? So let's be strict and fallback to not
recognizing nocsr.

And then we won't need that extra check in do_misc_fixups() because we
eagerly unset no_csr flag and will never hit that piece of logic in
patching.


I'd go even further and say that on any nocsr invariant violation, we
just go and reset all nocsr pattern flags across entire BPF program
(all subprogs including). In check_nocsr_stack_contract() I mean. Just
have a loop over all instructions and set that flag to false.

Why not? What realistic application would need to violate nocsr in
some subprogs but not in others?

KISS or it's too simplistic for some reason?

>
> [...]
>
> > > > > +
> > > > > +                       /* apply the rewrite:
> > > > > +                        *   *(u64 *)(r10 - X) =3D rY ; num-times
> > > > > +                        *   call()                              =
 -> call()
> > > > > +                        *   rY =3D *(u64 *)(r10 - X) ; num-times
> > > > > +                        */
> > > > > +                       err =3D verifier_remove_insns(env, i + de=
lta - spills_num, spills_num);
> > > > > +                       if (err)
> > > > > +                               return err;
> > > > > +                       err =3D verifier_remove_insns(env, i + de=
lta - spills_num + 1, spills_num);
> > > > > +                       if (err)
> > > > > +                               return err;
> > > >
> > > > why not a single bpf_patch_insn_data()?
> > >
> > > bpf_patch_insn_data() assumes that one instruction has to be replaced=
 with many.
> > > Here I need to replace many instructions with a single instruction.
> > > I'd prefer not to tweak bpf_patch_insn_data() for this patch-set.
> >
> > ah, bpf_patch_insn_data just does bpf_patch_insn_single, somehow I
> > thought that it does range for range replacement of instructions.
> > Never mind then (it's a bit sad that we don't have a proper flexible
> > and powerful patching primitive, though, but oh well).
>
> That is true.
> I'll think about it once other issues with this patch-set are resolved.

yeah, it's completely unrelated, but having a bpf_patch_insns that
takes input instruction range to be replaced and replacing it with
another set of instructions would cover all existing use cases and
some more. We wouldn't need verifier_remove_insns(), because that's
just replacing existing instructions with empty new set of
instructions. We would now have "insert instructions" primitive if we
specify empty input range of instructions. If we add a flag whether to
adjust jump offsets and make it configurable, we'd need the thing that
Alexei needed for may_goto without any extra hacks.

Furthermore, I find it wrong and silly that we keep having manual
delta+insn adjustments in every single piece of patching logic. I
think this should be done by bpf_patch_insns(). We need to have a
small "insn_patcher" struct that we use during instruction patching,
and a small instruction iterator on top that would keep returning next
instruction to process (and its index, probably). This will allow us
to optimize patching and instead of doing O(N) we can have something
faster and smarter (if we hide direct insn array accesses during
patching).

But this is all a completely separate story from all of this.

>
> [...]
>
> > > > > +
> > > > > +                       i +=3D spills_num - 1;
> > > > > +                       /*   ^            ^   do a second visit o=
f this instruction,
> > > > > +                        *   |            '-- so that verifier ca=
n inline it
> > > > > +                        *   '--------------- jump over deleted f=
ills
> > > > > +                        */
> > > > > +                       delta -=3D 2 * spills_num;
> > > > > +                       insn =3D env->prog->insnsi + i + delta;
> > > > > +                       goto next_insn;
> > > >
> > > > why not adjust the state and just fall through, what goto next_insn
> > > > does that we can't (and next instruction is misleading, so I'd rath=
er
> > > > fix up and move forward)
> > >
> > > I don't like this. The fall-through makes control flow more convolute=
d.
> > > To understand what would happen next:
> > > - with goto next_insn we just start over;
> > > - with fall-through we need to think about position of this particula=
r
> > >   'if' statement within the loop.
> > >
> >
> > Alright, it's fine. Though I don't see anything wrong with knowing
> > that we patch up nocsr pattern before we do inlining of calls. And
> > yes, order is important, so what? I always assumed that the order of
> > operations in do_misc_fixups() is not arbitrary.
>
> On a second thought maybe fall-through is not that bad.
>
> [...]

