Return-Path: <bpf+bounces-71638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAA5BF8EC4
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 23:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202735622D8
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A70B28506A;
	Tue, 21 Oct 2025 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB9nLaqz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306327FB2B
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081472; cv=none; b=OKmzaUdX3MwVfZY4zHuLdd5n3t6bH+9ySmMMlky2Bo/Eu84lZtdu6Rqgp7Qw99yBMcFqlv9TaVohatcVrpC0NBBuussT9E4QiFgWAhhZtJLs1DgriW2mZEdNwPldxbR8bEUmk5sodQekJ+6JsV0e7JL43Pq3fpGASjCUstn8GDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081472; c=relaxed/simple;
	bh=bIZGe/+gdpEbQoy5XF6P5z0NqhIIPcsgrDsy6kHACBc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EnMtAjZ1E4mJmm8nIzL/UOCCooJlTOIjc3tiGcaf4tcSl2CSew/r0AhBYM1Z5D59bLKALQDLvI3t8tkPcWCJ8sNykwryCHQCWRuv9iLwkziFqQGpZgaExf34OpF4KgFhn/5m01CCYzONwuaZnKoIX+2hp07MfkbRI4TGw7QqxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB9nLaqz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6cdba26639so237548a12.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 14:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761081470; x=1761686270; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9kRpaQVlP63a5dmysLH9EoAhw5X3f72JDHT/+FslWA=;
        b=GB9nLaqz/rDysEa20SeBs41iyu9oTjjhwEsEPzZjJe9BCTKc25WvfcpFfXD8diEVf3
         GWTNDju42p2anmUVYx2OgLNO+r9GJGo8j/F3VuBCCDzWgHkkAfcFKoklfiaEFTRP7xT7
         38wUflZmQCltolTHtIq8/n9G65DqmArMWodwvNsQUJdgLyrFAGt+KjHa9RwswtwD6AwP
         nf9pn6gUh6+ZqRVppompxtFDyBgR1kvdJofIvqqkbcQr4KLsHzZyquqoa+EiADFvtxPx
         h+zhjU8rXJKX2tVfSwj4buf29+BadJYtb0GOhJK3hjCVYzB4wy+pVU0Qm56gUb5THcqV
         k78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761081470; x=1761686270;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q9kRpaQVlP63a5dmysLH9EoAhw5X3f72JDHT/+FslWA=;
        b=YYg+tdoPJwr4j1CxnGTRc+UJU3kRzToMA/cOB6WGGiNLDN//gDkfE79QQmrJNsPwbv
         8SHtViE6eTM6nPKrS08jyA3F4pWlyMGtYN1OPjRjON1idMLRcHlrDdus4yfaAYibZtIa
         /xl6iWovpj8D2hSccZDOCaJlpmM0HnE/cuSH9lJ4ePcMRaF0hPJNXq1DclGL4ycgeWph
         dfVW/0i7y+hl/IEv3g9SWxoMvttAp8zXwhQBOh8brxyyoA0rOACM02zpGbo2bIW3plCc
         M1HEzBGtsmPTe36DmstJOmCFK8kFoxwNsqQ7OiFObS7nNI2a8TZeuzuobqtlcfydm0Gh
         sGhg==
X-Forwarded-Encrypted: i=1; AJvYcCX3WlDSGl+VLIioKZHpbnmkDdycLe1Tal1EBXoY9Bi3KmiQKqZaqD7bitOQfO9oXsTgMQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykaOK2H8YJ9ePb9dQMoroPthlp4wIV3sEh/YurTCqNI6d3cTuD
	GDfRMWJDPnWyUcelA2zNl/L9MjjlhbbWQAspCJIe30JL2yeCyGw7RHpI
X-Gm-Gg: ASbGnctNLRaDw/pE+Cm4ZUTSoTTDs/RkW0+hma9QfHQ0Thfx/aAYGah3cweyS3yWr3E
	S7nMKwlKvV6ZeDewwYc2nJN+x/eQlHZddePUmHNd9HbvM7t1VcHrVV9Cm1YWOqqzlBP5e/Zdjko
	VMrCT70yeM3MpVmwYgIMEG/e3NtcF/dlz5Gv8W5PUeJCeY/X1VwBpE8lTwu4UtC5vyTuhnj/EXi
	Wszw9qAYxyEfsusk20GebuGNs5k+yJqV3+ruC+SOJLsJpJ1hNshvyw1JtsLn1H6viwoUtcYWowu
	ff1AfKVl8kULRSq4nfnYsgAN2OXuYMTgegZGNkJiQBFyRiJTiNG0UqC/i42lQz1e3I9qldDqTJp
	8+zV5i0MIp3HW99ekBrTgPSf2N4an9J7uwMUMQvnhfFdnONpnsoDTHSmjVKxzLLxQFCVghp6/fa
	C2ZRcUbnyujuyE2Ilx3+R16Qb71zPzAuyxU7z6IqqH6WZ0aw==
X-Google-Smtp-Source: AGHT+IEMYv9/nkq5lwPTqCk+d0QO7MjqbikfosmYeH5tvg+T7ZSZcPiq0gCGk4vxMGgwRurJs79uyw==
X-Received: by 2002:a17:903:249:b0:267:44e6:11d6 with SMTP id d9443c01a7336-292ffba4632mr13315765ad.6.1761081469705;
        Tue, 21 Oct 2025 14:17:49 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247223a3csm118280915ad.112.2025.10.21.14.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 14:17:49 -0700 (PDT)
Message-ID: <c3de352f15a5004c48f4b37bfb4294f6602ec644.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 10/17] bpf, x86: add support for indirect
 jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Tue, 21 Oct 2025 14:17:48 -0700
In-Reply-To: <20251019202145.3944697-11-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
	 <20251019202145.3944697-11-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
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

LGTM, please, address a few remaining points.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ae017c032944..d2df21fde118 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> +static struct bpf_iarray *
> +create_jt(int t, struct bpf_verifier_env *env, int fd)
  		    	   		    	  ^^^^^^
				   This parameter is unused
> +{
> +	static struct bpf_subprog_info *subprog;
> +	int subprog_start, subprog_end;
> +	struct bpf_iarray *jt;
> +	int i;
> +
> +	subprog =3D bpf_find_containing_subprog(env, t);
> +	subprog_start =3D subprog->start;
> +	subprog_end =3D (subprog + 1)->start;
> +	jt =3D jt_from_subprog(env, subprog_start, subprog_end);
> +	if (IS_ERR(jt))
> +		return jt;
> +
> +	/* Check that the every element of the jump table fits within the given=
 subprogram */
> +	for (i =3D 0; i < jt->cnt; i++) {
> +		if (jt->items[i] < subprog_start || jt->items[i] >=3D subprog_end) {
> +			verbose(env, "jump table for insn %d points outside of the subprog [%=
u,%u]",
> +					t, subprog_start, subprog_end);
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
> +
> +	return jt;
> +}

[...]

> +/* gotox *dst_reg */
> +static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_=
insn *insn)
> +{
> +	struct bpf_verifier_state *other_branch;
> +	struct bpf_reg_state *dst_reg;
> +	struct bpf_map *map;
> +	u32 min_index, max_index;
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

Nit: we discussed this in v5, let's drop the verifier_bug_if() and
     return -EINVAL?

     > The program can be written in a way, such that e.g. hash map
     > pointer is passed as a parameter for gotox, that would be an
     > incorrect program, not a verifier bug.

     Also, use reg_type_str() instead of "type %d"?

> +
> +	err =3D indirect_jump_min_max_index(env, insn->dst_reg, map, &min_index=
, &max_index);
> +	if (err)
> +		return err;
> +
> +	/* Ensure that the buffer is large enough */
> +	if (!env->gotox_tmp_buf || env->gotox_tmp_buf->cnt < max_index - min_in=
dex + 1) {
> +		env->gotox_tmp_buf =3D iarray_realloc(env->gotox_tmp_buf,
> +						    max_index - min_index + 1);
> +		if (!env->gotox_tmp_buf)
> +			return -ENOMEM;
> +	}
> +
> +	n =3D copy_insn_array_uniq(map, min_index, max_index, env->gotox_tmp_bu=
f->items);

Nit: let's not forget about a follow-up to remove this allocation.

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
> +		other_branch =3D push_stack(env, env->gotox_tmp_buf->items[i],
> +					  env->insn_idx, env->cur_state->speculative);
> +		if (IS_ERR(other_branch))
> +			return PTR_ERR(other_branch);
> +	}
> +	env->insn_idx =3D env->gotox_tmp_buf->items[n-1];
> +	return 0;
> +}
> +

[...]

