Return-Path: <bpf+bounces-44407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA999C2956
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 02:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E561F233D7
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 01:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6462209B;
	Sat,  9 Nov 2024 01:48:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58BD48CFC
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 01:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731116937; cv=none; b=Nby4XMvYkx0FUDfjg0TE9iL6TRCNel82mFCf+CUdY361ctLekcohBoSLCYVmmnt1kv+PACr+nIEifKBeKpfdU3viaTTbpZqTC68iReFUXGB/RgiBBkHaYVh5Vj9irWtOj+aaBjhPCXfNWS1lAqo+li1oucZnsgOrkMZXyCJY4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731116937; c=relaxed/simple;
	bh=KPCdUGK6wiFGL81BOOrJlfuA1sIeUbVcsKGx3swbjSU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DNrzzFMtutZPCDjZI0K9UR45Dqme2sl/e0ED1Ji1CcGCCqsQvfL7KXyjrWa+VM8Ng6YwxKAxuX2DVO2WpoHPAYZuZ1SgJlzqJQT1LY1qajxZ10r5ilyQ5uJ0kA0aSgc8ObDN4ts11x1xeTfloFthdH7289rwb8pgNpIl+B2kUAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xldxs2c7zz4f3jsT
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 09:48:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 705991A0568
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 09:48:51 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC34IR_vy5nFdQFBQ--.22228S2;
	Sat, 09 Nov 2024 09:48:51 +0800 (CST)
Subject: Re: [PATCH bpf-next 0/3] Fix lockdep warning for htab of map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20241106063542.357743-1-houtao@huaweicloud.com>
 <20241106084527.4gPrMnHt@linutronix.de>
 <892b3592-0896-7634-ed44-9ba610242eb3@huaweicloud.com>
 <CAADnVQLPp2bGJQ_A4WS0sYM97xJFkQocK7t5pPN-mDVM=ZY4=A@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <2a069b1e-acd3-4fdf-2ec8-287dc8edafe4@huaweicloud.com>
Date: Sat, 9 Nov 2024 09:48:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLPp2bGJQ_A4WS0sYM97xJFkQocK7t5pPN-mDVM=ZY4=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC34IR_vy5nFdQFBQ--.22228S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWUJFWDXw4fArW8tFW5Jrb_yoW8Kw1Upr
	4fKa43Kr4DXryqvFnFyanrG34ftw13GrWUXryrKryj9rn0vFnYq3yIgF4ruFWIyr4IyFnI
	qrW0ka43Zw1UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 11/9/2024 3:52 AM, Alexei Starovoitov wrote:
> On Wed, Nov 6, 2024 at 1:49 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 11/6/2024 4:45 PM, Sebastian Andrzej Siewior wrote:
>>> On 2024-11-06 14:35:39 [+0800], Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> Hi,
>>> Hi Hou,
>>>
>>>> The patch set fixes a lockdep warning for htab of map. The
>>>> warning is found when running test_maps. The warning occurs when
>>>> htab_put_fd_value() attempts to acquire map_idr_lock to free the map id
>>>> of the inner map while already holding the bucket lock (raw_spinlock_t).
>>>>
>>>> The fix moves the invocation of free_htab_elem() after
>>>> htab_unlock_bucket() and adds a test case to verify the solution. Please
>>>> see the individual patches for details. Comments are always welcome.
> The fix makes sense.
> I manually resolved merge conflict and applied.

Thanks for the manually conflict resolving. However, the patch set
doesn't move all free operations outside of lock scope (e.g., for
bpf_map_lookup_and_delete()), because htab of maps doesn't support it. I
could post another patch set to do that.
>
>>> Thank you.
>>>
>>> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>>
>>> I've seen that you didn't move check_and_free_fields() out of the bucket
>>> locked section. Type BPF_TIMER does hrtimer_cancel() if the timer
>>> happens to run on a remote CPU. On PREEMPT_RT this will acquire a
>>> sleeping lock which is problematic due to the raw_spinlock_t.
>>> Would it be okay, to cleanup the timer unconditionally via the
>>> workqueue?
>> Yes. The patch set still invokes check_and_free_fields() under the
>> bucket lock when updating an existing element in a pre-allocated htab. I
>> missed the hrtimer case. For the sleeping lock, you mean the
>> cpu_base->softirq_expiry_lock in hrtimer_cancel_waiting_running(), right
>> ? Instead of cancelling the timer in workqueue, maybe we could save the
>> old value temporarily in the bucket lock, and try to free it outside of
>> the bucket lock or disabling the extra_elems logic temporarily for the
>> case ?
> We definitely need to avoid spamming wq when cancelling timers.
> wq may not be able to handle the volume.
> Moving it outside of bucket lock is certainly better.
> .

OK. Will try whether there is a better way to handle the cancelling of
timer case.


