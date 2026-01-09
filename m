Return-Path: <bpf+bounces-78277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3174D07018
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 04:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 584C0301CE94
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 03:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25B123A58B;
	Fri,  9 Jan 2026 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btUnpzJb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4482264A9
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767929829; cv=none; b=jlfoO9+tqZlx+RnXG3K0EC4cC1RegZjyzsvJhhiWCyuy6qi2d1Jb7ZvstMStQoywWWentV1pK6TS+ZQkdPB4lHpMUs2TiDEX99qSz4q23ovEiij8+mnQpm7MkzgSM0sr3r9SwCl+02M0+wc48WG3vaj7W6PEhjDguoi7E5mZNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767929829; c=relaxed/simple;
	bh=HK6DiWA9mIke710lZe3r/JUmrobufmU/iW0Ok6ExtBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALBfHKGsp/USJdJKORqdHWmxhgBJATndKf0vE29gO2Pa6I1TfmL/Hfgix0fBxA6+pnxyavZkGM4p38HOfFurZQBSTHVhI6oB3Sqlls1IvR89V1HgCA7IerBZDMY20cTKjfMdz04Gweikfh4u/sMDWICpwDergoyZ2TsBO0GuBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btUnpzJb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so3407617b3a.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 19:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767929827; x=1768534627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xvMgk2ec00T+2tDUQKQimVsmG/1WSzd9XK1gELLELo0=;
        b=btUnpzJbVNgOyui8m2mhjRpEZzjtT9aGITlAmUBtiJt0HbGJ5IyLZz58fYT3ieaXmW
         zHfQ8qaADCE11V8NnAHN9JImDwsaosAaTKxgd3gCJLw1s69sV09yzGCQKozJjnAZJfks
         2OLxo9KHwK2CB4riTRjkNHFOdH+8UaxlznNNe6BFSTeBhOfboiE4mTldwPHoNrmrD3Q0
         cGmSv1ZCgNS6xdoLVtDB41gFOzYncZuIlM6nXpgrlYDJlbJMvUCQHmYt954+iEDpb/B7
         uxZV+vZdIXvNNCkH7HuEAjGK04ZaMsIAhYaoj+pGsH1n/BF3vV1KaWrg07U4O09jweMZ
         5ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767929827; x=1768534627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvMgk2ec00T+2tDUQKQimVsmG/1WSzd9XK1gELLELo0=;
        b=SskskcGrVjpelkj8rbVCJA/3ArLYsRRaodyxH7AFsAFl64ICrFuTci7zWLvtENQosC
         9kFfoQ8NjVfnM0QcdrMEbMYCM3kJugTsFb1aDBS7e/LHKvuohdV/TiiQie4HoCPQOECx
         7Yhwc3VE+yKVRd+kHdePXuOkCh57eXrZQmg6eoDJPsvupMMnOJMbHToHlz3HGRzXRmQw
         NYG0X6ePiuQ9cNimoUIznxYHKH9lsgA/R5mYkD+vzn3C4IVublq8kqlyrS8F75Vko+vA
         bI/ilKjBDz1UEELRekDz+4ttWJqUuEj/j1B/tb4naepCHXhs77IdkECviQpB+W0VC0e/
         GjMg==
X-Forwarded-Encrypted: i=1; AJvYcCUoWu4aSKGsc5LRN8JiZHZFg+CqiDtiQEoICbZQGFck51H7u22klpdtCL66iOZDPtjsxYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgdcBReTixGGOYMV49mW632GqKWFtOplR0g2QaKcdlK6xyOQ0V
	YY2BV1p9HgnLvz4uLCA8SkPHnV6xOpMC9TSjCdUqPtkou2olNsTbmlv/8oUxzbs5
X-Gm-Gg: AY/fxX7zvnJQfDqLmosCRBSstpBkfNL4FhRu8ylRvZgXglDz81JL5Esh+q71ukOzldM
	sNCHQlYj+1N/MI49CJq8q87/tI87dtfWoN7PEGsenSzIxUoWUkTscdhdagvgh7nCvizMYqMkeNA
	bJoLOisXNbFudCNxeuZyxIeOA0Ed+6aG0GksxlpgANd8ddKo8DvxE3wEI9J1x+e4vmPIl/K25Ry
	xEyiHd/olZ/iDbRYyTL7dNPMjfS7KensgnDdF1FClKBoTRviLBvwyxmKZ9cYRLJ060EULCowF/n
	LXen3XX+v+3KjgUapTaV0urLyf7A7DsUYqa4gRGuuSAPFAaRTNtoFlqFRzWML03KPx+Tbsz6y8b
	Bx80W5nkN65/V7knAyDDRbytdPl6i/Hy2TJJ4o8317Ha1A4dbvhndG5YwEAQjeRRjfWv5g2eoQe
	jDkl/T
X-Google-Smtp-Source: AGHT+IF7pN2RRcT7o1Bm9PX616WUEnmMreEO0XlKyvrLSnpPAehSojiUVi7qiV5AQMRrUi5ZczuMQA==
X-Received: by 2002:a05:6a21:9999:b0:35e:6a5b:cbc9 with SMTP id adf61e73a8af0-3898f9904f5mr7963005637.50.1767929826972;
        Thu, 08 Jan 2026 19:37:06 -0800 (PST)
Received: from [0.0.0.0] ([8.222.167.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8afba8sm9021286a91.13.2026.01.08.19.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 19:37:06 -0800 (PST)
Message-ID: <702eb23c-7205-4de1-b56d-eedac6feae46@gmail.com>
Date: Thu, 8 Jan 2026 19:41:15 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv, bpf: Emit fence.i for BPF_NOSPEC
To: Lukas Gerlach <lukas.gerlach@cispa.de>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, sorear@fastmail.com,
 tech-speculation-barriers@lists.riscv.org
Cc: bjorn@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 luke.r.nels@gmail.com, xi.wang@gmail.com, palmer@dabbelt.com,
 luis.gerhorst@fau.de, daniel.weber@cispa.de, marton.bognar@kuleuven.be,
 jo.vanbulck@kuleuven.be, michael.schwarz@cispa.de
References: <20251228173753.56767-1-lukas.gerlach@cispa.de>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <20251228173753.56767-1-lukas.gerlach@cispa.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lukas,

Stefan and I have some doubts on fence.i's effectiveness as speculation
barrier. Flushing entire local instruction cache and instruction pipeline
is not absolutely necessary on impl having coherent I/D caches. Quoting
from Unprivileged SPEC ver. 20250508:

"The FENCE.I instruction was designed to support a wide variety of
  implementations. A simple implementation can flush the local instruction
  cache and the instruction pipeline when the FENCE.I is executed. A more
  complex implementation might snoop the instruction (data) cache on every
  data (instruction) cache miss, or use an inclusive unified private L2
  cache to invalidate lines from the primary instruction cache when they
  are being written by a local store instruction. If instruction and data
  caches are kept coherent in this way, or if the memory system consists of
  only uncached RAMs, then just the fetch pipeline needs to be flushed at a
  FENCE.I"

There's the question on overhead, too. Perhaps there's a more accurate and
lightweight insn available? I'm not an expert in u-arch. My gut feeling is
that we should not be dependent on specific impl's behavior and the riscv
SPEC should provide guidelines on speculation barrier instructions and how
to use them. Thus, I'm forwarding this to the Speculation Barriers Task-
Group, which I hope should be the perfect place to discuss such kind of
issues. @Speculation Barriers TG Please share your thoughts. Note that we
are dealing with existing HW, so we expect something to be working with
current SPEC and actual silicon. I'd be happy if I'm proven wrong, and
fence.i can actually be a speculation barrier. That's also a relief. Thank
you everyone.

BTW, per SPEC:

  "The FENCE.I only synchronizes the local hart, and the OS can reschedule
   the user hart to a different physical hart after the FENCE.I. This would
   require the OS to execute an additional FENCE.I as part of every context
   migration"

fence.i is local. I know some core does a broadcast and try to make it a
global fence.i, but this is not required by the SPEC.

Bo

On 12/28/25 09:37, Lukas Gerlach wrote:
> The BPF verifier inserts BPF_NOSPEC instructions to create speculation
> barriers. However, the RISC-V BPF JIT emits nothing for this
> instruction, leaving programs vulnerable to speculative execution
> attacks.
> 
> Originally, BPF_NOSPEC was used only for Spectre v4 mitigation, programs
> containing potential Spectre v1 gadgets were rejected by the verifier.
> With the VeriFence changes, the verifier now accepts these
> programs and inserts BPF_NOSPEC barriers for Spectre v1 mitigation as
> well. On RISC-V, this means programs that were previously rejected are
> now accepted but left unprotected against both v1 and v4 attacks.
> 
> RISC-V lacks a dedicated speculation barrier instruction.
> This patch uses the fence.i instruction as a stopgap solution.
> However an alternative and safer approach would be to reject vulnerable bpf
> programs again.
> 
> Fixes: f5e81d111750 ("bpf: Introduce BPF nospec instruction for mitigating Spectre v4")
> Fixes: 5fcf896efe28 ("Merge branch 'bpf-mitigate-spectre-v1-using-barriers'")
> Signed-off-by: Lukas Gerlach <lukas.gerlach@cispa.de>
> ---
>   arch/riscv/net/bpf_jit.h        | 10 ++++++++++
>   arch/riscv/net/bpf_jit_comp32.c |  6 +++++-
>   arch/riscv/net/bpf_jit_comp64.c |  6 +++++-
>   3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 632ced07bca4..e70b3bc19206 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -619,6 +619,16 @@ static inline void emit_fence_rw_rw(struct rv_jit_context *ctx)
>   	emit(rv_fence(0x3, 0x3), ctx);
>   }
>   
> +static inline u32 rv_fence_i(void)
> +{
> +	return rv_i_insn(0, 0, 1, 0, 0x0f);
> +}
> +
> +static inline void emit_fence_i(struct rv_jit_context *ctx)
> +{
> +	emit(rv_fence_i(), ctx);
> +}
> +
>   static inline u32 rv_nop(void)
>   {
>   	return rv_i_insn(0, 0, 0, 0, 0x13);
> diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
> index 592dd86fbf81..d9a6f55a7e8e 100644
> --- a/arch/riscv/net/bpf_jit_comp32.c
> +++ b/arch/riscv/net/bpf_jit_comp32.c
> @@ -1248,8 +1248,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   			return -1;
>   		break;
>   
> -	/* speculation barrier */
> +	/*
> +	 * Speculation barrier using fence.i for pipeline serialization.
> +	 * RISC-V lacks a dedicated speculation barrier instruction.
> +	 */
>   	case BPF_ST | BPF_NOSPEC:
> +		emit_fence_i(ctx);
>   		break;
>   
>   	case BPF_ST | BPF_MEM | BPF_B:
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 45cbc7c6fe49..fabafbebde0c 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1864,8 +1864,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   		break;
>   	}
>   
> -	/* speculation barrier */
> +	/*
> +	 * Speculation barrier using fence.i for pipeline serialization.
> +	 * RISC-V lacks a dedicated speculation barrier instruction.
> +	 */
>   	case BPF_ST | BPF_NOSPEC:
> +		emit_fence_i(ctx);
>   		break;
>   
>   	/* ST: *(size *)(dst + off) = imm */


