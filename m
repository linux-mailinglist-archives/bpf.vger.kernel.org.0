Return-Path: <bpf+bounces-71051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F06BE0AF2
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 22:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83ACD4F0204
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 20:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D5A2C11F9;
	Wed, 15 Oct 2025 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHrj4NpR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E653254BB
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760561204; cv=none; b=R6riNlVfhl7Z/9iV76XezXKQT1TmYRE1yp/+2FdcfPOpqzmj0MyqU0+sNUPy1PzaFXsnNcLASHRwplQ2A9XZrE6+xCoDFBjAeKEXc+jlCsZn6grRO3rZWah5XMuHHRb/ziywfWeW1IU7ZuFjtmfvGT3b04RYWrFEL3XDZMei1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760561204; c=relaxed/simple;
	bh=6OSb0R3nmRQ3fxpGKRiYJRabZSOkLtpKj6MAjhA3cNs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cmgVaYrRdQh/vBaFHiRTkMdQh3wDMDaRXIIbxZcuWpinVRjPT6WYQcifAPnMvCeaPW49E2FXNQSHB3Bb9Vmi/igboXi5ZQ5SFkZlo8ecNa887Vbaz+0s08OTVgpAcAtMOTJq9hIA6EvN5bdEvJzs8LjSkne66Q7DCuRKRjHONlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHrj4NpR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso1654745a91.0
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760561202; x=1761166002; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jNvgsEBtxzuZPg6c97y7Dp9GEWMlmcWM7YcGevkToTw=;
        b=kHrj4NpRleVvhxVnXBfh8pHcvv3lTdI86IYyuUMtCTmnZC2U79ahJzG3XfpjLsHcGQ
         UOKLVYdYIYSMKw/2nWEO9UI7MtMi4vI1trL/9KvUsdJQQNhhwtTEgDjSyjv2pCGIZmHt
         kXBM/oy8/VSiNcyJy0OOYTbCJKaBoQnGHr8Giv1E3uwO+Jpq4G8st/hFP8lA0jCkUttI
         JXgZMcHNTlvM3Nwvbzt5NFRAaL1ndkNtULhRBQFGhoeE44xn2lFBHt8QgAS9ya0nJKfn
         bmtk3j3EpXUSJW+Ahtt2TYFk2sGP2w1R11y3n85UodK0A8Jw72EjTazbMlvKuCaHjqru
         /bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760561202; x=1761166002;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNvgsEBtxzuZPg6c97y7Dp9GEWMlmcWM7YcGevkToTw=;
        b=DtXQ4a1LPKXG8+creECBwG9uuFcNQK6DihWe2hWauDqAahcr12e2LQT9zHIvQq/XKO
         vFGBZue5Sci6Jpe/jhe4VvGl0R/NsWTE81VevCoiBhiNr7Td9DB9WC/XSX3hOdmELBYw
         brFUcD9vdNS7xPM9+ezh1MmZA3m76lG/qjJ2icx+2/iwhW/y1EyBuhqPx4yu4mKkd0UG
         Eywq6g8sv8i6nYabr5h5tYPEOq7QDsp1hmiyWEVQugJaRSoUzDxBG5CZIo9oMtKzO1Yg
         uJdLLR+4kY8guWJ3P9glLTr0kxvspJSH2nVn5kYrjjAm0ntOnuMrk2Dk6JjOnRbu5Ywj
         NxoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhI/0SS/CjofvZ/67Jdr1kf1XbiqAtW38IrRlwe/4KrtB9y5HVX5JwjWBTzASg9kinDDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoBo+Y8qRf6tfwnOaDm5EmG4nj1BzOsmi4dFPZPnDKvol0T3tG
	fSWo1KedodVh4yMH+GSEuFvAyn0q7O9P96EWo78BeTa6uq2cjaaW0Ghk
X-Gm-Gg: ASbGncvDSM9WtjtO4B+GomSeoeN/OcdRimaOZSw7vbkgXe5kx/6PfMA1FBZnfFCNqMl
	J86bmZwbS+gJxociV24L2VQGy5g7rSNyDYDSyZS6jTzO+vYhzC8hfHWMDXrX/z1xhixM7TfjN5D
	qh/hZoVEq9CTyxC13rlQNVHXSDeBLMFWft/xgP3PDVrAluCFsvMemdamhSGH276Z/68YlWVOhOg
	QP9sV/7HxhaYqU2eN4r0stBJSxx6wltEGhG/5ToMJwmdoSk+W57Z/Nzmu8gfi0PE37l9ihjhUOl
	367CASk1hmVuenf+EGpCuD0BbM2B7aeMvVF7JAKCB6GXr2RQCXO3MvtQUFwne1nh362vrcp8DU/
	Uk4Mv9JT9PACfbFW7HgCox/wBTPDivWZ9OR9uyaCezeA9jIW8e7hZRo/pxn9ghlmZpqGYkL23cQ
	==
X-Google-Smtp-Source: AGHT+IE9lcbMYhTRvT7+oKs5db6vZBFD+Q7zvx1gJKdsoEm1EaMAMVBzoyIzDJ4p1wQOCU4cVfVefw==
X-Received: by 2002:a17:90a:d004:b0:32e:8ff9:d124 with SMTP id 98e67ed59e1d1-33b9e24efe5mr1761748a91.15.1760561202465;
        Wed, 15 Oct 2025 13:46:42 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a228a5b5csm521276a12.13.2025.10.15.13.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:46:42 -0700 (PDT)
Message-ID: <7157c18502fb9b17a28ad397073b7ec74a545e79.camel@gmail.com>
Subject: Re: [RFC PATCH v2 09/11] bpf: verifier: refactor kfunc
 specialization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 15 Oct 2025 13:46:39 -0700
In-Reply-To: <20251015161155.120148-10-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
	 <20251015161155.120148-10-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
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

Lgtm, but I think ai caught a real bug.

[...]

> +static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kf=
unc_desc *desc)
>  {
>  	struct bpf_prog *prog =3D env->prog;
>  	bool seen_direct_write;
>  	void *xdp_kfunc;
>  	bool is_rdonly;
> +	u32 func_id =3D desc->func_id;
> +	u16 offset =3D desc->offset;
> +	unsigned long addr =3D 0;
> +
> +	if (offset) /* return if module BTF is used */
> +		return;
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
>  	}
> =20
> -	if (func_id =3D=3D special_kfunc_list[KF_bpf_set_dentry_xattr] &&
> -	    bpf_lsm_has_d_inode_locked(prog))
> -		*addr =3D (unsigned long)bpf_set_dentry_xattr_locked;
> +	if (!addr) /* Nothing to patch with */
> +		return;

Nit: move this to a final else branch?

        } else if (func_id =3D=3D special_kfunc_list[KF_bpf_remove_dentry_x=
attr] {
                ...
        } else {
                return
        }

> =20
> -	if (func_id =3D=3D special_kfunc_list[KF_bpf_remove_dentry_xattr] &&
> -	    bpf_lsm_has_d_inode_locked(prog))
> -		*addr =3D (unsigned long)bpf_remove_dentry_xattr_locked;
> +	desc->imm =3D kfunc_call_imm(addr, func_id);
> +	desc->addr =3D addr;

I think ai review is right here, overflow check after specialization is mis=
sing.

>  }
> =20
>  static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *in=
sn_aux,

[...]

