Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39F85927C8
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 04:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiHOCai (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Aug 2022 22:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiHOCag (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Aug 2022 22:30:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC655599
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 19:30:35 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M5dVw5fgSzmVX4;
        Mon, 15 Aug 2022 10:28:24 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 15 Aug
 2022 10:30:31 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
        <edumazet@google.com>, <davem@davemloft.net>,
        <yoshfuji@linux-ipv6.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <andrii@kernel.org>, <mykolal@fb.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
        <song@kernel.org>, <yhs@fb.com>, <kpsingh@kernel.org>,
        <sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
        <shuah@kernel.org>, <bpf@vger.kernel.org>
CC:     <liujian56@huawei.com>
Subject: [PATCH bpf-next 1/2] sk_msg: Keep reference on socket file while wait_memory
Date:   Mon, 15 Aug 2022 10:33:42 +0800
Message-ID: <20220815023343.295094-2-liujian56@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220815023343.295094-1-liujian56@huawei.com>
References: <20220815023343.295094-1-liujian56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the below NULL pointer dereference:

[   14.471200] Call Trace:
[   14.471562]  <TASK>
[   14.471882]  lock_acquire+0x245/0x2e0
[   14.472416]  ? remove_wait_queue+0x12/0x50
[   14.473014]  ? _raw_spin_lock_irqsave+0x17/0x50
[   14.473681]  _raw_spin_lock_irqsave+0x3d/0x50
[   14.474318]  ? remove_wait_queue+0x12/0x50
[   14.474907]  remove_wait_queue+0x12/0x50
[   14.475480]  sk_stream_wait_memory+0x20d/0x340
[   14.476127]  ? do_wait_intr_irq+0x80/0x80
[   14.476704]  do_tcp_sendpages+0x287/0x600
[   14.477283]  tcp_bpf_push+0xab/0x260
[   14.477817]  tcp_bpf_sendmsg_redir+0x297/0x500
[   14.478461]  ? __local_bh_enable_ip+0x77/0xe0
[   14.479096]  tcp_bpf_send_verdict+0x105/0x470
[   14.479729]  tcp_bpf_sendmsg+0x318/0x4f0
[   14.480311]  sock_sendmsg+0x2d/0x40
[   14.480822]  ____sys_sendmsg+0x1b4/0x1c0
[   14.481390]  ? copy_msghdr_from_user+0x62/0x80
[   14.482048]  ___sys_sendmsg+0x78/0xb0
[   14.482580]  ? vmf_insert_pfn_prot+0x91/0x150
[   14.483215]  ? __do_fault+0x2a/0x1a0
[   14.483738]  ? do_fault+0x15e/0x5d0
[   14.484246]  ? __handle_mm_fault+0x56b/0x1040
[   14.484874]  ? lock_is_held_type+0xdf/0x130
[   14.485474]  ? find_held_lock+0x2d/0x90
[   14.486046]  ? __sys_sendmsg+0x41/0x70
[   14.486587]  __sys_sendmsg+0x41/0x70
[   14.487105]  ? intel_pmu_drain_pebs_core+0x350/0x350
[   14.487822]  do_syscall_64+0x34/0x80
[   14.488345]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

The test scene as following flow:
thread1                               thread2
-----------                           ---------------
 tcp_bpf_sendmsg
  tcp_bpf_send_verdict
   tcp_bpf_sendmsg_redir              sock_close
    tcp_bpf_push_locked                 __sock_release
     tcp_bpf_push                         //inet_release
      do_tcp_sendpages                    sock->ops->release
       sk_stream_wait_memory          	   // tcp_close
          sk_wait_event                      sk->sk_prot->close
           release_sock(__sk);
            ***

                                                lock_sock(sk);
                                                  __tcp_close
                                                    sock_orphan(sk)
                                                      sk->sk_wq  = NULL
                                                release_sock
            ****
           lock_sock(__sk);
          remove_wait_queue(sk_sleep(sk), &wait);
             sk_sleep(sk)
             //NULL pointer dereference
             &rcu_dereference_raw(sk->sk_wq)->wait

While waiting for memory in thread1, the socket is released with its wait
queue because thread2 has closed it. This caused by tcp_bpf_send_verdict
didn't increase the f_count of psock->sk_redir->sk_socket->file in thread1.

Avoid it by keeping a reference to the socket file while redirect sock wait
send memory. Refer to [1].

[1] https://lore.kernel.org/netdev/20190211090949.18560-1-jakub@cloudflare.com/

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 net/ipv4/tcp_bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index a1626afe87a1..201375829367 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -125,9 +125,17 @@ static int tcp_bpf_push_locked(struct sock *sk, struct sk_msg *msg,
 {
 	int ret;
 
+	/* Hold on to socket wait queue. */
+	if (sk->sk_socket && sk->sk_socket->file)
+		get_file(sk->sk_socket->file);
+
 	lock_sock(sk);
 	ret = tcp_bpf_push(sk, msg, apply_bytes, flags, uncharge);
 	release_sock(sk);
+
+	if (sk->sk_socket && sk->sk_socket->file)
+		fput(sk->sk_socket->file);
+
 	return ret;
 }
 
-- 
2.17.1

