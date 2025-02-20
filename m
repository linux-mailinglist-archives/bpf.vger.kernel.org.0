Return-Path: <bpf+bounces-52101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77835A3E621
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 21:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1AD19C2CB0
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 20:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29EB212B02;
	Thu, 20 Feb 2025 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEnX7NLN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DCE213E7C
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084835; cv=none; b=NhEVqAtG3ErlMaFkVmKj/SBjpahWM5e81slWyGYamHg4B6vOxH8O4NbgIxcg7QIBJG/D2/4P85SHEvANLzBJ7BJjqN8oFb64k9Gtj//+Bi2qS7mEbiAHH3TKJFeZUJEEKdXdiVid6H5VI6V0oK2VrpSc50YrRmUG4M4J3D7XYGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084835; c=relaxed/simple;
	bh=tdEQr1Pp9SQh2J9PQPFZWJQE2ipTUnXUl6AGGfCi16M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s3dFtn8LfQz044NPkmtKg4qbNBETkaNr78OoQ5l1+3R9aB9wkod1VPLB+cZYd6x46dHDr2J/jhQ3jn8eEA4r9jVFlI5idpHp31Guz6JG6BfmhxeYW7d3s6WuhDuCEiQ+/Qsq200wqQ2RN6ug153cyuvy3mVcIv0bBCRPXtlkvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEnX7NLN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c665ef4cso23140035ad.3
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 12:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740084833; x=1740689633; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5nVUJX6Nhs+u4WCw3geasu+xhyVWvl/AGEM3fRmIGPw=;
        b=GEnX7NLNvvYif/tQTnsq04QaTp2cf8Y2MqhGdHfcHxYFqPEVdovwwJ/DoT5AHymo1b
         1MGU+9TNPTCViqiVKucTDVrWZ61AUcsOByeDUMjXOT2WOYw2aJRDYtXp4nK4X354zz1u
         fovomrbkDYzm5wGlmJ/C0CLhol5x6m4lEk23CulCS36mzmbvBB3iUlE1+v1oStqO4nSN
         EuaFXAdqY+Cp6rd7LAhwklMbn/1pkqP/nTupdZpi3YLP0m30sIh2G1NuRS2R2v60GTlr
         X9JdrbqnvebyEz3AwH+kIknYZAZ6nz1/U5dKB6fcXsGf46St5lYdzKZMdp7UGEBYwCtc
         9reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740084833; x=1740689633;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5nVUJX6Nhs+u4WCw3geasu+xhyVWvl/AGEM3fRmIGPw=;
        b=VjYZLH9+tXbI++wHoI9GkUyBkRnca8bThOrzOlDE35oWfY8GCZfVit3x5nM2niRaoy
         KIZo8MNHtlInOTyLubs1TKAK34IfvCXo2lshJg+7W0rSC9MtZzTj9XKfMYsikP4QyAi7
         DptlqHw+KV0+fg9XVIqa6Cm8PSunkzUpMwRlTCeVOwYGvSIEkCjGK60l4uMR/Xg5fK25
         4wZ+HFTOObsvR5JfzFeKTjB87luxyyTwT1omnzrSGQjLeaC6nKvQPq/pbX5SybDtlUmQ
         5Wm8/j+BVeFakl6UZP88GnNpL/s0XNILKIgicZmPF8TzZkoZec3l2m9CCuUBeXRvpxIx
         oLUg==
X-Forwarded-Encrypted: i=1; AJvYcCVwhsB18+nUSkQiM+TCkFY9Hzw2VaYmEwjgFt+6TslDqdfhxCviAE5XJI2/VjdJCLgAmy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Pq1yOl8fO7bYadHqwXJrd3wGg1/R05XFuOFSjJAg1S8KoZmZ
	VOj2C6ahlkoex2GZpRk7IEf/q5nJVeLaFUlNY/prBnUvk9iANfG/
X-Gm-Gg: ASbGncvqHPGXVMtTGNWBpiFmUjQnFzKZyl9ZNM8Mp9XDaNEEA482DoGZQmoUoaUC8Vk
	9KIhC188cjamIrLQdRnvWZJw2Gq1IY+RUtrsmLZkmwOlYucrIXWaDSPaY8cAIpOG2ccWOWAEO2R
	Rdxh3YPo09FoNHvxtyAeehhdbNCIed2cUsta/NYW50e2Y36Am24UrGYfB+iWZINo7XnyuK+9vjn
	R3mvYaiKNEn4Vvw56lsmJZXvS1QlG0Pkohfj8XLBVBgnoSoGRoA4gHggIOpm8dowhYmBf9RUIml
	UUl2dOG7mKOk
X-Google-Smtp-Source: AGHT+IEZ0KhmxZP8DBRlARFdcbndEkQwHFgyTp4mKwA9zigVPApC6OvHF4cvt2GRvf8DlDro/b6EXw==
X-Received: by 2002:a05:6a00:a01:b0:728:e906:e45a with SMTP id d2e1a72fcca58-73426d98995mr493073b3a.24.1740084833018;
        Thu, 20 Feb 2025 12:53:53 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732532ce7f1sm12326468b3a.73.2025.02.20.12.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:53:52 -0800 (PST)
Message-ID: <c81af399f191aa18b393884676cb9838455383a5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] selftests/bpf: implement setting global
 variables in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Thu, 20 Feb 2025 12:53:48 -0800
In-Reply-To: <20250219233045.201595-2-mykyta.yatsenko5@gmail.com>
References: <20250219233045.201595-1-mykyta.yatsenko5@gmail.com>
	 <20250219233045.201595-2-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-19 at 23:30 +0000, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> To better verify some complex BPF programs we'd like to preset global
> variables.
> This patch introduces CLI argument `--set-global-vars` or `-G` to
> veristat, that allows presetting values to global variables defined
> in BPF program. For example:
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
> ./veristat wq.bpf.o  -G "a =3D 0" -G "b =3D 1" -G "c =3D 2" -G "d =3D 3"
> ```
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -1292,6 +1320,249 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
>  	return 0;
>  };
> =20
> +static int append_var_preset(struct var_preset **presets, int *cnt, cons=
t char *expr)
> +{
> +	void *tmp;
> +	struct var_preset *cur;
> +	char var[256], val[256];
> +
> +	tmp =3D realloc(*presets, (*cnt + 1) * sizeof(**presets));
> +	if (!tmp)
> +		return -ENOMEM;
> +	*presets =3D tmp;
> +	cur =3D &(*presets)[*cnt];
> +	cur->applied =3D false;
> +
> +	if (sscanf(expr, "%s =3D %s\n", var, val) !=3D 2) {
> +		fprintf(stderr, "Could not parse expression %s\n", expr);
> +		return -EINVAL;
> +	}
> +
> +	if (isalpha(*val)) {
> +		cur->svalue =3D strdup(val);

Nit: when I run veristat under valgrind, it complains that
     fields allocated in this function are never freed.
     Grepping for 'free', it look like veristat.c prefers to free
     any allocated memory before exit.

> +		cur->type =3D NAME;
> +	} else if (*val =3D=3D '-' || isdigit(*val)) {
> +		long long value;
> +
> +		errno =3D 0;
> +		value =3D strtoll(val, NULL, 0);
> +		if (errno =3D=3D ERANGE) {
> +			errno =3D 0;
> +			value =3D strtoull(val, NULL, 0);
> +		}
> +		cur->ivalue =3D value;
> +		cur->type =3D INTEGRAL;
> +		if (errno) {
> +			fprintf(stderr, "Could not parse integer value %s\n", val);
> +			return -EINVAL;
> +		}
> +	} else {
> +		fprintf(stderr, "Could not parse value %s\n", val);
> +		return -EINVAL;
> +	}
> +	cur->name =3D strdup(var);
> +	(*cnt)++;
> +	return 0;
> +}
> +
> +static int append_var_preset_file(const char *filename)
> +{
> +	char buf[1024];
> +	FILE *f;
> +	int err =3D 0;
> +
> +	f =3D fopen(filename, "rt");
> +	if (!f) {
> +		err =3D -errno;
> +		fprintf(stderr, "Failed to open presets in '%s': %d\n", filename, err)=
;

Nit: 		fprintf(stderr, "Failed to open presets in '%s': %s\n",
			filename, strerror(errno));
                   =20
                Would make this a bit more friendly
                (and it prints error code if string representation does not=
 exist).

> +		return -EINVAL;
> +	}
> +
> +	while (fscanf(f, " %1023[^\n]\n", buf) =3D=3D 1) {
> +		if (buf[0] =3D=3D '\0' || buf[0] =3D=3D '#')
> +			continue;
> +
> +		err =3D append_var_preset(&env.presets, &env.npresets, buf);
> +		if (err)
> +			goto cleanup;
> +	}
> +
> +cleanup:
> +	fclose(f);
> +	return err;
> +}

[...]


