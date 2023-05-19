Return-Path: <bpf+bounces-973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D4670A089
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 22:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2724281B7A
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 20:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C6517AB2;
	Fri, 19 May 2023 20:24:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D34117AA2
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 20:24:20 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D471B4
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 13:24:17 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-52867360efcso2611651a12.2
        for <bpf@vger.kernel.org>; Fri, 19 May 2023 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684527857; x=1687119857;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSHaYmtZG8JifBhQVt6XguqjPbR/Kr44NOgAlyW6hsA=;
        b=MijWXNWhIhuSg+s0a2bsjm4fIYgCctNhFnOOzZCCSipRSoMv5FI9W0JvHTSTl3HGoE
         EkItpxuV+CMuFsuCBsN2YyTm+TLAs7oxb+Kk9FEK/khpkGEhz801mcmNXyMKTHZyEnPS
         zd6xDpc0wx9YDNXdDzvLzHuPP0NpLhBFfU0HY8eVA1ap0Y8nJzVxG+nhfnJEzO7Jjvpr
         dfgh2cirf823calwYcyiEdOedjL/PRY5KMsrZ7Ss6C2CYvm284MiwVCzdnuNJo5EmLpd
         3zdeJVoHljKsijF408hc3JSuBVLrUDqB4+TpN7ud0CaIkAx7BArPcGIuVQBwSF480GfZ
         5upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684527857; x=1687119857;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSHaYmtZG8JifBhQVt6XguqjPbR/Kr44NOgAlyW6hsA=;
        b=Vzkz8NQsygd91agLPq+jK4ZUUyKRRxQ04wacpOg/NeZwNl3Vf1f9olmJfL3crX8+w0
         jHwJn4Xud7wzNL94HwK01TdLch2iJtXOx7KQAtdiu4bwBYpSXG8CubvsH7NT1Pn+SOLh
         4upWuV+JPcEDLLahe6aBpoYFphMnEZQd/1RypZAFYYxw2PM9Stvgv7cs3d7086wU/bEg
         tL/Ad1msHUpkZXLjiJo2pUZWs8qoJmYEWw1oAOsjDhiKjtVyVGg23v4M7b84HverJL+C
         IQGL8ZyGgt9bcxQx5yRQYXibAl0xXjzI8gp8KcozXeeyr+5X+1iwNUE1Gn5aWRDlUyP3
         F3jA==
X-Gm-Message-State: AC+VfDxMR24IL1A0wcA2/FEKdcMu4ijBU98+YH38C2U986ktXiPZEIyq
	VfWmN7NzINdicvjqa20mqN3xeg==
X-Google-Smtp-Source: ACHHUZ46RHlTIyZqx2vGQHNZI5yNcKvZ4lLLflkDtq3nG+g7mM1mzSKf4c2aiLK0ArP11up5IiVVuQ==
X-Received: by 2002:a17:902:e547:b0:1a6:bb04:a020 with SMTP id n7-20020a170902e54700b001a6bb04a020mr4437019plf.46.1684527857092;
        Fri, 19 May 2023 13:24:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:1403:cc18:50b2:683a? ([2601:647:4900:1fbb:1403:cc18:50b2:683a])
        by smtp.gmail.com with ESMTPSA id jh9-20020a170903328900b001a6f7744a27sm46511plb.87.2023.05.19.13.24.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 May 2023 13:24:16 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v8 bpf-next 01/10] bpf: tcp: Avoid taking fast sock lock
 in iterator
From: Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <9C2CEA58-12CE-4B30-982E-043F37B1BEAA@isovalent.com>
Date: Fri, 19 May 2023 13:24:15 -0700
Cc: bpf@vger.kernel.org,
 kafai@fb.com,
 sdf@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E861CB20-306D-4F14-B29A-4482C3190765@isovalent.com>
References: <20230517175458.527970-1-aditi.ghag@isovalent.com>
 <66d39520-d85c-834b-22b3-0cf7a1a45aaf@meta.com>
 <CC590F34-1A80-41D2-87BA-9247910D0434@isovalent.com>
 <2fb9b408-0791-4a33-bd0f-298703c740c5@meta.com>
 <9C2CEA58-12CE-4B30-982E-043F37B1BEAA@isovalent.com>
To: Yonghong Song <yhs@meta.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On May 19, 2023, at 7:55 AM, Aditi Ghag <aditi.ghag@isovalent.com> =
wrote:
>=20
>=20
>=20
>> On May 18, 2023, at 10:45 PM, Yonghong Song <yhs@meta.com> wrote:
>>=20
>>=20
>>=20
>> On 5/18/23 4:04 PM, Aditi Ghag wrote:
>>>> On May 18, 2023, at 11:57 AM, Yonghong Song <yhs@meta.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>> On 5/17/23 10:54 AM, Aditi Ghag wrote:
>>>>> This is a preparatory commit to replace `lock_sock_fast` with
>>>>> `lock_sock`, and faciliate BPF programs executed from the iterator =
to be
>>>>=20
>>>> facilitate
>>> Yikes! I'll fix the typos.
>>>>=20
>>>>> able to destroy TCP listening sockets using the bpf_sock_destroy =
kfunc
>>>>> (implemened in follow-up commits).  Previously, BPF TCP iterator =
was
>>>>=20
>>>> implemented
>>>>=20
>>>>> acquiring the sock lock with BH disabled. This led to scenarios =
where
>>>>> the sockets hash table bucket lock can be acquired with BH enabled =
in
>>>>> some context versus disabled in other, and  caused a
>>>>> <softirq-safe> -> <softirq-unsafe> dependency with the sock lock.
>>>>=20
>>>> For 'and caused a <softirq-safe> -> <softirq-unsafe> dependency =
with
>>>> the sock lock', maybe can be rephrased like below:
>>>>=20
>>>> In such situation, kernel issued an warning since it thinks that
>>>> in the BH enabled path the same bucket lock *might* be acquired =
again
>>>> in the softirq context (BH disabled), which will lead to a =
potential
>>>> dead lock.
>>> Hi Yonghong, I thought about this a bit more before posting the =
patch series. My reading of the splat was that the deadlock scenario =
that was specifically highlighted was with respect to the pair of bucket =
and sock locks.
>>> As for the bucket lock, there might a deadlock scenario with a set =
of events such as:
>>> 1) Bucket lock is acquired with BH enabled in a process context  =
(e.g., __inet_hash below called from process context)
>>> 2) the process context was interrupted before the lock was released =
by...
>>> 3) Another context with BH disabled (e.g., sock_destroy called for =
listening socket from iterator) tries to acquire the same lock again
>>> contd...
>>>>=20
>>>> Note that in this particular triggering, the local_bh_disable()
>>>> happens in process context, so the warning is a false alarm.
>>> Right, the sock_destroy program is run from the iterator as opposed =
to BPF programs being executed on kernel events. However, my =
understanding is that because local_bh_disable is called, the lock dep =
validator treats it as an irq-safe context.
>>> Based on my reading of the documentation [1], there can be a =
deadlock issue with the bucket lock by itself (ref: Single-lock state =
rules), or deadlock issue with the pair of bucket and sock locks that =
the splat highlights (ref: Multi-lock dependency rules).
>>> Let me know if this makes sense, or I'm missing something.
>>> [1] =
https://www.kernel.org/doc/Documentation/locking/lockdep-design.rst
>>> -------- Posting a snippet of the splat again just for reference  =
--------
>>> [    1.544410] which would create a new lock dependency:
>>> [    1.544797]  (slock-AF_INET6){+.-.}-{2:2} -> =
(&h->lhash2[i].lock){+.+.}-{2:2}
>>> [    1.545361]
>>> [    1.545361] but this new dependency connects a SOFTIRQ-irq-safe =
lock:
>>> [    1.545961]  (slock-AF_INET6){+.-.}-{2:2}
>>> [    1.545963]
>>> [    1.545963] ... which became SOFTIRQ-irq-safe at:
>>> [    1.546745]   lock_acquire+0xcd/0x330
>>> [    1.547033]   _raw_spin_lock+0x33/0x40
>>> [    1.547325]   sk_clone_lock+0x146/0x520
>>> [    1.547623]   inet_csk_clone_lock+0x1b/0x110
>>> [    1.547960]   tcp_create_openreq_child+0x22/0x3f0
>>> [    1.548327]   tcp_v6_syn_recv_sock+0x96/0x940
>>> [    1.548672]   tcp_check_req+0x13f/0x640
>>> [    1.548977]   tcp_v6_rcv+0xa62/0xe80
>>> [    1.549258]   ip6_protocol_deliver_rcu+0x78/0x590
>>> [    1.549621]   ip6_input_finish+0x72/0x140
>>> [    1.549931]   __netif_receive_skb_one_core+0x63/0xa0
>>> [    1.550313]   process_backlog+0x79/0x260
>>> [    1.550619]   __napi_poll.constprop.0+0x27/0x170
>>> [    1.550976]   net_rx_action+0x14a/0x2a0
>>> [    1.551272]   __do_softirq+0x165/0x510
>>> [    1.551563]   do_softirq+0xcd/0x100
>>> [    1.551836]   __local_bh_enable_ip+0xcc/0xf0
>>> [    1.552168]   ip6_finish_output2+0x27c/0xb10
>>> [    1.552500]   ip6_finish_output+0x274/0x510
>>> [    1.552823]   ip6_xmit+0x319/0x9b0
>>> [    1.553095]   inet6_csk_xmit+0x12b/0x2b0
>>> [    1.553398]   __tcp_transmit_skb+0x543/0xc30
>>> [    1.553731]   tcp_rcv_state_process+0x362/0x1180
>>> [    1.554088]   tcp_v6_do_rcv+0x10f/0x540
>>> [    1.554387]   __release_sock+0x6a/0xe0
>>> [    1.554679]   release_sock+0x2f/0xb0
>>> [    1.554957]   __inet_stream_connect+0x1ac/0x3a0
>>> [    1.555308]   inet_stream_connect+0x3b/0x60
>>> [    1.555632]   __sys_connect+0xa3/0xd0
>>> [    1.555915]   __x64_sys_connect+0x18/0x20
>>> [    1.556222]   do_syscall_64+0x3c/0x90
>>> [    1.556510]   entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>> [    1.556909]
>>> [    1.556909] to a SOFTIRQ-irq-unsafe lock:
>>> [    1.557326]  (&h->lhash2[i].lock){+.+.}-{2:2}
>>> [    1.557329]
>>> [    1.557329] ... which became SOFTIRQ-irq-unsafe at:
>>> [    1.558148] ...
>>> [    1.558149]   lock_acquire+0xcd/0x330
>>> [    1.558579]   _raw_spin_lock+0x33/0x40
>>> [    1.558874]   __inet_hash+0x4b/0x210
>>> [    1.559154]   inet_csk_listen_start+0xe6/0x100
>>> [    1.559503]   inet_listen+0x95/0x1d0
>>> [    1.559782]   __sys_listen+0x69/0xb0
>>> [    1.560063]   __x64_sys_listen+0x14/0x20
>>> [    1.560365]   do_syscall_64+0x3c/0x90
>>> [    1.560652]   entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>> [    1.561052] other info that might help us debug this:
>>> [    1.561052]
>>> [    1.561658]  Possible interrupt unsafe locking scenario:
>>> [    1.561658]
>>> [    1.562171]        CPU0                    CPU1
>>> [    1.562521]        ----                    ----
>>> [    1.562870]   lock(&h->lhash2[i].lock);
>>> [    1.563167]                                local_irq_disable();
>>> [    1.563618]                                lock(slock-AF_INET6);
>>> [    1.564076]                                =
lock(&h->lhash2[i].lock);
>>> [    1.564558]   <Interrupt>
>>> [    1.564763]     lock(slock-AF_INET6);
>>> [    1.565053]
>>> [    1.565053]  *** DEADLOCK ***
>>>>=20
>>>>> Here is a snippet of annotated stack trace that motivated this =
change:
>>>>> ```
>>>>> Possible interrupt unsafe locking scenario:
>>>>>      CPU0                    CPU1
>>>>>      ----                    ----
>>>>> lock(&h->lhash2[i].lock);
>>>>>                              local_irq_disable();
>>>>>                              lock(slock-AF_INET6);
>>>>>                              lock(&h->lhash2[i].lock);
>>>>=20
>>>>                                local_bh_disable();
>>>>                                lock(&h->lhash2[i].lock);
>>>>=20
>>>>> <Interrupt>
>>>>>   lock(slock-AF_INET6);
>>>>> *** DEADLOCK ***
>>>> Replace the above with below:
>>>>=20
>>>> kernel imagined possible scenario:
>>>>   local_bh_disable();  /* Possible softirq */
>>>>   lock(&h->lhash2[i].lock);
>>>> *** Potential Deadlock ***
>>=20
>> I applied the whole patch set (v8) locally except Patch 1, running
>> selftest and hit a different warning:
>>=20
>> ...
>> [  168.780736] watchdog: BUG: soft lockup - CPU#0 stuck for 86s! =
[test_progs:2331]
>> [  168.781385] Modules linked in: bpf_testmod(OE)
>> [  168.781751] CPU: 0 PID: 2331 Comm: test_progs Tainted: G OEL     =
6.4.0-rc1-00336-g2fa1ad98e6e8-dirty #258
>> [  168.782570] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>> [  168.783457] RIP: 0010:queued_spin_lock_slowpath+0xd8/0x500
>> [  168.783904] Code: 00 ff ff 44 23 33 45 09 fe 48 8d 7c 24 04 e8 0f =
54 ca fe 44 89 74 24 04 41 81 fe 00 01 00 00 73 28 45 85 f6 75 04 eb 0f =
f3 90 <48> 89 df e8 d0 51 ca fe 80 3b 00 6
>> [  168.785503] RSP: 0018:ffff888114557c00 EFLAGS: 00000202
>> [  168.785964] RAX: 0000000000000000 RBX: ffff888113fd0a98 RCX: =
ffffffff827c84a0
>> [  168.786576] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: =
ffff888113fd0a98
>> [  168.787192] RBP: 0000000000000000 R08: dffffc0000000000 R09: =
ffffed10227fa154
>> [  168.787837] R10: 0000000000000000 R11: dffffc0000000001 R12: =
ffff888113fd0a98
>> [  168.788505] R13: 0000000000000002 R14: 0000000000000001 R15: =
0000000000000000
>> [  168.789119] FS:  00007fc34f075500(0000) GS:ffff8881f7400000(0000) =
knlGS:0000000000000000
>> [  168.789804] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  168.790306] CR2: 0000559382dd9057 CR3: 0000000102ab8004 CR4: =
0000000000370ef0
>> [  168.790976] Call Trace:
>> [  168.791218]  <TASK>
>> [  168.791434]  _raw_spin_lock+0x84/0x90
>> [  168.791785]  tcp_abort+0x13c/0x1f0
>> [  168.792125]  bpf_prog_88539c5453a9dd47_iter_tcp6_client+0x82/0x89
>> [  168.792701]  bpf_iter_run_prog+0x1aa/0x2c0
>> [  168.793098]  ? preempt_count_sub+0x1c/0xd0
>> [  168.793488]  ? from_kuid_munged+0x1c8/0x210
>> [  168.793886]  bpf_iter_tcp_seq_show+0x14e/0x1b0
>> [  168.794326]  bpf_seq_read+0x36c/0x6a0
>> [  168.794686]  vfs_read+0x11b/0x440
>> [  168.795024]  ksys_read+0x81/0xe0
>> [  168.795341]  do_syscall_64+0x41/0x90
>> [  168.795689]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [  168.796172] RIP: 0033:0x7fc34f25479c
>> [  168.796514] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 =
e8 c9 fc ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 =
0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 8
>> [  168.798197] RSP: 002b:00007fffc299b5a0 EFLAGS: 00000246 ORIG_RAX: =
0000000000000000
>> [  168.798891] RAX: ffffffffffffffda RBX: 0000559382dc77f0 RCX: =
00007fc34f25479c
>> [  168.799552] RDX: 0000000000000032 RSI: 00007fffc299b640 RDI: =
0000000000000019
>> [  168.800213] RBP: 00007fffc299b690 R08: 0000000000000000 R09: =
00007fffc299b4a7
>> [  168.800868] R10: 0000000000000000 R11: 0000000000000246 R12: =
0000559382b2bf70
>> [  168.801530] R13: 0000000000000000 R14: 0000000000000000 R15: =
0000000000000000
>> [  168.802196]  </TASK>
>> The lockup seems true since no further progress of selftest since the =
above error/warning. So we hit a real deadlock here.
>>=20
>> I did some analysis, the following is what could be happened:
>>  bpf_iter_tcp_seq_show
>>    lock_sock_fast
>>      __lock_sock_fast
>>        spin_lock_bh(&sk->sk_lock.slock);
>>  ...
>>  tcp_abort
>>    local_bh_disable();
>>    spin_lock(&((sk)->sk_lock.slock)); // from bh_lock_sock(sk)
>>=20
>> So we have deadlock here for the sock.
>> With Patch 1, we use 'lock_sock', sock lock is not held, so there is =
no dead lock.
>> static inline void lock_sock(struct sock *sk)
>> {
>>       lock_sock_nested(sk, 0);
>> }
>> void lock_sock_nested(struct sock *sk, int subclass)
>> {
>>       /* The sk_lock has mutex_lock() semantics here. */
>>       mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_IP_);
>>=20
>>       might_sleep();
>>       spin_lock_bh(&sk->sk_lock.slock);
>>       if (sock_owned_by_user_nocheck(sk))
>>               __lock_sock(sk);
>>       sk->sk_lock.owned =3D 1;
>>       spin_unlock_bh(&sk->sk_lock.slock);
>> }
>> EXPORT_SYMBOL(lock_sock_nested);
>> void __lock_sock(struct sock *sk)
>>       __releases(&sk->sk_lock.slock)
>>       __acquires(&sk->sk_lock.slock)
>> {
>>       DEFINE_WAIT(wait);
>>       for (;;) {
>>               prepare_to_wait_exclusive(&sk->sk_lock.wq, &wait,
>>                                       TASK_UNINTERRUPTIBLE);
>>               spin_unlock_bh(&sk->sk_lock.slock);
>>               schedule();
>>               spin_lock_bh(&sk->sk_lock.slock);
>>               if (!sock_owned_by_user(sk))
>>                       break;
>>       }
>>       finish_wait(&sk->sk_lock.wq, &wait);
>> }
>>=20
>> The current stack trace and analysis likely from some of
>> previous versions of patch.
>>=20
>=20
> The current stack trace is for the iter_tcp6_server test specifically. =
As the commit message suggests, the potential deadlock warning was =
triggered for the case when TCP listening sockets are getting destroyed, =
which is what the test involves. You should see the current stack trace =
when running only that particular test without patch 1 (which is how I =
encountered the issue when I introduced that test in one of the middle =
versions of the patch series).=20
> Thanks for the additional pair of eyes on the stack trace analysis!=20
>=20
> So looks like this patch ended up resolving the real deadlock issue as =
well.=20
>=20

Here is a summary and the revised commit message based on our =
conversation in this thread that'll available in the next revision.=20

This is a preparatory commit to replace `lock_sock_fast` with
`lock_sock`,and facilitate BPF programs executed from the TCP sockets
 iterator to be able to destroy TCP sockets using the bpf_sock_destroy
 kfunc (implemented in follow-up commits).

 Previously, BPF TCP iterator was acquiring the sock lock with BH
 disabled. This led to scenarios where the sockets hash table bucket =
lock
 can be acquired with BH enabled in some path versus disabled in other.
 In such situation, kernel issued a warning since it thinks that in the
 BH enabled path the same bucket lock *might* be acquired again in the
 softirq context (BH disabled), which will lead to a potential dead =
lock.
 Since bpf_sock_destroy also happens in a process context, the potential
 deadlock warning is likely a false alarm.

Here is a snippet of annotated stack trace that motivated this change:

```

Possible interrupt unsafe locking scenario:

      CPU0                           CPU1
      ----                                ----
 lock(&h->lhash2[i].lock);
                                           local_bh_disable();
                                           lock(&h->lhash2[i].lock);

kernel imagined possible scenario:
  local_bh_disable();  /* Possible softirq */
  lock(&h->lhash2[i].lock);
*** Potential Deadlock ***

process context:

lock_acquire+0xcd/0x330
_raw_spin_lock+0x33/0x40
------> Acquire (bucket) lhash2.lock with BH enabled
__inet_hash+0x4b/0x210
inet_csk_listen_start+0xe6/0x100
inet_listen+0x95/0x1d0
__sys_listen+0x69/0xb0
__x64_sys_listen+0x14/0x20
do_syscall_64+0x3c/0x90
entry_SYSCALL_64_after_hwframe+0x72/0xdc

bpf_sock_destroy run from iterator:

lock_acquire+0xcd/0x330
_raw_spin_lock+0x33/0x40
------> Acquire (bucket) lhash2.lock with BH disabled
inet_unhash+0x9a/0x110
tcp_set_state+0x6a/0x210
:
:

```

Since bpf_sock_destroy also happens in a process context, the potential =
deadlock warning is likely a false alarm.

Also, Yonghong reported a deadlock for non-listening TCP sockets that =
this change resolves-

watchdog: BUG: soft lockup - CPU#0 stuck for 86s! [test_progs:2331]
RIP: 0010:queued_spin_lock_slowpath+0xd8/0x500
Call Trace:
 <TASK>
 _raw_spin_lock+0x84/0x90
 tcp_abort+0x13c/0x1f0
 bpf_prog_88539c5453a9dd47_iter_tcp6_client+0x82/0x89
 bpf_iter_run_prog+0x1aa/0x2c0
 ? preempt_count_sub+0x1c/0xd0
 ? from_kuid_munged+0x1c8/0x210
 bpf_iter_tcp_seq_show+0x14e/0x1b0
 bpf_seq_read+0x36c/0x6a0

Previously, lock_sock_fast held the sock lock which was again being =
acquired in tcp_abort:

bpf_iter_tcp_seq_show
   lock_sock_fast
     __lock_sock_fast
       spin_lock_bh(&sk->sk_lock.slock);
	/* * Fast path return with bottom halves disabled and * =
sock::sk_lock.slock held.* */
      =20
 ...
 tcp_abort
   local_bh_disable();
   spin_lock(&((sk)->sk_lock.slock)); // from bh_lock_sock(sk)

With the switch to lock_sock, it releases the lock before returning:

lock_sock
    lock_sock_nested
       spin_lock_bh(&sk->sk_lock.slock);
       :
       spin_unlock_bh(&sk->sk_lock.slock);



>> I suggest to rerun based on the latest patch set, collect
>> the warning message and resubmit Patch 1.
>>=20
>>>>> process context:
>>>>> lock_acquire+0xcd/0x330
>>>>> _raw_spin_lock+0x33/0x40
>>>>> ------> Acquire (bucket) lhash2.lock with BH enabled
>>>>> __inet_hash+0x4b/0x210
>>>>> inet_csk_listen_start+0xe6/0x100
>>>>> inet_listen+0x95/0x1d0
>>>>> __sys_listen+0x69/0xb0
>>>>> __x64_sys_listen+0x14/0x20
>>>>> do_syscall_64+0x3c/0x90
>>>>> entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>>>> bpf_sock_destroy run from iterator in interrupt context:
>>>>> lock_acquire+0xcd/0x330
>>>>> _raw_spin_lock+0x33/0x40
>>>>> ------> Acquire (bucket) lhash2.lock with BH disabled
>>>>> inet_unhash+0x9a/0x110
>>>>> tcp_set_state+0x6a/0x210
>>>>> tcp_abort+0x10d/0x200
>>>>> bpf_prog_6793c5ca50c43c0d_iter_tcp6_server+0xa4/0xa9
>>>>> bpf_iter_run_prog+0x1ff/0x340
>>>>> ------> lock_sock_fast that acquires sock lock with BH disabled
>>>>> bpf_iter_tcp_seq_show+0xca/0x190
>>>>> bpf_seq_read+0x177/0x450
>>>>> ```
>>>>> Acked-by: Yonghong Song <yhs@meta.com>
>>>>> Acked-by: Stanislav Fomichev <sdf@google.com>
>>>>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>>>>> ---
>>>>> net/ipv4/tcp_ipv4.c | 5 ++---
>>>>> 1 file changed, 2 insertions(+), 3 deletions(-)
>>>>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>>>>> index ea370afa70ed..f2d370a9450f 100644
>>>>> --- a/net/ipv4/tcp_ipv4.c
>>>>> +++ b/net/ipv4/tcp_ipv4.c
>>>>> @@ -2962,7 +2962,6 @@ static int bpf_iter_tcp_seq_show(struct =
seq_file *seq, void *v)
>>>>> 	struct bpf_iter_meta meta;
>>>>> 	struct bpf_prog *prog;
>>>>> 	struct sock *sk =3D v;
>>>>> -	bool slow;
>>>>> 	uid_t uid;
>>>>> 	int ret;
>>>>> @@ -2970,7 +2969,7 @@ static int bpf_iter_tcp_seq_show(struct =
seq_file *seq, void *v)
>>>>> 		return 0;
>>>>>   	if (sk_fullsock(sk))
>>>>> -		slow =3D lock_sock_fast(sk);
>>>>> +		lock_sock(sk);
>>>>>   	if (unlikely(sk_unhashed(sk))) {
>>>>> 		ret =3D SEQ_SKIP;
>>>>> @@ -2994,7 +2993,7 @@ static int bpf_iter_tcp_seq_show(struct =
seq_file *seq, void *v)
>>>>>   unlock:
>>>>> 	if (sk_fullsock(sk))
>>>>> -		unlock_sock_fast(sk, slow);
>>>>> +		release_sock(sk);
>>>>> 	return ret;
>>>>>   }


