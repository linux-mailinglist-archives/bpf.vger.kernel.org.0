Return-Path: <bpf+bounces-18541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7825A81B9D2
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 15:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0D51F225FE
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B5A1DFF1;
	Thu, 21 Dec 2023 14:48:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E836089
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 14:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39068C433C7;
	Thu, 21 Dec 2023 14:48:14 +0000 (UTC)
Date: Thu, 21 Dec 2023 09:49:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, bpf@vger.kernel.org, song@kernel.org,
 andrii@kernel.org, ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 guwen@linux.alibaba.com, alibuda@linux.alibaba.com,
 hengqi@linux.alibaba.com, Nathan Slingerland <slinger@meta.com>,
 "rihams@meta.com" <rihams@meta.com>, Alan Maguire
 <alan.maguire@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Question about bpf perfbuf/ringbuf: pinned in backend with
 overwriting
Message-ID: <20231221094917.20718e9b@gandalf.local.home>
In-Reply-To: <cde8a134-8185-4387-a2f5-db2f1173b31b@linux.alibaba.com>
References: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com>
	<c3c47250-2923-c376-4f5e-ddaf148bbf32@oracle.com>
	<CAEf4BzZOBdV9vxV6Gr9b5pQ8+M6tPVnHdmELWqOd5jdcL=KpiA@mail.gmail.com>
	<23691bb5-9688-4e93-a98c-1024e8a8fc62@linux.alibaba.com>
	<CAEf4BzaQv23wzgmmoSFBja7Syp3m3fRrfzWkFobQ4NNisDTEyA@mail.gmail.com>
	<qdiw6a7acgvepckv6uts5iusp74m7ud4i4lpniu3mgq6jdrs6s@mnttkagth64k>
	<20231219083851.0ec83349@gandalf.local.home>
	<cde8a134-8185-4387-a2f5-db2f1173b31b@linux.alibaba.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 21:00:39 +0800
Philo Lu <lulie@linux.alibaba.com> wrote:

> Hi Steven,
> 
> Thanks for your explanation about ftrace ring buffer. Also thanks to 
> Shung-Hsi for the discussion.
> 
> Here are some features of ftrace buffer that I'm not sure if they are 
> right. Could you please tell me if my understandings correct?
> 
> (1) When reading and writing occur concurrently:
>    (a) If reader is faster than writer, the reader cannot get the page 
> which is still being written, which means the reader cannot get the data 
> immediately of one-page length in the worst case.

Nope, that's not the case. Otherwise you couldn't do this!

 ~# cd /sys/kernel/tracing
 ~# echo hello world > trace_marker
 ~# cat trace_pipe
           <...>-861     [001] ..... 76124.880943: tracing_mark_write: hello world

Yes, the reader swaps out an active sub-buffer to read it. But it's fine if
the writer is still on that sub-buffer. That's because the sub-buffers are
a linked list and the writer will simply walk off the end of the sub-buffer
and back into the sub-buffers in the active ring buffer.

Note, in this case, the ring buffer cannot give the sub-buffer to the
reader to pass to splice, as then it could free it while the writer is
still on it, but instead, copies the data for the reader. It also keeps
track of what it copied so it doesn't copy it again the next time.

>    (b) If writer is faster than reader, the only race between them is 
> when reader is doing swap while writer wraps in overwrite mode. But if 
> the reader has finished swapping, the writer can wrap safely, because 
> the reader page if already out of the buffer page list.

Yes, that is the point of contention. But the writer doesn't wait for the
reader. The reader does a cmpxchg loop to make sure it's not conflicting
with the writer. The writer has priority and doesn't loop in this case.
That is, a reader will not slow down the writer except for what the
hardware causes in the contention.

> 
> (2) As the per-cpu buffer list is dynamic with reader page moves, we 
> cannot do mmap to expose the buffer to user. Users can consume at most 
> one page at a time.

The code works with splice, and the way trace-cmd does it, is to use the
max pipe size, and will read by default 64kb at a time. The internals swap
out one sub-buffer at a time, but then move them into the pipe, with zero
copy (if the sub-buffers are full and the writer is not still on them). The
user can see all these sub-buffers in the pipe at once.

I'm working to have 6.8 remove the limit of "one page" and allow the
sub-buffers to be any order of pages (1,2,4,8,...). I'm hoping to have that
work pushed to linux-next by end of today.

 https://lore.kernel.org/linux-trace-kernel/20231219185414.474197117@goodmis.org/

and we are also working on mmapping the ring buffer to user space:

 https://lore.kernel.org/linux-trace-kernel/20231219184556.1552951-1-vdonnefort@google.com/

That may not make 6.8 but will likely make 6.9 at the latest.

It still requires user space to make an ioctl() system call between
sub-buffers, as the swap logic is still implemented.

The way it will work is all the sub-buffers will be mmapped to user space
including the reader page. A meta data will point to which sub-buffer is
what. When user space calls the ioctl() it will update which one of the
mapped sub-buffers is the "reader-page" (really "reader-subbuf") and the
writers will not write on it. When user space is finished reading the data
on the reader-page it will call the ioctl() again and the meta data will be
updated to point to which sub-buffer is now the new "reader-page" for user
space to read.

There's no new allocations needed for the swap. The old reader-subbuf gets
swapped with one of the active sub-buffers and becomes an active sub-buffer
itself. The swapped out sub-buffer becomes the new "reader-page/subbuf".

> 
> (3) The wake-up behavior is controllable. If there is no waiter at all, 
> no overhead will be induced because of waking up.

Correct. When there's a waiter, a bit is set and an irq_work is called to
wake up the waiter (this is basically the same as what perf does).

You can also set when you want to wake up via the buffer_percent file in
tracefs. If the buffer is not filled to the percentage specified, it will
not wake up the waiters.

-- Steve

