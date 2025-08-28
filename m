Return-Path: <bpf+bounces-66771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF10BB391CC
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 04:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70B31799CE
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 02:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401B925BEE1;
	Thu, 28 Aug 2025 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sSWH2+Y8"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7081C01
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756348859; cv=none; b=m9Mm1u5Qdwvmu51wcMtp3rDflTi5kWvAl05igl4CnCr7TZZ/E7uwE9NdOmhZhDNbPv5jYK4NGA/7x8CrX4ZS8Cr/0hqOg6gspSb1cmWb+yRWB9qTor1cy5NcyVkQ829MLakBXl4PnvaKJiiRafMu8iBeGfbUntKhGOYwk3dLTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756348859; c=relaxed/simple;
	bh=YUnBOV0DRlWVcBC/QtoOy0ZWvZB0grZmo4YXjOzoDH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSCHtlhMccpgfnicceWQGh67AMDJvuGkTdS+i6+v620yMKW9bj6wbcoucBonEM4iiFFD7pArZXj77dJcs8wKKyM/8LErrWWpXx9nPx6xoUHSLF9BMWgbdXUd3NphKLOT5B/Fj2/Dk30mKHcPCke1ED0VRQov+wpTb8s89de+wL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sSWH2+Y8; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3463ffa-c2cb-43c8-a0d2-92bad49e3c23@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756348854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSzIAxQjIPhumyUd628BNPGzi5Ifl6qfzdJVclskNWo=;
	b=sSWH2+Y89Sm08DUMkjrMZaBSEVTDFUgl6aZHg+OOf5M4VfsyxQ2qbAFMJBorFxxptJAJUA
	N+5m2Czl2ETEyuR0aNaVuo+IJbDT4UDVZGdd9zEhvMrejc+HtGKmHRRhl/twR46DF58Hnw
	VL/7AaPBqGinEbipvV8+0STYe0Mvcb8=
Date: Thu, 28 Aug 2025 10:40:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] Deadlock triggered by bpfsnoop funcgraph feature
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jiri Olsa <jolsa@kernel.org>
References: <a08c7c19-1831-481f-9160-0583d850347a@linux.dev>
 <CAADnVQJz9ekB_LjSjRzJLmM_fvdCbeA+pFY20xviJ-qgwFtXWw@mail.gmail.com>
 <8dcc144e-3142-4e0d-a852-155781e41eb4@linux.dev>
 <CAADnVQLDG=Oavh9He=ivXm9MPwsqWHttbTYQh1-EZuHpwujaBA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLDG=Oavh9He=ivXm9MPwsqWHttbTYQh1-EZuHpwujaBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 28/8/25 08:42, Alexei Starovoitov wrote:
> On Tue, Aug 26, 2025 at 7:58 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 27/8/25 10:23, Alexei Starovoitov wrote:
>>> On Tue, Aug 26, 2025 at 7:13 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I’ve encountered a reproducible deadlock while developing the funcgraph
>>>> feature for bpfsnoop [0].
>>>
>>> debug it pls.
>>
>> It’s quite difficult for me. I’ve tried debugging it but didn’t succeed.
>>
>>> Sounds like you're implying that the root cause is in bpf,
>>> but why do you think so?
>>>
>>> You're attaching to things that shouldn't be attached to.
>>> Like rcu_lockdep_current_cpu_online()
>>> so effectively you're recursing in that lockdep code.
>>> See big lock there. It will dead lock for sure.
>>
>> If a function that acquires a lock can be traced by a tracing program,
>> bpfsnoop’s funcgraph will attempt to trace it as well. In such cases, a
>> deadlock is highly likely to occur.
>>
>> With bpfsnoop I try my best to avoid such deadlock issues. But what
>> about other bpf tracing tools? If they don’t handle this properly, the
>> kernel is very likely to crash.
> 
> bpf infra is trying hard not to crash it, but debug kernel is a different
> category. rcu_read_lock_held() doesn't exist in production kernels.
> You can propose adding "notrace" for it, but in general that doesn't scale.
> Same with rcu_lockdep_current_cpu_online().
> It probably deserves "notrace" too.

Indeed, it doesn't scale.

When I run
./bpfsnoop -k "htab_*_elem" --output-fgraph --fgraph-debug
--fgraph-exclude
'rcu_read_lock_*held,rcu_lockdep_current_cpu_online,*raw_spin_*lock*,kvfree,show_stack,put_task_stack',
the kernel doesn’t panic, but the OS eventually stalls and becomes
unresponsive to key presses.

It seems preferable to avoid running BPF programs continuously in such
cases.

Thanks,
Leon


