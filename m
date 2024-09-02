Return-Path: <bpf+bounces-38722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0243D968C71
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 18:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4978DB21C7E
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 16:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F301AB6E6;
	Mon,  2 Sep 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqE4KGNr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87713D50A
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725295985; cv=none; b=B9Z56LFC3NgnvA8+pQX9F7IeihJr4Sxzhk128tqC4uyhPXgnw0g0iEpQ2vFQpJ8QH1o7F/I/kU5v7vioamjYSUm6Q6Tq1VUGSLtdTZTZnZB/WzIvjm8SWnOq+X+sWmjDZsTwmDWDX6D575J/5e3mpusKyJ1Zus+IgKvPvpFWoLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725295985; c=relaxed/simple;
	bh=g5Wk3sgzLsa+KGsm7nov+wFDqRhOO5blY1+6shswAYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ryip7bHGmnWx1Bl215N//Iew4BvDdmOlTDpXgIlDnjXQVAgZfJ2wIDfE1zf42wWMg5EcWetmFl5ddTs5KVv8hYM23MiJ7rnNlHDKF21uBa0kqR3ZluRsKqOgOYbUtwkDzMw7gio7CPoKDItuCwVQwlRm1g45uzDBTIX1WjCQoMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqE4KGNr; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8684c31c60so498015966b.3
        for <bpf@vger.kernel.org>; Mon, 02 Sep 2024 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725295982; x=1725900782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvEb6GkltRVHLmLQMqhss9lkUpn2wgt27tytuYfvm+I=;
        b=HqE4KGNrSRemrGHw16vRLW/fqEBOenX5XvIQVTZQmUe6/ZkIhP0CxmXiZCUnDZ+N/f
         bC6xp8f7oy0jXf+kQusnAas8bZToj84K37qMyxXp1piUyLPW32nXyZ16YjLiOboUIqgx
         3+DK2oNuEfUW7EleIbMgrTQF2UK+iqFJmRV6OXxeH6bCI/2iwpu5QIqabwJkEKd1uvh7
         L/+czMTzd3/dGGYxuXfNrAqN6BzPZgzxpvtL3d8vApwSXSh/zKael1E0moNsLshs5qyx
         rZ0uyMqiTyAxsbVXtmCONpS6q8xZsqpUnXSvN208k9dn3xpiZgBwe+ik0uexJfg3MvfT
         kMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725295982; x=1725900782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvEb6GkltRVHLmLQMqhss9lkUpn2wgt27tytuYfvm+I=;
        b=U6fIRU/Dc2R+7V1P9Q9iXIEgP9FjLXdlokqkOVkuIpiPOpNJsSotQ2xeKQFKHuQ2hR
         HX15Drms4S+PendJrrOBEZTUUL15zqy6BfZxM32BLaGgDi2drl6WPxTddKCyPAja1wsL
         sDRiEUFj3wHiSpI3wQQacWq1yUtYXoqwU7EyX+/vheWl6bZR9r/OaEbj1MOsq23aAp9l
         VzAv7TDBzL9knPMxUFlxsBvQBo5bMoQ5AiWvEEP9S/bAkiPWoJBtbxaS4/ZGM0W3WF4L
         DVNF5szc8OF6S8lzl+mp8BwnAxYO227FavkiipVa+BQ+2qIzcuNDdy8u82aBsKJOeKVE
         kPPw==
X-Forwarded-Encrypted: i=1; AJvYcCXIK/IlWZSCo9whbh3879/X09NTvnWTF3XPBBM4Xd4KM4Bh1FYLxBF4LK7Gde797u1IYp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0sI4RO80ju2u2+9KWC55tORH3T6hxSfmuCG2R9CDfT+uuhbkR
	ceXC2LaTiLHRCHnAyXbzV58ijTvsKUZbpZv3sp90ru6OlE8xMjAt
X-Google-Smtp-Source: AGHT+IH3JaYUjwwXAbYdALOApAucTPX+0OrgazCKqPZWJQWldOasJrW/xArWYfY0weBK4pCnRpRL2Q==
X-Received: by 2002:a17:906:7308:b0:a7d:3cf6:48d1 with SMTP id a640c23a62f3a-a897f8d50a3mr1038830966b.32.1725295981078;
        Mon, 02 Sep 2024 09:53:01 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:3:9701:871:3aa1:b62a? ([2620:10d:c092:500::6:6ede])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891a3e9dsm579322866b.108.2024.09.02.09.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 09:53:00 -0700 (PDT)
Message-ID: <83f3b5c9-ec98-4a70-ace2-1e40187704b3@gmail.com>
Date: Mon, 2 Sep 2024 17:52:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Fix handling enum64 in btf dump sorting
To: Daniel Borkmann <daniel@iogearbox.net>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, kafai@meta.com, kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20240901213040.766724-1-yatsenko@meta.com>
 <695c2a92-a79d-5f8d-e3a9-00cd11b5f961@iogearbox.net>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <695c2a92-a79d-5f8d-e3a9-00cd11b5f961@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/09/2024 17:22, Daniel Borkmann wrote:
> On 9/1/24 11:30 PM, "Mykyta Yatsenko mykyta.yatsenko5"@gmail.com wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Wrong function is used to access the first enum64 element.
>> Substituting btf_enum(t) with btf_enum64(t) for BTF_KIND_ENUM64.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/bpf/bpftool/btf.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index 6789c7a4d5ca..b0f12c511bb3 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -557,16 +557,23 @@ static const char *btf_type_sort_name(const 
>> struct btf *btf, __u32 index, bool f
>>       const struct btf_type *t = btf__type_by_id(btf, index);
>>         switch (btf_kind(t)) {
>> -    case BTF_KIND_ENUM:
>> -    case BTF_KIND_ENUM64: {
>> +    case BTF_KIND_ENUM: {
>>           int name_off = t->name_off;
>>             /* Use name of the first element for anonymous enums if 
>> allowed */
>> -        if (!from_ref && !t->name_off && btf_vlen(t))
>> +        if (!from_ref && !name_off && btf_vlen(t))
>>               name_off = btf_enum(t)->name_off;
>>             return btf__name_by_offset(btf, name_off);
>>       }
>
> Small nit, could we consolidate the logic into the below? Still 
> somewhat nicer
> than duplicating all of the rest.
Thanks for the suggestion, this makes sense,  I will apply it.
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 6789c7a4d5ca..aae6f5262c6a 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -562,8 +562,10 @@ static const char *btf_type_sort_name(const 
> struct btf *btf, __u32 index, bool f
>                 int name_off = t->name_off;
>
>                 /* Use name of the first element for anonymous enums 
> if allowed */
> -               if (!from_ref && !t->name_off && btf_vlen(t))
> -                       name_off = btf_enum(t)->name_off;
> +               if (!from_ref && !name_off && btf_vlen(t))
> +                       name_off = btf_kind(t) == BTF_KIND_ENUM64 ?
> +                                  btf_enum64(t)->name_off :
> +                                  btf_enum(t)->name_off;
>
>                 return btf__name_by_offset(btf, name_off);
>         }
>
> Thanks,
> Daniel
>


