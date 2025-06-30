Return-Path: <bpf+bounces-61904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9249DAEE99A
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 23:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68B417DFC5
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 21:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC97F22FF2D;
	Mon, 30 Jun 2025 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q0L4bj+K"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53EA4A23
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751320150; cv=none; b=nfPROW0gQOMXJg/URjT8V5SLDY9nvwIu4GpRxeEPvoERCUcbw6pU2AYulr5lrQaixcHrV8ywUzj8g3rfkBbt9+mBvMl3mfB1pvcwrnD0nrUTwP/ppFnEhE0rp2TbLxdnfQL72i3lcyv7XaA2IeOpajsW4btVtT+7B4XgZSWnkWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751320150; c=relaxed/simple;
	bh=/YtMOgUJVzvubR6rJrk0HcGamZJgYROCRtLLoX72/KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zfu4CkWL6wcics28GoFsUIf28NLxoaj+SgUuQGtBDSipSGZ9pEROoqYE805i6eVM46KCsg4oqLbYQYfbsrUnb0GI63Bw3K9eGyZ2vufykZgWXmdupt1xbnJgBEsJzJYFssB3xRl9BSepejO2lJ8+mvaTb4rLvEZdZQBbx+jjZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q0L4bj+K; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9583e9fd-72aa-4d83-ac1b-6aaf018c418a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751320146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gObpFGQV5AQ0CIQtoZbIeIGkRKWJI9rd3AmhLwYFjAE=;
	b=Q0L4bj+KVrnv1SyXMFWyA+SMUOJRilx+CE9ZcqoZpzG2zBaT1gQNh6XpeamWyREaQVwLdX
	vTJwAtjGAYouuaRY5836vcLC/fKfOph3TuMTf3z0n+gh3Q1966FoMTpGk/0h8qVfqtPNz5
	y0pYyixEFwhYy8A1Q2h93BeADGzw/1Y=
Date: Mon, 30 Jun 2025 14:49:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix
 cgroup_xattr/read_cgroupfs_xattr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20250627191221.765921-1-song@kernel.org>
 <839d4696-fad6-499b-a156-994951ea75c7@linux.dev>
 <CAADnVQL5vQ9e5TMYfUafkzEUU+akgVME=OFtbATeTkL-G8aKLQ@mail.gmail.com>
 <11bd7899-9ffe-48fc-8d0b-94ed3b9532ab@linux.dev>
 <CAADnVQ++H6qOvU7tYvcxh8NW-kshUPhTCuc=4w4JCZCeu_zcdA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQ++H6qOvU7tYvcxh8NW-kshUPhTCuc=4w4JCZCeu_zcdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/27/25 2:38 PM, Alexei Starovoitov wrote:
> On Fri, Jun 27, 2025 at 2:36 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 6/27/25 2:34 PM, Alexei Starovoitov wrote:
>>> On Fri, Jun 27, 2025 at 2:19 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>>
>>>> On 6/27/25 12:12 PM, Song Liu wrote:
>>>>> cgroup_xattr/read_cgroupfs_xattr has two issues:
>>>>>
>>>>> 1. cgroup_xattr/read_cgroupfs_xattr messes up lo without creating a netns
>>>>>       first. This causes issue with other tests.
>>>>>
>>>>>       Fix this by using a different hook (lsm.s/file_open) and not messing
>>>>>       with lo.
>>>>>
>>>>> 2. cgroup_xattr/read_cgroupfs_xattr sets up cgroups without proper
>>>>>       mount namespaces.
>>>>>
>>>>>       Fix this by using the existing cgroup helpers. A new helper
>>>>>       set_cgroup_xattr() is added to set xattr on cgroup files.
>>>>>
>>>>> Fixes: f4fba2d6d282 ("selftests/bpf: Add tests for bpf_cgroup_read_xattr")
>>>>> Reported-by: Alexei Starovoitov <ast@kernel.org>
>>>>> Closes: https://lore.kernel.org/bpf/CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com/
>>>>> Signed-off-by: Song Liu <song@kernel.org>
>>>>>
>>>>> ---
>>>>> Changes v1 => v2:
>>>>> 1. Add the second fix above.
>>>>>
>>>>> v1: https://lore.kernel.org/bpf/20250627165831.2979022-1-song@kernel.org/
>>>>> ---
>>>>>     tools/testing/selftests/bpf/cgroup_helpers.c  |  21 ++++
>>>>>     tools/testing/selftests/bpf/cgroup_helpers.h  |   4 +
>>>>>     .../selftests/bpf/prog_tests/cgroup_xattr.c   | 117 ++++--------------
>>>>>     .../selftests/bpf/progs/read_cgroupfs_xattr.c |   4 +-
>>>>>     4 files changed, 49 insertions(+), 97 deletions(-)
>>>>
>>>> Hi Song.
>>>>
>>>> I tried this patch on BPF CI, and it appears it fixes the hanging
>>>> failure we've been seeing today on bpf-next and netdev.
>>>> I am going to add it to ci/diffs.
>>>
>>> Applied to bpf-next already.
>>
>> CI patches apply to all base branches. My understanding is, it's needed
>> at least for netdev too.
> 
> How is that possible?
> 
> The offending commit is only in /master and in /for-next branches,
> while /for-next is there for linux-next only.

Alexei, for-next contains offending commit, but does not have Song's
fix. Right now it's the only base branch on BPF CI that uses the temp
patch.

We do run tests on for-next, so I suppose the patch should remain in
ci/diffs until it's committed into for-next?


