Return-Path: <bpf+bounces-66829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D91AB39F35
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 15:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5311F366CD7
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 13:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0893148A1;
	Thu, 28 Aug 2025 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jhYL17xr"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B167311C01
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388384; cv=none; b=lPuTX00KQeT3aF14qY60BfoINmkBrRBpxAfD/A09tFIIyblnMfT75ChzIbf71ZwNsL4+Kpq+u0hbg6drBZqYUpGuERWOZRq5AD6PJADUspk5kyIvshwT+BlDTgSsKEG8n3QrcjkQbS/rxXipE8ddw64KkdzvCUpfeFYvFxiAifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388384; c=relaxed/simple;
	bh=Jm5mlJetgvF5AFhgoNW4Zu8wyFqXfuodsDQ9C4ACRq8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hnvwa46N15oeyGGFqSfx98XTBFpxzIog7v7wYKOG3F8NQinAy85vtp8WfaNRD3uQT+MpLTpXrIkg3R4JIj/J5joC2bQcT2+iXDB4ly0Q8Zep6/r4lUzh7gengo/O+qcXpB17quPc3QjA9L30Z3+/32R+w8Zu13W+/t3YE9Y/yaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jhYL17xr; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756388380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4U/mmOfvBDjn/aWPBXSrUl44Uj6eFf5My5o1NPCEidY=;
	b=jhYL17xr4dm1yBEYL1nWqevUKzzDJBHuNtORPQIVYTXWAImCLfM3SADu9ApB6o3z3yfH03
	lbKwl7iOnWPi1ozTx2sXIaWk1gdJZlynnXasPlteo/ousKIgbhpNNjfVkq3uGgdcfToLrl
	RTWhcIqIdUMs6Ds2C0loJkenNiF3Wz4=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Aug 2025 21:39:29 +0800
Message-Id: <DCE3PPX8IFF4.FE1BC8HMP4Y7@linux.dev>
Cc: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "bpf"
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Jiri Olsa" <jolsa@kernel.org>
Subject: Re: [BUG] Deadlock triggered by bpfsnoop funcgraph feature
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: <paulmck@kernel.org>
References: <a08c7c19-1831-481f-9160-0583d850347a@linux.dev>
 <CAADnVQJz9ekB_LjSjRzJLmM_fvdCbeA+pFY20xviJ-qgwFtXWw@mail.gmail.com>
 <8dcc144e-3142-4e0d-a852-155781e41eb4@linux.dev>
 <CAADnVQLDG=Oavh9He=ivXm9MPwsqWHttbTYQh1-EZuHpwujaBA@mail.gmail.com>
 <b3463ffa-c2cb-43c8-a0d2-92bad49e3c23@linux.dev>
 <93e75cff-871f-4b49-868c-11fea0eec396@paulmck-laptop>
In-Reply-To: <93e75cff-871f-4b49-868c-11fea0eec396@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Thu Aug 28, 2025 at 7:50 PM +08, Paul E. McKenney wrote:
> On Thu, Aug 28, 2025 at 10:40:47AM +0800, Leon Hwang wrote:
>> On 28/8/25 08:42, Alexei Starovoitov wrote:
>> > On Tue, Aug 26, 2025 at 7:58=E2=80=AFPM Leon Hwang <leon.hwang@linux.d=
ev> wrote:

[...]

>> >
>> > bpf infra is trying hard not to crash it, but debug kernel is a differ=
ent
>> > category. rcu_read_lock_held() doesn't exist in production kernels.
>> > You can propose adding "notrace" for it, but in general that doesn't s=
cale.
>> > Same with rcu_lockdep_current_cpu_online().
>> > It probably deserves "notrace" too.
>>
>> Indeed, it doesn't scale.
>>
>> When I run
>> ./bpfsnoop -k "htab_*_elem" --output-fgraph --fgraph-debug
>> --fgraph-exclude
>> 'rcu_read_lock_*held,rcu_lockdep_current_cpu_online,*raw_spin_*lock*,kvf=
ree,show_stack,put_task_stack',
>> the kernel doesn=E2=80=99t panic, but the OS eventually stalls and becom=
es
>> unresponsive to key presses.
>>
>> It seems preferable to avoid running BPF programs continuously in such
>> cases.
>
> Agreed, when adding code to the Linux kernel, whether via a patch, via
> a BPF program, or by whatever other means, you are taking responsibility
> for the speed, scalability, and latency effects of that code.
>
> Nevertheless, I am happy to add a few "notrace" modifiers
> if needed.  Do you guys need them for rcu_read_lock_held() and
> rcu_lockdep_current_cpu_online()?
>

I think it would be better to add "notrace" to following functions:

./bpfsnoop -k 'rcu_read_*lock_*held*,rcu_lockdep_*' --show-func-proto
bool rcu_lockdep_current_cpu_online(); [traceable]
int rcu_read_lock_any_held(); [traceable]
int rcu_read_lock_bh_held(); [traceable]
int rcu_read_lock_held(); [traceable]
int rcu_read_lock_sched_held(); [traceable]

Thanks,
Leon

