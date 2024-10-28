Return-Path: <bpf+bounces-43301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0EA9B31D4
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 14:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541CD1F21F22
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 13:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E381DCB06;
	Mon, 28 Oct 2024 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KQNM9MEj"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E31DC730;
	Mon, 28 Oct 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122706; cv=none; b=QtpfRi7kJ75EES7xX/1Diydmtkz6Cwnn/t3Ybzwu4NVYYf3UTzJMXoBOK990n3HGaZNJCmCu5eNfUmIwIkiKDS3QNRB2GQayj+xJ+/hj0s9cCduEchXk9tx01IihNqK0CkR24ZrKQWYr2GHK1hnsGJZ+8gZpNbvXaViYJ7kwVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122706; c=relaxed/simple;
	bh=PQsmwnRSoJgBKYMVwQrVMe6PPvEJe4g9uksm+f7pXQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0QgoUoTSQlvchg0odUxsfmSWs8OEUtmH0aMC89hRDKouh5D3sffshKrqeLlYI+MtpYOHsFYkR+5spRjKPhHRmflOqmMJFZDjylxO2rZIJTnDdv3XxEPQEdCyP4hwEB82YZqSgWwPnifmVIt0uSAMrjNuzlASRMf+0e8lHPzMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=KQNM9MEj; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730122703;
	bh=PQsmwnRSoJgBKYMVwQrVMe6PPvEJe4g9uksm+f7pXQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KQNM9MEjXDLUu0yqHqwIby5UG0G53zP7C2Bzr5Yl8aHYzhbmYPZ10w9P+E7zZNzlY
	 w10/bMA491wRvTFKTUZjSKb4kkiHpDT2e5zlzJPgrDMoyiB1ZqOGvONkK26R50vHDf
	 uciHd4u8G6sWPDAC7UJyAXzjz+iR9T2hiYE2LrMq0H9dNgyYlpdpMzVqlVOTbmXHJy
	 2ZEqqdc2VqYZFgf+TFB64d3JKtak492tIs2u/qCNR+ItDY0vatVrz0X1i+emMe0siY
	 W2KxAnLmqeJp90ijjrLTFdtIddopbOqDofW1MPth8ziddQglcGzNW+b0JuoIoaeq51
	 ukxIJ5RIQyyhg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XcZGQ6gp1zpxS;
	Mon, 28 Oct 2024 09:38:22 -0400 (EDT)
Message-ID: <459b9e7d-be9b-41d8-8ae3-4aa707def641@efficios.com>
Date: Mon, 28 Oct 2024 09:36:43 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/3] tracing: Introduce tracepoint_is_syscall()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>
References: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
 <20241026154629.593041-2-mathieu.desnoyers@efficios.com>
 <20241026200840.17171eb2@rorschach.local.home>
 <20241027231930.941d6c1f21e2b4668af44df8@kernel.org>
 <CAEf4BzbeE6n7E6K8_dhZ26ZHoVsz8V9mUSxm3CYzz2npmdpbiQ@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzbeE6n7E6K8_dhZ26ZHoVsz8V9mUSxm3CYzz2npmdpbiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-27 21:23, Andrii Nakryiko wrote:
> On Sun, Oct 27, 2024 at 7:19 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:

[...]

>>>>   include/linux/tracepoint-defs.h |  2 ++
>>>>   include/linux/tracepoint.h      | 24 ++++++++++++++++++++++++
>>>>   include/trace/define_trace.h    |  2 +-
>>>>   3 files changed, 27 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
>>>> index 967c08d9da84..53119e074c87 100644
>>>> --- a/include/linux/tracepoint-defs.h
>>>> +++ b/include/linux/tracepoint-defs.h
>>>> @@ -32,6 +32,8 @@ struct tracepoint_func {
>>>>   struct tracepoint_ext {
>>>>      int (*regfunc)(void);
>>>>      void (*unregfunc)(void);
>>>> +   /* Flags. */
>>>> +   unsigned int syscall:1;
>>>
>>> I wonder if we should call it "sleepable" instead? For this patch set
>>> do we really care if it's a system call or not? It's really if the
>>> tracepoint is sleepable or not that's the issue. System calls are just
>>> one user of it, there may be more in the future, and the changes to BPF
>>> will still be needed.
>>
>> I agree with this. Even if currently we restrict only syscall events
>> can be sleep, "tracepoint_is_syscall()" requires to add comment to
>> explain why on all call sites e.g.
>>
> 
> +1 to naming this "sleepable" (or at least "faultable"). BPF world
> uses "sleepable BPF" terminology for BPF programs and attachment hooks
> that can take page fault (and wait/sleep waiting for those to be
> handled), so this would be consistent with that. Also, from BPF
> standpoint this will be advertised as attaching to sleepable
> tracepoints regardless, so "syscall" terminology is too specific and
> misleading, because while current set of tracepoints are
> syscall-specific, the important part is taking page fault, no tracing
> syscalls.

+1 for "faultable".

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


