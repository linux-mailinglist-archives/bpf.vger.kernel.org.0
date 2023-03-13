Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC4F6B7C6D
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 16:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCMPv1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 11:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjCMPvM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 11:51:12 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0E16C19F
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 08:50:55 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id j7so1561101ybg.4
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 08:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678722655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttm5oWvpoDU+yNBkJy6lANgmUP+7hcOn6tTcRjPBmbo=;
        b=FqWXzBo0oadvFsGPWVEhuQnemb2UhLNrMLk4mIEsr9XgDforLETFOfoQ/1ydq+hpmf
         j1UwczpZO5mqRfYZVky7B5nBAmVrBObpofYjHDNPrGL6hPNPKbUP+BJDEk2EOgFe+ZCt
         XwaF+moTfmQn71FpUjepbXFgz89YRCIEcCZWkBm8UA2gcCpdoH9AMIvpoDai1SJq6cPu
         rk1maO6BBmUSHl1Kif85w84LWAs/7X9Cmh8U4cPcyg7kSSIp2WcpCkfMOK+iPND21B+S
         4r7SFajVAXrMdsuIzAFXiYYvScuzfAtFYFXUPhSmAAbZNZlpHdYAr+zt3UcPiqAA2T9/
         aXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678722655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttm5oWvpoDU+yNBkJy6lANgmUP+7hcOn6tTcRjPBmbo=;
        b=CkJgr8bR37hEiIQjQ9Vrx0+1BeTKMn1yIzhA35vpzfFtK906yTgxN/fdJQWWDf6G0t
         6QMMOhNfyABqQ890MVeuxFtJY9R6p+A3RRErXobJIagANKHLUok4J3KllZCYxMpKabQ6
         FxoqDcY4/T4QKhyVywP+ytNLQr0JZC0YAg0gPcCAVOyd/yCdVA0vi18QSUJzrZmLe++n
         ysP+Cf+bD3erm8FazDhvBJXAV4NjvdnVUGR7YkxN+648w3yXetkZ+nZSynphkPDu6Ctz
         n4KDEXhtQFm5l0+gn95e1PMt85Jg9LZsS7xkC03xXI1F9kJyZGqO4dknohow00H74/gD
         B0ZQ==
X-Gm-Message-State: AO0yUKVACFaAfQ+1w4hGa4xObGvpyXeBaNCmYL7Nx2bkQZY6AGbVry+7
        UzWyS3YcOTcfKa42ZPrT2xRSCZyZi0vuxVFnd+2eLg==
X-Google-Smtp-Source: AK7set9afg/+ojFX8gE8LptkSrwOs2CHsrAq0cKNKvlgBePCRtJ9zhsWvMa/F6mchiJFjOdr9rOQM9WfS8M8AweQoJs=
X-Received: by 2002:a05:6902:524:b0:ab8:1ed9:cfc5 with SMTP id
 y4-20020a056902052400b00ab81ed9cfc5mr21622383ybs.6.1678722654705; Mon, 13 Mar
 2023 08:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1678364612.git.lorenzo@kernel.org> <f20cfdb08d7357b0853d25be3b34ace4408693be.1678364613.git.lorenzo@kernel.org>
 <f5167659-99d7-04a1-2175-60ff1dabae71@tessares.net>
In-Reply-To: <f5167659-99d7-04a1-2175-60ff1dabae71@tessares.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 13 Mar 2023 08:50:43 -0700
Message-ID: <CANn89i+4F0QUqyDTqJ8GWrWvGnTyLTxja2hbL1W_rVdMqqmxaQ@mail.gmail.com>
Subject: Re: [PATCH net v2 6/8] veth: take into account device reconfiguration
 for xdp_features flag
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, saeedm@nvidia.com,
        leon@kernel.org, shayagr@amazon.com, akiyano@amazon.com,
        darinzon@amazon.com, sgoutham@marvell.com,
        lorenzo.bianconi@redhat.com, toke@redhat.com, teknoraver@meta.com,
        ttoukan.linux@gmail.com
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

On Mon, Mar 13, 2023 at 7:15=E2=80=AFAM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Lorenzo,
>
> On 09/03/2023 13:25, Lorenzo Bianconi wrote:
> > Take into account tx/rx queues reconfiguration setting device
> > xdp_features flag. Moreover consider NETIF_F_GRO flag in order to enabl=
e
> > ndo_xdp_xmit callback.
> >
> > Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>
> Thank you for the modification.
>
> Unfortunately, 'git bisect' just told me this modification is the origin
> of a new WARN when using veth in a netns:
>
>
> ###################### 8< ######################
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: suspicious RCU usage
> 6.3.0-rc1-00144-g064d70527aaa #149 Not tainted
> -----------------------------
> drivers/net/veth.c:1265 suspicious rcu_dereference_check() usage!
>
> other info that might help us debug this:
>

Same observation here, I am releasing a syzbot report with a repro.



>
> rcu_scheduler_active =3D 2, debug_locks =3D 1
> 1 lock held by ip/135:
> #0: ffffffff8dc4b108 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg
> (net/core/rtnetlink.c:6172)
>
> stack backtrace:
> CPU: 1 PID: 135 Comm: ip Not tainted 6.3.0-rc1-00144-g064d70527aaa #149
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> 04/01/2014
> Call Trace:
>  <TASK>
> dump_stack_lvl (lib/dump_stack.c:107)
> lockdep_rcu_suspicious (include/linux/context_tracking.h:152)
> veth_set_xdp_features (drivers/net/veth.c:1265 (discriminator 9))
> veth_newlink (drivers/net/veth.c:1892)
> ? veth_set_features (drivers/net/veth.c:1774)
> ? kasan_save_stack (mm/kasan/common.c:47)
> ? kasan_save_stack (mm/kasan/common.c:46)
> ? kasan_set_track (mm/kasan/common.c:52)
> ? alloc_netdev_mqs (include/linux/slab.h:737)
> ? rcu_read_lock_sched_held (kernel/rcu/update.c:125)
> ? trace_kmalloc (include/trace/events/kmem.h:54)
> ? __xdp_rxq_info_reg (net/core/xdp.c:188)
> ? alloc_netdev_mqs (net/core/dev.c:10657)
> ? rtnl_create_link (net/core/rtnetlink.c:3312)
> rtnl_newlink_create (net/core/rtnetlink.c:3440)
> ? rtnl_link_get_net_capable.constprop.0 (net/core/rtnetlink.c:3391)
> __rtnl_newlink (net/core/rtnetlink.c:3657)
> ? lock_downgrade (kernel/locking/lockdep.c:5321)
> ? rtnl_link_unregister (net/core/rtnetlink.c:3487)
> rtnl_newlink (net/core/rtnetlink.c:3671)
> rtnetlink_rcv_msg (net/core/rtnetlink.c:6174)
> ? rtnl_link_fill (net/core/rtnetlink.c:6070)
> ? mark_usage (kernel/locking/lockdep.c:4914)
> ? mark_usage (kernel/locking/lockdep.c:4914)
> netlink_rcv_skb (net/netlink/af_netlink.c:2574)
> ? rtnl_link_fill (net/core/rtnetlink.c:6070)
> ? netlink_ack (net/netlink/af_netlink.c:2551)
> ? lock_acquire (kernel/locking/lockdep.c:467)
> ? net_generic (include/linux/rcupdate.h:805)
> ? netlink_deliver_tap (include/linux/rcupdate.h:805)
> netlink_unicast (net/netlink/af_netlink.c:1340)
> ? netlink_attachskb (net/netlink/af_netlink.c:1350)
> netlink_sendmsg (net/netlink/af_netlink.c:1942)
> ? netlink_unicast (net/netlink/af_netlink.c:1861)
> ? netlink_unicast (net/netlink/af_netlink.c:1861)
> sock_sendmsg (net/socket.c:727)
> ____sys_sendmsg (net/socket.c:2501)
> ? kernel_sendmsg (net/socket.c:2448)
> ? __copy_msghdr (net/socket.c:2428)
> ___sys_sendmsg (net/socket.c:2557)
> ? mark_usage (kernel/locking/lockdep.c:4914)
> ? do_recvmmsg (net/socket.c:2544)
> ? lock_acquire (kernel/locking/lockdep.c:467)
> ? find_held_lock (kernel/locking/lockdep.c:5159)
> ? __lock_release (kernel/locking/lockdep.c:5345)
> ? __might_fault (mm/memory.c:5625)
> ? lock_downgrade (kernel/locking/lockdep.c:5321)
> ? __fget_light (include/linux/atomic/atomic-arch-fallback.h:227)
> __sys_sendmsg (include/linux/file.h:31)
> ? __sys_sendmsg_sock (net/socket.c:2572)
> ? rseq_get_rseq_cs (kernel/rseq.c:275)
> ? lockdep_hardirqs_on_prepare.part.0 (kernel/locking/lockdep.c:4263)
> do_syscall_64 (arch/x86/entry/common.c:50)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> RIP: 0033:0x7f0d1aadeb17
> Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 00 f3 0f 1e
> fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00
> f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   0f 00                   (bad)
>    2:   f7 d8                   neg    %eax
>    4:   64 89 02                mov    %eax,%fs:(%rdx)
>    7:   48 c7 c0 ff ff ff ff    mov    $0xffffffffffffffff,%rax
>    e:   eb b9                   jmp    0xffffffffffffffc9
>   10:   0f 1f 00                nopl   (%rax)
>   13:   f3 0f 1e fa             endbr64
>   17:   64 8b 04 25 18 00 00    mov    %fs:0x18,%eax
>   1e:   00
>   1f:   85 c0                   test   %eax,%eax
>   21:   75 10                   jne    0x33
>   23:   b8 2e 00 00 00          mov    $0x2e,%eax
>   28:   0f 05                   syscall
>   2a:*  48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
> <-- trapping instruction
>   30:   77 51                   ja     0x83
>   32:   c3                      ret
>   33:   48 83 ec 28             sub    $0x28,%rsp
>   37:   89 54 24 1c             mov    %edx,0x1c(%rsp)
>   3b:   48 89 74 24 10          mov    %rsi,0x10(%rsp)
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
>    6:   77 51                   ja     0x59
>    8:   c3                      ret
>    9:   48 83 ec 28             sub    $0x28,%rsp
>    d:   89 54 24 1c             mov    %edx,0x1c(%rsp)
>   11:   48 89 74 24 10          mov    %rsi,0x10(%rsp)
> RSP: 002b:00007ffca3305d48 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000640f2bb2 RCX: 00007f0d1aadeb17
> RDX: 0000000000000000 RSI: 00007ffca3305db0 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000001 R09: 00007ffca3304ae0
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffca3305eb4 R14: 00007ffca3305e80 R15: 0000561e28bf5020
>  </TASK>
> ip (135) used greatest stack depth: 24544 bytes left
>
> ###################### 8< ######################
>
>
> I can reproduce the issue on the "net" tree with just these 3 commands:
>
> # ip netns add ns1
> # ip netns add ns2
> # ip link add ns1eth1 netns ns1 type veth peer name ns2eth1 netns ns2
>
> Without this commit fccca038f300 ("veth: take into account device
> reconfiguration for xdp_features flag"), I don't have the issue.
>
> For more details about the issue detected by CIs validating our MPTCP
> tree, including kconfig and vmlinux if needed:
>
>   https://github.com/multipath-tcp/mptcp_net-next/issues/372
>
>
> Do you mind looking at this regression please? :)
>
>
> On our side, we will revert this patch in our tree for the moment to
> unblock our CI jobs.
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
