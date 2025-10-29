Return-Path: <bpf+bounces-72935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803BCC1DD41
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB74188A1A4
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B763218B2;
	Wed, 29 Oct 2025 23:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItPkI+DR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E326320CBF
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782094; cv=none; b=Do7NpIM3uWW7/nkg/nJJ/N0xbAIRGSfMAM99IwqGkOnf3dMU2Yw/WAwnIsUDRoEKEjom1RDWB0pIgbWkm3eNqklTvfL+dqOj9VZgMYMCRmKvoEvjT/LPiUq+xiELWwbquzBvCRVRlGybAi6lwh8SV+38xVt0t4DhVF4+GDW75/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782094; c=relaxed/simple;
	bh=IdqEFmHuoRNxR3u0UPrZ5MdcP+JNada6rMZWAMJseOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJnY13Qa+ckbvFIQ4XMy7CVCK/Ar0vuUI9SD1ZPQJayHzXrhhz/DQkkTlCs7LnX3hrCDsIdp02MbsN0aeOJdelhoN9Xr+4M8nrsjW4bOjPhtIRGUT/5CfVjkigF5572AhF62qylCyi4v5bdJCEPcBAb9bzLCjomugLrL07AXoo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItPkI+DR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26e68904f0eso4273085ad.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 16:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761782092; x=1762386892; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VqHaPvvHNUWfgjNN6SzCPgghHpzAxfuGayVQHsMdmeE=;
        b=ItPkI+DReCHnQEmUMZxEB1XrUNFArr3q5S+JVMeJn4Wrt4zaY+ogH4FRtdWxdfM0Q8
         XLisXfQRjBVvzJOOeRw3Yiszcry0QZr6wWAtvotdf5vggycUFwoDW8mcAZkWFzcH80nM
         9uKG9YWWM3SZdMRnhLwxoFG0jhTiq1SK+qzPM0wkWQgdOGswZrx3jMCGP2CBHGBp7Qkq
         uXuChpJ3nwNLk7ZneDBQD2w1W0fzmcsPB0Zht+f+6ie8Wj1+lPv94zh2Eohg90A4GLCK
         6JUOMhm20cMlyVEkPTgaoNRIDwp2/nqgEtIjZWcn+uN+/aPui5rNJjWffwxihjvXqCvr
         612A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782092; x=1762386892;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqHaPvvHNUWfgjNN6SzCPgghHpzAxfuGayVQHsMdmeE=;
        b=bCAQlp4awte+wtf2d18og4kWAvzttkNttU/xZmUve7CqpitTE1/TOD7VZZdAbfBTtc
         9YPlQhMDO8H1MdciNrPKz7KtUn/b4ClO/QXvdQbveIesoN6Tbkba/q9EuWExt5z/FMQL
         DPAyETp7fZ4cE5soNasXWIifZ/eNnu4DQy5zbK38d6qXdYeK5ro5rvsKC4oFqoQR81kl
         GUJ3oYzjfmaAPQF4sSUoaqh27PFC5fmpjMlYOfjLXpfNcrgY1Qi18HGjWqdpvitFnmVO
         dwodHX7WXu8lD+jBPC+9x15xKrvQ8byqbphpxB5dF0SlQILbDYx1m4THX+7g8UoxwyqA
         7kgw==
X-Forwarded-Encrypted: i=1; AJvYcCVXuOLb+yqu4DDFsB7U4RsAWsXvVlO5vSq2/72YIv2r212DP7joteNwulsWrnScOa+DcbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD4z9NNPNAFZXi3/g1iNdgbyR6+YzMLEx9U0gvEe+shzgBJUDW
	It/LI5ya4BEBWIUM9oGEqqEDEakrDjnMVJI0zEPvtNLtdZ4qZzXXekv+
X-Gm-Gg: ASbGncvew72hgsRStG/1wT/U93N4ZU7XbN/DxHf5mJgRNpLK8c6S2xyLQS31STfxGBM
	slEEeXSW+OvdqcLZDYVfXdNxGAXMmxA6f/6TnOsbP2Md8yjY6nLXq6bh6OLaZEoZhD022eV2pvU
	lPEz/sFTxumqdOzOkJ6v6IyQ9QiKq5YaCgzTj4XWpbcuslpk/fROO6LomyP79PTY6LjWwSZuEGT
	x34Mg0i1I3kFpNom6c2mgu+k454yomJtSuNbPdkeNcJzqssykeaM1mTgxc2Xh9U2MYRI6/P0oCB
	CDl6frSzmC32xU22k+fr6yr9keEdEyPJplbG8Syw1IC68pI/RIczzqOZHGr/zVxiYYz4cMvufry
	Yxn5AJmgNwuIMOnckbn2GL+bpsc+xoiKJYLBUxv2wsBf1ZJh3dm1VpfG4k7bmPLThUTWVykAw7X
	liC6euzgL4+OIKIz6it8UbAI58Pw==
X-Google-Smtp-Source: AGHT+IFHrYkS9VYx/11lvKingSrB4Z7zZwes4RlUiaCld0TDU8btdffXKIIOQlDKot8lbPJDzMD8+Q==
X-Received: by 2002:a17:903:22ca:b0:267:9931:dbfb with SMTP id d9443c01a7336-294ee0aa27fmr12249935ad.54.1761782091823;
        Wed, 29 Oct 2025 16:54:51 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d23218sm162919995ad.51.2025.10.29.16.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 16:54:51 -0700 (PDT)
Message-ID: <c7df8f49fe90256a37b286df7771dfca9b9573a4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] bpf: Add BTF_ID_LIST_END and
 BTF_ID_LIST_SIZE macros
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Wed, 29 Oct 2025 16:54:50 -0700
In-Reply-To: <20251029190113.3323406-2-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
		 <20251029190113.3323406-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
> Implement macros in btf_ids.h to enable a calculation of BTF_ID_LIST
> size. This is done by declaring an additional __end symbol which can
> then be used as an indicator of the end of an array.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  include/linux/btf_ids.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 139bdececdcf..27a4724d5aa9 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -97,6 +97,16 @@ asm(							\
>  __BTF_ID_LIST(name, local)				\
>  extern u32 name[];
> =20
> +/*
> + * The BTF_ID_LIST_END macro may be used to denote an end
> + * of a BTF_ID_LIST. This enables calculation of the list
> + * size with BTF_ID_LIST_SIZE.
> + */
> +#define BTF_ID_LIST_END(name) \
> +BTF_ID_LIST(name##__end)
> +#define BTF_ID_LIST_SIZE(name) \
> +(name##__end - name)
> +

Nit: no need for line break?

  #define BTF_ID_LIST_SIZE(name) (name##__end - name)

>  #define BTF_ID_LIST_GLOBAL(name, n)			\
>  __BTF_ID_LIST(name, globl)
> =20


