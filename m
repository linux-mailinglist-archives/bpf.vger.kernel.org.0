Return-Path: <bpf+bounces-49571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC4A1A154
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 10:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC867188F358
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0FF20C481;
	Thu, 23 Jan 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmzAzZ3y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7081720D4EF;
	Thu, 23 Jan 2025 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737626279; cv=none; b=Jmdh/DPJv1HOnVpyGYsE/CXOteOl69ERn972fZ2nDstMvGgZWW0Z7VjXCU6LjvgdZ+e7sFrBPkl/Ze5qQ+WzS/OyaqvEjAabvgGtM6jSuiRii6VsAevvLWB0JtCYH5e7HjHJmR5SFE03mVlD+pJugv8/l1urEeFMHXz4pGVpEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737626279; c=relaxed/simple;
	bh=FgicG9xKQ0MGARjqOPxoBkRCtWQnvWJcqdfPo1lLxVI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XLLZL8uP+si8Y3iSeXSLgzu5QPr9Cc1x8gwrb3wfbupOju16D2i11XhbHmSgyqEGUYkJLBw7tgRL4V8sXHsyFNTS+U4drtJE014+OHoDiPbuShN6ns7ySUa+sUTYVEz+uwcKWyYqLBrxjx/AwNiYKMW+La7uaUbQ7sx1IIXzGdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmzAzZ3y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21a7ed0155cso11118335ad.3;
        Thu, 23 Jan 2025 01:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737626277; x=1738231077; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xZOSwyM+r7tNYgCh6u6Am2CiILUNHkn5q/reme5TOsM=;
        b=OmzAzZ3y86PUuCzALm1J9ykg0bINgdocxW8pZ88QYLH1RdOyFpfW4Iog9AREiRo8Va
         PCmiQ3os1Kbjb8enb1uu+EwZhS5usO177sLe+BWG+aTdK1Ecgyhi0kfOf0eN74ayJZhw
         /6KJt4dMkH3GkVWiaEp58W3Mo7+IPGQzU2OcgNS7LS4LuGQGTtDlLQ9QL4+YJivUkCf9
         gPA9UvODd1ZN/rUdHiNs8MLcsvtjDVXq24rvwQAlySL+EcX9a/woNaHA3WFdWAu80UGZ
         T78n1xt1J54yt73ppkjOKMin4w8lp3paBungbmv3YH2rmrj5MTwovQRQ+k7VFG5Qa067
         2dXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737626277; x=1738231077;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZOSwyM+r7tNYgCh6u6Am2CiILUNHkn5q/reme5TOsM=;
        b=DpSY0ypPxlSVG5jnXZioMxEpdi9zGvPszIUT21xT4fqsmLcsgnpE74BroWif2dvXWK
         kRaZFbsa2MwFhmA2VYMHx3g3Jrx/dk5Ni2GE+2MZioz0ekao2kLimfZe4DrY4HsMWbkp
         8k4Z4dSwpXYVwxqMo8Eb++EZK9e5h0O0WT8GAiW0zTNPsmI22r/3pmo5k/pjDSpoAv0R
         T7beJS3Jc/DhIlyWTvO34inE3jloFTX7aaAy5k5ZxyK6e2605B7gtyahEOF/aESvSUEW
         lVc9bWb9QyBgL+tSlJ3keAK9e3GloNgiUEgFNKU/xdzHaORAdq8LyWCmgsB2YFfHTtVL
         DCAA==
X-Forwarded-Encrypted: i=1; AJvYcCUM2LmbsWfe1XVkfIdUIuaTzPcgr5lqH+Y6qedY4ryiyk/xx/CjP9QuDrC/gnfOX7LknxvHe30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwML0qXtnk3DGsWL8dg05/gL6sjZzUn3wpuo4ONWV2vRjx5UXLo
	U+iH3zW8E66yC0OB0DN5JE1NB1vI2ozu9/R1DKnlgbYIWLW7GCG6vASxn9+E
X-Gm-Gg: ASbGnct6PTQuss7zgMfXbJWTBQfoc6tPcHeSRQvL7pdCHG+flu/hVbHZIiwENHtYSvg
	0lfanEhzp6npTa9NZcggg4C4ORksXr+T/IKBEL4ydZ7xpHcHguao8qh/1sbk2o459UR8f0mJnRB
	OWEJyhTyAPipiit6CuTy9Gms35HVuOWc8JYc+eFTNa/PyeMRvmxaDM4y0o/q15I5dWAQy0BORuk
	pmtB8I5tVNDhd3XxFlEpFw/lJ47qcoxg3YirFA/pfJ8KzbPLruwV0z9Jsiap6tLosOyxa3XBY3k
	pg==
X-Google-Smtp-Source: AGHT+IEqbGvXZI9hSQvc/trgeyCmPiy5CnLjSNqYYwa6n8AOdMIMJmLdGNSJ6pFCHaLQiD3wKSdrOg==
X-Received: by 2002:a17:902:f689:b0:215:5935:7eef with SMTP id d9443c01a7336-21c35549f0fmr350115855ad.22.1737626277484;
        Thu, 23 Jan 2025 01:57:57 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3e14aesm108673965ad.195.2025.01.23.01.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 01:57:57 -0800 (PST)
Message-ID: <37a51a1f055f61911f7a4df9e8072f76412ad136.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/14] bpf: Allow struct_ops prog to return
 referenced kptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, stfomichev@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, amery.hung@bytedance.com
Date: Thu, 23 Jan 2025 01:57:52 -0800
In-Reply-To: <20241220195619.2022866-4-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
		 <20241220195619.2022866-4-amery.hung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-20 at 11:55 -0800, Amery Hung wrote:

[...]

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index d9e0af00580b..27d4a170df84 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -386,7 +386,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_de=
sc *st_ops_desc,
>  	st_ops_desc->value_type =3D btf_type_by_id(btf, value_id);
> =20
>  	for_each_member(i, t, member) {
> -		const struct btf_type *func_proto;
> +		const struct btf_type *func_proto, *ret_type;
> =20
>  		mname =3D btf_name_by_offset(btf, member->name_off);
>  		if (!*mname) {
> @@ -409,6 +409,16 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_d=
esc *st_ops_desc,
>  		if (!func_proto)
>  			continue;
> =20
> +		if (func_proto->type) {
> +			ret_type =3D btf_type_resolve_ptr(btf, func_proto->type, NULL);
> +			if (ret_type && !__btf_type_is_struct(ret_type)) {
> +				pr_warn("func ptr %s in struct %s returns non-struct pointer, which =
is not supported\n",
> +					mname, st_ops->name);
> +				err =3D -EOPNOTSUPP;
> +				goto errout;
> +			}
> +		}
> +

This limitation seems unnecessary, if reference leaks are only allowed
for parameters marked with __ref.

>  		if (btf_distill_func_proto(log, btf,
>  					   func_proto, mname,
>  					   &st_ops->func_models[i])) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 26305571e377..0e6a3c4daa7d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10707,6 +10707,8 @@ record_func_key(struct bpf_verifier_env *env, str=
uct bpf_call_arg_meta *meta,
>  static int check_reference_leak(struct bpf_verifier_env *env, bool excep=
tion_exit)
>  {
>  	struct bpf_verifier_state *state =3D env->cur_state;
> +	enum bpf_prog_type type =3D resolve_prog_type(env->prog);
> +	struct bpf_reg_state *reg =3D reg_state(env, BPF_REG_0);
>  	bool refs_lingering =3D false;
>  	int i;
> =20
> @@ -10716,6 +10718,12 @@ static int check_reference_leak(struct bpf_verif=
ier_env *env, bool exception_exi
>  	for (i =3D 0; i < state->acquired_refs; i++) {
>  		if (state->refs[i].type !=3D REF_TYPE_PTR)
>  			continue;
> +		/* Allow struct_ops programs to return a referenced kptr back to
> +		 * kernel. Type checks are performed later in check_return_code.
> +		 */
> +		if (type =3D=3D BPF_PROG_TYPE_STRUCT_OPS && !exception_exit &&
> +		    reg->ref_obj_id =3D=3D state->refs[i].id)
> +			continue;
>  		verbose(env, "Unreleased reference id=3D%d alloc_insn=3D%d\n",
>  			state->refs[i].id, state->refs[i].insn_idx);
>  		refs_lingering =3D true;
> @@ -16320,13 +16328,14 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const char
>  	const char *exit_ctx =3D "At program exit";
>  	struct tnum enforce_attach_type_range =3D tnum_unknown;
>  	const struct bpf_prog *prog =3D env->prog;
> -	struct bpf_reg_state *reg;
> +	struct bpf_reg_state *reg =3D reg_state(env, regno);
>  	struct bpf_retval_range range =3D retval_range(0, 1);
>  	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
>  	int err;
>  	struct bpf_func_state *frame =3D env->cur_state->frame[0];
>  	const bool is_subprog =3D frame->subprogno;
>  	bool return_32bit =3D false;
> +	const struct btf_type *reg_type, *ret_type =3D NULL;
> =20
>  	/* LSM and struct_ops func-ptr's return type could be "void" */
>  	if (!is_subprog || frame->in_exception_callback_fn) {
> @@ -16335,10 +16344,26 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const char
>  			if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
>  				/* See below, can be 0 or 0-1 depending on hook. */
>  				break;
> -			fallthrough;
> +			if (!prog->aux->attach_func_proto->type)
> +				return 0;
> +			break;
>  		case BPF_PROG_TYPE_STRUCT_OPS:
>  			if (!prog->aux->attach_func_proto->type)
>  				return 0;
> +
> +			if (frame->in_exception_callback_fn)
> +				break;
> +
> +			/* Allow a struct_ops program to return a referenced kptr if it
> +			 * matches the operator's return type and is in its unmodified
> +			 * form. A scalar zero (i.e., a null pointer) is also allowed.
> +			 */
> +			reg_type =3D reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL;
> +			ret_type =3D btf_type_resolve_ptr(prog->aux->attach_btf,
> +							prog->aux->attach_func_proto->type,
> +							NULL);

This does not enforce the kernel provenance of the pointer.
See my comment for the next patch for an example.

I think such return should only be allowed for parameters marked with
__ref suffix. If so, pointer provenance check would just compare
reg->ref_obj_id value with known ids of __ref arguments.

> +			if (ret_type && ret_type =3D=3D reg_type && reg->ref_obj_id)
> +				return __check_ptr_off_reg(env, reg, regno, false);
>  			break;
>  		default:
>  			break;
> @@ -16360,8 +16385,6 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno, const char
>  		return -EACCES;
>  	}
> =20
> -	reg =3D cur_regs(env) + regno;
> -
>  	if (frame->in_async_callback_fn) {
>  		/* enforce return zero from async callbacks like timer */
>  		exit_ctx =3D "At async callback return";
> @@ -16460,6 +16483,11 @@ static int check_return_code(struct bpf_verifier=
_env *env, int regno, const char
>  	case BPF_PROG_TYPE_NETFILTER:
>  		range =3D retval_range(NF_DROP, NF_ACCEPT);
>  		break;
> +	case BPF_PROG_TYPE_STRUCT_OPS:
> +		if (!ret_type)
> +			return 0;
> +		range =3D retval_range(0, 0);
> +		break;
>  	case BPF_PROG_TYPE_EXT:
>  		/* freplace program can return anything as its return value
>  		 * depends on the to-be-replaced kernel func or bpf program.



