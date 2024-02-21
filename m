Return-Path: <bpf+bounces-22445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C5985E4E4
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2EC3B23E8C
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD41384FDD;
	Wed, 21 Feb 2024 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="non9Z0/m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B323E84038
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537672; cv=none; b=fX5Q6+pcEp0oqNk0N26ebHdyuXVT5jJHiXRnKtAoPBoGDUIzl1qHasFsbS4fTbdhQJb9VjyDilpwGtlZZfJMb6ganzUQDZBNxnSZ7XUd3pZCSdN1IAKT7qcCJLw8LD1u+T/GITviET+Ll63jkggFvvGgZGQriiXCGB3KTbYIT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537672; c=relaxed/simple;
	bh=cXCNHxwUo54AVhnNkxYYm2Bt8n1UEEPaFn02I4zklLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGy2S50rdIP7h3Hw4e3dftETlidMquEqPn2qEIKKkb/yxRN6wQIWah1XDQJv69H/MmtNII2IA6zIh+sRFO3ROMBn6FqvOwlHBTmehtQ197KqG0gFuDYMYJmS/FX1dBVuQ/i1f2uaDamvzAbcy+eiBjDcNtUu+EvwJIxKjXn8yuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=non9Z0/m; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60879e3e3ccso9259377b3.3
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 09:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708537669; x=1709142469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjZeg4n3tqPpufkNBWnAqvfUdTIuu3uusZzvbzvoqqQ=;
        b=non9Z0/mHXKg3JWKpxUeUZS4g94jNjn6q82zFOW3nY6EpBOmMG1DxNAoDi53gbs5pF
         TkOVsDRSTmAkIEC83QGubcIK6NSlXHKSaS+nXfKVdiOkOqXxj0b7w89V3eFqkRH706KM
         MfDxO2jIe0aIIYvXmrtlp8qQjPacby26LBqE2jJqzf7vj8QtFs8h4GEBuPz4AgNIzIDa
         qRukWZ1Ll+b2VHYq14dEfhq3Blf5njvh3ZiO+Pjq0LFQf5jNCLxL8N/wFudJStodJvzm
         40ZcewbtzLB2seVYOn3B1TIZL1PEJT4fF7vuXX/XLU/r9nIE61rPEqFWx7Md25Q7wwBl
         RyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537669; x=1709142469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjZeg4n3tqPpufkNBWnAqvfUdTIuu3uusZzvbzvoqqQ=;
        b=CAE2JUvcOV6odDQYT3FEBTSw02lX4W6f+wcZH99YmCZPgm3GjGeuTzNUkB8ZMU9Wxh
         BYmWWYQuXjIDtNT+TB4Nel6IXgHJ5pEQKEA/R2taFzfPoAPtFSO0TwQI/KKDPI7xv10e
         yPGzWElLzrEI6LolNpGkZk8e920e1Avr0cPrIkXmhUAJ2CCrT3b66tKbguwF2RfgVP+K
         gr1p27uGpBpgLk/aCAE60cHT8hFXKNDRipjKIwE2SZrwSRyjwCacn07vQKb8Ibp9gGRa
         wxOOXFBCbiFgxquICXhp2BJZUFfb7cqpyctj9dsSUqy0//tHTXK/pnMP1S4HQcbTBxAH
         fo9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7arnXPErdQIqugmUJbOGzwwIAe4PMB4ORHDL1kQeefNRP90tnYCUyrHjHHSgS/gU25HFxawtgHsHLu0bTDpBd3dRD
X-Gm-Message-State: AOJu0YwadZxHYxAJq5QrOEKg2FzTc34HA/zHw5nILHwsg/MolrHiyo+x
	PPY7EY8hJp7LUwkad9J3WRtHnQIppuwZuZtYwS2kwGwolT3Yphb5
X-Google-Smtp-Source: AGHT+IEiNFyqbGnn0MD8l/JE+9q3dUS0C1RlUj67UwfpUwHsz2Rlsd7awwhSW+6YuFJZDfZumFxUsA==
X-Received: by 2002:a0d:f447:0:b0:608:6ca9:abda with SMTP id d68-20020a0df447000000b006086ca9abdamr4999967ywf.52.1708537669516;
        Wed, 21 Feb 2024 09:47:49 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:bc3b:b762:a625:955f? ([2600:1700:6cf8:1240:bc3b:b762:a625:955f])
        by smtp.gmail.com with ESMTPSA id v82-20020a814855000000b00608876ed731sm256033ywa.126.2024.02.21.09.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 09:47:49 -0800 (PST)
Message-ID: <f5338514-793a-4d73-9b8f-1381e985c943@gmail.com>
Date: Wed, 21 Feb 2024 09:47:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 4/5] bpftool: generated shadow variables for
 struct_ops maps.
Content-Language: en-US
To: Quentin Monnet <quentin@isovalent.com>, thinker.li@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240221012329.1387275-1-thinker.li@gmail.com>
 <20240221012329.1387275-5-thinker.li@gmail.com>
 <70fe67f3-4ae2-4866-95d6-e41c908ca300@isovalent.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <70fe67f3-4ae2-4866-95d6-e41c908ca300@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/21/24 03:49, Quentin Monnet wrote:
> 2024-02-21 01:23 UTC+0000 ~ thinker.li@gmail.com
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Declares and defines a pointer of the shadow type for each struct_ops map.
>>
>> The code generator will create an anonymous struct type as the shadow type
>> for each struct_ops map. The shadow type is translated from the original
>> struct type of the map. The user of the skeleton use pointers of them to
>> access the values of struct_ops maps.
>>
>> However, shadow types only supports certain types of fields, such as scalar
> 
> Nit: "such as" implies the list may not be exhaustive.
> 
>> types and function pointers. Any fields of unsupported types are translated
>> into an array of characters to occupy the space of the original
>> field. Function pointers are translated into pointers of the struct
>> bpf_program. Additionally, padding fields are generated to occupy the space
>> between two consecutive fields.
>>
>> The pointers of shadow types of struct_osp maps are initialized when
>> *__open_opts() in skeletons are called. For a map called FOO, the user can
>> access it through the pointer at skel->struct_ops.FOO.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/bpf/bpftool/gen.c | 229 +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 228 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>> index a9334c57e859..20c5d5912df7 100644
>> --- a/tools/bpf/bpftool/gen.c
>> +++ b/tools/bpf/bpftool/gen.c
>> @@ -909,6 +909,201 @@ codegen_progs_skeleton(struct bpf_object *obj, size_t prog_cnt, bool populate_li
>>   	}
>>   }
>>   
>> +static int walk_st_ops_shadow_vars(struct btf *btf,
>> +				   const char *ident,
>> +				   const struct bpf_map *map)
>> +{
>> +	DECLARE_LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts,
>> +			    .indent_level = 3,
>> +			    );
>> +	const struct btf_type *map_type, *member_type;
>> +	__u32 map_type_id, member_type_id;
>> +	__u32 offset, next_offset = 0;
>> +	const struct btf_member *m;
>> +	const char *member_name;
>> +	struct btf_dump *d = NULL;
>> +	int i, err = 0;
>> +	int size, map_size;
>> +
>> +	map_type_id = bpf_map__btf_value_type_id(map);
>> +	if (map_type_id == 0)
>> +		return -EINVAL;
>> +	map_type = btf__type_by_id(btf, map_type_id);
>> +	if (!map_type)
>> +		return -EINVAL;
>> +
>> +	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
>> +	if (!d)
>> +		return -errno;
>> +
>> +	for (i = 0, m = btf_members(map_type);
>> +	     i < btf_vlen(map_type);
>> +	     i++, m++) {
>> +		member_type = skip_mods_and_typedefs(btf, m->type,
>> +						     &member_type_id);
>> +		if (!member_type) {
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		member_name = btf__name_by_offset(btf, m->name_off);
>> +		if (!member_name) {
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		offset = m->offset / 8;
>> +		if (next_offset != offset) {
>> +			printf("\t\t\tchar __padding_%d[%d];\n",
>> +			       i - 1, offset - next_offset);
>> +		}
>> +
>> +		switch (btf_kind(member_type)) {
>> +		case BTF_KIND_INT:
>> +		case BTF_KIND_FLOAT:
>> +		case BTF_KIND_ENUM:
>> +		case BTF_KIND_ENUM64:
>> +			/* scalar type */
>> +			printf("\t\t\t");
>> +			opts.field_name = member_name;
>> +			err = btf_dump__emit_type_decl(d, member_type_id,
>> +						       &opts);
>> +			if (err)
>> +				goto out;
>> +			printf(";\n");
>> +
>> +			size = btf__resolve_size(btf, member_type_id);
>> +			if (size < 0) {
>> +				err = size;
>> +				goto out;
>> +			}
>> +
>> +			next_offset = offset + size;
>> +			break;
>> +
>> +		case BTF_KIND_PTR:
>> +			if (resolve_func_ptr(btf, m->type, NULL)) {
>> +				/* Function pointer */
>> +				printf("\t\t\tconst struct bpf_program *%s;\n",
>> +				       member_name);
>> +
>> +				next_offset = offset + sizeof(void *);
>> +				break;
>> +			}
>> +			fallthrough;
> 
> I wouldn't mind a comment about the "fallthrough;" to state explicitly
> that only function pointers are supported for now.


Sure

> 
>> +
>> +		default:
>> +			/* Unsupported types
>> +			 *
>> +			 * For unsupported types, we have to generate
>> +			 * definitions for them in order to support
>> +			 * them. For example, we need to generate a
>> +			 * definition for a struct type or a union type. It
>> +			 * may cause type conflicts without renaming since
>> +			 * the same type may be defined for several
>> +			 * skeletons, and the user may include these
>> +			 * skeletons in the same compile unit.
>> +			 */
> 
> This comment could be clearer. "For unsupported types, we have to
> generate definitions for them in order to support them". So do we, or do
> we not support them? "It may cause type conflicts [...]" -> do we
> address these?
> 
> My understanding is that this note describes the work to do if we want
> to add support in the future, and this could perhaps be more explicit:
> "We do not support other types yet. The reason is that ... But when we
> generate definitions, we will have to take care of type conflicts
> because ...". What do you think?


Agree! I will rephrase this comment.

> 
>> +			if (i == btf_vlen(map_type) - 1) {
>> +				map_size = btf__resolve_size(btf, map_type_id);
>> +				if (map_size < 0)
>> +					return -EINVAL;
>> +				size = map_size - offset;
>> +			} else {
>> +				size = (m[1].offset - m->offset) / 8;
>> +			}
>> +
>> +			printf("\t\t\tchar __padding_%d[%d];\n", i, size);
>> +
>> +			next_offset = offset + size;
>> +			break;
>> +		}
>> +	}
>> +
>> +out:
>> +	btf_dump__free(d);
>> +
>> +	return err;
>> +}
>> +
>> +/* Generate the pointer of the shadow type for a struct_ops map.
>> + *
>> + * This function adds a pointer of the shadow type for a struct_ops map.
>> + * The members of a struct_ops map can be exported through a pointer to a
>> + * shadow type. The user can access these members through the pointer.
>> + *
>> + * A shadow type includes not all members, only members of some types.
>> + * They are scalar types and function pointers. The function pointers are
>> + * translated to the pointer of the struct bpf_program. The scalar types
>> + * are translated to the original type without any modifiers.
>> + *
>> + * Unsupported types will be translated to a char array to take the same
>> + * space of the original field. However, due to handling padding and
>> + * alignments, the user should not access them directly.
> 
> What's the risk, and how should users know?

The names of unsupported fields are replaced by "__padding_*", and their
types are "char []".
Changing names and types of fields in a struct can lead to accessing
issues, where users may inadvertently corrupt data due to padding and
field reordering in different versions.

I will include the above explanation in the next version.

> 
>> + */
> 
> [...]
> 
> Thanks for this work! The bpftool changes look good. I've got these few
> observations above, but notwithstanding:
> 
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> 
> I wonder, did you think of adding a paragraph or an example to the man
> page for "bpftool gen"? Your change is for a specific use case, but
> otherwise I'm not sure how users will ever know that these shadow types
> are available (other than discovering them by luck in a skeleton) or how
> to use them if they need to.

Sure! I will add it in the following version.

> 
> Thanks,
> Quentin

