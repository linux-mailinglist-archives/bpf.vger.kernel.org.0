Return-Path: <bpf+bounces-29925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029658C826F
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 10:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA74B223A6
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 08:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C661B809;
	Fri, 17 May 2024 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DmkMWjRn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E3822EE8;
	Fri, 17 May 2024 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933399; cv=none; b=QzRRLMHocIKwiU7J3q+t8k0TtctEYhpsodQwaVjdhwfLuorOPH/bsF6R27AjnWM588cP620xtobGcSzGUR5uKP1YMCK2RZplY4uOEm2cQfCxOUZYqdTVsP1cydGDrfzo3E5bM3f0fHo626jSm5negXB6kzfFMGNgK6NE7Nc9/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933399; c=relaxed/simple;
	bh=wNEzgGHOjrndbGdT+4iN3Zp8tASOmsliZN8MhPwij5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PikCsV+7DxS4LH/YQC5uee4M9cfIzKFPQWlYV6Gku5qKgkZsqhbzo53Jkmls+BQnjk7xB8CLjRBzV4T/CX6dghbpVTnA8FX8JNUBgGyg3kYqZdmG9LtxxahMDoLYVNfUFRCTkG8gyyM4rlwpnmXyG5A0+PO5KxLCMdfo73//O2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DmkMWjRn; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.8.193.2] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D3CF73F103;
	Fri, 17 May 2024 08:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715933388;
	bh=PRtVwgpx4S0MflLTqf0VyebjH24V+iLMQE8myIRBDzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=DmkMWjRnT+y28G6OVilDXkBdO5pgpZ8TcdhDT+K8/aLALpQaN8wRnrs7MACjMV0Xr
	 SDo6NEVx9bVrqp8jnMaP4a42A3foSSXzIJZNLbp+VxjQeTwoYe5a7yh6/TWdPTRiv4
	 rU13StK43q6X9AuDsExIr1XPBIb4caPFTN8LRtAx1svs+d1Qr3MeMdQxYLyn8QI6b6
	 EAs5C53Qb5L2EyIF539M/MztKirb2YEKAf8jtrdZ5YZgZq9uNJKAEgM0Ke+Te2Fs28
	 akkIMvHQk5tnTwTNO2yJwi6+A5OkRPXgCgzVgLaJ234JvEp4iQuPHLTqcO7dAbHcIX
	 SUGiWhQZFWAvg==
Message-ID: <9dca979e-2e8d-4078-aa4f-bc54e1ddbf49@canonical.com>
Date: Fri, 17 May 2024 01:09:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/5] security: Count the LSMs enabled at compile time
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
 andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net,
 renauld@google.com, revest@chromium.org, song@kernel.org,
 Kui-Feng Lee <sinquersw@gmail.com>
References: <20240516003524.143243-1-kpsingh@kernel.org>
 <20240516003524.143243-3-kpsingh@kernel.org>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240516003524.143243-3-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 17:35, KP Singh wrote:
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
> 
> Without this one would need to generate static calls for the total
> number of LSMs in the kernel (even if they are not compiled) times the
> number of LSM hooks which ends up being quite wasteful.
> 
> Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

looks good
Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/linux/args.h      |   6 +-
>   include/linux/lsm_count.h | 128 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 131 insertions(+), 3 deletions(-)
>   create mode 100644 include/linux/lsm_count.h
> 
> diff --git a/include/linux/args.h b/include/linux/args.h
> index 8ff60a54eb7d..2e8e65d975c7 100644
> --- a/include/linux/args.h
> +++ b/include/linux/args.h
> @@ -17,9 +17,9 @@
>    * that as _n.
>    */
>   
> -/* This counts to 12. Any more, it will return 13th argument. */
> -#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
> -#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> +/* This counts to 15. Any more, it will return 16th argument. */
> +#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _n, X...) _n
> +#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
>   
>   /* Concatenate two parameters, but allow them to be expanded beforehand. */
>   #define __CONCAT(a, b) a ## b
> diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> new file mode 100644
> index 000000000000..73c7cc81349b
> --- /dev/null
> +++ b/include/linux/lsm_count.h
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2023 Google LLC.
> + */
> +
> +#ifndef __LINUX_LSM_COUNT_H
> +#define __LINUX_LSM_COUNT_H
> +
> +#include <linux/args.h>
> +
> +#ifdef CONFIG_SECURITY
> +
> +/*
> + * Macros to count the number of LSMs enabled in the kernel at compile time.
> + */
> +
> +/*
> + * Capabilities is enabled when CONFIG_SECURITY is enabled.
> + */
> +#if IS_ENABLED(CONFIG_SECURITY)
> +#define CAPABILITIES_ENABLED 1,
> +#else
> +#define CAPABILITIES_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_SELINUX)
> +#define SELINUX_ENABLED 1,
> +#else
> +#define SELINUX_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_SMACK)
> +#define SMACK_ENABLED 1,
> +#else
> +#define SMACK_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_APPARMOR)
> +#define APPARMOR_ENABLED 1,
> +#else
> +#define APPARMOR_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_TOMOYO)
> +#define TOMOYO_ENABLED 1,
> +#else
> +#define TOMOYO_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_YAMA)
> +#define YAMA_ENABLED 1,
> +#else
> +#define YAMA_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_LOADPIN)
> +#define LOADPIN_ENABLED 1,
> +#else
> +#define LOADPIN_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM)
> +#define LOCKDOWN_ENABLED 1,
> +#else
> +#define LOCKDOWN_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_SAFESETID)
> +#define SAFESETID_ENABLED 1,
> +#else
> +#define SAFESETID_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_BPF_LSM)
> +#define BPF_LSM_ENABLED 1,
> +#else
> +#define BPF_LSM_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_LANDLOCK)
> +#define LANDLOCK_ENABLED 1,
> +#else
> +#define LANDLOCK_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_IMA)
> +#define IMA_ENABLED 1,
> +#else
> +#define IMA_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_EVM)
> +#define EVM_ENABLED 1,
> +#else
> +#define EVM_ENABLED
> +#endif
> +
> +/*
> + *  There is a trailing comma that we need to be accounted for. This is done by
> + *  using a skipped argument in __COUNT_LSMS
> + */
> +#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args...)
> +#define COUNT_LSMS(args...) __COUNT_LSMS(args)
> +
> +#define MAX_LSM_COUNT			\
> +	COUNT_LSMS(			\
> +		CAPABILITIES_ENABLED	\
> +		SELINUX_ENABLED		\
> +		SMACK_ENABLED		\
> +		APPARMOR_ENABLED	\
> +		TOMOYO_ENABLED		\
> +		YAMA_ENABLED		\
> +		LOADPIN_ENABLED		\
> +		LOCKDOWN_ENABLED	\
> +		SAFESETID_ENABLED	\
> +		BPF_LSM_ENABLED		\
> +		LANDLOCK_ENABLED	\
> +		IMA_ENABLED		\
> +		EVM_ENABLED)
> +
> +#else
> +
> +#define MAX_LSM_COUNT 0
> +
> +#endif /* CONFIG_SECURITY */
> +
> +#endif  /* __LINUX_LSM_COUNT_H */


