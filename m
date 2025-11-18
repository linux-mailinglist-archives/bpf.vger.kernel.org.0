Return-Path: <bpf+bounces-75001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27768C6B6D7
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 20:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E8A44E7CE7
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 19:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2122253FC;
	Tue, 18 Nov 2025 19:26:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC82E1F02;
	Tue, 18 Nov 2025 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763493977; cv=none; b=XT2JXwlFUPhVMNXPjwjmt6vAtgHibFFFL3pBwo1EG0FN1MfrZM8vqS/7uuAjezWRcJaSqWEPqYFozl4lWNibRAriGYjL4O67hFi1ei6WIrP9uwdarbH5B5tWefBJWtMeMPQfnPSuseD2v3iQCMW2ln4uLRWNk+pWXpDJT0QsX0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763493977; c=relaxed/simple;
	bh=TdE/U+7RQXi4SqrRnPOBPwoC1Yp2VMYbtN8CNa8ePG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFnNJumle5f8wapKgYWHAtUj1BXgO2n3FEmFGjsJat5Cw6aR6aeLdBy8Q1TqfYS1ChutZ3oxsFqG1CHc0g4fAM6Cuusbrel2ZhHME2C9o7p/8/h1rYuSZfM5uN1nVl8rh0LcfOcThgAdTnWdqoPDGpClj779EBCw3BAMMW2mwY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 49FED1A01AD;
	Tue, 18 Nov 2025 19:26:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 6318220030;
	Tue, 18 Nov 2025 19:25:56 +0000 (UTC)
Date: Tue, 18 Nov 2025 14:26:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org, Steven Rostedt
 <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, "Carlos
 O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, David
 Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka
 <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [PATCH v11 03/15] unwind_user/sframe: Add support for reading
 .sframe headers
Message-ID: <20251118142623.57a60a62@gandalf.local.home>
In-Reply-To: <e5c5e17f-1efd-4f9e-be2d-c6f65003ba3d@linux.ibm.com>
References: <20251022144326.4082059-1-jremus@linux.ibm.com>
	<20251022144326.4082059-4-jremus@linux.ibm.com>
	<e5c5e17f-1efd-4f9e-be2d-c6f65003ba3d@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tbzdfz6xijjf1nsx9rf5cecaz6t1797w
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 6318220030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18kMxDuWA1tAF9m0DoMD/Jf6AhXJD9G9Y4=
X-HE-Tag: 1763493956-237256
X-HE-Meta: U2FsdGVkX187IrvkH90ckrHBgaHws/CDDckN7oWOSHQjYNUrMmyzebyXREW0G5QsO8LWPgB7KUXrlIl53TbVunkyTH7yH6013m9YXFffYOwssCNgJobXZ42EzqvfFBlvuBf1bDwTdo/cPGPnxjh7EcAhSP0F1bNcPPsTwG6CxpKVWybID+0QFOB0gq1aLVm1YKfNghJNuA7rARi3zkYltVvQULz7rE1Ewqmd0/GNKcO+e3P9xl+9pGtp+4dSugY0O4tKiekgg3+E9xuViKe0/aJvKMAdftbtsFgOa2PIxhuKrghkQmTozwPhe97I/b8vgxn0XYhcL7DlbF/TRMZC+t+3ihZyz2MU

On Tue, 18 Nov 2025 18:04:27 +0100
Jens Remus <jremus@linux.ibm.com> wrote:

> I wonder whether the series should be restructured as follows:
> 
> unwind_user/sframe: Store .sframe section data in per-mm maple tree
> unwind_user/sframe: Detect .sframe sections in executables
> unwind_user/sframe: Add support for reading .sframe headers
> unwind_user/sframe: Add support for reading .sframe contents
> unwind_user/sframe: Wire up unwind_user to sframe
> x86/uaccess: Add unsafe_copy_from_user() implementation
> unwind_user/sframe/x86: Enable sframe unwinding on x86
> unwind_user: Stop when reaching an outermost frame
> unwind_user/sframe: Add support for outermost frame indication
> unwind_user/sframe: Remove .sframe section on detected corruption
> unwind_user/sframe: Show file name in debug output
> unwind_user/sframe: Add .sframe validation option
> unwind_user/sframe: Add prctl() interface for registering .sframe sections
> 
> While moving sframe_add_section() and sframe_remove_section() from
> "unwind_user/sframe: Add support for reading .sframe headers" to
> "unwind_user/sframe: Store .sframe section data in per-mm maple tree" or
> into a new second patch, as they depend on the first and are required
> by the third.
> 
> What are your thoughts?  The reordering might be wasted effort.

If you feel it makes it better, sure, go ahead and do it.

-- Steve

