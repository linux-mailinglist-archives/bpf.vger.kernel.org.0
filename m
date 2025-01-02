Return-Path: <bpf+bounces-47785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B773A0002D
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 21:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E4E3A12C4
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD14F1B85C9;
	Thu,  2 Jan 2025 20:44:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563AB42AA2;
	Thu,  2 Jan 2025 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735850680; cv=none; b=SrcZWqTKqcXMSyLZAdQl0Me8M4klQOIj3GK8bpPtFvmcfKes8In3ssF/Qw0OxFGBKTns7orES0XGL8mZe8ZZBSl+OQrI6QVMy7ZIWmxi2oeUxt1swXt2F3QTpFtv9Rm2JHx50Tjvty23D/OC71a/tchyji15Bu18WSgGdb+C07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735850680; c=relaxed/simple;
	bh=gO6ZzICJtebDtgy2f/ARkKe5Ekf3d5/1wVclWuN+WCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rippU2ptcYoFxqYXM2tpOewyWrJvlnorcr8nYDBGNFjYk74GahvQ4RaNgxjOKLoh4WiNrhV11q5PNcj4Fw80/sPKy9AFD4CokAOg1BrFsmNDumUFpDHW+mrJ+dNrOnmxxHBnMWwgue/hTIowHo7Arnw24ItQGdehG8CPvcEH3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2661AC4CED0;
	Thu,  2 Jan 2025 20:44:38 +0000 (UTC)
Date: Thu, 2 Jan 2025 15:45:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>, Martin Kelly
 <martin.kelly@crowdstrike.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 14/14] scripts/sorttable: ftrace: Do not add weak
 functions to available_filter_functions
Message-ID: <20250102154554.07569e51@gandalf.local.home>
In-Reply-To: <20250102203625.GF7274@noisy.programming.kicks-ass.net>
References: <20250102185845.928488650@goodmis.org>
	<20250102190105.506164167@goodmis.org>
	<20250102194814.GA7274@noisy.programming.kicks-ass.net>
	<20250102145501.3e821c56@gandalf.local.home>
	<20250102202404.GD7274@noisy.programming.kicks-ass.net>
	<20250102153016.7fc5e443@gandalf.local.home>
	<20250102203625.GF7274@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 21:36:25 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> I'm not sure I understand, up until you've started userspace, nobody
> cares about those weird indexes.

The ftrace table is used for accounting. What is enabled, how many
attached, how are they attached (direct calls, ftrace_with_regs,
trampolines, etc). They are not something I want to update once it is
created. I guess it could be done by preventing any changes from happening,
and recreating them before the file could be examined.

But having them removed at build time seems so much more efficient.

At least it gave me the incentive to create the first 13 patches of this
series, to make the sorttable code much easier to digest. ;-) Which I would
add no matter the solution we come up with.

-- Steve

