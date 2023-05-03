Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD916F5FFF
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 22:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjECUZH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 16:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjECUZG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 16:25:06 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ED783DD
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 13:25:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b4a64c72bso4068058b3a.0
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 13:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683145503; x=1685737503;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJyJ1oyHzjlbdXxqRWFZNyXp556DgKL0jYmJeAIlIVI=;
        b=Ffb6T13CAjKAmv5cYw0ZRLYHI0OQpnunQy8Y8lgEXDqti8MEg6XhRLotppG2ge9elO
         sr7b8KMKAId3wf5MaxnfYn5rryBjmx+I5kUd3W0ksqn6sgx5XDy8Zs4pDnBD8xeuVX5p
         9lnp4XuzAQsqhJ/N83edgk/MFHdgglLc8CDLDWu2vSAuviEK7fiA2NMimQ0fm6HmlG7a
         +zYlWsekb3H/XqDxtleg2XBwccJ7P2zZqrDeIsroEJyXyupEonERBbkXMUQxG0kSrLI2
         uXJlv1as6wTx1sFLelij6FNYHrxLp4gEINVyhJxwSu3B1lT8O2v0lgDr8C6I+uA9iShy
         +PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683145503; x=1685737503;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJyJ1oyHzjlbdXxqRWFZNyXp556DgKL0jYmJeAIlIVI=;
        b=FOGgg/lz+b74GJXqM8GXf7KwTp0S1OWgOs5JUOHQtl7SQA2dWN0ZL1MiP9qx0BiqLy
         HVhirh2iyqQfISI9H84eCwkVLGfN1uW9N67xts1gKh2EbGIGDKToN+VIRPAESk998deP
         VQl8Qai5ntsAXamDp0BAJz4Mnw5YCWOZ/Jj13Yj4wnGxN8kTssa4zVvCpXmZw6O4Z0X7
         t1DbSdu8T8qg4NT2c5nw27u49b3E14PvXQozA0E4H4k4yEYqVF7UwSLQIlTbMvNJpj65
         l9S/45VB/40KdPrMemZrvG91g7aE/bdU3YUMfnalEBtW7BxNT2ARdFMohj3umy9DG9GE
         pueA==
X-Gm-Message-State: AC+VfDwuJO480bqoUd80fpVCr8qpEvPT3PF7YLV2Hui1axydKYCpKLpo
        lvPCZiubDt23SXOxmWB3IFOFbXyuYD5Xv7oPNd7s0w==
X-Google-Smtp-Source: ACHHUZ7MWB4Mfn8yY/EBGbDwuvV+4Gwmx9pFuDbnDY0++kp/WRGeK8RdGxf+NtrBvbgTJPaRPrCDbg==
X-Received: by 2002:a05:6a20:429e:b0:f5:b4a5:73b4 with SMTP id o30-20020a056a20429e00b000f5b4a573b4mr28419858pzj.27.1683145502823;
        Wed, 03 May 2023 13:25:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:e51a:7909:25fb:7d3? ([2601:647:4900:1fbb:e51a:7909:25fb:7d3])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090a8c8d00b0024deb445265sm6864406pjo.47.2023.05.03.13.25.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2023 13:25:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH 1/7] bpf: tcp: Avoid taking fast sock lock in iterator
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <eab6796c7280065c18d042e8c8a5d2ecd6b28527.camel@redhat.com>
Date:   Wed, 3 May 2023 13:25:01 -0700
Cc:     bpf@vger.kernel.org, kafai@fb.com, sdf@google.com,
        edumazet@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5F8EC70D-A25D-408E-930E-C81A22007502@isovalent.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
 <20230418153148.2231644-2-aditi.ghag@isovalent.com>
 <eab6796c7280065c18d042e8c8a5d2ecd6b28527.camel@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Apr 20, 2023, at 1:55 AM, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> Hi,
>=20
> On Tue, 2023-04-18 at 15:31 +0000, Aditi Ghag wrote:
>> Previously, BPF TCP iterator was acquiring fast version of sock lock =
that
>> disables the BH. This introduced a circular dependency with code =
paths that
>> later acquire sockets hash table bucket lock.
>> Replace the fast version of sock lock with slow that faciliates BPF
>> programs executed from the iterator to destroy TCP listening sockets
>> using the bpf_sock_destroy kfunc (implemened in follow-up commits).
>>=20
>> Here is a stack trace that motivated this change:
>>=20
>> ```
>> 1) sock_lock with BH disabled + bucket lock
>>=20
>> lock_acquire+0xcd/0x330
>> _raw_spin_lock_bh+0x38/0x50
>> inet_unhash+0x96/0xd0
>> tcp_set_state+0x6a/0x210
>> tcp_abort+0x12b/0x230
>> bpf_prog_f4110fb1100e26b5_iter_tcp6_server+0xa3/0xaa
>> bpf_iter_run_prog+0x1ff/0x340
>> bpf_iter_tcp_seq_show+0xca/0x190
>> bpf_seq_read+0x177/0x450
>> vfs_read+0xc6/0x300
>> ksys_read+0x69/0xf0
>> do_syscall_64+0x3c/0x90
>> entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>=20
>> 2) sock lock with BH enable
>>=20
>> [    1.499968]   lock_acquire+0xcd/0x330
>> [    1.500316]   _raw_spin_lock+0x33/0x40
>=20
> The above is quite confusing to me, here BH are disabled as well
> (otherwise the whole softirq processing would be really broken)

Hi! Looks like the commit warrants more detailed explanation.=20
I've annotated the relevant stack traces with the locks in question =
(also updated the patch description locally):

lock_acquire+0xcd/0x330
_raw_spin_lock+0x33/0x40
------> sock lock acquired with BH enabled
sk_clone_lock+0x146/0x520
inet_csk_clone_lock+0x1b/0x110
tcp_create_openreq_child+0x22/0x3f0
tcp_v6_syn_recv_sock+0x96/0x940


lock_acquire+0xcd/0x330
_raw_spin_lock+0x33/0x40
------> Acquire (bucket) lhash2.lock (may cause deadlock if interrupted)
__inet_hash+0x4b/0x210
inet_csk_listen_start+0xe6/0x100
inet_listen+0x95/0x1d0
__sys_listen+0x69/0xb0
__x64_sys_listen+0x14/0x20
do_syscall_64+0x3c/0x90
entry_SYSCALL_64_after_hwframe+0x72/0xdc


lock_acquire+0xcd/0x330
_raw_spin_lock+0x33/0x40
------> Acquire (bucket) lhash2.lock
inet_unhash+0x9a/0x110
tcp_set_state+0x6a/0x210
tcp_abort+0x10d/0x200
bpf_prog_6793c5ca50c43c0d_iter_tcp6_server+0xa4/0xa9
bpf_iter_run_prog+0x1ff/0x340
------> Release (bucket) lhash2.lock
bpf_iter_tcp_seq_show+0xca/0x190
------> Acquire (bucket) lhash2.lock
------> sock lock acquired with BH disabled
bpf_seq_read+0x177/0x450

=
--------------------------------------------------------------------------=
-------
Here is the full stack trace:

[    1.543344] and this task is already holding:
[    1.543786] ffffa37903b400b0 (slock-AF_INET6){+.-.}-{2:2}, at: =
__lock_sock_fast+0x33/0x70
[    1.544410] which would create a new lock dependency:
[    1.544797]  (slock-AF_INET6){+.-.}-{2:2} -> =
(&h->lhash2[i].lock){+.+.}-{2:2}
[    1.545361]
[    1.545361] but this new dependency connects a SOFTIRQ-irq-safe lock:
[    1.545961]  (slock-AF_INET6){+.-.}-{2:2}
[    1.545963]
[    1.545963] ... which became SOFTIRQ-irq-safe at:
[    1.546745]   lock_acquire+0xcd/0x330
[    1.547033]   _raw_spin_lock+0x33/0x40
[    1.547325]   sk_clone_lock+0x146/0x520
[    1.547623]   inet_csk_clone_lock+0x1b/0x110
[    1.547960]   tcp_create_openreq_child+0x22/0x3f0
[    1.548327]   tcp_v6_syn_recv_sock+0x96/0x940
[    1.548672]   tcp_check_req+0x13f/0x640
[    1.548977]   tcp_v6_rcv+0xa62/0xe80
[    1.549258]   ip6_protocol_deliver_rcu+0x78/0x590
[    1.549621]   ip6_input_finish+0x72/0x140
[    1.549931]   __netif_receive_skb_one_core+0x63/0xa0
[    1.550313]   process_backlog+0x79/0x260
[    1.550619]   __napi_poll.constprop.0+0x27/0x170
[    1.550976]   net_rx_action+0x14a/0x2a0
[    1.551272]   __do_softirq+0x165/0x510
[    1.551563]   do_softirq+0xcd/0x100
[    1.551836]   __local_bh_enable_ip+0xcc/0xf0
[    1.552168]   ip6_finish_output2+0x27c/0xb10
[    1.552500]   ip6_finish_output+0x274/0x510
[    1.552823]   ip6_xmit+0x319/0x9b0
[    1.553095]   inet6_csk_xmit+0x12b/0x2b0
[    1.553398]   __tcp_transmit_skb+0x543/0xc30
[    1.553731]   tcp_rcv_state_process+0x362/0x1180
[    1.554088]   tcp_v6_do_rcv+0x10f/0x540
[    1.554387]   __release_sock+0x6a/0xe0
[    1.554679]   release_sock+0x2f/0xb0
[    1.554957]   __inet_stream_connect+0x1ac/0x3a0
[    1.555308]   inet_stream_connect+0x3b/0x60
[    1.555632]   __sys_connect+0xa3/0xd0
[    1.555915]   __x64_sys_connect+0x18/0x20
[    1.556222]   do_syscall_64+0x3c/0x90
[    1.556510]   entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    1.556909]
[    1.556909] to a SOFTIRQ-irq-unsafe lock:
[    1.557326]  (&h->lhash2[i].lock){+.+.}-{2:2}
[    1.557329]
[    1.557329] ... which became SOFTIRQ-irq-unsafe at:
[    1.558148] ...
[    1.558149]   lock_acquire+0xcd/0x330
[    1.558579]   _raw_spin_lock+0x33/0x40
[    1.558874]   __inet_hash+0x4b/0x210
[    1.559154]   inet_csk_listen_start+0xe6/0x100
[    1.559503]   inet_listen+0x95/0x1d0
[    1.559782]   __sys_listen+0x69/0xb0
[    1.560063]   __x64_sys_listen+0x14/0x20
[    1.560365]   do_syscall_64+0x3c/0x90
[    1.560652]   entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    1.561052]
[    1.561052] other info that might help us debug this:
[    1.561052]
[    1.561658]  Possible interrupt unsafe locking scenario:
[    1.561658]
[    1.562171]        CPU0                             CPU1
[    1.562521]        ----                                  ----
[    1.562870]   lock(&h->lhash2[i].lock);
[    1.563167]                                               =
local_irq_disable();
[    1.563618]                                               =
lock(slock-AF_INET6);
[    1.564076]                                               =
lock(&h->lhash2[i].lock);
[    1.564558]   <Interrupt>
[    1.564763]     lock(slock-AF_INET6);
[    1.565053]
[    1.565053]  *** DEADLOCK ***
[    1.565053]
[    1.565505] 4 locks held by test_progs/117:
[    1.565829]  #0: ffffa37903af60a0 (&p->lock){+.+.}-{3:3}, at: =
bpf_seq_read+0x3f/0x450
[    1.566428]  #1: ffffa37903b40130 (sk_lock-AF_INET6){+.+.}-{0:0}, at: =
bpf_seq_read+0x177/0x450
[    1.567091]  #2: ffffa37903b400b0 (slock-AF_INET6){+.-.}-{2:2}, at: =
__lock_sock_fast+0x33/0x70
[    1.567780]  #3: ffffffffb4f966c0 (rcu_read_lock){....}-{1:2}, at: =
bpf_iter_run_prog+0x18b/0x340
[    1.568453]
[    1.568453] the dependencies between SOFTIRQ-irq-safe lock and the =
holding lock:
[    1.569132] -> (slock-AF_INET6){+.-.}-{2:2} {
[    1.569469]    HARDIRQ-ON-W at:
[    1.569717]                     lock_acquire+0xcd/0x330
[    1.570117]                     _raw_spin_lock_bh+0x38/0x50
[    1.570543]                     lock_sock_nested+0x50/0x80
[    1.570958]                     sk_setsockopt+0x776/0x16b0
[    1.571376]                     __sys_setsockopt+0x193/0x1b0
[    1.571809]                     __x64_sys_setsockopt+0x1f/0x30
[    1.572259]                     do_syscall_64+0x3c/0x90
[    1.572671]                     =
entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    1.573185]    IN-SOFTIRQ-W at:
[    1.573433]                     lock_acquire+0xcd/0x330
[    1.573835]                     _raw_spin_lock+0x33/0x40
[    1.574242]                     sk_clone_lock+0x146/0x520
[    1.574657]                     inet_csk_clone_lock+0x1b/0x110
[    1.575106]                     tcp_create_openreq_child+0x22/0x3f0
[    1.575585]                     tcp_v6_syn_recv_sock+0x96/0x940
[    1.576042]                     tcp_check_req+0x13f/0x640
[    1.576456]                     tcp_v6_rcv+0xa62/0xe80
[    1.576853]                     ip6_protocol_deliver_rcu+0x78/0x590
[    1.577337]                     ip6_input_finish+0x72/0x140
[    1.577772]                     =
__netif_receive_skb_one_core+0x63/0xa0
[    1.578272]                     process_backlog+0x79/0x260
[    1.578696]                     __napi_poll.constprop.0+0x27/0x170
[    1.579169]                     net_rx_action+0x14a/0x2a0
[    1.579586]                     __do_softirq+0x165/0x510
[    1.579995]                     do_softirq+0xcd/0x100
[    1.580381]                     __local_bh_enable_ip+0xcc/0xf0
[    1.580831]                     ip6_finish_output2+0x27c/0xb10
[    1.581289]                     ip6_finish_output+0x274/0x510
[    1.581733]                     ip6_xmit+0x319/0x9b0
[    1.582118]                     inet6_csk_xmit+0x12b/0x2b0
[    1.582540]                     __tcp_transmit_skb+0x543/0xc30
[    1.582988]                     tcp_rcv_state_process+0x362/0x1180
[    1.583464]                     tcp_v6_do_rcv+0x10f/0x540
[    1.583882]                     __release_sock+0x6a/0xe0
[    1.584291]                     release_sock+0x2f/0xb0
[    1.584686]                     __inet_stream_connect+0x1ac/0x3a0
[    1.585157]                     inet_stream_connect+0x3b/0x60
[    1.585598]                     __sys_connect+0xa3/0xd0
[    1.586001]                     __x64_sys_connect+0x18/0x20
[    1.586429]                     do_syscall_64+0x3c/0x90
[    1.586832]                     =
entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    1.587346]    INITIAL USE at:
[    1.587590]                    lock_acquire+0xcd/0x330
[    1.587985]                    _raw_spin_lock_bh+0x38/0x50
[    1.588407]                    lock_sock_nested+0x50/0x80
[    1.588821]                    sk_setsockopt+0x776/0x16b0
[    1.589241]                    __sys_setsockopt+0x193/0x1b0
[    1.589666]                    __x64_sys_setsockopt+0x1f/0x30
[    1.590108]                    do_syscall_64+0x3c/0x90
[    1.590505]                    =
entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    1.591007]  }
[    1.591144]  ... key      at: [<ffffffffb6441bc0>] =
af_family_slock_keys+0xa0/0x2e0
[    1.591721]
[    1.591721] the dependencies between the lock to be acquired
[    1.591722]  and SOFTIRQ-irq-unsafe lock:
[    1.592596] -> (&h->lhash2[i].lock){+.+.}-{2:2} {
[    1.592968]    HARDIRQ-ON-W at:
[    1.593209]                     lock_acquire+0xcd/0x330
[    1.593604]                     _raw_spin_lock+0x33/0x40
[    1.594002]                     __inet_hash+0x4b/0x210
[    1.594387]                     inet_csk_listen_start+0xe6/0x100
[    1.594839]                     inet_listen+0x95/0x1d0
[    1.595217]                     __sys_listen+0x69/0xb0
[    1.595594]                     __x64_sys_listen+0x14/0x20
[    1.595997]                     do_syscall_64+0x3c/0x90
[    1.596386]                     =
entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    1.596891]    SOFTIRQ-ON-W at:
[    1.597133]                     lock_acquire+0xcd/0x330
[    1.597537]                     _raw_spin_lock+0x33/0x40
[    1.597930]                     __inet_hash+0x4b/0x210
[    1.598308]                     inet_csk_listen_start+0xe6/0x100
[    1.598750]                     inet_listen+0x95/0x1d0
[    1.599129]                     __sys_listen+0x69/0xb0
[    1.599509]                     __x64_sys_listen+0x14/0x20
[    1.599912]                     do_syscall_64+0x3c/0x90
[    1.600303]                     =
entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    1.600799]    INITIAL USE at:
[    1.601037]                    lock_acquire+0xcd/0x330
[    1.601416]                    _raw_spin_lock+0x33/0x40
[    1.601801]                    __inet_hash+0x4b/0x210
[    1.602178]                    inet_csk_listen_start+0xe6/0x100
[    1.602618]                    inet_listen+0x95/0x1d0
[    1.602995]                    __sys_listen+0x69/0xb0
[    1.603368]                    __x64_sys_listen+0x14/0x20
[    1.603766]                    do_syscall_64+0x3c/0x90
[    1.604150]                    =
entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    1.604647]  }
[    1.604780]  ... key      at: [<ffffffffb64567a0>] __key.1+0x0/0x10
[    1.605235]  ... acquired at:
[    1.605470]    lock_acquire+0xcd/0x330
[    1.605748]    _raw_spin_lock+0x33/0x40
[    1.606017]    inet_unhash+0x9a/0x110
[    1.606275]    tcp_set_state+0x6a/0x210
[    1.606552]    tcp_abort+0x10d/0x200
[    1.606807]    bpf_prog_6793c5ca50c43c0d_iter_tcp6_server+0xa4/0xa9
[    1.607243]    bpf_iter_run_prog+0x1ff/0x340
[    1.607553]    bpf_iter_tcp_seq_show+0xca/0x190
[    1.607874]    bpf_seq_read+0x177/0x450
[    1.608145]    vfs_read+0xc6/0x300
[    1.608389]    ksys_read+0x69/0xf0
[    1.608631]    do_syscall_64+0x3c/0x90
[    1.608903]    entry_SYSCALL_64_after_hwframe+0x72/0xdc

>=20
> Thanks,
>=20
> Paolo

