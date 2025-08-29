Return-Path: <bpf+bounces-67023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D400BB3C213
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 19:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC247A5463
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAE534165B;
	Fri, 29 Aug 2025 17:52:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9431EF091;
	Fri, 29 Aug 2025 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756489922; cv=none; b=MzgsuVkcCg9wJWFLFt+QexE4ZqJn21XZLCNryFfXOmEHUiTHz93Z+jBNz5zL52ap4AoBT+j4SeuH6r/Lnf8CFU9W2MP+z/s/TzBlwXM9WmqswrIx/JWFmKVtzK3bp2qqSMUiBOPorJ/4nPS33qmRXn1SDFxj1+8fVAYUn8wS6ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756489922; c=relaxed/simple;
	bh=lodYfV7tgxa+jDYzCHE1/oRriI08XCqhcjW+lVIXhXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXxTh3t/Z1BlIs1o68NWOgw9S+ntCeFmdFYPW5ATuUUi2dbCVpKlaLKm+0oDbYjy6qZ5JFs7NuKJzs/7Of2KlpOY+KRB7nS6QP48arF7Wd1cPTJMhI2Z+U6+FA9eyGHEL1pC8Cjg77iHM9MZl7oqPEH2Jmg9dAjdbr49SXKKjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id C2DF013A849;
	Fri, 29 Aug 2025 17:51:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id B13401A;
	Fri, 29 Aug 2025 17:51:50 +0000 (UTC)
Date: Fri, 29 Aug 2025 13:52:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo
 <arnaldo.melo@gmail.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20250829135213.12104b17@gandalf.local.home>
In-Reply-To: <CAHk-=wj-ZfHXfXKtSNKoRXhNz10Do+mqDyUumEkx8H8OqVYP-A@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
	<D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
	<CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
	<20250828161718.77cb6e61@batman.local.home>
	<CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
	<20250828164819.51e300ec@batman.local.home>
	<CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
	<20250828171748.07681a63@batman.local.home>
	<CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
	<20250829110639.1cfc5dcc@gandalf.local.home>
	<CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
	<CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
	<20250829123321.63c9f525@gandalf.local.home>
	<CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
	<20250829125756.2be2a3c3@gandalf.local.home>
	<CAHk-=wj-ZfHXfXKtSNKoRXhNz10Do+mqDyUumEkx8H8OqVYP-A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B13401A
X-Stat-Signature: mnugijhp7qz76jkgwxc1ubz1kh91seq7
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+WY7Dek6SCEkl7lRyaKtfqswAeY5HyaIM=
X-HE-Tag: 1756489910-546407
X-HE-Meta: U2FsdGVkX18rZ/4F4Hp08qxxhHyMAv4BevZbFX0V46ZGaUwwo8kMbevYxO+/d0T7+WZCKc7/SAubFKxTJqdDnCxqKdEZVFWSX9eXERI9UhVHbgXeNyPDahh9NMzkfaBXeedHKyJAHm3ymWaw0nBrWSUi7CF7ao3T8MY+ws9571FCLsGgg/Hxs3xG3/0HWtWkOMsZQJjLMTE7xV8NJ5gTJDAFurCq94mEXb4+5XxeqlllxG/tRY+TlNvVxBdoxxteUQIhNYWOnOZUw7fl/mIguVGGy4n3fRyFDGmLjjlczc9CHyN5oNuVPA7elQNRMuyV3efYBZObKjFRpYRC6NA/VW54KbheDLVmZh/5cS9jDMj+Qujg+IqMuWuQxN2hSYwE

On Fri, 29 Aug 2025 10:02:40 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> (And, honestly, the likely thing is that you never match it up at all
> - you can delay the "match it up" until a human actually looks at a
> trace, which is presumably going to be a "one in a million" case).

Note the use case for this is for tooling that will be using these traces
for either flame graphs or for seeing where trouble areas are. That is, if
someone is enabling these stack traces, they most definitely will be looked
at. Maybe not directly by a human, but the tooling will and it will need the
mapping information.

-- Steve

