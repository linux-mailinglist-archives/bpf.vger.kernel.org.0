Return-Path: <bpf+bounces-29924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0608C8246
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 10:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254031C21BB6
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 08:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D08821373;
	Fri, 17 May 2024 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="elrPmV5g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3007328DA4;
	Fri, 17 May 2024 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933053; cv=none; b=cSCqHYXEQmsZiVQqapnJOt2NWP8iu8A0P6c8kHPB7L8KVz4+pZqLNsVWTiPvdeeUzNLGYeRPutqocLSEp+HMCaU1ih0DHPyp6Kvu2OaY0vRT5+Eg7mRveJSHNsiUy3cHxSlawNtcxDfdyKhHEfMLFheLZLPBNVqeYZ8sXKJHkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933053; c=relaxed/simple;
	bh=XZaa9vVqsuZLVJrkk5kjpUcAzKBYKYdObS8BQonHeW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1rcxYcwThFxjgKE1cCDpfNlx9Oo9CMjH8Jz8P3EJOPSQFsa6c/rgl9ox4q1T90v7ttNN/K/iZ11kw+lW0A9pdCvNWjmKkz0Pw9yfXHJ/xQbN48ZXYChlWIUIef8ApruQU2RiIuZwnWuQg8s6E5vj7CAQeEEuY2qH+rnZwSyvmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=elrPmV5g; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.8.193.2] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A006E3FE21;
	Fri, 17 May 2024 08:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715933041;
	bh=6f73wJOpnXPfmlfzDSwmA5b/rEYNvgxqFktpdTrtfUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=elrPmV5g3rjnj2J662xKlGIJbHULQvyzFSUjJPO0AsG0V8b/Xb4A4dB1MtvqbLgP2
	 MPQzPDcsOeJoqBpBJRT1Wai/+9WRDwwKn7sAPAiK9y5ulJHGbi13gl4eyep5wQWEOt
	 3wPNAu5I1Tn8HZ1DLR9+p9q+wyuBt26KPmytWzlo12jAVwDlw4d3VCS1+6RBO28szD
	 uAzz5opx+bnA9Z5DOJNhg+BvvWP8NbXTx3RavG4cVQFeCaaDUh3rYrH3BUO3Gq1j1R
	 U4MENsC2iViccilIwIqEWJ8lNmBWvbz02UOOFYvINt90a2NdrUxdgoaRQmHxFQDO7f
	 TS2SksYF7FfQQ==
Message-ID: <3e50ac39-2dde-47e7-8415-2b57f461094f@canonical.com>
Date: Fri, 17 May 2024 01:03:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/5] kernel: Add helper macros for loop unrolling
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, paul@paul-moore.com, casey@schaufler-ca.com,
 andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net,
 renauld@google.com, revest@chromium.org, song@kernel.org
References: <20240516003524.143243-1-kpsingh@kernel.org>
 <20240516003524.143243-2-kpsingh@kernel.org>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240516003524.143243-2-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 17:35, KP Singh wrote:
> This helps in easily initializing blocks of code (e.g. static calls and
> keys).
> 
> UNROLL(N, MACRO, __VA_ARGS__) calls MACRO N times with the first
> argument as the index of the iteration. This allows string pasting to
> create unique tokens for variable names, function calls etc.
> 
> As an example:
> 
> 	#include <linux/unroll.h>
> 
> 	#define MACRO(N, a, b)            \
> 		int add_##N(int a, int b) \
> 		{                         \
> 			return a + b + N; \
> 		}
> 
> 	UNROLL(2, MACRO, x, y)
> 
> expands to:
> 
> 	int add_0(int x, int y)
> 	{
> 		return x + y + 0;
> 	}
> 
> 	int add_1(int x, int y)
> 	{
> 		return x + y + 1;
> 	}
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

looks good

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/linux/unroll.h | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>   create mode 100644 include/linux/unroll.h
> 
> diff --git a/include/linux/unroll.h b/include/linux/unroll.h
> new file mode 100644
> index 000000000000..d42fd6366373
> --- /dev/null
> +++ b/include/linux/unroll.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2023 Google LLC.
> + */
> +
> +#ifndef __UNROLL_H
> +#define __UNROLL_H
> +
> +#include <linux/args.h>
> +
> +#define UNROLL(N, MACRO, args...) CONCATENATE(__UNROLL_, N)(MACRO, args)
> +
> +#define __UNROLL_0(MACRO, args...)
> +#define __UNROLL_1(MACRO, args...)  __UNROLL_0(MACRO, args)  MACRO(0, args)
> +#define __UNROLL_2(MACRO, args...)  __UNROLL_1(MACRO, args)  MACRO(1, args)
> +#define __UNROLL_3(MACRO, args...)  __UNROLL_2(MACRO, args)  MACRO(2, args)
> +#define __UNROLL_4(MACRO, args...)  __UNROLL_3(MACRO, args)  MACRO(3, args)
> +#define __UNROLL_5(MACRO, args...)  __UNROLL_4(MACRO, args)  MACRO(4, args)
> +#define __UNROLL_6(MACRO, args...)  __UNROLL_5(MACRO, args)  MACRO(5, args)
> +#define __UNROLL_7(MACRO, args...)  __UNROLL_6(MACRO, args)  MACRO(6, args)
> +#define __UNROLL_8(MACRO, args...)  __UNROLL_7(MACRO, args)  MACRO(7, args)
> +#define __UNROLL_9(MACRO, args...)  __UNROLL_8(MACRO, args)  MACRO(8, args)
> +#define __UNROLL_10(MACRO, args...) __UNROLL_9(MACRO, args)  MACRO(9, args)
> +#define __UNROLL_11(MACRO, args...) __UNROLL_10(MACRO, args) MACRO(10, args)
> +#define __UNROLL_12(MACRO, args...) __UNROLL_11(MACRO, args) MACRO(11, args)
> +#define __UNROLL_13(MACRO, args...) __UNROLL_12(MACRO, args) MACRO(12, args)
> +#define __UNROLL_14(MACRO, args...) __UNROLL_13(MACRO, args) MACRO(13, args)
> +#define __UNROLL_15(MACRO, args...) __UNROLL_14(MACRO, args) MACRO(14, args)
> +#define __UNROLL_16(MACRO, args...) __UNROLL_15(MACRO, args) MACRO(15, args)
> +#define __UNROLL_17(MACRO, args...) __UNROLL_16(MACRO, args) MACRO(16, args)
> +#define __UNROLL_18(MACRO, args...) __UNROLL_17(MACRO, args) MACRO(17, args)
> +#define __UNROLL_19(MACRO, args...) __UNROLL_18(MACRO, args) MACRO(18, args)
> +#define __UNROLL_20(MACRO, args...) __UNROLL_19(MACRO, args) MACRO(19, args)
> +
> +#endif /* __UNROLL_H */


