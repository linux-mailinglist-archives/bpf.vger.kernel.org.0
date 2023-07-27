Return-Path: <bpf+bounces-6037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 625CE764507
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 06:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95BA282090
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 04:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D021FA0;
	Thu, 27 Jul 2023 04:41:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D99ED5
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 04:41:46 +0000 (UTC)
Received: from out-41.mta1.migadu.com (out-41.mta1.migadu.com [95.215.58.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A163A271B
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 21:41:43 -0700 (PDT)
Message-ID: <782032ee-65f6-0f6c-e28a-4da0511ad1aa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690432901; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcoVuzZtmfRJjFtuQK/YS44b/rLo3iZdx8pg1uhVW3Y=;
	b=ciIPLJ1FAdk2zAdh0scaM6Pn+9/WdL2mMdnTE5AwYCjpt4nUzoyYHtJaK5UHsl80quTb3r
	BFsTaazPWxOiT4PaR6wgx0o3Ymu4AZ4ur+cNy+lEz9q4siU+FxNb4TSjyW7PYjB2J+GPNI
	HsykylzZyDgGxC69S2g5LOaQrNBWJVw=
Date: Wed, 26 Jul 2023 21:41:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: Register constraint in NEG instructions
Content-Language: en-US
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>
References: <878rb3842z.fsf@oracle.com> <87y1j36nhz.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87y1j36nhz.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/26/23 2:16 AM, Jose E. Marchesi wrote:
> 
> I see this in the verifier (bpf-next):
> 
>     if (opcode == BPF_NEG) {
> 	if (BPF_SRC(insn->code) != BPF_K ||
> 	    insn->src_reg != BPF_REG_0 ||
> 	    insn->off != 0 || insn->imm != 0) {
> 		verbose(env, "BPF_NEG uses reserved fields\n");
> 	return -EINVAL;
>     }
> 
> And along this llvm assembler test:
> 
>                 |
>                 v
>    // CHECK: 84 01 00 00 00 00 00 00	w1 = -w1
>    w1 = -w1
> 
> Is enough evidence that NEG is supposed to use only dst and not src.  I

Yes, in llvm (BPFInstrInfo.td),

class NEG_RR<BPFOpClass Class, BPFArithOp Opc,
              dag outs, dag ins, string asmstr, list<dag> pattern>
     : TYPE_ALU_JMP<Opc.Value, 0, outs, ins, asmstr, pattern> {
   bits<4> dst;

   let Inst{51-48} = dst;
   let BPFClass = Class;
}

You can see only dst register is used. The further evidence
is from the above kernel check.


> am sending a fix for standarization/instruction-set.rst.
> 
>> Hello.
>>
>> The neg (and neg32) instructions are documented to use (and encode) both
>> src and dst register operands in standarization/instruction-set.rst:
>>
>>    BPF_NEG   0x80   dst = -src
>>
>> However, in llvm's BPFAsmParser::PreMatchCheck, it is checked that both
>> source and destination registers refer to the same register.  If they
>> are not, an error is raised.
>>
>> Is this to speed up JIT to different architectures, some like x86
>> featuring `NEG reg' and others like aarch64 featuring `NEG reg1,reg2'?
>>
>> Should I send a patch for instruction-set.rst documenting the
>> requirement?
>>
>> Thanks.

