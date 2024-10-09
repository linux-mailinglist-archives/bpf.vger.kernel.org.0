Return-Path: <bpf+bounces-41439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1805B997044
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5DF1C228B8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3096D1F1318;
	Wed,  9 Oct 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sH7yKv9g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A285A1DED7E;
	Wed,  9 Oct 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488188; cv=none; b=tkHUMMyrM6WUsn44H3Q68zuya9o363GwI+DnDgTY0dQW/7aSJHqN2MQd3AGoGWz2qcEEBHZRwZaWYZ+x8GQBr78yJDZgzyneV2UEuVmAiXjmDuAjJkwSs+sLUchbfljnLRmpWRccsFUPM+s7qUUBkvhvuFZSGXZKa3z6QP6J3vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488188; c=relaxed/simple;
	bh=vaZ44Wl5JOxdy9oFJLJJAL9x0vbfCzi/eHgAZB/ESzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIhpxiDvAVtMtJH5CSKiVy+HXVLa9bB7uPNY9uOgzYPl/u4Qa6k0Swwr4HwcLUDzjenjaZaS/9dOARlCbpkbx5na+Ns/Czicyndc8+36CTJbwmcRV50ai5BDmPPjaGLevX6OtWXEUklhqnzY96uwSfiS4Rd8kI22s1M95vZ2Ezk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sH7yKv9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE908C4CEDC;
	Wed,  9 Oct 2024 15:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728488187;
	bh=vaZ44Wl5JOxdy9oFJLJJAL9x0vbfCzi/eHgAZB/ESzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sH7yKv9gGg5b1qdXLhLVGoAm4zHeomfkVd+znM0uQqyDqnhGSstUUqpoWKa/XdeEG
	 pQ61ia4cQGz6+ocMXLuPHJzn6NxmcRymhmBpFVY6rKp2ZlfmsiuUjzSWb3sS0SXzJK
	 t6X0rqh8Tq8T3OVU1UmjBomv95oCDcwKfrGV04vBiaCultUMfSO8pQ/YImQSQeS8tN
	 +ZoqvsmHwshdEqdWkN5jFKtsd7bCAQu5+slv4bJVRFpfAEHyr/uH/BO5O5O7NULKAo
	 HqTQCrG9liEtAv61ON++e0FBZ4kh1HStAdKNFoopwz/KtJEcnWL1G1rTykltWe8C6H
	 6xnPSCxADIAhg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fadc95ccfcso78566771fa.1;
        Wed, 09 Oct 2024 08:36:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxQ7Ruw/V19HsU61wfosfc0O42VK2HcIC1YhfGGNcGOlGK3Tnn5F09HsB2/FYknjlmTBzRbxSmegsEBm+3@vger.kernel.org, AJvYcCV5vJD/t8Nc1hKz7yYdf9LxL0c9xtI8XlxTPsqByWWio10B+I5gr97d26x1YXYf6q/4YpwgZgUaRd1YfU/lr8KgAcJy@vger.kernel.org, AJvYcCWHDq7Z3vmx0c2y5+I4a0TO5uBm3unywOJhiPcIP5c2PJTAU5TUO7f9KXFE25zndzmv3B0=@vger.kernel.org, AJvYcCWlU6NEJ6cv6LC+4cX7ppXXapMCWpAbbDsiiFDkd1nvcMyZdwYshxeWZpmNPajiKxLfSIY4306TYgxBYn7a@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3B1xtwsFlB+r5htMi9sSIuICm7GpmqblLASUu/Vhz++0AYS9L
	egLaDQq065jb5nAdFbtray9c3lFY4hRwv9B99CEDLjcywc5s30LHehvwWAZWw32Xsyb6xEaJI2N
	rISRKeGQbqwwQ6XX4fEPzu2lTYVA=
X-Google-Smtp-Source: AGHT+IElFccJ5/ibv1H6OlgQtd1WTyaW95bZIhoLK7e9L+c/Y+bcUY1pXEMVt/JPrDI7BZ0UHCs7Qik2Uagj0p70f5A=
X-Received: by 2002:a05:651c:546:b0:2f7:52c5:b67 with SMTP id
 38308e7fff4ca-2fb187cdd05mr18043231fa.29.1728488185194; Wed, 09 Oct 2024
 08:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915205648.830121-1-hbathini@linux.ibm.com> <20240915205648.830121-13-hbathini@linux.ibm.com>
In-Reply-To: <20240915205648.830121-13-hbathini@linux.ibm.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 10 Oct 2024 00:35:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAgEdtt0X3QhR9jKC3EXUqFqU4YVxm8qT9E2H7K7rq8Q@mail.gmail.com>
Message-ID: <CAK7LNATAgEdtt0X3QhR9jKC3EXUqFqU4YVxm8qT9E2H7K7rq8Q@mail.gmail.com>
Subject: Re: [PATCH v5 12/17] powerpc64/ftrace: Move ftrace sequence out of line
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Naveen N. Rao" <naveen@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nicholas Piggin <npiggin@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Vishal Chourasia <vishalc@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 5:58=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.co=
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
>
> Changes in v5:
> * Fixed ftrace stack tracer failure due to inadvertent use of
>   'add r7, r3, MCOUNT_INSN_SIZE' instruction instead of
>   'addi r7, r3, MCOUNT_INSN_SIZE'
> * Fixed build error for !CONFIG_MODULES case.
> * .vmlinux.arch.* files compiled under arch/powerpc/tools
> * Made sure .vmlinux.arch.* files are cleaned with `make clean`
>
>
>  arch/powerpc/Kbuild                        |   2 +-
>  arch/powerpc/Kconfig                       |   5 +
>  arch/powerpc/Makefile                      |   4 +
>  arch/powerpc/include/asm/ftrace.h          |  11 ++
>  arch/powerpc/include/asm/module.h          |   5 +
>  arch/powerpc/kernel/asm-offsets.c          |   4 +
>  arch/powerpc/kernel/module_64.c            |  58 +++++++-
>  arch/powerpc/kernel/trace/ftrace.c         | 162 +++++++++++++++++++--
>  arch/powerpc/kernel/trace/ftrace_entry.S   | 116 +++++++++++----
>  arch/powerpc/tools/Makefile                |  12 ++
>  arch/powerpc/tools/ftrace-gen-ool-stubs.sh |  43 ++++++
>  11 files changed, 384 insertions(+), 38 deletions(-)
>  create mode 100644 arch/powerpc/tools/Makefile
>  create mode 100755 arch/powerpc/tools/ftrace-gen-ool-stubs.sh
>
> diff --git a/arch/powerpc/Kbuild b/arch/powerpc/Kbuild
> index 571f260b0842..b010ccb071b6 100644
> --- a/arch/powerpc/Kbuild
> +++ b/arch/powerpc/Kbuild
> @@ -19,4 +19,4 @@ obj-$(CONFIG_KEXEC_CORE)  +=3D kexec/
>  obj-$(CONFIG_KEXEC_FILE)  +=3D purgatory/
>
>  # for cleaning
> -subdir- +=3D boot
> +subdir- +=3D boot tools
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index de18f3baff66..bae96b65f295 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -568,6 +568,11 @@ config ARCH_USING_PATCHABLE_FUNCTION_ENTRY
>         def_bool $(success,$(srctree)/arch/powerpc/tools/gcc-check-fpatch=
able-function-entry.sh $(CC) -mlittle-endian) if PPC64 && CPU_LITTLE_ENDIAN
>         def_bool $(success,$(srctree)/arch/powerpc/tools/gcc-check-fpatch=
able-function-entry.sh $(CC) -mbig-endian) if PPC64 && CPU_BIG_ENDIAN
>
> +config PPC_FTRACE_OUT_OF_LINE
> +       def_bool PPC64 && ARCH_USING_PATCHABLE_FUNCTION_ENTRY
> +       depends on PPC64

PPC64 appears twice here. It is redundant.

If this config entry is user-unconfigurable,
"def_bool PPC64 && ARCH_USING_PATCHABLE_FUNCTION_ENTRY" is enough.

"depends on PPC64" is unneeded.









> +       select ARCH_WANTS_PRE_LINK_VMLINUX
> +
>  config HOTPLUG_CPU
>         bool "Support for enabling/disabling CPUs"
>         depends on SMP && (PPC_PSERIES || \
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index bbfe4a1f06ef..c973e6cd1ae8 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -155,7 +155,11 @@ CC_FLAGS_NO_FPU            :=3D $(call cc-option,-ms=
oft-float)
>  ifdef CONFIG_FUNCTION_TRACER
>  ifdef CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY
>  KBUILD_CPPFLAGS        +=3D -DCC_USING_PATCHABLE_FUNCTION_ENTRY
> +ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D1
> +else
>  CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D2
> +endif
>  else
>  CC_FLAGS_FTRACE :=3D -pg
>  ifdef CONFIG_MPROFILE_KERNEL
> diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm=
/ftrace.h
> index 278d4548e8f1..bdbafc668b20 100644
> --- a/arch/powerpc/include/asm/ftrace.h
> +++ b/arch/powerpc/include/asm/ftrace.h
> @@ -24,6 +24,10 @@ unsigned long prepare_ftrace_return(unsigned long pare=
nt, unsigned long ip,
>  struct module;
>  struct dyn_ftrace;
>  struct dyn_arch_ftrace {
> +#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +       /* pointer to the associated out-of-line stub */
> +       unsigned long ool_stub;
> +#endif
>  };
>
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> @@ -130,6 +134,13 @@ static inline u8 this_cpu_get_ftrace_enabled(void) {=
 return 1; }
>
>  #ifdef CONFIG_FUNCTION_TRACER
>  extern unsigned int ftrace_tramp_text[], ftrace_tramp_init[];
> +#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +struct ftrace_ool_stub {
> +       u32     insn[4];
> +};
> +extern struct ftrace_ool_stub ftrace_ool_stub_text_end[], ftrace_ool_stu=
b_inittext[];
> +extern unsigned int ftrace_ool_stub_text_end_count, ftrace_ool_stub_init=
text_count;
> +#endif
>  void ftrace_free_init_tramp(void);
>  unsigned long ftrace_call_adjust(unsigned long addr);
>  #else
> diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm=
/module.h
> index 300c777cc307..9ee70a4a0fde 100644
> --- a/arch/powerpc/include/asm/module.h
> +++ b/arch/powerpc/include/asm/module.h
> @@ -47,6 +47,11 @@ struct mod_arch_specific {
>  #ifdef CONFIG_DYNAMIC_FTRACE
>         unsigned long tramp;
>         unsigned long tramp_regs;
> +#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +       struct ftrace_ool_stub *ool_stubs;
> +       unsigned int ool_stub_count;
> +       unsigned int ool_stub_index;
> +#endif
>  #endif
>  };
>
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-=
offsets.c
> index 23733282de4d..6854547d3164 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -674,5 +674,9 @@ int main(void)
>         DEFINE(BPT_SIZE, BPT_SIZE);
>  #endif
>
> +#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +       DEFINE(FTRACE_OOL_STUB_SIZE, sizeof(struct ftrace_ool_stub));
> +#endif
> +
>         return 0;
>  }
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module=
_64.c
> index 1db88409bd95..6816e9967cab 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -205,7 +205,9 @@ static int relacmp(const void *_x, const void *_y)
>
>  /* Get size of potential trampolines required. */
>  static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
> -                                   const Elf64_Shdr *sechdrs)
> +                                   const Elf64_Shdr *sechdrs,
> +                                   char *secstrings,
> +                                   struct module *me)
>  {
>         /* One extra reloc so it's always 0-addr terminated */
>         unsigned long relocs =3D 1;
> @@ -244,6 +246,24 @@ static unsigned long get_stubs_size(const Elf64_Ehdr=
 *hdr,
>         /* stubs for ftrace_caller and ftrace_regs_caller */
>         relocs +=3D IS_ENABLED(CONFIG_DYNAMIC_FTRACE) + IS_ENABLED(CONFIG=
_DYNAMIC_FTRACE_WITH_REGS);
>
> +#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +       /* stubs for the function tracer */
> +       for (i =3D 1; i < hdr->e_shnum; i++) {
> +               if (!strcmp(secstrings + sechdrs[i].sh_name, "__patchable=
_function_entries")) {
> +                       me->arch.ool_stub_count =3D sechdrs[i].sh_size / =
sizeof(unsigned long);
> +                       me->arch.ool_stub_index =3D 0;
> +                       relocs +=3D roundup(me->arch.ool_stub_count * siz=
eof(struct ftrace_ool_stub),
> +                                         sizeof(struct ppc64_stub_entry)=
) /
> +                                 sizeof(struct ppc64_stub_entry);
> +                       break;
> +               }
> +       }
> +       if (i =3D=3D hdr->e_shnum) {
> +               pr_err("%s: doesn't contain __patchable_function_entries.=
\n", me->name);
> +               return -ENOEXEC;
> +       }
> +#endif
> +
>         pr_debug("Looks like a total of %lu stubs, max\n", relocs);
>         return relocs * sizeof(struct ppc64_stub_entry);
>  }
> @@ -454,7 +474,7 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
>  #endif
>
>         /* Override the stubs size */
> -       sechdrs[me->arch.stubs_section].sh_size =3D get_stubs_size(hdr, s=
echdrs);
> +       sechdrs[me->arch.stubs_section].sh_size =3D get_stubs_size(hdr, s=
echdrs, secstrings, me);
>
>         return 0;
>  }
> @@ -1079,6 +1099,37 @@ int module_trampoline_target(struct module *mod, u=
nsigned long addr,
>         return 0;
>  }
>
> +static int setup_ftrace_ool_stubs(const Elf64_Shdr *sechdrs, unsigned lo=
ng addr, struct module *me)
> +{
> +#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +       unsigned int i, total_stubs, num_stubs;
> +       struct ppc64_stub_entry *stub;
> +
> +       total_stubs =3D sechdrs[me->arch.stubs_section].sh_size / sizeof(=
*stub);
> +       num_stubs =3D roundup(me->arch.ool_stub_count * sizeof(struct ftr=
ace_ool_stub),
> +                           sizeof(struct ppc64_stub_entry)) / sizeof(str=
uct ppc64_stub_entry);
> +
> +       /* Find the next available entry */
> +       stub =3D (void *)sechdrs[me->arch.stubs_section].sh_addr;
> +       for (i =3D 0; stub_func_addr(stub[i].funcdata); i++)
> +               if (WARN_ON(i >=3D total_stubs))
> +                       return -1;
> +
> +       if (WARN_ON(i + num_stubs > total_stubs))
> +               return -1;
> +
> +       stub +=3D i;
> +       me->arch.ool_stubs =3D (struct ftrace_ool_stub *)stub;
> +
> +       /* reserve stubs */
> +       for (i =3D 0; i < num_stubs; i++)
> +               if (patch_u32((void *)&stub->funcdata, PPC_RAW_NOP()))
> +                       return -1;
> +#endif
> +
> +       return 0;
> +}
> +
>  int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sechdrs)
>  {
>         mod->arch.tramp =3D stub_for_addr(sechdrs,
> @@ -1097,6 +1148,9 @@ int module_finalize_ftrace(struct module *mod, cons=
t Elf_Shdr *sechdrs)
>         if (!mod->arch.tramp)
>                 return -ENOENT;
>
> +       if (setup_ftrace_ool_stubs(sechdrs, mod->arch.tramp, mod))
> +               return -ENOENT;
> +
>         return 0;
>  }
>  #endif
> diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/tra=
ce/ftrace.c
> index 719517265d39..1fee074388cc 100644
> --- a/arch/powerpc/kernel/trace/ftrace.c
> +++ b/arch/powerpc/kernel/trace/ftrace.c
> @@ -37,7 +37,8 @@ unsigned long ftrace_call_adjust(unsigned long addr)
>         if (addr >=3D (unsigned long)__exittext_begin && addr < (unsigned=
 long)__exittext_end)
>                 return 0;
>
> -       if (IS_ENABLED(CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY))
> +       if (IS_ENABLED(CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY) &&
> +           !IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE))
>                 addr +=3D MCOUNT_INSN_SIZE;
>
>         return addr;
> @@ -127,11 +128,25 @@ static unsigned long ftrace_lookup_module_stub(unsi=
gned long ip, unsigned long a
>  }
>  #endif
>
> +static unsigned long ftrace_get_ool_stub(struct dyn_ftrace *rec)
> +{
> +#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +       return rec->arch.ool_stub;
> +#else
> +       BUILD_BUG();
> +#endif
> +}
> +
>  static int ftrace_get_call_inst(struct dyn_ftrace *rec, unsigned long ad=
dr, ppc_inst_t *call_inst)
>  {
> -       unsigned long ip =3D rec->ip;
> +       unsigned long ip;
>         unsigned long stub;
>
> +       if (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE))
> +               ip =3D ftrace_get_ool_stub(rec) + MCOUNT_INSN_SIZE; /* se=
cond instruction in stub */
> +       else
> +               ip =3D rec->ip;
> +
>         if (is_offset_in_branch_range(addr - ip))
>                 /* Within range */
>                 stub =3D addr;
> @@ -142,7 +157,7 @@ static int ftrace_get_call_inst(struct dyn_ftrace *re=
c, unsigned long addr, ppc_
>                 stub =3D ftrace_lookup_module_stub(ip, addr);
>
>         if (!stub) {
> -               pr_err("0x%lx: No ftrace stubs reachable\n", ip);
> +               pr_err("0x%lx (0x%lx): No ftrace stubs reachable\n", ip, =
rec->ip);
>                 return -EINVAL;
>         }
>
> @@ -150,6 +165,92 @@ static int ftrace_get_call_inst(struct dyn_ftrace *r=
ec, unsigned long addr, ppc_
>         return 0;
>  }
>
> +static int ftrace_init_ool_stub(struct module *mod, struct dyn_ftrace *r=
ec)
> +{
> +#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +       static int ool_stub_text_end_index, ool_stub_inittext_index;
> +       int ret =3D 0, ool_stub_count, *ool_stub_index;
> +       ppc_inst_t inst;
> +       /*
> +        * See ftrace_entry.S if changing the below instruction sequence,=
 as we rely on
> +        * decoding the last branch instruction here to recover the corre=
ct function ip.
> +        */
> +       struct ftrace_ool_stub *ool_stub, ool_stub_template =3D {
> +               .insn =3D {
> +                       PPC_RAW_MFLR(_R0),
> +                       PPC_RAW_NOP(),          /* bl ftrace_caller */
> +                       PPC_RAW_MTLR(_R0),
> +                       PPC_RAW_NOP()           /* b rec->ip + 4 */
> +               }
> +       };
> +
> +       WARN_ON(rec->arch.ool_stub);
> +
> +       if (is_kernel_inittext(rec->ip)) {
> +               ool_stub =3D ftrace_ool_stub_inittext;
> +               ool_stub_index =3D &ool_stub_inittext_index;
> +               ool_stub_count =3D ftrace_ool_stub_inittext_count;
> +       } else if (is_kernel_text(rec->ip)) {
> +               ool_stub =3D ftrace_ool_stub_text_end;
> +               ool_stub_index =3D &ool_stub_text_end_index;
> +               ool_stub_count =3D ftrace_ool_stub_text_end_count;
> +#ifdef CONFIG_MODULES
> +       } else if (mod) {
> +               ool_stub =3D mod->arch.ool_stubs;
> +               ool_stub_index =3D &mod->arch.ool_stub_index;
> +               ool_stub_count =3D mod->arch.ool_stub_count;
> +#endif
> +       } else {
> +               return -EINVAL;
> +       }
> +
> +       ool_stub +=3D (*ool_stub_index)++;
> +
> +       if (WARN_ON(*ool_stub_index > ool_stub_count))
> +               return -EINVAL;
> +
> +       if (!is_offset_in_branch_range((long)rec->ip - (long)&ool_stub->i=
nsn[0]) ||
> +           !is_offset_in_branch_range((long)(rec->ip + MCOUNT_INSN_SIZE)=
 -
> +                                      (long)&ool_stub->insn[3])) {
> +               pr_err("%s: ftrace ool stub out of range (%p -> %p).\n",
> +                                       __func__, (void *)rec->ip, (void =
*)&ool_stub->insn[0]);
> +               return -EINVAL;
> +       }
> +
> +       rec->arch.ool_stub =3D (unsigned long)&ool_stub->insn[0];
> +
> +       /* bl ftrace_caller */
> +       if (!mod)
> +               ret =3D ftrace_get_call_inst(rec, (unsigned long)ftrace_c=
aller, &inst);
> +#ifdef CONFIG_MODULES
> +       else
> +               /*
> +                * We can't use ftrace_get_call_inst() since that uses
> +                * __module_text_address(rec->ip) to look up the module.
> +                * But, since the module is not fully formed at this stag=
e,
> +                * the lookup fails. We know the target though, so genera=
te
> +                * the branch inst directly.
> +                */
> +               inst =3D ftrace_create_branch_inst(ftrace_get_ool_stub(re=
c) + MCOUNT_INSN_SIZE,
> +                                                mod->arch.tramp, 1);
> +#endif
> +       ool_stub_template.insn[1] =3D ppc_inst_val(inst);
> +
> +       /* b rec->ip + 4 */
> +       if (!ret && create_branch(&inst, &ool_stub->insn[3], rec->ip + MC=
OUNT_INSN_SIZE, 0))
> +               return -EINVAL;
> +       ool_stub_template.insn[3] =3D ppc_inst_val(inst);
> +
> +       if (!ret)
> +               ret =3D patch_instructions((u32 *)ool_stub, (u32 *)&ool_s=
tub_template,
> +                                        sizeof(ool_stub_template), false=
);
> +
> +       return ret;
> +#else /* !CONFIG_PPC_FTRACE_OUT_OF_LINE */
> +       BUILD_BUG();
> +#endif
> +}
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr, u=
nsigned long addr)
>  {
> @@ -162,18 +263,29 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsi=
gned long old_addr, unsigned
>  int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  {
>         ppc_inst_t old, new;
> -       int ret;
> +       unsigned long ip =3D rec->ip;
> +       int ret =3D 0;
>
>         /* This can only ever be called during module load */
> -       if (WARN_ON(!IS_ENABLED(CONFIG_MODULES) || core_kernel_text(rec->=
ip)))
> +       if (WARN_ON(!IS_ENABLED(CONFIG_MODULES) || core_kernel_text(ip)))
>                 return -EINVAL;
>
>         old =3D ppc_inst(PPC_RAW_NOP());
> -       ret =3D ftrace_get_call_inst(rec, addr, &new);
> -       if (ret)
> -               return ret;
> +       if (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE)) {
> +               ip =3D ftrace_get_ool_stub(rec) + MCOUNT_INSN_SIZE; /* se=
cond instruction in stub */
> +               ret =3D ftrace_get_call_inst(rec, (unsigned long)ftrace_c=
aller, &old);
> +       }
> +
> +       ret |=3D ftrace_get_call_inst(rec, addr, &new);
> +
> +       if (!ret)
> +               ret =3D ftrace_modify_code(ip, old, new);
>
> -       return ftrace_modify_code(rec->ip, old, new);
> +       if (!ret && IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE))
> +               ret =3D ftrace_modify_code(rec->ip, ppc_inst(PPC_RAW_NOP(=
)),
> +                        ppc_inst(PPC_RAW_BRANCH((long)ftrace_get_ool_stu=
b(rec) - (long)rec->ip)));
> +
> +       return ret;
>  }
>
>  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned=
 long addr)
> @@ -206,6 +318,13 @@ void ftrace_replace_code(int enable)
>                 new_addr =3D ftrace_get_addr_new(rec);
>                 update =3D ftrace_update_record(rec, enable);
>
> +               if (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) && update !=
=3D FTRACE_UPDATE_IGNORE) {
> +                       ip =3D ftrace_get_ool_stub(rec) + MCOUNT_INSN_SIZ=
E;
> +                       ret =3D ftrace_get_call_inst(rec, (unsigned long)=
ftrace_caller, &nop_inst);
> +                       if (ret)
> +                               goto out;
> +               }
> +
>                 switch (update) {
>                 case FTRACE_UPDATE_IGNORE:
>                 default:
> @@ -230,6 +349,24 @@ void ftrace_replace_code(int enable)
>
>                 if (!ret)
>                         ret =3D ftrace_modify_code(ip, old, new);
> +
> +               if (!ret && IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) &&
> +                   (update =3D=3D FTRACE_UPDATE_MAKE_NOP || update =3D=
=3D FTRACE_UPDATE_MAKE_CALL)) {
> +                       /* Update the actual ftrace location */
> +                       call_inst =3D ppc_inst(PPC_RAW_BRANCH((long)ftrac=
e_get_ool_stub(rec) -
> +                                                           (long)rec->ip=
));
> +                       nop_inst =3D ppc_inst(PPC_RAW_NOP());
> +                       ip =3D rec->ip;
> +
> +                       if (update =3D=3D FTRACE_UPDATE_MAKE_NOP)
> +                               ret =3D ftrace_modify_code(ip, call_inst,=
 nop_inst);
> +                       else
> +                               ret =3D ftrace_modify_code(ip, nop_inst, =
call_inst);
> +
> +                       if (ret)
> +                               goto out;
> +               }
> +
>                 if (ret)
>                         goto out;
>         }
> @@ -249,7 +386,8 @@ int ftrace_init_nop(struct module *mod, struct dyn_ft=
race *rec)
>         /* Verify instructions surrounding the ftrace location */
>         if (IS_ENABLED(CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY)) {
>                 /* Expect nops */
> -               ret =3D ftrace_validate_inst(ip - 4, ppc_inst(PPC_RAW_NOP=
()));
> +               if (!IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE))
> +                       ret =3D ftrace_validate_inst(ip - 4, ppc_inst(PPC=
_RAW_NOP()));
>                 if (!ret)
>                         ret =3D ftrace_validate_inst(ip, ppc_inst(PPC_RAW=
_NOP()));
>         } else if (IS_ENABLED(CONFIG_PPC32)) {
> @@ -277,6 +415,10 @@ int ftrace_init_nop(struct module *mod, struct dyn_f=
trace *rec)
>         if (ret)
>                 return ret;
>
> +       /* Set up out-of-line stub */
> +       if (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE))
> +               return ftrace_init_ool_stub(mod, rec);
> +
>         /* Nop-out the ftrace location */
>         new =3D ppc_inst(PPC_RAW_NOP());
>         addr =3D MCOUNT_ADDR;
> diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kern=
el/trace/ftrace_entry.S
> index 244a1c7bb1e8..5b2fc6483dce 100644
> --- a/arch/powerpc/kernel/trace/ftrace_entry.S
> +++ b/arch/powerpc/kernel/trace/ftrace_entry.S
> @@ -56,7 +56,7 @@
>         SAVE_GPR(2, r1)
>         SAVE_GPRS(11, 31, r1)
>         .else
> -#ifdef CONFIG_LIVEPATCH_64
> +#if defined(CONFIG_LIVEPATCH_64) || defined(CONFIG_PPC_FTRACE_OUT_OF_LIN=
E)
>         SAVE_GPR(14, r1)
>  #endif
>         .endif
> @@ -78,10 +78,6 @@
>
>         /* Get the _mcount() call site out of LR */
>         mflr    r7
> -       /* Save it as pt_regs->nip */
> -       PPC_STL r7, _NIP(r1)
> -       /* Also save it in B's stackframe header for proper unwind */
> -       PPC_STL r7, LRSAVE+SWITCH_FRAME_SIZE(r1)
>         /* Save the read LR in pt_regs->link */
>         PPC_STL r0, _LINK(r1)
>
> @@ -96,16 +92,6 @@
>         lwz     r5,function_trace_op@l(r3)
>  #endif
>
> -#ifdef CONFIG_LIVEPATCH_64
> -       mr      r14, r7         /* remember old NIP */
> -#endif
> -
> -       /* Calculate ip from nip-4 into r3 for call below */
> -       subi    r3, r7, MCOUNT_INSN_SIZE
> -
> -       /* Put the original return address in r4 as parent_ip */
> -       mr      r4, r0
> -
>         /* Save special regs */
>         PPC_STL r8, _MSR(r1)
>         .if \allregs =3D=3D 1
> @@ -114,17 +100,69 @@
>         PPC_STL r11, _CCR(r1)
>         .endif
>
> +#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +       /* Save our real return address in nvr for return */
> +       .if \allregs =3D=3D 0
> +       SAVE_GPR(15, r1)
> +       .endif
> +       mr      r15, r7
> +       /*
> +        * We want the ftrace location in the function, but our lr (in r7=
)
> +        * points at the 'mtlr r0' instruction in the out of line stub.  =
To
> +        * recover the ftrace location, we read the branch instruction in=
 the
> +        * stub, and adjust our lr by the branch offset.
> +        *
> +        * See ftrace_init_ool_stub() for the profile sequence.
> +        */
> +       lwz     r8, MCOUNT_INSN_SIZE(r7)
> +       slwi    r8, r8, 6
> +       srawi   r8, r8, 6
> +       add     r3, r7, r8
> +       /*
> +        * Override our nip to point past the branch in the original func=
tion.
> +        * This allows reliable stack trace and the ftrace stack tracer t=
o work as-is.
> +        */
> +       addi    r7, r3, MCOUNT_INSN_SIZE
> +#else
> +       /* Calculate ip from nip-4 into r3 for call below */
> +       subi    r3, r7, MCOUNT_INSN_SIZE
> +#endif
> +
> +       /* Save NIP as pt_regs->nip */
> +       PPC_STL r7, _NIP(r1)
> +       /* Also save it in B's stackframe header for proper unwind */
> +       PPC_STL r7, LRSAVE+SWITCH_FRAME_SIZE(r1)
> +#if defined(CONFIG_LIVEPATCH_64) || defined(CONFIG_PPC_FTRACE_OUT_OF_LIN=
E)
> +       mr      r14, r7         /* remember old NIP */
> +#endif
> +
> +       /* Put the original return address in r4 as parent_ip */
> +       mr      r4, r0
> +
>         /* Load &pt_regs in r6 for call below */
>         addi    r6, r1, STACK_INT_FRAME_REGS
>  .endm
>
>  .macro ftrace_regs_exit allregs
> +#ifndef CONFIG_PPC_FTRACE_OUT_OF_LINE
>         /* Load ctr with the possibly modified NIP */
>         PPC_LL  r3, _NIP(r1)
>         mtctr   r3
>
>  #ifdef CONFIG_LIVEPATCH_64
>         cmpd    r14, r3         /* has NIP been altered? */
> +#endif
> +#else /* !CONFIG_PPC_FTRACE_OUT_OF_LINE */
> +       /* Load LR with the possibly modified NIP */
> +       PPC_LL  r3, _NIP(r1)
> +       cmpd    r14, r3         /* has NIP been altered? */
> +       bne-    1f
> +
> +       mr      r3, r15
> +       .if \allregs =3D=3D 0
> +       REST_GPR(15, r1)
> +       .endif
> +1:     mtlr    r3
>  #endif
>
>         /* Restore gprs */
> @@ -132,14 +170,16 @@
>         REST_GPRS(2, 31, r1)
>         .else
>         REST_GPRS(3, 10, r1)
> -#ifdef CONFIG_LIVEPATCH_64
> +#if defined(CONFIG_LIVEPATCH_64) || defined(CONFIG_PPC_FTRACE_OUT_OF_LIN=
E)
>         REST_GPR(14, r1)
>  #endif
>         .endif
>
>         /* Restore possibly modified LR */
>         PPC_LL  r0, _LINK(r1)
> +#ifndef CONFIG_PPC_FTRACE_OUT_OF_LINE
>         mtlr    r0
> +#endif
>
>  #ifdef CONFIG_PPC64
>         /* Restore callee's TOC */
> @@ -153,7 +193,16 @@
>          /* Based on the cmpd above, if the NIP was altered handle livepa=
tch */
>         bne-    livepatch_handler
>  #endif
> -       bctr                    /* jump after _mcount site */
> +       /* jump after _mcount site */
> +#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +       /*
> +        * Return with blr to keep the link stack balanced. The function =
profiling sequence
> +        * uses 'mtlr r0' to restore LR.
> +        */
> +       blr
> +#else
> +       bctr
> +#endif
>  .endm
>
>  _GLOBAL(ftrace_regs_caller)
> @@ -177,6 +226,11 @@ _GLOBAL(ftrace_stub)
>
>  #ifdef CONFIG_PPC64
>  ftrace_no_trace:
> +#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +       REST_GPR(3, r1)
> +       addi    r1, r1, SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE
> +       blr
> +#else
>         mflr    r3
>         mtctr   r3
>         REST_GPR(3, r1)
> @@ -184,6 +238,7 @@ ftrace_no_trace:
>         mtlr    r0
>         bctr
>  #endif
> +#endif
>
>  #ifdef CONFIG_LIVEPATCH_64
>         /*
> @@ -194,11 +249,17 @@ ftrace_no_trace:
>          * We get here when a function A, calls another function B, but B=
 has
>          * been live patched with a new function C.
>          *
> -        * On entry:
> -        *  - we have no stack frame and can not allocate one
> +        * On entry, we have no stack frame and can not allocate one.
> +        *
> +        * With PPC_FTRACE_OUT_OF_LINE=3Dn, on entry:
>          *  - LR points back to the original caller (in A)
>          *  - CTR holds the new NIP in C
>          *  - r0, r11 & r12 are free
> +        *
> +        * With PPC_FTRACE_OUT_OF_LINE=3Dy, on entry:
> +        *  - r0 points back to the original caller (in A)
> +        *  - LR holds the new NIP in C
> +        *  - r11 & r12 are free
>          */
>  livepatch_handler:
>         ld      r12, PACA_THREAD_INFO(r13)
> @@ -208,18 +269,23 @@ livepatch_handler:
>         addi    r11, r11, 24
>         std     r11, TI_livepatch_sp(r12)
>
> -       /* Save toc & real LR on livepatch stack */
> -       std     r2,  -24(r11)
> -       mflr    r12
> -       std     r12, -16(r11)
> -
>         /* Store stack end marker */
>         lis     r12, STACK_END_MAGIC@h
>         ori     r12, r12, STACK_END_MAGIC@l
>         std     r12, -8(r11)
>
> -       /* Put ctr in r12 for global entry and branch there */
> +       /* Save toc & real LR on livepatch stack */
> +       std     r2,  -24(r11)
> +#ifndef CONFIG_PPC_FTRACE_OUT_OF_LINE
> +       mflr    r12
> +       std     r12, -16(r11)
>         mfctr   r12
> +#else
> +       std     r0, -16(r11)
> +       mflr    r12
> +       /* Put ctr in r12 for global entry and branch there */
> +       mtctr   r12
> +#endif
>         bctrl
>
>         /*
> diff --git a/arch/powerpc/tools/Makefile b/arch/powerpc/tools/Makefile
> new file mode 100644
> index 000000000000..3a389526498e
> --- /dev/null
> +++ b/arch/powerpc/tools/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +quiet_cmd_gen_ftrace_ool_stubs =3D GEN     $@
> +      cmd_gen_ftrace_ool_stubs =3D $< vmlinux.o $@
> +
> +$(obj)/.vmlinux.arch.S: $(src)/ftrace-gen-ool-stubs.sh vmlinux.o FORCE

$(obj)/vmlinux.arch.S: $(src)/ftrace-gen-ool-stubs.sh vmlinux.o FORCE


> +       $(call if_changed,gen_ftrace_ool_stubs)



> +
> +$(obj)/.vmlinux.arch.o: $(obj)/.vmlinux.arch.S FORCE
> +       $(call if_changed_rule,as_o_S)


This is unnecessary because the build rule %.S -> %.o
is available in scripts/Makefile.build


> +
> +clean-files +=3D .vmlinux.arch.S .vmlinux.arch.o

if_changed macro needs 'targets' assignment.

This line should be replaced with:

targets +=3D vmlinux.arch.S







> diff --git a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh b/arch/powerpc/to=
ols/ftrace-gen-ool-stubs.sh
> new file mode 100755
> index 000000000000..8e0a6d4ea202
> --- /dev/null
> +++ b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# Error out on error
> +set -e
> +
> +is_enabled() {
> +       grep -q "^$1=3Dy" include/config/auto.conf
> +}

Instead of checking the CONFIG option in this script,
I recommend passing the 64bit flag as a command line parameter.


> +
> +vmlinux_o=3D${1}
> +arch_vmlinux_S=3D${2}
> +
> +RELOCATION=3DR_PPC64_ADDR64
> +if is_enabled CONFIG_PPC32; then
> +       RELOCATION=3DR_PPC_ADDR32
> +fi
> +
> +num_ool_stubs_text=3D$(${CROSS_COMPILE}objdump -r -j __patchable_functio=
n_entries ${vmlinux_o} |


${CROSS_COMPILE}objdump  -> ${OBJDUMP}


> +                    grep -v ".init.text" | grep "${RELOCATION}" | wc -l)
> +num_ool_stubs_inittext=3D$(${CROSS_COMPILE}objdump -r -j __patchable_fun=
ction_entries ${vmlinux_o} |

${CROSS_COMPILE}objdump  -> ${OBJDUMP}

I also recommend passing ${OBJDUMP} from the command line parameter.



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
> --
> 2.46.0
>


--
Best Regards
Masahiro Yamada

