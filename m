Return-Path: <bpf+bounces-47810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1A8A001C7
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 00:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49223A5BA4
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 23:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AA61BEF67;
	Thu,  2 Jan 2025 23:29:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE91BC061;
	Thu,  2 Jan 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735860592; cv=none; b=ZbHqeUO3ewOp/eZ5Pskel46VTJQ2tIyGtmNFW2Lihz0aO42SlqDveZziLqPX4SFI4YE6LAc7IPDo7sBCNbH5pFVEefkUzgg5Xe/FHhMx5aFjIoF7XTToiAZDC1xBBu/la3494DwVIyA6ccenOOgzawNSxAbvsSSH3ch3x+Z8SgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735860592; c=relaxed/simple;
	bh=nWaQjzo8qqjV6+ZLeaVBFaMtw9JIlFf+TrWTKx8SwXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SK9Z6oWiTlWyndcn+IM9ALgmZrvBuzQGo2xM6mcUGuEgBD4I71xPhgyRdBA7HG2i4ZYLepKBWrxyjrPe64P1NeOghpJ+OIP98nbfnK7YWkxf0WK9Xw3NAAHP6MrM5g//g/degMMGVWjY2w5fI6crOkyR2iIkFhEUHTx4xCoU72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B92CC4CED0;
	Thu,  2 Jan 2025 23:29:50 +0000 (UTC)
Date: Thu, 2 Jan 2025 18:31:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Zheng Yejian
 <zhengyejian1@huawei.com>, Martin  Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf
 <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 00/16] scripts/sorttable: ftrace: Remove place
 holders for weak functions in available_filter_functions
Message-ID: <20250102183106.38b06f05@gandalf.local.home>
In-Reply-To: <20250102232609.529842248@goodmis.org>
References: <20250102232609.529842248@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 02 Jan 2025 18:26:09 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Steven Rostedt (16):
>       scripts/sorttable: Remove unused macro defines
>       scripts/sorttable: Remove unused write functions
>       scripts/sorttable: Remove unneeded Elf_Rel
>       scripts/sorttable: Have the ORC code use the _r() functions to read
>       scripts/sorttable: Make compare_extable() into two functions
>       scripts/sorttable: Convert Elf_Ehdr to union
>       scripts/sorttable: Replace Elf_Shdr Macro with a union
>       scripts/sorttable: Convert Elf_Sym MACRO over to a union
>       scripts/sorttable: Add helper functions for Elf_Ehdr
>       scripts/sorttable: Add helper functions for Elf_Shdr
>       scripts/sorttable: Add helper functions for Elf_Sym
>       scripts/sorttable: Use uint64_t for mcount sorting
>       scripts/sorttable: Move code from sorttable.h into sorttable.c
>       scripts/sorttable: Get start/stop_mcount_loc from ELF file directly

Note. These first 14 patches are simply clean up patches to the sorttable.c
code. I would like to start testing these and add them to linux-next, as I
do not believe they are controversial. They should not have any real
functional change, but it would still be good to test them on other
architectures outside of the mcount code.

The last two patches are what handle the weak functions in mcount_loc. I'll
hold off on those till after the v6.14 merge window.

-- Steve

