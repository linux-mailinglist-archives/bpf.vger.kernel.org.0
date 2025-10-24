Return-Path: <bpf+bounces-72138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D25BC079A4
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 19:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BDC3B77DA
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 17:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8BC328613;
	Fri, 24 Oct 2025 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYjA7c6L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA21A9FBC
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328520; cv=none; b=M4WCdARjVacHYnLBVfIza/X010e9MKkcKc8VdWVEL/lql1GNoDVS1c6Y4NV/9K9kcKtKQcaln4cM9VQe01yByLRMfATja/0sxYGLPispyMKkC0dSTNPyJX8jeMXDhezY/iEcukllkMZJ0m6jqA5kBIuo408wAof8ofzDBxQe65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328520; c=relaxed/simple;
	bh=/jJJJ+v+YjmCg2+3yHXWe5vZ3gIZ/Okbka3aQUQHr1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V8oT3I+uuKeGf8cmxCnvaz/zqLPvvR0wb/IvPKk1pEKIgfTE2Nod2uGCS+M/5uEgNFQPzuS7JGf+LxMVNc6qnoJo6vBus/iY7P0ez6Mj0gAqbuUw+bfZfExK8W6e/QxLeoXVwe0OjuE9DVk2gtH2v9se9JaDHc4f2DDoUsRFm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYjA7c6L; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so2079557a12.1
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761328518; x=1761933318; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aISeqrqEtxinQqMm5Av+qyK0EGiBEhmSqEbOhF7dUSk=;
        b=JYjA7c6Lho2ejbinK/5RbgF+zzPN4lQD4+OTeRHa80AnbKCtpdpC6D1Jmh4nxEjRep
         GpICFKdqWTVxjYSd54dur6eFjHe4Iw7OXnMlQv0vV5hYhFzYurSvZYZHRL6R0d/YHMcI
         jiJ0jy2BEUS7JcSCsZw2R5Qgl5Y9/7RKDf9TBHBxyHNV2wkeXdHhe5u09yE+OuGCHXUz
         xYf5G5NZCFk3wvT+XdRwqySlTVhKEqDsym1kAbg1zq3IvsxUP/sY9KyiNWqPATkezWS4
         KbBFnFcYkTp83Vjym+/x4udxxLziKYhPBsoyoKX6T85yWg0JQGj8yNt7XEgPl4547Pdg
         wbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328518; x=1761933318;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aISeqrqEtxinQqMm5Av+qyK0EGiBEhmSqEbOhF7dUSk=;
        b=oFP2G10cmmum9SCAlI6QwmObpPXH1FnBJ3nqCtsalfSN+MjbkM9SZUDSm31gJxnB05
         WFpXTymMUEXlIve95PhQx+2+NYtyJAgZP/2MJSIInMyzHUnT9vMcuz8glRwYPMw5BJ/q
         97czPES5wkOBK2aP8RMFOUWrpVFrjoWSB6XloM3oDCj5IDN9/Kh3Jdm+gqx0QKza14QS
         /SUpHqqRC0QZ02N40WJ4vi7IMnDwD72bOEC9Z3hYGGQygomLiLMj/XAFjVzd21CSEbfN
         HtpdGo+dqi/y7u8LLNJU735QkDB2INkvd8XDt0WmuHxjdGkU8++NFAZOJkeQ7ekAvv4W
         nWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7v9PyflGKcXZwW8gv/Z/bsYcftcDk1w4uN0W+5VPMqTM1Zb1MSOgeajryTvQiCkWWkh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUTgvo/g+w/pHXDXx36AeGKp91IOv4M3j+Zi3tt+eIWULvikHW
	BwZUKsc1lEWc2HS/QjKC1NBCTk2m9oa6nIJeoag8NK+WjoBBt1LMR9LL
X-Gm-Gg: ASbGnctkZHICenVACRKxQBi2RybvuttEGwAgTyU3jtQoABSAQHpHkeDFcLwB7GLi+hA
	I8Jmk961DlEwlhMtzhAFQJqqcQrkVjhKqqwF2VVrzx8MfR2A9rP5m1oSGfLph3Xqr9p2srNSpu6
	QBRoJHp5hXUMUgHA6jJxWeJNa/RkueTXyLhBh2OrN+URqvrzhevsqbAgYwW7HOQoC7jBe1csm9D
	vT7iz70m1paw2ksvYW9iVilBg5JvkpyftQFORXf/Z9o8WPiSC/SVSHlUWIcdslGdzeWgsjjhrmH
	Y3EHR1SXTUSPXFb592RBycn4Yk+WnY0JuKQIgMX8G+YGf8ZD82a13lu0uwmcIOiQJRO9bQwQm15
	drEJzGT0EEf+7Aaqw3GXcjda47AHHyb/Ot66dLUSVjfPzUYP7pZOHuWw8btCcNz7PH1lr/FlF8M
	LcNzTTucVD
X-Google-Smtp-Source: AGHT+IEGQajunhLpXH2LXQtLwzBmvMkkLfatr7nq1+E1YrtjuUO+Om+xmITDCZzB/aQeKHONagFUBQ==
X-Received: by 2002:a17:903:2290:b0:26a:23c7:68da with SMTP id d9443c01a7336-2948b9ad6d0mr31574425ad.25.1761328518136;
        Fri, 24 Oct 2025 10:55:18 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ded7c8bsm62308445ad.22.2025.10.24.10.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:55:17 -0700 (PDT)
Message-ID: <6558dc0590b174174321899af9981053db76845c.camel@gmail.com>
Subject: Re: [RFC dwarves 3/5] dwarf_loader: Collect inline expansion
 location information
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	acme@kernel.org, ttreyer@meta.com,
 yonghong.song@linux.dev, song@kernel.org, 	john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org,
 qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Date: Fri, 24 Oct 2025 10:55:14 -0700
In-Reply-To: <20251024073328.370457-4-alan.maguire@oracle.com>
References: <20251024073328.370457-1-alan.maguire@oracle.com>
	 <20251024073328.370457-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 08:33 +0100, Alan Maguire wrote:
> Collect location information for parameters, inline expansions and ensure=
 it
> does not rely on aspects of the CU that go away when it is freed.
>=20
> (This is a slightly differerent approach from Thierry's but it was helped
> greatly by his series; would happily add a Co-developed by here or
> whatever suits)
>=20
> Signed-off-by: Alan Maguire <alan.maguire>
> ---
>  dwarf_loader.c | 277 +++++++++++++++++++++++++++++++++++++++----------
>  dwarves.h      |  48 ++++++++-
>  2 files changed, 266 insertions(+), 59 deletions(-)
>=20
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 4656575..a7ae497 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1185,29 +1185,54 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attri=
bute *attr,
>  	return ret;
>  }
> =20
> -/* For DW_AT_location 'attr':
> - * - if first location is DW_OP_regXX with expected number, return the r=
egister;
> - *   otherwise save the register for later return
> - * - if location DW_OP_entry_value(DW_OP_regXX) with expected number is =
in the
> - *   list, return the register; otherwise save register for later return
> - * - otherwise if no register was found for locations, return -1.
> +/* Retrieve location information for parameter; focus on simple location=
s
> + * like constants and register values.  Support multiple registers as
> + * it is possible for a value (struct) to be passed via multiple registe=
rs.
> + * Handle edge cases like multiple instances of same location value, but
> + * avoid cases with large (>1 size) expressions to keep things simple.
> + * This covers the vast majority of cases.  The only unhandled atom is
> + * DW_OP_GNU_parameter_ref; future work could add that and improve
> + * location handling.  In practice the below supports the majority
> + * of parameter locations.
>   */
> -static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
> +static int parameter__locs(Dwarf_Die *die, Dwarf_Attribute *attr, struct=
 parameter *parm)
>  {
> -	Dwarf_Addr base, start, end;
> -	Dwarf_Op *expr, *entry_ops;
> -	Dwarf_Attribute entry_attr;
> -	size_t exprlen, entry_len;
> +	Dwarf_Addr base, start, end, first =3D -1;
> +	Dwarf_Attribute next_attr;
>  	ptrdiff_t offset =3D 0;
> -	int loc_num =3D -1;
> +	Dwarf_Op *expr;
> +	size_t exprlen;
>  	int ret =3D -1;
> =20
> +	/* parameter__locs() can be called recursively, but at toplevel
> +	 * die is non-NULL signalling we need to look up loc/const attrs.
> +	 */
> +	if (die) {
> +		if (dwarf_attr(die, DW_AT_const_value, attr) !=3D NULL) {
> +			parm->has_loc =3D 1;
> +			parm->optimized =3D 1;
> +			parm->locs[0].is_const =3D 1;
> +			parm->nlocs =3D 1;
> +			parm->locs[0].size =3D 8;
> +			parm->locs[0].value =3D attr_numeric(die, DW_AT_const_value);
> +			return 0;
> +		}
> +		if (dwarf_attr(die, DW_AT_location, attr) =3D=3D NULL)
> +			return 0;
> +	}
> +
>  	/* use libdw__lock as dwarf_getlocation(s) has concurrency issues
>  	 * when libdw is not compiled with experimental --enable-thread-safety
>  	 */
>  	pthread_mutex_lock(&libdw__lock);
>  	while ((offset =3D __dwarf_getlocations(attr, offset, &base, &start, &e=
nd, &expr, &exprlen)) > 0) {
> -		loc_num++;
> +		/* We only want location info referring to start of function;
> +		 * assumes we get location info in address order; empirically
> +		 * this is the case.  Only exception is DW_OP_*entry_value
> +		 * location info which always refers to the value on entry.
> +		 */
> +		if (first =3D=3D -1)

<moving comments from github>

Note: an alternative is to check that address range associated with
location corresponds to the starting address of the inline expansion,
e.g. like in [1]. I think it is a more correct approach.

[1] https://github.com/eddyz87/inline-address-printer/blob/master/main.c#L1=
84

> +			first =3D start;
> =20
>  		/* Convert expression list (XX DW_OP_stack_value) -> (XX).
>  		 * DW_OP_stack_value instructs interpreter to pop current value from
> @@ -1216,33 +1241,154 @@ static int parameter__reg(Dwarf_Attribute *attr,=
 int expected_reg)
>  		if (exprlen > 1 && expr[exprlen - 1].atom =3D=3D DW_OP_stack_value)
>  			exprlen--;
> =20
> -		if (exprlen !=3D 1)
> -			continue;
> +		if (exprlen > 1) {
> +			/* ignore complex exprs not at start of function,
> +			 * but bail if we hit a complex loc expr at the start.
> +			 */
> +			if (start !=3D first)
> +				continue;
> +			ret =3D -1;
> +			goto out;
> +		}
> =20
>  		switch (expr->atom) {
> -		/* match DW_OP_regXX at first location */
> +		case DW_OP_deref:
> +			if (parm->nlocs > 0)
> +				parm->locs[parm->nlocs - 1].is_deref =3D 1;
> +			else
> +				ret =3D -1;
> +			break;
>  		case DW_OP_reg0 ... DW_OP_reg31:
> -			if (loc_num !=3D 0)
> +			if (start !=3D first || parm->nlocs > 1)
> +				break;
> +			/* avoid duplicate location value */
> +			if (parm->nlocs > 0 && parm->locs[parm->nlocs - 1].reg =3D=3D
> +					       (expr->atom - DW_OP_reg0))
> +				break;
> +			parm->locs[parm->nlocs].reg =3D expr->atom - DW_OP_reg0;
> +			parm->locs[parm->nlocs].is_deref =3D 0;
> +			parm->locs[parm->nlocs].size =3D 8;
> +			parm->locs[parm->nlocs++].offset =3D 0;
> +			ret =3D 0;
> +			break;
> +		case DW_OP_fbreg:
> +		case DW_OP_breg0 ... DW_OP_breg31:
> +			if (start !=3D first || parm->nlocs > 1)
>  				break;
> -			ret =3D expr->atom;
> -			if (ret =3D=3D expected_reg)
> -				goto out;
> +			/* avoid duplicate location value */
> +			if (parm->nlocs > 0 && parm->locs[parm->nlocs - 1].reg =3D=3D
> +					       (expr->atom - DW_OP_breg0)) {
> +				if (parm->locs[parm->nlocs - 1].offset !=3D expr->offset)
> +					ret =3D -1;
> +				break;
> +			}
> +			parm->locs[parm->nlocs].reg =3D expr->atom - DW_OP_breg0;
> +			parm->locs[parm->nlocs].is_deref =3D 1;
> +			parm->locs[parm->nlocs].size =3D 8;
> +			parm->locs[parm->nlocs++].offset =3D expr->offset;

I think this should be `expr->number`:

  /* One operation in a DWARF location expression.
     A location expression is an array of these.  */
  typedef struct
  {
    uint8_t atom;                 /* Operation */
    Dwarf_Word number;            /* Operand */
    Dwarf_Word number2;           /* Possible second operand */
    Dwarf_Word offset;            /* Offset in location expression */
  } Dwarf_Op;

> +			ret =3D 0;
> +			break;
> +		case DW_OP_lit0 ... DW_OP_lit31:
> +			if (start !=3D first)
> +				break;
> +
> +			if (parm->nlocs > 0 && (expr->atom - DW_OP_lit0) =3D=3D
> +					       parm->locs[parm->nlocs - 1].value)
> +				break;
> +			parm->locs[parm->nlocs].is_const =3D 1;
> +			parm->locs[parm->nlocs].size =3D 1;
> +			parm->locs[parm->nlocs++].value =3D expr->atom - DW_OP_lit0;
> +			ret =3D 0;
> +			break;
> +		case DW_OP_const1u ... DW_OP_consts:
> +			if (start !=3D first)
> +				break;
> +			if (parm->nlocs > 0 && (parm->locs[parm->nlocs - 1].is_const &&
> +			    expr->number =3D=3D parm->locs[parm->nlocs - 1].value))
> +				break;
> +			parm->locs[parm->nlocs].is_const =3D 1;
> +			parm->locs[parm->nlocs].value =3D expr->number;
> +			switch (expr->atom) {
> +			case DW_OP_const1u:
> +				parm->locs[parm->nlocs].size =3D 1;
> +				break;
> +			case DW_OP_const1s:
> +				parm->locs[parm->nlocs].size =3D -1;
> +				break;
> +			case DW_OP_const2u:
> +				parm->locs[parm->nlocs].size =3D 2;
> +				break;
> +			case DW_OP_const2s:
> +				parm->locs[parm->nlocs].size =3D -2;
> +				break;
> +			case DW_OP_const4u:
> +				parm->locs[parm->nlocs].size =3D 4;
> +				break;
> +			case DW_OP_const4s:
> +				parm->locs[parm->nlocs].size =3D -4;
> +				break;
> +			case DW_OP_const8u:
> +			case DW_OP_constu:
> +				parm->locs[parm->nlocs].size =3D 8;
> +				break;
> +			case DW_OP_const8s:
> +			case DW_OP_consts:
> +				parm->locs[parm->nlocs].size =3D -8;
> +				break;
> +			}
> +			parm->nlocs++;
> +			ret =3D 0;
> +			break;
> +		case DW_OP_addr:
> +			if (start !=3D first || parm->nlocs > 0)
> +				break;
> +			parm->locs[parm->nlocs].is_const =3D 1;
> +			parm->locs[parm->nlocs].is_addr =3D 1;
> +			parm->locs[parm->nlocs].size =3D 8;
> +			parm->locs[parm->nlocs++].value =3D expr->number;
> +			ret =3D 0;
>  			break;
> -		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
>  		case DW_OP_entry_value:
>  		case DW_OP_GNU_entry_value:
> -			if (dwarf_getlocation_attr(attr, expr, &entry_attr) =3D=3D 0 &&
> -			    dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) =3D=3D 0 &=
&
> -			    entry_len =3D=3D 1) {
> -				ret =3D entry_ops->atom;
> -				if (ret =3D=3D expected_reg)
> -					goto out;
> +			/* Match DW_OP_entry_value(DW_OP_regXX) at any offset
> +			 * in function since it always describes value on entry.
> +			 */
> +			if (dwarf_getlocation_attr(attr, expr, &next_attr) =3D=3D 0) {
> +				pthread_mutex_unlock(&libdw__lock);
> +				return parameter__locs(NULL, &next_attr, parm);
>  			}
> +			ret =3D -1;
> +			break;
> +		case DW_OP_implicit_pointer:
> +			if (start !=3D first)
> +				break;
> +			if (dwarf_getlocation_implicit_pointer(attr, expr, &next_attr) =3D=3D=
 0) {
> +				pthread_mutex_unlock(&libdw__lock);
> +				return parameter__locs(NULL, &next_attr, parm);
> +			}
> +			ret =3D -1;
> +			break;
> +		case DW_OP_implicit_value:
> +			if (start !=3D first)
> +				break;
> +			if (dwarf_getlocation_attr(attr, expr, &next_attr) =3D=3D 0) {
> +				pthread_mutex_unlock(&libdw__lock);
> +				return parameter__locs(NULL, &next_attr, parm);
> +			}
> +			ret =3D -1;
> +			break;
> +		default:
> +			/* unhandled op */
> +			ret =3D -1;
>  			break;
>  		}
> +		if (ret =3D=3D -1)
> +			break;
>  	}
>  out:
>  	pthread_mutex_unlock(&libdw__lock);
> +	if (ret =3D=3D 0)
> +		parm->has_loc =3D 1;
>  	return ret;
>  }
> =20

[...]

