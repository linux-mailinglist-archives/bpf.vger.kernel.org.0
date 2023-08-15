Return-Path: <bpf+bounces-7827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C1F77CFF2
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 18:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24C81C20D7A
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 16:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286A6154BB;
	Tue, 15 Aug 2023 16:12:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060D114A90
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 16:12:40 +0000 (UTC)
Received: from out-13.mta0.migadu.com (out-13.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C3810DC
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 09:12:38 -0700 (PDT)
Message-ID: <ab4264da-7c73-e7c5-334d-ed61c9fdd241@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692115956; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldNyH6mOlPo9BIpW1w7GneztQqMYVJNxzFLcsi4xcKc=;
	b=euf7dfLEpqzC6atqqrHiFcWzB+Zwu1yxS8lNoXx8iApWGuWCg7ThTLw3OAxeI8Q076vso5
	qpwz05lAfeUdo7mS27LjC3CdTd6MMcT6fK2ilCfecIOXTXzoQywFZMl6dDFJ2IVrg/xoBn
	mrYHQD5NdyH9zklph3Ne/U0J0Dposvk=
Date: Tue, 15 Aug 2023 09:12:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: Masks and overflow of signed immediates in BPF instructions
Content-Language: en-US
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: david.faust@oracle.com, cupertino.miranda@oracle.com
References: <877cpwgzgh.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <877cpwgzgh.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/15/23 7:19 AM, Jose E. Marchesi wrote:
> 
> Hello.
> 
> The selftest progs/verifier_masking.c contains inline assembly code
> like:
> 
>    	w1 = 0xffffffff;
> 
> The 32-bit immediate of that instruction is signed.  Therefore, GAS
> complains that the above instruction overflows its field:
> 
>    /tmp/ccNOXFQy.s:46: Error: signed immediate out of range, shall fit in 32 bits
> 
> The llvm assembler is likely relying on signed overflow for the above to
> work.

Not really.

   def _ri_32 : ALU_RI<BPF_ALU, Opc, off,
                    (outs GPR32:$dst),
                    (ins GPR32:$src2, i32imm:$imm),
                    "$dst "#OpcodeStr#" $imm",
                    [(set GPR32:$dst, (OpNode GPR32:$src2, 
i32immSExt32:$imm))]>;


If generating from source, the pattern
    [(set GPR32:$dst, (OpNode GPR32:$src2, i32immSExt32:$imm))]
so value 0xffffffff is not SExt32 and it won't match and
eventually a LDimm_64 insn will be generated.

But for inline asm, we will have
   (outs GPR32:$dst)
   (ins GPR32:$src2, i32imm:$imm)

and i32imm is defined as
   def i32imm : Operand<i32>;
which is a unsigned 32bit value, so it is recognized properly
and the insn is encoded properly.

> 
> Using negative numbers to denote masks is ugly and obfuscating (for
> non-obvious cases like -1/0xffffffff) so I suggest we introduce a
> pseudo-op so we can do:
> 
>     w1 = %mask(0xffffffff)

I changed above
   w1 = 0xffffffff;
to
   w1 = %mask(0xffffffff)
and hit the following compilation failure.

progs/verifier_masking.c:54:9: error: invalid % escape in inline 
assembly string
    53 |         asm volatile ("                                 \
       |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    54 |         w1 = %mask(0xffffffff);                         \
       |                ^
1 error generated.

Do you have documentation what is '%mask' thing?

> 
> allowing the assembler to do the right thing (TM) converting and
> checking that the mask is valid and not relying on UB.
> 
> Thoughts?
> 

