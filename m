Return-Path: <bpf+bounces-51153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C0FA30F3B
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 16:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8874C3A6E17
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 15:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28732512F0;
	Tue, 11 Feb 2025 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecr0dwEu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D224E4D7
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286438; cv=none; b=BUhD/0+QBZix6I88V5bZw+QfkEgXqXgE+OatQMNUUUuJeNEgjjdB9Ja2BC569BIKy3r+YxNMrjxtT3Uu4xv3bPhdrfl8OPdD1zNkmGwQyCdGKJjUW3sZTJ33VPOQ2GcIY8e08VUJxAxxnwvx7/Q9X0XINqkFg+LjLdly56d7muc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286438; c=relaxed/simple;
	bh=7vDGPDrU+wwM44tgR5Eghx64dEBGBDnwDv3MrwKWDbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efG1IcSAYv7p/r5w4fcO9CTM7DspDLJyfYNi+MotiqIqSnNhz9ogR9+/iIqyrt7sLXr849haNZ6TU4RiOCtB1g8OcrT58sslibTq2PhHGg9/mxyUpvybPUHDk/kNFaeGpaoI00Mbn7sdpWf476swPUr8XuFXBWkrkUP5s78yL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecr0dwEu; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so868374466b.1
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 07:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739286435; x=1739891235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhfQpxQruGxgcQ60W6WuYwuhoK3sqVbAHgVBF3Y6+Jk=;
        b=ecr0dwEufOJ6F/5QdobLDM5IgNTPWg1KHX8myRtg387OT0HlIj1nnukRH6ZJjC6cWE
         LBeiB4FdFA5Gfq93oNraQeVIIyNJXjJKRfA8sogqmZeRDvvHgJXIKMt/PVIfcZ0wu3mb
         6B8PpsfdZbJ6fVeLZHekgMEvRQ6B2Kn3U025gh44qTmVWTrF/v+c7v/1GdVqG5kai41D
         KU/fvTxR5bipR4/OJBz3wPSq3IhK9RZFEFdRJ6CrsT4OU9LNGP39GGDTtn9tkYhIhT1K
         PMZzTrS7yDkMWbhBgx+DqdNQ7CaabMmZo7R5vOxlBKRySuusxrhcTpk3uGO10jS4cPy0
         t33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739286435; x=1739891235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhfQpxQruGxgcQ60W6WuYwuhoK3sqVbAHgVBF3Y6+Jk=;
        b=IJnA9rwanaQUqM1JatTx5Y7V+8GaA9ykeLmBQhcLLoYag/DQ+hvxBf3fd2k7Z8LiUX
         uke+asX5hE8Ig6d7PSD7yEC44N0qWsovWC3nn9rH1Tid9nOcQixAmwtR84n1cusJ1r7l
         mMpm4VPhjiw+DBLMH4WnBsMxvPko/bYbIPr4vZXgHRmsjoJmiq5CWuzQZtwCqJ4a8O3K
         Amg0zSNTRW0osjzPMkEZkPLNKoqezmYu0XfUTwDLmVqkvVsJKN4ZbFBDaBPcUROg/7jt
         WxGZPF8iVo9LCAwZauAAgLixoIhVvWUTVLcUmBp1xVIk+m5vHy7UeSVfUrntrX98cTf+
         J0YA==
X-Forwarded-Encrypted: i=1; AJvYcCU/1egnBHIrlLid+eCEUoz9WLi1hcULVoAsb6A6TcFrDfJSXEf037UJUC665Hxwz8FRudI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYG6omF4ugWAqDuD2Eh3Q4U5EmBbi59T81t4/6Uv9gMy5hUR2V
	ZU6Vxuhx/s1Hn/Vs1/WxdZ2lTCsCHeUj3wTyrHM/eYJFgR2evoY5xub4IA==
X-Gm-Gg: ASbGncudVMQiFgzqDpE9W4ogvPW2OfdGOYC4/zyiTcMqLYiBxSYeuQz8saA8trSdprt
	mtF2YvKFsEx3yV+Fwhx8W3RflHAaCgHj1ykxycMtsMCqTkSYnNl72DnP52t+w1Dj/ragx6X68BB
	4ZEX8u0MARBoYMhNFtQZmoABDZthZp0eu+dDr/KM8Vsv/rknFj+KzP9FaPqKpr9CRKdNKeZSmp7
	TNuKdYJXbd+anouokO4F/4UAzuTuxmut852AwglklEh8BuBNPRTxMIrHSCoZ/eGudCAUXcbFHmY
	98XQihBeaUR9N2CNUgN0MJWe4uM0yk5+q0cPe6zc/8l1TKoLwCbt
X-Google-Smtp-Source: AGHT+IFPlhSu121uuuTspN9fgL8PVQ2oXO4nCcLf1hTwJSKhrZecX5PDmLpQnJ1t3V8CylE1QG4oKQ==
X-Received: by 2002:a17:907:7215:b0:ab7:b5d6:2696 with SMTP id a640c23a62f3a-ab7b5d62d8amr1074024566b.32.1739286433892;
        Tue, 11 Feb 2025 07:07:13 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:3:8dd1:e06e:70b9:d7dc? ([2620:10d:c092:500::4:1255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7c264f1desm421272966b.146.2025.02.11.07.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 07:07:13 -0800 (PST)
Message-ID: <d5eb6223-973a-4784-bee3-98cc2b3fa63f@gmail.com>
Date: Tue, 11 Feb 2025 15:07:11 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: implement setting global
 variables in veristat
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250210135129.719119-1-mykyta.yatsenko5@gmail.com>
 <20250210135129.719119-2-mykyta.yatsenko5@gmail.com>
 <5d89c59467645cbb6d9a38a4ab52c7f7e614ec48.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <5d89c59467645cbb6d9a38a4ab52c7f7e614ec48.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/02/2025 01:24, Eduard Zingerman wrote:
> On Mon, 2025-02-10 at 13:51 +0000, Mykyta Yatsenko wrote:
>
> [...]
>
>> @@ -363,6 +378,24 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>>   			return -ENOMEM;
>>   		env.filename_cnt++;
>>   		break;
>> +	case 'G': {
>> +		static int presets_cap;
>> +		char *expr = strdup(arg);
>> +
>> +		if (expr[0] == '@') {
>> +			if (parse_var_presets_from_file(expr + 1, &env.presets,
>> +							&presets_cap, &env.npresets)) {
> Nit: I'd modify 'env' directly in parse_var_presets{,_from_file} and
>       add presets_cap field to 'env': to avoid static variable and to
>       avoid '(*presets)[*size].name = ...' below.
>
>> +				fprintf(stderr, "Could not parse global variables preset: %s\n",
>> +					arg);
>> +				argp_usage(state);
>> +			}
>> +		} else if (parse_var_presets(expr, &env.presets, &presets_cap, &env.npresets)) {
>> +			fprintf(stderr, "Could not parse global variables preset: %s\n", arg);
>> +			argp_usage(state);
>> +		}
>> +		free(expr);
>> +		break;
>> +	}
>>   	default:
>>   		return ARGP_ERR_UNKNOWN;
>>   	}
>> @@ -1292,6 +1325,273 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>   	return 0;
>>   };
>>   
>> +static int parse_var_presets(char *expr, struct var_preset **presets, int *capacity, int *size)
>> +{
>> +	char *eq_ptr = strchr(expr, '=');
>> +	char *name_ptr = expr;
>> +	char *name_end = eq_ptr - 1;
>> +	char *val_ptr = eq_ptr + 1;
>> +	long long value;
>> +
>> +	if (!eq_ptr) {
>> +		fprintf(stderr, "No assignment in expression\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	while (isspace(*name_ptr))
>> +		++name_ptr;
>> +	while (isspace(*name_end))
>> +		--name_end;
> I think this loop has to be capped by string start check,
> otherwise for -G ' = 10' it might read some uninitialized memory.
>
>> +	while (isspace(*val_ptr))
>> +		++val_ptr;
>> +
>> +	if (name_ptr > name_end) {
>> +		fprintf(stderr, "Empty variable name in expression %s\n", expr);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (*size >= *capacity) {
>> +		*capacity = max(*capacity * 2, 1);
>> +		*presets = realloc(*presets, *capacity * sizeof(**presets));
> Nit: if realloc() fails it returns NULL,
>       so the pointer to older *presets would be lost and never freed
>       (but we exit the program in case of an error, so not really an issue).
>       Also, check for NULL and return -ENOMEM?
>
>> +	}
>> +
>> +	if (isalpha(*val_ptr)) {
>> +		char *value_end = val_ptr + strlen(val_ptr) - 1;
>> +
>> +		while (isspace(*value_end))
>> +			--value_end;
>> +		*(value_end + 1) = '\0';
>> +
>> +		(*presets)[*size].svalue = strdup(val_ptr);
> Silly question, why strdup here and for .name?
> Keeping pointers to argv should be fine as far as I know.
Right, It seems like I don't really need to make this copy. Although, 
I'm going to follow up what
Andrii suggested and use sscanf, in that case copy will be needed.
>> +		(*presets)[*size].type = NAME;
>> +	} else if (*val_ptr == '-' || isdigit(*val_ptr)) {
>> +		errno = 0;
>> +		value = strtoll(val_ptr, NULL, 0);
>> +		if (errno == ERANGE) {
>> +			errno = 0;
>> +			value = strtoull(val_ptr, NULL, 0);
>> +		}
>> +		(*presets)[*size].ivalue = value;
>> +		(*presets)[*size].type = INTEGRAL;
>> +		if (errno) {
>> +			fprintf(stderr, "Could not parse integer value %s\n", val_ptr);
>> +			return -EINVAL;
>> +		}
>> +	} else {
>> +		fprintf(stderr, "Could not parse value %s\n", val_ptr);
>> +		return -EINVAL;
>> +	}
>> +	*(name_end + 1) = '\0';
>> +	(*presets)[*size].name = strdup(name_ptr);
>> +	(*size)++;
>> +	return 0;
>> +}
>> +
>> +static int parse_var_presets_from_file(const char *filename, struct var_preset **presets,
>> +				       int *capacity, int *size)
> Thank you for adding this!
>
>> +{
>> +	FILE *f;
>> +	char line[256];
>> +	int err = 0;
>> +
>> +	f = fopen(filename, "rt");
>> +	if (!f) {
>> +		fprintf(stderr, "Could not open file %s\n", filename);
>> +		return -EINVAL;
>> +	}
>> +
>> +	while (fgets(line, sizeof(line), f)) {
>> +		int err = parse_var_presets(line, presets, capacity, size);
>> +
>> +		if (err)
>> +			goto cleanup;
>> +	}
>> +
>> +cleanup:
> Nit: I'd check for ferror(f) and write something to stderr here.
>
>> +	fclose(f);
>> +	return err;
>> +}
>> +
>> +static bool is_signed_type(const struct btf_type *t)
>> +{
>> +	if (btf_is_int(t))
>> +		return btf_int_encoding(t) & BTF_INT_SIGNED;
>> +	if (btf_is_enum(t))
>> +		return btf_kflag(t);
>> +	return true;
>> +}
> [...]
>
>> +static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, int npresets)
>> +{
>> +	struct btf_var_secinfo *sinfo;
>> +	const char *sec_name;
>> +	const struct btf_type *type;
>> +	struct bpf_map *map;
>> +	struct btf *btf;
>> +	bool *set_var;
>> +	int i, j, k, n, cnt, err = 0;
>> +
>> +	if (npresets == 0)
>> +		return 0;
>> +
>> +	btf = bpf_object__btf(obj);
>> +	if (!btf)
>> +		return -EINVAL;
>> +
>> +	set_var = calloc(npresets, sizeof(bool));
>> +	for (i = 0; i < npresets; ++i)
>> +		set_var[i] = false;
> As Andrii writes in a sibling thread, I'd keep this flag in the
> 'struct var_preset'.
>
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
>> +				if (set_var[k]) {
>> +					fprintf(stderr, "Variable %s is set more than once",
>> +						var_name);
>> +				}
>> +
>> +				err = set_global_var(obj, btf, var_type, map, sinfo, presets + k);
>> +				if (err)
>> +					goto out;
>> +
>> +				set_var[k] = true;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +	for (i = 0; i < npresets; ++i) {
>> +		if (!set_var[i]) {
>> +			fprintf(stderr, "Global variable preset %s has not been applied\n",
>> +				presets[i].name);
>> +		}
>> +	}
>> +out:
>> +	free(set_var);
>> +	return err;
>> +}
>> +
> [...]
>
Thanks, I'll apply your suggestions in v3.

