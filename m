Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6035D5999D3
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 12:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245098AbiHSKhM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 06:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348227AbiHSKhM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 06:37:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8EEF438B
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 03:37:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r4so5131170edi.8
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc;
        bh=QsEaufN8elOkxyYkBSs1ElvXCpjDNX+kzGQIG065aiI=;
        b=pK811Wz2NzMerPkeJY4198aIAqKVaWZ1H16jf7gVn1Ng0Koof6BvZm3rbqVS/qqG3v
         APzC+FPyKmloxStZyCsla4PmKDiXwOYypkZncW8Wx2nxk9l3Ci0rg74ung3Xc9bL72gB
         hCicgx9f57nrb+MGjmkZi0/4qg/JXF+xEb39Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc;
        bh=QsEaufN8elOkxyYkBSs1ElvXCpjDNX+kzGQIG065aiI=;
        b=ABZC0WK2UcB9EwX+kmmO2u09p2EXRpTZNrNyI55fUO13OvMePVNfZdUWJri2hIAUUH
         OavixxnJr4bE4O3Ecz1RFyquuzwVGqR2XzL3ACQ343zIqCciyzUeQ/HVu8LqBAOGXu/w
         xt1ahiPSXqXzuhL+/Y+dZ0G1E+9x1o/H5jNBeA7rZqLq2BMBXpUC2NntdR6/xzxI7KB1
         l31jXPCjiSCGatmc4LRFxp8L14ttKs3u/GWgEFxjdctQUDgYc0Q38DqFyWGgwcv6pGKK
         b0IwUwzA2dlM8N2y/FhMCvPmyG7R8KXYUq2cEMa487HALwEe2y5vWpxhv24IhcL0dgTR
         CyOA==
X-Gm-Message-State: ACgBeo2Wy99vb4UxfmuK1uQWSiRAghKd0R+w1clz8XoSYnNMw8dVUgv9
        XNrozWxAe5yQtHDy+T4yUZ2rQQ==
X-Google-Smtp-Source: AA6agR4W6boYrOmdIRkqk9iAVlfej5ZekjZxH8/6zt+ERgWxXJ3wxbfjN7s48ol1stIPS+jk7qqehQ==
X-Received: by 2002:aa7:d856:0:b0:445:e147:e014 with SMTP id f22-20020aa7d856000000b00445e147e014mr5640783eds.425.1660905429522;
        Fri, 19 Aug 2022 03:37:09 -0700 (PDT)
Received: from cloudflare.com (79.184.200.53.ipv4.supernova.orange.pl. [79.184.200.53])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906329b00b0073c0b87ba34sm1840601ejw.198.2022.08.19.03.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 03:37:09 -0700 (PDT)
References: <20220815023343.295094-1-liujian56@huawei.com>
 <20220815023343.295094-2-liujian56@huawei.com>
 <871qtc1u9e.fsf@cloudflare.com>
 <2ad6173f254f4842b1abaeaf9a7a1e7d@huawei.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     "liujian (CE)" <liujian56@huawei.com>
Cc:     "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "mykolal@fb.com" <mykolal@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] sk_msg: Keep reference on socket file
 while wait_memory
Date:   Fri, 19 Aug 2022 12:34:42 +0200
In-reply-to: <2ad6173f254f4842b1abaeaf9a7a1e7d@huawei.com>
Message-ID: <87wnb4zfhn.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Fri, Aug 19, 2022 at 10:01 AM GMT, liujian (CE) wrote:
>> -----Original Message-----
>> From: Jakub Sitnicki [mailto:jakub@cloudflare.com]
>> Sent: Friday, August 19, 2022 4:39 PM
>> To: liujian (CE) <liujian56@huawei.com>; john.fastabend@gmail.com;
>> edumazet@google.com
>> Cc: davem@davemloft.net; yoshfuji@linux-ipv6.org; dsahern@kernel.org;
>> kuba@kernel.org; pabeni@redhat.com; andrii@kernel.org; mykolal@fb.com;
>> ast@kernel.org; daniel@iogearbox.net; martin.lau@linux.dev;
>> song@kernel.org; yhs@fb.com; kpsingh@kernel.org; sdf@google.com;
>> haoluo@google.com; jolsa@kernel.org; shuah@kernel.org;
>> bpf@vger.kernel.org
>> Subject: Re: [PATCH bpf-next 1/2] sk_msg: Keep reference on socket file
>> while wait_memory
>> 
>> On Mon, Aug 15, 2022 at 10:33 AM +08, Liu Jian wrote:
>> > Fix the below NULL pointer dereference:
>> >
>> > [   14.471200] Call Trace:
>> > [   14.471562]  <TASK>
>> > [   14.471882]  lock_acquire+0x245/0x2e0
>> > [   14.472416]  ? remove_wait_queue+0x12/0x50
>> > [   14.473014]  ? _raw_spin_lock_irqsave+0x17/0x50
>> > [   14.473681]  _raw_spin_lock_irqsave+0x3d/0x50
>> > [   14.474318]  ? remove_wait_queue+0x12/0x50
>> > [   14.474907]  remove_wait_queue+0x12/0x50
>> > [   14.475480]  sk_stream_wait_memory+0x20d/0x340
>> > [   14.476127]  ? do_wait_intr_irq+0x80/0x80
>> > [   14.476704]  do_tcp_sendpages+0x287/0x600
>> > [   14.477283]  tcp_bpf_push+0xab/0x260
>> > [   14.477817]  tcp_bpf_sendmsg_redir+0x297/0x500
>> > [   14.478461]  ? __local_bh_enable_ip+0x77/0xe0
>> > [   14.479096]  tcp_bpf_send_verdict+0x105/0x470
>> > [   14.479729]  tcp_bpf_sendmsg+0x318/0x4f0
>> > [   14.480311]  sock_sendmsg+0x2d/0x40
>> > [   14.480822]  ____sys_sendmsg+0x1b4/0x1c0
>> > [   14.481390]  ? copy_msghdr_from_user+0x62/0x80
>> > [   14.482048]  ___sys_sendmsg+0x78/0xb0
>> > [   14.482580]  ? vmf_insert_pfn_prot+0x91/0x150
>> > [   14.483215]  ? __do_fault+0x2a/0x1a0
>> > [   14.483738]  ? do_fault+0x15e/0x5d0
>> > [   14.484246]  ? __handle_mm_fault+0x56b/0x1040
>> > [   14.484874]  ? lock_is_held_type+0xdf/0x130
>> > [   14.485474]  ? find_held_lock+0x2d/0x90
>> > [   14.486046]  ? __sys_sendmsg+0x41/0x70
>> > [   14.486587]  __sys_sendmsg+0x41/0x70
>> > [   14.487105]  ? intel_pmu_drain_pebs_core+0x350/0x350
>> > [   14.487822]  do_syscall_64+0x34/0x80
>> > [   14.488345]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> >
>> > The test scene as following flow:
>> > thread1                               thread2
>> > -----------                           ---------------
>> >  tcp_bpf_sendmsg
>> >   tcp_bpf_send_verdict
>> >    tcp_bpf_sendmsg_redir              sock_close
>> >     tcp_bpf_push_locked                 __sock_release
>> >      tcp_bpf_push                         //inet_release
>> >       do_tcp_sendpages                    sock->ops->release
>> >        sk_stream_wait_memory          	   // tcp_close
>> >           sk_wait_event                      sk->sk_prot->close
>> >            release_sock(__sk);
>> >             ***
>> >
>> >                                                 lock_sock(sk);
>> >                                                   __tcp_close
>> >                                                     sock_orphan(sk)
>> >                                                       sk->sk_wq  = NULL
>> >                                                 release_sock
>> >             ****
>> >            lock_sock(__sk);
>> >           remove_wait_queue(sk_sleep(sk), &wait);
>> >              sk_sleep(sk)
>> >              //NULL pointer dereference
>> >              &rcu_dereference_raw(sk->sk_wq)->wait
>> >
>> > While waiting for memory in thread1, the socket is released with its
>> > wait queue because thread2 has closed it. This caused by
>> > tcp_bpf_send_verdict didn't increase the f_count of psock->sk_redir-
>> >sk_socket->file in thread1.
>> 
>> I'm not sure about this approach. Keeping a closed sock file alive, just so we
>> can wakeup from sleep, seems like wasted effort.
>> 
>> __tcp_close sets sk->sk_shutdown = RCV_SHUTDOWN | SEND_SHUTDOWN.
>> So we will return from sk_stream_wait_memory via the do_error path.
>> 
>> SEND_SHUTDOWN might be set because socket got closed and orphaned -
>> dead and detached from its file, like in this case.
>> 
>> So, IMHO, we should check if SOCK_DEAD flag is set on wakeup due to
>> SEND_SHUTDOWN in sk_stream_wait_memory, before accessing the wait
>> queue.
>> 
>> [...]
> As jakub's approach, this problem can be solved.
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index a7273b289188..a3dab7140f1e 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1998,6 +1998,8 @@ static inline void sk_set_socket(struct sock *sk, struct socket *sock)
>  static inline wait_queue_head_t *sk_sleep(struct sock *sk)
>  {
>         BUILD_BUG_ON(offsetof(struct socket_wq, wait) != 0);
> +       if (sock_flag(sk, SOCK_DEAD))
> +               return NULL;
>         return &rcu_dereference_raw(sk->sk_wq)->wait;
>  }
>  /* Detach socket from process context.
> diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> index 9860bb9a847c..da1be17d0b19 100644
> --- a/kernel/sched/wait.c
> +++ b/kernel/sched/wait.c
> @@ -51,6 +51,8 @@ void remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry
>  {
>         unsigned long flags;
>  
> +       if (wq_head == NULL)
> +               return;
>         spin_lock_irqsave(&wq_head->lock, flags);
>         __remove_wait_queue(wq_head, wq_entry);
>         spin_unlock_irqrestore(&wq_head->lock, flags);

I don't know if we want to change the contract for sk_sleep()
remove_wait_queue() so that they accept dead sockets or nulls.

How about just:

diff --git a/net/core/stream.c b/net/core/stream.c
index ccc083cdef23..1105057ce00a 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -159,7 +159,8 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
                *timeo_p = current_timeo;
        }
 out:
-       remove_wait_queue(sk_sleep(sk), &wait);
+       if (!sock_flag(sk, SOCK_DEAD))
+               remove_wait_queue(sk_sleep(sk), &wait);
        return err;

 do_error:




