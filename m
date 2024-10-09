Return-Path: <bpf+bounces-41440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F26E997048
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26051C2275B
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB041F4727;
	Wed,  9 Oct 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFymucgi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170731F4718;
	Wed,  9 Oct 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488209; cv=none; b=ZzSE2EXQvRVP7U+HxIAPTNZS1lSK/2qJyJaxHacWf2shanNKcWZ4CamBr9Oo8zx4RWzpsLv4vOZunAiiVStSlnUKffAAmzn0T8HaEYaECvTx74uos+7jPc6n9+79y0eU8v+OVWeAWM96Fh2hTaHsZkTt4fmmMkxaRhNVEN1PNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488209; c=relaxed/simple;
	bh=5W/eU0wvAS76JaKdlOSIGQ7kJOMA6WDcLObcwgbmvp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pN0cbHYZLVD47j0RrMgLn3Rwy8ijaAmv/+VKBiJNRgix2YVkUQS2jmV43E61MK2ZpY6UXTJuiGE9lH39bN7nIVeHJDruz4sjPB+EhRuswvO7HCa2LQrFfSLRqIUBPmdAo0BvJqTEdMx7w2Srux64oH7ZlFX+de027JtLgjVNJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFymucgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB87C4CED1;
	Wed,  9 Oct 2024 15:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728488208;
	bh=5W/eU0wvAS76JaKdlOSIGQ7kJOMA6WDcLObcwgbmvp8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aFymucgibUGQ4oF6G5DJqtrSLbWtFTV2T+it2VrzAD3MWPqXS/QY7ilPKtdYxcSax
	 r/IGdt2OkOjtRzbqo30v+YiMjNW/G+zylnDs4S2pFKY4k22BrTfyMEg6jtLVkorMy+
	 IM6Ix5KCL0vsHEh1Z7EBT0vAGcKJJEPSZcCaPww2rrQSrSueHkhnS7l+WX6i5pvgsJ
	 7vsXwnUNyZNm0pYB0N+07bixMXdiC3/fUUrfov5l9cLBT4mfjVja4lWV+ohZmcG0e4
	 Jkpdtj9gNXBcdqIs6JMhEfXBDVXH7SWikMFbcp0TvxczgGZnGyKnab4lgSIFSiCSQ1
	 U524DPXujqU+w==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398df2c871so7784751e87.1;
        Wed, 09 Oct 2024 08:36:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8q79LDm5euvcjPIOekPfZSfOf3BYXjQRF2Isiy53x/sI3Z7PIuJ6NjUTRIKViiB9v7MJq9eZrfFwBEcCI@vger.kernel.org, AJvYcCWZ28FqHMoCCJcK9MrBsfwGsPxWO1xoRELGiy5LROwuNpDs9V+aVZCqpDwxM25HxsdSoWA=@vger.kernel.org, AJvYcCXPoJ3j2pnbXsSZIslmS2x9JwRBG0Ns8cBoJkaqdqSwC5bl3kXrPIAz12k3ggVjGWA+LkRaf0njvD1sde4b@vger.kernel.org, AJvYcCXdYwHTQ8K3dHhobd68DDFN4NLPyTKWhFXud1o33MtOEGlTAsikudSul4wpuiJcWv6ffr2BlGqrldmo+Df5viDQWGNO@vger.kernel.org
X-Gm-Message-State: AOJu0YyJj0zVHe02PYsKumDHZJYdpyT2ZfeizZcfmYKrt2lb1hH1HYnA
	4vQMkGpRW3Ht6McIhhOQucbjznDmGtDYcx/ABr7czI1bV/7AWzf49/hu163XjOehx8x0kvqhQKo
	17zvwZzqE8BeY6Ofld3iKDW0YTqk=
X-Google-Smtp-Source: AGHT+IErCEsVSBygSrHOAxgDw+LlqbSlTSSpSn7uhv6ysjnosQXrEtX5GI4xz8sB9o22daBlWO7gKFAhl8OpeL3/vv0=
X-Received: by 2002:a05:6512:b84:b0:539:9155:e8bf with SMTP id
 2adb3069b0e04-539c92756b3mr448385e87.12.1728488207156; Wed, 09 Oct 2024
 08:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915205648.830121-1-hbathini@linux.ibm.com> <20240915205648.830121-14-hbathini@linux.ibm.com>
In-Reply-To: <20240915205648.830121-14-hbathini@linux.ibm.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 10 Oct 2024 00:36:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAREkj5OQ_HA2H=iV_32qdOcaguCOBKV1j+dJW0YaQh3UA@mail.gmail.com>
Message-ID: <CAK7LNAREkj5OQ_HA2H=iV_32qdOcaguCOBKV1j+dJW0YaQh3UA@mail.gmail.com>
Subject: Re: [PATCH v5 13/17] powerpc64/ftrace: Support .text larger than 32MB
 with out-of-line stubs
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
> Changes in v5:
> * num_ool_stubs_text_end used for setting up ftrace_ool_stub_text_end
>   set to zero instead of computing to some random negative value when
>   not required.
>
>  arch/powerpc/Kconfig                       | 12 ++++++++++++
>  arch/powerpc/include/asm/ftrace.h          |  6 ++++--
>  arch/powerpc/kernel/trace/ftrace.c         | 21 +++++++++++++++++----
>  arch/powerpc/kernel/trace/ftrace_entry.S   |  8 ++++++++
>  arch/powerpc/tools/Makefile                |  2 +-
>  arch/powerpc/tools/ftrace-gen-ool-stubs.sh | 16 ++++++++++++----
>  6 files changed, 54 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index bae96b65f295..a0ce00368bab 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -573,6 +573,18 @@ config PPC_FTRACE_OUT_OF_LINE
>         depends on PPC64
>         select ARCH_WANTS_PRE_LINK_VMLINUX
>
> +config PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE
> +       int "Number of ftrace out-of-line stubs to reserve within .text"
> +       default 32768 if PPC_FTRACE_OUT_OF_LINE
> +       default 0

This entry is meaningless when CONFIG_PPC_FTRACE_OUT_OF_LINE=3Dn.

           depends on PPC_FTRACE_OUT_OF_LINE
           default 32768




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
> index 3a389526498e..9eeb6edf02fe 100644
> --- a/arch/powerpc/tools/Makefile
> +++ b/arch/powerpc/tools/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>
>  quiet_cmd_gen_ftrace_ool_stubs =3D GEN     $@
> -      cmd_gen_ftrace_ool_stubs =3D $< vmlinux.o $@
> +      cmd_gen_ftrace_ool_stubs =3D $< $(CONFIG_PPC_FTRACE_OUT_OF_LINE_NU=
M_RESERVE) vmlinux.o $@
>
>  $(obj)/.vmlinux.arch.S: $(src)/ftrace-gen-ool-stubs.sh vmlinux.o FORCE
>         $(call if_changed,gen_ftrace_ool_stubs)
> diff --git a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh b/arch/powerpc/to=
ols/ftrace-gen-ool-stubs.sh
> index 8e0a6d4ea202..d6bd834e0868 100755
> --- a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
> +++ b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
> @@ -8,8 +8,9 @@ is_enabled() {
>         grep -q "^$1=3Dy" include/config/auto.conf
>  }
>
> -vmlinux_o=3D${1}
> -arch_vmlinux_S=3D${2}
> +vmlinux_o=3D${2}
> +arch_vmlinux_S=3D${3}
> +arch_vmlinux_o=3D$(dirname ${arch_vmlinux_S})/$(basename ${arch_vmlinux_=
S} .S).o


arch_vmlinux_o is not used in this script. Delete it.






>
>  RELOCATION=3DR_PPC64_ADDR64
>  if is_enabled CONFIG_PPC32; then
> @@ -21,15 +22,22 @@ num_ool_stubs_text=3D$(${CROSS_COMPILE}objdump -r -j =
__patchable_function_entries
>  num_ool_stubs_inittext=3D$(${CROSS_COMPILE}objdump -r -j __patchable_fun=
ction_entries ${vmlinux_o} |
>                          grep ".init.text" | grep "${RELOCATION}" | wc -l=
)
>
> +num_ool_stubs_text_builtin=3D${1}
> +if [ ${num_ool_stubs_text} -gt ${num_ool_stubs_text_builtin} ]; then
> +       num_ool_stubs_text_end=3D$(expr ${num_ool_stubs_text} - ${num_ool=
_stubs_text_builtin})
> +else
> +       num_ool_stubs_text_end=3D0
> +fi
> +
>  cat > ${arch_vmlinux_S} <<EOF
>  #include <asm/asm-offsets.h>
>  #include <linux/linkage.h>
>
>  .pushsection .tramp.ftrace.text,"aw"
> -SYM_DATA(ftrace_ool_stub_text_end_count, .long ${num_ool_stubs_text})
> +SYM_DATA(ftrace_ool_stub_text_end_count, .long ${num_ool_stubs_text_end}=
)
>
>  SYM_CODE_START(ftrace_ool_stub_text_end)
> -       .space ${num_ool_stubs_text} * FTRACE_OOL_STUB_SIZE
> +       .space ${num_ool_stubs_text_end} * FTRACE_OOL_STUB_SIZE
>  SYM_CODE_END(ftrace_ool_stub_text_end)
>  .popsection
>
> --
> 2.46.0
>


--
Best Regards
Masahiro Yamada

