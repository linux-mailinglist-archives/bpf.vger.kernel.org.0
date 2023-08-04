Return-Path: <bpf+bounces-6961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C20B76FBB4
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 10:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E301C21523
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A698BF1;
	Fri,  4 Aug 2023 08:10:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A179EF;
	Fri,  4 Aug 2023 08:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E85C433C7;
	Fri,  4 Aug 2023 08:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691136620;
	bh=n/fbxmZgAXx2EhdsI/2S74fch9nO3iVOz+1LpZmWgnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iu2MzKzcD2cspKi4j0qUBryfPs2H/VDOcp+QbnswsIQM++ze1K8Bqc67hs9Pytgnf
	 qPnHbJdmC4z90XYPZB3IrIcphE40CclpvvHcMKdIh/MKJEteGCEYaPQ+Ju/EHJD2i8
	 5pKPJuuH7dOBEl3OkpgzQNIb/KIgC46EMqXVkgKeKioszFuu4XtYe5GcUFrhTesWpC
	 72feH3UcNJJknPm6bI9uT7t2JvfPRCrimNQIX+7kU2TMKSA1U7Y9r05Yvx+yuvgAvq
	 QdUk+gbk6la6YfjiJVec8Y/TJqXXxZXTXGfKTa3fP9AoGZ2ul4NDIhHZ/uZdlVhEmv
	 potgPC1tdJ02w==
Date: Fri, 4 Aug 2023 17:10:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, martin.lau@linux.dev, bpf
 <bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, Tomasz
 =?UTF-8?B?UGF3ZcWC?= Gajc <tpgxyz@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: FAILED: load BTF from vmlinux: Invalid argument
Message-Id: <20230804171016.5676b193723d400dec062f5f@kernel.org>
In-Reply-To: <CAKwvOd=w3PFMDyZ1WL1DDx0Gyt-+sh7hYP_+8b9zEFu3uZpVXQ@mail.gmail.com>
References: <CAKwvOdm9PqNBLSZa_t5b=15cdtKvKq4q8WZr3i77W66m4FRAAQ@mail.gmail.com>
	<ZMwQivemlha+fU5i@kernel.org>
	<CAKwvOd=w3PFMDyZ1WL1DDx0Gyt-+sh7hYP_+8b9zEFu3uZpVXQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Nick,

On Thu, 3 Aug 2023 13:50:02 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Thu, Aug 3, 2023 at 1:39 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Thu, Aug 03, 2023 at 11:02:46AM -0700, Nick Desaulniers escreveu:
> > > Hi Martin (and BTF/BPF team),
> > > I've observed 2 user reports with the error from the subject of this email.
> > > https://github.com/ClangBuiltLinux/linux/issues/1825
> > > https://bbs.archlinux.org/viewtopic.php?id=284177
> > >
> > > Any chance you could take a look at these reports and help us figure
> > > out what's going wrong here?  Nathan and I haven't been able to
> > > reproduce, but this seems to be affecting OpenMandriva (and Tomasz).
> > >
> > > Sounds like perhaps llvm-objcopy vs gnu objcopy might be a relevant detail?
> >
> > Masami had a problem with new versions of compilers that was solved
> > with:
> >
> > ------------------------ 8< --------------------------------------------
> > > To check that please tweak:
> > >
> > > ⬢[acme@toolbox perf-tools-next]$ grep DWARF ../build/v6.2-rc5+/.config
> > > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> > > # CONFIG_DEBUG_INFO_DWARF4 is not set
> > > # CONFIG_DEBUG_INFO_DWARF5 is not set
> > > ⬢[acme@toolbox perf-tools-next]$
> > >
> > > i.e. disable CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT and enable
> > > CONFIG_DEBUG_INFO_DWARF4.
> >
> > Hm, with CONFIG_DEBUG_INFO_DWARF4, no warning were shown.
> 
> Downgrading from the now-6-year-old DWARFv5 to now-13-year-old DWARFv4
> is not what I'd consider a fix. Someday we can move to
> DWARFv5...someday...

Actually, even with DWARFv5, if I use newer clang, pahole succeded to make
BTF info. So it may depend on compiler version too.

> 
> What you describe sounds like build success, but reduction in debug info.
> 
> The reports I'm referring to seem to result in a build failure.

Yeah, it seems a different issue. I could build it at least.

Thank you,

> 
> >
> >   LD      .tmp_vmlinux.btf
> >   BTF     .btf.vmlinux.bin.o
> >   LD      .tmp_vmlinux.kallsyms1
> >
> > And
> >
> > / # strings /sys/kernel/btf/vmlinux | wc -l
> > 89921
> > / # strings /sys/kernel/btf/vmlinux | grep -w kfree
> > kfree
> >
> > It seems the BTF is correctly generated. (with DWARF5, the number of symbols
> > are about 30000.)
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

