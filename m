Return-Path: <bpf+bounces-7469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4DE777F19
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 19:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD491C21593
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 17:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C8B214E7;
	Thu, 10 Aug 2023 17:26:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FAB1E1C0
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 17:26:55 +0000 (UTC)
Received: from out-65.mta0.migadu.com (out-65.mta0.migadu.com [91.218.175.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8512702
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 10:26:53 -0700 (PDT)
Message-ID: <a4c550e4-1d65-aace-d9ba-820b89390f54@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691688412; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DYDuDmTEzK/8ypxAHYhc9PLKIKIpgIvhcUR7WlqjMw=;
	b=PJVD1JdvYRIN00s+bLVIBUK4UY6nlQsechkvU0fmjg3gmXUA7S8ksi4kZ6B4mSDT7iEtuU
	HNnYHoMIFEs63krF2mdlvuPRwv/pgIY8N5ARG3g8OpXgMgbudbNp0YEzlP7FjhN5YhxbTp
	Qgva+zGleYGCQPj2p8mXKpId6ASpPbU=
Date: Thu, 10 Aug 2023 10:26:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: Usage of "p" constraint in BPF inline asm
Content-Language: en-US
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Nick Desaulniers <ndesaulniers@google.com>
References: <87edkbnq14.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87edkbnq14.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/10/23 3:35 AM, Jose E. Marchesi wrote:
> 
> Hello.
> 
> We found that some of the BPF selftests use the "p" constraint in inline
> assembly snippets, for input operands for MOV (rN = rM) instructions.
> 
> This is mainly done via the __imm_ptr macro defined in
> tools/testing/selftests/bpf/progs/bpf_misc.h:
> 
>    #define __imm_ptr(name) [name]"p"(&name)
> 
> Example:
> 
>    int consume_first_item_only(void *ctx)
>    {
>          struct bpf_iter_num iter;
>          asm volatile (
>                  /* create iterator */
>                  "r1 = %[iter];"
>                  [...]
>                  :
>                  : __imm_ptr(iter)
>                  : CLOBBERS);
>          [...]
>    }
> 
> Little equivalent reproducer:
> 
>    int bar ()
>    {
>      int jorl;
>      asm volatile ("r1 = %a[jorl]" : : [jorl]"p"(&jorl));
>      return jorl;
>    }
> 
> The "p" constraint is a tricky one.  It is documented in the GCC manual
> section "Simple Constraints":
> 
>    An operand that is a valid memory address is allowed.  This is for
>    ``load address'' and ``push address'' instructions.
> 
>    p in the constraint must be accompanied by address_operand as the
>    predicate in the match_operand.  This predicate interprets the mode
>    specified in the match_operand as the mode of the memory reference for
>    which the address would be valid.
> 
> There are two problems:
> 
> 1. It is questionable whether that constraint was ever intended to be
>     used in inline assembly templates, because its behavior really
>     depends on compiler internals.  A "memory address" is not the same
>     than a "memory operand" or a "memory reference" (constraint "m"), and
>     in fact its usage in the template above results in an error in both
>     x86_64-linux-gnu and bpf-unkonwn-none:
> 
>       foo.c: In function ‘bar’:
>       foo.c:6:3: error: invalid 'asm': invalid expression as operand
>          6 |   asm volatile ("r1 = %[jorl]" : : [jorl]"p"(&jorl));
>            |   ^~~
> 
>     I would assume the same happens with aarch64, riscv, and most/all
>     other targets in GCC, that do not accept operands of the form A + B
>     that are not wrapped either in a const or in a memory reference.
> 
>     To avoid that error, the usage of the "p" constraint in internal GCC
>     instruction templates is supposed to be complemented by the 'a'
>     modifier, like in:
> 
>       asm volatile ("r1 = %a[jorl]" : : [jorl]"p"(&jorl));
> 
>     Internally documented (in GCC's final.cc) as:
> 
>       %aN means expect operand N to be a memory address
>          (not a memory reference!) and print a reference
>          to that address.
> 
>     That works because when the modifier 'a' is found, GCC prints an
>     "operand address", which is not the same than an "operand".
> 
>     But...
> 
> 2. Even if we used the internal 'a' modifier (we shouldn't) the 'rN =
>     rM' instruction really requires a register argument.  In cases
>     involving automatics, like in the examples above, we easily end with:
> 
>       bar:
>          #APP
>              r1 = r10-4
>          #NO_APP
> 
>     In other cases we could conceibly also end with a 64-bit label that
>     may overflow the 32-bit immediate operand of `rN = imm32'
>     instructions:
> 
>          r1 = foo
> 
>     All of which is clearly wrong.
> 
> clang happens to do "the right thing" in the current usage of __imm_ptr
> in the BPF tests, because even with -O2 it seems to "reload" the
> fp-relative address of the automatic to a register like in:
> 
>    bar:
> 	r1 = r10
> 	r1 += -4
> 	#APP
> 	r1 = r1
> 	#NO_APP

Unfortunately, the modifier 'a' won't work for clang.

$ cat t.c 
 

int bar () 
 

{ 
 

   int jorl; 
 

   asm volatile ("r1 = %a[jorl]" : : [jorl]"p"(&jorl)); 
 

   return jorl; 
 

} 
 

$ gcc -O2 -g -S t.c 
 

$ clang --target=bpf -O2 -g -S t.c 
 

clang: ../lib/Target/BPF/BPFAsmPrinter.cpp:126: virtual bool 
{anonymous}::BPFAsmPrinter::PrintAsmMemoryOperand(const 
llvm::MachineInstr*, unsigned int, const char*, llvm::raw_ostream&): 
Assertion `Offs
etMO.isImm() && "Unexpected offset for inline asm memory operand."' failed.
...

I guess BPF backend can try to add support for this 'a' modifier
if necessary.

> Which is what GCC would generate with -O0.  Whether this is by chance or
> by design (Nick, do you know?) I don't think the compiler should be
> expected to do that reload driven by the "p" constraint.
> 
> I would suggest to change that macro (and similar out of macro usages of
> the "p" constraint in selftests/bpf/progs/iters.c) to use the "r"
> constraint instead.  If a register is what is required, we should let
> the compiler know.

Could you specify what is the syntax ("r" constraint) which will work
for both clang and gcc?

> 
> Thoughts?
> 
> PS: I am aware that the x86 port of the kernel uses the "p" constraint
>      in the percpu macros (arch/x86/include/asm/percpu.h) but that usage
>      is in a different context (I would assume it is used in x86
>      instructions that get constant addresses or global addresses loaded
>      in registers and not automatics) where it seems to work well.
> 

