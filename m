Return-Path: <bpf+bounces-34366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0391E92CC5A
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 09:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17715286265
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 07:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45CB84A39;
	Wed, 10 Jul 2024 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkgcXCM2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8088384A35
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720598268; cv=none; b=cHTsC2DKQrkODvMhFSIpoKvgbrZFVRY02fv85ymqm1RgRy0Wa6RVKMQzIHwBoBIxUzHNa0Uh5HSlkYogbU1MM+fqaKJ3yW0xmYTJllsAhEJEq2M9Ywp1PFCSZHt8KxamATdoqjXSU7ol4bOTITSmKxEYdT/Irldj0DIpDXzfric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720598268; c=relaxed/simple;
	bh=z5IH4XZO/AxultyHr7MyPd6MMVSDhR26/R/G+z32IlY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W0zTrytVK+V60WKfi03TzxCGupWpHEYCtE9Del3h+Z73ezOpjC/ubCZkwKHI7OC8O2Fp9P0zFUq/Fw1wnYY0U8ZkhT9IhWJ7LmmSy4oM7t/YIPsTPUD9wQVNp4I6FdvXmDCJPKd41ug/45ZdulS0bmhSFNx+FjXCWY59l+GNOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkgcXCM2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70af2b1a35aso3942717b3a.1
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720598266; x=1721203066; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vJHjCure8OpCwJZek8VCttLVkOx52+V7+aqk6uqxR7U=;
        b=OkgcXCM2yha4hGtWo5ZVz79LLvN3fLK8E93ZIehzNcJ2dnyfrUd6L1aZqF8ACstv8A
         xsYWC2qzMsCeocrrLX454Yg/0KD4Z1aV4u5cGmXJMQWF3AP3KzNciLrnrxn9zpA67Yp8
         yZdXVSKcWCCCRCcc4K8MNXUAp8kYlJag3kHfmIE1hKDPN0bBCU0zaloakq1OWHAEC8Wl
         23aTylk+pPJLlSNFwAKF3AApoxt2HYySqw7Y3Timh8oB+G9pnZBW5AMmbnw9pGzPG9Fh
         fGQ4lcfWRg21erHpf8FP7qBNUqqE/tqQEGwu95tHdRYvntRCF9Cg+RW6CPqAfJsk/pD9
         o58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720598266; x=1721203066;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vJHjCure8OpCwJZek8VCttLVkOx52+V7+aqk6uqxR7U=;
        b=qjTuEUdt+go+m55vFlDINwRD2mg7mw34iR+Z3pFHDYlmX6zOblAZ3qKKtIIP7GtswB
         0GZqRrm2n+pAw3/Uvd1jq3zC2KHyw5EbRKGahTxbGjF6qva4AKjX3F0vivn5J9TiIiVO
         4mVa8tnQN5UshrIsdBFABW6BZAnxURjLiNnhRJaCDed/yOKKW6Ammt/FgfsO50BE3Z4D
         LH9Z+gYXqWKOyZnOY54AKyQIgnJzMjWJSzUrL0+zhDAiyJUqZsrXMqVt6uPQ17v+CjOC
         yebvMwVxKp4bhVymryiW36gORayNEbKh493qE9DGIGZ5gfQ69dg4p8D9QzQUFkNY5cwg
         8v6A==
X-Gm-Message-State: AOJu0YxPR9mTGdBzXH5o4LjYp2F979t9FinrTRv9u9om5oLsJmitftE4
	hkkBCNK0StpFkxXak5DwdfmEB0qJGKQPd+D9chOc2Jwnnhl9hcNz
X-Google-Smtp-Source: AGHT+IHOA+tqGTGqNSXr9DkuWMXJbkrr+vOFfIsC/2VU/dn+msmfkUwlwA0e0cOOwwc+hdgyn1jrPA==
X-Received: by 2002:a05:6a00:23c6:b0:705:c029:c9a7 with SMTP id d2e1a72fcca58-70b4357d888mr5594601b3a.15.1720598265525;
        Wed, 10 Jul 2024 00:57:45 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439678c3sm3099073b3a.127.2024.07.10.00.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 00:57:45 -0700 (PDT)
Message-ID: <de4ed737e56fc6288031191509acc590446f4d24.camel@gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  puranjay@kernel.org, jose.marchesi@oracle.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jul 2024 00:57:40 -0700
In-Reply-To: <CAEf4BzY00fv1+13rZHb+5YHdXcwPzYjNDnN3Rq0-o+cwSB=JFw@mail.gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
	 <20240704102402.1644916-3-eddyz87@gmail.com>
	 <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com>
	 <7ec55e40e50fd432ba2c5d344c4927ed3a5ab953.camel@gmail.com>
	 <CAEf4BzY00fv1+13rZHb+5YHdXcwPzYjNDnN3Rq0-o+cwSB=JFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 23:01 -0700, Andrii Nakryiko wrote:

[...]

> > Right, it should be '<', my bad, will update the comment.
>=20
> See, I do read comments ;)

Yes, sorry about that remark.

[...]

> > > > +/* See comment for mark_nocsr_pattern_for_call() */
> > > > +static void check_nocsr_stack_contract(struct bpf_verifier_env *en=
v, struct bpf_func_state *state,
> > > > +                                      int insn_idx, int off)
> > > > +{
> > > > +       struct bpf_subprog_info *subprog =3D &env->subprog_info[sta=
te->subprogno];
> > > > +       struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[insn_=
idx];
> > > > +
> > > > +       if (subprog->nocsr_stack_off <=3D off || aux->nocsr_pattern=
)
> > > > +               return;
> > >=20
> > > can helper call instruction go through this check? E.g., if we do
> > > bpf_probe_read_kernel() into stack slot, where do we check that that
> > > slot is not overlapping with nocsr spill/fill region?
> >=20
> > In check_helper_call() we do check_mem_access() that eventually calls
> > one of the check_stack_{read,write}_{fixed,varying}_off().
> > The .access_size should be set for bpf_probe_read_kernel()
> > because it's argument base type is ARG_PTR_TO_MEM.
> > I will add a test case to double-check this.
>=20
> Ok. Also as I was reading this I didn't yet realize that
> aux->nocsr_pattern is not set for call instruction itself, so I was
> worried that we might accidentally skip the check. But we don't set
> nocsr_pattern for call, so we should be good (but the test never
> hurts)

Well yes, there is a flag check, but call to bpf_probe_read_kernel()
touching candidate nocsr stack address should disable nocsr rewrites
for current subprogram.

[...]

> > > > +static u32 call_csr_mask(struct bpf_verifier_env *env, struct bpf_=
insn *insn)
> > >=20
> > > you use u8 for get_helper_reg_mask() and u32 here, why not keep them =
consistent?
> >=20
> > Ok
> >=20
> > > similar to the naming nit above, I think we should be a bit more
> > > explicit with what "mask" actually means. Is this also clobber mask?
> >=20
> > I mean, there is a comment right above the function.
> > This function returns a mask of caller saved registers (csr).
> > I'll make the name more explicit.
> >=20
> > >=20
> > > > +{
> > > > +       const struct bpf_func_proto *fn;
> > > > +
> > > > +       if (bpf_helper_call(insn) &&
> > > > +           (verifier_inlines_helper_call(env, insn->imm) || bpf_ji=
t_inlines_helper_call(insn->imm)) &&
> > > > +           get_helper_proto(env, insn->imm, &fn) =3D=3D 0 &&
> > > > +           fn->allow_nocsr)
> > > > +               return ~get_helper_reg_mask(fn);
> > >=20
> > > hm... I'm a bit confused why we do a negation here? aren't we working
> > > with clobbering mask... I'll keep reading for now.
> >=20
> > Please read the comment before the function.
> >=20
>=20
> Believe it or not, but I read it like 10 times and that didn't help me mu=
ch.
>=20
> +/* If 'insn' is a call that follows no_caller_saved_registers contract
> + * and called function is inlined by current jit or verifier,
> + * return a mask with 1s corresponding to registers that are scratched
> + * by this call (depends on return type and number of return parameters)=
.
> + * Otherwise return ALL_CALLER_SAVED_REGS mask.
>=20
> "registers that are scratched by this call" would be what
> get_helper_reg_mask() returns for the function (at least that's my
> reading of the above), and yet you return inverted mask. It doesn't
> really help that we return ALL_CALLER_SAVED_REGS as "nope, it's not
> nocsr call".

I see, I messed up the comment...

> Maybe it would be a bit easier to follow if call_csr_mask() returned
> bool and mask as an out parameter in case it's nocsr call. So instead
> of special casing ALL_CALLER_SAVED_REGS there would be a nice "not a
> nocsr, never mind" and early exit.

Out parameter seems to be an overkill. I'll change names a little bit
to make it easier to follow. If for v3 you'd still think that out
parameter is better I'll switch then.

> Anyways, perhaps I'm just being very dense here, I just found this
> particular piece extremely hard to follow intuitively.
>=20
> > >=20
> > > > +
> > > > +       return ALL_CALLER_SAVED_REGS;
> > > > +}
> >=20
> > [...]
> >=20
> > > > +static void mark_nocsr_pattern_for_call(struct bpf_verifier_env *e=
nv, int t)
> > > > +{
> > > > +       struct bpf_insn *insns =3D env->prog->insnsi, *stx, *ldx;
> > > > +       struct bpf_subprog_info *subprog;
> > > > +       u32 csr_mask =3D call_csr_mask(env, &insns[t]);
> > > > +       u32 reg_mask =3D ~csr_mask | ~ALL_CALLER_SAVED_REGS;
> > >=20
> > > tbh, I'm lost with all these bitmask and their inversions...
> > > call_csr_mask()'s result is basically always used inverted, so why no=
t
> > > return inverted mask in the first place?
> >=20
> > The mask is initialized as a set of all registers preserved by this cal=
l.
>=20
> ok, maybe it's just a mix of "no csr" and "csr" that confuses me. How
> about we call call_csr_mask as get_helper_preserved_mask() or
> something like that to "match" get_helper_clobber_mask()?

Yes, these two names are good, thank you.
I'd still call it get_call_preserved_mask() as kfuncs might be added
at some point.

> > Those that are not in mask need a spill/fill pair.
> > I'll toss things around to make this more clear.
> > (naming, comments, maybe move the '| ~ALL_CALLER_SAVED_REGS' to the cal=
l_csr_mask()).
> >=20
> > >=20
> > > > +       int s, i;
> > > > +       s16 off;
> > > > +
> > > > +       if (csr_mask =3D=3D ALL_CALLER_SAVED_REGS)
> > > > +               return;
> > > > +
> > > > +       for (i =3D 1, off =3D 0; i <=3D ARRAY_SIZE(caller_saved); +=
+i, off +=3D BPF_REG_SIZE) {
> > > > +               if (t - i < 0 || t + i >=3D env->prog->len)
> > > > +                       break;
> > > > +               stx =3D &insns[t - i];
> > > > +               ldx =3D &insns[t + i];
> > > > +               if (off =3D=3D 0) {
> > > > +                       off =3D stx->off;
> > > > +                       if (off % BPF_REG_SIZE !=3D 0)
> > > > +                               break;
> > >=20
> > > kind of ugly that we assume stx before we actually checked that it's
> > > STX?... maybe split humongous if below into instruction checking
> > > (with code and src_reg) and then off checking separately?
> >=20
> > Don't see anything ugly about this, tbh.
>=20
> you are using stx->off and do `% BPF_REG_SIZE` check on it while that
> stx->off field might be meaningless for the instruction (because we
> are not yet sure it's STX instruction), that's a bit ugly, IMO

I can rewrite it like below:

		if (stx->code !=3D (BPF_STX | BPF_MEM | BPF_DW) ||
		    ldx->code !=3D (BPF_LDX | BPF_MEM | BPF_DW))
			break;
		off =3D off !=3D 0 ?: stx->off; // or use full 'if' block from the old ve=
rsion
		if (stx->dst_reg !=3D BPF_REG_10 ||
		    ldx->src_reg !=3D BPF_REG_10 ||
		    /* check spill/fill for the same reg and offset */
		    stx->src_reg !=3D ldx->dst_reg ||
		    stx->off !=3D ldx->off ||
		    stx->off !=3D off ||
		    (off % BPF_REG_SIZE) !=3D 0 ||
		    /* this should be a previously unseen register */
		    (BIT(stx->src_reg) & reg_mask))
			break;

But I'm not sure this adds any actual clarity.

>=20
> > Can split the 'if' statement, if you think it's hard to read.
>=20
> it's not about readability for me
>=20
> >=20
> > >=20
> > > > +               }
> > > > +               if (/* *(u64 *)(r10 - off) =3D r[0-5]? */
> > > > +                   stx->code !=3D (BPF_STX | BPF_MEM | BPF_DW) ||
> > > > +                   stx->dst_reg !=3D BPF_REG_10 ||
> > > > +                   /* r[0-5] =3D *(u64 *)(r10 - off)? */
> > > > +                   ldx->code !=3D (BPF_LDX | BPF_MEM | BPF_DW) ||
> > > > +                   ldx->src_reg !=3D BPF_REG_10 ||
> > > > +                   /* check spill/fill for the same reg and offset=
 */
> > > > +                   stx->src_reg !=3D ldx->dst_reg ||
> > > > +                   stx->off !=3D ldx->off ||
> > > > +                   stx->off !=3D off ||
> > > > +                   /* this should be a previously unseen register =
*/
> > > > +                   BIT(stx->src_reg) & reg_mask)
> > >=20
> > > () around & operation?
> >=20
> > No need, & has higher priority over ||.
> > You can check the AST using
> > https://tree-sitter.github.io/tree-sitter/playground .
>=20
> Oh, I have no doubt you checked that it works correctly. It's just not
> a really good habit to rely on C's obscure operation ordering rules
> beyond A && B || C (and even then it is arguable). I think the rule of
> thumb to not mix bitwise and logic operators without explicit
> parenthesis makes sense.
>=20
> But never mind, I already feel weird complaining about !strcmp(),
> every real kernel engineer should memorize operator precedence by
> heart.

I assumed you implied incorrect evaluation order.
Will add parenthesis.

> > > > +                       break;
> > > > +               reg_mask |=3D BIT(stx->src_reg);
> > > > +               env->insn_aux_data[t - i].nocsr_pattern =3D 1;
> > > > +               env->insn_aux_data[t + i].nocsr_pattern =3D 1;
> > > > +       }
> > > > +       if (i =3D=3D 1)
> > > > +               return;
> > > > +       env->insn_aux_data[t].nocsr_spills_num =3D i - 1;
> > > > +       s =3D find_containing_subprog(env, t);
> > > > +       /* can't happen */
[...]
> > > > +       if (WARN_ON_ONCE(s < 0))
> > > > +               return;
> > > > +       subprog =3D &env->subprog_info[s];
> > > > +       subprog->nocsr_stack_off =3D min(subprog->nocsr_stack_off, =
off);
> > >=20
> > > should this be max()? offsets are negative, right? so if nocsr uses -=
8
> > > and -16 as in the example, entire [-16, 0) region is nocsr region
> >=20
> > This should be min exactly because stack offsets are negative.
> > For the example above the 'off' is initialized as -16 and then
> > is incremented by +8 giving final value of -8.
> > And I need to select the minimal value used between several patterns.
>=20
> so let's say I have two nocsr calls in the same subprog
>=20
>     *(u64 *)(r10 - 8)  =3D r1;
>     *(u64 *)(r10 - 16) =3D r2;
>     call %[to_be_inlined]
>     r2 =3D *(u64 *)(r10 - 16);
>     r1 =3D *(u64 *)(r10 - 8);
>=20
>=20
> and then a bit later
>=20
>=20
>     *(u64 *)(r10 - 16)  =3D r1;
>     *(u64 *)(r10 - 24) =3D r2;
>     call %[to_be_inlined]
>     r2 =3D *(u64 *)(r10 - 24);
>     r1 =3D *(u64 *)(r10 - 16);
>=20
>=20
> For the first chunk nocsr range is [-16, 0). For the second it's [-24,
> -8), right?
> Should `*(u64 *)(r10 - 8) =3D 123` somewhere in that subprog (not for
> nocsr calls) invalidate this whole nocsr thing? With min you'll
> basically have [-24, -8) as nocsr-reserved region, but shouldn't it be
> whole [-24, 0)?
>=20
> Clang shouldn't generate such inconsistent offset, right? But it's
> legal, no? And if not, then all the calls should use the same upper
> stack boundary and we shouldn't be doing min/max, but rather checking
> that they are all consistent.
>=20
> Or what am I missing again?

You don't miss anything.

With the current algorithm first call will not be rewritten because of
the offset check in do_misc_fixups().
The second call would be rewritten and this is safe to do, because
verifier knows that range [-24,-8) is only used by nocsr patterns.
What you suggest is slightly more pessimistic, compared to current
algorithm.

[...]

> > > > +
> > > > +                       /* apply the rewrite:
> > > > +                        *   *(u64 *)(r10 - X) =3D rY ; num-times
> > > > +                        *   call()                               -=
> call()
> > > > +                        *   rY =3D *(u64 *)(r10 - X) ; num-times
> > > > +                        */
> > > > +                       err =3D verifier_remove_insns(env, i + delt=
a - spills_num, spills_num);
> > > > +                       if (err)
> > > > +                               return err;
> > > > +                       err =3D verifier_remove_insns(env, i + delt=
a - spills_num + 1, spills_num);
> > > > +                       if (err)
> > > > +                               return err;
> > >=20
> > > why not a single bpf_patch_insn_data()?
> >=20
> > bpf_patch_insn_data() assumes that one instruction has to be replaced w=
ith many.
> > Here I need to replace many instructions with a single instruction.
> > I'd prefer not to tweak bpf_patch_insn_data() for this patch-set.
>=20
> ah, bpf_patch_insn_data just does bpf_patch_insn_single, somehow I
> thought that it does range for range replacement of instructions.
> Never mind then (it's a bit sad that we don't have a proper flexible
> and powerful patching primitive, though, but oh well).

That is true.
I'll think about it once other issues with this patch-set are resolved.

[...]

> > > > +
> > > > +                       i +=3D spills_num - 1;
> > > > +                       /*   ^            ^   do a second visit of =
this instruction,
> > > > +                        *   |            '-- so that verifier can =
inline it
> > > > +                        *   '--------------- jump over deleted fil=
ls
> > > > +                        */
> > > > +                       delta -=3D 2 * spills_num;
> > > > +                       insn =3D env->prog->insnsi + i + delta;
> > > > +                       goto next_insn;
> > >=20
> > > why not adjust the state and just fall through, what goto next_insn
> > > does that we can't (and next instruction is misleading, so I'd rather
> > > fix up and move forward)
> >=20
> > I don't like this. The fall-through makes control flow more convoluted.
> > To understand what would happen next:
> > - with goto next_insn we just start over;
> > - with fall-through we need to think about position of this particular
> >   'if' statement within the loop.
> >=20
>=20
> Alright, it's fine. Though I don't see anything wrong with knowing
> that we patch up nocsr pattern before we do inlining of calls. And
> yes, order is important, so what? I always assumed that the order of
> operations in do_misc_fixups() is not arbitrary.

On a second thought maybe fall-through is not that bad.

[...]

