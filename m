Return-Path: <bpf+bounces-60903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2AFADE98E
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EACA3B78F0
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161282882B9;
	Wed, 18 Jun 2025 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeLokeSE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0529E283CB3
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750244640; cv=none; b=ew7UUIpDg3F0nHybXEm5P1rHUg09YM7T77gv2dVhQNN5NmX4D2A2E8n435k/WXl4UHwlr+oSKn47k3EjgpJjt+mnvX/nXyAMuYiguRmUbDodXTwK1LlRuFscFaO519RBgVyoytrv8XJvzjubt0RFGg55pYrWB+Y0BbP+B7WByio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750244640; c=relaxed/simple;
	bh=hPuByeYGrMXgSEHCRQt1T1xOnwtGnOc1VK8hZzLvAvU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R7TY4hZ/RBrsCLk0QItSo36dxDJvdcPDsvU7h19fvGYmy57nffA0t7W42DOFahUUuZmCwpZF1uS7iEsgZMMnd/yQQ27glOaLthl57SXA9Qsw+uJXA7HfUofZEdYYpC78g2WFnGviTKOevWRmRHXWG79ZdL0yEBHbMWBN2XrZ4RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeLokeSE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so526210b3a.1
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 04:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750244638; x=1750849438; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syQFoV/6zs+NSW4aanZndZGPKTyfx5epODf+7KgQTYk=;
        b=aeLokeSElrUDOpE6aNbQBJHXf6b0ElfInHcV/r/guLvUIYgoQLx9V43CLF3EJ7OcY5
         d6R6iydn5aYw59TFauOeo2rDEgpb9QGyYbDfuib5eWQL+oDBhmN293U7OKTwvPAfL2IF
         08nYRQ2bUql71yRau50wLUQTJctJPE3wFTVU7pDDLTfx/iwAZyc/qdveEij4mKSpWT7r
         jjX9ZXun43Ka2No6avwGbRFV2222+23+H2zJSUws6sH2jzXic65mfZ2s4DpTNU+Niguz
         Bb5p9w03pyya0BufZa7VtJUAZI7V/r7LgYpXG2KmZ3w2NkY0Yi8xzGHM3v4Vx9wA9YRK
         l8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750244638; x=1750849438;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=syQFoV/6zs+NSW4aanZndZGPKTyfx5epODf+7KgQTYk=;
        b=ZKDKgalju32C0639KX9PtSO1ty24oWbnbEp/5ovKDatoO8urZ6t9llE13ik67AQEVb
         oordFx/8UVyydUzQiuDJ7J5NKThEwE8Vl470n2MDze//bKmqscXBRuyp5Y3br5oMGqjU
         Inj3e9cOmErsIypKyHCsa1H94F7jYSoTxcr18YVI4F6txzF/eYspSJUH14pjW6KhPbCN
         N7/EGcaqMN8sMU+Y/Va4+bAt4b2/h0mmbwSgI04mnCMl+9C6Qq12b4vYb636h0jWCaMM
         gQw1c7Jm8A80yX25Mj0X1D6P/IbUGOj4aqovOUYkzQjX6qWWfjebtEw2PxnjpFkMhZri
         4XDA==
X-Forwarded-Encrypted: i=1; AJvYcCWJOAJq0i3WKcEXR2wUpLoFzb36MClvg/K6UBI1FVY72G8Gno1WiwABH0DJCBqH/JCY0wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5cwdxLW7VRqDlY2E02cRv6RUAxahIn2FhwtrKEBUz3lX2hQP
	LHCYpTXAYXd3lixGRT4TjFq9MfmTPZTDjRvH97Kf3mmLqL8taynFbu7Sy7Fm/zihgHs=
X-Gm-Gg: ASbGnctGow37hIwHcIOia4gDZmzDUPtI32HTCJybQcpX1Iz3pYR6YjoFGSGEzesqKCF
	DmeObLCsGoQgnHkcb/Lbb/s5YA++VKwQvNU+jVJRKcGQIVqE/1W7LMNH5ofA4GSYKlrbRpyMHrv
	TGdFCvjCFC8aVrE9eO0kJz8Mjn67nYeTFEvQOR3n8RDOwB3XWFR9X8wNyCIsPeM4jEJhYQqWBr9
	rvwX696LoVJdTsVYVofaYAMumguXLXx6NwatwTJ+y30gx9l5hKmHZwocIuffsx0NtTU7uD7hF/j
	EVE+Y50HKtcfrNnNeV08l/hIIHpU4DxuOEhmA2xkN6Wm1A9H2gmj8qV8JQ==
X-Google-Smtp-Source: AGHT+IG8zCn8XNP7CP81NWhMN4xh4OEDG5nKKmK2WZe8N28a2uok4gW5dzlCaIzivGXQXetwAJomcw==
X-Received: by 2002:a05:6a00:854:b0:736:9f2e:1357 with SMTP id d2e1a72fcca58-748e7077f9dmr2852196b3a.12.1750244638009;
        Wed, 18 Jun 2025 04:03:58 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083065sm10607895b3a.73.2025.06.18.04.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 04:03:57 -0700 (PDT)
Message-ID: <8727a800569d88f8f932333859590f702c5332ea.camel@gmail.com>
Subject: Re: [RFC bpf-next 5/9] bpf, x86: add support for indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 18 Jun 2025 04:03:55 -0700
In-Reply-To: <20250615085943.3871208-6-a.s.protopopov@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
	 <20250615085943.3871208-6-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:

[...]

>     0:   r3 =3D r1                    # "switch (r3)"
>     1:   if r3 > 0x13 goto +0x666   # check r3 boundaries
>     2:   r3 <<=3D 0x3                 # r3 is void*, point to an address
>     3:   r1 =3D 0xbeef ll             # r1 is PTR_TO_MAP_VALUE, r1->map_p=
tr=3DM
>     5:   r1 +=3D r3                   # r1 inherits boundaries from r3
>     6:   r1 =3D *(u64 *)(r1 + 0x0)    # r1 now has type INSN_TO_PTR
                                                        ^^^^^^^^^^^
                                                        PTR_TO_INSN?

>     7:   gotox r1[,imm=3Dfd(M)]       # verifier checks that M =3D=3D r1-=
>map_ptr

[...]

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 37dc83d91832..d20f6775605d 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2520,6 +2520,13 @@ st:			if (is_imm8(insn->off))
> =20
>  			break;
> =20
> +		case BPF_JMP | BPF_JA | BPF_X:
> +		case BPF_JMP32 | BPF_JA | BPF_X:

Is it necessary to add both JMP and JMP32 versions?
Do we need to extend e.g. bpf_jit_supports_insn() and report an error
in verifier.c or should we rely on individual jits to report unknown
instruction?

> +			emit_indirect_jump(&prog,
> +					   reg2hex[insn->dst_reg],
> +					   is_ereg(insn->dst_reg),
> +					   image + addrs[i - 1]);
> +			break;
>  		case BPF_JMP | BPF_JA:
>  		case BPF_JMP32 | BPF_JA:
>  			if (BPF_CLASS(insn->code) =3D=3D BPF_JMP) {
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 008bcd44c60e..3c5eaea2b476 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -952,6 +952,7 @@ enum bpf_reg_type {
>  	PTR_TO_ARENA,
>  	PTR_TO_BUF,		 /* reg points to a read/write buffer */
>  	PTR_TO_FUNC,		 /* reg points to a bpf program function */
> +	PTR_TO_INSN,		 /* reg points to a bpf program instruction */
>  	CONST_PTR_TO_DYNPTR,	 /* reg points to a const struct bpf_dynptr */
>  	__BPF_REG_TYPE_MAX,
> =20
> @@ -3601,6 +3602,7 @@ int bpf_insn_set_ready(struct bpf_map *map);
>  void bpf_insn_set_release(struct bpf_map *map);
>  void bpf_insn_set_adjust(struct bpf_map *map, u32 off, u32 len);
>  void bpf_insn_set_adjust_after_remove(struct bpf_map *map, u32 off, u32 =
len);
> +int bpf_insn_set_iter_xlated_offset(struct bpf_map *map, u32 iter_no);

This is a horrible name:
- this function is not an iterator;
- it is way too long.

Maybe make it a bit more complex but convenient to use, e.g.:

  struct bpf_iarray_iter {
	struct bpf_map *map;
	u32 idx;
  };

  struct bpf_iset_iter bpf_iset_make_iter(struct bpf_map *map, u32 lo, u32 =
hi);
  bool bpf_iset_iter_next(struct bpf_iarray_iter *it, u32 *offset); // stil=
l a horrible name

This would hide the manipulation with unique indices from verifier.c.

?

> =20
>  struct bpf_insn_ptr {
>  	void *jitted_ip;
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 84b5e6b25c52..80d9afcca488 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -229,6 +229,10 @@ struct bpf_reg_state {
>  	enum bpf_reg_liveness live;
>  	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
>  	bool precise;
> +
> +	/* Used to track boundaries of a PTR_TO_INSN */
> +	u32 min_index;
> +	u32 max_index;

Use {umin,umax}_value instead?

>  };
> =20
>  enum bpf_stack_slot_type {
> diff --git a/kernel/bpf/bpf_insn_set.c b/kernel/bpf/bpf_insn_set.c
> index c20e99327118..316cecad60a9 100644
> --- a/kernel/bpf/bpf_insn_set.c
> +++ b/kernel/bpf/bpf_insn_set.c
> @@ -9,6 +9,8 @@ struct bpf_insn_set {
>  	struct bpf_map map;
>  	struct mutex state_mutex;
>  	int state;
> +	u32 **unique_offsets;

Why is this a pointer to pointer?
bpf_insn_set_iter_xlated_offset() is only used during check_cfg() and
main verification. At that point no instruction movement occurred yet,
so no need to track `&insn_set->ptrs[i].user_value.xlated_off`?

> +	u32 unique_offsets_cnt;
>  	long *ips;
>  	DECLARE_FLEX_ARRAY(struct bpf_insn_ptr, ptrs);
>  };

[...]

> @@ -15296,6 +15330,22 @@ static int adjust_reg_min_max_vals(struct bpf_ve=
rifier_env *env,
>  		return 0;
>  	}
> =20
> +	if (dst_reg->type =3D=3D PTR_TO_MAP_VALUE && map_is_insn_set(dst_reg->m=
ap_ptr)) {
> +		if (opcode !=3D BPF_ADD) {
> +			verbose(env, "Operation %s on ptr to instruction set map is prohibite=
d\n",
> +				bpf_alu_string[opcode >> 4]);
> +			return -EACCES;
> +		}
> +		src_reg =3D &regs[insn->src_reg];
> +		if (src_reg->type !=3D SCALAR_VALUE) {
> +			verbose(env, "Adding non-scalar R%d to an instruction ptr is prohibit=
ed\n",
> +				insn->src_reg);
> +			return -EACCES;
> +		}
> +		dst_reg->min_index =3D src_reg->umin_value / sizeof(long);
> +		dst_reg->max_index =3D src_reg->umax_value / sizeof(long);
> +	}
> +

What if there are several BPF_ADD on the same PTR_TO_MAP_VALUE in a row?
Shouldn't the {min,max}_index be accumulated in that case?

Nit: this should be handled inside adjust_ptr_min_max_vals().

>  	if (dst_reg->type !=3D SCALAR_VALUE)
>  		ptr_reg =3D dst_reg;
> =20

[...]

> @@ -17552,6 +17607,62 @@ static int mark_fastcall_patterns(struct bpf_ver=
ifier_env *env)

[...]

> +/* "conditional jump with N edges" */
> +static int visit_goto_x_insn(int t, struct bpf_verifier_env *env, int fd=
)
> +{
> +	struct bpf_map *map;
> +	int ret;
> +
> +	ret =3D add_used_map(env, fd, &map);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (map->map_type !=3D BPF_MAP_TYPE_INSN_SET)
> +		return -EINVAL;

Nit: print something in the log?

> +
> +	return push_goto_x_edge(t, env, map);
> +}
> +

[...]

> @@ -18786,11 +18904,22 @@ static bool func_states_equal(struct bpf_verifi=
er_env *env, struct bpf_func_stat
>  			      struct bpf_func_state *cur, u32 insn_idx, enum exact_level exac=
t)
>  {
>  	u16 live_regs =3D env->insn_aux_data[insn_idx].live_regs_before;
> +	struct bpf_insn *insn;
>  	u16 i;
> =20
>  	if (old->callback_depth > cur->callback_depth)
>  		return false;
> =20
> +	insn =3D &env->prog->insnsi[insn_idx];
> +	if (insn_is_gotox(insn)) {
> +		struct bpf_reg_state *old_dst =3D &old->regs[insn->dst_reg];
> +		struct bpf_reg_state *cur_dst =3D &cur->regs[insn->dst_reg];
> +
> +		if (old_dst->min_index !=3D cur_dst->min_index ||
> +		    old_dst->max_index !=3D cur_dst->max_index)
> +			return false;
> +	}
> +

Concur with Alexei, this should be handled by regsafe().
Also, having cur_dst as a subset of old_dst should be fine.

>  	for (i =3D 0; i < MAX_BPF_REG; i++)
>  		if (((1 << i) & live_regs) &&
>  		    !regsafe(env, &old->regs[i], &cur->regs[i],
> @@ -19654,6 +19783,55 @@ static int process_bpf_exit_full(struct bpf_veri=
fier_env *env,
>  	return PROCESS_BPF_EXIT;
>  }
> =20
> +static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_=
insn *insn)
> +{
> +	struct bpf_verifier_state *other_branch;
> +	struct bpf_reg_state *dst_reg;
> +	struct bpf_map *map;
> +	int xoff;
> +	int err;
> +	u32 i;
> +
> +	/* this map should already have been added */
> +	err =3D add_used_map(env, insn->imm, &map);
> +	if (err < 0)
> +		return err;
> +
> +	dst_reg =3D reg_state(env, insn->dst_reg);
> +	if (dst_reg->type !=3D PTR_TO_INSN) {
> +		verbose(env, "BPF_JA|BPF_X R%d has type %d, expected PTR_TO_INSN\n",
> +				insn->dst_reg, dst_reg->type);
> +		return -EINVAL;
> +	}
> +
> +	if (dst_reg->map_ptr !=3D map) {
> +		verbose(env, "BPF_JA|BPF_X R%d was loaded from map id=3D%u, expected i=
d=3D%u\n",
> +				insn->dst_reg, dst_reg->map_ptr->id, map->id);
> +		return -EINVAL;
> +	}
> +
> +	if (dst_reg->max_index >=3D map->max_entries)
> +		return -EINVAL;
> +
> +	for (i =3D dst_reg->min_index + 1; i <=3D dst_reg->max_index; i++) {

Why +1 is needed in `i =3D dst_reg->min_index + 1`?

> +		xoff =3D bpf_insn_set_iter_xlated_offset(map, i);
> +		if (xoff =3D=3D -ENOENT)
> +			break;
> +		if (xoff < 0)
> +			return xoff;
> +
> +		other_branch =3D push_stack(env, xoff, env->insn_idx, false);
> +		if (!other_branch)
> +			return -EFAULT;

Nit: `return -ENOMEM`.

> +	}
> +
> +	env->insn_idx =3D bpf_insn_set_iter_xlated_offset(map, dst_reg->min_ind=
ex);
> +	if (env->insn_idx < 0)
> +		return env->insn_idx;
> +
> +	return 0;
> +}
> +
>  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_st=
ate)
>  {
>  	int err;

[...]


