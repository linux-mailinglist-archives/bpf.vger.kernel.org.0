Return-Path: <bpf+bounces-62801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C4AFEBF7
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 16:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C84188F204
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C793E2E540F;
	Wed,  9 Jul 2025 14:29:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE42749D1;
	Wed,  9 Jul 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071356; cv=none; b=RVkjctqcaZzjlj6Ywc5ytdDJbk/WZPeD/wBiaOBctvEfUHxDR1Xa11x7vtBvoaTmMm+4i8baV7C4DAxjtji2XjVNEv/hnU4sTDBxITox2DjKDWxYJwh2e1ToUWLZVqI8TkgRy7FfbJNI+7kHzRZ9eCQXSzDyqU3EhzcSQDeuwBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071356; c=relaxed/simple;
	bh=V0lpzKxUMlOgRWszx6Dn8TT6IP+mzIDuesFXdmIcfGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajYzOIgrSfy7+hG5KPI1/ohZFJ/myTDEIrMOmTkKUEjkqx5Gqro5Fu4VlApjcCuCWdSHiQRLGcVhixrWpNfd0SvN2TbeRdNVz78RvwTdHcY3ot6uNGheocFPd+9tT1S0sSpvaSdfUqVb73uBIt2Dh8KfHa2cPDneXUboHsCBeio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id DF48E80209;
	Wed,  9 Jul 2025 14:29:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id D48272002C;
	Wed,  9 Jul 2025 14:29:05 +0000 (UTC)
Date: Wed, 9 Jul 2025 10:29:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Steven Rostedt <rostedt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [PATCH v8 06/12] unwind_user/sframe: Wire up unwind_user to
 sframe
Message-ID: <20250709102904.18cfd2ff@batman.local.home>
In-Reply-To: <939e13b0-be32-4ec9-a40f-0ad421f63233@efficios.com>
References: <20250708021115.894007410@kernel.org>
	<20250708021159.386608979@kernel.org>
	<d7d840f6-dc79-471e-9390-a58da20b6721@efficios.com>
	<20250708161124.23d775f4@gandalf.local.home>
	<a52c508c-2596-49d1-bbe8-8a92599714f6@linux.ibm.com>
	<39cf3aab-7073-443b-8876-9de65f4c315e@efficios.com>
	<7250b957-2139-4c03-9566-a6ed9713584e@efficios.com>
	<20250709100601.3989235d@batman.local.home>
	<939e13b0-be32-4ec9-a40f-0ad421f63233@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9b6yjpr56b45kor6fbfeph1db1oynkyn
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D48272002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/SrnEA40U3P0LAAyelCmkzNpM/l8l8jIM=
X-HE-Tag: 1752071345-248144
X-HE-Meta: U2FsdGVkX1+E22O0aliM1G0Lz0JqUW910NYsNWRxXRhUA/5nfjua72CF06pff9Q7sWK0hUUE0N0YtndxRUUEpQ38cjQ+b7b5v/dy7wT1jmzOuC1nrAR362VDnaDz8rNFAiz2f4v248eHSfCKfhxWuhCL3Kj1iP3cy+bTc+c2XJM3I8C4c/CWvRhZwcOtNHE6EHd50GM21VRVZgSgY/b9cbPeVM0OySTBZYc4O9Sd4R1wuT6yHZsSI07KRLPRl0Ea3xhhgCFTqkJFuCmUTi8Gxh8Yp7Gv9s9L564Ql9SLoXekdrpJju8t4Da66qB2U/TgtvGWAr7Xxh7KA09Wsn41suNTUPbRO/QJJ9kGib94e/4xal40YOy7km9ktjM3Lh4X

On Wed, 9 Jul 2025 10:10:30 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Indeed it's only kernel internal API, but this is API that will be
> expected by each architecture supporting unwind_user. Changing
> this later on will cause a lot of friction and cross-architecture churn
> compared to doing it right in the first place.

The changes you are suggesting is added info if an architecture needs
it. That is easy to do. All you need is to add an extra field in the
state structure and the architectures that need it can use it, and the
rest can ignore it.

Again, I'm not worried about it. If you want to send me a patch, feel
free, but I'm not doing this extra work, until I see a real problem.

-- Steve.

