Return-Path: <bpf+bounces-47781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 937999FFFFE
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 21:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613AE162E87
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA21B6D0E;
	Thu,  2 Jan 2025 20:29:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550DB3D96A;
	Thu,  2 Jan 2025 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849742; cv=none; b=jujWLUS1FOtG04ul/s6qswYpMYENmzB5SlXR6OdAb+FVHl1JG6SMnMI7feN3MRJbxYRKlTi+grrRSZ7aV0CnyOt0wDZUL5ADncRlbV9k3YI/IHy/0BbsF5rIq3iu4fz5pKmGJyL1MPDeA9HLAjwyhT53wR+21eWhRJDnZUjc7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849742; c=relaxed/simple;
	bh=CyHLEcjliYawV0oL5hNYajxfVIL/sktmbNfVHGxwf6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmY+XvEuWYavBACBLEBF762aJ4u1OcN6pORYNQ536twQK5Bof+ZtcloJKK4/UHyP6rhlIglYNOOXDUw7pBSXG1/FGZS4tOIwAMrOuYEpLXFRy2AQWNbsSfzqYN55nWva/ZfUISFUdQrAjvgzM0pARpMcYQdrqQYEqBtXTpLlvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08850C4CED0;
	Thu,  2 Jan 2025 20:28:59 +0000 (UTC)
Date: Thu, 2 Jan 2025 15:30:16 -0500
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
Message-ID: <20250102153016.7fc5e443@gandalf.local.home>
In-Reply-To: <20250102202404.GD7274@noisy.programming.kicks-ass.net>
References: <20250102185845.928488650@goodmis.org>
	<20250102190105.506164167@goodmis.org>
	<20250102194814.GA7274@noisy.programming.kicks-ass.net>
	<20250102145501.3e821c56@gandalf.local.home>
	<20250102202404.GD7274@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 21:24:04 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> It is not. If kallsyms is fixed, you can use that to tell which
> fentry/mcount sites are 'invalid'.

I can't use kallsyms for valid tests at boot up. Even with a binary search,
it's still rather slow. The ftrace table is created at early boot, even
before scheduling (it's needed before you can enable boot time function
tracing), so any slow down in creating that table slows down the boot, and
people will notice.

-- Steve

