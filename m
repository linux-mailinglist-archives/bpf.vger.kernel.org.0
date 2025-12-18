Return-Path: <bpf+bounces-76984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7D4CCBB5A
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 13:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 419673034A03
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD12732C92C;
	Thu, 18 Dec 2025 12:02:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC61A32A3C0;
	Thu, 18 Dec 2025 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059343; cv=none; b=Ca11lYEYVI1LkdPD0SIcvallPbUXum+AJnjG+DFSY2GnzyPnOcsnJONlgONeJwjLrcb5N2GIobc0ecYO+/i3B1dLwJPiToUik7HkO6ad5fOd94YaJ8Dhylj6obC4cSbFexwFw11FvWi2YVsQXzrfuK+t2IQOQMXxIzNDX0LiHw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059343; c=relaxed/simple;
	bh=BYJgx+KoHuf+T/XmZqzevNSNmwHPM+zL8GnCP4KiT7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZp1C67gC9W9ZQFswzF19xk6qNKWR93+/WC9ha38tl5rKaJQExFiVaPgByRO0OE6Dza8OIE6GI+bA6+XqsCbPiDxc8OvjhgRXuQBb5KWVDauwSrzyLmA+tOZj6GNFNkQjtk9VYxaFQ825418pOEeoHAMF5u4385uypLWEGxyo9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E31C6FEC;
	Thu, 18 Dec 2025 04:02:13 -0800 (PST)
Received: from [10.1.39.180] (unknown [10.1.39.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 029FB3F762;
	Thu, 18 Dec 2025 04:02:15 -0800 (PST)
Message-ID: <0d08b4bf-35c5-4c63-964b-ef886b8262d9@arm.com>
Date: Thu, 18 Dec 2025 12:02:14 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while
 stop_machine()
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>, Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, catalin.marinas@arm.com,
 will@kernel.org, kevin.brodsky@arm.com, dev.jain@arm.com,
 yang@os.amperecomputing.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <20251212161832.2067134-3-yeoreum.yun@arm.com> <aUPJuZINNuNxddRX@tiehlicka>
 <aUPLCPAyxkPeBaoD@e129823.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aUPLCPAyxkPeBaoD@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2025 09:36, Yeoreum Yun wrote:
> Hi,
>> On Fri 12-12-25 16:18:32, Yeoreum Yun wrote:
>>> linear_map_split_to_ptes() and __kpti_install_ng_mappings()
>>> are called as callback of stop_machine().
>>> That means these functions context are preemption disabled.
>>>
>>> Unfortunately, under PREEMPT_RT, the pagetable_alloc() or
>>> __get_free_pages() couldn't be called in this context
>>> since spin lock that becomes sleepable on RT,
>>> potentially causing a sleep during page allocation.
>>>
>>> To address this, pagetable_alloc_nolock().
>>
>> As you cannot tolerate allocation failure and this is pretty much
>> permanent allocation (AFAIU) why don't you use a static allocation?
> 
> Because of when bbl2_noabort is supported, that pages doesn't need to.
> If static alloc, that would be a waste in the system where bbl2_noabort
> is supported.
> 
> When I tested, these extra pages are more than 40 in my FVP.
> So, it would be better dynamic allocation and I think since it's quite a
> early time, it's probably not failed that's why former code runs as it
> is.

The required allocation size is also a function of the size of the installed RAM
so a static worst case allocation would consume all the RAM on small systems.

> 
> --
> Sincerely,
> Yeoreum Yun


