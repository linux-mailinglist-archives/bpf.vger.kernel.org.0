Return-Path: <bpf+bounces-10384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EC67A6117
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 13:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B891C20B79
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580F33D394;
	Tue, 19 Sep 2023 11:23:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15593882E;
	Tue, 19 Sep 2023 11:23:12 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7480B8;
	Tue, 19 Sep 2023 04:23:10 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RqfMv5MWtzVl1f;
	Tue, 19 Sep 2023 19:20:11 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 19 Sep 2023 19:23:07 +0800
Message-ID: <8ebbd85d-857a-432b-be56-1f8f425b979d@huawei.com>
Date: Tue, 19 Sep 2023 19:23:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Pu Lehui <pulehui@huaweicloud.com>
CC: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<netdev@vger.kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
 <20230919035711.3297256-5-pulehui@huaweicloud.com>
 <20230919-4734211982e4e411a93650a7@fedora>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20230919-4734211982e4e411a93650a7@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/19 18:04, Conor Dooley wrote:
> On Tue, Sep 19, 2023 at 11:57:11AM +0800, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> In the current RV64 JIT, if we just don't initialize the TCC in subprog,
>> the TCC can be propagated from the parent process to the subprocess, but
>> the TCC of the parent process cannot be restored when the subprocess
>> exits. Since the RV64 TCC is initialized before saving the callee saved
>> registers into the stack, we cannot use the callee saved register to
>> pass the TCC, otherwise the original value of the callee saved register
>> will be destroyed. So we implemented mixing bpf2bpf and tailcalls
>> similar to x86_64, i.e. using a non-callee saved register to transfer
>> the TCC between functions, and saving that register to the stack to
>> protect the TCC value. At the same time, we also consider the scenario
>> of mixing trampoline.
>>
>> Tests test_bpf.ko and test_verifier have passed, as well as the relative
>> testcases of test_progs*.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> Breaks the build:
> ../arch/riscv/net/bpf_jit_comp64.c:846:14: error: use of undeclared identifier 'BPF_TRAMP_F_TAIL_CALL_CTX'
> 

Hi Conor,

BPF_TRAMP_F_TAIL_CALL_CTX rely on commit [0], and it has been merged 
into bpf-next tree.

Link: 
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=2b5dcb31a19a2e0acd869b12c9db9b2d696ef544 
[0]

> Thanks,
> Conor.

