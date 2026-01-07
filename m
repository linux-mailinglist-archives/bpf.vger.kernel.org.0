Return-Path: <bpf+bounces-78168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F52D00650
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 00:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E37530204BD
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 23:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B4C40855;
	Wed,  7 Jan 2026 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OOVZZOnr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE312FD66B
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767828609; cv=none; b=pg/79el8G7lbMHl5VxqDH2pzN5O3bbT/cJWHaAA2Fm933RgfW59NW2AG+oOoiCmOihwMvkT9YAOWhu8OrmaHtl3ABYIs+EAw70noHizok/NozTqoXA0OQtkUacNJEi7Au/eMKxGyZAcq4bsaCFGR6B8oOLrO6BlV/IIatoasLmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767828609; c=relaxed/simple;
	bh=UDLdShWXKL52I+e1W+1cuswPFcxArF3MFXl9TS/TvWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhqkHj36YUlqqF3iOslImHjiHOQj41sfJaBv6bcaTLaEZVXhrk+J3To+9r+bvGYCA9xBIRRVN9jy+SASrlrvD13RKjLeVDjWKdODvl0Yd+hKNfjUg9vM8wSSU2BGcfzCvQ/dh0NUpF/9PoMDfha4+43pD4xFDslJpDcnIECQKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OOVZZOnr; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3e3dac349easo2247360fac.2
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 15:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1767828604; x=1768433404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DD3+WPugILA6AK9V3BgRQ69JbKdSsxscgzBr4aMHJyI=;
        b=OOVZZOnrH7/S++/5KxO1TKk3r0D/EXcCZLUOcPOMgDL+k/AZLBANoz4U0PEV5YvPnA
         rjhhJrwj9oeonq1uYkPnnMd4Rl8mqgsIoAaCQL0NvVCkRIZSWDXEY70O26QP2wkYpAiF
         yMsWCeIW4rZhD93qjwXC0xRVoiZyNhhGHx00+WqIqjVg2pIa5CdD61jYVPvVX+rnZSS2
         2oKGRui+3mgqF4AZeyMg2meTU9d4mDpRZKqLYRtcvU0Oe+1bPucC3mLbRnr/NbU2DezW
         9CylrPgi171Ip4T2o6SPBpPevGSfA2fAsX20+2nvOWAttBUy9H+RODRTW6LSUoO0NS2N
         hSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767828604; x=1768433404;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DD3+WPugILA6AK9V3BgRQ69JbKdSsxscgzBr4aMHJyI=;
        b=Y9OgroFKz8UbhAvzzYm0YhW47zHZpnGgqhqdBoMWL20l0ND59j9Ot8fbZjszAaqlb/
         uALMt5/SoGhdog4BDICEnFK0zFbntjDTtCKUsEqrNVvBQXyzVFwFue59mRpJV8+AI0qa
         1xh+1YWVQTIA9uRQ8BFTlFT2hLlX2jV6fNZ/YuKJGf+UiPsuqkH+2L5mhwISlzunmqDD
         N9jbmmf1nMEllKHl/LDPVDUxK85+0p4uXvX20Daw8txtC4N17uGnUPdKZRhoLjxBwCbv
         EvPPQl6gy1t+lt19ylVHOpIFYaY7DXcSsKetP8zbpfpOJxoch41JO/lOf+sPk3E00EKp
         cAlg==
X-Forwarded-Encrypted: i=1; AJvYcCU51oRKS2/zYyDsoSfJuD+voZT9+2dxOWyvu5tM/XpIlUK+L9vKkxyu0jB/sM9YNPaFYZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHs7fTh9Q/DDibRIvMODkZ5ZHVjV2b+/6DXCx8YX7QQfP8TAlh
	WfDH1G+iIJDo8d1f1RcWHJVpYK/FmlNRHw5vJHu14LJ8RuaCtF2D1K/AhpHar1MTELs=
X-Gm-Gg: AY/fxX68p/m7FL5DbXUj2jNyhIabe4jsMzPmDEDTDHJC8WpdzLs764aZkVwwJWZPo5o
	99syWcVK0zB42VA/FOECnFeKGCq+/5s9WU7gvBwPNZe81q1KyEcht6TI4lbGBcemfaCQX7rx5aa
	XqFHMoiWB1WBz7tQK2uRArqYdSXNYiW1+Muo/h1hOrWXvK9ZANae038mJ4+acLp3iwcs18+/AMu
	ofWtr7IeUog16njaaDmK4ij6dbGMrBNRk6ZOYqLDayNibi+kwbRK+sT+LtdOGkhEgNdsWBzsykZ
	SnCDzLhrXTIh44ki+7YH8gXdD8XxiHxEY+lPoC2eErCGpuIrVze1vnYe/CNck6uK8l35N5YO03F
	LUj+wNQfGdzGX1wO2WTZSvmZlZLq35AxIv24YlKY1IuPHcYAnP0Z104cfqE9TJX9D00AwfrZDI3
	Cezkl+ngtM0xf0Cm+/Cd+WRG4a2LtK
X-Google-Smtp-Source: AGHT+IEbrWosXtHfAjh0EHHCNxNQExF8ZdJBVaTpWjr+5/PED+E0A/kj02pUGytgAZFj/rBktqDFKw==
X-Received: by 2002:a05:6870:934b:b0:3f5:aced:c441 with SMTP id 586e51a60fabf-3ffc0993d08mr2061071fac.4.1767828604589;
        Wed, 07 Jan 2026 15:30:04 -0800 (PST)
Received: from [100.64.0.1] ([170.85.11.118])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de8cbfsm4035171fac.3.2026.01.07.15.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 15:30:04 -0800 (PST)
Message-ID: <06ac0b87-d398-4cb0-a614-760bfe41cf7f@sifive.com>
Date: Wed, 7 Jan 2026 17:30:02 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv, bpf: Emit fence.i for BPF_NOSPEC
To: Luis Gerhorst <luis.gerhorst@fau.de>,
 Lukas Gerlach <lukas.gerlach@cispa.de>
Cc: ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org,
 daniel.weber@cispa.de, daniel@iogearbox.net, jo.vanbulck@kuleuven.be,
 linux-riscv@lists.infradead.org, luke.r.nels@gmail.com,
 marton.bognar@kuleuven.be, michael.schwarz@cispa.de, palmer@dabbelt.com,
 pjw@kernel.org, xi.wang@gmail.com, cleger@rivosinc.com, palmer@rivosinc.com,
 conor.dooley@microchip.com, andrew@sifive.com
References: <87y0m996b2.fsf@fau.de>
 <20260107095406.4082-1-lukas.gerlach@cispa.de> <87sechz4x3.fsf@fau.de>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <87sechz4x3.fsf@fau.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-07 11:52 AM, Luis Gerhorst wrote:
> Lukas Gerlach <lukas.gerlach@cispa.de> writes:
> 
>> Regarding bpf_jit_bypass_spec_v1/v4(): currently this is per-architecture.
>> What we need is per-processor granularity, so we can disable mitigations
>> on in-order cores and keep them enabled on vulnerable out-of-order processors.
> 
> Yes, sorry this was unclear. I just wanted to point out that once you
> have that infrastructure you can implement them as follows:
> 
> bpf_jit_bypass_spec_v1/v4() {
>   if (RV_CPU_IN_ORDER())
>     return true;
>   else
>     return false;
> }
> 
> But you are right that the definition of RV_CPU_IN_ORDER() is still
> missing of course.
> 
>> Regarding fence.i being an extension: all RISC-V processors supported by the
>> kernel that are vulnerable to these attacks support this instruction.
> 
> I am not sure if I misunderstand the "that are vulnerable to these
> attacks".
> 
> If you mean that vulnerable CPUs always have fence.i: What if a CPU
> still does not support the instruction (no matter if it is vulnerable or
> not)?
> 
> If I understand the RISC-V JIT correctly, it will then still generate
> fence.i with this patch. When this eBPF program is then invoked the
> CPU will panic upon reaching the fence.i which is a invalid opcode as
> far as this CPU is concerned. Or is there some ifdef I am missing here?
> 
> I would assume you need something like this:
> 
> case BPF_ST | BPF_NOSPEC:
>   if (riscv_has_extension_likely(RISCV_ISA_EXT_ZIFENCEI))
>     emit_fence_i(ctx);
>   break;
> 
> Or is there some guarantee that this extension is always available? I
> read [3] as implying that this is no longer the case with the 2.0
> instruction set for unprivileged. Does this also mean it is an optional
> extension for the privileged ISA?

The Zifencei extension is no longer a mandatory part of the ISA, but it is
mandatory for Linux. Linux requires at least "rv32ima or rv64ima, as defined by
version 2.2 of the user ISA and version 1.10 of the privileged ISA".

Notably, in version 2.2 of the user ISA, the Zifencei extension was still an
unnamed subset of the I extension, so it is included in the above requirement.
It was later removed from the I extension and given its own name, which is why
we have weirdness like the code below. (You can see in arch/riscv/Makefile where
we unconditionally add either ISA version 2.2 or Zifencei to CFLAGS.)

> 
> RISC-V cpufeature.c had this in [2]:
> 
> 		/*
> 		 * Linux requires the following extensions, so we may as well
> 		 * always set them.
> 		 */
> 		set_bit(RISCV_ISA_EXT_ZICSR, this_isa);
> 		set_bit(RISCV_ISA_EXT_ZIFENCEI, this_isa);
> 
> But as of [1] it was changed to:
> 
> 		if (acpi_disabled) {
> 			set_bit(RISCV_ISA_EXT_ZICSR, source_isa);
> 			set_bit(RISCV_ISA_EXT_ZIFENCEI, source_isa);
> 
> So based on that I would assume fence.i may not always be supported.

This is just a quirk of the parsing code. As mentioned in [1], older devicetrees
were written while Zifencei was an implicit part of I, so we don't expect it to
appear in the devicetree. The ACPI table definition was written after Zifencei
was a separate extension, so we do expect Zifencei to appear on its own in the
ACPI table. But it is still required. (We don't currently check that all
extensions required by the kernel are actually present; this will be done as
part of the RVA23 enablement.)

> But I also found that 921ebd8f2c08 ("RISC-V: Allow userspace to flush
> the instruction cache") seems to assume that fence.i always works (see
> local_flush_icache_all() which I assume runs in the kernel).

Yes, the kernel definitely won't run if fence.i is missing, so we don't need to
worry about such hardware. We could probably document this better.

Regards,
Samuel

> Even if the CPU is known vulnerable but does not support the extension,
> it will be better not to generate the instruction. If we still want to
> do something about these CPUs, maybe add a warning message to advise the
> user that unpriv eBPF should definately be kept disabled on this CPU?
> 
> [1] https://lore.kernel.org/all/20230711224600.10879-1-palmer@rivosinc.com/
> [2] https://lore.kernel.org/all/20230607-nest-collision-5796b6be8be6@spud/
> [3] https://docs.riscv.org/reference/isa/unpriv/zifencei.html
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


