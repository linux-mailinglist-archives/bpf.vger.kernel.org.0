Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115CC6CC61E
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjC1PXb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 11:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjC1PXK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 11:23:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0BEEB64
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 08:21:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f22so7879757plr.0
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680016855;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjGeHIEYAS2j3Kyp1JMk2wgI4QYPfJYf+eTOeffiKhI=;
        b=JsDqxB4dkdIf1M9J/YxU/Sk3bKTVWndFz+S3iHOqoajn6KArNxk3UBvpGRZNnMSRJQ
         3LbLtzOMjulgxyczmutElUbHJAWlWqltbmAwcgqSJ+HQyDMUcpkSylcZcLk3L2IiQdkw
         gyQSlcgT4ryP+s6fuMyVnrWuOJY7JhsO5C8hRVQxpDULnDFs61O+Veu4tfNAYj/13+/f
         yp0onsF9dXZNS47NBGHk1yywNWP2NqFaPzaNl+EihQHh31nvfHn+VqTKGIWgaux59LqG
         XrPve05jBkJXWsYkg0Jp9mneKC6OxiNEEm7H5Zf8S6Z2soAOvVkhEiAC1V571vdfxpWa
         HHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680016855;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjGeHIEYAS2j3Kyp1JMk2wgI4QYPfJYf+eTOeffiKhI=;
        b=ynGhAAcNStAWLc3KRQea0z0OKb802rpiUE3mF2FmIIJS0oWYWhD6Ptz6OrT4YrJVCO
         j+J3ZFyp1jzoNh5ubqWQ96a/NvfCUnimD0Gizf0c7mOt7GjFDFB+S53TKlM6XjPkkTI3
         oHujeAn0vEZWcDo32ijNKkihyQ8Cf/YUfZvuCUkk4BaDJGyoVaAcTKrljvjHRiaPr3W3
         WJAAda2LfpXM2zkDY20UdFLN0P0UaLGr66gjgWyfPbI0jxnVnnOlO1z0+5xbckM8gWIJ
         Sp+I4zTUSgcLE8aMZSkUcNL6i2S2GJr9svlyVIKp8HZwL5E1IOobwnL4T7rGpMkizuvv
         U2AA==
X-Gm-Message-State: AAQBX9fVBYDSSU+ZVMYAdD6Z7ir/Fet7jASVfO35rgguOyqQHngIdDxZ
        BKcGjVJlqP4DtDZH9jRyPgnSjA==
X-Google-Smtp-Source: AKy350ZUDZ08a0UTQT6fl8Jrkp11MmPAJ3/ZFDqa04LDmA5xfwdLEaBSooyijFHAx/lnIgCooiuPTQ==
X-Received: by 2002:a17:90b:1e43:b0:23f:8752:98be with SMTP id pi3-20020a17090b1e4300b0023f875298bemr18730611pjb.4.1680016854720;
        Tue, 28 Mar 2023 08:20:54 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:74d3:2bc6:6239:344c? ([2601:647:4900:1fbb:74d3:2bc6:6239:344c])
        by smtp.gmail.com with ESMTPSA id iq10-20020a17090afb4a00b0023b29b464f9sm9436682pjb.27.2023.03.28.08.20.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2023 08:20:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v4 bpf-next 3/4] bpf,tcp: Avoid taking fast sock lock in
 iterator
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <ZB4Z7cnF+RDMaKvW@google.com>
Date:   Tue, 28 Mar 2023 08:20:52 -0700
Cc:     bpf@vger.kernel.org, kafai@fb.com,
        Eric Dumazet <edumazet@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A24468B-2F5C-4556-B413-4974409C4590@isovalent.com>
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-4-aditi.ghag@isovalent.com>
 <ZB4Z7cnF+RDMaKvW@google.com>
To:     Stanislav Fomichev <sdf@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 24, 2023, at 2:45 PM, Stanislav Fomichev <sdf@google.com> =
wrote:
>=20
> On 03/23, Aditi Ghag wrote:
>> Previously, BPF TCP iterator was acquiring fast version of sock lock =
that
>> disables the BH. This introduced a circular dependency with code =
paths that
>> later acquire sockets hash table bucket lock.
>> Replace the fast version of sock lock with slow that faciliates BPF
>> programs executed from the iterator to destroy TCP listening sockets
>> using the bpf_sock_destroy kfunc.
>=20
>> Here is a stack trace that motivated this change:
>=20
>> ```
>> 1) sock_lock with BH disabled + bucket lock
>=20
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
>> 2) sock lock with BH enable
>=20
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
>> ```
>=20
>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>=20
> Acked-by: Stanislav Fomichev <sdf@google.com>
>=20
> Don't need fixes because it doesn't trigger without your new
> bpf_sock_destroy?

That's right.

>=20
>=20
>> ---
>>  net/ipv4/tcp_ipv4.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
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
>=20
>> @@ -2970,7 +2969,7 @@ static int bpf_iter_tcp_seq_show(struct =
seq_file *seq, void *v)
>>  		return 0;
>=20
>>  	if (sk_fullsock(sk))
>> -		slow =3D lock_sock_fast(sk);
>> +		lock_sock(sk);
>=20
>>  	if (unlikely(sk_unhashed(sk))) {
>>  		ret =3D SEQ_SKIP;
>> @@ -2994,7 +2993,7 @@ static int bpf_iter_tcp_seq_show(struct =
seq_file *seq, void *v)
>=20
>>  unlock:
>>  	if (sk_fullsock(sk))
>> -		unlock_sock_fast(sk, slow);
>> +		release_sock(sk);
>>  	return ret;
>=20
>>  }
>> --
>> 2.34.1

