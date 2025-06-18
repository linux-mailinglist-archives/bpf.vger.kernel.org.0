Return-Path: <bpf+bounces-60934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8054AADEEA5
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905773A6F97
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7E12EA748;
	Wed, 18 Jun 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OVYnmy3H"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F522EA736;
	Wed, 18 Jun 2025 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255156; cv=none; b=lnIT6YGMEuau41Yk5iBTKsf0IrUErf+bC1VRiZWAnMxYxIl8n4nIiP410l8WTxw8ABMUReEyVpOMwn15ELAv7cAnJl1e5AzbF+iOmBa+mhnJLxMkC6HgBfMSEnjSOxMLYxZ44gzKKQEfcgc9EBUHFsHRDdfoCvzF+LJzEasrpyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255156; c=relaxed/simple;
	bh=o6EXKqIOQ92YndRNNyHRp6OGIcI3KPyINI+NbaiAHHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2VlLGmYvID3hmDbaauPTgYM5FUls5PzolnBqZMCZen6HtpK7TgrupiWgVDMmTgyGGThFJjb5Edw28bsYq+y1H4CPc9wrEInfO0TxA7eN7JVplEL7NhiUhdhRZPiOAv+qj5lkFLfLqWN2+sS/L3Lnuqev52jxip8zSPKMxoEEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OVYnmy3H; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cLny5fdbWXa03ojEBDQztF37oAyKTytrgydjanBvVl0=; b=OVYnmy3H6OTXaPq9kE1rWDJgqS
	yUrJaez6x89JUeD1SgtM2mDSsTDFA6edaYZ3zbteaLdZh9Fj5AV9zoKS53P+MBS6eyiQwe96SBW8y
	Dcvn8DclP4Blmw8IRBDmbaHeIaBLyzi6EcrjFr4FQWCNJ/k5L11Ra23ycmdik/IjxKojClpd/YehI
	PSmZarHt5e6oAkVtE2LTG3knIN94rf8XGUDx0XQ6wM+BAt9Rl1oV2fVqyCcEfFaHnarAchkjGFnfM
	9a50cwbzrF3CkimVowezaTOJ72o+QkKfFYmMGnko889Za77dbwPSu+WgWHCVDAoxD1D83Eks5HWtC
	a4KchlXQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRtJk-000000044tn-0r7t;
	Wed, 18 Jun 2025 13:59:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 20626307FB7; Wed, 18 Jun 2025 15:59:07 +0200 (CEST)
Date: Wed, 18 Jun 2025 15:59:07 +0200
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
Subject: Re: [PATCH v10 04/14] unwind_user/deferred: Add
 unwind_deferred_trace()
Message-ID: <20250618135907.GO1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.433111891@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611010428.433111891@goodmis.org>

On Tue, Jun 10, 2025 at 08:54:25PM -0400, Steven Rostedt wrote:
> diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
> index 349ce3677526..6752ac96d7e2 100644
> --- a/kernel/unwind/Makefile
> +++ b/kernel/unwind/Makefile
> @@ -1 +1 @@
> - obj-$(CONFIG_UNWIND_USER) += user.o
> + obj-$(CONFIG_UNWIND_USER)		+= user.o deferred.o

We really needed that extra whitespace? :-)

