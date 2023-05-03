Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF76F6009
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 22:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjECU0W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 16:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjECU0V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 16:26:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32AC83F1
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 13:26:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso6188448b3a.1
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683145579; x=1685737579;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lC8lCq0dq1tGcUNnfBuARVPlgK/ZPHHJZCYWmWGPkjI=;
        b=fbJEmRvmWAwrnWHhCK5cxItEKjLS0VXprYOOK1YRs+f7PVvsAG/zrxzGbxScQyYmwD
         6s6ML6I4A1jUNwQv0LfSlBNLUzwf4Y37W1TksGWtidomHrHkbERumIIF51ioBrFe73gJ
         IIPnJGtV9A2JMxWe56YapT4RZFW92TLn6/GjQ2RHYLvYkWE3wrOJB8A5f/y9Kkck6LKh
         dHaPtDcEBLmkC3E9b9XS5LstAwNCUAFRcZBtljAr9Vr9Rffg3QzNnP39oZY7kSd5qRR+
         KnJnEdmXumAA6dWRMp+YKRhaGgkfgTqX2EyoUWq20dJEgyjpKlMYlG2kmbLo5qRam/wZ
         0UYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683145579; x=1685737579;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lC8lCq0dq1tGcUNnfBuARVPlgK/ZPHHJZCYWmWGPkjI=;
        b=Zf7OgEN/onRRywXv3D/wYelzECM6AYQJlipuEXKFR0Mk1jt4zGZUIcv8FZy8z5FYQY
         tVeEvdf72dLEgL/Lkg3nMR2F5jbUOu4sXFiKTrXwghUzK9jZB5HXKjvla8V7SDfgSDsE
         BONOmCWnTnafuQ7VQy5L1XnppGZJWCYLZRfvtKUbO6qYp4B8UL8WgFXvsZt6eS2ZJWVQ
         rNvpe/3Kf5owhz0qcM3pRGZRh4eoVErjAUdpNWGuWUl6DIE7MSXYMMAtPRbO0zed4jmJ
         jTXtV3CO8tld6Ni/BtLw7fZRC+5YyAZ89J9kiFECXDrUDQtXRKRdjbAvOoZ30Kasm9od
         wLDg==
X-Gm-Message-State: AC+VfDzefRH3EaX3Rn28J3Q6SDdHk+IvJSVbAw96PNVPnhxMZJoAjzf0
        gmZpK3F15LVw5mPCzeG3Eiu9pQ==
X-Google-Smtp-Source: ACHHUZ4b/aCDaBtIdPzUbKpidRmN5OsswCQ5bEgs99Rdfcrio9a0CpeRS0Hj7ydKQZE2cEW+cxvEEQ==
X-Received: by 2002:a05:6a00:2350:b0:63b:8eeb:77b8 with SMTP id j16-20020a056a00235000b0063b8eeb77b8mr29536046pfj.13.1683145579175;
        Wed, 03 May 2023 13:26:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:e51a:7909:25fb:7d3? ([2601:647:4900:1fbb:e51a:7909:25fb:7d3])
        by smtp.gmail.com with ESMTPSA id s14-20020a056a00194e00b00627ed4e23e0sm23993544pfk.101.2023.05.03.13.26.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2023 13:26:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH 1/7] bpf: tcp: Avoid taking fast sock lock in iterator
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <e0a2d975-9160-57d1-1368-21df73ff3273@meta.com>
Date:   Wed, 3 May 2023 13:26:17 -0700
Cc:     bpf@vger.kernel.org, kafai@fb.com, sdf@google.com,
        edumazet@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <93FFD47E-B010-4EE6-8BB3-1729814B183A@isovalent.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
 <20230418153148.2231644-2-aditi.ghag@isovalent.com>
 <e0a2d975-9160-57d1-1368-21df73ff3273@meta.com>
To:     Yonghong Song <yhs@meta.com>
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



> On Apr 24, 2023, at 10:45 PM, Yonghong Song <yhs@meta.com> wrote:
>=20
>=20
>=20
> On 4/18/23 8:31 AM, Aditi Ghag wrote:
>> Previously, BPF TCP iterator was acquiring fast version of sock lock =
that
>> disables the BH. This introduced a circular dependency with code =
paths that
>> later acquire sockets hash table bucket lock.
>> Replace the fast version of sock lock with slow that faciliates BPF
>> programs executed from the iterator to destroy TCP listening sockets
>> using the bpf_sock_destroy kfunc (implemened in follow-up commits).
>> Here is a stack trace that motivated this change:
>> ```
>> 1) sock_lock with BH disabled + bucket lock
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
>=20
> IIUC, the above deadlock is due to
>=20
> > lock_acquire+0xcd/0x330
> > _raw_spin_lock_bh+0x38/0x50
> > inet_unhash+0x96/0xd0
> > tcp_set_state+0x6a/0x210
> > tcp_abort+0x12b/0x230
> > bpf_prog_f4110fb1100e26b5_iter_tcp6_server+0xa3/0xaa
> > bpf_iter_run_prog+0x1ff/0x340
> > ... lock_acquire for sock lock ...
> > bpf_iter_tcp_seq_show+0xca/0x190
> > bpf_seq_read+0x177/0x450
> > vfs_read+0xc6/0x300
> > ksys_read+0x69/0xf0
> > do_syscall_64+0x3c/0x90
> > entry_SYSCALL_64_after_hwframe+0x72/0xdc
>=20
> I could be great to make it explicit with the stack trace so
> it is clear where the circular dependency is.
>=20
>> 2) sock lock with BH enable
>> [    1.499968]   lock_acquire+0xcd/0x330
>> [    1.500316]   _raw_spin_lock+0x33/0x40
>> [    1.500670]   sk_clone_lock+0x146/0x520
>> [    1.501030]   inet_csk_clone_lock+0x1b/0x110
>> [    1.501433]   tcp_create_openreq_child+0x22/0x3f0
>> [    1.501873]   tcp_v6_syn_recv_sock+0x96/0x940
>> [    1.502284]   tcp_check_req+0x137/0x660
>> [    1.502646]   tcp_v6_rcv+0xa63/0xe80
>> [    1.502994]   ip6_protocol_deliver_rcu+0x78/0x590
>> [    1.503434]   ip6_input_finish+0x72/0x140
>> [    1.503818]   __netif_receive_skb_one_core+0x63/0xa0
>> [    1.504281]   process_backlog+0x79/0x260
>> [    1.504668]   __napi_poll.constprop.0+0x27/0x170
>> [    1.505104]   net_rx_action+0x14a/0x2a0
>> [    1.505469]   __do_softirq+0x165/0x510
>> [    1.505842]   do_softirq+0xcd/0x100
>> [    1.506172]   __local_bh_enable_ip+0xcc/0xf0
>> [    1.506588]   ip6_finish_output2+0x2a8/0xb00
>> [    1.506988]   ip6_finish_output+0x274/0x510
>> [    1.507377]   ip6_xmit+0x319/0x9b0
>> [    1.507726]   inet6_csk_xmit+0x12b/0x2b0
>> [    1.508096]   __tcp_transmit_skb+0x549/0xc40
>> [    1.508498]   tcp_rcv_state_process+0x362/0x1180
>=20
> Similarly, it would be good to illustrate where is the
> deadlock in this case.


Ack: responded to Paolo's message directly with more details. Thanks!

>=20
>> ```
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

