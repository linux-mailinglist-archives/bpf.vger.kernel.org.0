Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A755A5973
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 04:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiH3CeC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 22:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiH3CeB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 22:34:01 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F42A9E2D9
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 19:34:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q9so9402525pgq.6
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 19:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc;
        bh=NC5D4/9ODNR2utpR0eH1iQpIrCsga7h77tOJJBtfqvs=;
        b=jPn0Ejz+gQCyY2cBc+ze45WRDr3MJCFQPEjts9JdS0WiPA2OcXwifpzBQdlw+rlGbc
         UhnOQHZTGDooAuLvEJ2XKX/++OPABkaBR0cwH2kHib+D/hvS520pen9S8NhkwHYweLEO
         rL8SSW3qp9NFGTkn6CWJwMwe6/ZnoTzCXc5xQ+NnhpbQnBbXHbXSKKmEIJCWvxLAc308
         i905uvMvQFax5KdAIiLQPTlmFZlzbalkophLk9AObwU2WOG8MKwFNJfiAOz6rYtJsX0Q
         Fsc/QGZ/KfB7rsO/ggrBV4pwgrQIg3Otn17eOPsRSbSr/cttkrDfl7vxeEnWasKQkcmG
         jHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc;
        bh=NC5D4/9ODNR2utpR0eH1iQpIrCsga7h77tOJJBtfqvs=;
        b=FYzMlkYoSpxCsDNa6vAyYrjpoTfjXWy2b9vxrIoazkaWPK0jIOWU9jqJjg9V2h/3gY
         MuSb9r0sFuAnpjRFNt8LRltIkG+r1aRJMi/AJhrK/kq9H0bQUF63q/yS02v4mAGvhVkd
         D+on8Lfy5pNTIyp+kdwm3axgacYFXFctN662cJhhL6jdms4HWp1vjL/tOU2hANgZjlQA
         H4otasoI9U+5I4NJ4TsqzxJ8UOZi3oh3TaNo4gT39+ASX9Mqt+uTmEkkR17KKyEjH+2S
         NT1Vc5YWbLM7ftd9bO+CAycIa3s42tQjxJe7a2ORaTC6Sx2NvELndda9zsHolYy1LCIg
         ScyQ==
X-Gm-Message-State: ACgBeo0Szro8QfieyOU2kPYPyUxUGccnVXgI9MqXFpqY0DStobZRBLfq
        vdiQpAZGdZ5kJvuMV3+7g8Y=
X-Google-Smtp-Source: AA6agR5IHa+ebY/xTobkfDq3rnoYqvazJEyw/BkkM5rveXjfWsh1SahAXF4oErmJ+iDuKuBKZlvSqw==
X-Received: by 2002:a05:6a00:a90:b0:530:2f3c:da43 with SMTP id b16-20020a056a000a9000b005302f3cda43mr19287984pfl.50.1661826840486;
        Mon, 29 Aug 2022 19:34:00 -0700 (PDT)
Received: from localhost ([98.97.36.213])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902ea0300b00174c5fb500dsm3264442plg.116.2022.08.29.19.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:33:59 -0700 (PDT)
Date:   Mon, 29 Aug 2022 19:33:55 -0700
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
Message-ID: <630d77139b34c_9c0be2089d@john.notmuch>
In-Reply-To: <20220823133755.314697-2-liujian56@huawei.com>
References: <20220823133755.314697-1-liujian56@huawei.com>
 <20220823133755.314697-2-liujian56@huawei.com>
Subject: RE: [PATCH bpf-next v2 1/2] net: If the sock is dead, do not access
 sock's sk_wq in sk_stream_wait_memory
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
> We should check if SOCK_DEAD flag is set on wakeup in
> sk_stream_wait_memory, before accessing the wait queue.
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---

This LGTM but would be great if Eric could ACK as well from TCP side.

Acked-by: John Fastabend <john.fastabend@gmail.com>
