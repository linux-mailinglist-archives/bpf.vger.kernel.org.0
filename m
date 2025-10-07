Return-Path: <bpf+bounces-70482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B4CBC0063
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 04:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0073B1931
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 02:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECF31A76B1;
	Tue,  7 Oct 2025 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jwnVEiY+"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF27464
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759803952; cv=none; b=qaOkvMUHYL71zfUxCPCcqXqbu28FOQ5b4bbKvlGq8XinHQAy/gr/RxYAFcav+cGtC/Bi1GYMGu4V/mbtijpN3oKuArbWAruUpp00gIStG6iX6aewPxAtgYjTxVFqtSd8x3gh2CAwhortJeu5EvTuSqz6/gxo7o6PCr4CVB2qE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759803952; c=relaxed/simple;
	bh=hhMvCBnaVyEEhyRYwwYYg2TEyPmktd3es3/wlZqMFNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJBrDh7gVah7KmIJ0qKVUh0L6T9Fw9jJ0uvsmBk/DQGaoCzXkd/cIWvQytqiucU3KwKvGvP0QEmkqOnwgwXpJX0W6HChEQyOLFKJ/p4iBxpwPPrIuNZBA6txDivlZ/wvA10yedfgSD4xDyoTUMJkOTH885PR0+0VVCSab/2hz+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jwnVEiY+; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8726ab79-73f5-46c9-839a-d3abf6f301f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759803946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/MKPrETeCuyyOYuVdodsDdiZ6BmGFxYMMYFjYABmB/E=;
	b=jwnVEiY+lQvyrdA2Bf1cDFGtM/Wg/zb3zEORYQVzkoph90jCCxJpGDM7JAltMeK9M7gaXK
	S1C5GtB42Tynfz8K3GBngRpbfbnfBY3IkgfeiXf3hAwnbyxcW2AfoNQqPkmHB14NiVxnbs
	dMex8vxR6PyXIZmZuIr7y5KxzCVBtEU=
Date: Mon, 6 Oct 2025 19:25:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm <linux-mm@kvack.org>,
 bpf <bpf@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev>
 <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev> <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
 <87wm6rwd4d.fsf@linux.dev> <ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
 <CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
 <87iki0n4lm.fsf@linux.dev> <a76ad1e9-07d5-4ba1-83e4-22fe36a32df0@linux.dev>
 <877bxb77eh.fsf@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <877bxb77eh.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/3/25 7:00 PM, Roman Gushchin wrote:
> Martin KaFai Lau <martin.lau@linux.dev> writes:
> 
>> On 9/2/25 10:31 AM, Roman Gushchin wrote:
>>> Btw, what's the right way to attach struct ops to a cgroup, if there is
>>> one? Add a cgroup_id field to the struct and use it in the .reg()
>>
>> Adding a cgroup id/fd field to the struct bpf_oom_ops will be hard to
>> attach the same bpf_oom_ops to multiple cgroups.
>>
>>> callback? Or there is something better?
>>
>> There is a link_create.target_fd in the "union bpf_attr". The
>> cgroup_bpf_link_attach() is using it as cgroup fd. May be it can be
>> used here also. This will limit it to link attach only. Meaning the
>> SEC(".struct_ops.link") is supported but not the older
>> SEC(".struct_ops"). I think this should be fine.
> 
> I thought a bit more about it (sorry for the delay):
> if we want to be able to attach a single struct ops to multiple cgroups
> (and potentially other objects, e.g. sockets), we can't really
> use the existing struct ops's bpf_link.

The existing 'struct bpf_struct_ops_link'? yeah, I think it needs to be extended.

> 
> So I guess we need to add a new .attach() function beside .reg()
> which will take the existing link and struct bpf_attr as arguments and
> return a new bpf_link. And in libbpf we need a corresponding new
> bpf_link__attach_cgroup().

The target_fd (or cgroup_fd) is in attr. I think it is why the bpf_attr is 
needed during link_create (which calls .reg).

Other than link_create, the link_detach and link_update also need to know the 
cgroup but the cgroup_fd will not be in the attr. Only link_fd is available.

The cgroup probably needs to be stored in the link. The struct_ops has its 
'struct bpf_struct_ops_link'. Potentially a future struct_ops can be attached to 
non-cgroup also (e.g. attach to a netns), so maybe adding a 'void *target;' to 
the 'struct bpf_struct_ops_link' and pass the attr to .reg(). Note that the link 
pointer has already passed to .reg(). Then the subsystem (oom handling here) can 
initialize the 'void *target;'.


