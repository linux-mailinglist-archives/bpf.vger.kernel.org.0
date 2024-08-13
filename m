Return-Path: <bpf+bounces-37061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4B1950AC5
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BEA1C21AA5
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF881A2548;
	Tue, 13 Aug 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4ZXAxmq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B754918
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567950; cv=none; b=nKx0Fg5E2N1QpwHDX/eKRHatxIpPnmiI52KgcoiWRHbPStkJrHeKNWhwKtX3meOd6HGHbF/bq+qi4fPcmpZo6f/ZKvdug5TpWqOv7wJ/gto1dq6oAKWOg5b63yEZhWY64S16Ak2+gecYry4hfK4XD8PrTvdXUwtr5XipqsPBYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567950; c=relaxed/simple;
	bh=iXo6SMrH/ey97PgjflU6OUS/0I3l+rDDFNfSrD4Eojk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2s0rp9laBnEC9+4wgpLdKzGnNsoE/A+R2FGpuIuemql9Hdpm5YztdaUNdzMm4qK8jEiuRl9rz+48qX4PlWETG+v3eMmEuFt404Pmcnl6jX/p7rAZXEVEUNafmXUS+UjQ8D7/MdJUjK6VOzobPASY36c3h7rSkCrErw0q7FBoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4ZXAxmq; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e03caab48a2so51107276.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723567948; x=1724172748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8D0BT+3R/NdR5e9vk1S0ZBvGSp9KXbOWD09YEnmrPE=;
        b=g4ZXAxmq0EIYU7r7NewYzBBL6kQI5DK1sS4B+4DG7OdXojK9QkX1M5IR6e64baymV5
         ow64S+KafGLYdOT6prm+BYGt30jjMH9TczhOz73W9r0Ao5gL5O5A0EPIFq/HzO9/RNCE
         vq1+iqOeWcPZ1D7ibg+DT0zZPxgZ42BNPMHf8uSOmS2SKGJMSfSM3mztcrgHPaEIFtBc
         XYhLJS8isQtbgR0bQ5MIe9ZCOHDazduWJ9+rrH41g6QSg9oQGqYtT/lbkFigkRIN/SAz
         eAgW04F3dB5oYqU+HFPnoMM/9NSwe+HbDnzVo+9k6VWg2jmtzcdHUypogR0olwsrkfO5
         e5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567948; x=1724172748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8D0BT+3R/NdR5e9vk1S0ZBvGSp9KXbOWD09YEnmrPE=;
        b=R16jp2ppMwqohHZFrFY0KN91icUTUeAbAP3USAPMsDf5cXGvOPVAKm3klVYZp6N/ul
         D9gTJue6SUzagyUUApkIKsAfYKfaY1tsVvJVi6IwX1lodCswNxubV+v4v/9aGDgVSrPu
         ZkEHQ+TtM1TBIyKN2w3iESd5S9uHiXrNvTWpTA9F3VynIwLe1c5ZdF/LGljm96QHeBFn
         UX/8QVAk8jpL7drTRnx/8Lyi80bHnHWJKBW0IiIh9PfmrcujuYqiiwQiCDM6oFBFLiMI
         lZu+JUGC2k81MlqVhbhe1W8CYEsVQpOeAsNMUn+X1uUdwUYOSeJflFl3i57nKUkC7Szv
         nqbA==
X-Gm-Message-State: AOJu0YzvHCqKEaStLsXHiwMSo3wdDN3Sal1kUnkE09iWNuoo+0cA4DgN
	St8eJQPUQpJW2lusof1LSdyXiLEizbAJlwetIRDBHlbsmdWrf58j
X-Google-Smtp-Source: AGHT+IG+Onsj/LB1wu48g5Jek592DPFG4T2RA3qq0JsM0Unjs4/WGYhpNU7SS+ojZQ+FFouhb3Z3Gg==
X-Received: by 2002:a05:6902:160d:b0:e0e:8740:2a76 with SMTP id 3f1490d57ef6-e1154fe4b38mr377798276.26.1723567947702;
        Tue, 13 Aug 2024 09:52:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:2ccf:8565:88c4:147c? ([2600:1700:6cf8:1240:2ccf:8565:88c4:147c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0ec8be5ab0sm1552156276.17.2024.08.13.09.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 09:52:27 -0700 (PDT)
Message-ID: <00ec1572-9f74-4a01-b30a-4eb03489284e@gmail.com>
Date: Tue, 13 Aug 2024 09:52:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 2/5] bpf: Handle BPF_KPTR_USER in verifier.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kui-Feng Lee <kuifeng@meta.com>
References: <20240807235755.1435806-1-thinker.li@gmail.com>
 <20240807235755.1435806-3-thinker.li@gmail.com>
 <CAADnVQJdZgJi7=jo+Ur+hL1WtW3x06Zptupk+QOp-mMzSefzYw@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQJdZgJi7=jo+Ur+hL1WtW3x06Zptupk+QOp-mMzSefzYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/12/24 09:48, Alexei Starovoitov wrote:
> On Wed, Aug 7, 2024 at 4:58 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> Give PTR_MAYBE_NULL | PTR_UNTRUSTED | MEM_ALLOC | NON_OWN_REF to kptr_user
>> to the memory pointed by it readable and writable.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/verifier.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index df3be12096cf..84647e599595 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5340,6 +5340,10 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
>>          int perm_flags;
>>          const char *reg_name = "";
>>
>> +       if (kptr_field->type == BPF_KPTR_USER)
>> +               /* BPF programs should not change any user kptr */
>> +               return -EACCES;
>> +
>>          if (btf_is_kernel(reg->btf)) {
>>                  perm_flags = PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU;
>>
>> @@ -5483,6 +5487,12 @@ static u32 btf_ld_kptr_type(struct bpf_verifier_env *env, struct btf_field *kptr
>>                          ret |= NON_OWN_REF;
>>          } else {
>>                  ret |= PTR_UNTRUSTED;
>> +               if (kptr_field->type == BPF_KPTR_USER)
>> +                       /* In oder to access directly from bpf
>> +                        * programs. NON_OWN_REF make the memory
>> +                        * writable. Check check_ptr_to_btf_access().
>> +                        */
>> +                       ret |= MEM_ALLOC | NON_OWN_REF;
> 
> UNTRUSTED | MEM_ALLOC | NON_OWN_REF ?!
> 
> That doesn't fit into any of the existing verifier schemes.
> I cannot make sense of this part.
> 
> UNTRUSTED | MEM_ALLOC is read only through exceptions logic.
> The uptr has to be read/write through normal load/store.

I will remove UNTRUSTED and leave MEM_ALLOC and NON_OWN_REF.
Does it make sense to you?

