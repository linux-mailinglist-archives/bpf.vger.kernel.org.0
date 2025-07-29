Return-Path: <bpf+bounces-64634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48807B1504B
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 17:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F61546FB5
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0211929824B;
	Tue, 29 Jul 2025 15:40:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3792980AA;
	Tue, 29 Jul 2025 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803623; cv=none; b=F/fq3SQtl/ADIN22BDmCk2zmBDBi8sQ7kPXinjB/3nja/LLGgjf0voAro2hqGLTIn7I+akCm9WNO6CMe7t1flzjzwYEAteAqM6LWmxAQK68WlDU8CcKphQOnSadtqdxijVjf06db2xVkks+NCIGPLiqeX5DxySm2e2XxJ8WRL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803623; c=relaxed/simple;
	bh=OlRedFDxrkWC3m2IN07auHwrhh2BPsnAqUm1Ne3uE0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meBEiGf9P56drt3oe9BzWY2zvDC/1beds4O09ku3NMlhBiS8TPFgmjQ0CRjy3ulJ0Arne2JOeYWwtkvhuM1MJPyXP3yQsBTn0KQE/y50uAqyBSSphkWcAYrMZSvjYpV/8KgrPtGQQnBmTshmalmbc3OU19Ann/iinRrEtqUkSvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 18C94801A9;
	Tue, 29 Jul 2025 15:40:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id D2B8220028;
	Tue, 29 Jul 2025 15:40:15 +0000 (UTC)
Date: Tue, 29 Jul 2025 11:40:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, aahringo@redhat.com
Subject: Re: [PATCH] tracing/probes: Allow use of BTF names to dereference
 pointers
Message-ID: <20250729114014.22bf17c8@batman.local.home>
In-Reply-To: <20250729113335.2e4f087d@batman.local.home>
References: <20250729113335.2e4f087d@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: q6zgjy7nn1jg6bj3g7b74oqsemuc4oo8
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: D2B8220028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX186VMlIHneOuF/AgDag7l28Zac1Ill4rOU=
X-HE-Tag: 1753803615-805169
X-HE-Meta: U2FsdGVkX18Ow2xrPCJGOeQK7rQx+7+poyxBDd9bSNtdYHYpRa3MVczA9S65ndXqbb3GA+6mzA6r+qkbWevrB5tE+F1PvOEtM057N/MyPBmnzUOxPmBh9HPy2cSP2fnCdxnAMputoO/rxWgKhPpkrUYL4RwVOEaH1N8HfS6c5QlSk86/CKou/mT9a7uxU8wXUShTy/jdZzkNTb6b61R6BFfO9TMRNH57k62hKk2+lk/zT2lf3PCp+35rxrEDTfIsL7JUJgbMcLgxH1qLDOG2LP/gMnEZeD3okATbqhLTajifi8xglTGXG08dMYlgA35fvTWbpBuj07aaRFsjJZXHzzIAoeTbMlgVwfJUt9qUL/LlZfQCmNlsgPIy23K8lSXK

On Tue, 29 Jul 2025 11:33:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Anonymous structures are also handled:
> 
>   # echo 'e:xmit net.net_dev_xmit +net_device.name(+sk_buff.dev($skbaddr)):string' >> dynamic_events
> 
> Where "+net_device.name(+sk_buff.dev($skbaddr))" is equivalent to:
> 
>   (*(struct net_device *)((*(struct sk_buff *)($skbaddr))->dev)->name)

The above in wrong. It is equivalent to:

  (*(struct net_device *)((*(struct sk_buff *)($skbaddr)).dev).name)

I purposely tried to not use "->" but then failed to do so :-p

> 
> And nested structures can be found by adding more members to the arg:
> 
>   # echo 'f:read filemap_readahead.isra.0 file=+0(+dentry.d_name.name(+file.f_path.dentry($arg2))):string' >> dynamic_events
> 
> The above is equivalent to:
> 
>   *((*(struct dentry *)(*(struct file *)$arg2)->f_path.dentry)->d_name.name)

And this is supposed to be:

   *((*(struct dentry *)(*(struct file *)$arg2).f_path.dentry).d_name.name)

-- Steve

