Return-Path: <bpf+bounces-22746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E81928684F1
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 01:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5651F22DC7
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 00:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC13376;
	Tue, 27 Feb 2024 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccn3GhNc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFEA161
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708993181; cv=none; b=fz7K7OMMh4Yu+bE8JysixMGzqcXxf6B47Ro3asP479K5NyxzWlTheaCkGO4wpJFAhMzwF+yrtcEi6zpz9nGU9fwHcHtiAB6EPpQtIl7yLcoW7l/C3CIRuIlFXanhwGmROAJxBrdXfCh/ZGhXaWMfVYoqo/fHEE/pan78keLP1rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708993181; c=relaxed/simple;
	bh=wWRkiiKSCuOQXFUhlIOlptgx3x0hoeLhyMlKWPX405o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9g8l40HVaycPlSswV1ag7lcIcvWA+pmyGlACN9ir/vRkxi3Le5b3MXlCA8Rx8dCO/Rq4vOkuNHGPMIcdYt2dnaUKIIOa7SxF8VJWiNgTz0WCGs45cR2+OEzn6yiOc19oCyp4FQbTs2h5ypLv2ro/BVwG7IOrbZuxQP7vgQNQnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccn3GhNc; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-608cf2e08f9so30750707b3.0
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 16:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708993179; x=1709597979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKlCHKEHD2OqqtboEApOQCsW27CxRDgGe3A6L1L8QBI=;
        b=ccn3GhNcjIGjC55zN/s4Obg1eyqE8s3D1skJEoimbkFot6K+BKPxz3uOePgSTRIC8p
         qlThQjvqK+9BFTGB99xXVjvseE4XOKfdpBtDS/dnVG8R4Nw7SELk0anzPjMOz5s9YSsJ
         t0/7xTYxLkRJaLbFqE8lilRcQOkWG748oN5s96SBdav5RdFEpwhwt1dUBJfhyBpqaMEJ
         6daDSIHMpZ6vWw3bDUzownOw1UgXKSj0vFFb+QCuQpmu3jTwZjphDXhohCC0NwgMEmE2
         /gpu52BHtKjPB1cHIGVw98rzXzuMtTuhqqcxRgwXOSQd6NXeP3MIqb1YyShGm3QrvR3C
         Mo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708993179; x=1709597979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKlCHKEHD2OqqtboEApOQCsW27CxRDgGe3A6L1L8QBI=;
        b=LLplpwGdMj47wZlOzGCGmB4lmLZUzHkfP3txWoE+tr3M1zNbEnVmeR2PQAs38VvU4A
         aJ9VE9pvI6H2nyKIRMDsXk95t9Ay37Ru4aG3/4hvY5cViijsRHjiCN5C++BP3QZgz4Eu
         VDoai0yhcQB42WggKEWonOiXzgxKO2s6+x6sVx0RcS3dtwuNVxS/Gj8I2Phcpjom6pvu
         EuAAD5YbULo3L+1A5FWW+e7JxdYJleEfABbepu86x4jqInoAw/PcUPCX/JkKqsgZKZ1/
         q9pvw/JXrYhAmN7l/ztsAD2f+LbsNpJupsrQZxMz2A5DX7zQwWq49O6JqJNYxzC+1A3C
         PPug==
X-Forwarded-Encrypted: i=1; AJvYcCXMIocftbwDQW64EVSETSSI9Wq7EW/gZvGgqyNlsKM6ZzOlIbHk2yHp8IpBlXWefrCtgtDRRONwLzjAzMYGGCPum92q
X-Gm-Message-State: AOJu0YzaeWzfq1YEKgO8sworpZtLCIMnEMe+M9sBVEQkeJzupfGhZGhC
	aYYpYB26BYsnXdl8lREwo0zPY+860+iJbM6lYWNaLUbVI0fvSSy1
X-Google-Smtp-Source: AGHT+IH5C0n/wF8XkW+9zREWv7u1LMbiJvDtCe1deAT0/DHlnGzR5yqXbbPvF8IyyLZye/UAXgHbzg==
X-Received: by 2002:a0d:d9c5:0:b0:607:75e9:c786 with SMTP id b188-20020a0dd9c5000000b0060775e9c786mr810636ywe.8.1708993179403;
        Mon, 26 Feb 2024 16:19:39 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:5f7:55e:ea3a:9865? ([2600:1700:6cf8:1240:5f7:55e:ea3a:9865])
        by smtp.gmail.com with ESMTPSA id d14-20020a81ab4e000000b005ffc15cea80sm1415808ywk.26.2024.02.26.16.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 16:19:39 -0800 (PST)
Message-ID: <7f33c7dc-b2bc-48e8-840e-bfd3de5845da@gmail.com>
Date: Mon, 26 Feb 2024 16:19:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/6] libbpf: Convert st_ops->data to shadow
 type.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, quentin@isovalent.com
References: <20240222222624.1163754-1-thinker.li@gmail.com>
 <20240222222624.1163754-4-thinker.li@gmail.com>
 <0d8d82e5-c55a-4f6f-ba92-3d169daedc8c@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <0d8d82e5-c55a-4f6f-ba92-3d169daedc8c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/26/24 14:57, Martin KaFai Lau wrote:
> On 2/22/24 2:26 PM, thinker.li@gmail.com wrote:
>> +/* Convert the data of a struct_ops map to shadow type.
>> + *
>> + * The function pointers are replaced with the pointers of 
>> bpf_program in
>> + * st_ops->progs[].
>> + */
>> +static void struct_ops_convert_shadow(struct bpf_map *map,
>> +                      const struct btf_type *t)
>> +{
>> +    struct btf *btf = map->obj->btf;
>> +    struct bpf_struct_ops *st_ops = map->st_ops;
>> +    const struct btf_member *m;
>> +    const struct btf_type *mtype;
>> +    char *data;
>> +    int i;
>> +
>> +    data = st_ops->data;
>> +
>> +    for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
>> +        mtype = skip_mods_and_typedefs(btf, m->type, NULL);
>> +
>> +        if (btf_kind(mtype) != BTF_KIND_PTR)
>> +            continue;
>> +        if (!resolve_func_ptr(btf, m->type, NULL))
>> +            continue;
>> +
>> +        *((struct bpf_program **)(data + m->offset / 8)) =
>> +            st_ops->progs[i];
> 
> This is to initialize the bpf_program pointer in the st_ops->data.
> Can this be done directly at the bpf_object__collect_st_ops_relos()?

No problem!

> 
>> +    }
>> +}
>> +
> 

