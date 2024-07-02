Return-Path: <bpf+bounces-33664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4756292496E
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94746B2373F
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 20:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3429201242;
	Tue,  2 Jul 2024 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+WuoE1x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34951CF8F
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719952732; cv=none; b=TBuC7wWklhQaU0Qo5RrVuxt+pi3SLHc7xqq+wqIGDKUvwl907PoM8+T9HLRhGZpPkOxWfnKbym99q1QZXp4Wdh7kegibzn56I82oqXwDy0W1laHYun0IL5xjFUZcNBZHPF0D6/vpgVmJypRgHv0SiyzF5yZZ/FHMXwyp0HCn9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719952732; c=relaxed/simple;
	bh=yiF55bnQvm4hqyVEZYcXqZM49p8+/wO6Ss8OegviHAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rbS48jxXZh5p1VFPSapIziHShIsQL39Sza2gNkgKdAbQGwsymM5rDVD5x5jAft1U+s+FS7Rp5eKUSfdPxPksCcZwPjyBT6VvV3J2Yk2jLY2yrRiOVQrOeJ5fLPCeEUcU6Z2V5HcVOaI4mJsRFl1FN5gjMVLL4Q3cRu+rqZbYJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+WuoE1x; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3817084f7dbso2888905ab.2
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719952730; x=1720557530; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5M6JJ5iEY8lB8a5dblze80zXZOO65HOHQw3QCcw9BXc=;
        b=W+WuoE1xnrn34YLnUGyCBsKrcBfIjacLsAQ5zbTVzQUH+6TTJqh+4uqzR5bnyI20SH
         isXFbLHN8DLAbgFW84XHWzMNiJQkxyVVJ1n3LZyIGC6Ca0uw49d4OtHVd32HFC2+Tm/C
         27AJROdxUUIXW9cB4Nymb8qfg2LL73VVioBVAiLIZhZyhRUIKmSZ1Qr/gQEs55mEI//V
         PjVOVhM5VVfTIvboKjzhmggheIxvjt6XTgK2JBV1cPjCc7wRvhfy/hB5YGwDAVbOm7O8
         bVhGizGd/AaGA5j3D7lm9h2slTEbXU8bK5S25jnrQ9VB3xF9KyfSLgHfJt3crkJezNY8
         psLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719952730; x=1720557530;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5M6JJ5iEY8lB8a5dblze80zXZOO65HOHQw3QCcw9BXc=;
        b=RfwfKXJQXWsCYG9CsHayK4nvWmsHooU8qwYOfafvqvyR++rrdXtVE5KgxjEB41vrui
         VLd+B/s4AV66gRSHiGYTQnAKxphyZjhGSMCtDWfridHRTQ+yqbaEHRX8sdNyNe2C8Idj
         scO/5R4IJLnzpbY1JdCVA8RPgOxzvv7aJlI92NTZCIHGDJxbKsMzYDk27JqDCWWjIOBF
         IUx3TB0UI2e7HMR60+sMww2fE+SLKvVxni7A0aTG/OPwyvThAax4fGalHoCws0O3wfgb
         LbZxtFDd/P6sKOUTwrucGwai3eMSXTJV4tnzGPHTMVltZbrW+zLRwlbzg/Ud3i1KJT7t
         TbWg==
X-Gm-Message-State: AOJu0Yz//j/r1OpnxvUtZ/Hy8Eo5tzf99vsRsa0NB6rA4aG1rFk556th
	OVZebWIowX+qajOxNwuWX5xxVh/PE8ydk8LmklhmaMpfQN693U39
X-Google-Smtp-Source: AGHT+IGL1aC02P/iUmTvhN5jqbj7XUBQbnMb+5+Xaempuk89Mx884tOOPSXsN0o3Wwxwjpbw8t4QrA==
X-Received: by 2002:a05:6e02:1fc4:b0:374:9b99:752a with SMTP id e9e14a558f8ab-37cd19878f0mr115722875ab.14.1719952729862;
        Tue, 02 Jul 2024 13:38:49 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6d1f77bcsm7048639a12.79.2024.07.02.13.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 13:38:49 -0700 (PDT)
Message-ID: <806fe5b0940a8b3e60a9c5448ec213b23107e3f0.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 2/8] bpf: no_caller_saved_registers attribute
 for helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Date: Tue, 02 Jul 2024 13:38:44 -0700
In-Reply-To: <CAEf4Bzb5JoeVAwO6krQPUWHyUad0ya5ivXWukfb+_wrWrs7H5Q@mail.gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-3-eddyz87@gmail.com>
	 <CAEf4Bzb5JoeVAwO6krQPUWHyUad0ya5ivXWukfb+_wrWrs7H5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 17:41 -0700, Andrii Nakryiko wrote:

[...]

> > - clang generates a simple pattern for nocsr calls, e.g.:
> >=20
> >     r1 =3D 1;
> >     r2 =3D 2;
> >     *(u64 *)(r10 - 8)  =3D r1;
> >     *(u64 *)(r10 - 16) =3D r2;
> >     call %[to_be_inlined_by_jit]
>=20
> "inline_by_jit" is misleading, it can be inlined by BPF verifier using
> BPF instructions, not just by BPF JIT

Will change

> >     r2 =3D *(u64 *)(r10 - 16);
> >     r1 =3D *(u64 *)(r10 - 8);
> >     r0 =3D r1;
> >     r0 +=3D r2;
> >     exit;

[...]
>=20
> > -static int find_subprog(struct bpf_verifier_env *env, int off)
> > +/* Find subprogram that contains instruction at 'off' */
> > +static int find_containing_subprog(struct bpf_verifier_env *env, int o=
ff)
> >  {
> > -       struct bpf_subprog_info *p;
> > +       struct bpf_subprog_info *vals =3D env->subprog_info;
> > +       int high =3D env->subprog_cnt - 1;
> > +       int low =3D 0, ret =3D -ENOENT;
> >=20
> > -       p =3D bsearch(&off, env->subprog_info, env->subprog_cnt,
> > -                   sizeof(env->subprog_info[0]), cmp_subprogs);
> > -       if (!p)
> > +       if (off >=3D env->prog->len || off < 0)
> >                 return -ENOENT;
> > -       return p - env->subprog_info;
> >=20
> > +       while (low <=3D high) {
> > +               int mid =3D (low + high)/2;
>=20
> styling nit: (...) / 2
>=20
> > +               struct bpf_subprog_info *val =3D &vals[mid];
> > +               int diff =3D off - val->start;
> > +
> > +               if (diff < 0) {
>=20
> tbh, this hurts my brain. Why not write human-readable and more meaningfu=
l
>=20
> if (off < val->start)
>=20
> ?

No reason, will change.

> > +                       high =3D mid - 1;
> > +               } else {
> > +                       low =3D mid + 1;
> > +                       /* remember last time mid.start <=3D off */
> > +                       ret =3D mid;
> > +               }
>=20
> feel free to ignore, but I find this unnecessary `ret =3D mid` part a
> bit inelegant. See find_linfo in kernel/bpf/log.c for how
> lower_bound-like binary search could be implemented without this (I
> mean the pattern where invariant keeps low or high as always
> satisfying the condition and the other one being adjusted with +1 or
> -1, depending on desired logic).

Will steal the code from there, thank you.

[...]

> > +static u8 get_helper_reg_mask(const struct bpf_func_proto *fn)
> > +{
> > +       u8 mask;
> > +       int i;
> > +
> > +       if (!fn->nocsr)
> > +               return ALL_CALLER_SAVED_REGS;
> > +
> > +       mask =3D 0;
> > +       mask |=3D fn->ret_type =3D=3D RET_VOID ? 0 : BIT(BPF_REG_0);
> > +       for (i =3D 0; i < ARRAY_SIZE(fn->arg_type); ++i)
> > +               mask |=3D fn->arg_type[i] =3D=3D ARG_DONTCARE ? 0 : BIT=
(BPF_REG_1 + i);
>=20
> again subjective, but
>=20
> if (fn->ret_type !=3D RET_VOID)
>     mask |=3D BIT(BPF_REG_0);
>=20
> (and similarly for ARG_DONTCARE)
>=20
> seems a bit more readable and not that much more verbose

Sure, will change.

[...]

> > +static bool verifier_inlines_helper_call(struct bpf_verifier_env *env,=
 s32 imm)
> > +{
>=20
> note that there is now also bpf_jit_inlines_helper_call()

There is.
I'd like authors of jit inline patches to explicitly opt-in
for nocsr, vouching that inline patch follows nocsr contract.
The idea is that people would extend call_csr_mask() as necessary.

>=20
>=20
> > +       return false;
> > +}
> > +
> > +/* If 'insn' is a call that follows no_caller_saved_registers contract
> > + * and called function is inlined by current jit, return a mask with
> > + * 1s corresponding to registers that are scratched by this call
> > + * (depends on return type and number of return parameters).
> > + * Otherwise return ALL_CALLER_SAVED_REGS mask.
> > + */
> > +static u32 call_csr_mask(struct bpf_verifier_env *env, struct bpf_insn=
 *insn)
> > +{
> > +       const struct bpf_func_proto *fn;
> > +
> > +       if (bpf_helper_call(insn) &&
> > +           verifier_inlines_helper_call(env, insn->imm) &&
>=20
> strictly speaking, does nocsr have anything to do with inlining,
> though? E.g., if we know for sure (however, that's a separate issue)
> that helper implementation doesn't touch extra registers, why do we
> need inlining to make use of nocsr?

Technically, alternative for nocsr is for C version of the
helper/kfunc itself has no_caller_saved_registers attribute.
Grep shows a single function annotated as such in kernel tree:
stackleak_track_stack().
Or, maybe, for helpers/kfuncs implemented in assembly.
Whenever such helpers/kfuncs are added, this function could be extended.

>=20
> > +           get_helper_proto(env, insn->imm, &fn) =3D=3D 0 &&
> > +           fn->nocsr)
> > +               return ~get_helper_reg_mask(fn);
> > +
> > +       return ALL_CALLER_SAVED_REGS;
> > +}
> > +

[...]

> > +static int match_and_mark_nocsr_pattern(struct bpf_verifier_env *env, =
int t, bool mark)
> > +{
> > +       struct bpf_insn *insns =3D env->prog->insnsi, *stx, *ldx;
> > +       struct bpf_subprog_info *subprog;
> > +       u32 csr_mask =3D call_csr_mask(env, &insns[t]);
> > +       u32 reg_mask =3D ~csr_mask | ~ALL_CALLER_SAVED_REGS;
> > +       int s, i;
> > +       s16 off;
> > +
> > +       if (csr_mask =3D=3D ALL_CALLER_SAVED_REGS)
> > +               return false;
>=20
> false -> 0 ?

Right.

>=20
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

Makes sense.

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
> > +                       break;
> > +               reg_mask |=3D BIT(stx->src_reg);
> > +               if (mark) {
> > +                       env->insn_aux_data[t - i].nocsr_pattern =3D tru=
e;
> > +                       env->insn_aux_data[t + i].nocsr_pattern =3D tru=
e;
> > +               }
> > +       }
> > +       if (i =3D=3D 1)
> > +               return 0;
> > +       if (mark) {
> > +               s =3D find_containing_subprog(env, t);
> > +               /* can't happen */
> > +               if (WARN_ON_ONCE(s < 0))
> > +                       return 0;
> > +               subprog =3D &env->subprog_info[s];
> > +               subprog->nocsr_stack_off =3D min(subprog->nocsr_stack_o=
ff, off);
> > +       }
>=20
> why not split pattern detection and all this other marking logic? You
> can return "the size of csr pattern", meaning how many spills/fills
> are there surrounding the call, no? Then all the marking can be done
> (if necessary) by the caller.

I'll try recording pattern size for function call,
so no split would be necessary.

> The question is what to do with zero patter (no spills/fills for nocsr
> call, is that valid case?)

Zero pattern -- no spills/fills to remove, so nothing to do.
I will add a test case, but it should be handled by current implementation =
fine.

[...]

> > +/* Remove unnecessary spill/fill pairs, members of nocsr pattern.
> > + * Do this as a separate pass to avoid interfering with helper/kfunc
> > + * inlining logic in do_misc_fixups().
> > + * See comment for match_and_mark_nocsr_pattern().
> > + */
> > +static int remove_nocsr_spills_fills(struct bpf_verifier_env *env)
> > +{
> > +       struct bpf_subprog_info *subprogs =3D env->subprog_info;
> > +       int i, j, spills_num, cur_subprog =3D 0;
> > +       struct bpf_insn *insn =3D env->prog->insnsi;
> > +       int insn_cnt =3D env->prog->len;
> > +
> > +       for (i =3D 0; i < insn_cnt; i++, insn++) {
> > +               spills_num =3D match_nocsr_pattern(env, i);
>=20
> we can probably afford a single-byte field somewhere in
> bpf_insn_aux_data to remember "csr pattern size" instead of just a
> true/false fact that it is nocsr call. And so we wouldn't need to do
> pattern matching again here, we'll just have all the data.

Makes sense.

[...]

