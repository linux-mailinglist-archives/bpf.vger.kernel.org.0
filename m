Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625E76B9DA0
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 18:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCNRz1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 14 Mar 2023 13:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjCNRz0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 13:55:26 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637DC6A7E;
        Tue, 14 Mar 2023 10:55:25 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id bf15so6753309iob.7;
        Tue, 14 Mar 2023 10:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678816524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UC6SiqJv6vv+aMWv+c2O7wVq//MMLZA07pBFsShSM5s=;
        b=xb5s8xNCTDias2b+Q7cG7pk6KBOnvuk4OCopA+Y8iJ/Yl8csITY2ezxktYI/J8ptaO
         xrNck4Bqx1f9zomV8RLB2n0j+CB/KmNtuQI7UCsuCyRhm/A0daAlOwr+ShhrxkyrXgxd
         eO3j9FlRI+p5oyanhWxS/wVJfsfc6vBoWmzYtbx9D50n6JYyNTqQPNxaPgA8LX6M8e86
         U0B9h+po3s4yTHgXwzcH0xrvQ8yQXQqEzJH0dMCvw16D/CO86a0q3OsVujutqaUSpmFU
         ZeToG9PhmAsU9b8aeeHMm5HeXGkefNJeS6bhvNBqjWOJEs6HYBxabX6Tiz++Nv1JGylT
         1/Ow==
X-Gm-Message-State: AO0yUKW3F215cH+2ph/J2bKiVWrOIXuIAX88Wa/TzzIa3u4GTF+goQQ+
        bmqUZ8xWW37aV5RVVHKnmrGVxxRnIXSDYKIkVvk=
X-Google-Smtp-Source: AK7set/mFHxf4wxT++oOO9bnKbj6PFDPNuBQQ/UlvR2FPcsP+Upe3oFecm93vcNbSOLqo2tzP0Dlcsh1GXTHObmwoQI=
X-Received: by 2002:a5d:8d87:0:b0:744:f5bb:6e60 with SMTP id
 b7-20020a5d8d87000000b00744f5bb6e60mr18465052ioj.1.1678816524533; Tue, 14 Mar
 2023 10:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230313204825.2665483-1-namhyung@kernel.org> <ZA+ZkRYADwtFEsPt@kernel.org>
 <ZBBnUlIQ5gLhoScx@kernel.org>
In-Reply-To: <ZBBnUlIQ5gLhoScx@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 14 Mar 2023 10:55:13 -0700
Message-ID: <CAM9d7cj7CSToKq7FKqYKCzpWddTfBW0GZH9ydGM2ZMdwNDGm2g@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf lock contention: Improve lock symbol display (v1)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

On Tue, Mar 14, 2023 at 5:23 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Mar 13, 2023 at 06:45:53PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Mar 13, 2023 at 01:48:21PM -0700, Namhyung Kim escreveu:
> > > Hello,
> > >
> > > This patchset improves the symbolization of locks for -l/--lock-addr mode.
> > > As of now it only shows global lock symbols present in the kallsyms.  But
> > > we can add some more lock symbols by traversing pointers in the BPF program.
> > >
> > > For example, mmap_lock can be reached from the mm_struct of the current task
> > > (task_struct->mm->mmap_lock) and we can compare the address of the give lock
> > > with it.  Similarly I've added 'siglock' for current->sighand->siglock.
>
> Hey, we can go a bit further by using something like pahole's
> --expand_types and --expand_pointers and play iterating a type members
> and looking for locks, like:
>
> ⬢[acme@toolbox pahole]$ pahole task_struct | grep spinlock_t
>         spinlock_t                 alloc_lock;           /*  3280     4 */
>         raw_spinlock_t             pi_lock;              /*  3284     4 */
>         seqcount_spinlock_t        mems_allowed_seq;     /*  3616     4 */
> ⬢[acme@toolbox pahole]$
>
> Expand points will find mmap_lock:
>
> ⬢[acme@toolbox pahole]$ pahole --expand_pointers -C task_struct | grep -B10 mmap_lock
>                                                                 } *pgd;
>                                                                 atomic_t                       membarrier_state;
>                                                                 atomic_t                       mm_users;
>                                                                 atomic_t                       mm_count;
>
>                                                                 /* XXX 4 bytes hole, try to pack */
>
>                                                                 atomic_long_t                  pgtables_bytes;
>                                                                 int                            map_count;
>                                                                 spinlock_t                     page_table_lock;
>                                                                 struct rw_semaphore                          mmap_lock;
> ^C
> ⬢[acme@toolbox pahole]$
>
>
> ITs just too much expansion to see task_struct->mm, but it is there, of
> course:
>
> ⬢[acme@toolbox pahole]$ pahole mm_struct | grep mmap_lock
>                 struct rw_semaphore mmap_lock;           /*   120    40 */
> ⬢[acme@toolbox pahole]$
>
> Also:
>
> ⬢[acme@toolbox pahole]$ pahole --contains rw_semaphore
> address_space
> signal_struct
> key
> inode
> super_block
> quota_info
> user_namespace
> blocking_notifier_head
> backing_dev_info
> anon_vma
> tty_struct
> cpufreq_policy
> tcf_block
> ipc_ids
> autogroup
> kvm_arch
> posix_clock
> listener_list
> uprobe
> kernfs_root
> configfs_fragment
> ext4_inode_info
> ext4_group_info
> btrfs_fs_info
> extent_buffer
> btrfs_dev_replace
> btrfs_space_info
> btrfs_inode
> btrfs_block_group
> tpm_chip
> ib_device
> ib_xrcd
> blk_crypto_profile
> controller
> led_classdev
> cppc_pcc_data
> dm_snapshot
> ⬢[acme@toolbox pahole]$
>
> And:
>
> ⬢[acme@toolbox pahole]$ pahole --find_pointers_to mm_struct
> task_struct: mm
> task_struct: active_mm
> vm_area_struct: vm_mm
> flush_tlb_info: mm
> signal_struct: oom_mm
> tlb_state: loaded_mm
> linux_binprm: mm
> mmu_gather: mm
> trace_event_raw_xen_mmu_ptep_modify_prot: mm
> trace_event_raw_xen_mmu_alloc_ptpage: mm
> trace_event_raw_xen_mmu_pgd: mm
> trace_event_raw_xen_mmu_flush_tlb_multi: mm
> trace_event_raw_hyperv_mmu_flush_tlb_multi: mm
> mmu_notifier: mm
> mmu_notifier_range: mm
> sgx_encl_mm: mm
> rq: prev_mm
> kvm: mm
> cpuset_migrate_mm_work: mm
> mmap_unlock_irq_work: mm
> delayed_uprobe: mm
> map_info: mm
> trace_event_raw_mmap_lock: mm
> trace_event_raw_mmap_lock_acquire_returned: mm
> mm_walk: mm
> make_exclusive_args: mm
> mmu_interval_notifier: mm
> mm_slot: mm
> rmap_item: mm
> trace_event_raw_mm_khugepaged_scan_pmd: mm
> trace_event_raw_mm_collapse_huge_page: mm
> trace_event_raw_mm_collapse_huge_page_swapin: mm
> mm_slot: mm
> move_charge_struct: mm
> userfaultfd_ctx: mm
> proc_maps_private: mm
> remap_pfn: mm
> intel_svm: mm
> binder_alloc: vma_vm_mm
> ⬢[acme@toolbox pahole]$

This looks really cool! especially.

I'm especially interested in adding super_block and kernfs_root.
Let me see how I can add them.

Thanks,
Namhyung
