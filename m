Return-Path: <bpf+bounces-10027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8907A06D5
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656E21F23A71
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D48224DB;
	Thu, 14 Sep 2023 14:04:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C049241E3;
	Thu, 14 Sep 2023 14:04:08 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4735D1A2;
	Thu, 14 Sep 2023 07:04:07 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rmf8y1GDlzGppB;
	Thu, 14 Sep 2023 22:00:18 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 14 Sep 2023 22:04:01 +0800
Message-ID: <aacefd22-39df-6941-4d43-d47f72caa9d2@huawei.com>
Date: Thu, 14 Sep 2023 22:04:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next 4/6] riscv, bpf: Add necessary Zbb instructions
Content-Language: en-US
To: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>
CC: Pu Lehui <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>
References: <20230913153413.1446068-1-pulehui@huaweicloud.com>
 <20230913153413.1446068-5-pulehui@huaweicloud.com>
 <20230913-granny-heat-35d70b49ac85@spud>
 <20230914-ought-hypnotize-64cee0e27ed2@wendy>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20230914-ought-hypnotize-64cee0e27ed2@wendy>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected



On 2023/9/14 21:02, Conor Dooley wrote:
> On Wed, Sep 13, 2023 at 05:23:48PM +0100, Conor Dooley wrote:
>> On Wed, Sep 13, 2023 at 11:34:11PM +0800, Pu Lehui wrote:
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> Add necessary Zbb instructions introduced by [0] to reduce code size and
>>> improve performance of RV64 JIT. At the same time, a helper is added to
>>> check whether the CPU supports Zbb instructions.
>>>
>>> [0] https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bitmanip-1.0.0-38-g865e7a7.pdf
>>>
>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>> ---
>>>   arch/riscv/net/bpf_jit.h | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>>> index 8e0ef4d08..7ee59d1f6 100644
>>> --- a/arch/riscv/net/bpf_jit.h
>>> +++ b/arch/riscv/net/bpf_jit.h
>>> @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
>>>   	return IS_ENABLED(CONFIG_RISCV_ISA_C);
>>>   }
>>>   
>>> +static inline bool rvzbb_enabled(void)
>>> +{
>>> +	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB);
>>> +}
>>
>> I dunno much about bpf, so passing question that may be a bit obvious:
>> Is this meant to be a test as to whether the kernel binary is built with
>> support for the extension, or whether the underlying platform is capable
>> of executing zbb instructions.
>>
>> Sorry if that would be obvious to a bpf aficionado, context I have here
>> is the later user and the above rvc_enabled() test, which functions
>> differently to Zbb and so doesn't really help me.
> 
> FTR, I got an off-list reply about this & it is meant to be a check as
> to whether the underlying platform supports the extension. The current
> test here is insufficient for that.
> 

Thanks Conor for explain me lot about the difference between Compressed 
instructions and Zbb instructions. As the compressed instructions are a 
build-time option, while the Zbb is runtime detected. We need to add 
additional runtime detection as show bellow:

riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)

will patch this suggestion to the next version.

Thanks,
Lehui.

> Thanks,
> Conor.

