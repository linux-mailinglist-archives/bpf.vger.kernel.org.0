Return-Path: <bpf+bounces-12887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2234E7D1A43
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 03:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63B7B215AC
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 01:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3635965B;
	Sat, 21 Oct 2023 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D187EA
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 01:20:39 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62266D67
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 18:20:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SC3Y80dffz4f3jM6
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 09:20:28 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDnbK1dJzNl6CFZDQ--.60283S2;
	Sat, 21 Oct 2023 09:20:33 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 2/7] mm/percpu.c: introduce pcpu_alloc_size()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Dennis Zhou <dennis@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20231020133202.4043247-1-houtao@huaweicloud.com>
 <20231020133202.4043247-3-houtao@huaweicloud.com> <ZTK9a4H2iuJrJG+x@snowbird>
 <CAADnVQKREaN65cNMJ0qajjA9=46JWHyK9jdGFKcQ=RwjAMuQKQ@mail.gmail.com>
 <ZTLA87JYVRLHn/zk@snowbird>
 <CAADnVQJiDfTgE_pEirDf2z0cc93pyWQnNCWnmOp=uks=6FViAg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <12196815-c2ed-b5cb-4bda-bee794d8d082@huaweicloud.com>
Date: Sat, 21 Oct 2023 09:20:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJiDfTgE_pEirDf2z0cc93pyWQnNCWnmOp=uks=6FViAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDnbK1dJzNl6CFZDQ--.60283S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1UtF1rWr1DJr1Utry3twb_yoW8Xr18pF
	1Yqayqyr4qk398C3Z2va1xCw1YvaySvr1fu3yYqrnavF9Ivrn2qr4DC3y3uFy3Jrn3Cw1j
	vrWqqF9rA34DZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

Hi,

On 10/21/2023 5:17 AM, Alexei Starovoitov wrote:
> On Fri, Oct 20, 2023 at 11:03 AM Dennis Zhou <dennis@kernel.org> wrote:
>> On Fri, Oct 20, 2023 at 10:58:37AM -0700, Alexei Starovoitov wrote:
>>> On Fri, Oct 20, 2023 at 10:48 AM Dennis Zhou <dennis@kernel.org> wrote:
>>>> On Fri, Oct 20, 2023 at 09:31:57PM +0800, Hou Tao wrote:
>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>

SNIP
>>>>> + *
>>>>> + * Returns the size of the @ptr allocation. This is undefined for statically
>>>>                                               ^
>>>>
>>>> Nit: Alexei, when you pull this, can you make it a double space here?
>>>> Just keeps percpu's file consistent.
>>> Argh. Already applied.
>>> That's a very weird style you have in a few places.
>>> $ grep '\.  [A-z]' mm/*.c|wc -l
>>> 1118
>>> $ grep '\. [A-z]' mm/*.c|wc -l
>>> 2451
>>>
>>> Single space is used more often in mm/* and in the rest of the kernel.
>>>
>>> $ grep '\. [A-z]' mm/percpu.c|wc -l
>>> 10
>>>
>>> percpu.c isn't consistent either.
>>>
>>> I can force push if you really insist.
>> Eh, if it's trouble I can fix it in the future. I know single space is
>> more common, but percpu was written with double so I'm trying my best to
>> keep the file consistent.
> Ok. Fair enough.
> Force pushed with double space.

Thanks for the fixes. When I copied the sentence from the email, there
was indeed double spaces in it, but I simply ignored and "fixed" it, and
I also didn't double check the used style in mm/percpu.c. Will be more
carefully next time.


