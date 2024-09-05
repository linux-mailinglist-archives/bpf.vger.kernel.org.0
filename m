Return-Path: <bpf+bounces-39078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A3996E5C6
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 00:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8B1B23608
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3811AD413;
	Thu,  5 Sep 2024 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gewDuuRF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919513D638
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575587; cv=none; b=Oyl/6wEcMoSB1F3fisyKU0ULIWD4ZvFU5MzzpZi01GQZEuN75S6+0TAVl8zwApO+bM+VxkrTPbxSJcqzWWUekTyO5KOjadEcT4zEGVDnF0wn4C919XzDPfSwzb+RAqfetZK5BvVGiNDJuESytZC/sMBIMqFJy2cvIyupEQbXFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575587; c=relaxed/simple;
	bh=3vhJp0gafXSxj7qTeKBhXvIj6lC2WvRDfJr5ePsuRmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwWDEWMzzAj8XnjwwJFCBmRB2Q38Y9PJfzh1gScMHuasckRyWrn/upqc5yhwXuVUPAdCx/DzIJ6ZRynF9XLnxra4MEWCPhgOyQs3Sklqb5fzBE3bOYhu477QyyxMgxouv/4QbAuctZJT1gGIcClFJM/zWEhh93/U+3jymlCgEfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gewDuuRF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86e5e9ff05so171654066b.1
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725575584; x=1726180384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kr6KEjzL0wHorbPM+3um6VKRgvbYN5MldEnXoiOdpQY=;
        b=gewDuuRFZrKO5gvfSCUDo6T1+ecqQKituwAi6U4KN3Iw3nAIvBr8CaG1Njl7MmJHkj
         tIJ6Ei40prVLfnMoWv/WnawFwnHhdhR8a8w9alXxpX++ouAEvLxpmllkt2Y6rA09MzWB
         hJKA12T50lp+HUn+vHMwgMiMNhqKBj38Jq5M5mcZjFkqHExOkU0yXfEuvS/gIKFXeTXY
         h76U67B8f3Ml+usCzb1JIUkT2HCUt0sVBlPImDF9J8y/EPn/jTLk52Yydr0DyxHaeW/0
         pNQ7kEvWl3YvSTaC8z/pjCoa/toliTA6riTKiIBatGId8ji/FI0WqcBmHYY2CY56vWe0
         1/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725575584; x=1726180384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kr6KEjzL0wHorbPM+3um6VKRgvbYN5MldEnXoiOdpQY=;
        b=blR30R175JwJe++T5taP4GX7QM/ZzO7J1XKQgNItSW5LtqIizCZpzRCChAZjWPHcaa
         eRTy1+qw7t45GaWeoAd9/dZEm5J4njIujvWpEpX6UIADQCYSJnwTC4oLfMGRusZFAOwt
         d1J8gfi5HeJIJZ7JO52KeF1BMbUhuAyEufHRAVCIs6XimvJSHds9UC20m4ZaBwOtCDGz
         z1nqQd+Aa77lmRB9iny+7+LjgRZQwV7kxSItdjupj1sN7nTcPYa1vCGaPiDwBbC1qdg4
         glSi/hlU2vc319ceY0vIwcYY/0sneC6PCB/PEytPCw5gDvkxpvLbHjcJaAxAhIcF/Uxx
         lfJw==
X-Gm-Message-State: AOJu0YzwGrTn/uEkLmsMl8tsZEkAA502zMg3nWPzJq2qN+DhZkSNTpZd
	NOPkgPNmSKeNjstuLhDZjDkccI1jvMUh9Izc7RVufRsQgSi71SeW
X-Google-Smtp-Source: AGHT+IGd861SMy6tZKoNUTkzRrj2GoQ91hhAeXOuj1xCDBJul6j8XFsaXHynKe0L5lOfc/anju3ubw==
X-Received: by 2002:a17:907:7421:b0:a8a:8d81:97a8 with SMTP id a640c23a62f3a-a8a8d81aa63mr2849366b.1.1725575583154;
        Thu, 05 Sep 2024 15:33:03 -0700 (PDT)
Received: from [192.168.0.24] (walt-20-b2-v4wan-167837-cust573.vm13.cable.virginm.net. [80.2.18.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a7e68a345sm71680566b.121.2024.09.05.15.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 15:33:02 -0700 (PDT)
Message-ID: <d70142da-3f08-4d5f-9556-bf442570942d@gmail.com>
Date: Thu, 5 Sep 2024 23:33:01 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: improve btf c dump sorting stability
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20240905201206.648932-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzYnrpdBcTFpA_MsM+6qyW3Cmcte9zhv2vrJsnYKQrFhAQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzYnrpdBcTFpA_MsM+6qyW3Cmcte9zhv2vrJsnYKQrFhAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/09/2024 21:31, Andrii Nakryiko wrote:
> On Thu, Sep 5, 2024 at 1:12 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Existing algorithm for BTF C dump sorting uses only types and names of
>> the structs and unions for ordering. As dump contains structs with the
>> same names but different contents, relative to each other ordering of
>> those structs will be accidental.
>> This patch addresses this problem by introducing a new sorting field
>> that contains hash of the struct/union field names and types to
>> disambiguate comparison of the non-unique named structs.
>>
> Did you check how stable generated vmlinux.h now is when just
> rebuilding kernel with no actual changes? Does it still have some
> variation?
It's stable with this change, no variation at all (I tested up to about 5
times in a row rebuilding kernel and generating vmlinux.h), though, I 
would not
be surprised if some edge case for same-named structs is not covered.
It may get triggered in future by some change in kernel structures.
> LGTM, but let's keep the btf_type_sort_name() as is? See below.
>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/bpf/bpftool/btf.c | 93 ++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 79 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index 3b57ba095ab6..0e7151bfc3d5 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -50,6 +50,7 @@ struct sort_datum {
>>          int type_rank;
>>          const char *sort_name;
>>          const char *own_name;
>> +       __u64 disambig_hash;
>>   };
>>
>>   static const char *btf_int_enc_str(__u8 encoding)
>> @@ -557,17 +558,6 @@ static const char *btf_type_sort_name(const struct btf *btf, __u32 index, bool f
>>          const struct btf_type *t = btf__type_by_id(btf, index);
>>
>>          switch (btf_kind(t)) {
>> -       case BTF_KIND_ENUM:
>> -       case BTF_KIND_ENUM64: {
>> -               int name_off = t->name_off;
>> -
>> -               if (!from_ref && !name_off && btf_vlen(t))
>> -                       name_off = btf_kind(t) == BTF_KIND_ENUM64 ?
>> -                               btf_enum64(t)->name_off :
>> -                               btf_enum(t)->name_off;
>> -
>> -               return btf__name_by_offset(btf, name_off);
>> -       }
> Why remove this? anonymous enums will usually still have some
> meaningful prefix for each enumerator value, and so sorting based on
> those prefixes (effective) still seems useful for more logical
> ordering
Removed this just to simplify code a little bit. With the hash
function we use for disambiguation same-named enums, enums with
less number of elements would be pushed higher which is decent sorting 
as well.
I see why we would prefer to cluster enums with similar prefixes 
together. I'll
revert this removal in v2.
>
> pw-bot: cr
>
>>          case BTF_KIND_ARRAY:
>>                  return btf_type_sort_name(btf, btf_array(t)->type, true);
>>          case BTF_KIND_TYPE_TAG:
>> @@ -584,20 +574,94 @@ static const char *btf_type_sort_name(const struct btf *btf, __u32 index, bool f
>>          return NULL;
>>   }
>>
>> +static __u64 hasher(__u64 hash, __u64 val)
>> +{
>> +       return hash * 31 + val;
>> +}
>> +
>> +static __u64 btf_name_hasher(__u64 hash, const struct btf *btf, __u32 name_off)
>> +{
>> +       if (!name_off)
>> +               return hash;
>> +
>> +       return hasher(hash, str_hash(btf__name_by_offset(btf, name_off)));
>> +}
>> +
>> +static __u64 btf_type_disambig_hash(const struct btf *btf, __u32 index, bool include_members)
> nit: s/index/id/ ?
Ack
>
>> +{
>> +       const struct btf_type *t = btf__type_by_id(btf, index);
>> +       int i;
>> +       size_t hash = 0;
>> +
>> +       hash = btf_name_hasher(hash, btf, t->name_off);
>> +
>> +       switch (btf_kind(t)) {
>> +       case BTF_KIND_ENUM:
>> +       case BTF_KIND_ENUM64:
>> +               for (i = 0; i < btf_vlen(t); i++) {
>> +                       __u32 name_off = btf_is_enum(t) ?
>> +                               btf_enum(t)[i].name_off :
>> +                               btf_enum64(t)[i].name_off;
>> +
>> +                       hash = btf_name_hasher(hash, btf, name_off);
>> +               }
>> +               break;
>> +       case BTF_KIND_STRUCT:
>> +       case BTF_KIND_UNION:
>> +               if (!include_members)
>> +                       break;
>> +               for (i = 0; i < btf_vlen(t); i++) {
>> +                       const struct btf_member *m = btf_members(t) + i;
>> +
>> +                       hash = btf_name_hasher(hash, btf, m->name_off);
>> +                       /* resolve field type's name and hash it as well */
>> +                       hash = hasher(hash, btf_type_disambig_hash(btf, m->type, false));
>> +               }
>> +               break;
>> +       case BTF_KIND_TYPE_TAG:
>> +       case BTF_KIND_CONST:
>> +       case BTF_KIND_PTR:
>> +       case BTF_KIND_VOLATILE:
>> +       case BTF_KIND_RESTRICT:
>> +       case BTF_KIND_TYPEDEF:
>> +       case BTF_KIND_DECL_TAG:
>> +               hash = hasher(hash, btf_type_disambig_hash(btf, t->type, include_members));
>> +               break;
>> +       case BTF_KIND_ARRAY: {
>> +               struct btf_array *arr = btf_array(t);
>> +
>> +               hash = hasher(hash, arr->nelems);
>> +               hash = hasher(hash, btf_type_disambig_hash(btf, arr->type, include_members));
>> +               break;
>> +       }
>> +       default:
>> +               break;
>> +       }
>> +       return hash;
>> +}
>> +
>>   static int btf_type_compare(const void *left, const void *right)
>>   {
>>          const struct sort_datum *d1 = (const struct sort_datum *)left;
>>          const struct sort_datum *d2 = (const struct sort_datum *)right;
>>          int r;
>>
>> -       if (d1->type_rank != d2->type_rank)
>> -               return d1->type_rank < d2->type_rank ? -1 : 1;
>> +       r = d1->type_rank - d2->type_rank;
>> +       if (r)
>> +               return r;
>>
>>          r = strcmp(d1->sort_name, d2->sort_name);
>>          if (r)
>>                  return r;
>>
>> -       return strcmp(d1->own_name, d2->own_name);
>> +       r = strcmp(d1->own_name, d2->own_name);
>> +       if (r)
>> +               return r;
> when I was playing with this code I had stong desire to do something
> like below to cut down on visual noise
>
> r = d1->type_rank - d2->type_rank;
> r = r ?: strcmp(d1->sort_name, d2->sort_name);
> r = r ?: strcmp(d1->own_name, d2->own_name);
> if (r)
>      return r;
>
> WDYT?
Looks a little hard to parse for me (maybe a skill issue). Early exits 
help to disregard
context when reading the code (not sure if this makes sense), so I prefer
them. Essentially this is the same thing as theexisting code, but more 
compact,
makes sense, I'll include it in v2.
>> +
>> +       if (d1->disambig_hash != d2->disambig_hash)
>> +               return d1->disambig_hash < d2->disambig_hash ? -1 : 1;
>> +
>> +       return d1->index - d2->index;
>>   }
>>
>>   static struct sort_datum *sort_btf_c(const struct btf *btf)
>> @@ -618,6 +682,7 @@ static struct sort_datum *sort_btf_c(const struct btf *btf)
>>                  d->type_rank = btf_type_rank(btf, i, false);
>>                  d->sort_name = btf_type_sort_name(btf, i, false);
>>                  d->own_name = btf__name_by_offset(btf, t->name_off);
>> +               d->disambig_hash = btf_type_disambig_hash(btf, i, true);
>>          }
>>
>>          qsort(datums, n, sizeof(struct sort_datum), btf_type_compare);
>> --
>> 2.46.0
>>


