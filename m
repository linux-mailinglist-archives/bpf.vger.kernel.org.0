Return-Path: <bpf+bounces-65886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E24B2A6B9
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 15:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C449681149
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B216322DB9;
	Mon, 18 Aug 2025 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL3B7LQh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA532253A
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524184; cv=none; b=iEmh+/W3mRoC7P40w+wD1BBqM3uPHhRet7V6PHa4TSsF2eVpDVyoqPPRKKj0swecu59D/bgEjM5n4bpLCAegEGt66COGOKRM2bMcGp7Hlbddx4EL+7vsle+ITFLTKK+8pwLYtxNnhUQ/hd2UY8ufpgGn9gcX95gf8+i6+8hfX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524184; c=relaxed/simple;
	bh=35IjhsFyUwK4hyxt/nQzagbpxOh5BWYNJ7kPcALufCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHm2by2Ku9g6julCP0RGvopko1yeK7UNFIC0wsC+G5I3DLtP396WcWv6MA3N9HRfZrZUIPxndH4RGbMa9ZZyO6sISHIUYfQgEaejX/RuVVJ4EtmLtPqB6UK0X3kNJUmLksQNAORj1uIYitXLY9ZRSsfojj1W/c44jGASSKpkTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dL3B7LQh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so32967205e9.2
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755524181; x=1756128981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRdv/HgXHB3vjcJizQXiu5bi0y2yJ0XJPbTPxPMbUYQ=;
        b=dL3B7LQhXJGfBUD5YjMetpIMAxrTdUR2/VHXAoH3k0K4oNBZKRwCKkNWOkAnz4dJ5T
         VQf6hgkIgAJyE2Vsjt+ykyAR+cQl5I7tg/Xx1Rf4QCzuJFGTmGLPnzDaxmWMlFuE1F8u
         Bb3sO5PaRk7iRDIHX0HKSX0n75Wn/zzeUMygN5EIqFp5DPqdiBgRfyRUKu/zEbQuvKmA
         4rg2mVHXzRrMP2nzN4IwZCC3sFeEtnCpv0vjQYf1x4kqDFDcecKzU8j41XJSWZM1NLyS
         TCYKKHOZcfsMbiqCTvJ44DUId4xxndkP9lgdxYffu9iHu0IbosW7PsBopOgoa4za0FCQ
         f+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755524181; x=1756128981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRdv/HgXHB3vjcJizQXiu5bi0y2yJ0XJPbTPxPMbUYQ=;
        b=Y7GjfNI1EaruKZ37vyUBoeSYf1BMDXanU2y3aPKNptfROMchU2R5XKhSy2iEPpRTHu
         EhvNRLKCt+QmULt204rI/9RVPN2YSOpMsTntAh9Rug0bLGykp0zKIPEKhQaPMLg6qmJ5
         7kDa4JMpsWHuC7uwdMB/Lit/A+//GWBcFYyR+j0D66PTC64QHFVcXbsP7nsVQO1CS1uF
         tZDI1EaEpawLdXxiPRce1FxDwAoc8Afr4dmw5DfUtxL9ldhuy1x3EYY8kZMGFUXCAsSm
         NeV/L9RKWv3aeUgoQmNntTl7xKzU4ng8mi9CCiCIuYnj+7+RF80k3RIUKKeoJHIDRytI
         yeeg==
X-Gm-Message-State: AOJu0YyKWGtaGiYTNmfGh70vD+QzT/ZXE4K/kSvViOoUK1W8ms7N4L0+
	7vhj8672uzJnC24LJ1Zly9bwigZ15FhyqNmvJ0YLM9pDNJHliVjPz7GO
X-Gm-Gg: ASbGncs1RPJyrT7b2CTO+t65RTEoR/KxaWa/4Z5T7XiQQDKHh9dx5LQQOTSAT0nZ1HL
	xHCwA23uH93/VFZsvWmA/Wq+Z8Y598DA+ayR1UjqU6pHmclJmidU6psHkPl7Uk6hVhTzaEUhXTd
	sjDvxqazN3LrQQq+C10OVlwCM1EQn4DZswk8u7ZCi9JlHo/ctoie8Mch8L8qsWBifabqVZokjeQ
	RF/2IFyyenqKpl3AU1t195FMAmUQH+fRMwUJrWomtLKNFX/ksC+oC7nbrAOmf+k8Xra/nfQoGhl
	FrbAQ2kK5AxMax1YOJBqUYnWZbrAoa9kv40CaUKn0qwATWg7OdSqwSNKaxofRA9IDUXgPjCKkv9
	zuk5tZdmeuCILBTzIYLyiS7MVndjynFffSDppGSqeSpfLitHhNHyD2+gR5A==
X-Google-Smtp-Source: AGHT+IGu/8Gx43MqKTt5DfYPlB4IKdpPSEAfzuuHejjZjYNEbJCSWzrT/wJPsmDMjGQ+W3IIYAjsJA==
X-Received: by 2002:a05:600c:1909:b0:458:f70d:ebdd with SMTP id 5b1f17b1804b1-45a21839d0bmr106500725e9.16.1755524180769;
        Mon, 18 Aug 2025 06:36:20 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:6f32:c1a9:c43:2a17? ([2620:10d:c092:500::5:fc0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c74876csm173178465e9.14.2025.08.18.06.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:36:20 -0700 (PDT)
Message-ID: <67ae2d13-ce55-4593-816c-31674b7445b0@gmail.com>
Date: Mon, 18 Aug 2025 14:36:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
 <20250815192156.272445-4-mykyta.yatsenko5@gmail.com> <aJ-t7wxrQIB1oYyh@krava>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <aJ-t7wxrQIB1oYyh@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/25 23:00, Jiri Olsa wrote:
> On Fri, Aug 15, 2025 at 08:21:55PM +0100, Mykyta Yatsenko wrote:
>
> SNIP
>
>>   void bpf_task_work_cancel_and_free(void *val)
>>   {
>> +	struct bpf_task_work *tw = val;
>> +	struct bpf_task_work_context *ctx;
>> +	enum bpf_task_work_state state;
>> +
>> +	/* No need do rcu_read_lock as no other codepath can reset this pointer */
>> +	ctx = unrcu_pointer(xchg((struct bpf_task_work_context __force __rcu **)&tw->ctx, NULL));
>> +	if (!ctx)
>> +		return;
>> +	state = xchg(&ctx->state, BPF_TW_FREED);
>> +
>> +	switch (state) {
>> +	case BPF_TW_SCHEDULED:
>> +		/* If we can't cancel task work, rely on task work callback to free the context */
>> +		if (!task_work_cancel_match(ctx->task, task_work_match, ctx))
>> +			break;
>> +		bpf_task_work_context_reset(ctx);
>> +		fallthrough;
>> +	case BPF_TW_STANDBY:
>> +		call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
>> +		break;
>> +	/* In all below cases scheduling logic should detect context state change and cleanup */
>> +	case BPF_TW_SCHEDULING:
>> +	case BPF_TW_PENDING:
>> +	case BPF_TW_RUNNING:
>> +	default:
>> +		break;
>> +	}
>>   }
>>   
>>   BTF_KFUNCS_START(generic_btf_ids)
>> @@ -3769,6 +4017,8 @@ BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_rbtree_left, KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_rbtree_right, KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
>> +BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
> hi,
> I'd like to use that with uprobes, could we add it to common_kfunc_set?
> I tried it with uprobe and it seems to work nicely
>
> thanks,
> jirka
I'll move these kfuncs into common_kfunc_set, in the next version.
>
> ----
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 346ae8fd3ada..b5d52168ba77 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4129,6 +4129,8 @@ BTF_ID_FLAGS(func, bpf_strnstr);
>   BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>   #endif
>   BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
>   BTF_KFUNCS_END(common_btf_ids)
>   
>   static const struct btf_kfunc_id_set common_kfunc_set = {


