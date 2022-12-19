Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D82651287
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 20:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiLSTNy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 14:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiLSTNu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 14:13:50 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EC9E094
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 11:13:49 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id q92-20020a17090a17e500b00223b688fe9fso1566189pja.3
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 11:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9waIoLPfjEIXBT2UAgIFxPvrXTrym213d5FFzQJSSbs=;
        b=M3Od+rSNpjlUOwidJc2O11k+GNrLWsIR2qpryFM21xIt5ShhYhCW7xh8Xomqib4eXq
         WDTuo7/pyrpuoDqomVFxF2WEhngdHwxX3g1uEakDRVwhkTMrLSBc3vGsMOBRPY6DntCE
         BDZSReS3rk/uUG8N/+PFHdLh5xeL6VRz+nSgGS+WBHVnjRoweUNGMYxgbuPXntOr0c+7
         6i9b04BLXV5JahofPQCs7JNsoxM1myt+L1ccaj4uXe7nl7HjIAQJ4/W7CobW8jC5CHaH
         gctgE2GRrzdI1dU+QteWniGZzBwUH8SH9p8Hlj/clDRm4YsYGVUobPlzl7iaOHPgl64Y
         Fn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9waIoLPfjEIXBT2UAgIFxPvrXTrym213d5FFzQJSSbs=;
        b=Vvu162S/j5wSxqY13sUYznacpbyjLK37pXq8i/1/tmna1KetanRmktwv/Op8k9KX1V
         dzT35LEc0hyWTpR1JwNW7u1knGeiuSABUvM5asQf9bot+IMcoW5a3reKY4098jOsZV2s
         UJvCJ6YqWqOcSPbmrYv9/XclAYbV/chQxpCWoIAAs6niGR3c+cnDu7D/MUpvvLgi8ndh
         VmrxXYUZ4IOKj0P8wroXqmWDCqarh1lBw4GVLIJ6aFZ/t0YrziUI9PkRth/RMLF2sFX3
         y2JeXUhFD3+/5ULt+H1rU32eDs22N/KamSiCw49VIOxo98gK8L5qpTiJnXoFmJVT/IKO
         Xnrg==
X-Gm-Message-State: ANoB5pl+UskIh6I8MHOxBPqWT/wLK3rd30JY3EU3YyUoyowqqlRJbz/a
        P8gHs9hD3MJxxqrvGds2vwYqQug=
X-Google-Smtp-Source: AA0mqf6bJkWslD9a7BOtBa7Tvdb7O06LkIsPilcLEW0XHE1E8JsnY+2z0R+erJyqdu/byOXde33yGyw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:6804:b0:189:907c:8380 with SMTP id
 h4-20020a170902680400b00189907c8380mr50843675plk.104.1671477228478; Mon, 19
 Dec 2022 11:13:48 -0800 (PST)
Date:   Mon, 19 Dec 2022 11:13:46 -0800
In-Reply-To: <CACkBjsaXNceR8ZjkLG=dT3P=4A8SBsg0Z5h5PWLryF5=ghKq=g@mail.gmail.com>
Mime-Version: 1.0
References: <CACkBjsaXNceR8ZjkLG=dT3P=4A8SBsg0Z5h5PWLryF5=ghKq=g@mail.gmail.com>
Message-ID: <Y6C36gvJ2JnwKm3X@google.com>
Subject: Re: WARNING in __mark_chain_precision
From:   sdf@google.com
To:     Hao Sun <sunhao.th@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On 12/19, Hao Sun wrote:
> Hi,

> The following backtracking bug can be triggered on the latest bpf-next and
> Linux 6.1 with the C prog provided. I don't have enough knowledge about
> this part in the verifier, don't know how to fix this.

Maybe something related to commit be2ef8161572 ("bpf: allow precision  
tracking
for programs with subprogs") and/or the related ones?


> This can be reproduced on:

> HEAD commit: 0e43662e61f2 tools/resolve_btfids: Use pkg-config to locate  
> libelf
> git tree: bpf-next
> console log: https://pastebin.com/raw/45hZ7iqm
> kernel config: https://pastebin.com/raw/0pu1CHRm
> C reproducer: https://pastebin.com/raw/tqsiezvT

> func#0 @0
> 0: R1=ctx(off=0,imm=0) R10=fp0
> 0: (18) r2 = 0x8000000000000          ; R2_w=2251799813685248
> 2: (18) r6 = 0xffff888027358000       ;
> R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
> 4: (18) r7 = 0xffff88802735a000       ;  
> R7_w=map_ptr(off=0,ks=156,vs=2624,imm=0)
> 6: (18) r8 = 0xffff88802735e000       ;  
> R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0)
> 8: (18) r9 = 0x8e9700000000           ; R9_w=156779191205888
> 10: (36) if w9 >= 0xffffffe3 goto pc+1
> last_idx 10 first_idx 0
> regs=200 stack=0 before 8: (18) r9 = 0x8e9700000000
> 11: R9_w=156779191205888
> 11: (85) call #0
> 12: (cc) w2 s>>= w7
> last_idx 12 first_idx 12
> parent didn't have regs=4 stack=0 marks: R1=ctx(off=0,imm=0)
> R2_rw=P2251799813685248 R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
> R7_rw=map_ptr(off=0,ks=156,vs=2624,imm=0)
> R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0) R9_w=156779191205888 R10=fp0
> last_idx 11 first_idx 0
> regs=4 stack=0 before 11: (85) call #0
> BUG regs 4
> processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 1
> peak_states 1 mark_read 1

> ------------[ cut here ]------------
> verifier backtracking bug
> WARNING: CPU: 6 PID: 8646 at kernel/bpf/verifier.c:2756 backtrack_insn
> kernel/bpf/verifier.c:2756 [inline]
> WARNING: CPU: 6 PID: 8646 at kernel/bpf/verifier.c:2756
> __mark_chain_precision+0x1baf/0x1d70 kernel/bpf/verifier.c:3065
> Modules linked in:
> CPU: 6 PID: 8646 Comm: a.out Not tainted 6.1.0-09634-g0e43662e61f2 #146
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux
> 1.16.1-1-1 04/01/2014
> RIP: 0010:backtrack_insn kernel/bpf/verifier.c:2756 [inline]
> RIP: 0010:__mark_chain_precision+0x1baf/0x1d70 kernel/bpf/verifier.c:3065
> Code: 0d 31 ff 89 de e8 91 ec ed ff 84 db 0f 85 ef fe ff ff e8 b4 f0
> ed ff 48 c7 c7 e0 8f 53 8a c6 05 28 71 ab 0d 01 e8 83 b3 1e 08 <0f> 0b
> e9 50 f8 ff ff 48 8b 74 24 38 48 c7 c7 80 d0 63 8d e8 49 46
> RSP: 0018:ffffc9001463f1a0 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff888020470000 RSI: ffffffff816662c0 RDI: fffff520028c7e26
> RBP: 0000000000000004 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000080000000 R11: 0000000000000000 R12: 0000000000000020
> R13: dffffc0000000000 R14: 000000000000000b R15: ffff88802be74000
> FS: 00007fd3daeb8440(0000) GS:ffff888063980000(0000)  
> knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000240 CR3: 0000000017394000 CR4: 0000000000750ee0
> PKRU: 55555554
> Call Trace:
> <TASK>
> mark_chain_precision kernel/bpf/verifier.c:3165 [inline]
> adjust_reg_min_max_vals+0x981/0x58d0 kernel/bpf/verifier.c:10715
> check_alu_op+0x380/0x1820 kernel/bpf/verifier.c:10928
> do_check kernel/bpf/verifier.c:13821 [inline]
> do_check_common+0x1c3b/0xe520 kernel/bpf/verifier.c:16289
> do_check_main kernel/bpf/verifier.c:16352 [inline]
> bpf_check+0x83b4/0xb310 kernel/bpf/verifier.c:16936
> bpf_prog_load+0xf7a/0x21a0 kernel/bpf/syscall.c:2619
> __sys_bpf+0xf03/0x5840 kernel/bpf/syscall.c:4979
> __do_sys_bpf kernel/bpf/syscall.c:5083 [inline]
> __se_sys_bpf kernel/bpf/syscall.c:5081 [inline]
> __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5081
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fd3da8e4469
> Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
> RSP: 002b:00007fff090c1a78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd3da8e4469
> RDX: 0000000000000080 RSI: 0000000020000840 RDI: 0000000000000005
> RBP: 00007fff090c2a90 R08: 00007fd3da92e160 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000561aefc006c0
> R13: 00007fff090c2b70 R14: 0000000000000000 R15: 0000000000000000
> </TASK>
