Return-Path: <bpf+bounces-73801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C977C39F6C
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 10:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC3C1889465
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 09:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08AE2DC784;
	Thu,  6 Nov 2025 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpMaTlbE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390A230B52F
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423066; cv=none; b=CidHeuqidIP5tDgeoUVqI4xW1vvFbRGgX6M73lt33Y1P4O490EVckdOHTHAXGSYTtJQ2Xc7niYV4Piw26X2LTEV7NyA1xdIxgjU5vN+zB19iVABEY21RzP8WuHodHDhbqcp4x8SwLSpYXDfmbxqL8VCG2sMHsXfvys2qtRKACLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423066; c=relaxed/simple;
	bh=ayZEdYLK6xkGkhUdXM3ILrFQAlvlAu9LPIH0BS9Y/fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUyP6o39r/u2hSv7DjBX4iApQFvYQ8/ZVWSn5+YF58r84CpYQm8LHBCkwVLABIhjm2T4q3Fp5o2vj7moNs709Ys5mVONjHyk6NX4q6VEunbLEXsLJC96R3pGg6uHQCy0o0RFq8PBpq74tUxI47hRG4seFePejghwtR7EkRHXZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpMaTlbE; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640f8a7aba2so1098386a12.0
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 01:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762423062; x=1763027862; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2nUoRXG13B7Ugrq1sj0WFTLKrzeLi3ePPRM1Pk4sYoY=;
        b=kpMaTlbEZHbAXJIkAfX8FVpABmCoAJtsmWpdb/RjTH4nIhIROO+WVhTGtDyJW/pd2z
         GTvqPHT6xZ47x4HUH5EHQxz4Vumq5BxpYr/lcBOlyC0L6dgCp1j4gYrXnudXuRnByGKX
         KXkfodPEb07CtZqhxETeiays32bM1JqxqRKuTTLtgGkPSfn39Bmc3HmxWl9/If9EPPk/
         snrjCgfL4dKcp0UMZFJVDeUBgIovrtIyaT3eo79MBMFAnTYgE3ZRieTdxJgEiueQpHXg
         fMLIc7q7bTXYoSSeTT65mKzZRwy26YoR2o8PIY+xvOdekTY8IPxhj/3RVR6Via1rfry1
         B9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423062; x=1763027862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nUoRXG13B7Ugrq1sj0WFTLKrzeLi3ePPRM1Pk4sYoY=;
        b=R5PGtoFEJczmHHqTHYbjFyqvTBiMrGgpyyqEBzQvMlExFCVYru+So+vSbJN/tSwYbn
         G8uVWHoc+doz16CiHVFKHxFZhkzXjoyzXO1dNp/KzVS54W0KQdx5jHcI1s+eow3t++jO
         FicFE14NMdrnY2abh2cRr36NqPJASPaRwmhtJy+9J/h5aAtixm3fDBM09Rf1ylfx5OvC
         nIeATwGW/456fzU5ECHExsS/z0yB8k33WQYRDjF62KUpnAPkXu3gXYJCsjMFvI4vGMZj
         udoI90mtc/zh5lyCiTCdAzkwTRPHDbq2MMa/o+dXi84Dpk9DMml2aSCIDolJePP2a1+i
         WRnQ==
X-Gm-Message-State: AOJu0YxnA5VRe0QsvWQww/pXQ7D3+4QGEb0lKMnMdBi6qhJr6IDvG2h/
	ujh6/6DrGHWbna1LRze7+/d4tGlmAokMOk3eMj+aJaP/U8tLuBT7jhOZD1xAzw==
X-Gm-Gg: ASbGncs7+JOWFqhF8QGXmmtSP58oiTnlBJ7k3Q4U0166VBpSh+CEKkNq2FDPTDvEm1p
	jGR+/fkbRFZBadSm/wwpEymFobCRAX+L0pnHVI3Fpy6Bnr/3eUF/niy1U6Ukm4Jb6Qlnswy1Uwg
	LYjb6OgRlzqZV52c8Zu7oQwIhSYTfnXIYsVBnZe+4vdeUQi2WGvvZT6pDENaeVpOch+lO3Q+9Oq
	GMhU7NZlVRvtvtLTdNYWwOdT0HGoCTQnsR1n4KYWmBKjfB6xNr4WlQAHQJGTvCRciOmqqC2flou
	E2ADf+nY2rNOObXIB6AUSNe/haGMWtEDrA9aPoaNq+wweu8SZ9dszEWTO/Ga7otlZzLoRlzvsVd
	SS381Uat9smBFABRmgPkVtSyFHOO40ZJBh+dabMk22ZJIhG7UzgG32o3Pgh/F9yEHsK1pIqiduV
	yBlF806dsMHQ==
X-Google-Smtp-Source: AGHT+IF4kFaTstbaz/CM6hcqwkjy/WVWHmYxmy6sTUpKupHCNEnIZVvXkV9z2ICnd1wCaAFud/2wEg==
X-Received: by 2002:a17:907:7f9f:b0:b64:76fc:ea5c with SMTP id a640c23a62f3a-b726554be36mr667459966b.52.1762423062413;
        Thu, 06 Nov 2025 01:57:42 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c8f51sm173671066b.70.2025.11.06.01.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 01:57:42 -0800 (PST)
Date: Thu, 6 Nov 2025 10:03:53 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v11 bpf-next 08/12] bpf, x86: add support for indirect
 jumps
Message-ID: <aQxyiWANixOfg+Eg@mail.gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
 <20251105090410.1250500-9-a.s.protopopov@gmail.com>
 <CAADnVQK3piReoo1ja=9hgz7aJ60Y_Jjur_JMOaYV8-Mn_VyE4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK3piReoo1ja=9hgz7aJ60Y_Jjur_JMOaYV8-Mn_VyE4A@mail.gmail.com>

On 25/11/05 02:42PM, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 12:58 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > Add support for a new instruction
> >
> >     BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=0
> >
> > which does an indirect jump to a location stored in Rx.  The register
> > Rx should have type PTR_TO_INSN. This new type assures that the Rx
> > register contains a value (or a range of values) loaded from a
> > correct jump table – map of type instruction array.
> >
> > For example, for a C switch LLVM will generate the following code:
> >
> >     0:   r3 = r1                    # "switch (r3)"
> >     1:   if r3 > 0x13 goto +0x666   # check r3 boundaries
> >     2:   r3 <<= 0x3                 # adjust to an index in array of addresses
> >     3:   r1 = 0xbeef ll             # r1 is PTR_TO_MAP_VALUE, r1->map_ptr=M
> >     5:   r1 += r3                   # r1 inherits boundaries from r3
> >     6:   r1 = *(u64 *)(r1 + 0x0)    # r1 now has type INSN_TO_PTR
> >     7:   gotox r1                   # jit will generate proper code
> >
> > Here the gotox instruction corresponds to one particular map. This is
> > possible however to have a gotox instruction which can be loaded from
> > different maps, e.g.
> >
> >     0:   r1 &= 0x1
> >     1:   r2 <<= 0x3
> >     2:   r3 = 0x0 ll                # load from map M_1
> >     4:   r3 += r2
> >     5:   if r1 == 0x0 goto +0x4
> >     6:   r1 <<= 0x3
> >     7:   r3 = 0x0 ll                # load from map M_2
> >     9:   r3 += r1
> >     A:   r1 = *(u64 *)(r3 + 0x0)
> >     B:   gotox r1                   # jump to target loaded from M_1 or M_2
> >
> > During check_cfg stage the verifier will collect all the maps which
> > point to inside the subprog being verified. When building the config,
> > the high 16 bytes of the insn_state are used, so this patch
> > (theoretically) supports jump tables of up to 2^16 slots.
> >
> > During the later stage, in check_indirect_jump, it is checked that
> > the register Rx was loaded from a particular instruction array.
> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c  |   3 +
> >  include/linux/bpf.h          |   1 +
> >  include/linux/bpf_verifier.h |   9 +
> >  kernel/bpf/bpf_insn_array.c  |  15 ++
> >  kernel/bpf/core.c            |   1 +
> >  kernel/bpf/liveness.c        |   3 +
> >  kernel/bpf/log.c             |   1 +
> >  kernel/bpf/verifier.c        | 373 ++++++++++++++++++++++++++++++++++-
> >  8 files changed, 400 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index bbd2b03d2b74..36a0d4db9f68 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2628,6 +2628,9 @@ st:                       if (is_imm8(insn->off))
> >
> >                         break;
> >
> > +               case BPF_JMP | BPF_JA | BPF_X:
> > +                       emit_indirect_jump(&prog, insn->dst_reg, image + addrs[i - 1]);
> > +                       break;
> >                 case BPF_JMP | BPF_JA:
> >                 case BPF_JMP32 | BPF_JA:
> >                         if (BPF_CLASS(insn->code) == BPF_JMP) {
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 9d41a6affcef..09d5dc541d1c 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1001,6 +1001,7 @@ enum bpf_reg_type {
> >         PTR_TO_ARENA,
> >         PTR_TO_BUF,              /* reg points to a read/write buffer */
> >         PTR_TO_FUNC,             /* reg points to a bpf program function */
> > +       PTR_TO_INSN,             /* reg points to a bpf program instruction */
> >         CONST_PTR_TO_DYNPTR,     /* reg points to a const struct bpf_dynptr */
> >         __BPF_REG_TYPE_MAX,
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 6b820d8d77af..5441341f1ab9 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -527,6 +527,7 @@ struct bpf_insn_aux_data {
> >                 struct {
> >                         u32 map_index;          /* index into used_maps[] */
> >                         u32 map_off;            /* offset from value base address */
> > +                       struct bpf_iarray *jt;  /* jump table for gotox instruction */
> >                 };
> >                 struct {
> >                         enum bpf_reg_type reg_type;     /* type of pseudo_btf_id */
> > @@ -840,6 +841,7 @@ struct bpf_verifier_env {
> >         struct bpf_scc_info **scc_info;
> >         u32 scc_cnt;
> >         struct bpf_iarray *succ;
> > +       struct bpf_iarray *gotox_tmp_buf;
> >  };
> >
> >  static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
> > @@ -1050,6 +1052,13 @@ static inline bool bpf_stack_narrow_access_ok(int off, int fill_size, int spill_
> >         return !(off % BPF_REG_SIZE);
> >  }
> >
> > +static inline bool insn_is_gotox(struct bpf_insn *insn)
> > +{
> > +       return BPF_CLASS(insn->code) == BPF_JMP &&
> > +              BPF_OP(insn->code) == BPF_JA &&
> > +              BPF_SRC(insn->code) == BPF_X;
> > +}
> > +
> >  const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type);
> >  const char *dynptr_type_str(enum bpf_dynptr_type type);
> >  const char *iter_type_str(const struct btf *btf, u32 btf_id);
> > diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> > index 2053fda377bb..61ce52882632 100644
> > --- a/kernel/bpf/bpf_insn_array.c
> > +++ b/kernel/bpf/bpf_insn_array.c
> > @@ -114,6 +114,20 @@ static u64 insn_array_mem_usage(const struct bpf_map *map)
> >         return insn_array_alloc_size(map->max_entries);
> >  }
> >
> > +static int insn_array_map_direct_value_addr(const struct bpf_map *map, u64 *imm, u32 off)
> > +{
> > +       struct bpf_insn_array *insn_array = cast_insn_array(map);
> > +
> > +       if ((off % sizeof(long)) != 0 ||
> > +           (off / sizeof(long)) >= map->max_entries)
> > +               return -EINVAL;
> > +
> > +       /* from BPF's point of view, this map is a jump table */
> > +       *imm = (unsigned long)insn_array->ips + off;
> > +
> > +       return 0;
> > +}
> > +
> >  BTF_ID_LIST_SINGLE(insn_array_btf_ids, struct, bpf_insn_array)
> >
> >  const struct bpf_map_ops insn_array_map_ops = {
> > @@ -126,6 +140,7 @@ const struct bpf_map_ops insn_array_map_ops = {
> >         .map_delete_elem = insn_array_delete_elem,
> >         .map_check_btf = insn_array_check_btf,
> >         .map_mem_usage = insn_array_mem_usage,
> > +       .map_direct_value_addr = insn_array_map_direct_value_addr,
> >         .map_btf_id = &insn_array_btf_ids[0],
> >  };
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 4b62a03d6df5..ef4448f18aad 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -1708,6 +1708,7 @@ bool bpf_opcode_in_insntable(u8 code)
> >                 [BPF_LD | BPF_IND | BPF_B] = true,
> >                 [BPF_LD | BPF_IND | BPF_H] = true,
> >                 [BPF_LD | BPF_IND | BPF_W] = true,
> > +               [BPF_JMP | BPF_JA | BPF_X] = true,
> >                 [BPF_JMP | BPF_JCOND] = true,
> >         };
> >  #undef BPF_INSN_3_TBL
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index bffb495bc933..a7240013fd9d 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
> > @@ -485,6 +485,9 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
> >         struct bpf_iarray *succ;
> >         int insn_sz;
> >
> > +       if (unlikely(insn_is_gotox(insn)))
> > +               return env->insn_aux_data[idx].jt;
> > +
> >         /* pre-allocated array of size up to 2; reset cnt, as it may have been used already */
> >         succ = env->succ;
> >         succ->cnt = 0;
> > diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> > index 70221aafc35c..a0c3b35de2ce 100644
> > --- a/kernel/bpf/log.c
> > +++ b/kernel/bpf/log.c
> > @@ -461,6 +461,7 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
> >                 [PTR_TO_ARENA]          = "arena",
> >                 [PTR_TO_BUF]            = "buf",
> >                 [PTR_TO_FUNC]           = "func",
> > +               [PTR_TO_INSN]           = "insn",
> >                 [PTR_TO_MAP_KEY]        = "map_key",
> >                 [CONST_PTR_TO_DYNPTR]   = "dynptr_ptr",
> >         };
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 781669f649f2..1268fa075d4c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6006,6 +6006,18 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
> >         return 0;
> >  }
> >
> > +/*
> > + * Return the size of the memory region accessible from a pointer to map value.
> > + * For INSN_ARRAY maps whole bpf_insn_array->ips array is accessible.
> > + */
> > +static u32 map_mem_size(const struct bpf_map *map)
> > +{
> > +       if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY)
> > +               return map->max_entries * sizeof(long);
> > +
> > +       return map->value_size;
> > +}
> > +
> >  /* check read/write into a map element with possible variable offset */
> >  static int check_map_access(struct bpf_verifier_env *env, u32 regno,
> >                             int off, int size, bool zero_size_allowed,
> > @@ -6015,11 +6027,11 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
> >         struct bpf_func_state *state = vstate->frame[vstate->curframe];
> >         struct bpf_reg_state *reg = &state->regs[regno];
> >         struct bpf_map *map = reg->map_ptr;
> > +       u32 mem_size = map_mem_size(map);
> >         struct btf_record *rec;
> >         int err, i;
> >
> > -       err = check_mem_region_access(env, regno, off, size, map->value_size,
> > -                                     zero_size_allowed);
> > +       err = check_mem_region_access(env, regno, off, size, mem_size, zero_size_allowed);
> >         if (err)
> >                 return err;
> >
> > @@ -7481,6 +7493,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >  {
> >         struct bpf_reg_state *regs = cur_regs(env);
> >         struct bpf_reg_state *reg = regs + regno;
> > +       bool insn_array = reg->type == PTR_TO_MAP_VALUE &&
> > +                         reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_ARRAY;
> >         int size, err = 0;
> >
> >         size = bpf_size_to_bytes(bpf_size);
> > @@ -7488,7 +7502,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >                 return size;
> >
> >         /* alignment checks will add in reg->off themselves */
> > -       err = check_ptr_alignment(env, reg, off, size, strict_alignment_once);
> > +       err = check_ptr_alignment(env, reg, off, size, strict_alignment_once || insn_array);
> >         if (err)
> >                 return err;
> >
> > @@ -7515,6 +7529,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >                         verbose(env, "R%d leaks addr into map\n", value_regno);
> >                         return -EACCES;
> >                 }
> > +               if (t == BPF_WRITE && insn_array) {
> > +                       verbose(env, "writes into insn_array not allowed\n");
> > +                       return -EACCES;
> > +               }
> > +
> >                 err = check_map_access_type(env, regno, off, size, t);
> 
> This is a bit ugly.
> Just set map->map_flags |= BPF_F_RDONLY_PROG;
> at map creation time or check that it's created this way from libbpf.
> And remove the above check.
> check_map_access_type() will do it generically.
> 
> and with that reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_ARRAY ->strict
> can move into check_ptr_alignment().
> Abusing strict_alignment_once for this is wrong.
> 
> Both can be a follow up.

Ok, thanks, will follow up on both issues.

