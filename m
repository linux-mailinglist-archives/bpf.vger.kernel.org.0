Return-Path: <bpf+bounces-72882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B08C5C1D096
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E1C234C7E9
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D9359FAC;
	Wed, 29 Oct 2025 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djmOjuuV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DE535773C;
	Wed, 29 Oct 2025 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766878; cv=none; b=ngBADEJy3C0RB2K5V+xBip26iWyzwCbqMDkKdwJnIwmOAyjjMtTz9E6q/JiO90xG5XKPiVixlvR3i+8dcG3cJSDMdRdlMXtTsxj3jq1QyPZa62s6yD57ldfhq5dLdbPdgrzgK24xVy4WflS4Pxs+HF/zTDtgZiaH31a/7NuBMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766878; c=relaxed/simple;
	bh=TNh5VN+rElAfNyIN5E6bNLS9CBZBBa8t2lecam8U8gs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lR5yDsOEjg9JIhM7m/AGU0FZCMnv6Ylz4bFgL+ngtqXB65jJ7icRypFQqm2Nswrv3i31X1/1qHOyDYnZKP+6rK/FgLwvYMRPf6094EAJb4PINq40/Y+4ZiEL51l7ZvgWXoSoE0hkmeagci7U35v/fMBEuWixf6hvZ6HMbpA0sgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djmOjuuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892CAC4CEF7;
	Wed, 29 Oct 2025 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761766877;
	bh=TNh5VN+rElAfNyIN5E6bNLS9CBZBBa8t2lecam8U8gs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=djmOjuuVyjehkE20q1AcUA7N+34z3eBFEhFK7BhhomkjvmecfYM1K0KkgKgw3JIyj
	 R8uQdlsl4BmZ9Aivwn6LLsHe7hFYIQvR/iP8iSLDuoQ/w1zk8Lpao65RJYFgKrJn8x
	 64BIQ2loxBt3lBkgVSlyx1B+X5D2JOVYwWJaYEk9OV8fGsLaNXxJawzttAWXgV9938
	 cYX7n0hgvBqw/iX2nqncjI2hLZAvWOObxiyBGOP/GQnmhEBi6Wiye1XZnp0BNyy/SN
	 B9IZR8oMQqAu5EIabcz943NjWcSRxCIbMqYhujk2Aa6FDMHwmUSCBHIA8ZrvEviZpl
	 NTF7NPWDAq5xg==
Content-Type: multipart/mixed; boundary="===============3920572624472113543=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3ff9f05dd90ecae535887b2b6ae14ab6b04fd28e8da22af874e917c5126cd803@mail.kernel.org>
In-Reply-To: <20251029190113.3323406-2-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-2-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 1/8] bpf: Add BTF_ID_LIST_END and BTF_ID_LIST_SIZE macros
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,bpf@vger.kernel.org,andrii@kernel.org,ast@kernel.org
Cc: dwarves@vger.kernel.org,alan.maguire@oracle.com,acme@kernel.org,eddyz87@gmail.com,tj@kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Oct 2025 19:41:16 +0000 (UTC)

--===============3920572624472113543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit d616f53ce936875dd9f44cc77f9bed1198596463
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Add BTF_ID_LIST_END and BTF_ID_LIST_SIZE macros

This commit adds two new preprocessor macros to btf_ids.h for
calculating the size of BTF_ID_LIST arrays using pointer arithmetic
between a list and its __end marker.

> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 139bdecec..27a4724d5 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -97,6 +97,16 @@ asm(							\
>  __BTF_ID_LIST(name, local)				\
>  extern u32 name[];
>
> +/*
> + * The BTF_ID_LIST_END macro may be used to denote an end
> + * of a BTF_ID_LIST. This enables calculation of the list
> + * size with BTF_ID_LIST_SIZE.
> + */
> +#define BTF_ID_LIST_END(name) \
> +BTF_ID_LIST(name##__end)
> +#define BTF_ID_LIST_SIZE(name) \
> +(name##__end - name)
> +

Are the fallback definitions missing for CONFIG_DEBUG_INFO_BTF=n?

Looking at the #else branch starting at line 228, all existing macros
like BTF_ID_LIST, BTF_ID, BTF_SET_START, etc. have fallback definitions.
These new macros BTF_ID_LIST_END and BTF_ID_LIST_SIZE only exist in the
CONFIG_DEBUG_INFO_BTF=y path. When CONFIG_DEBUG_INFO_BTF is disabled,
code using these macros will fail to compile.

While there's no current usage that would break, the API is incomplete
compared to the established pattern in this header where every macro
works in both config states.

>  #define BTF_ID_LIST_GLOBAL(name, n)			\
>  __BTF_ID_LIST(name, globl)


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `bpf: Add BTF_ID_LIST_END and BTF_ID_LIST_SIZE macros`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18919699520

--===============3920572624472113543==--

