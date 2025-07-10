Return-Path: <bpf+bounces-62926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCD8B006B4
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 17:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFBA4E597F
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CC251022;
	Thu, 10 Jul 2025 15:30:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEAD2737FD;
	Thu, 10 Jul 2025 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161458; cv=none; b=p+l/HwbAzKqc/ZeAKABkpgyY8Onk75uvz0NFzYwQFvxFWZNLQihinDrERMwtc4+HprAp8S/l6H+uhqJIqbOZiQDJKqs8fAZ32Awy13T2bn1vDaz1KajW/aGPEmfYTSncIYEdmPze0nbrUZrqWR/sytbAOFXLEe78B6sV2sO1aA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161458; c=relaxed/simple;
	bh=eNnzmd/JEya04OP8Mh/whLJnjLXMDy1YqvTFq/nfITc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdwJN9+8h/gRsf9bw2CoIBf4SRFEoe4dgiyrLF3aneET8PznKgYsrkJBx46zlvS6m1e19xLPCcZXCM0txAOVd4hfsPripgHxwPY8o7n0dy703VN3XqU9Vr4nFayBINKPoi7wn2AGTSb2DuedCv4XbtIfQPYCuDEc1z6jM2Sagzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id E214D129B3A;
	Thu, 10 Jul 2025 15:30:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id BF99617;
	Thu, 10 Jul 2025 15:30:40 +0000 (UTC)
Date: Thu, 10 Jul 2025 11:30:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt
 <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v8 06/12] unwind_user/sframe: Wire up unwind_user to
 sframe
Message-ID: <20250710113039.04a431d9@batman.local.home>
In-Reply-To: <a52c508c-2596-49d1-bbe8-8a92599714f6@linux.ibm.com>
References: <20250708021115.894007410@kernel.org>
	<20250708021159.386608979@kernel.org>
	<d7d840f6-dc79-471e-9390-a58da20b6721@efficios.com>
	<20250708161124.23d775f4@gandalf.local.home>
	<a52c508c-2596-49d1-bbe8-8a92599714f6@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qfn11of8yy6w4krucobyhddby5pbo7ja
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: BF99617
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/2XbU+LTT2smNLeoAUds5lmeztJ568iEw=
X-HE-Tag: 1752161440-812969
X-HE-Meta: U2FsdGVkX18qTiNldn/rZBbbsD1cKNTotV3OEputbyHklyK3GRwYIGzQzpnKY/cLIpLnAPD6Q9/WihCefUuNf/aGVQUEmwfkm6uqm3OoFWYd4MGAlz5ty9ZJuylAJMuGskKCUJvCQvyDY2gsllVjjaemdOCqbzEBRkXtQz1zWIQ16+Z/27QHfesEuG8dMa5NFIaV2ntvnuSDeIOrUlYMuuiTJnKvoNSqG06BZAdi31QazUMgTNCIBzku1ztcHQvQDX6tMJxtLCG0jMLZY3gx7zjTOv9mlxUb9WRuKIDK6bX3ClktZZHrN9OwNTd86MzI/EDn0l+rJOv0dnxsWstUMj+3FvrCt3lp

On Wed, 9 Jul 2025 09:58:26 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> I think Mathieu has a point, as unwind_user_next() calls the optional
> architecture-specific arch_unwind_user_next() at the end.  The x86
> implementation does state->type specific processing (for
> UNWIND_USER_TYPE_COMPAT_FP).

I'm not too comfortable with the compat patches at this stage. I'm
thinking of separating out the compat patches, and just reject the
deferred unwind if the task is in compat mode (forcing perf or other
tracers to use whatever it uses today).

I'll take Mathieu's patches and merge them with Josh's, but make them a
separate series.

I'm aiming to get the core series into this merge window, and the less
complexity we have, the better. Then everything can be worked on
simultaneously in the next merge window as all the other patches will
not have any dependency on each other. They all have dependency on the
core set.

-- Steve

