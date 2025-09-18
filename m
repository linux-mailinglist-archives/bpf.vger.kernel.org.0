Return-Path: <bpf+bounces-68837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1214B866A8
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E340F7AA29E
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0940E280017;
	Thu, 18 Sep 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHc94rOH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1428024468C
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758220229; cv=none; b=IGfLmrXiLiL2DvGly5rRZy+8/2FG4uGiwdsmToWXyy3TorGeisWlIc0VZhhB+uy9MIMBAmOP5QjbhF03Kp0ieOu/vHhAIjfKX4cyBd/CZRBO2JV6HHZrYOhpRxq89+AN1RQii9QJJONu4uiNZOMqNtyiu+ZfLSZmWmBtpeJNxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758220229; c=relaxed/simple;
	bh=yGbQo3B1QeolqOzFJDtN7vKde0FLSvCPYvilgpfxPHg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZOdZ2b7wk4q0VO6AO/G8QjEZZy9FLwbvnMxAzvMpHqZrEtJTRTqZbcJOmTsFTLGd/9HYNleBTmhjfN4ij5lgF3/UnQcrJFC12+OramSiBLuBfkvkGEhaEoxZegWgwWn6IIZZHw2m7NE/W29SHewO5U7bqvSvkyLIrjGFvhbBCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHc94rOH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77251d7cca6so1350226b3a.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758220226; x=1758825026; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DoAuM0Yzvno0pOlModNhDagzc1OJINVKJMok3EdIsas=;
        b=PHc94rOHDMUPoNKGONDw3jPPMAvd+JNiWnI3E88S10bU7cc5zuTsVXeGK35LlSfEbw
         ql3JRnHtzPIIfu3WMpZOuSFuhrMDnQcTGH3q+aMX0X+eeo+OL+USGfkizbEaEF6q39Ph
         V9blQASbYXmECA2GxO4AMDU0h17GAVEDPrj9RmcXbQ5E4X/UakGMy3jh3haz43WaAgd2
         Jxi5e9FzqjGhwyXtdcWuDTp7bdepCFS+DY/I8yu6QNmUUYu/y0/Z5tojHPv5Zd6pwi/5
         WMvTfCev1dzU8CGN2mu2xKBwpXQCTXcPKPhnmKH1tpkAcTF+lpYnzAwyx4I4zB2FhFde
         c07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758220226; x=1758825026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DoAuM0Yzvno0pOlModNhDagzc1OJINVKJMok3EdIsas=;
        b=S6RvI2GKgOixEUd6OOUJA0HPmfU4N3EmNWfYkpELPg4HuFpKMVSb5+lw9+aLsJbr37
         mEKpBAS8oETMdxvZbnrW7uWtoph2th1DrMxKvYmdcXGaY2QhJv5TKOfxwHWzL2ySjfWq
         E0dANAvGtEZ+V9VVfIb/1Tf7PEnU+CmZzenCJnTBHCJcnFiXDrTikgINIVUwdkdRh9CD
         hNLYGhUZV6ANFN4eN1PEJHtGzt38sB9YHVIqeJwwlzOczoz4s3VgJRGx2JqSIqqEIyQP
         ciF9BAV8q+9pEAgB5JyZ85jpShMMO49vSK9Joi0Jjzp9ACmGTkVGlwlyOietOcHT3trC
         eqgA==
X-Forwarded-Encrypted: i=1; AJvYcCV6YCVle3SMxrrf4MBSbt0DawyETPRpSdNDl4kRh3Zrw7FkbyXJ/iNQ7oY25P6WNbnsfVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4tncH2JKbsvZIkFc4U8v31s1oJQnQAHy2otZChc+3GjxDfMmX
	R6qBnb0fJYjCc++I8p5HFTB1vXEsOiP2mPZVbV6deexQLB7HGYTODr4F
X-Gm-Gg: ASbGncuC5Zo9Na8EzOrYmM9Ve1ISVt8aAYHkVQpdUy0Z2ENHNT378Yv+Ms8xF9fWbvq
	tWFd9IdgjHEsb82O+XfYE1M6XZmbmY6RLZ7XOo0k55cNXZ2T/h4yZ5fgxuNYVVhjl7hsbmfF/gO
	9JFJxgxdRVPBkL4BF/DSJ/3Nq6AftVbHu1cETxceZOatuvi2JWbRtUbmE3sAWWRl7Z6pwFVYBlY
	CXHQ9LaP/PAPCJjSwWHf2uJvZlsJiXQnsYTD1bTSK37/phJQJjXckDVn6XT4G2fx871Q24HnNDY
	Y5YtxXEBhWj2t5d+4jo8ODcShcLHORrQNTGxH4qP2LSG35tajtPDm4XJMKBNPuipXCd+5oJCRn8
	Srt4FthseXv+4QQeoRRjELT+MeMkbK3s8hapXaA==
X-Google-Smtp-Source: AGHT+IHHiFQMKLZX6/IhwLpi1j0PenKG5Hr2HAglbcQJGgg+H94N3+9jNgSVMS6inMayTcmGUuZRjQ==
X-Received: by 2002:a05:6a20:2449:b0:246:17b:3576 with SMTP id adf61e73a8af0-2927182c4e3mr724204637.46.1758220226171;
        Thu, 18 Sep 2025 11:30:26 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff448058sm2916832a12.54.2025.09.18.11.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:30:25 -0700 (PDT)
Message-ID: <ef94d1029cee1661cadbcfdafa2da9748af8884c.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: introduce kfunc flags for dynptr types
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Thu, 18 Sep 2025 11:30:22 -0700
In-Reply-To: <20250918132756.194301-1-mykyta.yatsenko5@gmail.com>
References: <20250918132756.194301-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 14:27 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> The verifier currently special-cases dynptr initialization kfuncs to set
> the correct dynptr type for an uninitialized argument. This patch moves
> that logic into kfunc metadata.
>=20
> Introduce KF_DYNPTR_* kfunc flags and a helper,
> dynptr_type_from_kfunc_flags(), which translates those flags into the
> appropriate DYNPTR_TYPE_* mask. With the type encoded in the kfunc
> declaration, the verifier no longer needs explicit checks for
> bpf_dynptr_from_xdp(), bpf_dynptr_from_skb(), and
> bpf_dynptr_from_skb_meta().
>=20
> This simplifies the verifier and centralizes dynptr typing in kfunc
> declarations, with no user-visible behavior change.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(But I have two questions, see below).

>  include/linux/btf.h   |  3 +++
>  kernel/bpf/verifier.c | 31 +++++++++++++++++++++++--------
>  net/core/filter.c     |  6 +++---
>  3 files changed, 29 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 9eda6b113f9b..d41d6a0d1085 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -79,6 +79,9 @@
>  #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its=
 first argument */
>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its=
 second argument */
> +#define KF_DYNPTR_XDP   (1 << 16) /* kfunc takes dynptr to XDP */
> +#define KF_DYNPTR_SKB   (1 << 17) /* kfunc takes dynptr to SKB */
> +#define KF_DYNPTR_SKB_META   (1 << 18) /* kfunc takes dynptr to SKB meta=
data */

Are we worried about running out of bits?
E.g. an alternative is to reserve 4-bits and use that portion as an enum.

>  /*
>   * Tag marking a kernel function as a kfunc. This is meant to minimize t=
he
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b9394f8fac0e..9aa2f00ede49 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2282,6 +2282,25 @@ static bool reg_is_dynptr_slice_pkt(const struct b=
pf_reg_state *reg)
>  		(DYNPTR_TYPE_SKB | DYNPTR_TYPE_XDP | DYNPTR_TYPE_SKB_META));
>  }
> =20
> +static u64 dynptr_type_from_kfunc_flags(const struct bpf_kfunc_call_arg_=
meta *meta)
> +{
> +	static const struct {
> +		u64 mask;
> +		enum bpf_type_flag type;
> +	} type_flags[] =3D {
> +		{ KF_DYNPTR_SKB, DYNPTR_TYPE_SKB },
> +		{ KF_DYNPTR_XDP, DYNPTR_TYPE_XDP },
> +		{ KF_DYNPTR_SKB_META, DYNPTR_TYPE_SKB_META },
> +	};
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(type_flags); ++i) {
> +		if (type_flags[i].mask & meta->kfunc_flags)
> +			return type_flags[i].type;
> +	}

Do we want to check for erroneous combination of bits,
e.g. KF_DYNPTR_SKB | KF_DYNPTR_XDP?
Probably fine to skip such checks.

> +	return 0;
> +}
> +
>  /* Unmodified PTR_TO_PACKET[_META,_END] register from ctx access. */
>  static bool reg_is_init_pkt_pointer(const struct bpf_reg_state *reg,
>  				    enum bpf_reg_type which)

[...]

