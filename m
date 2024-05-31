Return-Path: <bpf+bounces-31000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 009E18D5C77
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 10:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8511C21BCE
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 08:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9EF7B3EB;
	Fri, 31 May 2024 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7zlrYX2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B85588D;
	Fri, 31 May 2024 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143207; cv=none; b=aFizwI2N7OIRrqq/OIw0WLXIwT8CO2XHdCdAptyYfi67VhzYkkdRAicemZfr2pKz2D4Q21DxXAJQsfyd0p+SMFdxP5HxavxKzLD/HpqAke3qwG5thHudq6/9MmetRFvbNu68u+e9ZZmLRkgHkLI2vGnGJoRTMELT7F4B4c1hmiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143207; c=relaxed/simple;
	bh=wDyZkf28JsJ5TohSO2vSxwaGAZmLOJOoNv5aSa1U16w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnhBpTn8p2fwB4MFwFc/cxXtOPhCdd0skN4BBhXVioNbhJGOtcaHnuYET4VbJMscbt4Gn57c6CDg2KbN/kkVKzHRVfEa4qcBaHD8HwIMSnycV4zNeUsIWYN0lBRAhza3pQJ7gSYGhK1ZP3y8pIc0w3IM5wPgZDTWQllJdzNVXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7zlrYX2; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b7ebb2668so1991300e87.2;
        Fri, 31 May 2024 01:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717143203; x=1717748003; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hwcwTxOA0LgSmJEDTw/wqCjtExC/6SA0GpZ98SrAk50=;
        b=T7zlrYX29xoaErlFSZOTVH/+RHXCRi7qx4egYe4aY+VpQ9Q7DkKxp4AyZHwwpwMla0
         eXg68dZimi2nSGcHdDgZrDpQXiPBqN0lIi04BMaUU4toYK3ds6XzrQEjAmjZ68+mMZLX
         HaVqO8iStMkfPf3WgnNDG39L4flhzsAlXVF8SQIHBgNawef6eIwQ7E1dHb6Et5h8X344
         GpDvpdupwJlggbxdUTQN9F8HsNflFcu82MzdiTo19/yWaxvmgCJZOQ1ibGnRS37OKL0F
         1og1hidlk/kEShm24sDmBBhdJcfoS9FRFHifaLt2+DBVZFK8TKeqZcdCAwuePdSHMCTs
         gaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717143203; x=1717748003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwcwTxOA0LgSmJEDTw/wqCjtExC/6SA0GpZ98SrAk50=;
        b=QnUw+sVwEO2XQ1NRCg3DjLkUwdaSIb8C9+Nodp5LV8koPxlkIubYbR3OOq6ub7al/m
         jFsH8MN2P0acJbqwkZ8BKFHqGuF3haUpL4CbQaCXZUFQNFqxHd8jVtuSdgH6yrclkFnl
         3lQAg+CaATVqAfCjimJFOFW6ntSh/fL3z9JVwygmLgyWtGR1IdQQWTmSin4n8OLYflm+
         GIxXSA+Eb4ApXMC+j6cwxF6cJkTDQnz8PyN2XM1XySxCkcWnSVGu3nGIdQ3KFpk9N+c/
         wbtLk/xX2wnE2AIQTqawCeIfg7Yvf3IWB+uso7NMc+O7PG/1ipNaOqI5VZDdnkLItb1i
         7m4w==
X-Forwarded-Encrypted: i=1; AJvYcCXMjJyRTCcqZrEG2v9K7N62IaL9pxfu4PsXDbjkm/+R9tmaxrCpp3eLO0lAlpwrVTG/N19g6CJVvr89nK3Dpmh3Pr/KM2uAGd95I0yKz6sdvJcP+u5aG0EnuErrJw==
X-Gm-Message-State: AOJu0Yxw2VXJEksjIFW7pcnc5cRyHH+PjLqjG7c5fNpdyjSc8IRI+Ij3
	eutAKkNEObsMDY/2NFZeSIS7N0dqzKkCfIejw8/XkRO7J4Efk2igBFk53w==
X-Google-Smtp-Source: AGHT+IEUDBohkxpKzw7dY/TJ4dRmwKLweh+N7S8ESJmRBO9axc+Y9g8dsQUVliE4ydd4hmbE60EjTw==
X-Received: by 2002:a05:6512:2508:b0:529:b691:e37e with SMTP id 2adb3069b0e04-52b895715eemr1045142e87.40.1717143203005;
        Fri, 31 May 2024 01:13:23 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eb621507sm59793966b.222.2024.05.31.01.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 01:13:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 31 May 2024 10:13:21 +0200
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Problem with BTF generation on mips64el
Message-ID: <ZlmGoT9KiYLZd91S@krava>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>

On Fri, May 31, 2024 at 10:17:53AM +0800, Hengqi Chen wrote:
> Hi Tony,
> 
> On Fri, May 31, 2024 at 9:30 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > Hello,
> >
> > For some time now I'm seeing multiple issues during BTF generation while
> > building recent kernels targeting mips64el, and would appreciate some help
> > to understand and fix the problems.
> >
> > Some relate to resolve_btfids:
> >
> > >   LD      vmlinux
> > >   BTFIDS  vmlinux
> > > WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
> > > WARN: resolve_btfids: unresolved symbol bpf_session_cookie
> > > WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
> > > WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
> > > WARN: resolve_btfids: unresolved symbol bpf_key_put
> > > WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
> > > WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
> > > WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
> > > WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
> > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
> > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
> > > WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
> > > WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
> > >   NM      System.map
> > >   SORTTAB vmlinux
> > >   OBJCOPY vmlinux.32
> >
> > These do not appear to be #ifdef-related and have similar past reports [1].

I can reproduce the warning just for bpf_session_cookie,
which has fix in progress:
  https://lore.kernel.org/bpf/20240531071557.MvfIqkn7@linutronix.de/T/#t

> >
> > I also see many pahole failures during BTF encoding of modules, such as:
> >
> > >   CC [M]  net/ipv6/netfilter/nft_fib_ipv6.mod.o
> > >   CC [M]  net/ipv6/netfilter/ip6t_REJECT.mod.o
> > >   CC [M]  net/psample/psample.mod.o
> > >   LD [M]  crypto/cmac.ko
> > >   BTF [M] crypto/cmac.ko
> > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit
> > > or DW_TAG_skeleton_unit expected got member (0xd)!
> 
> The issue seems to be related to elfutils. Have you tried build from
> the latest elfutils source ?
> I saw the latest MIPS backend in elfutils already implemented the
> reloc_simple_type hook.

hi,
+1, could you also check the pahole version you used?

jirka

> 
> > >   LD [M]  lib/test_bpf.ko
> > >   BTF [M] lib/test_bpf.ko
> > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit
> > > or DW_TAG_skeleton_unit expected got member (0xd)!
> > >   LD [M]  lib/crc-ccitt.ko
> > >   BTF [M] lib/crc-ccitt.ko
> > > die__process_unit: DW_TAG_compile_unit (0x11) @ <0x9331> not handled!
> > > die__process_unit: tag not supported 0x11 (compile_unit)!
> > > die__process: got compile_unit unexpected tag after DW_TAG_compile_unit!
> > >   LD [M]  lib/libcrc32c.ko
> > >   BTF [M] lib/libcrc32c.ko
> > > die__process_unit: DW_TAG_compile_unit (0x11) @ <0x99a5> not handled!
> > > die__process_unit: tag not supported 0x11 (compile_unit)!
> > > die__process: got compile_unit unexpected tag after DW_TAG_compile_unit!
> > >   LD [M]  lib/ts_kmp.ko
> > >   BTF [M] lib/ts_kmp.ko
> > >   LD [M]  lib/ts_bm.ko
> > >   BTF [M] lib/ts_bm.ko
> > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit
> > > or DW_TAG_skeleton_unit expected got member (0xd)!
> > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit
> > > or DW_TAG_skeleton_unit expected got member (0xd)!
> >
> > I have seen reports of various similar "die__" messages on the dwarves
> > list and repo, with the hint of an elfutils connection [2] but nothing
> > conclusive.
> >
> > Details of the git commit and build environment are as follows:
> >
> > > $ git log -1 --oneline  bpf/master
> > > 9dfdb706e164 (bpf/master) selftests/bpf: fix inet_csk_accept prototype in
> > > test_sk_storage_tracing.c
> > >
> > > $ lsb_release -a
> > > Description:    Ubuntu 22.04.4 LTS
> > >
> > > $ cat gcc-compile.txt
> > > ARCH=mips CROSS_COMPILE=mips64el-linux-gnuabi64- CC="ccache ${CROSS_COMPILE}gcc" make -j6
> > >
> > > $ mips64el-linux-gnuabi64-gcc --version
> > > mips64el-linux-gnuabi64-gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0
> > >
> > > $ mips64el-linux-gnuabi64-ld --version
> > > GNU ld (GNU Binutils for Ubuntu) 2.38
> > >
> > > $ pahole --version
> > > v1.26
> > >
> > > $ ldd $(which pahole)
> > >         linux-vdso.so.1 (0x00007fff16f3f000)
> > >         libdw.so.1 => /lib/x86_64-linux-gnu/libdw.so.1 (0x00007fc39d42e000)
> > >         libelf.so.1 => /lib/x86_64-linux-gnu/libelf.so.1 (0x00007fc39d410000)
> > >         libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007fc39d3f4000)
> > >         libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fc39d1cb000)
> > >         liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007fc39d1a0000)
> > >         libbz2.so.1.0 => /lib/x86_64-linux-gnu/libbz2.so.1.0 (0x00007fc39d18d000)
> > >         /lib64/ld-linux-x86-64.so.2 (0x00007fc39d59d000)
> > >
> > > $ dpkg -s elfutils
> > > Package: elfutils
> > > ...
> > > Version: 0.186-1build1
> > > Depends: libasm1 (>= 0.132), libc6 (>= 2.34), libdw1 (= 0.186-1build1),
> > > libelf1 (= 0.186-1build1), libstdc++6 (>= 4.1.1)
> >
> > For reference, I also attached the full .config and build log from the
> > above.
> >
> > I should add this is not only a problem with the latest bpf/master but
> > also appears to affect the 6.6.x LTS kernel, which I tested while building
> > a mips64el OpenWrt distro image. That build environment employs the latest
> > gcc 13.3, binutils 2.42, pahole 1.26, and elfutils 0.191.
> >
> > Not only do I see similar warnings from resolve_btfids and pahole, but
> > while running the distro image I encounter module loading failures that
> > suggest ELF corruption in some module .ko files, based on the following:
> >
> > > root@OpenWrt:/# strace insmod /lib/modules/6.6.30/nf_conntrack.ko
> > > ...
> > > init_module(0xfff3e36160, 307448, "")   = -1 EINVAL (Invalid argument)
> > > ...
> >
> > > $ man init_module
> > > ...
> > > The following errors may additionally occur for init_module():
> > > ...
> > >      EINVAL param_values is invalid, or some part of the ELF image in
> > >      module_image contains inconsistencies.
> > > ...
> >
> > I'd be grateful if some of the BTF/pahole experts could please review this
> > issue and share next steps or other details I might provide.
> >
> > Thanks,
> > Tony Ambardar
> >
> > Link: https://lore.kernel.org/all/202401211357.OCX9yllM-lkp@intel.com/ [1]
> > Link: https://github.com/acmel/dwarves/issues/45 [2]
> 
> Cheers,
> Hengqi
> 

