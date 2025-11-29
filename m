Return-Path: <bpf+bounces-75765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAF0C94650
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 19:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D955E3A4695
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 18:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA1016F288;
	Sat, 29 Nov 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="imequqQ+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE92F1E5714;
	Sat, 29 Nov 2025 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764439619; cv=none; b=Zf8a0svX+tosz/xJVbrc5njc8AEkTmgIB5Doc8HLHWB0OeVCKi8LfMNjkl5juo1VDuoYJgCXqp3xWmnPMAz6gV5UiVeIX0tAQYIBwBquPFGs1moNIxputE4vQTFi0EXQggkMidmnjggOoUp3nhNlUIi3aROXnlJjxZmNBQe3Iqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764439619; c=relaxed/simple;
	bh=nHDT+vnVr9ZxoQNQJxT+ttjh4quzdU+UxPDtwJWJq9Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hknBEV+J9R3Y8JbE3hLjch/Q7FwQza+WAzkEskC3QAwVGvxxMWvhLxcH/3wz75+CIFHtUcg6rBp5DQLYBMBPSRpZyjMCfJjEDwhYq629Ux8h/QAXjM98Qey4el0mQq1xgPu5Cy1gNB74rnYGzcRYgVd1mqsCPV54GOWEZJdPpJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=imequqQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952E3C4CEF7;
	Sat, 29 Nov 2025 18:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1764439619;
	bh=nHDT+vnVr9ZxoQNQJxT+ttjh4quzdU+UxPDtwJWJq9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=imequqQ+pT6INKeFynsxEJTEi5ZQUOItUSepXeIIj0XlNMIRMi2GdRFp1LsQlnirL
	 Ibr6hf35eNoBXFqol2lu4UpPb4GkIS3TOn2Y5YI+pLWuYA6hDM5l36aflaAbALkxVc
	 FLdxZYEfksXfgRkwCy+oGFJKtKjO/B2SCEXq39VA=
Date: Sat, 29 Nov 2025 10:06:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, kevin.brodsky@arm.com, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, urezki@gmail.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 stable@vger.kernel.org, Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH] kasan: hw_tags: fix a false positive case of vrealloc
 in alloced size
Message-Id: <20251129100658.6b25799da5ace00c3a6d0f42@linux-foundation.org>
In-Reply-To: <20251129123648.1785982-1-yeoreum.yun@arm.com>
References: <20251129123648.1785982-1-yeoreum.yun@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 29 Nov 2025 12:36:47 +0000 Yeoreum Yun <yeoreum.yun@arm.com> wrote:

> When a memory region is allocated with vmalloc() and later expanded with
> vrealloc() — while still within the originally allocated size —
> KASAN may report a false positive because
> it does not update the tags for the newly expanded portion of the memory.
> 
> A typical example of this pattern occurs in the BPF verifier,
> and the following is a related false positive report:
> 
> [ 2206.486476] ==================================================================
> [ 2206.486509] BUG: KASAN: invalid-access in __memcpy+0xc/0x30
> [ 2206.486607] Write at addr f5ff800083765270 by task test_progs/205
> [ 2206.486664] Pointer tag: [f5], memory tag: [fe]
> [ 2206.486703]
> [ 2206.486745] CPU: 4 UID: 0 PID: 205 Comm: test_progs Tainted: G           OE       6.18.0-rc7+ #145 PREEMPT(full)
> [ 2206.486861] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [ 2206.486897] Hardware name:  , BIOS
> [ 2206.486932] Call trace:
> [ 2206.486961]  show_stack+0x24/0x40 (C)
> [ 2206.487071]  __dump_stack+0x28/0x48
> [ 2206.487182]  dump_stack_lvl+0x7c/0xb0
> [ 2206.487293]  print_address_description+0x80/0x270
> [ 2206.487403]  print_report+0x94/0x100
> [ 2206.487505]  kasan_report+0xd8/0x150
> [ 2206.487606]  __do_kernel_fault+0x64/0x268
> [ 2206.487717]  do_bad_area+0x38/0x110
> [ 2206.487820]  do_tag_check_fault+0x38/0x60
> [ 2206.487936]  do_mem_abort+0x48/0xc8
> [ 2206.488042]  el1_abort+0x40/0x70
> [ 2206.488127]  el1h_64_sync_handler+0x50/0x118
> [ 2206.488217]  el1h_64_sync+0xa4/0xa8
> [ 2206.488303]  __memcpy+0xc/0x30 (P)
> [ 2206.488412]  do_misc_fixups+0x4f8/0x1950
> [ 2206.488528]  bpf_check+0x31c/0x840
> [ 2206.488638]  bpf_prog_load+0x58c/0x658
> [ 2206.488737]  __sys_bpf+0x364/0x488
> [ 2206.488833]  __arm64_sys_bpf+0x30/0x58
> [ 2206.488920]  invoke_syscall+0x68/0xe8
> [ 2206.489033]  el0_svc_common+0xb0/0xf8
> [ 2206.489143]  do_el0_svc+0x28/0x48
> [ 2206.489249]  el0_svc+0x40/0xe8
> [ 2206.489337]  el0t_64_sync_handler+0x84/0x140
> [ 2206.489427]  el0t_64_sync+0x1bc/0x1c0
> 
> Here, 0xf5ff800083765000 is vmalloc()ed address for
> env->insn_aux_data with the size of 0x268.
> While this region is expanded size by 0x478 and initialise
> increased region to apply patched instructions,
> a false positive is triggered at the address 0xf5ff800083765270
> because __kasan_unpoison_vmalloc() with KASAN_VMALLOC_PROT_NORMAL flag only
> doesn't update the tag on increaed region.
> 
> To address this, introduces KASAN_VMALLOC_EXPAND flag which
> is used to expand vmalloc()ed memory in range of real allocated size
> to update tag for increased region.

Thanks.

> Fixes: 23689e91fb22 ("kasan, vmalloc: add vmalloc tagging for HW_TAGS”)
> Cc: <stable@vger.kernel.org>

Unfortunately this is changing the same code as "mm/kasan: fix
incorrect unpoisoning in vrealloc for KASAN",
(https://lkml.kernel.org/r/20251128111516.244497-1-jiayuan.chen@linux.dev)
which is also cc:stable.

So could you please take a look at the code in mm.git's
mm-hotfixes-unstable branch
(git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm) and base the
fix upon that?  This way everything should merge and backport nicely.



