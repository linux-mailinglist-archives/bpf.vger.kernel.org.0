Return-Path: <bpf+bounces-73269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F0EC296F3
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 22:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DBF3ACBF6
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 21:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B0A1FBEA6;
	Sun,  2 Nov 2025 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BCSFaMuD"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4621917F0
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762117798; cv=none; b=rcVhWZYBxCCFr24FF/4o/uD3mrKOSpnkCzxWilcB81Xxey1SjQXjJFcRemx3QuxgVFBwTq4sjnGyueUz29M4UskswSM8hRtwT9VyShw9ROkTDDzs5LF1hWEEi7aqor22Mn+abzgOH4bHDyNWJvTRi/LvR2MjsE+RgcG7s5HFLR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762117798; c=relaxed/simple;
	bh=F8Xab92Gzik/UNdaPP4pDyJZSeHRyoIirM/XfITxbaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BcS1V0o181YOvh+pKVM1hJjaLRwL9u4FTPFIvcTVPdMcbGRSkWOigatvrjUQFHQ2xztL0uIciPRLVcQdoFH8wZoevSs4kPYocC3RYRK5H8qknZwM1xcbmxqLqRDyNLibLPmOV9tzyX1DPKXEgsDPD6gBIEZXlCm9pDyr2Hh206s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BCSFaMuD; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762117793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gAXmeX2vGz54XSwHtOTFcyqmVp+LVbdN0KySc9/XxCo=;
	b=BCSFaMuDWZvhGuK3M8jq73iXeeCw++xgqxFM0RIJ0Q7sBeTHlERrN2x/JruaS9YJ7nwza9
	h8gqats07cT1iWF+GU7ixYeWQ1af+8OTumPHVZQv16AYEYIGEGDXeNSyW3cwdckNKSigCR
	N6U0l8Q6V03D9uy8bYqtQaixkQHeODc=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Johannes Weiner <hannes@cmpxchg.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  JP Kobryn <inwardvessel@gmail.com>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,  bpf@vger.kernel.org,
  Martin KaFai Lau <martin.lau@kernel.org>,  Song Liu <song@kernel.org>,
  Kumar Kartikeya Dwivedi <memxor@gmail.com>,  Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 07/23] mm: introduce bpf_oom_kill_process() bpf kfunc
In-Reply-To: <aQR79srdPzyUT9_I@tiehlicka> (Michal Hocko's message of "Fri, 31
	Oct 2025 10:05:58 +0100")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-8-roman.gushchin@linux.dev>
	<aQR79srdPzyUT9_I@tiehlicka>
Date: Sun, 02 Nov 2025 13:09:45 -0800
Message-ID: <87a514nnty.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Michal Hocko <mhocko@suse.com> writes:

> On Mon 27-10-25 16:17:10, Roman Gushchin wrote:
>> Introduce bpf_oom_kill_process() bpf kfunc, which is supposed
>> to be used by BPF OOM programs. It allows to kill a process
>> in exactly the same way the OOM killer does: using the OOM reaper,
>> bumping corresponding memcg and global statistics, respecting
>> memory.oom.group etc.
>> 
>> On success, it sets om_control's bpf_memory_freed field to true,
>> enabling the bpf program to bypass the kernel OOM killer.
>> 
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>
> LGTM
> Just a minor question
>
>> +	/* paired with put_task_struct() in oom_kill_process() */
>> +	task = tryget_task_struct(task);
>
> Any reason this is not a plain get_task_struct?

Fair enough, get_task_struct() should work too.

Thanks

