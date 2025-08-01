Return-Path: <bpf+bounces-64899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E54CEB184D5
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B8C3B319B
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5103B27146A;
	Fri,  1 Aug 2025 15:19:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689E1D7E37;
	Fri,  1 Aug 2025 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061545; cv=none; b=fUoVsbiR+VaqvXRzIcvXBYPQNVVqQR2uc/vL803upE0vGMgNcJsiFmpvHScP/XoVSXtxRvtXDmEmSoXNEojvMvAYXldb2teVivZrTFI3gWsi3DsPb/gK7R+wiLVZUciA2Empb80kNzwIAyWR3fz7XXr2pGXzPbdr9LfTZcI5r/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061545; c=relaxed/simple;
	bh=MJt1O5PgGCgdKLxzhcyGpMTDCKhMZs8K5bnjRub5LYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgqMRf6uqcsk7dK1LQirfTfkC8WDwMDyzQLcxw6aEcx/Yz1DzPOy08PiqlrxAizqEuF1sgrMwPCix3kYJcmPsTA1moE0xVHls5VYGdwRKmu+VrJQEAUOJ6n90EpYml2vL4mrPfIy84bfufnYGZcC4cZXs65NRGQ65t/87WOSji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 6FC801139E9;
	Fri,  1 Aug 2025 15:19:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 98F5120024;
	Fri,  1 Aug 2025 15:18:58 +0000 (UTC)
Date: Fri, 1 Aug 2025 11:19:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH] btf: Simplify BTF logic with use of __free(btf_put)
Message-ID: <20250801111919.13c0620e@gandalf.local.home>
In-Reply-To: <CAADnVQLFLSwrnHKZUtUpwQ1tst71AfYCcbbtK2haxF=R9StpSw@mail.gmail.com>
References: <20250801071622.63dc9b78@gandalf.local.home>
	<CAADnVQLky+R-tfkGaDo-R_-tJ8E3bmWz8Ug7etgTKsCpfXTSKw@mail.gmail.com>
	<20250801110705.373c69b4@gandalf.local.home>
	<CAADnVQLFLSwrnHKZUtUpwQ1tst71AfYCcbbtK2haxF=R9StpSw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uh8zk8moytwqhj6gqjk57ygys15kzhr8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 98F5120024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/C2s2qNC4iOOfdt7rTFaR3WFgLRxItvbM=
X-HE-Tag: 1754061538-639185
X-HE-Meta: U2FsdGVkX1+Qh4hk+SHCZoUjeaYpTw1e78S+soH8knU75LmgkQQkfwOhuLesDj8onmziu/yPQb5SiRixNA/AoOjU2YoHOTaXWFHkwokG7hoRNbHdhKHZ72XCxiNJJDi83wAjHtZx/CeF4x2JvxB3DQ7fGofSjvHQPjJQ6RcTJIUUz7z1Hrb5oynfKt034Cd6nf53OCIW915lJ+urdM6zdVFBqke6OFSvpV1BxFNKhiRoYQeV4WBUKhbciHPmVJ+0mXtSwhNNoQpzyZYJkM8QK3PJUh51Hn4Hozt8RFtib1GOY5YkrzmmIp3at5zaQ0VYGGX8QmM14mH6DxufsZcYrdFvu1iBwBmj

On Fri, 1 Aug 2025 08:12:08 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> 
> You can use it in kernel/trace/trace_output.c, of course,

I guess that means I should just use the DEFINE_FREE() in that file
directly and not in the btf.h header file?

> but I really think it's a step back in maintainability.
> All this cleanup.h is not a silver bullet. It needs to be used sparingly.

I have my reservations about the cleanup.h code too. But the more I use it,
the more I like it. My biggest worry is guard() leak. That is, having a
lock or interrupt/preemption disabled for longer than they need to be,
because code was added at the end of the function after the protection is
needed.

-- Steve

