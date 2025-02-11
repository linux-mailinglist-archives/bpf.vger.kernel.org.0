Return-Path: <bpf+bounces-51089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615A7A30009
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 02:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0306D3A25AE
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D71A194141;
	Tue, 11 Feb 2025 01:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJlUK1UQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2DD5223
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237097; cv=none; b=f2aWDKxYvqQKf8pMYSFzrhfUsiCAeEGyU7HRm1/mQNo3AQu11SRp93Ewq3eFL5g9o8t7eTA0UtIbUCc3FgGCxx2DHQG2mq0wxMuE1ukHz7geyjmtum3HHRRxbVsBPMRO2Q3A+1nTpBkL0ogqUatGdvNJxzes1ACeX0kafz9Tcug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237097; c=relaxed/simple;
	bh=AUm0EQNCbfMbPnAKYOSKfF3BsU8FVAckDZYz0rwAYtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LOZCN+YEYjeCXQsP9q8GqHZpkeLXntCi3IkDXxv0h/It5hLqOAiKhxxdQNX78xCXZaptbOyDqKC0hV/6aTV7goTt9xBxvfITZln82MsyzIgc2FaHQ/wVC1R+Ys4dQ4+KyUbVgiqmqF8r88TclrEgVq0oVG2JHqDi1vYiu8LIQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJlUK1UQ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa7465baceso3166269a91.0
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 17:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739237094; x=1739841894; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X+lMk424LmHa5R0I7Hr/MSEa2RGlFTZ2njVqLUsVJeo=;
        b=FJlUK1UQiA+WzbTBf7mDNOano1+alFAqNXWtzC7Xi35+/5ugfYYPgLs7ue69U8Z3jq
         D0CtPUcucJ7457/7wsQdgFEZBJop+LkQWAIkMK2w5E8FGEhDpU3mcRKyXVVmrFRIEDJ0
         hb1+t+tdTS+Gk4fPnE6yggN9fA6xragylZy4SOnBaSGWBxqSLJSYjHbf5/1eMnFq+G1V
         uFs4vWCriIZOtY/MbW0Tqhj3Iyx3dqwDjNxhDM7hAG9d5lAMG6/VtJ2YZ1mJlkhOhiRN
         BW9AlhZAiX8neqoUbGXpD0k+vCCKbYSh9f6rHJQ5oS7+plmAPXP1T3Pc4Y2b3TZvT45H
         EJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739237094; x=1739841894;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+lMk424LmHa5R0I7Hr/MSEa2RGlFTZ2njVqLUsVJeo=;
        b=nUmu56n+lKXhokUIyAzIgcOpISRSFA8zdKqlxOA95V5UYb3Wyuh/atF4lMX4FbupNC
         SKdqfjZVY72CzWsSAdc0dml5+W8NO4tEVj56007Y3D4RatR59pU0/XMwzxv6/6PE40Fi
         +T9hpwCN5+63gFxA1u+4tpv00st6p7XGXK5u4BWxsiDgNEA0YvUUiVK0BiBSk0ZY5lqs
         woGEWE+5Z43ZL2YUtgMMxD/ukNe62VYfAt6ZECvw2K/d7hmj1r2S6nKpM5u2ge2HQ2hX
         AeWpgqjbBbSU5CSy6RvxBK5c3V9yREQ4tz27IVca3KVQPZ+YbyXloJMjRa8vIfpaa9hO
         QZyA==
X-Forwarded-Encrypted: i=1; AJvYcCVSDELD9q87/5eabiC/zdbwZq3PYfObGleAdn3pCakj+r6V0Qd08RLsZfPcNWzfzkW6Y7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh5T9dOZ3I9fOjTti4GAxwryEz+3mUN91BtrfGig8aYegcjIRO
	RuRY/Av1XksWK2i8sU6J+Syx6c7i0ESkVzxnYbBxPLnSF/py/yR3BHup8zJh
X-Gm-Gg: ASbGncv3NJXAaUrArlG2NW/5n8TTcD/z4isTI+T6PfbUufuFsWaRXcXCIF/4EbyjsOV
	Zmrta5CjdAncH4+yJrDz9ouaUKRB7DB3W4XT7iwWIwJ1jq+pECA4DNSjQfkCouSK/TT4hu7e6yf
	rHiJFRSgWVmqUAIWvP1eIP7Qyx0DmZEfImeUH+PziPBHMccVSelGfIeHvSgPbLt5tTS2XY2RGBc
	PlSlrNHJCQC6V7drvvL99YGylybSM3fn19y2x227nbSJerVPnFaXTScHL4E6aXkzfUB0UJ1kPMd
	WU/g2RXhL1TU
X-Google-Smtp-Source: AGHT+IGUG1xi4GQErf6yUgXD5Z4cU5c+mm/VOJXN2w1horecfOx71+H3OFrlALvAwaxBGkfZ9aWeSA==
X-Received: by 2002:a05:6a00:b42:b0:730:937f:e835 with SMTP id d2e1a72fcca58-730937feb2bmr7012907b3a.17.1739237094501;
        Mon, 10 Feb 2025 17:24:54 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730764c4b51sm4934197b3a.55.2025.02.10.17.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 17:24:54 -0800 (PST)
Message-ID: <5d89c59467645cbb6d9a38a4ab52c7f7e614ec48.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: implement setting global
 variables in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 10 Feb 2025 17:24:48 -0800
In-Reply-To: <20250210135129.719119-2-mykyta.yatsenko5@gmail.com>
References: <20250210135129.719119-1-mykyta.yatsenko5@gmail.com>
	 <20250210135129.719119-2-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-10 at 13:51 +0000, Mykyta Yatsenko wrote:

[...]

> @@ -363,6 +378,24 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
>  			return -ENOMEM;
>  		env.filename_cnt++;
>  		break;
> +	case 'G': {
> +		static int presets_cap;
> +		char *expr =3D strdup(arg);
> +
> +		if (expr[0] =3D=3D '@') {
> +			if (parse_var_presets_from_file(expr + 1, &env.presets,
> +							&presets_cap, &env.npresets)) {

Nit: I'd modify 'env' directly in parse_var_presets{,_from_file} and
     add presets_cap field to 'env': to avoid static variable and to
     avoid '(*presets)[*size].name =3D ...' below.

> +				fprintf(stderr, "Could not parse global variables preset: %s\n",
> +					arg);
> +				argp_usage(state);
> +			}
> +		} else if (parse_var_presets(expr, &env.presets, &presets_cap, &env.np=
resets)) {
> +			fprintf(stderr, "Could not parse global variables preset: %s\n", arg)=
;
> +			argp_usage(state);
> +		}
> +		free(expr);
> +		break;
> +	}
>  	default:
>  		return ARGP_ERR_UNKNOWN;
>  	}
> @@ -1292,6 +1325,273 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
>  	return 0;
>  };
> =20
> +static int parse_var_presets(char *expr, struct var_preset **presets, in=
t *capacity, int *size)
> +{
> +	char *eq_ptr =3D strchr(expr, '=3D');
> +	char *name_ptr =3D expr;
> +	char *name_end =3D eq_ptr - 1;
> +	char *val_ptr =3D eq_ptr + 1;
> +	long long value;
> +
> +	if (!eq_ptr) {
> +		fprintf(stderr, "No assignment in expression\n");
> +		return -EINVAL;
> +	}
> +
> +	while (isspace(*name_ptr))
> +		++name_ptr;
> +	while (isspace(*name_end))
> +		--name_end;

I think this loop has to be capped by string start check,
otherwise for -G ' =3D 10' it might read some uninitialized memory.

> +	while (isspace(*val_ptr))
> +		++val_ptr;
> +
> +	if (name_ptr > name_end) {
> +		fprintf(stderr, "Empty variable name in expression %s\n", expr);
> +		return -EINVAL;
> +	}
> +
> +	if (*size >=3D *capacity) {
> +		*capacity =3D max(*capacity * 2, 1);
> +		*presets =3D realloc(*presets, *capacity * sizeof(**presets));

Nit: if realloc() fails it returns NULL,
     so the pointer to older *presets would be lost and never freed
     (but we exit the program in case of an error, so not really an issue).
     Also, check for NULL and return -ENOMEM?

> +	}
> +
> +	if (isalpha(*val_ptr)) {
> +		char *value_end =3D val_ptr + strlen(val_ptr) - 1;
> +
> +		while (isspace(*value_end))
> +			--value_end;
> +		*(value_end + 1) =3D '\0';
> +
> +		(*presets)[*size].svalue =3D strdup(val_ptr);

Silly question, why strdup here and for .name?
Keeping pointers to argv should be fine as far as I know.

> +		(*presets)[*size].type =3D NAME;
> +	} else if (*val_ptr =3D=3D '-' || isdigit(*val_ptr)) {
> +		errno =3D 0;
> +		value =3D strtoll(val_ptr, NULL, 0);
> +		if (errno =3D=3D ERANGE) {
> +			errno =3D 0;
> +			value =3D strtoull(val_ptr, NULL, 0);
> +		}
> +		(*presets)[*size].ivalue =3D value;
> +		(*presets)[*size].type =3D INTEGRAL;
> +		if (errno) {
> +			fprintf(stderr, "Could not parse integer value %s\n", val_ptr);
> +			return -EINVAL;
> +		}
> +	} else {
> +		fprintf(stderr, "Could not parse value %s\n", val_ptr);
> +		return -EINVAL;
> +	}
> +	*(name_end + 1) =3D '\0';
> +	(*presets)[*size].name =3D strdup(name_ptr);
> +	(*size)++;
> +	return 0;
> +}
> +
> +static int parse_var_presets_from_file(const char *filename, struct var_=
preset **presets,
> +				       int *capacity, int *size)

Thank you for adding this!

> +{
> +	FILE *f;
> +	char line[256];
> +	int err =3D 0;
> +
> +	f =3D fopen(filename, "rt");
> +	if (!f) {
> +		fprintf(stderr, "Could not open file %s\n", filename);
> +		return -EINVAL;
> +	}
> +
> +	while (fgets(line, sizeof(line), f)) {
> +		int err =3D parse_var_presets(line, presets, capacity, size);
> +
> +		if (err)
> +			goto cleanup;
> +	}
> +
> +cleanup:

Nit: I'd check for ferror(f) and write something to stderr here.

> +	fclose(f);
> +	return err;
> +}
> +
> +static bool is_signed_type(const struct btf_type *t)
> +{
> +	if (btf_is_int(t))
> +		return btf_int_encoding(t) & BTF_INT_SIGNED;
> +	if (btf_is_enum(t))
> +		return btf_kflag(t);
> +	return true;
> +}

[...]

> +static int set_global_vars(struct bpf_object *obj, struct var_preset *pr=
esets, int npresets)
> +{
> +	struct btf_var_secinfo *sinfo;
> +	const char *sec_name;
> +	const struct btf_type *type;
> +	struct bpf_map *map;
> +	struct btf *btf;
> +	bool *set_var;
> +	int i, j, k, n, cnt, err =3D 0;
> +
> +	if (npresets =3D=3D 0)
> +		return 0;
> +
> +	btf =3D bpf_object__btf(obj);
> +	if (!btf)
> +		return -EINVAL;
> +
> +	set_var =3D calloc(npresets, sizeof(bool));
> +	for (i =3D 0; i < npresets; ++i)
> +		set_var[i] =3D false;

As Andrii writes in a sibling thread, I'd keep this flag in the
'struct var_preset'.

> +
> +	cnt =3D btf__type_cnt(btf);
> +	for (i  =3D 0; i !=3D cnt; ++i) {
> +		type =3D btf__type_by_id(btf, i);
> +
> +		if (!btf_is_datasec(type))
> +			continue;
> +
> +		sinfo =3D btf_var_secinfos(type);
> +		sec_name =3D btf__name_by_offset(btf, type->name_off);
> +		map =3D bpf_object__find_map_by_name(obj, sec_name);
> +		if (!map)
> +			continue;
> +
> +		n =3D btf_vlen(type);
> +		for (j =3D 0; j < n; ++j, ++sinfo) {
> +			const struct btf_type *var_type =3D btf__type_by_id(btf, sinfo->type)=
;
> +			const char *var_name =3D btf__name_by_offset(btf, var_type->name_off)=
;
> +
> +			if (!btf_is_var(var_type))
> +				continue;
> +
> +			for (k =3D 0; k < npresets; ++k) {
> +				if (strcmp(var_name, presets[k].name) !=3D 0)
> +					continue;
> +
> +				if (set_var[k]) {
> +					fprintf(stderr, "Variable %s is set more than once",
> +						var_name);
> +				}
> +
> +				err =3D set_global_var(obj, btf, var_type, map, sinfo, presets + k);
> +				if (err)
> +					goto out;
> +
> +				set_var[k] =3D true;
> +				break;
> +			}
> +		}
> +	}
> +	for (i =3D 0; i < npresets; ++i) {
> +		if (!set_var[i]) {
> +			fprintf(stderr, "Global variable preset %s has not been applied\n",
> +				presets[i].name);
> +		}
> +	}
> +out:
> +	free(set_var);
> +	return err;
> +}
> +

[...]


