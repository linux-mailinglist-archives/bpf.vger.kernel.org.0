Return-Path: <bpf+bounces-71563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D34BF6A72
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E00294EC95D
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D865D334688;
	Tue, 21 Oct 2025 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LriEdxY8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F4A239E76
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051839; cv=none; b=f94RCi//PBEMd9NDK4CheFIebDVf21gVcBHXpOgm4yg5d/MZl0HCVxeTaxYHR2FqS5uV6r1CB8VFDHZ5ZaOkFQ04Ic8byDUzIxqNEhCM1n5rXL+ArycaShlMNb5TGa3PmXfYH0Rgs2iV5+0a/oWtSJHx1n96HrxRLypwEcuCSlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051839; c=relaxed/simple;
	bh=sUIAop8Y7NfCE2zVP0iJ6mX23u7YE3BAyGSJOhYgI5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mX3eWciHRiudT1NzWHHlSzS4vlyT5EVmUIJGJeRyip0qz62fmfvm3N2lGr1Y2eyXRMQyu4SLzcOQnt+2kC6oFEGji8X2xMbwnikDD3OUeZQjMNwvLWMaYv7uOCnlG1ZRlHd7LNNYvKAWqIYzaBEg0/2CmsDnQTIBZe4sZSx3EZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LriEdxY8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so36885655e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761051836; x=1761656636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFvuBh281gERLDs5w+qQCtFRoYtWPyIRTuKhwujYAvk=;
        b=LriEdxY8H0pvCO+9buL7YBasDN3HZE3ws1srN4pw955f4dET+Ajk2WCT12xRPDBba4
         Sj5I3o8D+Yleqg44BHo2geZwrXOiHhCF+453KCDhk/zZcT8FJhD9E3dZ3P8NtVuegDB6
         8gng9XTFZ/DCpo78hgLHJ7QyPUI4LYFVTVNt+X04JLt8WrUnYdzmPxR+ihw/SXXyOu+R
         0h1vOWMWXl0+lJH1M6eQcsPCqMsk988Okfy/rLodR5U2zOyFdo4i/TxZ/fOhs0uRrnzr
         ugJe8LjkhH8dMHb3W2Hai2Kd6YCY1L+hduvB8rdLHSLq7b4DCNaBuakS51DGQt6E3Ha1
         20PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051836; x=1761656636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFvuBh281gERLDs5w+qQCtFRoYtWPyIRTuKhwujYAvk=;
        b=MCY6dSd51gv4WfUIWahJ6N2bBeerO2tiQpcSUIGl4w9kGrQNHTzq8AIQjz+wXNSjMN
         Fbwx5PLaC8tUdnKYmD9HTUThLdFYxWC2yfpOuWBkxzKMBVFI4vuVj1SFDf/7u8DtJQlZ
         iScjnQx6V5Kjyg3c+MfL+Fl/08ZubpWRgrwoYWQc5Rbvs7+YqLy2L3XddGBQudkiM77m
         dYXkeJ7Z72uEHeRIWjfP1QONEGso4+Fleucq1evJpQzogpjYjrWZrZFinc0b6yEAhr3S
         jbGq5ZeRqNhSlyZrO+2zAZc00t/ig+1XGdiTabG5AUmquEWaQXIWW5oIMZ2ZNWAH1p0k
         kjPA==
X-Forwarded-Encrypted: i=1; AJvYcCUsO9lwKhxlqgQQ3R49aHJnYbw2rPG9fWTfUegidqEXzZFh+/Q/ftyFe4a8vVn3WhsQwxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoGL15MTotx/rr58fqH2ZO1i5DPiOBNJdwMBUsj2HpktVUUBh9
	7tGX9tI9FkjSUe1ZxazCJjf0xNwnWS3O2KJU945u04YnqUDUmD1N5puU
X-Gm-Gg: ASbGncuEt5g4l7PKGxIJJxRuROGKDtwumUFVe9Lh434uba6zsohJZvaZKvHrzBQT+4+
	rFBzM78duV0pOErg/h+qYb28N6LApwKWY7u9PgMQmznLRAC23J7eFuKCp64Z40QdgHC7voAWgq1
	g0OO0ERANwu8eePLuYBsWTvPESYfu6SjtlUId7M+IWmcxGeP+cnK4/NfkqudaXoT2D9QvQLW1dl
	EA5MWmI4SgvCiZG5ZRDuD/maIlV3PB65GN73KS4HgTxeOzrs7h8rG31cSTnl+r+1B9VYZWj3RPQ
	JosHcfnMQnTb275uFZTTTmDPXdLLiBBh3pu0/M1Qjluk4nPKkiP1MZJFlodKHFddMtJzgE44uEr
	AsM3tALp18p4s/lAr3Sl3Rw5mQbXmCprH9RiN/bIIkTyg2ZKZmpvSZsuew/meSnuEQUGHRBz7Bk
	RFd8mg73DSgaiLOJaT1Lvssv6ChBsjOKMjwei9haIRKjki8u0i3jI=
X-Google-Smtp-Source: AGHT+IGVRCiPFczu2sFfvElQcyWd5llYV+CLaXLeNGrA7rVFl3TV9e9dT7ICNUzWOMt6XGjvMKJkWg==
X-Received: by 2002:a05:6000:400a:b0:426:d544:1da8 with SMTP id ffacd0b85a97d-42704b4c0c6mr11874372f8f.9.1761051835474;
        Tue, 21 Oct 2025 06:03:55 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:4c57:4e9:b55b:f327? ([2620:10d:c092:500::6:c0ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9f71sm20428002f8f.37.2025.10.21.06.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:03:55 -0700 (PDT)
Message-ID: <3acacf6f-d31d-4770-b468-7c8407e26caf@gmail.com>
Date: Tue, 21 Oct 2025 14:03:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 08/10] bpf: verifier: refactor kfunc
 specialization
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
 <20251020222538.932915-9-mykyta.yatsenko5@gmail.com>
 <e6388c88bcb09404209a956e65f4d0510aa13294.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <e6388c88bcb09404209a956e65f4d0510aa13294.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 00:38, Eduard Zingerman wrote:
> On Mon, 2025-10-20 at 23:25 +0100, Mykyta Yatsenko wrote:
>
> [...]
>
>> @@ -3375,18 +3366,25 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>>   			return err;
>>   	}
>>   
>> +	err = btf_distill_func_proto(&env->log, desc_btf,
>> +				     func_proto, func_name,
>> +				     &func_model);
>> +	if (err)
>> +		return err;
>> +
>> +	err = kfunc_call_imm(env, addr, func_id, &call_imm);
>> +	if (err)
>> +		return err;
>> +
> Sorry, I should have asked in v1/v2. Is there a reason to call this
> function two times? In other words, it looks like doing the following
> on top of your changes is sufficient and removes the need to call
> kfunc_call_imm twice:
Yeah, I think we can skip the first call, I got confused initially by the
sort_kfunc_descs_by_imm_off(), which relies on imm to be set, that's why 
in v1 I
also re-sorted array after modifying imm.
It looks like initially we sort by func_id and offset and then modify 
sorting order to imm,
offset, we patch the imm before changing sort order, so it's all good, 
thanks!
>
>      ---- 8< -----------------------------------------
>
>      diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>      index 0418768d13e4..f509f9e0383d 100644
>      --- a/kernel/bpf/verifier.c
>      +++ b/kernel/bpf/verifier.c
>      @@ -3373,13 +3373,8 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>              if (err)
>                      return err;
>       
>      -       err = kfunc_call_imm(env, addr, func_id, &call_imm);
>      -       if (err)
>      -               return err;
>      -
>              desc = &tab->descs[tab->nr_descs++];
>              desc->func_id = func_id;
>      -       desc->imm = call_imm;
>              desc->offset = offset;
>              desc->addr = addr;
>              desc->func_model = func_model;
>      @@ -21892,8 +21887,10 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
>              unsigned long addr = 0;
>              int err;
>       
>      +       addr = desc->addr;
>      +
>              if (offset) /* return if module BTF is used */
>      -               return 0;
>      +               goto fill_imm;
>       
>              if (bpf_dev_bound_kfunc_id(func_id)) {
>                      xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
>      @@ -21922,9 +21919,7 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
>                              addr = (unsigned long)bpf_dynptr_from_file_sleepable;
>              }
>       
>      -       if (!addr) /* Nothing to patch with */
>      -               return 0;
>      -
>      +fill_imm:
>              err = kfunc_call_imm(env, addr, func_id, &desc->imm);
>              if (err)
>                      return err;
>
>      ----------------------------------------- >8 ----
>
> The desc->imm field is used only from:
> - kfunc_desc_cmp_by_imm_off():
>    - invoked from do_misc_fixups() at the very end,
>      after all specialize_kfunc() calls are done.
> - bpf_jit_find_kfunc_model(), from some jits.
>
> So, that should be safe.
> Selftests are passing after this change as well.
>
>>   	desc = &tab->descs[tab->nr_descs++];
>>   	desc->func_id = func_id;
>>   	desc->imm = call_imm;
>>   	desc->offset = offset;
>>   	desc->addr = addr;
>> -	err = btf_distill_func_proto(&env->log, desc_btf,
>> -				     func_proto, func_name,
>> -				     &desc->func_model);
>> -	if (!err)
>> -		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
>> -		     kfunc_desc_cmp_by_id_off, NULL);
>> -	return err;
>> +	desc->func_model = func_model;
>> +	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
>> +	     kfunc_desc_cmp_by_id_off, NULL);
>> +	return 0;
>>   }
>
> [...]


