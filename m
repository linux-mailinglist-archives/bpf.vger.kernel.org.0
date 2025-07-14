Return-Path: <bpf+bounces-63202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F80CB0417D
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 16:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D5A4A53A0
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7AA248191;
	Mon, 14 Jul 2025 14:21:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085FF246773;
	Mon, 14 Jul 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502906; cv=none; b=SBS0jSvKtJ7Ij4YajlT/pjbY8IzderPwyHkAMxarhgLI+W+Hi6sGfQzXFFEuijwpTEIYRGRRbHGX7qD2kkEJmfRMAZo9vVZKMaPCt+MhxZzyJK2XgpJlnN16HRr+d7QONFoc45+OjGdTXfkAZjR9uAxaQK++zM8sGm/sg9lLMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502906; c=relaxed/simple;
	bh=P6Ow1Bg0igbmULKDYZlnuoaZBU61dtOGRVAxG//hpBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWGFBHGnBqkHJJ8Vy0olU1JmnVVgXSZbrRHNLy+RQOt2v+NJNlBL9pcHeK1GNvp4D7QxQv9JmstEc/SVeW/nfUZFI18arN9MDcxcZfn2YbPLdz+oN3m7gtzLvfnixxtGz1TFP3mNl5X0SPt5ebWeZDwGz7ISG4N/VYwAZCd0a8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 00ACF1D847B;
	Mon, 14 Jul 2025 14:21:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 67ACD18;
	Mon, 14 Jul 2025 14:21:35 +0000 (UTC)
Date: Mon, 14 Jul 2025 10:21:40 -0400
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
Subject: Re: [PATCH v13 09/14] unwind deferred: Use SRCU
 unwind_deferred_task_work()
Message-ID: <20250714102140.4886afa0@batman.local.home>
In-Reply-To: <20250714135638.GC4105545@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
	<20250708012359.172959778@kernel.org>
	<20250714135638.GC4105545@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 67ACD18
X-Stat-Signature: a3jb9xhduppwen5ij4gceiqfyc58dxtq
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX195kjxDmwykymGve/t5hpmc/d6WZ8LcvKM=
X-HE-Tag: 1752502895-102230
X-HE-Meta: U2FsdGVkX18aSa07GshJbS5ftUch2Q3kvC3PxfEAKfIUmZ4CH9JZr89h1/sJUehz+nEeVVvRVRjOESdrS/FP/lqOE2zjs8uD2ot58BDpVsOSNB7DhmtIJe4VEqVQOSfOyowf3xoBInGsuhqavTF/kXO2W0SlcGsJ6j4PkURM2X49qWq8j0Rhe6q9X51H9F1Yqcra3MSaiBvbovdyoK+0/5tIS8vIrm0w2UCfe1dnUB0lDTxi0CSulH9BYoG88lD+2u32rdc8McLj/1WNQ6oQCdCSDJIPRBNfO2uBzEVtacu7eH2tgW68pgNf4UT2hGd7Lk2FvJpVsZG0FqFh4zoU+Q3OcYWOm71tc2K2Htv+q29MoA2I7RfXYV1s7voN1ma/

On Mon, 14 Jul 2025 15:56:38 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Please; something like so:
> 
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -524,4 +524,9 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_st
>  		    srcu_read_unlock(_T->lock, _T->idx),
>  		    int idx)
>  
> +DEFINE_LOCK_GUARD_1(srcu_lite, struct srcu_struct,
> +		    _T->idx = srcu_read_lock_lite(_T->lock),
> +		    srcu_read_unlock_lite(_T->lock, _T->idx),
> +		    int idx)
> +
>  #endif
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -165,7 +165,7 @@ static void unwind_deferred_task_work(st
>  
>  	cookie = info->id.id;
>  
> -	guard(mutex)(&callback_mutex);
> +	guard(srcu_lite)(&unwind_srcu);
>  	list_for_each_entry(work, &callbacks, list) {
>  		work->func(work, &trace, cookie);
>  	}

I think I rather have a scoped_guard() here. One thing that bothers me
about the guard() logic is that it could easily start to "leak"
protection. That is, the unwind_srcu is only needed for walking the
list. The reason I chose to open code the protection, is because I
wanted to distinctly denote where the end of the protection was.

-- Steve

