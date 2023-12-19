Return-Path: <bpf+bounces-18246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D38A817E5F
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 01:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236CB2836DB
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 00:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57996387;
	Tue, 19 Dec 2023 00:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJssJxwd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391AA7F
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 00:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e2bd8c396so2912899e87.0
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 16:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702944278; x=1703549078; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89TNN1r3fxTzF0RmHOxpfIgTyFpJX99bhad5xTG16rY=;
        b=aJssJxwdANhvAaY1ybumhm+vYk2jHiLSZL5o4n92RGbk/az+Oqvfn8V1T8ObRE5H67
         YejxJnpxeKfJGNnv9ps3CkLaAeunJfOXBYfMESYr7b++MuFs5PkzAFSpB5Hno2Uk9YLr
         2P0XWIxAvdXgfB850as2hGahDujEZagiNaW/HnuMnGAMeMgLKE0rY4LiSqTcJTRrBC8y
         fVphYHJzAlfnYSb8UaGhhiopJC47v3aus+YArRbqlm4JjTNcnIimXWBhKjsRcuQjdPPo
         NdyzgtessGXDCje2bh4+8Kcmv5T+TREPpApDm1A78FS6bYYbFG83NNHx11OBXk5KvqXq
         ZOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944278; x=1703549078;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89TNN1r3fxTzF0RmHOxpfIgTyFpJX99bhad5xTG16rY=;
        b=XBmfb5JlGXX5bFOazeG5gQTNNyICRNYHbve+5FCOF2wrGxyWVhW9TBJPtCLJnhawYM
         kAld6scjs61NKMKHO7kAsJ7oNecoN8lDA1J4GRQEFdkPNQ79fV6WrFwdEj6+yLCgYDQy
         x1wKw/T3JzEnEEYgi2HxACgHR4iz+Jzy318nPXWBuLAacD5uRJbKQaWarPI4eFzM2fmm
         1XajhEvoxu9Pqzg+toZTsWX+XAE/n9b/iEZtIaSKc/9xLlTENyB5+dXxpzg3XciPDPkC
         QBfxsMoAkLbE2hatzLnRD97A3wwguIWkmbeAvM4FxgTmWifE9S23HqDVKnB/xvWYADIf
         chNA==
X-Gm-Message-State: AOJu0YzIsG2IcfruztmQewZVyHn4a2JE/kvyUfD7QsB+4KxNjWctGXVP
	CYtogJzAVofsUdXFO6SDwNw=
X-Google-Smtp-Source: AGHT+IFu7KPxVPPT5LOxaM9tDUR1cGyNzvH6RA4c9NeYGiSQIni6afJBKxOMHUG5qH1J9gDMSZnIGA==
X-Received: by 2002:ac2:5f7c:0:b0:50e:2275:59bb with SMTP id c28-20020ac25f7c000000b0050e227559bbmr2550411lfc.44.1702944277881;
        Mon, 18 Dec 2023 16:04:37 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h36-20020a0565123ca400b0050be9c8b108sm3050329lfv.60.2023.12.18.16.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:04:37 -0800 (PST)
Message-ID: <658b22003f90e066ba7d6585aa444c3e401ff0ac.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Simplify checking size of helper
 accesses
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com
Date: Tue, 19 Dec 2023 02:04:31 +0200
In-Reply-To: <20231217010649.577814-2-andreimatei1@gmail.com>
References: <20231217010649.577814-1-andreimatei1@gmail.com>
	 <20231217010649.577814-2-andreimatei1@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-12-16 at 20:06 -0500, Andrei Matei wrote:
[...]

> (*) Besides standing to reason that the checks for a bigger size access
> are a super-set of the checks for a smaller size access, I have also
> mechanically verified this by reading the code for all types of
> pointers. I could convince myself that it's true for all but
> PTR_TO_BTF_ID (check_ptr_to_btf_access). There, simply looking
> line-by-line does not immediately prove what we want. If anyone has any
> qualms, let me know.

check_help_mem_access() is a bit obfuscated :)
After staring at it for a bit I have a question regarding
check_ptr_to_btf_access():
- it can call btf_struct_access(),
  which in can call btf_struct_walk(),
  which has the following check:

		if (btf_type_is_ptr(mtype)) {
			const struct btf_type *stype, *t;
			enum bpf_type_flag tmp_flag =3D 0;
			u32 id;

			if (msize !=3D size || off !=3D moff) {
				bpf_log(log,
					"cannot access ptr member %s with moff %u in struct %s with off %u siz=
e %u\n",
					mname, moff, tname, off, size);
				return -EACCES;
			}

- previously this code was executed twice, for size 0 and for size
  umax_value of the size register;
- now this code is executed only for umax_value of the size register;
- is it possible that with size 0 this code could have reported error
  -EACCESS error, which would be missed now?
 =20
Except for the question above I don't see any issues,
but check_help_mem_access() has many sub-cases,
so I might have missed something.

Also a few nits below.

[...]

> @@ -7256,6 +7256,65 @@ static int check_helper_mem_access(struct bpf_veri=
fier_env *env, int regno,
>  	}
>  }
> =20
> +/* Helper function for logging an error about an invalid attempt to perf=
orm a
> + * (possibly) zero-sized memory access. The pointer being dereferenced i=
s in
> + * register @ptr_regno, and the size of the access is in register @size_=
regno.
> + * The size register is assumed to either be a constant zero or have a z=
ero lower
> + * bound.
> + *
> + * Logs a message like:
> + * invalid zero-size read. Size comes from R2=3D0. Attempting to derefer=
ence *map_value R1: off=3D[0,4] value_size=3D48
> + */
> +static void log_zero_size_access_err(struct bpf_verifier_env *env,
> +			      int ptr_regno,
> +			      int size_regno)
> +{
> +	struct bpf_reg_state *ptr_reg =3D &cur_regs(env)[ptr_regno];
> +	struct bpf_reg_state *size_reg =3D &cur_regs(env)[size_regno];
> +	const bool size_is_const =3D tnum_is_const(size_reg->var_off);
> +	const char *ptr_type_str =3D reg_type_str(env, ptr_reg->type);
> +	/* allocate a few buffers to be used as parts of the error message */
> +	char size_range_buf[64] =3D {0}, max_size_buf[64] =3D {0}, off_buf[64] =
=3D {0};
> +	s64 min_off, max_off;

Nit: empty is needed here

[...]

>  /* verify arguments to helpers or kfuncs consisting of a pointer and an =
access
>   * size.
>   *
> @@ -7268,6 +7327,7 @@ static int check_mem_size_reg(struct bpf_verifier_e=
nv *env,
>  			      struct bpf_call_arg_meta *meta)
>  {
>  	int err;
> +	const bool size_is_const =3D tnum_is_const(reg->var_off);

Nit: please swap definitions to get the "reverse Christmas tree":

    const bool size_is_const =3D tnum_is_const(reg->var_off);
    int err;

> =20
>  	/* This is used to refine r0 return value bounds for helpers
>  	 * that enforce this value as an upper bound on return values.
> @@ -7282,7 +7342,7 @@ static int check_mem_size_reg(struct bpf_verifier_e=
nv *env,
>  	/* The register is SCALAR_VALUE; the access check
>  	 * happens using its boundaries.
>  	 */
> -	if (!tnum_is_const(reg->var_off))
> +	if (!size_is_const)
>  		/* For unprivileged variable accesses, disable raw
>  		 * mode so that the program is required to
>  		 * initialize all the memory that the helper could
> @@ -7296,12 +7356,9 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,
>  		return -EACCES;
>  	}
> =20
> -	if (reg->umin_value =3D=3D 0) {
> -		err =3D check_helper_mem_access(env, regno - 1, 0,
> -					      zero_size_allowed,
> -					      meta);
> -		if (err)
> -			return err;
> +	if (reg->umin_value =3D=3D 0 && !zero_size_allowed) {
> +		log_zero_size_access_err(env, regno-1, regno);
> +		return -EACCES;
>  	}
> =20
>  	if (reg->umax_value >=3D BPF_MAX_VAR_SIZ) {
> @@ -7309,9 +7366,21 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,
>  			regno);
>  		return -EACCES;
>  	}
> +	/* If !zero_size_allowed, we already checked that umin_value > 0, so
> +	 * umax_value should also be > 0.
> +	 */
> +	if (reg->umax_value =3D=3D 0 && !zero_size_allowed) {
> +		verbose(env, "verifier bug: !zero_size_allowed should have been handle=
d already\n");
> +		return -EFAULT;
> +	}
>  	err =3D check_helper_mem_access(env, regno - 1,
>  				      reg->umax_value,
> -				      zero_size_allowed, meta);
> +				      /* zero_size_allowed: we asserted above that umax_value is
> +				       * not zero if !zero_size_allowed, so we don't need any
> +				       * further checks.
> +				       */
> +				      true ,
                          ^
Nit: extra space ---------'

> +				      meta);
>  	if (!err)
>  		err =3D mark_chain_precision(env, regno);
>  	return err;

[...]

