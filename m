Return-Path: <bpf+bounces-70176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DF9BB21DA
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 02:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2581792D2
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 00:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8282C134BD;
	Thu,  2 Oct 2025 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4vVix/X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A9290F
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 00:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759364157; cv=none; b=CXAwaqR/zxQYs7YJykm7NJpl8+0jbfrXUWh56c7y0L8EJ4DMVJhx7/F+vWSGYCxIZK9DV6Cj+F26qmAnsvq74VZdVfgHvj39LQ3aK8dNNOAFBrOr5GNKPtRipTZ0qwxVV7AoyrTIcm1tcqGo/nPjRw/PduMlu8CPd04SwCSzD2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759364157; c=relaxed/simple;
	bh=wjeLWLmgnDlVGWayiXg2RwYV1jwDRfObvfkwf5I6Cyg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FnEK1tZcBwVmB0TDJCaZuVOQwdc33CFgnKO9PRTtqItDRfSge5yAVVLZz5+nJD5BOwGN7oPAwVmtg79oKyPF/T2yMilad2gwxYTrZRetKCIRJjFmBVKHngSIzSIVwreiaLG+WL74hTwDv3QgSiNBu/jFjg3xr2RCp8OOi+OtD+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4vVix/X; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so449835a91.2
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 17:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759364154; x=1759968954; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYKaueU06n650cE8grXlc6iV4/sruQKpBQnq2Up0GrY=;
        b=l4vVix/XbAxMlPbWUsaPESSKwFSJqSQTaGWNfF3ryYV+lqyE33YNiXuneY7289MPkM
         Fgs9mUcT7bRjbtHxr5nAQeOPUqWnl5QixD8Zf6hHTieCZ2tU97RBzEi0LzMIphH+2lGz
         E2veEvxQGvinIsNEdQu8VvUeH/CXnkkfIfa7uwG1jYt+ZLzhLQLdlIv7yoDi0u7LRd94
         g+lfarWONfbgg6jD27G0aB/Oc06qbAJw201wmi3wStJgHOiKGLY3SQ0lMv9WdyeL3yF7
         pZ5KMoZBY24pdqkgxMKZgllwGXKK5wdHVyorEqJLNi8KRa+YtY+3zsGy/9NPB8o16Yiu
         ZRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759364154; x=1759968954;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OYKaueU06n650cE8grXlc6iV4/sruQKpBQnq2Up0GrY=;
        b=Rf1mIvH7N7DhsuP6KJOF3CVlSLHRq8xJucl3mnQ3YPkf7pQh+sfL4Rk9d+M4X2WnKI
         EwuoSCdxwiHKcBp7BS72JRpD4IrZ8uqYdOWp5y78QyWfhtDxRDXQFKNeu8H6ZG5UOUCk
         79JTx7wR+O08AmAQCPZ+amEfZaOzjMnRp5K1Q0NNwYvGzkBVn+rdukMkNq+dkR8gYHoJ
         LenJbF5tBJWAwasxBqqueTUoWo6ug1NGjOGdwCq9QqO2xkoSEpSUokkPlN7VhyYrIyK9
         Fip+cXrJTDUawDwN2SqY1J8TBpBCTKNb0fWIastSF3YTMowQyJ0JR/0MMB+jsxlMGB07
         ak8A==
X-Forwarded-Encrypted: i=1; AJvYcCWvs8nL2oP8EfJ/I5n3XfbKHfGh9NMVCGqbz6CEz3S8Hyy4dYuGD+DvqSnYYJm3vNgzOgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhr0/yIrV69c0HBFo4od54EDTdwT3AEO19mBI6HHCllFidNoCa
	qaU/4TvLKWttHpPK5sXacITVl1e6v8OMg+7ig8qJ91nDuF1b2aDVJC0bkdgsqtTk+Jg=
X-Gm-Gg: ASbGncsZ/xlUsfDaktSjxzvXP9oRkXqGkseLQGyAIC4V044pqtUO5RBbtIONY6M8IBr
	61vuy4SP7JtTBPqRG8qWbkGdfffqiuiaGvCbYjjNZhoWTd6gfAsnktjLnCl8t/n3Dt7XDK43701
	qyI8UCzLoBIC05a5/dkqELxk7h/WKTpEnETimPNHh616VkEq9MIYpQ/0Z/AaZuatXayzB7u9MYo
	7GT0ZwFdzeu6ehx30scSpAj/4p2LandewvAMgiqe4U2T4H4A7DewoAmc8ZXKWSHtJLkEnRn4DrU
	2ZTFiup3o5kNau3TcwhEsLtYViSZ+olb2ZZ/KWgOLvelGLZEt1/b1AY0lXgNOfYXGraUPypRhJ3
	KzLHlWpKo9dtREr9z2Jkn1Tco9ae4RBvsi1lA9htvL2b7vJ5czOWEIw8cA9kLense213aUxI=
X-Google-Smtp-Source: AGHT+IFrtlqL+h/asUbsVCo5nG9vO8xd0SGFv6tSAxQCKW0i0k9HliA8nzRL8TZQ3pbmrImvDDRv5g==
X-Received: by 2002:a17:90b:17cf:b0:32e:24cf:e658 with SMTP id 98e67ed59e1d1-339a6e756famr6361193a91.3.1759364154360;
        Wed, 01 Oct 2025 17:15:54 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fcac7dsm850386b3a.38.2025.10.01.17.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 17:15:54 -0700 (PDT)
Message-ID: <8143e0481d68bb1793464c2d796fce7602695076.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 10/15] bpf, x86: add support for indirect
 jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 01 Oct 2025 17:15:52 -0700
In-Reply-To: <20250930125111.1269861-11-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-11-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> Add support for a new instruction
>=20
>     BPF_JMP|BPF_X|BPF_JA, SRC=3D0, DST=3DRx, off=3D0, imm=3D0
>=20
> which does an indirect jump to a location stored in Rx.  The register
> Rx should have type PTR_TO_INSN. This new type assures that the Rx
> register contains a value (or a range of values) loaded from a
> correct jump table =E2=80=93 map of type instruction array.
>=20
> For example, for a C switch LLVM will generate the following code:
>=20
>     0:   r3 =3D r1                    # "switch (r3)"
>     1:   if r3 > 0x13 goto +0x666   # check r3 boundaries
>     2:   r3 <<=3D 0x3                 # adjust to an index in array of ad=
dresses
>     3:   r1 =3D 0xbeef ll             # r1 is PTR_TO_MAP_VALUE, r1->map_p=
tr=3DM
>     5:   r1 +=3D r3                   # r1 inherits boundaries from r3
>     6:   r1 =3D *(u64 *)(r1 + 0x0)    # r1 now has type INSN_TO_PTR
>     7:   gotox r1                   # jit will generate proper code
>=20
> Here the gotox instruction corresponds to one particular map. This is
> possible however to have a gotox instruction which can be loaded from
> different maps, e.g.
>=20
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
>=20
> During check_cfg stage the verifier will collect all the maps which
> point to inside the subprog being verified. When building the config,
> the high 16 bytes of the insn_state are used, so this patch
> (theoretically) supports jump tables of up to 2^16 slots.
>=20
> During the later stage, in check_indirect_jump, it is checked that
> the register Rx was loaded from a particular instruction array.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---


[...]

> @@ -571,6 +572,9 @@ struct bpf_insn_aux_data {
>  	u8 fastcall_spills_num:3;
>  	u8 arg_prog:4;
> =20
> +	/* true if jt->off was allocated */
> +	bool jt_allocated;
> +

This is a leftover from v3, no longer used.

>  	/* below fields are initialized once */
>  	unsigned int orig_idx; /* original instruction index */
>  	bool jmp_point;
> @@ -840,6 +844,8 @@ struct bpf_verifier_env {
>  	struct bpf_scc_info **scc_info;
>  	u32 scc_cnt;
>  	struct bpf_iarray *succ;
> +	u32 *gotox_tmp_buf;
> +	size_t gotox_tmp_buf_size;
>  };

[...]

> @@ -14685,6 +14723,11 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env,
>  				dst);
>  			return -EACCES;
>  		}
> +		if (ptr_to_insn_array) {
> +			verbose(env, "R%d subtraction from pointer to instruction prohibited\=
n",
> +				dst);
> +			return -EACCES;
> +		}

Is anything going to break if subtraction is allowed?
The bounds are still maintained, so seem to be ok.

>  		if (known && (ptr_reg->off - smin_val =3D=3D
>  			      (s64)(s32)(ptr_reg->off - smin_val))) {
>  			/* pointer -=3D K.  Subtract it from fixed offset */

[...]

> @@ -17786,6 +17830,210 @@ static struct bpf_iarray *iarray_realloc(struct=
 bpf_iarray *old, size_t n_elem)
>  	return new;
>  }
> =20
> +#define SET_HIGH(STATE, LAST)	STATE =3D (STATE & 0xffffU) | ((LAST) << 1=
6)
> +#define GET_HIGH(STATE)		((u16)((STATE) >> 16))
> +
> +static int push_gotox_edge(int t, struct bpf_verifier_env *env, struct b=
pf_iarray *jt)
> +{
> +	int *insn_stack =3D env->cfg.insn_stack;
> +	int *insn_state =3D env->cfg.insn_state;
> +	u16 prev;
> +	int w;
> +

push_insn() checks if `t` is in range [0, env->prog->len],
is the same check needed here?

> +	for (prev =3D GET_HIGH(insn_state[t]); prev < jt->off_cnt; prev++) {
> +		w =3D jt->off[prev];
> +		mark_jmp_point(env, w);
> +
> +		/* EXPLORED || DISCOVERED */
> +		if (insn_state[w])
> +			continue;
> +
> +		break;
> +	}
> +
> +	if (prev =3D=3D jt->off_cnt)
> +		return DONE_EXPLORING;
> +
> +	if (env->cfg.cur_stack >=3D env->prog->len)
> +		return -E2BIG;
> +	insn_stack[env->cfg.cur_stack++] =3D w;

I think `insn_state[w] |=3D DISCOVERED;` is missing here.

> +
> +	SET_HIGH(insn_state[t], prev + 1);
> +	return KEEP_EXPLORING;
> +}

[...]

> +static struct bpf_iarray *
> +create_jt(int t, struct bpf_verifier_env *env, int fd)
> +{
> +	static struct bpf_subprog_info *subprog;
> +	int subprog_idx, subprog_start, subprog_end;
> +	struct bpf_iarray *jt;
> +	int i;
> +
> +	if (env->subprog_cnt =3D=3D 0)
> +		return ERR_PTR(-EFAULT);
> +
> +	subprog_idx =3D bpf_find_containing_subprog_idx(env, t);
> +	if (subprog_idx < 0) {
> +		verbose(env, "can't find subprog containing instruction %d\n", t);
> +		return ERR_PTR(-EFAULT);
> +	}

Nit: There is now verifier_bug() for such cases.
     Also, it seems that all bpf_find_containing_subprog() users
     assume that the function can't fail.
     Like in this case, there is already access `jt =3D env->insn_aux_data[=
t].jt;`
     in visit_gotox_insn() that will be an error if `t` is bogus.

> +	subprog =3D &env->subprog_info[subprog_idx];
> +	subprog_start =3D subprog->start;
> +	subprog_end =3D (subprog + 1)->start;
> +	jt =3D jt_from_subprog(env, subprog_start, subprog_end);
> +	if (IS_ERR(jt))
> +		return jt;
> +
> +	/* Check that the every element of the jump table fits within the given=
 subprogram */
> +	for (i =3D 0; i < jt->off_cnt; i++) {
> +		if (jt->off[i] < subprog_start || jt->off[i] >=3D subprog_end) {
> +			verbose(env, "jump table for insn %d points outside of the subprog [%=
u,%u]",
> +					t, subprog_start, subprog_end);
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
> +
> +	return jt;
> +}
> +
> +/* "conditional jump with N edges" */
> +static int visit_gotox_insn(int t, struct bpf_verifier_env *env, int fd)
> +{
> +	struct bpf_iarray *jt;
> +
> +	jt =3D env->insn_aux_data[t].jt;
> +	if (!jt) {
> +		jt =3D create_jt(t, env, fd);
> +		if (IS_ERR(jt))
> +			return PTR_ERR(jt);
> +	}
> +	env->insn_aux_data[t].jt =3D jt;

Nit: move this assignment up into the `if (!jt)` body?

> +
> +	mark_prune_point(env, t);
> +	return push_gotox_edge(t, env, jt);
> +}
> +

I think the following implementation should achieve the same result:

  /* "conditional jump with N edges" */
  static int visit_gotox_insn(int t, struct bpf_verifier_env *env, int fd)
  {
        int *insn_stack =3D env->cfg.insn_stack;
        int *insn_state =3D env->cfg.insn_state;
        bool keep_exploring =3D false;
        struct bpf_iarray *jt;
        int i, w;

        jt =3D env->insn_aux_data[t].jt;
        if (!jt) {
                jt =3D create_jt(t, env, fd);
                if (IS_ERR(ptr: jt))
                        return PTR_ERR(ptr: jt);

                env->insn_aux_data[t].jt =3D jt;
        }

        mark_prune_point(env, idx: t);
        for (i =3D 0; i < jt->off_cnt; i++) {
                w =3D jt->off[i];
                mark_jmp_point(env, idx: w);

                /* EXPLORED || DISCOVERED */
                if (insn_state[w])
                        continue;

                if (env->cfg.cur_stack >=3D env->prog->len)
                        return -E2BIG;

                insn_stack[env->cfg.cur_stack++] =3D w;
                insn_state[w] |=3D DISCOVERED;
                keep_exploring =3D true;
        }

        return keep_exploring ? KEEP_EXPLORING : DONE_EXPLORING;
  }

But w/o GET_HIGH/SET_HIGH things. Wdyt?


[...]

> @@ -19817,6 +20068,103 @@ static int process_bpf_exit_full(struct bpf_ver=
ifier_env *env,
>  	return PROCESS_BPF_EXIT;
>  }
> =20
> +static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
> +				       int regno,
> +				       struct bpf_map *map,
> +				       u32 *pmin_index, u32 *pmax_index)
> +{
> +	struct bpf_reg_state *reg =3D reg_state(env, regno);
> +	u64 min_index, max_index;
> +	const u32 size =3D 8;
> +
> +	if (check_add_overflow(reg->umin_value, reg->off, &min_index) ||
> +		(min_index > (u64) U32_MAX * size)) {
> +		verbose(env, "the sum of R%u umin_value %llu and off %u is too big\n",
> +			     regno, reg->umin_value, reg->off);
> +		return -ERANGE;
> +	}
> +	if (check_add_overflow(reg->umax_value, reg->off, &max_index) ||
> +		(max_index > (u64) U32_MAX * size)) {
> +		verbose(env, "the sum of R%u umax_value %llu and off %u is too big\n",
> +			     regno, reg->umax_value, reg->off);
> +		return -ERANGE;
> +	}
> +
> +	min_index /=3D size;
> +	max_index /=3D size;
> +
> +	if (min_index >=3D map->max_entries || max_index >=3D map->max_entries)=
 {

Nit: it is guaranteed that reg->umin_value <=3D reg->umax_value,
     so checking max_index should be sufficient.

> +		verbose(env, "R%u points to outside of jump table: [%llu,%llu] max_ent=
ries %u\n",
> +			     regno, min_index, max_index, map->max_entries);
> +		return -EINVAL;
> +	}
> +
> +	*pmin_index =3D min_index;
> +	*pmax_index =3D max_index;
> +	return 0;
> +}
> +
> +/* gotox *dst_reg */
> +static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_=
insn *insn)
> +{
> +	struct bpf_verifier_state *other_branch;
> +	struct bpf_reg_state *dst_reg;
> +	struct bpf_map *map;
> +	u32 min_index, max_index;
> +	size_t new_size;
> +	u32 *new_buf;
> +	int err =3D 0;
> +	int n;
> +	int i;
> +
> +	dst_reg =3D reg_state(env, insn->dst_reg);
> +	if (dst_reg->type !=3D PTR_TO_INSN) {
> +		verbose(env, "R%d has type %d, expected PTR_TO_INSN\n",
> +			     insn->dst_reg, dst_reg->type);
> +		return -EINVAL;
> +	}
> +
> +	map =3D dst_reg->map_ptr;
> +	if (verifier_bug_if(!map, env, "R%d has an empty map pointer", insn->ds=
t_reg))
> +		return -EFAULT;
> +
> +	if (verifier_bug_if(map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY, env,
> +			    "R%d has incorrect map type %d", insn->dst_reg, map->map_type))
> +		return -EFAULT;

Are you sure this is a verifier bug?
The program can be written in a way, such that e.g. hash map pointer
is passed as a parameter for gotox, that would be an incorrect program,
not a verifier bug.

> +
> +	err =3D indirect_jump_min_max_index(env, insn->dst_reg, map, &min_index=
, &max_index);
> +	if (err)
> +		return err;
> +
> +	/* Ensure that the buffer is large enough */
> +	new_size =3D sizeof(u32) * (max_index - min_index + 1);
> +	if (env->gotox_tmp_buf_size < new_size) {
> +		new_buf =3D kvrealloc(env->gotox_tmp_buf, new_size, GFP_KERNEL_ACCOUNT=
);
> +		if (!new_buf)
> +			return -ENOMEM;
> +		env->gotox_tmp_buf =3D new_buf;
> +		env->gotox_tmp_buf_size =3D new_size;

Can gotox_tmp_buf be an bpf_iarray instance?
If it can, iarray_realloc() can be reused here.

> +	}
> +
> +	n =3D copy_insn_array_uniq(map, min_index, max_index, env->gotox_tmp_bu=
f);

I still think this might be a problem for big jump tables if gotox is
in a loop body. Can you check a perf report for such scenario?
E.g. 256 entries in the jump table, some duplicates, dispatched in a loop.

> +	if (n < 0)
> +		return n;
> +	if (n =3D=3D 0) {
> +		verbose(env, "register R%d doesn't point to any offset in map id=3D%d\=
n",
> +			     insn->dst_reg, map->id);
> +		return -EINVAL;
> +	}
> +
> +	for (i =3D 0; i < n - 1; i++) {
> +		other_branch =3D push_stack(env, env->gotox_tmp_buf[i],
> +					  env->insn_idx, env->cur_state->speculative);
> +		if (IS_ERR(other_branch))
> +			return PTR_ERR(other_branch);
> +	}
> +	env->insn_idx =3D env->gotox_tmp_buf[n-1];
> +	return 0;
> +}
> +
>  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_st=
ate)
>  {
>  	int err;

[...]

