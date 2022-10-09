Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410205F90E6
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 00:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiJIW2U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Oct 2022 18:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiJIW0Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Oct 2022 18:26:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78EB31228;
        Sun,  9 Oct 2022 15:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9387B60CF8;
        Sun,  9 Oct 2022 22:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E89C433C1;
        Sun,  9 Oct 2022 22:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665353915;
        bh=FHmskZLC3rOyEZgjdwW+ifoYQUgvUC1l+yZwcFFvZY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IeCekFVIMNcIQARXYlGVIRt75q5vXjsWGrgUjOs5SeJ+VknJcc/L+bTWRIffy+r0N
         rsAvSWIzKBEml39uHCdsqiUx4adKJ8hemLU1GrDfjUuLRLyfuypgQW8ECBJdqITEx6
         PFKly1imkCxc4cGSiLpMWw/76FdQJ5Vj3vE8xHCzSt4+EB15kKmQrjmXKgUunZGvrO
         LMitObsE8S2vvO0sU2T0lqLFzgGwsUgLQOhYePICU33EsXaumUyf7b6Vd401qOxfci
         /m0q+je7fy7ArM+fEGKMXSbz0DC/46xKNLB+GICAWIms9yV7iKIJyhKLl9d98vc0qi
         qCpRecNfzb4nw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liu Jian <liujian56@huawei.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 64/73] net: If sock is dead don't access sock's sk_wq in sk_stream_wait_memory
Date:   Sun,  9 Oct 2022 18:14:42 -0400
Message-Id: <20221009221453.1216158-64-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221009221453.1216158-1-sashal@kernel.org>
References: <20221009221453.1216158-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Liu Jian <liujian56@huawei.com>

[ Upstream commit 3f8ef65af927db247418d4e1db49164d7a158fc5 ]

Fixes the below NULL pointer dereference:

  [...]
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
  [...]

The test scenario has the following flow:

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

We should check if SOCK_DEAD flag is set on wakeup in sk_stream_wait_memory
before accessing the wait queue.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Liu Jian <liujian56@huawei.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/bpf/20220823133755.314697-2-liujian56@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/stream.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/stream.c b/net/core/stream.c
index 06b36c730ce8..2ee82115b919 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -159,7 +159,8 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 		*timeo_p = current_timeo;
 	}
 out:
-	remove_wait_queue(sk_sleep(sk), &wait);
+	if (!sock_flag(sk, SOCK_DEAD))
+		remove_wait_queue(sk_sleep(sk), &wait);
 	return err;
 
 do_error:
-- 
2.35.1

