Return-Path: <bpf+bounces-71965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C6C03284
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 21:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C043B006B
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 19:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE50348451;
	Thu, 23 Oct 2025 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ01ncSt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9002882CE
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247136; cv=none; b=oMIbMU/I/ghZ68rc0MjCVLISIfG/zY9GUzVtqo3moctS05y2P1QgMYsZEwUUJoP/RM+jNeYFlQAEijq4aQYEL9EvPsHH36lGZ6vffmTeVDw7No4qoSs/ls10uZUU7Jh26CcsZP9h5/e4ugxp/qwPVAnhB7KJOY0ljN+D9cve/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247136; c=relaxed/simple;
	bh=ZlVl4Y8fvijsIY/tZOebc6pxDPocARgBnk23Bvw1/Ws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aXqA5Y2iD9bnl7dAoYzTJkmFyyJhYWfRE2wJUxJqS/pCGyBky/vEYSOf6+nwEs4XUWT+/WJKZ70VebeBI1xofhwZxJghbTW0LQ5oLGgi4U6qlskXJeGrvbVwJmYZh+yfGhAWHhHM320QGPtEjoEVCYkb+lyKU4W6KX0SiBgazkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQ01ncSt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-793021f348fso1159964b3a.1
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761247134; x=1761851934; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d2Wyw9UPvJvWNPUS1O/5Wbx6cu+HsX5RAvhS3bPDhM4=;
        b=VQ01ncStqw3zRTNvoMzeyEi9bzeC+oZZpGcswqPOJLi6VYNJgheqs3CQaq5/RYrl0m
         NsRpNihgU3hre2fyFvnuBXhqDof4OKoPQUXssERZH0Ow+17WtSSEsFCAsNEUl/SHgOFX
         8+ME2ZhJcxBxAtMfNGoJZZHcjj0x+aBYcISHU7JH2Q9+Ly8MehIhnJldAT4f+bycHb8y
         1eXLu+Rv62IL861DiKpXQzONxpFkU3luDXNIXoZGemzhcnUpE27vMfrEZLwRf4z0Dhz+
         8KegJUOTELma6C8e6r10qbzHSCrYuHQU5x5eKCo5u72ZwhBStb07vh0LL3zUnn5FcsMm
         +Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761247134; x=1761851934;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2Wyw9UPvJvWNPUS1O/5Wbx6cu+HsX5RAvhS3bPDhM4=;
        b=iP7eBZEW9YSDrLs8rIPxrANz/kKjoqhVWPJZU0t9gJEDlO4OnhXTbGn1uzoRVYhsGT
         buI1NM0VMSVyDt9/UrL3JbYwB+UW4DhSsPphOGlSMaUa5ITV4yS7AEV7d2dKkEIk5j5p
         xx+O2QGgqmgv9OZiZy5cMDCWvymjqLcUYuk/E1/13HvpdI2T3wvo5INwLT4vKnC5JCMj
         zWWZaLTVf5yI9jrgi+WBCNMlFgpsOdtJ/dnvcUzvl/TSEto3HnwBDXMMgPKUjaWO8z7U
         oyLXqm6woxueDwasuES/oa0qgBUYWFYkyCcsLZI4JpSAYfOTfRxR/cF5lfoXdrK18T2a
         Oixg==
X-Forwarded-Encrypted: i=1; AJvYcCVL6jJGH9OFrQQ/E5tGts90Z7WtmKo8aGDbltrK9/FcBehQRQnsxw8jl5Z7m1NpdJygfaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXwEie2r/bO6Mz6dTrmmVwFIQNGpLCipyZ2Cc9U5uLzetitS1y
	LEe+yHCN4ccDFTCzboNfZ8F9AeUUPontcLkdc8qdztwYKTxsCY50aQr7
X-Gm-Gg: ASbGncuDEttnQUXph9/ocC9m1IQyg28v7HG1Q9dBCjeckuJc82WJG2ALsaYv+e1Kj3G
	9jLfn6VC67nRKWgYUwp/UKofh5ypd0VjrCYcCdEhXMgG9Yz0PVhtetQUZDB05uBNsdGOD1xvOtV
	3HFz4SghrcxuuV0rU4PyH2SLzUJEreJwWFzEgSfGf0K0wyHWI66bZkp6M+IUIrWvdHh3z9MDPkt
	LGNGn/7+/1YUmhD6PBJdx0d6cXMGaQbpB2JcYYlSJFhRd5pqG/o8LQkEVDfW1NPXkZmZQ8viQ2d
	iwwL7d3DDswEpcXUuUVjpZezPj42HAO49nMD+Sjh4aAedt+K2dOycH4GlOgLKOBkzewKdf4dwXy
	TYHxPiE+0C22uM/lnclwMPwNIiU/ea/G5KbRvMGEmf5P0eVb2qmXKvh+JtuUKbA1NMEuzub7sKg
	==
X-Google-Smtp-Source: AGHT+IFSOMyy4CQOMO6iTPnyGDZ4lKheF1dZ6GnReQZHIBdMpbixWN6EucmzeUPlpNjUIFfppa1t/A==
X-Received: by 2002:a05:6a20:7344:b0:2e2:3e68:6e45 with SMTP id adf61e73a8af0-334a8642ea9mr36315441637.51.1761247133885;
        Thu, 23 Oct 2025 12:18:53 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a342sm6621836a91.13.2025.10.23.12.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 12:18:53 -0700 (PDT)
Message-ID: <de9b8201c4312ff891899b1a7a443332879d9043.camel@gmail.com>
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
Date: Thu, 23 Oct 2025 12:18:50 -0700
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
> +			if (err)
> +				return err;
> +		}
> +		break;

Do we want to also check that number of parameters in loc_proto is the
same (or less then) number of parameters in func_proto?
Also, would it make sense to support a case when e.g. parameters #1
and #3 are in known locations, but parameter #2 is absent?

> +	}
>  	default:
>  		pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
>  		return -EINVAL;

[...]

