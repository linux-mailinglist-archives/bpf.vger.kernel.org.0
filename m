Return-Path: <bpf+bounces-72914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8941C1D85A
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F679420F75
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 21:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8E52EBB84;
	Wed, 29 Oct 2025 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="csOcxHFR"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B3E274FE8
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774830; cv=none; b=TdnVDX0P+iDnftCCYW8yBNu3R8YVZHA/A7xVz3nLXgrQQ/b0CYjB3SuPPH9pnFKOmnCsji7DXLYLHko9TN/TNfvQ0VgVV8mM0myirqD2RX+CuSy+WUHFv7p+VfbLTuRo50P36CztAgxF779GwzUdWfuK3G1eSJYHLi0bulvsT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774830; c=relaxed/simple;
	bh=pRbBQ8z+sVjizpZCWo5hT/mNnyCZzi3jD4cZdQbYlrk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aSlq/S4PcS4HIDAWY1tb0ZhL51VwWJMrEeeO0M63YaagrxJBhlDlXxZ46VaCn4MYfEHTBgPX/K+dvy5IZQ6rm1R3WVuSY4wDeg67YQjdkc/GmEqN3R35kp3BAiiP1X1jMUEsoIHKNI1KmrfjF5/wUi8/zZkP/KS1qsezXsYU+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=csOcxHFR; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761774826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRbBQ8z+sVjizpZCWo5hT/mNnyCZzi3jD4cZdQbYlrk=;
	b=csOcxHFRJMKoqy3bgapanUAkcjC8JMzxMX/V6v8WjihxeU45lzMu454aITCt7yS/w57B40
	6C/Th57sjWmYDj42CsxxgzABtVElBGYig2qHIacSpSCzNNU5MPWom2nD/vFeNo2jJL/fI1
	R0rwHvH1fMX8QhZftw1demdPjuW9x6I=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Song Liu <song@kernel.org>
Cc: Tejun Heo <tj@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrii Nakryiko <andrii@kernel.org>,  JP
 Kobryn <inwardvessel@gmail.com>,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  bpf@vger.kernel.org,  Martin KaFai Lau
 <martin.lau@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops
 to cgroups
In-Reply-To: <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
	(Song Liu's message of "Wed, 29 Oct 2025 14:18:00 -0700")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-3-roman.gushchin@linux.dev>
	<aQJZgd8-xXpK-Af8@slm.duckdns.org> <87ldkte9pr.fsf@linux.dev>
	<aQJ61wC0mvzc7qIU@slm.duckdns.org>
	<CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
Date: Wed, 29 Oct 2025 14:53:39 -0700
Message-ID: <871pmle5ng.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Song Liu <song@kernel.org> writes:

> Hi Tejun,
>
> On Wed, Oct 29, 2025 at 1:36=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>>
>> On Wed, Oct 29, 2025 at 01:25:52PM -0700, Roman Gushchin wrote:
>> > > BTW, for sched_ext sub-sched support, I'm just adding cgroup_id to
>> > > struct_ops, which seems to work fine. It'd be nice to align on the s=
ame
>> > > approach. What are the benefits of doing this through fd?
>> >
>> > Then you can attach a single struct ops to multiple cgroups (or Idk
>> > sockets or processes or some other objects in the future).
>> > And IMO it's just a more generic solution.
>>
>> I'm not very convinced that sharing a single struct_ops instance across
>> multiple cgroups would be all that useful. If you map this to normal
>> userspace programs, a given struct_ops instance is package of code and a=
ll
>> the global data (maps). ie. it's not like running the same program multi=
ple
>> times against different targets. It's more akin to running a single prog=
ram
>> instance which can handle multiple targets.
>>
>> Maybe that's useful in some cases, but that program would have to explic=
itly
>> distinguish the cgroups that it's attached to. I have a hard time imagin=
ing
>> use cases where a single struct_ops has to service multiple disjoint cgr=
oups
>> in the hierarchy and it ends up stepping outside of the usual operation
>> model of cgroups - commonality being expressed through the hierarchical
>> structure.
>
> How about we pass a pointer to mem_cgroup (and/or related pointers)
> to all the callbacks in the struct_ops? AFAICT, in-kernel _ops structures=
 like
> struct file_operations and struct tcp_congestion_ops use this method. And
> we can actually implement struct tcp_congestion_ops in BPF. With the
> struct tcp_congestion_ops model, the struct_ops map and the struct_ops
> link are both shared among multiple instances (sockets).

+1 to this.
I agree it might be debatable when it comes to cgroups, but when it comes to
sockets or similar objects, having a separate struct ops per object
isn't really an option.

