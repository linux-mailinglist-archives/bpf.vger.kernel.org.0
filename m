Return-Path: <bpf+bounces-44399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C55CE9C2742
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 22:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E3A1C21EC4
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 21:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A470C1EBA03;
	Fri,  8 Nov 2024 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iS+Fj0E+"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF563233D92
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731103038; cv=none; b=aQxJ1PvqIAE2cNH5cDK/R/HTO5oYhAr9u2u60j31fk1sVQAuURy6qMId0UV7QKsKm/2sAEb8KAgf6H9F2CILOojIBGiC+0CNvDNtcKfq7g1Jqp408ykJ4kqAn8KkJLHYe+hVW9bel9EjTzJTjSZCtV8ySu1D32QdjzRyN8tSc+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731103038; c=relaxed/simple;
	bh=uk6zwBUdCoWKzaxIMUe1UZubqlKY4Q1KCB1VREdP3j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVz5SC32OXFt1BAyTx6xNgWAXqvVXAhGfne4FLOqyxJCsd/WiqEC6m/eP+j1kCahlcIlWQebYb7hE2TxgxvRCDNfASk0NKkyl6Sdd9dBa65Bt6UwTZlPZCe61iekz6fAYErHvrrN0yTk5rLZfOuQ0KN+obje6h9szIbAEQkbRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iS+Fj0E+; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0f763686-2b79-40ee-b8c2-0fcfe78d7520@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731103033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GO7O9WBWpFbJyYcBW2Al7NQap8WX4yTGXeve1S0eneI=;
	b=iS+Fj0E+GNmAnSa096JFp6Zt9Sk+23o91W4Hj42xFwuQNztP+uV9gosdXDcH5CgErHCgdA
	ZCU05zq7BtwS0rB4oymcku7BLzYhNZ1UEWoZqUzRMctXvnl3eXMmJlSWjVlTmDa9jfE4qr
	YnlouZoRmk7emg4uqUuxVFikra7ddQs=
Date: Fri, 8 Nov 2024 13:57:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 0/2] Handle possible NULL trusted raw_tp
 arguments
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 kkd@meta.com, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Song Liu <song@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <olsajiri@gmail.com>,
 Juri Lelli <juri.lelli@redhat.com>, Kernel Team <kernel-team@fb.com>
References: <20241101000017.3424165-1-memxor@gmail.com>
 <CAP01T75OUeE8E-Lw9df84dm8ag2YmHW619f1DmPSVZ5_O89+Bg@mail.gmail.com>
 <c3f7ee7790c6f53a572ff2857433f534f4972189.camel@gmail.com>
 <CAADnVQLZ9oj4+en43UZVOOLNHfHGq2aEcR9pYwLKLeMh1rJN-w@mail.gmail.com>
 <57dfdda6a89819b65be8960c3c6953bb9b8ceed3.camel@gmail.com>
 <df84c4c41d3fa9cbc43738ad226bc9efc5fa495c.camel@gmail.com>
 <CAADnVQJNnqpoF2sNL76_Newyve8NVD2PLdq=tJyiA=tXkn_G4Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJNnqpoF2sNL76_Newyve8NVD2PLdq=tJyiA=tXkn_G4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/8/24 12:13 PM, Alexei Starovoitov wrote:
> On Thu, Nov 7, 2024 at 9:08 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> On Fri, 2024-11-01 at 17:32 -0700, Eduard Zingerman wrote:
>>> On Fri, 2024-11-01 at 17:29 -0700, Alexei Starovoitov wrote:
>>>
>>> [...]
>>>
>>>> Hmm.
>>>> Puranjay touched it last with extra logic.
>>>>
>>>> And before that David Vernet tried to address flakiness
>>>> in commit 4a54de65964d.
>>>> Yonghong also noticed lockups in paravirt
>>>> and added workaround 7015843afc.
>>>>
>>>> Your additional timeout/workaround makes sense to me,
>>>> but would be good to bisect whether Puranjay's change caused it.
>>> I'll debug what's going on some time later today or on Sat.
>> I finally had time to investigate this a bit.
>> First, here is how to trigger lockup:
>>
>>    t1=send_signal/send_signal_perf_thread_remote; \
>>    t2=send_signal/send_signal_nmi_thread_remote; \
>>    for i in $(seq 1 100); do ./test_progs -t $t1,$t2; done
>>
>> Must be both tests for whatever reason.
>> The failing test is 'send_signal_nmi_thread_remote'.
>>
>> The test is organized as parent and child processes communicating
>> various events to each other. The intended sequence of events:
>> - child:
>>    - install SIGUSR1 handler
>>    - notify parent
>>    - wait for parent
>> - parent:
>>    - open PERF_COUNT_SW_CPU_CLOCK event
>>    - attach BPF program to the event
>>    - notify child
>>    - enter busy loop for 10^8 iterations
>>    - wait for child
>> - BPF program:
>>    - send SIGUSR1 to child
>> - child:
>>    - poll for SIGUSR1 in a busy loop
>>    - notify parent
>> - parent:
>>    - check value communicated by child,
>>      terminate test.
>>
>> The lockup happens because on every other test run perf event is not
>> triggered, child does not receive SIGUSR1 and thus both parent and
>> child are stuck.
>>
>> For 'send_signal_nmi_thread_remote' perf event is defined as:
>>
>>          struct perf_event_attr attr = {
>>                  .sample_period = 1,
>>                  .type = PERF_TYPE_HARDWARE,
>>                  .config = PERF_COUNT_HW_CPU_CYCLES,
>>          };
>>
>> And is opened for parent process pid.
>>
>> Apparently, the perf event is not always triggered between lines
>> send_signal.c:165-180. And at line 180 parent enters system call,
>> so cpu cycles stop ticking for 'parent', thus if perf event
>> had not been triggered already it won't be triggered at all
>> (as far as I understand).
>>
>> Applying same fix as Yonghong did in 7015843afc is sufficient to
>> reliably trigger perf event:
>>
>> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> @@ -223,7 +223,8 @@ static void test_send_signal_perf(bool signal_thread, bool remote)
>>   static void test_send_signal_nmi(bool signal_thread, bool remote)
>>   {
>>          struct perf_event_attr attr = {
>> -               .sample_period = 1,
>> +               .freq = 1,
>> +               .sample_freq = 1000,
>>                  .type = PERF_TYPE_HARDWARE,
>>                  .config = PERF_COUNT_HW_CPU_CYCLES,
>>          };
>>
>> But I don't understand why.
>> As far as I can figure from kernel source code,
>> sample_period is measured in nanoseconds (is it?),
> I believe sample_period is a number of samples.
> 1 means that perf suppose to generate event very often.
> It means nanoseconds only for SW cpu_cycles.
>
> let's apply above workaround and move on. Pls send a patch.

sample_period = 1 intends to make sure we can get at one sample
since many samples will be generated. But too many samples may
cause *rare* issues in internal kernel logic in certain *corner*
cases. Agree with Alexei, let us just use a reasonable sample_freq
to fix the issue. Thanks!



