Return-Path: <bpf+bounces-11470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64D17BA89A
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 20:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 51F16281EB1
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 18:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ECE3D390;
	Thu,  5 Oct 2023 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f69rH9mH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72A3B7A7
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 18:05:25 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A169F
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 11:05:21 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-588fb7ab571so712801a12.1
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696529121; x=1697133921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJUMSiGFlvAVYgaBt0uVPGC5wgZdbFUKxWx9q2PnuOU=;
        b=f69rH9mH1AHv7wEkgadOVF/JJ+j1YDgZSxtd9U/haPw1q0xUxuZNggsKjKY6/lFujT
         pSPprfuJ6xNHYf/KqLP4pGxz7PCnsH8n4yOnuRtuYA/zaY/goyEmdJVZU9eN2TJ7XG93
         nUh3Rvch4h+AQeTp70c1rePWstEhlozfeDK+vIok7zSy6Nq8AXNTEy8HqLTwtbq97Vc5
         pBVa3ZPM4xVBYVUKbNHWa1Mrd2QhiuSlsI8SON+en848CWgnPlUWOji6/FVoLmBhP4fr
         c+/Bo3yB+VQO3I2R2np6Gs6rXqeLsGOaIRPRMTky2n75vWpAKMbG+ZZ4AYS9nfR2dyn9
         OBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696529121; x=1697133921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJUMSiGFlvAVYgaBt0uVPGC5wgZdbFUKxWx9q2PnuOU=;
        b=A3Dvo2XbxSwHlZYTWNmkeNdVmZBsZbKrjma7i+KPlkSvKEj6KbrWp7rN5GNUr9L5JD
         3sCIM2bZbMDibE9DRPnolqqPfFCSsi0Aug84EamRUnE4m6NlkjMNrTUPDKSZE77tfzjd
         BUefDqjdOkDwP8h3XC66hIKECgMMNcK2rJLZ3y1nd6NmkQatAy0hu7bTpkOoE7zUdZBw
         Q6unHKGCozFxhKtA880zf4NHBieYteP/PWkOylYv6LXYB54iZBZY9f/zZqE/BN5KzNPn
         Ryamh/Vyq9MbNmD+jTyNSv0/M7sLaXukVYwzH9PHGgB3yqXQSwH8GRakCsDQ/LqWMSGC
         nhhA==
X-Gm-Message-State: AOJu0Yw1OqW9GfOtfmqIX5M/Ypd2tsQpwKZTnfNbeLTLf4R8p5NVwRl4
	lCFd9+dTWdF+RRoThVtAlLpIQI0=
X-Google-Smtp-Source: AGHT+IFdxhKGl7RfnI8XGoYmHmXXYCSj9r+mtddx6+aPHVdIcP1QH2JP7LcwSKziF6NiAnVkfnySm3Q=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3dc7:0:b0:574:e90:6e54 with SMTP id
 k190-20020a633dc7000000b005740e906e54mr83961pga.6.1696529121155; Thu, 05 Oct
 2023 11:05:21 -0700 (PDT)
Date: Thu, 5 Oct 2023 11:05:19 -0700
In-Reply-To: <20231005145814.83122-2-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005145814.83122-1-hffilwlqm@gmail.com> <20231005145814.83122-2-hffilwlqm@gmail.com>
Message-ID: <ZR763xGlqqu2gb41@google.com>
Subject: Re: [RFC PATCH bpf-next 1/3] bpf, x64: Fix tailcall hierarchy
From: Stanislav Fomichev <sdf@google.com>
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, maciej.fijalkowski@intel.com, jakub@cloudflare.com, 
	iii@linux.ibm.com, hengqi.chen@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/05, Leon Hwang wrote:
> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
> handling in JIT"), the tailcall on x64 works better than before.
> 
> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
> 
> How about:
> 
> 1. More than 1 subprograms are called in a bpf program.
> 2. The tailcalls in the subprograms call the bpf program.
> 
> Because of missing tail_call_cnt back-propagation, a tailcall hierarchy
> comes up. And MAX_TAIL_CALL_CNT limit does not work for this case.
> 
> As we know, in tail call context, the tail_call_cnt propagates by stack
> and rax register between BPF subprograms. So, propagating tail_call_cnt
> pointer by stack and rax register makes tail_call_cnt as like a global
> variable, in order to make MAX_TAIL_CALL_CNT limit works for tailcall
> hierarchy cases.
> 
> Before jumping to other bpf prog, load tail_call_cnt from the pointer
> and then compare with MAX_TAIL_CALL_CNT. Finally, increment
> tail_call_cnt by the pointer.
> 
> But, where does tail_call_cnt store?
> 
> It stores on the stack of uppest-hierarchy-layer bpf prog, like
> 
>  |  STACK  |
>  +---------+ RBP
>  |         |
>  |         |
>  |         |
>  | tcc_ptr |
>  |   tcc   |
>  |   rbx   |
>  +---------+ RSP
> 
> Why not back-propagate tail_call_cnt?
> 
> It's because it's vulnerable to back-propagate it. It's unable to work
> well with the following case.
> 
> int prog1();
> int prog2();
> 
> prog1 is tail caller, and prog2 is tail callee. If we do back-propagate
> tail_call_cnt at the epilogue of prog2, can prog2 run standalone at the
> same time? The answer is NO. Otherwise, there will be a register to be
> polluted, which will make kernel crash.
> 
> Can tail_call_cnt store at other place instead of the stack of bpf prog?
> 
> I'm not able to infer a better place to store tail_call_cnt. It's not a
> working inference to store it at ctx or on the stack of bpf prog's
> caller.
> 
> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 120 +++++++++++++++++++++++-------------
>  1 file changed, 76 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8c10d9abc2394..8ad6368353c2b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -256,7 +256,7 @@ struct jit_context {
>  /* Number of bytes emit_patch() needs to generate instructions */
>  #define X86_PATCH_SIZE		5
>  /* Number of bytes that will be skipped on tailcall */
> -#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
> +#define X86_TAIL_CALL_OFFSET	(24 + ENDBR_INSN_SIZE)
>  
>  static void push_r12(u8 **pprog)
>  {
> @@ -304,6 +304,25 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
>  	*pprog = prog;
>  }
>  

[..]

> +static void emit_nops(u8 **pprog, int len)
> +{
> +	u8 *prog = *pprog;
> +	int i, noplen;
> +
> +	while (len > 0) {
> +		noplen = len;
> +
> +		if (noplen > ASM_NOP_MAX)
> +			noplen = ASM_NOP_MAX;
> +
> +		for (i = 0; i < noplen; i++)
> +			EMIT1(x86_nops[noplen][i]);
> +		len -= noplen;
> +	}
> +
> +	*pprog = prog;
> +}

From high level - makes sense to me.
I'll leave a thorough review to the people who understand more :-)
I see Maciej commenting on your original "Fix tailcall infinite loop"
series.

One suggestion I have is: the changes to 'memcpy(prog, x86_nops[5],
X86_PATCH_SIZE);' and this emit_nops move here don't seem like
they actually belong to this patch. Maybe do them separately?

