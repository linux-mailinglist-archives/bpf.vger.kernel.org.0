Return-Path: <bpf+bounces-21637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD9B84FA68
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 18:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0310F1C22D99
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 17:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEC37BAE8;
	Fri,  9 Feb 2024 16:57:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0847B3EE
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497871; cv=none; b=A+oaIF1IZlJrS/djgQ6aS/lsELAlbTwNQ/w4su52F/rYq2aWUQFZOpPkE8eR5oWu7QKYb/HrTdjxURmPt4VfFwhSIISORx5EVgcK9O6DM0HD91HW7Ngn4SrmCjTU2rK3GmWzl442iC+tE3rY8TMVfpKKpQoH/v1HwoJB6nte+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497871; c=relaxed/simple;
	bh=2O62NP7wfKN6+eb+gNogLNqXISTEttMtqvV8Oxx80rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCqb/7UVMAv6u5QwqvZaS9tY95phKNEL+j6J5cpDtv94u8K7o0eUTzs1hB9mRN43dDypawYh6CSWw++J8XPGnOlVviz95Nq9QTCbmbk82Yh4KamuK9UWQ2CFQAOJiyJ1cOv7hh2bBiaEASaRRfyAiy2rNUJYxPLpDROXmCUWRrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783d4b3ad96so67837985a.3
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 08:57:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707497869; x=1708102669;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aG6KHSkq2vVo/go4bIeARSJ2dQsFSsB9TwMm+EEehbk=;
        b=FwIQdpGY01h8PTJth2QdT05hNsqByWLvNeWAT93BGwoIBLlyupQNBnTOAjV6MB0fT+
         jCOQfFCUyA7JVzDnH538N22JJFSkK038SeimcB/CF1mbgfIoKupvlZMnJB9EIm16stNw
         48SaBm5ex+gmFWF00Zom5ZZNxYOhaoR8UqVlPqMitqc1y7J2R8yWhwYXLEJDd4NG5CWg
         f8QbfLNAvi9db8ffSaogZWYt7mt2GFEymBTDdJCzKYmqwsRwO47qLKFBnPHLhAzbRLGb
         Y9lAP9D+h4Qn4ouSMuLfc1Gorus3OoPLJ9HsB8vhoLY4mch1FiK2eBkyuhLn4qMy++dq
         WAhQ==
X-Gm-Message-State: AOJu0YyBs3dhG7mOYAp2uVuLXRuS14NcWXZ6vJVLh0e3B7YDWEnx15Mn
	W+nxA/NjROBxSsVnuHSC0C8CPGJXrT+VuGxYxtH9786gyZwjkNhrchRvVlNhWWM=
X-Google-Smtp-Source: AGHT+IFb5FT5WZzOZjpBJvkWwuz8byiSf1norw9lAVDsTJi55VC5fjj7tPtas+/ZkYthxb1HPKd84Q==
X-Received: by 2002:a05:620a:90a:b0:785:8e15:ccdc with SMTP id v10-20020a05620a090a00b007858e15ccdcmr1908566qkv.74.1707497868593;
        Fri, 09 Feb 2024 08:57:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCFSy3Rgydf9qVXaC1qYHEWGNTOkUxhfCxVNVuLFTrEu5NNDDzRhn0cbkyoQYxeHBWoKqaivwgrSlajiOsnF36SjPIqaHMj2iN5Aak/CJyK0elQHIBpSGVUTonHRfiPSFKynXsA6i0bUE06h/TIaBnN/8HzVPDIhKpjJlM/UdkSh4T600SM6N69j8YA8X4tw5TOzsLQVgw3sn5N0ZCq0RDGxkUY9Soi//h1JEqnfnUUdTVpOy96/EwdCzOaVGd0LHcTmOMkUD/Z3RYjTaA6FI+d9bOkvo2n+MxUlO0gx9CZU03umLYx2hUgoviISA7AA==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id vw16-20020a05620a565000b0078575747a18sm871084qkn.30.2024.02.09.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:57:48 -0800 (PST)
Date: Fri, 9 Feb 2024 10:57:45 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
	tj@kernel.org, brho@google.com, hannes@cmpxchg.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 02/16] bpf: Recognize '__map' suffix in kfunc
 arguments
Message-ID: <20240209165745.GB975217@maniforge.lan>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-3-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Eova/GuUNfBAodRg"
Content-Disposition: inline
In-Reply-To: <20240206220441.38311-3-alexei.starovoitov@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Eova/GuUNfBAodRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 02:04:27PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Recognize 'void *p__map' kfunc argument as 'struct bpf_map *p__map'.
> It allows kfunc to have 'void *' argument for maps, since bpf progs
> will call them as:
> struct {
>         __uint(type, BPF_MAP_TYPE_ARENA);
> 	...
> } arena SEC(".maps");
>=20
> bpf_kfunc_with_map(... &arena ...);
>=20
> Underneath libbpf will load CONST_PTR_TO_MAP into the register via ld_imm=
64 insn.
> If kfunc was defined with 'struct bpf_map *' it would pass
> the verifier, but bpf prog would need to use '(void *)&arena'.
> Which is not clean.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/verifier.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d9c2dbb3939f..db569ce89fb1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10741,6 +10741,11 @@ static bool is_kfunc_arg_ignore(const struct btf=
 *btf, const struct btf_param *a
>  	return __kfunc_param_match_suffix(btf, arg, "__ign");
>  }
> =20
> +static bool is_kfunc_arg_map(const struct btf *btf, const struct btf_par=
am *arg)
> +{
> +	return __kfunc_param_match_suffix(btf, arg, "__map");
> +}
> +
>  static bool is_kfunc_arg_alloc_obj(const struct btf *btf, const struct b=
tf_param *arg)
>  {
>  	return __kfunc_param_match_suffix(btf, arg, "__alloc");
> @@ -11064,7 +11069,7 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
>  		return KF_ARG_PTR_TO_CONST_STR;
> =20
>  	if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_ids[base_type=
(reg->type)])) {
> -		if (!btf_type_is_struct(ref_t)) {
> +		if (!btf_type_is_struct(ref_t) && !btf_type_is_void(ref_t)) {
>  			verbose(env, "kernel function %s args#%d pointer type %s %s is not su=
pported\n",
>  				meta->func_name, argno, btf_type_str(ref_t), ref_tname);
>  			return -EINVAL;
> @@ -11660,6 +11665,13 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  		if (kf_arg_type < 0)
>  			return kf_arg_type;
> =20
> +		if (is_kfunc_arg_map(btf, &args[i])) {
> +			/* If argument has '__map' suffix expect 'struct bpf_map *' */
> +			ref_id =3D *reg2btf_ids[CONST_PTR_TO_MAP];
> +			ref_t =3D btf_type_by_id(btf_vmlinux, ref_id);
> +			ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
> +		}

This is fine, but given that this should only apply to KF_ARG_PTR_TO_BTF_ID,
this seems a bit cleaner, wdyt?

index ddaf09db1175..998da8b302ac 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10741,6 +10741,11 @@ static bool is_kfunc_arg_ignore(const struct btf *=
btf, const struct btf_param *a
        return __kfunc_param_match_suffix(btf, arg, "__ign");
 }

+static bool is_kfunc_arg_map(const struct btf *btf, const struct btf_param=
 *arg)
+{
+       return __kfunc_param_match_suffix(btf, arg, "__map");
+}
+
 static bool is_kfunc_arg_alloc_obj(const struct btf *btf, const struct btf=
_param *arg)
 {
        return __kfunc_param_match_suffix(btf, arg, "__alloc");
@@ -10910,6 +10915,7 @@ enum kfunc_ptr_arg_type {
        KF_ARG_PTR_TO_RB_NODE,
        KF_ARG_PTR_TO_NULL,
        KF_ARG_PTR_TO_CONST_STR,
+       KF_ARG_PTR_TO_MAP,      /* pointer to a struct bpf_map */
 };

 enum special_kfunc_type {
@@ -11064,12 +11070,12 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
                return KF_ARG_PTR_TO_CONST_STR;

        if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_ids[base_=
type(reg->type)])) {
-               if (!btf_type_is_struct(ref_t)) {
+               if (!btf_type_is_struct(ref_t) && !btf_type_is_void(ref_t))=
 {
                        verbose(env, "kernel function %s args#%d pointer ty=
pe %s %s is not supported\n",
                                meta->func_name, argno, btf_type_str(ref_t)=
, ref_tname);
                        return -EINVAL;
                }
-               return KF_ARG_PTR_TO_BTF_ID;
+               return is_kfunc_arg_map(meta->btf, &args[argno]) ? KF_ARG_P=
TR_TO_MAP : KF_ARG_PTR_TO_BTF_ID;
        }

        if (is_kfunc_arg_callback(env, meta->btf, &args[argno]))
@@ -11663,6 +11669,7 @@ static int check_kfunc_args(struct bpf_verifier_env=
 *env, struct bpf_kfunc_call_
                switch (kf_arg_type) {
                case KF_ARG_PTR_TO_NULL:
                        continue;
+               case KF_ARG_PTR_TO_MAP:
                case KF_ARG_PTR_TO_ALLOC_BTF_ID:
                case KF_ARG_PTR_TO_BTF_ID:
                        if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(m=
eta))
@@ -11879,6 +11886,13 @@ static int check_kfunc_args(struct bpf_verifier_en=
v *env, struct bpf_kfunc_call_
                        if (ret < 0)
                                return ret;
                        break;
+               case KF_ARG_PTR_TO_MAP:
+                       /* If argument has '__map' suffix expect 'struct bp=
f_map *' */
+                       ref_id =3D *reg2btf_ids[CONST_PTR_TO_MAP];
+                       ref_t =3D btf_type_by_id(btf_vmlinux, ref_id);
+                       ref_tname =3D btf_name_by_offset(btf, ref_t->name_o=
ff);
+
+                       fallthrough;
                case KF_ARG_PTR_TO_BTF_ID:
                        /* Only base_type is checked, further checks are do=
ne here */
                        if ((base_type(reg->type) !=3D PTR_TO_BTF_ID ||


> +
>  		switch (kf_arg_type) {
>  		case KF_ARG_PTR_TO_NULL:
>  			continue;
> --=20
> 2.34.1
>=20
>=20

--Eova/GuUNfBAodRg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcZZiQAKCRBZ5LhpZcTz
ZIRqAP9RMb4YEZxJeCZzub6P8wiByjfmccyYJrlrT+8/m2Qs+gEAt3Y16on7fQjH
qv6BC/gomkKKj5TpNzs+nAlSjIILlQw=
=zDKM
-----END PGP SIGNATURE-----

--Eova/GuUNfBAodRg--

