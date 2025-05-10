Return-Path: <bpf+bounces-57963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48828AB206B
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 02:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8A31C262D0
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 00:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C6238B;
	Sat, 10 May 2025 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S9JCE690"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE565184
	for <bpf@vger.kernel.org>; Sat, 10 May 2025 00:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746835274; cv=none; b=D9UOvygLSdP5sgP9ZWy/j9Yc9q/I3mZvfr5o3OX1qjo1Vs3QOW8fF5UVq06BoyK0FS785B405smc5U3vAxHRXSwxZ5QZnrzPjX6j4lXA+9GxV8ZSxqvMPWf6prA4YVKf0fBTIRkc6sGl7TgtIg2iXKJbs7wut0ICvAI0+4WMlVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746835274; c=relaxed/simple;
	bh=bzHojvGJXfKfrCmjqiTDizZgHXYSrsTm0PuXbD9H59Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ud8wqaQ7n0lP1htCkaAHUbhPErFtmui/n6V7VOHHFTcAleiHu/HW9SwawxBHBOSSrXntfv3bydHilTitDptQRwersGDY0rbrPFPZkLEHtUW+BBP5QbNpWiTEF5TjAkb5M0pZAY1KRykxY5KP6lJFzHOdwFLo3HbMyF0SNqJQZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S9JCE690; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d18b3908-de58-4db6-9b0e-e075e48c64e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746835269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqGICKR0J8kaSqihoAuGNQEpzMu6vFRsCKY6VhMIAeY=;
	b=S9JCE690w7MexHS5XWfhOglm8oB63CfB8RWeF85ZzaLmKHO1UW90tqnUvOQczhiwdgJgTl
	R0nvHkcjkxTl0e9g6pkvCe0yXdNxvVeYVw+obLX3p0Lig8WT3MDDloz3SyCwUEiDAnfsG4
	gB/ck3t1iN8oEXLEnzXc2Gl0B3Zu/NU=
Date: Fri, 9 May 2025 17:01:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 07/17] bpf: Support new 32bit offset jmp
 instruction
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, "Lai, Yi" <yi1.lai@linux.intel.com>,
 Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 David Faust <david.faust@oracle.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, yi1.lai@intel.com
References: <20230728011143.3710005-1-yonghong.song@linux.dev>
 <20230728011231.3716103-1-yonghong.song@linux.dev>
 <Z/8q3xzpU59CIYQE@ly-workstation>
 <763cbfb4-b1a0-4752-8428-749bb12e2103@linux.dev>
 <33a03235-638d-4c63-811d-ec44872654b3@linux.dev>
 <CAADnVQJBgEDXnsRjTC0BUPAqfiHoH+ZL6vk1Me-+QcXbT811jg@mail.gmail.com>
 <342054de8fb765780b1856e5b3b81b4e0a531620.camel@gmail.com>
 <CAEf4Bzbgci5pOmHmYoAYTe6cYdwJ4ju=5LuT0VQzsu+aKQ1AgQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bzbgci5pOmHmYoAYTe6cYdwJ4ju=5LuT0VQzsu+aKQ1AgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/9/25 5:36 AM, Andrii Nakryiko wrote:
> On Fri, May 9, 2025 at 1:50 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> On Fri, 2025-05-09 at 10:21 -0700, Alexei Starovoitov wrote:
>>
>> [...]
>>
>>> hmm.
>>> We probably should filter out r10 somehow,
>>> since the following:
>>>> mark_precise: frame1: regs=r2 stack= before 7: (bd) if r2 <= r10 goto pc-1
>>>> mark_precise: frame1: regs=r2,r10 stack= before 6: (06) gotol pc+0
>>> is already odd.
>> Not Andrii, but here are my 5 cents.
>>
>> check_cond_jmp() allows comparing pointers with scalars.
>> is_branch_taken() predicts jumps for null comparisons.
>> Hence, tracking precision of the r2 above is correct.
>> backtrack_insn() does not know the types of the registers when
>> processing `r2 <= r10` and thus adds r10 to the tracked set.
>> Whenever a scalar is added to a PTR_TO_STACK such scalar is marked as precise.
>> This means that there is no need to track precision for constituents
>> of the PTR_TO_STACK values.
>>
>> Given above, I think that filtering out r10 should be safe.
> Yeah, it makes no sense to track r10. It's always "precise", effectively.

This does make sense. I will craft a patch to fix it (not tracking r10
during precision backtrack) soon.

>
>> In case if sequence of instructions would be more complex, e.g.:
>>
>>          r9 = r10
>>          if r2 <= r9 goto -1; \
>>
>> backtrack_insn() would still eventually get to r10 and stop
>> propagation.
>>


