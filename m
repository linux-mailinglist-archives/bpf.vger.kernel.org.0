Return-Path: <bpf+bounces-52404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D3FA42AF2
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D2D7ABC9E
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C473D265CA8;
	Mon, 24 Feb 2025 18:14:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DBE264F88;
	Mon, 24 Feb 2025 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420885; cv=none; b=bQBomXO7xBuFwchEalJ8wB6vYbdCuPOGuFNGCffm9BlBV2V8d09gxHeyDoDm9ODaJue2rp8tLc56J6LZpHusYnaRBCRUYxvSsHwu7LK/EbcftZGQfOAmNCC40sy1swA8D8eeDKIlx1Jlu22UxA7D4cjiNARFyuAahH4Il3dYpt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420885; c=relaxed/simple;
	bh=/s0XGqofsuu7ODp5LQuTxhbS8POtR/ORGiT+1DkaJac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxuVmJ555UGoUiS/EdvIXMaM9Szt8BE6lq7C5nP/WIdgHdeqCVOa1DRQHYzjoq0qhKcmtWaV1p0CqN9zPS2KH+aCRZgKw19ZARw1e/mBV/F/YNZCyYLdv8IqRCf10RjGIgm0nybw719uHXUcQxkEXBOxQvJQlXZzKRjWEjFMubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A10EC4CEDD;
	Mon, 24 Feb 2025 18:14:42 +0000 (UTC)
Date: Mon, 24 Feb 2025 13:15:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>, Martin Kelly
 <martin.kelly@crowdstrike.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, Heiko
 Carstens <hca@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>
Subject: Re: [for-next][PATCH 4/6] scripts/sorttable: Zero out weak
 functions in mcount_loc table
Message-ID: <20250224131518.61ef53ed@gandalf.local.home>
In-Reply-To: <20250224180805.GA1536711@ax162>
References: <20250219151815.734900568@goodmis.org>
	<20250219151904.476350486@goodmis.org>
	<20250224180805.GA1536711@ax162>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 10:08:05 -0800
Nathan Chancellor <nathan@kernel.org> wrote:

> Our CI and KernelCI reports that this change as commit ef378c3b8233
> ("scripts/sorttable: Zero out weak functions in mcount_loc table") in
> next-20250224 breaks when an architecture does not have kaslr_offset()
> defined:
> 
>   $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mrproper allmodconfig kernel/trace/ftrace.o
>   kernel/trace/ftrace.c: In function 'ftrace_process_locs':
>   kernel/trace/ftrace.c:7074:24: error: implicit declaration of function 'kaslr_offset' [-Wimplicit-function-declaration]
>    7074 |         kaslr = !mod ? kaslr_offset() : 0;
>         |                        ^~~~~~~~~~~~
> 
> https://lore.kernel.org/CACo-S-0GeJjWWcrGvos_Avg2FwGU2tj2QZpgoHOvPT+YbyknSg@mail.gmail.com/

Thanks, I'll add a patch to put an #ifdef around it.

Now the question is, can it still change the address of it with out kaslr_offset()?

-- Steve

