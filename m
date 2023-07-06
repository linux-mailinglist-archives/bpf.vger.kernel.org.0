Return-Path: <bpf+bounces-4237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F09749BC1
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395222812BE
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BE18C11;
	Thu,  6 Jul 2023 12:30:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3C8F64
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 12:30:40 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9AE1BD9
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 05:30:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QxbTk2hQSz4f3v55
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 20:30:34 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgA3yDLos6ZkDBl9Mg--.45876S2;
	Thu, 06 Jul 2023 20:30:35 +0800 (CST)
Subject: Re: [v3 PATCH bpf-next 3/6] bpf: populate the per-cpu
 insertions/deletions counters for hashmaps
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
References: <20230630082516.16286-1-aspsk@isovalent.com>
 <20230630082516.16286-4-aspsk@isovalent.com>
 <05a3c521-3c6f-79c2-a5a8-1f8ab35eb759@huaweicloud.com>
 <ZKQt84Qz0A0ZkgN1@zh-lab-node-5>
 <b1b9e2b8-f31e-abf5-8853-cb64bb0232a6@huaweicloud.com>
 <ZKayoTYomkVc/i3r@zh-lab-node-5>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <522a607a-0a34-e584-7e21-86221fbd6c1a@huaweicloud.com>
Date: Thu, 6 Jul 2023 20:30:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZKayoTYomkVc/i3r@zh-lab-node-5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgA3yDLos6ZkDBl9Mg--.45876S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWkCw48ArW3AFW5tF4fZrb_yoW8JFWkpr
	WktF13GF4vqas3KwnrJ3WrJrn0yw4kCFyrK3s5CrWjv3Z3WrnIkay0qa1Y9F97G34fG3Wj
	vFZ0qryxCas093JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrcTmDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/6/2023 8:25 PM, Anton Protopopov wrote:
> On Thu, Jul 06, 2023 at 10:01:26AM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 7/4/2023 10:34 PM, Anton Protopopov wrote:
>>> On Tue, Jul 04, 2023 at 09:56:36PM +0800, Hou Tao wrote:
SNIP
>>>> by introducing a new map flag ?
>>> Per-map-flag or a static key? For me it looked like just doing an unconditional
>>> `inc` for a per-cpu variable is better vs. doing a check then `inc` or an
>>> unconditional jump.
>> Sorry I didn't make it clear that I was worried about the allocated
>> per-cpu memory. Previous I thought the per-cpu memory is limited, but
>> after did some experiments I found it was almost the same as kmalloc()
>> which could use all available memory to fulfill the allocation request.
>> For a host with 72-cpus, the memory overhead for 10k hash map is about
>> ~6MB. The overhead is tiny compared with the total available memory, but
>> it is avoidable.
> So, in my first patch I've only added new counters for preallocated maps. But
> then the feedback was that we need a generic percpu inc/dec counters, so I
> added them by default. For me a percpu s64 looks cheap enough for a hash map...

Thanks for the explanation. Let's just allocate the per-cpu elem_count
in hash map. If there are use cases which need to make it optional, we
can revise that later.
> .


