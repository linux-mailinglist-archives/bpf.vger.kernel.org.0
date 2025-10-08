Return-Path: <bpf+bounces-70563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8160BC3131
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 02:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E0664E597D
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 00:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6872367D7;
	Wed,  8 Oct 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwaDFdhO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223BB15D1
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759883124; cv=none; b=uJk9DnAmlLXmyETPO6PnGcm0S2QM5qjXBQuMFIEUqkv+kAPOZlJsMd5y1VRNqQEfo4ZD1EWZvAsfXEqD2fgBYvSnuFbr7hZSbiQojGtkMMH1VZA8gMbydIbyL+CTDNQQub9pYCPNvsGPhB4QRZN8vvPJeMVRXLUyJUZ8Gw8sURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759883124; c=relaxed/simple;
	bh=Jtg2b3nObX99dDQGbY3zeMhShoXcITYDHZT0BPxza/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJiOXt6J9i294fE9fI7FHJbCpLU5MKDjvJ3fV02BRN3RKBZolrxmcAnLr2s4ghkw+6MOV6n1Bq70JzfB2Fld4hsLSo3u0Cd4mV2NibyXN4V4NDr22Y8pybv94Avh6TIzEd7I99jcrovanJ/zo+yobHKe0VaSpc4AXwKTDB0Bi/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwaDFdhO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e4f2696bdso82255205e9.0
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 17:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759883121; x=1760487921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1TewT05QsCmN2H9BRIbAPb+VmMEDffe+it12p2hhiU=;
        b=SwaDFdhObPqD4jyF5g81/K6SM6ZvtTVLpqoeALWmdCSk3ECcOE9e0e8Y1FNcr40nFe
         RQy8ZxFuvYpiULzY7GAwxfiUoy9xeWIX41itJnr5+VCTGBI+sTmvs4RuGIiDDfbqyLUb
         5rS3R9eQES4EoaTgq7JurHUxQc5pWxKsqS6RFrLu7PhbwNbQSpKgsnKnJ6FqC0YacMsX
         HLDsc7nhBW8hM7Hbtlp2crSV4HmN+MQr/s0FCxkDgSv3j2/l2nYK1Y2prlQ8l3O/uXHO
         K/dsi6FqGE68e/uq9kZf2ZkFiHIbZ46Oz9Uu1dQzuLkkw0tB9sm7NI2BKc2aMAAQqMxj
         v6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759883121; x=1760487921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1TewT05QsCmN2H9BRIbAPb+VmMEDffe+it12p2hhiU=;
        b=az46iLXPzMM5/mhqbWgqezN/EEVnksRYEMd45kLM7eH8RvX8mt/zkdkNBu861wV1wo
         yGiSalHRfO2yyEBbqrK3sf0os01xjr3B9pCqT3fBcmzqrxQntmmCzrqc1Fc1ds5QzcEv
         9Jeqxg1ukyB61JAX9NSSlonHYF01qTtMrMrcDaxgJ0omSaAkejjKDpepPyc+xZfS/e1H
         qUg0DJBn+2dXlSgOu7POO6JaChOwFFzDS2Q277aByl7TfRUASWUU47t9Aoi48z9y+fUA
         ar4fk6XDpum3RmLaf9x0xMaTFeY1/jq5pgi9fddNqfYAij982xeX50Ocq5kqVmCJWA+v
         XIUA==
X-Forwarded-Encrypted: i=1; AJvYcCVmJ1CkPteHs/R0VD35x9iGHUfn4K8KQVHZXEEXFBnUHyGYqKfn5n7RE6WSQ8FsDBo2K+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAufyPSKJNCHJK+xJ/Juojj8ntX8+IVqR839NHXhRZyCC57BO3
	kgOewoRI2z4MkCR1hLusLgwT/6GTRUHjpEwpeR+XSeZ5hsvKvKAV+yQc
X-Gm-Gg: ASbGncs6UslBJjGEB57pZyptU+VPKCI7CC3z37VDffbQa6KiXYDfklobBBC0eOahfOV
	9S0A9WiB9TfxR1tE7r14B7nwcqKyrRwWwlrxg0V1sLYzgIpLnX6VnwqS8beHeRraXDiCSHcQ/4v
	o18pKyeBNhCh/8q+FlEPMWKMiNo3U9e1kuiSD0JOIG1iyYg2XReS+yIdB9ik2C+2nJAcH3jfHTv
	dJhYr1PW2MC0FLQCGipWE4r3uGdV67AYAfLs6k2EfF4cwrvpX/AmEcVHytUV7Vhj74f7//6eGK8
	/OkOuuZSDuOfKr2+hOWVZSGIN0DHjSfO3Pxlics12rO68dl0QoNZvWx2indjVddPCrUhj9WW2uI
	guI3fxxFqx9cj+PBWfXqhR+M8FQMd+5xRwFb1r0u/vPwRQfysuRarUbYaU9kQjsU7Eqc4UEj0Kn
	OND3qXDgRgqCuj4rj5u4xcmgjTcrbVE9M=
X-Google-Smtp-Source: AGHT+IGplK8zPVplGEUniAcu1+DYT8Vow9Nr3ZUyQRUXR1sSxOjhxYnhMtK6P7w5OFcCcwUhKuQ7yg==
X-Received: by 2002:a05:600c:1f06:b0:46e:384f:bd86 with SMTP id 5b1f17b1804b1-46fa9a9443fmr8763095e9.5.1759883121099;
        Tue, 07 Oct 2025 17:25:21 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c2884bsm13311995e9.17.2025.10.07.17.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 17:25:20 -0700 (PDT)
Message-ID: <894be77e-66dc-407e-9388-daadb175d376@gmail.com>
Date: Wed, 8 Oct 2025 01:25:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 07/10] bpf: add kfuncs and helpers support for file
 dynptrs
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
 <20251003160416.585080-8-mykyta.yatsenko5@gmail.com>
 <706964d19f99777ae76c1cb930fd0a30f979e23f.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <706964d19f99777ae76c1cb930fd0a30f979e23f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 22:35, Eduard Zingerman wrote:
> On Fri, 2025-10-03 at 17:04 +0100, Mykyta Yatsenko wrote:
>
> [...]
>
>> @@ -1702,6 +1733,25 @@ int bpf_dynptr_check_size(u64 size)
>>   	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
>>   }
>>   
>> +static int bpf_file_fetch_bytes(struct bpf_dynptr_file_impl *df, u64 offset, void *buf, u64 len)
>> +{
>> +	const void *ptr;
>> +
>> +	if (!buf || len == 0)
>> +		return -EINVAL;
>> +
>> +	df->freader.buf = buf;
>> +	df->freader.buf_sz = len;
>> +	ptr = freader_fetch(&df->freader, offset + df->offset, len);
> What will happen, if file does not have enough data to read `len` bytes?
> Will freader_fetch() return NULL?
yes, that's what should happen, freader will try to load folio after the 
last one,
which should fail and return NULL.
>
>> +	if (!ptr)
>> +		return df->freader.err;
>> +
>> +	if (ptr != buf) /* Force copying into the buffer */
>> +		memcpy(buf, ptr, len);
>> +
>> +	return 0;
>> +}
>> +
>>   void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
>>   		     enum bpf_dynptr_type type, u32 offset, u32 size)
>>   {
> [...]


