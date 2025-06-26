Return-Path: <bpf+bounces-61662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE68AE9D46
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 14:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869C74A1F9B
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD53C216E1B;
	Thu, 26 Jun 2025 12:13:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C3FDDD2;
	Thu, 26 Jun 2025 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750940020; cv=none; b=ETssuZGI8lilvkJ4Ap5N0eAhn7FERcvgPNuiLt7cUh/Y4xS9TtI6Nuvb2jYt3gq8puao2D1lTRvsIZ13qCT41mZZ0O0WYRmkU2FDkG9iZ3E9fW7uHYCckjyicQcQIWwOVHFkgLZKwBb1s4IcQUfRmYe6pByUNLce8YE+jNbj/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750940020; c=relaxed/simple;
	bh=ZJDkm+ay6O98NiXiGMPkpDGJGpWWhfw+/kn1f31F10Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGEk36fTRpeJ5yXjl5WYHWWf2Xc9HevGorBFptsvIQ00qcTKoLXgRiosTx3gJktyAAZk2VPt+LCBoAM6VSUgsH/nOS32z6KBXwWNc/Sl0zBqaArvxDeHbDAMqSJpvN1N8uLJQDcWsD9u4+/nj7InEFykVczwNcm0wHURpD9R7qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id D538F1206B7;
	Thu, 26 Jun 2025 12:13:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id DE2412000E;
	Thu, 26 Jun 2025 12:13:31 +0000 (UTC)
Date: Thu, 26 Jun 2025 08:13:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v11 13/14] perf/x86: Rename and move get_segment_base()
 and make it global
Message-ID: <20250626081352.30b360f8@gandalf.local.home>
In-Reply-To: <aF0IeDBaAfRypu1W@gmail.com>
References: <20250625225600.555017347@goodmis.org>
	<20250625225717.016385736@goodmis.org>
	<aF0IeDBaAfRypu1W@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uys6ttrkumetetsc4q3cpeitdrxnbwkr
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: DE2412000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18rv6R1OBR9mcy111QH7t1FM1i8rlVGQg8=
X-HE-Tag: 1750940011-661499
X-HE-Meta: U2FsdGVkX1/qz+jyF9/tlZIldOEdrudCEWU5a97Pg8NrdTzggJLyt/G6ust73fl1uM28G8SoLmCp1MzDYLve+kVjCQMOJj1fZ5bFx5TzIIvRIax/WNSS6Nfm8IblnY7U66+aCfrWe3XzUzXayOZVVL60wng38G259CSVpirG52uKnhro+8qgaX9c+Fjc19tJyDhoxyYKezBgefNvhN4YwIQi1vYjdtu/BoEYF3iFiohTbVtHfhisEImvcNuQLkQALapWS2EKq+qRFoZnt4mQVzlO4pg5ugfSByIU32lGeGbpVse+Ni4DJkFaLT7e2OupK/8G4lFgS1tvLuws5tsn+J+YkiY7hrfbmA0mDDGdz4TD6bHN4cyP45lRqX6dWGW9syBoLLebtVuiQtO9E0bpug==

On Thu, 26 Jun 2025 10:44:40 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > 
> > get_segment_base() will be used by the unwind_user code, so make it
> > global and rename it to segment_base_address() so it doesn't conflict with
> > a KVM function of the same name.  
> 
> So if you make an x86-internal helper function global, please prefix it 
> with x86_ or so:
> 
> 	unsigned long x86_get_segment_base(unsigned int segment)
> 
> Keeping the _get name also keeps it within the nomenclature of the 
> general segment descriptor API family:
> 
> 	get_desc_base()
> 	set_desc_base()
> 	get_desc_limit()
> 	set_desc_limit()
>   [x86_]get_segment_base()

Sounds good.

> 
> > Also add a lockdep_assert_irqs_disabled() to make sure it's always 
> > called with interrupts disabled.  
> 
> Please make this a separate patch, this change gets hidden in the noise 
> of the function movement and renaming otherwise, plus it also makes the 
> title false and misleading:
> 
>    perf/x86: Rename and move get_segment_base() and make it global
> 

I'll break it up.

Thanks for the review!

-- Steve

