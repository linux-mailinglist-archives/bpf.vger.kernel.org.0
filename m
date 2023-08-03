Return-Path: <bpf+bounces-6895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB73976F416
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 22:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BCF2823B2
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 20:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD912590D;
	Thu,  3 Aug 2023 20:39:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864CF1F92A;
	Thu,  3 Aug 2023 20:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C455BC433C8;
	Thu,  3 Aug 2023 20:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691095181;
	bh=vq+ZJscQSHTgASapItxHVYRsoff6DX1V6z69uDZoFh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sgl8Rmy/e101ZLtrkJg/ik+2pApx/tTe0cL5y0IduDNCEDQcemfWOlvGfNqjv2Mhr
	 NexFGQbQ8zgVOa9jFWZ+PHnEAhG4aanJdBlVewc0b5nqGm9hasQYP74TR3O/mYwLmW
	 6Zo08hHXVW1AjFavKQYaucOkLHucGBVakxgvDdvm8OAtXKGwspwcFsVaWByIe+pjnz
	 lDeKEaFN4qZqhBWJihi8gyoJuuqD9fprAySC9WKDCAwpBN7QpGLhpgLeyMAqqPlpew
	 XLd3PjJqf3R37aDGuyIARo8PJkvGX00bm3wFZGow+K4gW70ohHgCY2Y2sJH6k0d4b1
	 50BVBwA7tTJAg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 363B3404DF; Thu,  3 Aug 2023 17:39:38 -0300 (-03)
Date: Thu, 3 Aug 2023 17:39:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: martin.lau@linux.dev, bpf <bpf@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	Tomasz =?utf-8?B?UGF3ZcWC?= Gajc <tpgxyz@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: FAILED: load BTF from vmlinux: Invalid argument
Message-ID: <ZMwQivemlha+fU5i@kernel.org>
References: <CAKwvOdm9PqNBLSZa_t5b=15cdtKvKq4q8WZr3i77W66m4FRAAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdm9PqNBLSZa_t5b=15cdtKvKq4q8WZr3i77W66m4FRAAQ@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Thu, Aug 03, 2023 at 11:02:46AM -0700, Nick Desaulniers escreveu:
> Hi Martin (and BTF/BPF team),
> I've observed 2 user reports with the error from the subject of this email.
> https://github.com/ClangBuiltLinux/linux/issues/1825
> https://bbs.archlinux.org/viewtopic.php?id=284177
> 
> Any chance you could take a look at these reports and help us figure
> out what's going wrong here?  Nathan and I haven't been able to
> reproduce, but this seems to be affecting OpenMandriva (and Tomasz).
> 
> Sounds like perhaps llvm-objcopy vs gnu objcopy might be a relevant detail?

Masami had a problem with new versions of compilers that was solved
with:

------------------------ 8< --------------------------------------------
> To check that please tweak:
>
> ⬢[acme@toolbox perf-tools-next]$ grep DWARF ../build/v6.2-rc5+/.config
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> ⬢[acme@toolbox perf-tools-next]$
>
> i.e. disable CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT and enable
> CONFIG_DEBUG_INFO_DWARF4.

Hm, with CONFIG_DEBUG_INFO_DWARF4, no warning were shown.

  LD      .tmp_vmlinux.btf
  BTF     .btf.vmlinux.bin.o
  LD      .tmp_vmlinux.kallsyms1

And

/ # strings /sys/kernel/btf/vmlinux | wc -l
89921
/ # strings /sys/kernel/btf/vmlinux | grep -w kfree
kfree

It seems the BTF is correctly generated. (with DWARF5, the number of symbols
are about 30000.)

