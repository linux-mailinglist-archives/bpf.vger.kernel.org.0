Return-Path: <bpf+bounces-45557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 032FA9D79DA
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 02:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9163F163781
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 01:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1119B66E;
	Mon, 25 Nov 2024 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eINfl1EA"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0239680B;
	Mon, 25 Nov 2024 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732499423; cv=none; b=aij1wL0Y8TG9gWhes+5Q3P8Z7yGV1bN2qAHQDqBK/zbbeNy/7y49mWKNgN5i1vOCsdUd7tY379BlOIl4kWsSAIh0/oMmrCZWkqBRo523PUd58oGuU1VOLI4b1kidOjxPQwvw6GxzfHNmOrPxKjFtdH5cxrcaj5bZA56V+QHSd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732499423; c=relaxed/simple;
	bh=rE5bD2UVTzHtxWoYQBYx7rJbm4CkHn6QMgaWmgDOOBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuEa3aqaHVYoKHoLUVxxdJy2mwuy1gL8/FusUR/eilfmS9EzCHJKjV/kF7596HupKv2dvKXcYeAdAtMRfVi/otAa4bo7deRht6B1Fom8X7gnm9FxqGXPrhCS7vm/xfKxI7cnx5GQCa4j/TeAG0Fn+XdtVqYLXa9LalMInky2Qfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=eINfl1EA; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1732499412;
	bh=rE5bD2UVTzHtxWoYQBYx7rJbm4CkHn6QMgaWmgDOOBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eINfl1EAc1Con4OD4xPVAvTTgg/QTzyCQQV+bztoxSLVdjLQUqQkQefMlHnU3gjWN
	 kuufYWPnWwev09r3HwJKznUwQm3NRFYEZg3tZtpmesHhijXb9zAqJhXgLBlefp6XU5
	 mZbPu0BKVplI7K8Wwg0w2GY0II6PdnSBX+sg/zgB82O43ydUw/ytow5je0DQWcPiGx
	 Ws3W2WEqhoAGZnTGVMgaxf0Lv/MjVlSqIplgMNlBEdsKl8MdKxnuNyaua2pWT+GksW
	 znNrWLTReYHfmiJudUzvLb8YPl5i6uxnNymBrDATKLUi+nIfL4gj2eqpmu422JhbgJ
	 MCt/+EgHIsLlg==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XxTDN2ySzzrTR;
	Sun, 24 Nov 2024 20:50:12 -0500 (EST)
Message-ID: <0ed11f00-d885-482a-8c82-37f9ffdb2968@efficios.com>
Date: Sun, 24 Nov 2024 20:50:12 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from
 __DO_TRACE()
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Michael Jeanson <mjeanson@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>,
 linux-trace-kernel@vger.kernel.org
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
 <20241123153031.2884933-5-mathieu.desnoyers@efficios.com>
 <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-23 12:38, Linus Torvalds wrote:
> On Sat, 23 Nov 2024 at 07:31, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>>   include/linux/tracepoint.h | 45 ++++++++++----------------------------
>>   1 file changed, 12 insertions(+), 33 deletions(-)
> 
> Thanks. This looks much more straightforward, and obviously is smaller too.
> 
> Side note: I realize I was the one suggesting "scoped_guard()", but
> looking at the patch I do think that just unnecessarily added another
> level of indentation. Since you already wrote the
> 
>      if (cond) {
>          ..
>      }
> 
> part as a block statement, there's no upside to the guard having its
> own scoped block, so instead of
> 
>      if (cond) { \
>          scoped_guard(preempt_notrace)           \
>              __DO_TRACE_CALL(name, TP_ARGS(args)); \
>      }
> 
> this might be simpler as just a plain "guard()" and one less indentation:
> 
>      if (cond) { \
>          guard(preempt_notrace);           \
>          __DO_TRACE_CALL(name, TP_ARGS(args)); \
>      }
> 
> but by now this is just an unimportant detail.
> 
> I think I suggested scoped_guard() mainly because that would then just
> make the "{ }" in the if-statement superfluous, but that's such a
> random reason that it *really* doesn't matter.

Thanks for the follow up. I agree that guard() would remove one level
of nesting and would be an improvement.

Steven, do you want me to update the series with this change or
should I leave the scoped_guard() as is considering the ongoing
testing in linux-next ? We can always keep this minor change
(scoped_guard -> guard) for a follow up patch.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


