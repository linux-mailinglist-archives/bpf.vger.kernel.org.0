Return-Path: <bpf+bounces-66833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81625B3A201
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 16:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3BEA06AA6
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 14:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00664277C85;
	Thu, 28 Aug 2025 14:28:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0748621CA02;
	Thu, 28 Aug 2025 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391294; cv=none; b=e1ocnMy3C7yoaBwcpxfuaGDqIhVU8PR5s/C+DkgMGMlF9cEz9JaF2Z7W55rCJy3SGaNWyl9Mp5gI2oBP1lCoYxGlelobwn+zuqa9jbAlRezFofWnBeg/FT+ZwRfzV7Ct7l5w5kiBPqG2z1BF5jb+KPF4qpLmKnbX4QSa8W/xYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391294; c=relaxed/simple;
	bh=t7pg/G4Tk4S39M8NtXKJTglfwsOPVinBNlNJsePOcow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8ZKRAN8nxjB6ZZ89K+EiAiTguAL59eLxcRb1HnglaBmbU5ooXyoBRZVWqwYSfSY7zUBAuAavEEAPt2vEysdLD225OvYCd93xQxIksuKsD/swUHi1VxE1txZ/NVV+1ErK1RJgznfhn5iOnS8a+uQfxKJkW7AK523zbkXGiQiTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id C3E74577E2;
	Thu, 28 Aug 2025 14:28:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 39CDD29;
	Thu, 28 Aug 2025 14:27:59 +0000 (UTC)
Date: Thu, 28 Aug 2025 10:28:19 -0400
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
Message-ID: <20250828102819.27d62d75@gandalf.local.home>
In-Reply-To: <el6nfiplc3pitfief24cbcsd4dhvrp5hxwoz3dzccb5kilcogq@qv4pqrzekkfw>
References: <20250827201548.448472904@kernel.org>
	<20250827202440.444464744@kernel.org>
	<el6nfiplc3pitfief24cbcsd4dhvrp5hxwoz3dzccb5kilcogq@qv4pqrzekkfw>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xedd6eijkc1xu5qms1rx3p8witpz3qqo
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 39CDD29
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/UpGGk0sN7ZRFjbCfmYaa8yXlKjFyWmZ0=
X-HE-Tag: 1756391279-514030
X-HE-Meta: U2FsdGVkX1/NHsF/xLEc4nIoi2djvu4+eFUqz+90saW6KPe2SSSeHmY3d+2NzAa0ja91OBKVE3l04tc1bxQy7939iX/OxWrqxK1IELyEJeTE86USU8gn/Yo564nlJA0gRJUwLSoesr1f16mCj/54MlKG/D2f/iybpDUF+amParwwGdPNDuwVkc+tupcJa0smZ6kzulttx6uToOb3SFRwLvkJ65U63MpGUeLUyl80lS7vxSNbsm3iUljE607my7wQG5plrIvuU58Lc4jwmSELen3dko11S0vheFH6PbTbHgw4gWUnnOaT8XsXXcBY7bDZVhxP1UVlbhi9CDBAw8HqA0VFWELP40G2

On Wed, 27 Aug 2025 21:46:01 -0400
"Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> >  int sframe_remove_section(unsigned long sframe_start)
> >  {
> > -	return -ENOSYS;
> > +	struct mm_struct *mm = current->mm;
> > +	struct sframe_section *sec;
> > +	unsigned long index = 0;
> > +	bool found = false;
> > +	int ret = 0;
> > +
> > +	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
> > +		if (sec->sframe_start == sframe_start) {
> > +			found = true;
> > +			ret |= __sframe_remove_section(mm, sec);
> > +		}
> > +	}  
> 

Josh should be able to answer this better than I can, as he wrote it, and
I'm not too familiar with how to use maple tree (reading the documentation
now).

> If you use the advanced interface you have to handle the locking, but it
> will be faster.  I'm not sure how frequent you loop across many entries,
> but you can do something like:
> 
> MA_SATE(mas, &mm->sframe_mt, index, index);
> 
> mas_lock(&mas);
> mas_for_each(&mas, sec, ULONG_MAX) {
> ...
> }
> mas_unlock(&mas);
> 
> The maple state contains memory addresses of internal nodes, so you
> cannot just edit the tree without it being either unlocked (which
> negates the gains you would have) or by using it in the modification.
> 
> This seems like a good choice considering the __sframe_remove_section()
> is called from only one place. You can pass the struct ma_state through
> to the remove function and use it with mas_erase().
> 
> Actually, reading it again,  why are you starting a search at 0?  And
> why are you deleting everything after the sframe_start to ULONG_MAX?
> This seems incorrect.  Can you explain your plan a bit here?

Let me give a brief overview of how and why maple trees are used for
sframes:

The sframe section is mapped to the user space address from the elf file
when the application starts. The dynamic library loader could also do a
system call to tell the kernel where the sframe is for some dynamically
loaded code. Since there can be more than one text section that has an
sframe associated to it, the mm->sframe_mt is used to hold the range of
text to find its corresponding sframe section. That is, there's one sframe
section for the code that was loaded during exec(), and then there may be a
separate sframe section for every library that is loaded. Note, it is
possible that the same sframe section may cover more than one range of text.

When doing stack walking, the instruction pointer is used as the key in the
maple tree to find its corresponding sframe section.

Now, if the sframe is determined to be corrupted, it must be removed from
the current->mm->sframe_mt. It also gets removed when the dynamic loader
removes some text from the application that has the code.

I'm guessing that the 0 to ULONG_MAX is to simply find and remove all the
associated sframe sections, as there may be more than one text range that a
single sframe section covers.

Does this make sense?

Thanks for reviewing!

-- Steve

> 
> > +
> > +	if (!found || ret)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +void sframe_free_mm(struct mm_struct *mm)
> > +{
> > +	struct sframe_section *sec;
> > +	unsigned long index = 0;
> > +
> > +	if (!mm)
> > +		return;
> > +
> > +	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX)
> > +		free_section(sec);
> > +
> > +	mtree_destroy(&mm->sframe_mt);  
>

