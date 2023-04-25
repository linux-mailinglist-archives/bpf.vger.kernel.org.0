Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794F86EDCB0
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 09:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjDYHdY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 03:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbjDYHcs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 03:32:48 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5416013C2B
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 00:31:56 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-32addcf3a73so201686795ab.0
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 00:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682407915; x=1684999915;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xq/1X6dim9yVpm4WmSrDKdpjZQ76TBH7JXRh02wzjPs=;
        b=CHjKZuL+1Kd8u80KMpuVfP10IiV26E1dEDQLZEyPWAo0XVQs05wmF2Xs3K4bXH6WzS
         qZRVy56QM6PncQcFnYuCznETVLnX/VJzRArPkx5K8MwEbOti1z0VT6tGY91q5obj73hT
         6dfzpLls7Yh5alILwNLEYQVVAJkePz/7z5mKBMGDaslWMtKb2/Kmofa7wKcngjaaZG5u
         G08a8vqTE5xkxGoddYG27GuwN3bCupgCChIWGiIFXKThYK8Pe5At3/FG93zUMaA45nwz
         6BVnJyZAjf+XTz+uRCqUo7UgViBjA4ysV+nAVxxYt3Hy/m1hTNk3sZmSHLOy3aE+8nCE
         J44w==
X-Gm-Message-State: AAQBX9fdzksDI1pIRGIIrQLR3sE+vHuM30UEu5GRvT7gQ2Q3f7CIebse
        LUaKvYsrXd+ompTMEwFWoDZ6ibjCOtHgCxVa6O+cX/zOIiG4
X-Google-Smtp-Source: AKy350bVP4a0j5Jjfd1rDnCB8SnbLt2iwfQAy1MD+D79iTTFbvKVrfLH8oyOFXmTksC/rLXk/Uam81B+LvOeBsCtDQA/Z2npr3Tj
MIME-Version: 1.0
X-Received: by 2002:a05:6638:12c6:b0:40f:9f56:2bfc with SMTP id
 v6-20020a05663812c600b0040f9f562bfcmr11295818jas.3.1682407915588; Tue, 25 Apr
 2023 00:31:55 -0700 (PDT)
Date:   Tue, 25 Apr 2023 00:31:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d14f305fa241e67@google.com>
Subject: [syzbot] [bpf?] KCSAN: data-race in __bpf_lru_list_rotate /
 __htab_lru_percpu_map_update_elem (5)
From:   syzbot <syzbot+ebe648a84e8784763f82@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6a66fdd29ea1 Merge tag 'rust-fixes-6.3' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160d8948280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4baf7c6b35b5d5
dashboard link: https://syzkaller.appspot.com/bug?extid=ebe648a84e8784763f82
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/78937867b23a/disk-6a66fdd2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfd6c176adff/vmlinux-6a66fdd2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/51509bf47166/bzImage-6a66fdd2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebe648a84e8784763f82@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __bpf_lru_list_rotate / __htab_lru_percpu_map_update_elem

write to 0xffff888137038deb of 1 bytes by task 11240 on cpu 1:
 __bpf_lru_node_move kernel/bpf/bpf_lru_list.c:113 [inline]
 __bpf_lru_list_rotate_active kernel/bpf/bpf_lru_list.c:149 [inline]
 __bpf_lru_list_rotate+0x1bf/0x750 kernel/bpf/bpf_lru_list.c:240
 bpf_lru_list_pop_free_to_local kernel/bpf/bpf_lru_list.c:329 [inline]
 bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:447 [inline]
 bpf_lru_pop_free+0x638/0xe20 kernel/bpf/bpf_lru_list.c:499
 prealloc_lru_pop kernel/bpf/hashtab.c:290 [inline]
 __htab_lru_percpu_map_update_elem+0xe7/0x820 kernel/bpf/hashtab.c:1316
 bpf_percpu_hash_update+0x5e/0x90 kernel/bpf/hashtab.c:2313
 bpf_map_update_value+0x2a9/0x370 kernel/bpf/syscall.c:200
 generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1687
 bpf_map_do_batch+0x2d9/0x3d0 kernel/bpf/syscall.c:4534
 __sys_bpf+0x338/0x810
 __do_sys_bpf kernel/bpf/syscall.c:5096 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5094 [inline]
 __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5094
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888137038deb of 1 bytes by task 11241 on cpu 0:
 bpf_lru_node_set_ref kernel/bpf/bpf_lru_list.h:70 [inline]
 __htab_lru_percpu_map_update_elem+0x2f1/0x820 kernel/bpf/hashtab.c:1332
 bpf_percpu_hash_update+0x5e/0x90 kernel/bpf/hashtab.c:2313
 bpf_map_update_value+0x2a9/0x370 kernel/bpf/syscall.c:200
 generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1687
 bpf_map_do_batch+0x2d9/0x3d0 kernel/bpf/syscall.c:4534
 __sys_bpf+0x338/0x810
 __do_sys_bpf kernel/bpf/syscall.c:5096 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5094 [inline]
 __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5094
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x01 -> 0x00

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 11241 Comm: syz-executor.3 Not tainted 6.3.0-rc7-syzkaller-00136-g6a66fdd29ea1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
