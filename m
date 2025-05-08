Return-Path: <bpf+bounces-57721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C610FAAF108
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 04:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F8A1C0406C
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 02:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ACF1B0402;
	Thu,  8 May 2025 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hrSdYq40"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D2B33FD;
	Thu,  8 May 2025 02:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746670423; cv=none; b=CvZCxvVn6f1FJ4anrzzFKVXEACmtekwuNMfW3I8bKxQh9YdKipM6IvLQyLtMNSD6Y0lNvAUMMV4YyEDaXV+dIourwLnfapDM7mdeyfSJjfqea+kyAvuW9chZUoQYUPS0zqdrWtmk9q6az8iI8ytkuQ3TjWcOW0aj73OSZQkMlD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746670423; c=relaxed/simple;
	bh=WJKZNJ7SSSRUugZCCAEW1tNYWcaSO9G+6+1s7+4IiEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLwyEv3yQWF4+zWxJb/XN5dyKfC7cykb+kbdefixIFF6ObrpczGRxofzERB8BuHQWgQSOf6NJfsW19GGBJpqf86nDqWYT9Y0GM3hEVGxXx1DqrcajMHi8H0Uj5/gffSH5M+ON4etjhLxg5YkqpymgkP2vvkzRQaYNLD1TBSqCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hrSdYq40; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=61xY3I9e2FylqeuGTMALB60yte4ov1P0b2glBpex5Ro=;
	b=hrSdYq40oM3crGMLp1Jat0MLOU7uVGeJAgPsID43MOT8HJTFJkQlZaB4EjE16e
	vS1lf0nTVebRfYjRNdXypyjP84WlQAs1Y1ciGfU8gcS+1dCxvJdp8mt1sHnroRbx
	YLCpB3Lt760pzquOx8BifbKs0f8vyf5t8EM6krKGAhia8=
Received: from [172.24.149.29] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnb35VEhxo3PESAA--.31069S2;
	Thu, 08 May 2025 10:09:27 +0800 (CST)
Message-ID: <4e66082e-7b00-418b-a21f-73f73d80524c@126.com>
Date: Thu, 8 May 2025 10:09:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 0/2] sched_ext: rename var for slice refill
 event and add helper
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 joshdon@google.com, brho@google.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250507011637.77589-1-jameshongleiwang@126.com>
 <aBuRhMtQa-ogEv57@slm.duckdns.org>
Content-Language: en-US
From: Honglei Wang <jameshongleiwang@126.com>
In-Reply-To: <aBuRhMtQa-ogEv57@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnb35VEhxo3PESAA--.31069S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyxJFW3Wr1DJFWfurW7Arb_yoWDKwcEgF
	9IkrZrJanruF4UCay3K3W5t3sFgrWvvrs8JFWDtrsFyrWfJrZxJr95KrZ3Xw18WayIyF9x
	Krn8Aa4xGwnxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0gTmDUUUUU==
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbirxRHrWgcEMortAABsh

Hi Tejun,

On 2025/5/8 00:59, Tejun Heo wrote:
> On Wed, May 07, 2025 at 09:16:35AM +0800, Honglei Wang wrote:
>> SCX_EV_ENQ_SLICE_DFL gives the impression that the event only occurs
>> when the tasks were enqueued, which seems not accurate. So rename the
>> variable to SCX_EV_REFILL_SLICE_DFL.
>>
>> The slice refilling with default slice always come with event
>> statistics together, add a helper routine to make it cleaner.
>>
>> Changes in v2:
>> Refine the comments base on Andrea's suggestion.
>>
>> Honglei Wang (2):
>>   sched_ext: change the variable name for slice refill event
>>   sched_ext: add helper for refill task with default slice
>>
>>  kernel/sched/ext.c             | 36 +++++++++++++++++-----------------
>>  tools/sched_ext/scx_qmap.bpf.c |  4 ++--
>>  2 files changed, 20 insertions(+), 20 deletions(-)
> 
> These patches already had been applied back in mid April. If there are
> updates to be made, please send incremental patches.
> 

Seems I missed the applied message in the mail series... Sorry for
bothering, I'll be careful next time.

Thanks,
Honglei

> Thanks.
> 


