Return-Path: <bpf+bounces-66037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0B6B2CDB3
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 22:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BAE1C413D4
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 20:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9B3101D2;
	Tue, 19 Aug 2025 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jc6p9mvm"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568CE284896
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634606; cv=none; b=dxPqa7zIfR6XhOX3w95xJ/lPEi1I06dBvm7R2kewvJokyfE5JptMlWmyX8Ey913z08Hk9JTkO8WI/lW9+tvhwoVBkwoxs+jzmOO8rKdBEVoXgBeI9B8HnmO9CUVG8M6E/Ssa6P/Lk9/amtJez9HJvUiL3A1Ml+rVJ1m8Hlu1PO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634606; c=relaxed/simple;
	bh=udgocsjJD41ItoihgnArmiVjyb7mSZD6JjIAaDNQ6Lg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O7Dwzk9u+R/A3PZ035TmEqk/r2bJ+A75uhDuINjrc9JlH7Su9UYJy+NsxoQ+2gu6+XCsUmwq0s4FfJ0DQwduQmxjmiID5Bp8GFlVu/yEG8/B3p/LZu7ozs5XHezZciXtLOXpWDYWV+Z9HwabnsXyhFO7L1Sxt5SjhAAMK4f7PbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jc6p9mvm; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755634601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JqbB3H+IOvqAzvYEg/c7+VdVr8vD6PumH4PG2on0onk=;
	b=jc6p9mvmzAAxtUOk1Rl3nqhHXLTv28gZeOudhcu3Cs/7o0QHDQm830galIumRVJf11TdYU
	MpQhTSYtWIW+fwvpqjeo2YRTOsNkduSprMPk+w3CEXSIF5COP9hRD5+OmtHii7bR32eviT
	BwLcrgjM/id8VJCcmz0+hNbNwbK51GY=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David Rientjes
 <rientjes@google.com>,  Matt Bobrowski <mattbobrowski@google.com>,  Song
 Liu <song@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,
  Alexei Starovoitov <ast@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/14] mm: introduce bpf_out_of_memory() bpf kfunc
In-Reply-To: <CAJuCfpHTtLQR0NpsbFytaOdEc0KqNv6PxVpxNetYD6Ce4sY9UQ@mail.gmail.com>
	(Suren Baghdasaryan's message of "Mon, 18 Aug 2025 21:09:24 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-7-roman.gushchin@linux.dev>
	<CAJuCfpHTtLQR0NpsbFytaOdEc0KqNv6PxVpxNetYD6Ce4sY9UQ@mail.gmail.com>
Date: Tue, 19 Aug 2025 13:16:30 -0700
Message-ID: <87wm6zysm9.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Suren Baghdasaryan <surenb@google.com> writes:

> On Mon, Aug 18, 2025 at 10:02=E2=80=AFAM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
>>
>> Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
>> an out of memory events and trigger the corresponding kernel OOM
>> handling mechanism.
>>
>> It takes a trusted memcg pointer (or NULL for system-wide OOMs)
>> as an argument, as well as the page order.
>>
>> If the wait_on_oom_lock argument is not set, only one OOM can be
>> declared and handled in the system at once, so if the function is
>> called in parallel to another OOM handling, it bails out with -EBUSY.
>> This mode is suited for global OOM's: any concurrent OOMs will likely
>> do the job and release some memory. In a blocking mode (which is
>> suited for memcg OOMs) the execution will wait on the oom_lock mutex.
>>
>> The function is declared as sleepable. It guarantees that it won't
>> be called from an atomic context. It's required by the OOM handling
>> code, which is not guaranteed to work in a non-blocking context.
>>
>> Handling of a memcg OOM almost always requires taking of the
>> css_set_lock spinlock. The fact that bpf_out_of_memory() is sleepable
>> also guarantees that it can't be called with acquired css_set_lock,
>> so the kernel can't deadlock on it.
>>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> ---
>>  mm/oom_kill.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 25fc5e744e27..df409f0fac45 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -1324,10 +1324,55 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_=
control *oc,
>>         return 0;
>>  }
>>
>> +/**
>> + * bpf_out_of_memory - declare Out Of Memory state and invoke OOM killer
>> + * @memcg__nullable: memcg or NULL for system-wide OOMs
>> + * @order: order of page which wasn't allocated
>> + * @wait_on_oom_lock: if true, block on oom_lock
>> + * @constraint_text__nullable: custom constraint description for the OO=
M report
>> + *
>> + * Declares the Out Of Memory state and invokes the OOM killer.
>> + *
>> + * OOM handlers are synchronized using the oom_lock mutex. If wait_on_o=
om_lock
>> + * is true, the function will wait on it. Otherwise it bails out with -=
EBUSY
>> + * if oom_lock is contended.
>> + *
>> + * Generally it's advised to pass wait_on_oom_lock=3Dtrue for global OO=
Ms
>> + * and wait_on_oom_lock=3Dfalse for memcg-scoped OOMs.
>
> From the changelog description I was under impression that it's vice
> versa, for global OOMs you would not block (wait_on_oom_lock=3Dfalse),
> for memcg ones you would (wait_on_oom_lock=3Dtrue).

Good catch, fixed.

>
>> + *
>> + * Returns 1 if the forward progress was achieved and some memory was f=
reed.
>> + * Returns a negative value if an error has been occurred.
>
> s/has been occurred/has occurred or occured

Same here.

Thanks!

