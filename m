Return-Path: <bpf+bounces-8427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D207786489
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 03:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268372813F8
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 01:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C95817CB;
	Thu, 24 Aug 2023 01:17:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237597F;
	Thu, 24 Aug 2023 01:17:24 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6411510E4;
	Wed, 23 Aug 2023 18:17:23 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RWQ8B1qzzzNn3Y;
	Thu, 24 Aug 2023 09:13:46 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 24 Aug 2023 09:17:20 +0800
Message-ID: <490126e3-b5da-4523-11af-62a2a3c33514@huawei.com>
Date: Thu, 24 Aug 2023 09:17:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next 3/7] riscv, bpf: Support sign-extension mov insns
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Pu Lehui
	<pulehui@huaweicloud.com>, <linux-riscv@lists.infradead.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Xu Kuohai <xukuohai@huawei.com>,
	Puranjay Mohan <puranjay12@gmail.com>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-4-pulehui@huaweicloud.com>
 <87pm3dlj80.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <87pm3dlj80.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/24 2:14, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Add support sign-extension mov instructions for RV64.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   arch/riscv/net/bpf_jit_comp64.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index fd36cb17101a..d1497182cacf 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -1047,7 +1047,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>   			emit_zext_32(rd, ctx);
>>   			break;
>>   		}
>> -		emit_mv(rd, rs, ctx);
>> +		switch (insn->off) {
>> +		case 0:
>> +			emit_mv(rd, rs, ctx);
>> +			break;
>> +		case 8:
>> +		case 16:
>> +			emit_slli(rs, rs, 64 - insn->off, ctx);
>> +			emit_srai(rd, rs, 64 - insn->off, ctx);
> 
> You're clobbering the source register (rs) here, which is correct.

alright, will fix it

> 
> (Side note: Maybe it's time to add Zbb support to the JIT soon! ;-))
> 
> 
> Björn

