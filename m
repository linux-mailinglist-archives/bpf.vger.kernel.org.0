Return-Path: <bpf+bounces-44118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440759BE306
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 10:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FA2283ED6
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 09:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674F51D90AD;
	Wed,  6 Nov 2024 09:49:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086FD1D5CFA
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886551; cv=none; b=X/mw8PzidXd+ykoiX0IvIiihnOzscpaXlbkR6nkeYh+vDzIkyk/iqknyFRiTEi8q9uMtX4r0YBHzeAW4lmJytj+CdzCPKqMFqTWwadHXTJaBLAZV8BghSbWGKCJ2Z2EYT847HpsU16oSdr9ncjaOj+3r8WgK4apgAf5OuJrB90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886551; c=relaxed/simple;
	bh=byC/jeLaj+nHCzucV3VMC+qyJ/hk+twRUL7E0Peh18o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C8gBRnwIlO076IoQ1ElOaOYiIP48JlS+olWiqfs9tXD/4JHjR0GqFnXWK43uBiIaFsou+J0O0eEx3ZRa+fR9/U4jGgBzJP/94/NUjlJODUUqJzTUFbHl9oXiII+lgPmEXRVX/kx8FAFEuS9oI/4oT3VAzwK9PnpQrqS7Uhd2+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xk0lK1gm4z4f3jXr
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 17:48:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 377391A018D
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 17:49:03 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgCHGcaLOytnWOXlAw--.3094S2;
	Wed, 06 Nov 2024 17:49:02 +0800 (CST)
Subject: Re: [PATCH bpf-next 0/3] Fix lockdep warning for htab of map
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 xukuohai@huawei.com
References: <20241106063542.357743-1-houtao@huaweicloud.com>
 <20241106084527.4gPrMnHt@linutronix.de>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <892b3592-0896-7634-ed44-9ba610242eb3@huaweicloud.com>
Date: Wed, 6 Nov 2024 17:48:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241106084527.4gPrMnHt@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgCHGcaLOytnWOXlAw--.3094S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1DXw4fZF15AF13CF1Utrb_yoW8WF1Upr
	4xGa43KF4DXryvvFnFyayDC34fJw1fGrW7Gry8Kryjvws8Z3ZYqayI9a1F9FyIyrs7A3ZI
	qrWDua43uryjvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/6/2024 4:45 PM, Sebastian Andrzej Siewior wrote:
> On 2024-11-06 14:35:39 [+0800], Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Hi,
> Hi Hou,
>
>> The patch set fixes a lockdep warning for htab of map. The
>> warning is found when running test_maps. The warning occurs when
>> htab_put_fd_value() attempts to acquire map_idr_lock to free the map id
>> of the inner map while already holding the bucket lock (raw_spinlock_t).
>>
>> The fix moves the invocation of free_htab_elem() after
>> htab_unlock_bucket() and adds a test case to verify the solution. Please
>> see the individual patches for details. Comments are always welcome.
> Thank you.
>
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> I've seen that you didn't move check_and_free_fields() out of the bucket
> locked section. Type BPF_TIMER does hrtimer_cancel() if the timer
> happens to run on a remote CPU. On PREEMPT_RT this will acquire a
> sleeping lock which is problematic due to the raw_spinlock_t.
> Would it be okay, to cleanup the timer unconditionally via the
> workqueue?

Yes. The patch set still invokes check_and_free_fields() under the
bucket lock when updating an existing element in a pre-allocated htab. I
missed the hrtimer case. For the sleeping lock, you mean the
cpu_base->softirq_expiry_lock in hrtimer_cancel_waiting_running(), right
? Instead of cancelling the timer in workqueue, maybe we could save the
old value temporarily in the bucket lock, and try to free it outside of
the bucket lock or disabling the extra_elems logic temporarily for the
case ?
> Sebastian


