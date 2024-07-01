Return-Path: <bpf+bounces-33479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0651491DB6F
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 11:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E7E1C22F28
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83204F606;
	Mon,  1 Jul 2024 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQRH5gW8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890C2C859;
	Mon,  1 Jul 2024 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826267; cv=none; b=Vs3bG2946a6+bRdAZCmDMDEjA46JfxTAdci60bu9+4nV05thTezUu/R5V/FBhHdMTNFOi+whd6BfJme6a/PrcJk6lKlqMEYdZYZscKue3vR6GuatRqdgdhc+NYoBYQmJPzgTdOLEpcVUlnqCzTx/1BWisOH6kcnwtPmnqg3eVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826267; c=relaxed/simple;
	bh=0A8bnbwVB+OvZRrPKNHfPVALWwXyLMQBiHU4DvS4UKk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ncx9CxDl8S9aF3mH9K1kjcHH9wQ7GAODeJ3TOTRZ4+cfrbe9/Qb8HZ9u19svKAXaCTF/OumPxYYbLIjR1z8QLNkKOX5YL9/BPf0CW2gmx0Wh0/59fiCkf8yfqJUwTdRCXkfOUa8Vgx4crFmd5g2+B0atkeKcLaxagryB5xx7JBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQRH5gW8; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-706b539fcaeso2613588b3a.0;
        Mon, 01 Jul 2024 02:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719826265; x=1720431065; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORLsqYDozGGQHazYB1vFAMEwUxePoC0MYlzI3YFADyM=;
        b=QQRH5gW8/A8Cppzc/XuAf8d5gUVRnLR5MfGMtfV+gGRLz6bFhR3BUdI1OkbAy3eQQ/
         JTOEYr2pEqtZPBheoKpAfbqyiKZbsbCk1TBM2zjLOgukgtiRn2J17FfuClyA7pHIhKyJ
         7Evmo56HfyuuVjoLL485tUzjn5S5ruk5tmKuaTE2qXcZOtTvhUsT2A6O4ccu7ew5ydj8
         CxSL0yYPdUJwJWU9Cihwzdm1Fej0VOZjk5W59QrjehNEcOfa8At3vKsVD81bIciQcOCz
         X/gOgHFgbJ0rHpq5+0NSEoLRDIUgehHoa2v3n9npQMFMdJTFdgB2bPTPPjkq3hNWv6sn
         j9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719826265; x=1720431065;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ORLsqYDozGGQHazYB1vFAMEwUxePoC0MYlzI3YFADyM=;
        b=SV5GkgRMbf5fCfxLpuxZWwjXjm0LYiGmzaVM2oJsSOIGZV6/+Q1+iW01Tc/MQr7V6s
         cgqCj2bgEkM5xniQ2pXWi0iFnhdTJUjmDFbyQnWRH3UlVC1wTxygjfmhxwij0n25TPJ3
         3wgxHiG7kvS9glH5X1/ii4spmmRM42bp8BuzGUCPi/ECU42b/wxwk8Ugu5fxx2la0snf
         u93bw0kXQnkFxNp6xvdf3UBDhzZy1lvs7SKIuQjquXotMk/0CE095RsVv2qYSIqbNBs2
         U9tI5Ngm3yZYsnahpb7rhEPguGyWqMXcoUM8PFDJrMkQgpynb89sCzZsu07P6Tt/CP8f
         UHzw==
X-Forwarded-Encrypted: i=1; AJvYcCXb2fs34C44VOmQl9RIK2F8c3puoK4t604GNPhN8Ucg8RhkSUHMxj8g/W+r51uRSmO+s+tbnEV3M6KEWUUJ1GUtAMNIgmKScs6s5Qm2TWMCf/wxx4LYr4oTTjs2wvlvVWRYAyUqo8wg
X-Gm-Message-State: AOJu0Yz5aXaFoilHWxfiUiohr4r54HbYhI8Ra/fhd0tbUPkInaDTYwOY
	8euj7AGRdhGU2B0/IeqFWsuiIMiX/x50J64s2qapGohJcvQRApz4ZsmAEw==
X-Google-Smtp-Source: AGHT+IHtdZNcHIniXJIYYH2e8PojgzEqciWgh1slaKx0J2rNH4ZsGskgBTwGuCXxoA/fCUlDhB3m8w==
X-Received: by 2002:a05:6a20:cf84:b0:1be:c41d:b6b7 with SMTP id adf61e73a8af0-1bef624385dmr6815619637.19.1719826265398;
        Mon, 01 Jul 2024 02:31:05 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708048942b9sm6014253b3a.190.2024.07.01.02.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 02:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 19:30:56 +1000
Message-Id: <D2E3IZ8IEYRJ.1QO5PIRLRD7Z4@gmail.com>
Cc: "Michael Ellerman" <mpe@ellerman.id.au>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>, "Masahiro Yamada"
 <masahiroy@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Song Liu" <song@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>
Subject: Re: [RFC PATCH v3 05/11] kbuild: Add generic hook for architectures
 to use before the final vmlinux link
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Naveen N Rao" <naveen@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1718908016.git.naveen@kernel.org>
 <8b296f09aa8a702095f8be04e9f0e167db5b4d77.1718908016.git.naveen@kernel.org>
In-Reply-To: <8b296f09aa8a702095f8be04e9f0e167db5b4d77.1718908016.git.naveen@kernel.org>

On Fri Jun 21, 2024 at 4:54 AM AEST, Naveen N Rao wrote:
> On powerpc, we would like to be able to make a pass on vmlinux.o and
> generate a new object file to be linked into vmlinux. Add a generic pass
> in Makefile.vmlinux that architectures can use for this purpose.
>
> Architectures need to select CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX and must
> provide arch/<arch>/tools/Makefile with .arch.vmlinux.o target, which
> will be invoked prior to the final vmlinux link step.
>
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
>  arch/Kconfig             |  3 +++
>  scripts/Makefile.vmlinux |  8 ++++++++
>  scripts/link-vmlinux.sh  | 11 ++++++++---
>  3 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 975dd22a2dbd..649f0903e7ef 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1643,4 +1643,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
>  config ARCH_NEED_CMPXCHG_1_EMU
>  	bool
> =20
> +config ARCH_WANTS_PRE_LINK_VMLINUX
> +	def_bool n

Could you add a comment above this (that contains basically
the 2nd paragraph of your changelog)?

Thanks,
Nick

> +
>  endmenu
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index 49946cb96844..6410e0be7f52 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -22,6 +22,14 @@ targets +=3D .vmlinux.export.o
>  vmlinux: .vmlinux.export.o
>  endif
> =20
> +ifdef CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX
> +targets +=3D .arch.vmlinux.o
> +.arch.vmlinux.o: vmlinux.o FORCE
> +	$(Q)$(MAKE) $(build)=3Darch/$(SRCARCH)/tools .arch.vmlinux.o
> +
> +vmlinux: .arch.vmlinux.o
> +endif
> +
>  ARCH_POSTLINK :=3D $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postli=
nk)
> =20
>  # Final link of vmlinux with optional arch pass after final link
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 518c70b8db50..aafaed1412ea 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -122,7 +122,7 @@ gen_btf()
>  		return 1
>  	fi
> =20
> -	vmlinux_link ${1}
> +	vmlinux_link ${1} ${arch_vmlinux_o}
> =20
>  	info "BTF" ${2}
>  	LLVM_OBJCOPY=3D"${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
> @@ -178,7 +178,7 @@ kallsyms_step()
>  	kallsymso=3D${kallsyms_vmlinux}.o
>  	kallsyms_S=3D${kallsyms_vmlinux}.S
> =20
> -	vmlinux_link ${kallsyms_vmlinux} "${kallsymso_prev}" ${btf_vmlinux_bin_=
o}
> +	vmlinux_link ${kallsyms_vmlinux} "${kallsymso_prev}" ${btf_vmlinux_bin_=
o} ${arch_vmlinux_o}
>  	mksysmap ${kallsyms_vmlinux} ${kallsyms_vmlinux}.syms
>  	kallsyms ${kallsyms_vmlinux}.syms ${kallsyms_S}
> =20
> @@ -223,6 +223,11 @@ fi
> =20
>  ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=3Dinit init/version-t=
imestamp.o
> =20
> +arch_vmlinux_o=3D""
> +if is_enabled CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX; then
> +	arch_vmlinux_o=3D.arch.vmlinux.o
> +fi
> +
>  btf_vmlinux_bin_o=3D""
>  if is_enabled CONFIG_DEBUG_INFO_BTF; then
>  	btf_vmlinux_bin_o=3D.btf.vmlinux.bin.o
> @@ -273,7 +278,7 @@ if is_enabled CONFIG_KALLSYMS; then
>  	fi
>  fi
> =20
> -vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
> +vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o} ${arch_vmlinux_=
o}
> =20
>  # fill in BTF IDs
>  if is_enabled CONFIG_DEBUG_INFO_BTF && is_enabled CONFIG_BPF; then


