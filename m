Return-Path: <bpf+bounces-49312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73776A1757B
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3401A7A3CC7
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A360219E0;
	Tue, 21 Jan 2025 01:15:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E222581
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422133; cv=none; b=d+jS1qOeYAqhGtE+B7IpBIme4MdbIQHg7HZq+KOxaD6zSKdxtP8uEgG1Eks8CsuS645Mp9qzj8SLh6oOKI53owpZ/jrhjsXAh319IiODkuMWitbmHB5CsCdcJbaEgHp5FncuQYxtskL4pc5r+zKHOYEz6ABxmp1yxUO+JewVy2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422133; c=relaxed/simple;
	bh=G5USHZnBaF7dAfxxpZ9pLAneAQr2fEy0todZimyjIRU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fMGoXi7pe8oBXdUctsXPhUJAIJ41U+uNW1W7xZxgvovgUyHSCFp97hmWQXeFsmQeA4gHpon+XUQmoJgwoCDo2ZPMJRo/GxKJScvcE66lVSh9p+ER5D4Gz4zMMeWEQChMu4MRuL45y1l1lq5QuBXe292pLV3LS/AVVDOzznk1gfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YcTlY4Hwmz4f3l2T
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 09:15:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2FE231A1384
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 09:15:26 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgBXuV0o9Y5nOX8mBg--.8352S2;
	Tue, 21 Jan 2025 09:15:24 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Free element after unlock in
 __htab_map_lookup_and_delete_elem()
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
 bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, houtao1@huawei.com,
 xukuohai@huawei.com
References: <20250117101816.2101857-1-houtao@huaweicloud.com>
 <20250117101816.2101857-4-houtao@huaweicloud.com> <87o705oby2.fsf@toke.dk>
 <96a1e15a-52d8-acee-aee8-f494f009d2d7@huaweicloud.com>
 <87v7u9n9yj.fsf@toke.dk>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <cc432722-41e7-22a1-cb31-706e24164f5d@huaweicloud.com>
Date: Tue, 21 Jan 2025 09:15:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87v7u9n9yj.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgBXuV0o9Y5nOX8mBg--.8352S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr18uFy5JFy8Jw13tFW8JFb_yoW8Xry7p3
	48K3WSkrs7Kr10vwnrt3W8WFW0yw13Gr13Wrn8Gw1rAFn0qFySgFWIvFW5u3W5AFn3C3Zr
	Xa1jy3sxtryUuwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/20/2025 4:52 PM, Toke Høiland-Jørgensen wrote:
> Hou Tao <houtao@huaweicloud.com> writes:
>
>> Hi,
>>
>> On 1/17/2025 8:35 PM, Toke Høiland-Jørgensen wrote:
>>> Hou Tao <houtao@huaweicloud.com> writes:
>>>
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> The freeing of special fields in map value may acquire a spin-lock
>>>> (e.g., the freeing of bpf_timer), however, the lookup_and_delete_elem
>>>> procedure has already held a raw-spin-lock, which violates the lockdep
>>>> rule.
>>> This implies that we're fixing a locking violation here? Does this need
>>> a Fixes tag?
>>>
>>> -Toke
>> Ah, the fix tag is a bit hard. The lockdep violation in the patch is
>> also related with PREEMPT_RT, however, the lookup_and_delete_elem is
>> introduced in v5.14. Also considering that patch #4 will also fix the
>> lockdep violation in the case, I prefer to not add a fix tag in the
>> patch. Instead I will update the commit message for the patch to state
>> that it will reduce the lock scope of bucket lock. What do you think ?
> Sure; and maybe put the same explanation for why there's no Fixes tag
> into the commit message as well? :)

I have rewritten the commit message for the patch and it is ready for
resend. However it seems Alexei has already merged this patch set [1],
therefore, I will keep it as is.

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=d10cafc5d54a0f70681ab2f739ea6c46282c86f9
>
> -Toke
>
> .


