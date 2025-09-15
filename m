Return-Path: <bpf+bounces-68400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45B5B58165
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 17:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8807A1DCB
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088BF2367A8;
	Mon, 15 Sep 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/3ENAK0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1F2DC786
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951962; cv=none; b=G8md+UmgJO1cltpIB4Q6Wuo0who8Rwop/6NzHyQh5obQ4U/wJV78ISdeYM35tZLG6D2OhIaHkVZgiAij5f2QJLwS2iTqiNZx6ulQnnHryv0SWuEbo6nDADc0Wm/GB+KgoSmu3jn4Y8lKh65pXPOe5bfeVMyxJVy4/bLMs8Uo22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951962; c=relaxed/simple;
	bh=O4x8Ur/RzPXQDt5S/TjrninfMA9ajzPcJmvEer9QxTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pf9dSUHnbfbnu1866KsdrD7D4BjDsfejh7/PlVFLKKYOZi/TtVv+krMbvMn+WYfmM92BONAygQDzuznmDn9/IxP/os8S7R4G+IMltaYy5dA9g1Xr32qhMm1s9r+bOoAbUs0h4VLfVoP4H8wL+8oXljoPsl8fzooFN2Hj1BU+C7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/3ENAK0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45f29d2357aso12281995e9.2
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757951959; x=1758556759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t0tZvJAwyKdHCDRCfpcUUykZpDHuAJSTyqRj7bXJ6JI=;
        b=h/3ENAK0qIxJqEvKHuxsg6f75ZHcLW67n04TZ03cuDu/Fe/TGza0er/tmQuomWSSxL
         rT3f0iQNXd4iQ8Np/87qDZnzNz4GSmJO67W9rWZNDTuF8ZmwCTO2JN4t3ihaciplXj9C
         MrUCK+AR/CgcIu8ZT7PkOHjrdx6Wn6vkM6XBruzrCh4iGlxTWn31hXHungCnBFi8IxBM
         SrYxcqrhOuQwGX5w/bo8jfjPN6sFyvUYVP947vwvDGYB9t8NaIillZtQbob8G3GnEP6B
         UwJ1zocBkBdPa1zhZxKo8ebvpHZQTwEPYTlG26BvAJsie+j40e+raZBw4y+lqHvQTJxI
         B2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757951959; x=1758556759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0tZvJAwyKdHCDRCfpcUUykZpDHuAJSTyqRj7bXJ6JI=;
        b=AbN3sZEhQMDjWcHmpXL2rWA0XTkrFq2JOVloDKSaUAIDwk0dsNf8nAEvVwSQfKXWkj
         4OnwvJE57DAfP5KNm61OvF9kMa62YVHs5COnykuyup1QBu4d4QvxJP/ctNcmtL7GcRLM
         m5+X8/odTc47P66wqrmnO0DgUTehfB58uePaWhWATuXino/DyZQMRjNMO14qVBlHUxWW
         gpUe5zQmlhHJ/2R/zAe2UdtmTSbeVtB61KMLxpeJO4LtOXxSA50xnVMsi1CEWH0ggnX4
         5bEQEzeqw6nFBpAwcDQrnfUunyx435x9oPMN5LknLsK5PXPm8+NknlMylb2NrvDql4Z+
         CxMw==
X-Forwarded-Encrypted: i=1; AJvYcCUoGAwMSxbk86fbytUbg5Q5n2xivsyATIs2TGjTwbCu0d5gbhL/ERrD/xqRTjsP5MaxB6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx31qJy8EwxkAymmYVnxfheWnQAjx4QfwnNUqRAJfFDjVtctAOl
	0wa5x5I3w7hQ0uPlaPbGKPFuNOm5P8IcFVYytR4uhpv+f4FSum0eq+2y
X-Gm-Gg: ASbGncsFzKQRkwscy738B8/NMTqem3RLb7RMWeRVeaSAM67SGSRF0+p+MX5UxZmoRUf
	hTxlrakS0vGSyc97v7Gz0z297u4XWJUizEyA/MWb7LTpcet0FGNfINqoWSk50ENxuju61VGJ0BC
	m/krboDvYqfOgRZFxzjUnSpnX3wttOrAfiRtUKa29Z2surv/sAe124U52vAObiTtH1GvtL2zqVa
	jNu6Y9pbe56a/uWvZRQAfwFyIyAtAjb8oEk+8xYkRWeeOSy/3Pz21e9PZA68bXsjxRrz52QQBT7
	SQ/nI23T/+tcZSK+Mqobwf31O0pcE0S3CdCmumwpZz6Qo9nBDl6S66i4xtleSEGBzt46kgxNAL2
	yKI/m/gQSSFIF7rTmJAki8bUE48fkAtFz0KMqwazrmtqEk8wJ3rJuY1T1rG4L
X-Google-Smtp-Source: AGHT+IHi/NYuBzIxJ5ot1ObUSc9JAYKeVnVOiVWt3D3oAVHTV2so8XqBPYiB0fQ1nKHKThoaAB5qog==
X-Received: by 2002:a05:600c:1c9d:b0:45b:6275:42cc with SMTP id 5b1f17b1804b1-45f211ffafbmr104526185e9.28.1757951959000;
        Mon, 15 Sep 2025 08:59:19 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:4eb3:9189:a7fd:1180? ([2620:10d:c092:500::6:388e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017b2a32sm186615375e9.18.2025.09.15.08.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 08:59:18 -0700 (PDT)
Message-ID: <ac73378d-290c-4ab0-a604-6de693ce6c6f@gmail.com>
Date: Mon, 15 Sep 2025 16:59:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 4/7] bpf: bpf task work plumbing
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
 <20250905164508.1489482-5-mykyta.yatsenko5@gmail.com>
 <c67790c49ae9ce4e1f34df324ab0b217ab867f03.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <c67790c49ae9ce4e1f34df324ab0b217ab867f03.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/25 00:09, Eduard Zingerman wrote:
> On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
>
> [...]
>
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index 3d080916faf9..4130d8e76dff 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
> [...]
>
>> @@ -439,12 +439,14 @@ static void array_map_free_timers_wq(struct bpf_map *map)
>>   	/* We don't reset or free fields other than timer and workqueue
>>   	 * on uref dropping to zero.
>>   	 */
>> -	if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE)) {
>> +	if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
> I think that hashtab.c:htab_free_internal_structs needs to be renamed
> and called here, thus avoiding code duplication.
Sorry for the delayed follow up on this, just was trying to do it. I'm 
not sure if it is possible
to reuse anything from hashtab in arraymap at the moment, there is no 
header file for hashtab.
If we are going to introduce a new file to facilitate code reuse between 
maps, maybe we should go for
map_intern_helpers.c/h or something like that. WDYT?
>
>>   		for (i = 0; i < array->map.max_entries; i++) {
>>   			if (btf_record_has_field(map->record, BPF_TIMER))
>>   				bpf_obj_free_timer(map->record, array_map_elem_ptr(array, i));
>>   			if (btf_record_has_field(map->record, BPF_WORKQUEUE))
>>   				bpf_obj_free_workqueue(map->record, array_map_elem_ptr(array, i));
>> +			if (btf_record_has_field(map->record, BPF_TASK_WORK))
>> +				bpf_obj_free_task_work(map->record, array_map_elem_ptr(array, i));
>>   		}
>>   	}
>>   }
> [...]
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index a1a9bc589518..73ca21911b30 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> [...]
>
>> @@ -4034,6 +4037,10 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
>>   		case BPF_LIST_NODE:
>>   		case BPF_RB_NODE:
>>   			break;
>> +		case BPF_TASK_WORK:
>> +			WARN_ON_ONCE(rec->task_work_off >= 0);
>> +			rec->task_work_off = rec->fields[i].offset;
>> +			break;
> Nit: let's move this case up to BPF_WORKQUEUE or BPF_REFCOUNT,
>       so that similar cases are grouped together.
>
>>   		default:
>>   			ret = -EFAULT;
>>   			goto end;
> [...]
>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 0fbfa8532c39..7da1ca893dfe 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
> [...]
>
>> @@ -840,6 +849,9 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>>   				continue;
>>   			bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);
>>   			break;
>> +		case BPF_TASK_WORK:
>> +			bpf_task_work_cancel_and_free(field_ptr);
>> +			break;
> Nit: same here, let's keep similar cases together.
>
>>   		case BPF_LIST_NODE:
>>   		case BPF_RB_NODE:
>>   		case BPF_REFCOUNT:
> [...]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index a5d19a01d488..6152536a834f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2240,6 +2240,8 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
>>   				reg->map_uid = reg->id;
>>   			if (btf_record_has_field(map->inner_map_meta->record, BPF_WORKQUEUE))
>>   				reg->map_uid = reg->id;
>> +			if (btf_record_has_field(map->inner_map_meta->record, BPF_TASK_WORK))
>> +				reg->map_uid = reg->id;
> Nit: this can be shorter:
>
> 			if (btf_record_has_field(map->inner_map_meta->record,
> 						 BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK))
> 				reg->map_uid = reg->id;
>
>
>>   		} else if (map->map_type == BPF_MAP_TYPE_XSKMAP) {
>>   			reg->type = PTR_TO_XDP_SOCK;
>>   		} else if (map->map_type == BPF_MAP_TYPE_SOCKMAP ||
> [...]
>
>> @@ -10943,6 +10956,35 @@ static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
>>   	return 0;
>>   }
>>   
>> +static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
>> +						 struct bpf_func_state *caller,
>> +						 struct bpf_func_state *callee,
>> +						 int insn_idx)
>> +{
>> +	struct bpf_map *map_ptr = caller->regs[BPF_REG_3].map_ptr;
>> +
>> +	/*
>> +	 * callback_fn(struct bpf_map *map, void *key, void *value);
>> +	 */
>> +	callee->regs[BPF_REG_1].type = CONST_PTR_TO_MAP;
>> +	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
>> +	callee->regs[BPF_REG_1].map_ptr = map_ptr;
>> +
>> +	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
>> +	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
>> +	callee->regs[BPF_REG_2].map_ptr = map_ptr;
>> +
>> +	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
>> +	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
>> +	callee->regs[BPF_REG_3].map_ptr = map_ptr;
>> +
>> +	/* unused */
>> +	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
>> +	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
>> +	callee->in_callback_fn = true;
> This should be `callee->in_async_callback_fn = true;` to avoid an
> infinite loop check in the is_state_visisted() in some cases.
>
>> +	return 0;
>> +}
>> +
>>   static bool is_rbtree_lock_required_kfunc(u32 btf_id);
>>   
>>   /* Are we currently verifying the callback for a rbtree helper that must
> [...]
>
>> @@ -13171,6 +13235,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>   					return -EINVAL;
>>   				}
>>   			}
>> +			if (meta->map.ptr && reg->map_ptr->record->task_work_off >= 0) {
>> +				if (meta->map.ptr != reg->map_ptr ||
>> +				    meta->map.uid != reg->map_uid) {
>> +					verbose(env,
>> +						"bpf_task_work pointer in R2 map_uid=%d doesn't match map pointer in R3 map_uid=%d\n",
>> +						meta->map.uid, reg->map_uid);
>> +					return -EINVAL;
>> +				}
>> +			}
> Please merge this with the case for wq_off above.
>
>>   			meta->map.ptr = reg->map_ptr;
>>   			meta->map.uid = reg->map_uid;
>>   			fallthrough;
> [...]


