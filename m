Return-Path: <bpf+bounces-49898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18CCA2015A
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9468716565C
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA05B1DC9A2;
	Mon, 27 Jan 2025 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qLWONNQT"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EB61DACA7
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019131; cv=none; b=rGKKuhqiHXmzOKDdVZlvPly4tcCyDuixBSYMJwOR8yYyjnNKP7PXqnQxpdre4+l4WaD6bxEk3UZh8Mt6znRmmdGdP3fOib9liVv724HBC1Gko+5fkxJnTIss8AYSFxbnr8tUSdGt9BGn4kFBAKsm/cVKIK12oYqSb0ZI2R85Z10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019131; c=relaxed/simple;
	bh=9eOZO557I3AVaxCLQXhmIgkgKjRLU9Wi1jgi5Jr99w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGeBe45FyyPA2LnlNq0RnpVv8jo7deYoNJyleYnXpzO3URcJ7shbr/HuYKV85fTFqsdV5WrGB/nq98pDQp60ka4ve8w/UQ39ILdlkwj6vNt5Gsgq4q+Ql4+ByEX12J95NjLHeIJKROakwwIM/0uCfI5lGN4MZcftuiwfKAYrm4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qLWONNQT; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c153542-079a-4566-9f32-8335bbb0456a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738019113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCw3mJ1w4NJnZl0OvH+BZ8sydRhM86rSvEiTEi79bt4=;
	b=qLWONNQTTtoxRtrOYGi1w5pmcJLm//ry4ETTA3+7uFHqGL/mf8HykBuk0bDwG/uWjSZBgj
	Ibh82AXVcrO5IdgdTF6MUco3hFSPEwXZPwqYV6H//ZuwQDoV6KUKkUDOF8rFhwPj51cc5g
	6nN6nw4z5D80JrRw6pkoJl3Tcd/nbH0=
Date: Mon, 27 Jan 2025 15:05:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] bpf: Fix deadlock when freeing cgroup storage
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Abel Wu <wuyun.abel@bytedance.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>,
 "open list:BPF [STORAGE & CGROUPS]" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241221061018.37717-1-wuyun.abel@bytedance.com>
 <02c69185-1477-485c-af4f-a46f7aadadab@linux.dev>
 <7139ed64-55be-4b70-a03f-8b2414fc93d3@bytedance.com>
 <CAADnVQ+ws4c=G02HjR7Oww_cSuoVFfkWMjP0BbnUrrDgo6tywQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAADnVQ+ws4c=G02HjR7Oww_cSuoVFfkWMjP0BbnUrrDgo6tywQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/27/25 2:15 PM, Alexei Starovoitov wrote:
> On Sun, Jan 26, 2025 at 1:31 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> On 1/25/25 4:20 AM, Martin KaFai Lau Wrote:
>>> On 12/20/24 10:10 PM, Abel Wu wrote:
>>>> The following commit
>>>> bc235cdb423a ("bpf: Prevent deadlock from recursive bpf_task_storage_[get|delete]")
>>>> first introduced deadlock prevention for fentry/fexit programs attaching
>>>> on bpf_task_storage helpers. That commit also employed the logic in map
>>>> free path in its v6 version.
>>>>
>>>> Later bpf_cgrp_storage was first introduced in
>>>> c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgroup-attached bpf progs")
>>>> which faces the same issue as bpf_task_storage, instead of its busy
>>>> counter, NULL was passed to bpf_local_storage_map_free() which opened
>>>> a window to cause deadlock:
>>>>
>>>>      <TASK>
>>>>          (acquiring local_storage->lock)
>>>>      _raw_spin_lock_irqsave+0x3d/0x50
>>>>      bpf_local_storage_update+0xd1/0x460
>>>>      bpf_cgrp_storage_get+0x109/0x130
>>>>      bpf_prog_a4d4a370ba857314_cgrp_ptr+0x139/0x170
>>>>      ? __bpf_prog_enter_recur+0x16/0x80
>>>>      bpf_trampoline_6442485186+0x43/0xa4
>>>>      cgroup_storage_ptr+0x9/0x20
>>>>          (holding local_storage->lock)
>>>>      bpf_selem_unlink_storage_nolock.constprop.0+0x135/0x160
>>>>      bpf_selem_unlink_storage+0x6f/0x110
>>>>      bpf_local_storage_map_free+0xa2/0x110
>>>>      bpf_map_free_deferred+0x5b/0x90
>>>>      process_one_work+0x17c/0x390
>>>>      worker_thread+0x251/0x360
>>>>      kthread+0xd2/0x100
>>>>      ret_from_fork+0x34/0x50
>>>>      ret_from_fork_asm+0x1a/0x30
>>>>      </TASK>
>>>>
>>>> Progs:
>>>>    - A: SEC("fentry/cgroup_storage_ptr")
>>>
>>> The v1 thread has suggested using notrace in a few functions. I didn't see any counterarguments that wouldn't be sufficient.
>>>
>>> imo, that should be a better option instead of having more unnecessary failures in all other normal use cases which will not be interested in tracing cgroup_storage_ptr().
> 
> Martin,
> 
> task_storage_map_free() is doing this busy inc/dec already,
> in that sense doing the same in cgroup_storage_map_free() fits.

sgtm. Agree to be consistent with the task_storage_map_free.

would be nice if the busy inc/dec usage can be revisited after the rqspinlock work.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

