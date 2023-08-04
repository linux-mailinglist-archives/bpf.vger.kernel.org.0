Return-Path: <bpf+bounces-7027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE063770629
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 18:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7E21C2190E
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 16:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F334CA69;
	Fri,  4 Aug 2023 16:41:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49DBE4A;
	Fri,  4 Aug 2023 16:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E309FC433C7;
	Fri,  4 Aug 2023 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691167301;
	bh=Lkrz5fdo48b6U0XEshqshN85hsfuLrLwvnvbpsynonc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6SG1fYK5kOKTSvTYFMeKkaub/Q3bf1uWHe2FAHjqIM6NRYeKVy857xoXTe4DSPp8
	 jNSNKZ0oOdlmwuOBGq2V6yov6ZHUiDGyrvsrnSVd8vNV5qT2sftmLMTcqo63DEkUZB
	 oaG3Fll/aCLu+Tz9sWZtEXW/YntuVw+ERoJhLd1zXolNXx4EXDVIX6f7f+vCs4Zj+y
	 +FDt2H/aR96JHssD+R/KNFajQpr3gQEx6k1mAlortirGpz6naOMs9IGLZKdzB3dJuT
	 2JULxnROeXJ3qmCwQIoRY6oiPWe+zkFTiuNKSXePH9pVSQj8tGMdp+Lw+jtyBED3XL
	 HNLoUpBT+TBPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id BCB7C404DF; Fri,  4 Aug 2023 13:41:38 -0300 (-03)
Date: Fri, 4 Aug 2023 13:41:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, martin.lau@linux.dev,
	bpf <bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>,
	Tomasz =?utf-8?B?UGF3ZcWC?= Gajc <tpgxyz@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, m.seyfarth@gmail.com,
	Fangrui Song <maskray@google.com>
Subject: Re: FAILED: load BTF from vmlinux: Invalid argument
Message-ID: <ZM0qQlvd1VKoCeIO@kernel.org>
References: <CAKwvOdm9PqNBLSZa_t5b=15cdtKvKq4q8WZr3i77W66m4FRAAQ@mail.gmail.com>
 <ZMwQivemlha+fU5i@kernel.org>
 <CAKwvOd=w3PFMDyZ1WL1DDx0Gyt-+sh7hYP_+8b9zEFu3uZpVXQ@mail.gmail.com>
 <afe71df3-48e4-837a-e85d-b6a6764eee62@oracle.com>
 <CAKwvOdn93Zpdkk3faNNdDw=tnMQ6Mxo5tTVCDmrqStU95MVQqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdn93Zpdkk3faNNdDw=tnMQ6Mxo5tTVCDmrqStU95MVQqA@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Fri, Aug 04, 2023 at 09:11:09AM -0700, Nick Desaulniers escreveu:
> + Marcus (who also just reported seeing this
> https://github.com/ClangBuiltLinux/linux/issues/1825#issuecomment-1664671027
> and might be able to help reproduce).
> + Fangrui (because seeing dd used as a result of 90ceddcb4950 makes me shudder)
> 
> On Thu, Aug 3, 2023 at 3:10 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On 03/08/2023 21:50, Nick Desaulniers wrote:
> > > On Thu, Aug 3, 2023 at 1:39 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > >>
> > >> Em Thu, Aug 03, 2023 at 11:02:46AM -0700, Nick Desaulniers escreveu:
> > >>> Hi Martin (and BTF/BPF team),
> > >>> I've observed 2 user reports with the error from the subject of this email.
> > >>> https://github.com/ClangBuiltLinux/linux/issues/1825
> > >>> https://bbs.archlinux.org/viewtopic.php?id=284177
> > >>>
> > >>> Any chance you could take a look at these reports and help us figure
> > >>> out what's going wrong here?  Nathan and I haven't been able to
> > >>> reproduce, but this seems to be affecting OpenMandriva (and Tomasz).
> > >>>
> > >>> Sounds like perhaps llvm-objcopy vs gnu objcopy might be a relevant detail?
> > >>
> > >> Masami had a problem with new versions of compilers that was solved
> > >> with:
> > >>
> > >> ------------------------ 8< --------------------------------------------
> > >>> To check that please tweak:
> > >>>
> > >>> ⬢[acme@toolbox perf-tools-next]$ grep DWARF ../build/v6.2-rc5+/.config
> > >>> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> > >>> # CONFIG_DEBUG_INFO_DWARF4 is not set
> > >>> # CONFIG_DEBUG_INFO_DWARF5 is not set
> > >>> ⬢[acme@toolbox perf-tools-next]$
> > >>>
> > >>> i.e. disable CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT and enable
> > >>> CONFIG_DEBUG_INFO_DWARF4.
> > >>
> > >> Hm, with CONFIG_DEBUG_INFO_DWARF4, no warning were shown.
> > >
> > > Downgrading from the now-6-year-old DWARFv5 to now-13-year-old DWARFv4
> > > is not what I'd consider a fix. Someday we can move to
> > > DWARFv5...someday...
> > >
> > > What you describe sounds like build success, but reduction in debug info.
> > >
> > > The reports I'm referring to seem to result in a build failure.
> > >
> >
> > This is a strange one. The error in question
> >
> > CC .vmlinux.export.o
> > UPD include/generated/utsversion.h
> > CC init/version-timestamp.o
> > LD .tmp_vmlinux.btf
> > BTF .btf.vmlinux.bin.o
> > libbpf: BTF header not found
> > pahole: .tmp_vmlinux.btf: Invalid argument
> 
> That's slightly different from Tomasz and Marcus' report (not sure if
> that's relevant):
> 
> FAILED: load BTF from vmlinux: Invalid argument
> 
> That seems to come from
> tools/bpf/resolve_btfids/main.c:529
> Which seems like some failed call to btf_parse().
> EINVAL is getting propagated up from btf_parse(), but that's not super
> descriptive...

Jiri, have you stumbled on this before? 

- Arnaldo
 
> The hard part is that I suspect OpenMandriva (Tomasz) and Marcus are
> both setting additional flags in their toolchains, which can make
> reproducing tricky.
> 
> >
> > ...occurs during BTF parsing when the raw size of the BTF is smaller
> > than the BTF header size, which should never happen unless BTF
> > is corrupted. Thing is, at that stage we shouldn't be parsing BTF,
> > we should be generating it from DWARF. The only time pahole parses BTF
> > is when it's creating split BTF for modules (it parses the base BTF), or
> > when it's reading existing BTF, neither of which it should be doing at
> > this stage.
> >
> > But I suspect the issue is in gen_btf() in scripts/link-vmlinux.sh.
> > Prior to running pahole, we call "vmlinux_link .tmp_vmlinux.btf".
> > If that went awry somehow and .tmp_vmlinux.btf wasn't created, it
> 
> Wouldn't we expect some kind of linker error though in that case?
> 
> > would explain the "Invalid argument" error:
> >
> > $ pahole -J nosuchfile
> > pahole: nosuchfile: Invalid argument
> >
> > I see some clang specifics in vmlinux_link(), so I think a good
> > first step would be to check if .tmp_vlinux.btf exists prior
> > to running pahole. The submitter mentioned swapping linkers seems to
> > help, so that seems a promising angle. If there's a kernel .config
> > available I can try and reproduce the failure too. Thanks!
> >
> > Alan
> >
> > >>
> > >>   LD      .tmp_vmlinux.btf
> > >>   BTF     .btf.vmlinux.bin.o
> > >>   LD      .tmp_vmlinux.kallsyms1
> > >>
> > >> And
> > >>
> > >> / # strings /sys/kernel/btf/vmlinux | wc -l
> > >> 89921
> > >> / # strings /sys/kernel/btf/vmlinux | grep -w kfree
> > >> kfree
> > >>
> > >> It seems the BTF is correctly generated. (with DWARF5, the number of symbols
> > >> are about 30000.)
> > >
> > >
> > >
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers

-- 

- Arnaldo

