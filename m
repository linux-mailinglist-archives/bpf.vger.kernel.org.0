Return-Path: <bpf+bounces-18519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE37081B4FA
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 12:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD941F245D9
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AD16D1A4;
	Thu, 21 Dec 2023 11:33:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA356BB32
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SwpFc205Bz4f3jLr
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 19:32:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A8B491A0899
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 19:32:53 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgB3jrxfIoRlsNaxEA--.54563S2;
	Thu, 21 Dec 2023 19:32:51 +0800 (CST)
Subject: Re: [PATCH bpf-next 0/3] bpf: inline bpf_kptr_xchg()
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231219135615.2656572-1-houtao@huaweicloud.com>
 <42d42854-61d4-5379-908a-04892765f85c@iogearbox.net>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <95b8c2cd-44d5-5fe1-60b5-7e8218779566@huaweicloud.com>
Date: Thu, 21 Dec 2023 19:32:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <42d42854-61d4-5379-908a-04892765f85c@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgB3jrxfIoRlsNaxEA--.54563S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry3Gw45JF4kWF4rtFWrKrg_yoW8ArWfpr
	WxKFW3tryqyr97A3yfWw17J34Yyw4rGw17XF13CF1DAFn0qFyvqF1IgrWFgFy5Xr4IkF4Y
	yF4jvryS9as8ZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/20/2023 10:54 PM, Daniel Borkmann wrote:
> On 12/19/23 2:56 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Hi,
>>
>> The motivation for the patch set comes from the performance profiling of
>> bpf memory allocator benchmark (will post it soon). The initial purpose
>> of the benchmark is used to test whether or not there is performance
>> degradation when using c->unit_size instead of ksize() to select the
>> target cache for free [1]. The benchmark uses bpf_kptr_xchg() to stash
>> the allocated objects and fetches the stashed objects for free. Based on
>> the fix proposed in [1], After inling bpf_kptr_xchg(), the performance
>> for object free increase about ~4%.
>
> It would probably make more sense if you place this also in the actual
> patch as motivation / use case on /why/ it's needed.

Thanks for the suggestion. Will added it in the inline patch.
>
>> Initially the inline is implemented in do_jit() for x86-64 directly, but
>> I think it will more portable to implement the inline in verifier.
>> Please see individual patches for more details. And comments are always
>> welcome.
>>
>> [1]:
>> https://lore.kernel.org/bpf/20231216131052.27621-1-houtao@huaweicloud.com
>>
>> Hou Tao (3):
>>    bpf: Support inlining bpf_kptr_xchg() helper
>>    bpf, x86: Don't generate lock prefix for BPF_XCHG
>>    bpf, x86: Inline bpf_kptr_xchg() on x86-64
>>
>>   arch/x86/net/bpf_jit_comp.c |  9 ++++++++-
>>   include/linux/filter.h      |  1 +
>>   kernel/bpf/core.c           | 10 ++++++++++
>>   kernel/bpf/verifier.c       | 17 +++++++++++++++++
>>   4 files changed, 36 insertions(+), 1 deletion(-)
>>
>
> nit: Needs a rebase.
> .

Will do.


