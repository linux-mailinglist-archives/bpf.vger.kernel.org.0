Return-Path: <bpf+bounces-47784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEC3A00017
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 21:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A19E7A230A
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3D21B6D10;
	Thu,  2 Jan 2025 20:40:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C85C1922F2;
	Thu,  2 Jan 2025 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735850432; cv=none; b=u7CIUcNkTjyCb3RgmU1lMMKZJCHRHr3hREsVEDxfBIoT25ZgmSKrN8UM7JwKE+BmAJsP3SC+sH6XK7LcHYhdnhHTMcjmtHVRzssEa3G3GkZLEp2y42c3BUVZV0TvouPu0kEBsZqrUrWYCAXSVlZ66PcC3F4aEIKkEn8P3fkhaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735850432; c=relaxed/simple;
	bh=XE/myzutFCcsG+LHfBKxcy4UDj6yiYV8CtmuHJJC0o8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4sHZ5UBJp7/mGPjXEtMXc+SpgpgYFnCPGHEKSprOC1galAH/6kfOdOe/Oi6hGRXiG6D119wyAnchSt3xYwdp37bwrAAK3krFUk/1XZcECd7EBwgwVBisShO404lXSgnBZ6G8C2aGW6ErJkT4kRzroNCVTYxO7SO1EGJqqhU2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2916DC4CED0;
	Thu,  2 Jan 2025 20:40:30 +0000 (UTC)
Date: Thu, 2 Jan 2025 15:41:46 -0500
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
Message-ID: <20250102154146.1d5e8f9c@gandalf.local.home>
In-Reply-To: <20250102203200.GE7274@noisy.programming.kicks-ass.net>
References: <20250102185845.928488650@goodmis.org>
	<20250102190105.506164167@goodmis.org>
	<20250102194814.GA7274@noisy.programming.kicks-ass.net>
	<20250102145501.3e821c56@gandalf.local.home>
	<20250102150356.1372a947@gandalf.local.home>
	<20250102203200.GE7274@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 21:32:00 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> This is quite the insane interface -- but whatever. I still feel
> strongly you should fix kallsyms so that we can all deal more sanely
> with the weak crap.

Question about fixing kallsyms, which I would like done too. I guess an
invisible place holder for weak functions may be best. Saving the size of
all functions could be memory wasteful. As there are a lot of functions:

 # wc -l /proc/kallsyms 
 207126 /proc/kallsyms

What would be best? To add a placeholder where weak functions are, but they
would not be printed in /proc/kallsyms?  If a lookup occurs, and it lands
on one of theses functions, to return "not found"?

-- Steve

