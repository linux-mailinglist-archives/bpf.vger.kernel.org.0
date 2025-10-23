Return-Path: <bpf+bounces-71858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA6DBFEC39
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 02:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF2E14E465E
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 00:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58D17483;
	Thu, 23 Oct 2025 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZkS7mei"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F681891A9
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181023; cv=none; b=cO08BTyowZiDbmJT5tZdr4dS/tRagk9wK7ZkNwAuiCuJqvKDCNVJMtOpLmdEj33da/c2ZiqRsmijoui3LA2Rz6dqjEkXrquCM2D/eABmdwbD0ZtSU9sEIlqC8BFOelKKJoijohBNa6Fr8o35TRUU/IHSTslAFAkq7yFION6dtkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181023; c=relaxed/simple;
	bh=cMRrsSoUCKVN272+zUrBcFfVfKdMzsflpJn5+RK/ni4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QMkGEUCqeruDK4PwNUuKT4bYbHfYbcW2kj5egsLP+Xx2x09zfKN817YsjjtdQy+3ua2qBslY2hIsG8C4PPZpOYxEZA8KQi+TMaMgWQ4FsDcBq3U280ZbDl04SA/dYOgChGL/s2viYDsmJW8eXaNQdu9sLVarR7DnO1jiSLNHibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZkS7mei; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so2813305ad.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 17:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181021; x=1761785821; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L7EKnyBeh0jONdCQLwZ24E1aRwyCcjKTqUSkMS6hbrg=;
        b=UZkS7meiBaEounjwQunFkIOanTScRQy2/UnHlDMaG+ChGVWPLVXKc8RDHGf3VLLaXW
         08CeDq1GZyo2p/oh2A4oomiqDYABs1s/JYF7Gbn6GXYrjXm9M6VhLS00TmGbIzQJ0N2R
         3aoAZxTT9hJJfo5Q2ghEq+j0UWDi4asa1RYI+NWVlFLWA6RGK7uFhL3d2K56wvPjBNKa
         26AWqjSA6BtnkSUc9Xs9o0QaEIsHCjNkfl2to1NJ1hoKF/Okv/T/oNNQ9Lc17ejAcrAS
         5KWOSe6vJ1XaycjGV1c4gQWhJymQA2fp2LpOErWmknNS40H1L1jgaYBVLJeflCOL+0Z/
         D1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181021; x=1761785821;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7EKnyBeh0jONdCQLwZ24E1aRwyCcjKTqUSkMS6hbrg=;
        b=R/dKyt8pFw4dffpoT3zFUgG0CP5WQnTvMnCwAckgvYgywAYUZ1GG+Azcp0VFlcFyYv
         sojjhrjdGLin3bG9utZXkkYsWPBAhTkcpvnU4S2klGxzbRMU22c+22aw30ob3AoHJvQI
         B6as0trXFx3SA69lHnCG7vtAl2hgGaCSDZUZdmcMZDg14c3dwQmLZMQpxeEJACPaIjQ7
         Vi6r/8GpVRD2diU0nRLAie6+Ku9iVJuNRzirKChWGXCM22gzahKV6K3g0TujKZ6X9Gsk
         fIXDCdj9Wp3r/s7Rn/CzcK0x8GMyXhmBZdDbBNfN2qFVv3EygIfK3pjHKKbMTxTwBiTa
         gihA==
X-Forwarded-Encrypted: i=1; AJvYcCXXtR84Yyg05JI0DK4y9B/ermMS5T1RWOQAjeDB18HpVKLJ4g4+MaBRSG/wMIPb9yXQm6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjrhFO4BFNShQXc+fBTOjpS3uNMOi40iuufGrbZVvigNaYFZvh
	H6gX9vWYguyhnEpxk9j9Zp30npIyTzw9eI0wvB3O7OHedG8/ullAzwuf
X-Gm-Gg: ASbGncuPDj+swcRi1sqzGcfAEDpvgcb3HxYckeYR33JMroz5lU5wr4h72QMaNHW8uuQ
	OCvPxN7585FJjFQOJECFnogXxBBr8WpsjxBNrKgFINmlQEaWLucSIhMbW1VfByzBwvM9Yv8qHyq
	cS2mHzTsjsNUghnOb0yu0VnCODDyQAG/1SSXt501RlnhebC5df7OOy4CyqSZUomaMvw4Ut8s2ON
	gsI9hypKh/yMSNxWp2W8KK9WzBb1fZN54JoRitPbxm6NAjU4fMPMZecAs/z0rnnstpOdBOgbQvB
	fDBTZnPPJSeU7MfDljTKcABK2lOAEhVIEsc+h64lteiUGTox7iTKsydcJIDT5xlNKxbuiTnrIYF
	H0/2qSuqO0ta4nWadBlmljSJEX+N1pCNvRbJ2qEylIxcIx5zWW3eVxoMVzX7vU2UheWyhaBge8m
	zWE5OiXdLGqMV/2+QBiQli9XYYIY6n9DeKBts=
X-Google-Smtp-Source: AGHT+IFb4obnKXDqBY+g5WJSO2SBBcOBNb+s5DQi2tBL/aLUZjx2MpT0JXgIbiGQ/WOMRBlUJ0/weA==
X-Received: by 2002:a17:903:138a:b0:290:9332:eebd with SMTP id d9443c01a7336-290c9cf90b5mr261337535ad.10.1761181020913;
        Wed, 22 Oct 2025 17:57:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fa8d:1a05:3c71:d71? ([2620:10d:c090:500::7:b877])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda72e8sm4553365ad.9.2025.10.22.17.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 17:57:00 -0700 (PDT)
Message-ID: <531305ee76a5ef186b1204dc8281ebc7ebb2b1c0.camel@gmail.com>
Subject: Re: [RFC bpf-next 01/15] bpf: Extend UAPI to support location
 information
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Date: Wed, 22 Oct 2025 17:56:57 -0700
In-Reply-To: <20251008173512.731801-2-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
			 <20251008173512.731801-2-alan.maguire@oracle.com>
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

> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index f06976ffb63f..65091c6aff4b 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h

[...]

> > @@ -552,7 +579,7 @@ struct btf_field_desc {
>  	/* member struct size, or zero, if no members */
>  	int m_sz;
>  	/* repeated per-member offsets */
> -	int m_off_cnt, m_offs[1];
> +	int m_off_cnt, m_offs[2];
>  };

Should this be a part of patch #2?
Commit message of the patch #2 explains why its needed.

> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 266d4ffa6c07..a74b9d202847 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h

[...]

> +/* BTF_KIND_LOC_PARAM consists a btf_type specifying a vlen of 0, name_o=
ff is 0
> + * and is followed by a singular "struct btf_loc_param". type/size speci=
fies
> + * the size of the associated location value.  The size value should be
> + * cast to a __s32 as negative sizes can be specified; -8 to indicate a =
signed
> + * 8 byte value for example.

Not sure it matters after Andrii's suggestion, but I find this
description a bit cryptic. Maybe just note that (s32)(t)->size
can be -8, -4, -2 for signed values, 2, 4, 8 for unsigned values,
and its absolute value denotes the size of the value in bytes?

+1 to Andrii's suggestion to use enum to represent btf_loc_param "tag".

Also, what register numbering scheme is used?
Probably should be mentioned in the docstring.

> + *
> + * If kind_flag is 1 the btf_loc is a constant value, otherwise it repre=
sents
> + * a register, possibly dereferencing it with the specified offset.
> + *
> + * "struct btf_type" is followed by a "struct btf_loc_param" which consi=
sts
> + * of either the 64-bit value or the register number, offset etc.
> + * Interpretation depends on whether the kind_flag is set as described a=
bove.
> + */

[...]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0de8fc8a0e0b..29cec549f119 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[...]

> +static void btf_loc_param_log(struct btf_verifier_env *env,
> +			 const struct btf_type *t)
> +{
> +	const struct btf_loc_param *p =3D btf_loc_param(t);
> +
> +	if (btf_type_kflag(t))
> +		btf_verifier_log(env, "type=3D%u const=3D%lld", t->type, btf_loc_param=
_value(t));
> +	else
> +		btf_verifier_log(env, "type=3D%u reg=3D%u flags=3D%d offset %u",

Nit: print flags in hex?

> +				 t->type, p->reg, p->flags, p->offset);
> +}

[...]



