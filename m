Return-Path: <bpf+bounces-46123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3B49E47C7
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 23:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3522854BC
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58501C3C0A;
	Wed,  4 Dec 2024 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn6SX3cI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CED9191F9C;
	Wed,  4 Dec 2024 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733351129; cv=none; b=t/vGlmX5k5Xr2iaug3kugqa808/uVnE8r5CHe4ilnzEjieXdTn5RG+1XpcfJ2t5ZzO5IgV6n37MeBpL0GA9TjbxAvheP+QlpQJb93aszixDleJ/Isr/SFad7kr+SyuqCXttdBXimI65EjhjTIEyTt1ybsY2ni97cx+Bvv2oRM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733351129; c=relaxed/simple;
	bh=Svhvx/FLqvM3LsSzNvoXTx78IfFZXUGoIjpdQ/ZRB5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmSMq9RtB6bppvwGMWTZRTpojM7v2im0+6E9cGtdlVYlJejUcKQzN9Keyma/WvjOtgWAwr8vE0gv5j4ce8L7p/+CrVMk/Jo25tCZuKasF5WpsEk+YV82jaqBxD9gK52HY7VcBFvYOLmNwyEBasnsJxi+igFyzshC9LuRxmpIm+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn6SX3cI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D269C4CED1;
	Wed,  4 Dec 2024 22:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733351127;
	bh=Svhvx/FLqvM3LsSzNvoXTx78IfFZXUGoIjpdQ/ZRB5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fn6SX3cIr6/3gd0Z71d+obmDUvIDr6O+UyshioD6N7hOOLdMIUk9KlVeCL0GuBP7T
	 kJCpjy2YQ6v7tMjaKWutRkPoIDH2gKtZpEZxmRQVi1apnaM1zYGIxK+ntUz2TvguiQ
	 og+RhvUfhF8XmuNXDxRVeE8JikE/E2vCJdUXean/bxBHM/vdmWLJlB2yoc6dzdnnZP
	 2pIsV2FF7iDPybMsTi+p45iB7MWpfv5kQAiCtOvBHdMByWY37MhthTJZrc+CspmdR+
	 9PbvAdg4wIODFA1fboko7/d+e029YCkUpP1m7+w3ft89gl/cx3VLZ4jfgB0m0J5R+0
	 H/KRaXckwRlDA==
Date: Wed, 4 Dec 2024 14:25:25 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Nick Terrell <terrelln@fb.com>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [PATCH] bpftool: Fix failure with static linkage
Message-ID: <Z1DW1aJ4rYlMI6S1@google.com>
References: <20241204213059.2792453-1-leo.yan@arm.com>
 <Z1DLYCha0-o1RWkF@google.com>
 <bf5da4d3-c317-4616-ac68-0d49bb5815c2@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf5da4d3-c317-4616-ac68-0d49bb5815c2@kernel.org>

Hello,

On Wed, Dec 04, 2024 at 10:08:15PM +0000, Quentin Monnet wrote:
> 2024-12-04 13:36 UTC-0800 ~ Namhyung Kim <namhyung@kernel.org>
> > Hi Leo,
> > 
> > On Wed, Dec 04, 2024 at 09:30:59PM +0000, Leo Yan wrote:
> >> When building perf with static linkage:
> >>
> >>   make O=/build LDFLAGS="-static" -C tools/perf VF=1 DEBUG=1
> >>   ...
> >>   LINK    /build/util/bpf_skel/.tmp/bootstrap/bpftool
> >>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_compress':
> >>   (.text+0x113): undefined reference to `ZSTD_createCCtx'
> >>   /usr/bin/ld: (.text+0x2a9): undefined reference to `ZSTD_compressStream2'
> >>   /usr/bin/ld: (.text+0x2b4): undefined reference to `ZSTD_isError'
> >>   /usr/bin/ld: (.text+0x2db): undefined reference to `ZSTD_freeCCtx'
> >>   /usr/bin/ld: (.text+0x5a0): undefined reference to `ZSTD_compressStream2'
> >>   /usr/bin/ld: (.text+0x5ab): undefined reference to `ZSTD_isError'
> >>   /usr/bin/ld: (.text+0x6b9): undefined reference to `ZSTD_freeCCtx'
> >>   /usr/bin/ld: (.text+0x835): undefined reference to `ZSTD_freeCCtx'
> >>   /usr/bin/ld: (.text+0x86f): undefined reference to `ZSTD_freeCCtx'
> >>   /usr/bin/ld: (.text+0x91b): undefined reference to `ZSTD_freeCCtx'
> >>   /usr/bin/ld: (.text+0xa12): undefined reference to `ZSTD_freeCCtx'
> >>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_decompress':
> >>   (.text+0xbfc): undefined reference to `ZSTD_decompress'
> >>   /usr/bin/ld: (.text+0xc04): undefined reference to `ZSTD_isError'
> >>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_decompress_elf':
> >>   (.text+0xd45): undefined reference to `ZSTD_decompress'
> >>   /usr/bin/ld: (.text+0xd4d): undefined reference to `ZSTD_isError'
> >>   collect2: error: ld returned 1 exit status
> >>
> >> Building bpftool with static linkage also fails with the same errors:
> >>
> >>   make O=/build -C tools/bpf/bpftool/ V=1
> >>
> >> To fix the issue, explicitly link libzstd.
> > 
> > I was about to report exactly the same. :)
> 
> Thank you both. This has been reported before [0] but I didn't find the
> time to look into a proper fix.
> 
> The tricky part is that static linkage works well without libzstd for
> older versions of elfutils [1], but newer versions now require this
> library. Which means that we don't want to link against libzstd
> unconditionally, or users trying to build bpftool may have to install
> unnecessary dependencies. Instead we should add a new probe under
> tools/build/feature (Note that we already have several combinations in
> there, libbfd, libbfd-liberty, libbfd-liberty-z, and I'm not sure what's
> the best approach in terms of new combinations).

I think you can use pkg-config if available.

  $ pkg-config --static --libs libelf
  -lelf -lz -lzstd -pthread 

Thanks,
Namhyung

> 
> [0] https://github.com/libbpf/bpftool/issues/152
> [1] https://github.com/libbpf/bpftool/issues/152#issuecomment-2343131810

