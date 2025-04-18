Return-Path: <bpf+bounces-56216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C923A92FE3
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 04:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8D4464292
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 02:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076CB267B92;
	Fri, 18 Apr 2025 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="YQEbBVeH"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7E6261362;
	Fri, 18 Apr 2025 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942961; cv=none; b=C7yB0eFUxepbYoA0A3s0XWH1efh0Ee0ae4L0sjZsPN+WNI0TgZJoZ8GbC4hOGfeWyueZAhJzIqIcx6VAmz9o4d2CgWKHd3lQ1Q1cQ5eAZ6AVUzP3QZzHBzFk3ubmgb0KPB3qkXS1KmUAjwIz/kf5FDiAVD01+GDq+LdnvGlc1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942961; c=relaxed/simple;
	bh=JCzfdM5PNe2ZJFrq9lg1dO7fGrTlR36T84drGygkf/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0OjuLiUNB0zx35LeBSzCJrks1wxi3KysTSQur+FAeKdjB73C77a5Jvg73H3VIqqtc7L6bfajv28+9uAmINz/D9bDbF4k9ebuLljxIdAZEnRuZ5lVX+Id0bRpSaUyOGt14oom9Bg8GBcpb6UjvaGxl3HMR+B87HMHjAJjp+jCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=YQEbBVeH; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=xwhX0vOBkVUpBae2W/i8kIt8mM6leS7GZ7Ncbac7mTk=;
	b=YQEbBVeHOSOosjFKl4Hy6C7rrj/v2lSprceKcqSCY1oAuex7Sor1Rmbx1nSi2g
	yPa9Mtn4hFC5nKiZeGk7nBlR7vq6zy42+MnA2BTZ4mlSD1MGvBGZDQ/NT9Enu4Cd
	lel0I8F0q2a5EcGWiB+dwMWd257wE2nWHuvpjUZRuk7nc=
Received: from [172.24.148.178] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3Xw9VswFoXkCCBA--.42431S2;
	Fri, 18 Apr 2025 10:05:10 +0800 (CST)
Message-ID: <a247e016-494d-42a6-8f6a-2ff08366404b@126.com>
Date: Fri, 18 Apr 2025 10:05:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched_ext: change the variable name for slice refill
 event
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, joshdon@google.com, brho@google.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250417080708.1333-1-jameshongleiwang@126.com>
 <20250417080708.1333-2-jameshongleiwang@126.com> <aAFIvndKUQXm_ix5@gpd3>
Content-Language: en-US
From: Honglei Wang <jameshongleiwang@126.com>
In-Reply-To: <aAFIvndKUQXm_ix5@gpd3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3Xw9VswFoXkCCBA--.42431S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1rXF1DuF1xKFWkCw17Jrb_yoW8Gr1xpr
	Z3AF1Skan2yayxArWfZr1kXr1Yqa1fGw42gr1rtrs7tw1jkF1Fgr15tr4SgFW5X39akF18
	t3Wj93ZxGrsFv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j39N3UUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbirxwzrWgBrEGwZwAAs+

Hi Andrea,

On 2025/4/18 02:30, Andrea Righi wrote:
> Hi Honglei,
> 
> On Thu, Apr 17, 2025 at 04:07:07PM +0800, Honglei Wang wrote:
>> SCX_EV_ENQ_SLICE_DFL gives the impression that the event only occurs
>> when the tasks were enqueued, which seems not accurate. What it actually
>> means is the refilling with defalt slice, and this can occur either when
>> enqueue or pick_task. Let's change the variable to
>> SCX_EV_REFILL_SLICE_DFL.
>>
>> Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
>> ---
>>  kernel/sched/ext.c             | 22 +++++++++++-----------
>>  tools/sched_ext/scx_qmap.bpf.c |  4 ++--
>>  2 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 66bcd40a28ca..594087ac4c9e 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -1517,10 +1517,10 @@ struct scx_event_stats {
>>  	s64		SCX_EV_ENQ_SKIP_MIGRATION_DISABLED;
>>  
>>  	/*
>> -	 * The total number of tasks enqueued (or pick_task-ed) with a
>> -	 * default time slice (SCX_SLICE_DFL).
>> +	 * The total number of tasks slice refill with default time slice
>> +	 * (SCX_SLICE_DFL).
> 
> Nit, how about:
> 
> Total number of times a task's time slice was refilled with the default
> value (SCX_SLICE_DFL).
> 

OK, will send a update later.

Thanks,
Honglei

> Thanks,
> -Andrea


