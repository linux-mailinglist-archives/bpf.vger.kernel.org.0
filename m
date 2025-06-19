Return-Path: <bpf+bounces-61041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59072AE0001
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B3B5A36CC
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 08:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235DF265CB6;
	Thu, 19 Jun 2025 08:37:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2C264F9C;
	Thu, 19 Jun 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322261; cv=none; b=ekCJ3gdOvJbQsBS3RWger48+jpS4W8BplF5inDeayN16TapltDJYUePME71WvczprF9/968h6EMSLz9GrStV5UI9KPQbNzjGZFFEvvd6tiOXn1JLu3yMw8L22ixg7RdBM9iwqPsBnzIKIHyQpQFtK8pDUTE1O/dwJ0/rkBHXNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322261; c=relaxed/simple;
	bh=gA4upAqoJWkQtJ7rSaVEKem3TBElKddDr0DK+4SVX+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVwFzHYw6ZWMBjviGUhCQJ8r1HgaxIMNTF3p1fDndWvYtTG0uYwuB2PQ1MegczPuwgGCRTw8JIhI9pNnY5MnR973Qs6cRn4S0FI7aHd/9ZHhA69HcQj0PqLgWpF5zF632l8yaf7z38ge/EaMgDqDsmQbaPlrLvQx9oJ2J9atCFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 49B53BAB96;
	Thu, 19 Jun 2025 08:37:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 98FD180013;
	Thu, 19 Jun 2025 08:37:28 +0000 (UTC)
Date: Thu, 19 Jun 2025 04:37:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250619043733.2a74d431@batman.local.home>
In-Reply-To: <20250619083415.GZ1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.938845449@goodmis.org>
	<20250619083415.GZ1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6o39rbir7g7zatdxpdbp4t4tx8md3peo
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 98FD180013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/YidxWd14pz5aFYb+6ASL5NItAI6wgpWg=
X-HE-Tag: 1750322248-522237
X-HE-Meta: U2FsdGVkX18cYiTxl+yELbwf2Tvb7DjLxPFEt+ulY1H4hCPFM84GEbGoFS5GMYZYQxnejBVvZ9PSjRZ95uZzD+PfioKmItkvV/hTQS17Qsb7mq72WjULF08jDlRKlhRzb7YSne1P1brHDAFV2PXDX/W8+ayPFSMnAIId/gthsNph4MeUv4T1lJMDGtaZ3FbNZ6CKwcOTYDnjEIyEWGWMycEg86Nz/xVdLAEq4cVVu74mCRl+5i8XdBpGQqqH0AMrceK69VJ6P/nA4ms6P3viBuhDBukCGxC0aAJzIaZ01slBLrdR/I1m7ACOOAZwzSqModyRVEzVySSfZ28skVajVsQm1O4BIewq2I/gzkaRjl0yJhmj4qIx6CKvjSkMh20hyP6WsKxBRNJ1I93fvuhQGg==

On Thu, 19 Jun 2025 10:34:15 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Why can't we cmpxchg_local() the thing and avoid this horrible stuff?
> 
> static u64 get_timestamp(struct unwind_task_info *info)
> {
> 	u64 new, old = info->timestamp;
> 
> 	if (old)
> 		return old;
> 	
> 	new = local_clock();
> 	old = cmpxchg_local(&info->timestamp, old, new);
> 	if (old)
> 		return old;
> 	return new;
> }
> 
> Seems simple enough; what's wrong with it?

It's a 64 bit number where most 32 bit architectures don't have any
decent cmpxchg on 64 bit values. That's given me hell in the ring
buffer code :-p

-- Steve

