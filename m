Return-Path: <bpf+bounces-41418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CC8996FC4
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8051F21148
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C001E0DB9;
	Wed,  9 Oct 2024 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOKOvzKx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624EC199230;
	Wed,  9 Oct 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487440; cv=none; b=nzOtYo+kQInHMdoYPDKj62oxRGH00l+6bftstVfb0Lp97dBwmeGiM6sSmTeX9qLI2c9VLklngUokUQJ9A2QYA4WVueuDbhUAZJBfDOcj8GtK4zpsZhhAjbWDIqr2JvcpdFnc3ZLwAHpKLVHPJ97s/Pby26XStM1sST1EpbABnlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487440; c=relaxed/simple;
	bh=4AjksnzzW5k8hBBme1kBI/+DD7QGwpafnwlUuyqFM6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Di3OKqWHvFYh/6WmD2h50TYEe99HGt42PrAGo4Nli9OZJ5gYYt7UnXco9meL88z2vksvF14QtovQ/pNNt0fRffC6BHHHQ86CUChe6Poo4JG7nTBM+3LkrzrbcmhK9WZgx/3BGJqhXEMRZwYQruwe/c262yjvC5mSyrSZimzhZIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOKOvzKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6846C4CEC5;
	Wed,  9 Oct 2024 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728487439;
	bh=4AjksnzzW5k8hBBme1kBI/+DD7QGwpafnwlUuyqFM6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hOKOvzKxW6op8p2Rq75UJoop9Pd0jFDZDJXovc+WfjxUYXz+3mIUeE+rqO8deMQol
	 D5Q3zUA2oddqsXKrwAYpUx3bSQVX+ifmZDaQcwFkhqcmlYKbkRvQQSygISBlUEYBiz
	 lwIbYr5wZA0P1+iQQH52qhdR8w68Xqow/FF9F6Ktjv5n+WLCQrdhmpx8dj00R8El+E
	 1s8C+p+0+ykam250o5nlc5/KtVQdMDSoZGcveRbLtfo5TutKX+KDW+EFjRaTtT/sgx
	 YdUBVf2B++TXBgNKhR8m1OEuIQjCyQvBCHF8mhTQDPplS3zIR4l17t7YN6gzrsovb7
	 cxqKuczpR6kxQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5399651d21aso6431179e87.3;
        Wed, 09 Oct 2024 08:23:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSqw7DXJFD/KBIu2FRQ5/BLxSMR3sOif7mqyf+M30dn45vTM/jM9dasFLY7D8KUZAvxn4=@vger.kernel.org, AJvYcCVUD4XTm8jfWizf6AY3U6KTxSye+7ilclhu+uveEQYIRcMqJV5rFuSVLWO6riVg2QpEfmJkOaglHvP4wwo1rnGgmZ4A@vger.kernel.org, AJvYcCVan0fOKVSaxuY3mpehjrSGT9F/kT7y22gnpq0tonMwm2k4YLYZPbAxxDqvC12a32QNDoP7yqaozElEDhy8@vger.kernel.org, AJvYcCWw+glId4vP2hKM+OKSS1Q0chwzxlSvZ1cDMDIlfAH0kBthl/mqRtHXPZmKmP2GDSp6HjZL4E36r8sO5yeB@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLppdR/il1B8UBBhoqeVT4qkPRiEoGNcrSFclK4DsnmEJ3Ncg
	Wt3WQO7PeA2ehksrpnQl5wVcMu0QTFlpJ+e/Y+2c6WVX0aSCNB6deTJMKxys/cYkLLPNuNO10eJ
	3OoFv4phxq1jrD56fF53lgpk4fns=
X-Google-Smtp-Source: AGHT+IEiWPw+RQ+TnDaHXfM/Mw/zmdX2TI3sj1La8whAJdJcZ29a26S9fWhexgESxPKq+5AXQsmOXW5h7DnougX3kLY=
X-Received: by 2002:a05:6512:1188:b0:539:9d24:9ea with SMTP id
 2adb3069b0e04-539c48d93dfmr1743896e87.34.1728487438407; Wed, 09 Oct 2024
 08:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915205648.830121-1-hbathini@linux.ibm.com> <20240915205648.830121-12-hbathini@linux.ibm.com>
In-Reply-To: <20240915205648.830121-12-hbathini@linux.ibm.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 10 Oct 2024 00:23:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS9LPPxVOU55t2C_vkXYXK-8_2bHCVPWVxYdwrSrxCduw@mail.gmail.com>
Message-ID: <CAK7LNAS9LPPxVOU55t2C_vkXYXK-8_2bHCVPWVxYdwrSrxCduw@mail.gmail.com>
Subject: Re: [PATCH v5 11/17] kbuild: Add generic hook for architectures to
 use before the final vmlinux link
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
> On powerpc, we would like to be able to make a pass on vmlinux.o and
> generate a new object file to be linked into vmlinux. Add a generic pass
> in Makefile.vmlinux that architectures can use for this purpose.
>
> Architectures need to select CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX and must
> provide arch/<arch>/tools/Makefile with .arch.vmlinux.o target, which
> will be invoked prior to the final vmlinux link step.
>
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>
> Changes in v5:
> * Intermediate files named .vmlinux.arch.* instead of .arch.vmlinux.*
>
>
>  arch/Kconfig             | 6 ++++++
>  scripts/Makefile.vmlinux | 7 +++++++
>  scripts/link-vmlinux.sh  | 7 ++++++-
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 975dd22a2dbd..ef868ff8156a 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1643,4 +1643,10 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
>  config ARCH_NEED_CMPXCHG_1_EMU
>         bool
>
> +config ARCH_WANTS_PRE_LINK_VMLINUX
> +       def_bool n


Redundant default. This line should be "bool".






> +       help
> +         An architecture can select this if it provides arch/<arch>/tool=
s/Makefile
> +         with .arch.vmlinux.o target to be linked into vmlinux.
> +
>  endmenu
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index 49946cb96844..edf6fae8d960 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -22,6 +22,13 @@ targets +=3D .vmlinux.export.o
>  vmlinux: .vmlinux.export.o
>  endif
>
> +ifdef CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX
> +vmlinux: arch/$(SRCARCH)/tools/.vmlinux.arch.o

If you move this to arch/*/tools/, there is no reason
to make it a hidden file.


vmlinux: arch/$(SRCARCH)/tools/vmlinux.arch.o




> +arch/$(SRCARCH)/tools/.vmlinux.arch.o: vmlinux.o

FORCE is missing.


arch/$(SRCARCH)/tools/vmlinux.arch.o: vmlinux.o FORCE



> +       $(Q)$(MAKE) $(build)=3Darch/$(SRCARCH)/tools $@
> +endif
> +
>  ARCH_POSTLINK :=3D $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postli=
nk)
>
>  # Final link of vmlinux with optional arch pass after final link
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index f7b2503cdba9..b3a940c0e6c2 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -100,7 +100,7 @@ vmlinux_link()
>         ${ld} ${ldflags} -o ${output}                                   \
>                 ${wl}--whole-archive ${objs} ${wl}--no-whole-archive    \
>                 ${wl}--start-group ${libs} ${wl}--end-group             \
> -               ${kallsymso} ${btf_vmlinux_bin_o} ${ldlibs}
> +               ${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldl=
ibs}
>  }
>
>  # generate .BTF typeinfo from DWARF debuginfo
> @@ -214,6 +214,11 @@ fi
>
>  ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=3Dinit init/version-t=
imestamp.o
>
> +arch_vmlinux_o=3D""
> +if is_enabled CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX; then
> +       arch_vmlinux_o=3Darch/${SRCARCH}/tools/.vmlinux.arch.o


arch_vmlinux_o=3Darch/${SRCARCH}/tools/vmlinux.arch.o



> +fi
> +
>  btf_vmlinux_bin_o=3D
>  kallsymso=3D
>  strip_debug=3D
> --
> 2.46.0
>


--
Best Regards
Masahiro Yamada

