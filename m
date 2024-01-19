Return-Path: <bpf+bounces-19902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB2D832EA0
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 19:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBEA1F2427D
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 18:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513FB55E7F;
	Fri, 19 Jan 2024 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfBouHRK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AF55E6D
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687561; cv=none; b=Nl5biYLDGzmccVo0bdYe+7opiixBFntFvtecli8rtqDDVPk/FDhyQsGg+k3HteUBgPRSsdM4jTRTv+9E9tnWmZLp6akMiUnnGUMYwTcPHNcDZ3USJX7YQkG1Ymg5czbpPopuJgnqinr5HVFr7JmcJbaI6PBMGYTWE3o0Suzvr0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687561; c=relaxed/simple;
	bh=UVgnj/EJqFd9dZVAxqFO58SHUoy8lOdgNtsn767QH/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asALxZjknQJcW3mdYgCp3P/hPt50y77JwMmHpS/h/B80L5VfLxm9N9gie4tQsnaSgSnZeg5qwh38zAyd+wMAChfOUY8pJCjQFobZCDoJr80378lLudBdBXEJN3WBtC7bVFF98WueGGE+J/8J8wtkZwdF4sJ/GnybO/JeIwTfLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfBouHRK; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5edfcba97e3so11601827b3.2
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 10:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705687559; x=1706292359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+OuVbguvqUkQkKaFYnaigV5Zn/g2/zgNXwCVZMk5uZg=;
        b=bfBouHRKdlO9ddGmTpllROHL46UXUuu22LApKPNI/DYzJl8uxNBc/Vds3osGvU6+2a
         WrqZscvRvBcV1Lcm/yDUzGTJdu02MDwM98KKkITr4aQ9+ERVisBe8ypFSwyoGKkdkS36
         qFld0YIwWrYp0XfFSyudk4Vr3aUiX+TChOgksM29GgRsVDa/akLwG9fiMxEpIuK+xmsz
         Af/2eq9j5HB7gBFEUDRZrdXgd1Mc6oslWSk+pR+OnaJX9Xc45Pv7qVDWsNOXuJt2v/LK
         9KjMvfxY0TVQUdIrD/OxLWKHtR97NUBPbMPTon87Ur2DXGAlrPHlISgazOfrHtILgQCC
         qsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705687559; x=1706292359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OuVbguvqUkQkKaFYnaigV5Zn/g2/zgNXwCVZMk5uZg=;
        b=nQlCIiCMFgUNuKrYNETx1ZzrlN9T46bqzbWS4K7CwIXb2cFOao3LnpVTxVEz5fbv9G
         mpld9Ye9COdiiHMrIo5n8uZ7OZ0I57GeDEt+89v1f4mitP341mFHNIHhOIoIRdsr1VKy
         fAJY46uZzgcHHl/i9KE9kjzW3fTwiT48T2GMv7FIaEllVcBDgb/OokvaxO3jgTQ8BUkZ
         2WnCXJWCesekV9IWsZ7hav3lDFjhBwMtrw8UxUpPz6XmoWwZ0bJypSohfQOlcqFv4kKK
         99OyztxRBOq34jcG4zHCH5rM9zHSItp8QhnEoGqke6azUFcIaVDyWQ8kw+aKQ9sv4wsl
         9clg==
X-Gm-Message-State: AOJu0YxXk8Hq3KXAQZGJTEO7kABpnCJVZJ/JkDa+Egw2sUYRQMXWEkkP
	fNzQolsJoomaPcAU/3wFlKSBDOsXCD0VpVywXV8RE0RPOtVqNnm0
X-Google-Smtp-Source: AGHT+IFu/MMKmC3gEgYWz7kaDmBLTjXz5ciaPQnj0l7mP6cWsoyD2gh+L8MyvOU5REOonyFgGrsayQ==
X-Received: by 2002:a0d:c802:0:b0:5e8:92f9:46e8 with SMTP id k2-20020a0dc802000000b005e892f946e8mr309653ywd.30.1705687559391;
        Fri, 19 Jan 2024 10:05:59 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:c63b:9436:82f0:e71a? ([2600:1700:6cf8:1240:c63b:9436:82f0:e71a])
        by smtp.gmail.com with ESMTPSA id w135-20020a81498d000000b005ff89655201sm1357882ywa.114.2024.01.19.10.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 10:05:59 -0800 (PST)
Message-ID: <cce556a9-ca52-4dcb-8d3f-46f363162cac@gmail.com>
Date: Fri, 19 Jan 2024 10:05:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v16 08/14] bpf: pass attached BTF to the
 bpf_struct_ops subsystem
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-9-thinker.li@gmail.com>
 <c8ff1275-fbc2-4117-9f40-59072e129426@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <c8ff1275-fbc2-4117-9f40-59072e129426@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/18/24 13:56, Martin KaFai Lau wrote:
> On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 0744a1f194fa..ff41f7736618 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20234,6 +20234,7 @@ static int check_struct_ops_btf_id(struct 
>> bpf_verifier_env *env)
>>       const struct btf_member *member;
>>       struct bpf_prog *prog = env->prog;
>>       u32 btf_id, member_idx;
>> +    struct btf *btf;
>>       const char *mname;
>>       if (!prog->gpl_compatible) {
>> @@ -20241,8 +20242,10 @@ static int check_struct_ops_btf_id(struct 
>> bpf_verifier_env *env)
>>           return -EINVAL;
>>       }
>> +    btf = prog->aux->attach_btf ?: bpf_get_btf_vmlinux();
>> +
> 
> just "btf = prog->aux->attach_btf;" which was assigned to 
> bpf_get_btf_vmlinux() for the non-module case. Take a look at 
> bpf_prog_load() in syscall.c

You are right. I have been too protective here.

