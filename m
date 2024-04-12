Return-Path: <bpf+bounces-26609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B805C8A24A4
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 06:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B37E1F229EC
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 04:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6193117C7F;
	Fri, 12 Apr 2024 04:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ild5aeX8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95601179B2
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 04:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712894447; cv=none; b=HHuGwhg08ZKIFsMLugDB84+dnoFO86OUkJ+0modEqyxf0JwpbdlKsIHxp7QzQOs2+zttwA+UCPHCAaO8s+KEUXEzPilmMH8HWyU3NZ5TfTFhKiWvGUB63kEmTwl+jzAT2RgQ7dNsLanvQxHAXAN8hmTweucRHDG3VTKZohIV6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712894447; c=relaxed/simple;
	bh=M2MrJTESUF58tnZUJTh6VJvPuNoHoPlB3JAvMHZVZ50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DeRqilhn0oFE0SDazjP8twcbnZxurdHu59YI5dOtY2eMuE5hyrJI5nqczIVsl1mjdqL3dDZhwaih7wLvRXal+U2LmgC6cr7Vd25NWAlFhQk04x8gPO7b91kWjG7enDVv/iaSGwQFrpy5VhqwdVMjAP4PSwnPCm0GXzxfK7OKM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ild5aeX8; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-618874234c9so68627b3.0
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 21:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712894445; x=1713499245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=At3Sspe7ZG5XZwsbT1J9+hSyE7SQ8OREDx1nL4cLg2s=;
        b=ild5aeX8zKEiNDCHxoKYHSLHWNRHJHR8zHWsjlRqc6/LPFAo2wnBIm/0PNuU0KTT4X
         HvIoZ1D3eqyqUkYtjanC+d7vi4x+DpEFcpqDWIslqmgjXsHEJt6mR66kIwhVt7VLkP6H
         +j1TaGhd21T1+VVEY+NmiLUhAhSSRZ5uIjQ1ey2kS3iEul47j0U1sH0L++pcfQ0Xmsj1
         eu/EAZ3vHAZr2Bj+r4xU6uVddqz2oIVejek+HAJYAuCmYQzq+NoIU+dRNuGNFaD657+e
         wd2hBCofiH1XfeK9Y3kr9O5fbn4KJvpfxmtPUHmF55jH61rkoW2RxDAcCB9Fp1X15KK3
         Xh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712894445; x=1713499245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=At3Sspe7ZG5XZwsbT1J9+hSyE7SQ8OREDx1nL4cLg2s=;
        b=Jcv9hSkbO6DF8MEFXpoeCAlQMPltHPJwIOYmDXOngdBfcVOgLVMzzbuORjNE/VtbBQ
         ptk+Tjf2evKiMiS4E4ZSbiQH705g61AVVC4RG+GrmGzLhME9uOFqO3gSu0N5OJcMREt3
         t9gYERO5lCGkTPtdn6qGeTdwmtfsDVmnnQ4Rg5+t9lvRQlb0VUKbGqQNh9VYkpTMqesQ
         mdggUqYlMklJoDVD1DoJ6kzUBfkSPEqEbHt/hkKxdrUmqcM+Nq5t0JYE59bkOLAPLEbB
         B+kxyzQVgRWZJjmW+Q+M52jDQgidb2QBsWf0VDJwoQowmeYJ0IlYy8462a6ffL+BLxSQ
         Qp0w==
X-Forwarded-Encrypted: i=1; AJvYcCVBEkbvqJzHCmc8MVLf8LMy8NE2XIwpajmSInFGVnJ6s0TSbMin3REUbprHdUMpbp0CzwFrivloVAp7TwtQUYwTeHBx
X-Gm-Message-State: AOJu0YwlQNHhnzzd5eg/g7Gc5evG3+SlaQLdvIsT4Jym+NwqoIq/t4gG
	wUAhQQfGRRYYrK4Hvy7K9H1egWv+/8gAZcqUhX1hQwR50Z+aG23Q
X-Google-Smtp-Source: AGHT+IGSPtCh8nRJH48NI1TEY2eA9F6AnEC2SC6YIvU2QdwLR4ArHjPIlj9D38HD1xSX/H5pU6ym9Q==
X-Received: by 2002:a81:aa05:0:b0:618:7c25:9e30 with SMTP id i5-20020a81aa05000000b006187c259e30mr847789ywh.37.1712894443988;
        Thu, 11 Apr 2024 21:00:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:d7:be37:7e5d:7c78? ([2600:1700:6cf8:1240:d7:be37:7e5d:7c78])
        by smtp.gmail.com with ESMTPSA id u14-20020a81840e000000b00617fa1b5a07sm643814ywf.19.2024.04.11.21.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 21:00:43 -0700 (PDT)
Message-ID: <750623da-bb75-429a-8ef7-c6a21a15c5e5@gmail.com>
Date: Thu, 11 Apr 2024 21:00:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 04/11] bpf: check_map_kptr_access() compute the
 offset from the reg state.
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240410004150.2917641-1-thinker.li@gmail.com>
 <20240410004150.2917641-5-thinker.li@gmail.com>
 <51436d219e351558fdb6b57641280039540754ee.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <51436d219e351558fdb6b57641280039540754ee.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/11/24 15:13, Eduard Zingerman wrote:
> On Tue, 2024-04-09 at 17:41 -0700, Kui-Feng Lee wrote:
>> Previously, check_map_kptr_access() assumed that the accessed offset was
>> identical to the offset in the btf_field. However, once field array is
>> supported, the accessed offset no longer matches the offset in the
>> bpf_field. It may refer to an element in an array while the offset in the
>> bpf_field refers to the beginning of the array.
>>
>> To handle arrays, it computes the offset from the reg state instead.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
>>   kernel/bpf/verifier.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 86adacc5f76c..34e43220c6f0 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5349,18 +5349,19 @@ static u32 btf_ld_kptr_type(struct bpf_verifier_env *env, struct btf_field *kptr
>>   }
>>   
>>   static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
>> -				 int value_regno, int insn_idx,
>> +				 u32 offset, int value_regno, int insn_idx,
>>   				 struct btf_field *kptr_field)
>>   {
>>   	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
>>   	int class = BPF_CLASS(insn->code);
>> -	struct bpf_reg_state *val_reg;
>> +	struct bpf_reg_state *val_reg, *reg;
>>   
>>   	/* Things we already checked for in check_map_access and caller:
> 
> Nit: at the moment when this patch is applied check_map_access is not
>       yet modified.


Yes, I will change the order of the patches.


> 
>>   	 *  - Reject cases where variable offset may touch kptr
>>   	 *  - size of access (must be BPF_DW)
>>   	 *  - tnum_is_const(reg->var_off)
>> -	 *  - kptr_field->offset == off + reg->var_off.value
>> +	 *  - kptr_field->offset + kptr_field->size * i / kptr_field->nelems
>> +	 *    == off + reg->var_off.value where n is an index into the array
>                                             ^^^ nit: this should be 'i'

Yes!


> 
>>   	 */
>>   	/* Only BPF_[LDX,STX,ST] | BPF_MEM | BPF_DW is supported */
>>   	if (BPF_MODE(insn->code) != BPF_MEM) {
> 
> [...]
> 

