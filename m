Return-Path: <bpf+bounces-29484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2EC8C28EF
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 18:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4BA4B21B6C
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 16:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB181758D;
	Fri, 10 May 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MrFGm8HR"
X-Original-To: bpf@vger.kernel.org
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214BB14F90
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359663; cv=none; b=UGYHSUB7yqav0E70ucK5jmwd02FdAmrdI8WC9EFdm52jOszBSRHp3u3aWZdvrTOLx7iGhR6vD6ujAelcBP+bxIcsipH50HLaeoa+tMQw6nMaQU9O/2fjoCUg/9jqgRJYnw8u1CIgzUiDzLtneTJS5AcW54EDTzKwPj0rrlCv0+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359663; c=relaxed/simple;
	bh=W6GeWHlPCwE5MhjXRcxJ+3YcZWzGFuF32W13U92QquU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2OGOzcj7RgLYPAeP82QZELkSDYtjgtaogwzsLKvL6tkugLD9fQP48ADMOAZnHaduqEH/lZwW4abOk6KxCT6o+0uIRUMO4rEuPZ4rUoYlB+TQPRtCA+/29/D0ynuObCAP1OJv1s2AQt8XSDWbf488Lkn/ABqYbKWRzDADYCjnh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=MrFGm8HR; arc=none smtp.client-ip=66.163.184.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715359660; bh=6JC4c7M9zN+e9IcLHOfZPWVSXDalQGIAS82BEuAAnE4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=MrFGm8HRVWJ1OS98DX9d08dVFRpFjL87Hb/MREt3lqldjr3RhPWatLjSxfDbn5+TYkH+uSgswAGXEE5b7+qrdsD6v1xcvUAupRcDHUtr4HoM/NuXdWA9AgAGBfvAzSVzefhbHLp1/S1m6QVZSf+BIag/3KOqine9hg12qm72lIhRgFl31nnI5H2htorjsmexe7L28lZWVYm2s5Iyq6NRdUE1YKWHEtQA0I6SRTRsgDNnDxwlLXu8KFpArhdzW/D5crRuILpz9lFCxnOdXsJVy1W2KxtQCExn0Lhc2EzvgPCJNM9NJTGZpkzLnghVtiOWsrwcpD8OjdP7MAyFoUPEAA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715359660; bh=wogl3bYj0c0VBJaR5J46RWr7A58LX/OyYDljNah8Gsi=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jQLNEzEeSq7HnE0AntmP09e8IKLVcHG2dxaVz1SLHx66Nx9jdCGYW5q0njxlX8LV1qGNR6iFxwpLmGgD2qyzaBIIXpgaFYJwA325K8YA6K4QUd8dRN6J3p918QKQf8RVjwoH0pk4xhEcaqd6+8h1MuBGESJP1XhlplnZ5vtGTgG9kRqV8cHstFy2GFt4aEVWRYgGA5epn7+Fvkm+0wfDnetJzmoKi4gBCSpPhl1/piGdGxGMUA0aOzbl8y6xp5x2jFBzLl3PaEGTXpYkq3/2hbdC9PCxAFUnPHLZHlOyMHJswDkT7uwLwjBwbeEPlqtMJsvXzkNSZT7rYnZGf9EE8A==
X-YMail-OSG: tSPF1TMVM1kN67GXFncnlW3dSEKLo6EPqX.CEix5Vct8cX6D3GLwWcAwc49VpyI
 WH4ebIPY92bbXo7qQoGK1nPm2sr4RbosoA3i3.IASHQjarc5iAEXy3DJdWoso9cxJILJQWuvKMj2
 vzzt11caVF7sbTpbqZUYYqetQGPXXVin.3hMp04LHWnXZOihG8U9la.cNTNZ56148sLmRsdUSLBJ
 p06O1pcYfHbC4HsaHLdwWa1xf9NgNuRkjBnCG45yQaBwJR7T1vpLMRIySi7KoJ9V_rNZecgL3zrm
 Z96riAxsiqRk_b_1R4G9Gkq.MYw9KiNVOjnXRwFGl3h5E_lE1X_15OrkjQ0Dpv8.UA6fOErY.Yfm
 iqDARLkieoRxEjbWjSzHo2aQcN483IBcgBXnZI2bIP46RhoA.eo6cd7gSGgZrIEvv2iSnaR0.iZH
 q7qaNg7fHwus9PGyiTmpEwwEo55N7zWck40RNL0rXRNLzOs9BfHSW_cikuBh162Jbit2XQdfV8m0
 663Jg_M77gp9MdwtOKICvqxrIK5NQ2_fThuaph7Wl.tH0hVFaTk2gp.ED56tMYOTt89DJsdmg6EJ
 FbW_3cS7YVNuQ3ArhM5eeBn3X2KA5HBO3Y9Ua9dDxDi57MuNWETgf0fag63H.H0Zd.6Gd0nU_3OH
 zvuVajFCTCrq3Z7CzAVsgiZd536BFYC_VZ0zMUZvEXE1C5xDdpiekodrIzU5ONNqwZo6s1JvGavH
 NXzhp9bQU1vXJzeMOvl2NqdsUnZeaW0Ch6pC.x56tIHj2fqQ54YYIABdPpEL_zxKbLWdHDZOiUbV
 ZGLLF4XQkffGToJZmTmrnCawxC7cNedKMy0FptEIaCBnvmVOuNfDKftXfL7EboTZGH5U7ZqhDSvB
 W07.BdlDFLn2QBR9sykZ2DsvZajk9nrkB7ao4_MGXTtoYJkV7i1cwySePSuws.LrPm5Ai3N9y_g0
 ADpvOAxySDzOWRW5GlFKMzpolIgtyzBNomhl6GshZc10ANS0ihzdf4fvx44SRxXP7sl8lWnCpFp9
 FhFjr4kZQkITUNXM5LbVPkNwjYILFsFWxG5MpTa0lBKEYuxWkPCsD9MquolsFam1.Jf1VhnY7quq
 8sAA8.Avj5GCu0JammBYYIvfnW_G8dRZbt3UV.xEapx.ZD8qdEj9o5h6zvgnsJQy4A4h2RzmAywh
 meUza7T9HMaCIuh3wYIVVsQxEQMIUWeyYgSvV6eJbFrRTY3NFEX2FwDVhagQoJOgOt.r032MYtKX
 rx8pLAcZXfylAsnXz9mJurQiVbhQiAXIIbP4VxTnGtvlcxOA8IwxcQHfME0qFN5YWBzrjMz3MFH2
 gwygagnWs5KWlG4lTuweg.Z.izGnSQ72bj6yec5fTH49UQLyPgxwBXzugX3DGLdEKb6wUwEkuc9M
 .b4ZiNT0JkVdVmRobYkcRIaLVzVWqzwl7A.ZyWIESzpmL1iNt2w6TH4UdDqrNeUnIqyrKPV4hiZk
 SrY0Zv57iQTUx.CW98coSoqgw_Nq2H.UZ_TFhhcLIxcrUXz45qMNn3aqxNDbURylZ6WHZ58IcyhO
 V4KJGaW9flBviMoOM13ITlqtg9MRU1easbzWVJP.sgop8p5jEOQYpoXcU6LAJXj8mrIwh7KgRyxd
 xToNoi3YAFYGAqS.wEpnd5_KNAgdW3iTyWkmbsXy8le0_BWNXqYK7VT6VOKSbyqEaEQcf1lL5Xro
 xuioIsgSjKMhm9RU.BepwNKJRJyDGqHaGw2lELWsWrUocML7RWeYwaH6TOIxEs0KP6HeMHrpBMdW
 Eyf3EEYNrr26xaLFB0xAXX5UvzGca2aGVkUdNRXIY7F4H8t2.MQqiox8m7V_b_P5VozfhpmwfVHZ
 2pqsdi7ZYYJobYtHH7nGmGhjD1rYhLNTn5duM7xvpVq7Q9VVo2vASa9VomhkTC.bLFU9D1338BZN
 mbO0Oidy5V2DpNaa2USEazhXXoCu3xirnMYpvKGby9ye2JQaiJotirYmNo8ANju.CCxEPxpuIF68
 7bI7sYoQ3PdRSLyhxMzVycBotDgpAeJnpMO28eNr9AaU0rRDSUgSI0vfm.KsZ0sPpjXJDfDc2Doy
 cuzA_H1FG7NR.qsomCXH7eN5Uyl5ZbkAG8aQROSZkQGLAeO5KCS04l53MWC5GINXIuZ9QZj6abYz
 SM_uTzsl0k7rS5vvKNi1W9kcxJYb1hRarIN0nppiXC9QiFPsCV7ISgYMqFmYimKsmxMRq7LrZZ1m
 fmglWQI21pMRrfkl4ydBudTh96NylxSDTtQv8ky1e650bl4o5wwTrSpxT89OI.LBm9ISPFi303xF
 Ykyh0qCagI7n3jEwANw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 617abb55-02ae-491b-b856-8f59c7024a06
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 May 2024 16:47:40 +0000
Received: by hermes--production-gq1-59c575df44-f4snh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0ff3e2b4d3d5ba5569bd0a7619da345f;
          Fri, 10 May 2024 16:47:34 +0000 (UTC)
Message-ID: <a4d3a0dd-2ef9-4fbc-bf72-fa6cd84231d8@schaufler-ca.com>
Date: Fri, 10 May 2024 09:47:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/5] security: Count the LSMs enabled at compile time
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, paul@paul-moore.com, andrii@kernel.org,
 keescook@chromium.org, daniel@iogearbox.net, renauld@google.com,
 revest@chromium.org, song@kernel.org, Kui-Feng Lee <sinquersw@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240509201421.905965-1-kpsingh@kernel.org>
 <20240509201421.905965-3-kpsingh@kernel.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240509201421.905965-3-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22321 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/9/2024 1:14 PM, KP Singh wrote:
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
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/args.h      |   6 +-
>  include/linux/lsm_count.h | 128 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 131 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/lsm_count.h
>
> diff --git a/include/linux/args.h b/include/linux/args.h
> index 8ff60a54eb7d..2e8e65d975c7 100644
> --- a/include/linux/args.h
> +++ b/include/linux/args.h
> @@ -17,9 +17,9 @@
>   * that as _n.
>   */
>  
> -/* This counts to 12. Any more, it will return 13th argument. */
> -#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
> -#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> +/* This counts to 15. Any more, it will return 16th argument. */
> +#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _n, X...) _n
> +#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
>  
>  /* Concatenate two parameters, but allow them to be expanded beforehand. */
>  #define __CONCAT(a, b) a ## b
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

