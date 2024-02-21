Return-Path: <bpf+bounces-22472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBD185EC97
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 00:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A06EB21E24
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 23:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80684126F11;
	Wed, 21 Feb 2024 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5eKnOE9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9305E3EA8E
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557203; cv=none; b=QufMeBxWwvBbigBwe9Gm3yDyMg8UxEPBQMEXF5uK+4ReIUYpZvW/glQa1huUGJJufb7cIIwa6rxzZs2GYVE//TTQTE0RY/0WOWchWULZF292afgYt0+0E39h9/a8Q60helxPoV20x0irne7ZpATVxooz66Kzibu0/J91iqEvt1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557203; c=relaxed/simple;
	bh=AxMuwO/MrdA47lE6U0o+edStZ0VprAX3zNcLp91BJNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1LmVvne8vZH5BjyCA0Mr4WvtAFL5e/h6JMfjPkfXsFdgwIWl8Td6uwYOkrX9/wzv29N1vnryVD5vMlisy5gzq7sQSL7Y2mwjduKvIQVJoMtcXtUgUqztjEUa+xwlEaYRVwlJxD8XaVcke9dpgW/PPJBRg9sBNJe0N45KOm2hdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5eKnOE9; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6088276045fso12714627b3.2
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 15:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708557200; x=1709162000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTgMs3K/IQ9v3Khow7x8lVmfaY5YCSyQYbcO/nMh8+8=;
        b=M5eKnOE9O1/5vj6RlxBf8B8hcuJZcDyAShjGDlbXEZg9UQP5bJZoIDMHfZ8zrlPAfp
         EJCRTS1bBer8LHkQ9m2YXLSBgi33QDEw8CiK8q8ktROVnpsIkVbzX5oKwlhbDvbLO2bl
         KSI5RlAZlmsgSgxknkRV5dBJC5ICwqlLLCWb9juYnq5ArJIs6TB2DipCoICLp1frX8b/
         +DlBHHCSFTDzaGzgo3LgSnWiF8PVMeoIKV9VOKMMi95cWFQp0ko/pAsLWE2ChPWbS2CP
         81U6yaDbQCT2TOIyl8pcWDy9s0RLfkKiW2Hhi863hVKBMEexeDHjclb9AF4Dg5wXQrPG
         5oSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708557200; x=1709162000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTgMs3K/IQ9v3Khow7x8lVmfaY5YCSyQYbcO/nMh8+8=;
        b=rKQP1Vy+0vgxMTCR0LBmpjU+PvX2Ikgz/w/OE6SE3btQBY1snetYB8Ywn2fsao4Hxd
         i0rKFRbWeH+fBLTmG0fClHMWbGktYwxJhHmANJQD/FbGlwfy+lkw0b2anBQjR9nPaueK
         odfDIrIAQN2EnVb02ihdefmH+olKZ2rjPN9IY70Sz6Bd/QeD0//AaNGvtpS6nkzALWaf
         rgBJbfab6DuVeRfgYdBCQQ2SmV2qcJbX6n+WnqemIp6L001ueyIQQmEXzmeCjUAhgZUc
         rFGYcWitMWwsgu4SH37SCh9zRdBiu+eoNdFcR2L9DHHs9qP3Ka302nENwVsmOG2nFr4t
         aPsw==
X-Forwarded-Encrypted: i=1; AJvYcCV9d9gnbCIbMGYZpy4NNI+KO7FSMCJNAMUBuhOK4FEvoCWEoZQWntAgxetEpky0HX8JQIBtpJpGQpy1p2TyI910xGX/
X-Gm-Message-State: AOJu0Yw4knksJFz8JoKSv+mErR1Vzk9IPeP+vuJHumiEMwff2TFD/R//
	gBiMLgDD8qeBC+Tlgl7vm4FOWma+4H8beixkEjsN0k6p6X1mUE4S
X-Google-Smtp-Source: AGHT+IG98d7/QM03I6ECRMCCVOu3O0AOhw65EmZdnVFmtSUY0Fm6KzLGEfuXRiVQIMbgfkcryBm7VA==
X-Received: by 2002:a81:4520:0:b0:607:fb5f:5e1f with SMTP id s32-20020a814520000000b00607fb5f5e1fmr16062308ywa.23.1708557200478;
        Wed, 21 Feb 2024 15:13:20 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:bc3b:b762:a625:955f? ([2600:1700:6cf8:1240:bc3b:b762:a625:955f])
        by smtp.gmail.com with ESMTPSA id a184-20020a0dd8c1000000b006081d516064sm2111451ywe.7.2024.02.21.15.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 15:13:20 -0800 (PST)
Message-ID: <286d36e1-1d1e-49d3-93d6-d29b402e6009@gmail.com>
Date: Wed, 21 Feb 2024 15:13:18 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Check cfi_stubs before registering a
 struct_ops type.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240221075213.2071454-1-thinker.li@gmail.com>
 <20240221075213.2071454-3-thinker.li@gmail.com>
 <8e6e79d6-e003-446b-bc36-b6a4500f802b@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <8e6e79d6-e003-446b-bc36-b6a4500f802b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/21/24 10:25, Martin KaFai Lau wrote:
> On 2/20/24 11:52 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Recently, cfi_stubs were introduced. However, existing struct_ops types
>> that are not in the upstream may not be aware of this, resulting in 
>> kernel
>> crashes. By rejecting struct_ops types that do not provide cfi_stubs 
>> during
>> registration, these crashes can be avoided.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/bpf/bpf_struct_ops.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 0d7be97a2411..c1c502caae08 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -302,6 +302,11 @@ int bpf_struct_ops_desc_init(struct 
>> bpf_struct_ops_desc *st_ops_desc,
>>       }
>>       sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
>> +    if (!st_ops->cfi_stubs) {
>> +        pr_warn("struct %s has no cfi_stubs\n", st_ops->name);
>> +        return -EINVAL;
>> +    }
>> +
>>       type_id = btf_find_by_name_kind(btf, st_ops->name,
>>                       BTF_KIND_STRUCT);
>>       if (type_id < 0) {
>> @@ -339,6 +344,7 @@ int bpf_struct_ops_desc_init(struct 
>> bpf_struct_ops_desc *st_ops_desc,
>>       for_each_member(i, t, member) {
>>           const struct btf_type *func_proto;
>> +        u32 moff;
>>           mname = btf_name_by_offset(btf, member->name_off);
>>           if (!*mname) {
>> @@ -361,6 +367,17 @@ int bpf_struct_ops_desc_init(struct 
>> bpf_struct_ops_desc *st_ops_desc,
>>           if (!func_proto)
>>               continue;
>> +        moff = __btf_member_bit_offset(t, member) / 8;
>> +        err = st_ops->check_member ?
>> +            st_ops->check_member(t, member, NULL) : 0;
> 
> I don't think it is necessary to make check_member more complicated by 
> taking
> NULL prog. The struct_ops implementer then needs to handle this extra NULL
> prog case.
> 
> Have you thought about Alexei's earlier suggestion in v3 to reuse the NULL
> member in cfi_stubs to flag unsupported member and remove the 
> unsupported_ops[]
> from bpf_tcp_ca.c?
> 
> If the verifier can consistently reject loading unsupported bpf prog, it 
> will
> not reach the bpf_struct_ops_map_update_elem and then hits the NULL member
> in cfi_stubs during map_update_elem.
> 

Ok! I misunderstood previously. I will go this way.


