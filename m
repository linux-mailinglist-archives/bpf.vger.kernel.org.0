Return-Path: <bpf+bounces-22398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CF985D76A
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 12:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E001F22F99
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 11:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ACC45C06;
	Wed, 21 Feb 2024 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="IoU5+qWg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B573747A79
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516188; cv=none; b=mtldKKXZSgH9IbDF+I56In8UCjgSTvAfBr27xtRCEhUCsa/cBVRp6UNsb/QLnXDaPDR12is9q6c1jJt06+ptimzaOSBBJc3AMypjZ1LI6FnB2zPmXl9/yH5E3u1z6ubJtzkGFnv5/rvmZgXTRbN8zO0bwe6Nu1LPzMDotn3Ie78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516188; c=relaxed/simple;
	bh=OFJj0MNekxMwz0N3n4bK7VDzgmk7ibORDahCKwIwZxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdKDlULh2ML/9MXgp6p7teXA1BUHVeoP8JsBuF5JZBJ0nQ/4l18VxZTuO2KwUD+pfvPAS5oBEIguiCwMoEMrm9YCL6HH6Wsa/uqlf1rITraY099HDcRHFjxPfBzfbHxxgjAiuiRUbuM8kws6jlIR6tc30N26hPO+FDNCJEh2S6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=IoU5+qWg; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d23d301452so5699061fa.1
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 03:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1708516185; x=1709120985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTOZ8Gs/A4Ar2seHb8g4kjHrVQkMtpxWuSEL8mT4Ehc=;
        b=IoU5+qWgXaiV1xA4JEXL6iEFRNrkDFm51ubfUIaRfCuplk6gGDe7E3UHWu6zUL6ea+
         Qh6P1GD1Rd+UamoLsAF6JtYdtb863H8d8IY6of6ZpMGoAC9iqVG58jx2dTiKn7RbA4Hb
         gWBmEFzBsF3s/R8AUXHi2fqCToFJ8qN6+BS+4tJhS9ex3+68a5f6ClWVxM+Xa8JGcROc
         Gg/R4H38yklnTNj5l00hHfhHmOrK3PiF2vxHwMUOYKvHOy0PyudWMR4jl+wgoHvYc3RC
         m/PAXSWAX48yzkGv6avzqcvp8oFBEW3oH/VAUmttaDv4b/sT2ri96QvGlHo55Wt1fqOQ
         PlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708516185; x=1709120985;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTOZ8Gs/A4Ar2seHb8g4kjHrVQkMtpxWuSEL8mT4Ehc=;
        b=ot7sydYQH/9mmwlLsJS9cnP6tXTeFZVJhIlY9u2FTDFVaoIMVXei1wuNETTMjSfbE4
         daCPCpdFIiBdRXJYnLRosE970tOCI24GEfAHDrIkha3KxIPN95LZN37mA393ND640mau
         +XhxK1UmpbpYBBrZGdG0NmZwVcK65Y+ZiN/6mupKPwObmpqo7CfOsUT5MfcLiDzeRVy2
         JTGtNDfEDgqCwC2rMFQneEpHHVrVhHbd3YBoresXGOGgf32bSK/WC4F5OaSc6SLVnMS/
         OC1gBCfQjpDsF3d0/MqPnmLDtY20KG9QTXriUJ+XNjPjRexancC6hNBuN4kcCntDmCZn
         LejA==
X-Forwarded-Encrypted: i=1; AJvYcCVXdnqxH7mmGmYkTa9ycltfMvaT4iwfk9HRYP24lgVoy+s8AmY6Ixg8ZJlIszomob0S8JrDzqHr6UwcJepauulcNAMX
X-Gm-Message-State: AOJu0Yyv4czAmOlA+p7EWfoT3kkQTekkMgIiyBVXhpEX157C7EDGumN0
	hEQuEbEJaqvfbZXVCJDdx2axJMLlHeEvrEUvHoB4bS9DLtLl0b6dU39gAvUjf0s=
X-Google-Smtp-Source: AGHT+IGl0AHUJll3VsYBeGntq92oC5CoVIt89imtv1ArfUC8R7UaW0Uawh18v9LPC3m2O9Pu5XVCWA==
X-Received: by 2002:a05:6512:3a7:b0:512:b37f:a9ae with SMTP id v7-20020a05651203a700b00512b37fa9aemr4677166lfp.63.1708516184838;
        Wed, 21 Feb 2024 03:49:44 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:94d:9869:c48b:acac? ([2a02:8011:e80c:0:94d:9869:c48b:acac])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b00412590eee7csm14945004wmq.10.2024.02.21.03.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 03:49:44 -0800 (PST)
Message-ID: <70fe67f3-4ae2-4866-95d6-e41c908ca300@isovalent.com>
Date: Wed, 21 Feb 2024 11:49:43 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 4/5] bpftool: generated shadow variables for
 struct_ops maps.
Content-Language: en-GB
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20240221012329.1387275-1-thinker.li@gmail.com>
 <20240221012329.1387275-5-thinker.li@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240221012329.1387275-5-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-02-21 01:23 UTC+0000 ~ thinker.li@gmail.com
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Declares and defines a pointer of the shadow type for each struct_ops map.
> 
> The code generator will create an anonymous struct type as the shadow type
> for each struct_ops map. The shadow type is translated from the original
> struct type of the map. The user of the skeleton use pointers of them to
> access the values of struct_ops maps.
> 
> However, shadow types only supports certain types of fields, such as scalar

Nit: "such as" implies the list may not be exhaustive.

> types and function pointers. Any fields of unsupported types are translated
> into an array of characters to occupy the space of the original
> field. Function pointers are translated into pointers of the struct
> bpf_program. Additionally, padding fields are generated to occupy the space
> between two consecutive fields.
> 
> The pointers of shadow types of struct_osp maps are initialized when
> *__open_opts() in skeletons are called. For a map called FOO, the user can
> access it through the pointer at skel->struct_ops.FOO.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/bpf/bpftool/gen.c | 229 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 228 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a9334c57e859..20c5d5912df7 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -909,6 +909,201 @@ codegen_progs_skeleton(struct bpf_object *obj, size_t prog_cnt, bool populate_li
>  	}
>  }
>  
> +static int walk_st_ops_shadow_vars(struct btf *btf,
> +				   const char *ident,
> +				   const struct bpf_map *map)
> +{
> +	DECLARE_LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts,
> +			    .indent_level = 3,
> +			    );
> +	const struct btf_type *map_type, *member_type;
> +	__u32 map_type_id, member_type_id;
> +	__u32 offset, next_offset = 0;
> +	const struct btf_member *m;
> +	const char *member_name;
> +	struct btf_dump *d = NULL;
> +	int i, err = 0;
> +	int size, map_size;
> +
> +	map_type_id = bpf_map__btf_value_type_id(map);
> +	if (map_type_id == 0)
> +		return -EINVAL;
> +	map_type = btf__type_by_id(btf, map_type_id);
> +	if (!map_type)
> +		return -EINVAL;
> +
> +	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
> +	if (!d)
> +		return -errno;
> +
> +	for (i = 0, m = btf_members(map_type);
> +	     i < btf_vlen(map_type);
> +	     i++, m++) {
> +		member_type = skip_mods_and_typedefs(btf, m->type,
> +						     &member_type_id);
> +		if (!member_type) {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		member_name = btf__name_by_offset(btf, m->name_off);
> +		if (!member_name) {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		offset = m->offset / 8;
> +		if (next_offset != offset) {
> +			printf("\t\t\tchar __padding_%d[%d];\n",
> +			       i - 1, offset - next_offset);
> +		}
> +
> +		switch (btf_kind(member_type)) {
> +		case BTF_KIND_INT:
> +		case BTF_KIND_FLOAT:
> +		case BTF_KIND_ENUM:
> +		case BTF_KIND_ENUM64:
> +			/* scalar type */
> +			printf("\t\t\t");
> +			opts.field_name = member_name;
> +			err = btf_dump__emit_type_decl(d, member_type_id,
> +						       &opts);
> +			if (err)
> +				goto out;
> +			printf(";\n");
> +
> +			size = btf__resolve_size(btf, member_type_id);
> +			if (size < 0) {
> +				err = size;
> +				goto out;
> +			}
> +
> +			next_offset = offset + size;
> +			break;
> +
> +		case BTF_KIND_PTR:
> +			if (resolve_func_ptr(btf, m->type, NULL)) {
> +				/* Function pointer */
> +				printf("\t\t\tconst struct bpf_program *%s;\n",
> +				       member_name);
> +
> +				next_offset = offset + sizeof(void *);
> +				break;
> +			}
> +			fallthrough;

I wouldn't mind a comment about the "fallthrough;" to state explicitly
that only function pointers are supported for now.

> +
> +		default:
> +			/* Unsupported types
> +			 *
> +			 * For unsupported types, we have to generate
> +			 * definitions for them in order to support
> +			 * them. For example, we need to generate a
> +			 * definition for a struct type or a union type. It
> +			 * may cause type conflicts without renaming since
> +			 * the same type may be defined for several
> +			 * skeletons, and the user may include these
> +			 * skeletons in the same compile unit.
> +			 */

This comment could be clearer. "For unsupported types, we have to
generate definitions for them in order to support them". So do we, or do
we not support them? "It may cause type conflicts [...]" -> do we
address these?

My understanding is that this note describes the work to do if we want
to add support in the future, and this could perhaps be more explicit:
"We do not support other types yet. The reason is that ... But when we
generate definitions, we will have to take care of type conflicts
because ...". What do you think?

> +			if (i == btf_vlen(map_type) - 1) {
> +				map_size = btf__resolve_size(btf, map_type_id);
> +				if (map_size < 0)
> +					return -EINVAL;
> +				size = map_size - offset;
> +			} else {
> +				size = (m[1].offset - m->offset) / 8;
> +			}
> +
> +			printf("\t\t\tchar __padding_%d[%d];\n", i, size);
> +
> +			next_offset = offset + size;
> +			break;
> +		}
> +	}
> +
> +out:
> +	btf_dump__free(d);
> +
> +	return err;
> +}
> +
> +/* Generate the pointer of the shadow type for a struct_ops map.
> + *
> + * This function adds a pointer of the shadow type for a struct_ops map.
> + * The members of a struct_ops map can be exported through a pointer to a
> + * shadow type. The user can access these members through the pointer.
> + *
> + * A shadow type includes not all members, only members of some types.
> + * They are scalar types and function pointers. The function pointers are
> + * translated to the pointer of the struct bpf_program. The scalar types
> + * are translated to the original type without any modifiers.
> + *
> + * Unsupported types will be translated to a char array to take the same
> + * space of the original field. However, due to handling padding and
> + * alignments, the user should not access them directly.

What's the risk, and how should users know?

> + */

[...]

Thanks for this work! The bpftool changes look good. I've got these few
observations above, but notwithstanding:

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

I wonder, did you think of adding a paragraph or an example to the man
page for "bpftool gen"? Your change is for a specific use case, but
otherwise I'm not sure how users will ever know that these shadow types
are available (other than discovering them by luck in a skeleton) or how
to use them if they need to.

Thanks,
Quentin

