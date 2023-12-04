Return-Path: <bpf+bounces-16563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAAF802DAC
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 09:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491FD280ED6
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 08:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7AB101DA;
	Mon,  4 Dec 2023 08:57:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A82D1729
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 00:57:13 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SkHbj0x7yz4f3nTy
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 16:57:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C278B1A0F58
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 16:57:09 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAXc0NjlG1lvfkjCw--.16482S2;
	Mon, 04 Dec 2023 16:57:09 +0800 (CST)
Subject: Re: [PATCH bpf v4 5/7] bpf: Optimize the free of inner map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
References: <20231130140120.1736235-1-houtao@huaweicloud.com>
 <20231130140120.1736235-6-houtao@huaweicloud.com>
 <20231203185444.l3bip4fwfbqqn5oz@macbook-pro-49.dhcp.thefacebook.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <c5f74764-dad0-8d0a-9db7-8562b5b9bdd9@huaweicloud.com>
Date: Mon, 4 Dec 2023 16:57:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231203185444.l3bip4fwfbqqn5oz@macbook-pro-49.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAXc0NjlG1lvfkjCw--.16482S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3ZF1fAF4Uur48tw4fZrb_yoW8GFyxpF
	WUK3W8KrsrXr4vg3srJw1xZa45J398J34rJa4rGrWrX3y3Z340gF17GayjkF9xWr4kJFWj
	v395Z345C3sxZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/4/2023 2:54 AM, Alexei Starovoitov wrote:
> On Thu, Nov 30, 2023 at 10:01:18PM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When removing the inner map from the outer map, the inner map will be
>> freed after one RCU grace period and one RCU tasks trace grace
>> period, so it is certain that the bpf program, which may access the
>> inner map, has exited before the inner map is freed.
>>
>> However there is no need to wait for one RCU tasks trace grace period if
>> the outer map is only accessed by non-sleepable program. So adding
>> sleepable_refcnt in bpf_map and increasing sleepable_refcnt when adding
>> the outer map into env->used_maps for sleepable program. Considering the
>> max number of bpf program is INT_MAX - 1, atomic_t instead of atomic64_t
>> is used for sleepable_refcnt. When removing the inner map from the outer
>> map, using sleepable_refcnt to decide whether or not a RCU tasks trace
>> grace period is needed before freeing the inner map.
> Optimizing too soon as usual?
> I bet you saw that we use:
>  atomic64_t refcnt
> for bpf_map, but you probably didn't dig into git history and
> missed commit 92117d8443bc ("bpf: fix refcnt overflow") ?

Yes. I didn't think it thoroughly. Although the max number of bpf
program INT_MAX - 1, but the allocation of id happens after the increase
of sleepable_refcnt, so the overflow is still possible. Will fix it in v5.


