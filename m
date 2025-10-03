Return-Path: <bpf+bounces-70334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE371BB7EDC
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 20:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BDD3AEE26
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB31F2DEA8E;
	Fri,  3 Oct 2025 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFOc6U69"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83991EA7DF
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517639; cv=none; b=OSaIGugL1thLcKZxRql6Rza0A6qsMUB1vg5sDLXNb4/p+AgGeKWSTgf85o6eUCBBveuohNeHU6k7FSEB0u2GFlx2O/K9mBVSYAPHXQdfnkB3bahLhl2fCosXiUQE4vZ9hp5jN9ggPZ6CpODXA5sHGEUDKPodUgiJIrB2lWpOENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517639; c=relaxed/simple;
	bh=D2um47ivMaQ6lGKiI0KQqKWIUFgAJ2EAhpljQBWtkgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUPvf8FdmyDxR5II8o5AXAG3ye297wC2J/MTbGzxncwminLVYIPkgQyRTriJkBTsOyHYkCyYnd9UYorsSxAZdjiTeL3L4nFfwssP2K5NBYHbj0pAgndzEAc8F3T3xLV2BkRLLaasNTbg8k1fGf9wwdd5I6Igvu83CqNE6CtXb4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFOc6U69; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-421b93ee372so1248874f8f.2
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759517636; x=1760122436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1U/QqzKbUd4khs/2bGb7kPGrT7bJy98u8pM5YNcWsY=;
        b=KFOc6U69tsOehc0tDO9mR0Mh7nFZ8mNy09M3Q64dhQgDjISy9I6ezGp3+Zpu9eGnm3
         K7FNXokdsGCCA4cJwgMGS8L16eZ6o8+APE8WHWMOkcwnd5uivRqGgTUYL8bKBxtHm5Ox
         /YcOQia/Fbh0BrX2fkoPL+vTjD4/TS5IWN3vutv7Bj96KT6R4EPfxZc56xg9vRYE/yBk
         hfLVs9ArbO4cUFX1Wm0VhMVkyfpxfC5H1jXmLdrg/N7gjGPynytckUFWy55w25ANrwqU
         aoDdex2bjJpZVxFu9z/BnGqyxB06De5SrcP9LWbxsNDwpPagC32PtgYjTopmb22vA3vX
         S1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759517636; x=1760122436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1U/QqzKbUd4khs/2bGb7kPGrT7bJy98u8pM5YNcWsY=;
        b=ui6q5/b92kLWztmcQmIPxrdwSOmtva3ARlFA8+b4HpMG0Ogi0d8xsbdSAy7eC//KgE
         1CU72e9HpBu13rqdHfvJ9EqNSywSlLOSiA/Md0bo5U/JT6BFYXJqOZQs3lc8u8sJAv7E
         6geM+3Y8EvgTHl7BPpCBXSEwT4gMC+qdHw8kZYvLGLG39Zb54Uzz1NZ6a8ujrvVXSIfm
         04863foiUBGFCdZ/yNbgoRmzxjih04OM+FQL1r+2cpH9dsXQplVbR0/muJz1vwLAPkhg
         SPwk7yg3hn0J1gsLG+sa2R7ZKHe6f4H019SmEMNTq1cTWNoChxDkLD/3LoFoQCp1Jm0u
         Vqkw==
X-Forwarded-Encrypted: i=1; AJvYcCWcVomiBE5TeWfn/SQwShEXmpHU8lDy2HizQW71xmp5+e9zFQ72B+P0ykWyXzelAswRaxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmZFHhUkpZnBDq/J0/lCx2HW6u/MeCAU5fzQtFQuHYhLDCCgGi
	CTG/xIzfmaGS2K4AbSmkuXl5E33ng+yeWq0Rzc4BMsL4eNkAdSDntM6q7waaDg==
X-Gm-Gg: ASbGncs82DKobcBTe2kVlgFdl/HdJDZNnA2n7etsPsOVbR6x4FR88EnWXYcxt91ytR2
	hATRFkPyIZiKjoNNieaOgx1HVcoznRyZG7qEARUQWXt9WnRBi4DVh17brTOu/Bntr/GDjOOWEtM
	SFjnwvsDogoLi4Td6xA0EjjRJzHdOlncCv0hAi9nyqFKQYJlrvbv24FK5yPvQh+mlyZANX0OaaV
	uPdZwxAR5m3hfZlG+pK2egqdbXOY6o4VgAyEt9MtOYMzQifC7CZNaIjXMX/uaMc8/vocdBdTZXj
	kK50bDDai111UlBQBjCXlHPQTcqb5EDNnKDoJhWzJEazILv3biC80vW2QZ4M7IiCrkykV4j4/kb
	iXyU08PvWk8SHby4m6O8JrdDUlaDMO8YlS1kaMU9/Q7NhFWlUdJtPypsOHIHoNSKI4C47f14=
X-Google-Smtp-Source: AGHT+IGeKmb3MDFVWWHMUTqzjgM/b2Ns8JUzHFRrnuVr0FqqUB/F3M+V4rTFqPV6k0MrLrenvZrJog==
X-Received: by 2002:a05:6000:2303:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-4256714bac2mr2810445f8f.14.1759517635822;
        Fri, 03 Oct 2025 11:53:55 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0c3:1130::123d? ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9762sm8941839f8f.38.2025.10.03.11.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 11:53:55 -0700 (PDT)
Message-ID: <a1b7ad01-f28f-4a60-a15b-3babb1cf26c9@gmail.com>
Date: Fri, 3 Oct 2025 19:53:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 02/10] bpf: widen dynptr size/offset to 64 bit
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
 <20251003160416.585080-3-mykyta.yatsenko5@gmail.com>
 <10973dbe691484a3a77938db374f9056ce23513a.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <10973dbe691484a3a77938db374f9056ce23513a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/25 19:40, Eduard Zingerman wrote:
> On Fri, 2025-10-03 at 17:04 +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Dynptr currently caps size and offset at 24 bits, which isn’t sufficient
>> for file-backed use cases; even 32 bits can be limiting. Refactor dynptr
>> helpers/kfuncs to use 64-bit size and offset, ensuring consistency
>> across the APIs.
>>
>> This change does not affect internals of xdp, skb or other dynptrs,
>> which continue to behave as before.
>>
>> The widening enables large-file access support via dynptr, implemented
>> in the next patches.
> Maybe add a note here that this change does not break binary
> compatibility with BPF programs compiled for older kernels?
>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 8f23f5273bab..7cc4f2e05ed2 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -3372,13 +3372,13 @@ typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struc
>>    * direct calls into all the specific callback implementations
>>    * (copy_user_data_sleepable, copy_user_data_nofault, and so on)
>>    */
>> -static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr, u32 doff, u32 size,
>> +static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr, u64 doff, u64 size,
>>   						 const void *unsafe_src,
>>   						 copy_fn_t str_copy_fn,
> The definition for copy_fn_t looks like:
>
>    typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struct *tsk);
>
> should we change it to use u64 as well? Probably does not matter.
This callback does not work with dynptr, that's why I did not convert it.
>
>>   						 struct task_struct *tsk)
>>   {
>>   	struct bpf_dynptr_kern *dst;
>> -	u32 chunk_sz, off;
>> +	u64 chunk_sz, off;
>>   	void *dst_slice;
>>   	int cnt, err;
>>   	char buf[256];
> [...]


