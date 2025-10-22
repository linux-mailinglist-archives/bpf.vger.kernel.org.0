Return-Path: <bpf+bounces-71854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CA7BFE5B7
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 23:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48E53A9134
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 21:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D573305042;
	Wed, 22 Oct 2025 21:58:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5ED2FABF0;
	Wed, 22 Oct 2025 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170327; cv=none; b=DNCM05N8BiqQB9RJ7m7o5C1IdK5odUCpStiMsycQtBKRpqETHecKCfwiAM6/KCWXwqeVnpKDXExlV81w7ddgZLGrd+xHPuhHDHc0bBabpggH3Zq9XwhafT3Igk9lZh2mBaCDNftuHSklQu2SjJynYrh40VVVe+kxCWHZbQUOU4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170327; c=relaxed/simple;
	bh=R+7MM262PH/JVz87dey4sJwnUpOcNmwpRnabeIBO2ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSRSixwUD/mGi4rgexTlYg+6/uOKKkqZMnLuujw347GFvcsif171x3hYm1JmGz39L9Hzve94vlr//tuyVOrrmgX5NKgyWxExrwR7GVP6tvdcd/EoMfe8OSyJeexqs+H7/nBuQ+HCFfxp7kcyTIwJCAvVietlP5B2pADRV48vD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id BDC15160997;
	Wed, 22 Oct 2025 21:58:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id D10CA35;
	Wed, 22 Oct 2025 21:58:30 +0000 (UTC)
Date: Wed, 22 Oct 2025 17:58:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 linux-mm@kvack.org, Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Florian Weimer
 <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, "Carlos O'Donell"
 <codonell@redhat.com>, Sam James <sam@gentoo.org>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, David
 Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka
 <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [PATCH v11 00/15] unwind_deferred: Implement sframe handling
Message-ID: <20251022175855.383f4148@gandalf.local.home>
In-Reply-To: <20251022133932.5e8b419d3525da07453b137d@linux-foundation.org>
References: <20251022144326.4082059-1-jremus@linux.ibm.com>
	<20251022133932.5e8b419d3525da07453b137d@linux-foundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bsfc6mitws67pox8hr1i96sxk1378s1t
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: D10CA35
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18I+F+bKdHr/1KWa9dV4J918j6i3JKGfmQ=
X-HE-Tag: 1761170310-477037
X-HE-Meta: U2FsdGVkX1+6Dwf/frnjEfjO+nympxtkiyuuKnisUQHr0Ev92Yu80CM0iT0usvlkaJZYGaIje1yrwxXmuC/2UwH2bLBFlm4aEftY60JIyC8Po8JN8XT+0XN9xMhK7T0Yc3dOEkK+DfC9KY0c8XFYcSLHVLGR/rPlrif/jrS7eiW/K4a5BqbVunBK4ORQ5r4o77YidFgjWtBjWG02uaglaCLPKbMNmlv70EX7LsB03TgsAleK8nBQOzgx3Dr5xk81Qq3N94MBUCR5kAGVuGm3DmJNBLoAdeykzbNvVJugFbhOt8fkmMkVkAkA/HVBssjta7TFaiiBrjbrpMnHdPNR9SvdxAqZSyzwa5E78Php+ZvqWajXvn4KcUbGfIlAtwcqbuaXmHDan4QPGEMhnQ0oTg==

On Wed, 22 Oct 2025 13:39:32 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 22 Oct 2025 16:43:11 +0200 Jens Remus <jremus@linux.ibm.com> wrote:
> 
> > This is the implementation of parsing the SFrame section in an ELF file.  
> 
> Presently x86_64-only, it seems.  Can we expect to see this implemented
> for other architectures?

Yes, and Jens is here to port it to the s390 :-)

Currently Peter Zijlstra and I are updating the deferred unwinder. Jens is
working on getting sframes to work with it. His interest is getting it for
s390 whereas ours is for x86.

> 
> Would a selftest for this be appropriate?  To give testers some way of
> exercising the code and make to life better for people who are enabling
> this on other architectures.

Yes we should definitely have selftests. But we are far from getting there.
One requirement is that the toolchain used to build the test must support
adding sframes.

> 
> In what tree do you anticipate this project being carried?
> 

It will likely go between tip or my tree.

-- Steve

