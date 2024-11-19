Return-Path: <bpf+bounces-45132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7069D1CF8
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 02:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C5D2834C6
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 01:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D7413777F;
	Tue, 19 Nov 2024 01:09:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81E2AD2C
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978580; cv=none; b=lcKbi+peVcTkq3rEjG4G3KuJVLJNxswWUtGVNmFBt3puHlMEJRzigNzxFCXtR90/pgyg2Hm0fxOaATcj4BMMXbUMfmOu/88pC6JLiW1MuaAFTvUt6q8XeBISWRAqWSQpOvcuWLxzI2bLOXSsXmyvWBO2mi3ZEhnvbhGXEDItwI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978580; c=relaxed/simple;
	bh=/e/1Zsj1pTS26onJakG6lAjNk9PkUOzpixw3SYTNYtI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XQ48rfJu4smqEP8ESwNXrO6cGP9i5rIQ3qH9hJnarCjtYfcJh40VZUIGE+fqRBc1lYdnTlpgRzshVrzMJJ2YCNa/yYxJtHpLS4GBRP21EAemraGk/CQ1Hgm+xD2rd0P3puqyTtFXqDFG7GTjRvpHzhVsd0lTs7mQSBNiwS2e7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xsmbt37fcz4f3lVL
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 09:09:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C89601A058E
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 09:09:33 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgC3ScZJ5TtnoOl+CA--.48319S2;
	Tue, 19 Nov 2024 09:09:32 +0800 (CST)
Subject: Re: [PATCH bpf-next 00/10] Fixes for LPM trie
To: Daniel Xu <dlxu@meta.com>, "bot+bpf-ci@kernel.org" <bot+bpf-ci@kernel.org>
Cc: kernel-ci <kernel-ci@meta.com>, "andrii@kernel.org" <andrii@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <46268aa9ef13a24388af833b17f6cef8bdd3a7be8402fec7640e65a2f1118468@mail.kernel.org>
 <fd947bab-1445-4d43-ce7e-ed53697d466a@huaweicloud.com>
 <f17d65e4-9f41-4d67-a7e7-1eac4d98ca7b@meta.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <034c0709-b783-8b74-4342-bd558da3cefa@huaweicloud.com>
Date: Tue, 19 Nov 2024 09:09:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f17d65e4-9f41-4d67-a7e7-1eac4d98ca7b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgC3ScZJ5TtnoOl+CA--.48319S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr4xtw1DWryxGr17Cw1rZwb_yoWktFgEkw
	sruFykGFn8J3WSkFnrXw4rJFn293y8ZF15Kr4DtrW7ZwnYv34DXr48GF93ZF98Xan3Xrya
	9wn3ZanxKrsrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFB
	T5DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/19/2024 1:43 AM, Daniel Xu wrote:
> Hi Hou,
>
> On 11/17/24 22:20, Hou Tao wrote:
>> Hi,
>>
>> On 11/18/2024 9:42 AM, bot+bpf-ci@kernel.org wrote:
>>> Dear patch submitter,
>>>
>>> CI has tested the following submission:
>>> Status:     SUCCESS
>>> Name:       [bpf-next,00/10] Fixes for LPM trie
>>> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=910440&state=*
>>> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/11884065937
>>>
>>> No further action is necessary on your part.
>>>
>>>
>>> Please note: this email is coming from an unmonitored mailbox. If you have
>>> questions or feedback, please reach out to the Meta Kernel CI team at
>>> kernel-ci@meta.com.
>> I am curious about the reason on why test_maps on s390 is disabled. If I
>> remember correctly, test_maps on s390 was still enabled last year [1].
>>
>> [1]: https://github.com/kernel-patches/bpf/actions/runs/7164372250
>>
> It was disabled in 
> https://github.com/kernel-patches/vmtest/commit/5489ef2bc1fed11e841d2d3485ab80ce4b390d94 
> .
>
> I recall it was kinda flakey and low signal.

I see. Thanks for the information.
>
> Thanks,
>
> Daniel
>


