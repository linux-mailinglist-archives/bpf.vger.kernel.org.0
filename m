Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83D85975C1
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 20:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiHQSdh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 14:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbiHQSdd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 14:33:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF369AFFA
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 11:33:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w14so12690733plp.9
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc;
        bh=Lkv6QAv4f4JIPg9zhTcA+8sMPGAR5JzuvwfkHQcH39U=;
        b=QV5xxn4Xpcenz+sknUddo0XxcfluEmTKKX1DXjPA+KQQWs7L61oM63BS9Mzq0SfQFk
         Ej7Gpa5jLlI0GGpaR7CfxLcqCnbjSbFzdMpL+PoA+mnkPjNg/ZzCjcrzEglOtTG9hWmB
         T+PLoGZm/Y3MKumNgv+ePgZpYJE+nLv3b+xwEdAPZPawv8gGAvBMg1F71CdOpuuyLWJf
         suSL976PtDvSbU7wSwLX8WlJ0wJqOaYPoMJSEVkyDI6H/RcPYKDbKXmJhSnGRLyTbGEQ
         ++3gCTTjOPu2HC6AnvLXQnBrCwSlRyOfG3/6R+RQLG+RVQhXtYOG5rviJX5E8mrcu54z
         BIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc;
        bh=Lkv6QAv4f4JIPg9zhTcA+8sMPGAR5JzuvwfkHQcH39U=;
        b=Y+69Dd8YQRrDUdxbB8WASdOUO40vOIBYgwMT5NfIM6JTFFTQacw1a5/Q6GYogD6FpI
         wyX2Cssb0K6PJQo5LVwYdjFh62oIKjHarV3ePUVuPjrX3hi4AInsr8fpvLXEU0ZdfLVU
         0ePw8j9m1dLrrcgz6RrHSTfM0PSYZj8EIVEDd51xR6/nkHrU30vqZKVTd/ZnBRAOZdz8
         YS8k9LdOVWa4l16c8ULNsQb5EHj4YKMXoo8WCocuWp0Bi6Kdn3ewVmtDGI2r1MigBMua
         UeGJstnBymub+OF8MMWsuaPdZRQoWNhWQl+txj5wfcmIyqw6Ouka1dHWQ8jFaPizspUA
         ONSw==
X-Gm-Message-State: ACgBeo2aYAYxxHL8JTEju4hh6lgJjfNZG9E0zPUbEKX89F3JMaXdvRbr
        csjvW1KSjE4cgJV9Oz9Bt+8=
X-Google-Smtp-Source: AA6agR5Xu6d6pGNbuSU/AMMROZ2I/C7bQELgT9T3GoobqS0moXsIBcO88v1VBa82YUmYB8HKN35XUg==
X-Received: by 2002:a17:90b:4c07:b0:1f5:40a:8040 with SMTP id na7-20020a17090b4c0700b001f5040a8040mr4952625pjb.121.1660761210860;
        Wed, 17 Aug 2022 11:33:30 -0700 (PDT)
Received: from localhost ([98.97.34.78])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902dacc00b0017269cc60d7sm227792plx.214.2022.08.17.11.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 11:33:29 -0700 (PDT)
Date:   Wed, 17 Aug 2022 11:33:27 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     "liujian (CE)" <liujian56@huawei.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "jakub@cloudflare.com" <jakub@cloudflare.com>,
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
Message-ID: <62fd34777acc9_23bf1208a3@john.notmuch>
In-Reply-To: <3497c978eefd4db7ad0c022fefe14cf6@huawei.com>
References: <20220815023343.295094-1-liujian56@huawei.com>
 <20220815023343.295094-2-liujian56@huawei.com>
 <62fc3c4aad5b2_1cdc820836@john.notmuch>
 <3497c978eefd4db7ad0c022fefe14cf6@huawei.com>
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

liujian (CE) wrote:
> 
> 
> > -----Original Message-----
> > From: John Fastabend [mailto:john.fastabend@gmail.com]
> > Sent: Wednesday, August 17, 2022 8:55 AM
> > To: liujian (CE) <liujian56@huawei.com>; john.fastabend@gmail.com;
> > jakub@cloudflare.com; edumazet@google.com; davem@davemloft.net;
> > yoshfuji@linux-ipv6.org; dsahern@kernel.org; kuba@kernel.org;
> > pabeni@redhat.com; andrii@kernel.org; mykolal@fb.com; ast@kernel.org;
> > daniel@iogearbox.net; martin.lau@linux.dev; song@kernel.org; yhs@fb.com;
> > kpsingh@kernel.org; sdf@google.com; haoluo@google.com;
> > jolsa@kernel.org; shuah@kernel.org; bpf@vger.kernel.org
> > Cc: liujian (CE) <liujian56@huawei.com>
> > Subject: RE: [PATCH bpf-next 1/2] sk_msg: Keep reference on socket file
> > while wait_memory
> > 
> > Liu Jian wrote:
> > > Fix the below NULL pointer dereference:
> > >
> > > [   14.471200] Call Trace:
> > > [   14.471562]  <TASK>
> > > [   14.471882]  lock_acquire+0x245/0x2e0
> > > [   14.472416]  ? remove_wait_queue+0x12/0x50
> > > [   14.473014]  ? _raw_spin_lock_irqsave+0x17/0x50
> > > [   14.473681]  _raw_spin_lock_irqsave+0x3d/0x50
> > > [   14.474318]  ? remove_wait_queue+0x12/0x50
> > > [   14.474907]  remove_wait_queue+0x12/0x50
> > > [   14.475480]  sk_stream_wait_memory+0x20d/0x340
> > > [   14.476127]  ? do_wait_intr_irq+0x80/0x80
> > > [   14.476704]  do_tcp_sendpages+0x287/0x600
> > > [   14.477283]  tcp_bpf_push+0xab/0x260
> > > [   14.477817]  tcp_bpf_sendmsg_redir+0x297/0x500
> > > [   14.478461]  ? __local_bh_enable_ip+0x77/0xe0
> > > [   14.479096]  tcp_bpf_send_verdict+0x105/0x470
> > > [   14.479729]  tcp_bpf_sendmsg+0x318/0x4f0
> > > [   14.480311]  sock_sendmsg+0x2d/0x40
> > > [   14.480822]  ____sys_sendmsg+0x1b4/0x1c0
> > > [   14.481390]  ? copy_msghdr_from_user+0x62/0x80
> > > [   14.482048]  ___sys_sendmsg+0x78/0xb0
> > > [   14.482580]  ? vmf_insert_pfn_prot+0x91/0x150
> > > [   14.483215]  ? __do_fault+0x2a/0x1a0
> > > [   14.483738]  ? do_fault+0x15e/0x5d0
> > > [   14.484246]  ? __handle_mm_fault+0x56b/0x1040
> > > [   14.484874]  ? lock_is_held_type+0xdf/0x130
> > > [   14.485474]  ? find_held_lock+0x2d/0x90
> > > [   14.486046]  ? __sys_sendmsg+0x41/0x70
> > > [   14.486587]  __sys_sendmsg+0x41/0x70
> > > [   14.487105]  ? intel_pmu_drain_pebs_core+0x350/0x350
> > > [   14.487822]  do_syscall_64+0x34/0x80
> > > [   14.488345]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >
> > > The test scene as following flow:
> > > thread1                               thread2
> > > -----------                           ---------------
> > >  tcp_bpf_sendmsg
> > >   tcp_bpf_send_verdict
> > >    tcp_bpf_sendmsg_redir              sock_close
> > >     tcp_bpf_push_locked                 __sock_release
> > >      tcp_bpf_push                         //inet_release
> > >       do_tcp_sendpages                    sock->ops->release
> > >        sk_stream_wait_memory          	   // tcp_close
> > >           sk_wait_event                      sk->sk_prot->close
> > >            release_sock(__sk);
> > >             ***
> > >
> > >                                                 lock_sock(sk);
> > >                                                   __tcp_close
> > >                                                     sock_orphan(sk)
> > >                                                       sk->sk_wq  = NULL
> > >                                                 release_sock
> > >             ****
> > >            lock_sock(__sk);
> > >           remove_wait_queue(sk_sleep(sk), &wait);
> > >              sk_sleep(sk)
> > >              //NULL pointer dereference
> > >              &rcu_dereference_raw(sk->sk_wq)->wait
> > >
> > > While waiting for memory in thread1, the socket is released with its
> > > wait queue because thread2 has closed it. This caused by
> > > tcp_bpf_send_verdict didn't increase the f_count of psock->sk_redir-
> > >sk_socket->file in thread1.
> > >
> > > Avoid it by keeping a reference to the socket file while redirect sock
> > > wait send memory. Refer to [1].
> > >
> > > [1]
> > > https://lore.kernel.org/netdev/20190211090949.18560-1-jakub@cloudflare
> > > .com/
> > >
> > > Signed-off-by: Liu Jian <liujian56@huawei.com>
> > 
> > Thanks for the detailed commit message its necessary to understand the
> > problem without spending hours deciphering it myself.
> > 
> > When I looked at [1] we solved a simliar problem by using the
> > MSG_DONTWAIT flag so that the error was pushed back to the sending.
> > 
> > Can we do the same thing here? The nice bit here is the error would get all
> > the way back to the sending socket so userspace could decide how to handle
> > it? Did I miss something?
> > 
> [1] works in sk_psock_backlog function, it can not be detected by the userspace app.
> But here, the problem is that app wants this to be a blocked system call.
> If the MSG_DONTWAIT flag is forcibly added, this changes the function behavior.
> 

Ah right. We could push it to the sk_psock_backlog as another option similar
to what sk_psock_verdict_apply() does with sk_psock_skb_redirect(). The
problem would be we don't have an skb here and then instead of the
stream wait logic we would be using the backlog logic which might create
some subtle change. Seems a bit intrusive to me.

I don't have any better ideas off-hand even though reaching into the file
like above in the patch is not ideal.

Maybe Jakub has some thoughts?

Thanks!
John
