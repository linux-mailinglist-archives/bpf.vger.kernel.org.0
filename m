Return-Path: <bpf+bounces-50408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C794A271D6
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 13:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AE9163CF1
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB3F211290;
	Tue,  4 Feb 2025 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKUxwoXh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3FC20F074
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738672191; cv=none; b=pQpLTHZ9u6KQplTCLx7Tuh+YApzXddjg1xhAFDtlFfDWpn1kuYqxDf8J+YGGDK52uu+VxddjZS7pbomzaM9ZdYFj96nc0V1a0hXXeDRtr3+HA5qzA4AqrSitAV9B/8Il8I0dea767cUnRq4xwP4qY3KV9XQTdWB5PoYJYbbHMZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738672191; c=relaxed/simple;
	bh=jYQIB/FyKU0Z4mzWv5Ik32DKdBZBTOs3Gr/Ucmtzoco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3lnauurZbou9kzhBS8FTo7ZEHpjg9eDZxpdQRu7308XqOIw6K0hJjtGVllyfYGpiF+OgQdiSs26ma9oZSmPqn0mIZzWDvCxnrBNgW7qTS7CrVPv2XEPimPSTrUOB2XLhLctsuX0BP3/w7CMMxmyNTCNlDvtaHJ6J8Y5pCd94+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKUxwoXh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso37946035e9.3
        for <bpf@vger.kernel.org>; Tue, 04 Feb 2025 04:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738672187; x=1739276987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzsIw3ZWXC0QC3FjNMfj/os8fYOct5DeRn8bPKhGFSc=;
        b=MKUxwoXhzIij3iTHjdcTgDco5yTrhaG3cNMUdNY/8YDpzQ6IeNUmk3kKgQn53m4B/t
         EVi9Uhtoy3MNkG8Iu0tqnzsuqdxBUFA4OxmMTrFiPUwWtKuWh0NfUHb33KnIqB5neX1T
         GucmpgxfGgwKeZ2TMJwpMD4O3Q4mIHPf7EWOdJxLnt182DVz1YHdiSG3Mc9/cz1k5hNj
         didfREYGxGKr3JXxf0Bg5YK8iL7CcQ1pkKp0yovY0pwL6PU2+VpxQJGfLE+MbXo52aOB
         gnyKWl/9vBDwQnLIGiYQmyrq4DKiupgjBsZpQPuJL5BJHVZhivuF7r6F7ySyuMPaProP
         wDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738672187; x=1739276987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzsIw3ZWXC0QC3FjNMfj/os8fYOct5DeRn8bPKhGFSc=;
        b=F8Tv7kD2fk8EboYFIpERj90yC48K101mnyxA2C15JMB4R2iSPfjo4EQX+51asXi4Qd
         +IvYvKKGLO9hKj6jSK96PcUGBLLl9x3iqv5SQVaejT3SLGwunfwjimnE4uLgKc+iZgdo
         tp3kp6Tx2pO6fedvEkZZP7ERMnhANkjN8f2LWcZP55z0RHewK/tYLwV8NvijZzVoGXOA
         984VOvuONSRZGCJVslM0N2XiK7JxuYFvMXq3Lp/HoUMRflwXhoHmQGYBUFk0mTWtQKPL
         56+fqKMwgJEj4mhPSlCj/REYbp1Qjxpoism5fp3cG6ZGnF5aINarNWT3/KBhI4l7dkOW
         YGug==
X-Forwarded-Encrypted: i=1; AJvYcCWbaQ4qWECqhXpWa79a7kx2Ltaf+1pjIpN1g/C6nXADoe9THFmoObYgtg1fwhsPdD0kbes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+V/CYbIs82xXYc00l0UGbiUr5KpRCtbZlnewipy1+7NzZ5Vh
	sJA8Z1F/EvZ0XUCCOsx3NsR5YZiwkrNHB5/O4KZXEJYxbwfWFqn8XoDb6g==
X-Gm-Gg: ASbGnctj1RnSBs3iU9sT2uk+MUG372+mSf1JWCaMrFCwoC9Qd9d76PEhxWvVO6xb/bT
	wQPzzK1yKtnkB2A7d3+cdN2EOIjztdtIl1o6srajk9BosK9A8OApo3XlXgQwyI94QOjAOuR2yNT
	qK8bQholCjGK6OczEOV/EiR9hETQtadHbTAiuH+yik/1l1hsNaLZfehk7hqThZ//8nz652PZxEA
	N/VqYPoJ1gWEY5WTn2u4YqxQe3X+SMACsBJ23Qz8kvggc6UtZ+B8WZDwIXhUBSc16+l932rABU6
	ij6O90J53ZDeuSCEVPzv4YZc5k35nXLJpPzbZEv/dPPVvwqfCXUBuC51mI9BPvEy73BBKoaUgui
	gg43okfSrkOE=
X-Google-Smtp-Source: AGHT+IE49iOIJPTTE9oMNCGcGnOzr0VgB8UeZCYifIXEz6AU6brr0ksW0YjcE0CNPzSzRtqt8nYp4A==
X-Received: by 2002:a05:6000:188b:b0:385:f2a2:50df with SMTP id ffacd0b85a97d-38c5195f498mr22051412f8f.27.1738672186780;
        Tue, 04 Feb 2025 04:29:46 -0800 (PST)
Received: from [192.168.0.18] (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c102d00sm15992316f8f.32.2025.02.04.04.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 04:29:46 -0800 (PST)
Message-ID: <59150228-6d24-4a54-b36e-9ecdfadd4e8e@gmail.com>
Date: Tue, 4 Feb 2025 12:29:45 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: implement setting global
 variables in veristat
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250203164002.128321-1-mykyta.yatsenko5@gmail.com>
 <9d42c86be3a8057054ffb1e7f7c6af09d5a5d767.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <9d42c86be3a8057054ffb1e7f7c6af09d5a5d767.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/02/2025 22:56, Eduard Zingerman wrote:
> On Mon, 2025-02-03 at 16:40 +0000, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> To better verify some complex BPF programs we'd like to preset global
>> variables.
>> This patch introduces CLI argument `--set-global-vars` to veristat, that
>> allows presetting values to global variables defined in BPF program. For
>> example:
>>
>> prog.c:
>> ```
>> enum Enum { ELEMENT1 = 0, ELEMENT2 = 5 };
>> const volatile __s64 a = 5;
>> const volatile __u8 b = 5;
>> const volatile enum Enum c = ELEMENT2;
>> const volatile bool d = false;
>>
>> char arr[4] = {0};
>>
>> SEC("tp_btf/sched_switch")
>> int BPF_PROG(...)
>> {
>> 	bpf_printk("%c\n", arr[a]);
>> 	bpf_printk("%c\n", arr[b]);
>> 	bpf_printk("%c\n", arr[c]);
>> 	bpf_printk("%c\n", arr[d]);
>> 	return 0;
>> }
>> ```
>> By default verification of the program fails:
>> ```
>> ./veristat prog.bpf.o
>> ```
>> By presetting global variables, we can make verification pass:
>> ```
>> ./veristat wq.bpf.o  --set-global-vars "a = 0; b = 1; c = 2; d = 3;"
>> ```
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> This is super useful, thank you!
> Maybe also add an ability to read variables list from a file?
> (e.g. using -g @file-name syntax as in -f).
>
> Worked fine for my small example, but failed to affect an object file
> with multiple programs, see below.
>
> Also, given that it is non-trivial to see if variable had indeed been set,
> I think it would be useful to add a selftest that does
> system("./veristat -l7 -v -g ...") and matches log output to check that
> values are set correctly, e.g. I used the following simple test:
>
> 	const volatile u8  _u8  = 0;
> 	const volatile u16 _u16 = 0;
> 	const volatile u32 _u32 = 0;
> 	const volatile u64 _u64 = 0;
> 	const volatile s8  _s8  = 0;
> 	const volatile s16 _s16 = 0;
> 	const volatile s32 _s32 = 0;
> 	const volatile s64 _s64 = 0;
>
> 	SEC("socket")
> 	int test_globals(void *ctx)
> 	{
> 		volatile unsigned long cnt;
> 		cnt = _u8;
> 		cnt = _u16;
> 		cnt = _u32;
> 		cnt = _u64;
> 		cnt = _s8;
> 		cnt = _s16;
> 		cnt = _s32;
> 		cnt = _s64;
> 		return cnt;
> 	}
>
>>   tools/testing/selftests/bpf/veristat.c | 189 +++++++++++++++++++++++++
>>   1 file changed, 189 insertions(+)
> [...]
>
>> @@ -1292,6 +1312,169 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>   	return 0;
>>   };
>>   
>> +static int parse_var_presets(char *expr, struct var_preset *presets, int capacity, int *size)
>> +{
>> +	char *state;
>> +	char *next;
>> +	int i = 0;
>> +
>> +	while ((next = strtok_r(i ? NULL : expr, ";", &state))) {
>> +		char *eq_ptr = strchr(next, '=');
>> +		char *name_ptr = next;
>> +		char *name_end = eq_ptr - 1;
>> +		char *val_ptr = eq_ptr + 1;
>> +
>> +		if (!eq_ptr)
>> +			continue;
> Nit: error message here?
>
>> +
>> +		if (i >= capacity) {
>> +			fprintf(stderr, "Too many global variable presets\n");
>> +			return -EINVAL;
>> +		}
>> +		while (isspace(*name_ptr))
>> +			++name_ptr;
>> +		while (isspace(*name_end))
>> +			--name_end;
>> +
>> +		*(name_end + 1) = '\0';
>> +		presets[i].name = strdup(name_ptr);
>> +		errno = 0;
>> +		presets[i].value = strtoll(val_ptr, NULL, 10);
> Nit: using base of 0 would allow to specify values either as decimals or in hex
>       (using '0x' prefix).
>
>> +		if (errno == ERANGE) {
>> +			errno = 0;
>> +			presets[i].value = strtoull(val_ptr, NULL, 10);
>> +		}
>> +		if (errno) {
>> +			fprintf(stderr, "Could not parse integer value %s\n", val_ptr);
>> +			return -EINVAL;
>> +		}
>> +		++i;
>> +	}
>> +	*size = i;
>> +	return 0;
>> +}
>> +
>> +static bool is_signed_type(const struct btf_type *type)
>> +{
>> +	if (btf_is_int(type))
> Nit: enums could be signed as well.
>
>> +		return btf_int_encoding(type) & BTF_INT_SIGNED;
>> +	return true;
>> +}
>> +
>> +static const struct btf_type *var_base_type(const struct btf *btf, const struct btf_type *type)
>> +{
>> +	switch (btf_kind(type)) {
>> +	case BTF_KIND_VAR:
>> +	case BTF_KIND_TYPE_TAG:
>> +	case BTF_KIND_CONST:
>> +	case BTF_KIND_VOLATILE:
>> +	case BTF_KIND_RESTRICT:
>> +	case BTF_KIND_TYPEDEF:
>> +	case BTF_KIND_DECL_TAG:
>> +		return var_base_type(btf, btf__type_by_id(btf, type->type));
>> +	}
>> +	return type;
>> +}
>> +
>> +static bool is_preset_supported(const struct btf_type *t)
>> +{
>> +	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
>> +}
>> +
>> +static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct btf_type *t,
>> +			  struct bpf_map *map, struct btf_var_secinfo *sinfo, long long new_val)
>> +{
>> +	const struct btf_type *base_type;
>> +	void *ptr;
>> +	size_t size;
>> +
>> +	base_type = var_base_type(btf, t);
>> +	if (!is_preset_supported(base_type)) {
>> +		fprintf(stderr, "Setting global variable for btf kind %d is not supported\n",
>> +			btf_kind(base_type));
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Check if value fits into the target variable size */
>> +	if  (sinfo->size < sizeof(new_val)) {
>> +		bool is_signed = is_signed_type(base_type);
>> +		__u32 unsigned_bits = sinfo->size * 8 - (is_signed ? 1 : 0);
>> +		long long max_val = 1ll << unsigned_bits;
>> +
>> +		if (new_val >= max_val || new_val < -max_val) {
>> +			fprintf(stderr,
>> +				"Variable %s value %lld is out of range [%lld; %lld]\n",
>> +				btf__name_by_offset(btf, t->name_off), new_val,
>> +				is_signed ? -max_val : 0, max_val - 1);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	ptr = (void *)bpf_map__initial_value(map, &size);
>> +	if (!ptr || (sinfo->offset + sinfo->size > size))
>> +		return -EINVAL;
>> +
>> +	memcpy(ptr + sinfo->offset, &new_val, sinfo->size);
> will this work for big endian?
>
>> +	return 0;
>> +}
>> +
>> +static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, int npresets)
>> +{
>> +	struct btf_var_secinfo *sinfo;
>> +	const char *sec_name;
>> +	const struct btf_type *type;
>> +	struct bpf_map *map;
>> +	struct btf *btf;
>> +	int i, j, k, n, cnt, err, preset_cnt = 0;
>> +
>> +	if (npresets == 0)
>> +		return 0;
>> +
>> +	btf = bpf_object__btf(obj);
>> +	if (!btf)
>> +		return -EINVAL;
>> +
>> +	cnt = btf__type_cnt(btf);
>> +	for (i  = 0; i != cnt; ++i) {
>> +		type = btf__type_by_id(btf, i);
>> +
>> +		if (!btf_is_datasec(type))
>> +			continue;
>> +
>> +		sinfo = btf_var_secinfos(type);
>> +		sec_name = btf__name_by_offset(btf, type->name_off);
>> +		map = bpf_object__find_map_by_name(obj, sec_name);
>> +		if (!map)
>> +			continue;
>> +
>> +		n = btf_vlen(type);
>> +		for (j = 0; j < n; ++j, ++sinfo) {
>> +			const struct btf_type *var_type = btf__type_by_id(btf, sinfo->type);
>> +			const char *var_name = btf__name_by_offset(btf, var_type->name_off);
>> +
>> +			if (!btf_is_var(var_type))
>> +				continue;
>> +
>> +			for (k = 0; k < npresets; ++k) {
>> +				if (strcmp(var_name, presets[k].name) != 0)
>> +					continue;
>> +
>> +				err = set_global_var(obj, btf, var_type, map, sinfo,
>> +						     presets[k].value);
>> +				if (err)
>> +					return err;
>> +
>> +				preset_cnt++;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +	if (preset_cnt != npresets)
>> +		fprintf(stderr, "Some global variable presets have not been applied\n");
> Nit: it would be nice to print which ones were not set.
>
>> +
>> +	return 0;
>> +}
>> +
>>   static int process_obj(const char *filename)
>>   {
>>   	const char *base_filename = basename(strdupa(filename));
>> @@ -1338,6 +1521,12 @@ static int process_obj(const char *filename)
>>   		prog_cnt++;
>>   	}
>>   
>> +	err = set_global_vars(obj, env.presets, env.npresets);
>> +	if (err) {
>> +		fprintf(stderr, "Failed to set global variables\n");
>> +		goto cleanup;
>> +	}
>> +
>>   	if (prog_cnt == 1) {
>>   		prog = bpf_object__next_program(obj, NULL);
>>   		bpf_program__set_autoload(prog, true);
> Same needs to happen for the loop below when prog_cnt != 1, e.g.:
>
> @@ -1544,6 +1544,12 @@ static int process_obj(const char *filename)
>                          goto cleanup;
>                  }
>   
> +               err = set_global_vars(tobj, env.presets, env.npresets);
> +               if (err) {
> +                       fprintf(stderr, "Failed to set global variables\n");
> +                       goto cleanup;
> +               }
> +
>                  lprog = NULL;
>                  bpf_object__for_each_program(tprog, tobj) {
>                          const char *tprog_name = bpf_program__name(tprog);
>
> Or, better yet, get rid of the `prog_cnt == 1` special case.
>
Thanks for the suggestions, make sense, going to address in v2.

