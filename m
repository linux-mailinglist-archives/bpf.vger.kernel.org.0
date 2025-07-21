Return-Path: <bpf+bounces-63920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B25FB0C66F
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 16:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730A21AA691D
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 14:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4087F1DF754;
	Mon, 21 Jul 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA3NF4Sw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0C7189BB0;
	Mon, 21 Jul 2025 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108431; cv=none; b=t6ax17uwQBB0b9H7oS2feLHYnBllAi6JEhW1j23nntFowjECKZXizbeeRCAZTRzLEoxOLc18qSB+OUHPBb7lOVA65kcDTDVeCp5LT3UgcCewzuh1qnAZqfvLuD2cd9zs2GkAq2sQ9BynnlwJkqcqMsX/vBbCDRDnKaGZkIr0LqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108431; c=relaxed/simple;
	bh=W3DsCBY2u1iSBpXEbgL+BBx51siqsbpsok2aDJTUk7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsoZ7aUoxqcaLA8TKS784eIrlrQowgsARh4yA73kBdkJ0XUOErP4r8ylgbkAzN6DlRDXf80/A/1ThN05POM4aH54ybfFiJOo7NKSrufT7354MREqIMV0L8NOXVZVzxWqOPLsm+ST1U7Vko3GuIOhXYRezBYeTORPmNwof2gxG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA3NF4Sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB5BC4CEED;
	Mon, 21 Jul 2025 14:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753108431;
	bh=W3DsCBY2u1iSBpXEbgL+BBx51siqsbpsok2aDJTUk7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NA3NF4SwRguReA5PzVLGxM2kOQRnW6dl5eszhshHh05TjV/aXBdeKRfdRVIDfz517
	 fYvSfJdrVvkqvumZMi2yWX7uZgupy1mbFZ9xGTdyJnulFVybRE4kGIQ1rVYzobRazE
	 0nzcEEzZZko+3TLWwwi3366OsDH64fjsGVPXRQguBFYtlHEvtD8gSaTlalSv0T6hj5
	 ETOaHncxlYb7sqYdGlLFPHaXjAaFU9r6G8k0hTU4XlY4yVsUu/vpH0lJEsR0nnG3Tu
	 4i+bPrJatkkGWPbVqzCIvObFfsa3eSEDloykgduuHFHAZhhe1YkNlOmxh8mSx9X/St
	 F3GzdYXn6sU+w==
Date: Mon, 21 Jul 2025 15:33:46 +0100
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
Subject: Re: [PATCH bpf-next v11 2/3] cfi: Move BPF CFI types and helpers to
 generic code
Message-ID: <aH5PypjBVdzVxxlo@willie-the-truck>
References: <20250718223345.1075521-5-samitolvanen@google.com>
 <20250718223345.1075521-7-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718223345.1075521-7-samitolvanen@google.com>

On Fri, Jul 18, 2025 at 10:33:48PM +0000, Sami Tolvanen wrote:
> Instead of duplicating the same code for each architecture, move
> the CFI type hash variables for BPF function types and related
> helper functions to generic CFI code, and allow architectures to
> override the function definitions if needed.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/riscv/include/asm/cfi.h  | 16 ------------
>  arch/riscv/kernel/cfi.c       | 24 ------------------
>  arch/x86/include/asm/cfi.h    | 10 ++------
>  arch/x86/kernel/alternative.c | 12 ---------
>  include/linux/cfi.h           | 47 +++++++++++++++++++++++++++++------
>  kernel/cfi.c                  | 15 +++++++++++
>  6 files changed, 56 insertions(+), 68 deletions(-)

Thanks, Sami, I like the look of this now.

If you can get the kbuild robot on board too, then I think we're good to
go!

Will

