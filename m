Return-Path: <bpf+bounces-61039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B05FAADFF61
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964F85A0151
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 08:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527B325D90C;
	Thu, 19 Jun 2025 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A5/zBiCr"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7376A23AE60;
	Thu, 19 Jun 2025 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750320081; cv=none; b=H4GtI45JotpxejgSim+ovXJtD5/SMAPS5HWNiOI4s2aUqiUct+5LUjxn0jqhjbf9dOfIpiaf60sCNicKX0hs02mfzoqCSuoEOdcpSg4OI8vgL+xen5BvqLxtin4OUaI7SQlx4IKFIDRhN0NnuU01NwwoQRGcHG40Jm1yLAhqWKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750320081; c=relaxed/simple;
	bh=K4Uqs7AMZHE9Ot8S/BK4MEl+Qm8sSFeK1zNGuiqrgoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZV9PjtRCTwiTxFGqvzGn+Rk4XfeouxKb2Gr41+mobKa7bm7Y2c2EeoIo2oflHJk5ePtz64huJPouOVZcvAXeLK04hwoJL7AAD22MiObqVINPJrXoMUHutzpf5wdCrZrm4Gbq1ickgbvijFkC0EkiEJR+GlfVvOrqlzIigrvICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A5/zBiCr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Xsbe0ope0hkQuYxUEAzIg1Go8B7EYdI/tGK+nDa4ZWM=; b=A5/zBiCrJaivG0mCc6mnTIuiF4
	lHSJk9V9KEW19Jnla8pqEDTVOMZFK6D4GpDUwW62tporUnwDaZSR+xf4KySLr3bc8Y80/qMFVUsoX
	OGhk/3o13hWitflAPwiVSgWZ5YFCvj5u0rul9pzcgVthVoxmwLwPAvZSQKPWebOuDatOObKUUgevK
	A8bxXIsmLhPl77R36ftsFWIt9UoeECp4okly8lxRSdY/WURGRsN/Qv6u1ykzstdjNc3p97q9L+YNh
	h3V9fM//FV73t8O8dXP8+n2cUDh26NuZmAfb/tPO4ieXxGXjEpGmEZ78ne5xbCsBRqoCIrYPJzIT7
	uy+5sHHQ==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSACr-00000007imF-1jBP;
	Thu, 19 Jun 2025 08:01:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EE7F53088F2; Thu, 19 Jun 2025 10:01:08 +0200 (CEST)
Date: Thu, 19 Jun 2025 10:01:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250619080108.GY1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.770214773@goodmis.org>
 <20250618142000.GS1613376@noisy.programming.kicks-ass.net>
 <20250618113706.2eb46544@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618113706.2eb46544@gandalf.local.home>

On Wed, Jun 18, 2025 at 11:37:06AM -0400, Steven Rostedt wrote:
> On Wed, 18 Jun 2025 16:20:00 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > The timestamp is passed to the caller on request, and when the stacktrace is
> > > generated upon returning to user space, it call the requester's callback
> > > with the timestamp as well as the stacktrace.  
> > 
> > This whole story hinges on there being a high resolution time-stamp
> > available... Good thing we killed x86 !TSC support when we did. You sure
> > there's no other architectures you're interested in that lack a high res
> > time source?
> > 
> > What about two CPUs managing to request an unwind at exactly the same
> > time?
> 
> It's mapped to a task. As long as each timestamp is unique for a task it
> should be fine. As the trace can record the current->pid along with the
> timestamp to map to the unique user space stack trace.
> 
> As for resolution, as long as there can't be two system calls back to back
> within the same time stamp. Otherwise, yeah, we have an issue.

Well, up until very recent, jiffies was the fallback clock on x86. You
can get PID reuse in a jiffy if you push things hard.

Most archs seem to have some higher res clock these days, but I would
not be surprised if among the museum pieces we still support there's
some crap lying in wait.

If you want to rely on consecutive system calls never seeing the same
timestamp, let alone PID reuse in the same timestamp -- for some generic
infrastructure -- you need to go audit all the arch code.

