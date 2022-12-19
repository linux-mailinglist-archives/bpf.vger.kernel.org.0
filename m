Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BBA651308
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 20:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiLST0u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 14:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiLST0F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 14:26:05 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053D912D09
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 11:26:00 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-437b250c03aso117841017b3.6
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 11:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A72jyanPPSt6/KgJqBHm0/yxCNi6NbR8O60U30+8bic=;
        b=QJSkUIAznbfcaHQsaxjglLva9EJrH64Y8vvsuuWfCewjY+S75BHYc1y1sTo02Qf7RU
         1NrtrJIgyARSoiCumesuac+GS8pMS0YUrAzQ7DBPR/vbvosTLX3/t5i0rjY9AqDFCYmZ
         JfGZQrsCELEdY/A7XO6H9aqFxaDbC53UxUa1mzn6VsJrokAXVTo7oJQHkiaLs73UHqyd
         5F36HujDz9qWKdkpCjDwo5EgQp5bUSKmtmHt1qTZWWhj0gRSlIQAxB8OoVrKL+6Vy9qg
         seLDT+/Yw9TXcKTgrVOB4wbm8Z8Akn4uzB43KxPTSW2z9pHc+iUUBwNuuqzbKrcVAvnH
         FavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A72jyanPPSt6/KgJqBHm0/yxCNi6NbR8O60U30+8bic=;
        b=bDScD269leCOUrXFSaVO9fcxV5BXPb2nqWmnF/cKxrYykJxIY7AvuwX8fZFFZodXlD
         oYyNzZ6jkiGKUxtfYD/1KjNNk+rWLr7ZvTy3OsWG1I8Wv4vhEWbIOevaF1RuXG6gUTTP
         dnY7XGuf7c+RV7VlVubW7awYKxPOGsRxtlwnRogDoSsp+35xyELKKJSZhkvoLkOJrRU6
         wwQCLk/Ss2Z/q8PUZetiJ04RmsqCf5aOty/YtLqCej3JAPDRBShWjbJEqwl7k5LDDqSk
         TefE4UjRQ8l6uyoJfaCEF00fXTK97o1ZcPs5+QMqWyetx3TnqPDAGfWbcuVS6UiQ9Hj2
         7vRg==
X-Gm-Message-State: ANoB5pmWVKnWTuuwxyKvZFkgC21CkxR5xBTi3vKb6YN51+b3siFXCQ5p
        7QA49NO12FxL0K5iFUFsv0jCDDo=
X-Google-Smtp-Source: AA0mqf4+NqBYADtN9jm8QBMpB2EdRE8mbqkYL182eM8B1P6NiqKQhdKXAL9vdsfIQyY3Awb9Pedeo/Q=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:1e0b:0:b0:6f4:6603:db81 with SMTP id
 e11-20020a251e0b000000b006f46603db81mr53416454ybe.220.1671477959953; Mon, 19
 Dec 2022 11:25:59 -0800 (PST)
Date:   Mon, 19 Dec 2022 11:25:58 -0800
In-Reply-To: <CA+QYu4q_FhdnkdzTrzS9jhw-7CjEirWBtTKuB-cNozD1z2f8qg@mail.gmail.com>
Mime-Version: 1.0
References: <CA+QYu4q_FhdnkdzTrzS9jhw-7CjEirWBtTKuB-cNozD1z2f8qg@mail.gmail.com>
Message-ID: <Y6C6xhAJ5w+j4NyU@google.com>
Subject: Re: [6.1.0][bpf] BUG: KASAN: slab-out-of-bounds in copy_array (kernel/bpf/verifier.c:1074)
From:   sdf@google.com
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        CKI Project <cki-project@redhat.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/19, Bruno Goncalves wrote:
> We recently started to hit the following issue on the mainline kernel
> [1], the call trace is from commit [2]. The first commit we noticed
> the problem is [3], although we don't know exactly when it was
> introduced.

Seems similar to  
https://lore.kernel.org/bpf/Y6C1SFEj9MOOnAnb@google.com/T/#t ?

> ==================================================================
> [   46.073262] BUG: KASAN: slab-out-of-bounds in copy_array
> (kernel/bpf/verifier.c:1074)
> [   46.074131] Write of size 40 at addr ffff8880079cf840 by task systemd/1
> [   46.075043]
> [   46.076104] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [   46.076926] Call Trace:
> [   46.077331]  <TASK>
> [   46.077670] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
> [   46.078240] print_report (mm/kasan/report.c:307 mm/kasan/report.c:417)
> [   46.078769] ? __virt_addr_valid (./include/linux/mmzone.h:1783
> ./include/linux/mmzone.h:1879 arch/x86/mm/physaddr.c:65)
> [   46.079389] ? copy_array (kernel/bpf/verifier.c:1074)
> [   46.079885] kasan_report (mm/kasan/report.c:184 mm/kasan/report.c:519)
> [   46.080430] ? copy_array (kernel/bpf/verifier.c:1074)
> [   46.080929] ? kasan_check_range (mm/kasan/generic.c:190)
> [   46.081556] ? memcpy (mm/kasan/shadow.c:65 (discriminator 1))
> [   46.082006] ? copy_array (kernel/bpf/verifier.c:1074)
> [   46.082571] ? copy_verifier_state (kernel/bpf/verifier.c:1250)
> [   46.083231] ? pop_stack (kernel/bpf/verifier.c:1315)
> [   46.083718] ? do_check_common (kernel/bpf/verifier.c:14031
> kernel/bpf/verifier.c:16289)
> [   46.084364] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4383)
> [   46.084979] ? __pfx_do_check_common (kernel/bpf/verifier.c:16225)
> [   46.085644] ? __kmem_cache_free (mm/slub.c:3787 mm/slub.c:3800)
> [   46.086244] ? check_cfg (kernel/bpf/verifier.c:12511)
> [   46.086766] ? bpf_check (kernel/bpf/verifier.c:16352
> kernel/bpf/verifier.c:16936)
> [   46.087313] ? __pfx_bpf_check (kernel/bpf/verifier.c:16819)
> [   46.087878] ? __pfx___lock_acquire (kernel/locking/lockdep.c:4913)
> [   46.088548] ? lock_is_held_type (kernel/locking/lockdep.c:466
> kernel/locking/lockdep.c:5712)
> [   46.089122] ? find_held_lock (kernel/locking/lockdep.c:5179)
> [   46.089697] ? lock_release (kernel/locking/lockdep.c:466
> kernel/locking/lockdep.c:5690)
> [   46.090261] ? ktime_get_with_offset (./include/linux/seqlock.h:274
> kernel/time/timekeeping.c:889)
> [   46.090921] ? __pfx_lock_release (kernel/locking/lockdep.c:5676)
> [   46.091521] ? __might_fault (mm/memory.c:5647 mm/memory.c:5640)
> [   46.092048] ? __might_resched (kernel/sched/core.c:9950)
> [   46.092650] ? memset (mm/kasan/shadow.c:44)
> [   46.093109] ? bpf_prog_load (kernel/bpf/syscall.c:2619)
> [   46.093722] ? __pfx_bpf_prog_load (kernel/bpf/syscall.c:2478)
> [   46.094357] ? lock_is_held_type (kernel/locking/lockdep.c:466
> kernel/locking/lockdep.c:5712)
> [   46.094963] ? __sys_bpf (kernel/bpf/syscall.c:4979)
> [   46.095496] ? __pfx___sys_bpf (kernel/bpf/syscall.c:4926)
> [   46.096073] ? mark_held_locks (kernel/locking/lockdep.c:4224)
> [   46.096658] ? __x64_sys_bpf (kernel/bpf/syscall.c:5081)
> [   46.097187] ? do_syscall_64 (arch/x86/entry/common.c:50
> arch/x86/entry/common.c:80)
> [   46.097753] ? entry_SYSCALL_64_after_hwframe  
> (arch/x86/entry/entry_64.S:120)
> [   46.098510]  </TASK>
> [   46.098830]
> [   46.099066] Allocated by task 1:
> [   46.099597] kasan_save_stack (mm/kasan/common.c:46)
> [   46.100146] kasan_set_track (mm/kasan/common.c:52)
> [   46.100705] __kasan_krealloc (mm/kasan/common.c:371  
> mm/kasan/common.c:439)
> [   46.101295] krealloc (./include/linux/kasan.h:231
> mm/slab_common.c:1361 mm/slab_common.c:1398)
> [   46.101754] push_jmp_history (kernel/bpf/verifier.c:2593)
> [   46.102334] do_check_common (kernel/bpf/verifier.c:13552
> kernel/bpf/verifier.c:13752 kernel/bpf/verifier.c:16289)
> [   46.102908] bpf_check (kernel/bpf/verifier.c:16352
> kernel/bpf/verifier.c:16936)
> [   46.103439] bpf_prog_load (kernel/bpf/syscall.c:2619)
> [   46.103986] __sys_bpf (kernel/bpf/syscall.c:4979)
> [   46.104512] __x64_sys_bpf (kernel/bpf/syscall.c:5081)
> [   46.105012] do_syscall_64 (arch/x86/entry/common.c:50
> arch/x86/entry/common.c:80)
> [   46.105613] entry_SYSCALL_64_after_hwframe  
> (arch/x86/entry/entry_64.S:120)
> [   46.106377]
> [   46.106641] The buggy address belongs to the object at ffff8880079cf840
> [   46.106641]  which belongs to the cache kmalloc-64 of size 64
> [   46.108316] The buggy address is located 0 bytes inside of
> [   46.108316]  64-byte region [ffff8880079cf840, ffff8880079cf880)
> [   46.109904]
> [   46.110167] The buggy address belongs to the physical page:
> [   46.110981] page:ffffea00001e73c0 refcount:1 mapcount:0
> mapping:0000000000000000 index:0xffff8880079cf040 pfn:0x79cf
> [   46.112490] flags: 0xfffffc0000200(slab|node=0|zone=1| 
> lastcpupid=0x1fffff)
> [   46.113456] raw: 000fffffc0000200 ffff888100042900 ffffea00040605d0
> ffff8881000406c8
> [   46.114534] raw: ffff8880079cf040 000000000010000a 00000001ffffffff
> 0000000000000000
> [   46.115617] page dumped because: kasan: bad access detected
> [   46.116394]
> [   46.116632] Memory state around the buggy address:
> [   46.117339]  ffff8880079cf700: fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc
> [   46.118303]  ffff8880079cf780: fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc
> [   46.119305] >ffff8880079cf800: fc fc fc fc fc fc fc fc 00 00 00 00
> fc fc fc fc
> [   46.120328]                                                        ^
> [   46.121235]  ffff8880079cf880: fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc
> [   46.122299]  ffff8880079cf900: fc fc fc fc fc fc fc fc fa fb fb fb
> fb fb fb fb
> [   46.123316]  
> ==================================================================

> kernel tarball:
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/725608072/publish%20x86_64%20debug/3491129543/artifacts/kernel-mainline.kernel.org-redhat_725608072_x86_64_debug.tar.gz

> kernel config:  
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/725608072/build%20x86_64%20debug/3491129500/artifacts/kernel-mainline.kernel.org-redhat_725608072_x86_64_debug.config

> test logs: https://datawarehouse.cki-project.org/kcidb/tests/6444438
> cki issue tracker: https://datawarehouse.cki-project.org/issue/1770

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> [2] f9ff5644bcc04221bae56f922122f2b7f5d24d62
> [3] 93761c93e9da28d8a020777cee2a84133082b477

> Thank you,
> Bruno Goncalves

