Return-Path: <bpf+bounces-44900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79ED9CC7A1
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3C4284105
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E361E49F;
	Fri, 15 Nov 2024 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVZSFqXU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96CA8837
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630441; cv=none; b=BXQnccma2scf/xsnzPVl5iOqf9OdW1pRltCO3DusWdKS2GhE2XerLQFS3eJL+EAYAft5wjpmPU7IbozW/2rCiPC6Dml1eLpjO8mUVhlMgX87yIMCWNCI13t3wqdoJo7uItT21vWARkPX3/DPRkz2gVrUXqzxFhz7qS/4Ot4TxzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630441; c=relaxed/simple;
	bh=cf+l+MLBF+vKVZc4qAaJ020yusoZH+xLn2vBQ42qpI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLt0ckQm+NsOA3fwCEXcMfHYaP33WMfF3Ife9mE5vnLUUNfrIyGAturEVPjSNXyS+ld9k48kFMzL8gykkou/2D6bxhusLjd1c4P8e64+u0YBE8g/RLQGcRNkybAQUtnzW+Hqxd5dWMYRvfhp0q1AY8X3zB0q/Ngv/2Mhov28Z0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVZSFqXU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720c286bcd6so1089615b3a.3
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731630439; x=1732235239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XVjQaifdM1mvLy3dFtAibzV4ZT5856HOwup2TIHa+Y=;
        b=MVZSFqXUcuiMqZyxr99QlMqXVZ1WAqethQ5ZMR5PplyKsR3Gn96D2LCGVqi3uaTy5k
         SQO5ENcZWfEUMvSZlcCDVtWNc9ILAfK3YGLd6P+DeIarhUKEwLH5YE6wtZ8ny7FK2/4d
         MWsVNXvtDXK86wUVu5muHnafvISkuIwaqE+MINUGovRG0mMQ/joH2tOXK578gZrcSdUn
         QCufkXNEdXC4Wo0cOU8ysHe9hMu0eAZdwtw/4MYIx5/2gmBvQWhaBcoVk7ACFH0S9EAe
         MGK80YnUMmAMB0abniXYW+PYGRlsg2JTwEUafdMskUx8fpPSvJ60zaKAckAJhX2cjfK8
         sMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731630439; x=1732235239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XVjQaifdM1mvLy3dFtAibzV4ZT5856HOwup2TIHa+Y=;
        b=aW33DCarvnILvrmVRqEJABXdHc3ktsaM7hbEN0D2yLB9KPD3is7QzcI72PKTsjOTr8
         1z1oPvLaYyufN9NSq4WDOCa/kX5z3nqTPSEaMoL9EH1Y3cPk6vBwVH3tz2yA0eRs4ZgF
         QiFJyhdQgwqLoG17NgSbGfauQ0Z7G3kZWSwSffxeKySBFPT5JDmix9abelIMKt1t2iFL
         ADZ/s4EBujvF1RR45GfqePtp5hHt3X9WOCMv1qbqu9FfpgBoYnnPp0CGko1DyezleATB
         yULT3pcCWVW9fHRMuPObstFyytbBg1QGdaafQGWeRuQ4eTNtaqmGR3PGB+ixFdpd7f0K
         qrCA==
X-Gm-Message-State: AOJu0YwmwzGzTXoNj52fqk6QTK14/UZBYQDDHfO/WJI/9EP+2rv+Sg7J
	y+btOiQW38rm/qEBlQ1JwlwK1gXXkfVC2tlpH9cr5bNFNj+GywDgSzHQCotMS9QkjIqLmCRdFiM
	DIRF5vRQ6orkG5iSn6p1y6cdIrm8=
X-Google-Smtp-Source: AGHT+IFZcLM01eY9Ij6ZlvSDQAuWvbw0vbL0RoaSU/UHj1ARfYLalpdQgahAXzqBis26YuLUJEI06/uZPIOCOfk+SY4=
X-Received: by 2002:a17:90b:4d88:b0:2e9:5360:22b2 with SMTP id
 98e67ed59e1d1-2ea1551e46fmr1209929a91.20.1731630438936; Thu, 14 Nov 2024
 16:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107175040.1659341-1-eddyz87@gmail.com> <20241107175040.1659341-4-eddyz87@gmail.com>
In-Reply-To: <20241107175040.1659341-4-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 16:27:06 -0800
Message-ID: <CAEf4Bza7o+-G+zFeNC_6N+jmvLtiHkVoTFWE0nh=wZx4is30kw@mail.gmail.com>
Subject: Re: [RFC bpf-next 03/11] bpf: shared BPF/native kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:51=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> This commit adds a notion of inlinable kfuncs, compiled both to native
> code and BPF. BPF-compiled version is embedded in kernel data section
> and is available to verifier. Verifier uses it to replace calls to
> such kfuncs with inlined function bodies.
>
> Inlinable kfuncs are available only if CLANG is used for kernel
> compilation.
>
> In the scope of this commit all inlining happens as last steps of
> do_check(), after verification is finished. Follow up commits would
> extend this mechanism to allow removal of some conditional branches
> inside inlined function bodies.
>
> The commit consists of the following changes:
> - main kernel makefile:
>   modified to compile a bootstrap version of the bpftool;
> - kernel/bpf/Makefile:
>   - a new file inlinable_kfuncs.c is added;
>   - makefile is modified to compile this file as BPF elf,
>     using the following steps:
>     - use clang with native target to produce LLVM bitcode;
>     - compile LLVM bitcode to BPF object file;
>     - resolve relocations inside BPF object file using bpftool as a
>       linker;
>     Such arrangement allows including unmodified network related
>     header files.
> - verifier.c:
>   - generated BPF elf is included as a part of kernel data section;
>   - at kernel initialization phase:
>     - the elf is parsed and each function declared within it is
>       recorded as an instance of 'inlinable_kfunc' structure;
>     - calls to extern functions within elf file (pointed to by
>       relocation records) are replaced with kfunc call instructions;
>   - do_check() is modified to replace calls to kfuncs from inlinable
>     kfunc table with function bodies:
>     - replacement happens after main verification pass, so the bodies
>       of the kfuncs are not analyzed by verifier;
>     - if kfunc uses callee saved registers r6-r9 the spill/fill pairs
>       are generated for these register before/after inlined kfunc body
>       at call site;
>     - if kfunc uses r10 as a base pointer for load or store
>       instructions, offsets of these instructions are adjusted;
>     - if kfunc uses r10 in other instructions, such r10 is considered
>       as escaping and kfunc is not inlined.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  Makefile                      |  22 +-
>  kernel/bpf/Makefile           |  24 +-
>  kernel/bpf/inlinable_kfuncs.c |   1 +
>  kernel/bpf/verifier.c         | 652 +++++++++++++++++++++++++++++++++-
>  4 files changed, 680 insertions(+), 19 deletions(-)
>  create mode 100644 kernel/bpf/inlinable_kfuncs.c
>
> diff --git a/Makefile b/Makefile
> index a9a7d9ffaa98..4ded57f4b0c2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -496,6 +496,7 @@ CLIPPY_DRIVER       =3D clippy-driver
>  BINDGEN                =3D bindgen
>  PAHOLE         =3D pahole
>  RESOLVE_BTFIDS =3D $(objtree)/tools/bpf/resolve_btfids/resolve_btfids
> +BPFTOOL                =3D $(objtree)/tools/bpf/bpftool/bootstrap/bpftoo=
l
>  LEX            =3D flex
>  YACC           =3D bison
>  AWK            =3D awk
> @@ -585,7 +586,7 @@ export RUSTC_BOOTSTRAP :=3D 1
>  export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COM=
PILE LD CC HOSTPKG_CONFIG
>  export RUSTC RUSTDOC RUSTFMT RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDG=
EN
>  export HOSTRUSTC KBUILD_HOSTRUSTFLAGS
> -export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX=
 YACC AWK INSTALLKERNEL
> +export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS BPF=
TOOL LEX YACC AWK INSTALLKERNEL
>  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
>  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_=
MODULE
> @@ -1356,6 +1357,25 @@ ifneq ($(wildcard $(resolve_btfids_O)),)
>         $(Q)$(MAKE) -sC $(srctree)/tools/bpf/resolve_btfids O=3D$(resolve=
_btfids_O) clean
>  endif
>
> +# TODO: cross compilation?
> +# TODO: bootstrap! (to avoid vmlinux.h generation)
> +PHONY +=3D bpftool_bootstrap bpftool_clean
> +bpftool_O =3D $(abspath $(objtree))/tools/bpf/bpftool
> +
> +ifdef CONFIG_BPF
> +ifdef CONFIG_CC_IS_CLANG
> +prepare: bpftool_bootstrap
> +endif
> +endif
> +
> +bpftool_bootstrap:
> +       $(Q)$(MAKE) -sC $(srctree)/tools/bpf/bpftool O=3D$(bpftool_O) src=
tree=3D$(abspath $(srctree)) bootstrap
> +
> +bpftool_clean:
> +ifneq ($(wildcard $(bpftool_O)),)
> +       $(Q)$(MAKE) -sC $(srctree)/tools/bpf/bpftool O=3D$(bpftool_O) src=
tree=3D$(abspath $(srctree)) clean
> +endif
> +
>  # Clear a bunch of variables before executing the submake
>  ifeq ($(quiet),silent_)
>  tools_silent=3Ds
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 105328f0b9c0..3d7ee81c8e2e 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) :=3D -fno-=
gcse
>  endif
>  CFLAGS_core.o +=3D -Wno-override-init $(cflags-nogcse-yy)
>
> -obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o log.o token.o
> +obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o tnum.o log.o=
 token.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_iter.o map_iter.o task_iter.o prog_it=
er.o link_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ringbu=
f.o
> @@ -53,3 +53,25 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D relo_core.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_relocate.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D kmem_cache_iter.o
> +obj-$(CONFIG_BPF_SYSCALL) +=3D helpers.o inlinable_kfuncs.o
> +
> +ifdef CONFIG_CC_IS_CLANG
> +
> +LLC ?=3D $(LLVM_PREFIX)llc$(LLVM_SUFFIX)
> +
> +# -mfentry -pg is $(CC_FLAGS_FTRACE)
> +# -fpatchable-function-entry=3D16,16 is $(PADDING_CFLAGS)
> +CFLAGS_REMOVE_inlinable_kfuncs.bpf.bc.o +=3D $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_inlinable_kfuncs.bpf.bc.o +=3D $(PADDING_CFLAGS)
> +$(obj)/inlinable_kfuncs.bpf.bc.o: $(src)/inlinable_kfuncs.c
> +       $(Q)$(CLANG) $(c_flags) -emit-llvm -c $< -o $@
> +
> +$(obj)/inlinable_kfuncs.bpf.o: $(obj)/inlinable_kfuncs.bpf.bc.o
> +       $(Q)$(LLC) -mcpu=3Dv3 --mtriple=3Dbpf --filetype=3Dobj $< -o $@
> +
> +$(obj)/inlinable_kfuncs.bpf.linked.o: $(obj)/inlinable_kfuncs.bpf.o
> +       $(Q)$(BPFTOOL) gen object $@ $<

what's the point? Just to strip DWARF? `strip -g` then?

but honestly, why even bother embedding entire ELF? Get binary data
from .text, separately record ELF symbols (to know function name,
size, and where they start). Keep it simple and minimal.


> +
> +$(obj)/verifier.o: $(obj)/inlinable_kfuncs.bpf.linked.o
> +
> +endif
> diff --git a/kernel/bpf/inlinable_kfuncs.c b/kernel/bpf/inlinable_kfuncs.=
c
> new file mode 100644
> index 000000000000..7b7dc05fa1a4
> --- /dev/null
> +++ b/kernel/bpf/inlinable_kfuncs.c
> @@ -0,0 +1 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3bae0bbc1da9..fbf51147f319 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20509,6 +20509,622 @@ static int fixup_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
>         return 0;
>  }
>

[...]

