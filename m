Return-Path: <bpf+bounces-63354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFC6B065CA
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 20:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9A156650D
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7619A29AAF5;
	Tue, 15 Jul 2025 18:10:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD125A331;
	Tue, 15 Jul 2025 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603023; cv=none; b=G2OzCoZNZvxutbVkCZe33G+6NCyJ+nCevDo3VMf7iq72xRaY2XFqVTay128mbByjfsDmHibrPqneMe4S6UWHF7ZQ3u/OpYZpsdWTv3MjLoM7VTaPTFh0b8dZ0CorMmtXki0+73VOhdO/av7YX2HZog6gzM6o4kcKfRtUvqaqpe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603023; c=relaxed/simple;
	bh=+I67IhVZrwNzIQDh2QnMQiYAzkAGHSBvrsqyNmzwc1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuipiwOmPP+e1JMlTp+FErSCIkDKJW7hyf7/gnhEVwzDWpwHcZJ6LiYNKVCPxsYLI+35SlzJWF9Uph9EVfGauCD1JFU1MqcbyOCY1/Ac1WvrEI+wt0647GK5BmHIQu4L1PwShyNIiegZ1yBcWr7v2LfnD1ukmERCypfmC3Xmse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id EDEFF80157;
	Tue, 15 Jul 2025 18:10:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 6CB5832;
	Tue, 15 Jul 2025 18:10:13 +0000 (UTC)
Date: Tue, 15 Jul 2025 14:10:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>
Subject: Re: [PATCH v13 10/14] unwind: Clear unwind_mask on exit back to
 user space
Message-ID: <20250715141012.7ef40529@batman.local.home>
In-Reply-To: <20250715140650.19c0a8ed@batman.local.home>
References: <20250708012239.268642741@kernel.org>
	<20250708012359.345060579@kernel.org>
	<20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
	<20250715084932.0563f532@gandalf.local.home>
	<20250715140650.19c0a8ed@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6CB5832
X-Stat-Signature: xuuact5orag81z4gzz7ztcmtmnxsnbuw
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/4exjFpoJeQpgEWCycArim0ykI5+OTwUU=
X-HE-Tag: 1752603013-164919
X-HE-Meta: U2FsdGVkX1+b1QGOHoeREoKqJRwZ0dWtN2myVHg4o4ohSY4UfAReCaJaRbgBlG+63MWblAcxZnWlwWfGZ8WiVAtL8ghYdZzgt9vWWYKaBAl34i1IuTtd4Vqu2LZ9s4hfwY351iU/7V7LxYSL9z5qx0DzLO1snDLrw54j6ZWtByMLT4p4qyfJrON7ahEyTNPC9svIqayXuLmI8O2m2znAAmERtCXdOAkKH4bcieL0ay8ZQCIn73UaC2Ti80Xbs/f8/jED0V+c4r5FaWx5N6O0WPretf64PSk+tCoWs+sop4hNEbc//sttGEW7ecSZWU8FiKTNlfTFq9szdJv3Pj7nEnVxfZhbJo0cEn9gCcgjdZZM18efcciofdthhpAOib9X

On Tue, 15 Jul 2025 14:06:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Ah it is still used in the perf code:

Either way, what I'll do is to remove this special return value for this
series, and add it back in the perf series if needed.

This is one of the problems that arises when you take a series with
lots of changes and try to break it apart. You will always miss
something that isn't needed in one where a change was made for another
series.

Working on each one to make sure this all works, it starts to blend together :-p

-- Steve

