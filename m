Return-Path: <bpf+bounces-77294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E702CD6C7C
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 18:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F9133014B62
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 17:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7383C3233EA;
	Mon, 22 Dec 2025 17:14:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDDD2D8DD4;
	Mon, 22 Dec 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766423648; cv=none; b=LVgGhVQdjAyloLZcOtEetl3ysG+V1foIEKJ6V8sk8AsWC1IE/gfX1gvg3BslqdyrqvbDC7dw3a+wEvfH9Dtmm3Jn2cowrfbfH9BcQEReEOSOdahL1znFP1AKdsjZTXzX6VQfEcZZqHCPo+TOPDfuLB6Pip+gNQTYRDVMipilGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766423648; c=relaxed/simple;
	bh=iUcvJFzEIxQE0YuXD16Jb0QM5rBcC5p0hD16V8QIR6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJUoxMJwgmxzCDT3siVhrqBgdh3bLECFkK/ydBjN+WdgaFw1e6RKMeUd8rxEwM1rmI3LW8sqIfxwwpHvjYghOj1OSpmh0eMQv2xp+ZUroDivTy1ltNHSU97JugAnY9VhX0MC4HorumrwBHLl4ts+UeoVDS5yAVdXSy9Ml+rsm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id A500C1402CB;
	Mon, 22 Dec 2025 17:14:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id C69B46000E;
	Mon, 22 Dec 2025 17:13:59 +0000 (UTC)
Date: Mon, 22 Dec 2025 12:15:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: liujing40 <liujing.root@gmail.com>
Cc: menglong.dong@linux.dev, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, liujing40@xiaomi.com,
 martin.lau@linux.dev, mhiramat@kernel.org, sdf@fomichev.me,
 song@kernel.org, yonghong.song@linux.dev
Subject: Re: [PATCH 2/2] bpf: Implement kretprobe fallback for kprobe multi
 link
Message-ID: <20251222121547.39b35b0d@gandalf.local.home>
In-Reply-To: <20251222080253.2314895-1-liujing40@xiaomi.com>
References: <24197762.6Emhk5qWAg@7940hx>
	<20251222080253.2314895-1-liujing40@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bhw91ua8kd46xeiwp6xqseu6cm1isc6j
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: C69B46000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ZeY1gRXrfPVHTXdV06fMLtOdC1nsm634=
X-HE-Tag: 1766423639-972695
X-HE-Meta: U2FsdGVkX18CF9ChIIGdxWYxT7VA+r3sFrR8dEccwh6o4wWKTLNIdKQRaGPsvDY4FOoWd3R7kva3KI8GNs33XKGXfIO5EUDHZ8hkZQ1b3vY5eETIHt1uru40ATmqv1MDRWG2figR1z/QefRtX71aCWwaK/ilRGfuf1/q0XAFI2Mvz2cxvBBimk/wDgnyCIqq+quP6ra300Z4HmK18GR0p5AmAk/NdlnAkAZlvJ8FxBP/i2buSnRnVABLkXzJDgHjTBJ7z668SV4h5oD+RYsZvVzJRHFxsWDTG4sLyLvit4eiXRfS1gwhx9T/P1Hk6QD4iWVOrn3nDW2oXZEAsysedaflmCGSAovG/NHzr3pTC4MR2l/AKD3kmaBrBDwcOoxZbQwrV2WvLgw=

On Mon, 22 Dec 2025 16:02:53 +0800
liujing40 <liujing.root@gmail.com> wrote:

> The Dynamic ftrace feature is not enabled in Android for security reasons,
> forcing us to fall back on kretprobe.

Really? I would say kretprobe is a much bigger security risk than ftrace.
Ftrace only attaches to a set of defined functions and anything that is
enabled is displayed in /sys/kernel/tracing/enabled_functions (for security
reasons!)

Whereas kretprobe can attach to anything, and call anything. Not to
mention, there's no way to know if a kretprobe is there or not. So rootkits
that would use this can most definitely go under the wire, whereas they
can't with ftrace.

So if they disable ftrace for security reasons, they most definitely should
be disabling kprobes!

-- Steve


> https://source.android.com/docs/core/tests/debug/ftrace#dftrace
> 
> I will provide the benchmark test results as soon as possible.

