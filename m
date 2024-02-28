Return-Path: <bpf+bounces-22891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFBC86B5DB
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7BF1F275A1
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 17:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACA73FBBE;
	Wed, 28 Feb 2024 17:23:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624F03FBB2
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140999; cv=none; b=OhgxSN+ZNLk9s6rkJ+kAhO+1Z/0SDG1cXW75BYX/EA+RI22yW2kY8VgJ5jTCo1XMaC6hgOsBqLnEFOkStjpaO1PzUpt/rNTsgCI6uTpuKDOxtZxBfvtKIljmw8UBRa/sKMLTcMriuiSaxWbCwMyCdBkmaV308uwsclMH5H6SlqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140999; c=relaxed/simple;
	bh=CgBZMEM8U2o4CM/biFsYDnFk7wU9qHwMCvKmApUAFGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzCjcHgCQ9MBqwQXs7PFx/O/evJE0az0EJZ2f8s5DjCb0JJOjfp8KnfHtcm/UJjhIKb0kti6ULdu5NvQJ1g6PZWGyjdjhCirQsG1z1KP+Oq6iTVtQLIWxNBdOe4DHuKVj0oNnQ7I422wDimC4ZRx5i360SjcIc6/eNsy876de1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36517375cc6so81575ab.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 09:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140996; x=1709745796;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86eUicHVHWJVZ2KbBSM30NgEj8HM+9MnC0hTX36/JBM=;
        b=h0QYxUmxqwV4yk0NoG9TSaYi6dtbXek3lq7ZWxHiB/fbAMpw5BYFyzFTE4cTqiJiRO
         hQSyzvUvc+wnKo5kVdI2SHoDyW+9ABTEH6lsCCmquTi4RzdD1i6RKTnUWxRBpdI6zLmE
         hAAHMh0MMOM8CXfb7pKQTy7sdjJ7n4vBVXR/Gzf3mbdOL7pWD9luIZdsbdt8J+LS4i3o
         rbGRhP5t9GA2D4e5vvWh8bcN2NaxXn1rti3xdxOfC3NRxf7vVVjKnxAJHIMdrvdJG0+Q
         x28D7r/49vrbYctAcw7P+3K5hRHMYYUElQzIYh7C50U8ih96h3H3V/oWY0LnOzmsasm7
         Ijbg==
X-Gm-Message-State: AOJu0Yxqsk5R9NdYEwqY2euxP94MnwqVJGbKzAh1i4MZynUYoOPas/g4
	FtXjGbGPaXo9yX8DbYF55/2l6lkSqVp/qc8DP35Mvmk0MTJCl/8K
X-Google-Smtp-Source: AGHT+IHQ6+cS/dSuI294M01+txSV0c+va6wdDv+rE58M2vYX8QT/ys7vdRsFB9HXlhjGLD8sgpIRbw==
X-Received: by 2002:a92:d782:0:b0:363:d9eb:c2de with SMTP id d2-20020a92d782000000b00363d9ebc2demr58781iln.6.1709140996298;
        Wed, 28 Feb 2024 09:23:16 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id di1-20020a056e021f8100b003642ad5889fsm277303ilb.26.2024.02.28.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:23:15 -0800 (PST)
Date: Wed, 28 Feb 2024 11:23:13 -0600
From: David Vernet <void@manifault.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v1 2/8] libbpf: tie struct_ops programs to
 kernel BTF ids, not to local ids
Message-ID: <20240228172313.GB148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-3-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HJC5RoKlVYtJRqUo"
Content-Disposition: inline
In-Reply-To: <20240227204556.17524-3-eddyz87@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--HJC5RoKlVYtJRqUo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:45:50PM +0200, Eduard Zingerman wrote:
> Enforce the following existing limitation on struct_ops programs based
> on kernel BTF id instead of program-local BTF id:
>=20
>     struct_ops BPF prog can be re-used between multiple .struct_ops &
>     .struct_ops.link as long as it's the same struct_ops struct
>     definition and the same function pointer field

Am I correct in understanding the code that the prog also has to be at the =
same
offset in the new type? So if we have for example:

SEC("struct_ops/test")
int BPF_PROG(foo) { ... }

struct some_ops___v1 {
	int (*test)(void);
};

struct some_ops___v2 {
	int (*init)(void);
	int (*test)(void);
};

Then this wouldn't work? If so, would it be possible for libbpf to do somet=
hing
like invisibly duplicate the prog and create a separate one for each struct=
_ops
map where it's encountered? It feels like a rather awkward restriction to
impose given that the idea behind the feature is to enable loading one of
multiple possible definitions of a struct_ops type.

>=20
> This allows reusing same BPF program for versioned struct_ops map
> definitions, e.g.:
>=20
>     SEC("struct_ops/test")
>     int BPF_PROG(foo) { ... }
>=20
>     struct some_ops___v1 { int (*test)(void); };
>     struct some_ops___v2 { int (*test)(void); };
>=20
>     SEC(".struct_ops.link") struct some_ops___v1 a =3D { .test =3D foo }
>     SEC(".struct_ops.link") struct some_ops___v2 b =3D { .test =3D foo }
>=20
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 44 ++++++++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 23 deletions(-)
>=20
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index abe663927013..c239b75d5816 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1134,8 +1134,27 @@ static int bpf_map__init_kern_struct_ops(struct bp=
f_map *map)
> =20
>  			if (mod_btf)
>  				prog->attach_btf_obj_fd =3D mod_btf->fd;
> -			prog->attach_btf_id =3D kern_type_id;
> -			prog->expected_attach_type =3D kern_member_idx;
> +
> +			/* if we haven't yet processed this BPF program, record proper
> +			 * attach_btf_id and member_idx
> +			 */
> +			if (!prog->attach_btf_id) {
> +				prog->attach_btf_id =3D kern_type_id;
> +				prog->expected_attach_type =3D kern_member_idx;
> +			}
> +
> +			/* struct_ops BPF prog can be re-used between multiple
> +			 * .struct_ops & .struct_ops.link as long as it's the
> +			 * same struct_ops struct definition and the same
> +			 * function pointer field
> +			 */
> +			if (prog->attach_btf_id !=3D kern_type_id ||
> +			    prog->expected_attach_type !=3D kern_member_idx) {
> +				pr_warn("struct_ops reloc %s: cannot use prog %s in sec %s with type=
 %u attach_btf_id %u expected_attach_type %u for func ptr %s\n",
> +					map->name, prog->name, prog->sec_name, prog->type,
> +					prog->attach_btf_id, prog->expected_attach_type, mname);
> +				return -EINVAL;
> +			}
> =20
>  			st_ops->kern_func_off[i] =3D kern_data_off + kern_moff;
> =20
> @@ -9409,27 +9428,6 @@ static int bpf_object__collect_st_ops_relos(struct=
 bpf_object *obj,
>  			return -EINVAL;
>  		}
> =20
> -		/* if we haven't yet processed this BPF program, record proper
> -		 * attach_btf_id and member_idx
> -		 */
> -		if (!prog->attach_btf_id) {
> -			prog->attach_btf_id =3D st_ops->type_id;
> -			prog->expected_attach_type =3D member_idx;
> -		}
> -
> -		/* struct_ops BPF prog can be re-used between multiple
> -		 * .struct_ops & .struct_ops.link as long as it's the
> -		 * same struct_ops struct definition and the same
> -		 * function pointer field
> -		 */
> -		if (prog->attach_btf_id !=3D st_ops->type_id ||
> -		    prog->expected_attach_type !=3D member_idx) {
> -			pr_warn("struct_ops reloc %s: cannot use prog %s in sec %s with type =
%u attach_btf_id %u expected_attach_type %u for func ptr %s\n",
> -				map->name, prog->name, prog->sec_name, prog->type,
> -				prog->attach_btf_id, prog->expected_attach_type, name);
> -			return -EINVAL;
> -		}
> -
>  		st_ops->progs[member_idx] =3D prog;
>  	}
> =20
> --=20
> 2.43.0
>=20

--HJC5RoKlVYtJRqUo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZd9sAQAKCRBZ5LhpZcTz
ZFfpAQC0FRKNmzakuOCla5KqT/x0D+yLstW9BcMAISLQY4j6+QD/bCjPy1dXAWFQ
nq2dhSaAfQRLXmuNTKicsZbVZbH4gQ4=
=Yz9f
-----END PGP SIGNATURE-----

--HJC5RoKlVYtJRqUo--

