Return-Path: <bpf+bounces-65950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4843BB2B648
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BDC627889
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1771FA272;
	Tue, 19 Aug 2025 01:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBiDlkIz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9291798F
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 01:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567297; cv=none; b=XRYvfU4TRSHvtbwFFmyC9HWyOQzkL6Xep1mU1tad1F3lLZEEiVPnRx19QyQWPrp8fpKNwr/SLeKo3j1m0IKtyz6oPICvDFqOeJ2EPEpKdNVJp4EK9HEBB1p6YbF4CSn533YKidByoZ+e0pCzl3KfDueVuaL7x44fLqrc9BfmZvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567297; c=relaxed/simple;
	bh=ameQ824fqvOyPqTx2W7ukmwIE0CwWVg4uTeUvR7FgUs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KM7uVpieagTrG4a+9AmjEVhrud/wZVxqhsiWutaXJVp9LF7NYOVHX9YaQn25rOfv/kzB+/5hHMoAfWFXNWV1vUgIKot2amX5Ll5A+jJKD6rlOUJkwy7ieGIqeYGOXT/H+pY/PjtmKp6/4PxWzS7SuZnx6BpeVyYGGHOXRtQjICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBiDlkIz; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b471737b347so3267874a12.1
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 18:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755567295; x=1756172095; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ixkWX/jO7TL2xM0m357bxOR7ddRwWjbORGMuaV5xrM=;
        b=fBiDlkIzGjJablxkekcy2mrjsDl7t6ZJP8qc5Px5Koy32K+AIBpY4WmBmrdsRotjCe
         ad+XcrUuWMzrqDUn6pKF0pRIRnYBn2nRP1SkNi7kQXdba+UVpfCZVZ8DKA2TExcNsflP
         bK8uwF9ufA6/IicwQDO7QbLasRTnWMHs96cDkf/lvlYrBLtIyjpIuSYZVziO/rb82t7w
         lpt2DttDdRfwwfaVYAu42EAyCcaiqcN0/AN/KX8lu+U/JyNrHE4t3YQw/x68YlIHnopD
         NZiz+E/dLwWASdJVDoJMyScEwacxFUEAFa2pXby8Kur1ADPxmvvt819K6HQsLitrMc5U
         97ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567295; x=1756172095;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ixkWX/jO7TL2xM0m357bxOR7ddRwWjbORGMuaV5xrM=;
        b=fytHGsnFj1r8grgz7cf2qeNz9L5yr807vada8KO/4yB1it/X568r93d6HHBJeIOlW0
         7pr2+BuLXG/5xGB+d82cR/iCXu8GHaQXbPMh5NtEDGln5PMp/yctp11WroERfQi4ujVn
         /2PEXB2m1cI+8ShtGP4KdtXsSM58e3gXwGcFajO4zcVdo0xunbonU8PQoO5RbCbk6HCk
         ru0v8xC3Qwkh0y+2SIlCm195YEeDPTlGuqQzloPVvoqTEnP+hrYWfrfS0J9Ekt2XkifV
         eQKOPOj7iFoWVDCC0wyiQqzr25ykuwBQ5cl763zRo/yz23QIuqhTSAuyoDGM3oH1i077
         uISw==
X-Forwarded-Encrypted: i=1; AJvYcCVtTsvwVbk6Ebaw20ZcQ7lQrxS5t8h1FdYYlQs17/LvzsBJqnmniY1ywE5zPnnHGOHfjTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSivrVLeQ/FO0Vea3SsYcyClnV2VFIuCM/TJ4Nf9QaC+mUNQb
	b0S1R1Y1w2L/0AcoeHJDJ7CF9ZqRVSrotEgDDj2Rxl++vPQol4ejXTvk
X-Gm-Gg: ASbGncvzJmFOWxVZUNhJq/VCb56vFDqSYxgoE/rwuxijlLHpXVcbNGEiIA+g8DhLD3f
	aDyWFItAnDxs8VBAiNuMPGlqVw8IKW/HHVbM7EP3pWpY0hrOO7+WELYbHeKSpjFCkY6jLeoEVEd
	zytyXqpcIvks0h76ZCeg1HVw3c9pmtf/VHAx/Rer9maq3Cv6rWqk0xLDGNir6pwu0MsaIITPl4O
	IR/ix2U6PwN58/ID2cDf+c+9w4hFDYyIE7Og+SS4wGZFrL3eXFzTZU3yhEyn9YoSqSPEEEmtEck
	TOa3eqDcui+5feEH5me2064ePg5sUB+8KkBmvy8MlKvrMNBMoxb3HkaBYskII/lalIMDVo1+R+q
	yx/MmYfsMKzeGQRo+7DiMIFaznHoAXR2FqVo1
X-Google-Smtp-Source: AGHT+IFWSkG6xo3LDPYrZtOYLSP+dCOigIwM9DL5m8Yj48T/LPOwqXxzNKhMnYvhAh/PXEY0yLtGPw==
X-Received: by 2002:a17:902:eccf:b0:240:934f:27ac with SMTP id d9443c01a7336-245e049d32fmr11153985ad.33.1755567294420;
        Mon, 18 Aug 2025 18:34:54 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::f? ([2620:10d:c090:600::1:e786])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d578aa4sm92119505ad.153.2025.08.18.18.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 18:34:54 -0700 (PDT)
Message-ID: <5be3791aa3fe268a8da6ef2e4691a13e7947f805.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: bpf task work plumbing
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 18 Aug 2025 18:34:52 -0700
In-Reply-To: <20250815192156.272445-2-mykyta.yatsenko5@gmail.com>
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
	 <20250815192156.272445-2-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-15 at 20:21 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> This patch adds necessary plumbing in verifier, syscall and maps to
> support handling new kfunc bpf_task_work_schedule and kernel structure
> bpf_task_work. The idea is similar to how we already handle bpf_wq and
> bpf_timer.
> verifier changes validate calls to bpf_task_work_schedule to make sure
> it is safe and expected invariants hold.
> btf part is required to detect bpf_task_work structure inside map value
> and store its offset, which will be used in the next patch to calculate
> key and value addresses.
> arraymap and hashtab changes are needed to handle freeing of the
> bpf_task_work: run code needed to deinitialize it, for example cancel
> task_work callback if possible.
> The use of bpf_task_work and proper implementation for kfuncs are
> introduced in the next patch.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Amount of copy-paste necessary for dealing with objects btf is saddening.
This patch follows current approach and seem to do it correctly.

[...]

> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -431,7 +431,7 @@ static void *array_map_vmalloc_addr(struct bpf_array =
*array)
>  	return (void *)round_down((unsigned long)array, PAGE_SIZE);
>  }
> =20
> -static void array_map_free_timers_wq(struct bpf_map *map)
> +static void array_map_free_internal_structs(struct bpf_map *map)
>  {
>  	struct bpf_array *array =3D container_of(map, struct bpf_array, map);
>  	int i;
> @@ -439,12 +439,14 @@ static void array_map_free_timers_wq(struct bpf_map=
 *map)
>  	/* We don't reset or free fields other than timer and workqueue
>  	 * on uref dropping to zero.
>  	 */
> -	if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE)) {
> +	if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE | BPF_T=
ASK_WORK)) {

Is there a way to share this code between array map and hash map?

>  		for (i =3D 0; i < array->map.max_entries; i++) {
>  			if (btf_record_has_field(map->record, BPF_TIMER))
>  				bpf_obj_free_timer(map->record, array_map_elem_ptr(array, i));
>  			if (btf_record_has_field(map->record, BPF_WORKQUEUE))
>  				bpf_obj_free_workqueue(map->record, array_map_elem_ptr(array, i));
> +			if (btf_record_has_field(map->record, BPF_TASK_WORK))
> +				bpf_obj_free_task_work(map->record, array_map_elem_ptr(array, i));
>  		}
>  	}
>  }

[...]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 64739308902f..378f260235dd 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3527,6 +3527,15 @@ static int btf_get_field_type(const struct btf *bt=
f, const struct btf_type *var_
>  			goto end;
>  		}
>  	}
> +	if (field_mask & BPF_TASK_WORK) {
> +		if (!strcmp(name, "bpf_task_work")) {
> +			if (*seen_mask & BPF_TASK_WORK)
> +				return -E2BIG;
> +			*seen_mask |=3D BPF_TASK_WORK;
> +			type =3D BPF_TASK_WORK;
> +			goto end;
> +		}
> +	}

Nit: extract this and ifs before it as a loop over array
     of name/flag pairs?

>  	field_mask_test_name(BPF_LIST_HEAD, "bpf_list_head");
>  	field_mask_test_name(BPF_LIST_NODE, "bpf_list_node");
>  	field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");

[...]

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 71f9931ac64c..207ad4823b5b 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[...]

> @@ -233,6 +233,9 @@ static void htab_free_prealloced_timers_and_wq(struct=
 bpf_htab *htab)
>  		if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
>  			bpf_obj_free_workqueue(htab->map.record,
>  					       htab_elem_value(elem, htab->map.key_size));
> +		if (btf_record_has_field(htab->map.record, BPF_TASK_WORK))
> +			bpf_obj_free_task_work(htab->map.record,
> +					       htab_elem_value(elem, htab->map.key_size));

If there is no generic way to share this code with array maps,
please, at-least within the hashmap.c extract these "if (btf_record_has_fie=
ld(...)) {...}"
groups so that there is no duplication between
htab_free_{malloced,preallocated}_internal_structs(htab).

>  		cond_resched();
>  	}
>  }

[...]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0fbfa8532c39..108d86f7eeaf 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[...]

> @@ -1309,6 +1322,14 @@ static int map_check_btf(struct bpf_map *map, stru=
ct bpf_token *token,
>  					goto free_map_tab;
>  				}
>  				break;
> +			case BPF_TASK_WORK:

This can be added to the group with BPF_TIMER and BPF_WORKQUEUE just above.

> +				if (map->map_type !=3D BPF_MAP_TYPE_HASH &&
> +				    map->map_type !=3D BPF_MAP_TYPE_LRU_HASH &&
> +				    map->map_type !=3D BPF_MAP_TYPE_ARRAY) {
> +					ret =3D -EOPNOTSUPP;
> +					goto free_map_tab;
> +				}
> +				break;
>  			default:
>  				/* Fail if map_type checks are missing for a field type */
>  				ret =3D -EOPNOTSUPP;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a61d57996692..be7a744c7917 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

This function repeats process_timer_func() almost verbatim.

> +{
> +	struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regno];
> +	struct bpf_map *map =3D reg->map_ptr;
> +	bool is_const =3D tnum_is_const(reg->var_off);
> +	u64 val =3D reg->var_off.value;
> +
> +	if (!map->btf) {
> +		verbose(env, "map '%s' has to have BTF in order to use bpf_task_work\n=
",
> +			map->name);
> +		return -EINVAL;
> +	}
> +	if (!btf_record_has_field(map->record, BPF_TASK_WORK)) {
> +		verbose(env, "map '%s' has no valid bpf_task_work\n", map->name);
> +		return -EINVAL;
> +	}
> +	if (!is_const) {
> +		verbose(env,
> +			"bpf_task_work has to be at the constant offset\n");
> +		return -EINVAL;
> +	}
> +	if (map->record->task_work_off !=3D val + reg->off) {
> +		verbose(env,
> +			"off %lld doesn't point to 'struct bpf_task_work' that is at %d\n",
> +			val + reg->off, map->record->task_work_off);
> +		return -EINVAL;
> +	}
> +	if (meta->map.ptr) {
> +		verifier_bug(env, "Two map pointers in a bpf_task_work kfunc");
> +		return -EFAULT;
> +	}
> +
> +	meta->map.uid =3D reg->map_uid;
> +	meta->map.ptr =3D map;
> +	return 0;
> +}
> +
>  static int process_kptr_func(struct bpf_verifier_env *env, int regno,
>  			     struct bpf_call_arg_meta *meta)
>  {

[...]

