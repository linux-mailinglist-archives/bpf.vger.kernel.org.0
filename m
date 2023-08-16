Return-Path: <bpf+bounces-7864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C4277D873
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 04:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB9C1C20ECA
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 02:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE68DC2FA;
	Wed, 16 Aug 2023 02:31:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B3C2EB
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 02:31:19 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA801BE6
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 19:31:17 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQXCl2P8Fz1GDbk;
	Wed, 16 Aug 2023 10:29:55 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 10:31:14 +0800
Message-ID: <6e8244b3-acf8-acd3-2dda-8777b2b4c7f9@huawei.com>
Date: Wed, 16 Aug 2023 10:31:13 +0800
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
To: <yonghong.song@linux.dev>, Xu Kuohai <xukuohai@huaweicloud.com>,
	<bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Daniel Borkmann
	<daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Will Deacon
	<will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Yonghong Song
	<yhs@fb.com>, Zi Shen Lim <zlim.lnx@gmail.com>
References: <20230815154158.717901-1-xukuohai@huaweicloud.com>
 <20230815154158.717901-8-xukuohai@huaweicloud.com>
 <f1b6fde2-5097-7a0f-29ad-7390a165bf16@linux.dev>
 <67212714-15f3-84e8-d5c6-84746632eedd@huaweicloud.com>
 <2fd02263-669f-82cf-d2c0-86fb5e4ad993@linux.dev>
From: Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <2fd02263-669f-82cf-d2c0-86fb5e4ad993@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/16/2023 9:57 AM, Yonghong Song wrote:
> 
> 
> On 8/15/23 6:28 PM, Xu Kuohai wrote:
>> On 8/16/2023 12:57 AM, Yonghong Song wrote:
>>>
>>>
>>> On 8/15/23 8:41 AM, Xu Kuohai wrote:
>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>
>>>> Enable cpu v4 instruction tests for arm64.
>>>>
>>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>>
>>> Thanks for adding cpu v4 support for arm64. The CI looks green as well for arm64.
>>>
>>> https://github.com/kernel-patches/bpf/actions/runs/5868919914/job/15912774884?pr=5525
>>>
>>
>> Well, it looks like the CI's clang doesn't support cpu v4 yet:
>>
>>    #306/1   verifier_bswap/cpuv4 is not supported by compiler or jit, use a dummy test:OK
>>    #306     verifier_bswap:OK
>>
>>> Ack this patch which enabled cpu v4 tests for arm64.
> 
> Ah. Sorry. Could you paste your local cpu v4 run results for
> these related tests in the commit message then?
> 

Sure. The results are as follows. I'll post these in the commit message.

# ./test_progs -t ldsx_insn,verifier_sdiv,verifier_movsx,verifier_ldsx,verifier_gotol,verifier_bswap
#115/1   ldsx_insn/map_val and probed_memory:OK
#115/2   ldsx_insn/ctx_member_sign_ext:OK
#115/3   ldsx_insn/ctx_member_narrow_sign_ext:OK
#115     ldsx_insn:OK
#302/1   verifier_bswap/BSWAP, 16:OK
#302/2   verifier_bswap/BSWAP, 16 @unpriv:OK
#302/3   verifier_bswap/BSWAP, 32:OK
#302/4   verifier_bswap/BSWAP, 32 @unpriv:OK
#302/5   verifier_bswap/BSWAP, 64:OK
#302/6   verifier_bswap/BSWAP, 64 @unpriv:OK
#302     verifier_bswap:OK
#316/1   verifier_gotol/gotol, small_imm:OK
#316/2   verifier_gotol/gotol, small_imm @unpriv:OK
#316     verifier_gotol:OK
#324/1   verifier_ldsx/LDSX, S8:OK
#324/2   verifier_ldsx/LDSX, S8 @unpriv:OK
#324/3   verifier_ldsx/LDSX, S16:OK
#324/4   verifier_ldsx/LDSX, S16 @unpriv:OK
#324/5   verifier_ldsx/LDSX, S32:OK
#324/6   verifier_ldsx/LDSX, S32 @unpriv:OK
#324/7   verifier_ldsx/LDSX, S8 range checking, privileged:OK
#324/8   verifier_ldsx/LDSX, S16 range checking:OK
#324/9   verifier_ldsx/LDSX, S16 range checking @unpriv:OK
#324/10  verifier_ldsx/LDSX, S32 range checking:OK
#324/11  verifier_ldsx/LDSX, S32 range checking @unpriv:OK
#324     verifier_ldsx:OK
#335/1   verifier_movsx/MOV32SX, S8:OK
#335/2   verifier_movsx/MOV32SX, S8 @unpriv:OK
#335/3   verifier_movsx/MOV32SX, S16:OK
#335/4   verifier_movsx/MOV32SX, S16 @unpriv:OK
#335/5   verifier_movsx/MOV64SX, S8:OK
#335/6   verifier_movsx/MOV64SX, S8 @unpriv:OK
#335/7   verifier_movsx/MOV64SX, S16:OK
#335/8   verifier_movsx/MOV64SX, S16 @unpriv:OK
#335/9   verifier_movsx/MOV64SX, S32:OK
#335/10  verifier_movsx/MOV64SX, S32 @unpriv:OK
#335/11  verifier_movsx/MOV32SX, S8, range_check:OK
#335/12  verifier_movsx/MOV32SX, S8, range_check @unpriv:OK
#335/13  verifier_movsx/MOV32SX, S16, range_check:OK
#335/14  verifier_movsx/MOV32SX, S16, range_check @unpriv:OK
#335/15  verifier_movsx/MOV32SX, S16, range_check 2:OK
#335/16  verifier_movsx/MOV32SX, S16, range_check 2 @unpriv:OK
#335/17  verifier_movsx/MOV64SX, S8, range_check:OK
#335/18  verifier_movsx/MOV64SX, S8, range_check @unpriv:OK
#335/19  verifier_movsx/MOV64SX, S16, range_check:OK
#335/20  verifier_movsx/MOV64SX, S16, range_check @unpriv:OK
#335/21  verifier_movsx/MOV64SX, S32, range_check:OK
#335/22  verifier_movsx/MOV64SX, S32, range_check @unpriv:OK
#335/23  verifier_movsx/MOV64SX, S16, R10 Sign Extension:OK
#335/24  verifier_movsx/MOV64SX, S16, R10 Sign Extension @unpriv:OK
#335     verifier_movsx:OK
#347/1   verifier_sdiv/SDIV32, non-zero imm divisor, check 1:OK
#347/2   verifier_sdiv/SDIV32, non-zero imm divisor, check 1 @unpriv:OK
#347/3   verifier_sdiv/SDIV32, non-zero imm divisor, check 2:OK
#347/4   verifier_sdiv/SDIV32, non-zero imm divisor, check 2 @unpriv:OK
#347/5   verifier_sdiv/SDIV32, non-zero imm divisor, check 3:OK
#347/6   verifier_sdiv/SDIV32, non-zero imm divisor, check 3 @unpriv:OK
#347/7   verifier_sdiv/SDIV32, non-zero imm divisor, check 4:OK
#347/8   verifier_sdiv/SDIV32, non-zero imm divisor, check 4 @unpriv:OK
#347/9   verifier_sdiv/SDIV32, non-zero imm divisor, check 5:OK
#347/10  verifier_sdiv/SDIV32, non-zero imm divisor, check 5 @unpriv:OK
#347/11  verifier_sdiv/SDIV32, non-zero imm divisor, check 6:OK
#347/12  verifier_sdiv/SDIV32, non-zero imm divisor, check 6 @unpriv:OK
#347/13  verifier_sdiv/SDIV32, non-zero imm divisor, check 7:OK
#347/14  verifier_sdiv/SDIV32, non-zero imm divisor, check 7 @unpriv:OK
#347/15  verifier_sdiv/SDIV32, non-zero imm divisor, check 8:OK
#347/16  verifier_sdiv/SDIV32, non-zero imm divisor, check 8 @unpriv:OK
#347/17  verifier_sdiv/SDIV32, non-zero reg divisor, check 1:OK
#347/18  verifier_sdiv/SDIV32, non-zero reg divisor, check 1 @unpriv:OK
#347/19  verifier_sdiv/SDIV32, non-zero reg divisor, check 2:OK
#347/20  verifier_sdiv/SDIV32, non-zero reg divisor, check 2 @unpriv:OK
#347/21  verifier_sdiv/SDIV32, non-zero reg divisor, check 3:OK
#347/22  verifier_sdiv/SDIV32, non-zero reg divisor, check 3 @unpriv:OK
#347/23  verifier_sdiv/SDIV32, non-zero reg divisor, check 4:OK
#347/24  verifier_sdiv/SDIV32, non-zero reg divisor, check 4 @unpriv:OK
#347/25  verifier_sdiv/SDIV32, non-zero reg divisor, check 5:OK
#347/26  verifier_sdiv/SDIV32, non-zero reg divisor, check 5 @unpriv:OK
#347/27  verifier_sdiv/SDIV32, non-zero reg divisor, check 6:OK
#347/28  verifier_sdiv/SDIV32, non-zero reg divisor, check 6 @unpriv:OK
#347/29  verifier_sdiv/SDIV32, non-zero reg divisor, check 7:OK
#347/30  verifier_sdiv/SDIV32, non-zero reg divisor, check 7 @unpriv:OK
#347/31  verifier_sdiv/SDIV32, non-zero reg divisor, check 8:OK
#347/32  verifier_sdiv/SDIV32, non-zero reg divisor, check 8 @unpriv:OK
#347/33  verifier_sdiv/SDIV64, non-zero imm divisor, check 1:OK
#347/34  verifier_sdiv/SDIV64, non-zero imm divisor, check 1 @unpriv:OK
#347/35  verifier_sdiv/SDIV64, non-zero imm divisor, check 2:OK
#347/36  verifier_sdiv/SDIV64, non-zero imm divisor, check 2 @unpriv:OK
#347/37  verifier_sdiv/SDIV64, non-zero imm divisor, check 3:OK
#347/38  verifier_sdiv/SDIV64, non-zero imm divisor, check 3 @unpriv:OK
#347/39  verifier_sdiv/SDIV64, non-zero imm divisor, check 4:OK
#347/40  verifier_sdiv/SDIV64, non-zero imm divisor, check 4 @unpriv:OK
#347/41  verifier_sdiv/SDIV64, non-zero imm divisor, check 5:OK
#347/42  verifier_sdiv/SDIV64, non-zero imm divisor, check 5 @unpriv:OK
#347/43  verifier_sdiv/SDIV64, non-zero imm divisor, check 6:OK
#347/44  verifier_sdiv/SDIV64, non-zero imm divisor, check 6 @unpriv:OK
#347/45  verifier_sdiv/SDIV64, non-zero reg divisor, check 1:OK
#347/46  verifier_sdiv/SDIV64, non-zero reg divisor, check 1 @unpriv:OK
#347/47  verifier_sdiv/SDIV64, non-zero reg divisor, check 2:OK
#347/48  verifier_sdiv/SDIV64, non-zero reg divisor, check 2 @unpriv:OK
#347/49  verifier_sdiv/SDIV64, non-zero reg divisor, check 3:OK
#347/50  verifier_sdiv/SDIV64, non-zero reg divisor, check 3 @unpriv:OK
#347/51  verifier_sdiv/SDIV64, non-zero reg divisor, check 4:OK
#347/52  verifier_sdiv/SDIV64, non-zero reg divisor, check 4 @unpriv:OK
#347/53  verifier_sdiv/SDIV64, non-zero reg divisor, check 5:OK
#347/54  verifier_sdiv/SDIV64, non-zero reg divisor, check 5 @unpriv:OK
#347/55  verifier_sdiv/SDIV64, non-zero reg divisor, check 6:OK
#347/56  verifier_sdiv/SDIV64, non-zero reg divisor, check 6 @unpriv:OK
#347/57  verifier_sdiv/SMOD32, non-zero imm divisor, check 1:OK
#347/58  verifier_sdiv/SMOD32, non-zero imm divisor, check 1 @unpriv:OK
#347/59  verifier_sdiv/SMOD32, non-zero imm divisor, check 2:OK
#347/60  verifier_sdiv/SMOD32, non-zero imm divisor, check 2 @unpriv:OK
#347/61  verifier_sdiv/SMOD32, non-zero imm divisor, check 3:OK
#347/62  verifier_sdiv/SMOD32, non-zero imm divisor, check 3 @unpriv:OK
#347/63  verifier_sdiv/SMOD32, non-zero imm divisor, check 4:OK
#347/64  verifier_sdiv/SMOD32, non-zero imm divisor, check 4 @unpriv:OK
#347/65  verifier_sdiv/SMOD32, non-zero imm divisor, check 5:OK
#347/66  verifier_sdiv/SMOD32, non-zero imm divisor, check 5 @unpriv:OK
#347/67  verifier_sdiv/SMOD32, non-zero imm divisor, check 6:OK
#347/68  verifier_sdiv/SMOD32, non-zero imm divisor, check 6 @unpriv:OK
#347/69  verifier_sdiv/SMOD32, non-zero reg divisor, check 1:OK
#347/70  verifier_sdiv/SMOD32, non-zero reg divisor, check 1 @unpriv:OK
#347/71  verifier_sdiv/SMOD32, non-zero reg divisor, check 2:OK
#347/72  verifier_sdiv/SMOD32, non-zero reg divisor, check 2 @unpriv:OK
#347/73  verifier_sdiv/SMOD32, non-zero reg divisor, check 3:OK
#347/74  verifier_sdiv/SMOD32, non-zero reg divisor, check 3 @unpriv:OK
#347/75  verifier_sdiv/SMOD32, non-zero reg divisor, check 4:OK
#347/76  verifier_sdiv/SMOD32, non-zero reg divisor, check 4 @unpriv:OK
#347/77  verifier_sdiv/SMOD32, non-zero reg divisor, check 5:OK
#347/78  verifier_sdiv/SMOD32, non-zero reg divisor, check 5 @unpriv:OK
#347/79  verifier_sdiv/SMOD32, non-zero reg divisor, check 6:OK
#347/80  verifier_sdiv/SMOD32, non-zero reg divisor, check 6 @unpriv:OK
#347/81  verifier_sdiv/SMOD64, non-zero imm divisor, check 1:OK
#347/82  verifier_sdiv/SMOD64, non-zero imm divisor, check 1 @unpriv:OK
#347/83  verifier_sdiv/SMOD64, non-zero imm divisor, check 2:OK
#347/84  verifier_sdiv/SMOD64, non-zero imm divisor, check 2 @unpriv:OK
#347/85  verifier_sdiv/SMOD64, non-zero imm divisor, check 3:OK
#347/86  verifier_sdiv/SMOD64, non-zero imm divisor, check 3 @unpriv:OK
#347/87  verifier_sdiv/SMOD64, non-zero imm divisor, check 4:OK
#347/88  verifier_sdiv/SMOD64, non-zero imm divisor, check 4 @unpriv:OK
#347/89  verifier_sdiv/SMOD64, non-zero imm divisor, check 5:OK
#347/90  verifier_sdiv/SMOD64, non-zero imm divisor, check 5 @unpriv:OK
#347/91  verifier_sdiv/SMOD64, non-zero imm divisor, check 6:OK
#347/92  verifier_sdiv/SMOD64, non-zero imm divisor, check 6 @unpriv:OK
#347/93  verifier_sdiv/SMOD64, non-zero imm divisor, check 7:OK
#347/94  verifier_sdiv/SMOD64, non-zero imm divisor, check 7 @unpriv:OK
#347/95  verifier_sdiv/SMOD64, non-zero imm divisor, check 8:OK
#347/96  verifier_sdiv/SMOD64, non-zero imm divisor, check 8 @unpriv:OK
#347/97  verifier_sdiv/SMOD64, non-zero reg divisor, check 1:OK
#347/98  verifier_sdiv/SMOD64, non-zero reg divisor, check 1 @unpriv:OK
#347/99  verifier_sdiv/SMOD64, non-zero reg divisor, check 2:OK
#347/100 verifier_sdiv/SMOD64, non-zero reg divisor, check 2 @unpriv:OK
#347/101 verifier_sdiv/SMOD64, non-zero reg divisor, check 3:OK
#347/102 verifier_sdiv/SMOD64, non-zero reg divisor, check 3 @unpriv:OK
#347/103 verifier_sdiv/SMOD64, non-zero reg divisor, check 4:OK
#347/104 verifier_sdiv/SMOD64, non-zero reg divisor, check 4 @unpriv:OK
#347/105 verifier_sdiv/SMOD64, non-zero reg divisor, check 5:OK
#347/106 verifier_sdiv/SMOD64, non-zero reg divisor, check 5 @unpriv:OK
#347/107 verifier_sdiv/SMOD64, non-zero reg divisor, check 6:OK
#347/108 verifier_sdiv/SMOD64, non-zero reg divisor, check 6 @unpriv:OK
#347/109 verifier_sdiv/SMOD64, non-zero reg divisor, check 7:OK
#347/110 verifier_sdiv/SMOD64, non-zero reg divisor, check 7 @unpriv:OK
#347/111 verifier_sdiv/SMOD64, non-zero reg divisor, check 8:OK
#347/112 verifier_sdiv/SMOD64, non-zero reg divisor, check 8 @unpriv:OK
#347/113 verifier_sdiv/SDIV32, zero divisor:OK
#347/114 verifier_sdiv/SDIV32, zero divisor @unpriv:OK
#347/115 verifier_sdiv/SDIV64, zero divisor:OK
#347/116 verifier_sdiv/SDIV64, zero divisor @unpriv:OK
#347/117 verifier_sdiv/SMOD32, zero divisor:OK
#347/118 verifier_sdiv/SMOD32, zero divisor @unpriv:OK
#347/119 verifier_sdiv/SMOD64, zero divisor:OK
#347/120 verifier_sdiv/SMOD64, zero divisor @unpriv:OK
#347     verifier_sdiv:OK
Summary: 6/166 PASSED, 0 SKIPPED, 0 FAILED

>>>
>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>>
>>>> ---
>>>>   tools/testing/selftests/bpf/progs/test_ldsx_insn.c | 2 +-
>>>>   tools/testing/selftests/bpf/progs/verifier_bswap.c | 2 +-
>>>>   tools/testing/selftests/bpf/progs/verifier_gotol.c | 2 +-
>>>>   tools/testing/selftests/bpf/progs/verifier_ldsx.c  | 2 +-
>>>>   tools/testing/selftests/bpf/progs/verifier_movsx.c | 2 +-
>>>>   tools/testing/selftests/bpf/progs/verifier_sdiv.c  | 2 +-
>>>>   6 files changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
>>>> index 321abf862801..916d9435f12c 100644
>>>> --- a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
>>>> +++ b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
>>>> @@ -5,7 +5,7 @@
>>>>   #include <bpf/bpf_helpers.h>
>>>>   #include <bpf/bpf_tracing.h>
>>>> -#if defined(__TARGET_ARCH_x86) && __clang_major__ >= 18
>>>> +#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86)) && __clang_major__ >= 18
>>>>   const volatile int skip = 0;
>>>>   #else
>>>>   const volatile int skip = 1;
>>> [...]
>>>
>>> .
>>
> 
> .


