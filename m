Return-Path: <bpf+bounces-35034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA096937221
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 03:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A191C2110B
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 01:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEBD4A3F;
	Fri, 19 Jul 2024 01:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EJvTscGN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC151877
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354165; cv=none; b=ddIW+DncLMXE+kJDGvfFbjji0XMTEU8Tka5zVYc2lbs3T4sHQ52JtrHH4ZVsY4Ghmh5eU9+OLrQm/aZet8vaVD8cPkjrESWRzbpW7+AAOIRPOOttOAK0kpbfC3wC6I6TWFjvRUq93qE/5n+UAYn/n4nTg5fQYwb+szZ9Oa0EBrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354165; c=relaxed/simple;
	bh=S9XvNO5ImX+pLgU29r+6NFx5Ta4huWYgZm7RlPFFY+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3qjLhkYiyNvgA+qN/djA3cVug3+FeRgXvnEeg2931krqUsEA5Qd4U2dw2r/BP6D5RBq3icZFWOGdE4qBjXVyjcDVO2IUsqeZFE3sbzUci/CgL/IdXOhW/MzLXMvrclaGg5wQeltogGJ18W/AWAajOrUrKEmtYBUbWrc+M4M6kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=EJvTscGN; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f70a708f8aso68428939f.2
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 18:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721354161; x=1721958961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBMoNxUmM+zvCwOfsVSk2SpUB5b5ZDpmyE9LlBQJw9Q=;
        b=EJvTscGNPlpSCnWzgP2GymJeMPzM7pdBypCZqZWX/uli3YrtPKsor3vSYm2wGMBDwi
         6bDXV8RtyJEprhtEDMk31/YBy3hcOk+kQeu3W72eSQP794t78Jdx8b08X1W8TxvmWP6X
         T2CByomBzwxSwZy4cdp/1ZMeYsssCjjiodhMsWuitOetsriNGSdKbFC44AgWAzeOW0/r
         3oACKReDDY907jZNmQqqgRDZm/HouP8Zi5aKeuwxcUYJ2WZAkm8M8irz+Vu3H3O87g9m
         j/2KwH6UfiFxUa5/B/I8dEZJf0E0hgr40vvXe+MhwoNKDOlfatdkbvV6O6Ffmx9gG0iT
         Pfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354161; x=1721958961;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBMoNxUmM+zvCwOfsVSk2SpUB5b5ZDpmyE9LlBQJw9Q=;
        b=iLwYmlMoacFk1F5RbhkQD+zzEyWz63Hm7AxuxV75KiropIu1ACx/qSOuBrXmVA3wG/
         yY6NSKPMdPFl1KKFvmGsDCyPv+eBTb+XZ1/2zhRsHGhoRwHD7+0Czm8Y2pBBIuYEckkf
         bS+e+1Abo8oj4VCRif6B+ss5U+PrXH4Bvad17sayQ/rjXaRppLs76YaoPNz8InfNYzO/
         18kshIvjRZHh6sjLbrdgZHtbdUx771Qk76eEYbfSS4sXTBdrrAOZ0sxpDwVk8e8/SG//
         gTp8xO9Yhd71baZaxX8bGu69vJBe4DGNuBYV5l4b4h5Vp7KuH0zL6sxoXPPn/2AQ4Fmw
         uu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvUqYE9vfH7JjRo2J8qr+F//rWCYxVc2tMAlf1d+A7pwQlx7yK8v/8ddzsNZstV6ps/biWyIt7F2BQVuVloCaDSgHd
X-Gm-Message-State: AOJu0YyhbRUeoardHJUS0P/1fFj4CT2dp850JylnhGu3M9i8sBqiE1XX
	L38MuHimOH8olptliZnTAq3uBtxBaJUoc4rCI0t4DpWaPHG57a7dyDa0GaS31/o=
X-Google-Smtp-Source: AGHT+IG2CoPSYAyYkOoMBa2c9qiOtGSDneT6EFNBl+4SSwvbjQ9YO4XF8yNAxCBa+piiQdYwhgiz9A==
X-Received: by 2002:a05:6602:6d8d:b0:813:f74:e6e6 with SMTP id ca18e2360f4ac-81711e18cd9mr843812239f.15.1721354161352;
        Thu, 18 Jul 2024 18:56:01 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c2342bf2cfsm124927173.8.2024.07.18.18.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 18:56:00 -0700 (PDT)
Message-ID: <a28ddc26-d77a-470a-a33f-88144f717e86@sifive.com>
Date: Thu, 18 Jul 2024 20:55:58 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: patch: Remove redundant functions
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ard Biesheuvel <ardb@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>,
 Puranjay Mohan <puranjay@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>,
 Xi Wang <xi.wang@gmail.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20240717084102.150914-1-alexghiti@rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20240717084102.150914-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 2024-07-17 3:41 AM, Alexandre Ghiti wrote:
> Commit edf2d546bfd6f5c4 ("riscv: patch: Flush the icache right after
> patching to avoid illegal insns") removed the last differences between
> patch_text_set_nosync() and patch_insn_set(), and between
> patch_text_nosync() and patch_insn_write().
> 
> So remove the redundant *_nosync() functions.

My understanding was that we would eventually revert that patch, once we are
sure we never non-atomically patch the text patching code. So it's helpful to
keep the semantic distinction between the two sets of functions.

And looking at this closer, I think the original patch should not have removed
the calls to flush_icache_range() anyway. It replaces a global icache flush with
a local icache flush, which is wrong if there is more than one CPU online, and
there are a couple of places (bpf_jit_core.c, kprobes.c) where those functions
are called at runtime.

Regards,
Samuel

> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/linux-riscv/CAMuHMdUwx=rU2MWhFTE6KhYHm64phxx2Y6u05-aBLGfeG5696A@mail.gmail.com/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/errata/sifive/errata.c |  4 ++--
>  arch/riscv/errata/thead/errata.c  |  2 +-
>  arch/riscv/include/asm/patch.h    |  3 +--
>  arch/riscv/kernel/alternative.c   |  4 ++--
>  arch/riscv/kernel/cpufeature.c    |  2 +-
>  arch/riscv/kernel/jump_label.c    |  2 +-
>  arch/riscv/kernel/patch.c         | 24 +-----------------------
>  arch/riscv/net/bpf_jit_core.c     |  4 ++--
>  8 files changed, 11 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
> index 716cfedad3a2..5253b205aa17 100644
> --- a/arch/riscv/errata/sifive/errata.c
> +++ b/arch/riscv/errata/sifive/errata.c
> @@ -112,8 +112,8 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  		tmp = (1U << alt->patch_id);
>  		if (cpu_req_errata & tmp) {
>  			mutex_lock(&text_mutex);
> -			patch_text_nosync(ALT_OLD_PTR(alt), ALT_ALT_PTR(alt),
> -					  alt->alt_len);
> +			patch_insn_write(ALT_OLD_PTR(alt), ALT_ALT_PTR(alt),
> +					 alt->alt_len);
>  			mutex_unlock(&text_mutex);
>  			cpu_apply_errata |= tmp;
>  		}
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index bf6a0a6318ee..0ce280a190b6 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -182,7 +182,7 @@ void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  				memcpy(oldptr, altptr, alt->alt_len);
>  			} else {
>  				mutex_lock(&text_mutex);
> -				patch_text_nosync(oldptr, altptr, alt->alt_len);
> +				patch_insn_write(oldptr, altptr, alt->alt_len);
>  				mutex_unlock(&text_mutex);
>  			}
>  		}
> diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
> index 9f5d6e14c405..6b0e9b8a321b 100644
> --- a/arch/riscv/include/asm/patch.h
> +++ b/arch/riscv/include/asm/patch.h
> @@ -6,9 +6,8 @@
>  #ifndef _ASM_RISCV_PATCH_H
>  #define _ASM_RISCV_PATCH_H
>  
> +int patch_insn_set(void *addr, u8 c, size_t len);
>  int patch_insn_write(void *addr, const void *insn, size_t len);
> -int patch_text_nosync(void *addr, const void *insns, size_t len);
> -int patch_text_set_nosync(void *addr, u8 c, size_t len);
>  int patch_text(void *addr, u32 *insns, int ninsns);
>  
>  extern int riscv_patch_in_stop_machine;
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
> index 0128b161bfda..a8b508d99cf8 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -83,7 +83,7 @@ static void riscv_alternative_fix_auipc_jalr(void *ptr, u32 auipc_insn,
>  	riscv_insn_insert_utype_itype_imm(&call[0], &call[1], imm);
>  
>  	/* patch the call place again */
> -	patch_text_nosync(ptr, call, sizeof(u32) * 2);
> +	patch_insn_write(ptr, call, sizeof(u32) * 2);
>  }
>  
>  static void riscv_alternative_fix_jal(void *ptr, u32 jal_insn, int patch_offset)
> @@ -98,7 +98,7 @@ static void riscv_alternative_fix_jal(void *ptr, u32 jal_insn, int patch_offset)
>  	riscv_insn_insert_jtype_imm(&jal_insn, imm);
>  
>  	/* patch the call place again */
> -	patch_text_nosync(ptr, &jal_insn, sizeof(u32));
> +	patch_insn_write(ptr, &jal_insn, sizeof(u32));
>  }
>  
>  void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 5ef48cb20ee1..4c040a857c7e 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -795,7 +795,7 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
>  		altptr = ALT_ALT_PTR(alt);
>  
>  		mutex_lock(&text_mutex);
> -		patch_text_nosync(oldptr, altptr, alt->alt_len);
> +		patch_insn_write(oldptr, altptr, alt->alt_len);
>  		riscv_alternative_fix_offsets(oldptr, alt->alt_len, oldptr - altptr);
>  		mutex_unlock(&text_mutex);
>  	}
> diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
> index e6694759dbd0..74b5ebfacf4a 100644
> --- a/arch/riscv/kernel/jump_label.c
> +++ b/arch/riscv/kernel/jump_label.c
> @@ -36,6 +36,6 @@ void arch_jump_label_transform(struct jump_entry *entry,
>  	}
>  
>  	mutex_lock(&text_mutex);
> -	patch_text_nosync(addr, &insn, sizeof(insn));
> +	patch_insn_write(addr, &insn, sizeof(insn));
>  	mutex_unlock(&text_mutex);
>  }
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index ab03732d06c4..bf45b507f900 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -177,7 +177,7 @@ static int __patch_insn_write(void *addr, const void *insn, size_t len)
>  NOKPROBE_SYMBOL(__patch_insn_write);
>  #endif /* CONFIG_MMU */
>  
> -static int patch_insn_set(void *addr, u8 c, size_t len)
> +int patch_insn_set(void *addr, u8 c, size_t len)
>  {
>  	size_t patched = 0;
>  	size_t size;
> @@ -198,17 +198,6 @@ static int patch_insn_set(void *addr, u8 c, size_t len)
>  }
>  NOKPROBE_SYMBOL(patch_insn_set);
>  
> -int patch_text_set_nosync(void *addr, u8 c, size_t len)
> -{
> -	u32 *tp = addr;
> -	int ret;
> -
> -	ret = patch_insn_set(tp, c, len);
> -
> -	return ret;
> -}
> -NOKPROBE_SYMBOL(patch_text_set_nosync);
> -
>  int patch_insn_write(void *addr, const void *insn, size_t len)
>  {
>  	size_t patched = 0;
> @@ -230,17 +219,6 @@ int patch_insn_write(void *addr, const void *insn, size_t len)
>  }
>  NOKPROBE_SYMBOL(patch_insn_write);
>  
> -int patch_text_nosync(void *addr, const void *insns, size_t len)
> -{
> -	u32 *tp = addr;
> -	int ret;
> -
> -	ret = patch_insn_write(tp, insns, len);
> -
> -	return ret;
> -}
> -NOKPROBE_SYMBOL(patch_text_nosync);
> -
>  static int patch_text_cb(void *data)
>  {
>  	struct patch_insn *patch = data;
> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index 0a96abdaca65..b053ae5c4191 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -226,7 +226,7 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len)
>  	int ret;
>  
>  	mutex_lock(&text_mutex);
> -	ret = patch_text_nosync(dst, src, len);
> +	ret = patch_insn_write(dst, src, len);
>  	mutex_unlock(&text_mutex);
>  
>  	if (ret)
> @@ -240,7 +240,7 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
>  	int ret;
>  
>  	mutex_lock(&text_mutex);
> -	ret = patch_text_set_nosync(dst, 0, len);
> +	ret = patch_insn_set(dst, 0, len);
>  	mutex_unlock(&text_mutex);
>  
>  	return ret;


