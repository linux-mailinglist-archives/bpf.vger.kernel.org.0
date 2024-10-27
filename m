Return-Path: <bpf+bounces-43255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E33B9B1CBE
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 10:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E62C1F21834
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 09:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCB6126C13;
	Sun, 27 Oct 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5DDEy4+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A997DA6D;
	Sun, 27 Oct 2024 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730020912; cv=none; b=BbTu8iVbRcAJeioNAH5iKNaJxl6pMx8Z59Buus2f9mKuVkQECkkmDAlK2qkonVIXsPZq5qE96CcrGtIdTyl5wkXLqW1+mbknASWkzu1M5/p/di/Z5cf4MklIKHy2ujhbkn/gCPvS8MJhK2ODJT8svSMwY4sKo7HfGy4YBbkVfR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730020912; c=relaxed/simple;
	bh=Hhva42WPCShAFFkXmCOYCeH5zalvUU7wEkwSbU5sfHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfwrIGKl6M/K9SN8mFdaIvIC2C4/uit7iaaHTqNDv8/DvHSPLoTL2eSdM7DGVpqjh2w9YpzX1lcIvJXYs+s+HC19DVaEL7EFeSVtzIZGwwUFBj/X4oEKB/aSB84OdadRMVm1E3E3ZH12TvGR6aHR7Sv5yRBKwqWB83gwgXUVyVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5DDEy4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E381C4CEE7;
	Sun, 27 Oct 2024 09:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730020912;
	bh=Hhva42WPCShAFFkXmCOYCeH5zalvUU7wEkwSbU5sfHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n5DDEy4+ez5iIRNSlZLIh0/6u/o9dBtmMQ3Qnrw5YX0TjsNcqb//7mbzdZa3iFYyA
	 vgOphpGVRof5tqvAwK9GeiLDHr5aKa3EGzTJo3UYGTkV0tr123xcNnWCKlEO9mWRlp
	 8jFhmzIfYo587Y8MHTISZ1Ge/XW654DS3fJIfsoPLBumyYowonPPTWd9O1dM+zjGS0
	 cKA2nsWz69tHXiEaTiTvXjap+ul1scYk7wUs09+8v2qp4Q7qwo4DwdeU//aBwHCNoF
	 w5/cE7ii8desYpS4j3L4IdC5OEQeh0oG1r59NuXzdAcjYGg7VfQyM0AEKAddyvwQK9
	 yqg/w4iMcLqLA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e8607c2aso3495112e87.3;
        Sun, 27 Oct 2024 02:21:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8dpsi8wPmloj24TN3aXE6ru3eX776l2xetVsWWLgO81ho/ZMS2fIMt7SKT3h8RM/TdWb18sW0r7jSUfnV@vger.kernel.org, AJvYcCUIHY8q/Gr3YVkRQ5agaevnNndOqhUFHw9uUcG2cXOM9uSx2dDdVBR/aLivQvYU2RyuUag=@vger.kernel.org, AJvYcCVKPFOT2Ciz2pHwmUAUnayN+byMDXtoEnwgzV5toFpNAe1DPwBt5DmF/f5+j/ciVM2sgB6N5qJLjY0c7NwprAYNMY5p@vger.kernel.org, AJvYcCVM3zmBOreOQ0VdKbUvJyK/fJdr/CpKuL7NOh2W48IsFJBBPDMjcbBwzm/iEY3nSJ3UbEYHk6RhFvLTRThR@vger.kernel.org
X-Gm-Message-State: AOJu0YxGobNFQdMFgQJe4/RoBC5F6ozdKTViUn2HqOfhDgEgMTDJ9neD
	e0QsCISJprRgMH4fUpfle/iVUDqB7fmjtucS78v0rFGdFCOmElYGhElZla1dOxTXHBQn6A7PXtv
	772ATXob5N8CAFIA0mHy/By/kAag=
X-Google-Smtp-Source: AGHT+IHWDEbdS6dDes0FXasZhcczxuG/y8V5MfEi19kb1OsAxqisZ47o0GkY5XeGVwsrBNUXk3HWpjxvqknLG0iETfA=
X-Received: by 2002:a05:6512:230b:b0:539:d05c:f553 with SMTP id
 2adb3069b0e04-53b348cc551mr1681456e87.21.1730020910946; Sun, 27 Oct 2024
 02:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018173632.277333-1-hbathini@linux.ibm.com> <20241018173632.277333-13-hbathini@linux.ibm.com>
In-Reply-To: <20241018173632.277333-13-hbathini@linux.ibm.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 27 Oct 2024 18:21:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNASyfxY9RJU+pvEdyd6yuB=r4C9xcvBBTLokXe_xkhM8RA@mail.gmail.com>
Message-ID: <CAK7LNASyfxY9RJU+pvEdyd6yuB=r4C9xcvBBTLokXe_xkhM8RA@mail.gmail.com>
Subject: Re: [PATCH v6 12/17] powerpc64/ftrace: Move ftrace sequence out of line
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	"Naveen N. Rao" <naveen@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Nicholas Piggin <npiggin@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Vishal Chourasia <vishalc@linux.ibm.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 2:38=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.co=
m> wrote:
>
> From: Naveen N Rao <naveen@kernel.org>
>
> Function profile sequence on powerpc includes two instructions at the
> beginning of each function:
>         mflr    r0
>         bl      ftrace_caller
>
> The call to ftrace_caller() gets nop'ed out during kernel boot and is
> patched in when ftrace is enabled.
>
> Given the sequence, we cannot return from ftrace_caller with 'blr' as we
> need to keep LR and r0 intact. This results in link stack (return
> address predictor) imbalance when ftrace is enabled. To address that, we
> would like to use a three instruction sequence:
>         mflr    r0
>         bl      ftrace_caller
>         mtlr    r0
>
> Further more, to support DYNAMIC_FTRACE_WITH_CALL_OPS, we need to
> reserve two instruction slots before the function. This results in a
> total of five instruction slots to be reserved for ftrace use on each
> function that is traced.
>
> Move the function profile sequence out-of-line to minimize its impact.
> To do this, we reserve a single nop at function entry using
> -fpatchable-function-entry=3D1 and add a pass on vmlinux.o to determine
> the total number of functions that can be traced. This is then used to
> generate a .S file reserving the appropriate amount of space for use as
> ftrace stubs, which is built and linked into vmlinux.
>
> On bootup, the stub space is split into separate stubs per function and
> populated with the proper instruction sequence. A pointer to the
> associated stub is maintained in dyn_arch_ftrace.
>
> For modules, space for ftrace stubs is reserved from the generic module
> stub space.
>
> This is restricted to and enabled by default only on 64-bit powerpc,
> though there are some changes to accommodate 32-bit powerpc. This is
> done so that 32-bit powerpc could choose to opt into this based on
> further tests and benchmarks.
>
> As an example, after this patch, kernel functions will have a single nop
> at function entry:
> <kernel_clone>:
>         addis   r2,r12,467
>         addi    r2,r2,-16028
>         nop
>         mfocrf  r11,8
>         ...
>
> When ftrace is enabled, the nop is converted to an unconditional branch
> to the stub associated with that function:
> <kernel_clone>:
>         addis   r2,r12,467
>         addi    r2,r2,-16028
>         b       ftrace_ool_stub_text_end+0x11b28
>         mfocrf  r11,8
>         ...
>
> The associated stub:
> <ftrace_ool_stub_text_end+0x11b28>:
>         mflr    r0
>         bl      ftrace_caller
>         mtlr    r0
>         b       kernel_clone+0xc
>         ...
>
> This change showed an improvement of ~10% in null_syscall benchmark on a
> Power 10 system with ftrace enabled.
>
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---

> diff --git a/arch/powerpc/tools/Makefile b/arch/powerpc/tools/Makefile
> new file mode 100644
> index 000000000000..d2e7ecd5f46f
> --- /dev/null
> +++ b/arch/powerpc/tools/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +quiet_cmd_gen_ftrace_ool_stubs =3D GEN     $@
> +      cmd_gen_ftrace_ool_stubs =3D $< "$(CONFIG_64BIT)" "$(OBJDUMP)" vml=
inux.o $@
> +
> +$(obj)/vmlinux.arch.S: $(src)/ftrace-gen-ool-stubs.sh vmlinux.o FORCE
> +       $(call if_changed,gen_ftrace_ool_stubs)
> +
> +targets +=3D vmlinux.arch.S


Makefile looks good to me.


> diff --git a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh b/arch/powerpc/to=
ols/ftrace-gen-ool-stubs.sh
> new file mode 100755
> index 000000000000..96e1ca5803e4
> --- /dev/null
> +++ b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
> @@ -0,0 +1,41 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# Error out on error
> +set -e
> +
> +is_64bit=3D"$1"
> +objdump=3D"$2"
> +vmlinux_o=3D"$3"
> +arch_vmlinux_S=3D"$4"
> +
> +RELOCATION=3DR_PPC64_ADDR64
> +if [ -z "$is_64bit" ]; then
> +       RELOCATION=3DR_PPC_ADDR32
> +fi
> +
> +num_ool_stubs_text=3D$($objdump -r -j __patchable_function_entries "$vml=
inux_o" |
> +                    grep -v ".init.text" | grep -c "$RELOCATION")
> +num_ool_stubs_inittext=3D$($objdump -r -j __patchable_function_entries "=
$vmlinux_o" |
> +                        grep ".init.text" | grep -c "$RELOCATION")
> +
> +cat > "$arch_vmlinux_S" <<EOF
> +#include <asm/asm-offsets.h>
> +#include <linux/linkage.h>
> +
> +.pushsection .tramp.ftrace.text,"aw"
> +SYM_DATA(ftrace_ool_stub_text_end_count, .long $num_ool_stubs_text)
> +
> +SYM_CODE_START(ftrace_ool_stub_text_end)
> +       .space $num_ool_stubs_text * FTRACE_OOL_STUB_SIZE
> +SYM_CODE_END(ftrace_ool_stub_text_end)
> +.popsection
> +
> +.pushsection .tramp.ftrace.init,"aw"
> +SYM_DATA(ftrace_ool_stub_inittext_count, .long $num_ool_stubs_inittext)
> +
> +SYM_CODE_START(ftrace_ool_stub_inittext)
> +       .space $num_ool_stubs_inittext * FTRACE_OOL_STUB_SIZE


To avoid the warning mention in another thread,
it is better to avoid zero .space.





> +SYM_CODE_END(ftrace_ool_stub_inittext)
> +.popsection
> +EOF
> --
> 2.47.0
>


--=20
Best Regards
Masahiro Yamada

