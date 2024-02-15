Return-Path: <bpf+bounces-22101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0715B856D86
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 20:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B071B2113B
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 19:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7A13957E;
	Thu, 15 Feb 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIdZa+MX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6988F2595
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024768; cv=none; b=cwzV67GxWZDIoz8kE0Ke+UVHpTEJovizqgXGU8Mx0bw+/epEg2H2RHEWCp7ieouS2rUP7jAOgxKw3+1m2/VnyY1ZAKkX+FDK66BH6/lvAZUCkg0jUQ/eux9rIdvHPb6kMeaXNMEQY0SfU+syMzKHZqeQ58qJGCPotmtiQt0sfUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024768; c=relaxed/simple;
	bh=QF+fzc2PZLLXsfL0IW5QnGsfRwkrc4qU7GH9Po+8Zpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gjPbt/ZFKHVKMJ0ndAaPtPkEVRyGeFTJGwZDknVnISg5rkrT7pbZX6CyXWpM2ipEYOymSTVNVHoJ0ej92Sae9fhxzM/QPfSeslQ20wWvbqKyq+mvvHgXDffph1zSg3Z0zPhIX+nkYNaf3TfsdqvzjSqZGrQYjxaiZBv/c5IvRR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIdZa+MX; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607e41efcf1so6599357b3.1
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 11:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708024766; x=1708629566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVNTT3i8CzyCieqAwB+/JMKFTRPfB+Z8gbty0NFt+EE=;
        b=eIdZa+MXPyNzacCBnqNtxsjvUKTvX8LiH7lYTRBP9R0qIUIyVthx5cXEb6Z3ohgixi
         cA6K0QbQKEnuEGHQcHkye4BdjdtTHShCVUx+Seg3ueXwoJFDPpVy9u56ZCCGgSjoZcFz
         uNLrtGtpGMYuoIv1i5UKGaiJhil2p7NbiDE4Tro7vMWyT+AH1tgemI37/EvMNBCXhHwj
         gr7gJz5iMzly/7ikcSIPGOBQ8j4EH0SwAYqrvbpQAxjcDsI/1gGcT2EgocsXa/UK2jNy
         Sjb/adjpvbuBLMtj9KbNBDUkx0dgJ6RlvY6l0l5d+mHEds1Ckr/ZK3RNon4xXdSTDbra
         K5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708024766; x=1708629566;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVNTT3i8CzyCieqAwB+/JMKFTRPfB+Z8gbty0NFt+EE=;
        b=i1aK6ZJBktB0+UjvJD88GTnelUTyjKRyzjr0fkR5aosiNZbAaEJ1M8KQJ17S3TYSM4
         zdNrDaRG0H5vX8EmKBAZ/eoT2bfq0s6nRSHVARHqgarUkFbsULBWHD2elPXIQ9kEUd1o
         g+0yGFz3LFRgASNiMK4UWn51PxZuo1wZ1feaRc8ED4VYSjP0OJWnrgNvHQs9Udp7wbZY
         U5tfag7KH/tvLiQjcCBYmtKuJIdBVL7uRxawkzIIQkLVcYsseqMR4g4AZtaHa4/Ms2xx
         U1Z5XbGmn/CDLhjpmpHtyiEMA4vFSNDdiE/59ho5xwq9gsqa99+GXQu1xMvJeSTRJF4m
         hU0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXv3doq1jb2jcBq+NHrgknfaloJlmk4NV0y+8n1VCvgmmoxqCE96oPBKrFk6BIdGlUfW/bhWH9LH+8WKL6nMGB8B4PY
X-Gm-Message-State: AOJu0YyPg3YfjEDkGLFKZnYJK4mSlH951HzrAKaS4P2VA+3LfhpQSFII
	SXHt3n3GiruZpk/+Qp5NUDNexL4jEGmxKwsr5jHOqHdifrdZpLaE
X-Google-Smtp-Source: AGHT+IEqfpQKxWQS9+FCHOQdwBFmAIcpAGc+dnr/JQkCsReTt4vBvAxKWYZcUD/Eigla0xIhT7HSWg==
X-Received: by 2002:a05:690c:82e:b0:607:9e7e:7d02 with SMTP id by14-20020a05690c082e00b006079e7e7d02mr2603674ywb.35.1708024766327;
        Thu, 15 Feb 2024 11:19:26 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:121a:9239:6a3e:3f96? ([2600:1700:6cf8:1240:121a:9239:6a3e:3f96])
        by smtp.gmail.com with ESMTPSA id r76-20020a0de84f000000b0060784f1fadbsm3503ywe.109.2024.02.15.11.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 11:19:25 -0800 (PST)
Message-ID: <6b75ba79-dfc8-4681-b8d5-3f63e0b6706a@gmail.com>
Date: Thu, 15 Feb 2024 11:19:24 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Check cfi_stubs before registering a
 struct_ops type.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240215022401.1882010-1-thinker.li@gmail.com>
 <32dd0715-1f36-4de2-ab69-0e21019eade5@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <32dd0715-1f36-4de2-ab69-0e21019eade5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/15/24 10:23, Martin KaFai Lau wrote:
> On 2/14/24 6:24 PM, thinker.li@gmail.com wrote:
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
>>   kernel/bpf/bpf_struct_ops.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 0d7be97a2411..e35958142dce 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -302,6 +302,11 @@ int bpf_struct_ops_desc_init(struct 
>> bpf_struct_ops_desc *st_ops_desc,
>>       }
>>       sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
>> +    if (!st_ops->cfi_stubs) {
> 
> How about *(void **)(st_ops->cfi_stubs + moff) ? Does it need a NULL check?

This NULL check is necessary to prevent the crash but good to have.

> 
> Please add a test.

Got it!

> 
>> +        pr_warn("The struct_ops %s has no cfi_stubs\n", st_ops->name);
>> +        return -EINVAL;
>> +    }
>> +
>>       type_id = btf_find_by_name_kind(btf, st_ops->name,
>>                       BTF_KIND_STRUCT);
>>       if (type_id < 0) {
> 

