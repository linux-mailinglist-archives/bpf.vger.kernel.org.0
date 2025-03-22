Return-Path: <bpf+bounces-54562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D77A6C6D7
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 02:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86CF3BC642
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 01:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DC81BC5C;
	Sat, 22 Mar 2025 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBN+dKUq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5B3FFD
	for <bpf@vger.kernel.org>; Sat, 22 Mar 2025 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742605776; cv=none; b=uDfWuAwZR3GHsnITBynqbQqcc2Dfs2IUrGGkjQJ/DizM4nFb87HhTvViepTR5nZ+ttLumwfCQBiNB9XNrUfQFfIWgx4nmSlE7QLO45yk+K97G/hsnNuFFYYQpeZdcKbq1NnmfmtT9/VbBhxGogcijYHfn5aPHM9Ho8EFao/3E8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742605776; c=relaxed/simple;
	bh=RHnF97vxaogfg31pPh0xihnTtDGXFdxNZg66JB90DRE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bk9pn6aZIeYPEHwR71PySd3+2jZwLApTxoN6HSZijJeVa56jC6gS0O7Kv9QyiPa8E/9Yk8hR14UiYMFDx7Ihf/6t1+LgOoSEMn0+aTLtiLG1Bmypo4suev8M/GO9fhhaKkR1mZcb3yH7ESFA0gp7CtRae8tVLaOrQAl9itZQhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBN+dKUq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22423adf751so52723675ad.2
        for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 18:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742605774; x=1743210574; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZZ20OGaNtfn3wuTOXT6V11NpZCZpr982oQaFZGqvM3I=;
        b=RBN+dKUqxVyhz6P9wmRKNUpq9ppGfoNZxYX2mtqGOwR6Oo3HVB1Wow0FXa6LmDo5kr
         cqsQxrc7D93QcU9oq42/Zp1tfUQ35q6RH4m67FDZvp2T0QrRtoXp9GYBtZjoRkcIQoqk
         wszZLMdnC4JtpWcrGhmJ2TBk8HYMoHDDGGeMgTV1uc1KhNlFUxk8oBB7xg4NRoWLsj3p
         YjQTn9WSCjOSkxAxiyXVB0ffs9yEb4PxwTa/bGl0DqXvJgf9fDCJ6Nxy1w3Kn4Vs2C7v
         WPMOUuEgiqtZtGJqQEnA15F7MfsntNv6xvRYe0xqGSCMKgu3t7wL+oROEpmd7UeqOyHZ
         +6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742605774; x=1743210574;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ20OGaNtfn3wuTOXT6V11NpZCZpr982oQaFZGqvM3I=;
        b=dX6XHoNKmjh/OMbSSOh9jP8DcyZYOvxgkkh4LBk47Dvp6HpL3kWNzFYj9Xk+4eX66u
         Q6LeFCknPaslcuuSUZlFsMIQ8oMClpPKMkRafuXTkdu0401iL+IJ7vLqEOCoYxGb11Cx
         DbXr9G7jKoW6V3E3ByKhoUsd9SJ0pxtAhAf/HN1OZewcuWF2kHSVjq4ybq/Xd9QwMP3e
         632PWn5wsjlGg+qKRM0C1LGuWcdoiiYH0teMCT5lpMRwrxLdj+15VdSNVNfvwOwL5+hi
         K5mmPexqM++lwXG9vJPJ2/xITr3CCVpTp/aKWBHVEbORIge3bTMArZM0lZVk1ViKnGJj
         AxoA==
X-Forwarded-Encrypted: i=1; AJvYcCVNjP8/axP4G42aUBacsG9dWbo4EllYqHh0+Ygx9KEjEnokkwngJqUJWNkDUuAjpAPkb20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg9W2SNhBk7Z/i8XByh6qFkLdVejd1Lu28bSF1UGuVUh9fin+P
	SZutd/2vQ+mhfQgOkfSLvQoqm5tf9aOF60jSjM5U6EOhJUZnb/i+
X-Gm-Gg: ASbGncstvNtID0kHDiJ4S23maZ2e1Mbv49vBt71Ke9fTBiZC6GlfpD1So1AfIFTRnla
	jUWwq/I/0PLPgVmdlbLlsf1qp3bcwWCJ3SR6v41BOLY88s8Drdv5Ycref3L354pykjEXOZpY65a
	JJjmamA+BAIo9O6TTqj3LoBS8GbC0+mx/caYy+yBhyanZ50ccQ/I4tSKV7zlob4wDyT01pIzebh
	XfrChd/4YhZsdtOB1EMAUULT+lu0+YAzHm2IS1VazEpdBNNmyftOIt474L8PkogtyEGkK2gzbHg
	tYVBaEK75LclU9V+0DzXLB1n+KoHJWNgwTQqXgs9h2p8r1MxRAk=
X-Google-Smtp-Source: AGHT+IH25HSwG6nzGTYjuJ/j+wfgKtBHuv1fjueIGCpvUAdUieSQncoFOwBG3OQhcEpQCkkKY8JdAg==
X-Received: by 2002:a17:903:2350:b0:216:410d:4c53 with SMTP id d9443c01a7336-22780e10cdemr77019465ad.41.1742605774251;
        Fri, 21 Mar 2025 18:09:34 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf636122sm6929309a91.45.2025.03.21.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 18:09:33 -0700 (PDT)
Message-ID: <73d0676051a7e0e0108a13a5b4f36c33d6496fa2.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: support struct/union presets in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 21 Mar 2025 18:09:29 -0700
In-Reply-To: <20250320224546.241673-1-mykyta.yatsenko5@gmail.com>
References: <20250320224546.241673-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-20 at 22:45 +0000, Mykyta Yatsenko wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index a18972ffdeb6..babc97b799a2 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -23,6 +23,7 @@
>  #include <float.h>
>  #include <math.h>
>  #include <limits.h>
> +#include <linux/err.h>
> =20
>  #ifndef ARRAY_SIZE
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> @@ -1486,7 +1487,131 @@ static bool is_preset_supported(const struct btf_=
type *t)
>  	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
>  }
> =20
> -static int set_global_var(struct bpf_object *obj, struct btf *btf, const=
 struct btf_type *t,
> +struct btf_anon_stack {
> +	const struct btf_type *t;
> +	__u32 offset;
> +};
> +
> +const struct btf_member *btf_find_member(const struct btf *btf,
> +					 const struct btf_type *parent_type,
> +					 const char *member_name,
> +					 __u32 *anon_offset)
> +{
> +	struct btf_anon_stack *anon_stack;
> +	const struct btf_member *retval =3D NULL;
> +	__u32 cur_offset =3D 0;
> +	const char *name;
> +	int top =3D 0, i;
> +
> +	if (!btf_is_struct(parent_type) && !btf_is_union(parent_type))
> +		return ERR_PTR(-EINVAL);
> +
> +	anon_stack =3D malloc(sizeof(*anon_stack));
> +	if (!anon_stack)
> +		return ERR_PTR(-ENOMEM);
> +
> +	anon_stack[top].t =3D parent_type;
> +	anon_stack[top++].offset =3D 0;
> +
> +	do {
> +		parent_type =3D anon_stack[--top].t;
> +		cur_offset =3D anon_stack[top].offset;
> +
> +		for (i =3D 0; i < btf_vlen(parent_type); ++i) {
> +			const struct btf_member *member;
> +			const struct btf_type *t;
> +			int tid;
> +
> +			member =3D btf_members(parent_type) + i;
> +			tid =3D  btf__resolve_type(btf, member->type);

Nit: these are called member_tid and member_type in the function below.

> +			if (tid < 0) {
> +				retval =3D ERR_PTR(-EINVAL);
> +				goto out;
> +			}
> +			t =3D btf__type_by_id(btf, tid);
> +			if (member->name_off) {
> +				name =3D btf__name_by_offset(btf, member->name_off);
> +				if (name && strcmp(member_name, name) =3D=3D 0) {
> +					if (anon_offset)

Nit: anon_offset is always non-null.

> +						*anon_offset =3D cur_offset;
> +					retval =3D member;
> +					goto out;
> +				}
> +			} else if (t) {

Nit: result of `btf__resolve_type()` is not checked against NULL in
     most places in veristat.c. When bpf object file is opened by
     libbpf the BTF is setup by function btf.c:btf_new(), which
     does some sanity including checks for ids of member types.
     See btf.c:btf_sanity_check().

> +				struct btf_anon_stack *tmp;
> +
> +				tmp =3D realloc(anon_stack, (top + 1) * sizeof(*anon_stack));
> +				if (!tmp) {
> +					retval =3D ERR_PTR(-ENOMEM);
> +					goto out;
> +				}
> +				anon_stack =3D tmp;
> +				/* Anonymous union/struct: push to stack */
> +				anon_stack[top].t =3D t;
> +				anon_stack[top++].offset =3D cur_offset + member->offset;

I think it is necessary to check that `t` is struct or union,
otherwise something like 'struct foo { int :64; int bar; }'
will cause trouble.

> +			}
> +		}
> +	} while (top > 0);
> +out:
> +	free(anon_stack);
> +	return retval;
> +}
> +
> +static int adjust_var_secinfo_tok(char **name_tok, const struct btf *btf=
,
> +				  const struct btf_type *t, struct btf_var_secinfo *sinfo)
> +{
> +	char *name =3D strtok_r(NULL, ".", name_tok);
> +	const struct btf_type *member_type;
> +	const struct btf_member *member;
> +	int member_tid;
> +	__u32 anon_offset =3D 0;
> +
> +	if (!name)
> +		return 0;
> +
> +	if (!btf_is_union(t) && !btf_is_struct(t))
> +		return -EINVAL;
> +
> +	member =3D btf_find_member(btf, t, name, &anon_offset);
> +	if (IS_ERR(member))
> +		return -EINVAL;
> +
> +	member_tid =3D btf__resolve_type(btf, member->type);
> +	member_type =3D btf__type_by_id(btf, member_tid);
> +
> +	if (btf_kflag(t)) {
> +		sinfo->offset +=3D (BTF_MEMBER_BIT_OFFSET(member->offset) + anon_offse=
t) / 8;
> +		sinfo->size =3D BTF_MEMBER_BITFIELD_SIZE(member->offset) / 8;

Bitfields are not handled by `set_global_var`, as ->size is in bytes.
Maybe just error out here saying that setting bitfields is not supported?
Alternatively, there is a utility function btf_member_bit_offset(),
maybe declare a similar btf_member_bit_size() and remove the
btf_kflag(t) condition here? Just to make it a bit easier to understand.

> +	} else {
> +		sinfo->offset +=3D (member->offset + anon_offset) / 8;
> +		sinfo->size =3D member_type->size;
> +	}
> +	sinfo->type =3D member_tid;
> +
> +	return adjust_var_secinfo_tok(name_tok, btf, member_type, sinfo);
> +}
> +
> +static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
> +			      struct btf_var_secinfo *sinfo, const char *var)
> +{
> +	char expr[256], *saveptr;
> +	const struct btf_type *base_type;
> +	int err;
> +
> +	base_type =3D btf__type_by_id(btf, btf__resolve_type(btf, t->type));
> +	if (!btf_is_union(base_type) && !btf_is_struct(base_type))
> +		return 0;

What would happen if preset "foo.bar" would be specified for variable
"foo" being e.g. of type "int"? It seems the ".bar" part would be just
ignored.

> +
> +	strcpy(expr, var);

Nit: strncpy ?

> +	strtok_r(expr, ".", &saveptr);
> +	err =3D adjust_var_secinfo_tok(&saveptr, btf, base_type, sinfo);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int set_global_var(struct bpf_object *obj, struct btf *btf,
>  			  struct bpf_map *map, struct btf_var_secinfo *sinfo,
>  			  struct var_preset *preset)
>  {
> @@ -1495,9 +1620,9 @@ static int set_global_var(struct bpf_object *obj, s=
truct btf *btf, const struct
>  	long long value =3D preset->ivalue;
>  	size_t size;
> =20
> -	base_type =3D btf__type_by_id(btf, btf__resolve_type(btf, t->type));
> +	base_type =3D btf__type_by_id(btf, btf__resolve_type(btf, sinfo->type))=
;
>  	if (!base_type) {
> -		fprintf(stderr, "Failed to resolve type %d\n", t->type);
> +		fprintf(stderr, "Failed to resolve type %d\n", sinfo->type);
>  		return -EINVAL;
>  	}
>  	if (!is_preset_supported(base_type)) {
> @@ -1530,7 +1655,7 @@ static int set_global_var(struct bpf_object *obj, s=
truct btf *btf, const struct
>  		if (value >=3D max_val || value < -max_val) {
>  			fprintf(stderr,
>  				"Variable %s value %lld is out of range [%lld; %lld]\n",
> -				btf__name_by_offset(btf, t->name_off), value,
> +				btf__name_by_offset(btf, base_type->name_off), value,
>  				is_signed ? -max_val : 0, max_val - 1);
>  			return -EINVAL;
>  		}
> @@ -1590,7 +1715,12 @@ static int set_global_vars(struct bpf_object *obj,=
 struct var_preset *presets, i
>  			var_name =3D btf__name_by_offset(btf, var_type->name_off);
> =20
>  			for (k =3D 0; k < npresets; ++k) {
> -				if (strcmp(var_name, presets[k].name) !=3D 0)
> +				struct btf_var_secinfo tmp_sinfo;
> +				int var_len =3D strlen(var_name);
> +
> +				if (strncmp(var_name, presets[k].name, var_len) !=3D 0 ||
> +				    (presets[k].name[var_len] !=3D '\0' &&
> +				     presets[k].name[var_len] !=3D '.'))

var_name comes from BTF and presets[k].name comes from command line, right?
Meaning that there might be a case when strlen(presets[k].name) < strlen(va=
r_name)
and access presets[k].name[var_len] would be out of bounds. Wdyt?

>  					continue;
> =20
>  				if (presets[k].applied) {
> @@ -1598,13 +1728,17 @@ static int set_global_vars(struct bpf_object *obj=
, struct var_preset *presets, i
>  						var_name);
>  					return -EINVAL;
>  				}
> +				memcpy(&tmp_sinfo, sinfo, sizeof(*sinfo));
> +				err =3D adjust_var_secinfo(btf, var_type,
> +							 &tmp_sinfo, presets[k].name);
> +				if (err)
> +					return err;
> =20
> -				err =3D set_global_var(obj, btf, var_type, map, sinfo, presets + k);
> +				err =3D set_global_var(obj, btf, map, &tmp_sinfo, presets + k);
>  				if (err)
>  					return err;
> =20
>  				presets[k].applied =3D true;
> -				break;

This is removed to handle cases with presets "foo.bar" and "foo.buz", right=
?
Maybe extend the test case a bit?

>  			}
>  		}
>  	}



