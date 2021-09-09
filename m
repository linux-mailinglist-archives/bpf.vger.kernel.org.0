Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C9F4058BD
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245217AbhIIOQw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 10:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244751AbhIIOQq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 10:16:46 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC26C0F912D
        for <bpf@vger.kernel.org>; Thu,  9 Sep 2021 05:35:01 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id ay33so1515196qkb.10
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dzv1otaVillljBApZ61+C9DPuFqhaGAlld9tHoBrw6U=;
        b=ed/K1n5ByoLN6mgfet+MZORqBRa0y7W2dCICZxGy571oQUh1kGLXSlFn3DvkOO0BQk
         0IOjKAeYJ/lamhAdNF2SoSG6mIOj6apOsbaFpQFwFYsb9T7X2czFhJhzTrA5eKnXZ3SR
         gq3+SDCthDUnBNkezYLKN65dMCJC5byTT2UmvORtCJYFo7aotxLmzkhVooD3UFSnrOet
         Es/TRLW9o31hymxW1TT/1iTnGZaUhY8g3ZkJwC1uKSLQhNTZEiBmVn2BhoOjhKHbNw8W
         q2h08VFlwMjwmVoydf4LB16II24ADknUYrXcZ2P61z+n5SBwXSO6eL55mfmPCiN9LomN
         Mj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dzv1otaVillljBApZ61+C9DPuFqhaGAlld9tHoBrw6U=;
        b=rIqsv4SZcZ2/wLy5VK6oBO9rBheosv48t4Auljy6UM1r+5+MrGxV/6jgZMwcYy/CTn
         bDBcgVHP9MQsGB2b+dzLLukVTILj+0irjkFmiSbhq2YOPnYDeJRc0C/3H7a6nORo6xGT
         sucya2wPRa3J/mVNYy+TxV3Njbcr5CD3O4u3ySGzDoAS8NW+KA/2w2Uns2iD9/mSCSJt
         prBKmLpsVw6f7I/gU5A9OKE04FKM/myXtEE8bCpjFb/DyguMI1eCk2wC3zYDQgIj3fuV
         of2e/mQVMb7PtRcNVeXhzOBxptWIEpzeGV/jndfU0/XIJ9Zh2ppQ5Z/7WK22Cif5RLQd
         +Scg==
X-Gm-Message-State: AOAM53109IO8OH2lq7JM3sgdCZvXYt+07oxvPud6Ag84IKEhAguNGGOF
        P5Z+0xJ/1i8Czk68dtKyOaOxzw==
X-Google-Smtp-Source: ABdhPJxhInboz2BGmy908czVCSc26TAJDIDVPJMvIGZwSTOA4EfFLKO6hyflgkCUI137jA7tOqoP2w==
X-Received: by 2002:a05:620a:1446:: with SMTP id i6mr2518861qkl.361.1631190900294;
        Thu, 09 Sep 2021 05:35:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id i16sm977844qtq.52.2021.09.09.05.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:34:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mOJGd-00FBhQ-2M; Thu, 09 Sep 2021 09:34:59 -0300
Date:   Thu, 9 Sep 2021 09:34:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Luigi Rizzo <lrizzo@google.com>
Subject: Re: [PATCH bpf-next v4] bpf: fix lockdep warning triggered by
 stack_map_get_build_id_offset()
Message-ID: <20210909123459.GC3544071@ziepe.ca>
References: <20210909060245.2966358-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909060245.2966358-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 08, 2021 at 11:02:45PM -0700, Yonghong Song wrote:
> Current bpf-next bpf selftest "get_stack_raw_tp" triggered the warning:
> 
>   [ 1411.304463] WARNING: CPU: 3 PID: 140 at include/linux/mmap_lock.h:164 find_vma+0x47/0xa0
>   [ 1411.304469] Modules linked in: bpf_testmod(O) [last unloaded: bpf_testmod]
>   [ 1411.304476] CPU: 3 PID: 140 Comm: systemd-journal Tainted: G        W  O      5.14.0+ #53
>   [ 1411.304479] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>   [ 1411.304481] RIP: 0010:find_vma+0x47/0xa0
>   [ 1411.304484] Code: de 48 89 ef e8 ba f5 fe ff 48 85 c0 74 2e 48 83 c4 08 5b 5d c3 48 8d bf 28 01 00 00 be ff ff ff ff e8 2d 9f d8 00 85 c0 75 d4 <0f> 0b 48 89 de 48 8
>   [ 1411.304487] RSP: 0018:ffffabd440403db8 EFLAGS: 00010246
>   [ 1411.304490] RAX: 0000000000000000 RBX: 00007f00ad80a0e0 RCX: 0000000000000000
>   [ 1411.304492] RDX: 0000000000000001 RSI: ffffffff9776b144 RDI: ffffffff977e1b0e
>   [ 1411.304494] RBP: ffff9cf5c2f50000 R08: ffff9cf5c3eb25d8 R09: 00000000fffffffe
>   [ 1411.304496] R10: 0000000000000001 R11: 00000000ef974e19 R12: ffff9cf5c39ae0e0
>   [ 1411.304498] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9cf5c39ae0e0
>   [ 1411.304501] FS:  00007f00ae754780(0000) GS:ffff9cf5fba00000(0000) knlGS:0000000000000000
>   [ 1411.304504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 1411.304506] CR2: 000000003e34343c CR3: 0000000103a98005 CR4: 0000000000370ee0
>   [ 1411.304508] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [ 1411.304510] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [ 1411.304512] Call Trace:
>   [ 1411.304517]  stack_map_get_build_id_offset+0x17c/0x260
>   [ 1411.304528]  __bpf_get_stack+0x18f/0x230
>   [ 1411.304541]  bpf_get_stack_raw_tp+0x5a/0x70
>   [ 1411.305752] RAX: 0000000000000000 RBX: 5541f689495641d7 RCX: 0000000000000000
>   [ 1411.305756] RDX: 0000000000000001 RSI: ffffffff9776b144 RDI: ffffffff977e1b0e
>   [ 1411.305758] RBP: ffff9cf5c02b2f40 R08: ffff9cf5ca7606c0 R09: ffffcbd43ee02c04
>   [ 1411.306978]  bpf_prog_32007c34f7726d29_bpf_prog1+0xaf/0xd9c
>   [ 1411.307861] R10: 0000000000000001 R11: 0000000000000044 R12: ffff9cf5c2ef60e0
>   [ 1411.307865] R13: 0000000000000005 R14: 0000000000000000 R15: ffff9cf5c2ef6108
>   [ 1411.309074]  bpf_trace_run2+0x8f/0x1a0
>   [ 1411.309891] FS:  00007ff485141700(0000) GS:ffff9cf5fae00000(0000) knlGS:0000000000000000
>   [ 1411.309896] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 1411.311221]  syscall_trace_enter.isra.20+0x161/0x1f0
>   [ 1411.311600] CR2: 00007ff48514d90e CR3: 0000000107114001 CR4: 0000000000370ef0
>   [ 1411.312291]  do_syscall_64+0x15/0x80
>   [ 1411.312941] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [ 1411.313803]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>   [ 1411.314223] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [ 1411.315082] RIP: 0033:0x7f00ad80a0e0
>   [ 1411.315626] Call Trace:
>   [ 1411.315632]  stack_map_get_build_id_offset+0x17c/0x260
> 
> To reproduce, first build `test_progs` binary:
>   make -C tools/testing/selftests/bpf -j60
> and then run the binary at tools/testing/selftests/bpf directory:
>   ./test_progs -t get_stack_raw_tp
> 
> The warning is due to commit 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked()
> annotations to find_vma*()") which added mmap_assert_locked() in find_vma() function.
> The mmap_assert_locked() function asserts that mm->mmap_lock needs to be held. But this
> is not the case for bpf_get_stack() or bpf_get_stackid() helper (kernel/bpf/stackmap.c),
> which uses mmap_read_trylock_non_owner() instead. Since mm->mmap_lock is not held
> in bpf_get_stack[id]() use case, the above warning is emitted during test run.
> 
> This patch fixed the issue by (1). using mmap_read_trylock() instead of
> mmap_read_trylock_non_owner() to satisfy lockdep checking in find_vma(),
> and (2). droping lockdep for mmap_lock right before the irq_work_queue().
> 
> Cc: Luigi Rizzo <lrizzo@google.com>
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Fixes: 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to find_vma*()")
> Signed-off-by: Yonghong Song <yhs@fb.com>
>  kernel/bpf/stackmap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index e8eefdf8cf3e..7b7500a3724b 100644
> +++ b/kernel/bpf/stackmap.c
> @@ -179,7 +179,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  	 * with build_id.
>  	 */
>  	if (!user || !current || !current->mm || irq_work_busy ||
> -	    !mmap_read_trylock_non_owner(current->mm)) {
> +	    !mmap_read_trylock(current->mm)) {

This was the only caller of mmap_read_trylock_non_owner(), so please
delete it too

Jason
