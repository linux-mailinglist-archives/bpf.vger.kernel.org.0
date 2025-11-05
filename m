Return-Path: <bpf+bounces-73739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9916C38383
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 23:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C70414E99D0
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 22:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375582F1FE6;
	Wed,  5 Nov 2025 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUEtM318"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C632F12A8
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382590; cv=none; b=O2Vhy/Llkr+0F4kFzn/Tl1ojyRn2E70xwOLk1hFL54nPkqX2wVytehdLl2jffq096vh4GoSq0+MHRgdfSss0spqCMeMz7RTjzSGKuIgsV+UPYbutIzLwzjq4CAu010tV7ndRRGeM2My9t5FUUXmbQutM487jcPYP7qr3r4oXFCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382590; c=relaxed/simple;
	bh=8wH/bgLQKix3EGpyZnB835u4qIx6MaQZxZa+7u7Asjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJvlD07KpBEyWKPII7GZ4+FvhurSTejd3e8p5OO+KsFmeW2Yks9jp1grNMI0OUSjJoyRn9DKJjMvS/ZokX1ndyuOsSRuAMlFwHNBtxnRX3i0JYQZvutLAJuTe7R0ZndbEBeYqK0ube1XGzE+t39OMukrQt3d+KVhnFPCdb7aHXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUEtM318; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-421851bcb25so177092f8f.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 14:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762382587; x=1762987387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKYLRw2dniPDh6QfXWv3miibWWEZ4Ar4jKwApkUOdgc=;
        b=HUEtM318IwgtSjR0Ictr30gEJ1FkUJTwqO5LhoQWFes4wG4peoz6o04DRXZK8bRxHO
         FDKkxzCHdYEZZbcBVmkt+NXYUi5Q0zZlEPEeF5Y0DmzHQcUkJLl7MzzJCkmfVlI3tD2R
         kicns92rih6H+WjDqfRqzOKjzq7XzDUpMZeDVOSXmFoCvb6v6EB6fTr9T0WqR5auJU5Y
         9GMBJCzd4NOMHRvPgLkV4u48TEnwBqIe42C90pTcwwGA5OlpMjGzCQiWXm4eXgIKznwd
         hj77LT9sjGSfjD147jftbxXtEL8APJZBaRBGPJ66D1iMg2mLY71f4u+cghEd5k2j0LM3
         heNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762382587; x=1762987387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKYLRw2dniPDh6QfXWv3miibWWEZ4Ar4jKwApkUOdgc=;
        b=s7Otgw/ijEQVxpSO83MuRkpbgjXG+XkRXFB7cR+BS+6tLLXoZa2yltKGYRDJOW5DFU
         tIKq2WW6Xyyer76mwNRJHrX1ib81G/WoUy/W5FM9+9mf1Ws0gj9Y4TpdaBfX2nkZak9B
         qxoC8w2okMLcIP+O42lUj50IvAyat5PSOmRVTpGRjTrd/cuuflIIR5Vw4L4OCLGmsUsn
         ROQIglc1HoGFjsxlvYnlv6EjvPqVt5Et8m/NzEmjJ7YXOJAxNlEmeHCii7453j/q9W+y
         CdHLQu6y20J2S2+O4Belvr6d0sNefXlSeIPPY6gh23yDY4ZRnzqzwPBGnXwm+Kzrv6Sq
         zNJA==
X-Gm-Message-State: AOJu0Yw4KAmZlixVKeaSA345C7edcGqXT1MmMKmIC0iDakb8XOfJCUDr
	kh+L4j47XncEqaXN3ct65w7yuV8gtU5pCCuH0YjdcwpSHLcQXBWK1AV/2mT6xjM4HFMPMGO7xEH
	M/38A+tkSwWiLJSEKun0i3AAzDIvXSKE=
X-Gm-Gg: ASbGncuCqsRiuOGSY/qV3oOQBBN4L8TKGjUQLCCh9iLU+mN+PKBv5TokXGgouq9q5xY
	7bnv+qZU3+6rEVgUT1z/BuBxmT4sxC9nKg3kT9h9kuPwqqBzNU1hIwlbXllGZx/Ujqp7CJ7pjS4
	Br4eq77NhulE0N6dZ6Hvij0q7frLC/yyNPKL6SAq4LZgRTMOUhhFX298TC0hJCgY/1GhW/+VGB5
	U6sRFLJHMQz/ChbKuhsG8Xla34V+NHUjgZpDAO9ge20KxsSsnzSw7fvQjVjPKwEYbVy17oHZokU
	9E3kWowsYviglPLGWA==
X-Google-Smtp-Source: AGHT+IFubL7F6F3VlVdWAd7DA+myYyU8sW2eO5GIqaKXRWl03FGQa+f507uoI94T1LrVVZH64km1nef8C42znB0icGM=
X-Received: by 2002:a05:6000:2386:b0:429:d3a7:18bd with SMTP id
 ffacd0b85a97d-429e334019cmr3833892f8f.59.1762382586832; Wed, 05 Nov 2025
 14:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com> <20251105090410.1250500-9-a.s.protopopov@gmail.com>
In-Reply-To: <20251105090410.1250500-9-a.s.protopopov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 14:42:55 -0800
X-Gm-Features: AWmQ_bmXxWW9-JIp48W2Yt899_6b-En5C61JoG-cTRcpezBQogvtqDnSComl9go
Message-ID: <CAADnVQK3piReoo1ja=9hgz7aJ60Y_Jjur_JMOaYV8-Mn_VyE4A@mail.gmail.com>
Subject: Re: [PATCH v11 bpf-next 08/12] bpf, x86: add support for indirect jumps
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 12:58=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> Add support for a new instruction
>
>     BPF_JMP|BPF_X|BPF_JA, SRC=3D0, DST=3DRx, off=3D0, imm=3D0
>
> which does an indirect jump to a location stored in Rx.  The register
> Rx should have type PTR_TO_INSN. This new type assures that the Rx
> register contains a value (or a range of values) loaded from a
> correct jump table =E2=80=93 map of type instruction array.
>
> For example, for a C switch LLVM will generate the following code:
>
>     0:   r3 =3D r1                    # "switch (r3)"
>     1:   if r3 > 0x13 goto +0x666   # check r3 boundaries
>     2:   r3 <<=3D 0x3                 # adjust to an index in array of ad=
dresses
>     3:   r1 =3D 0xbeef ll             # r1 is PTR_TO_MAP_VALUE, r1->map_p=
tr=3DM
>     5:   r1 +=3D r3                   # r1 inherits boundaries from r3
>     6:   r1 =3D *(u64 *)(r1 + 0x0)    # r1 now has type INSN_TO_PTR
>     7:   gotox r1                   # jit will generate proper code
>
> Here the gotox instruction corresponds to one particular map. This is
> possible however to have a gotox instruction which can be loaded from
> different maps, e.g.
>
>     0:   r1 &=3D 0x1
>     1:   r2 <<=3D 0x3
>     2:   r3 =3D 0x0 ll                # load from map M_1
>     4:   r3 +=3D r2
>     5:   if r1 =3D=3D 0x0 goto +0x4
>     6:   r1 <<=3D 0x3
>     7:   r3 =3D 0x0 ll                # load from map M_2
>     9:   r3 +=3D r1
>     A:   r1 =3D *(u64 *)(r3 + 0x0)
>     B:   gotox r1                   # jump to target loaded from M_1 or M=
_2
>
> During check_cfg stage the verifier will collect all the maps which
> point to inside the subprog being verified. When building the config,
> the high 16 bytes of the insn_state are used, so this patch
> (theoretically) supports jump tables of up to 2^16 slots.
>
> During the later stage, in check_indirect_jump, it is checked that
> the register Rx was loaded from a particular instruction array.
>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c  |   3 +
>  include/linux/bpf.h          |   1 +
>  include/linux/bpf_verifier.h |   9 +
>  kernel/bpf/bpf_insn_array.c  |  15 ++
>  kernel/bpf/core.c            |   1 +
>  kernel/bpf/liveness.c        |   3 +
>  kernel/bpf/log.c             |   1 +
>  kernel/bpf/verifier.c        | 373 ++++++++++++++++++++++++++++++++++-
>  8 files changed, 400 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index bbd2b03d2b74..36a0d4db9f68 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2628,6 +2628,9 @@ st:                       if (is_imm8(insn->off))
>
>                         break;
>
> +               case BPF_JMP | BPF_JA | BPF_X:
> +                       emit_indirect_jump(&prog, insn->dst_reg, image + =
addrs[i - 1]);
> +                       break;
>                 case BPF_JMP | BPF_JA:
>                 case BPF_JMP32 | BPF_JA:
>                         if (BPF_CLASS(insn->code) =3D=3D BPF_JMP) {
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9d41a6affcef..09d5dc541d1c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1001,6 +1001,7 @@ enum bpf_reg_type {
>         PTR_TO_ARENA,
>         PTR_TO_BUF,              /* reg points to a read/write buffer */
>         PTR_TO_FUNC,             /* reg points to a bpf program function =
*/
> +       PTR_TO_INSN,             /* reg points to a bpf program instructi=
on */
>         CONST_PTR_TO_DYNPTR,     /* reg points to a const struct bpf_dynp=
tr */
>         __BPF_REG_TYPE_MAX,
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 6b820d8d77af..5441341f1ab9 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -527,6 +527,7 @@ struct bpf_insn_aux_data {
>                 struct {
>                         u32 map_index;          /* index into used_maps[]=
 */
>                         u32 map_off;            /* offset from value base=
 address */
> +                       struct bpf_iarray *jt;  /* jump table for gotox i=
nstruction */
>                 };
>                 struct {
>                         enum bpf_reg_type reg_type;     /* type of pseudo=
_btf_id */
> @@ -840,6 +841,7 @@ struct bpf_verifier_env {
>         struct bpf_scc_info **scc_info;
>         u32 scc_cnt;
>         struct bpf_iarray *succ;
> +       struct bpf_iarray *gotox_tmp_buf;
>  };
>
>  static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_=
env *env, int subprog)
> @@ -1050,6 +1052,13 @@ static inline bool bpf_stack_narrow_access_ok(int =
off, int fill_size, int spill_
>         return !(off % BPF_REG_SIZE);
>  }
>
> +static inline bool insn_is_gotox(struct bpf_insn *insn)
> +{
> +       return BPF_CLASS(insn->code) =3D=3D BPF_JMP &&
> +              BPF_OP(insn->code) =3D=3D BPF_JA &&
> +              BPF_SRC(insn->code) =3D=3D BPF_X;
> +}
> +
>  const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type=
 type);
>  const char *dynptr_type_str(enum bpf_dynptr_type type);
>  const char *iter_type_str(const struct btf *btf, u32 btf_id);
> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> index 2053fda377bb..61ce52882632 100644
> --- a/kernel/bpf/bpf_insn_array.c
> +++ b/kernel/bpf/bpf_insn_array.c
> @@ -114,6 +114,20 @@ static u64 insn_array_mem_usage(const struct bpf_map=
 *map)
>         return insn_array_alloc_size(map->max_entries);
>  }
>
> +static int insn_array_map_direct_value_addr(const struct bpf_map *map, u=
64 *imm, u32 off)
> +{
> +       struct bpf_insn_array *insn_array =3D cast_insn_array(map);
> +
> +       if ((off % sizeof(long)) !=3D 0 ||
> +           (off / sizeof(long)) >=3D map->max_entries)
> +               return -EINVAL;
> +
> +       /* from BPF's point of view, this map is a jump table */
> +       *imm =3D (unsigned long)insn_array->ips + off;
> +
> +       return 0;
> +}
> +
>  BTF_ID_LIST_SINGLE(insn_array_btf_ids, struct, bpf_insn_array)
>
>  const struct bpf_map_ops insn_array_map_ops =3D {
> @@ -126,6 +140,7 @@ const struct bpf_map_ops insn_array_map_ops =3D {
>         .map_delete_elem =3D insn_array_delete_elem,
>         .map_check_btf =3D insn_array_check_btf,
>         .map_mem_usage =3D insn_array_mem_usage,
> +       .map_direct_value_addr =3D insn_array_map_direct_value_addr,
>         .map_btf_id =3D &insn_array_btf_ids[0],
>  };
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 4b62a03d6df5..ef4448f18aad 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1708,6 +1708,7 @@ bool bpf_opcode_in_insntable(u8 code)
>                 [BPF_LD | BPF_IND | BPF_B] =3D true,
>                 [BPF_LD | BPF_IND | BPF_H] =3D true,
>                 [BPF_LD | BPF_IND | BPF_W] =3D true,
> +               [BPF_JMP | BPF_JA | BPF_X] =3D true,
>                 [BPF_JMP | BPF_JCOND] =3D true,
>         };
>  #undef BPF_INSN_3_TBL
> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index bffb495bc933..a7240013fd9d 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -485,6 +485,9 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32=
 idx)
>         struct bpf_iarray *succ;
>         int insn_sz;
>
> +       if (unlikely(insn_is_gotox(insn)))
> +               return env->insn_aux_data[idx].jt;
> +
>         /* pre-allocated array of size up to 2; reset cnt, as it may have=
 been used already */
>         succ =3D env->succ;
>         succ->cnt =3D 0;
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 70221aafc35c..a0c3b35de2ce 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -461,6 +461,7 @@ const char *reg_type_str(struct bpf_verifier_env *env=
, enum bpf_reg_type type)
>                 [PTR_TO_ARENA]          =3D "arena",
>                 [PTR_TO_BUF]            =3D "buf",
>                 [PTR_TO_FUNC]           =3D "func",
> +               [PTR_TO_INSN]           =3D "insn",
>                 [PTR_TO_MAP_KEY]        =3D "map_key",
>                 [CONST_PTR_TO_DYNPTR]   =3D "dynptr_ptr",
>         };
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 781669f649f2..1268fa075d4c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6006,6 +6006,18 @@ static int check_map_kptr_access(struct bpf_verifi=
er_env *env, u32 regno,
>         return 0;
>  }
>
> +/*
> + * Return the size of the memory region accessible from a pointer to map=
 value.
> + * For INSN_ARRAY maps whole bpf_insn_array->ips array is accessible.
> + */
> +static u32 map_mem_size(const struct bpf_map *map)
> +{
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY)
> +               return map->max_entries * sizeof(long);
> +
> +       return map->value_size;
> +}
> +
>  /* check read/write into a map element with possible variable offset */
>  static int check_map_access(struct bpf_verifier_env *env, u32 regno,
>                             int off, int size, bool zero_size_allowed,
> @@ -6015,11 +6027,11 @@ static int check_map_access(struct bpf_verifier_e=
nv *env, u32 regno,
>         struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
>         struct bpf_reg_state *reg =3D &state->regs[regno];
>         struct bpf_map *map =3D reg->map_ptr;
> +       u32 mem_size =3D map_mem_size(map);
>         struct btf_record *rec;
>         int err, i;
>
> -       err =3D check_mem_region_access(env, regno, off, size, map->value=
_size,
> -                                     zero_size_allowed);
> +       err =3D check_mem_region_access(env, regno, off, size, mem_size, =
zero_size_allowed);
>         if (err)
>                 return err;
>
> @@ -7481,6 +7493,8 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
>  {
>         struct bpf_reg_state *regs =3D cur_regs(env);
>         struct bpf_reg_state *reg =3D regs + regno;
> +       bool insn_array =3D reg->type =3D=3D PTR_TO_MAP_VALUE &&
> +                         reg->map_ptr->map_type =3D=3D BPF_MAP_TYPE_INSN=
_ARRAY;
>         int size, err =3D 0;
>
>         size =3D bpf_size_to_bytes(bpf_size);
> @@ -7488,7 +7502,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
>                 return size;
>
>         /* alignment checks will add in reg->off themselves */
> -       err =3D check_ptr_alignment(env, reg, off, size, strict_alignment=
_once);
> +       err =3D check_ptr_alignment(env, reg, off, size, strict_alignment=
_once || insn_array);
>         if (err)
>                 return err;
>
> @@ -7515,6 +7529,11 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
>                         verbose(env, "R%d leaks addr into map\n", value_r=
egno);
>                         return -EACCES;
>                 }
> +               if (t =3D=3D BPF_WRITE && insn_array) {
> +                       verbose(env, "writes into insn_array not allowed\=
n");
> +                       return -EACCES;
> +               }
> +
>                 err =3D check_map_access_type(env, regno, off, size, t);

This is a bit ugly.
Just set map->map_flags |=3D BPF_F_RDONLY_PROG;
at map creation time or check that it's created this way from libbpf.
And remove the above check.
check_map_access_type() will do it generically.

and with that reg->map_ptr->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY ->stric=
t
can move into check_ptr_alignment().
Abusing strict_alignment_once for this is wrong.

Both can be a follow up.

