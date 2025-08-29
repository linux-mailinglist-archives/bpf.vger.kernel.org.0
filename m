Return-Path: <bpf+bounces-67048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF55B3C5B5
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 01:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E001B23D10
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 23:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3343148DD;
	Fri, 29 Aug 2025 23:42:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CAD313E2F;
	Fri, 29 Aug 2025 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510954; cv=none; b=DwOL8nrTTjb5B+5wuT2C4jgnYoTkPKN8jt0ffoUN0x3ftIgGV1HtQ7BsRNLMdJ0lgSoslLrHmbJ8/iKW/z8ir5gG/LVqLQr21EwMk/dJQjK3BcGDAHGgBQQ1Zz7QwY+4xIMGhWdPVGvBCjm94gRcF+psPq9DdnFJ/Uw6gGNrW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510954; c=relaxed/simple;
	bh=OMoarhBKWRFMEKlBjhoZlnUHQlWKXzQC/8XRcWcRgQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPc4QurEi4CHLLMlWCjbo9RKJvK1eaOEmYnYAHp3zEBn5zWDlfvvU1c5uGV/2gdAeIxDcMMZ6hY/AcfIYQsDJakf7VAaTB1dkPZRw6xEpxafXUSh58hRADK9sZFvhNF9zNeTG434KfSxnu1xK9jWn94ezgBb6oL5ZhthF51OQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 0DBCCC0A3E;
	Fri, 29 Aug 2025 23:42:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id C022930;
	Fri, 29 Aug 2025 23:42:23 +0000 (UTC)
Date: Fri, 29 Aug 2025 19:42:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Steven Rostedt
 <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, Andrew
 Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell"
 <codonell@redhat.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
Message-ID: <20250829194246.744c760b@gandalf.local.home>
In-Reply-To: <20250829190935.7e014820@gandalf.local.home>
References: <20250828180300.591225320@kernel.org>
	<CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
	<20250828171748.07681a63@batman.local.home>
	<CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
	<20250829110639.1cfc5dcc@gandalf.local.home>
	<CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
	<20250829121900.0e79673c@gandalf.local.home>
	<CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
	<20250829124922.6826cfe6@gandalf.local.home>
	<CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
	<6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com>
	<CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
	<20250829141142.3ffc8111@gandalf.local.home>
	<CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
	<20250829171855.64f2cbfc@gandalf.local.home>
	<CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
	<20250829190935.7e014820@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C022930
X-Stat-Signature: azhwezcc14saodu69w4ah5bim47aswj1
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18JIfWswO10uE6nLVJT4VE/MKCv0PTvJos=
X-HE-Tag: 1756510943-862589
X-HE-Meta: U2FsdGVkX199iHuOEkJPwTYcEot9z3agL4VFtTQKQhV4DCgF8Nuvn5MIUxD2Y0mU3qJhMXmgywmTSbzffvJOkpbtCIcds0bkVeHfRC05gAdzqhkqgpFW2eVTB/MptON7Q2zOWE75bOXxMk82l4NkllEB5fQw0caXw0Wc4bZQJDSJFxvVkMTKNyWl7bCHSU1UPA3vEhFjqbbAb1gZCb87gRV6S4XRCbSTP9G9q4Tg0vNTT2xswqvX/xDaZRUJ6rQGX9M4PenXkAA4IckVgETmOumbbmzyj+rJb7qbSwZd7xWeCNuD+Xy+hA1j7z3WdEmzSY5tSLeD8qH7rGR4qyMfey58dLe1FK01+AOjWaKfQQ3iVhzh0+tvLiVUGFzAvmGy

On Fri, 29 Aug 2025 19:09:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > NOTHING like that. You don't look at the hash. You don't "register"
> > it. You don't touch it in any way. You literally just use it as a
> > value, and user space will figure it out later. At event parsing time.  
> 
> I guess this is where I'm stuck. How does user space know what those hash
> values mean? Where does it get the information from?

This is why I had the stored hash items in a "file_cache". It was the way
to know that a new vma is being used and needs an event to show it.

> 
> That is, this would likely be useful:
> 
>   vma = NULL;
>   foreach addr in callchain
>     if (!vma || addr not in range of vma)
>       vma = vma_lookup(addr);

You already stated that the vma_lookup() and the hash algorithm is very
expensive, but they need to be done anyway. A simple hash lookup is quick
and would be lost in the noise.


   vma = NULL;
   hash = 0;
   foreach addr in callchain
     if (!vma || addr not in range of vma) {
       vma = vma_lookup(addr);
       hash = get_hash(vma);
     }
     callchain[i] = addr - offset;
     hash[i] = hash;


I had that get_hash(vma) have something like:


  u32 get_hash(vma) {
     unsigned long ptr = (unsigned long)vma->vm_file;
     u32 hash;

     /* Remove alignment */
     ptr >>= 3;
     hash = siphash_1u32((u32)ptr, &key);

     if (lookup_hash(hash))
        return hash; // already saved

     // The above is the most common case and is quick.
     // Especially compared to vma_lookup() and the hash algorithm

     /* Slow but only happens when a new vma is discovered */
     trigger_event_that_maps_hash_to_file_data(hash, vma);

     /* Doesn't happen again for this hash value */
     save_hash(hash);


This is also where I would have a callback from munmap() to remove the
vmas from this hash table because they are no longer around. And if a new
vma came around with the same vm_file address, it would not be found in the
hash table and would trigger the print again with the hash and the new file
it represents.

This "garbage" was how I implemented the way to let user space know what
the meaning of the hash values are.

Otherwise, we need something else to expose to user space what those hashes
mean. And that's where I don't know what you are expecting.

-- Steve

