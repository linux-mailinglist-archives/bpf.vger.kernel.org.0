Return-Path: <bpf+bounces-50322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F264A262CB
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 19:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD83B18812FB
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 18:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57161553A3;
	Mon,  3 Feb 2025 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV287DvZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF29310E0;
	Mon,  3 Feb 2025 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608344; cv=none; b=DcU0IvSV0ifr6hkbh6w/rczdZ5fzXPx2f/0LdoylRktpZPH4bgovmYK8pbfj57yH1qG8uMhtfBM0vy+pKKKKZ2qwQj8S+zGV/lrT6a1Pxc9c+5YyAGYcY789F0yfeUOAigAGypK8gNu8zOn4RIkK0+E1cz7wHSL+0FfcfsJHF5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608344; c=relaxed/simple;
	bh=Sh9JqsMn3+WNjs/UhIQpp+0bQxQfRenxCzV9TC5Mz8k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rWMGxaovvE+ES1No7m/vfSL3tRnU5sbGCGWr6dqt6UTf9yRyODNaNwHuPAisHXwRC1uN8waF8YU0AvssKWpGxqnfGVH3zmhuRoC+EvpcdB3PBkbZ/b9YUwK+xNIB3MznjTYKbheawNRP7tvIXX9+cerUm8+qzgNyB0kQOC/EyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV287DvZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2166651f752so95779665ad.3;
        Mon, 03 Feb 2025 10:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738608340; x=1739213140; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GF5bCNHsQSd0Et+4UjT6iUc3/eSHGhbwhOmyy8nTBgs=;
        b=FV287DvZuf7riuMOhmW7hDHvKAEl5Obxw6SG5MtDcu8dGp86Jhkzkv+S0/vJWsGX9F
         bxA8OsjCc4liekYYIulazqqOlZb/npZTOaAE9//mdzuEh3H7Pw/vTn8uKpstuYQg8gTS
         d3d/mg2/J1yE8djBEuB33ZQFTldXVD2uoORfNKWqY0Z8YsVUjY3tcQn567j8PZ5ZFTsn
         9qxZPzAOMM6yqDeV897thTjrwhZ/7pr2xANAJFYGYsAqOqfHcxA2IG9utqidmUaizTaD
         LI+PFV+BylItIwu1om1sGq7RQPyds8TxeSupBibfGXZALKxdP5XGV+Rc09OPpx3RQyPe
         owOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738608340; x=1739213140;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GF5bCNHsQSd0Et+4UjT6iUc3/eSHGhbwhOmyy8nTBgs=;
        b=KOZXvaVNlGAqA+VZ8CMK74I5kpH/iJ5kWivDvFBJ1BmexSmp47/yEoKHIZemPnh+ng
         7IuqybTZUGoOzpIrRlnFhxF5T7lII1QnO20HJqSmPPqSomC9N04Sup9ZyxR2SnW0jGQb
         Y3mUKbGcoVLZxUGkzx4Yxr1aOOiYPxlfBZRSoSRVqi12a9mCWssj8Ff8eMQlBNbNrGn6
         AntTCukm/o5qjMo5WxUMEyMS4nSDxaTethyx2sCPFOboQLsm7NYI0DPSbQ1C9Bi8ueN9
         NpaEFGVKxbF5ypCIilx+9wK58u1U+d+G5KtaDoknnbHdPVj8RsLaR0qo6+TFs8+pmpVK
         hqDA==
X-Forwarded-Encrypted: i=1; AJvYcCUBoD/MaFho6uGttHN5vJDdmdH9hru8jC2N7ohmo5SlEF171b6ePsyqgIMm+0CFM0aUYNY=@vger.kernel.org, AJvYcCWqSIl4V5szysFylIZ1IMo7cIy5B3tyn/Te2TzCxW0vUg9Dn7nmUzZWm8Efw7X003BGeu3yeqbpPKlW/ek7@vger.kernel.org
X-Gm-Message-State: AOJu0YyAvUi7iL9b+54IxgjJatTffSajxjZ+hPXiCNKXEbSfGSkKu1uU
	Eto7pLreySolrY6lcbjraNCB/9myTEAKYFmeaROxwttj1szoCFnO
X-Gm-Gg: ASbGncv0vRCnggiNqsAt6M4MMzjvNR5kZi2NvSCcfodJBXS4afYVx/VUBNJid86CB7H
	tnC/1WxU/Bz+3KNMmsjSngHuOaPwVVGS2yc1JusdPgO93EYOi9VQCFE6YjItcvX2TWKC0qP2rok
	JaQjPChY7hMGJnQJ6l/p+U0g1zhAYYtEZxe4kjZd7Ph27bccEHCA2yNXcbapeSjoINNGyDagVYG
	bit/bqVJe75kyqoWUt2CqEBV0BXfjCZOmwNE1x38nq5nEoS/eVMTD134Bvan/SMyxEAVD8dLseU
	QCusH46AGYWJ
X-Google-Smtp-Source: AGHT+IHi/LhXzMClWbHreZV7J7kdHrZ4MloVmok977ZqERzj4/39svg06fAAaCiNlzrpPRBw5iARKw==
X-Received: by 2002:a17:903:41cf:b0:216:3c2b:a5e5 with SMTP id d9443c01a7336-21dd7d7bc9emr325633955ad.27.1738608339860;
        Mon, 03 Feb 2025 10:45:39 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f80a1sm80499695ad.87.2025.02.03.10.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 10:45:39 -0800 (PST)
Message-ID: <084abedc8ec36ffe77f97531c0bcebc291547415.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: verifier: Do not extract constant map
 keys for irrelevant maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, daniel@iogearbox.net, andrii@kernel.org, 
	ast@kernel.org
Cc: john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, 	jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	mhartmay@linux.ibm.com, iii@linux.ibm.com
Date: Mon, 03 Feb 2025 10:45:35 -0800
In-Reply-To: <ebbf8edf871a6543425b75bb659400221bd28275.1738439839.git.dxu@dxuuu.xyz>
References: <cover.1738439839.git.dxu@dxuuu.xyz>
	 <ebbf8edf871a6543425b75bb659400221bd28275.1738439839.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-02-01 at 12:58 -0700, Daniel Xu wrote:
> Previously, we were trying to extract constant map keys for all
> bpf_map_lookup_elem(), regardless of map type. This is an issue if the
> map has a u64 key and the value is very high, as it can be interpreted
> as a negative signed value. This in turn is treated as an error value by
> check_func_arg() which causes a valid program to be incorrectly
> rejected.
>=20
> Fix by only extracting constant map keys for relevant maps. See next
> commit for an example via selftest.
>=20
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Nit:
  would be good if commit message said something along the lines:
  ... the fix works because nullness elision is only allowed for
      {PERCPU_}ARRAY maps, and keys for these are within u32 range ...

> ---
>  kernel/bpf/verifier.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9971c03adfd5..e9176a5ce215 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9206,6 +9206,8 @@ static s64 get_constant_map_key(struct bpf_verifier=
_env *env,
>  	return reg->var_off.value;
>  }
> =20
> +static bool can_elide_value_nullness(enum bpf_map_type type);
> +
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			  struct bpf_call_arg_meta *meta,
>  			  const struct bpf_func_proto *fn,
> @@ -9354,9 +9356,11 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
>  		err =3D check_helper_mem_access(env, regno, key_size, BPF_READ, false,=
 NULL);
>  		if (err)
>  			return err;
> -		meta->const_map_key =3D get_constant_map_key(env, reg, key_size);
> -		if (meta->const_map_key < 0 && meta->const_map_key !=3D -EOPNOTSUPP)
> -			return meta->const_map_key;
> +		if (can_elide_value_nullness(meta->map_ptr->map_type)) {
> +			meta->const_map_key =3D get_constant_map_key(env, reg, key_size);
> +			if (meta->const_map_key < 0 && meta->const_map_key !=3D -EOPNOTSUPP)
> +				return meta->const_map_key;
> +		}
>  		break;
>  	case ARG_PTR_TO_MAP_VALUE:
>  		if (type_may_be_null(arg_type) && register_is_null(reg))



