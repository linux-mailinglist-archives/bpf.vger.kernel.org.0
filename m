Return-Path: <bpf+bounces-18525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B16B81B6D8
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 14:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCA31C25A72
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FB17347C;
	Thu, 21 Dec 2023 13:00:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCAC7318E
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vyxmfz9_1703163640;
Received: from 30.221.128.103(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0Vyxmfz9_1703163640)
          by smtp.aliyun-inc.com;
          Thu, 21 Dec 2023 21:00:41 +0800
Message-ID: <cde8a134-8185-4387-a2f5-db2f1173b31b@linux.alibaba.com>
Date: Thu, 21 Dec 2023 21:00:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about bpf perfbuf/ringbuf: pinned in backend with
 overwriting
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org, song@kernel.org,
 andrii@kernel.org, ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 guwen@linux.alibaba.com, alibuda@linux.alibaba.com,
 hengqi@linux.alibaba.com, Nathan Slingerland <slinger@meta.com>,
 "rihams@meta.com" <rihams@meta.com>, Alan Maguire <alan.maguire@oracle.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com>
 <c3c47250-2923-c376-4f5e-ddaf148bbf32@oracle.com>
 <CAEf4BzZOBdV9vxV6Gr9b5pQ8+M6tPVnHdmELWqOd5jdcL=KpiA@mail.gmail.com>
 <23691bb5-9688-4e93-a98c-1024e8a8fc62@linux.alibaba.com>
 <CAEf4BzaQv23wzgmmoSFBja7Syp3m3fRrfzWkFobQ4NNisDTEyA@mail.gmail.com>
 <qdiw6a7acgvepckv6uts5iusp74m7ud4i4lpniu3mgq6jdrs6s@mnttkagth64k>
 <20231219083851.0ec83349@gandalf.local.home>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <20231219083851.0ec83349@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steven,

Thanks for your explanation about ftrace ring buffer. Also thanks to 
Shung-Hsi for the discussion.

Here are some features of ftrace buffer that I'm not sure if they are 
right. Could you please tell me if my understandings correct?

(1) When reading and writing occur concurrently:
   (a) If reader is faster than writer, the reader cannot get the page 
which is still being written, which means the reader cannot get the data 
immediately of one-page length in the worst case.
   (b) If writer is faster than reader, the only race between them is 
when reader is doing swap while writer wraps in overwrite mode. But if 
the reader has finished swapping, the writer can wrap safely, because 
the reader page if already out of the buffer page list.

(2) As the per-cpu buffer list is dynamic with reader page moves, we 
cannot do mmap to expose the buffer to user. Users can consume at most 
one page at a time.

(3) The wake-up behavior is controllable. If there is no waiter at all, 
no overhead will be induced because of waking up.

Thanks.

On 2023/12/19 21:38, Steven Rostedt wrote:
> On Tue, 19 Dec 2023 14:23:59 +0800
> Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> 
>> Curious whether it is possible to reuse ftrace's trace buffer instead
>> (or it's underlying ring buffer implementation at
>> kernel/trace/ring_buffer.c). AFAICT it satisfies both requirements that
>> Philo stated: (1) no need for user process as the buffer is accessible
>> through tracefs, and (2) has an overwrite mode.
> 
> Yes, the ftrace ring-buffer was in fact designed for the above use case.
> 
>>
>> Further more, a natural feature request that would come after
>> overwriting support would be snapshotting, and that has already been
>> covered in ftrace.
> 
> Yes, it has that too.
> 
>>
>> Note: technically BPF program could already write to ftrace's trace
>> buffer with the bpf_trace_vprintk() helper, but that goes through string
>> formatting and only allows writing into to the global buffer.
> 
> When eBPF was first being developed, Alexei told me he tried the ftrace
> ring buffer, and he said the filtering was too slow. That's because it
> would always write into the ring buffer and then try to discard it after
> the fact, which required a few cmpxchg to synchronize. He decided that the
> perf ring buffer was a better fit for this.
> 
> That was solved with this: 0fc1b09ff1ff4 ("tracing: Use temp buffer when
> filtering events") Which makes the filtering similar to perf as perf always
> copies events to a temporary buffer first.
> 
> It still falls back to writing directly into the ring buffer if the temp
> buffer is currently being used by another event on the same CPU.
> 
> Note that the perf ring buffer was designed for profiling (taking
> intermediate traces) and tightly coupled to have a reader. Whereas the
> ftrace ring buffer was designed for high speed constant tracing, with or
> without a reader.
> 
> -- Steve

