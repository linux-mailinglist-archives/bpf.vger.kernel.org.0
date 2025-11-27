Return-Path: <bpf+bounces-75638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A32F3C8E18B
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 12:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B8864E34B3
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9B132BF48;
	Thu, 27 Nov 2025 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIlJwzwL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05831815D
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764244126; cv=none; b=PnchZz5kQ1h+WQHb7xBHdmgBmG8MQSQLTz6AXnKgrhQj87HBpn4LnFq9jZo74xOH23gRGPEjZitj280Ai9GcKiOO+7kpT/7tTFBOswWwH70ZqxMVtWwTYi5/seUHjKn59Fv8YSUZDvg/IL2L8gEW9iSESbas5Gvvhd3rVmg8NSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764244126; c=relaxed/simple;
	bh=w/afnhuYyNZIpCydtL72AbZ9I5In+EX1JoLUP6VMW2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7XYcqzpeqiUQRgrF1vFq6Z58+Nv+VJ3TtzO+UsQuupT8X+W+PXkDG400nEWV2koPt21lwKHjp0OSqAoHxAnO4iB30Rm3ttJnuldbk+Iy4+wn1H54O1Zxy5/Mv9hXQsp5zj91bVequcYjOLHoxdJsmvVt1pTY/PF3JXecTtrcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIlJwzwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E511C4CEF8;
	Thu, 27 Nov 2025 11:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764244125;
	bh=w/afnhuYyNZIpCydtL72AbZ9I5In+EX1JoLUP6VMW2A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tIlJwzwL3cjRTN8mgWo++SdcXe3FjPS+Xlfq613EqGHn+hljGEMsciAyEvGEtxggW
	 U6hS+CA6VqAl3wDTQT0zY0zuYfoPC2mtD+e63GIsHgyPFYYP14UbAH46cEcp214acs
	 9g2pl0ho6ilJP/wlcnosybWKcg/b/CkB3rjhDALYYBFYlCEPPYicCoSRLBdaXoZRlk
	 sEscJ/dCsrWibvkGoY8sLJpFdiH/y6diziI2PGI1ECAtw/CJNC9LMY9b+Y57swmgKH
	 yrq2DUcTxsXGSC6XhQic1mgvMV5cV5jb7CH+UUatK4u13CX+M3ZW5UstuULer6EIya
	 fSwxnSiCgEPpg==
Message-ID: <9f73a5bd-32a0-4d5f-8a3f-7bff8232e408@kernel.org>
Date: Thu, 27 Nov 2025 12:48:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global mode
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, Johannes Weiner
 <hannes@cmpxchg.org>, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>,
 Amery Hung <ameryhung@gmail.com>, David Rientjes <rientjes@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Barry Song <21cnbao@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>,
 lance.yang@linux.dev, Randy Dunlap <rdunlap@infradead.org>,
 Chris Mason <clm@meta.com>, bpf <bpf@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>
References: <20251026100159.6103-1-laoar.shao@gmail.com>
 <20251026100159.6103-7-laoar.shao@gmail.com>
 <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com>
 <CALOAHbD+9gxukoZ3OQvH2fNH2Ff+an+Dx-fzx_+mhb=8fZZ+sw@mail.gmail.com>
 <CAADnVQK9kp_5zh0gYvXdJ=3MSuXTbmZT+cah5uhZiGk5qYfckw@mail.gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <CAADnVQK9kp_5zh0gYvXdJ=3MSuXTbmZT+cah5uhZiGk5qYfckw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> To move forward, I'm happy to set the global mode aside for now and
>> potentially drop it in the next version. I'd really like to hear your
>> perspective on the per-process mode. Does this implementation meet
>> your needs?

I haven't had the capacity to follow the evolution of this patch set 
unfortunately, just to comment on some points from my perspective.

First, I agree that the global mode is not what we want, not even as a 
fallback.

> 
> Attaching st_ops to task_struct or to mm_struct is a can of worms.
> With cgroup-bpf we went through painful bugs with lifetime
> of cgroup vs bpf, dying cgroups, wq deadlock, etc. All these
> problems are behind us. With st_ops in mm_struct it will be more
> painful. I'd rather not go that route.

That's valuable information, thanks. I would have hoped that per-MM 
policies would be easier.

Are there some pointers to explore regarding the "can of worms" you 
mention when it comes to per-MM policies?

> 
> And revist cgroup instead, since you were way too quick
> to accept the pushback because all you wanted is global mode.
> 
> The main reason for pushback was:
> "
> Cgroup was designed for resource management not for grouping processes and
> tune those processes
> "
> 
> which was true when cgroup-v2 was designed, but that ship sailed
> years ago when we introduced cgroup-bpf.

Also valuable information.

Personally I don't have a preference regarding per-mm or per-cgroup. 
Whatever we can get working reliably. Sounds like cgroup-bpf has sorted 
out most of the mess.

memcg/cgroup maintainers might disagree, but it's probably worth having 
that discussion once again.

> None of the progs are doing resource management and lots of infrastructure,
> container management, and open source projects use cgroup-bpf
> as a grouping of processes. bpf progs attached to cgroup/hook tuple
> only care about processes within that cgroup. No resource management.
> See __cgroup_bpf_check_dev_permission or __cgroup_bpf_run_filter_sysctl
> and others.
> The path is current->cgroup->bpf_progs and progs do exactly
> what cgroup wasn't designed to do. They tune a set of processes.
> 
> You should do the same.
> 
> Also I really don't see a compelling use case for bpf in THP.

There is a lot more potential there to write fine-tuned policies that 
thack VMA information into account.

The tests likely reflect what Yafang seems to focus on: IIUC primarily 
enabling+disabling traditional THPs (e.g., 2M) on a per-process basis.

Some of what Yafang might want to achieve could maybe at this point be 
maybe achieved through the prctl(PR_SET_THP_DISABLE) support, including 
extensions we recently added [1].

Systemd support still seems to be in the works [2] for some of that.


[1] https://lwn.net/Articles/1032014/
[2] https://github.com/systemd/systemd/pull/39085

-- 
Cheers

David

