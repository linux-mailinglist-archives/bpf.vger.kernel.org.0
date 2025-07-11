Return-Path: <bpf+bounces-63091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DCFB02605
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 22:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E90566B3C
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 20:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5431822A4DA;
	Fri, 11 Jul 2025 20:56:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2C019995E;
	Fri, 11 Jul 2025 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267416; cv=none; b=pxtmWn95Lf71IQf26wxnk3Zh1Q6dFskcvluC/vV/xCmEfdNbfBVriSE9MsToSZZfG44AaHS8XN4MwWXHanEhnB1IvfN2gOe0/kpNIzFcqXhjAqUZTEu5bIgxEY1WlAZcG59iDhW1IMDptMIOfMfI3nqhgAP/m6SBmSDJop8rFDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267416; c=relaxed/simple;
	bh=uZumtuSSmliFMIBh5qSPbQhn5tbKEvU5/OkxUvh3Y5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKxza4/C55nl86RxM9IJJRW96AcA/hvqmBcEQ2CwIcvn8GyVChRVYzZ+q0jjx2NJMPbVb7CnQghEUIb6mO9gNHr0FRfRVh/As9CUmyvKTbFJNEkiHjSUQ2oQG4+6MetJCJhS2ZAlH4I7aZhvkORwvXiPkAH96DASPCTc0zprWdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 0952F80BCA;
	Fri, 11 Jul 2025 20:56:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 897A91D;
	Fri, 11 Jul 2025 20:56:46 +0000 (UTC)
Date: Fri, 11 Jul 2025 16:56:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>
Subject: Re: [PATCH v13 00/11] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20250711165654.08ab1dc5@gandalf.local.home>
In-Reply-To: <aHFzdCv3-BRw9btW@google.com>
References: <20250708020003.565862284@kernel.org>
	<aHFzdCv3-BRw9btW@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 897A91D
X-Stat-Signature: jhaiescu5rgpejwnpgpjzxkm6ysbsrk4
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Ej+U+j9CCCPQAsk9gmwhcIoQOTKRD9v8=
X-HE-Tag: 1752267406-533946
X-HE-Meta: U2FsdGVkX19h7c8SjJQl6kkGtiqlV6jLIs5Ez8svbcPe1Co0sf+IdUDgo+Fx3uFlUCujEwxzV6X+N/e06MT7SvUfeAYXY84V9aFBsvOCZx0ouswLcgKVoRNRapMjH/oaXx0O+HPW274ZszFZh4b1l2IO2XlsxMKHtV8xU8yV2G5tcSa6AwBZJ62tml72QhZLTllXjVeDWx6UM7ssoxmMSiz5DXVQaa3y08DCfA1Wn7IY/GK0A920KWt3y3uyTZZFfMPFkJ8BiQ3jIwtQlNoQUB11sqeCMTP834Ea4ROEG//rcSOo71wHMOqbcgZ8Zxy1ECYgiiRwLS570mGBgxKKDid5WuIO5VEZ

On Fri, 11 Jul 2025 13:26:28 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> > - Removed use of timestamp. The deferred unwind has gone back to using
> >   cookies, and perf doesn't use the cookie. This means the
> >   struct perf_callchain_deferred_event is not modified.  
> 
> What about adding the cookies in the records to handle lost data?  Even
> if it's not necessary to match callchains to samples, it still needs to
> reject invalid callchains across the losts.  Maybe it can just flush
> pending samples when it sees LOST records and not try to match them but
> having the cookies will handle it more accurately as some callchains may
> be valid after the LOST.

Sure, I can add that back, with the added comments needed that Jens
suggested.

Thanks,

-- Steve

