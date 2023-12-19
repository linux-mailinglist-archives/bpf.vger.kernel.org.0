Return-Path: <bpf+bounces-18285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D148188C1
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 14:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81ED6285AAB
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F038A19471;
	Tue, 19 Dec 2023 13:37:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F931A587
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 13:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3D4C433C8;
	Tue, 19 Dec 2023 13:37:53 +0000 (UTC)
Date: Tue, 19 Dec 2023 08:38:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Philo Lu
 <lulie@linux.alibaba.com>, bpf@vger.kernel.org, song@kernel.org,
 andrii@kernel.org, ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 guwen@linux.alibaba.com, alibuda@linux.alibaba.com,
 hengqi@linux.alibaba.com, Nathan Slingerland <slinger@meta.com>,
 "rihams@meta.com" <rihams@meta.com>, Alan Maguire
 <alan.maguire@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Question about bpf perfbuf/ringbuf: pinned in backend with
 overwriting
Message-ID: <20231219083851.0ec83349@gandalf.local.home>
In-Reply-To: <qdiw6a7acgvepckv6uts5iusp74m7ud4i4lpniu3mgq6jdrs6s@mnttkagth64k>
References: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com>
	<c3c47250-2923-c376-4f5e-ddaf148bbf32@oracle.com>
	<CAEf4BzZOBdV9vxV6Gr9b5pQ8+M6tPVnHdmELWqOd5jdcL=KpiA@mail.gmail.com>
	<23691bb5-9688-4e93-a98c-1024e8a8fc62@linux.alibaba.com>
	<CAEf4BzaQv23wzgmmoSFBja7Syp3m3fRrfzWkFobQ4NNisDTEyA@mail.gmail.com>
	<qdiw6a7acgvepckv6uts5iusp74m7ud4i4lpniu3mgq6jdrs6s@mnttkagth64k>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 14:23:59 +0800
Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:

> Curious whether it is possible to reuse ftrace's trace buffer instead
> (or it's underlying ring buffer implementation at
> kernel/trace/ring_buffer.c). AFAICT it satisfies both requirements that
> Philo stated: (1) no need for user process as the buffer is accessible
> through tracefs, and (2) has an overwrite mode.

Yes, the ftrace ring-buffer was in fact designed for the above use case.

> 
> Further more, a natural feature request that would come after
> overwriting support would be snapshotting, and that has already been
> covered in ftrace.

Yes, it has that too.

> 
> Note: technically BPF program could already write to ftrace's trace
> buffer with the bpf_trace_vprintk() helper, but that goes through string
> formatting and only allows writing into to the global buffer.

When eBPF was first being developed, Alexei told me he tried the ftrace
ring buffer, and he said the filtering was too slow. That's because it
would always write into the ring buffer and then try to discard it after
the fact, which required a few cmpxchg to synchronize. He decided that the
perf ring buffer was a better fit for this.

That was solved with this: 0fc1b09ff1ff4 ("tracing: Use temp buffer when
filtering events") Which makes the filtering similar to perf as perf always
copies events to a temporary buffer first.

It still falls back to writing directly into the ring buffer if the temp
buffer is currently being used by another event on the same CPU.

Note that the perf ring buffer was designed for profiling (taking
intermediate traces) and tightly coupled to have a reader. Whereas the
ftrace ring buffer was designed for high speed constant tracing, with or
without a reader.

-- Steve

