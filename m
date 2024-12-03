Return-Path: <bpf+bounces-45990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8AB9E1287
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 05:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59345164DD3
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 04:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A2813D521;
	Tue,  3 Dec 2024 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXm4PxeW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095317C68
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 04:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733201409; cv=none; b=rftl693WsZi56TYhmRZ3EMwhxC6OO5hyYlUWkw36cZqCKwKkzEvsyCU6ko9yQKiRaWXqj9dGYEybJNHcl02FWk/Ew7Vjuet3GQxpgRYBgZ+wdkRdka2XlllQXiSpGFbcbmU24/7Avl3fk7SgtEI8Dw933lFbAps7N1guxwZ5Oxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733201409; c=relaxed/simple;
	bh=HcpEh9cWym4yVuCKYVJ5ccdAsd1kyq92bLOZUFRmiCs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l76vxH7dagkqVEQfG7xGCA/z9NSD5SeQyY0SyQbpdD9BkyphL6IXzkgulMDgW/X2Eb1FdqMAlHswSJnE6LbC8G6A39f5MApIC+oPeGgf+HVk26S8ax6Uqf8AlpHJxhUxugosKT5LwiStJ6VsHBUdKKTK74G9oEmhaeCKsaO9HhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXm4PxeW; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fc2dbee20fso3767376a12.3
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 20:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733201407; x=1733806207; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3zOaoJXjBZf7TuRpBnyt8in5a8AUEPGyFkjOHCS79mA=;
        b=SXm4PxeWYKC4DG0VdK2vFJz1dmhsZ3bgYSIibx8nPvOefDoKJRnf8x5naPYcFIhaRY
         pQD8DnzDEpoAN4P0pQdTZ4K4E5EV9Cj7lsPfWB/IumCnDC8Fc3A8/NjYlY3qH9FRXoFW
         eSdA81+QA0MDDSNPbF+5qH1/YUaQlBbccPhpk2oJAY9Inlzzs9mI4qk8QGw2nijyhy9W
         NT5WSZgnHL1WkYRnPF5r8+Km/YVJCY7T/VWA50AZyYKl2yN50kz1ysA8wTsZTzE5SgUo
         SU3uc+XNCqtX23qJL+v8od2bcUgHHeTHLtT/lZOEz9cPDTL7KZdGRIgRST8kytQ/XqEl
         kVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733201407; x=1733806207;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3zOaoJXjBZf7TuRpBnyt8in5a8AUEPGyFkjOHCS79mA=;
        b=TgAz2esZerG+okX2h2VLNaJ1YtTp7uSRyO+M7UEv4ByTR4acU3XF+5P89IQT15/I+X
         AeqgeBouIAUV0Cm8XgBk6KYMaN4s80sn5h28w5ngV0RqCi3GFOoMVI+Rs9uVYv9loqDS
         pDXbY6DF66mV8N9MDeouL3iuoZ0NXP+HTcj9+1lfXgIJ6k9IHrAHW2TvGtJcJPjhCaDL
         g+mYo+NBn/+GnKK2bXY4Ysr/HLlgYNKqxoddvj4Fs+0STBJtKQvOQfP0QpPb8JWeGimI
         /uYVAbbGfQXD8CUdCeKtsOOtG0GgTmYxV4cy83zF20AH0EhTM5S486e4+FBdwO0GlSL7
         sKjQ==
X-Gm-Message-State: AOJu0Yx1uiUDM8YyVcCqmeZig1BIdqk5RowQOyk/nG74C3nOe4h0vvmP
	mPRRuMHJJXOhvb1JFPaeATKsXiT4e7Q8RJW5JUdOcHUL4wXGaS9OQ6gEEw==
X-Gm-Gg: ASbGncsPQ0xerDiLy+FjZn5J/nCkI8goVPsj596nDEbSWwIwKQvCl5/JmO5x56xZ5J0
	o/vEFwEhIRSwuQu8cNX7zEYgePNLyREX60fXzuUxgsNUSiWP2ipp8aUICXzoYmhKWWBeclLRRjK
	gy0eGBb3Xq67lEmTJa1uf/n/DjMUteyCpFOeOFCdvpPcdfWdqBeY6acNtiO7saQSK8Y+7EkQyYg
	dnUsAQ+tfjglUbKfULvLYJh2RbnEcii5SYGRrPXkF/TFKQ=
X-Google-Smtp-Source: AGHT+IH3atB8TZYDCt92qaqK9hU+D1Ed63CwoVLRDNguCduOh8esNgsgefFlFJR2VfBsXhjFfLRsXw==
X-Received: by 2002:a05:6a21:6d9f:b0:1d9:18af:d150 with SMTP id adf61e73a8af0-1e1653c5744mr1796707637.21.1733201406618;
        Mon, 02 Dec 2024 20:50:06 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417614basm9467985b3a.11.2024.12.02.20.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:50:05 -0800 (PST)
Message-ID: <af043dde50045c5fbce2564130b9b9105b12eeec.camel@gmail.com>
Subject: Re: [PATCH bpf v2] samples/bpf: remove unnecessary -I flags from
 libbpf EXTRA_CFLAGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 	masahiroy@kernel.org
Date: Mon, 02 Dec 2024 20:50:00 -0800
In-Reply-To: <d451820d25395d013e716884bb037af2aff50115.camel@gmail.com>
References: <20241202234741.3492084-1-eddyz87@gmail.com>
			 <Z05PkpUCQb7T_rk3@mini-arch>
		 <ed5cd40f87b28528cd6a9a6db55e9879e34d9e92.camel@gmail.com>
	 <d451820d25395d013e716884bb037af2aff50115.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-02 at 17:44 -0800, Eduard Zingerman wrote:
> On Mon, 2024-12-02 at 16:52 -0800, Eduard Zingerman wrote:
>=20
> [...]
>=20
> > > Naive question: why pass EXTRA_CFLAGS to libbpf at all? Can we drop i=
t?
> >=20
> > This was added by the commit [0].
> > As far as I understand, the idea is to pass the following flags:
> >=20
> >     ifeq ($(ARCH), arm)
> >     # Strip all except -D__LINUX_ARM_ARCH__ option needed to handle lin=
ux
> >     # headers when arm instruction set identification is requested.
> >     ARM_ARCH_SELECTOR :=3D $(filter -D__LINUX_ARM_ARCH__%, $(KBUILD_CFL=
AGS))
> >     ...
> >     TPROGS_CFLAGS +=3D $(ARM_ARCH_SELECTOR)
> >     endif
> >=20
> >     ifeq ($(ARCH), mips)
> >     TPROGS_CFLAGS +=3D -D__SANE_USERSPACE_TYPES__
> >     ...
> >     endif
> >=20
> > Not sure if these are still necessary.
> >=20
> > [0] commit d8ceae91e9f0 ("samples/bpf: Provide C/LDFLAGS to libbpf")
> >=20
>=20
> But this means that I should include sysroot part in the COMMON_CFLAGS.
> I'll get the arm cross-compilation environment and double check.
>=20

So, I tested build as follows:
- setup a debian chroot for 'testing';
- added gcc-arm-linux-gnueabihf toolchain and dependencies necessary
  for kernel build (as in [0]) + clang-18 + qemu-system-arm + qemu-user-sta=
tic;
- cross-compiled kernel for ARM inside that chroot:
  $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- make olddefconfig
  $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- make -j
- prepared an ARM sysroot (again, debian 'testing'):
  $ debootstrap --arch armhf --variant=3Dbuildd testing \
      /some/dir/trixie-armhf http://deb.debian.org/debian
  (and installed libelf-dev inside chroot)
- compiled samples with the following command:
  $ CLANG=3Dclang-18 LLC=3Dllc-18 OPT=3Dopt-18 LLVM_DIS=3Dllvm-dis-18 \
    LLVM_OBJCOPY=3Dllvm-objcopy-18 LLVM_READELF=3Dllvm-readelf-18 \
    ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- \
    SYSROOT=3D/some/dir/trixie-armhf/ \
    make M=3Dsamples/bpf

[0] https://docs.kernel.org/bpf/s390.html

The compilation finishes successfully with and without EXTRA_CFLAGS
passed to libbpf build. When EXTRA_CFLAGS are passed, I don't see any
-D__LINUX_ARM_ARCH__% flags passed to libbpf build.

Still, I'm hesitant to remove this flag, I'd prefer to post a v3
covering sysroot flag and be done with this. E.g. as below:

--- 8< ----------------------------------------------------
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index bcf103a4c14f..96a05e70ace3 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -146,13 +146,14 @@ ifeq ($(ARCH), x86)
 BPF_EXTRA_CFLAGS +=3D -fcf-protection
 endif
=20
-TPROGS_CFLAGS +=3D -Wall -O2
-TPROGS_CFLAGS +=3D -Wmissing-prototypes
-TPROGS_CFLAGS +=3D -Wstrict-prototypes
-TPROGS_CFLAGS +=3D $(call try-run,\
+COMMON_CFLAGS +=3D -Wall -O2
+COMMON_CFLAGS +=3D -Wmissing-prototypes
+COMMON_CFLAGS +=3D -Wstrict-prototypes
+COMMON_CFLAGS +=3D $(call try-run,\
        printf "int main() { return 0; }" |\
        $(CC) -Werror -fsanitize=3Dbounds -x c - -o "$$TMP",-fsanitize=3Dbo=
unds,)
=20
+TPROGS_CFLAGS +=3D $(COMMON_CFLAGS)
 TPROGS_CFLAGS +=3D -I$(objtree)/usr/include
 TPROGS_CFLAGS +=3D -I$(srctree)/tools/testing/selftests/bpf/
 TPROGS_CFLAGS +=3D -I$(LIBBPF_INCLUDE)
@@ -162,7 +163,7 @@ TPROGS_CFLAGS +=3D -I$(srctree)/tools/lib
 TPROGS_CFLAGS +=3D -DHAVE_ATTR_TEST=3D0
=20
 ifdef SYSROOT
-TPROGS_CFLAGS +=3D --sysroot=3D$(SYSROOT)
+COMMON_CFLAGS +=3D --sysroot=3D$(SYSROOT)
 TPROGS_LDFLAGS :=3D -L$(SYSROOT)/usr/lib
 endif
=20
@@ -229,7 +230,7 @@ clean:
=20
 $(LIBBPF): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIB=
BPF_OUTPUT)
 # Fix up variables inherited from Kbuild that tools/ build system won't li=
ke
-       $(MAKE) -C $(LIBBPF_SRC) RM=3D'rm -rf' EXTRA_CFLAGS=3D"$(TPROGS_CFL=
AGS)" \
+       $(MAKE) -C $(LIBBPF_SRC) RM=3D'rm -rf' EXTRA_CFLAGS=3D"$(COMMON_CFL=
AGS)" \
                LDFLAGS=3D"$(TPROGS_LDFLAGS)" srctree=3D$(BPF_SAMPLES_PATH)=
/../../ \
                O=3D OUTPUT=3D$(LIBBPF_OUTPUT)/ DESTDIR=3D$(LIBBPF_DESTDIR)=
 prefix=3D \
                $@ install_headers
---------------------------------------------------- >8 ---

(and maybe peek a better name for COMMON_CFLAGS).


