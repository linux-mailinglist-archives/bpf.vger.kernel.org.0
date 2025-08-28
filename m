Return-Path: <bpf+bounces-66839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02284B3A4ED
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 17:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251FA1C82E64
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BCE25179A;
	Thu, 28 Aug 2025 15:51:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A961F8BA6;
	Thu, 28 Aug 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396289; cv=none; b=Zp6ICBXE1gAcGjnvaSvTpL/5ASVZLKuFo0h+fDO4zsc7HkIWStkkVkY1xT97YeKe9NXQHn9xiGFSFJksZCsFzQSMiChvHuwYPcSGmoqoT4kD+IyGDtwn/iZkewC2lGYei6/DaMZR+dNkeCLVjRYsn5BauJIOkzjK39IMl/dup2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396289; c=relaxed/simple;
	bh=d+rWHjrAq6cCAypejXWh9I3ab+O0wg129sFx02OLWRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWuvQ1dw1W5fBlEabn4jxPnXDwEOWZvB8WNGXNY7/loSTGnEPXyegGcIOpg5Z4td38rtFvnRpurOgBT/DOAADgPPYvGFC0vjCbWrKV9tKfmhyrw1oA2U+P0oD/Mph4j/80rcGuP8uFXCcHK2YbiohXjVAw5/RwxQJV2AO05UdfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id B621D1391CD;
	Thu, 28 Aug 2025 15:51:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 518E31B;
	Thu, 28 Aug 2025 15:51:08 +0000 (UTC)
Date: Thu, 28 Aug 2025 11:51:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Sam James
 <sam@gentoo.org>, Kees Cook <kees@kernel.org>, Carlos O'Donell
 <codonell@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, David Hildenbrand <david@redhat.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, linux-mm@kvack.org
Subject: Re: [PATCH v10 02/11] unwind_user/sframe: Store sframe section data
 in per-mm maple tree
Message-ID: <20250828115128.25f7b171@gandalf.local.home>
In-Reply-To: <emcthzvyvaj4fqfurbjx7xxqh3w4uwt2qxa4h6hdurh6brvnkc@zk4dspp2tcca>
References: <20250827201548.448472904@kernel.org>
	<20250827202440.444464744@kernel.org>
	<el6nfiplc3pitfief24cbcsd4dhvrp5hxwoz3dzccb5kilcogq@qv4pqrzekkfw>
	<20250828102819.27d62d75@gandalf.local.home>
	<emcthzvyvaj4fqfurbjx7xxqh3w4uwt2qxa4h6hdurh6brvnkc@zk4dspp2tcca>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: etf1r68hxurzy47ti6noiaecma5p9fpz
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 518E31B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19EvgcdawFHgwUNiQPAjXoZr2Nlbn5YCvo=
X-HE-Tag: 1756396268-783114
X-HE-Meta: U2FsdGVkX1/6C8uLnTWJJyXcAvMV6Ww3mVMIM9gY+X+uMOVQ4Puy6e3J2Dlc5raOYtp2QzM2wBOFerfN59HVoeBMe+Tdj8C5Fn+8nRf7oWjxdaTUvaQo6kRqdblbhE4PZVdALKEcsT43WUnfYzXV6oBilCDDKpNVNNMSwzYHl1YTsTQO84j8wFEJm7lrBRS1tQ20W8+I6G9Nqeh0o2XTpJI5PyJW0/PKjreV6dl2ZTHEpNLnjBOong6uuuZbKiNZwuSGwjphz+Rsvfk9nAzc959FMbLnVLiNy1yRY0APE88kODj3LROXx3qDs5NeQLB/qBbGFIZtIzMaIdlkeXvkxkSCdyu61AYz

On Thu, 28 Aug 2025 11:27:00 -0400
"Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> > Does this make sense?
> >   
> 
> Perhaps it's the corruption part that I'm missing here.  If the sframe
> is corrupt, you are iterating over all elements and checking the start
> address passed in against the section start.
> 
> So if the section is corrupted then how can we depend on the
> sec->sframe_start?
> 
> And is the maple tree corrupted?  I mean, the mappings to sframe_start
> -> sec is still reliable, right?  
> 
> Looking at the storing code, you store text_start - text_end to sec,
> presumably the text_start cannot be smaller than the sframe_start?

Sorry, that's not what gets corrupted. I should have expanded on it.

The sframe section is two tables that describe how to get the return
address from text locations, much like how ORC works in the kernel. We get
a start and end address of where the sframe exists (that has the two
tables) and a start and end section of the text it represents.

When I said "corrupted", I meant that the sframe tables are totally created
by user space and can not be trusted. While reading the sframe tables, if
there's any anomaly that is found, it is considered "corrupted". So no, the
start and end of where the sframes are and where the text should be
validated at the start (I need to check that we do ;-).

But once we start reading the sframe tables, they could hold garbage, or
have something in there that the kernel doesn't support. As soon as that is
detected, it gets removed so that it isn't looked at again.

-- Steve

