Return-Path: <bpf+bounces-67828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B66B49E91
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBAF189FB49
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 01:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3A01A9FB7;
	Tue,  9 Sep 2025 01:17:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3CD72634;
	Tue,  9 Sep 2025 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757380647; cv=none; b=l3746+tRU7GRGTEUyhv0GhTQYtrvNktgJwP/UE8D+uwQo+J4tag6AaDFEUmMMZdv0rdZGq0vPm7CpPXLl+IaKzkQRfkK5tuZbyfF5xYfYXyuxzxW7w4MK+Q6KuelCbqG9DrHGQGY400JuyXwIoIA9bq9u3KgJjO18eoBKFbZ4Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757380647; c=relaxed/simple;
	bh=WyS4dxEmWDZXMBOG37rJkEoTtkOROH67mn1SKF8pw60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ze67xYaaegLo3kEHWHCcV6LU9eEdcxneBkE+hO0yE3tKldFxgvD0f3fhTui7Y6hPIKQMZRyY+tv9bK+bXc4v2VDPuTxbQjK119/L3/sKEkbZHtle+SryLqsgpp6XNjfT8VYzjef5UNTr/6NNDxJkC6nBcw3OsfrZH38wAsK05nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 444591402B4;
	Tue,  9 Sep 2025 01:17:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id EE7F12002C;
	Tue,  9 Sep 2025 01:17:15 +0000 (UTC)
Date: Mon, 8 Sep 2025 21:18:02 -0400
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
Message-ID: <20250908211802.1d3438d3@gandalf.local.home>
In-Reply-To: <CAHk-=wiEL-5f96NbRtm4JJVi6u=3Edto9-ZABgpOc6WAj=gX=w@mail.gmail.com>
References: <20250828180300.591225320@kernel.org>
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
	<CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
	<20250830143114.395ed246@batman.local.home>
	<CAHk-=wjgXGuJVaOmftxnwrS6FafwrLL+yHrH6-sgbBRB-iLn8w@mail.gmail.com>
	<20250908174235.29a57e62@gandalf.local.home>
	<CAHk-=wiEL-5f96NbRtm4JJVi6u=3Edto9-ZABgpOc6WAj=gX=w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jbo5gt7j8qwnq1u4m4kjfbxyns645h8j
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: EE7F12002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/v1P4jlNvlxCkwaDuyC3roPHDk5Tixu8E=
X-HE-Tag: 1757380635-192276
X-HE-Meta: U2FsdGVkX18WrPDkWXPcZGdwFRnyFGOC/tyENIyeZeht5/i1S5pnpkwDKCU7gQW5BmpVpBhIF8TIXR5etkzMBDKVzj3keQ09Lc4fxmDjkdBQoLuzehRUUW92LUaXJTdwwB9bCodS4wjv+8mcK88QZxDuJEV6/DJPwngRcW9fBcQhTGK/Ih87pX4Ip3U1MXRj/UtdAVEj1cTBqxf9gLlXLTPgoUwCxqyfj5RLjjTZQDp+CKXY0n4EPnoMc7cGyaR5WBLfdKTyPQS6hcNgOFiXZICDn9sg5vGWR9yj6JPkswDyjKzng/R63xXcNcHet0UCvkPqCG6bQw+9WmNREqJlX2JR3NfAj0C86cwimadPYd9G6yGX5DGIUexLx0i4i/IrnusKIzxxmDoZCNnIW/htuPqIWacG7FowpRaKrvFUtKg=

On Mon, 8 Sep 2025 16:09:50 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> > To compensate this, we could replace the path and build-id with a unique
> > identifier, (being an inode/device or hash, or whatever) to associate that
> > file. It may even work if it is unique per task. Then whenever one of these
> > identifiers were to show up representing a new file, it would be printed.  
> 
> So I really hate the inode number, because it's just wrong.

I just mentioned an identifier, it didn't need to be the inode.

> 
> So if you do that
> 
>     inode = file_user_inode(vma->vm_file);

And if I do end up using an inode, I'll make sure to use that.


> And *none* of these issues would be true of somebody who uses the
> 'perf()' interface that can do all of this much more efficiently, and
> without the downsides, and without any artificially limited sysfs
> interfaces.

Note, there is no user space component running during the trace when
tracing with tracefs, whereas perf requires a user space tool to be
running along with what is being traced. The idea, is not to affect what is
being traced by a user space tracer. Tracing is started when needed, and
when the anomaly is detected, tracing is stopped, and then the tooling
extracts the trace and post processes it.

> 
> So that really makes me go: just don't expose this at all in sysfs
> files.  You *cannot* do a good job in sysfs, because the interface is
> strictly worse than just doing the proper job using perf.
> 
> Alternatively, just do the expensive thing. Expose the actual
> pathname, and expose the build ID. Yes, it's expensive, but dammit,
> that's the whole *point* of tracing in sysfs. sysfs was never about
> being efficient, it was about convenience.

Technically, it's "tracefs" and not "sysfs". When tracefs is configured,
sysfs will create a directory called /sys/kernel/tracing to allow user
space to mount tracefs there, but it is still a separate file system which
can be mounted outside of sysfs.

The code in tracefs is designed to be very efficient and tries very hard to
keep the overhead down. The tracefs ring buffer is still 2 or 3 times
faster than the perf buffer. It is optimized for tracing, and that's even
why it doesn't rely on a user space component, as it's another way to allow
always-on-tracing to not affect the system as much while tracing.

> 
> So if you trace through sysfs, you either don't get the full
> information that could be there, or pay the price for the expense of
> generating the full info.

But I will say the time to get the path name isn't an issue here. It's the
size of the path name being recorded into the ring buffer. The ring buffer's
size is limited, and a lot of compaction techniques are used to try to use
it efficiently.

As the stack trace only happens when the task goes back to user space, it's
not as a time sensitive event as say function tracing. Thus spending a few
more microseconds on something isn't going to cause much of a notice.

An 8 byte identifier for a file is much better than the path name where it
can be 40 bytes or more. In my example:

 /usr/lib/x86_64-linux-gnu/libselinux.so.1

is 41 bytes, 42 if you count the nul terminating byte.

Now if we just hash the path name, that would be doable. Then when we see a
new name pop up, we can trigger another event to show the path name (and
perhaps even the build id). What's nice about triggering another event to
show the full path name, is that you can put that other event into another
buffer, to keep the path names from dropping stack traces, and vice versa.

I liked an idea you had in a previous email:
https://lore.kernel.org/all/CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com/

    You do it for the first time you see it, and every N times afterwards
    (maybe by simply using a counter array that is indexed by the low bits
    of the hash, and incrementing it for every hash you see, and if it was
    zero modulo N you do that "mmap reminder" thing).

Instead of a N counter, have a time expiry of say 200 milliseconds or so. At
the stack trace, look at the path name, hash it, put it into a look up
table, and if it's not there, trigger the other event to show the path name
and save it and a timestamp into the look up table. If it's in the look up
table, and the timestamp is greater than 200 milliseconds, trigger it again
and reset the timestamp.

The idea is only to remove duplicates, and move the longer names into a
separate buffer.

Recording full path names in every stack trace will make it much harder to
use the information as it will lose a lot more stack traces.

> 
> Make the "give me the expensive output" be a dynamic flag, so that you
> don't do it by default, but if you have some model where you are
> scripting things with shell-script rather than doing 'perf record', at
> least you get good output.

Note, it's not a shell script. We do have tooling, it's just that nothing
runs while the trace is happening. The tooling starts the trace and exits.
When the issue is discovered, tracing is stopped, and the tooling will then
extract the trace and process it. If a crash occurs, the persistent ring
buffer can be extracted to get the data.

We will use this in the field. That is, on chromebooks where people have
opted in to allow analysis of their machines. If there's an anomaly
detected in thousands of users, we can start tracing and then extract the
traces to debug what is happening on their machines. We want to make sure
we get enough stack traces that will go back far enough to where the issue
first occurred. Hence why we want to keep the traces small and compact.

-- Steve


