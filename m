Return-Path: <bpf+bounces-66987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EFEB3BED5
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8E44672D1
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B9F321F37;
	Fri, 29 Aug 2025 15:06:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B7C2135CE;
	Fri, 29 Aug 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479994; cv=none; b=Hh2UoxZcH+Ic0UQYymWFcUdwuop9LtroughvCxxxVhJQ6zYRF6ZtQkzy3HCMd8z9n/kRQPAfKH9VXoCmdPvFXKsF5fEvCnmaswv6o5IczLoXk7K86qM2i3w5My6Bukm1wNTszbhdBfZAG2ChfUwPILvShQcjPK6a1Vlo9MVcOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479994; c=relaxed/simple;
	bh=apVO4erBY67X3gOL47lHlUPruWHS2u9r8oRV22lYIPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZcnar79ZJLfVYWlaHfYHqtbEcVkAEFVfiH6FJ/HmpiuU5q1vcQfYtUkUpMRua1JQtC0pbUKZFvuujTuJMQhNlVoCrVwkI33epWpMxTAQSpsnbMavqu/BpHMIqt7JKQSrkXfWAASV1JdtZWdFT3ZPI3Faa8Q93mca9rDtXWLVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 579711DEA3E;
	Fri, 29 Aug 2025 15:06:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id ECCB36001C;
	Fri, 29 Aug 2025 15:06:16 +0000 (UTC)
Date: Fri, 29 Aug 2025 11:06:39 -0400
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
Message-ID: <20250829110639.1cfc5dcc@gandalf.local.home>
In-Reply-To: <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
	<20250828180357.223298134@kernel.org>
	<CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
	<D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
	<CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
	<20250828161718.77cb6e61@batman.local.home>
	<CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
	<20250828164819.51e300ec@batman.local.home>
	<CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
	<20250828171748.07681a63@batman.local.home>
	<CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pe9uoz3cgkztrrbpdod16zao8fx3pcd7
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: ECCB36001C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+w+yQFbZ+QM+XAONzSEjn0kRKCzwUOCC4=
X-HE-Tag: 1756479976-193067
X-HE-Meta: U2FsdGVkX1+UuCDfBTIeCsB+M0BOp4BQ7P7j+vJ48thHOd7BLOHXUs5j9udANa2Dy2UZQcxe/ahZ+p5whmf51D64bUEKI0K6KykxuiK/McDkruG7NMpRAxBhM9aadmk2jlcxDViRSrFic5hvwBNxnENXiCFT6T4hGzSAPis60BJhQKMTVGHzbu/7vGP7UxTvt06Xv0l25vXZ1iX+emn3ZKT2UjE3hnRpJYfQ73tGJdOP5Cldsj8yzBkt4JlvEVO8GgKUMZgnIYtr70I/domfK1W+DQmmThtNYuDMTYKe+5EeS6ByJUdiCFzSb0JhVzaUwAvt+L7wLiYa6HaIc8e3hR4laqmGJYl+N8kL4CTP2ka44U+Fi9PgHqK0vBUnY4wO

On Thu, 28 Aug 2025 15:10:52 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And because the file pointer doesn't have any long-term meaning, it
> also means that you also can't make the mistake of thinking the hash
> has a long lifetime. With an inode pointer hash, you could easily have
> software bugs that end up not realizing that it's a temporary hash,
> and that the same inode *will* get two different hashes if the inode
> has been flushed from memory and then loaded anew due to memory
> pressure.

The hash value can actually last longer than the file pointer. Thus, if we
use the file pointer for the hash, then we could risk it getting freed and
then allocated again for different file. Then we get the same hash value
for two different paths.

What I'm looking at doing is using both the file pointer as well as its
path to make the hash:

struct jhash_key {
	void		*file;
	struct path	path;
};

u32 trace_file_cache_add(struct vm_area_struct *vma)
{
	[..]
	static u32 initval;
	u32 hash;

	if (!vma->vm_file)
		return 0;

	if (!initval)
		get_random_bytes(&initval, sizeof(initval));

	jkey.file = vma->vm_file;
	jkey.path = vma->vm_file->f_path;

	hash = jhash(&jkey, sizeof(jkey), initval);

	if (!trace_file_cache_enabled())
		return hash;

	[ add the hash to the rhashtable and print if unique ]

Hopefully by using both the file pointer and its path to create the hash,
it will stay unique for some time.

-- Steve

