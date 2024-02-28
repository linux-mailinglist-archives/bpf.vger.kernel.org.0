Return-Path: <bpf+bounces-22912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882AD86B822
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 20:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A101F22AC4
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6005A74410;
	Wed, 28 Feb 2024 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxZXMVpI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D079B71
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148480; cv=none; b=og6Ndbi8xD/+5HuDSyn7GsSbJrx1WoCe773Yhpgbr6FUZLKz4M8IWO1/Wc0w0fuhOUvUQl6s1xvN7enZbtJV9StV8tdAHKjxYnGOmNE7IH/61vpyliLyeUOrGGbrWRtJyQmiaQcxigKeyhfw+b0d3m+PxHWEKPiVP1MLru+BnlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148480; c=relaxed/simple;
	bh=LxcirTAoySOPLZOPcOJUSafRcRUtlOCzo4UUwHED72o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n75BbOzVqOwwpAC0u/Trrbur16e9r3CvNqyEsE8d7PYnQV0k7R8PZ05NSQ9DyA5n+KMZTeWvf2YsK3ADVNFLLxu2dv8qTrFv/KgGBpCAyfdparaONCfp0F28Z9bdPSrvlP5fHytHUv9xfuM9FZumfqSspniTEi6/gULZygqFtHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxZXMVpI; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbed0710c74so140962276.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 11:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709148478; x=1709753278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ufe2w4ZR5aGzqu2uKCWcsNJZG6ehd/d5wUHdeYHL2oQ=;
        b=GxZXMVpI/qp0I+eMIyGizhrGV8wrWerM6VPs/6/7Ly56uV3Ms49uVwTHsNeM2xsNkF
         ZIa+RFa7a5vkwzbbCljaPMZ9I73FpLlI4y2QWYoiTiKgnDeglIVsH+N12DMoE7JFWuyu
         bb0SPPM4bPsOP9l0PGQiP5U63o5EtQ+h3lAbfpgxYDzcSJwjYlJNDC6Tu2SY0sGmFg9E
         oPji994d2A+KlQHOIdO1SejU7m1MzhsivQV6ZiuIHNGdM/OHFfemGyU7nbpbWRiJvSsr
         5FnOm8/NRzpFq2NALjnKQkd4wEbkVC2uJKQn+9QPXsetPHT7CGwya+JjHIXg9MbMXSaL
         4NZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148478; x=1709753278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ufe2w4ZR5aGzqu2uKCWcsNJZG6ehd/d5wUHdeYHL2oQ=;
        b=oMY+fOcqJp13TR3BN9NAeFKTU3fpfPqft6GMuUpuzViVlcapmii7jrn7eZhNmPcI9T
         zGcWPc1H2v8QTgonvGKx9i65ih21YWLarTRxz4H/x0KteRGY/x4AzlD4TgNkRpGkeEKI
         mxOptU7A1BUZju1w8TZmQaGFohdCTzFyFyZ+4iftNOVPro5k/afaCojfqBoPN4kosR1l
         CQFkOJEgYLZKCuAbNqPA5s1vTrAHs1kJY4YFBOw9gnATCsJd6M/a+/g8+s7aLeA3ECj7
         mKR2P1RZuOC+jhF1RVJrejAf7O3PT7bfEVCNWgX8Zq9EgXhPOnAepUDETjwNknM0r7EA
         ed+w==
X-Gm-Message-State: AOJu0YzOmg0mLUTr0j2E2hYUJk/wgPmjGcwSlwlYF4XYcWI1BDC3G8H4
	irIEDZNHntTftvEw7Hk9tReTGiGvEMoH5u271zv4z3/eWpYpotl1
X-Google-Smtp-Source: AGHT+IHuX6zLOu5SoBsJdYQVeuiO9S3PMx7o5fSXaiscSU3nsLc3+FYljGlyhzL3ptpw9JZaWBDDcw==
X-Received: by 2002:a25:bc8a:0:b0:dcf:56c1:5a12 with SMTP id e10-20020a25bc8a000000b00dcf56c15a12mr159236ybk.38.1709148478272;
        Wed, 28 Feb 2024 11:27:58 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:8315:1f56:c755:e391? ([2600:1700:6cf8:1240:8315:1f56:c755:e391])
        by smtp.gmail.com with ESMTPSA id h135-20020a25d08d000000b00dc6d6dc9771sm12530ybg.8.2024.02.28.11.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 11:27:57 -0800 (PST)
Message-ID: <d342f4ee-8b70-456c-aea5-54fc9084f52c@gmail.com>
Date: Wed, 28 Feb 2024 11:27:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/6] libbpf: Convert st_ops->data to shadow
 type.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 quentin@isovalent.com, kuifeng@meta.com
References: <20240227010432.714127-1-thinker.li@gmail.com>
 <20240227010432.714127-4-thinker.li@gmail.com>
 <CAEf4BzZbE=2Kvrx_XK60jhtFfJuFsu18=pcZFry8UuF-s_Lg_A@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzZbE=2Kvrx_XK60jhtFfJuFsu18=pcZFry8UuF-s_Lg_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/28/24 09:58, Andrii Nakryiko wrote:
> On Mon, Feb 26, 2024 at 5:04 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> Convert st_ops->data to the shadow type of the struct_ops map. The shadow
>> type of a struct_ops type is a variant of the original struct type
>> providing a way to access/change the values in the maps of the struct_ops
>> type.
>>
>> bpf_map__initial_value() will return st_ops->data for struct_ops types. The
>> skeleton is going to use it as the pointer to the shadow type of the
>> original struct type.
>>
>> One of the main differences between the original struct type and the shadow
>> type is that all function pointers of the shadow type are converted to
>> pointers of struct bpf_program. Users can replace these bpf_program
>> pointers with other BPF programs. The st_ops->progs[] will be updated
>> before updating the value of a map to reflect the changes made by users.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 465b50235a01..2d22344fb127 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -1102,6 +1102,9 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
>>                  if (btf_is_ptr(mtype)) {
>>                          struct bpf_program *prog;
>>
>> +                       /* Update the value from the shadow type */
>> +                       st_ops->progs[i] = *(struct bpf_program **)mdata;
>> +
> 
> it's unsettling to just cast a pointer like this without any
> validation. It's too easy for users to set either some garbage there
> or struct bpf_program * pointer from some other skeleton.
> 
> Luckily, validation is pretty simple, we can just iterate over all
> bpf_object's programs and check if any of them matches the value of
> the mdata pointer. If not, error out with meaningful error.

Make sense to me.

> 
> Also, even if the bpf_program pointer is correct, it could be a
> program of the wrong type, so I think we should add a bit more
> validation here, given these pointers are set by users directly after
> bpf_object is opened.


Agree!
Although this will be checked by the kernel, it makes sense to check at
the user space to provide a more meaningful error.

> 
>>                          prog = st_ops->progs[i];
>>                          if (!prog)
>>                                  continue;
>> @@ -9308,7 +9311,9 @@ static struct bpf_map *find_struct_ops_map_by_offset(struct bpf_object *obj,
>>          return NULL;
>>   }
>>
>> -/* Collect the reloc from ELF and populate the st_ops->progs[] */
>> +/* Collect the reloc from ELF, populate the st_ops->progs[], and update
>> + * st_ops->data for shadow type.
>> + */
>>   static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
>>                                              Elf64_Shdr *shdr, Elf_Data *data)
>>   {
>> @@ -9422,6 +9427,14 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
>>                  }
>>
>>                  st_ops->progs[member_idx] = prog;
>> +
>> +               /* st_ops->data will be expose to users, being returned by
> 
> typo: exposed
> 
>> +                * bpf_map__initial_value() as a pointer to the shadow
>> +                * type. All function pointers in the original struct type
>> +                * should be converted to a pointer to struct bpf_program
>> +                * in the shadow type.
>> +                */
>> +               *((struct bpf_program **)(st_ops->data + moff)) = prog;
>>          }
>>
>>          return 0;
>> @@ -9880,6 +9893,12 @@ int bpf_map__set_initial_value(struct bpf_map *map,
>>
>>   void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
>>   {
>> +       if (bpf_map__is_struct_ops(map)) {
>> +               if (psize)
>> +                       *psize = map->def.value_size;
>> +               return map->st_ops->data;
>> +       }
>> +
>>          if (!map->mmaped)
>>                  return NULL;
>>          *psize = map->def.value_size;
>> --
>> 2.34.1
>>

