Return-Path: <bpf+bounces-50603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7F8A29F94
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 05:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71ADF7A2D7C
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 04:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B6D156C74;
	Thu,  6 Feb 2025 04:17:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E142AB4
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738815467; cv=none; b=hUp7/KQ9EcPJPAq4PjswIOcb7gc2sYMiVhCPb2+ddNK9upOZrfP0jyVJKNz1BPEsFP8mFxjA5/e0Q3IDDFpQ2+cQ0PMsmo1Z5Q+dhPjuQ0AnMsc3rzHIzg6qhb0lxdUaw5ajarbmMgGpMrfYZ391H3IqxvfVDrRQi8KpgNjIFuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738815467; c=relaxed/simple;
	bh=vIZcM2Fr4S3aLwemT/o229hsIWf7yIgvNbtSqm/foz4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hV6c1XePZ181LxvWNzFpI7z+cYXozxMYKyV6TOunucCPQ6hT6mai0PcT9NkO7m1zD0kM/DXH04cW0pTrWyPL2kjfQl8D7LQ3FQKXa0//1/Yneuh7d3WPBTdHwQJAB/7SnI1KAvAqDdv6/LtG247UZ58fnDix89x/JvFD4JUAXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YpP2X1Zw4z4f3jq4
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 12:17:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 1A0FD1A06D7
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 12:17:40 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgCn+MLgN6Rnb7UADA--.55769S2;
	Thu, 06 Feb 2025 12:17:40 +0800 (CST)
Subject: Re: handling EINTR from bpf_map_lookup_batch
To: Yan Zhai <yan@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
References: <Z6JXtA1M5jAZx8xD@debian.debian>
 <d8893a20-4211-2fd6-e9d1-b65e81367950@huaweicloud.com>
 <CAADnVQLNSUOz7kSwMr0dfgT1gk02S1wNgJOhk-5h_d01AM2RbA@mail.gmail.com>
 <CAO3-Pbqbj_pi3BrA7h3qtRsrcm_wJVLnJwyKwuuNLYg==_QvRA@mail.gmail.com>
 <3d906727-1872-ca7e-759c-65c16b0f339f@huaweicloud.com>
 <CAO3-PbrNgZ-SDSCwNfKqeLK_ZSiq2zCXBQq7dM+PawRY9=xA_A@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <50dacbd0-48e9-c51c-634b-27f6c5fff439@huaweicloud.com>
Date: Thu, 6 Feb 2025 12:17:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAO3-PbrNgZ-SDSCwNfKqeLK_ZSiq2zCXBQq7dM+PawRY9=xA_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgCn+MLgN6Rnb7UADA--.55769S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFykZw48AryfArWxtFyxZrb_yoW8AFy7pr
	WrWa9rtw4DAF42ywnxtw109a4jyr17tF1UtwnxK3sruFyDur9xZF4xKa1Y9Fy5Jr1vqr1Y
	qFWrXa9aga4UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/6/2025 11:01 AM, Yan Zhai wrote:
> On Wed, Feb 5, 2025 at 6:46 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> On 2/6/2025 12:27 AM, Yan Zhai wrote:
>>> On Wed, Feb 5, 2025 at 3:56 AM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>> Let's not invent new magic return values.
>>>>
>>>> But stepping back... why do we have this EINTR case at all?
>>>> Can we always goto next_key for all map types?
>>>> The command returns and a set of (key, value) pairs.
>>>> It's always better to skip then get stuck in EINTR,
>>>> since EINTR implies that the user space should retry and it
>>>> might be successful next time.
>>>> While here it's not the case.
>>>> I don't see any selftests for EINTR, so I suspect it was added
>>>> as escape path in case retry count exceeds 3 and author assumed
>>>> that it should never happen in practice, so EINTR was expected
>>>> to be 'never happens'. Clearly that's not the case.
>>> It makes more sense to me if we just goto the next key for all types.
>>> At least for current users of generic batch lookup, arrays and
>>> lpm_trie, I didn't notice in any case retry would help.
>> I think it will break lpm_trie. In lpm_trie, if tries to find the next
>> key of a non-existent key, it will restart from the left-mode node.
> I am not sure how lpm trie would break if we always skip to the next
> key. Current retry logic does not change prev_key, so the lookup key
> will always be the same. It would make sense if searching with the
> same key could temporarily fail, but it does not seem so for both
> lpm_tire and array based maps.

Retry logic does change prev_key, please see "swap(prev_key, key);"
below the next_key tag, otherwise the lookup_batch procedure will loop
forever for array map.
>
> Yan
>
>>> best
>>> Yan
> .


