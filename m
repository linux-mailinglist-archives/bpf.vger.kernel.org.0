Return-Path: <bpf+bounces-17362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A08C80BF8A
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 04:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81801C20895
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 03:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B6515AF8;
	Mon, 11 Dec 2023 03:03:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B2BDA
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 19:03:11 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpRQ24y91z4f3jqh
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 11:03:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D710A1A0366
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 11:03:07 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgC3uQ_qe3Zlc55GDQ--.7189S2;
	Mon, 11 Dec 2023 11:03:07 +0800 (CST)
Subject: Re: [PATCH bpf-next 7/7] bpf: Wait for sleepable BPF program in
 maybe_wait_bpf_programs()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20231208102355.2628918-1-houtao@huaweicloud.com>
 <20231208102355.2628918-8-houtao@huaweicloud.com>
 <CAADnVQKZfvDQUuzJ98n5Q6a1xU5XBxFGi0PeEnmRxj_TFKoW1A@mail.gmail.com>
 <bcaeae84-766c-5e3c-d444-70015ada7765@huaweicloud.com>
 <CAADnVQKev7805QuyZA1yq_N3Ljg+X5vZqscRpCSHS2NV3AdMgw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3af83be7-8370-c0e6-3915-ffb443ea9907@huaweicloud.com>
Date: Mon, 11 Dec 2023 11:03:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQKev7805QuyZA1yq_N3Ljg+X5vZqscRpCSHS2NV3AdMgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgC3uQ_qe3Zlc55GDQ--.7189S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GF4xGw4DGF1kWr4DAFW8Zwb_yoW8JrWDpF
	9Y9a4DKr4qyrs09Fn2vr48X348Wr4SgrW7trs5Kr4FvF15uF95KrWxKFs8uFnYyw4xt342
	qrWUZ3Z5CF1Yv37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/11/2023 10:56 AM, Alexei Starovoitov wrote:
> On Sun, Dec 10, 2023 at 6:07 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi Alexei,
>>
>> On 12/10/2023 10:11 AM, Alexei Starovoitov wrote:
>>> On Fri, Dec 8, 2023 at 2:22 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> +       /* Wait for any running non-sleepable and sleepable BPF programs to
>>>> +        * complete, so that userspace, when we return to it, knows that all
>>>> +        * programs that could be running use the new map value.
>>> which could be forever... and the user space task doing simple map update
>>> will never know why it got stuck in syscall waiting... forever...
>>> synchronous waiting for tasks_trace is never an option.
>> Could you please elaborate the reason why there is dead-lock problem ?
>> In my naive understanding, synchronize_rcu_tasks_trace() only waits for
>> the end of rcu_read_lock_trace()/rcu_read_unlock_trace(), if there is no
>> rcu_read_lock_trace being held, there will be no dead-lock.
> I didn't say it's dead-lock. rcu_read_lock_trace() section can last
> for a very long time. The user space shouldn't be exposed to such delays.

I see. Thanks for the explanation. Will update the comments in
maybe_wait_bpf_programs() in a new patch.
> .


