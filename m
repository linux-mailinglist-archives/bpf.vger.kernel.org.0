Return-Path: <bpf+bounces-42572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78E69A5998
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 06:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF5EB227E6
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 04:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257001CEEAF;
	Mon, 21 Oct 2024 04:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ReO/d4C3"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E8A1940B0
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 04:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729485884; cv=none; b=kX7mwlRlasyaLwSdWHB8f0o3ZwGVKxaogy4IKcsePrMBMY8c2w7bVK64KLxdYEON5PQ4Z5L9YYMRuAG+Qs6LVHSkCggin1b3JYE3E3uUtM63GE069e79OfDDdm69fSjdES97+7b5vcTIFEZqduYaTWE6Q6Zux8tNrbiSS6e26og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729485884; c=relaxed/simple;
	bh=4LIdq9nA0sKugyd8rtTv8xkXFrK1SAZG0uMegWMIC50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFcFs+iVDlYSWZn2s5lk+UFXhLKifq/Pb0ReRHAD+76eLkMPq47KIsddD5XxYSJmDj+mmZKboqsH9gCxF9lmBCBCq9LfCoMBKj/ZracXDmD+05wjdPOzLB5XyxXmSH1cpOy7z8Hh9zh5cef15fqVkTdvLU9l179N7tKO5t26W3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ReO/d4C3; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <19985cb7-9c32-471d-8e35-02fc7b7998c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729485879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e05oiLk2gfblA5mAErTL92rFlTFAiq6x69LcPdFyEwE=;
	b=ReO/d4C3zJypr+vFk22sFu31dPI0NvQ55+z6/EPNqN9BI1STl5FhR647ddwUj6DoSq2ZIz
	fSF7oFVX9Qc3e2dDKHfJRub1p0domg1IXo9iHqBu3R5MeDRgpL714qjycxPFbRDR0aYo/H
	Ux8YcI+4WPn1h/C4+bUDb2swQ8IOHCY=
Date: Sun, 20 Oct 2024 21:44:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 7/9] bpf, x86: Add jit support for private
 stack
Content-Language: en-GB
To: kernel test robot <lkp@intel.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241017223214.3177977-1-yonghong.song@linux.dev>
 <202410210358.dvPfsO1C-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <202410210358.dvPfsO1C-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/20/24 12:52 PM, kernel test robot wrote:
> Hi Yonghong,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/bpf-Allow-each-subprog-having-stack-size-of-512-bytes/20241018-063530
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20241017223214.3177977-1-yonghong.song%40linux.dev
> patch subject: [PATCH bpf-next v5 7/9] bpf, x86: Add jit support for private stack
> config: x86_64-randconfig-122-20241021 (https://download.01.org/0day-ci/archive/20241021/202410210358.dvPfsO1C-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241021/202410210358.dvPfsO1C-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410210358.dvPfsO1C-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>>> arch/x86/net/bpf_jit_comp.c:1487:44: sparse: sparse: cast removes address space '__percpu' of expression
>     arch/x86/net/bpf_jit_comp.c:1488:31: sparse: sparse: cast removes address space '__percpu' of expression
>     arch/x86/net/bpf_jit_comp.c:2073:54: sparse: sparse: cast truncates bits from constant value (800000a00000 becomes a00000)
>
> vim +/__percpu +1487 arch/x86/net/bpf_jit_comp.c
>
>    1477	
>    1478	static void emit_root_priv_frame_ptr(u8 **pprog, struct bpf_prog *bpf_prog,
>    1479					     u32 orig_stack_depth)
>    1480	{
>    1481		void __percpu *priv_frame_ptr;
>    1482		u8 *prog = *pprog;
>    1483	
>    1484		priv_frame_ptr = bpf_prog->aux->priv_stack_ptr + orig_stack_depth;
>    1485	
>    1486		/* movabs r9, priv_frame_ptr */
>> 1487		emit_mov_imm64(&prog, X86_REG_R9, (long) priv_frame_ptr >> 32,
>    1488			       (u32) (long) priv_frame_ptr);
>    1489	#ifdef CONFIG_SMP
>    1490		/* add <r9>, gs:[<off>] */
>    1491		EMIT2(0x65, 0x4c);
>    1492		EMIT3(0x03, 0x0c, 0x25);
>    1493		EMIT((u32)(unsigned long)&this_cpu_off, 4);
>    1494	#endif
>    1495		*pprog = prog;
>    1496	}
>    1497	

Looks like the following change will fix the problem:

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 86ebca32befc..9a885cbefef4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1484,8 +1484,8 @@ static void emit_root_priv_frame_ptr(u8 **pprog, struct bpf_prog *bpf_prog,
         priv_frame_ptr = bpf_prog->aux->priv_stack_ptr + orig_stack_depth;
  
         /* movabs r9, priv_frame_ptr */
-       emit_mov_imm64(&prog, X86_REG_R9, (long) priv_frame_ptr >> 32,
-                      (u32) (long) priv_frame_ptr);
+       emit_mov_imm64(&prog, X86_REG_R9, (__force long) priv_frame_ptr >> 32,
+                      (u32) (__force long) priv_frame_ptr);
  #ifdef CONFIG_SMP
         /* add <r9>, gs:[<off>] */
         EMIT2(0x65, 0x4c);

I will fix the issue in the next revision.


