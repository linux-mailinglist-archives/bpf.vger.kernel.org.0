Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D70059666D
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 02:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiHQAyl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 20:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiHQAyj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 20:54:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C78D7F240
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 17:54:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 130so10781974pfv.13
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 17:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc;
        bh=YGSn4AVZTTm0cs1ExzYJ3eKj7k/3/tini41zm1j9sEQ=;
        b=Zh3DFIiUHscxQZeb7gb1YufMOuDzaRCkDcXcUalOWLu7tndz72Czv8QTRDriXew6vq
         cUFCz7gkrSb7c188ZyXkAj2PfPXGVKXPEj0vZBH0t5Uszv9psY2fq4PkkYmAgRhI8j+g
         pbuWNmKBHon/VR1thzFe7xezkM+2MmwYugC3nCizsYWI+mSBMiUI5ELPNFChpg3QLpKo
         MLKsFAlwqe/DWNIcD3kBtQVny+x5yR5qBGurgeQx0JQ+Dbyjlt0kqA7mBuKEKQPWFrWy
         jf4Mx4iERSqcX7n0/HZqCu5FIDVrp8Ww4/yqC7gtJp5Jn5PKf8p8sxBXo3PPCDbuRAHM
         ukWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc;
        bh=YGSn4AVZTTm0cs1ExzYJ3eKj7k/3/tini41zm1j9sEQ=;
        b=W7akdDAV749nWLT1gL1UaVZdiWwjEvZd4AiZJd4j97famlh+sgI9ew/XP7K3bDcoey
         iU9cCNuFLb+c5GsYo1aABKk74AF3urPUfC64Ua1lIxDZS5lLURPsQhxieF2rWA/h7gDH
         E28vfp0s+QRdnKooNF1Bas8BFth4UaofKa/25eRjS8kAC3mkQolht8/fF/tUDhsmsPIV
         h1p4qoyjQFxwYbEcwPlG0Lv7wQmZZeng03KnVDLSHeXvLYfQx8F06huULMg7RRQx0NzP
         swAbDSQ3wz3q3gIxXc20Tf5nzTUT0xQGz4uOCA0bDGUOP+MH45VJEjUSxUBAKzd6vLft
         ludA==
X-Gm-Message-State: ACgBeo3DCtzDYO5y5V0nPd3YursZ9xXyqtFnChix7jKwu/clcTqsiA/C
        l+YI38Q6gy46UvOwwjBlp34=
X-Google-Smtp-Source: AA6agR5lwUC5J824oN/2LCB9VSmUFJwGMpOnOFF+4rlEjpeN+jH91IC5W/264IB5ERvcMl85Dsnuqw==
X-Received: by 2002:a05:6a02:314:b0:41e:2339:75ec with SMTP id bn20-20020a056a02031400b0041e233975ecmr20470799pgb.134.1660697677740;
        Tue, 16 Aug 2022 17:54:37 -0700 (PDT)
Received: from localhost ([98.97.34.78])
        by smtp.gmail.com with ESMTPSA id z31-20020a630a5f000000b0041c30f78fa6sm7997249pgk.69.2022.08.16.17.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 17:54:36 -0700 (PDT)
Date:   Tue, 16 Aug 2022 17:54:34 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Liu Jian <liujian56@huawei.com>, john.fastabend@gmail.com,
        jakub@cloudflare.com, edumazet@google.com, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, andrii@kernel.org, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
        bpf@vger.kernel.org
Cc:     liujian56@huawei.com
Message-ID: <62fc3c4aad5b2_1cdc820836@john.notmuch>
In-Reply-To: <20220815023343.295094-2-liujian56@huawei.com>
References: <20220815023343.295094-1-liujian56@huawei.com>
 <20220815023343.295094-2-liujian56@huawei.com>
Subject: RE: [PATCH bpf-next 1/2] sk_msg: Keep reference on socket file while
 wait_memory
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Liu Jian wrote:
> Fix the below NULL pointer dereference:
> 
> [   14.471200] Call Trace:
> [   14.471562]  <TASK>
> [   14.471882]  lock_acquire+0x245/0x2e0
> [   14.472416]  ? remove_wait_queue+0x12/0x50
> [   14.473014]  ? _raw_spin_lock_irqsave+0x17/0x50
> [   14.473681]  _raw_spin_lock_irqsave+0x3d/0x50
> [   14.474318]  ? remove_wait_queue+0x12/0x50
> [   14.474907]  remove_wait_queue+0x12/0x50
> [   14.475480]  sk_stream_wait_memory+0x20d/0x340
> [   14.476127]  ? do_wait_intr_irq+0x80/0x80
> [   14.476704]  do_tcp_sendpages+0x287/0x600
> [   14.477283]  tcp_bpf_push+0xab/0x260
> [   14.477817]  tcp_bpf_sendmsg_redir+0x297/0x500
> [   14.478461]  ? __local_bh_enable_ip+0x77/0xe0
> [   14.479096]  tcp_bpf_send_verdict+0x105/0x470
> [   14.479729]  tcp_bpf_sendmsg+0x318/0x4f0
> [   14.480311]  sock_sendmsg+0x2d/0x40
> [   14.480822]  ____sys_sendmsg+0x1b4/0x1c0
> [   14.481390]  ? copy_msghdr_from_user+0x62/0x80
> [   14.482048]  ___sys_sendmsg+0x78/0xb0
> [   14.482580]  ? vmf_insert_pfn_prot+0x91/0x150
> [   14.483215]  ? __do_fault+0x2a/0x1a0
> [   14.483738]  ? do_fault+0x15e/0x5d0
> [   14.484246]  ? __handle_mm_fault+0x56b/0x1040
> [   14.484874]  ? lock_is_held_type+0xdf/0x130
> [   14.485474]  ? find_held_lock+0x2d/0x90
> [   14.486046]  ? __sys_sendmsg+0x41/0x70
> [   14.486587]  __sys_sendmsg+0x41/0x70
> [   14.487105]  ? intel_pmu_drain_pebs_core+0x350/0x350
> [   14.487822]  do_syscall_64+0x34/0x80
> [   14.488345]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> The test scene as following flow:
> thread1                               thread2
> -----------                           ---------------
>  tcp_bpf_sendmsg
>   tcp_bpf_send_verdict
>    tcp_bpf_sendmsg_redir              sock_close
>     tcp_bpf_push_locked                 __sock_release
>      tcp_bpf_push                         //inet_release
>       do_tcp_sendpages                    sock->ops->release
>        sk_stream_wait_memory          	   // tcp_close
>           sk_wait_event                      sk->sk_prot->close
>            release_sock(__sk);
>             ***
> 
>                                                 lock_sock(sk);
>                                                   __tcp_close
>                                                     sock_orphan(sk)
>                                                       sk->sk_wq  = NULL
>                                                 release_sock
>             ****
>            lock_sock(__sk);
>           remove_wait_queue(sk_sleep(sk), &wait);
>              sk_sleep(sk)
>              //NULL pointer dereference
>              &rcu_dereference_raw(sk->sk_wq)->wait
> 
> While waiting for memory in thread1, the socket is released with its wait
> queue because thread2 has closed it. This caused by tcp_bpf_send_verdict
> didn't increase the f_count of psock->sk_redir->sk_socket->file in thread1.
> 
> Avoid it by keeping a reference to the socket file while redirect sock wait
> send memory. Refer to [1].
> 
> [1] https://lore.kernel.org/netdev/20190211090949.18560-1-jakub@cloudflare.com/
> 
> Signed-off-by: Liu Jian <liujian56@huawei.com>

Thanks for the detailed commit message its necessary to understand
the problem without spending hours deciphering it myself.

When I looked at [1] we solved a simliar problem by using
the MSG_DONTWAIT flag so that the error was pushed back to
the sending.

Can we do the same thing here? The nice bit here is the error
would get all the way back to the sending socket so userspace
could decide how to handle it? Did I miss something?

> ---
>  net/ipv4/tcp_bpf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index a1626afe87a1..201375829367 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -125,9 +125,17 @@ static int tcp_bpf_push_locked(struct sock *sk, struct sk_msg *msg,
>  {
>  	int ret;
>  
> +	/* Hold on to socket wait queue. */
> +	if (sk->sk_socket && sk->sk_socket->file)
> +		get_file(sk->sk_socket->file);
> +
>  	lock_sock(sk);
>  	ret = tcp_bpf_push(sk, msg, apply_bytes, flags, uncharge);
>  	release_sock(sk);
> +
> +	if (sk->sk_socket && sk->sk_socket->file)
> +		fput(sk->sk_socket->file);
> +
>  	return ret;
>  }
>  
> -- 
> 2.17.1
> 


