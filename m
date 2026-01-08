Return-Path: <bpf+bounces-78214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E792AD03293
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 14:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEC6A3008777
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E7D3BC4FD;
	Thu,  8 Jan 2026 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="TXRwanSq"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C83B8BC7
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866723; cv=none; b=mHsaEbg46SNX6xxXH8+WsoxYboUFejv0ZXoXa107+WH9oKfMG8ft2pLH+t3YHtFr2vGXs+g3ujIQDcNqTu1PgnO1CCFU1Rgd0MxlzzwD7jSsVZz91Nzdi0SUVhIs2UwsJgQHHKVcQvTx+OLUwWkBtANs1Pmsw+KtbaATA3uPL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866723; c=relaxed/simple;
	bh=jS/mByU1/+LWoO6eJHzIMJeaNxLcmHNTlUbmDgIA0RI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QwHuVI2YVJ0nZferjng3m38x3R6axMgRurl/j6x70Rz0vep7gkyk9IMZ/fKp/6eIvSudtRmZ73ooPs2JSFowMdGg5PYm5ZkiW62e8UNEXIDU6yaKGFscUdtVA8NO+3HiASwoWNxlcNCEBrnzhehWX/hhOZveMPPkZ/6oemKj1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=TXRwanSq; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1767866709; bh=pnpSM3+LZ7mt++O2dJV5Zv3nt3YFPeMMaAN43GJ9qSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=TXRwanSqLD1caB7/z27CfdMl+01wFPEyCyYyER7hODQ7nfKk+4XAQ6n19GMWyCM8A
	 nUbjG/WzLyx9YtxeG8ajPcVS0xlmB5XWF1qggMqc2p3T32fCJNy9sAI7/d31CFSwtK
	 qR2HJY2B4tcQAziwErqszVK3Yu7Zl7eXvxGiYSPZfJwO1NoV12ffLKPQHDFhti7Ha1
	 ix/1yVb+qbCPtuvZKaeee+siCZBJSKn27khqzRi5ZQDuEAMuUq0WyEwQQas41jITYO
	 5sI8dXKMtI+ciJHNvZZ9fzJcdzAWx7i45PagAO/JWk+JVgzV8ZmIMQEOcIoH9eyIsB
	 3xlb+iqxx+3Mg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4dn0rj5vcVz1xwT;
	Thu,  8 Jan 2026 11:05:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.188.34.184
Received: from localhost (i4laptop33.informatik.uni-erlangen.de [10.188.34.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX180WNKE5bNi5QBpRfXLZfhB6/uihbEZEPM=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4dn0rg0bYbz1y3L;
	Thu,  8 Jan 2026 11:05:07 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Lukas Gerlach <lukas.gerlach@cispa.de>,  ast@kernel.org,
  bjorn@kernel.org,  bpf@vger.kernel.org,  daniel.weber@cispa.de,
  daniel@iogearbox.net,  jo.vanbulck@kuleuven.be,
  linux-riscv@lists.infradead.org,  luke.r.nels@gmail.com,
  marton.bognar@kuleuven.be,  michael.schwarz@cispa.de,
  palmer@dabbelt.com,  pjw@kernel.org,  xi.wang@gmail.com,
  cleger@rivosinc.com,  palmer@rivosinc.com,  conor.dooley@microchip.com,
  andrew@sifive.com
Subject: Re: [PATCH] riscv, bpf: Emit fence.i for BPF_NOSPEC
In-Reply-To: <06ac0b87-d398-4cb0-a614-760bfe41cf7f@sifive.com> (Samuel
	Holland's message of "Wed, 7 Jan 2026 17:30:02 -0600")
References: <87y0m996b2.fsf@fau.de>
	<20260107095406.4082-1-lukas.gerlach@cispa.de> <87sechz4x3.fsf@fau.de>
	<06ac0b87-d398-4cb0-a614-760bfe41cf7f@sifive.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 08 Jan 2026 11:05:06 +0100
Message-ID: <875x9czagd.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Samuel Holland <samuel.holland@sifive.com> writes:

> The Zifencei extension is no longer a mandatory part of the ISA, but it is
> mandatory for Linux. Linux requires at least "rv32ima or rv64ima, as defined by
> version 2.2 of the user ISA and version 1.10 of the privileged ISA".
>
> Notably, in version 2.2 of the user ISA, the Zifencei extension was still an
> unnamed subset of the I extension, so it is included in the above requirement.
> It was later removed from the I extension and given its own name, which is why
> we have weirdness like the code below. (You can see in arch/riscv/Makefile where
> we unconditionally add either ISA version 2.2 or Zifencei to CFLAGS.)
>
>> RISC-V cpufeature.c had this in [2]:
>> 
>> 		/*
>> 		 * Linux requires the following extensions, so we may as well
>> 		 * always set them.
>> 		 */
>> 		set_bit(RISCV_ISA_EXT_ZICSR, this_isa);
>> 		set_bit(RISCV_ISA_EXT_ZIFENCEI, this_isa);
>> 
>> But as of [1] it was changed to:
>> 
>> 		if (acpi_disabled) {
>> 			set_bit(RISCV_ISA_EXT_ZICSR, source_isa);
>> 			set_bit(RISCV_ISA_EXT_ZIFENCEI, source_isa);
>> 
>> So based on that I would assume fence.i may not always be supported.
>
> This is just a quirk of the parsing code. As mentioned in [1], older devicetrees
> were written while Zifencei was an implicit part of I, so we don't expect it to
> appear in the devicetree. The ACPI table definition was written after Zifencei
> was a separate extension, so we do expect Zifencei to appear on its own in the
> ACPI table. But it is still required. (We don't currently check that all
> extensions required by the kernel are actually present; this will be done as
> part of the RVA23 enablement.)
>
>> But I also found that 921ebd8f2c08 ("RISC-V: Allow userspace to flush
>> the instruction cache") seems to assume that fence.i always works (see
>> local_flush_icache_all() which I assume runs in the kernel).
>
> Yes, the kernel definitely won't run if fence.i is missing, so we don't need to
> worry about such hardware. We could probably document this better.

Thanks for clarifying this! In that case the patch looks good to me.

I assume some testing has been done to ensure the instruction coding
works. (I think the eBPF CI does not have RISC-V yet but [1] previously
worked fine for me.)

Acked-by: Luis Gerhorst <luis.gerhorst@fau.de>

[1] https://github.com/pulehui/riscv-bpf-vmtest

