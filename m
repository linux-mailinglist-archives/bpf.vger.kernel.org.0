Return-Path: <bpf+bounces-30646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CCD8D0188
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 15:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDA7287A4D
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 13:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9871915EFC1;
	Mon, 27 May 2024 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpD51+ht"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9CC15EFAF;
	Mon, 27 May 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816635; cv=none; b=MLhADOHjBQtBxTT52CXizWLJyqUwfKpWazF56eDQdOrx25CYbHXc6K2ytx3AIe2pvTcsecAxGlPBPJlrzRLUggTOJiO7vMnhayhtX6Qz4iHN5srFtJQMi3exkOzMSDfWQjslSTcdJbCJ/GdE6Y8ozOCYgNbeH6BJX0c6oZb2PUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816635; c=relaxed/simple;
	bh=XKIExmxJ0QbTZF18xt6QtZCjep9rcJmkPdgH9omxsFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsqcPuYRZ66ZtTpqD1/HzShpIkgSj5tbPZad4XWZDKVGJmpq1Wxpe8yZ9+d3eqgtYUsY9z2sqxmXqAiyG0fAMq2gwP5ibkpZPj8zPgJG8tQM62h7AODyslFeGKe6mDoU1+OOkBLG2snxOC8oibevv0FgKIe8KbtoKAe1mxwkSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpD51+ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FF9C32789;
	Mon, 27 May 2024 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716816634;
	bh=XKIExmxJ0QbTZF18xt6QtZCjep9rcJmkPdgH9omxsFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZpD51+htCJ6SFNZuke4BoLNDvsbG3BwXps9XuSfgY/V7RDJK8uYWK6mMo74/X1Icx
	 h+VP95NwwrBsKTJG9dhNotAvQhppQanZL4MNveYrxuY+7fVPPyBsQtRCk3ccH9ByUp
	 fHUHV2WvCNAbAydO1Lsq1Ejk55SXEhpUfJ1Wa7hyKmtiAmZjv/LsjLEZAZ7nf/xHpp
	 5yIXXe0gYaYxNXFgVpEGHZKvMP32oStRf+3rEJreqskl6VLKbUXTJpMXc1Nh2z8tkx
	 CMLIg0DckUDs4HJ0ZaIpkXiYAMjC4nJQSZZayCfl6hElOWhtLHV6Xhrf5gkCyQRW1g
	 U+CWs9DdjZ1mA==
Date: Mon, 27 May 2024 16:28:45 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [Patch bpf] vmalloc: relax is_vmalloc_or_module_addr() check
Message-ID: <ZlSKjd6-6-no-x9W@kernel.org>
References: <20240526230648.188550-1-xiyou.wangcong@gmail.com>
 <1f39f888-989f-658b-a107-90ffe1347d0f@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f39f888-989f-658b-a107-90ffe1347d0f@iogearbox.net>

On Mon, May 27, 2024 at 03:11:50PM +0200, Daniel Borkmann wrote:
> On 5/27/24 1:06 AM, Cong Wang wrote:
> > From: Cong Wang <cong.wang@bytedance.com>
> > 
> > After commit 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
> > CONFIG_BPF_JIT does not depend on CONFIG_MODULES any more and bpf jit
> > also uses the MODULES_VADDR ~ MODULES_END memory region. But
> > is_vmalloc_or_module_addr() still checks CONFIG_MODULES, which then
> > returns false for a bpf jit memory region when CONFIG_MODULES is not
> > defined. It leads to the following kernel BUG:
> > 
> > [    1.567023] ------------[ cut here ]------------
> > [    1.567883] kernel BUG at mm/vmalloc.c:745!
> > [    1.568477] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > [    1.569367] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0+ #448
> > [    1.570247] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> > [    1.570786] RIP: 0010:vmalloc_to_page+0x48/0x1ec
> > [    1.570786] Code: 0f 00 00 e8 eb 1a 05 00 b8 37 00 00 00 48 ba fe ff ff ff ff 1f 00 00 4c 03 25 76 49 c6 02 48 c1 e0 28 48 01 e8 48 39 d0 76 02 <0f> 0b 4c 89 e7 e8 bf 1a 05 00 49 8b 04 24 48 a9 9f ff ff ff 0f 84
> > [    1.570786] RSP: 0018:ffff888007787960 EFLAGS: 00010212
> > [    1.570786] RAX: 000036ffa0000000 RBX: 0000000000000640 RCX: ffffffff8147e93c
> > [    1.570786] RDX: 00001ffffffffffe RSI: dffffc0000000000 RDI: ffffffff840e32c8
> > [    1.570786] RBP: ffffffffa0000000 R08: 0000000000000000 R09: 0000000000000000
> > [    1.570786] R10: ffff888007787a88 R11: ffffffff8475d8e7 R12: ffffffff83e80ff8
> > [    1.570786] R13: 0000000000000640 R14: 0000000000000640 R15: 0000000000000640
> > [    1.570786] FS:  0000000000000000(0000) GS:ffff88806cc00000(0000) knlGS:0000000000000000
> > [    1.570786] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    1.570786] CR2: ffff888006a01000 CR3: 0000000003e80000 CR4: 0000000000350ef0
> > [    1.570786] Call Trace:
> > [    1.570786]  <TASK>
> > [    1.570786]  ? __die_body+0x1b/0x58
> > [    1.570786]  ? die+0x31/0x4b
> > [    1.570786]  ? do_trap+0x9d/0x138
> > [    1.570786]  ? vmalloc_to_page+0x48/0x1ec
> > [    1.570786]  ? do_error_trap+0xcd/0x102
> > [    1.570786]  ? vmalloc_to_page+0x48/0x1ec
> > [    1.570786]  ? vmalloc_to_page+0x48/0x1ec
> > [    1.570786]  ? handle_invalid_op+0x2f/0x38
> > [    1.570786]  ? vmalloc_to_page+0x48/0x1ec
> > [    1.570786]  ? exc_invalid_op+0x2b/0x41
> > [    1.570786]  ? asm_exc_invalid_op+0x16/0x20
> > [    1.570786]  ? vmalloc_to_page+0x26/0x1ec
> > [    1.570786]  ? vmalloc_to_page+0x48/0x1ec
> > [    1.570786]  __text_poke+0xb6/0x458
> > [    1.570786]  ? __pfx_text_poke_memcpy+0x10/0x10
> > [    1.570786]  ? __pfx___mutex_lock+0x10/0x10
> > [    1.570786]  ? __pfx___text_poke+0x10/0x10
> > [    1.570786]  ? __pfx_get_random_u32+0x10/0x10
> > [    1.570786]  ? srso_return_thunk+0x5/0x5f
> > [    1.570786]  text_poke_copy_locked+0x70/0x84
> > [    1.570786]  text_poke_copy+0x32/0x4f
> > [    1.570786]  bpf_arch_text_copy+0xf/0x27
> > [    1.570786]  bpf_jit_binary_pack_finalize+0x26/0x5a
> > [    1.570786]  bpf_int_jit_compile+0x576/0x8ad
> > [    1.570786]  ? __pfx_bpf_int_jit_compile+0x10/0x10
> > [    1.570786]  ? srso_return_thunk+0x5/0x5f
> > [    1.570786]  ? __kmalloc_node_track_caller+0x2b5/0x2e0
> > [    1.570786]  bpf_prog_select_runtime+0x7c/0x199
> > [    1.570786]  bpf_prepare_filter+0x1e9/0x25b
> > [    1.570786]  ? __pfx_bpf_prepare_filter+0x10/0x10
> > [    1.570786]  ? srso_return_thunk+0x5/0x5f
> > [    1.570786]  ? _find_next_bit+0x29/0x7e
> > [    1.570786]  bpf_prog_create+0xb8/0xe0
> > [    1.570786]  ptp_classifier_init+0x75/0xa1
> > [    1.570786]  ? __pfx_ptp_classifier_init+0x10/0x10
> > [    1.570786]  ? srso_return_thunk+0x5/0x5f
> > [    1.570786]  ? register_pernet_subsys+0x36/0x42
> > [    1.570786]  ? srso_return_thunk+0x5/0x5f
> > [    1.570786]  sock_init+0x99/0xa3
> > [    1.570786]  ? __pfx_sock_init+0x10/0x10
> > [    1.570786]  do_one_initcall+0x104/0x2c4
> > [    1.570786]  ? __pfx_do_one_initcall+0x10/0x10
> > [    1.570786]  ? parameq+0x25/0x2d
> > [    1.570786]  ? rcu_is_watching+0x1c/0x3c
> > [    1.570786]  ? trace_kmalloc+0x81/0xb2
> > [    1.570786]  ? srso_return_thunk+0x5/0x5f
> > [    1.570786]  ? __kmalloc+0x29c/0x2c7
> > [    1.570786]  ? srso_return_thunk+0x5/0x5f
> > [    1.570786]  do_initcalls+0xf9/0x123
> > [    1.570786]  kernel_init_freeable+0x24f/0x289
> > [    1.570786]  ? __pfx_kernel_init+0x10/0x10
> > [    1.570786]  kernel_init+0x19/0x13a
> > [    1.570786]  ret_from_fork+0x24/0x41
> > [    1.570786]  ? __pfx_kernel_init+0x10/0x10
> > [    1.570786]  ret_from_fork_asm+0x1a/0x30
> > [    1.570786]  </TASK>
> > [    1.570819] ---[ end trace 0000000000000000 ]---
> > [    1.571463] RIP: 0010:vmalloc_to_page+0x48/0x1ec
> > [    1.572111] Code: 0f 00 00 e8 eb 1a 05 00 b8 37 00 00 00 48 ba fe ff ff ff ff 1f 00 00 4c 03 25 76 49 c6 02 48 c1 e0 28 48 01 e8 48 39 d0 76 02 <0f> 0b 4c 89 e7 e8 bf 1a 05 00 49 8b 04 24 48 a9 9f ff ff ff 0f 84
> > [    1.574632] RSP: 0018:ffff888007787960 EFLAGS: 00010212
> > [    1.575129] RAX: 000036ffa0000000 RBX: 0000000000000640 RCX: ffffffff8147e93c
> > [    1.576097] RDX: 00001ffffffffffe RSI: dffffc0000000000 RDI: ffffffff840e32c8
> > [    1.577084] RBP: ffffffffa0000000 R08: 0000000000000000 R09: 0000000000000000
> > [    1.578077] R10: ffff888007787a88 R11: ffffffff8475d8e7 R12: ffffffff83e80ff8
> > [    1.578810] R13: 0000000000000640 R14: 0000000000000640 R15: 0000000000000640
> > [    1.579823] FS:  0000000000000000(0000) GS:ffff88806cc00000(0000) knlGS:0000000000000000
> > [    1.580992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    1.581869] CR2: ffff888006a01000 CR3: 0000000003e80000 CR4: 0000000000350ef0
> > [    1.582800] Kernel panic - not syncing: Fatal exception
> > [    1.583765] ---[ end Kernel panic - not syncing: Fatal exception ]---
> > 
> > Fixes: 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> 
> Thanks for the fix!
> 
> Mike/Luis, do you plan to pick this up or rather prefer if we route it to
> Linus (with your Ack assuming it looks good to you)?

I'm fine with routing this via bpf, but usually vmalloc patches go via mm
tree, so it's more up to Andrew.
 
> Thanks,
> Daniel

-- 
Sincerely yours,
Mike.

