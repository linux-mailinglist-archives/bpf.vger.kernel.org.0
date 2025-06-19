Return-Path: <bpf+bounces-61086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0742AE0925
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 16:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6314A5068
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 14:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313E0288C2C;
	Thu, 19 Jun 2025 14:50:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B811EB5FD;
	Thu, 19 Jun 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344637; cv=none; b=MzwZ+wJZWqgI/df51Tttt1aCGhVdpSOHe25elcJAtA90/qMnMmtEF2olwjIzJSk/lKTMo9licwaX1Uc7VupQaYd/ohrTd0GHpC1BrYENKqJ7tu68ez0ivuU/pHqsffmC/7Lnt3a10dJ1PNhIxmCB5U9hFKLrNfqhF5+F1XH8m28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344637; c=relaxed/simple;
	bh=VbhmAEBQ8O4YJvRcxwQ4zTltQ26TLxM7HAoCcW6W/zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZhGqr3gJe0T4u9rFjd6ioA8CZqSJhJQfEKnp2y9hDxMFEC3Xj6Bctlp4Qzj4PguOoHQe8wv5GuWwWbTIyzuwoSZEvniI9vwusLFGSpsDYVVGptKafp+7p55EbFYLRQGmpsrFadGxXZizEiifEVTZUxbw5jsLA3PinEknO/aIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bNNSQ43q2z9tMS;
	Thu, 19 Jun 2025 16:35:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jvK5WwOsEdLr; Thu, 19 Jun 2025 16:35:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bNNSL6hPpz9tMd;
	Thu, 19 Jun 2025 16:35:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DC3A98B790;
	Thu, 19 Jun 2025 16:35:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 6cuBk6pQxYZw; Thu, 19 Jun 2025 16:35:30 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 380198B78C;
	Thu, 19 Jun 2025 16:35:30 +0200 (CEST)
Message-ID: <f138b40e-095a-48f0-80b9-86685c640cd6@csgroup.eu>
Date: Thu, 19 Jun 2025 16:35:29 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] powerpc/bpf: Fix warning for unused
 ori31_emitted
To: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
References: <20250619142647.2157017-1-luis.gerhorst@fau.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250619142647.2157017-1-luis.gerhorst@fau.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 19/06/2025 à 16:26, Luis Gerhorst a écrit :
> Without this, the compiler (clang21) might emit a warning under W=1
> because the variable ori31_emitted is set but never used if
> CONFIG_PPC_BOOK3S_64=n.
> 
> Without this patch:
> 
> $ make -j $(nproc) W=1 ARCH=powerpc SHELL=/bin/bash arch/powerpc/net
>    [...]
>    CC      arch/powerpc/net/bpf_jit_comp.o
>    CC      arch/powerpc/net/bpf_jit_comp64.o
> ../arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_build_body':
> ../arch/powerpc/net/bpf_jit_comp64.c:417:28: warning: variable 'ori31_emitted' set but not used [-Wunused-but-set-variable]
>    417 |         bool sync_emitted, ori31_emitted;
>        |                            ^~~~~~~~~~~~~
>    AR      arch/powerpc/net/built-in.a
> 
> With this patch:
> 
>    [...]
>    CC      arch/powerpc/net/bpf_jit_comp.o
>    CC      arch/powerpc/net/bpf_jit_comp64.o
>    AR      arch/powerpc/net/built-in.a
> 
> Fixes: dff883d9e93a ("bpf, arm64, powerpc: Change nospec to include v1 barrier")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506180402.uUXwVoSH-lkp@intel.com/
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/net/bpf_jit_comp64.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 3665ff8bb4bc..a25a6ffe7d7c 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -820,13 +820,12 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   		case BPF_ST | BPF_NOSPEC:
>   			sync_emitted = false;
>   			ori31_emitted = false;
> -#ifdef CONFIG_PPC_E500
> -			if (!bpf_jit_bypass_spec_v1()) {
> +			if (IS_ENABLED(CONFIG_PPC_E500) &&
> +			    !bpf_jit_bypass_spec_v1()) {
>   				EMIT(PPC_RAW_ISYNC());
>   				EMIT(PPC_RAW_SYNC());
>   				sync_emitted = true;
>   			}
> -#endif
>   			if (!bpf_jit_bypass_spec_v4()) {
>   				switch (stf_barrier) {
>   				case STF_BARRIER_EIEIO:
> @@ -849,10 +848,10 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   					break;
>   				}
>   			}
> -#ifdef CONFIG_PPC_BOOK3S_64
> -			if (!bpf_jit_bypass_spec_v1() && !ori31_emitted)
> +			if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&
> +			    !bpf_jit_bypass_spec_v1() &&
> +			    !ori31_emitted)
>   				EMIT(PPC_RAW_ORI(_R31, _R31, 0));
> -#endif
>   			break;
>   
>   		/*
> 
> base-commit: cd7312a78f36e981939abe1cd1f21d355e083dfe


