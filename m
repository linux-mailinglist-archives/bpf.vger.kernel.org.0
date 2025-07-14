Return-Path: <bpf+bounces-63212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F4205B04337
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 17:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EA316A147
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D133264609;
	Mon, 14 Jul 2025 15:12:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2792125F96B;
	Mon, 14 Jul 2025 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505930; cv=none; b=iuRGhQTe0Atm6syTzXra2K3Ec7NYlKcUa26Bx0ICa9+1nvxg1bjoS+9xXhHuKubn0bghKFr5xHUOnZbrn5cbzcvy0d9EBbWZFYcCdoOGYQk3HddGy7LGZS3p5dHiCVlZekvDEnQsJ8tRhsBC5+UICExLGLEAAJI57WaNrNYWy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505930; c=relaxed/simple;
	bh=oq/kRc8YkSkQx0CNEH486rkwM/R8OEPfaXk2gBAVbk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zg4ExF7xnQsNfO+ruinUiFfGOCMFCuhNDpi5u70r/09wnGLLWOajnsyJgkKyyTpWQAD4kKUfHiZIQ0aKiBuXD3VqPtEuloCLT2+ffFIN5Esgi+jU9X+f1sCIXSgcrszTJC5l0UoZcZmv+4KIEVlNb/oqy65Tal+0cVx/Zt/gMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id C30B7801E3;
	Mon, 14 Jul 2025 15:12:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id DC2E42000E;
	Mon, 14 Jul 2025 15:11:59 +0000 (UTC)
Date: Mon, 14 Jul 2025 11:11:58 -0400
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
Subject: Re: [PATCH v13 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250714111158.41219a86@batman.local.home>
In-Reply-To: <20250714150516.GE4105545@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
	<20250708012358.831631671@kernel.org>
	<20250714132936.GB4105545@noisy.programming.kicks-ass.net>
	<20250714101919.1ea7f323@batman.local.home>
	<20250714150516.GE4105545@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5yczkq9m3prf68zz9rpu1dhpt1xqqi8t
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: DC2E42000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18va/HTPSKBw/fWiX/8a5inP/5claP6jAI=
X-HE-Tag: 1752505919-76516
X-HE-Meta: U2FsdGVkX185sujVYAEVxebt/0QBj4TxPRzIVvAoMsm/98GD2mjQpIxYcV5v1hYrijXv5Gp2cGzUdMVt1FjILgERmtMpQIuwkRahwlryzR5BZGPo3rQ7bqYG5ufGHclTPG7mHHfcSQrb1zM6r36CCHVI/FL1YXQ4uuTlwFt7mV/V8Yy7/DBUwVyDRkeqLAIHuTsk6/eCqtTjXICC1IIgsPu5hEeTbregqgb89x+bc+OAcKkqQoQZrPZXBmxCEEjcHvcjPbLCsLopleqas/RYzg0N3QqM3+hicI0tZsLP2BJE124Rvl5ki/jskepY5yE7AA06fd2J8zMUOGGQ4hLQ8NJ33iKTg0/r5bmioi/tQk13h2wKfdnn1imz3EO+tLjboeG1RJePCqltKYiEMYryHQ==

On Mon, 14 Jul 2025 17:05:16 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Urgh; so I hate reviewing code you're ripping out in the next patch :-(

Sorry. It just happened to be developed that way. Patch 10 came about
to fix a bug that was triggered with the current method.

> 
> Let me go stare at that.

Thanks!

-- Steve

