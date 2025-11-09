Return-Path: <bpf+bounces-74038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F47C44A44
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 00:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBF954E5DC3
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 23:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E7726FDBB;
	Sun,  9 Nov 2025 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwnOpyVs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D9243376;
	Sun,  9 Nov 2025 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762731445; cv=none; b=sG7hWsoEm/J8b8BHpKdFcGvH1yo5K8Yp8XIpf54IjJ9ywbkVCpg54YVJCQFK6AniJyydheSv/ToYJG4od0ENMgJlDaA9xPrPu/6zace7NUY/J1BJI2HAYRuKSwvn7qyQdZkiFGeR3ZweaOXTDQLxfjAuugbEDsy7SSN3cULV+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762731445; c=relaxed/simple;
	bh=5YEOu82QTmZW2HELOApkW8zOPzE/QRgh57UZFjoQzaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5ZY42R3WG039uFg08pV3lkZ+DCS0N93+jp5XsztEq8nZAYHhJnC/5WS+CVVgAbOE3KE4TgsVtlXLtkDrsqe3hqHHm1JmqQ75rPN8xuw8VSrMM1V7Crr71byV9Gy5qLffScuCDzuUozIHIHXy4hBeYWEdlgUuDS6WZw4lgRhqKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwnOpyVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD19C4CEF7;
	Sun,  9 Nov 2025 23:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762731445;
	bh=5YEOu82QTmZW2HELOApkW8zOPzE/QRgh57UZFjoQzaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwnOpyVsRJk5v3uibYeRVnOCS2mEpIYu7UA25lknHfLbVYn5c0tnxogXclky73IXw
	 yrDTeYj/kkD2tUuLkZnRbrOlrGIlx+gRHuxUgLbIkuRPZEdTMoENUZvLxPWrjXWcXY
	 TvhOV1UDfUV7n/9tkkg7FkgtHb5nj9cTYTQ0AwmIUpkIC/VkV6yD5XHuPqVF8vK3tU
	 G7llEsKGssu6wbw7AkmKT+YCjI9Rrl5WWmVGQtqcwALYW6yiBRJqsmDdI0FpEfs6KA
	 uobnRFDZyqTFZ4mmXZj0E6Mp0YkMnzFCTFeLhtfQBYDeMCopY1sLKNrj/i35WfiMn3
	 NjCIcAeWhh0LA==
Date: Sun, 9 Nov 2025 16:37:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jens Reidel <adrian@mainlining.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] mips: Use generic endianness macros instead of
 MIPS-specific ones
Message-ID: <20251109233720.GB2977577@ax162>
References: <20251108-mips-bpf-fix-v1-1-0467c3ee2613@mainlining.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108-mips-bpf-fix-v1-1-0467c3ee2613@mainlining.org>

On Sat, Nov 08, 2025 at 11:05:55PM +0100, Jens Reidel wrote:
> Compiling bpf_skel for mips currently fails because clang --target=bpf
> is invoked and the source files include byteorder.h, which uses the
> MIPS-specific macros to determine the endianness, rather than the generic
> __LITTLE_ENDIAN__ / __BIG_ENDIAN__. Fix this by using the generic
> macros, which are also defined when targeting bpf. This is already done
> similarly for powerpc.
> 
> Signed-off-by: Jens Reidel <adrian@mainlining.org>

As far as I can tell, this should be fine since clang defines these
macros in the generic case since [1] and I assume GCC does as well but
if there is a risk of this being a problem for userspace, these could be
added in addition to __MIPSEB__ / __MIPSEL__.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

[1]: https://github.com/llvm/llvm-project/commit/2c942c64fb521357ed98c380823e79833a121d18

> ---
>  arch/mips/include/uapi/asm/byteorder.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/include/uapi/asm/byteorder.h b/arch/mips/include/uapi/asm/byteorder.h
> index b4edc85f9c30c09aafbc189ec820e6e2f7cbe0d8..5e3c3baa24994a9f3637bf2b63ea7c3577cae541 100644
> --- a/arch/mips/include/uapi/asm/byteorder.h
> +++ b/arch/mips/include/uapi/asm/byteorder.h
> @@ -9,12 +9,10 @@
>  #ifndef _ASM_BYTEORDER_H
>  #define _ASM_BYTEORDER_H
>  
> -#if defined(__MIPSEB__)
> -#include <linux/byteorder/big_endian.h>
> -#elif defined(__MIPSEL__)
> +#ifdef __LITTLE_ENDIAN__
>  #include <linux/byteorder/little_endian.h>
>  #else
> -# error "MIPS, but neither __MIPSEB__, nor __MIPSEL__???"
> +#include <linux/byteorder/big_endian.h>
>  #endif
>  
>  #endif /* _ASM_BYTEORDER_H */
> 
> ---
> base-commit: 9c0826a5d9aa4d52206dd89976858457a2a8a7ed
> change-id: 20251108-mips-bpf-fix-8d1f14bc4903
> 
> Best regards,
> -- 
> Jens Reidel <adrian@mainlining.org>

