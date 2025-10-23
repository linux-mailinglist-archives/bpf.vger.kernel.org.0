Return-Path: <bpf+bounces-71859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4CFBFEC3C
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 02:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ADF94E2E25
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 00:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8063C1A3165;
	Thu, 23 Oct 2025 00:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+pmiirx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8781235B154
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181057; cv=none; b=g/cUAmEkL7MKY3FRQuvA+WXrrAIzy6LMxxhhIuJOXh+p9VseMApSWlqjTDB85Z6627kZ9e8ZszH8+m6Bp5lwc10nx+ZyLRCC9y5XEVDp0kPM6TDiSVOH7VAIGNYbQ8jHnKwI15dKjOXZZRlRlBU0YkFTW39hrYigmhbyJAVREXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181057; c=relaxed/simple;
	bh=KeiA21OKMHVHxWBS2SFXZT/vOIC4OQ7sVFDRF6D6368=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=biGWLSB6byhW8Cn8+gTWsXzFRaExFq398jTG1hXUfcpWQPbM4p1SL/pVGiLbssNWKAplITeupADGe4WBOpjr41kB/rTRUMnAvuYwzhjT/Wf01CcExKpLQ7EYmbIentTiGgjh4L3ei2REGNPlnQoDo6xqK6qCJji9RIv/KS+IqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+pmiirx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7811a02316bso178215b3a.3
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 17:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181055; x=1761785855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W2FZ/t+WQN+ebpe5bkA7qAjqtfR2fImIxXm9jF/Fglw=;
        b=H+pmiirxSY9iyup5MRMFT4mepCqSL1Zxoc15IqioE1vIBjiXzGAp/gFZMEjoKd6QOs
         lbQ37XlYbWTPyG6xe7xUu1zSJ8OIMKtvcLCjtPgkgHMR4GBZ8d0ZhAWNmqQZCnQIt6XO
         QAf8my1yvPqBJgug2jlyXlD3fcV2zuWqWWPVPepvQ64SoS+EpKTeMwMECY7lV2Z4Mh1o
         ilTyDLOPLoQiUo0CO4OMnJwa7I1Tjs7Zzvr7E4mgtwqUncQK9L9Mgm6Sh6mEK0geM68c
         a66cy4oFJXbXdYf3M42p1nrNSFGsdulcs0UwxMzrsFtViOkrPLh76wGlJhjGZERmYB1S
         avEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181055; x=1761785855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W2FZ/t+WQN+ebpe5bkA7qAjqtfR2fImIxXm9jF/Fglw=;
        b=cPGWkRYcN/zkaa5bLhkNOtkeC92v/hD3I1I2fqK1KVE2DAYyVDwu4GdF5bgji3CWIm
         BBUSgSOvynAxDQ3ytuyKeZ0z4ONf/zEqbyideUrYAauBCvn1bS0dXl51q46g370dcKue
         Y5lN24rzMjMNiCR2FqWyqXxfl2favocamI+y2qw7FZohQHtPUkz/C+On3lcSVygbTxNa
         u3mDy8KW7jL9NSpeHkyKv+A3vKvh+BxdA4IdBBcxT7qKqdM2xlxpY+Roqz3O0e/ipgRf
         c8xfE5LGAa2/gtfJXZtNEFEThUP9JifIiAqlQvmQm5H2ZMFXq4Ta3tqDrP7NDu/2MloO
         mpNw==
X-Forwarded-Encrypted: i=1; AJvYcCVWcHLVHYW904LFe+wPuYIK5bKNANWkB91tp/FAEAK8hXb2Ssj8XU7aJJjhtS6h8/xAkyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZG5qntVRFV8o0AMUaGXVj/S09P0MSL7+Tti97YC9/5M5VNSDD
	isSC5hZci2MlxNVYVrsJJSjXL6K9BPSit5ywk3Rx6JfI0NIcNi43z6I3
X-Gm-Gg: ASbGncvT9IYcYWdLuHrwDDx4GJ7UIShFrDBnp+ErvMvHCsATzJEZuUwZVn4D0uMDsV7
	k2Nfn268dOIzzdpwFL/kmsAQvIrIwrBU0IxzLgWOYtjq3sHOHRGhwpIkGJrjRxNaZ6pIenr1BDp
	MpCDwujRPVbr09r5YydhblsYAUo74uEhUDlBrysJ/dJJuJBF8vBh5+79d4hohKEXpcA3fLSVZbw
	xnQgjTNSrrHG0erbLaN16WLsaEH/6eTYuWG3Tel/N+RCBGvAlui1zmKc5jjWBnU7sbM3IV/UGhR
	ZcCtEN3mOPw5pUMD/1FCOX4khzh/iyP8yTAwM6WS8u+CJWfS2mShd+7ltCXkU7TaM90BoehmJRm
	5RvW4FV5xPd8V5LpRD4Rm7+IPq45hSShrmQoCKbYnCapjK2IRjNRfT18Rfha735ULom/XQ1rt9s
	8cMVyj36EbUoucZ3wF/5Shm4AaD8DG98A+qYw=
X-Google-Smtp-Source: AGHT+IGIKj6y9FV88U6XCmNmrNc7e0J/LncU7hBeyp9e+rHo6S2D+XxSttGhr5tcx+qEiNEDmmoofQ==
X-Received: by 2002:a05:6a00:a87:b0:77e:f03b:d49a with SMTP id d2e1a72fcca58-7a220a995bfmr26445131b3a.19.1761181054586;
        Wed, 22 Oct 2025 17:57:34 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fa8d:1a05:3c71:d71? ([2620:10d:c090:500::7:b877])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8ac3dsm565677b3a.44.2025.10.22.17.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 17:57:34 -0700 (PDT)
Message-ID: <adb75ea792825e164a4758e40059a677d26694b7.camel@gmail.com>
Subject: Re: [RFC bpf-next 02/15] libbpf: Add support for BTF kinds
 LOC_PARAM, LOC_PROTO and LOCSEC
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Date: Wed, 22 Oct 2025 17:57:32 -0700
In-Reply-To: <20251008173512.731801-3-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
		 <20251008173512.731801-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-08 at 18:34 +0100, Alan Maguire wrote:

[...]

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 18907f0fcf9f..0abd7831d6b4 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[...]

> @@ -588,6 +621,34 @@ static int btf_validate_type(const struct btf *btf, =
const struct btf_type *t, __

offtopic: we should probably switch this function to use field and string i=
terators.

>  		}
>  		break;
>  	}
> +	case BTF_KIND_LOC_PARAM:
> +		break;
> +	case BTF_KIND_LOC_PROTO: {
> +		__u32 *p =3D btf_loc_proto_params(t);
> +
> +		n =3D btf_vlen(t);
> +		for (i =3D 0; i < n; i++, p++) {
> +			err =3D btf_validate_id(btf, *p, id);
> +			if (err)
> +				return err;
> +		}
> +		break;
> +	}
> +	case BTF_KIND_LOCSEC: {
> +		const struct btf_loc *l =3D btf_locsec_locs(t);
> +
> +		n =3D btf_vlen(t);
> +		for (i =3D 0; i < n; i++, l++) {
> +			err =3D btf_validate_str(btf, l->name_off, "loc name", id);
> +			if (!err)
> +				err =3D btf_validate_id(btf, l->func_proto, id);
> +			if (!err)
> +				btf_validate_id(btf, l->loc_proto, id);
                              ^^^^
                       Missing `err =3D`?

> +			if (err)
> +				return err;
> +		}
> +		break;
> +	}
>  	default:
>  		pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
>  		return -EINVAL;
> @@ -2993,6 +3054,183 @@ int btf__add_decl_attr(struct btf *btf, const cha=
r *value, int ref_type_id,
>  	return btf_add_decl_tag(btf, value, ref_type_id, component_idx, 1);
>  }
> =20
> +/*
> + * Append new BTF_KIND_LOC_PARAM with either
> + *   - *value* set as __u64 value following btf_type, with info->kflag s=
et to 1
> + *     if *is_value* is true; or
> + *   - *reg* number, *flags* and *offset* set if *is_value* is set to 0,=
 and
> + *    info->kflag set to 0.
> + * Returns:
> + *   -  >0, type ID of newly added BTF type;
> + *   - <0, on error.
> + */
> +int btf__add_loc_param(struct btf *btf, __s32 size, bool is_value, __u64=
 value,
> +		       __u16 reg, __u16 flags, __s32 offset)

Probably, would be more convenient to have several functions, e.g.:
- btf__add_loc_param_const()
- btf__add_loc_param_reg()
- btf__add_loc_param_deref()

Should `size` be some kind of enum?
E.g. with values like S64, S32, ..., U64.
So the the usage would be like:

  btf__add_loc_param_const(btf, U64, 0xdeadbeef);

Wdyt?

> +{
> +	struct btf_loc_param *p;
> +	struct btf_type *t;
> +	int sz;
> +
> +	if (btf_ensure_modifiable(btf))
> +		return libbpf_err(-ENOMEM);
> +
> +	sz =3D sizeof(struct btf_type) + sizeof(__u64);
> +	t =3D btf_add_type_mem(btf, sz);
> +	if (!t)
> +		return libbpf_err(-ENOMEM);
> +
> +	t->name_off =3D 0;
> +	t->info =3D btf_type_info(BTF_KIND_LOC_PARAM, 0, is_value);
> +	t->size =3D size;
> +
> +	p =3D btf_loc_param(t);
> +
> +	if (is_value) {
> +		p->val_lo32 =3D value & 0xffffffff;
> +		p->val_hi32 =3D value >> 32;
> +	} else {
> +		p->reg =3D reg;
> +		p->flags =3D flags;
> +		p->offset =3D offset;
> +	}
> +	return btf_commit_type(btf, sz);
> +}

[...]

> +int btf__add_locsec_loc(struct btf *btf, const char *name, __u32 func_pr=
oto, __u32 loc_proto,
> +			__u32 offset)
> +{
> +	struct btf_type *t;
> +	struct btf_loc *l;
> +	int name_off, sz;
> +
> +	if (!name || !name[0])
> +		return libbpf_err(-EINVAL);
> +
> +	if (validate_type_id(func_proto) || validate_type_id(loc_proto))
> +		return libbpf_err(-EINVAL);
> +
> +	/* last type should be BTF_KIND_LOCSEC */
> +	if (btf->nr_types =3D=3D 0)
> +		return libbpf_err(-EINVAL);
> +	t =3D btf_last_type(btf);
> +	if (!btf_is_locsec(t))
> +		return libbpf_err(-EINVAL);
> +
> +	/* decompose and invalidate raw data */
> +	if (btf_ensure_modifiable(btf))
> +		return libbpf_err(-ENOMEM);
> +
> +	name_off =3D btf__add_str(btf, name);
> +	if (name_off < 0)
> +		return name_off;
> +
> +	sz =3D sizeof(*l);
> +	l =3D btf_add_type_mem(btf, sz);
> +	if (!l)
> +		return libbpf_err(-ENOMEM);
> +
> +	l->name_off =3D name_off;
> +	l->func_proto =3D func_proto;
> +	l->loc_proto =3D loc_proto;
> +	l->offset =3D offset;
> +
> +	/* update parent type's vlen */
> +	t =3D btf_last_type(btf);
> +	btf_type_inc_vlen(t);

Since vlen is only u16, maybe check for overflow and report an error here?

> +
> +	btf->hdr->type_len +=3D sz;
> +	btf->hdr->str_off +=3D sz;
> +	return 0;
> +}
> +
>  struct btf_ext_sec_info_param {
>  	__u32 off;
>  	__u32 len;

[...]

> @@ -5075,6 +5361,45 @@ static int btf_dedup_ref_type(struct btf_dedup *d,=
 __u32 type_id)
>  		break;
>  	}
> =20
> +	case BTF_KIND_LOC_PROTO: {
> +		__u32 *p1, *p2;
> +		__u16 i, vlen;
> +
> +		p1 =3D btf_loc_proto_params(t);
> +		vlen =3D btf_vlen(t);
> +
> +		for (i =3D 0; i < vlen; i++, p1++) {
> +			ref_type_id =3D btf_dedup_ref_type(d, *p1);
> +			if (ref_type_id < 0)
> +				return ref_type_id;
> +			*p1 =3D ref_type_id;
> +		}
> +
> +		h =3D btf_hash_loc_proto(t);
> +		for_each_dedup_cand(d, hash_entry, h) {
> +			cand_id =3D hash_entry->value;
> +			cand =3D btf_type_by_id(d->btf, cand_id);
> +			if (!btf_equal_common(t, cand))
> +				continue;

Nit: having btf_equal_loc_proto() would have been more readable here.

> +			vlen =3D btf_vlen(cand);
> +			p1 =3D btf_loc_proto_params(t);
> +			p2 =3D btf_loc_proto_params(cand);
> +			if (vlen =3D=3D 0) {
> +				new_id =3D cand_id;
> +				break;
> +			}
> +			for (i =3D 0; i < vlen; i++, p1++, p2++) {
> +				if (*p1 !=3D *p2)
> +					break;
> +				new_id =3D cand_id;
> +				break;
> +			}
> +			if (new_id =3D=3D cand_id)
> +				break;

Why `break` and not `continue`?
Also, BTF_KIND_FUNC_PROTO does not have this special case, why the differen=
ce?

> +		}
> +		break;
> +	}
> +
>  	default:
>  		return -EINVAL;
>  	}

[...]

> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 6388392f49a0..95bdda2f4a2d 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -328,6 +328,9 @@ static int btf_dump_mark_referenced(struct btf_dump *=
d)
>  		case BTF_KIND_ENUM64:
>  		case BTF_KIND_FWD:
>  		case BTF_KIND_FLOAT:
> +		case BTF_KIND_LOC_PARAM:
> +		case BTF_KIND_LOC_PROTO:
> +		case BTF_KIND_LOCSEC:
>  			break;
> =20
>  		case BTF_KIND_VOLATILE:
> @@ -339,7 +342,6 @@ static int btf_dump_mark_referenced(struct btf_dump *=
d)
>  		case BTF_KIND_VAR:
>  		case BTF_KIND_DECL_TAG:
>  		case BTF_KIND_TYPE_TAG:
> -			d->type_states[t->type].referenced =3D 1;
>  			break;

This change seems unrelated, why is it necessary?

> =20
>  		case BTF_KIND_ARRAY: {

[...]


