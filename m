Return-Path: <bpf+bounces-16824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C6E8062E1
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AC92821D8
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0007A41210;
	Tue,  5 Dec 2023 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhZ22qLo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE4F196
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 15:22:16 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bfd8d5c77so2916940e87.1
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 15:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701818535; x=1702423335; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nm00C7sfdf8ZbSrHd07FrM5Y0TRD56h7DDFk8gJr4jM=;
        b=HhZ22qLodETPjCh7OzeuOK4uKs3b05T/KpRZIVqvjhbNlrkow11p6VkNiCyS5aNe9L
         JsDtyXnNquCnZJvgOkZLL9UD+x6rYlTdE61k4YMJZ8nYGBZ3P5IFCbirt2ujVlTvmr+F
         rdqAv9oHZoKCOUdbugJoHiLXqAW9jSq+RID6se+071rAcHPokL9MvY8V35/60JZUorJs
         rACNAN/hZDKp6hQWPBZRTpfel703aX5NC+bHjOCndW8QUdQyHv8cziMQPmSMpRZCl2jA
         nV4yzRSMQrdICWyGDQcMKlADjkE+k21QqDhgD0nxTonFFYw8kKwUhYSdNIk8XWNHwsBS
         SnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701818535; x=1702423335;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nm00C7sfdf8ZbSrHd07FrM5Y0TRD56h7DDFk8gJr4jM=;
        b=u9jTkbL4BeAhJ0crjUkhdCLD+kUK0iZc8g9EDBnYyMZfA3s9chheEqSJKzdzJr8vgr
         hoZikFMCE7NObpG1Gaq6qC7EcpsGtVt5AxNlEO0tAxJl69S3GNpybP+dMT4d54jecOc7
         Z76hVExZlix2kEtMI/oGsbsyYlhIhEtB99VnYytAKw+aXO9Y8Zz0ySs+EQ/iQpnAfkwp
         qg/XQtjGnEI9IeRc+jmBzmX8cTB/Yi/k9nbEhOdXqu/eVTXdJMcrqHVFMA1QCag53hof
         zDRgLK334IkLpFhgl/uMUIFftBhIb+SlHuYmyusopzuQ/lwN5hdykRnWUQmhOgVJ8G2T
         ojbA==
X-Gm-Message-State: AOJu0Yy+km+CuFu3Ei6kwlQRy9jC8Eq9ZJJVt2ecEisXhRLb5SkukmUp
	CH6Q2JV3pRm0vaMtXfSynSCTDzuvCIs=
X-Google-Smtp-Source: AGHT+IFWhmFKnS+nzONPAbBiqOcRHLvEHW6YX42dqSpa2iSozFL1nrllquC07cBhoWwD98GegCQv1Q==
X-Received: by 2002:ac2:560e:0:b0:50b:f84a:5392 with SMTP id v14-20020ac2560e000000b0050bf84a5392mr13496lfd.36.1701818534920;
        Tue, 05 Dec 2023 15:22:14 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id be17-20020a056512251100b0050bc39bdd43sm696321lfb.211.2023.12.05.15.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 15:22:14 -0800 (PST)
Message-ID: <fc790a1fd70a4159c6d73b953088ec2beb97f48b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 10/13] bpf: support 'arg:xxx'
 btf_decl_tag-based hints for global subprog args
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 06 Dec 2023 01:22:13 +0200
In-Reply-To: <20231204233931.49758-11-andrii@kernel.org>
References: <20231204233931.49758-1-andrii@kernel.org>
	 <20231204233931.49758-11-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-04 at 15:39 -0800, Andrii Nakryiko wrote:
[...]

> @@ -6845,7 +6845,47 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
>  	 * Only PTR_TO_CTX and SCALAR are supported atm.
>  	 */
>  	for (i =3D 0; i < nargs; i++) {
> +		bool is_nonnull =3D false;
> +		const char *tag;
> +
>  		t =3D btf_type_by_id(btf, args[i].type);
> +
> +		tag =3D btf_find_decl_tag_value(btf, fn_t, i, "arg:");

Nit: this does a linear scan over all BTF type ids for each
     function parameter, which is kind of ugly.

> +		if (IS_ERR(tag) && PTR_ERR(tag) =3D=3D -ENOENT) {
> +			tag =3D NULL;
> +		} else if (IS_ERR(tag)) {
> +			bpf_log(log, "arg#%d type's tag fetching failure: %ld\n", i, PTR_ERR(=
tag));
> +			return PTR_ERR(tag);
> +		}
> +		/* 'arg:<tag>' decl_tag takes precedence over derivation of
> +		 * register type from BTF type itself
> +		 */
> +		if (tag) {
> +			/* disallow arg tags in static subprogs */
> +			if (!is_global) {
> +				bpf_log(log, "arg#%d type tag is not supported in static functions\n=
", i);
> +				return -EOPNOTSUPP;
> +			}

Nit: this would be annoying if someone would add/remove 'static' a few
     times while developing BPF program. Are there safety reasons to
     forbid this?

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5787b7fd16ba..61e778dbde10 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9268,9 +9268,30 @@ static int btf_check_func_arg_match(struct bpf_ver=
ifier_env *env, int subprog,
>  			ret =3D check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
>  			if (ret < 0)
>  				return ret;
> -
>  			if (check_mem_reg(env, reg, regno, arg->mem_size))
>  				return -EINVAL;
> +			if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)=
) {
> +				bpf_log(log, "arg#%d is expected to be non-NULL\n", i);
> +				return -EINVAL;
> +			}
> +		} else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_META) {
> +			if (reg->type !=3D PTR_TO_PACKET_META) {
> +				bpf_log(log, "arg#%d expected pkt_meta, but got %s\n",
> +					i, reg_type_str(env, reg->type));
> +				return -EINVAL;
> +			}
> +		} else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_DATA) {
> +			if (reg->type !=3D PTR_TO_PACKET) {

I think it is necessary to check that 'reg->umax_value =3D=3D 0'.
check_packet_access() uses reg->umax_value to bump
env->prog->aux->max_pkt_offset. When body of a global function is
verified it starts with 'umax_value =3D=3D 0'.
Might be annoying from usability POV, however.

> +				bpf_log(log, "arg#%d expected pkt, but got %s\n",
> +					i, reg_type_str(env, reg->type));
> +				return -EINVAL;
> +			}
> +		} else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_END) {
> +			if (reg->type !=3D PTR_TO_PACKET_END) {
> +				bpf_log(log, "arg#%d expected pkt_end, but got %s\n",
> +					i, reg_type_str(env, reg->type));
> +				return -EINVAL;
> +			}
>  		} else {
>  			bpf_log(log, "verifier bug: unrecognized arg#%d type %d\n",
>  				i, arg->arg_type);

[...]



