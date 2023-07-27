Return-Path: <bpf+bounces-6056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91507764AD9
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 10:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6B22821D7
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 08:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDDDE571;
	Thu, 27 Jul 2023 08:10:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B23BE56E
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 08:10:01 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2710C59CB;
	Thu, 27 Jul 2023 01:09:41 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RBNc6582PztRZF;
	Thu, 27 Jul 2023 16:05:26 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 16:08:40 +0800
Message-ID: <ac709bc1-5a58-f10a-30cd-861ba8a137c3@huawei.com>
Date: Thu, 27 Jul 2023 16:08:40 +0800
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
Content-Language: en-US
To: Luke Nelson <lukenels@cs.washington.edu>, <bpf@vger.kernel.org>
CC: Luke Nelson <luke.r.nels@gmail.com>, kernel test robot <lkp@intel.com>, Xi
 Wang <xi.wang@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Alexei
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
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20230727024931.17156-1-luke.r.nels@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Nit: maybe use "riscv, bpf" for the subject will look nice for the 
riscv-bpf git log tree.

On 2023/7/27 10:49, Luke Nelson wrote:
> Sparse warns that a cast in rv_s_insn truncates bits from the constant
> 0x7ff to 0xff.  The warning originates from the use of a constant offset
> of -8 in a store instruction in bpf_jit_comp64.c:
> 
>    emit(rv_sd(RV_REG_SP, -8, RV_REG_RA), &ctx);
> 
> rv_sd then calls rv_s_insn, with imm11_0 equal to (u16)(-8), or 0xfff8.
> 
> Here's the current implementation of rv_s_insn:
> 
>    static inline u32 rv_s_insn(u16 imm11_0, u8 rs2, u8 rs1, u8 funct3, u8 opcode)
>    {
>            u8 imm11_5 = imm11_0 >> 5, imm4_0 = imm11_0 & 0x1f;
> 
>            return (imm11_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) |
>                   (imm4_0 << 7) | opcode;
>    }
> 
> imm11_0 is a signed 12-bit immediate offset of the store instruction. The
> instruction encoding requires splitting the immediate into bits 11:5 and
> bits 4:0. In this case, imm11_0 >> 5 = 0x7ff, which then gets truncated
> to 0xff when cast to u8, causing the warning from sparse. However, this is
> not actually an issue because the immediate offset is signed---truncating
> upper bits that are all set to 1 has no effect on the value of the
> immediate.
> 
> There is another subtle quirk with this code, which is imm11_5 is
> supposed to be the upper 7 bits of the 12-bit signed immediate, but its
> type is u8 with no explicit mask to select out only the bottom 7 bits.
> This happens to be okay here because imm11_5 is the left-most field in
> the instruction and the "extra" bit will be shifted out when imm11_5 is
> shifted left by 25.
> 
> This commit fixes the warning by changing the type of imm11_5 and imm4_0
> to be u32 instead of u8, and adding an explicit mask to compute imm11_5
> instead of relying on truncation + shifting.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307260704.dUElCrWU-lkp@intel.com/
> In-Reply-To: <202307260704.dUElCrWU-lkp@intel.com>
> Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
> Cc: Xi Wang <xi.wang@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   arch/riscv/net/bpf_jit.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 2717f5490428..e159c6e3ff43 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -238,7 +238,7 @@ static inline u32 rv_i_insn(u16 imm11_0, u8 rs1, u8 funct3, u8 rd, u8 opcode)
> 
>   static inline u32 rv_s_insn(u16 imm11_0, u8 rs2, u8 rs1, u8 funct3, u8 opcode)
>   {
> -	u8 imm11_5 = imm11_0 >> 5, imm4_0 = imm11_0 & 0x1f;
> +	u32 imm11_5 = (imm11_0 >> 5) & 0x7f, imm4_0 = imm11_0 & 0x1f;
> 
>   	return (imm11_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) |
>   		(imm4_0 << 7) | opcode;
> --
> 2.34.1
> 
> 

