Return-Path: <bpf+bounces-34347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A4992C8C8
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 05:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D3C1F23ABE
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 03:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7AE168D0;
	Wed, 10 Jul 2024 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw3VjTiz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C310E6
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580417; cv=none; b=WW0bgHQ6fpSPtQ3wjpVOUXbtqWpHfB3phSGc1s9accju27qmfLI8T6UKm87lKBjEGs5YSEjPG0pG2tDtew6DFh67VgYw1s41V8adXAhItH/vn6z3GIaoUvewW0IqTkwWNLHrFW3JUHyWwyjbp8FBwjdM5droKonUjrb3IQkYOAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580417; c=relaxed/simple;
	bh=u7d4+/0V6L43TX0sdiPjprrqOvyMk8jEHgUB7eRoTgo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FgYrRY6I6gFD63eF7kQSQKgVy+2hjAgkSZ8PgHBhLY9eltXXOPgIYWUJiAwm9fFp2paOh+uEl0uVZlbZwFFovH241x+a3zMNx+dhhYOWWPYWcFxicfLJiqJR91m9MZAWWO5ET54pk46yfWhyjZSYTtwHr4F/8qmsrxEXspSDpAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw3VjTiz; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-75c3afd7a50so3067586a12.2
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 20:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720580415; x=1721185215; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Upxqw4X8H3FJs1/ONM9vjas406GEnIa44nsM41AcII0=;
        b=bw3VjTizcSDpbGDXKymnp8PuwhDuz2pFkNI0nWfbjiDzfkvk3qePExV+/7WcqinCgS
         o6MkMshqaNz8bO1F130rceYuFlVUvS8hYpMWp+MvOqhx/4on8qaLvjbcUMpNocQpNGZI
         z+f66nUvFIrnPu1+lh8B7Ac5O1Gnv0cTrR6S0096hk4tU7dSMbEnYSnVp9++nKEno2wU
         v1LmZsQVwKE78DJIRoE3oxn0U3pRdYV2ShSfT5EoQXhym9sUFl6yc0G9ZX0HQELabEIg
         LdG9fZ3d80xGAndzZb/hJhIcZk5TI/73gp7upmK4UYcbxrWgpHaTEZMAWH95Gducq+Mc
         F2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720580415; x=1721185215;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Upxqw4X8H3FJs1/ONM9vjas406GEnIa44nsM41AcII0=;
        b=bWUle3Y3DabBV+0srqJ3LtTmGTSAUIpAYTH5Ax1ZMJCeFJzyAda1KjxB5Cmm9cPbp1
         i4l1/0KiQe8Wl4k1GEZ4KUvtZE+D4E5PvazciTxeBP5sxYa2HJl+FbwGk/XVtMIe4NLJ
         2FFCdbxS7iCGlFjWXsCqAaQPylP0xKztVvhO5sttX5JErDRjRGnoRp1bg3Iwl+COi94g
         KbYZ+om1YiYO6gXyWZY3lzKHJMF5DbpGj1aVl/mnOYVWUnuoThyQuz81MGS+1gHETy6Z
         nwL9dYZ7UJHxepx6oSEk8MeQj8KZF411n4n5Qkb53Ten6AYmRmZtSImHdcjhCKx7TYAl
         BQWg==
X-Gm-Message-State: AOJu0YwRzZrUrRYIFKJKZs7FkvZEFw8SkNW1TeUdzPql7zr01UG5LfPJ
	oOnvmGd/+Y/eeQIU3lRwpUhafEfIiCSHbzKRdJJK2BhwjXoTkAka
X-Google-Smtp-Source: AGHT+IG68HoIYnidPm7R3685iJ1b5D0jTpyeO+vzUWQVhtGB8cTWKuzRpaJ5j5W8iGsGCXop4ZG9Fw==
X-Received: by 2002:a05:6a20:258f:b0:1c0:d9c9:64f9 with SMTP id adf61e73a8af0-1c298243af3mr4520593637.36.1720580414367;
        Tue, 09 Jul 2024 20:00:14 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad5640sm22885315ad.309.2024.07.09.20.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 20:00:13 -0700 (PDT)
Message-ID: <7ec55e40e50fd432ba2c5d344c4927ed3a5ab953.camel@gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  puranjay@kernel.org, jose.marchesi@oracle.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 09 Jul 2024 20:00:08 -0700
In-Reply-To: <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
	 <20240704102402.1644916-3-eddyz87@gmail.com>
	 <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 16:42 -0700, Andrii Nakryiko wrote:

[...]

> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 2b54e25d2364..735ae0901b3d 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -585,6 +585,15 @@ struct bpf_insn_aux_data {
> >          * accepts callback function as a parameter.
> >          */
> >         bool calls_callback;
> > +       /* true if STX or LDX instruction is a part of a spill/fill
> > +        * pattern for a no_caller_saved_registers call.
> > +        */
> > +       u8 nocsr_pattern:1;
> > +       /* for CALL instructions, a number of spill/fill pairs in the
> > +        * no_caller_saved_registers pattern.
> > +        */
> > +       u8 nocsr_spills_num:3;
>=20
> despite bitfields this will extend bpf_insn_aux_data by 8 bytes. there
> are 2 bytes of padding after alu_state, let's put this there.
>=20
> And let's not add bitfields unless absolutely necessary (this can be
> always done later).

Will remove the bitfields and move the fields.

>=20
> > +
> >  };
> >=20
> >  #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF pr=
ogram */
> > @@ -641,6 +650,11 @@ struct bpf_subprog_info {
> >         u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
> >         u16 stack_depth; /* max. stack depth used by this function */
> >         u16 stack_extra;
> > +       /* stack depth after which slots reserved for
> > +        * no_caller_saved_registers spills/fills start,
> > +        * value <=3D nocsr_stack_off belongs to the spill/fill area.
>=20
> are you sure about <=3D (not <), it seems like nocsr_stack_off is
> exclusive right bound for nocsr stack region (it would be good to call
> this out explicitly here)

Right, it should be '<', my bad, will update the comment.

>=20
> > +        */
> > +       s16 nocsr_stack_off;
> >         bool has_tail_call: 1;
> >         bool tail_call_reachable: 1;
> >         bool has_ld_abs: 1;
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 4869f1fb0a42..d16a249b59ad 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2471,16 +2471,37 @@ static int cmp_subprogs(const void *a, const vo=
id *b)
> >                ((struct bpf_subprog_info *)b)->start;
> >  }
> >=20
> > -static int find_subprog(struct bpf_verifier_env *env, int off)
> > +/* Find subprogram that contains instruction at 'off' */
> > +static int find_containing_subprog(struct bpf_verifier_env *env, int o=
ff)
> >  {
> > -       struct bpf_subprog_info *p;
> > +       struct bpf_subprog_info *vals =3D env->subprog_info;
> > +       int l, r, m;
> >=20
> > -       p =3D bsearch(&off, env->subprog_info, env->subprog_cnt,
> > -                   sizeof(env->subprog_info[0]), cmp_subprogs);
> > -       if (!p)
> > +       if (off >=3D env->prog->len || off < 0 || env->subprog_cnt =3D=
=3D 0)
> >                 return -ENOENT;
> > -       return p - env->subprog_info;
> >=20
> > +       l =3D 0;
> > +       m =3D 0;
>=20
> no need to initialize m

Ok

>=20
> > +       r =3D env->subprog_cnt - 1;
> > +       while (l < r) {
> > +               m =3D l + (r - l + 1) / 2;
> > +               if (vals[m].start <=3D off)
> > +                       l =3D m;
> > +               else
> > +                       r =3D m - 1;
> > +       }
> > +       return l;
> > +}
>=20
> I love it, looks great :)
>

Agree

[...]

> > @@ -4501,6 +4522,23 @@ static int get_reg_width(struct bpf_reg_state *r=
eg)
> >         return fls64(reg->umax_value);
> >  }
> >=20
> > +/* See comment for mark_nocsr_pattern_for_call() */
> > +static void check_nocsr_stack_contract(struct bpf_verifier_env *env, s=
truct bpf_func_state *state,
> > +                                      int insn_idx, int off)
> > +{
> > +       struct bpf_subprog_info *subprog =3D &env->subprog_info[state->=
subprogno];
> > +       struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[insn_idx]=
;
> > +
> > +       if (subprog->nocsr_stack_off <=3D off || aux->nocsr_pattern)
> > +               return;
>=20
> can helper call instruction go through this check? E.g., if we do
> bpf_probe_read_kernel() into stack slot, where do we check that that
> slot is not overlapping with nocsr spill/fill region?

In check_helper_call() we do check_mem_access() that eventually calls
one of the check_stack_{read,write}_{fixed,varying}_off().
The .access_size should be set for bpf_probe_read_kernel()
because it's argument base type is ARG_PTR_TO_MEM.
I will add a test case to double-check this.

[...]

> > @@ -15951,6 +15993,206 @@ static int visit_func_call_insn(int t, struct=
 bpf_insn *insns,
> >         return ret;
> >  }
> >=20
> > +/* Bitmask with 1s for all caller saved registers */
> > +#define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
> > +
> > +/* Return a bitmask specifying which caller saved registers are
> > + * modified by a call to a helper.
> > + * (Either as a return value or as scratch registers).
> > + *
> > + * For normal helpers registers R0-R5 are scratched.
> > + * For helpers marked as no_csr:
> > + * - scratch R0 if function is non-void;
> > + * - scratch R1-R5 if corresponding parameter type is set
> > + *   in the function prototype.
> > + */
> > +static u8 get_helper_reg_mask(const struct bpf_func_proto *fn)
>=20
> suggestion: to make this less confusing, here we are returning a mask
> of registers that are clobbered by the helper, is that right? so
> get_helper_clobber_mask() maybe?

get_helper_clobber_mask() is a good name, will change.

[...]

> > +/* If 'insn' is a call that follows no_caller_saved_registers contract
> > + * and called function is inlined by current jit or verifier,
> > + * return a mask with 1s corresponding to registers that are scratched
> > + * by this call (depends on return type and number of return parameter=
s).
>=20
> return parameters? was it supposed to be "function parameters/arguments"?

My bad.

>=20
> > + * Otherwise return ALL_CALLER_SAVED_REGS mask.
> > + */
> > +static u32 call_csr_mask(struct bpf_verifier_env *env, struct bpf_insn=
 *insn)
>=20
> you use u8 for get_helper_reg_mask() and u32 here, why not keep them cons=
istent?

Ok

> similar to the naming nit above, I think we should be a bit more
> explicit with what "mask" actually means. Is this also clobber mask?

I mean, there is a comment right above the function.
This function returns a mask of caller saved registers (csr).
I'll make the name more explicit.

>=20
> > +{
> > +       const struct bpf_func_proto *fn;
> > +
> > +       if (bpf_helper_call(insn) &&
> > +           (verifier_inlines_helper_call(env, insn->imm) || bpf_jit_in=
lines_helper_call(insn->imm)) &&
> > +           get_helper_proto(env, insn->imm, &fn) =3D=3D 0 &&
> > +           fn->allow_nocsr)
> > +               return ~get_helper_reg_mask(fn);
>=20
> hm... I'm a bit confused why we do a negation here? aren't we working
> with clobbering mask... I'll keep reading for now.

Please read the comment before the function.

>=20
> > +
> > +       return ALL_CALLER_SAVED_REGS;
> > +}

[...]

> > +static void mark_nocsr_pattern_for_call(struct bpf_verifier_env *env, =
int t)
>=20
> t is insn_idx, let's not carry over old crufty check_cfg naming

Ok

>=20
> > +{
> > +       struct bpf_insn *insns =3D env->prog->insnsi, *stx, *ldx;
> > +       struct bpf_subprog_info *subprog;
> > +       u32 csr_mask =3D call_csr_mask(env, &insns[t]);
> > +       u32 reg_mask =3D ~csr_mask | ~ALL_CALLER_SAVED_REGS;
>=20
> tbh, I'm lost with all these bitmask and their inversions...
> call_csr_mask()'s result is basically always used inverted, so why not
> return inverted mask in the first place?

The mask is initialized as a set of all registers preserved by this call.
Those that are not in mask need a spill/fill pair.
I'll toss things around to make this more clear.
(naming, comments, maybe move the '| ~ALL_CALLER_SAVED_REGS' to the call_cs=
r_mask()).

>=20
> > +       int s, i;
> > +       s16 off;
> > +
> > +       if (csr_mask =3D=3D ALL_CALLER_SAVED_REGS)
> > +               return;
> > +
> > +       for (i =3D 1, off =3D 0; i <=3D ARRAY_SIZE(caller_saved); ++i, =
off +=3D BPF_REG_SIZE) {
> > +               if (t - i < 0 || t + i >=3D env->prog->len)
> > +                       break;
> > +               stx =3D &insns[t - i];
> > +               ldx =3D &insns[t + i];
> > +               if (off =3D=3D 0) {
> > +                       off =3D stx->off;
> > +                       if (off % BPF_REG_SIZE !=3D 0)
> > +                               break;
>=20
> kind of ugly that we assume stx before we actually checked that it's
> STX?... maybe split humongous if below into instruction checking
> (with code and src_reg) and then off checking separately?

Don't see anything ugly about this, tbh.
Can split the 'if' statement, if you think it's hard to read.

>=20
> > +               }
> > +               if (/* *(u64 *)(r10 - off) =3D r[0-5]? */
> > +                   stx->code !=3D (BPF_STX | BPF_MEM | BPF_DW) ||
> > +                   stx->dst_reg !=3D BPF_REG_10 ||
> > +                   /* r[0-5] =3D *(u64 *)(r10 - off)? */
> > +                   ldx->code !=3D (BPF_LDX | BPF_MEM | BPF_DW) ||
> > +                   ldx->src_reg !=3D BPF_REG_10 ||
> > +                   /* check spill/fill for the same reg and offset */
> > +                   stx->src_reg !=3D ldx->dst_reg ||
> > +                   stx->off !=3D ldx->off ||
> > +                   stx->off !=3D off ||
> > +                   /* this should be a previously unseen register */
> > +                   BIT(stx->src_reg) & reg_mask)
>=20
> () around & operation?

No need, & has higher priority over ||.
You can check the AST using
https://tree-sitter.github.io/tree-sitter/playground .

>=20
> > +                       break;
> > +               reg_mask |=3D BIT(stx->src_reg);
> > +               env->insn_aux_data[t - i].nocsr_pattern =3D 1;
> > +               env->insn_aux_data[t + i].nocsr_pattern =3D 1;
> > +       }
> > +       if (i =3D=3D 1)
> > +               return;
> > +       env->insn_aux_data[t].nocsr_spills_num =3D i - 1;
> > +       s =3D find_containing_subprog(env, t);
> > +       /* can't happen */
>=20
> then don't check ;) we leave the state partially set for CSR but not
> quite. We either should error out completely or just assume
> correctness of find_containing_subprog, IMO

Ok

>=20
> > +       if (WARN_ON_ONCE(s < 0))
> > +               return;
> > +       subprog =3D &env->subprog_info[s];
> > +       subprog->nocsr_stack_off =3D min(subprog->nocsr_stack_off, off)=
;
>=20
> should this be max()? offsets are negative, right? so if nocsr uses -8
> and -16 as in the example, entire [-16, 0) region is nocsr region

This should be min exactly because stack offsets are negative.
For the example above the 'off' is initialized as -16 and then
is incremented by +8 giving final value of -8.
And I need to select the minimal value used between several patterns.

>=20
> > +}

[...]

> > @@ -20119,6 +20361,48 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >                         goto next_insn;
> >                 if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> >                         goto next_insn;
> > +               /* Remove unnecessary spill/fill pairs, members of nocs=
r pattern */
> > +               if (env->insn_aux_data[i + delta].nocsr_spills_num > 0)=
 {
> > +                       u32 j, spills_num =3D env->insn_aux_data[i + de=
lta].nocsr_spills_num;
> > +                       int err;
> > +
> > +                       /* don't apply this on a second visit */
> > +                       env->insn_aux_data[i + delta].nocsr_spills_num =
=3D 0;
> > +
> > +                       /* check if spill/fill stack access is in expec=
ted offset range */
> > +                       for (j =3D 1; j <=3D spills_num; ++j) {
> > +                               if ((insn - j)->off >=3D subprogs[cur_s=
ubprog].nocsr_stack_off ||
> > +                                   (insn + j)->off >=3D subprogs[cur_s=
ubprog].nocsr_stack_off) {
> > +                                       /* do a second visit of this in=
struction,
> > +                                        * so that verifier can inline =
it
> > +                                        */
> > +                                       i -=3D 1;
> > +                                       insn -=3D 1;
> > +                                       goto next_insn;
> > +                               }
> > +                       }
>=20
> I don't get this loop, can you elaborate? Why are we double-checking
> anything here, didn't we do this already?

We established probable patterns and probable minimal offset.
Over the course of program verification we might have invalidated the
.nocsr_stack_off for a particular subprogram =3D> hence a need for this che=
ck.

>=20
> > +
> > +                       /* apply the rewrite:
> > +                        *   *(u64 *)(r10 - X) =3D rY ; num-times
> > +                        *   call()                               -> ca=
ll()
> > +                        *   rY =3D *(u64 *)(r10 - X) ; num-times
> > +                        */
> > +                       err =3D verifier_remove_insns(env, i + delta - =
spills_num, spills_num);
> > +                       if (err)
> > +                               return err;
> > +                       err =3D verifier_remove_insns(env, i + delta - =
spills_num + 1, spills_num);
> > +                       if (err)
> > +                               return err;
>=20
> why not a single bpf_patch_insn_data()?

bpf_patch_insn_data() assumes that one instruction has to be replaced with =
many.
Here I need to replace many instructions with a single instruction.
I'd prefer not to tweak bpf_patch_insn_data() for this patch-set.

On the other hand, the do_jit() for x86 removes NOPs (BPF_JA +0),
so I can probably replace spills/fills with NOPs here instead of
calling bpf_patch_insn_data() or bpf_remove_insns().

> > +
> > +                       i +=3D spills_num - 1;
> > +                       /*   ^            ^   do a second visit of this=
 instruction,
> > +                        *   |            '-- so that verifier can inli=
ne it
> > +                        *   '--------------- jump over deleted fills
> > +                        */
> > +                       delta -=3D 2 * spills_num;
> > +                       insn =3D env->prog->insnsi + i + delta;
> > +                       goto next_insn;
>=20
> why not adjust the state and just fall through, what goto next_insn
> does that we can't (and next instruction is misleading, so I'd rather
> fix up and move forward)

I don't like this. The fall-through makes control flow more convoluted.
To understand what would happen next:
- with goto next_insn we just start over;
- with fall-through we need to think about position of this particular
  'if' statement within the loop.

>=20
> > +               }
> >                 if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
> >                         ret =3D fixup_kfunc_call(env, insn, insn_buf, i=
 + delta, &cnt);
> >                         if (ret)

[...]

