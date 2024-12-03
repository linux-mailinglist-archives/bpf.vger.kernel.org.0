Return-Path: <bpf+bounces-45991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4067E9E1295
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 06:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AC2281F4C
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 05:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D89F136352;
	Tue,  3 Dec 2024 05:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkamBstx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C3817
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733202034; cv=none; b=L/0RnfB6rLa4cnzBEzRprtVx70H8lJsXro4iPYqnvN6AIcR0I650PiZUlvdOmjNpNf1JU3yLmOMCyLIe6YIbKkbU+L8rRvCHPYp8VyfoidyJ5IZidm/ogsFSnFc5uvOEU/FucCHSdvszKk8l9vKCVGU+sBRYHg3ob0K4VfbzvXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733202034; c=relaxed/simple;
	bh=ZFEkNpWgnFaxt8goSHe1cIkoivHmMfxot1GdT3xq8iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1GsfAmxGHXWTzwPdFsYIwEK1sVSPF/wOaUdHn5DV0ffZkhy7XicyqBmn9JoPFxdbDcdznyy9qLmXRLP+0FeyvNoTm0tHOt3KLo4srqfj+uQvXKaAAV0x6RXfKzOpcPwwiitM0E+0QPSzaEwNO3EGwHXsXz1jkEm3DdsVZ1HdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkamBstx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21539e1d09cso46470225ad.1
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 21:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733202032; x=1733806832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+SO1WMI9SqIPa4r1fcY5OgvRuVOUEANiFmVdu7F354=;
        b=OkamBstxB3MlSsTnI0gHlpfowyi6JN9RzT1Ez56WywLn25MJUciq0grnVGtb4EbkR4
         yv3/w7HWGbeG+z1FI9Ij31sZSmAKgE43UfE6IRFl8x4U+4gT3K+I5ZRvmLMe7d5I5Yj0
         dRR2NNPLUQ4M/mkkzCOdWfBQ4jJ8V8zO/Glk6QkXNfsrBLpu5/fWigBNYVltNeFDeTyc
         tJhEaAj3MDEZ7vJyMiJrHYTGGI3YSU27l60G0T5vdyyGxYryUgsxSAOLd7GCe4jCki9V
         blichepoVNEhW2iipfrr4uZRuzTH3JNmR5dAIceBQ3MB7YH/MpEFCBZZdcxXF1Cc10XV
         Qjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733202032; x=1733806832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+SO1WMI9SqIPa4r1fcY5OgvRuVOUEANiFmVdu7F354=;
        b=CJhMESpjwhgjybmKiYqvEbi6g3JJoIngbzyxs11YjJs6TpdA+iIlcv2zINK6hX9Bwa
         BOBQaMI6v1h+u/yQTe4kRJjkYJB3CzsJpcd9fI3+KroZBT68Nns8UtvBJMrzErPZU8g/
         NKeT/afNfkiAhd+eKncUVoTejNmuNoUBewpzuBdtfzZkTYmuuxAwRZ8uq1RfNQNOziwS
         oy38QW7qfRrFtY8jeI7E/GVYXiT+NwreQK6IsNloyZPnrAr3PhnSIL95qkfj17WLt7Hy
         gMFIhevqY4HtcOfVVNs4+zlMU71kSmdgyzzqO3jxrjPtA3e32OWV9ZzRsJRbYJMOR3Q5
         Wdzg==
X-Gm-Message-State: AOJu0Yz3g6kE9GHFMXP+rMz9K+V2yvUtqOpjrjMPtSuGOoEpgprXvdyC
	1AO7tMALHbeo5dS+Gs7HNPgCkI4V/VW8C41I72cF6pv5Aemo5z0=
X-Gm-Gg: ASbGnct/mid06Rex0qnYAbbAdE9pex8Uy3moKmKHov+DrGuoKbh2QPWP8m3s8Uj5SRC
	gi+DV0vzCIcuVnzUbh6KmGUYdxqmCZqlyf6BV1KETCXLbhvflPn1tgzpH3vB97B95lH6/SX2UOn
	34SmBoWRJe+984GQ5kRoNK6cZWVNQNicRgcUDvggxbavITeEV36I7IGg0Fijn/pZSfVDiYKZ12v
	NPzoVyDRVYiqnp2skf0tT2w3QMJ+rm5yHgWk77XCbbtUo64kA==
X-Google-Smtp-Source: AGHT+IFVw4ohzNJYzYNr/y9sCmAVAMHa64EWlno6woDdhGO86j2MhQCRJAVJftMbnSrAHVTrrfkNuw==
X-Received: by 2002:a17:902:d4c2:b0:215:b468:1a48 with SMTP id d9443c01a7336-215bd2001f9mr14052985ad.26.1733202031535;
        Mon, 02 Dec 2024 21:00:31 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215b190112csm9850395ad.282.2024.12.02.21.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 21:00:31 -0800 (PST)
Date: Mon, 2 Dec 2024 21:00:30 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev, masahiroy@kernel.org
Subject: Re: [PATCH bpf v2] samples/bpf: remove unnecessary -I flags from
 libbpf EXTRA_CFLAGS
Message-ID: <Z06Qbsh7Elx7psRx@mini-arch>
References: <20241202234741.3492084-1-eddyz87@gmail.com>
 <Z05PkpUCQb7T_rk3@mini-arch>
 <ed5cd40f87b28528cd6a9a6db55e9879e34d9e92.camel@gmail.com>
 <d451820d25395d013e716884bb037af2aff50115.camel@gmail.com>
 <af043dde50045c5fbce2564130b9b9105b12eeec.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af043dde50045c5fbce2564130b9b9105b12eeec.camel@gmail.com>

On 12/02, Eduard Zingerman wrote:
> On Mon, 2024-12-02 at 17:44 -0800, Eduard Zingerman wrote:
> > On Mon, 2024-12-02 at 16:52 -0800, Eduard Zingerman wrote:
> > 
> > [...]
> > 
> > > > Naive question: why pass EXTRA_CFLAGS to libbpf at all? Can we drop it?
> > > 
> > > This was added by the commit [0].
> > > As far as I understand, the idea is to pass the following flags:
> > > 
> > >     ifeq ($(ARCH), arm)
> > >     # Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
> > >     # headers when arm instruction set identification is requested.
> > >     ARM_ARCH_SELECTOR := $(filter -D__LINUX_ARM_ARCH__%, $(KBUILD_CFLAGS))
> > >     ...
> > >     TPROGS_CFLAGS += $(ARM_ARCH_SELECTOR)
> > >     endif
> > > 
> > >     ifeq ($(ARCH), mips)
> > >     TPROGS_CFLAGS += -D__SANE_USERSPACE_TYPES__
> > >     ...
> > >     endif
> > > 
> > > Not sure if these are still necessary.
> > > 
> > > [0] commit d8ceae91e9f0 ("samples/bpf: Provide C/LDFLAGS to libbpf")
> > > 
> > 
> > But this means that I should include sysroot part in the COMMON_CFLAGS.
> > I'll get the arm cross-compilation environment and double check.
> > 
> 
> So, I tested build as follows:
> - setup a debian chroot for 'testing';
> - added gcc-arm-linux-gnueabihf toolchain and dependencies necessary
>   for kernel build (as in [0]) + clang-18 + qemu-system-arm + qemu-user-static;
> - cross-compiled kernel for ARM inside that chroot:
>   $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make olddefconfig
>   $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j
> - prepared an ARM sysroot (again, debian 'testing'):
>   $ debootstrap --arch armhf --variant=buildd testing \
>       /some/dir/trixie-armhf http://deb.debian.org/debian
>   (and installed libelf-dev inside chroot)
> - compiled samples with the following command:
>   $ CLANG=clang-18 LLC=llc-18 OPT=opt-18 LLVM_DIS=llvm-dis-18 \
>     LLVM_OBJCOPY=llvm-objcopy-18 LLVM_READELF=llvm-readelf-18 \
>     ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- \
>     SYSROOT=/some/dir/trixie-armhf/ \
>     make M=samples/bpf
> 
> [0] https://docs.kernel.org/bpf/s390.html
> 
> The compilation finishes successfully with and without EXTRA_CFLAGS
> passed to libbpf build. When EXTRA_CFLAGS are passed, I don't see any
> -D__LINUX_ARM_ARCH__% flags passed to libbpf build.
> 
> Still, I'm hesitant to remove this flag, I'd prefer to post a v3
> covering sysroot flag and be done with this. E.g. as below:
> 
> --- 8< ----------------------------------------------------
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index bcf103a4c14f..96a05e70ace3 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -146,13 +146,14 @@ ifeq ($(ARCH), x86)
>  BPF_EXTRA_CFLAGS += -fcf-protection
>  endif
>  
> -TPROGS_CFLAGS += -Wall -O2
> -TPROGS_CFLAGS += -Wmissing-prototypes
> -TPROGS_CFLAGS += -Wstrict-prototypes
> -TPROGS_CFLAGS += $(call try-run,\
> +COMMON_CFLAGS += -Wall -O2
> +COMMON_CFLAGS += -Wmissing-prototypes
> +COMMON_CFLAGS += -Wstrict-prototypes
> +COMMON_CFLAGS += $(call try-run,\
>         printf "int main() { return 0; }" |\
>         $(CC) -Werror -fsanitize=bounds -x c - -o "$$TMP",-fsanitize=bounds,)
>  
> +TPROGS_CFLAGS += $(COMMON_CFLAGS)
>  TPROGS_CFLAGS += -I$(objtree)/usr/include
>  TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
>  TPROGS_CFLAGS += -I$(LIBBPF_INCLUDE)
> @@ -162,7 +163,7 @@ TPROGS_CFLAGS += -I$(srctree)/tools/lib
>  TPROGS_CFLAGS += -DHAVE_ATTR_TEST=0
>  
>  ifdef SYSROOT
> -TPROGS_CFLAGS += --sysroot=$(SYSROOT)
> +COMMON_CFLAGS += --sysroot=$(SYSROOT)
>  TPROGS_LDFLAGS := -L$(SYSROOT)/usr/lib
>  endif
>  
> @@ -229,7 +230,7 @@ clean:
>  
>  $(LIBBPF): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUTPUT)
>  # Fix up variables inherited from Kbuild that tools/ build system won't like
> -       $(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)" \
> +       $(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(COMMON_CFLAGS)" \
>                 LDFLAGS="$(TPROGS_LDFLAGS)" srctree=$(BPF_SAMPLES_PATH)/../../ \
>                 O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
>                 $@ install_headers
> ---------------------------------------------------- >8 ---
> 
> (and maybe peek a better name for COMMON_CFLAGS).
> 

Agreed, let's go with what you have (especially since you've tested it).
The samples are mostly deprecated / in maintenance mode anyway.

Feel free to slap:
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

