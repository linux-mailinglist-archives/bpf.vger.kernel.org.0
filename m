Return-Path: <bpf+bounces-7857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E1A77D7AA
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 03:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0CF11C20E7E
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 01:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A317F2;
	Wed, 16 Aug 2023 01:28:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F7392
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 01:28:35 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAA0211E
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 18:28:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQVrs2YNNz4f3m7J
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 09:28:29 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgAHKm49JtxkDYY6Aw--.30849S2;
	Wed, 16 Aug 2023 09:28:30 +0800 (CST)
Message-ID: <67212714-15f3-84e8-d5c6-84746632eedd@huaweicloud.com>
Date: Wed, 16 Aug 2023 09:28:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Enable cpu v4 tests for arm64
Content-Language: en-US
To: yonghong.song@linux.dev, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Yonghong Song <yhs@fb.com>,
 Zi Shen Lim <zlim.lnx@gmail.com>
References: <20230815154158.717901-1-xukuohai@huaweicloud.com>
 <20230815154158.717901-8-xukuohai@huaweicloud.com>
 <f1b6fde2-5097-7a0f-29ad-7390a165bf16@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <f1b6fde2-5097-7a0f-29ad-7390a165bf16@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHKm49JtxkDYY6Aw--.30849S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1xZryfGF1kZr17uF4rKrg_yoW8CF1rpa
	4kWas8Kr1IkFnxWF13GFW7ZFyrtws2vryYya10yw45WF1DJryxJrs7KF45KrnIgrZY9rs5
	Za42g39xZF48ZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/16/2023 12:57 AM, Yonghong Song wrote:
> 
> 
> On 8/15/23 8:41 AM, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> Enable cpu v4 instruction tests for arm64.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> 
> Thanks for adding cpu v4 support for arm64. The CI looks green as well for arm64.
> 
> https://github.com/kernel-patches/bpf/actions/runs/5868919914/job/15912774884?pr=5525
>

Well, it looks like the CI's clang doesn't support cpu v4 yet:

   #306/1   verifier_bswap/cpuv4 is not supported by compiler or jit, use a dummy test:OK
   #306     verifier_bswap:OK

> Ack this patch which enabled cpu v4 tests for arm64.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 
>> ---
>>   tools/testing/selftests/bpf/progs/test_ldsx_insn.c | 2 +-
>>   tools/testing/selftests/bpf/progs/verifier_bswap.c | 2 +-
>>   tools/testing/selftests/bpf/progs/verifier_gotol.c | 2 +-
>>   tools/testing/selftests/bpf/progs/verifier_ldsx.c  | 2 +-
>>   tools/testing/selftests/bpf/progs/verifier_movsx.c | 2 +-
>>   tools/testing/selftests/bpf/progs/verifier_sdiv.c  | 2 +-
>>   6 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
>> index 321abf862801..916d9435f12c 100644
>> --- a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
>> +++ b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
>> @@ -5,7 +5,7 @@
>>   #include <bpf/bpf_helpers.h>
>>   #include <bpf/bpf_tracing.h>
>> -#if defined(__TARGET_ARCH_x86) && __clang_major__ >= 18
>> +#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86)) && __clang_major__ >= 18
>>   const volatile int skip = 0;
>>   #else
>>   const volatile int skip = 1;
> [...]
> 
> .


