Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DE0650A5D
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 11:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiLSKuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 05:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiLSKuN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 05:50:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF95E0FC
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 02:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671446969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ho5jtWhPuSHIXjfDD2E10WI60ShEl9nLFRwx5n5ZW0w=;
        b=BrNNeutXqxCmEK70eM3LSFvVlJNYRwatMhaAvPXsvKcfX5WigaGgFnBp5SXYO4SdBve5qx
        Ip0nt2Cp6nb/cIst2ljgz6qGl1S4RPbf4+wZXTz2iNZ/VBiWDiNs1JDHhiX9Qn4lzPPdi8
        C9JGWqlcPx/Fjmco+Vj9iY4mzxdbl8U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-cGPG0Q6mPLOYDbZ1o5eVOg-1; Mon, 19 Dec 2022 05:49:28 -0500
X-MC-Unique: cGPG0Q6mPLOYDbZ1o5eVOg-1
Received: by mail-ed1-f69.google.com with SMTP id h18-20020a05640250d200b004758e655ebeso5924841edb.11
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 02:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ho5jtWhPuSHIXjfDD2E10WI60ShEl9nLFRwx5n5ZW0w=;
        b=wcCNxHzP8cK6lYp8R3QgsM4j8OPk6QbTGgS+KyJt9kejCe2P7uk1qhHhJcZQAeuEn+
         GbhL3ZUTo8HwIWstZxlcX1chrtIY7ehmL2FXhxKjprpOf8GrtfWPQWbGK6uywlvRIlVe
         nmZfzrityE3sZ92WuOzXOqn6eEEl/xJoQzNCb+L3S3EmFBwsHAVqJhphfClmLvQR21S0
         9WYrqzCBFZeyxI0ZNUThLK4Xd941MuHVcjjSNQgY0YtfRbz0xW34zXWBJx3hQ8WvTSNJ
         RW/jIn8WAzky6GL1agNio/RBy1cDjHQXQC1rXhE+qn0EuNdNNoUHS2xHvNbDKc8raA+k
         tPpw==
X-Gm-Message-State: ANoB5pldgHtY2DCoiS0n3KuRktauOYhAtv76sHGOBUBa8mNJ0Ja7fHJ/
        t8ZSiiNXNxtnDpp1yBoa28ZjH1iBcHwDo9uF1B8rKOopGWunxX+TItr4iZzc5ga6P8owzPyQHbQ
        4IfTyEClHf+m6KbpnHJQ6sy9nZ26M
X-Received: by 2002:a17:906:a148:b0:7ad:b286:8ee2 with SMTP id bu8-20020a170906a14800b007adb2868ee2mr38559028ejb.511.1671446965100;
        Mon, 19 Dec 2022 02:49:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6lM6N7T8pr7Q89pxKpPCIxf5ObGG1HBUAN3XmqSnwCyCt3Y1Kg+XCcEI0Xqg30wr1ZBO2DyAM8m93H+wgOiE4=
X-Received: by 2002:a17:906:a148:b0:7ad:b286:8ee2 with SMTP id
 bu8-20020a170906a14800b007adb2868ee2mr38559027ejb.511.1671446964931; Mon, 19
 Dec 2022 02:49:24 -0800 (PST)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Mon, 19 Dec 2022 11:49:13 +0100
Message-ID: <CA+QYu4q_FhdnkdzTrzS9jhw-7CjEirWBtTKuB-cNozD1z2f8qg@mail.gmail.com>
Subject: [6.1.0][bpf] BUG: KASAN: slab-out-of-bounds in copy_array (kernel/bpf/verifier.c:1074)
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     CKI Project <cki-project@redhat.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We recently started to hit the following issue on the mainline kernel
[1], the call trace is from commit [2]. The first commit we noticed
the problem is [3], although we don't know exactly when it was
introduced.

==================================================================
[   46.073262] BUG: KASAN: slab-out-of-bounds in copy_array
(kernel/bpf/verifier.c:1074)
[   46.074131] Write of size 40 at addr ffff8880079cf840 by task systemd/1
[   46.075043]
[   46.076104] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[   46.076926] Call Trace:
[   46.077331]  <TASK>
[   46.077670] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
[   46.078240] print_report (mm/kasan/report.c:307 mm/kasan/report.c:417)
[   46.078769] ? __virt_addr_valid (./include/linux/mmzone.h:1783
./include/linux/mmzone.h:1879 arch/x86/mm/physaddr.c:65)
[   46.079389] ? copy_array (kernel/bpf/verifier.c:1074)
[   46.079885] kasan_report (mm/kasan/report.c:184 mm/kasan/report.c:519)
[   46.080430] ? copy_array (kernel/bpf/verifier.c:1074)
[   46.080929] ? kasan_check_range (mm/kasan/generic.c:190)
[   46.081556] ? memcpy (mm/kasan/shadow.c:65 (discriminator 1))
[   46.082006] ? copy_array (kernel/bpf/verifier.c:1074)
[   46.082571] ? copy_verifier_state (kernel/bpf/verifier.c:1250)
[   46.083231] ? pop_stack (kernel/bpf/verifier.c:1315)
[   46.083718] ? do_check_common (kernel/bpf/verifier.c:14031
kernel/bpf/verifier.c:16289)
[   46.084364] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4383)
[   46.084979] ? __pfx_do_check_common (kernel/bpf/verifier.c:16225)
[   46.085644] ? __kmem_cache_free (mm/slub.c:3787 mm/slub.c:3800)
[   46.086244] ? check_cfg (kernel/bpf/verifier.c:12511)
[   46.086766] ? bpf_check (kernel/bpf/verifier.c:16352
kernel/bpf/verifier.c:16936)
[   46.087313] ? __pfx_bpf_check (kernel/bpf/verifier.c:16819)
[   46.087878] ? __pfx___lock_acquire (kernel/locking/lockdep.c:4913)
[   46.088548] ? lock_is_held_type (kernel/locking/lockdep.c:466
kernel/locking/lockdep.c:5712)
[   46.089122] ? find_held_lock (kernel/locking/lockdep.c:5179)
[   46.089697] ? lock_release (kernel/locking/lockdep.c:466
kernel/locking/lockdep.c:5690)
[   46.090261] ? ktime_get_with_offset (./include/linux/seqlock.h:274
kernel/time/timekeeping.c:889)
[   46.090921] ? __pfx_lock_release (kernel/locking/lockdep.c:5676)
[   46.091521] ? __might_fault (mm/memory.c:5647 mm/memory.c:5640)
[   46.092048] ? __might_resched (kernel/sched/core.c:9950)
[   46.092650] ? memset (mm/kasan/shadow.c:44)
[   46.093109] ? bpf_prog_load (kernel/bpf/syscall.c:2619)
[   46.093722] ? __pfx_bpf_prog_load (kernel/bpf/syscall.c:2478)
[   46.094357] ? lock_is_held_type (kernel/locking/lockdep.c:466
kernel/locking/lockdep.c:5712)
[   46.094963] ? __sys_bpf (kernel/bpf/syscall.c:4979)
[   46.095496] ? __pfx___sys_bpf (kernel/bpf/syscall.c:4926)
[   46.096073] ? mark_held_locks (kernel/locking/lockdep.c:4224)
[   46.096658] ? __x64_sys_bpf (kernel/bpf/syscall.c:5081)
[   46.097187] ? do_syscall_64 (arch/x86/entry/common.c:50
arch/x86/entry/common.c:80)
[   46.097753] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
[   46.098510]  </TASK>
[   46.098830]
[   46.099066] Allocated by task 1:
[   46.099597] kasan_save_stack (mm/kasan/common.c:46)
[   46.100146] kasan_set_track (mm/kasan/common.c:52)
[   46.100705] __kasan_krealloc (mm/kasan/common.c:371 mm/kasan/common.c:439)
[   46.101295] krealloc (./include/linux/kasan.h:231
mm/slab_common.c:1361 mm/slab_common.c:1398)
[   46.101754] push_jmp_history (kernel/bpf/verifier.c:2593)
[   46.102334] do_check_common (kernel/bpf/verifier.c:13552
kernel/bpf/verifier.c:13752 kernel/bpf/verifier.c:16289)
[   46.102908] bpf_check (kernel/bpf/verifier.c:16352
kernel/bpf/verifier.c:16936)
[   46.103439] bpf_prog_load (kernel/bpf/syscall.c:2619)
[   46.103986] __sys_bpf (kernel/bpf/syscall.c:4979)
[   46.104512] __x64_sys_bpf (kernel/bpf/syscall.c:5081)
[   46.105012] do_syscall_64 (arch/x86/entry/common.c:50
arch/x86/entry/common.c:80)
[   46.105613] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
[   46.106377]
[   46.106641] The buggy address belongs to the object at ffff8880079cf840
[   46.106641]  which belongs to the cache kmalloc-64 of size 64
[   46.108316] The buggy address is located 0 bytes inside of
[   46.108316]  64-byte region [ffff8880079cf840, ffff8880079cf880)
[   46.109904]
[   46.110167] The buggy address belongs to the physical page:
[   46.110981] page:ffffea00001e73c0 refcount:1 mapcount:0
mapping:0000000000000000 index:0xffff8880079cf040 pfn:0x79cf
[   46.112490] flags: 0xfffffc0000200(slab|node=0|zone=1|lastcpupid=0x1fffff)
[   46.113456] raw: 000fffffc0000200 ffff888100042900 ffffea00040605d0
ffff8881000406c8
[   46.114534] raw: ffff8880079cf040 000000000010000a 00000001ffffffff
0000000000000000
[   46.115617] page dumped because: kasan: bad access detected
[   46.116394]
[   46.116632] Memory state around the buggy address:
[   46.117339]  ffff8880079cf700: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   46.118303]  ffff8880079cf780: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   46.119305] >ffff8880079cf800: fc fc fc fc fc fc fc fc 00 00 00 00
fc fc fc fc
[   46.120328]                                                        ^
[   46.121235]  ffff8880079cf880: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   46.122299]  ffff8880079cf900: fc fc fc fc fc fc fc fc fa fb fb fb
fb fb fb fb
[   46.123316] ==================================================================

kernel tarball:
https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/725608072/publish%20x86_64%20debug/3491129543/artifacts/kernel-mainline.kernel.org-redhat_725608072_x86_64_debug.tar.gz

kernel config: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/725608072/build%20x86_64%20debug/3491129500/artifacts/kernel-mainline.kernel.org-redhat_725608072_x86_64_debug.config

test logs: https://datawarehouse.cki-project.org/kcidb/tests/6444438
cki issue tracker: https://datawarehouse.cki-project.org/issue/1770

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
[2] f9ff5644bcc04221bae56f922122f2b7f5d24d62
[3] 93761c93e9da28d8a020777cee2a84133082b477

Thank you,
Bruno Goncalves

