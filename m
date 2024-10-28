Return-Path: <bpf+bounces-43269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C989B22AC
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 03:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E801F21C63
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 02:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94661155C97;
	Mon, 28 Oct 2024 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="OZIawUAV"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF7C14A088;
	Mon, 28 Oct 2024 02:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730082212; cv=none; b=golnDRuYpIR52SqMwQwxbz8Pxqar1HnMS4Yyu21EQm9hlqZs46dPkyzHfnSQYv8GcuXkda9a9MMURSjmdcEw8rludFyIvVEq06Md4BkMzDqB3VRWXTt3m+4dasVDKo695w2cKWscIwPmf1VpIXUCiH7K0b75n34Z+BSQO6PE0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730082212; c=relaxed/simple;
	bh=u/xTtnizdqRxZA7D0F1Ev2yUBsm0p/OFai4PrZAtDDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rxf7gLGvF7LrYNuxlV/bcyeA+11Zmtv7WgcOYFj3ueztQe/nc49zAQq4MqUMdiIcCltaKvIDg/7Q0hOOOwmBoQWkcK0e3HKdt2YJXuRJ1scyVZZzeE5MGYxU5ShlM9UPtmCoK2rl/cRC9Wbq+3JizAK2FFxBWgf1g1KGjWiCZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=OZIawUAV; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730082202;
	bh=wVzoc2YabnIij5HP3bkYWkQB3e64c7slt7BMmOIG3vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OZIawUAVvihaiXSwIbUZzcTz/tSg3C1U5LEaVYgOz4QoVISgtL6WviXd3+smevP7j
	 R/hVpxpqQA2czH0OgbOsdZ/XN9oOlY7sbOzvWwnvGYYyYJsAuLhD8D2cGXk3zQ3Qcf
	 Xlmo8LCM81g3VdyYneWeZi52VsFp2ozQKki9ZSVwqAf7xk8cYqaSwqlX4Mipqjed6a
	 eYbw3SKM3H8Y7R3CxIjshRL1I3sLTmewm9KYFwOuMGXWKXrkByPLjplT3Ne2Vy4WLv
	 oS3+EntGWYqofeVy/dSgM+jb9ZxRrfbS0RYyedkF7axBWtyZppZ+q42fJGbmWcXti8
	 0jDbtveRkr5HQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XcHHX4W29z4x89;
	Mon, 28 Oct 2024 13:23:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Naveen N. Rao" <naveen@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Daniel Borkmann <daniel@iogearbox.net>, Masahiro
 Yamada <masahiroy@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Vishal Chourasia
 <vishalc@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: [PATCH v6 17/17] powerpc64/bpf: Add support for bpf trampolines
In-Reply-To: <20241018173632.277333-18-hbathini@linux.ibm.com>
References: <20241018173632.277333-1-hbathini@linux.ibm.com>
 <20241018173632.277333-18-hbathini@linux.ibm.com>
Date: Mon, 28 Oct 2024 13:23:13 +1100
Message-ID: <87wmhtrmni.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hari Bathini <hbathini@linux.ibm.com> writes:
> From: Naveen N Rao <naveen@kernel.org>
>
> Add support for bpf_arch_text_poke() and arch_prepare_bpf_trampoline()
> for 64-bit powerpc. While the code is generic, BPF trampolines are only
> enabled on 64-bit powerpc. 32-bit powerpc will need testing and some
> updates.

Hi Hari,

This is breaking the PCREL build for me:

  ERROR: 11:49:18: Failed building ppc64le_defconfig+pcrel@fedora
  INFO: 11:49:18: (skipped 41 lines) ...
  INFO: 11:49:18: /linux/arch/powerpc/net/bpf_jit.h:90:9: note: in expansion of macro 'EMIT'
     90 |         EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
        |         ^~~~
  /linux/arch/powerpc/include/asm/ppc-opcode.h:473:88: note: in expansion of macro 'IMM_DS'
    473 | #define PPC_RAW_LD(r, base, i)          (0xe8000000 | ___PPC_RT(r) | ___PPC_RA(base) | IMM_DS(i))
        |                                                                                        ^~~~~~
  /linux/arch/powerpc/net/bpf_jit.h:90:14: note: in expansion of macro 'PPC_RAW_LD'
     90 |         EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
        |              ^~~~~~~~~~
  /linux/arch/powerpc/net/bpf_jit.h:90:36: note: in expansion of macro 'offsetof'
     90 |         EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
        |                                    ^~~~~~~~
  /linux/arch/powerpc/net/bpf_jit_comp.c:791:17: note: in expansion of macro 'PPC64_LOAD_PACA'
    791 |                 PPC64_LOAD_PACA();
        |                 ^~~~~~~~~~~~~~~
  /linux/arch/powerpc/net/bpf_jit.h:90:65: error: 'struct paca_struct' has no member named 'kernel_toc'; did you mean 'kernel_msr'?
     90 |         EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
        |                                                                 ^~~~~~~~~~
  /linux/arch/powerpc/net/bpf_jit.h:29:34: note: in definition of macro 'PLANT_INSTR'
     29 |         do { if (d) { (d)[idx] = instr; } idx++; } while (0)
        |                                  ^~~~~
  /linux/arch/powerpc/net/bpf_jit.h:90:9: note: in expansion of macro 'EMIT'
     90 |         EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
        |         ^~~~
  /linux/arch/powerpc/include/asm/ppc-opcode.h:473:88: note: in expansion of macro 'IMM_DS'
    473 | #define PPC_RAW_LD(r, base, i)          (0xe8000000 | ___PPC_RT(r) | ___PPC_RA(base) | IMM_DS(i))
        |                                                                                        ^~~~~~
  /linux/arch/powerpc/net/bpf_jit.h:90:14: note: in expansion of macro 'PPC_RAW_LD'
     90 |         EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
        |              ^~~~~~~~~~
  /linux/arch/powerpc/net/bpf_jit.h:90:36: note: in expansion of macro 'offsetof'
     90 |         EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
        |                                    ^~~~~~~~
  /linux/arch/powerpc/net/bpf_jit_comp.c:882:25: note: in expansion of macro 'PPC64_LOAD_PACA'
    882 |                         PPC64_LOAD_PACA();
        |                         ^~~~~~~~~~~~~~~
  make[5]: *** [/linux/scripts/Makefile.build:229: arch/powerpc/net/bpf_jit_comp.o] Error 1


To test it you need to enable CONFIG_POWER10_CPU, eg:

  CONFIG_POWERPC64_CPU=n
  CONFIG_POWER10_CPU=y
  CONFIG_PPC_KERNEL_PCREL=y

This diff gets it building, but I haven't tested it actually works:

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 2d04ce5a23da..af6ff3eb621a 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -86,9 +86,14 @@
                                                        0xffff));             \
                } } while (0)
 #define PPC_LI_ADDR    PPC_LI64
+
+#ifndef CONFIG_PPC_KERNEL_PCREL
 #define PPC64_LOAD_PACA()                                                    \
        EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)))
 #else
+#define PPC64_LOAD_PACA() do {} while (0)
+#endif
+#else
 #define PPC_LI64(d, i) BUILD_BUG()
 #define PPC_LI_ADDR    PPC_LI32
 #define PPC64_LOAD_PACA() BUILD_BUG()

cheers

