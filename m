Return-Path: <bpf+bounces-22930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6607586B9CE
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89ADE1C22532
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD3D70026;
	Wed, 28 Feb 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxQN/7wq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FFD4D11F
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155446; cv=none; b=UkberCuk04iQ3YMFLiKqRsuwT6pB5rq0SIno2HH01wJWnmcHeFobcN343GX0623ch9xD3F5a+qCz1WG5RTpiBF9HzDDRb4yV0XyHF8V6voS8SLxX0YN9aOXQBkhGyk0cPuOSIqFfbp8bxwS2++BpX631Tn/RmV2hiTANexVBRMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155446; c=relaxed/simple;
	bh=cknM66RR1pV3L/KN6LdXg7rJx/2c9cmI+izCUsJqbuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruizPqyMk6wdyIDv8ASQTnfSwmUo2+y08M7JrjcMFNZdFPcMVVTVuLnBXz+IWcg+G4nAPpaSSqt8CxXdSIcc1FAGvG2QtKwrNBzbwIfFourL0fnItaULF0R+R25pJT0t6+DiONpIco5xmsrTPvGhSPlwq5i2TKSayT0MYkXRJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxQN/7wq; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-607e54b6cf5so1872987b3.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 13:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709155444; x=1709760244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lFfUGOL3GWSo8ubx2eEcaDPTNzXR9n2OWctxsSlobxA=;
        b=PxQN/7wq80K/DlLuC7T4l6NUjGRwLXQLc4UbGFCAm+yZ5YTvHZmFNNaTA5ixQvshMb
         Ir1SXIUQ96OZ3pazadn1+8XU3XeiqK4gJCWhPyshZaRC6tjMYFt1/q7eamsZvcCr0VJK
         w4aCRxe46i7VtjpWRXcVk3h8EZ28gbRDz1STuTki66JkMzLdskI6/m9XTzuM8VFbC7v3
         LhvOzsHJ4pr/xJp1GFtqo1bJeFjCMjMdSA4atovHXRyj2T3iwtT5YDIzCQmoiM0oT8YH
         9Sp2427l52Rvxu7e8Xle/1bQncyLNyjcbRt0QQMdkLA1b6PtMdClZOgyENAnvBVAYFis
         fr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155444; x=1709760244;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFfUGOL3GWSo8ubx2eEcaDPTNzXR9n2OWctxsSlobxA=;
        b=KO2X3e8rj+2SjLdER3zZE386iNziT3gbf5iq+uf0wDlr4Ht2CRD+3VG/Wp15WrNeac
         V/UVff5yoeTHbupWY0xhlWqGzHDeYGrCLDfdwt5haiw6oVrnt8Qyw4TQ+1T6jAt2/bx9
         lKWu7r20krUIJcs9bQrnsMlZ9iT2k2A9ez8TocKDmAkFY2dFjTZu4idMC8WJkXZ0Bsk2
         t6AQ0aB6jfbgcvfwg+CeefL4NxO124QVzd6y5J0vMuMoHKgahoY5a3pspbd50feHhLMC
         EM3FlFrh0ETbWKnbq90dQGnV2sMROv8rADUcXSfWXYMAXrQ+YIZQYIaKauNdK7BvkLtb
         g5cQ==
X-Gm-Message-State: AOJu0Yx1xIyJx+QRH3HQtZ7E0yqlmmJaSMV4ncPDjcpaA9kKm3F87Opv
	li+S7W3EG28EImnOsxurgFtqb1xs943oXlsyqPFC0KMxKFPV9EPJ
X-Google-Smtp-Source: AGHT+IHcAE4Ha7xo5bL9/qwGu01v7Eb69M/n8OlUTBJVrR4zGzxLczVGSHIbbObBaITiJUejew5FQQ==
X-Received: by 2002:a0d:ea46:0:b0:609:1207:40a3 with SMTP id t67-20020a0dea46000000b00609120740a3mr334699ywe.17.1709155443710;
        Wed, 28 Feb 2024 13:24:03 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:8315:1f56:c755:e391? ([2600:1700:6cf8:1240:8315:1f56:c755:e391])
        by smtp.gmail.com with ESMTPSA id o14-20020a81ef0e000000b005ffff40c58csm68816ywm.125.2024.02.28.13.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 13:24:03 -0800 (PST)
Message-ID: <c5580b27-6deb-4ab8-bc97-3c4bbd0eff20@gmail.com>
Date: Wed, 28 Feb 2024 13:24:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 2/6] libbpf: set btf_value_type_id of struct
 bpf_map for struct_ops.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 quentin@isovalent.com, kuifeng@meta.com
References: <20240227010432.714127-1-thinker.li@gmail.com>
 <20240227010432.714127-3-thinker.li@gmail.com>
 <CAEf4BzYp0xjWPzeA1-QCL20PSBa9krcA=LwxuZpe+8-btQUf6g@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzYp0xjWPzeA1-QCL20PSBa9krcA=LwxuZpe+8-btQUf6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/28/24 09:48, Andrii Nakryiko wrote:
> On Mon, Feb 26, 2024 at 5:04 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> For a struct_ops map, btf_value_type_id is the type ID of it's struct
>> type. This value is required by bpftool to generate skeleton including
>> pointers of shadow types. The code generator gets the type ID from
>> bpf_map__btf_vaule_type_id() in order to get the type information of the
>> struct type of a map.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index ef8fd20f33ca..465b50235a01 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -1229,6 +1229,7 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
>>                  map->name = strdup(var_name);
>>                  if (!map->name)
>>                          return -ENOMEM;
>> +               map->btf_value_type_id = type_id;
>>
> 
> this part is good
> 
>>                  map->def.type = BPF_MAP_TYPE_STRUCT_OPS;
>>                  map->def.key_size = sizeof(int);
>> @@ -4818,7 +4819,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>>          if (obj->btf && btf__fd(obj->btf) >= 0) {
>>                  create_attr.btf_fd = btf__fd(obj->btf);
>>                  create_attr.btf_key_type_id = map->btf_key_type_id;
>> -               create_attr.btf_value_type_id = map->btf_value_type_id;
>> +               create_attr.btf_value_type_id =
>> +                       def->type != BPF_MAP_TYPE_STRUCT_OPS ?
>> +                       map->btf_value_type_id : 0;
> 
> but here I think it's cleaner to reset create_attr.btf_value_type_id
> to zero a bit lower, see that we have special logic for
> PERF_EVENT_ARRAY, CGROUP_ARRAY and a bunch more maps. Just add a case
> for BPF_MAP_TYPE_STRUCT_OPS that will clear
> create_attr.btf_value_type_id only (keeping btf_fd and
> map->btf_value_Type_id intact)

No problem!

> 
>>          }
>>
>>          if (bpf_map_type__is_map_in_map(def->type)) {
>> --
>> 2.34.1
>>

