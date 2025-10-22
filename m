Return-Path: <bpf+bounces-71653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A100BF97E7
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 02:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 751834EC287
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 00:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D961D5CEA;
	Wed, 22 Oct 2025 00:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVEOcPx3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41921D61B7
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 00:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093747; cv=none; b=cIO7zGj77taapE0+18WF+qigS3XTCXP9jy/OP+9umUzAoGcx9myWosk+9uSeYeC0+PoS5kyv+mOYBRd0CPPWUufNg0wsmNwb3LQA+nAYKU/kqdtniMxvUelSbU8muzLuP7wYbZvRbQm94PbQ4R8lreth+tJGzUjeKJZMAtrzaUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093747; c=relaxed/simple;
	bh=7BO/SowVxnVUXFxGKoVHqISgr3TYjOEK3z2N++DDj5k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C8ZfQigi5IlNZH/+mSOis/MkF91CF9gOln9LVeM6yg0LLtGDhoDYzDfLp/E5AlRJKvQltyakXZZ43OfBvnf9AeRw6dDk8piiGNT0IZ/t318VMDm73wfIw5ns9KvGB4XvSPKPKnBr0Tk25ERQm1/tzV4qLexBZtFv62b1UW+isXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVEOcPx3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so5551625a12.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 17:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761093745; x=1761698545; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J2ktlfSzG9oFRjddVn5XSB4n2njoKlWzGRGcRgwrJcU=;
        b=bVEOcPx3flxV2QpQwoeg3SfyiQgmPCp0fMAxU1Q5and6+ndYIUo9szYnMAYednEuyH
         xSOoRq6yHISfkytj7TndNL1gVQ5+PESM+a36i/Pj36RGv/LbH8XNu7EXEoDWdhCKeDea
         sMWDON84qiGNNJ0fvNA9IEE6mdK6fscCyEPNIdsE0X4MwAKr7cFUN2coDH+XGrEw7G3M
         oWFdQ6MYbDKgwU1tc32F4jRoYteb0RTSShZVUHKosim57Ly6RkhVYLuE+/YmasXjYTll
         K3b3Y8GXvjyDAuUhyvKgkY0813vdroD8lagCrFzuGGE12UBVhMRxfeeXosZyODtgKHme
         7LAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761093745; x=1761698545;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2ktlfSzG9oFRjddVn5XSB4n2njoKlWzGRGcRgwrJcU=;
        b=eWW/Kzcrx5W7ibgtVfda6XOxadTFD6Z2l3WzrC1ZiX5N0YYtvoge/B3040ndmjwx1v
         qFu5lVjvQB2B6WORjHXDEm0Q2zeja+Cwpmek1tHPpEH3Qx4ktFTe062ZZunt+n9FFHlw
         uamjIMhMR/I29akrhJkkoCisJVYR5Y6Bjs+glOKs4JCTBOaWgSOjJC7hZS6IKyzRtiiC
         HyAX2AgeGZ+93G1TC68mvLe0BQmxJFvpkE4x3iGLv29ut4cwqa5aKti0ntmo+4WQ2a5K
         V9LFgpSoCH7/vGng+I5SaPInLEWM5pOVe/XNOgfgpepuhnNP0J3yKsuymdUA3YGNMabA
         m0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/ALX+gigR7JnRMRANO5NCP+DiptIAHf2/A5GKg21gMk/JGLI/xZhaUiUIxRMJREaL2N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypOj+YSbJtNZxVRh/AGAzmRFfeYxBr4JFRzQ113xo9UKuD8BS8
	fwb18J6xBD6HeWxUeSPw5+vp8Io+jENPPB0D36mm5hPxD5KSFLye240b
X-Gm-Gg: ASbGncuNYBRb4v70Z8uw713fv16A74dWOXlEeBZHd5sBtGw3Dn9oLbUu1ua7grSUSbb
	WEUS/gJqydZ1VkSEWRfrOzWuK+W4Amir7YL2FnJl586VQhK/DRFMc1VTxIt2STFYj4gE7AxBZWq
	U/0H6EeZjnlLXUtxgtpA4PTn0yzrxpSyH6LAsXrpb0qVzYCokYe/2L/Av1Fs1UnI/nL1vvypE5d
	iSGXgdvqQWaLABtDkMdrNItyg4BbEj7/tY9KprDn14d3qrTgmGBNB2upoIiF7x3GOKyJrHsi+wP
	5EICM8kfuG3gyzM9WqUuayI+bYnmVnSn+5Npldv9kljpfjAsrVXafnUiFj2qHf+BQ1lAxDGFz5+
	ZKEWp4g832IZ7E2L78Tp31khK6fCQqUu/Rw3BVdQWh8GMbEnPG+ca9JN+KLF/FxqzleRZeq+PHU
	P+/ViuBTTo6rVCNM//wRlhrYEgyB9P8fwjgbA=
X-Google-Smtp-Source: AGHT+IGHus4xSlZTd7ftwgx5U/B9+vdmVt+b6nLYiL731SUNIrZyigNMCE20WSlnHpfTSil+kEfXgg==
X-Received: by 2002:a17:902:e543:b0:269:4741:6d33 with SMTP id d9443c01a7336-290c9d3740dmr234057695ad.23.1761093745080;
        Tue, 21 Oct 2025 17:42:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224a2652sm797640a91.18.2025.10.21.17.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:42:24 -0700 (PDT)
Message-ID: <5f873de5d22d95133aedf31e4b2e1d81cfca4647.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 08/10] bpf: verifier: refactor kfunc
 specialization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 21 Oct 2025 17:42:23 -0700
In-Reply-To: <20251021200334.220542-9-mykyta.yatsenko5@gmail.com>
References: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
	 <20251021200334.220542-9-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 21:03 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Move kfunc specialization (function address substitution) to later stage
> of verification to support a new use case, where we need to take into
> consideration whether kfunc is called in sleepable context.
>=20
> Minor refactoring in add_kfunc_call(), making sure that if function
> fails, kfunc desc is not added to tab->descs (previously it could be
> added or not, depending on what failed).
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -3126,6 +3124,10 @@ struct bpf_kfunc_btf_tab {
>  	u32 nr_descs;
>  };
> =20
> +static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_id=
);
> +

Nit: this prototype is no longer necessary.

> +static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfu=
nc_desc *desc);
> +
>  static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
>  {
>  	const struct bpf_kfunc_desc *d0 =3D a;

[...]

> @@ -21861,47 +21852,62 @@ static int fixup_call_args(struct bpf_verifier_=
env *env)
>  	return err;
>  }
> =20
> +static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_id=
)
> +{
> +	if (bpf_jit_supports_far_kfunc_call())
> +		return func_id;
> +
> +	return BPF_CALL_IMM(func_addr);
> +}
> +

Nit: this can now be inlined in specialize_kfunc().

>  /* replace a generic kfunc with a specialized version if necessary */
> -static void specialize_kfunc(struct bpf_verifier_env *env,
> -			     u32 func_id, u16 offset, unsigned long *addr)
> +static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfu=
nc_desc *desc)
>  {
>  	struct bpf_prog *prog =3D env->prog;
>  	bool seen_direct_write;
>  	void *xdp_kfunc;
>  	bool is_rdonly;
> +	u32 func_id =3D desc->func_id;
> +	u16 offset =3D desc->offset;
> +	unsigned long addr =3D desc->addr, call_imm;
> +
> +	if (offset) /* return if module BTF is used */
> +		goto set_imm;
> =20
>  	if (bpf_dev_bound_kfunc_id(func_id)) {
>  		xdp_kfunc =3D bpf_dev_bound_resolve_kfunc(prog, func_id);
> -		if (xdp_kfunc) {
> -			*addr =3D (unsigned long)xdp_kfunc;
> -			return;
> -		}
> +		if (xdp_kfunc)
> +			addr =3D (unsigned long)xdp_kfunc;
>  		/* fallback to default kfunc when not supported by netdev */
> -	}
> -
> -	if (offset)
> -		return;
> -
> -	if (func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_from_skb]) {
> +	} else if (func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_from_skb]) {
>  		seen_direct_write =3D env->seen_direct_write;
>  		is_rdonly =3D !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
> =20
>  		if (is_rdonly)
> -			*addr =3D (unsigned long)bpf_dynptr_from_skb_rdonly;
> +			addr =3D (unsigned long)bpf_dynptr_from_skb_rdonly;
> =20
>  		/* restore env->seen_direct_write to its original value, since
>  		 * may_access_direct_pkt_data mutates it
>  		 */
>  		env->seen_direct_write =3D seen_direct_write;
> +	} else if (func_id =3D=3D special_kfunc_list[KF_bpf_set_dentry_xattr]) =
{
> +		if (bpf_lsm_has_d_inode_locked(prog))
> +			addr =3D (unsigned long)bpf_set_dentry_xattr_locked;
> +	} else if (func_id =3D=3D special_kfunc_list[KF_bpf_remove_dentry_xattr=
]) {
> +		if (bpf_lsm_has_d_inode_locked(prog))
> +			addr =3D (unsigned long)bpf_remove_dentry_xattr_locked;
> +	}
> +
> +set_imm:
> +	call_imm =3D kfunc_call_imm(addr, func_id);
> +	/* Check whether the relative offset overflows desc->imm */
> +	if ((unsigned long)(s32)call_imm !=3D call_imm) {
> +		verbose(env, "address of kernel func_id %u is out of range\n", func_id=
);
> +		return -EINVAL;
>  	}
> -
> -	if (func_id =3D=3D special_kfunc_list[KF_bpf_set_dentry_xattr] &&
> -	    bpf_lsm_has_d_inode_locked(prog))
> -		*addr =3D (unsigned long)bpf_set_dentry_xattr_locked;
> -
> -	if (func_id =3D=3D special_kfunc_list[KF_bpf_remove_dentry_xattr] &&
> -	    bpf_lsm_has_d_inode_locked(prog))
> -		*addr =3D (unsigned long)bpf_remove_dentry_xattr_locked;
> +	desc->imm =3D call_imm;
> +	desc->addr =3D addr;
> +	return 0;
>  }
> =20
>  static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *in=
sn_aux,

[...]

