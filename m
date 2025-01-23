Return-Path: <bpf+bounces-49569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61361A1A14F
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 10:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88443ABAD7
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 09:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E59E20DD5E;
	Thu, 23 Jan 2025 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCwNQ9jj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2F520CCFB;
	Thu, 23 Jan 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737626236; cv=none; b=nB6eMrnvF3HpLCu22n2gdP5WjqM+HLcxHq4xukg3jEqxtssTnXMaQ0yBjNVIKrGfYGME4cYR+DYQzvVFb/1+tsC8zXfipFcvpBnWxYN76eP9JfM8gkIA5++5lsUX/o/YcOYz8xjG7QbgSCcG5R0hjQesB7A8rLJhDOzGR1LiOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737626236; c=relaxed/simple;
	bh=x7MrWrh9s4+2xOk6514eGbTBSVS0ZR49Q4i+dlUkIDU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GvW9Qbkvuf3beD2gosiQ8rCVby67W3K2b0Y9yOkMV6OmSKmkGaND0MHRmSmHbvYWWV+mcxVTtssf9//OxMkTFFnxvsQgSiNR6mo5EA7szzz+Y0K9eVU8uyU2Yw9AUZdsOUW5vIdKfVuAaKqDwJrSIe169dFaCYZPwUEQQyz5eEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCwNQ9jj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21649a7bcdcso10971465ad.1;
        Thu, 23 Jan 2025 01:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737626234; x=1738231034; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ucSoUf9zPoPz/2MmjdKOJuDYg9iHG9qEzkVprvIblnk=;
        b=lCwNQ9jjVSB98J4XuoJAiTx+vEhoyYg32DK5ChK4V8eZGi3vEk+ag0RZAzBfnpFbie
         EZAcMmwJ1vwx5lIcB01mLNqQ3/Uni3k9iTqm6d0JHFEr3wZeKgYwCbqsC+1Is7Qz6Ma8
         fdLO0qYwkVfWRMTE3yTWkt6Eg3+Kjvca/3cj/AcXFR1NeYD/51BAFNgnWSeByPJIOKik
         Uf826o9DE1pV8Xy8ZNHmWufKjgpouZee8HOea9ov/1w1595V+6c/HzlrolpsUSi5dK4a
         EE94jV0kzNbLTs/6mA+WhZS47xo5We6wMgSSKywhYuH+wg/D+G6kU1qssvdgwj6LgrC2
         OMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737626234; x=1738231034;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ucSoUf9zPoPz/2MmjdKOJuDYg9iHG9qEzkVprvIblnk=;
        b=nraFTv2pnHtjMvjmIPyauCTBu9Hka02zzRfO2lNPQ3r777xa0h32kSR915vNdyVzUR
         G9pX9yQpE56HIXpuhmc+8Fc0gXwXw2EFwFESilRlUUAD3CyfHWqIyIGmoAxTnMhqz7FU
         SB62EAlQfEqGPgFwq+aVYJvN8q3Dy/26ZFaENE0gKEQ6KF7/NyHSl8Xz4XnCRP64p4r6
         dSxczoMgOp4jjsTst9GWBICdwJcAveXY6LliI+tzhA1tkwGs8Udh1zrpwtGkFvZuydm+
         ZvvwiTnVylMlNHCzCvE1BSTE2lyqX1n7lQMK+YsoutgsunKZ5PWR4z/IYYsWnxBLyr2t
         zpoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGofxhbv+b/1wV9kSj8Ou24RlIBfb/yLcJyERLz6co4utF4sUAfzH6DFiU+KncvOUpW5pEBsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/MyebiEI3XrQEFoTxYamsaaIXVM4MvWw3sXucXjY9jOAPJXlU
	dmUauuvbd8A4cwMy6vcQavzKb97AHhkjWBTsslyCsGpszH5xBXKn
X-Gm-Gg: ASbGncv4jvxfsswSUW0WkoHpTdh8H/hrj+E2J8p5FpLDFjNPgPPBXNFEGpd2jlac+uX
	p44KOL91BacgXYIDdKRIZkv0ToOlPPq+e3SJAd/oceQlOMqhZdzyg7dBt35LuP+OquwxdO8rFGm
	AX9fFsG3sGn83pZXc2dcdw/hvhbR1Jd2Cgdr1/5L3qJeD7H51j5e8bPjfDMPUoiiAZSrxqs2829
	APCD22oKlr17rpg5E4qipLltCGwQrjWCgUuaCCzax9+gDo7rHd/4zEpNZhIYQeH36IdE/sf8LXa
	UQ==
X-Google-Smtp-Source: AGHT+IFO7qmxrrtvSmdmUK7vk8xIIt4eT66KKBZvZdmEy9g8EqyAjovKPL8+E/kxvoRkZcWODKRkCg==
X-Received: by 2002:a05:6a00:23c3:b0:725:b201:2353 with SMTP id d2e1a72fcca58-72daf997326mr34263065b3a.13.1737626234114;
        Thu, 23 Jan 2025 01:57:14 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f06e6sm12762936b3a.34.2025.01.23.01.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 01:57:13 -0800 (PST)
Message-ID: <ce15f61de21a4415d00d2e52c2eedc63564093c8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 01/14] bpf: Support getting referenced kptr
 from struct_ops argument
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, stfomichev@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, amery.hung@bytedance.com
Date: Thu, 23 Jan 2025 01:57:08 -0800
In-Reply-To: <20241220195619.2022866-2-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
		 <20241220195619.2022866-2-amery.hung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-20 at 11:55 -0800, Amery Hung wrote:
> From: Amery Hung <amery.hung@bytedance.com>
>=20
> Allows struct_ops programs to acqurie referenced kptrs from arguments
> by directly reading the argument.
>=20
> The verifier will acquire a reference for struct_ops a argument tagged
> with "__ref" in the stub function in the beginning of the main program.
> The user will be able to access the referenced kptr directly by reading
> the context as long as it has not been released by the program.
>=20
> This new mechanism to acquire referenced kptr (compared to the existing
> "kfunc with KF_ACQUIRE") is introduced for ergonomic and semantic reasons=
.
> In the first use case, Qdisc_ops, an skb is passed to .enqueue in the
> first argument. This mechanism provides a natural way for users to get a
> referenced kptr in the .enqueue struct_ops programs and makes sure that a
> qdisc will always enqueue or drop the skb.
>=20
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---

Hi Amery,

Sorry, for joining so late in the review process.
Decided to take a look at verifier related changes.
Overall the patch looks good to me,
but I dislike the part allocating parameter ids.

[...]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 28246c59e12e..c2f4f84e539d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6682,6 +6682,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
>  			info->reg_type =3D ctx_arg_info->reg_type;
>  			info->btf =3D ctx_arg_info->btf ? : btf_vmlinux;
>  			info->btf_id =3D ctx_arg_info->btf_id;
> +			info->ref_obj_id =3D ctx_arg_info->refcounted ? ++nr_ref_args : 0;
>  			return true;
>  		}
>  	}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f27274e933e5..26305571e377 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -22161,6 +22182,16 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog)
>  		mark_reg_known_zero(env, regs, BPF_REG_1);
>  	}
> =20
> +	/* Acquire references for struct_ops program arguments tagged with "__r=
ef".
> +	 * These should be the earliest references acquired. btf_ctx_access() w=
ill
> +	 * assume the ref_obj_id of the n-th __ref-tagged argument to be n.
> +	 */
> +	if (!subprog && env->prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
> +		for (i =3D 0; i < env->prog->aux->ctx_arg_info_size; i++)
> +			if (env->prog->aux->ctx_arg_info[i].refcounted)
> +				acquire_reference(env, 0);
> +	}
> +
>  	ret =3D do_check(env);
>  out:
>  	/* check for NULL is necessary, since cur_state can be freed inside

I think it would be cleaner if:
- each program would own it's instance of 'env->prog->aux->ctx_arg_info';
- ref_obj_id field would be added to 'struct bpf_ctx_arg_aux';
- parameter ids would be allocated in do_check_common(), but without
  reliance on being first to allocate.

Or add some rigour to this thing and e.g. make env->id_gen signed
and declare an enum of special ids like:

  enum special_ids {
  	STRUCT_OPS_CTX_PARAM_0 =3D -1,
  	STRUCT_OPS_CTX_PARAM_1 =3D -2,
  	STRUCT_OPS_CTX_PARAM_2 =3D -3,
  	...
  }

and update the loop above as:

	if (!subprog && env->prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
		for (i =3D 0; i < env->prog->aux->ctx_arg_info_size; i++)
			if (env->prog->aux->ctx_arg_info[i].refcounted)
            	/* imagined function that acquires an id with specific value *=
/
				acquire_special_reference(env, 0, STRUCT_OPS_CTX_PARAM_0 - i /* desired=
 id */);
	}

wdyt?


