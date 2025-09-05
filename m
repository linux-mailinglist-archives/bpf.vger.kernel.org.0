Return-Path: <bpf+bounces-67655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00013B46703
	for <lists+bpf@lfdr.de>; Sat,  6 Sep 2025 01:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5DE5C1C5C
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BBC2BE629;
	Fri,  5 Sep 2025 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUY2g217"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2424DCE5
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757113805; cv=none; b=sQwTmeDD3xezjD6gr9XrlWQsJUgdJsbhz4IvarJgUB3ClH/IhQChKp6lRMV46qe8knjpO4i+V9k8ZLiL8k4tyu0X1b2I9XEUE4zG1bHUKiXxPDVCIfhFBHG18RNEOCmiR3+B+gPhZ7piApCKcZAxhO/A2jm2gtccPEM/6XxVMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757113805; c=relaxed/simple;
	bh=AAwt325vkQT7/8eCqof5zs3LBkoeg3CKk2semkjgypA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N0KEsVcNUBnG0p/L2Fz5qcr8UfTYQQCPjQPDh2YdE5/7+mDEoyYKJfWQJj4hqUkMiPy7OV4kNG7xyBUEWL/9AWCuEpuoj9+zc7SQxeM9NOiXzavzjnbQqqoRCv9CE6q3oFvM/EQa/b3sJ8zNRYfRTIGwSSI8HSkjgfmpGOFFac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUY2g217; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24879ed7c17so21127975ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 16:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757113803; x=1757718603; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=71PAfTiLkSBGMvHWW4zhg34iUBol2zun7w/KBUUGxEY=;
        b=nUY2g217001+OH5Ti2tHM93og2gZAwY6V1nUu2Gclys7pXKKGk/GHuf8rWFqaS7YhV
         U66IJRZRps057v8FO2u1V3QapDdu+F1e1IGJVRjr3bP9C9KXQCgaGwh1bJst1RUjVHiJ
         FoI2V4EgD3hpaIW6EB9fMMg6J3EUSQgc+hOksjrxCU4MgYBHJEPq0sl+9gwYJj0CNsFO
         RGB2Vm1jr/I4Wqk7ncZ+apWJMJX+G57UzkR1fehWXlEYAdx1Ziny4RAdoti5X1ot+PFF
         Bq7OP/IVT0ntw9wnYAzxQyoyA/vyO649ckP184CLI6mS2tHq6rQNkIDIYU/FPqqOedat
         lLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757113803; x=1757718603;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71PAfTiLkSBGMvHWW4zhg34iUBol2zun7w/KBUUGxEY=;
        b=W8QAkVMt4JITosaS20A6AXLErVKbInJUi41sGDTumr0Ppb1BW4bGI95wBF283vbKKu
         /JuO0CNAGOxw/j/y+i/sH65ntq1QNyJJe2T69sfAVDoZ5jRdGIosE+MRc9sMYn7UiNl6
         +DITAFk/oAa8uCgBl32VgBiWIxQxzFRKGYsMuLvXYDW8rsOiZiJQILWGwBcvnJTkJWzi
         yIgfeB893codIKoP9Crf1+obMdw4of3jEF8ttbWsNG2RWU7fKcoVJvTrhI1ymi3D8Aoc
         iwqENkZD+YXbpwwx1Dk9rq8tYmzGwOaWa9eRE0VlezC4SNitkCHzxtzflWHPU+JQ+xhY
         +7zg==
X-Forwarded-Encrypted: i=1; AJvYcCU/w1N61KI8YaVhmt6Iz+SDkkmulFs63K6C7zTiz6BLqN0uhsuSoZfEGF1xNebT21SLsvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxklG/suCBCeB2BwqfMChUdR9pL+YDVGjU2v6Y+twGF8gEET0lM
	6Ix7NjC6DQ24ubJXjI/NQ7zAojiDaWTgXUvRutxKziX8nZIfNYjQviOq
X-Gm-Gg: ASbGncvkRsMUO5bTmj1hJb0QiMpBAetzqzLAxdMTDl0lLyM2IXf8kEjl+NEQf29jfqH
	bAWixnBjF1NXQ6mmyYw8SVLcWLPN71vuCed2FaKO26DxfCR+C98B14bzm0We+3wwJrSYvJ/014z
	kOWghDzMclRCElXji9Rt2YR1kvmFYyg2bLJRrGajK2h9iyMO/q8bKZcqEhtnaw/NBJoItQ2HLpo
	geXWLni/k8pcUu5mCvol0DVvCxCTei4A2RaI5rFCvnwBKle6aJb62CDmVMP6kEjxZfWWLIw91xn
	sTrEvb5hMWcrnKZAl+G4SJo84z3QuJejPFwLVvdw3uHyax6IsTq1on68dM9ImaWri5JEC6X59ly
	Lc4If5+YU3r1nuOb/o6BNygWyzRnBEHT5fZiihuU=
X-Google-Smtp-Source: AGHT+IEFqfXnSpfYCRDYWlYDlbQ2vD2IJpMeZrglczPRem1Nx++PVAa1LF9FR0/cpcM2HQc15HBM8w==
X-Received: by 2002:a17:902:ef11:b0:242:9bc5:31a0 with SMTP id d9443c01a7336-25174ff5f3dmr4759315ad.56.1757113802694;
        Fri, 05 Sep 2025 16:10:02 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da3c38sm222931975ad.91.2025.09.05.16.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 16:10:02 -0700 (PDT)
Message-ID: <c67790c49ae9ce4e1f34df324ab0b217ab867f03.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf: bpf task work plumbing
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 05 Sep 2025 16:09:58 -0700
In-Reply-To: <20250905164508.1489482-5-mykyta.yatsenko5@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-5-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:

[...]

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 3d080916faf9..4130d8e76dff 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c

[...]

> @@ -439,12 +439,14 @@ static void array_map_free_timers_wq(struct bpf_map=
 *map)
>  	/* We don't reset or free fields other than timer and workqueue
>  	 * on uref dropping to zero.
>  	 */
> -	if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE)) {
> +	if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE | BPF_T=
ASK_WORK)) {

I think that hashtab.c:htab_free_internal_structs needs to be renamed
and called here, thus avoiding code duplication.

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
> index a1a9bc589518..73ca21911b30 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[...]

> @@ -4034,6 +4037,10 @@ struct btf_record *btf_parse_fields(const struct b=
tf *btf, const struct btf_type
>  		case BPF_LIST_NODE:
>  		case BPF_RB_NODE:
>  			break;
> +		case BPF_TASK_WORK:
> +			WARN_ON_ONCE(rec->task_work_off >=3D 0);
> +			rec->task_work_off =3D rec->fields[i].offset;
> +			break;

Nit: let's move this case up to BPF_WORKQUEUE or BPF_REFCOUNT,
     so that similar cases are grouped together.

>  		default:
>  			ret =3D -EFAULT;
>  			goto end;

[...]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0fbfa8532c39..7da1ca893dfe 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[...]

> @@ -840,6 +849,9 @@ void bpf_obj_free_fields(const struct btf_record *rec=
, void *obj)
>  				continue;
>  			bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);
>  			break;
> +		case BPF_TASK_WORK:
> +			bpf_task_work_cancel_and_free(field_ptr);
> +			break;

Nit: same here, let's keep similar cases together.

>  		case BPF_LIST_NODE:
>  		case BPF_RB_NODE:
>  		case BPF_REFCOUNT:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a5d19a01d488..6152536a834f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2240,6 +2240,8 @@ static void mark_ptr_not_null_reg(struct bpf_reg_st=
ate *reg)
>  				reg->map_uid =3D reg->id;
>  			if (btf_record_has_field(map->inner_map_meta->record, BPF_WORKQUEUE))
>  				reg->map_uid =3D reg->id;
> +			if (btf_record_has_field(map->inner_map_meta->record, BPF_TASK_WORK))
> +				reg->map_uid =3D reg->id;

Nit: this can be shorter:

			if (btf_record_has_field(map->inner_map_meta->record,
						 BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK))
				reg->map_uid =3D reg->id;


>  		} else if (map->map_type =3D=3D BPF_MAP_TYPE_XSKMAP) {
>  			reg->type =3D PTR_TO_XDP_SOCK;
>  		} else if (map->map_type =3D=3D BPF_MAP_TYPE_SOCKMAP ||

[...]

> @@ -10943,6 +10956,35 @@ static int set_rbtree_add_callback_state(struct =
bpf_verifier_env *env,
>  	return 0;
>  }
> =20
> +static int set_task_work_schedule_callback_state(struct bpf_verifier_env=
 *env,
> +						 struct bpf_func_state *caller,
> +						 struct bpf_func_state *callee,
> +						 int insn_idx)
> +{
> +	struct bpf_map *map_ptr =3D caller->regs[BPF_REG_3].map_ptr;
> +
> +	/*
> +	 * callback_fn(struct bpf_map *map, void *key, void *value);
> +	 */
> +	callee->regs[BPF_REG_1].type =3D CONST_PTR_TO_MAP;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
> +	callee->regs[BPF_REG_1].map_ptr =3D map_ptr;
> +
> +	callee->regs[BPF_REG_2].type =3D PTR_TO_MAP_KEY;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
> +	callee->regs[BPF_REG_2].map_ptr =3D map_ptr;
> +
> +	callee->regs[BPF_REG_3].type =3D PTR_TO_MAP_VALUE;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
> +	callee->regs[BPF_REG_3].map_ptr =3D map_ptr;
> +
> +	/* unused */
> +	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
> +	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
> +	callee->in_callback_fn =3D true;

This should be `callee->in_async_callback_fn =3D true;` to avoid an
infinite loop check in the is_state_visisted() in some cases.

> +	return 0;
> +}
> +
>  static bool is_rbtree_lock_required_kfunc(u32 btf_id);
> =20
>  /* Are we currently verifying the callback for a rbtree helper that must

[...]

> @@ -13171,6 +13235,15 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  					return -EINVAL;
>  				}
>  			}
> +			if (meta->map.ptr && reg->map_ptr->record->task_work_off >=3D 0) {
> +				if (meta->map.ptr !=3D reg->map_ptr ||
> +				    meta->map.uid !=3D reg->map_uid) {
> +					verbose(env,
> +						"bpf_task_work pointer in R2 map_uid=3D%d doesn't match map pointe=
r in R3 map_uid=3D%d\n",
> +						meta->map.uid, reg->map_uid);
> +					return -EINVAL;
> +				}
> +			}

Please merge this with the case for wq_off above.

>  			meta->map.ptr =3D reg->map_ptr;
>  			meta->map.uid =3D reg->map_uid;
>  			fallthrough;

[...]

