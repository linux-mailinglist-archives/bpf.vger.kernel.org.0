Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC156B93CF
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 13:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjCNMbV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 08:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjCNMbC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 08:31:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFC97DA1;
        Tue, 14 Mar 2023 05:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0246DB81905;
        Tue, 14 Mar 2023 12:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41046C433EF;
        Tue, 14 Mar 2023 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678796629;
        bh=bHVG6dSQimW/cFHcRzTGys9iwkQ1d8n2ulEi+M5nzlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdF7YGKaXC36EjMn9dm3L8/jG9yINq2r7GVsB8N0q2+P2axrC8HURqhe9V1+n5v0a
         dWxbWBNTOx46+825dyQN3FWk6Q04F8LwS165QGfJFb6xxzAsfEbb99Wj8SQMr3bmDd
         bGQtAI4TvcNcHAmrSFIa6d8YJK8jXNJ7GOItanp6ig46SwT20JbPJYlHwDiM8VBgDe
         9Nrvk8mwMbxdoQ6uuph6+QZQVxDADXSPSsJ3du8LWmjE88ybFaTO6WZiz0fh+dxPUl
         in+8R1liTevsB57e69InZ5ihE4DJ273JLd98UhBiB9pCATvZz25UMt1hDgYXOmBi+5
         VV8sFZQKxyW7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B2FA74049F; Tue, 14 Mar 2023 09:23:46 -0300 (-03)
Date:   Tue, 14 Mar 2023 09:23:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 0/4] perf lock contention: Improve lock symbol display
 (v1)
Message-ID: <ZBBnUlIQ5gLhoScx@kernel.org>
References: <20230313204825.2665483-1-namhyung@kernel.org>
 <ZA+ZkRYADwtFEsPt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZA+ZkRYADwtFEsPt@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Mar 13, 2023 at 06:45:53PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Mar 13, 2023 at 01:48:21PM -0700, Namhyung Kim escreveu:
> > Hello,
> > 
> > This patchset improves the symbolization of locks for -l/--lock-addr mode.
> > As of now it only shows global lock symbols present in the kallsyms.  But
> > we can add some more lock symbols by traversing pointers in the BPF program.
> > 
> > For example, mmap_lock can be reached from the mm_struct of the current task
> > (task_struct->mm->mmap_lock) and we can compare the address of the give lock
> > with it.  Similarly I've added 'siglock' for current->sighand->siglock.

Hey, we can go a bit further by using something like pahole's
--expand_types and --expand_pointers and play iterating a type members
and looking for locks, like:

⬢[acme@toolbox pahole]$ pahole task_struct | grep spinlock_t
	spinlock_t                 alloc_lock;           /*  3280     4 */
	raw_spinlock_t             pi_lock;              /*  3284     4 */
	seqcount_spinlock_t        mems_allowed_seq;     /*  3616     4 */
⬢[acme@toolbox pahole]$

Expand points will find mmap_lock:

⬢[acme@toolbox pahole]$ pahole --expand_pointers -C task_struct | grep -B10 mmap_lock
								} *pgd;
								atomic_t                       membarrier_state;
								atomic_t                       mm_users;
								atomic_t                       mm_count;

								/* XXX 4 bytes hole, try to pack */

								atomic_long_t                  pgtables_bytes;
								int                            map_count;
								spinlock_t                     page_table_lock;
								struct rw_semaphore                          mmap_lock;
^C
⬢[acme@toolbox pahole]$


ITs just too much expansion to see task_struct->mm, but it is there, of
course:

⬢[acme@toolbox pahole]$ pahole mm_struct | grep mmap_lock
		struct rw_semaphore mmap_lock;           /*   120    40 */
⬢[acme@toolbox pahole]$

Also:

⬢[acme@toolbox pahole]$ pahole --contains rw_semaphore
address_space
signal_struct
key
inode
super_block
quota_info
user_namespace
blocking_notifier_head
backing_dev_info
anon_vma
tty_struct
cpufreq_policy
tcf_block
ipc_ids
autogroup
kvm_arch
posix_clock
listener_list
uprobe
kernfs_root
configfs_fragment
ext4_inode_info
ext4_group_info
btrfs_fs_info
extent_buffer
btrfs_dev_replace
btrfs_space_info
btrfs_inode
btrfs_block_group
tpm_chip
ib_device
ib_xrcd
blk_crypto_profile
controller
led_classdev
cppc_pcc_data
dm_snapshot
⬢[acme@toolbox pahole]$

And:

⬢[acme@toolbox pahole]$ pahole --find_pointers_to mm_struct
task_struct: mm
task_struct: active_mm
vm_area_struct: vm_mm
flush_tlb_info: mm
signal_struct: oom_mm
tlb_state: loaded_mm
linux_binprm: mm
mmu_gather: mm
trace_event_raw_xen_mmu_ptep_modify_prot: mm
trace_event_raw_xen_mmu_alloc_ptpage: mm
trace_event_raw_xen_mmu_pgd: mm
trace_event_raw_xen_mmu_flush_tlb_multi: mm
trace_event_raw_hyperv_mmu_flush_tlb_multi: mm
mmu_notifier: mm
mmu_notifier_range: mm
sgx_encl_mm: mm
rq: prev_mm
kvm: mm
cpuset_migrate_mm_work: mm
mmap_unlock_irq_work: mm
delayed_uprobe: mm
map_info: mm
trace_event_raw_mmap_lock: mm
trace_event_raw_mmap_lock_acquire_returned: mm
mm_walk: mm
make_exclusive_args: mm
mmu_interval_notifier: mm
mm_slot: mm
rmap_item: mm
trace_event_raw_mm_khugepaged_scan_pmd: mm
trace_event_raw_mm_collapse_huge_page: mm
trace_event_raw_mm_collapse_huge_page_swapin: mm
mm_slot: mm
move_charge_struct: mm
userfaultfd_ctx: mm
proc_maps_private: mm
remap_pfn: mm
intel_svm: mm
binder_alloc: vma_vm_mm
⬢[acme@toolbox pahole]$

- Arnaldo


> > On the other hand, we can traverse some of semi-global locks like per-cpu,
> > per-device, per-filesystem and so on.  I've added 'rqlock' for each cpu's
> > runqueue lock.
> > 
> > It cannot cover all types of locks in the system but it'd be fairly usefule
> > if we can add many of often contended locks.  I tried to add futex locks
> > but it failed to find the __futex_data symbol from BTF.  I'm not sure why but
> > I guess it's because the struct doesn't have a tag name.
> > 
> > Those locks are added just because they got caught during my test.
> > It'd be nice if you suggest which locks to add and how to do that. :)
> > I'm thinking if there's a way to track file-based locks (like epoll, etc).
> > 
> > Finally I also added a lock type name after the symbols (if any) so that we
> > can get some idea even though it has no symbol.  The example output looks
> > like below:
> > 
> >   $ sudo ./perf lock con -abl -- sleep 1
> >    contended   total wait     max wait     avg wait            address   symbol
> > 
> >           44      6.13 ms    284.49 us    139.28 us   ffffffff92e06080   tasklist_lock (rwlock)
> >          159    983.38 us     12.38 us      6.18 us   ffff8cc717c90000   siglock (spinlock)
> >           10    679.90 us    153.35 us     67.99 us   ffff8cdc2872aaf8   mmap_lock (rwsem)
> >            9    558.11 us    180.67 us     62.01 us   ffff8cd647914038   mmap_lock (rwsem)
> >           78    228.56 us      7.82 us      2.93 us   ffff8cc700061c00    (spinlock)
> >            5     41.60 us     16.93 us      8.32 us   ffffd853acb41468    (spinlock)
> >           10     37.24 us      5.87 us      3.72 us   ffff8cd560b5c200   siglock (spinlock)
> >            4     11.17 us      3.97 us      2.79 us   ffff8d053ddf0c80   rq_lock (spinlock)
> >            1      7.86 us      7.86 us      7.86 us   ffff8cd64791404c    (spinlock)
> >            1      4.13 us      4.13 us      4.13 us   ffff8d053d930c80   rq_lock (spinlock)
> >            7      3.98 us      1.67 us       568 ns   ffff8ccb92479440    (mutex)
> >            2      2.62 us      2.33 us      1.31 us   ffff8cc702e6ede0    (rwlock)
> > 
> > The tasklist_lock is global so it's from the kallsyms.  But others like
> > siglock, mmap_lock and rq_lock are from the BPF.
> 
> Beautiful :-)
> 
> And the csets are _so_ small and demonstrate techniques that should be
> used in more and more tools.
> 
> Applied, testing.
> 
> - Arnaldo
>  
> > You get get the code at 'perf/lock-symbol-v1' branch in
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> > 
> > Thanks,
> > Namhyung
> > 
> > Namhyung Kim (4):
> >   perf lock contention: Track and show mmap_lock with address
> >   perf lock contention: Track and show siglock with address
> >   perf lock contention: Show per-cpu rq_lock with address
> >   perf lock contention: Show lock type with address
> > 
> >  tools/perf/builtin-lock.c                     | 46 +++++++----
> >  tools/perf/util/bpf_lock_contention.c         | 35 ++++++++-
> >  .../perf/util/bpf_skel/lock_contention.bpf.c  | 77 +++++++++++++++++++
> >  tools/perf/util/bpf_skel/lock_data.h          | 14 ++++
> >  4 files changed, 152 insertions(+), 20 deletions(-)
> > 
> > 
> > base-commit: b8fa3e3833c14151a47ebebbc5427dcfe94bb407
> > -- 
> > 2.40.0.rc1.284.g88254d51c5-goog
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
