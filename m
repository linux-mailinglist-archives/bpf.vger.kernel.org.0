Return-Path: <bpf+bounces-64457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE68B12D47
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 03:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8E11897E13
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 01:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403F372633;
	Sun, 27 Jul 2025 01:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ae1MjPUZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327413AF2;
	Sun, 27 Jul 2025 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753578051; cv=none; b=P15xlYB/VF6XHMzoPWxKITAtUzkIi3GioNtN+k6eujbl4DxF8tyTe6lsp+KklPj1eXaGPDC0LRL8pOLrMEOUoRdJA0aO95ElvJcHI+h36VslLf9eVt/ubg8+DmELMEd7OB9C9gM630UNwH15tUghu50W8lx7jUJ8eujR60XwCpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753578051; c=relaxed/simple;
	bh=i04joahZ7AlXGF/TYePnuX2oiqMpq4D4TwWOHYF//Ac=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lsWCdQ7jv+S5fblPPBkki2pnVUA7JmxgRr8kVLDSMXKJ0f6Y8LtvyfXnhnIgHagQ5+ekWeuFLWIIDkWJ0tJLszzyPBHnFDo0egtAjhTBlrjtDRwV2zBdo2SkDSUXbvNN6PwiftpLNEc4h4W02zGhplPAOKzOckYCO4TVzwtej8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ae1MjPUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F68C4CEED;
	Sun, 27 Jul 2025 01:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753578051;
	bh=i04joahZ7AlXGF/TYePnuX2oiqMpq4D4TwWOHYF//Ac=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ae1MjPUZLc9E5viz7ZJ3lHJaqmHt0f1OmsK5o5DOi5OmHQtWlvck2OCHuKHBWUSer
	 CdygWA4v0OCmd3ToI16uJ6XdDjZZH53QW/RfB82f1vX96OXes34slei/LQqvM4+KcV
	 q5/CEBXRoAubZMzCJThSFSzW6wZmmh5PRxXNqg0CLqc7vaiSE5wOjzo5p+ehwev477
	 H0P5K05TbW0QEOw9nQGqrbYrLmIqJJMh++NqYYdTUX+r0YDp2pVwHspY/af6lbYc6N
	 zi6ghsvSlEG9ULL9E41qOk/Qsa8k++o+nbC9Cbim2sTHMLgB2c1AfNHKGB1QVgMIgG
	 2t1jP/GqbckWQ==
Message-ID: <c4bf63161e13ce1b51a288b1fd0f3fb0b1170f22.camel@kernel.org>
Subject: Re: [PATCH v4 0/5] Support trampoline for LoongArch
From: Geliang Tang <geliang@kernel.org>
To: Chenghao Duan <duanchenghao@kylinos.cn>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, yangtiezhu@loongson.cn, 
	hengqi.chen@gmail.com, chenhuacai@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, 	guodongtai@kylinos.cn, youling.tang@linux.dev,
 jianghaoran@kylinos.cn, 	vincent.mc.li@gmail.com
Date: Sun, 27 Jul 2025 09:00:43 +0800
In-Reply-To: <20250724141929.691853-1-duanchenghao@kylinos.cn>
References: <20250724141929.691853-1-duanchenghao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chenghao, Huacai, Tuezhu,

I first discovered this Loongarch BPF trampoline issue when debugging
MPTCP BPF selftests on a Loongarch machine last June (see my commit
eef0532e900c "selftests/bpf: Null checks for links in bpf_tcp_ca"), and
reported it to Huachui. Tiezhu and I started implementing BPF
trampoline last June. I also called on more Chinese kernel engineers to
participate in the development of the Loongarch BPF trampoline at the
openEuler Developer Day 2024 and CLSF 2024 conferences. Although this
work was finally handed over to Chenghao, it is also necessary to
mention me as the reporter and our early developers in the commit log.

Thanks,
-Geliang

On Thu, 2025-07-24 at 22:19 +0800, Chenghao Duan wrote:
> v4:
> 1. Delete the #3 patch of version V3.
> 
> 2. Add 5 NOP instructions in build_prologue().
>    Reserve space for the move_imm + jirl instruction.
> 
> 3. Differentiate between direct jumps and ftrace jumps of trampoline:
>    direct jumps skip 5 instructions.
>    ftrace jumps skip 2 instructions.
> 
> 4. Remove the generation of BL jump instructions in
> emit_jump_and_link().
>    After the trampoline ends, it will jump to the specified register.
>    The BL instruction writes PC+4 to r1 instead of allowing the
>    specification of rd.
> 
> ---------------------------------------------------------------------
> --
> Historical Version:
> v3:
> 1. Patch 0003 adds EXECMEM_BPF memory type to the execmem subsystem.
> 
> 2. Align the size calculated by arch_bpf_trampoline_size to page
> boundaries.
> 
> 3. Add the flush icache operation to larch_insn_text_copy.
> 
> 4. Unify the implementation of bpf_arch_xxx into the patch
> "0004-LoongArch-BPF-Add-bpf_arch_xxxxx-support-for-Loong.patch".
> 
> 5. Change the patch order. Move the patch
> "0002-LoongArch-BPF-Update-the-code-to-rename-validate_.patch" before
> "0005-LoongArch-BPF-Add-bpf-trampoline-support-for-Loon.patch".
> 
> URL for version v3:
> https://lore.kernel.org/all/20250709055029.723243-1-duanchenghao@kylinos.cn/
> ---------
> v2:
> 1. Change the fixmap in the instruction copy function to
> set_memory_xxx.
> 
> 2. Change the implementation method of the following code.
> 	- arch_alloc_bpf_trampoline
> 	- arch_free_bpf_trampoline
> 	Use the BPF core's allocation and free functions.
> 
> 	- bpf_arch_text_invalidate
> 	Operate with the function larch_insn_text_copy that carries
> 	memory attribute modifications.
> 
> 3. Correct the incorrect code formatting.
> 
> URL for version v2:
> https://lore.kernel.org/all/20250618105048.1510560-1-duanchenghao@kylinos.cn/
> ---------
> v1:
> Support trampoline for LoongArch. The following feature tests have
> been
> completed:
> 	1. fentry
> 	2. fexit
> 	3. fmod_ret
> 
> TODO: The support for the struct_ops feature will be provided in
> subsequent patches.
> 
> URL for version v1:
> https://lore.kernel.org/all/20250611035952.111182-1-duanchenghao@kylinos.cn/
> ---------------------------------------------------------------------
> --
> 
> Chenghao Duan (4):
>   LoongArch: Add larch_insn_gen_{beq,bne} helpers
>   LoongArch: BPF: Update the code to rename validate_code to
>     validate_ctx
>   LoongArch: BPF: Add bpf_arch_xxxxx support for Loongarch
>   LoongArch: BPF: Add bpf trampoline support for Loongarch
> 
> Tiezhu Yang (1):
>   LoongArch: BPF: Add struct ops support for trampoline
> 
>  arch/loongarch/include/asm/inst.h |   3 +
>  arch/loongarch/kernel/inst.c      |  60 ++++
>  arch/loongarch/net/bpf_jit.c      | 521
> +++++++++++++++++++++++++++++-
>  arch/loongarch/net/bpf_jit.h      |   6 +
>  4 files changed, 589 insertions(+), 1 deletion(-)

