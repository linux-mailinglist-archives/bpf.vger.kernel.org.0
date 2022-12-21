Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB91E653175
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 14:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiLUNNw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 08:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiLUNNv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 08:13:51 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7322A7662
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 05:13:47 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1441d7d40c6so19101996fac.8
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 05:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtO9wDg8hJUBUQLaiwbIVAo5mfbNL2fVZzLLZezJ9QQ=;
        b=tdnjA/5PXpLbV2h4/LVz0eHHrk3fPY2VmbkazutmwZogNrS41rkgbySWaKIFWmZCLJ
         i9SdHw9xyb/HsyIZIBwypHdzlYWDcxg5yBKLjJ4Qyw8iUyQpy2l7GOK92iArImyL1Hay
         w8GQbEBIm1YU0BlcxRI0fv/Mu3+0kGoTUHNCnWoYhQkmLDoDECDNln3BcMz2JumGgKRG
         tbhhS/lvRkBS5q7mslBMMW0rzXKq9Wccn+YWaMNV4uyXEyjrEdvv8LaddoRILTF9K6Qa
         msweVuTk4ZNIBpUEhmrnt7cvkjIDtjPjyxXzbGM7zPppb8NeH7ykwrt1/3LaGlu783sx
         tS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtO9wDg8hJUBUQLaiwbIVAo5mfbNL2fVZzLLZezJ9QQ=;
        b=39NfIStlL9X6zeoXembuM1sqJEJeFFeEM85jbwhpwo9G9gJk+5J7W2EaQOTW7x9P2l
         i3GsstXH0RGovef+SWJxZ/oM6TzoW2TMKcoUlsBwHzZyRRgLPh/v040VRzDLfeaBtuQj
         QmMlDOIZIvW17pOLoHX6H6cTARIKH+P+mKCJgyQORKQh2/JKdpi5Fq4+WAVeTzw4KzkH
         fGLi1BxlG7Z61aot2d8s5spdmH93ybmGrus5/KUbAs0nFAM+OG3yLq/NNTrTzmr4SgcV
         Zof+x3N9YRdeEPiu7EcLoGgUuhIrDb5f7CV68lheOsHJqajMGVqH01uh/nUCvxtHR6vO
         F7aA==
X-Gm-Message-State: AFqh2krajHo7yT/uWWA3X2KYLUnimt6rcQDak7tHkdNuHgn+2HTkSQi1
        mZyrWdtT4zV6mK5rDKntnoEKwDPxFybkrtcvxhQZ2Q==
X-Google-Smtp-Source: AMrXdXsyxYuopd3Pilvwcm9RqZRo8uJMyPihyDIVvk58KoFpPnsoD5+9K1a55cKZ9tJrnhz35XcMw96wlhr9vbI+Xjk=
X-Received: by 2002:a05:6870:bb0c:b0:144:8c6d:33b9 with SMTP id
 nw12-20020a056870bb0c00b001448c6d33b9mr78974oab.190.1671628425203; Wed, 21
 Dec 2022 05:13:45 -0800 (PST)
MIME-Version: 1.0
References: <000000000000ea7a5c05f051fd00@google.com> <07f9fa58-097f-f14e-b07a-c94deed898eb@ghiti.fr>
In-Reply-To: <07f9fa58-097f-f14e-b07a-c94deed898eb@ghiti.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 21 Dec 2022 14:13:33 +0100
Message-ID: <CACT4Y+YcJqcEFSq-AJQpmps7po7qyBA4Vyts3ku9b=d18O65YA@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes boot error: WARNING in __apply_to_page_range (2)
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     syzbot <syzbot+5702f46b5b22bdb38b7e@syzkaller.appspotmail.com>,
        andrii@kernel.org, aou@eecs.berkeley.edu, ast@kernel.org,
        bjorn@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, luke.r.nels@gmail.com,
        martin.lau@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com,
        sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
        xi.wang@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 21 Dec 2022 at 13:45, Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Hi,
>
> On 12/21/22 09:03, syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    eb67d239f3aa Merge tag 'riscv-for-linus-6.2-mw1' of git:/=
/..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux=
.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1667268048000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbe108b5bcf4ef=
832
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5702f46b5b22bdb=
38b7e
> compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, =
GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: riscv64
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+5702f46b5b22bdb38b7e@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 2760 at mm/memory.c:2637 apply_to_pmd_range mm/memor=
y.c:2637 [inline]
>
>
> This leads to the following:
>
> if (WARN_ON_ONCE(pmd_leaf(*pmd)))
>     return -EINVAL;
>
>
> WARNING: CPU: 0 PID: 2760 at mm/memory.c:2637 apply_to_pud_range mm/memor=
y.c:2680 [inline]
> WARNING: CPU: 0 PID: 2760 at mm/memory.c:2637 apply_to_p4d_range mm/memor=
y.c:2716 [inline]
> WARNING: CPU: 0 PID: 2760 at mm/memory.c:2637 __apply_to_page_range+0x988=
/0x1212 mm/memory.c:2750
> Modules linked in:
> CPU: 0 PID: 2760 Comm: dhcpcd Not tainted 6.1.0-syzkaller-13662-geb67d239=
f3aa #0
> Hardware name: riscv-virtio,qemu (DT)
> epc : apply_to_pmd_range mm/memory.c:2637 [inline]
> epc : apply_to_pud_range mm/memory.c:2680 [inline]
> epc : apply_to_p4d_range mm/memory.c:2716 [inline]
> epc : __apply_to_page_range+0x988/0x1212 mm/memory.c:2750
>  ra : apply_to_pmd_range mm/memory.c:2637 [inline]
>  ra : apply_to_pud_range mm/memory.c:2680 [inline]
>  ra : apply_to_p4d_range mm/memory.c:2716 [inline]
>  ra : __apply_to_page_range+0x988/0x1212 mm/memory.c:2750
> epc : ffffffff8042aac8 ra : ffffffff8042aac8 sp : ff20000004d57290
>  gp : ffffffff85cdd280 tp : ff6000000e206200 t0 : ff60000010988a00
>  t1 : 00000000000f0000 t2 : ffffffff804616b4 s0 : ff20000004d57380
>  s1 : 0000000000000006 a0 : 0000000000000007 a1 : 00000000000f0000
>  a2 : ffffffff8042aac8 a3 : 0000000000000002 a4 : ff6000000e207200
>  a5 : 0000000000000000 a6 : 0000000000000003 a7 : 0000000000000000
>  s2 : fffffffeef001000 s3 : 00000000371000e7 s4 : ff6000007a660bc0
>  s5 : 0000000000001000 s6 : fffffffeef001000 s7 : 0000000000000001
>  s8 : ffffffff804d8484 s9 : 0000000000000000 s10: fffffffeef000000
>  s11: 0000000000000000 t3 : fffffffff3f3f300 t4 : fffffffef0a07c70
>  t5 : fffffffef0a07c71 t6 : ff6000000ebcccb8
> status: 0000000000000120 badaddr: 0000000000000000 cause: 000000000000000=
3
> [<ffffffff8042b386>] apply_to_page_range+0x34/0x46 mm/memory.c:2769
> [<ffffffff804d872a>] kasan_populate_vmalloc+0x52/0x5e mm/kasan/shadow.c:3=
15
> [<ffffffff804619e0>] alloc_vmap_area+0x4a6/0x1636 mm/vmalloc.c:1647
> [<ffffffff80462de2>] __get_vm_area_node+0x272/0x3b0 mm/vmalloc.c:2515
> [<ffffffff8046917c>] __vmalloc_node_range+0x280/0xdb8 mm/vmalloc.c:3187
> [<ffffffff800192c0>] bpf_jit_alloc_exec+0x46/0x52 arch/riscv/net/bpf_jit_=
core.c:190
>
>
> Here we can see that we are allocating the shadow memory for a BPF region=
 which is *vmalloc-backed*: but the current upstream implementation does po=
pulate the BPF region at initialization, it does not shallow populate it. A=
nd we try to use huge pages when possible so that can trigger this warning =
here.
>
> This is something that I fixed in the following series: https://patchwork=
.kernel.org/project/linux-riscv/list/?series=3D705150 :)

Good!
Let's tell syzbot so that it reports similar bugs in future:

#syz fix: riscv: Rework kasan population functions


> Glad to see syzbot running again, thanks
>
> Alex
>
>
> [<ffffffff80282f10>] bpf_jit_binary_alloc+0x96/0x13c kernel/bpf/core.c:10=
27
> [<ffffffff8001904c>] bpf_int_jit_compile+0x87a/0xa8c arch/riscv/net/bpf_j=
it_core.c:112
> [<ffffffff80284d76>] bpf_prog_select_runtime+0x1a2/0x22e kernel/bpf/core.=
c:2191
> [<ffffffff828a6840>] bpf_migrate_filter+0x258/0x2be net/core/filter.c:129=
8
> [<ffffffff828acbec>] bpf_prepare_filter+0x10e/0x1b4 net/core/filter.c:134=
6
> [<ffffffff828acfbc>] __get_filter+0x148/0x1a0 net/core/filter.c:1515
> [<ffffffff828b3e7c>] sk_attach_filter+0x22/0x11a net/core/filter.c:1530
> [<ffffffff827f1af4>] sk_setsockopt+0x144e/0x270c net/core/sock.c:1297
> [<ffffffff827f2dfa>] sock_setsockopt+0x48/0x58 net/core/sock.c:1549
> [<ffffffff827dfcc8>] __sys_setsockopt+0x3f0/0x418 net/socket.c:2242
> [<ffffffff827dfd2a>] __do_sys_setsockopt net/socket.c:2257 [inline]
> [<ffffffff827dfd2a>] sys_setsockopt+0x3a/0x4c net/socket.c:2254
> [<ffffffff80005ff6>] ret_from_syscall+0x0/0x2
> irq event stamp: 940
> hardirqs last  enabled at (939): [<ffffffff833903b0>] __raw_spin_unlock_i=
rqrestore include/linux/spinlock_api_smp.h:151 [inline]
> hardirqs last  enabled at (939): [<ffffffff833903b0>] _raw_spin_unlock_ir=
qrestore+0x68/0x98 kernel/locking/spinlock.c:194
> hardirqs last disabled at (940): [<ffffffff800105e0>] __trace_hardirqs_of=
f+0x18/0x20 arch/riscv/kernel/trace_irq.c:25
> softirqs last  enabled at (888): [<ffffffff8339107a>] softirq_handle_end =
kernel/softirq.c:414 [inline]
> softirqs last  enabled at (888): [<ffffffff8339107a>] __do_softirq+0x640/=
0x930 kernel/softirq.c:600
> softirqs last disabled at (883): [<ffffffff80069192>] do_softirq_own_stac=
k include/asm-generic/softirq_stack.h:10 [inline]
> softirqs last disabled at (883): [<ffffffff80069192>] invoke_softirq kern=
el/softirq.c:452 [inline]
> softirqs last disabled at (883): [<ffffffff80069192>] __irq_exit_rcu+0x15=
4/0x1ea kernel/softirq.c:650
> ---[ end trace 0000000000000000 ]---
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
