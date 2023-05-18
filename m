Return-Path: <bpf+bounces-924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38C1708C01
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 01:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43781C211AC
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 23:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B9220F1;
	Thu, 18 May 2023 23:04:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D920EE
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 23:04:58 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D71E69
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 16:04:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso244238b3a.3
        for <bpf@vger.kernel.org>; Thu, 18 May 2023 16:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684451096; x=1687043096;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfSoB5Yo6e8ms8Dk6weAEAqJQoPdL7BXoDNjoiEIZsQ=;
        b=i/LWWd570G+ndlzeFKp6eb04vH3JxfXEIc6ytAg00yHUGNTwYaA3od5wSB4RumyvU7
         Xly7Gkmg0qWT5f5lU77FLnIeMB0lVp1l231YXqnkQ6MuG6/598pQ/VCuIh3TAG0HIKrA
         qxpca+HBpPKQKOP1oq6ItjkHZQrpEzpInqSqJg1wSlhsuBKkFAAF6tFVnPaCDpcp3J1t
         ggEauzoaOj7kwIP/yGRBmra0ghEz1lGVvfRw3z8A/vojOzZRe8A4QjpKHq+pg6LdRLfp
         1U9A2WlIFwyUkuMSySlLiSgUnRXNUKy3uPG2VdhkziNyYJa4R4ytyPLeBzz7UraQSNdE
         eaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684451096; x=1687043096;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfSoB5Yo6e8ms8Dk6weAEAqJQoPdL7BXoDNjoiEIZsQ=;
        b=lpxJAt4GjgGZvpTHFNP2wACPtfm/uTPG9MFubEN315fZ5A7N/GF3lJLlqyoeg8GzpQ
         Wzanv6wuFys2xRmNMChFU9baOn/GmhOdcGhaf13T4xTkPPvhHmiDZqK9H/HEomPmA/zC
         /alQ0wXK1myP/L1i07m+xEg/bIHgITNkjaMLwuF4D2uo0e8xbje+WA0tYmLOocFM3cln
         PqxKAvsLJGfaPGfduF2CdY2McvwI/awXBJ4T4r9+hLjQ7qdM8s5DNJLDDcoPdooW3XMB
         YFwaOhWt7h5Enh3joyyt2L7yCqFDLCO8B397JQCMflIJZeZBf4oOxwO1pt3c9Dd2Hgxi
         mOlg==
X-Gm-Message-State: AC+VfDzvxhzihZ52lXcSaRe1esQIKWPywot5cp0NkjYJO/TmzCqQf56U
	BBF0pVwn+RQWTzO2oxlCb4NsTpB7x5wEcOaxfE4=
X-Google-Smtp-Source: ACHHUZ4tmyY/85/MdCDKaofYqF8tg6nie204acKX60htUcrzGtt4prUrwg66Tn+sEEZ2uTfl9crGFQ==
X-Received: by 2002:a17:902:e74f:b0:1ae:f37:c1a8 with SMTP id p15-20020a170902e74f00b001ae0f37c1a8mr825586plf.40.1684451095989;
        Thu, 18 May 2023 16:04:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:10a0:2431:f414:6aae? ([2601:647:4900:1fbb:10a0:2431:f414:6aae])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902b78c00b001993a1fce7bsm1972582pls.196.2023.05.18.16.04.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2023 16:04:55 -0700 (PDT)
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
In-Reply-To: <66d39520-d85c-834b-22b3-0cf7a1a45aaf@meta.com>
Date: Thu, 18 May 2023 16:04:53 -0700
Cc: bpf@vger.kernel.org,
 kafai@fb.com,
 sdf@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC590F34-1A80-41D2-87BA-9247910D0434@isovalent.com>
References: <20230517175458.527970-1-aditi.ghag@isovalent.com>
 <66d39520-d85c-834b-22b3-0cf7a1a45aaf@meta.com>
To: Yonghong Song <yhs@meta.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On May 18, 2023, at 11:57 AM, Yonghong Song <yhs@meta.com> wrote:
>=20
>=20
>=20
> On 5/17/23 10:54 AM, Aditi Ghag wrote:
>> This is a preparatory commit to replace `lock_sock_fast` with
>> `lock_sock`, and faciliate BPF programs executed from the iterator to =
be
>=20
> facilitate

Yikes! I'll fix the typos.=20

>=20
>> able to destroy TCP listening sockets using the bpf_sock_destroy =
kfunc
>> (implemened in follow-up commits).  Previously, BPF TCP iterator was
>=20
> implemented
>=20
>> acquiring the sock lock with BH disabled. This led to scenarios where
>> the sockets hash table bucket lock can be acquired with BH enabled in
>> some context versus disabled in other, and  caused a
>> <softirq-safe> -> <softirq-unsafe> dependency with the sock lock.
>=20
> For 'and caused a <softirq-safe> -> <softirq-unsafe> dependency with
> the sock lock', maybe can be rephrased like below:
>=20
> In such situation, kernel issued an warning since it thinks that
> in the BH enabled path the same bucket lock *might* be acquired again
> in the softirq context (BH disabled), which will lead to a potential
> dead lock.


Hi Yonghong, I thought about this a bit more before posting the patch =
series. My reading of the splat was that the deadlock scenario that was =
specifically highlighted was with respect to the pair of bucket and sock =
locks.=20

As for the bucket lock, there might a deadlock scenario with a set of =
events such as:
 1) Bucket lock is acquired with BH enabled in a process context  (e.g., =
__inet_hash below called from process context)
 2) the process context was interrupted before the lock was released =
by...
 3) Another context with BH disabled (e.g., sock_destroy called for =
listening socket from iterator) tries to acquire the same lock again

contd...

>=20
> Note that in this particular triggering, the local_bh_disable()
> happens in process context, so the warning is a false alarm.


Right, the sock_destroy program is run from the iterator as opposed to =
BPF programs being executed on kernel events. However, my understanding =
is that because local_bh_disable is called, the lock dep validator =
treats it as an irq-safe context.

Based on my reading of the documentation [1], there can be a deadlock =
issue with the bucket lock by itself (ref: Single-lock state rules), or =
deadlock issue with the pair of bucket and sock locks that the splat =
highlights (ref: Multi-lock dependency rules).=20

Let me know if this makes sense, or I'm missing something. =20


[1] https://www.kernel.org/doc/Documentation/locking/lockdep-design.rst


-------- Posting a snippet of the splat again just for reference  =
--------

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
[    1.561052] other info that might help us debug this:
[    1.561052]


[    1.561658]  Possible interrupt unsafe locking scenario:
[    1.561658]
[    1.562171]        CPU0                    CPU1
[    1.562521]        ----                    ----
[    1.562870]   lock(&h->lhash2[i].lock);
[    1.563167]                                local_irq_disable();
[    1.563618]                                lock(slock-AF_INET6);
[    1.564076]                                lock(&h->lhash2[i].lock);
[    1.564558]   <Interrupt>
[    1.564763]     lock(slock-AF_INET6);
[    1.565053]
[    1.565053]  *** DEADLOCK ***

>=20
>> Here is a snippet of annotated stack trace that motivated this =
change:
>> ```
>> Possible interrupt unsafe locking scenario:
>>       CPU0                    CPU1
>>       ----                    ----
>>  lock(&h->lhash2[i].lock);
>>                               local_irq_disable();
>>                               lock(slock-AF_INET6);
>>                               lock(&h->lhash2[i].lock);
>=20
>                                 local_bh_disable();
>                                 lock(&h->lhash2[i].lock);
>=20
>>  <Interrupt>
>>    lock(slock-AF_INET6);
>> *** DEADLOCK ***
> Replace the above with below:
>=20
> kernel imagined possible scenario:
>    local_bh_disable();  /* Possible softirq */
>    lock(&h->lhash2[i].lock);
> *** Potential Deadlock ***
>> process context:
>> lock_acquire+0xcd/0x330
>> _raw_spin_lock+0x33/0x40
>> ------> Acquire (bucket) lhash2.lock with BH enabled
>> __inet_hash+0x4b/0x210
>> inet_csk_listen_start+0xe6/0x100
>> inet_listen+0x95/0x1d0
>> __sys_listen+0x69/0xb0
>> __x64_sys_listen+0x14/0x20
>> do_syscall_64+0x3c/0x90
>> entry_SYSCALL_64_after_hwframe+0x72/0xdc
>> bpf_sock_destroy run from iterator in interrupt context:
>> lock_acquire+0xcd/0x330
>> _raw_spin_lock+0x33/0x40
>> ------> Acquire (bucket) lhash2.lock with BH disabled
>> inet_unhash+0x9a/0x110
>> tcp_set_state+0x6a/0x210
>> tcp_abort+0x10d/0x200
>> bpf_prog_6793c5ca50c43c0d_iter_tcp6_server+0xa4/0xa9
>> bpf_iter_run_prog+0x1ff/0x340
>> ------> lock_sock_fast that acquires sock lock with BH disabled
>> bpf_iter_tcp_seq_show+0xca/0x190
>> bpf_seq_read+0x177/0x450
>> ```
>> Acked-by: Yonghong Song <yhs@meta.com>
>> Acked-by: Stanislav Fomichev <sdf@google.com>
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>> ---
>>  net/ipv4/tcp_ipv4.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index ea370afa70ed..f2d370a9450f 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -2962,7 +2962,6 @@ static int bpf_iter_tcp_seq_show(struct =
seq_file *seq, void *v)
>>  	struct bpf_iter_meta meta;
>>  	struct bpf_prog *prog;
>>  	struct sock *sk =3D v;
>> -	bool slow;
>>  	uid_t uid;
>>  	int ret;
>>  @@ -2970,7 +2969,7 @@ static int bpf_iter_tcp_seq_show(struct =
seq_file *seq, void *v)
>>  		return 0;
>>    	if (sk_fullsock(sk))
>> -		slow =3D lock_sock_fast(sk);
>> +		lock_sock(sk);
>>    	if (unlikely(sk_unhashed(sk))) {
>>  		ret =3D SEQ_SKIP;
>> @@ -2994,7 +2993,7 @@ static int bpf_iter_tcp_seq_show(struct =
seq_file *seq, void *v)
>>    unlock:
>>  	if (sk_fullsock(sk))
>> -		unlock_sock_fast(sk, slow);
>> +		release_sock(sk);
>>  	return ret;
>>    }


