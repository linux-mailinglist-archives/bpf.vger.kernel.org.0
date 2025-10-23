Return-Path: <bpf+bounces-71860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47612BFEC3F
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 02:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40B819C47DE
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 00:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD7F1ACEAF;
	Thu, 23 Oct 2025 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGpK72hc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD0535B154
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181076; cv=none; b=gAF8zC3UGI1fC0J0kb1iAcSgtMhoml67d+WVyh5CRypbBC/28hRIUHphSxiPqsbUSvJx98yXbNPnyCagfhQ99kq9uS9HypGorsHlDz7zuL9duI5DoDTNV7Dt6JmBy127f/eGoLSVtG3IWA11RHAGGxkPN7b8gVMdRwuWhI4I41U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181076; c=relaxed/simple;
	bh=OhHIcf6Ne8NRU56fecVnuzIwGk1s0hhhCmy+PIAcdxw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BZblvVX1VxxQmVOtu9/8ONhcBEc5v52JRrCrbbamVvAJ8LnLkNM01PaRB6+FLa00uKa1QSrpnGzyvcsnwVA05hBVjqFIgLJB3t2KTZkn6o8wOyT9l/kvllt1ZhhdEOTqz5PHSZlc9HcY4MMK2LGQiqMAEQ5L7hYdO1ZG7vuDL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGpK72hc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2698d47e776so1576585ad.1
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 17:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181075; x=1761785875; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gEXdmu/2wxpM7IquNDAPmKSkEyc9yb95pGP92RuWof0=;
        b=NGpK72hclIbNAlNKlaSEcEQdXkaJgJHx95uZwJDgh5bRg4urKCQdPgd3jJ0HXz/idW
         dsISkgiU/criOkCMzwDHKf7nonQIxZh7HtL9oOFvM3TIz4Sv+PUzzYCSoyAe+gJNSbWW
         /VLaru6LfarxXa1lYvHCg12VKJmprzn+8jzjezprp3HHtqdcxKfFAtt007nQ1mdl7LMk
         llZ+6BeD8LDJrAAsmDFJi8aQJTf0Sd6XstlwMHa+1KIBw0Kzzz7VBsB7gphmIJRRuSTB
         2uxEO3xN+7otPkvdMgAf9mjQakT8Baxf1m3+3kdrio3l1EKTt6u3azrFnlBVpL/vhFVV
         f3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181075; x=1761785875;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEXdmu/2wxpM7IquNDAPmKSkEyc9yb95pGP92RuWof0=;
        b=g5jbqUDu+4GNRNhRILDj2SXUPs11UqwzSiGT2V71gIeqwhT8Y8pKCJHZ5F4B87sI/q
         KBC44q6ch2+1FJ9gU5B0BzlkQAdpn2UN/GA9OGj69ltngdoe0I4frudzYoJnx/7PDJQa
         upCh+V1O6F0+SO1uiB/tCciy9GpgqE5+fxkcAC3x0WEajzNBocZiBNSEIoqHfHaQlOB4
         fU2ysrMDLeUniKqjwlmrY3m1rBJk8Xs/uwA1MDyjyzeAleHONf8Jdlcs/wAb9CtOLMU3
         RJvLhZCdqrL89Y99iY8vlL6iOJsEErk4K0pacH9hT0Oat8LXf9CemUdTkTg7yEfz7R+5
         5XeA==
X-Forwarded-Encrypted: i=1; AJvYcCUs+BN/1TtCxWaJ1GwibhhvZqeSj4OX4AI2l6EFJI2DkSFk4D+C0Ao4PyJrxLy88eWC3LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVSFBa/cZ9rDeqPN4rBdvo4ikaekpltR3sXHYbMOfj46hKa82
	euPxzGxMY6GCmuN5j7/XHEnpTx3ss3W2dkp27g7jnCBAfBVpLOxc7Syn
X-Gm-Gg: ASbGncsgeHZS0r44D9zqKfqAgilBwB8tAQP9SM0S8MHaheFjUN5XQDbfG8bWyRWMfUU
	9qRtEYunLDwi17hOgq46mUA+WFrV44pDWzsamlYZS72FJtaRGGPlN+3SpKDTCUbQTNTge1+b0rJ
	DifSEiC35d/8j0AnGMOSXklXPex9aSXtFeCRX6rXU6TlaUT+mmhL8ta/jlCr6oVx68A2xVJ3oIL
	4vng/q8Iucq7xPheQBRBuuXzxqz+tn/4WELcnKdcMFq21EdPmaK3KQtz8lD5uz8QjWKUrPOP1dJ
	whEyLkTeV212qP4SOf2Vt8eR2AV2mYk1C2qKbmHvTwYHb/FCPl+6zFuWxEzTMuv6DtW+4xYFRmZ
	AJgE3MQ+/t+890hTSAf7q1/sZ1qb8xcAKztwIbWmvundZTlWfCuV6qIdYjBukkkD0TELz1EPhKp
	EMnO9Y2XySuIe6mA4SrRZSsYQy
X-Google-Smtp-Source: AGHT+IEXps3FRDxn7qpGsv525YnedqBqIu8aUTX+ZxMIYzmPlS/fYONlFrtmkTwBDBk31lFMenebqQ==
X-Received: by 2002:a17:902:ef4c:b0:290:7803:9e8 with SMTP id d9443c01a7336-290cb659d58mr285990605ad.48.1761181074548;
        Wed, 22 Oct 2025 17:57:54 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fa8d:1a05:3c71:d71? ([2620:10d:c090:500::7:b877])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f64f9sm4254135ad.86.2025.10.22.17.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 17:57:54 -0700 (PDT)
Message-ID: <bc3b203185107bd68c64458e0c71f68cd16e8595.camel@gmail.com>
Subject: Re: [RFC bpf-next 05/15] bpftool: Add ability to dump LOC_PARAM,
 LOC_PROTO and LOCSEC
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Date: Wed, 22 Oct 2025 17:57:51 -0700
In-Reply-To: <20251008173512.731801-6-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
		 <20251008173512.731801-6-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-08 at 18:35 +0100, Alan Maguire wrote:

[...]

> @@ -420,6 +423,98 @@ static int dump_btf_type(const struct btf *btf, __u3=
2 id,
>  		}
>  		break;
>  	}
> +	case BTF_KIND_LOC_PARAM: {
> +		const struct btf_loc_param *p =3D btf_loc_param(t);
> +		__s32 sz =3D (__s32)t->size;
> +
> +		if (btf_kflag(t)) {
> +			__u64 uval =3D btf_loc_param_value(t);
> +			__s64 sval =3D (__s64)uval;
> +
> +			if (json_output) {
> +				jsonw_int_field(w, "size", sz);
> +				if (sz >=3D 0)
> +					jsonw_uint_field(w, "value", uval);
> +				else
> +					jsonw_int_field(w, "value", sval);
> +			} else {
> +				if (sz >=3D 0)
> +					printf(" size=3D%d value=3D%llu", sz, uval);
> +				else
> +					printf(" size=3D%d value=3D%lld", sz, sval);
> +			}
> +		} else {
> +			if (json_output) {
> +				jsonw_int_field(w, "size", sz);
> +				jsonw_uint_field(w, "reg", p->reg);
> +				jsonw_uint_field(w, "flags", p->flags);
> +				jsonw_int_field(w, "offset", p->offset);
> +			} else {
> +				printf(" size=3D%d reg=3D%u flags=3D0x%x offset=3D%d",
> +				       sz, p->reg, p->flags, p->offset);

Did you consider printing this in a more user readable form?
E.g. `*(u64 *)(rbp - 8)`?

> +			}
> +		}
> +		break;
> +	}

[...]


