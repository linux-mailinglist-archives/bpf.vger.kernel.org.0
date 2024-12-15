Return-Path: <bpf+bounces-46996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A139F2302
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 10:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4150618868B4
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 09:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D4D149C69;
	Sun, 15 Dec 2024 09:37:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175851119A
	for <bpf@vger.kernel.org>; Sun, 15 Dec 2024 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734255443; cv=none; b=HG0CCYEnjZEfSY9KocKgHzraSEk0UhKl0w2s4eRk751La0LQVXMVyRCkwYQt+mk4hyZjKmt0lR+jJzNuySdEYyM+mpMoJCCzTJSK7MPVwtkoE2/HTgM04SL9pkJfN135bmSgqzb/VwGjh+0SPmdcb1kKwLWV9OEu1hQTyAXdTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734255443; c=relaxed/simple;
	bh=aFyf84927ad+AFzDCRr/03Y7olCji90RVsUVZnJPVxM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FlIwmvH4EpZjisE1Z3TxMJple07UZq/wcOxrTMqvp8eLsh1jzHApp5KbTkzcDjly0Zqk2xwrx+BU5y41AhGlRzMRLk0DGxyLMTz6FikuZFL4M4NXKI0Zr4QRcsqYmuVXh2+J0j4WUqzzOtq2mPga52h4QwMZ9+zzTsCLi/ejO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y9ydg27Dxz4f3kvl
	for <bpf@vger.kernel.org>; Sun, 15 Dec 2024 17:36:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B59161A0359
	for <bpf@vger.kernel.org>; Sun, 15 Dec 2024 17:37:15 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgB3U8BHo15n9SoZEg--.3526S2;
	Sun, 15 Dec 2024 17:37:15 +0800 (CST)
Subject: Re: [PATCH bpf v2 7/9] bpf: Use raw_spinlock_t for LPM trie
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <linux@weissschuh.net>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20241127004641.1118269-1-houtao@huaweicloud.com>
 <20241127004641.1118269-8-houtao@huaweicloud.com> <87frnai67q.fsf@toke.dk>
 <CAADnVQLD+m_L-K0GiFsZ3SO94o3vvdi6dT3cWM=HPuTQ2_AUAQ@mail.gmail.com>
 <fede4cf9-60df-ce3a-9290-18d371622d3b@huaweicloud.com>
 <878qsua2b5.fsf@toke.dk>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <23c8dc9b-4a4d-0fa1-8362-770ffd6aea35@huaweicloud.com>
Date: Sun, 15 Dec 2024 17:37:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <878qsua2b5.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgB3U8BHo15n9SoZEg--.3526S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15ZF4fCF4xKF4fCr4kWFg_yoW8Zr17pF
	W8t3WYqF4DJr1rAwnFy3ykuryjyw1xKw129F1rJryxur90qryfGr1vvr4Y9an5Xr4IkF43
	X340qa4xZw1rAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU0s2-5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/5/2024 5:47 PM, Toke Høiland-Jørgensen wrote:
> Hou Tao <houtao@huaweicloud.com> writes:
>
>> Hi,
>>
>> On 12/3/2024 9:42 AM, Alexei Starovoitov wrote:
>>> On Fri, Nov 29, 2024 at 4:18 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>> Hou Tao <houtao@huaweicloud.com> writes:
>>>>
>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>
>>>>> After switching from kmalloc() to the bpf memory allocator, there will be
>>>>> no blocking operation during the update of LPM trie. Therefore, change
>>>>> trie->lock from spinlock_t to raw_spinlock_t to make LPM trie usable in
>>>>> atomic context, even on RT kernels.
>>>>>
>>>>> The max value of prefixlen is 2048. Therefore, update or deletion
>>>>> operations will find the target after at most 2048 comparisons.
>>>>> Constructing a test case which updates an element after 2048 comparisons
>>>>> under a 8 CPU VM, and the average time and the maximal time for such
>>>>> update operation is about 210us and 900us.
>>>> That is... quite a long time? I'm not sure we have any guidance on what
>>>> the maximum acceptable time is (perhaps the RT folks can weigh in
>>>> here?), but stalling for almost a millisecond seems long.
>>>>
>>>> Especially doing this unconditionally seems a bit risky; this means that
>>>> even a networking program using the lpm map in the data path can stall
>>>> the system for that long, even if it would have been perfectly happy to
>>>> be preempted.
>>> I don't share this concern.
>>> 2048 comparisons is an extreme case.
>>> I'm sure there are a million other ways to stall bpf prog for that long.
>> 2048 is indeed an extreme case. I would do some test to check how much
>> time is used for the normal cases with prefixlen=32 or prefixlen=128.
> That would be awesome, thanks!

Sorry for the long delay. After apply patch set v3, the avg and max time
for prefixlen = 32 and prefix =128 is about 2.3/4, 7.7/11 us respectively.
>
> -Toke
>
>
> .


