Return-Path: <bpf+bounces-32547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E19190F993
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 00:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206341C21F2A
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 22:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B0882C60;
	Wed, 19 Jun 2024 22:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvI8uZYj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C0E763EE
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837601; cv=none; b=c5uhvTosTyHueQHIqN1h20c5Urm2GRIGD0PVhLgleZWyQ7CGdGwc1DnWaB75uOPG5bKQ/el+lzvNssOPdSokPdh1jjziuDuxAjNvGgw8cHr2AnMbVIf/BZSGmQe7MwvsHC5m98ECYUe1CkIdJ7hyOKi3GAA5ZBTt95JZpH3pVMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837601; c=relaxed/simple;
	bh=9VlmOWBsE0EaPzUnOkDtefbL+S2GN92At/aAbtgwUk4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=icS0EJcsuEhcLkvY2k933nGEmDj8/75XX1kiDoU8s+aIJqdmXypSS2JJ9NazhRU7r4fwlZCBazDrRiDPmoe+plYvpUHKQBza9VN5TIkeJ/EfBJVWsAgWgiGztTtBkuH3IFNOUKJUQrQcgEeSzyJtg5at1/GUfzRJachLZPC7tlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvI8uZYj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f47f07acd3so2205305ad.0
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 15:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718837599; x=1719442399; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7tBjX4+1mPy/yE0AtNn3E7NR3S9qq47OXPUHX/nYVyo=;
        b=VvI8uZYj3nYzfAYe62d2ESWIoDPKUIjv3/gK0BUXB3NeWN720OQYNJAsGfcOUbcXb5
         yTNzRWCCWPpcmTliB+Y2LuO3xDE3Od4FhzULsSNZD6QFDwwmyH2JlikviD4NO7uRTw+O
         iwzhTGVoS6nNMfAU6vjphnc4yvBYmeTx9xMJBl8XLhqvh5zj71S5sZPk64rbwPFeI27/
         eja/ZuIxsP8tj66wHErSAMlGOuF5P5awKgpNebm9IwIbEP2CfFXAS21uXXkZoteCOtyr
         a6vPLDp0DzjOZ1JHG1KgAzJ9EO/c2Xs3H60sn6NzcsMxOgLYQX1lh9Jzz+am+8L06tgB
         1WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718837599; x=1719442399;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7tBjX4+1mPy/yE0AtNn3E7NR3S9qq47OXPUHX/nYVyo=;
        b=C41qzGHpuJaBOLPnOdQ+LLYx+foADtjFAlIXfU71rWdA1pejHzgxbbQKgwgNr1JpDv
         N+QG/cnZ2FIkEqGhGnRfxih8rsbrsZkYFXBMh0stPn5cqpGtmNF/9xHPkrtfonp7MGDH
         hvCPbESws+RmilxpHXgKcTbIqDpSCsyUkoICfx9Uj6k8dXbSSkxjnWa0kF+KQATOw+pO
         0A6oO9mbsbdGaSUl9K1mPA+X31A+1BFpJOtKbirws39jZ7N0yuJZ0CWt3p9RNl3Dte9T
         jNnlkDhjaRKqIEE7QdQ5m/puI8dzqS2E1QiZm1Nmw5YxeRcaa9WANLWh16Qjj7Fjra1e
         BH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7/MHAFtZBGbqPB6x+uztvN1eY+apBMb96KuA+MbDxM6Ul8TCMbQ0ztXIaKw4SX9Q3w4rWuf7B3P9aPs5dlQkMaZr3
X-Gm-Message-State: AOJu0YzdFqDD+r3ncyp98qaP1HMoMmL9uWAnCR71cl1Tv56uZ/GLxQ3F
	fcnVIpXGgSxheajoDN+KuwxIr9TegI4+kHV0pXm2IUw8kF6VMUBA
X-Google-Smtp-Source: AGHT+IHU/SlUOI48fDOkvxWvR7cthX8bG+wHQYM1QVtM7Qh0uKRZQKCWdocBVmAvbexWpFa5XYCPRw==
X-Received: by 2002:a17:902:d382:b0:1f6:fe0d:ad47 with SMTP id d9443c01a7336-1f9aa46e784mr34086505ad.62.1718837599274;
        Wed, 19 Jun 2024 15:53:19 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55e5fsm123240285ad.59.2024.06.19.15.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 15:53:18 -0700 (PDT)
Message-ID: <98105e974668a12d72cb3bdf490a70a4b1e227ad.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: add missing check_func_arg_reg_off() to
 prevent out-of-bounds memory accesses
From: Eduard Zingerman <eddyz87@gmail.com>
To: Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 kpsingh@kernel.org,  sdf@fomichev.me, jolsa@kernel.org, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>
Date: Wed, 19 Jun 2024 15:53:13 -0700
In-Reply-To: <20240619082946.2389067-1-mattbobrowski@google.com>
References: <20240619082946.2389067-1-mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-19 at 08:29 +0000, Matt Bobrowski wrote:
> Currently, it's possible to pass in a modified CONST_PTR_TO_DYNPTR to
> a global function as an argument. The adverse effects of this is that
> BPF helpers can continue to make use of this modified
> CONST_PTR_TO_DYNPTR from within the context of the global function,
> which can unintentionally result in out-of-bounds memory accesses and
> therefore compromise overall system stability i.e.

[...]

> Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---

Hi Matt,

Thank you for fixing this bug. Overall looks good,
I second the requests from Kumar + one nit from me.
Also, note that kfunc_param_nullable/kfunc_dynptr_nullable_test3
needs an update.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -9464,7 +9471,13 @@ static int btf_check_func_arg_match(struct bpf_ver=
ifier_env *env, int subprog,
>  				return -EINVAL;
>  			}
>  		} else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
> -			ret =3D process_dynptr_func(env, regno, -1, arg->arg_type, 0);
> +			ret =3D check_func_arg_reg_off(env, reg, regno,
> +						     ARG_PTR_TO_DYNPTR);

Nit: Please avoid splitting lines too often, this line should be:
			ret =3D check_func_arg_reg_off(env, reg, regno, ARG_PTR_TO_DYNPTR);
     the limit for line length is 100 characters.
     There are a few more such places.

> +			if (ret)
> +				return ret;
> +
> +			ret =3D process_dynptr_func(env, regno, -1, arg->arg_type,
> +						  0);
>  			if (ret)
>  				return ret;
>  		} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_BTF_ID) {

[...]

