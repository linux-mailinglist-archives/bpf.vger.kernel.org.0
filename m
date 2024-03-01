Return-Path: <bpf+bounces-23171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3783386E7F5
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E095D1F2973A
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647DF2746D;
	Fri,  1 Mar 2024 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMLqlWtt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55016FF21
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316256; cv=none; b=lqNhje/5uZNZCEIMnKHnC05J3Wdt8YNEOC81HbDGmpBm18UGGlbjUv64TOsx+FD9ZhuWCwmDPakN/Vw6WMih8k+G9J5r0pgTjA2gGeMQT0In5MLRkrkQWRYD97AsYtnyUv3Gsj+nUbvtxzzsxGeZtEANP0DVpcqDRytyK0uBCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316256; c=relaxed/simple;
	bh=vdAXjjJTZZP8OO8dJRoVviGnkrVlBNZxS/+ymY67kDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaqLjTDwDZfzJegDlAO/x4dJGPF3x8E0EFtg1rBPR/5lEMHWmP7MAY3cdKXHeTNwvJat5taTZszrRv2GuHXQ5Erq30WxCo8rJIDhGuql8m12bYVIxRMf6YlJCgjUrqbued82DHim79BCBNrn2Wri8J5heCH5AY4UNRFF/SZjKjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMLqlWtt; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-607e54b6cf5so17193477b3.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 10:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709316253; x=1709921053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44fmF/zi97ai9SI3mCC6336LYXXhizR0NraAUrChuAU=;
        b=gMLqlWttx1UfzU1ejwduCO9VY4JKXH957I3GzBqrZ6F6oolY9YpCMgWlUHBL4s/ypP
         WlAshrGVh5rbpHs/5zIhC/FsHuTPYyHB2qR0u4Db0vZoxAtCi49WOCreLKeiGyfWrQpf
         bmc6/2QWZ8FjPot/QUADg2aQuGn84T+ttPQcIsUhC8+/50DGPLYdnk0x6WYDHIrMJJ2X
         eWt2dP8hd39mxh6BUMCNV2Ct8rP27+n81afAImBN3kvvymKLmcI89fIlb4+m0QS0fom/
         iPbAf9YMn7zF8U+brDDTm02it5WPPHuahjoI6Y+ISEJfWLkZShdQCgfisAhZSKnJYXFZ
         uTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709316253; x=1709921053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44fmF/zi97ai9SI3mCC6336LYXXhizR0NraAUrChuAU=;
        b=Tnp8gNOl3OlyR5zT6B4Mt3Dwcx40brWAORPVP8rJcZjCWhO2LWQ+hcKMwqlVM5lkPG
         QIN0sM9wLfEbagmzXHVZI72gVRw+Zlx+i6gfM6jXqmiKjZD1FJ7FAEzXbVo650igZZfD
         Xeu8Q6kmr/Izx46rRZNSaSxeBS17b61n7AH9C9kCblGaoubBmXrl11t5CiOb/eu8xwi1
         ZYFvARaLaX6P7L1uINZQuXk2/+fdtXDxPcd+mwJnYIx6uoMLCI4A7mxvgVNeK0XB97jj
         gjojZNokzOL61KQGD4YgpJA9zhxxlNy7IiyFZa69+o5nCp4wd5y1ICRzeGdM1BEWGzkf
         LZPw==
X-Gm-Message-State: AOJu0YxJdvLqcSNbGLpItqnDPlmsnWehl38zbE0LwTvnZglT1zNfGHfI
	e4OYVdURBs+oV/wuagyrjxpCnWyLjPISJ3bmeN0GDS02qtqby/P6
X-Google-Smtp-Source: AGHT+IH0Dom3fOFQBQmA5RQ7BiPaO12OqSI06kSATrKi6GH8R5Ix+kMp82H7DGoFexzpgdYClpY2jw==
X-Received: by 2002:a81:82c1:0:b0:609:8cec:36a4 with SMTP id s184-20020a8182c1000000b006098cec36a4mr805512ywf.19.1709316253560;
        Fri, 01 Mar 2024 10:04:13 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:997:2bbc:b035:6e36? ([2600:1700:6cf8:1240:997:2bbc:b035:6e36])
        by smtp.gmail.com with ESMTPSA id g4-20020a81ae44000000b006077d0a9f21sm1068157ywk.93.2024.03.01.10.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 10:04:13 -0800 (PST)
Message-ID: <41651148-1b59-440a-b5d9-9756719e9847@gmail.com>
Date: Fri, 1 Mar 2024 10:04:11 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 3/5] bpftool: generated shadow variables for
 struct_ops maps.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 quentin@isovalent.com, kuifeng@meta.com
References: <20240229064523.2091270-1-thinker.li@gmail.com>
 <20240229064523.2091270-4-thinker.li@gmail.com>
 <CAEf4BzbPG1CSC62dKcDb_=aH8pi7NEZ5zQFQxMQdOPEzZmLzvQ@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzbPG1CSC62dKcDb_=aH8pi7NEZ5zQFQxMQdOPEzZmLzvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/29/24 14:25, Andrii Nakryiko wrote:
> On Wed, Feb 28, 2024 at 10:45 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
... skipped ...
>> +static int gen_st_ops_shadow(const char *obj_name, struct btf *btf, struct bpf_object *obj)
>> +{
>> +       int err, st_ops_cnt = 0;
>> +       struct bpf_map *map;
>> +       char ident[256];
>> +
>> +       if (!btf)
>> +               return 0;
>> +
>> +       /* Generate the pointers to shadow types of
>> +        * struct_ops maps.
>> +        */
>> +       bpf_object__for_each_map(map, obj) {
>> +               if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
>> +                       continue;
>> +               if (!get_map_ident(map, ident, sizeof(ident)))
>> +                       continue;
>> +
>> +               if (!st_ops_cnt++)
> 
> goodness, too much operator precedence knowledge assumed, I simplified
> this to what I can follow myself:
> 
> if (st_ops_cnt == 0)
>      printf(...);
> st_ops_cnt++;
> 
> I don't think saving one line of code is worth it.

It is totally reasonable.

Thanks for review!

