Return-Path: <bpf+bounces-60881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F80ADE03F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 02:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A11E189B5FB
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 00:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485157261B;
	Wed, 18 Jun 2025 00:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8ra8y+u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4826929A5
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750208239; cv=none; b=VjZH6zv2i2gCrmDt6rCPA28IfUFjERcigr2daFJER9/zjfsQXECiJIbNx3L7HhTeDfZ7fGWxShi4rGr9e8sDqewXL7P48ueR2lBYq/qsn6VqnPBpxwNUfViJJ+KENyZZSny4qhPWkMZXDHpU96xzY3hLv2UEhvEl4WnYNZrdi2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750208239; c=relaxed/simple;
	bh=o+d9OxMWyyzlBJK5ZRxcFl+OCiXvYbfN8yJ3qQotHp4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pPXAwz0wxbVFtn8IkzVlHHdxor+ScUWEIQUUtzLM3jfzF/vI5f06Y8kL90K59ZJmMZOCjbh8nVVwdPSWPiTq9QNJpgVdmTHGiCYkDszyK319mP18AHcnzKvRPq4+0GrJuIWty1LnXP9o84qgp4wOlsOt79rXx0ho8Zrp8QxKi/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8ra8y+u; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b2f603b0ef6so4710887a12.1
        for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 17:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750208237; x=1750813037; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36muuUc2e4HA/TmgS8o7dc8nePVZjU2omftrrz4/E7k=;
        b=Y8ra8y+uPJING56KB35qBw1M4KRBa99S6NY//uY4Bmz5g4XYhHttuE9vJi7adiGFYO
         CxuJT83S1FjaYkJBaAmN0hsiRwUia3ryBisSQWzq54DkGXpxREkNKOxbYS8ovH4OstT2
         DB4NjdLjsnn/Cy07jPfRipNzpTNxigXearRtpAauucqioMLiokcsqXsYAqtV9mUfNJcm
         nZFKJpf8E7+HeGqjZ/V78YouqaqFG5eheBLzL/qM4unf3xu6vSCZf035prJ53nmPqlWl
         UEC4Elc7E40BW+ZzINPzCMwb0UR2/MKMkoEzbqDCitpv4x/Tayrl5pXmnEMU7XozKZUn
         r9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750208237; x=1750813037;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=36muuUc2e4HA/TmgS8o7dc8nePVZjU2omftrrz4/E7k=;
        b=KPc6R8wa7LA9AP3pmX3lOWKrvmGs1DDXXyanC63K+XjLOvtUMTbOJrOwlgnEKbW9hH
         Zn247d8mWWAUYNb8iqSRel1THt5olFcids6zJQQIH9ZviHIlUS6qlzQvscFyR3EzLN1c
         cPQTtxHggU+OV8cWNi/u3p7/yV13sLBz0GicH4mB1vjjSYszvaImADPmvDWg4rWUPMRg
         L/Nr0+aje7Rx2EpHClNiwm7ztwSAIwa5NcIiqsz0AtQIK2OwAQw7VKHNviB2/+5z1cmn
         HWr2txWnPxwebTupej8UPUMiOK68mxu1KS8B+jYBi+TjGKbCl1VLb4i9Ij91GzGCS72u
         EBlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHA2qiLzRp4Y9RKRx7J94iP0P5k8t6KUoGP/DZKV/Bh2nCP8hkJ1Qj60un7k0J7j+5Dzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkfSklKae7r28Xwo5ePNQVwLxnNX8nSaGtHYZpjhwAyUTwqiR
	BAJatF5OJHCCtl5HMztwFTeUmZFl2AYLtNavUTJOsGmXIzpGGr2YFhLw
X-Gm-Gg: ASbGnctDAHz5hbCoEs7iuCJAQ5mC61VFq+eqUKH2c0oOTlUXnl+fBFO4eW+ky5BByPq
	wE4tLfpYZYXPOBXmyqnmUlMIFBbZI/bdTC0tjOYdAjnxbcJgzl4P6DwgdwF/czqXvkF8WX0sPb6
	Lc3GJ2UeKnrZzXPHCiOD2iLjmPc9bOYcLHHEDJKGu/YtnGEYUtOdh4FWNmmOYpm8/I3DSaSr5ak
	mcmfBusDH48Um91IgPKoMJ9Ukjnj5w9+5ZZphOZq9wI2sWvGFntVHALr9cs2jChSCHeMQdrvICy
	Dk7ZuvYfoov7dylxZT0BEG4XrtCdxgp+UauGXPpxmReNGJ545SLAat+J6GknCP4f/3gz
X-Google-Smtp-Source: AGHT+IFUCfAsOWcfyOKDeQJr/YBVmSfbqdLArgxngw9Dwe/uUkVZ+68i8YnL2bJxfs6pPDVzAj3IMw==
X-Received: by 2002:a17:90b:35c9:b0:311:ffe8:20e9 with SMTP id 98e67ed59e1d1-313f1cb52c3mr25044862a91.17.1750208237337;
        Tue, 17 Jun 2025 17:57:17 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::247? ([2620:10d:c090:600::1:8e91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c6ab91sm11405251a91.48.2025.06.17.17.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 17:57:17 -0700 (PDT)
Message-ID: <7edb47e73baa46705119a23c6bf4af26517a640f.camel@gmail.com>
Subject: Re: [RFC bpf-next 2/9] bpf, x86: add new map type: instructions set
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Tue, 17 Jun 2025 17:57:15 -0700
In-Reply-To: <20250615085943.3871208-3-a.s.protopopov@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
	 <20250615085943.3871208-3-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:

Meta: "instruction set" is a super confusing name, at-least for me the
      first thought is about actual set of instructions supported by
      some h/w. instruction_info? instruction_offset? just
      "iset"/"ioffset"?

[...]

> On map creation/initialization, before loading the program, each
> element of the map should be initialized to point to an instruction
> offset within the program. Before the program load such maps should
> be made frozen. After the program verification xlated and jitted
> offsets can be read via the bpf(2) syscall.

I think such maps would be a bit more ergonomic it original
instruction index would be saved as well, e.g:

  (original_offset, xlated_offset, jitted_offset)

Otherwise user would have to recover original offset from some
external mapping. This information is stored in orig_xlated_off
anyway.

[...]

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 15672cb926fc..923c38f212dc 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1615,6 +1615,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image

[...]

> @@ -2642,6 +2645,14 @@ st:			if (is_imm8(insn->off))
>  				return -EFAULT;
>  			}
>  			memcpy(rw_image + proglen, temp, ilen);
> +
> +			/*
> +			 * Instruction sets need to know how xlated code
> +			 * maps to jited code
> +			 */
> +			abs_xlated_off =3D bpf_prog->aux->subprog_start + i - 1 - adjust_off;

Nit: `adjust_off` is a bit hard to follow, maybe move the following:

	abs_xlated_off =3D bpf_prog->aux->subprog_start + i - 1;

     to the beginning of the loop?

> +			bpf_prog_update_insn_ptr(bpf_prog, abs_xlated_off, proglen, ilen,
> +						 jmp_offset, image + proglen);

Nit: initialize `jmp_offset` at each loop iteration to 0?
     otherwise it would denote jump offset of the last processed
     jump instruction for all following non-jump instructions.

>  		}
>  		proglen +=3D ilen;
>  		addrs[i] =3D proglen;
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8189f49e43d6..008bcd44c60e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3596,4 +3596,25 @@ static inline bool bpf_is_subprog(const struct bpf=
_prog *prog)
>  	return prog->aux->func_idx !=3D 0;
>  }
>
> +int bpf_insn_set_init(struct bpf_map *map, const struct bpf_prog *prog);
> +int bpf_insn_set_ready(struct bpf_map *map);
> +void bpf_insn_set_release(struct bpf_map *map);
> +void bpf_insn_set_adjust(struct bpf_map *map, u32 off, u32 len);
> +void bpf_insn_set_adjust_after_remove(struct bpf_map *map, u32 off, u32 =
len);
> +
> +struct bpf_insn_ptr {

Could you please add comments describing each field?
E.g.: "address of the instruction in the jitted image",
      "for jump instructions, the relative offset of the jump target",
      "index of the original instruction",
      "original value of the corresponding bpf_insn_set_value.xlated_off".

> +	void *jitted_ip;
> +	u32 jitted_len;
> +	int jitted_jump_offset;
> +	struct bpf_insn_set_value user_value; /* userspace-visible value */
> +	u32 orig_xlated_off;
> +};

[...]

> diff --git a/kernel/bpf/bpf_insn_set.c b/kernel/bpf/bpf_insn_set.c
> new file mode 100644

[...]

> +static int insn_set_check_btf(const struct bpf_map *map,
> +			      const struct btf *btf,
> +			      const struct btf_type *key_type,
> +			      const struct btf_type *value_type)
> +{
> +	u32 int_data;
> +
> +	if (BTF_INFO_KIND(key_type->info) !=3D BTF_KIND_INT)
> +		return -EINVAL;
> +
> +	if (BTF_INFO_KIND(value_type->info) !=3D BTF_KIND_INT)
> +		return -EINVAL;
> +
> +	int_data =3D *(u32 *)(key_type + 1);

Nit: use btf_type_int() accessor?

> +	if (BTF_INT_BITS(int_data) !=3D 32 || BTF_INT_OFFSET(int_data))
> +		return -EINVAL;
> +
> +	int_data =3D *(u32 *)(value_type + 1);
> +	if (BTF_INT_BITS(int_data) !=3D 32 || BTF_INT_OFFSET(int_data))

Should this check for `BTF_INT_BITS(int_data) !=3D 64`?

> +		return -EINVAL;
> +
> +	return 0;
> +}

[...]

> +int bpf_insn_set_init(struct bpf_map *map, const struct bpf_prog *prog)
> +{
> +	struct bpf_insn_set *insn_set =3D cast_insn_set(map);
> +	int i;
> +
> +	if (!is_frozen(map))
> +		return -EINVAL;
> +
> +	if (!valid_offsets(insn_set, prog))
> +		return -EINVAL;
> +
> +	/*
> +	 * There can be only one program using the map
> +	 */
> +	mutex_lock(&insn_set->state_mutex);
> +	if (insn_set->state !=3D INSN_SET_STATE_FREE) {
> +		mutex_unlock(&insn_set->state_mutex);
> +		return -EBUSY;
> +	}
> +	insn_set->state =3D INSN_SET_STATE_INIT;
> +	mutex_unlock(&insn_set->state_mutex);
> +
> +	/*
> +	 * Reset all the map indexes to the original values.  This is needed,
> +	 * e.g., when a replay of verification with different log level should
> +	 * be performed.
> +	 */
> +	for (i =3D 0; i < map->max_entries; i++)
> +		insn_set->ptrs[i].user_value.xlated_off =3D insn_set->ptrs[i].orig_xla=
ted_off;
> +
> +	return 0;
> +}
> +
> +int bpf_insn_set_ready(struct bpf_map *map)

What is the reasoning for not needing to take the mutex here and in
the bpf_insn_set_release?

> +{
> +	struct bpf_insn_set *insn_set =3D cast_insn_set(map);
> +	int i;
> +
> +	for (i =3D 0; i < map->max_entries; i++) {
> +		if (insn_set->ptrs[i].user_value.xlated_off =3D=3D INSN_DELETED)
> +			continue;
> +		if (!insn_set->ips[i])
> +			return -EFAULT;
> +	}
> +
> +	insn_set->state =3D INSN_SET_STATE_READY;
> +	return 0;
> +}
> +
> +void bpf_insn_set_release(struct bpf_map *map)
> +{
> +	struct bpf_insn_set *insn_set =3D cast_insn_set(map);
> +
> +	insn_set->state =3D INSN_SET_STATE_FREE;
> +}

[...]

(... I'll continue reading through patch-set a bit later ...)

