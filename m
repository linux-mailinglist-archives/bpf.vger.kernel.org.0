Return-Path: <bpf+bounces-50847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2C1A2D441
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 07:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B2397A502D
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 06:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA0D1A2543;
	Sat,  8 Feb 2025 06:22:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D54437A
	for <bpf@vger.kernel.org>; Sat,  8 Feb 2025 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738995778; cv=none; b=RkmaOKaYrYIQqwl2aCcvpVv+ve9fzvFsG9h9HzWRyCA+hPTwH7mUtkmdwo3BadWLKVCON2gFae7saesCNXf4yp4ve86Js/WNm/MPAAp476/scb4F7gSiNAW5G03+w6BK9LiI2GbfuUQ+tkZH5td5eWbeCeeUlkVHJHsOQEhDWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738995778; c=relaxed/simple;
	bh=CFPMSQ/xK4hza2UlSvoE86VYMRSuM65bg3bZnqD7H/A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jM8lEHMOJz5wRGce84WEtNR0HjYSWPynxim9uFreP+KUVCId1B7r5ipbiyO7PKm3UbjwMoRilmP67u21is4rtzm5pEuSFjsPxdhcUu4GSrB6IBFbYJJD0JPh7KiyNmWZFeQrmBFwOXbSqlOPM4fRUiGDA/y+tO0SRJjccDWlT/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Yqgjq2Sf5z4f3jLp
	for <bpf@vger.kernel.org>; Sat,  8 Feb 2025 14:22:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E3BCA1A138E
	for <bpf@vger.kernel.org>; Sat,  8 Feb 2025 14:22:45 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBXqcMw+KZnTXnGDA--.40243S2;
	Sat, 08 Feb 2025 14:22:43 +0800 (CST)
Subject: Re: Poor performance of bpf_map_update_elem() for
 BPF_MAP_TYPE_HASH_OF_MAPS / BPF_MAP_TYPE_ARRAY_OF_MAPS
To: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>, bpf@vger.kernel.org
Cc: Jelle van der Beek <jelle@superluminal.eu>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <CAH6OuBR=w2kybK6u7aH_35B=Bo1PCukeMZefR=7V4Z2tJNK--Q@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <db6b3fb9-bcb7-7670-6cb2-1ef5406e81c4@huaweicloud.com>
Date: Sat, 8 Feb 2025 14:22:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAH6OuBR=w2kybK6u7aH_35B=Bo1PCukeMZefR=7V4Z2tJNK--Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBXqcMw+KZnTXnGDA--.40243S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWxXryUJr4fCF47ZFy5Arb_yoW5tw48pF
	Z5K34UKFnFgr4ayr4av3yfXw40qrs5Gry3Zwn5GrW5ZrZ0kFn7ur1I9a15ZF90vrsxGa10
	qryIvr97Cr1rA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/5/2025 8:58 PM, Ritesh Oedayrajsingh Varma wrote:
> Hi,
>
> We are in a situation where we're frequently updating a
> BPF_MAP_TYPE_HASH_OF_MAPS with new data for a given key via
> bpf_map_update_elem(). During profiling, we've noticed that
> bpf_map_update_elem() on such maps is _very_ expensive. In our tests,
> the average time is ~9ms per call, with spikes to ~45ms per call:
>
> Function Name:   bpf_map_update_elem
> Number of calls:  1213
> Total time:            11s 880ms 994µs
> Maximum:            45ms 431µs
> Top Quartile:        11ms 660µs
> Average:              9ms 794µs
> Median:                9ms 218µs
> Bottom Quartile:   7ms 363µs
> Minimum:             23µs
>
> The cause of this poor performance is the wait for the RCU grace
> period when map_update_elem() is called: after the update has
> completed without errors, it calls maybe_wait_bpf_programs() which in
> turn calls synchronize_rcu() for BPF_MAP_TYPE_HASH_OF_MAPS (and
> BPF_MAP_TYPE_ARRAY_OF_MAPS).
>
> As I understand from the commit that introduced this [1], the RCU GP
> wait was added to ensure that user space could be guaranteed that
> after the update, no BPF programs are still looking at the old value
> of the map [2]. When this commit was introduced, the RCU GP wait also
> covered a potential UAF when updating the outer map while a BPF
> program was still looking at the old inner map. That UAF was (much)
> later addressed by a different patchset [3] and the discussion in that
> patchset [4] mentions that maybe_wait_bpf_programs() is not needed
> anymore with the UAF fixes:
>
>> So, you're correct, maybe_wait_bpf_programs() is not sufficient any more,
>> but we cannot delete it, since it addresses user space assumptions
>> on what bpf progs see when the inner map is replaced.
> Given this, while it's not possible to remove the wait entirely
> without breaking user space, I was wondering if it would be
> possible/acceptable to add a way to opt-out of this behavior for
> programs like ours that don't care about this. One way to do so could
> be to add an additional flag to the BPF_MAP_CREATE flags, perhaps
> something like BPF_F_INNER_MAP_NO_SYNC. There are already map-specific
> flags in there (for example, BPF_F_NO_COMMON_LRU or
> BPF_F_STACK_BUILD_ID), so it would fit with that pattern;
> maybe_wait_bpf_programs() could then check the map flags and only
> perform the wait if the flag is not set (which is the default).
>
> In our case, we don't care if running BPF programs are still working
> with the old map, but for the thousands of bpf_map_update_elem() calls
> we're doing in certain situations, we're spending _seconds_ waiting on
> the RCU GP, so adding something like this would greatly improve the
> latency in our scenarios.
>
> If this sounds like something that would be acceptable, I'd be happy
> to make the change and send a patch, of course. Any thoughts on this
> are appreciated!

If the time used for synchronize_rcu() is too long, maybe we could
switch to synchronize_rcu_expedited() instead. Could you please check
the average map update time for synchronize_rcu_expedited() ?
>
> [1] commit 1ae80cf31938 ("bpf: wait for running BPF programs when
> updating map-in-map")
> [2] https://lore.kernel.org/lkml/20181111221706.032923266@linuxfoundation.org/
> [3] https://lore.kernel.org/bpf/20231113123324.3914612-1-houtao@huaweicloud.com/
> [4] https://lore.kernel.org/bpf/CAADnVQK=tJRhQY1zfLK2n7_tPA5+vN8+KqWmSLqjubUuh6UFAw@mail.gmail.com/
>
> Cheers,
> Ritesh
>
>
> .


