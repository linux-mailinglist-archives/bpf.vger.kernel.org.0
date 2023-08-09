Return-Path: <bpf+bounces-7281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1767750F6
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 04:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46C6281A6A
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 02:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBE362B;
	Wed,  9 Aug 2023 02:32:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C45181
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 02:32:44 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A651980;
	Tue,  8 Aug 2023 19:32:42 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RLDZn1H2pz1GDfP;
	Wed,  9 Aug 2023 10:31:29 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 10:32:39 +0800
Message-ID: <721de7d4-2802-7399-c2d4-2631cfb20515@huawei.com>
Date: Wed, 9 Aug 2023 10:32:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next] riscv/bpf: Fix truncated immediate warning in
 rv_s_insn
To: Luke Nelson <lukenels@cs.washington.edu>
CC: <bpf@vger.kernel.org>, kernel test robot <lkp@intel.com>, Xi Wang
	<xi.wang@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20230727024931.17156-1-luke.r.nels@gmail.com>
 <b85bcf1d-9467-4df6-da11-8f0b24165ada@huawei.com>
 <CC58CCF3-1994-4C50-B8FC-E1520ED743BF@cs.washington.edu>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <CC58CCF3-1994-4C50-B8FC-E1520ED743BF@cs.washington.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/9 0:08, Luke Nelson wrote:
> 
>>>   static inline u32 rv_s_insn(u16 imm11_0, u8 rs2, u8 rs1, u8 funct3, u8 opcode)
>>>   {
>>> - u8 imm11_5 = imm11_0 >> 5, imm4_0 = imm11_0 & 0x1f;
>>> + u32 imm11_5 = (imm11_0 >> 5) & 0x7f, imm4_0 = imm11_0 & 0x1f;
>>
>> Hi Luke,
>>
>> keep u8 and add 0x7f explicit mask should work. I ran the repro case and it can silence the warning.
>>
>>>
>>>    return (imm11_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) |
>>>    (imm4_0 << 7) | opcode;
> 

Hi Luke,

Thank for more detailed explanation.

> That does fix the warning, but I think explicitly declaring imm11_5
> as u32 is more clear here than the current code which relies on
> implicit promotion of imm11_5 from u8 to signed int in the expression
> (imm11_5 << 25).
> 
> Because of the promotion to signed int, (imm11_5 << 25) is technically
> signed overflow and undefined behavior whenever the shift changes
> the value in the sign bit. In practice, this isn't an issue; both
> because the kernel is compiled with -fno-strict-overflow, but also
> because GCC documentation explicitly states that "GCC does not use
> the latitude given in C99 and C11 only to treat certain aspects of
> signed '<<' as undefined" [1].
> 
> Though it may not be an issue in practice, since I'm touching this
> line anyways to fix the warning, I think it makes sense to update
> the type of imm11_5 to be u32 at the same time.
> 

Agree. But this inconsistency looks weird, i.e. imm11_5 change to u32 
while rs2, rs1 and funct3 still u8. Anyway, our primary goal is to 
silence the sparse warning, and the current patch looks good to me. 
Let's go ahead.

Feel free to add:
Reviewed-by: Pu Lehui <pulehui@huawei.com>

>> Nit: maybe use "riscv, bpf" for the subject will look nice for the riscv-bpf git log tree.
> 
> Sure, I can send out a new revision with an updated subject line.
> 
> - Luke
> 
> 
> [1]: https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html

