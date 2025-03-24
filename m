Return-Path: <bpf+bounces-54606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910F0A6D9AF
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 13:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E84716C4F0
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9964425D8E1;
	Mon, 24 Mar 2025 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2Zi20W0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462218D65F
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817712; cv=none; b=D51DttX8UKxZFS47BSceHj9dUoK1nQqGNL1124m6OBdYeRCioMwm3oJFpfNtn19AhjyYTIGbXdI4jrMrJ8C5syGVYLhiPsDV70ZetvY1Zt3+bUhm/bXYEKnY7ARs4JWw/uvbPjTgnxbLthPKXqeVR9R+19ED0MizsHOK2JVN1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817712; c=relaxed/simple;
	bh=WnJeJzi5azuQ5tScOq3SuJNHH4/EHrrR1ojnHVqUUSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekqToMd1O7IM92gH8D5FuQta1ZU7bzf3k3mthr5vM2Dk3S8dWBmCWtvm8MDSBw13fthFUsC7rSJ8lk64CKCNw26QHOrvneTJ7qcV6+KxJjHuokwm7cbSt30qcmbPK3lHLbq8hT1+6p+/8wB/CeazUbx0Q3buugS6iRa/Y0Kho8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2Zi20W0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913cf69784so3444941f8f.1
        for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 05:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742817708; x=1743422508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jGvYGPWze+juchZpdjGPGH4M0r+INDXB337ghWaOsg=;
        b=L2Zi20W0bjtLETiBnTptAQ8zHmuSOpoJ8dYC9N94lcXsj4FIDIniG6YkOakHGY7Yp5
         1+doSDyCNvSMoAfAtRuTSBvLDaamk/zvx/EvHgRIwgNHKVESWXCgp81Ek8U75rgZUxgu
         piGacslsz8OnLUA6MghIS5V7zQ0Lec+MG1VC8czZ5fu1e3zic9ddbsVB+8nFWRY0f/0T
         v9ecNRiTiH8SA4Y/YTDRLGOsWGBVHVuTrwFsOsXaLyZoPEL67DPjmdDvbiLY3Yq3PwHy
         Fuo7dHSDBF/+iNonS9zag/vPS1Ovexoj+TxqbNxX2rGOXPEgnC7YZim9Bpe3EMcadtSI
         Wnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742817708; x=1743422508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jGvYGPWze+juchZpdjGPGH4M0r+INDXB337ghWaOsg=;
        b=SZ5KosPb48yG0b+5S3pfK3D28yBwRx0DK5zeSVeyiCe9iYsd8r4G6Z2GOgeIBZNdD5
         JXC81UWpMta8qZuyIUTbwOvV95BziWcHUb4Uio3VkmJ1H8zYjB0qST5dfpqWb8fSKz7W
         AnpI4rvKIJ8Sm/eqOvGphzmmEjjyY4nHz8LGV2jjTa0drXFmc6+vdqqLTtcgJFnB9Fyq
         JOrapQMyGOiI5ZCCvP5dzfRmt4v4PTfRmQspqJGt6MaVGrcADMfOg7N6z7cUX7svdFn2
         ZoRpdNoHDmHYbcETqqIJsF/H8XSQPlGdBbCLDmuEH5R41Bu1mfolHEhS9bzr+mneIBJI
         craw==
X-Forwarded-Encrypted: i=1; AJvYcCUGlp24V1kzPzOCDoaZOak49/rjFFY5VsjO7wT2WAwkIV6I82VL5y5zrF1YGZbDnaYgcAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhUmMluWvNxK9ImK0tsTLqq4KXYxz6Hw2L46KBeZIjPLA4hDp8
	XKPz7s6wLTtSe+i+VO4zT0EBsGE6AhI8y0Q5X7bDrMbrvZG/2ssy
X-Gm-Gg: ASbGncvuwI8uPSxf1WVyfJ8CBGMaqKURUPPCjWoEYgas7AeME9TsZIAy22jD08h5/Ml
	fBwyIizFCN3bgmDlUCHwqr4GiyV7nopzpdf9StMUc0BYzSivDoqHTHnzWQRzMmVqCWaqEffruyS
	4dXDDWJGV87IxDKrwitodrQ2RRrRZ3oRvdiapvcMEnAjms08LSvOdyiiFH8trtoLPYqUPQpntf4
	6DIpcMECE317Vhu+G0cElkBT7bkqGVWN9PzykeTzU0tgS+E3QB1nE1zpkzRhsutrCgNoFQUDh80
	v4jWMJHxesADzg4lmEr4JQB7yIRIIlfYaHOLcsX0Ew4mtncLs/8/5tmZ1186PjCY+qqOl8H0vZ0
	Hrx7jPikbIHbyd03Zj4pGXqzLzvsD8HH6RlcO
X-Google-Smtp-Source: AGHT+IHq+QbsL/Az44MedVns5Gz0RMgPP0qmn8Dlz9s14OaFl1RvxprwB4cBb56QgFqOV6GpXKjHsQ==
X-Received: by 2002:a05:6000:2cf:b0:391:1473:2a08 with SMTP id ffacd0b85a97d-3997f8f8ae5mr8655871f8f.7.1742817707890;
        Mon, 24 Mar 2025 05:01:47 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10? ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd2798bsm121073875e9.20.2025.03.24.05.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 05:01:47 -0700 (PDT)
Message-ID: <d1b7e614-8a8a-4767-86fc-4f3e45215e49@gmail.com>
Date: Mon, 24 Mar 2025 12:01:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: support struct/union presets in
 veristat
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250320224546.241673-1-mykyta.yatsenko5@gmail.com>
 <73d0676051a7e0e0108a13a5b4f36c33d6496fa2.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <73d0676051a7e0e0108a13a5b4f36c33d6496fa2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/03/2025 01:09, Eduard Zingerman wrote:
> On Thu, 2025-03-20 at 22:45 +0000, Mykyta Yatsenko wrote:
>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
>> index a18972ffdeb6..babc97b799a2 100644
>> --- a/tools/testing/selftests/bpf/veristat.c
>> +++ b/tools/testing/selftests/bpf/veristat.c
>> @@ -23,6 +23,7 @@
>>   #include <float.h>
>>   #include <math.h>
>>   #include <limits.h>
>> +#include <linux/err.h>
>>   
>>   #ifndef ARRAY_SIZE
>>   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>> @@ -1486,7 +1487,131 @@ static bool is_preset_supported(const struct btf_type *t)
>>   	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
>>   }
>>   
>> -static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct btf_type *t,
>> +struct btf_anon_stack {
>> +	const struct btf_type *t;
>> +	__u32 offset;
>> +};
>> +
>> +const struct btf_member *btf_find_member(const struct btf *btf,
>> +					 const struct btf_type *parent_type,
>> +					 const char *member_name,
>> +					 __u32 *anon_offset)
>> +{
>> +	struct btf_anon_stack *anon_stack;
>> +	const struct btf_member *retval = NULL;
>> +	__u32 cur_offset = 0;
>> +	const char *name;
>> +	int top = 0, i;
>> +
>> +	if (!btf_is_struct(parent_type) && !btf_is_union(parent_type))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	anon_stack = malloc(sizeof(*anon_stack));
>> +	if (!anon_stack)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	anon_stack[top].t = parent_type;
>> +	anon_stack[top++].offset = 0;
>> +
>> +	do {
>> +		parent_type = anon_stack[--top].t;
>> +		cur_offset = anon_stack[top].offset;
>> +
>> +		for (i = 0; i < btf_vlen(parent_type); ++i) {
>> +			const struct btf_member *member;
>> +			const struct btf_type *t;
>> +			int tid;
>> +
>> +			member = btf_members(parent_type) + i;
>> +			tid =  btf__resolve_type(btf, member->type);
> Nit: these are called member_tid and member_type in the function below.
>
>> +			if (tid < 0) {
>> +				retval = ERR_PTR(-EINVAL);
>> +				goto out;
>> +			}
>> +			t = btf__type_by_id(btf, tid);
>> +			if (member->name_off) {
>> +				name = btf__name_by_offset(btf, member->name_off);
>> +				if (name && strcmp(member_name, name) == 0) {
>> +					if (anon_offset)
> Nit: anon_offset is always non-null.
>
Addressing nits in v2.
>> +						*anon_offset = cur_offset;
>> +					retval = member;
>> +					goto out;
>> +				}
>> +			} else if (t) {
> Nit: result of `btf__resolve_type()` is not checked against NULL in
>       most places in veristat.c. When bpf object file is opened by
>       libbpf the BTF is setup by function btf.c:btf_new(), which
>       does some sanity including checks for ids of member types.
>       See btf.c:btf_sanity_check().
>
>> +				struct btf_anon_stack *tmp;
>> +
>> +				tmp = realloc(anon_stack, (top + 1) * sizeof(*anon_stack));
>> +				if (!tmp) {
>> +					retval = ERR_PTR(-ENOMEM);
>> +					goto out;
>> +				}
>> +				anon_stack = tmp;
>> +				/* Anonymous union/struct: push to stack */
>> +				anon_stack[top].t = t;
>> +				anon_stack[top++].offset = cur_offset + member->offset;
> I think it is necessary to check that `t` is struct or union,
> otherwise something like 'struct foo { int :64; int bar; }'
> will cause trouble.
This is a good idea, I agree.
>> +			}
>> +		}
>> +	} while (top > 0);
>> +out:
>> +	free(anon_stack);
>> +	return retval;
>> +}
>> +
>> +static int adjust_var_secinfo_tok(char **name_tok, const struct btf *btf,
>> +				  const struct btf_type *t, struct btf_var_secinfo *sinfo)
>> +{
>> +	char *name = strtok_r(NULL, ".", name_tok);
>> +	const struct btf_type *member_type;
>> +	const struct btf_member *member;
>> +	int member_tid;
>> +	__u32 anon_offset = 0;
>> +
>> +	if (!name)
>> +		return 0;
>> +
>> +	if (!btf_is_union(t) && !btf_is_struct(t))
>> +		return -EINVAL;
>> +
>> +	member = btf_find_member(btf, t, name, &anon_offset);
>> +	if (IS_ERR(member))
>> +		return -EINVAL;
>> +
>> +	member_tid = btf__resolve_type(btf, member->type);
>> +	member_type = btf__type_by_id(btf, member_tid);
>> +
>> +	if (btf_kflag(t)) {
>> +		sinfo->offset += (BTF_MEMBER_BIT_OFFSET(member->offset) + anon_offset) / 8;
>> +		sinfo->size = BTF_MEMBER_BITFIELD_SIZE(member->offset) / 8;
> Bitfields are not handled by `set_global_var`, as ->size is in bytes.
> Maybe just error out here saying that setting bitfields is not supported?
> Alternatively, there is a utility function btf_member_bit_offset(),
> maybe declare a similar btf_member_bit_size() and remove the
> btf_kflag(t) condition here? Just to make it a bit easier to understand.
Right, we don't support setting bitfields, It makes sense to error out.
>> +	} else {
>> +		sinfo->offset += (member->offset + anon_offset) / 8;
>> +		sinfo->size = member_type->size;
>> +	}
>> +	sinfo->type = member_tid;
>> +
>> +	return adjust_var_secinfo_tok(name_tok, btf, member_type, sinfo);
>> +}
>> +
>> +static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
>> +			      struct btf_var_secinfo *sinfo, const char *var)
>> +{
>> +	char expr[256], *saveptr;
>> +	const struct btf_type *base_type;
>> +	int err;
>> +
>> +	base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
>> +	if (!btf_is_union(base_type) && !btf_is_struct(base_type))
>> +		return 0;
> What would happen if preset "foo.bar" would be specified for variable
> "foo" being e.g. of type "int"? It seems the ".bar" part would be just
> ignored.
>
good point, I'll change this for v2.
>> +
>> +	strcpy(expr, var);
> Nit: strncpy ?
yes
>
>> +	strtok_r(expr, ".", &saveptr);
>> +	err = adjust_var_secinfo_tok(&saveptr, btf, base_type, sinfo);
>> +	if (err)
>> +		return err;
>> +
>> +	return 0;
>> +}
>> +
>> +static int set_global_var(struct bpf_object *obj, struct btf *btf,
>>   			  struct bpf_map *map, struct btf_var_secinfo *sinfo,
>>   			  struct var_preset *preset)
>>   {
>> @@ -1495,9 +1620,9 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct
>>   	long long value = preset->ivalue;
>>   	size_t size;
>>   
>> -	base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
>> +	base_type = btf__type_by_id(btf, btf__resolve_type(btf, sinfo->type));
>>   	if (!base_type) {
>> -		fprintf(stderr, "Failed to resolve type %d\n", t->type);
>> +		fprintf(stderr, "Failed to resolve type %d\n", sinfo->type);
>>   		return -EINVAL;
>>   	}
>>   	if (!is_preset_supported(base_type)) {
>> @@ -1530,7 +1655,7 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct
>>   		if (value >= max_val || value < -max_val) {
>>   			fprintf(stderr,
>>   				"Variable %s value %lld is out of range [%lld; %lld]\n",
>> -				btf__name_by_offset(btf, t->name_off), value,
>> +				btf__name_by_offset(btf, base_type->name_off), value,
>>   				is_signed ? -max_val : 0, max_val - 1);
>>   			return -EINVAL;
>>   		}
>> @@ -1590,7 +1715,12 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
>>   			var_name = btf__name_by_offset(btf, var_type->name_off);
>>   
>>   			for (k = 0; k < npresets; ++k) {
>> -				if (strcmp(var_name, presets[k].name) != 0)
>> +				struct btf_var_secinfo tmp_sinfo;
>> +				int var_len = strlen(var_name);
>> +
>> +				if (strncmp(var_name, presets[k].name, var_len) != 0 ||
>> +				    (presets[k].name[var_len] != '\0' &&
>> +				     presets[k].name[var_len] != '.'))
> var_name comes from BTF and presets[k].name comes from command line, right?
> Meaning that there might be a case when strlen(presets[k].name) < strlen(var_name)
> and access presets[k].name[var_len] would be out of bounds. Wdyt?
checks
```
+(presets[k].name[var_len] != '\0' && presets[k].name[var_len] != '.')
```
Are executed only if
```
strncmp(var_name, presets[k].name, var_len) == 0
```
returns 0 (because of ||), which means there are at least var_len 
non-terminal symbols in
presets[k].name.

>>   					continue;
>>   
>>   				if (presets[k].applied) {
>> @@ -1598,13 +1728,17 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
>>   						var_name);
>>   					return -EINVAL;
>>   				}
>> +				memcpy(&tmp_sinfo, sinfo, sizeof(*sinfo));
>> +				err = adjust_var_secinfo(btf, var_type,
>> +							 &tmp_sinfo, presets[k].name);
>> +				if (err)
>> +					return err;
>>   
>> -				err = set_global_var(obj, btf, var_type, map, sinfo, presets + k);
>> +				err = set_global_var(obj, btf, map, &tmp_sinfo, presets + k);
>>   				if (err)
>>   					return err;
>>   
>>   				presets[k].applied = true;
>> -				break;
> This is removed to handle cases with presets "foo.bar" and "foo.buz", right?
> Maybe extend the test case a bit?
It has been extended, check this out:
+        " -G \"union1.struct3.var_u8_l = 0xaa\" "\
+        " -G \"union1.struct3.var_u8_h = 0xaa\" "\
>>   			}
>>   		}
>>   	}
>


