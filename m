Return-Path: <bpf+bounces-11509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A2F7BB022
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 03:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 89057282262
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D78A15CB;
	Fri,  6 Oct 2023 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id/0BsKp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BC015AD
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 01:43:25 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7596E7
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 18:43:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690bd59322dso1388908b3a.3
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 18:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696556603; x=1697161403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=df1ZlXghuvqDj31c4fjB7N6UXSzh/ntS04iANy7uEr0=;
        b=id/0BsKpV4I0cDYasswwuu42hpA2iXw0RkJAn9G/J6PvscRHTwz5LxVKVub/EmZjZh
         d7hS+zlCK/sTTJRBn9cfdLP0ZDQC+ajY8GH2wzL03bTXPWasgw7EGxIqNqkpQuxtCMS1
         aaxSerL0Cr8aZWNl1nDuY35EdrmgNM+Y0em6Unf448pr0Fvr+RgakOD2Wi+2BNIlKZgw
         d9yTbkaVQV0vzfWEpx9Ghj6p7wbYw1J3Sfe9h929e5PpWqMVwZG/avSiJvr5XczqX5CW
         9lpQpaKq4BYnY02Y8FN07O8hIf1N0t+RIPy9S9O481gS2NiruijA41RwoNJURUPUWJ1N
         j1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696556603; x=1697161403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=df1ZlXghuvqDj31c4fjB7N6UXSzh/ntS04iANy7uEr0=;
        b=tUgLr7/QsIlRGgzrSBZHlkDnZ+9RIPG6582Lm5ouKJGof06Mv9s1LNsvBFXEnmcZZQ
         nBTYQybsMjcQHDzHFP5OF69X8rHvegIuerZxlWZza1pdhUFCVgv6mlwJGNfkJOlb1SuH
         dNSlswQmnyGAkrT6KVzT2OAIQUSZkdz66ZCdOBh6BCuYRJ3NpDBdUI+VNSNPq9v11P8e
         PQA5rwbo3OMWHxawLAc4M5BBAQCMnjl4i1BuA/JFnYWLRPZfaT5da03U+Yy/8IAerKPP
         OGjiPq0qdGE8uxc8u1HA0+hlS2nOu1equgcl9iP7ffc4bZdpxSx+OX/zIQcjxzwwBwgt
         /hJg==
X-Gm-Message-State: AOJu0YyJXvbiGOrpGh5txs31IZ/ttsbnPSr5Q9qlXuIwWhwOkSdmmYi7
	yHa/1tr7OO2yIbwLKcZRWMmxvkUuOtmEnQ==
X-Google-Smtp-Source: AGHT+IFukUTbPeNqM7r2SbsdREVmHGz1t4yohK4tsHtcFn0bQG4LiNRABND1YuvWXrRe2/gv2pXfTA==
X-Received: by 2002:a05:6a00:2191:b0:68a:4261:ab7f with SMTP id h17-20020a056a00219100b0068a4261ab7fmr7668071pfi.31.1696556602819;
        Thu, 05 Oct 2023 18:43:22 -0700 (PDT)
Received: from [10.22.68.101] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id x7-20020a056a00270700b0068c670afe30sm235548pfv.124.2023.10.05.18.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 18:43:22 -0700 (PDT)
Message-ID: <787e2f5e-41b3-0793-97e3-a6566c2b34bf@gmail.com>
Date: Fri, 6 Oct 2023 09:43:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH bpf-next 1/3] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, maciej.fijalkowski@intel.com, jakub@cloudflare.com,
 iii@linux.ibm.com, hengqi.chen@gmail.com
References: <20231005145814.83122-1-hffilwlqm@gmail.com>
 <20231005145814.83122-2-hffilwlqm@gmail.com> <ZR763xGlqqu2gb41@google.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <ZR763xGlqqu2gb41@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/10/23 02:05, Stanislav Fomichev wrote:
> On 10/05, Leon Hwang wrote:
>> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
>> handling in JIT"), the tailcall on x64 works better than before.
>>
>> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
>> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
>>
>> How about:
>>
>> 1. More than 1 subprograms are called in a bpf program.
>> 2. The tailcalls in the subprograms call the bpf program.
>>
>> Because of missing tail_call_cnt back-propagation, a tailcall hierarchy
>> comes up. And MAX_TAIL_CALL_CNT limit does not work for this case.
>>
>> As we know, in tail call context, the tail_call_cnt propagates by stack
>> and rax register between BPF subprograms. So, propagating tail_call_cnt
>> pointer by stack and rax register makes tail_call_cnt as like a global
>> variable, in order to make MAX_TAIL_CALL_CNT limit works for tailcall
>> hierarchy cases.
>>
>> Before jumping to other bpf prog, load tail_call_cnt from the pointer
>> and then compare with MAX_TAIL_CALL_CNT. Finally, increment
>> tail_call_cnt by the pointer.
>>
>> But, where does tail_call_cnt store?
>>
>> It stores on the stack of uppest-hierarchy-layer bpf prog, like
>>
>>  |  STACK  |
>>  +---------+ RBP
>>  |         |
>>  |         |
>>  |         |
>>  | tcc_ptr |
>>  |   tcc   |
>>  |   rbx   |
>>  +---------+ RSP
>>
>> Why not back-propagate tail_call_cnt?
>>
>> It's because it's vulnerable to back-propagate it. It's unable to work
>> well with the following case.
>>
>> int prog1();
>> int prog2();
>>
>> prog1 is tail caller, and prog2 is tail callee. If we do back-propagate
>> tail_call_cnt at the epilogue of prog2, can prog2 run standalone at the
>> same time? The answer is NO. Otherwise, there will be a register to be
>> polluted, which will make kernel crash.
>>
>> Can tail_call_cnt store at other place instead of the stack of bpf prog?
>>
>> I'm not able to infer a better place to store tail_call_cnt. It's not a
>> working inference to store it at ctx or on the stack of bpf prog's
>> caller.
>>
>> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
>> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
>>  arch/x86/net/bpf_jit_comp.c | 120 +++++++++++++++++++++++-------------
>>  1 file changed, 76 insertions(+), 44 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 8c10d9abc2394..8ad6368353c2b 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -256,7 +256,7 @@ struct jit_context {
>>  /* Number of bytes emit_patch() needs to generate instructions */
>>  #define X86_PATCH_SIZE		5
>>  /* Number of bytes that will be skipped on tailcall */
>> -#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
>> +#define X86_TAIL_CALL_OFFSET	(24 + ENDBR_INSN_SIZE)
>>  
>>  static void push_r12(u8 **pprog)
>>  {
>> @@ -304,6 +304,25 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
>>  	*pprog = prog;
>>  }
>>  
> 
> [..]
> 
>> +static void emit_nops(u8 **pprog, int len)
>> +{
>> +	u8 *prog = *pprog;
>> +	int i, noplen;
>> +
>> +	while (len > 0) {
>> +		noplen = len;
>> +
>> +		if (noplen > ASM_NOP_MAX)
>> +			noplen = ASM_NOP_MAX;
>> +
>> +		for (i = 0; i < noplen; i++)
>> +			EMIT1(x86_nops[noplen][i]);
>> +		len -= noplen;
>> +	}
>> +
>> +	*pprog = prog;
>> +}
> 
> From high level - makes sense to me.
> I'll leave a thorough review to the people who understand more :-)
> I see Maciej commenting on your original "Fix tailcall infinite loop"
> series.

Welcome for your review.

> 
> One suggestion I have is: the changes to 'memcpy(prog, x86_nops[5],
> X86_PATCH_SIZE);' and this emit_nops move here don't seem like
> they actually belong to this patch. Maybe do them separately?

Moving emit_nops here is for them:

+			/* Keep the same instruction layout. */
+			emit_nops(&prog, 3);
+			emit_nops(&prog, 6);
+			emit_nops(&prog, 6);

and do the changes to 'memcpy(prog, x86_nops[5], X86_PATCH_SIZE);' BTW.

Thanks,
Leon

