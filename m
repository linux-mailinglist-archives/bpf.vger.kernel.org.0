Return-Path: <bpf+bounces-75688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEBCC91433
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 09:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 989814E72E3
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 08:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80DA2E8B8E;
	Fri, 28 Nov 2025 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUD92oud"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB52E7F25
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319160; cv=none; b=uOJLbFMLWzyoHuThgsVd/3ujGwEtZkUhuK11yREA938oXMq++FV6M5qUE2F0ioRILDdF/zt9ovDKWe8Cac6K6sOz6gMkR2mgr0Ya5B18U00I3K4HLMvfwCRfC8h6BUL4Bg/+2a7nUyI3J34WapvEFDmiPnD9SGmCmugDf3Upil0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319160; c=relaxed/simple;
	bh=emweKubAm92oT2D1EO70r45t37gZ6Qzd9aHduwcG1jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFLK7lIkg0CDUxm2PBGW5Eigu23wlyYgEWZFVf5QGbuCW6Zi0B8ozKcNOpSC5AncwxWIWNjN2jbVfpof6ZkzPAVJ7pqVX63s/qxleOiueagwg/2dvC2r6edhMJ/T4t1AxW936jdiKAbW9rnVJRxtnQCgMzCbFDqVv7SpSK/+4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUD92oud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA901C4CEF1;
	Fri, 28 Nov 2025 08:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764319159;
	bh=emweKubAm92oT2D1EO70r45t37gZ6Qzd9aHduwcG1jk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UUD92oudvVRiptW+fkQhAqZxu8ZE/Bh1gFsXnoqwYdARGRc2ccvI3eXNieYFyVuEp
	 uvvcXfX0Xrpvyp3fc8Wzv3tCUPwryr/fZHwX/JLPS4bT5FVnF+xejTfXCJgyXKrYlZ
	 sEs7G8/jgAH0yz80dxHWKP/rwdIAIg33mcwOIOB/gMSQBVFYQwh4rB9SOK5Px/5Yey
	 9CfFgdbviGUy6nS/xiaSUXdTR6zt6r5H1RUafvKtTcDRY/HIprBax6fR7/6l8R5TeZ
	 ER5Ja6qPPgrEdu/rUyfdMbZAhl1PaxL6KNKV5ydtcxuhhACPEbhwYSr9izr9iheig1
	 MS2X/VGvfZ/jg==
Message-ID: <e52bf30d-e63b-44ed-9808-ee3e612e0ba1@kernel.org>
Date: Fri, 28 Nov 2025 09:39:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global mode
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 <9f73a5bd-32a0-4d5f-8a3f-7bff8232e408@kernel.org>
 <CALOAHbCR3Y=GCpX8S9CctONO=Emh4RvYAibHU=ZQyLP1s0MOVQ@mail.gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <CALOAHbCR3Y=GCpX8S9CctONO=Emh4RvYAibHU=ZQyLP1s0MOVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/28/25 03:53, Yafang Shao wrote:
> On Thu, Nov 27, 2025 at 7:48 PM David Hildenbrand (Red Hat)
> <david@kernel.org> wrote:

Lorenzo commented on the upstream topic, let me mostly comment on the 
other parts:
>>> Attaching st_ops to task_struct or to mm_struct is a can of worms.
>>> With cgroup-bpf we went through painful bugs with lifetime
>>> of cgroup vs bpf, dying cgroups, wq deadlock, etc. All these
>>> problems are behind us. With st_ops in mm_struct it will be more
>>> painful. I'd rather not go that route.
>>
>> That's valuable information, thanks. I would have hoped that per-MM
>> policies would be easier.
> 
> The per-MM approach has a performance advantage over per-MEMCG
> policies. This is because it accesses the policy hook directly via
> 
>    vma->vm_mm->bpf_mm->policy_hook()
> 
> whereas the per-MEMCG method requires a more expensive lookup:
> 
>    memcg = get_mem_cgroup_from_mm(vma->vm_mm);
>    memcg->bpf_memcg->policy_hook();
> > This lookup could be a concern in a critical path. However, this
> performance issue in the per-MEMCG mode can be mitigated. For
> instance, when a task is added to a new memcg, we can cache the hook
> pointer:
> 
>    task->mm->bpf_mm->policy_hook = memcg->bpf_memcg->policy_hook
> 
> Ultimately, we might still introduce a mm_struct:bpf_mm field to
> provide an efficient interface.

Right, caching is what I would have proposed. I would expect some 
headakes with lifetime, but probably nothing unsolvable.


>> Sounds like cgroup-bpf has sorted
>> out most of the mess.
> 
> No, the attach-based cgroup-bpf has proven to be ... a "can of worms"
> in practice ...
>   (I welcome corrections from the BPF maintainers if my assessment is
> inaccurate.)

I don't know what's right or wrong here, as Alexei said the "mm_struct" 
based one would be a can of worms and that the the cgroup-based one 
apparently solved these issues ("All these problems are behind us."), 
that's why I asked for some clarifications. :)

[...]

>>
>> Some of what Yafang might want to achieve could maybe at this point be
>> maybe achieved through the prctl(PR_SET_THP_DISABLE) support, including
>> extensions we recently added [1].
>>
>> Systemd support still seems to be in the works [2] for some of that.
>>
>>
>> [1] https://lwn.net/Articles/1032014/
>> [2] https://github.com/systemd/systemd/pull/39085
> 
> Thank you for sharing this.
> However, BPF-THP is already deployed across our server fleet and both
> our users and my boss are satisfied with it. As such, we are not
> considering a switch. The current solution also offers us a valuable
> opportunity to experiment with additional policies in production.

Just to emphasize: we usually don't add two mechanisms to achieve the 
very same end goal. There really must be something delivering more value 
for us to accept something more complex. Focusing on solving a solved 
problem is not good.

If some company went with a downstream-only approach they might be stuck 
having to maintain that forever.

That's why other companies prefer upstream-first :)


Having that said, the original reason why I agreed that having bpf for 
THP can be valuable is that I see a lot more value for rapid prototyping 
and policies once you can actually control on a per-VMA basis (using vma 
size, flags, anon-vma names etc) where specific folio orders could be 
valuable, and where not. But also, possibly where we would want to waste 
memory and where not.

As we are speaking I have a customer running into issues [1] with 
virtio-balloon discarding pages in a VM and khugepaged undoing part of 
that work in the hypervisor. The workaround of telling khugepaged to not 
waste memory in all of the system really feels suboptimal when we know 
that it's only the VM memory of such VMs (with balloon deflation 
enabled) where we would not want to waste memory but still use THPs.

[1] https://issues.redhat.com/browse/RHEL-121177

-- 
Cheers

David

