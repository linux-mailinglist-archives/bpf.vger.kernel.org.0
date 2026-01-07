Return-Path: <bpf+bounces-78145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3077ACFF4FF
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A7753009FD2
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F86E2D63E8;
	Wed,  7 Jan 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="frVi5bsO"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49838487BE
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808841; cv=none; b=ftNTsyDfRKsv60dFdsUDJmUpgpDFTDvRxBVcP88t/5gDdeE+AoELommugMyg694G0tl+KXqld9TOAJv7wMF9kQQAf2J4+Ch5POd0vrY6gq3PRAMM5PpYuXf+W26T2NrZl0rjhzJ94luH7yu09CU7afIP1bmi+dgnNXTcXJaEhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808841; c=relaxed/simple;
	bh=XWYpzFVOYNMZshVetMxqmksABzUHIEZ+W32iYolvtL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F2SJt7l3WVvav/rIzN78V3Pp7ep/oVG2hK+N0G2Vw8ZRTisjWKC8mf6Ky0PJdadV2FUVeQhKPTBwi/jpGDkDdT/nbANOvUPv1fn/Ng4/M04+jLCnGbZvZavNdNoJ0YUYdjFG9Aua+LRUhfGYQJ+oVHCgvZ9sgaAsc2TNpd6ce2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=frVi5bsO; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1767808348; bh=FEBbEJYjF9VeYuE/c6VI2LwqJ1VlZp1N2SisoMN0mzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=frVi5bsOpHQyFdBNg/aA4J73jE61+MYbzsrKroDpZBhxhbi0vauKHV5NrIACNrO5b
	 dyMBdoXBaDAUxS9LZQjaF4Z9c1AjI8un16hnHb8G31qeuFwqWGbWizET+PWIioS7kp
	 IVHr6UmC+vDQWrrM50QQIuZImmRpWP1rGgApKU05Xoj+yCE6dPIshlq+cSqZ50d1oh
	 jcP8hRBen2TLlJyQXBfFIX/T6zyKV3lq41JLsMXYKoF5Q+5ilWviIxt20IsKo1Cb0X
	 MPXbjPRN725V30meLJRVY2I0ci2/SlJ3/yoNyCkDO2gWlkEShVe5Nx34WZ4KJvVmup
	 wQNDzMuCNmsPg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4dmbGM6ssTzPkCM;
	Wed,  7 Jan 2026 18:52:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.188.34.184
Received: from localhost (i4laptop33.informatik.uni-erlangen.de [10.188.34.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19Sh7w1z3IDDyxOFeZshEUU57P0q9RJGdo=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4dmbGJ700vzPk7g;
	Wed,  7 Jan 2026 18:52:24 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Lukas Gerlach <lukas.gerlach@cispa.de>
Cc: <ast@kernel.org>,  <bjorn@kernel.org>,  <bpf@vger.kernel.org>,
  <daniel.weber@cispa.de>,  <daniel@iogearbox.net>,
  <jo.vanbulck@kuleuven.be>,  <linux-riscv@lists.infradead.org>,
  <luke.r.nels@gmail.com>,  <marton.bognar@kuleuven.be>,
  <michael.schwarz@cispa.de>,  <palmer@dabbelt.com>,  <pjw@kernel.org>,
  <xi.wang@gmail.com>, <cleger@rivosinc.com>, <palmer@rivosinc.com>,
 <conor.dooley@microchip.com>, <andrew@sifive.com>
Subject: Re: [PATCH] riscv, bpf: Emit fence.i for BPF_NOSPEC
In-Reply-To: <20260107095406.4082-1-lukas.gerlach@cispa.de> (Lukas Gerlach's
	message of "Wed, 7 Jan 2026 10:54:05 +0100")
References: <87y0m996b2.fsf@fau.de>
	<20260107095406.4082-1-lukas.gerlach@cispa.de>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 07 Jan 2026 18:52:24 +0100
Message-ID: <87sechz4x3.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Gerlach <lukas.gerlach@cispa.de> writes:

> Regarding bpf_jit_bypass_spec_v1/v4(): currently this is per-architecture.
> What we need is per-processor granularity, so we can disable mitigations
> on in-order cores and keep them enabled on vulnerable out-of-order processors.

Yes, sorry this was unclear. I just wanted to point out that once you
have that infrastructure you can implement them as follows:

bpf_jit_bypass_spec_v1/v4() {
  if (RV_CPU_IN_ORDER())
    return true;
  else
    return false;
}

But you are right that the definition of RV_CPU_IN_ORDER() is still
missing of course.

> Regarding fence.i being an extension: all RISC-V processors supported by the
> kernel that are vulnerable to these attacks support this instruction.

I am not sure if I misunderstand the "that are vulnerable to these
attacks".

If you mean that vulnerable CPUs always have fence.i: What if a CPU
still does not support the instruction (no matter if it is vulnerable or
not)?

If I understand the RISC-V JIT correctly, it will then still generate
fence.i with this patch. When this eBPF program is then invoked the
CPU will panic upon reaching the fence.i which is a invalid opcode as
far as this CPU is concerned. Or is there some ifdef I am missing here?

I would assume you need something like this:

case BPF_ST | BPF_NOSPEC:
  if (riscv_has_extension_likely(RISCV_ISA_EXT_ZIFENCEI))
    emit_fence_i(ctx);
  break;

Or is there some guarantee that this extension is always available? I
read [3] as implying that this is no longer the case with the 2.0
instruction set for unprivileged. Does this also mean it is an optional
extension for the privileged ISA?

RISC-V cpufeature.c had this in [2]:

		/*
		 * Linux requires the following extensions, so we may as well
		 * always set them.
		 */
		set_bit(RISCV_ISA_EXT_ZICSR, this_isa);
		set_bit(RISCV_ISA_EXT_ZIFENCEI, this_isa);

But as of [1] it was changed to:

		if (acpi_disabled) {
			set_bit(RISCV_ISA_EXT_ZICSR, source_isa);
			set_bit(RISCV_ISA_EXT_ZIFENCEI, source_isa);

So based on that I would assume fence.i may not always be supported.

But I also found that 921ebd8f2c08 ("RISC-V: Allow userspace to flush
the instruction cache") seems to assume that fence.i always works (see
local_flush_icache_all() which I assume runs in the kernel).

Even if the CPU is known vulnerable but does not support the extension,
it will be better not to generate the instruction. If we still want to
do something about these CPUs, maybe add a warning message to advise the
user that unpriv eBPF should definately be kept disabled on this CPU?

[1] https://lore.kernel.org/all/20230711224600.10879-1-palmer@rivosinc.com/
[2] https://lore.kernel.org/all/20230607-nest-collision-5796b6be8be6@spud/
[3] https://docs.riscv.org/reference/isa/unpriv/zifencei.html

