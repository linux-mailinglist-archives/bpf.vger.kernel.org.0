Return-Path: <bpf+bounces-29225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147CF8C14FA
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE64B236E4
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 18:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E3F7E58C;
	Thu,  9 May 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVqbxlsY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842AF7EEED
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715280151; cv=none; b=nZ+eesW1KFQSL+l2jjK9slqPVVWyV6b/88SbfCn1qpLlV6HFgYOl+7iKTntbDsbVHrYxudYYrfh5oayIigeYG/k357oHJzsuEnQX8R1KsVNFVFYQm7N9JVfo9TotHjJa8lge4kWq2jK6fGX123px7ZOdiW8aZGO/dujjtVWWO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715280151; c=relaxed/simple;
	bh=RlaOcUqCGdtgIVPngDnk+s8Ssk0Th1UXed0XYtLPL2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DL7e+uzxSdIcKQtqjgCKfDV1g23EEPMRLCMi1Af6UMnYbFT7FtjU+QKuJ1PuhdXnTGvArmaoSnTo/rTf7MTYjsHtrdF8l77rSJ3MlaGBRJ4cAthHgsB9R/WXPTMk9ucU+2uD9Vt3qMsn+RimtWPHXgTcL+xjwG5OIk/EH0dv9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVqbxlsY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34da35cd01cso1021388f8f.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 11:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715280146; x=1715884946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drM7RZDEil6iy17EcxsKVFOFLOMs4RIqS4Z3WFd7G/0=;
        b=XVqbxlsYci2+dL3Ip3bX1eXsDrtuFb+5kAL+/CG8W0vaye6TvhD4D87dzt+ywVp11M
         RBpTUU1nSVUmISIfrWsgcjjzgNNqcpxmzRludi4ed6rgUplKVAhI0T6VI1djh++HrShA
         kvG6HSnosIbQuDyTU7dOplL/Mfyicxn7IlZuuQuNJnJ3EW0cdXAiHTGBq2/P9OM5rS3+
         2qJkEfSEh46a+lTmYSlNYNpx+sVWI/RGrumfDB0Rglel5swEup+itKNxy/eJJjnPpcsn
         W7OOP5dZBYR2Bj38zwyToZ/6eKyoyzwUonz5s7ybqCci2Hdl0nZupyTFGyxDhe9FQHIq
         TfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715280146; x=1715884946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drM7RZDEil6iy17EcxsKVFOFLOMs4RIqS4Z3WFd7G/0=;
        b=YRWHiGx8M4WjsMX39fLf+eTxtacWN5JnwfecMTU6EsvtKbQlIH8e+1h7CmwGFcvzlH
         UuomqE3V0g+HEJ+Kgfhqs3U89o17Hq1DKwLqQFschiKleV/Qj3m9fr+IN+4raJxOfjcz
         3lw+zRzL+/k+6lxkl/IMRzSoB8TaT4RdIDC/tCtz9KCM+aNPwby7O5DuDggbjdCW+hsa
         G8vnzjTd6to4MGy+DDVakSVMKMYZ8eCLlz89TEUxchmbRfbQG88fh8bwQPubeC4fKxXh
         8HBUCtnyTJyo3PwUuD3fPtyYyNejSAKJ81ualADbA1FBTytMYLvbXReoRsaxVE9Yk+rh
         uWXw==
X-Forwarded-Encrypted: i=1; AJvYcCVx+vzaAv0XRpk6dfmCJQZgv3L9ugGZoOtGcElIFSikSL5A8AB4lW8AJ94jo8G40OlrqA7R9kQOhQcU5c2vwg9mIREk
X-Gm-Message-State: AOJu0Yw0RnkZxcSQlOMoVeuomDPdyeZwUKNbhqVPmm4bn9yxmERMMcEs
	VfQTifM5xNGvYCBKC2diATCfFJ2Uz//9BjqofpSeY5wVS7e+RMRV
X-Google-Smtp-Source: AGHT+IGUaaEpIAmCkksGB3Q+e2L8mFjb+om6rUfK2pbZOJv9SXPRXK4k+sjEfrsVquMr0VDhHsoKeA==
X-Received: by 2002:adf:f342:0:b0:34d:9ec4:7b78 with SMTP id ffacd0b85a97d-3504a969229mr329765f8f.56.1715280145426;
        Thu, 09 May 2024 11:42:25 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0c3:1131::11ee? ([2620:10d:c092:400::5:c730])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17f37sm100381666b.224.2024.05.09.11.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 11:42:25 -0700 (PDT)
Message-ID: <3999bafb-c64e-489f-a461-ac1a748abb6d@gmail.com>
Date: Thu, 9 May 2024 19:42:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next] bpftool: introduce btf c dump sorting
To: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, kernel-team@meta.com, qmo@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20240509151744.131648-1-yatsenko@meta.com>
 <b43d0677-5018-45a1-8b0e-00bdc68a09af@oracle.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <b43d0677-5018-45a1-8b0e-00bdc68a09af@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/9/24 17:08, Alan Maguire wrote:
> On 09/05/2024 16:17, Mykyta@web.codeaurora.org wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Sort bpftool c dump output; aiming to simplify vmlinux.h diffing and
>> forcing more natural type definitions ordering.
>>
>> Definitions are sorted first by their BTF kind ranks, then by their base
>> type name and by their own name.
>>
>> Type ranks
>>
>> Assign ranks to btf kinds (defined in function btf_type_rank) to set
>> next order:
>> 1. Anonymous enums/enums64
>> 2. Named enums/enums64
>> 3. Trivial types typedefs (ints, then floats)
>> 4. Structs/Unions
>> 5. Function prototypes
>> 6. Forward declarations
>>
>> Type rank is set to maximum for unnamed reference types, structs and
>> unions to avoid emitting those types early. They will be emitted as
>> part of the type chain starting with named type.
>>
>> Lexicographical ordering
>>
>> Each type is assigned a sort_name and own_name.
>> sort_name is the resolved name of the final base type for reference
>> types (typedef, pointer, array etc). Sorting by sort_name allows to
>> group typedefs of the same base type. sort_name for non-reference type
>> is the same as own_name. own_name is a direct name of particular type,
>> is used as final sorting step.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> This looks great! Not sure if you experimented with sorting for the
> split BTF case (dumping /sys/kernel/btf/tun say); are there any
> additional issues in doing that? From what I can see below the sort
> would just be applied across base and split BTF and should just work, is
> that right? A few suggestions below, but
This functionality is oblivious to split BTF, dumping 
/sys/kernel/btf/tun will
sort all types across both base and split BTF, not distinguishing where 
those
types come from.
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
>> ---
>>   tools/bpf/bpftool/btf.c | 125 +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 122 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index 91fcb75babe3..09ecd2abf066 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -43,6 +43,13 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>>   	[BTF_KIND_ENUM64]	= "ENUM64",
>>   };
>>   
>> +struct sort_datum {
>> +	int index;
>> +	int type_rank;
>> +	const char *sort_name;
>> +	const char *own_name;
>> +};
>> +
>>   static const char *btf_int_enc_str(__u8 encoding)
>>   {
>>   	switch (encoding) {
>> @@ -460,11 +467,114 @@ static void __printf(2, 0) btf_dump_printf(void *ctx,
>>   	vfprintf(stdout, fmt, args);
>>   }
>>   
>> +static bool is_reference_type(const struct btf_type *t)
>> +{
>> +	int kind = btf_kind(t);
>> +
>> +	return kind == BTF_KIND_CONST || kind == BTF_KIND_PTR || kind == BTF_KIND_VOLATILE ||
>> +		kind == BTF_KIND_RESTRICT || kind == BTF_KIND_ARRAY || kind == BTF_KIND_TYPEDEF ||
>> +		kind == BTF_KIND_DECL_TAG;
>> +}
>> +
>> +static int btf_type_rank(const struct btf *btf, __u32 index, bool has_name)
>> +{
>> +	const struct btf_type *t = btf__type_by_id(btf, index);
>> +	const int max_rank = 10;
>> +	const int kind = btf_kind(t);
>> +
>> +	if (t->name_off)
>> +		has_name = true;
>> +
>> +	switch (kind) {
>> +	case BTF_KIND_ENUM:
>> +	case BTF_KIND_ENUM64:
>> +		return has_name ? 1 : 0;
>> +	case BTF_KIND_INT:
>> +	case BTF_KIND_FLOAT:
>> +		return 2;
>> +	case BTF_KIND_STRUCT:
>> +	case BTF_KIND_UNION:
>> +		return has_name ? 3 : max_rank;
>> +	case BTF_KIND_FUNC_PROTO:
>> +		return has_name ? 4 : max_rank;
>> +
> Don't think a FUNC_PROTO will ever have a name, so has_name check
> probably not needed here.
The reason for that check is to penalize FUNC_PROTO type (assign 
max_rank to it),
but assign rank 4 to typedef type pointing to that FUNC_PROTO. You can 
see that
for reference types this function is called recursively until 
non-reference type
is reached, we assign non-maximum rank only if there was a named type along
the chain of recursive calls. Assigning rank 4 to FUNC_PROTO will lead 
to printing
those function prototypes unordered, as their names are assigned to 
typedef type.

>> +	default: {
>> +		if (has_name && is_reference_type(t)) {
>> +			const int parent = kind == BTF_KIND_ARRAY ? btf_array(t)->type : t->type;
>> +
>> +			return btf_type_rank(btf, parent, has_name);
>> +		}
>> +		return max_rank;
>> +	}
>> +	}
>> +}
>> +
>> +static const char *btf_type_sort_name(const struct btf *btf, __u32 index)
>> +{
>> +	const struct btf_type *t = btf__type_by_id(btf, index);
>> +	int kind = btf_kind(t);
>> +
>> +	/* Use name of the first element for anonymous enums */
>> +	if (!t->name_off && (kind == BTF_KIND_ENUM || kind == BTF_KIND_ENUM64) &&
>> +	    BTF_INFO_VLEN(t->info))
>> +		return btf__name_by_offset(btf, btf_enum(t)->name_off);
>> +
>> +	/* Return base type name for reference types */
>> +	while (is_reference_type(t)) {
> The two times is_reference_type() is used, we use this conditional to
> get the array type; worth rolling this into a get_reference_type(t)
> function that returns t->type for reference types, btf_array(t)->type
> for arrays and -1 otherwise perhaps?
Agree.
>
>> +		index = btf_kind(t) == BTF_KIND_ARRAY ? btf_array(t)->type : t->type;
>> +		t = btf__type_by_id(btf, index);
>> +	}
>> +
>> +	return btf__name_by_offset(btf, t->name_off);
>> +}
>> +
>> +static int btf_type_compare(const void *left, const void *right)
>> +{
>> +	const struct sort_datum *datum1 = (const struct sort_datum *)left;
>> +	const struct sort_datum *datum2 = (const struct sort_datum *)right;
>> +	int sort_name_cmp;
>> +
>> +	if (datum1->type_rank != datum2->type_rank)
>> +		return datum1->type_rank < datum2->type_rank ? -1 : 1;
>> +
>> +	sort_name_cmp = strcmp(datum1->sort_name, datum2->sort_name);
>> +	if (sort_name_cmp)
>> +		return sort_name_cmp;
>> +
>> +	return strcmp(datum1->own_name, datum2->own_name);
>> +}
>> +
>> +static struct sort_datum *sort_btf_c(const struct btf *btf)
>> +{
>> +	int total_root_types;
>> +	struct sort_datum *datums;
>> +
>> +	total_root_types = btf__type_cnt(btf);
>> +	datums = malloc(sizeof(struct sort_datum) * total_root_types);
> calloc(total_root_types, sizeof(*datums)) will get you a
> zero-initialized array, which may be useful below...
>
>> +	if (!datums)
>> +		return NULL;
>> +
>> +	for (int i = 0; i < total_root_types; ++i) {
> you're starting from zero here so you'll get &btf_void below; if you
> zero-initialize above I think you can just start from 1.
>
>> +		struct sort_datum *current_datum = datums + i;
>> +		const struct btf_type *t = btf__type_by_id(btf, i);
>> +
>> +		current_datum->index = i;
>> +		current_datum->type_rank = btf_type_rank(btf, i, false);
>> +		current_datum->sort_name = btf_type_sort_name(btf, i);
>> +		current_datum->own_name = btf__name_by_offset(btf, t->name_off);
>> +	}
>> +
>> +	qsort(datums, total_root_types, sizeof(struct sort_datum), btf_type_compare);
>> +
>> +	return datums;
>> +}
>> +
>>   static int dump_btf_c(const struct btf *btf,
>> -		      __u32 *root_type_ids, int root_type_cnt)
>> +		      __u32 *root_type_ids, int root_type_cnt, bool sort_dump)
>>   {
>>   	struct btf_dump *d;
>>   	int err = 0, i;
>> +	struct sort_datum *datums = NULL;
>>   
>>   	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
>>   	if (!d)
>> @@ -486,8 +596,12 @@ static int dump_btf_c(const struct btf *btf,
>>   	} else {
>>   		int cnt = btf__type_cnt(btf);
>>   
>> +		if (sort_dump)
>> +			datums = sort_btf_c(btf);
>>   		for (i = 1; i < cnt; i++) {
>> -			err = btf_dump__dump_type(d, i);
>> +			int idx = datums ? datums[i].index : i;
>> +
>> +			err = btf_dump__dump_type(d, idx);
>>   			if (err)
>>   				goto done;
>>   		}
>> @@ -501,6 +615,7 @@ static int dump_btf_c(const struct btf *btf,
>>   
>>   done:
>>   	btf_dump__free(d);
>> +	free(datums);
>>   	return err;
>>   }
>>   
>> @@ -553,6 +668,7 @@ static int do_dump(int argc, char **argv)
>>   	__u32 root_type_ids[2];
>>   	int root_type_cnt = 0;
>>   	bool dump_c = false;
>> +	bool sort_dump_c = true;
>>   	__u32 btf_id = -1;
>>   	const char *src;
>>   	int fd = -1;
>> @@ -663,6 +779,9 @@ static int do_dump(int argc, char **argv)
>>   				goto done;
>>   			}
>>   			NEXT_ARG();
>> +		} else if (is_prefix(*argv, "unordered")) {
> you'll need to update the man page and add to the bash completion for
> this new argument I think.
>
>> +			sort_dump_c = false;
>> +			NEXT_ARG();
>>   		} else {
>>   			p_err("unrecognized option: '%s'", *argv);
>>   			err = -EINVAL;
>> @@ -691,7 +810,7 @@ static int do_dump(int argc, char **argv)
>>   			err = -ENOTSUP;
>>   			goto done;
>>   		}
>> -		err = dump_btf_c(btf, root_type_ids, root_type_cnt);
>> +		err = dump_btf_c(btf, root_type_ids, root_type_cnt, sort_dump_c);
>>   	} else {
>>   		err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
>>   	}



