Return-Path: <bpf+bounces-30991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836848D5892
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 04:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7AC81C2314C
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 02:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9574E3D;
	Fri, 31 May 2024 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrQVjNVm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF74C6D;
	Fri, 31 May 2024 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717121887; cv=none; b=ntRyXd6L9xpju/C1GfSYTvbLYNBnUYBBhmlI99Vf7F2m1sTb2Kbbqcrj+sFaRD81/e67ZcQVWYM/lchD3m3gNOnxEnv7MQjMq6xbJaIuN/1Cb6dquEDa4B7DMzQOCuiTAmAQfOe+vq1UjZTw8WFhThTR/0KIiMt2wW+H8ia5leA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717121887; c=relaxed/simple;
	bh=lMVnvwybXy8yR2nqhRxUuwWKS7A5lzSdIm/q4TgqH8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OR9CR6ycm5hOSnsAHTdekPf9rDOapHanXXcz7muOyf0ODtybr/YPa3dCZ/vr6Nkc/2T48GLAWdyQNM9iVgb20EzqFs/uq2MnXKXpmOUe51s062eIqxxTXtZ9YeQcmjk+p6a+Ycs/dPK62sAJx40vUpTQuvr2XHCp0gQZSmqB5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrQVjNVm; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24ca21014ccso811266fac.1;
        Thu, 30 May 2024 19:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717121885; x=1717726685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2jJKpYW2xBF8wTl1TEIuXajBFfQtwx2Az/QJcPa93A=;
        b=VrQVjNVm6A6hwMHj8TSQf5HzoY5pbhBFoiv5JQp4lLmnrZyWoUavfHx9rXYSHUTzL3
         u/VtIJ1UqnRhUSdi9YIDYSrdA7lYWn8FEmhHi/FV7VBDGLWbde9FX8De71i1kRkUZacD
         eh7+TKsfIDEPnQ85Ldrs3/fWfxJd+OlfAgOOrXSk/DDDUH/oHVPXhZTHBeZJc7jZIrMs
         AR888G+IGjEaxRKxdrpVdyGejm2wP7KQKZmfvJy8ofMBGBwK5I18G33tHaS3hRUu+Ypx
         giOYm2EFKnONAxX5EC+Oi5qrXQrWq0LipdPAtpNWn8SOThu++SbjY/YuupDPpuZ5RTgG
         64Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717121885; x=1717726685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2jJKpYW2xBF8wTl1TEIuXajBFfQtwx2Az/QJcPa93A=;
        b=qK4Y5UJeVhmic2/sQl50yZQ8/2pdINUcRpGp9vLAkK8KWN1oK3tJ6IJrYTqvDfTPiE
         7z5x96XCS+p8jd4/XaFVo1c9KxwAQY3Uc57JWdkZLWAqonfczisq5AHVH4cJDchn1AJ+
         bL8UEuI6a++nts8x+sOZ16Q/fZR1BfXK55OkbbfSPo9sZTBqiNEJYBfXfrm12Zkf6Fmn
         g5nXzwRRadvSwOPBC1UwwJCJ/akvQzQf5drfLdstlfeeX47TNX47nVVr0CxWyXZp8bLc
         gH7X2iBOpQ1PpQNCAr1TVqGBr99QAZyZueLb3YgPzyuBH8o8oW6zC7/2FCi78CuC/MEK
         bi9g==
X-Forwarded-Encrypted: i=1; AJvYcCV4E843cghYEqESdUEoM0nJTSDIu/FULey6cIXXaHOl7XKrjq9AiCGsu6CxxQLGU8T+v46c/vyYaSUgCzcFJGug4mWPmfZb0Q==
X-Gm-Message-State: AOJu0YxVm766Jac8MwWdzWkJNASMgPYM8jDQIUymUJEiGk7RsId56jn7
	5dFJtb+qma4RSIta8/LTMqlKdr/X8ao5P6otgKSrwKudwb2Xfji+Au5Uoxc98JWn06GXe8L1k7Q
	ypggHZtwAX1vSSOQyVX4fKm63dfl6cm2M
X-Google-Smtp-Source: AGHT+IESCfL9/oWmkYNLCRdJB7hT9Qjc7hJY3CnS/I3vSJXLEd3BSNrSmSZN4mFPdHNgtRRxmYZGCN+y202r6l9uGDs=
X-Received: by 2002:a05:6870:9a1e:b0:24c:a8ca:d091 with SMTP id
 586e51a60fabf-2508c1b9450mr516351fac.56.1717121884520; Thu, 30 May 2024
 19:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
In-Reply-To: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Fri, 31 May 2024 10:17:53 +0800
Message-ID: <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
Subject: Re: Problem with BTF generation on mips64el
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Fri, May 31, 2024 at 9:30=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> Hello,
>
> For some time now I'm seeing multiple issues during BTF generation while
> building recent kernels targeting mips64el, and would appreciate some hel=
p
> to understand and fix the problems.
>
> Some relate to resolve_btfids:
>
> >   LD      vmlinux
> >   BTFIDS  vmlinux
> > WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
> > WARN: resolve_btfids: unresolved symbol bpf_session_cookie
> > WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
> > WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
> > WARN: resolve_btfids: unresolved symbol bpf_key_put
> > WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
> > WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
> > WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
> > WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
> > WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
> > WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
> > WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
> > WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
> >   NM      System.map
> >   SORTTAB vmlinux
> >   OBJCOPY vmlinux.32
>
> These do not appear to be #ifdef-related and have similar past reports [1=
].
>
> I also see many pahole failures during BTF encoding of modules, such as:
>
> >   CC [M]  net/ipv6/netfilter/nft_fib_ipv6.mod.o
> >   CC [M]  net/ipv6/netfilter/ip6t_REJECT.mod.o
> >   CC [M]  net/psample/psample.mod.o
> >   LD [M]  crypto/cmac.ko
> >   BTF [M] crypto/cmac.ko
> > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_uni=
t
> > or DW_TAG_skeleton_unit expected got member (0xd)!

The issue seems to be related to elfutils. Have you tried build from
the latest elfutils source ?
I saw the latest MIPS backend in elfutils already implemented the
reloc_simple_type hook.

> >   LD [M]  lib/test_bpf.ko
> >   BTF [M] lib/test_bpf.ko
> > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_uni=
t
> > or DW_TAG_skeleton_unit expected got member (0xd)!
> >   LD [M]  lib/crc-ccitt.ko
> >   BTF [M] lib/crc-ccitt.ko
> > die__process_unit: DW_TAG_compile_unit (0x11) @ <0x9331> not handled!
> > die__process_unit: tag not supported 0x11 (compile_unit)!
> > die__process: got compile_unit unexpected tag after DW_TAG_compile_unit=
!
> >   LD [M]  lib/libcrc32c.ko
> >   BTF [M] lib/libcrc32c.ko
> > die__process_unit: DW_TAG_compile_unit (0x11) @ <0x99a5> not handled!
> > die__process_unit: tag not supported 0x11 (compile_unit)!
> > die__process: got compile_unit unexpected tag after DW_TAG_compile_unit=
!
> >   LD [M]  lib/ts_kmp.ko
> >   BTF [M] lib/ts_kmp.ko
> >   LD [M]  lib/ts_bm.ko
> >   BTF [M] lib/ts_bm.ko
> > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_uni=
t
> > or DW_TAG_skeleton_unit expected got member (0xd)!
> > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_uni=
t
> > or DW_TAG_skeleton_unit expected got member (0xd)!
>
> I have seen reports of various similar "die__" messages on the dwarves
> list and repo, with the hint of an elfutils connection [2] but nothing
> conclusive.
>
> Details of the git commit and build environment are as follows:
>
> > $ git log -1 --oneline  bpf/master
> > 9dfdb706e164 (bpf/master) selftests/bpf: fix inet_csk_accept prototype =
in
> > test_sk_storage_tracing.c
> >
> > $ lsb_release -a
> > Description:    Ubuntu 22.04.4 LTS
> >
> > $ cat gcc-compile.txt
> > ARCH=3Dmips CROSS_COMPILE=3Dmips64el-linux-gnuabi64- CC=3D"ccache ${CRO=
SS_COMPILE}gcc" make -j6
> >
> > $ mips64el-linux-gnuabi64-gcc --version
> > mips64el-linux-gnuabi64-gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0
> >
> > $ mips64el-linux-gnuabi64-ld --version
> > GNU ld (GNU Binutils for Ubuntu) 2.38
> >
> > $ pahole --version
> > v1.26
> >
> > $ ldd $(which pahole)
> >         linux-vdso.so.1 (0x00007fff16f3f000)
> >         libdw.so.1 =3D> /lib/x86_64-linux-gnu/libdw.so.1 (0x00007fc39d4=
2e000)
> >         libelf.so.1 =3D> /lib/x86_64-linux-gnu/libelf.so.1 (0x00007fc39=
d410000)
> >         libz.so.1 =3D> /lib/x86_64-linux-gnu/libz.so.1 (0x00007fc39d3f4=
000)
> >         libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00007fc39d1cb=
000)
> >         liblzma.so.5 =3D> /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007fc=
39d1a0000)
> >         libbz2.so.1.0 =3D> /lib/x86_64-linux-gnu/libbz2.so.1.0 (0x00007=
fc39d18d000)
> >         /lib64/ld-linux-x86-64.so.2 (0x00007fc39d59d000)
> >
> > $ dpkg -s elfutils
> > Package: elfutils
> > ...
> > Version: 0.186-1build1
> > Depends: libasm1 (>=3D 0.132), libc6 (>=3D 2.34), libdw1 (=3D 0.186-1bu=
ild1),
> > libelf1 (=3D 0.186-1build1), libstdc++6 (>=3D 4.1.1)
>
> For reference, I also attached the full .config and build log from the
> above.
>
> I should add this is not only a problem with the latest bpf/master but
> also appears to affect the 6.6.x LTS kernel, which I tested while buildin=
g
> a mips64el OpenWrt distro image. That build environment employs the lates=
t
> gcc 13.3, binutils 2.42, pahole 1.26, and elfutils 0.191.
>
> Not only do I see similar warnings from resolve_btfids and pahole, but
> while running the distro image I encounter module loading failures that
> suggest ELF corruption in some module .ko files, based on the following:
>
> > root@OpenWrt:/# strace insmod /lib/modules/6.6.30/nf_conntrack.ko
> > ...
> > init_module(0xfff3e36160, 307448, "")   =3D -1 EINVAL (Invalid argument=
)
> > ...
>
> > $ man init_module
> > ...
> > The following errors may additionally occur for init_module():
> > ...
> >      EINVAL param_values is invalid, or some part of the ELF image in
> >      module_image contains inconsistencies.
> > ...
>
> I'd be grateful if some of the BTF/pahole experts could please review thi=
s
> issue and share next steps or other details I might provide.
>
> Thanks,
> Tony Ambardar
>
> Link: https://lore.kernel.org/all/202401211357.OCX9yllM-lkp@intel.com/ [1=
]
> Link: https://github.com/acmel/dwarves/issues/45 [2]

Cheers,
Hengqi

