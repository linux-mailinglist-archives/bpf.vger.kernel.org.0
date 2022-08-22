Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1085B59C372
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 17:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbiHVPwg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 11:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiHVPwf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 11:52:35 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C072C12A
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 08:52:34 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3378303138bso265385537b3.9
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SV/3XTnA1B+b9u9DiRDfjj8ulOtTS/Sr5qrNrmd/ti4=;
        b=ZRF+02j0WM0QGoEk+lD43Tw3Rs0t+qoj1jK2wobaOZgNB+1aAs08O2f8TuyTLn16F9
         EG0K8D8ck1dfEpiR0uxY7KlNDa+8Sra0qb3mLFiIgbZ/GAXu4uz38sg7JppQ3B7wh39s
         dGRQgiziLhYhadpC2An1jcccGeV/Tv2+7ym03FykPZHlPjTmqdRLI0I5MglykLxXdquD
         oRiWcAlEL5V6cLJ/KeSElWXQdkBL7EZemHy08noxl1+pGY9AobaqelNTD6aBJziqd4Z1
         kAFlRzVwXTk0YzDWEnHoN4jW4OibDu6CVADrZYYIH9T6EwbvCwlqcH3frrElbl7fzelg
         Z1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SV/3XTnA1B+b9u9DiRDfjj8ulOtTS/Sr5qrNrmd/ti4=;
        b=QGBIfweTWkpcoDz7lc2d1Knf8z5jDrMwkAbWTdFG7leQHoNvKbVX0Qtjravhz7rCA9
         Du2Pfx9TMYHHNvqscE+BA+0sXQmDI/brTHGt5dQ4H05ujfiGzpPIVJ+ny7uqlgZPN/hJ
         0G8A4rClnnT7OhAePoi8ePi+OqCAJfGl7aUuzwn+flFXXNtYUwRZekPwLLwPTC45h5Lp
         uEHVqrPfX6jYFwYf1M37LtBYhunaCFj2HyMXAyfx9ZUWbGA7+5tTuKBzk+GbM7Qe4PEj
         gPSwn4BPih8ui+KB7ZjMnAtZcSwLk+N8AvoYLawg0im54j8uMEaWVaDwuovlMBlbWpar
         eb7Q==
X-Gm-Message-State: ACgBeo057dnTfc+lQV4mXb15N2A1VY+MzM/Qw6pvEJ2+VWfaixdIW/Ad
        GfwGG8Ac8vDRNdN3bPWLm5s8uLrKJoJrFIQ3T6JuOQ==
X-Google-Smtp-Source: AA6agR54jUDV70ncP2DhClmTlRb8VdAGBS68FHgvG2FW1yTNuaZd6ZshV2tkrZ03ThEcyaFDhCYHCMJD3p8O6MR9vuo=
X-Received: by 2002:a05:690c:82e:b0:338:f953:5e6b with SMTP id
 by14-20020a05690c082e00b00338f9535e6bmr13899453ywb.55.1661183553402; Mon, 22
 Aug 2022 08:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220815023343.295094-1-liujian56@huawei.com> <20220815023343.295094-2-liujian56@huawei.com>
 <871qtc1u9e.fsf@cloudflare.com> <2ad6173f254f4842b1abaeaf9a7a1e7d@huawei.com> <87wnb4zfhn.fsf@cloudflare.com>
In-Reply-To: <87wnb4zfhn.fsf@cloudflare.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 22 Aug 2022 08:52:22 -0700
Message-ID: <CANn89i+LX=fUhcjdzppm7u2bqgwApRSPDscuwhN6828ua=LumA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] sk_msg: Keep reference on socket file while wait_memory
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     "liujian (CE)" <liujian56@huawei.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 19, 2022 at 3:37 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
>
> On Fri, Aug 19, 2022 at 10:01 AM GMT, liujian (CE) wrote:
> >> -----Original Message-----
> >> From: Jakub Sitnicki [mailto:jakub@cloudflare.com]
> >> Sent: Friday, August 19, 2022 4:39 PM
> >> To: liujian (CE) <liujian56@huawei.com>; john.fastabend@gmail.com;
> >> edumazet@google.com
> >> Cc: davem@davemloft.net; yoshfuji@linux-ipv6.org; dsahern@kernel.org;
> >> kuba@kernel.org; pabeni@redhat.com; andrii@kernel.org; mykolal@fb.com;
> >> ast@kernel.org; daniel@iogearbox.net; martin.lau@linux.dev;
> >> song@kernel.org; yhs@fb.com; kpsingh@kernel.org; sdf@google.com;
> >> haoluo@google.com; jolsa@kernel.org; shuah@kernel.org;
> >> bpf@vger.kernel.org
> >> Subject: Re: [PATCH bpf-next 1/2] sk_msg: Keep reference on socket file
> >> while wait_memory
> >>
> >> On Mon, Aug 15, 2022 at 10:33 AM +08, Liu Jian wrote:
> >> > Fix the below NULL pointer dereference:
> >> >
> >> > [   14.471200] Call Trace:
> >> > [   14.471562]  <TASK>
> >> > [   14.471882]  lock_acquire+0x245/0x2e0
> >> > [   14.472416]  ? remove_wait_queue+0x12/0x50
> >> > [   14.473014]  ? _raw_spin_lock_irqsave+0x17/0x50
> >> > [   14.473681]  _raw_spin_lock_irqsave+0x3d/0x50
> >> > [   14.474318]  ? remove_wait_queue+0x12/0x50
> >> > [   14.474907]  remove_wait_queue+0x12/0x50
> >> > [   14.475480]  sk_stream_wait_memory+0x20d/0x340
> >> > [   14.476127]  ? do_wait_intr_irq+0x80/0x80
> >> > [   14.476704]  do_tcp_sendpages+0x287/0x600
> >> > [   14.477283]  tcp_bpf_push+0xab/0x260
> >> > [   14.477817]  tcp_bpf_sendmsg_redir+0x297/0x500
> >> > [   14.478461]  ? __local_bh_enable_ip+0x77/0xe0
> >> > [   14.479096]  tcp_bpf_send_verdict+0x105/0x470
> >> > [   14.479729]  tcp_bpf_sendmsg+0x318/0x4f0
> >> > [   14.480311]  sock_sendmsg+0x2d/0x40
> >> > [   14.480822]  ____sys_sendmsg+0x1b4/0x1c0
> >> > [   14.481390]  ? copy_msghdr_from_user+0x62/0x80
> >> > [   14.482048]  ___sys_sendmsg+0x78/0xb0
> >> > [   14.482580]  ? vmf_insert_pfn_prot+0x91/0x150
> >> > [   14.483215]  ? __do_fault+0x2a/0x1a0
> >> > [   14.483738]  ? do_fault+0x15e/0x5d0
> >> > [   14.484246]  ? __handle_mm_fault+0x56b/0x1040
> >> > [   14.484874]  ? lock_is_held_type+0xdf/0x130
> >> > [   14.485474]  ? find_held_lock+0x2d/0x90
> >> > [   14.486046]  ? __sys_sendmsg+0x41/0x70
> >> > [   14.486587]  __sys_sendmsg+0x41/0x70
> >> > [   14.487105]  ? intel_pmu_drain_pebs_core+0x350/0x350
> >> > [   14.487822]  do_syscall_64+0x34/0x80
> >> > [   14.488345]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >> >
> >> > The test scene as following flow:
> >> > thread1                               thread2
> >> > -----------                           ---------------
> >> >  tcp_bpf_sendmsg
> >> >   tcp_bpf_send_verdict
> >> >    tcp_bpf_sendmsg_redir              sock_close
> >> >     tcp_bpf_push_locked                 __sock_release
> >> >      tcp_bpf_push                         //inet_release
> >> >       do_tcp_sendpages                    sock->ops->release
> >> >        sk_stream_wait_memory                  // tcp_close
> >> >           sk_wait_event                      sk->sk_prot->close
> >> >            release_sock(__sk);
> >> >             ***
> >> >
> >> >                                                 lock_sock(sk);
> >> >                                                   __tcp_close
> >> >                                                     sock_orphan(sk)
> >> >                                                       sk->sk_wq  = NULL
> >> >                                                 release_sock
> >> >             ****
> >> >            lock_sock(__sk);
> >> >           remove_wait_queue(sk_sleep(sk), &wait);
> >> >              sk_sleep(sk)
> >> >              //NULL pointer dereference
> >> >              &rcu_dereference_raw(sk->sk_wq)->wait
> >> >
> >> > While waiting for memory in thread1, the socket is released with its
> >> > wait queue because thread2 has closed it. This caused by
> >> > tcp_bpf_send_verdict didn't increase the f_count of psock->sk_redir-
> >> >sk_socket->file in thread1.
> >>
> >> I'm not sure about this approach. Keeping a closed sock file alive, just so we
> >> can wakeup from sleep, seems like wasted effort.
> >>
> >> __tcp_close sets sk->sk_shutdown = RCV_SHUTDOWN | SEND_SHUTDOWN.
> >> So we will return from sk_stream_wait_memory via the do_error path.
> >>
> >> SEND_SHUTDOWN might be set because socket got closed and orphaned -
> >> dead and detached from its file, like in this case.
> >>
> >> So, IMHO, we should check if SOCK_DEAD flag is set on wakeup due to
> >> SEND_SHUTDOWN in sk_stream_wait_memory, before accessing the wait
> >> queue.
> >>
> >> [...]
> > As jakub's approach, this problem can be solved.
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index a7273b289188..a3dab7140f1e 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1998,6 +1998,8 @@ static inline void sk_set_socket(struct sock *sk, struct socket *sock)
> >  static inline wait_queue_head_t *sk_sleep(struct sock *sk)
> >  {
> >         BUILD_BUG_ON(offsetof(struct socket_wq, wait) != 0);
> > +       if (sock_flag(sk, SOCK_DEAD))
> > +               return NULL;
> >         return &rcu_dereference_raw(sk->sk_wq)->wait;
> >  }
> >  /* Detach socket from process context.
> > diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> > index 9860bb9a847c..da1be17d0b19 100644
> > --- a/kernel/sched/wait.c
> > +++ b/kernel/sched/wait.c
> > @@ -51,6 +51,8 @@ void remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry
> >  {
> >         unsigned long flags;
> >
> > +       if (wq_head == NULL)
> > +               return;
> >         spin_lock_irqsave(&wq_head->lock, flags);
> >         __remove_wait_queue(wq_head, wq_entry);
> >         spin_unlock_irqrestore(&wq_head->lock, flags);
>
> I don't know if we want to change the contract for sk_sleep()
> remove_wait_queue() so that they accept dead sockets or nulls.
>
> How about just:
>
> diff --git a/net/core/stream.c b/net/core/stream.c
> index ccc083cdef23..1105057ce00a 100644
> --- a/net/core/stream.c
> +++ b/net/core/stream.c
> @@ -159,7 +159,8 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
>                 *timeo_p = current_timeo;
>         }
>  out:
> -       remove_wait_queue(sk_sleep(sk), &wait);
> +       if (!sock_flag(sk, SOCK_DEAD))
> +               remove_wait_queue(sk_sleep(sk), &wait);
>         return err;
>
>  do_error:
>

OK, but what about tcp_msg_wait_data() and udp_msg_wait_data () ?
It seems they could be vulnerable as well..
