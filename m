Return-Path: <bpf+bounces-50329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E8A2672F
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 23:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D5B3A5069
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 22:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4BE211283;
	Mon,  3 Feb 2025 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAmiJFK3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1053A1D5CD4
	for <bpf@vger.kernel.org>; Mon,  3 Feb 2025 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623384; cv=none; b=ECXf+uKZX+p0BgVTvfvOXnKqUp/0NPiokuTR/IY8pFoPZOtdL/yTIOox2ZuumriS/PQpRAjWP0FsA7Ng0Ke2Bks9u7cgn45/sYmKm7W2ujkGItgrABoo6p1BcjE0wqjapXGholR9JBW/fzL9x3qcUO94x85AkgEPA4LQGHGwmNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623384; c=relaxed/simple;
	bh=NLN0srcSPinVGVvzXNISS+XcCDHOS8uMfr4guIqK9Uc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AO4eml687nKJWlUo0ISMJLu2oqTJEGj1u0HDN7RiBGjcSIeaGRUjBT4Xo3WP+EDurB+4vpUcyipHj0cUj0yVNvtbCZI6iuXVAvAI8EmxSnBg4ygv3XlNdzDhMMMtRKJFLg9M64ICGwAueyVZpwGZkWKOdOhfNQyp+DzQePZ2kdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAmiJFK3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so9158972a91.0
        for <bpf@vger.kernel.org>; Mon, 03 Feb 2025 14:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738623382; x=1739228182; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YfcGao7tbqYm4yYrAWnH40UCh/sD4BcXTzPq0hZJ+EY=;
        b=LAmiJFK3esxImCHBmiefzWD29YcM26SCOn1H9wpuCmUiIUVAweDNOPh57BkQYzy75h
         TYfgZuE+Rfy1Sfx5sj91z7NjOIlsetFpiKXwsDhuoEjlGwQaBDZJbfEVTbsHvRSlzkBT
         awHKHNOeinxA56AHUw2BhHUFS3J6kzlHFJUW5IYBtXzOkBgGhq8WlEg0Z1KCzt8vJC1q
         RMfRVTK7mm9C9pY6I7hk8MbNKOAIbJT6jr5r8lD0fGA3R0f/YXimJcLIaWWsnpFvok1S
         tm3U6TbWS5lhrpkhuN1OKeCGWUnqpBcpB3Wt6x7eDFs1t/4i50w6rKynRnpe0qqOnUvm
         poFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738623382; x=1739228182;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfcGao7tbqYm4yYrAWnH40UCh/sD4BcXTzPq0hZJ+EY=;
        b=PnHXtwTQ7I6Hr0Gwx9rCsytvDLnNCmMnIYOfiL5ydxCHYaZrfnmLeLkwSrL3fYTynK
         0aL+MdW3XbafK48xdwKI6NjlLyridkKBpvCs3CtG7gQgWJlG2nhlVc9OB2DHoj2QP/mS
         3TteW7/iEv1taqEpbzoUAAmO+3U5CEqNpztJXZUQzIkzuDca0zZaYitVfPKehPuezcIU
         VnF6kzWLfofP6VBGMg4H7TA04g5H3AACov/eHwuAvlo0838c/XGAt1jYvBK53Ang08Qq
         3Uv2702WQkXMLBakSyKe0tSaGus8oVox2ynRdM3tZ05C/GLG/yZXPIKXDSCiYGZoDPyh
         kbUw==
X-Forwarded-Encrypted: i=1; AJvYcCVPbwARimkCn4bgLT4oxprVIZRvfCgTc5aWHEkHj8lKjlJFK9an/nAQ45MoZGtLB8p4b2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyINk9OhBywzP84qxe/FrFt07I5MVVC5S8qlaAYzyWmSRaJdYOS
	Zwnno/mnmQWzoUpzY17MhOI7pV8oysiekwn2TXVq6SfJBhV3vOPo
X-Gm-Gg: ASbGncvamvfm8q0rzmGUy5LL8Bm8PK/LTv2VF4WlZzsIYePb+xbAXnunh16AW0Ssl2L
	89yWgjmSaRABp+w3/LohTXcw2+L+tuI4SW+/mjMi5kGQiSfuTaDG0R/Nu0JubHnXQmPkuf2bW6Q
	AjfrN2Xnf33YuOQVGrgfao3bs1/82U+0DqWL27mQyUMgEFf6pseyuU3TrIxugzeZmgmL0BAYp2I
	t+V2hds38R0GqjvCNR/LOfAoynHS6bZVVQLz77sCv6+5VJxoBTGT1Jt0BeoMfSfFRqN5mJwG4du
	KoNDOwn1l9Vy
X-Google-Smtp-Source: AGHT+IFM4kiOmYu6Ep6Qlo25qUCwbRAI1Do4SVaMNtc71y/2llo9cTzWNQgho9kfYpCNpth5ZiFAtg==
X-Received: by 2002:a17:90b:2dc7:b0:2f2:e905:d5ff with SMTP id 98e67ed59e1d1-2f9ba227090mr1706122a91.6.1738623382151;
        Mon, 03 Feb 2025 14:56:22 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bc97d95sm13200041a91.8.2025.02.03.14.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:56:21 -0800 (PST)
Message-ID: <9d42c86be3a8057054ffb1e7f7c6af09d5a5d767.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: implement setting global
 variables in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 03 Feb 2025 14:56:16 -0800
In-Reply-To: <20250203164002.128321-1-mykyta.yatsenko5@gmail.com>
References: <20250203164002.128321-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-03 at 16:40 +0000, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> To better verify some complex BPF programs we'd like to preset global
> variables.
> This patch introduces CLI argument `--set-global-vars` to veristat, that
> allows presetting values to global variables defined in BPF program. For
> example:
>=20
> prog.c:
> ```
> enum Enum { ELEMENT1 =3D 0, ELEMENT2 =3D 5 };
> const volatile __s64 a =3D 5;
> const volatile __u8 b =3D 5;
> const volatile enum Enum c =3D ELEMENT2;
> const volatile bool d =3D false;
>=20
> char arr[4] =3D {0};
>=20
> SEC("tp_btf/sched_switch")
> int BPF_PROG(...)
> {
> 	bpf_printk("%c\n", arr[a]);
> 	bpf_printk("%c\n", arr[b]);
> 	bpf_printk("%c\n", arr[c]);
> 	bpf_printk("%c\n", arr[d]);
> 	return 0;
> }
> ```
> By default verification of the program fails:
> ```
> ./veristat prog.bpf.o
> ```
> By presetting global variables, we can make verification pass:
> ```
> ./veristat wq.bpf.o  --set-global-vars "a =3D 0; b =3D 1; c =3D 2; d =3D =
3;"
> ```
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

This is super useful, thank you!
Maybe also add an ability to read variables list from a file?
(e.g. using -g @file-name syntax as in -f).

Worked fine for my small example, but failed to affect an object file
with multiple programs, see below.

Also, given that it is non-trivial to see if variable had indeed been set,
I think it would be useful to add a selftest that does
system("./veristat -l7 -v -g ...") and matches log output to check that
values are set correctly, e.g. I used the following simple test:

	const volatile u8  _u8  =3D 0;
	const volatile u16 _u16 =3D 0;
	const volatile u32 _u32 =3D 0;
	const volatile u64 _u64 =3D 0;
	const volatile s8  _s8  =3D 0;
	const volatile s16 _s16 =3D 0;
	const volatile s32 _s32 =3D 0;
	const volatile s64 _s64 =3D 0;

	SEC("socket")
	int test_globals(void *ctx)
	{
		volatile unsigned long cnt;
		cnt =3D _u8;
		cnt =3D _u16;
		cnt =3D _u32;
		cnt =3D _u64;
		cnt =3D _s8;
		cnt =3D _s16;
		cnt =3D _s32;
		cnt =3D _s64;
		return cnt;
	}

>  tools/testing/selftests/bpf/veristat.c | 189 +++++++++++++++++++++++++
>  1 file changed, 189 insertions(+)

[...]

> @@ -1292,6 +1312,169 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
>  	return 0;
>  };
> =20
> +static int parse_var_presets(char *expr, struct var_preset *presets, int=
 capacity, int *size)
> +{
> +	char *state;
> +	char *next;
> +	int i =3D 0;
> +
> +	while ((next =3D strtok_r(i ? NULL : expr, ";", &state))) {
> +		char *eq_ptr =3D strchr(next, '=3D');
> +		char *name_ptr =3D next;
> +		char *name_end =3D eq_ptr - 1;
> +		char *val_ptr =3D eq_ptr + 1;
> +
> +		if (!eq_ptr)
> +			continue;

Nit: error message here?

> +
> +		if (i >=3D capacity) {
> +			fprintf(stderr, "Too many global variable presets\n");
> +			return -EINVAL;
> +		}
> +		while (isspace(*name_ptr))
> +			++name_ptr;
> +		while (isspace(*name_end))
> +			--name_end;
> +
> +		*(name_end + 1) =3D '\0';
> +		presets[i].name =3D strdup(name_ptr);
> +		errno =3D 0;
> +		presets[i].value =3D strtoll(val_ptr, NULL, 10);

Nit: using base of 0 would allow to specify values either as decimals or in=
 hex
     (using '0x' prefix).

> +		if (errno =3D=3D ERANGE) {
> +			errno =3D 0;
> +			presets[i].value =3D strtoull(val_ptr, NULL, 10);
> +		}
> +		if (errno) {
> +			fprintf(stderr, "Could not parse integer value %s\n", val_ptr);
> +			return -EINVAL;
> +		}
> +		++i;
> +	}
> +	*size =3D i;
> +	return 0;
> +}
> +
> +static bool is_signed_type(const struct btf_type *type)
> +{
> +	if (btf_is_int(type))

Nit: enums could be signed as well.

> +		return btf_int_encoding(type) & BTF_INT_SIGNED;
> +	return true;
> +}
> +
> +static const struct btf_type *var_base_type(const struct btf *btf, const=
 struct btf_type *type)
> +{
> +	switch (btf_kind(type)) {
> +	case BTF_KIND_VAR:
> +	case BTF_KIND_TYPE_TAG:
> +	case BTF_KIND_CONST:
> +	case BTF_KIND_VOLATILE:
> +	case BTF_KIND_RESTRICT:
> +	case BTF_KIND_TYPEDEF:
> +	case BTF_KIND_DECL_TAG:
> +		return var_base_type(btf, btf__type_by_id(btf, type->type));
> +	}
> +	return type;
> +}
> +
> +static bool is_preset_supported(const struct btf_type *t)
> +{
> +	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
> +}
> +
> +static int set_global_var(struct bpf_object *obj, struct btf *btf, const=
 struct btf_type *t,
> +			  struct bpf_map *map, struct btf_var_secinfo *sinfo, long long new_v=
al)
> +{
> +	const struct btf_type *base_type;
> +	void *ptr;
> +	size_t size;
> +
> +	base_type =3D var_base_type(btf, t);
> +	if (!is_preset_supported(base_type)) {
> +		fprintf(stderr, "Setting global variable for btf kind %d is not suppor=
ted\n",
> +			btf_kind(base_type));
> +		return -EINVAL;
> +	}
> +
> +	/* Check if value fits into the target variable size */
> +	if  (sinfo->size < sizeof(new_val)) {
> +		bool is_signed =3D is_signed_type(base_type);
> +		__u32 unsigned_bits =3D sinfo->size * 8 - (is_signed ? 1 : 0);
> +		long long max_val =3D 1ll << unsigned_bits;
> +
> +		if (new_val >=3D max_val || new_val < -max_val) {
> +			fprintf(stderr,
> +				"Variable %s value %lld is out of range [%lld; %lld]\n",
> +				btf__name_by_offset(btf, t->name_off), new_val,
> +				is_signed ? -max_val : 0, max_val - 1);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	ptr =3D (void *)bpf_map__initial_value(map, &size);
> +	if (!ptr || (sinfo->offset + sinfo->size > size))
> +		return -EINVAL;
> +
> +	memcpy(ptr + sinfo->offset, &new_val, sinfo->size);

will this work for big endian?

> +	return 0;
> +}
> +
> +static int set_global_vars(struct bpf_object *obj, struct var_preset *pr=
esets, int npresets)
> +{
> +	struct btf_var_secinfo *sinfo;
> +	const char *sec_name;
> +	const struct btf_type *type;
> +	struct bpf_map *map;
> +	struct btf *btf;
> +	int i, j, k, n, cnt, err, preset_cnt =3D 0;
> +
> +	if (npresets =3D=3D 0)
> +		return 0;
> +
> +	btf =3D bpf_object__btf(obj);
> +	if (!btf)
> +		return -EINVAL;
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
> +				err =3D set_global_var(obj, btf, var_type, map, sinfo,
> +						     presets[k].value);
> +				if (err)
> +					return err;
> +
> +				preset_cnt++;
> +				break;
> +			}
> +		}
> +	}
> +	if (preset_cnt !=3D npresets)
> +		fprintf(stderr, "Some global variable presets have not been applied\n"=
);

Nit: it would be nice to print which ones were not set.

> +
> +	return 0;
> +}
> +
>  static int process_obj(const char *filename)
>  {
>  	const char *base_filename =3D basename(strdupa(filename));
> @@ -1338,6 +1521,12 @@ static int process_obj(const char *filename)
>  		prog_cnt++;
>  	}
> =20
> +	err =3D set_global_vars(obj, env.presets, env.npresets);
> +	if (err) {
> +		fprintf(stderr, "Failed to set global variables\n");
> +		goto cleanup;
> +	}
> +
>  	if (prog_cnt =3D=3D 1) {
>  		prog =3D bpf_object__next_program(obj, NULL);
>  		bpf_program__set_autoload(prog, true);

Same needs to happen for the loop below when prog_cnt !=3D 1, e.g.:

@@ -1544,6 +1544,12 @@ static int process_obj(const char *filename)
                        goto cleanup;
                }
=20
+               err =3D set_global_vars(tobj, env.presets, env.npresets);
+               if (err) {
+                       fprintf(stderr, "Failed to set global variables\n")=
;
+                       goto cleanup;
+               }
+
                lprog =3D NULL;
                bpf_object__for_each_program(tprog, tobj) {
                        const char *tprog_name =3D bpf_program__name(tprog)=
;

Or, better yet, get rid of the `prog_cnt =3D=3D 1` special case.



