Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A41599805
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 11:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347665AbiHSJCM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 05:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347025AbiHSJCK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 05:02:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C686F23C1
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 02:02:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id qn6so7592569ejc.11
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 02:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc;
        bh=FnOgTS6P6pkWF5l/Qts2hE9FfSfpoGbi274HGSdbW7o=;
        b=OC8t7wut7ZnT38rvXfRAL725WAKWB283zuSuHMRJ6w8hCkHqFuXNvfRRlNhsHfaFz6
         53C1FTjX3PhJg0JP9Y28vTV51MIfdhSvXWmEhcYeUwX/fjFEfMF886wHk4aKWR9Z0r/p
         ia8DqP5V2oMuTgikVhH69F68VgiaIucnvr6KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc;
        bh=FnOgTS6P6pkWF5l/Qts2hE9FfSfpoGbi274HGSdbW7o=;
        b=cybe8wRHaxB3lXPYa1jjV61GtwkDaLtjsK5AN0jul71EkFxaqF0R9xlHK0k+zCNIgN
         kXS78NcijgqYiLoUbsyipd5qYcD4VkYKKMuHa4A9SkVv87TVfDsCsYe9iAgv+LX8BTNH
         q926HUvJIfjq+viwxObEbYMIYwyMiWbdC5DOkFs0w2kgH7jIiHUNs0khpU1I4s6bRwAF
         LjeqbboQDArD1zMh53Ho/HB5/dkQ7Ffodc9Bhx0dyMOuv/I1F6afYMbgwiXWAijf0Mxh
         1rauaLM89sJoDh++JM8+kd0cKP2kDLOEebfOhtwphBTWTFps9JmAac/znmCjaTFQSvpK
         yURA==
X-Gm-Message-State: ACgBeo38vNacJO5j/X3IyElXRB/x2m6zXb2X4J3BZMSycqXL93Os/MKS
        b88SAu+Fl5mgQDuc2oTuKXLsUQ==
X-Google-Smtp-Source: AA6agR5RsAcNC/Oy7xOLVP3CV0POALsMhEjvmgOX8bKKzv6dyB9ehVItD0yIV2593F1df10T/1HzmQ==
X-Received: by 2002:a17:907:1688:b0:730:b3ae:347 with SMTP id hc8-20020a170907168800b00730b3ae0347mr4230354ejc.756.1660899726913;
        Fri, 19 Aug 2022 02:02:06 -0700 (PDT)
Received: from cloudflare.com (79.184.200.53.ipv4.supernova.orange.pl. [79.184.200.53])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b00726c0e63b94sm2020308ejh.27.2022.08.19.02.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 02:02:06 -0700 (PDT)
References: <20220815023343.295094-1-liujian56@huawei.com>
 <20220815023343.295094-2-liujian56@huawei.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Liu Jian <liujian56@huawei.com>, john.fastabend@gmail.com,
        edumazet@google.com
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, andrii@kernel.org,
        mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] sk_msg: Keep reference on socket file
 while wait_memory
Date:   Fri, 19 Aug 2022 10:39:07 +0200
In-reply-to: <20220815023343.295094-2-liujian56@huawei.com>
Message-ID: <871qtc1u9e.fsf@cloudflare.com>
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

On Mon, Aug 15, 2022 at 10:33 AM +08, Liu Jian wrote:
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

I'm not sure about this approach. Keeping a closed sock file alive, just
so we can wakeup from sleep, seems like wasted effort.

__tcp_close sets sk->sk_shutdown = RCV_SHUTDOWN | SEND_SHUTDOWN. So we
will return from sk_stream_wait_memory via the do_error path.

SEND_SHUTDOWN might be set because socket got closed and orphaned - dead
and detached from its file, like in this case.

So, IMHO, we should check if SOCK_DEAD flag is set on wakeup due to
SEND_SHUTDOWN in sk_stream_wait_memory, before accessing the wait queue.

[...]
