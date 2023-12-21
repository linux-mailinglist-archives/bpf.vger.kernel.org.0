Return-Path: <bpf+bounces-18520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722F881B500
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 12:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CF81C24214
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 11:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E306BB5F;
	Thu, 21 Dec 2023 11:37:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EDF4F60D
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SwpLP354Fz4f3lDS
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 19:37:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A81F01A0362
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 19:37:06 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgCX+rhfI4RlaxqyEA--.26156S2;
	Thu, 21 Dec 2023 19:37:06 +0800 (CST)
Subject: Re: [PATCH bpf-next 2/3] bpf, x86: Don't generate lock prefix for
 BPF_XCHG
To: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Hou Tao <houtao1@huawei.com>
References: <20231219135615.2656572-1-houtao@huaweicloud.com>
 <20231219135615.2656572-3-houtao@huaweicloud.com>
 <7f682450-e165-26a9-1247-ef1440d9b7a2@iogearbox.net>
 <CAADnVQKZAsLhZEd8E4_jODJq=V+DexcVCrmifvYNaFwpcbXLgw@mail.gmail.com>
 <1b1c23b6-467e-d645-cbcb-0c51db2203a1@iogearbox.net>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <0afcb79f-d7b7-5c2a-f2d0-ae0e67f3441c@huaweicloud.com>
Date: Thu, 21 Dec 2023 19:37:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1b1c23b6-467e-d645-cbcb-0c51db2203a1@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgCX+rhfI4RlaxqyEA--.26156S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1fuw4UZrWrXF17Ww45KFg_yoW8XF15pF
	W7Gas8tF4DJr4kCwn2g3yxZ3WUtw4rGr45CrZYq392ka4qgr90ga4UtFWa9asxJrn5Cw12
	vFWjq34xXa45ZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbPEf5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/21/2023 2:46 AM, Daniel Borkmann wrote:
> On 12/20/23 7:25 PM, Alexei Starovoitov wrote:
>> On Wed, Dec 20, 2023 at 6:58 AM Daniel Borkmann
>> <daniel@iogearbox.net> wrote:
>>>
>>> On 12/19/23 2:56 PM, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> According to the implementation of atomic_xchg() under x86-64, the
>>>> lock
>>>> prefix is not necessary for BPF_XCHG atomic operation, so just remove
>>>> it.
>>>
>>> It's probably a good idea for the commit message to explicitly quote
>>> the
>>> Intel docs in here, so it's easier to find on why the lock prefix would
>>> not be needed for the xchg op.
>>
>> It's a surprise to me as well.
>> Definitely more info would be good.
>>
>> Also if xchg insn without lock somehow implies lock in the HW
>> what is the harm of adding it explicitly?
>> If it's a lock in HW than performance with and without lock prefix
>> should be the same, right?
>
> e.g. 7.3.1.2 Exchange Instructions says:
>
>   The XCHG (exchange) instruction swaps the contents of two operands.
> This
>   instruction takes the place of three MOV instructions and does not
> require
>   a temporary location to save the contents of one operand location while
>   the other is being loaded. When a memory operand is used with the XCHG
>   instruction, the processor’s LOCK signal is automatically asserted.
>
> Also curious if there is any harm adding it explicitly.
>
> .

I could use the bpf ma benchmark to test it, but I doubt it will make
any visible difference.


