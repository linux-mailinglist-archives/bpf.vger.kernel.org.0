Return-Path: <bpf+bounces-34796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE29930EC2
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 09:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E282811BD
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 07:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2876018411D;
	Mon, 15 Jul 2024 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIn1Yh5O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F2184108;
	Mon, 15 Jul 2024 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721028606; cv=none; b=quc8MdgWTwM36ZHZfJoVLLtrabg8NkNAKHtbQC6znRsnSUOWv7unbwFPVFHAH43c+hac5koJf7weEd/7E/yAf5BELfo1IRsVXkUK75Xs5oOz8aKUtXjNlSbdwBXx3TCmVIr/5cn85BV4jvNbC0srOqM0nNRHJIJUMcsZvjrCp6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721028606; c=relaxed/simple;
	bh=AM42cWTW7un45eFJ/EDWHEgDA8q8GBmfCeHFxHs9fwo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=X9pD5Q9tfq8EmYToV7OReZfVJJgRyuh+VwKxBduIWlSlvenKkRHxiRI1gpQy/UIzYr7gjgBX7FtTEziM68JTvyaOx75oH039NKdNeSm+jOjbErli/S80RBjKV8b1ygP53p4ftbFE94kamTpwbRfRw4pNXB7FPReh05SZKdE3KlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIn1Yh5O; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fbcf71d543so25525925ad.1;
        Mon, 15 Jul 2024 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721028604; x=1721633404; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKQo9FhAVoaowXJ5veaqZ/q1Hr6Iori2+sa1LUwT+cM=;
        b=eIn1Yh5O3GZGscpt28fBmk9GKDJHhl9OnGOVdQNhn/kFzY9Z5wnj//ahribtGR5YdT
         eKj4Itvb0sR5FlZexOf/GevaqIq2itQParSQuqYUkbQrmAww8l8SXS8IO0NHPeCJbcQl
         Y3TnT7tKjxBNbcSRXYWqebK6fKCKeYlVfAmMwqN22j2UQYyMWCzCc9bcdk0z1nXMwcUu
         pi7QZzdaov+a7NhfSWOu+GPaMHjYEFsymbTldZFc/XqWtr5KvqTYKeCEXozNEGH/DQzO
         rhXgyVH2avmskpjKOeomYxxHyQWZPptvO/qEYXZXj0EygasUcYvTmSJ3gZ+QLkadqZqY
         9JGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721028604; x=1721633404;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NKQo9FhAVoaowXJ5veaqZ/q1Hr6Iori2+sa1LUwT+cM=;
        b=R10EXO/pgod976vKNraS6AOtSYjaBwpd0HQ39qQamM384YPJDnqghJh/+eDcOHYJzG
         n3SyzSn/jbW9T2HY5e8lvpvPD/UPIODNCBY00b8qDed0FKo5kymSsY/vtg9hd5RVG5NZ
         GeeGyuPdb5LkQTvN/kguMMIJQip0uIjl0TZLmejriH/9AtZKBkc5MfUDVQ9NV5j2H5rc
         GK2b4BO0WQnKeVhPe4Fhgs1kEijJSvZ56ilJuZnzImh3ee6qif+QFtCq9AeHgTD2xM4s
         UB89tjkkC86cANqHNU8RmfZyAN21gh6gSt6Dp+wFQnHIGV4zQCXsHaKgyES5SaY2/RS9
         7+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP8Lbx0YSTzVizMRTKyBzlakofGrXL1jiqh0zwtm9OwOw8+YvJHJ1jS9A+sObs7VOzRW2MgJQV26DwEW6509Ku5fT+sU8fdCDoLwr9vDTFFDdO6fHxIOADlBQgaD71HTODtioIi82BlUVApq2Ivkm1nf0MuqsSLoL779VOWmwmzMq5/nEXBJD9ZR7AX7LLLutpfA8syprFmqAAIGjfnl7dzBuM
X-Gm-Message-State: AOJu0Yy2z2bQ7mmjYnI5i0EMK4dR7K+9JhmDyAuvs/oivIZBHh8O4o4V
	pUfsNFwtE8INV900CKMMCfh0EJlkytU63Hj9YYwvfaBL2yXt9OCIBDPx8A==
X-Google-Smtp-Source: AGHT+IH8nFjkvz8RIHB/6NaJPlNL5ZFJl57TrddGB9e6no/jh+pmO1LMjIcEgSJT25B+vybEayFdXw==
X-Received: by 2002:a17:903:1cc:b0:1fb:8d32:d87b with SMTP id d9443c01a7336-1fbb6d0ae62mr129811745ad.15.1721028604282;
        Mon, 15 Jul 2024 00:30:04 -0700 (PDT)
Received: from localhost ([1.146.120.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc381a1sm34105525ad.202.2024.07.15.00.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 00:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jul 2024 17:29:53 +1000
Message-Id: <D2PXPX96JT5D.3BP6QTVVEA3VA@gmail.com>
Cc: "Michael Ellerman" <mpe@ellerman.id.au>, "Christophe Leroy"
 <christophe.leroy@csgroup.eu>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>, "Hari Bathini"
 <hbathini@linux.ibm.com>, "Mahesh Salgaonkar" <mahesh@linux.ibm.com>,
 "Vishal Chourasia" <vishalc@linux.ibm.com>
Subject: Re: [RFC PATCH v4 11/17] kbuild: Add generic hook for architectures
 to use before the final vmlinux link
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Naveen N Rao" <naveen@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1720942106.git.naveen@kernel.org>
 <87b71debd931011f8b9204c700b3084a6c3cdab8.1720942106.git.naveen@kernel.org>
In-Reply-To: <87b71debd931011f8b9204c700b3084a6c3cdab8.1720942106.git.naveen@kernel.org>

On Sun Jul 14, 2024 at 6:27 PM AEST, Naveen N Rao wrote:
> On powerpc, we would like to be able to make a pass on vmlinux.o and
> generate a new object file to be linked into vmlinux. Add a generic pass
> in Makefile.vmlinux that architectures can use for this purpose.
>
> Architectures need to select CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX and must
> provide arch/<arch>/tools/Makefile with .arch.vmlinux.o target, which
> will be invoked prior to the final vmlinux link step.

Maybe POSTLINK should move to more like this with explicit config
option too rather than just picking up Makefile.postlink...

>
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
>  arch/Kconfig             |  6 ++++++
>  scripts/Makefile.vmlinux |  8 ++++++++
>  scripts/link-vmlinux.sh  | 11 ++++++++---
>  3 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 975dd22a2dbd..ef868ff8156a 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1643,4 +1643,10 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
>  config ARCH_NEED_CMPXCHG_1_EMU
>  	bool
> =20
> +config ARCH_WANTS_PRE_LINK_VMLINUX
> +	def_bool n
> +	help
> +	  An architecture can select this if it provides arch/<arch>/tools/Make=
file
> +	  with .arch.vmlinux.o target to be linked into vmlinux.

Someone bikeshedded me before for putting comments for putting comment
for non-user-selectable option in 'help'. Even though heaps of options
are like that here, apparently they preferred # comment above the option
for developer comments. I personally thought this looks nicer but do
Kconfig maintainers prefer #?

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

Does .vmlinux.arch.o follow convention better? I guess the btf does
not. So, nevermind.

Could this just be done entirely in link-vmlinux.sh like kallsyms and
btf?

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

BTF generation needs  the prelink .o?

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

I guess it looks okay, similar to btf although I'm not a kbuild expert.

Thanks,
Nick

