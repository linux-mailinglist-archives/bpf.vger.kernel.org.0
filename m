Return-Path: <bpf+bounces-43254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7459B1CAE
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 10:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474451C20AA5
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 09:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE07B126C03;
	Sun, 27 Oct 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfREm3sj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7344375;
	Sun, 27 Oct 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730020682; cv=none; b=cMF1K8m/J20Rez7bDDhQsn+NjZpDthJpfokwu6KUIWlb6G9IuPJX5/R6sZ7F97h+C3v5ZId2iPpKjjXt71JxJ5nKwaMQgdgAKMESSENtAIiQaO9nPQiRDwcRn/i5npfOE8G5eXjFU3gspEgLKE1G8VD19XN24BTpJoGuDJrUXBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730020682; c=relaxed/simple;
	bh=wMl5ogsPP3HaYzAA71sR/+7MhuF/bHx7cifoHX6Lhpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iX9U0VgXgLA2sZpHww4Ri1RFULumrDqV04nN9GccvSSxeOPmLhwOddWpDUSKWo3EV1oi2h18ycu2ncYDVXEO2EB31Sr+qcINXQrc/1uOP/hH65PY3mDCTTXxthwjNd8yBW+/L+hMthcnpy/46GiBvXGFaajXcjmft3ttuWhFaLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfREm3sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6EAC4CEEB;
	Sun, 27 Oct 2024 09:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730020681;
	bh=wMl5ogsPP3HaYzAA71sR/+7MhuF/bHx7cifoHX6Lhpw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mfREm3sjKpMRp8M6nwo7Va9YlI9zEtXUGQ/C+rZXzv1dKWqF+35VDhJcO1EIW3MrD
	 QKcnukxgwLoPmOat2nzsW9XFjyOmegIyshqxAWg+XG9QrW/Xdqplr40y3az8NvP2vr
	 yCRGIy/ASKp89ZGT9OAJGVhJalBbscroTriHekXI2wbRFjvuu3oNrLHdinLOM3xyAk
	 cComNa58idq8laRSUgPhB+SR9Dq2vfZHQCpNcePLgRHV+843tjW8tYUyj10ueumUlS
	 v1uDqipaHqZ+alIcp1CO5ZB3oAKf0SXWQeW461VFI+ksPHtZ6R9f5aSFzm+2vwalrR
	 y2mbAqph/lCHQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so30612761fa.3;
        Sun, 27 Oct 2024 02:18:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwrJRbUVUG0Y+mcobsxmzH38j8CA/FLI/YWCmePZzUjFHd1jRI321mDij88qXdvsEiD9OmQDtcph+D0Kqa@vger.kernel.org, AJvYcCVZ8Qusp1foHoNCa5lR+Z0emXvKEh6JLeEHTuckE39JWgxucHymL4J/y8ksdAGp8eMz4GyV74AMlFaqf6IZ@vger.kernel.org, AJvYcCVmGhOiVzXYo/Oz7qa9JWl9SRK3WbO/hmqguPwBkhRY9ndjVavcGenT+NJk0VlhOjMsjKQ=@vger.kernel.org, AJvYcCXAGK4OGhd0GDBtZNqSIayLMpao7L61z4Y4KreO2XjyZvkb/ijbNvv4nxAcFdA1NyshcBJy6hvUd71hkaZqF1c/doPH@vger.kernel.org
X-Gm-Message-State: AOJu0YzoXcCuCDkOGf62395MuR/aKTZ2zR4TAOYjkcZEMyAxS2Bmy3OT
	kcd9gio8FF7Ysnwgto7mM8NOpSQE1FvUf13L1sH9NESXzpHIOT8INOJ1VFJCnwAobnJ2h9NJovo
	9vZvkJ5f7k+USi7FTqvz/fB1O74w=
X-Google-Smtp-Source: AGHT+IFLZMUrsbbbZWhWxXI+738FWCeRLv7eFTf5IOnQ0WnMCDIgMvE2hwGHMIgOakmhhFiHh136Ial7L3KVUNCWCyw=
X-Received: by 2002:a2e:4619:0:b0:2fb:6057:e695 with SMTP id
 38308e7fff4ca-2fcbdfbb83cmr16431101fa.18.1730020679968; Sun, 27 Oct 2024
 02:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018173632.277333-1-hbathini@linux.ibm.com> <20241018173632.277333-14-hbathini@linux.ibm.com>
In-Reply-To: <20241018173632.277333-14-hbathini@linux.ibm.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 27 Oct 2024 18:17:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASMYLwjyHx+yx_+6uGSuSVNgPR3uX1QHAf1RyKrDhgTAQ@mail.gmail.com>
Message-ID: <CAK7LNASMYLwjyHx+yx_+6uGSuSVNgPR3uX1QHAf1RyKrDhgTAQ@mail.gmail.com>
Subject: Re: [PATCH v6 13/17] powerpc64/ftrace: Support .text larger than 32MB
 with out-of-line stubs
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
> We are restricted to a .text size of ~32MB when using out-of-line
> function profile sequence. Allow this to be extended up to the previous
> limit of ~64MB by reserving space in the middle of .text.
>
> A new config option CONFIG_PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE is
> introduced to specify the number of function stubs that are reserved in
> .text. On boot, ftrace utilizes stubs from this area first before using
> the stub area at the end of .text.
>
> A ppc64le defconfig has ~44k functions that can be traced. A more
> conservative value of 32k functions is chosen as the default value of
> PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE so that we do not allot more space
> than necessary by default. If building a kernel that only has 32k
> trace-able functions, we won't allot any more space at the end of .text
> during the pass on vmlinux.o. Otherwise, only the remaining functions
> get space for stubs at the end of .text. This default value should help
> cover a .text size of ~48MB in total (including space reserved at the
> end of .text which can cover up to 32MB), which should be sufficient for
> most common builds. For a very small kernel build, this can be set to 0.
> Or, this can be bumped up to a larger value to support vmlinux .text
> size up to ~64MB.
>
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>
> Changes in v6:
> * Updated with Masahiro's suggestions at
>   https://lore.kernel.org/all/CAK7LNAREkj5OQ_HA2H=3DiV_32qdOcaguCOBKV1j+d=
JW0YaQh3UA@mail.gmail.com/
>
>
>  arch/powerpc/Kconfig                       | 12 ++++++++++++
>  arch/powerpc/include/asm/ftrace.h          |  6 ++++--
>  arch/powerpc/kernel/trace/ftrace.c         | 21 +++++++++++++++++----
>  arch/powerpc/kernel/trace/ftrace_entry.S   |  8 ++++++++
>  arch/powerpc/tools/Makefile                |  3 ++-
>  arch/powerpc/tools/ftrace-gen-ool-stubs.sh | 19 +++++++++++++------
>  6 files changed, 56 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 26e3060e44f4..2e347f682c15 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -573,6 +573,18 @@ config PPC_FTRACE_OUT_OF_LINE
>         def_bool PPC64 && ARCH_USING_PATCHABLE_FUNCTION_ENTRY
>         select ARCH_WANTS_PRE_LINK_VMLINUX
>
> +config PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE
> +       int "Number of ftrace out-of-line stubs to reserve within .text"
> +       depends on PPC_FTRACE_OUT_OF_LINE
> +       default 32768
> +       help
> +         Number of stubs to reserve for use by ftrace. This space is
> +         reserved within .text, and is distinct from any additional spac=
e
> +         added at the end of .text before the final vmlinux link. Set to
> +         zero to have stubs only be generated at the end of vmlinux (onl=
y
> +         if the size of vmlinux is less than 32MB). Set to a higher valu=
e
> +         if building vmlinux larger than 48MB.
> +
>  config HOTPLUG_CPU
>         bool "Support for enabling/disabling CPUs"
>         depends on SMP && (PPC_PSERIES || \
> diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm=
/ftrace.h
> index bdbafc668b20..28f3590ca780 100644
> --- a/arch/powerpc/include/asm/ftrace.h
> +++ b/arch/powerpc/include/asm/ftrace.h
> @@ -138,8 +138,10 @@ extern unsigned int ftrace_tramp_text[], ftrace_tram=
p_init[];
>  struct ftrace_ool_stub {
>         u32     insn[4];
>  };
> -extern struct ftrace_ool_stub ftrace_ool_stub_text_end[], ftrace_ool_stu=
b_inittext[];
> -extern unsigned int ftrace_ool_stub_text_end_count, ftrace_ool_stub_init=
text_count;
> +extern struct ftrace_ool_stub ftrace_ool_stub_text_end[], ftrace_ool_stu=
b_text[],
> +                             ftrace_ool_stub_inittext[];
> +extern unsigned int ftrace_ool_stub_text_end_count, ftrace_ool_stub_text=
_count,
> +                   ftrace_ool_stub_inittext_count;
>  #endif
>  void ftrace_free_init_tramp(void);
>  unsigned long ftrace_call_adjust(unsigned long addr);
> diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/tra=
ce/ftrace.c
> index 1fee074388cc..bee2c54a8c04 100644
> --- a/arch/powerpc/kernel/trace/ftrace.c
> +++ b/arch/powerpc/kernel/trace/ftrace.c
> @@ -168,7 +168,7 @@ static int ftrace_get_call_inst(struct dyn_ftrace *re=
c, unsigned long addr, ppc_
>  static int ftrace_init_ool_stub(struct module *mod, struct dyn_ftrace *r=
ec)
>  {
>  #ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> -       static int ool_stub_text_end_index, ool_stub_inittext_index;
> +       static int ool_stub_text_index, ool_stub_text_end_index, ool_stub=
_inittext_index;
>         int ret =3D 0, ool_stub_count, *ool_stub_index;
>         ppc_inst_t inst;
>         /*
> @@ -191,9 +191,22 @@ static int ftrace_init_ool_stub(struct module *mod, =
struct dyn_ftrace *rec)
>                 ool_stub_index =3D &ool_stub_inittext_index;
>                 ool_stub_count =3D ftrace_ool_stub_inittext_count;
>         } else if (is_kernel_text(rec->ip)) {
> -               ool_stub =3D ftrace_ool_stub_text_end;
> -               ool_stub_index =3D &ool_stub_text_end_index;
> -               ool_stub_count =3D ftrace_ool_stub_text_end_count;
> +               /*
> +                * ftrace records are sorted, so we first use up the stub=
 area within .text
> +                * (ftrace_ool_stub_text) before using the area at the en=
d of .text
> +                * (ftrace_ool_stub_text_end), unless the stub is out of =
range of the record.
> +                */
> +               if (ool_stub_text_index >=3D ftrace_ool_stub_text_count |=
|
> +                   !is_offset_in_branch_range((long)rec->ip -
> +                                              (long)&ftrace_ool_stub_tex=
t[ool_stub_text_index])) {
> +                       ool_stub =3D ftrace_ool_stub_text_end;
> +                       ool_stub_index =3D &ool_stub_text_end_index;
> +                       ool_stub_count =3D ftrace_ool_stub_text_end_count=
;
> +               } else {
> +                       ool_stub =3D ftrace_ool_stub_text;
> +                       ool_stub_index =3D &ool_stub_text_index;
> +                       ool_stub_count =3D ftrace_ool_stub_text_count;
> +               }
>  #ifdef CONFIG_MODULES
>         } else if (mod) {
>                 ool_stub =3D mod->arch.ool_stubs;
> diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kern=
el/trace/ftrace_entry.S
> index 5b2fc6483dce..a6bf7f841040 100644
> --- a/arch/powerpc/kernel/trace/ftrace_entry.S
> +++ b/arch/powerpc/kernel/trace/ftrace_entry.S
> @@ -374,6 +374,14 @@ _GLOBAL(return_to_handler)
>         blr
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
>
> +#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +SYM_DATA(ftrace_ool_stub_text_count, .long CONFIG_PPC_FTRACE_OUT_OF_LINE=
_NUM_RESERVE)
> +
> +SYM_CODE_START(ftrace_ool_stub_text)
> +       .space CONFIG_PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE * FTRACE_OOL_STU=
B_SIZE
> +SYM_CODE_END(ftrace_ool_stub_text)
> +#endif
> +
>  .pushsection ".tramp.ftrace.text","aw",@progbits;
>  .globl ftrace_tramp_text
>  ftrace_tramp_text:
> diff --git a/arch/powerpc/tools/Makefile b/arch/powerpc/tools/Makefile
> index d2e7ecd5f46f..e1f7afcd9fdf 100644
> --- a/arch/powerpc/tools/Makefile
> +++ b/arch/powerpc/tools/Makefile
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>
>  quiet_cmd_gen_ftrace_ool_stubs =3D GEN     $@
> -      cmd_gen_ftrace_ool_stubs =3D $< "$(CONFIG_64BIT)" "$(OBJDUMP)" vml=
inux.o $@
> +       cmd_gen_ftrace_ool_stubs =3D $< "$(CONFIG_PPC_FTRACE_OUT_OF_LINE_=
NUM_RESERVE)" "$(CONFIG_64BIT)" \
> +                                  "$(OBJDUMP)" vmlinux.o $@
>
>  $(obj)/vmlinux.arch.S: $(src)/ftrace-gen-ool-stubs.sh vmlinux.o FORCE
>         $(call if_changed,gen_ftrace_ool_stubs)
> diff --git a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh b/arch/powerpc/to=
ols/ftrace-gen-ool-stubs.sh
> index 96e1ca5803e4..3ea0f23f2501 100755
> --- a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
> +++ b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
> @@ -4,10 +4,11 @@
>  # Error out on error
>  set -e
>
> -is_64bit=3D"$1"
> -objdump=3D"$2"
> -vmlinux_o=3D"$3"
> -arch_vmlinux_S=3D"$4"
> +num_ool_stubs_text_builtin=3D"$1"
> +is_64bit=3D"$2"
> +objdump=3D"$3"
> +vmlinux_o=3D"$4"
> +arch_vmlinux_S=3D"$5"
>
>  RELOCATION=3DR_PPC64_ADDR64
>  if [ -z "$is_64bit" ]; then
> @@ -19,15 +20,21 @@ num_ool_stubs_text=3D$($objdump -r -j __patchable_fun=
ction_entries "$vmlinux_o" |
>  num_ool_stubs_inittext=3D$($objdump -r -j __patchable_function_entries "=
$vmlinux_o" |
>                          grep ".init.text" | grep -c "$RELOCATION")
>
> +if [ "$num_ool_stubs_text" -gt "$num_ool_stubs_text_builtin" ]; then
> +       num_ool_stubs_text_end=3D$((num_ool_stubs_text - num_ool_stubs_te=
xt_builtin))
> +else
> +       num_ool_stubs_text_end=3D0
> +fi
> +
>  cat > "$arch_vmlinux_S" <<EOF
>  #include <asm/asm-offsets.h>
>  #include <linux/linkage.h>
>
>  .pushsection .tramp.ftrace.text,"aw"
> -SYM_DATA(ftrace_ool_stub_text_end_count, .long $num_ool_stubs_text)
> +SYM_DATA(ftrace_ool_stub_text_end_count, .long $num_ool_stubs_text_end)
>
>  SYM_CODE_START(ftrace_ool_stub_text_end)
> -       .space $num_ool_stubs_text * FTRACE_OOL_STUB_SIZE
> +       .space $num_ool_stubs_text_end * FTRACE_OOL_STUB_SIZE
>  SYM_CODE_END(ftrace_ool_stub_text_end)
>  .popsection


I got this warning:

  GEN     arch/powerpc/tools/vmlinux.arch.S
  AS      arch/powerpc/tools/vmlinux.arch.o
arch/powerpc/tools/vmlinux.arch.S: Assembler messages:
arch/powerpc/tools/vmlinux.arch.S:9: Warning: .space repeat count is
zero, ignored



--=20
Best Regards
Masahiro Yamada

