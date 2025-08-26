Return-Path: <bpf+bounces-66579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C29AB371DF
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 20:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B5B7B2A65
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC732F3603;
	Tue, 26 Aug 2025 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WbwWflZK"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F7EEBB
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231302; cv=none; b=jUscKrlnoav+YJ5MFHxdYAYQtPxCieG8w6lILkIBjoA6CrYFj+HJ+yLTOEvXT5yuD919XiUkcIv5oW2zb7GKm04SpzRXPCStAw8agAHNkk1WFy+aU8da1vWTByRMyzBJDS0e/ly3FoizGRnlFjuvvDb5y1PCda7XT/AC6TwsjHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231302; c=relaxed/simple;
	bh=ZsPzngLlhnV8qcl2ZjKKiafuwl2ONmzXJcE69uIuT6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4qGRLnhnHodg+DGTfBgEsDV+C594OAfhm1RIRbX1HlDCuu9od6Ueh6JTtq0P0Ye4gkc2QQ1mL8pEWEOxCpf6ZVQuwkS9o8SAj5F4BtD5S40Zl63qKqi99yu0loD/M/tM9XJiT2g0YhjRh0qIlAbi2Uim+UFWXXNEb511g5MgyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WbwWflZK; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756231287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmKY6MkQc3HKzHukHIfBKw9ER0H4ED2SLHs/o7yHr2Y=;
	b=WbwWflZK374x9tt80LfgBRf+IupQVf/iyXGr7itPyUkuxFOEpIulPZy5irxj2OhFddyewp
	48ZyQhY8YW43UPn9lr7lxb6cW9QVr9GQoM+Wk+CqjOmpqHpeIKhFrpth1K404H+5bGuROL
	V7o/TTcag4nyOyd97obXf43b1Zl4yHY=
Date: Tue, 26 Aug 2025 11:01:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm@kvack.org,
 bpf@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev>
 <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev> <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
 <87wm6rwd4d.fsf@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87wm6rwd4d.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/25/25 10:00 AM, Roman Gushchin wrote:
> Martin KaFai Lau <martin.lau@linux.dev> writes:
> 
>> On 8/20/25 5:24 PM, Roman Gushchin wrote:
>>>> How is it decided who gets to run before the other? Is it based on
>>>> order of attachment (which can be non-deterministic)?
>>> Yeah, now it's the order of attachment.
>>>
>>>> There was a lot of discussion on something similar for tc progs, and
>>>> we went with specific flags that capture partial ordering constraints
>>>> (instead of priorities that may collide).
>>>> https://lore.kernel.org/all/20230719140858.13224-2-daniel@iogearbox.net
>>>> It would be nice if we can find a way of making this consistent.
>>
>> +1
>>
>> The cgroup bpf prog has recently added the mprog api support also. If
>> the simple order of attachment is not enough and needs to have
>> specific ordering, we should make the bpf struct_ops support the same
>> mprog api instead of asking each subsystem creating its own.
>>
>> fyi, another need for struct_ops ordering is to upgrade the
>> BPF_PROG_TYPE_SOCK_OPS api to struct_ops for easier extension in the
>> future. Slide 13 in
>> https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/view
> 
> Does it mean it's better now to keep it simple in the context of oom
> patches with the plan to later reuse the generic struct_ops
> infrastructure?
> 
> Honestly, I believe that the simple order of attachment should be
> good enough for quite a while, so I'd not over-complicate this,
> unless it's not fixable later.

I think the simple attachment ordering is fine. Presumably the current link list 
in patch 1 can be replaced by the mprog in the future. Other experts can chime 
in if I have missed things.

Once it needs to have an ordering api in the future, it should probably stay 
with mprog instead of each subsystem creating its own. The inspection tool 
(likely a subcmd in bpftool) can also be created to inspect the struct_ops order 
of a subsystem.

