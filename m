Return-Path: <bpf+bounces-63709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E8B0A2AF
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 13:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EC21C21DCD
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 11:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608972D9786;
	Fri, 18 Jul 2025 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wit5SPbm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87BC21B9C6;
	Fri, 18 Jul 2025 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838979; cv=none; b=nM7MyNtI6D1H6wgbXq/j37Tk5GK+Tpaywj2DBq5QAQHfxSr0ogRMlij6tibsk9XYAYBOjFB/X1fZ3Ek2NpH82ptgOM4USm9oopiHdwqEjS3DOvpVoMZDDgmmp6cqfra4hyKWzshvilYWO/YC0P4AaZanb7pw5kSTwL3jTQsA95k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838979; c=relaxed/simple;
	bh=c1aJonaSn7m5jpxkZVQAbObN+591/3gbJ6vAeHNRkOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ah+o5EzWG/0koCw/2fHmInngkZqac6JBT5Q55FAla6CHRR7dm8pQ2BThkxvZ3LFJQ7WAgp0XqY5yEyebfMThz9yN/sxbKeMifQ92dkelvSAViyTQj60u89RnFGRxeJi9gi/TPkiyt1ZNFEE5DedwAHM0yhi8Qp75Xb2qsOynOYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wit5SPbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27582C4CEEB;
	Fri, 18 Jul 2025 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752838979;
	bh=c1aJonaSn7m5jpxkZVQAbObN+591/3gbJ6vAeHNRkOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wit5SPbmg2PXTNyuXevhjnuEUrLjnleqAlzHzBm8sweT1IhJutppROwa55ClUnAne
	 ctEekz23EnBWWnlt39mCkEpBNMJct3yoFW4SNPgPETdE2gdb1xPplkazMfFuwv6l+s
	 UhLelyFejw/O2WRCuMJYEYv1Bp4wkGL3+Gyih0+MndeCWZT5w7CfdDaqSzRY1qcR6V
	 NsBylB7FXKSmxqwYeyWjpTrxue8gGFP434e30I8XoUCdP+uR/wwK754BLYCL7i3GB8
	 hz91wLv9mLBAc1e889aUWhEVTixS5SaSO8wyQcRS90DaKOeRhOelb1KsmPRlKnT7ox
	 tQZDkGi32WX5w==
Date: Fri, 18 Jul 2025 12:42:54 +0100
From: Will Deacon <will@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxwell Bland <mbland@motorola.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Dao Huang <huangdao1@oppo.com>
Subject: Re: [PATCH bpf-next v10 3/3] arm64/cfi,bpf: Support kCFI + BPF on
 arm64
Message-ID: <aHozPj7NIudHmmgM@willie-the-truck>
References: <20250715225733.3921432-5-samitolvanen@google.com>
 <20250715225733.3921432-8-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715225733.3921432-8-samitolvanen@google.com>

On Tue, Jul 15, 2025 at 10:57:37PM +0000, Sami Tolvanen wrote:
> From: Puranjay Mohan <puranjay12@gmail.com>
> 
> Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
> calling BPF programs from this interface doesn't cause CFI warnings.
> 
> When BPF programs are called directly from C: from BPF helpers or
> struct_ops, CFI warnings are generated.
> 
> Implement proper CFI prologues for the BPF programs and callbacks and
> drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
> prologue when a struct_ops trampoline is being prepared.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Co-developed-by: Maxwell Bland <mbland@motorola.com>
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Tested-by: Dao Huang <huangdao1@oppo.com>
> ---
>  arch/arm64/include/asm/cfi.h  |  7 +++++++
>  arch/arm64/net/bpf_jit_comp.c | 22 +++++++++++++++++++---
>  2 files changed, 26 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/include/asm/cfi.h

> diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.h
> new file mode 100644
> index 000000000000..ab90f0351b7a
> --- /dev/null
> +++ b/arch/arm64/include/asm/cfi.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_CFI_H
> +#define _ASM_ARM64_CFI_H
> +
> +#define __bpfcall
> +
> +#endif /* _ASM_ARM64_CFI_H */

So close to not needing the arch header at all!

Acked-by: Will Deacon <will@kernel.org>

Will

