Return-Path: <bpf+bounces-63634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C5DB09201
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18EC189EC70
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D812F948A;
	Thu, 17 Jul 2025 16:38:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A413D145348;
	Thu, 17 Jul 2025 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770327; cv=none; b=ahisBP7GdpDfBbd8kcR6J5f3DAk4ezqcyGavO3E5dvWokNWnuQ+QSnfgAbDA3Qu2neFlvNSKDBI9jKtRlfrYdL5A52agnnzrW3I5fpF/GDN84As57ZlkjA2nhK9HtwT5G8zGfF/XUIUOpW7WC7i1EFyNczV7TayZ6AmwnoIgYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770327; c=relaxed/simple;
	bh=/lWi3pXaJ3llT/utRyZVcTX6L5mZifX69h5Q13eMmJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0AFOx7rsyeTD0JyEgaoIjYSJtJxJSpU2a1Abq5GrnEfEvjXG/FXqqIsLiRkyJsyeVeMLJ11eQ59dbYl4pDXkEIo3n7583qW8uJUxpLbEaoz8cL7dBh00jvZRLhTbuoaCXtB8WuW4z5Sw3KiK3vQZIOFxFPG5n8mXJK2MJSPoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 86DFB1A017A;
	Thu, 17 Jul 2025 16:38:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 74CAE32;
	Thu, 17 Jul 2025 16:38:36 +0000 (UTC)
Date: Thu, 17 Jul 2025 12:38:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v14 09/12] unwind deferred: Use SRCU
 unwind_deferred_task_work()
Message-ID: <20250717123835.21c8aa89@batman.local.home>
In-Reply-To: <a9bdf195-e9b2-4cd0-88ba-b6f68b3b72b3@paulmck-laptop>
References: <20250717004910.297898999@kernel.org>
	<20250717004957.918908732@kernel.org>
	<47c3b0df-9f11-4e14-97e2-0f3ba3b09855@paulmck-laptop>
	<20250717082526.7173106a@gandalf.local.home>
	<41c204c0-eabc-4f4f-93f4-2568e2f962a9@paulmck-laptop>
	<20250717121010.4246366a@batman.local.home>
	<a9bdf195-e9b2-4cd0-88ba-b6f68b3b72b3@paulmck-laptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 74CAE32
X-Stat-Signature: xay1j81jcwor5ab8f19ohqmfyxetzg5p
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+dwEPDopII2FDU0xpnvkJQH8Cc23zvuzs=
X-HE-Tag: 1752770316-666472
X-HE-Meta: U2FsdGVkX19l5YJ+we3bRDbWCryF5sp2t3YoXG0e5O1vVjxoXf4mqiiSkhzgpVLZDmdboRShCD/D/VyDiG57trD6Jp6HNNoJM856H4WPxuif7BgZyD/wMACwGw+4KUg7qeeIq3TVxQg2hQNEAbjbDLtoeMBM2WPU5GgXATtYBl+mTqaGqhkO17DOlxS5+9JOyDc065n+WbMh7SmDplrlFWl9s20KM8MXT5ZeP6US6vo8zYSMBzuskVQ4TNIJb0F+eFiHtzZB0BBgQDI7BKISqFPM9z3DPDqIwN8SfG6g1+g578MFpDbYOjO0OOmP4OXa3sMIf67/vWq1HwPKj6fUHhbroXJAtUAi

On Thu, 17 Jul 2025 09:27:34 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > Two, I'm still grasping at the concept of srcu_fast (and srcu_lite for
> > that matter), where I rather be slow and safe than optimize and be
> > unsafe. The code where this is used may be faulting in user space
> > memory, so it doesn't need the micro-optimizations now.  
> 
> Straight-up SRCU and guard(srcu), then?  Both are already in mainline.
> 
> Or are those read-side smp_mb() calls a no-go for this code?

As I stated, the read-side is likely going to be faulting in user space
memory. I don't think one or two smp_mb() will really make much of a
difference ;-)

It's not urgent. If it can be switched to srcu_fast, we can do it later.

Thanks,

-- Steve

