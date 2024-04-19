Return-Path: <bpf+bounces-27196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 077308AA6F4
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 04:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F22B21B2A
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 02:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4F68BF7;
	Fri, 19 Apr 2024 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUuuk6bT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DEF944E
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713493819; cv=none; b=gvOlThO5Yg4DnCYVj+Rqm0hBrgy+NJC8SNfeIOjhQXWifSMkGIjO1z7hT9UYkv5/dFcBO2vQyjbJJ+0kLMamt+kdSJSKx4ypvz1yLeo5oAvLP/k+H+/kjHgPqIWr0BbvWBN1P4VP3CyhwOTbZiizsyEydf3mTGI9OGsZlc51vc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713493819; c=relaxed/simple;
	bh=0mCJLnS6XiRo9IsnVARqwLTXgiMYLpOZMqMYcgCTdWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HDLpLt14VLkl+nyDqLnIVROfppIe83+Vj45O3AwmYCJJFAzwKQf+4ElDsWgtpoMKo1OCQN3JE0iV70th4p4W+L9RNBFiVbSxCp7iJr+e/BCdz+5PmRLPfSe2v/G5KaKnw2aJmqR5LVIPRxsAwXYpZ9vqk9dlfoF4mn70O7w6TMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUuuk6bT; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c730f599abso957891b6e.0
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 19:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713493817; x=1714098617; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xomwUYT7H0q1FqOzDDwZcZM8h1PukcDsWRzHspRa17w=;
        b=BUuuk6bTRCMtA9tbfg7jIY6jL5kAxvpTbBfkho+Bkz3Dks0tmMYDw5FVmg/xHxRCLX
         PMNxL6vbB/zsKGm9v3vhODqmjca8/h/Z8tdjtrK6cUua8Oo8x8WOdU7TaQ+LvB/HoTPu
         odDfATDGLd0+USK4VphnYk8glEXkAyjY4l8N0ghMW82nLC5UJx7rIeedcNKX1o0ZLjUe
         GQmtXZJndM+Q/6Ss5YKR9v2v8cF7PpUjahxwppYwii65PyO8IG5Bzu/t7rrBD56ypqtu
         BB3rfpuok44p/MK4PqmuDzqmjWaUy/GNNImOVhaVwYYTWLmjRsb9TPYZ33vpa4PP4yN1
         5GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713493817; x=1714098617;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xomwUYT7H0q1FqOzDDwZcZM8h1PukcDsWRzHspRa17w=;
        b=dPNFRObfVA8hgW8gZsmBoDEkc7tPe4lOYE8pIWX1oGIQLcZj/QxWN6PPOzhNacdegp
         Ni/mnlmA56Wbh9JFaeG6Dou7e68VQ1SZWnWG+djgRz3isAG7AaxYDgIVn9tIcA+E5+3Y
         Bpe/YCPbnpY6Hl7y2kZTljrtb9aq3K9bqFkAOutKikFmCpMQxZoa/pzNv61Ms0oN+2re
         Y8m3OjlOYDNP45yLoy9AZOrSTtB8z1uDjExl21zGjXbuuTIEuUZG5Z0n1uAe1b60ZKY2
         f/h6pq+qLYfWbj3E3aRWGDhajHMOsJgr6oB51tQU/jRnCe3/WP3ddVHiNrmCLskNDSr/
         GLuw==
X-Forwarded-Encrypted: i=1; AJvYcCVzyOrY4jfUsijlQiY9P0B2TEMjN1BHskCugBExRVipAabi6EomrH1xT/NMsC61PJfmlRsZq9TM/z4ExMCx8Cnz6KkY
X-Gm-Message-State: AOJu0Yz3deQSPtmblfJKBmzM0rd8s4uc7kzQ7v/lbKtsC+dA+tzhnxXu
	q/n3doeGGWT6f89wmXKA5DeLRsNFu+M67fYYbpmycmJIvsgYV7wM1bMuiMEP
X-Google-Smtp-Source: AGHT+IHdti+w7ET1oZchpIihD6QxPHy4KzEI60MRIJxqELn9KNgIJc+i963fnCxZUatMuH/ypnaEnA==
X-Received: by 2002:a05:6808:bd0:b0:3c7:3ab:69a with SMTP id o16-20020a0568080bd000b003c703ab069amr1104630oik.20.1713493817358;
        Thu, 18 Apr 2024 19:30:17 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:775f:334d:e9e8:42bd? ([2604:3d08:9880:5900:775f:334d:e9e8:42bd])
        by smtp.gmail.com with ESMTPSA id m3-20020a635803000000b005e485fbd455sm2125487pgb.45.2024.04.18.19.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 19:30:16 -0700 (PDT)
Message-ID: <78488c062d4154f78706d371bf3ed600a0601ab6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] bpf/verifier: relax MUL range
 computation check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Elena
 Zannoni <elena.zannoni@oracle.com>
Date: Thu, 18 Apr 2024 19:30:15 -0700
In-Reply-To: <20240417122341.331524-5-cupertino.miranda@oracle.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
	 <20240417122341.331524-5-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-17 at 13:23 +0100, Cupertino Miranda wrote:

[...]

>  static int is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
> +					    struct bpf_reg_state dst_reg,
>  					    struct bpf_reg_state src_reg)

Nit: there is no need to pass {dst,src}_reg by value,
     struct bpf_reg_state is 120 bytes in size
    (but maybe compiler handles this).

>  {
> -	bool src_known;
> +	bool src_known, dst_known;
>  	u64 insn_bitness =3D (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) ? 64 : 32=
;
>  	bool alu32 =3D (BPF_CLASS(insn->code) !=3D BPF_ALU64);
>  	u8 opcode =3D BPF_OP(insn->code);
> =20
> -	bool valid_known =3D true;
> -	src_known =3D is_const_reg_and_valid(src_reg, alu32, &valid_known);
> +	bool valid_known_src =3D true;
> +	bool valid_known_dst =3D true;
> +	src_known =3D is_const_reg_and_valid(src_reg, alu32, &valid_known_src);
> +	dst_known =3D is_const_reg_and_valid(dst_reg, alu32, &valid_known_dst);
> =20
>  	/* Taint dst register if offset had invalid bounds
>  	 * derived from e.g. dead branches.
>  	 */
> -	if (valid_known =3D=3D false)
> +	if (valid_known_src =3D=3D false)
>  		return UNCOMPUTABLE_RANGE;
> =20
>  	switch (opcode) {
> @@ -13457,10 +13460,12 @@ static int is_safe_to_compute_dst_reg_range(str=
uct bpf_insn *insn,
>  	case BPF_OR:
>  		return COMPUTABLE_RANGE;
> =20
> -	/* Compute range for the following only if the src_reg is known.
> +	/* Compute range for MUL if at least one of its registers is known.
>  	 */
>  	case BPF_MUL:
> -		return src_known ? COMPUTABLE_RANGE : UNCOMPUTABLE_RANGE;
> +		if (src_known || (dst_known && valid_known_dst))
> +			return COMPUTABLE_RANGE;
> +		break;

Is it even necessary to restrict src or dst to be known?
adjust_scalar_min_max_vals() logic for multiplication looks as follows:

	case BPF_MUL:
		dst_reg->var_off =3D tnum_mul(dst_reg->var_off, src_reg.var_off);
		scalar32_min_max_mul(dst_reg, &src_reg);
		scalar_min_max_mul(dst_reg, &src_reg);
		break;

Where tnum_mul() refers to a paper, and that paper does not restrict
abstract multiplication algorithm to constant values on either side.
The scalar_min_max_mul() and scalar32_min_max_mul() are similar:
- if both src and dst are positive
- if overflow is not possible
- adjust dst->min *=3D src->min
- adjust dst->max *=3D src->max

I think this should work just fine if neither of src or dst is a known cons=
tant.
What do you think?

[...]

