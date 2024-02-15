Return-Path: <bpf+bounces-22044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B30D855899
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 02:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50337B266F7
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 01:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC61EDE;
	Thu, 15 Feb 2024 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlu1fxk+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77632EC7
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707959445; cv=none; b=BWrGuwwbZYc2qd2tpZWcQJ5bLTyVZP1lkoq8yyQ8YaC/826RMX+An+SlCJHkjPV7tAVg7seEIly+iRLHWK+LCwlV4wnmlk411ejGpsq4MWFM9rEK8JVLCyJkyJR10/xhLG/jwm1C4Mxy70T4qecoEvCdQllmzlM8RAwKRYRiECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707959445; c=relaxed/simple;
	bh=3NkI6e6dmyDYqpMIbgt0eaUm0gBqZ9YC7eg+d3omuXY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EDs9ISV4eQOmj0Vb42nBx825nJQ8xZHxdf+Egf71eZZC3pPduEOhB3XBnsZ6CyywqntJfvjztSb4JXT9UANFbcl3k4w+sv+nIZzzh8bkvDnlaYZtmzGy7oT8n4AGMs/hnl+Bz1NKpx+tqfFQVqmUqhQbajitio6vdnrp719wOzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlu1fxk+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3c2efff32aso36372466b.0
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 17:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707959442; x=1708564242; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NJrqXdDkNtR5y6zLRjxfnY/XhEPvaJUrB7G6u2ypcGI=;
        b=hlu1fxk+IUpC7Zxsgntbm3dNrA8MPs+5jUBmKEBOXWo4oZ6RxDPqnNB44tbYmmMKuz
         5/YtkqPO5FoVCyalsQ+FAsn7TOuVLDz4zYo7S2A8JZIQaxyK5tPyMQYOH9Zsd1jzBh2e
         nRxyzKFEk6bOXx1j+Sra31YwLFW2X8DlLH0l2+v7fNIcKa/lfmVfs29dUA/2yUjY7Rpw
         z3jh+Sg7L3GG8/pRz27iaQ1vwC0X8K1SdNivtDSsvlC68Z5X7j0+C2fS8ODpmSxxH2vR
         sThjWOEuQaPcZmyUKfGaSpbt0mLH4eBMvxLO2CKoVPff1JDFHoAOBEiimAH58ZqHRWpe
         8aUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707959442; x=1708564242;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJrqXdDkNtR5y6zLRjxfnY/XhEPvaJUrB7G6u2ypcGI=;
        b=tCPcLBLr2EHvHrSKJ/q8mazS/2o/WWrD1Q6v47zbSXxgdbc8UgFe1jVUl0uwN7QBZN
         DRpvr1npNJAl988C/H3S+PbziKMr72pGfvTFuyf2HAJJJ/9y3CvynQhGOdaroUAsXgQj
         Bk+hX1xO1k8nmSKSY1Gwn7rwRwN9HwVh+qJcaXqwQHAb2+1cmBC77buhErS9Y85VWcG5
         wfArijGbII2CpLF64UigqXEdsII6FSguKGtg8mGdpK4souSDGYy6uNPSvVz1szeMPf7f
         v7OOGNbxM66vaU4uFCvomL7I7gaaCemUildazyD7E5Irbxz5IxLcPJ7yOBIAoxcbh/RP
         EgzA==
X-Forwarded-Encrypted: i=1; AJvYcCUfVDPSh37cl5xiUYcn8BqTWq0bfZVJk5nzaJEzUFa1ROWokB1jpsZPui+3L8qhxUlGs+qDV8YfxdXNk4JPLlMzUarm
X-Gm-Message-State: AOJu0YzDCSbg/B0KuSbysl74D3dHrWw/5o7Q9sdMDbaplgvRzd1p38VP
	qSS1fKxUPR68SH9zRdE/k9CRJqm+xhKisCTENDEjYeum3/XeqB9ecG37Fbf6gPI=
X-Google-Smtp-Source: AGHT+IEGTDDNxjRQegPd4AcgLfQWOa/fPodlcm5WSbqivcUWLbvIP0eVWyL0O07+qdJCJPu4sA34TQ==
X-Received: by 2002:a17:906:a8f:b0:a3c:be5b:ed90 with SMTP id y15-20020a1709060a8f00b00a3cbe5bed90mr202384ejf.16.1707959441531;
        Wed, 14 Feb 2024 17:10:41 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lr19-20020a170906fb9300b00a3d4db8ecd8sm48335ejb.99.2024.02.14.17.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:10:40 -0800 (PST)
Message-ID: <6bfdc890c49fe4836aa18dcd509c9d3ecc05e26f.camel@gmail.com>
Subject: Re: [RFC PATCH v1 02/14] bpf: Process global subprog's exception
 propagation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,  Tejun Heo
 <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
 Rishabh Iyer <rishabh.iyer@epfl.ch>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Date: Thu, 15 Feb 2024 03:10:39 +0200
In-Reply-To: <20240201042109.1150490-3-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-3-memxor@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 04:20 +0000, Kumar Kartikeya Dwivedi wrote:
> Global subprogs are not descended during symbolic execution, but we
> summarized whether they can throw an exception (reachable from another
> exception throwing subprog) in mark_exception_reachable_subprogs added
> by the previous patch.

[...]

> Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Also, did you consider global subprograms that always throw?
E.g. do some logging and unconditionally call bpf_throw().

[...]

> @@ -9505,6 +9515,9 @@ static int check_func_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
>  		mark_reg_unknown(env, caller->regs, BPF_REG_0);
>  		caller->regs[BPF_REG_0].subreg_def =3D DEF_NOT_SUBREG;
> =20
> +		if (env->cur_state->global_subprog_call_exception)
> +			verbose(env, "Func#%d ('%s') may throw exception, exploring program p=
ath where exception is thrown\n",
> +				subprog, sub_name);

Nit: Maybe move this log entry to do_check?
     It would be printed right before returning to do_check() anyways.
     Maybe add a log level check?

>  		/* continue with next insn after call */
>  		return 0;
>  	}

[...]

> @@ -17675,6 +17692,11 @@ static int do_check(struct bpf_verifier_env *env=
)
>  				}
>  				if (insn->src_reg =3D=3D BPF_PSEUDO_CALL) {
>  					err =3D check_func_call(env, insn, &env->insn_idx);
> +					if (!err && env->cur_state->global_subprog_call_exception) {
> +						env->cur_state->global_subprog_call_exception =3D false;
> +						exception_exit =3D true;
> +						goto process_bpf_exit_full;
> +					}
>  				} else if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
>  					err =3D check_kfunc_call(env, insn, &env->insn_idx);
>  					if (!err && is_bpf_throw_kfunc(insn)) {




