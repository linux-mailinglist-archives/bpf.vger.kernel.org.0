Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B240760EDED
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 04:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJ0C1n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 22:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiJ0C1m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 22:27:42 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EC7A59B3;
        Wed, 26 Oct 2022 19:27:41 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3691e040abaso168948037b3.9;
        Wed, 26 Oct 2022 19:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6jgXjzNEpSg6Mnp5IPTP6PBfCWPdUvFYbw7U1OhjGnA=;
        b=k08Cat+rnq1eEukNes/P64KOIudwwGMGzHBzA1S01nePfHlo8fh43r2kttVT6z7PpM
         U80GoNklX3Dk6BJeqowFq2p3784TA/0QsCeA7mEazxwzKCoO42vNa7ZSNzyinIM9Gd+r
         kRRKHP9u6JwsHSSQl0PGkMi+g0dbYql7nVihCrVk97/SgvQv3yws5OX0ck3JtCIM+HEc
         PpLyQ8HGM7H4kKDdD56IHoZyBvipgsNickPj9xRNaGT3+nafNiNkogD2TO2uvgTV+WWf
         vvI+QuZGdEpqpT9xwMIMg3vW3a3IpLwZlkh62f2wtK1xwmc5eEjq0qt/sH1CPp/+CCMJ
         kB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6jgXjzNEpSg6Mnp5IPTP6PBfCWPdUvFYbw7U1OhjGnA=;
        b=ZEVehQgpwsbV+epUEVi3xDIm905eS/ekKYcYLCp9FEOx6b+YGkzYZ+f6C98h+DYtr2
         BCk5e3+WVxdwV/Dkz7NHzEyg5XhHjUZ8bz0Zm2hb0ceM8+Hn0/isaOzrVnCnKQ4HsrUv
         qF7d3ieL9fXcg29Rrihn43c/s8a5YgK8wB6Mqpua7PGiPeV5BpsyPsGs6YbQh2X/GcEM
         3TDrD2l+5qGOWJrPrgaOb7TgZbz6zVqyCmO1iG7VTMKAlWXirRCD/h+i48BwKJkFU9un
         RGVrJhsrD3K/edOC/kxjWFRf/sTCcmFUT253ikQtcyi7RrvLlZRMMJzQWGnXH01L3fGH
         45Ig==
X-Gm-Message-State: ACrzQf0lMi0lQ/mSwZ2lva5z64q37Gtw9os56vKP2Ol/nL9jLeHeR4g2
        BilKzXiyVm/Uii2YYDTSxa5zdh5E/d0RCOxn+q/gtoH57w==
X-Google-Smtp-Source: AMsMyM5lBWVbaaTlg6E1cslhNAvIW9l3ap7RqQ6RDpznVBKwpxVFaGla8cdT5POTbYIS9zQFOSJ2N25IBTalhNLrfUY=
X-Received: by 2002:a81:5f0b:0:b0:35c:6d31:3ad6 with SMTP id
 t11-20020a815f0b000000b0035c6d313ad6mr41457772ywb.102.1666837659817; Wed, 26
 Oct 2022 19:27:39 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 27 Oct 2022 10:27:28 +0800
Message-ID: <CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com>
Subject: WARNING in bpf_bprintf_prepare
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     andrii@kernel.org, ast@kernel.org, bpf <bpf@vger.kernel.org>,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, martin.lau@linux.dev,
        sdf@google.com, song@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

The following warning can be triggered with the C reproducer in the link.
Syzbot also reported this several days ago, Jiri posted a patch that
uses bpf prog `active` field to fix this by 05b24ff9b2cfab (bpf:
Prevent bpf program recursion...) according to syzbot dashboard
(https://syzkaller.appspot.com/bug?id=179313fb375161d50a98311a28b8e2fc5f7350f9).
But this warning can still be triggered on 247f34f7b803
(Linux-v6.1-rc2) that already merged the patch, so it seems that this
still is an issue.

HEAD commit: 247f34f7b803 Linux 6.1-rc2
git tree: upstream
console output: https://pastebin.com/raw/kNw8JCu5
kernel config: https://pastebin.com/raw/sE5QK5HL
C reproducer: https://pastebin.com/raw/X96ASi27

------------[ cut here ]------------
WARNING: CPU: 6 PID: 6850 at kernel/bpf/helpers.c:770
try_get_fmt_tmp_buf kernel/bpf/helpers.c:770 [inline]
WARNING: CPU: 6 PID: 6850 at kernel/bpf/helpers.c:770
bpf_bprintf_prepare+0xf6a/0x1170 kernel/bpf/helpers.c:818
Modules linked in:
CPU: 6 PID: 6850 Comm: a.out Not tainted 6.1.0-rc2-dirty #23
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:try_get_fmt_tmp_buf kernel/bpf/helpers.c:770 [inline]
RIP: 0010:bpf_bprintf_prepare+0xf6a/0x1170 kernel/bpf/helpers.c:818
Code: c6 e8 ba 51 00 07 83 c0 01 48 98 48 01 c5 48 89 6c 24 08 e8 b8
0a eb ff 8d 6b 02 83 44 24 10 01 e9 2d f5 ff ff e8 a6 0a eb ff <0f> 0b
65 ff 0d 85 bf 7c 7e bf 01 00 00 00 41 bc f0 ff ff ff e8 2d
RSP: 0018:ffffc90015a96c20 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff88814f8057c0
RDX: 0000000000000000 RSI: ffff88814f8057c0 RDI: 0000000000000002
RBP: ffffc90015a96d50 R08: ffffffff818681ba R09: 0000000000000003
R10: 0000000000000005 R11: fffffbfff1a25ab2 R12: 0000000000000003
R13: 0000000000000004 R14: ffffc90015a96e08 R15: 0000000000000003
FS:  00007f012f4d2440(0000) GS:ffff8880b9d80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f012f19ac28 CR3: 0000000148da3000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ____bpf_trace_printk kernel/trace/bpf_trace.c:385 [inline]
 bpf_trace_printk+0xab/0x420 kernel/trace/bpf_trace.c:376
 bpf_prog_0605f9f479290f07+0x2f/0x33
 bpf_dispatcher_nop_func include/linux/bpf.h:963 [inline]
 __bpf_prog_run include/linux/filter.h:600 [inline]
 bpf_prog_run include/linux/filter.h:607 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2254 [inline]
 bpf_trace_run2+0x14d/0x3d0 kernel/trace/bpf_trace.c:2293
 __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
 __traceiter_contention_begin+0x56/0x90 include/trace/events/lock.h:95
 trace_contention_begin include/trace/events/lock.h:95 [inline]
 __pv_queued_spin_lock_slowpath+0x542/0xff0 kernel/locking/qspinlock.c:405
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x204/0x2d0 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0x41/0x50 kernel/locking/spinlock.c:162
 ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
 bpf_trace_printk+0xcf/0x420 kernel/trace/bpf_trace.c:376
 </TASK>

Regards
Hao Sun
