Return-Path: <bpf+bounces-63708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EEAB0A2A8
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 13:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8782FA83F9A
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED71A2D94BF;
	Fri, 18 Jul 2025 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYeuJ2WX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A2C2980D3;
	Fri, 18 Jul 2025 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838805; cv=none; b=Orlhc7fAgp6HL7posfEghMvVdnr9mor6869QBv15o1+RE+eh4zltdQUhVkCRO3WC4TV/SGBWS5RxOeHm4E3LFyQUKCUy9ThNgLbHWE7VlaNNI719FeayWJCyEW3c79rk7mq32DOM6yCf89cGc1F1N1e4N6/1Hhl/nX+2Ql3VOAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838805; c=relaxed/simple;
	bh=mt4VDxY3tbDadjNu9CTiubY7kgDlEox9bXAyrOo3E5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYXxloguP80QmOsHt+ZH72DfmEaQXLkGW4pGa3+Kv/wWVAHd2qnR8ymc3Ul/IOhcezk2XuWFCwKSdpdnLlOiqs/YnVatUMFzPEezYbNkWyq75LKoJcoh5POB8xMXd5QJpvLG0oxBWza9+eB6bq3MpTjlynNqsLsH+4w97zR73O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYeuJ2WX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED134C4CEF0;
	Fri, 18 Jul 2025 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752838804;
	bh=mt4VDxY3tbDadjNu9CTiubY7kgDlEox9bXAyrOo3E5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aYeuJ2WXLAtnQCT4EHlcChjo7Hv0urmKqM3Dbes1riiodONgzsOw9Y1UwDZsTJXv+
	 ewDz8T4x7xLuPuMcZxBTaecP1El5AAJmAs83RWFXNTQ8pJw0HnI7s8xr2KfwrnZ7iD
	 UDwWDUYyh43wJnTJuzTfeLsI4XeMRCQWaycl+gY4bP7SqSgjdKsaqRqzNAMQ8BPtpl
	 KqAE8BHY26GM2+IUVAoVNrRcBuEFaqwr+st/9z6rkMm0dxDdijCj2mBh6AQgI1IGDv
	 mymY9aNbxx4b8wzX5u14TecZBoatyp+sgh6Nuy10ituczzH3U45oewhmzBVFTAF6Ku
	 uOKQ7WYiEuLug==
Date: Fri, 18 Jul 2025 12:39:59 +0100
From: Will Deacon <will@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxwell Bland <mbland@motorola.com>
Subject: Re: [PATCH bpf-next v10 2/3] cfi: Move BPF CFI types and helpers to
 generic code
Message-ID: <aHoyjx1xJJVP6Khz@willie-the-truck>
References: <20250715225733.3921432-5-samitolvanen@google.com>
 <20250715225733.3921432-7-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715225733.3921432-7-samitolvanen@google.com>

On Tue, Jul 15, 2025 at 10:57:36PM +0000, Sami Tolvanen wrote:
> Instead of duplicating the same code for each architecture, move
> the CFI type hash variables for BPF function types and related
> helper functions to generic CFI code, and allow architectures to
> override the function definitions if needed.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/riscv/include/asm/cfi.h  | 16 ---------------
>  arch/riscv/kernel/cfi.c       | 24 -----------------------
>  arch/x86/include/asm/cfi.h    |  9 ---------
>  arch/x86/kernel/alternative.c | 12 ------------
>  include/linux/cfi.h           | 37 +++++++++++++++++++++++++++--------
>  kernel/cfi.c                  | 25 +++++++++++++++++++++++
>  6 files changed, 54 insertions(+), 69 deletions(-)

[...]

> @@ -27,6 +29,29 @@ enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,
>  	return BUG_TRAP_TYPE_BUG;
>  }
>  
> +u32 __weak cfi_get_func_hash(void *func)
> +{
> +	u32 hash;
> +
> +	if (get_kernel_nofault(hash, func - cfi_get_offset()))
> +		return 0;
> +
> +	return hash;
> +}

Do you really need the '__weak' function definition here, or could you
use an '#ifndef cfi_get_func_hash' guard, a bit like you're doing for
cfi_get_offset()?

Will

