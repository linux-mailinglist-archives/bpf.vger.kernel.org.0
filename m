Return-Path: <bpf+bounces-66307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0596EB322D5
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 21:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFBEB05DC4
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 19:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D028B2D0C91;
	Fri, 22 Aug 2025 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dLb4CQU1"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A837B21ABD0
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890889; cv=none; b=o+CGjzE+Rtc6UBEXD/bz9OKy3lzYUykWiwXvGI4BQ1xdV5F5b4OPatBAmwV4O3fGH1BVOLHniM1TSiwtcqH43LpFfxibyR+foz+t4T09GUj72Doz8bkmvijcx5Mo09nGccS4Y8xA0HGbDTDx5CGZWrIyUfaKX+VIE6X6yoazP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890889; c=relaxed/simple;
	bh=M0P0HQ+EROChtcg44tr/Trj/AZjEl0C4MNocqhQSunQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBhFPCP+mOJDQYpQGmXfc393lsgnDoczE8D8O0Ldhcw6gerX9w5PP2BgafYtrLDXA3GfC552dWcAFPSdMiBBuO906emUGJDXwqH9XZ0Lcz7P7c5NMxEveKJ1pfdxod8WdhGvmrOi+T1bknUPlP0tKDUNUbO2TbC92eJ4O4G4m6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dLb4CQU1; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755890874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tYNnmeG0XprxKHduPvXJ3NDXo6LkvZ9PXIZw0+i39Mw=;
	b=dLb4CQU1hdQ6WGWVNfKCXMj3e0QSc58PFH34wffAKQg7MGYRyXfGhinDJPLodwwg+E8S55
	COiW8FoozWMKc4A3ZD4LpWWcF1hW5y36YziTryHO0lB+0laZ4U6XnMOQAwTsCqEPrHI8+g
	XRL10qKJMbfZKT2pplmVc6EgeVI0VjA=
Date: Fri, 22 Aug 2025 12:27:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org,
 Suren Baghdasaryan <surenb@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev>
 <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87ms7tldwo.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/20/25 5:24 PM, Roman Gushchin wrote:
>> How is it decided who gets to run before the other? Is it based on
>> order of attachment (which can be non-deterministic)?
> Yeah, now it's the order of attachment.
> 
>> There was a lot of discussion on something similar for tc progs, and
>> we went with specific flags that capture partial ordering constraints
>> (instead of priorities that may collide).
>> https://lore.kernel.org/all/20230719140858.13224-2-daniel@iogearbox.net
>> It would be nice if we can find a way of making this consistent.

+1

The cgroup bpf prog has recently added the mprog api support also. If the simple 
order of attachment is not enough and needs to have specific ordering, we should 
make the bpf struct_ops support the same mprog api instead of asking each 
subsystem creating its own.

fyi, another need for struct_ops ordering is to upgrade the 
BPF_PROG_TYPE_SOCK_OPS api to struct_ops for easier extension in the future. 
Slide 13 in https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/view

