Return-Path: <bpf+bounces-70352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBADBB842E
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 00:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3654C27E4
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 22:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D8D26A1CC;
	Fri,  3 Oct 2025 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAaIujNX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D53224AF7
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759529328; cv=none; b=Q5SidxehBRQzzjQTDuH9F67mdII3WLq8LIt2gx8rpsLifrPCpNsj1mQgRIfMxqhCyleb90c4rrh4XYpkNjBqhr9I1T8ZXcHsA2wa/rWJobfQ3Bs+ILC0SG3u1Qlrc0w+mzuFSh9m42t07pnY+e4VXRlrR2tTLw5lkWy1jwnaTDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759529328; c=relaxed/simple;
	bh=r1xFmyC37L7LKhAxdCXwfkjHUFIHO+twiLdFV/axnIs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oh5ymSF1Wlt/PvS4qTJ7InH6ruF5Artl3G4NoedRseh3cbx41ih/rfebtzNDKwBJjo21JLu0j7RPSL4dLoYA0BVKmFk93k8l8Q/1JsRoTzHtVBmm1b7dbpRLbqayPVZN16dgE8KyHVZ5EKWYccWl8rtYQEMkleCSOE0qwFUaNvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAaIujNX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so3095867a91.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 15:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759529326; x=1760134126; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TVeLjx3WNso+KxM2dWHLeiGRPC+TnR0apG+PzqZtV5E=;
        b=FAaIujNXmIOzj8sVab6Z4RiLD3ZvA4sSEFU+SS0GuTFg1NBM5NmDBA4kobPE443Iyk
         9LtDX5rmxuiw/kdAaYi6DrhH/oM6h0AbBlOGv+uoPxKy7PslDol9G1VB3QES8BU8O0NF
         UxRZ45hjhiibYIMqBnsz+nDahj86HQbxL8jv9Nlqe4Le0z6DQgZvIOQlpK/0SRg3InQh
         hK/HfDDsMqqxoGmrlo/Irs6JmIxR/SjAQBmlyrOLJNKLij3OwwKKOVyO+PDVPjXLRovs
         DC8gnuf++diV1ciEqv/8FWfLSz2HluAvFgs+tZ1pohB1UXiTTj5YX9z9M6fTvL31ZXk4
         wuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759529326; x=1760134126;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVeLjx3WNso+KxM2dWHLeiGRPC+TnR0apG+PzqZtV5E=;
        b=jz5x/fAAg89iETS3txUW83YECvFhLzvkN8xU+3ZYhcGYRq33e7iZsD2kbXIxPkC3JQ
         ZoJGZJB+DXuStG5RaOs46/1HkyyJDv7YgB4n6NYeajrG+X67Xj/RU+ho4vzV0gkc+QAf
         HuDrRUOB1B+GFzBE+eWBvfrj7nKsnEO0ExPgdJGKRvrf67ViRQm9YjB8s/kWlm6dzNQ2
         Qa+Yk8+4J7Kl3rYeVCIdUjzjNg2Pnv0QH5XvDeVDPyiqi4Jz1yvKkywH1y77P5wEruDS
         NK2DVd/AS5lKNLV+wEIcT/6fHcQcidK2gYVsGBEgDpTeiMsxVph7d8ym26QaxMI5OFsr
         ZVqA==
X-Forwarded-Encrypted: i=1; AJvYcCXz6g24RHia0ylDnET+qenMcx1BYpe5XGDzZ67uHUqhGmV4cGAwjdAqf0Ux20SQW2bQO/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy74Le1Iy2+uqIt2PTPG3LovyzFJRWdetxzT+/yqhNI4KwpM9a1
	kf+sKIznqQq/KKj1DH3LjkLr0OqjmOoUU9uYQ28BJSURJxKvNKuWd6Gn
X-Gm-Gg: ASbGnctF8pF8JmNiNaCVdPKlQvPZpdif4P0MhYofS+i1OdbdE65Et2jUYetElkIQpd9
	PKXcSoOih7YCa7JyY9XhE+B1NtxXvFfRwHdXgYizv3YUI6S/iI37kHCVtRE2INnNAOE/lFUsZuz
	vSqALwhhq+y4n4CKGQRapcXlVrvois0SBKb8K8cSYS1TNwt4ko6KcBRs5ZYOXFqskorVyhOfdpR
	teJd0pNSPqualJjgeK83emdDMgnciGfes67nGi23c4nBbBOb8+9pJLlqNyIqqWr9OMdTQ6ZO+aK
	sqyBXBDdFlWsJyTZDTN2BPLeRuSXwpoSEZgrNAc+ojEUV6tSQvtW7L7VjoIIt1V/fQXp0yjM56w
	psauOpRrm68PNt/qDy0cMKwIfMqi2TKXSPJDlwvtk0AKuLtcUjyOol0d4qsfUkLkes5r7lNoRyc
	j7vTsKDo0=
X-Google-Smtp-Source: AGHT+IG9eJkXh0jsEOW8E8rLGrNT2q2EEq/M6kmpWCcH+KBCwfzwu0CP2mPbSrBaNGU8Ak+1FqR3tQ==
X-Received: by 2002:a17:903:28f:b0:28a:5b8b:1f6b with SMTP id d9443c01a7336-28e9a5a1177mr59626655ad.21.1759529325812;
        Fri, 03 Oct 2025 15:08:45 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d24fdsm60060115ad.93.2025.10.03.15.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 15:08:45 -0700 (PDT)
Message-ID: <bf0c87d7c378f033dd2efc193c86789cfd2604f3.camel@gmail.com>
Subject: Re: [RFC PATCH v1 08/10] bpf: verifier: refactor kfunc
 specialization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 03 Oct 2025 15:08:44 -0700
In-Reply-To: <20251003160416.585080-9-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
	 <20251003160416.585080-9-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 17:04 +0100, Mykyta Yatsenko wrote:

[...]

> @@ -3354,18 +3344,29 @@ static int add_kfunc_call(struct bpf_verifier_env=
 *env, u32 func_id, s16 offset)
>  			return err;
>  	}
> =20
> +	err =3D btf_distill_func_proto(&env->log, desc_btf,
> +				     func_proto, func_name,
> +				     &func_model);
> +	if (err)
> +		return err;
> +
> +	call_imm =3D kfunc_call_imm(addr, func_id);
> +	/* Check whether the relative offset overflows desc->imm */
> +	if ((unsigned long)(s32)call_imm !=3D call_imm) {

This error was previously reported only when !bpf_jit_supports_far_kfunc_ca=
ll().

> +		verbose(env, "address of kernel function %s is out of range\n",
> +			func_name);
> +		return -EINVAL;
> +	}
> +
>  	desc =3D &tab->descs[tab->nr_descs++];
>  	desc->func_id =3D func_id;
> -	desc->imm =3D call_imm;

Nit: no need to move this assignment.

>  	desc->offset =3D offset;
>  	desc->addr =3D addr;
> -	err =3D btf_distill_func_proto(&env->log, desc_btf,
> -				     func_proto, func_name,
> -				     &desc->func_model);
> -	if (!err)
> -		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
> -		     kfunc_desc_cmp_by_id_off, NULL);
> -	return err;
> +	desc->imm =3D call_imm;
> +	desc->func_model =3D func_model;
> +	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
> +	     kfunc_desc_cmp_by_id_off, NULL);
> +	return 0;
>  }
> =20
>  static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
> @@ -21822,21 +21823,32 @@ static int fixup_call_args(struct bpf_verifier_=
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
>  /* replace a generic kfunc with a specialized version if necessary */
> -static void specialize_kfunc(struct bpf_verifier_env *env,
> -			     u32 func_id, u16 offset, unsigned long *addr)
> +static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kf=
unc_desc *desc)
>  {
> +	struct bpf_prog_aux *prog_aux =3D env->prog->aux;
> +	struct bpf_kfunc_desc_tab *tab =3D prog_aux->kfunc_tab;
>  	struct bpf_prog *prog =3D env->prog;
>  	bool seen_direct_write;
>  	void *xdp_kfunc;
>  	bool is_rdonly;
> +	u32 func_id =3D desc->func_id;
> +	u16 offset =3D desc->offset;
> +	unsigned long call_imm;
> +	unsigned long addr =3D 0;
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
>  	}

Note: right after this line there is:

	if (offset)      // this checks if kernel or module BTF is used
		return;

The refactoring changes behavior at this point:
previously if `offset !=3D 0` the `addr` computed for dev bound kfunc
would be assigned to `desc->addr`, after the refactoring this is not
the case.

On the other hand, bpf_dev_bound_kfunc_id() looks up func_id in set8
xdp_metadata_kfunc_ids, that contains functions only defined for
kernel BTF.

Hence, I suggest moving this `if (offset) return` as the first check
in the function, to avoid confusion.

> =20
> @@ -21848,21 +21860,28 @@ static void specialize_kfunc(struct bpf_verifie=
r_env *env,
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
> =20
> -	if (func_id =3D=3D special_kfunc_list[KF_bpf_remove_dentry_xattr] &&
> -	    bpf_lsm_has_d_inode_locked(prog))
> -		*addr =3D (unsigned long)bpf_remove_dentry_xattr_locked;
> +	call_imm =3D kfunc_call_imm(addr, func_id);
> +	desc->imm =3D call_imm;

Nit:	desc->imm =3D kfunc_call_imm(addr, func_id);

> +	desc->addr =3D addr;
> +	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
> +	     kfunc_desc_cmp_by_id_off, NULL);

Why sorting again?
Neither `func_id` nor `offset` fields change.

>  }
> =20
>  static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *in=
sn_aux,
> @@ -21885,7 +21904,7 @@ static void __fixup_collection_insert_kfunc(struc=
t bpf_insn_aux_data *insn_aux,
>  static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_ins=
n *insn,
>  			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>  {
> -	const struct bpf_kfunc_desc *desc;
> +	struct bpf_kfunc_desc *desc;
> =20
>  	if (!insn->imm) {
>  		verbose(env, "invalid kernel function call not eliminated in verifier =
pass\n");
> @@ -21905,6 +21924,8 @@ static int fixup_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>  		return -EFAULT;
>  	}
> =20
> +	specialize_kfunc(env, desc);
> +
>  	if (!bpf_jit_supports_far_kfunc_call())
>  		insn->imm =3D BPF_CALL_IMM(desc->addr);
>  	if (insn->off)

