Return-Path: <bpf+bounces-38132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB84960546
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6683CB22649
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF5819ADBE;
	Tue, 27 Aug 2024 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrA01tKR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249D9199EB4;
	Tue, 27 Aug 2024 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749981; cv=none; b=jte9quJVsp933lupLzg6TKK6wTCFI2lab8RbjXchjhJmO6SIsiKeDEwr7QkWGuR1aFlDq9yVAaEw0tFzGc5QyuwSEq2q9e/07IkVNL1miScBBZc5XxlYQuWKEag8uHntYZkEns2c1v6bO/OKAj58Tkemsmd8r2/7SKabd8zNo9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749981; c=relaxed/simple;
	bh=JxBQoVGyG+qnPOwGjG78VRBfznoWP5yyUz2/W3rfI0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzJSAna4S1vyrGJoZFU6tj1eqG3oNx2jKXXF0Bz4ueQn8fU7w+xECrwtQF/zWwhllGKT2dKdxb33wi+cEOSEfptKRffq1Y5HYQqY9+b1bLOkWIEGjthfVlX04rqIgPJqBKcoitCm2iIcEtfY6vtL7rkFijjzfeLvQeCkgnP43c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrA01tKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C54C8B7A0;
	Tue, 27 Aug 2024 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724749980;
	bh=JxBQoVGyG+qnPOwGjG78VRBfznoWP5yyUz2/W3rfI0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PrA01tKRAv67667BhlYHwLAguaIpMvgYRwoz9RHhkkU4fdYgs3z1puwLLFt4z1yBy
	 upl6LRUGvlrtoGBB5IcTtB1SIWyk4uf34i3TaDnu7ViPYAmhlkvfoGspCTH3Kkt1OZ
	 /O1QYNB/5dewc14K70kKCELmMILYtHplTFZysZa8OvWZ9Et+lGPSOmRBAUbQ+RDXjS
	 5BCOahxLoEdHRh+qcvbmct22T/FUwQfssUtUREWQhhj7F8TTtmUpQmPOogWPiBWftb
	 mzQhUYovXDdNpWHvgNcGM7uqCprn3YOGPUuoQ0i32h9aS6WJAuIGs9lrdIi8fgVO5T
	 IlFDEbRg2r/zw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5334adf7249so6178305e87.3;
        Tue, 27 Aug 2024 02:13:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVAbX9lsIv1lWiBExJjnd6p+Fm/xDCvIa63Lxbzya2bifptI6PEVrq1kGHGrvvgc3FRtuDAH2LQJvLHhTW@vger.kernel.org, AJvYcCV9aDeWd7W1U4BINQtPVJiP1coMiuA+Jg+zWNxVFbPcxr/VniG2/5Phf8sn+3Z/GzrUcOppJEp4E33R/7xym3tghvR8@vger.kernel.org, AJvYcCWTsmHWpseRpyxmc1ImHFt7DAfWZIjRdtnkY9Pjb8LA6yEggEWGkzhs6BLcicPBxnT6nIc=@vger.kernel.org, AJvYcCXP7Zzl5nl8vApT3xvCTKhH+Z4cC+lvga2YYFDgcrIehMM2DEpSkCJWAfwYpAQKR9x/LAI0kwkFRHLymenY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj+nfU5WN2Tqz8Mx8wzRyGUoNIOTRkd2JHylMG1gqs4IOFT0EL
	S/yGcXfs6eIGe+jyDGSlBYKsgaqlv6p8TZ1NU3nYh2NUg3/Sh/2MUYnfvcJ1VpAOELT/HXttejX
	tVrETHuYQuwSs9PSXsAk2GnQZPtQ=
X-Google-Smtp-Source: AGHT+IFpCvVGtqFkt0e1lRXvFIGTnLGle1JtCtNw8SoAQ03bNvZsLp6/AZo8+h9NMyIwcFL6WJlC0PGYw5oMpoctElo=
X-Received: by 2002:a05:6512:2c8a:b0:52c:e0e1:9ae3 with SMTP id
 2adb3069b0e04-5344e500a1fmr1501367e87.57.1724749979251; Tue, 27 Aug 2024
 02:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720942106.git.naveen@kernel.org> <9cf2cdddba74ec167ae1af5ec189bba8f704fb51.1720942106.git.naveen@kernel.org>
In-Reply-To: <9cf2cdddba74ec167ae1af5ec189bba8f704fb51.1720942106.git.naveen@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 27 Aug 2024 18:12:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQV+B=Jx1o3j3YkVL6CuTz5uPUnS+340KGA7aKs2eLxXw@mail.gmail.com>
Message-ID: <CAK7LNAQV+B=Jx1o3j3YkVL6CuTz5uPUnS+340KGA7aKs2eLxXw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 12/17] powerpc64/ftrace: Move ftrace sequence out
 of line
To: Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, 
	Vishal Chourasia <vishalc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 5:29=E2=80=AFPM Naveen N Rao <naveen@kernel.org> wr=
ote:
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
> Signed-off-by: Naveen N Rao <naveen@kernel.org>



> diff --git a/arch/powerpc/tools/Makefile b/arch/powerpc/tools/Makefile
> new file mode 100644
> index 000000000000..31dd3151c272
> --- /dev/null
> +++ b/arch/powerpc/tools/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +quiet_cmd_gen_ftrace_ool_stubs =3D FTRACE  $@


This is not "FTRACE".

"GEN" or something like that.



> +      cmd_gen_ftrace_ool_stubs =3D $< $(objtree)/vmlinux.o $@
> +
> +targets +=3D .arch.vmlinux.o
> +.arch.vmlinux.o: $(srctree)/arch/powerpc/tools/ftrace-gen-ool-stubs.sh $=
(objtree)/vmlinux.o FORCE
> +       $(call if_changed,gen_ftrace_ool_stubs)
> +
> +clean-files +=3D $(objtree)/.arch.vmlinux.S $(objtree)/.arch.vmlinux.o



This is wrong. $(objtree) is always '.'

It will attempt to clean up:

arch/powerpc/tools/.arch.vmlinux.S
arch/powerpc/tools/.arch.vmlinux.o



You must not create the intermediate file,
.arch.vmlinux.S at the top directory because
this build step is pretty much PowerPC-specific.


Rather, I'd recommend to create *.S and *.o in
arch/powerpc/tools/:

arch/powerpc/tools/vmlinux.S
arch/powerpc/tools/vmlinux.o




When you submit the next version, please run 'make clean'
and confirm that any powerpc-specific build artifacts
not being left-over.






> diff --git a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh b/arch/powerpc/to=
ols/ftrace-gen-ool-stubs.sh
> new file mode 100755
> index 000000000000..0b85cd5262ff
> --- /dev/null
> +++ b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
> @@ -0,0 +1,48 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# Error out on error
> +set -e
> +
> +is_enabled() {
> +       grep -q "^$1=3Dy" include/config/auto.conf
> +}
> +
> +vmlinux_o=3D${1}
> +arch_vmlinux_o=3D${2}
> +arch_vmlinux_S=3D$(dirname ${arch_vmlinux_o})/$(basename ${arch_vmlinux_=
o} .o).S
> +
> +RELOCATION=3DR_PPC64_ADDR64
> +if is_enabled CONFIG_PPC32; then
> +       RELOCATION=3DR_PPC_ADDR32
> +fi
> +
> +num_ool_stubs_text=3D$(${CROSS_COMPILE}objdump -r -j __patchable_functio=
n_entries ${vmlinux_o} |
> +                    grep -v ".init.text" | grep "${RELOCATION}" | wc -l)
> +num_ool_stubs_inittext=3D$(${CROSS_COMPILE}objdump -r -j __patchable_fun=
ction_entries ${vmlinux_o} |
> +                        grep ".init.text" | grep "${RELOCATION}" | wc -l=
)
> +
> +cat > ${arch_vmlinux_S} <<EOF
> +#include <asm/asm-offsets.h>
> +#include <linux/linkage.h>
> +
> +.pushsection .tramp.ftrace.text,"aw"
> +SYM_DATA(ftrace_ool_stub_text_end_count, .long ${num_ool_stubs_text})
> +
> +SYM_CODE_START(ftrace_ool_stub_text_end)
> +       .space ${num_ool_stubs_text} * FTRACE_OOL_STUB_SIZE
> +SYM_CODE_END(ftrace_ool_stub_text_end)
> +.popsection
> +
> +.pushsection .tramp.ftrace.init,"aw"
> +SYM_DATA(ftrace_ool_stub_inittext_count, .long ${num_ool_stubs_inittext}=
)
> +
> +SYM_CODE_START(ftrace_ool_stub_inittext)
> +       .space ${num_ool_stubs_inittext} * FTRACE_OOL_STUB_SIZE
> +SYM_CODE_END(ftrace_ool_stub_inittext)
> +.popsection
> +EOF
> +
> +${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
> +      ${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL} \
> +      -c -o ${arch_vmlinux_o} ${arch_vmlinux_S}


Please do not compile this within a shell script.

scripts/Makefile.build provides rule_as_o_S to do this.




[1] vmlinux.o --> arch/powerpc/tools/vmlinux.S

[2] arch/powerpc/tools/vmlinux.S --> arch/powerpc/tools/vmlinux.o


Please split these in separate build rules.





> --
> 2.45.2
>


--
Best Regards
Masahiro Yamada

