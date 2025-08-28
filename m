Return-Path: <bpf+bounces-66911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 325F2B3ADA1
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 00:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C0B1C2715A
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 22:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D19285049;
	Thu, 28 Aug 2025 22:44:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331126B77B;
	Thu, 28 Aug 2025 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756421084; cv=none; b=Jc4OciEBv9sX/jOmSTSLTb4axms2siXP/v7oPN6S2lPlM8uMDCk4JZIQH8UmkiqzbM72KA+Qol9TZV4hlXYXMxYdvyBCclN8wWkFb1a3EYtzllYUIgohLfpM/9kCSq4bvgpAqQNXiOup2h/+fNv1L9xYNoZ0wX6DGRc9TbNE3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756421084; c=relaxed/simple;
	bh=i8B475GFQv13EK2Z65lMMoGXTratgVqcu8ZihnWECDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVD2YQxcZw84/JH4iCE7KxNT3FYgeXKW5y3bOds29t3rit+WAoi0z9v14ljK41Ru86AQhcM6C+LmW9emX9p31ey1kxmdt0Ov2Dgl8b0frAAy4tELLlRqJ90W3i67OAcS0bDNXamDXK1XAsit7jW2UkL6VCAQ4QFkXHrdg9LM8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B4CF71190DE;
	Thu, 28 Aug 2025 22:44:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 806F62000D;
	Thu, 28 Aug 2025 22:44:33 +0000 (UTC)
Date: Thu, 28 Aug 2025 18:44:54 -0400
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
Message-ID: <20250828184454.0681a2c6@gandalf.local.home>
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
X-Rspamd-Queue-Id: 806F62000D
X-Stat-Signature: pc3b9kohapgudmcbqjtfxxb856xjt7x8
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/D+WLcwnZSdCPst/uJHEijZy1DI0ybSF0=
X-HE-Tag: 1756421073-400866
X-HE-Meta: U2FsdGVkX18ltWyuwuDBvGXtiJcyZ4mEbm6HixOdWvSKWt5tGg4YithH/RS+KFZ7rUIBG5mOkmgmhOTTCUOI20dcQI8uymQCBIpzD/qTjibf4wOgus3/OCRjjtsKsuqWKFSovfEcuCTdpPepB88LJnQzWPS/N8cmvgq94iXK0t5YjwEmIG8Nw+bk47IUlZ8c8qStPwB4MDKSamGl/7ctvUr+eAsCy+73GTziuNTqG0EPB2+cs4hvTHcgsAcQapuMK+9Y7vi7LhPB7Lh8u5bA8vV7/PGcy2P1OZzS8QcGsB/KzkbPGjImOgIvm23igNwc/BWktTTPWF9JrKsq9bvl3TYkpMvKLWUffzyU+eWuzhJxm/toPuQWql2e2cu7WOCLkvLXoe5GhEowGblVCM6yPQ==


[ My last email of the night, as it's our anniversary, and I'm off to dinner now ;-) ]

On Thu, 28 Aug 2025 15:10:52 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 28 Aug 2025 at 14:17, Steven Rostedt <rostedt@kernel.org> wrote:
> >
> > But that's unique per task, right? What I liked about the f_inode
> > pointer, is that it appears to be shared between tasks.  
> 
> I actually think the local meaning of the file pointer is an advantage.
> 
> It not only means that you see the difference in mappings of the same
> file created with different open calls, it also means that when
> different processes mmap the same executable, they don't see the same
> hash.
> 
> And because the file pointer doesn't have any long-term meaning, it
> also means that you also can't make the mistake of thinking the hash
> has a long lifetime. With an inode pointer hash, you could easily have
> software bugs that end up not realizing that it's a temporary hash,
> and that the same inode *will* get two different hashes if the inode
> has been flushed from memory and then loaded anew due to memory
> pressure.

This is a reasonable argument. But it is still nice to have the same value
for all tasks. This is for a "file_cache" that does get flushed regularly
(when various changes happen to the tracefs system).

It's only purpose is to map the user space stack trace hash value to a path
name (and build-id).

But yeah, I do not want another file to get flagged with the same hash.

> 
> > I only want to add a new hash and print the path for a new file. If
> > several tasks are using the same file (which they are with the
> > libraries), then having the hash be the same between tasks would be
> > more efficient.  
> 
> Why? See above why I think it's a mistake to think those hashes have
> lifetimes. They don't. Two different inodes can have the same hash due
> to lifetime issues, and the same inode can get two different hashes at
> different times for the same reason.
> 
> So you *need* to tie these things to the only lifetime that matters:
> the open/close pair (and the mmap - and the stack traces - will be
> part of that lifetime).
> 
> I literally think that you are not thinking about this right if you
> think you can re-use the hash.

I'm just worried about this causing slow downs, especially if I also track
the buildid. I did a quick update to the code to first use the f_inode and
get the build_id, and it gives:

       trace-cmd-1012    [003] ...1.    35.247318: inode_cache: hash=0xcb214087 path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
       trace-cmd-1012    [003] ...1.    35.247333: inode_cache: hash=0x2565194a path=/usr/local/bin/trace-cmd build_id={0x3f399e26,0xf9eb2d4d,0x475fa369,0xf5bb7eeb,0x6244ae85}
       trace-cmd-1012    [003] ...1.    35.247419: inode_cache: hash=0x22dca920 path=/usr/local/lib64/libtracefs.so.1.8.2 build_id={0x6b040bdb,0x961f23d6,0xc1e1027e,0x7067c348,0xd069fa67}
       trace-cmd-1012    [003] ...1.    35.247455: inode_cache: hash=0xe87b6ea5 path=/usr/local/lib64/libtraceevent.so.1.8.4 build_id={0x8946b4eb,0xe3bf4ec5,0x11fd7d86,0xcd3105e2,0xe44a8d4d}
       trace-cmd-1012    [003] ...1.    35.247488: inode_cache: hash=0xafc34117 path=/usr/lib/x86_64-linux-gnu/libzstd.so.1.5.7 build_id={0x379dc873,0x32bbdbc4,0x91eeb6cf,0xba549730,0xe2b96c55}
            bash-1003    [001] ...1.    35.248508: inode_cache: hash=0xcf9bd2d6 path=/usr/bin/bash build_id={0xd94aa36d,0x8e1f19c7,0xa4a69446,0x7338f602,0x20d66357}
  NetworkManager-581     [004] ...1.    35.703993: inode_cache: hash=0xea1c3e22 path=/usr/sbin/NetworkManager build_id={0x278c6dbb,0x4a1cdde6,0xa1a30a2c,0xbc417464,0x9dfaa28e}
            bash-1003    [001] ...1.    35.904817: inode_cache: hash=0x133252fa path=/usr/lib/x86_64-linux-gnu/libtinfo.so.6.5 build_id={0xff2193a5,0xb2ece2f1,0x1bcbd242,0xca302a0b,0xc155fd26}
            bash-1013    [004] ...1.    37.716435: inode_cache: hash=0x53ae379b path=/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 build_id={0x4ed9e462,0xb302cd84,0x3ccf0104,0xbd80ac72,0x91c7fd44}
            bash-1013    [004] ...1.    37.722923: inode_cache: hash=0xa55a259e path=/usr/lib/x86_64-linux-gnu/libz.so.1.3.1 build_id={0xc2d9e5b6,0xb211e958,0xdef878e4,0xe4022df,0x9552253}

Now I changed it to be the file pointer, and it does give a bit more (see the duplicates):

    sshd-session-1004    [007] ...1.    98.940058: inode_cache: hash=0x41a6191a path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
       trace-cmd-1016    [006] ...1.    98.940089: inode_cache: hash=0xcc38a542 path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
       trace-cmd-1016    [006] ...1.    98.940109: inode_cache: hash=0xa89cdd4b path=/usr/local/bin/trace-cmd build_id={0x3f399e26,0xf9eb2d4d,0x475fa369,0xf5bb7eeb,0x6244ae85}
       trace-cmd-1016    [006] ...1.    98.940410: inode_cache: hash=0xb3c570ca path=/usr/local/lib64/libtracefs.so.1.8.2 build_id={0x6b040bdb,0x961f23d6,0xc1e1027e,0x7067c348,0xd069fa67}
       trace-cmd-1016    [006] ...1.    98.940460: inode_cache: hash=0x4da4af85 path=/usr/local/lib64/libtraceevent.so.1.8.4 build_id={0x8946b4eb,0xe3bf4ec5,0x11fd7d86,0xcd3105e2,0xe44a8d4d}
       trace-cmd-1016    [006] ...1.    98.940513: inode_cache: hash=0xce16bd9d path=/usr/lib/x86_64-linux-gnu/libzstd.so.1.5.7 build_id={0x379dc873,0x32bbdbc4,0x91eeb6cf,0xba549730,0xe2b96c55}
            bash-1007    [004] ...1.    98.941772: inode_cache: hash=0x772df671 path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
            bash-1007    [004] ...1.    98.941911: inode_cache: hash=0xdb764962 path=/usr/bin/bash build_id={0xd94aa36d,0x8e1f19c7,0xa4a69446,0x7338f602,0x20d66357}
            bash-1007    [004] ...1.   100.080299: inode_cache: hash=0xef3bf212 path=/usr/lib/x86_64-linux-gnu/libtinfo.so.6.5 build_id={0xff2193a5,0xb2ece2f1,0x1bcbd242,0xca302a0b,0xc155fd26}
           gmain-602     [003] ...1.   100.477235: inode_cache: hash=0xc9205658 path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
       trace-cmd-1017    [005] ...1.   101.412116: inode_cache: hash=0x5a77751e path=/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 build_id={0x4ed9e462,0xb302cd84,0x3ccf0104,0xbd80ac72,0x91c7fd44}
       trace-cmd-1017    [005] ...1.   101.417004: inode_cache: hash=0xf2e95689 path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
       trace-cmd-1017    [005] ...1.   101.418528: inode_cache: hash=0x5f35d3ca path=/usr/lib/x86_64-linux-gnu/libzstd.so.1.5.7 build_id={0x379dc873,0x32bbdbc4,0x91eeb6cf,0xba549730,0xe2b96c55}
       trace-cmd-1017    [005] ...1.   101.418572: inode_cache: hash=0x57feda78 path=/usr/lib/x86_64-linux-gnu/libz.so.1.3.1 build_id={0xc2d9e5b6,0xb211e958,0xdef878e4,0xe4022df,0x9552253}
       trace-cmd-1017    [005] ...1.   101.418620: inode_cache: hash=0x22ad5d84 path=/usr/local/lib64/libtraceevent.so.1.8.4 build_id={0x8946b4eb,0xe3bf4ec5,0x11fd7d86,0xcd3105e2,0xe44a8d4d}
       trace-cmd-1017    [005] ...1.   101.418666: inode_cache: hash=0x11c240a6 path=/usr/local/lib64/libtracefs.so.1.8.2 build_id={0x6b040bdb,0x961f23d6,0xc1e1027e,0x7067c348,0xd069fa67}
       trace-cmd-1017    [005] ...1.   101.418714: inode_cache: hash=0xf4e46cf path=/usr/local/bin/trace-cmd build_id={0x3f399e26,0xf9eb2d4d,0x475fa369,0xf5bb7eeb,0x6244ae85}
  wpa_supplicant-583     [000] ...1.   102.521195: inode_cache: hash=0xd20a587b path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
       trace-cmd-1018    [005] ...1.   102.847910: inode_cache: hash=0xee16ee8e path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
    sshd-session-1004    [000] ...1.   102.853561: inode_cache: hash=0x3404c7ea path=/usr/lib/openssh/sshd-session build_id={0x3b119855,0x5b15323e,0xe1ec337a,0xbd49f66e,0x78bddd0f}
   systemd-udevd-323     [007] ...1.   125.800839: inode_cache: hash=0x760273d5 path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
 systemd-journal-294     [000] ...1.   125.800932: inode_cache: hash=0x77f34056 path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
   systemd-udevd-323     [007] ...1.   125.801135: inode_cache: hash=0xe70bd063 path=/usr/lib/x86_64-linux-gnu/systemd/libsystemd-shared-257.so build_id={0x81d9bace,0x59f9953f,0x439928d7,0xe849d513,0xf2103286}
         systemd-1       [006] ...1.   125.801781: inode_cache: hash=0x42292844 path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
         systemd-1       [006] ...1.   125.802811: inode_cache: hash=0x2cac8b3b path=/usr/lib/x86_64-linux-gnu/systemd/libsystemd-core-257.so build_id={0x580a80c5,0x931714d2,0xec54d3be,0xd5400bc0,0x6f2530ba}
         systemd-1       [006] ...1.   125.803740: inode_cache: hash=0xb17acaa6 path=/usr/lib/x86_64-linux-gnu/systemd/libsystemd-shared-257.so build_id={0x81d9bace,0x59f9953f,0x439928d7,0xe849d513,0xf2103286}
            cron-541     [006] ...1.   138.192640: inode_cache: hash=0x9285db61 path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
  NetworkManager-581     [005] ...1.   144.716224: inode_cache: hash=0xf3c5bbc1 path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
  NetworkManager-581     [005] ...1.   144.716392: inode_cache: hash=0x381883bb path=/usr/sbin/NetworkManager build_id={0x278c6dbb,0x4a1cdde6,0xa1a30a2c,0xbc417464,0x9dfaa28e}
  NetworkManager-581     [005] ...1.   146.385151: inode_cache: hash=0x43451e15 path=/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.8400.0 build_id={0x9a7d3e29,0x5d8ed8f,0xe399da0,0xb5d373da,0x3ca1049b}
         chronyd-663     [001] ...1.   157.080405: inode_cache: hash=0xa0db647a path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
         chronyd-663     [001] ...1.   158.152790: inode_cache: hash=0x1c471c4c path=/usr/sbin/chronyd build_id={0xf9588e62,0x3a8e6223,0x619fcb4f,0x12562bb,0x2ea104fb}

But maybe it's not enough to be an issue. But this will become more
predominate when sframes is built throughout. I only have a few
applications having sframes enabled so not every task is getting a full
stack trace, and hence, not all the files being touched is being displayed.

Just to clarify my concern. I want the stack traces to be quick and small.
I believe a 32 bit hash may be enough. And then have a side event that gets
updated when new files appear that can display much more information. This
side event may be slow which is why I don't want it to occur often. But I
do want it to occur for all new files.

-- Steve

