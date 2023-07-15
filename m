Return-Path: <bpf+bounces-5061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC957547A5
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 11:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B40282142
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9170F15CD;
	Sat, 15 Jul 2023 09:10:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB427FA
	for <bpf@vger.kernel.org>; Sat, 15 Jul 2023 09:10:33 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A0D268B;
	Sat, 15 Jul 2023 02:10:31 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R32Y96HpxztR8t;
	Sat, 15 Jul 2023 17:07:25 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 15 Jul 2023 17:10:27 +0800
Message-ID: <56a6a35c-7320-4569-71e3-c4daffee78f3@huawei.com>
Date: Sat, 15 Jul 2023 17:10:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V11 0/5] riscv: Optimize function trace
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Song Shuai
	<suagrfillet@gmail.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mark.rutland@arm.com>, <guoren@kernel.org>, <bjorn@rivosinc.com>,
	<jszhang@kernel.org>, <conor.dooley@microchip.com>, <palmer@rivosinc.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <songshuaishuai@tinylab.org>,
	<bpf@vger.kernel.org>
References: <20230627111612.761164-1-suagrfillet@gmail.com>
 <87jzv5q9tv.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <87jzv5q9tv.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/13 2:11, Björn Töpel wrote:
> Song Shuai <suagrfillet@gmail.com> writes:
> 
> [...]
> 
>> Add WITH_DIRECT_CALLS support [3] (patch 3, 4)
>> ==============================================
> 
> We've had some offlist discussions, so here's some input for a wider
> audience! Most importantly, this is for Palmer, so that this series is
> not merged until a proper BPF trampoline fix is in place.
> 
> Note that what's currently usable from BPF trampoline *works*. It's
> when this series is added that it breaks.
> 
> TL;DR This series adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS, which enables
> fentry/fexit BPF trampoline support. Unfortunately the
> fexit/BPF_TRAMP_F_SKIP_FRAME parts of the RV BPF trampoline breaks
> with this addition, and need to be addressed *prior* merging this
> series. An easy way to reproduce, is just calling any of the kselftest
> tests that uses fexit patching.
> 
> The issue is around the nop seld, and how a call is done; The nop sled
> (patchable-function-entry) size changed from 16B to 8B in commit
> 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to half"), but
> BPF code still uses the old 16B. So it'll work for BPF programs, but not
> for regular kernel functions.
> 
> An example:
> 
>    | ffffffff80fa4150 <bpf_fentry_test1>:
>    | ffffffff80fa4150:       0001                    nop
>    | ffffffff80fa4152:       0001                    nop
>    | ffffffff80fa4154:       0001                    nop
>    | ffffffff80fa4156:       0001                    nop
>    | ffffffff80fa4158:       1141                    add     sp,sp,-16
>    | ffffffff80fa415a:       e422                    sd      s0,8(sp)
>    | ffffffff80fa415c:       0800                    add     s0,sp,16
>    | ffffffff80fa415e:       6422                    ld      s0,8(sp)
>    | ffffffff80fa4160:       2505                    addw    a0,a0,1
>    | ffffffff80fa4162:       0141                    add     sp,sp,16
>    | ffffffff80fa4164:       8082                    ret
> 
> is patched to:
> 
>    | ffffffff80fa4150:  f70c0297                     auipc   t0,-150208512
>    | ffffffff80fa4154:  eb0282e7                     jalr    t0,t0,-336
> 
> The return address to bpf_fentry_test1 is stored in t0 at BPF
> trampoline entry. Return to the *parent* is in ra. The trampline has
> to deal with this.
> 
> For BPF_TRAMP_F_SKIP_FRAME/CALL_ORIG, the BPF trampoline will skip too
> many bytes, and not correctly handle parent calls.
> 
> Further; The BPF trampoline currently has a different way of patching
> the nops for BPF programs, than what ftrace does. That should be changed
> to match what ftrace does (auipc/jalr t0).
> 
> To summarize:
>   * Align BPF nop sled with patchable-function-entry: 8B.
>   * Adapt BPF trampoline for 8B nop sleds.
>   * Adapt BPF trampoline t0 return, ra parent scheme.
> 

Thanks Björn, I make a adaptation as follows, looking forward to your 
review.

https://lore.kernel.org/bpf/20230715090137.2141358-1-pulehui@huaweicloud.com/

> 
> Cheers,
> Björn
> 
> 

