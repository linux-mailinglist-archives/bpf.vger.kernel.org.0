Return-Path: <bpf+bounces-55239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE26A7A745
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256B63B5A04
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 15:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A924250BE5;
	Thu,  3 Apr 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwaNmsnz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D01A257D;
	Thu,  3 Apr 2025 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743695412; cv=none; b=ijwRj93a3IYAyukbmMG0EFuemvkawj7EFDSgZiSdCAHAoX+drhEubHEZ3MCMq/FshlN5ix2sMTp1+JWf+w2bfy87OnpnlV0ShQ6nBpxQsOgxLpH4/vwtV0eSsF2tTJk6nZ5VUYNg4rS33K9CAa2ZJBtyNrVv0Qm3XRTzLx/9ozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743695412; c=relaxed/simple;
	bh=0AC/e1p1TESoRNde9r7NQRKgzDKVZKdHxSa7/YkMjpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baNtYiUN6AKinEJ6xIzD2CyshwMmdaFi6w1lbNW8vPGyjeqmfFDLMGb8OMWWRRcEMaB6cAop1+WjwVe9zrdwQ22aoOiSgp44CWb9P2ghZArSnLYXeqZpytJEXjjWws/Fet7EhUIok6AOhCbxR9ODi5rXRICe4Ktr9P7qS9lMt3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwaNmsnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FE1C4CEE3;
	Thu,  3 Apr 2025 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743695412;
	bh=0AC/e1p1TESoRNde9r7NQRKgzDKVZKdHxSa7/YkMjpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwaNmsnzg6AYpVJSTwVRIQdkmYfrDWwkx+dhF0jhi6H44/LEuybkDj+csuqzunsGQ
	 CnW8XRwpJZpR2bXhMB4WlHtUPBgoZ+y8kH1O+V8nEslAsxiCFZR9AlNMIe1RhJLUuO
	 hn8pOiH22VOSsxmPh0vUmwkk26Lx95Q3KVitoTnAPK0Rx7FgDH3zFXE8/OBIFb5COR
	 OP/HmrtTvfUQS7xe4FH3x06qtpxQPtm7cyz69lpXl7VkJss+nWsFbAhz2lbLB7QUw+
	 cMsPnS99d/qKrlMuAY6C7e4xewgOfeocqTj4XbG2jB3Ed7xdvUhQjiuNArMeTlvH+O
	 5SXxcos+/YfGw==
Date: Thu, 3 Apr 2025 21:15:02 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nicholas Piggin <npiggin@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	stable@vger.kernel.org
Subject: Re: [RESEND PATCH] powerpc64/bpf: fix JIT code size calculation of
 bpf trampoline
Message-ID: <5ufbeu7staczxfhdd3uepqnkzxozlhxus2hfpxiiqllid2l4vs@n63eyfgosatl>
References: <20250326143422.1158383-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326143422.1158383-1-hbathini@linux.ibm.com>

On Wed, Mar 26, 2025 at 08:04:22PM +0530, Hari Bathini wrote:
> The JIT compile of ldimm instructions can be anywhere between 1-5
> instructions long depending on the value being loaded.
> 
> arch_bpf_trampoline_size() provides JIT size of the BPF trampoline
> before the buffer for JIT'ing it is allocated. BPF trampoline JIT
> code has ldimm instructions that need to load the value of pointer
> to struct bpf_tramp_image. But this pointer value is not same while
> calling arch_bpf_trampoline_size() & arch_prepare_bpf_trampoline().
> So, the size arrived at using arch_bpf_trampoline_size() can vary
> from the size needed in arch_prepare_bpf_trampoline(). When the
> number of ldimm instructions emitted in arch_bpf_trampoline_size()
> is less than the number of ldimm instructions emitted during the
> actual JIT compile of trampoline, the below warning is produced:
> 
>   WARNING: CPU: 8 PID: 204190 at arch/powerpc/net/bpf_jit_comp.c:981 __arch_prepare_bpf_trampoline.isra.0+0xd2c/0xdcc
> 
> which is:
> 
>   /* Make sure the trampoline generation logic doesn't overflow */
>   if (image && WARN_ON_ONCE(&image[ctx->idx] >
> 			(u32 *)rw_image_end - BPF_INSN_SAFETY)) {
> 
> Pass NULL as the first argument to __arch_prepare_bpf_trampoline()
> call from arch_bpf_trampoline_size() function, to differentiate it
> from how arch_prepare_bpf_trampoline() calls it and ensure maximum
> possible instructions are emitted in arch_bpf_trampoline_size() for
> ldimm instructions that load a different value during the actual JIT
> compile of BPF trampoline.
> 
> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/6168bfc8-659f-4b5a-a6fb-90a916dde3b3@linux.ibm.com/
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
> 
> * Removed a redundant '/' accidently added in a comment and resending.
> 
>  arch/powerpc/net/bpf_jit_comp.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 2991bb171a9b..c94717ccb2bd 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -833,7 +833,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  	EMIT(PPC_RAW_STL(_R26, _R1, nvr_off + SZL));
>  
>  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -		PPC_LI_ADDR(_R3, (unsigned long)im);
> +		/*
> +		 * Emit maximum possible instructions while getting the size of
> +		 * bpf trampoline to ensure trampoline JIT code doesn't overflow.
> +		 */
> +		PPC_LI_ADDR(_R3, im ? (unsigned long)im :
> +				(unsigned long)(~(1UL << (BITS_PER_LONG - 1))));

We generally rely on  a NULL 'image' to detect a dummy pass. See commit 
d3921cbb6cd6 ("powerpc/bpf: Only pad length-variable code at initial 
pass"), for instance. Have you considered updating PPC_LI64() and 
PPC_LI32() to simply emit a fixed number of nops if image is NULL? 


- Naveen


