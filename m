Return-Path: <bpf+bounces-66146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3731B2EB2B
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 04:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC505E4BD5
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 02:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D398E242D95;
	Thu, 21 Aug 2025 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Suk4niCs"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD1F23BD02
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 02:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755742972; cv=none; b=GUfbAzHbgKYtxT4P8QqYoh/dRp+gInnl6V0G3oUXroR8mq0W7uQKptiFYPogucagRGUxkI/O4+hB829CL7yNOTN25TbfbHj8tO47tAeW8rsF0XMrbUg7fPGbiHfdsBWPZKsF7SZZ6ERd3FAMMZCLVTkuEgnCgtqZH4mIoJkF5VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755742972; c=relaxed/simple;
	bh=oDwbBGmgxy3vUPvM7avZroGuhizSxxMXx+qwF7bBMrE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IrAjkceI8FoVmbbCbfqqwRZeoQKlqNj2EiPlxGSso9nRPNXicO7mYLmJJeNGokg8NeoviFV6kwIDuJ9DwQiKk5NC1ujoIryiw3QdsmACjcVVluILJ/Zttqit6ZLUFx6LtbkIAeDaKEvLF7o7tz4dM1E5FdU6wQRoh2Gl2LD8YAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Suk4niCs; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755742958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j74vLZJ/pDTvrOLGmgUzsjwHFqEGtuc7kqWVVBs93lA=;
	b=Suk4niCsZPDfF3AjH92kMN99VOBt3dRVWTsdffSM0hmqybDSR7M+H6BQe0sxIveGb+8V/9
	/sTqh0mdQNBNFIDknWXs8LeU5Y/lKkrNYX65al5YV4UQEcL5OzfCbhfAdc537GMe/n8xXP
	p8s623IbZqPxrfdYYuAifSgkbamO820=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko
 <mhocko@suse.com>,  David Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
In-Reply-To: <CAP01T76xFkhsQKCtCynnHR4t6KyciQ4=VW2jhF8mcZEVBjsF1w@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Thu, 21 Aug 2025 02:36:49
	+0200")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-2-roman.gushchin@linux.dev>
	<CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
	<87ms7tldwo.fsf@linux.dev>
	<CAP01T76xFkhsQKCtCynnHR4t6KyciQ4=VW2jhF8mcZEVBjsF1w@mail.gmail.com>
Date: Wed, 20 Aug 2025 19:22:31 -0700
Message-ID: <875xehh0rc.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Thu, 21 Aug 2025 at 02:25, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>>
>> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>>
>> > On Mon, 18 Aug 2025 at 19:01, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>> >>
>> >> Introduce a bpf struct ops for implementing custom OOM handling policies.
>> >>
>> >> The struct ops provides the bpf_handle_out_of_memory() callback,
>> >> which expected to return 1 if it was able to free some memory and 0
>> >> otherwise.
>> >>
>> >> In the latter case it's guaranteed that the in-kernel OOM killer will
>> >> be invoked. Otherwise the kernel also checks the bpf_memory_freed
>> >> field of the oom_control structure, which is expected to be set by
>> >> kfuncs suitable for releasing memory. It's a safety mechanism which
>> >> prevents a bpf program to claim forward progress without actually
>> >> releasing memory. The callback program is sleepable to enable using
>> >> iterators, e.g. cgroup iterators.
>> >>
>> >> The callback receives struct oom_control as an argument, so it can
>> >> easily filter out OOM's it doesn't want to handle, e.g. global vs
>> >> memcg OOM's.
>> >>
>> >> The callback is executed just before the kernel victim task selection
>> >> algorithm, so all heuristics and sysctls like panic on oom,
>> >> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
>> >> are respected.
>> >>
>> >> The struct ops also has the name field, which allows to define a
>> >> custom name for the implemented policy. It's printed in the OOM report
>> >> in the oom_policy=<policy> format. "default" is printed if bpf is not
>> >> used or policy name is not specified.
>> >>
>> >> [  112.696676] test_progs invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
>> >>                oom_policy=bpf_test_policy
>> >> [  112.698160] CPU: 1 UID: 0 PID: 660 Comm: test_progs Not tainted 6.16.0-00015-gf09eb0d6badc #102 PREEMPT(full)
>> >> [  112.698165] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
>> >> [  112.698167] Call Trace:
>> >> [  112.698177]  <TASK>
>> >> [  112.698182]  dump_stack_lvl+0x4d/0x70
>> >> [  112.698192]  dump_header+0x59/0x1c6
>> >> [  112.698199]  oom_kill_process.cold+0x8/0xef
>> >> [  112.698206]  bpf_oom_kill_process+0x59/0xb0
>> >> [  112.698216]  bpf_prog_7ecad0f36a167fd7_test_out_of_memory+0x2be/0x313
>> >> [  112.698229]  bpf__bpf_oom_ops_handle_out_of_memory+0x47/0xaf
>> >> [  112.698236]  ? srso_alias_return_thunk+0x5/0xfbef5
>> >> [  112.698240]  bpf_handle_oom+0x11a/0x1e0
>> >> [  112.698250]  out_of_memory+0xab/0x5c0
>> >> [  112.698258]  mem_cgroup_out_of_memory+0xbc/0x110
>> >> [  112.698274]  try_charge_memcg+0x4b5/0x7e0
>> >> [  112.698288]  charge_memcg+0x2f/0xc0
>> >> [  112.698293]  __mem_cgroup_charge+0x30/0xc0
>> >> [  112.698299]  do_anonymous_page+0x40f/0xa50
>> >> [  112.698311]  __handle_mm_fault+0xbba/0x1140
>> >> [  112.698317]  ? srso_alias_return_thunk+0x5/0xfbef5
>> >> [  112.698335]  handle_mm_fault+0xe6/0x370
>> >> [  112.698343]  do_user_addr_fault+0x211/0x6a0
>> >> [  112.698354]  exc_page_fault+0x75/0x1d0
>> >> [  112.698363]  asm_exc_page_fault+0x26/0x30
>> >> [  112.698366] RIP: 0033:0x7fa97236db00
>> >>
>> >> It's possible to load multiple bpf struct programs. In the case of
>> >> oom, they will be executed one by one in the same order they been
>> >> loaded until one of them returns 1 and bpf_memory_freed is set to 1
>> >> - an indication that the memory was freed. This allows to have
>> >> multiple bpf programs to focus on different types of OOM's - e.g.
>> >> one program can only handle memcg OOM's in one memory cgroup.
>> >> But the filtering is done in bpf - so it's fully flexible.
>> >
>> > I think a natural question here is ordering. Is this ability to have
>> > multiple OOM programs critical right now?
>>
>> Good question. Initially I had only supported a single bpf policy.
>> But then I realized that likely people would want to have different
>> policies handling different parts of the cgroup tree.
>> E.g. a global policy and several policies handling OOMs only
>> in some memory cgroups.
>> So having just a single policy is likely a no go.
>
> If the ordering is more to facilitate scoping, would it then be better
> to support attaching the policy to specific memcg/cgroup?

Well, it has some advantages and disadvantages. First, it will require
way more infrastructure on the memcg side. Second, the interface is not
super clear: we don't want to have a struct ops per cgroup, I guess.
And in many case a single policy for all memcgs is just fine, so asking
the user to attach it to all memcgs is just adding a toil and creating
all kinds of races.
So I see your point, but I'm not yet convinced, to be honest.

Thanks!

