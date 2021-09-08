Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E8D4039A0
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 14:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhIHMV2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 08:21:28 -0400
Received: from www62.your-server.de ([213.133.104.62]:58118 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhIHMV2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 08:21:28 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mNwYs-0002bD-Bc; Wed, 08 Sep 2021 14:20:18 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mNwYs-000Faz-4V; Wed, 08 Sep 2021 14:20:18 +0200
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org, linux-mm@kvack.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com,
        Luigi Rizzo <lrizzo@google.com>, liam.howlett@oracle.com,
        akpm@linux-foundation.org
References: <20210908044427.3632119-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ebcddf07-f329-05fa-8fdc-b2b9d6b0127b@iogearbox.net>
Date:   Wed, 8 Sep 2021 14:20:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210908044427.3632119-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26288/Wed Sep  8 10:22:21 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/8/21 6:44 AM, Yonghong Song wrote:
> Current bpf-next bpf selftest "get_stack_raw_tp" triggered the warning:
> 
>    [ 1411.304463] WARNING: CPU: 3 PID: 140 at include/linux/mmap_lock.h:164 find_vma+0x47/0xa0
>    [ 1411.304469] Modules linked in: bpf_testmod(O) [last unloaded: bpf_testmod]
>    [ 1411.304476] CPU: 3 PID: 140 Comm: systemd-journal Tainted: G        W  O      5.14.0+ #53
>    [ 1411.304479] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>    [ 1411.304481] RIP: 0010:find_vma+0x47/0xa0
>    [ 1411.304484] Code: de 48 89 ef e8 ba f5 fe ff 48 85 c0 74 2e 48 83 c4 08 5b 5d c3 48 8d bf 28 01 00 00 be ff ff ff ff e8 2d 9f d8 00 85 c0 75 d4 <0f> 0b 48 89 de 48 8
>    [ 1411.304487] RSP: 0018:ffffabd440403db8 EFLAGS: 00010246
>    [ 1411.304490] RAX: 0000000000000000 RBX: 00007f00ad80a0e0 RCX: 0000000000000000
>    [ 1411.304492] RDX: 0000000000000001 RSI: ffffffff9776b144 RDI: ffffffff977e1b0e
>    [ 1411.304494] RBP: ffff9cf5c2f50000 R08: ffff9cf5c3eb25d8 R09: 00000000fffffffe
>    [ 1411.304496] R10: 0000000000000001 R11: 00000000ef974e19 R12: ffff9cf5c39ae0e0
>    [ 1411.304498] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9cf5c39ae0e0
>    [ 1411.304501] FS:  00007f00ae754780(0000) GS:ffff9cf5fba00000(0000) knlGS:0000000000000000
>    [ 1411.304504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [ 1411.304506] CR2: 000000003e34343c CR3: 0000000103a98005 CR4: 0000000000370ee0
>    [ 1411.304508] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    [ 1411.304510] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    [ 1411.304512] Call Trace:
>    [ 1411.304517]  stack_map_get_build_id_offset+0x17c/0x260
>    [ 1411.304528]  __bpf_get_stack+0x18f/0x230
>    [ 1411.304541]  bpf_get_stack_raw_tp+0x5a/0x70
>    [ 1411.305752] RAX: 0000000000000000 RBX: 5541f689495641d7 RCX: 0000000000000000
>    [ 1411.305756] RDX: 0000000000000001 RSI: ffffffff9776b144 RDI: ffffffff977e1b0e
>    [ 1411.305758] RBP: ffff9cf5c02b2f40 R08: ffff9cf5ca7606c0 R09: ffffcbd43ee02c04
>    [ 1411.306978]  bpf_prog_32007c34f7726d29_bpf_prog1+0xaf/0xd9c
>    [ 1411.307861] R10: 0000000000000001 R11: 0000000000000044 R12: ffff9cf5c2ef60e0
>    [ 1411.307865] R13: 0000000000000005 R14: 0000000000000000 R15: ffff9cf5c2ef6108
>    [ 1411.309074]  bpf_trace_run2+0x8f/0x1a0
>    [ 1411.309891] FS:  00007ff485141700(0000) GS:ffff9cf5fae00000(0000) knlGS:0000000000000000
>    [ 1411.309896] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [ 1411.311221]  syscall_trace_enter.isra.20+0x161/0x1f0
>    [ 1411.311600] CR2: 00007ff48514d90e CR3: 0000000107114001 CR4: 0000000000370ef0
>    [ 1411.312291]  do_syscall_64+0x15/0x80
>    [ 1411.312941] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    [ 1411.313803]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>    [ 1411.314223] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    [ 1411.315082] RIP: 0033:0x7f00ad80a0e0
>    [ 1411.315626] Call Trace:
>    [ 1411.315632]  stack_map_get_build_id_offset+0x17c/0x260
> 
> To reproduce, first build `test_progs` binary:
>    make -C tools/testing/selftests/bpf -j60
> and then run the binary at tools/testing/selftests/bpf directory:
>    ./test_progs -t get_stack_raw_tp
> 
> The warning is due to commit 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to find_vma*()")
> which added mmap_assert_locked() in find_vma() function. The mmap_assert_locked() function
> asserts that mm->mmap_lock needs to be held. But this is not the case for
> bpf_get_stack() or bpf_get_stackid() helper (kernel/bpf/stackmap.c), which
> uses mmap_read_trylock_non_owner() instead. Since mm->mmap_lock is not held
> in bpf_get_stack[id]() use case, the above warning is emitted during test run.
> 
> This patch added function find_vma_no_check() which does not have mmap_assert_locked() call and
> bpf_get_stack[id]() helpers call find_vma_no_check() instead. This resolved the above warning.
> 
> I didn't use __find_vma() name because it has been used in drivers/gpu/drm/i915/i915_gpu_error.c:
>      static struct i915_vma_coredump *
>      __find_vma(struct i915_vma_coredump *vma, const char *name) { ... }
> 
> Cc: Luigi Rizzo <lrizzo@google.com>
> Fixes: 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to find_vma*()")
> Signed-off-by: Yonghong Song <yhs@fb.com>

Luigi / Liam / Andrew, if the below looks reasonable to you, any objections to route the
fix with your ACKs via bpf tree to Linus (or strong preference via -mm fixes)?

Thanks,
Daniel

> ---
>   include/linux/mm.h    | 2 ++
>   kernel/bpf/stackmap.c | 2 +-
>   mm/mmap.c             | 9 +++++++--
>   3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 50e2c2914ac2..ba7a11d900f5 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2669,6 +2669,8 @@ extern int expand_upwards(struct vm_area_struct *vma, unsigned long address);
>   #endif
>   
>   /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
> +extern struct vm_area_struct * find_vma_no_check(struct mm_struct * mm,
> +						 unsigned long addr);
>   extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
>   extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned long addr,
>   					     struct vm_area_struct **pprev);
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index e8eefdf8cf3e..838a2c141497 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -190,7 +190,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>   	}
>   
>   	for (i = 0; i < trace_nr; i++) {
> -		vma = find_vma(current->mm, ips[i]);
> +		vma = find_vma_no_check(current->mm, ips[i]);
>   		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
>   			/* per entry fall back to ips */
>   			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 88dcc5c25225..8d5e340114f8 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2270,12 +2270,11 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>   EXPORT_SYMBOL(get_unmapped_area);
>   
>   /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
> -struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
> +struct vm_area_struct *find_vma_no_check(struct mm_struct *mm, unsigned long addr)
>   {
>   	struct rb_node *rb_node;
>   	struct vm_area_struct *vma;
>   
> -	mmap_assert_locked(mm);
>   	/* Check the cache first. */
>   	vma = vmacache_find(mm, addr);
>   	if (likely(vma))
> @@ -2302,6 +2301,12 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>   	return vma;
>   }
>   
> +struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
> +{
> +	mmap_assert_locked(mm);
> +	return find_vma_no_check(mm, addr);
> +}
> +
>   EXPORT_SYMBOL(find_vma);
>   
>   /*
> 

