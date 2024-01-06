Return-Path: <bpf+bounces-19158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E57A825DEE
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 03:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13F21F2459A
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 02:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE49136F;
	Sat,  6 Jan 2024 02:34:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28F15AB
	for <bpf@vger.kernel.org>; Sat,  6 Jan 2024 02:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T6PYB5Sbyz4f3pC2
	for <bpf@vger.kernel.org>; Sat,  6 Jan 2024 10:34:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 93B191A01CA
	for <bpf@vger.kernel.org>; Sat,  6 Jan 2024 10:34:40 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgA3RkY9vJhlFfwaFw--.58489S2;
	Sat, 06 Jan 2024 10:34:40 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 0/3] bpf: inline bpf_kptr_xchg()
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>, houtao1@huawei.com
References: <20240105104819.3916743-1-houtao@huaweicloud.com>
 <CAPhsuW6EFyr-CrsOfsJBgCJzygV7-v52aKvLJgTBzMdoVm8pSw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <95ea0a85-2c3b-33da-d5f0-27089171ce2d@huaweicloud.com>
Date: Sat, 6 Jan 2024 10:34:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6EFyr-CrsOfsJBgCJzygV7-v52aKvLJgTBzMdoVm8pSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgA3RkY9vJhlFfwaFw--.58489S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWDXw4Dtry8Cw1kWr17Wrg_yoW8Ww4DpF
	WrGryUtrZrGF98A3WDX3y3Xa4fA393u345WrnIy3yDA3W5Xr9rWF95t3s09F98uF4Ika4j
	ya17Zr9xW3WFyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 1/6/2024 6:53 AM, Song Liu wrote:
> On Fri, Jan 5, 2024 at 2:47 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Hi,
>>
>> The motivation of inlining bpf_kptr_xchg() comes from the performance
>> profiling of bpf memory allocator benchmark [1]. The benchmark uses
>> bpf_kptr_xchg() to stash the allocated objects and to pop the stashed
>> objects for free. After inling bpf_kptr_xchg(), the performance for
>> object free on 8-CPUs VM increases about 2%~10%. However the performance
>> gain comes with costs: both the kasan and kcsan checks on the pointer
>> will be unavailable. Initially the inline is implemented in do_jit() for
>> x86-64 directly, but I think it will more portable to implement the
>> inline in verifier.
> How much work would it take to enable this on other major architectures?
> AFAICT, most jit compilers already handle BPF_XCHG, so it should be
> relatively simple?

Yes. I think enabling this inline will be relatively simple. As said in
patch #1, the inline depends on two conditions:
1) atomic_xchg() support on pointer-sized word.
2)  the implementation of xchg is the same as atomic_xchg() on
pointer-sized words.
For condition 1), I think most major architecture JIT backends have
support it. So the following work is to check the implementation of xchg
and atomic_xchg(), to enable the inline and to do more test.

I will try to enable the inline on arm64 first. And will x86-64 + arm64
be enough for the definition of "major architectures" ? Or Should it
include riscv, s380, powerpc as well ?

> Other than this, for the set
>
> Acked-by: Song Liu <song@kernel.org>

Thanks for the ack.
>
> Thanks,
> Song
> .


