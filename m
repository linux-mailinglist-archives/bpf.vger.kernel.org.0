Return-Path: <bpf+bounces-20108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C0A83994A
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 20:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10340291FAE
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 19:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E259811F5;
	Tue, 23 Jan 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ee+fcp3e"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEE6481DC
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036840; cv=none; b=e4HIW9XbwcWRJITS2tNbLkjgz0HBHIaVjCTbO7vFYwuIoH2CFQLFrBZjguN/p5X60k8HMlBndP1eH0T9nxqnCpO5GgTYxK1txFqIZhhJM9s3H9yoke7+Sp+j7g8CJ8WZXj72yIXpCdS0Vi8QRnpWiXe/AYdmYRdT+bc7H2SauLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036840; c=relaxed/simple;
	bh=T1ojnkDmieNUMaMydDicnh2ZYXE6abGTtCW1fNinP3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcqKxlaH8ivRhm/KluFy060odjQccslIXpIFjoX7hzdl7tTcKyr5qQJRduwFLqn7GLdjpoe3V4KenY8mdTGTMI7i5aPiTkIvbUXpO6uz28pirnak0drEol8+i97MPx8fOQ6R1IAvOjWfIDlAS7aK8AUWDYpeRz79s2eAYZb/p1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ee+fcp3e; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e2247f21-3400-42b3-b346-a743bbce7677@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706036837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCDacNONIVJ/nJUMw1gdlDXfnAzHvUXGGwp1+atxAo8=;
	b=ee+fcp3eRLoLkpIzrhkbeD5mGthoxUdACK5aCnxtH/jFZaatDDYbhXp0BRnJMd7NDWBQ5U
	6pbcF6aj2Ve5GRYexQBu32PU3jNIEr2o3BtcdqBQd87H27L54ZEuuSgMZH6Il4B0CbMTd9
	IVhY6fexOiVLwFjPHrg3Xz1WWp6xnE8=
Date: Tue, 23 Jan 2024 11:07:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: use r constraint instead of p constraint in
 selftests
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>
References: <20240123181309.19853-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240123181309.19853-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/23/24 10:13 AM, Jose E. Marchesi wrote:
> Some of the BPF selftests use the "p" constraint in inline assembly
> snippets, for input operands for MOV (rN = rM) instructions.
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
>
> Which is what GCC would generate with -O0.  Whether this is by chance
> or by design, the compiler shouln't be expected to do that reload
> driven by the "p" constraint.
>
> This patch changes the usage of the "p" constraint in the BPF
> selftests macros to use the "r" constraint instead.  If a register is
> what is required, we should let the compiler know.
>
> Previous discussion in bpf@vger:
> https://lore.kernel.org/bpf/87h6p5ebpb.fsf@oracle.com/T/#ef0df83d6975c34dff20bf0dd52e078f5b8ca2767
>
> Tested in bpf-next master.
> No regressions.
>
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


