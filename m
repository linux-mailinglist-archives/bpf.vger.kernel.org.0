Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D12E6D0947
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjC3PTl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 11:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjC3PTl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 11:19:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA858D321
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 08:18:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id le6so18359042plb.12
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680189495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfYJYnl0Heey6FS2EwHdEmVSHYV5GV5CMBukfM7CZco=;
        b=G1uq2MRc9yjupxXARmLcuBek5Hg2bm4sXA0E2d8Ii3tF9LADjKu93mvPVID/9BXgqw
         B2GDNgHcS4zV6k0HEM+iNJzWibohdAzaUeE6xy8d+jwvSp6CFxJqxfkp+eMcSjyoQDOS
         cjBN4DXu53/wvvYsoScxpCc/S+KAn9cy8QgCJYWp7dDA3zmebHbx9Yz1GvJUt+KL8H11
         fsUaWSiECWn1aQpeT0Ea79OjT4pMqlkd4B07FhTJbuwEz3R+v4EVuzxdhCUChGR5Dquy
         XBdFTvbfAR4rFXUFDr/18wDnznvTKa2afjQXSQwTV2n1surFLNRE/HvZN+ou3vDAVXdT
         dp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfYJYnl0Heey6FS2EwHdEmVSHYV5GV5CMBukfM7CZco=;
        b=6WLb+axM/9u8Aa2ZVzes6BWzMdEpRH/wpNnYLh4GeZ+sjM7WBCYb17Z3y5H/Bnf5kM
         +8kq+i7WYM/IAvsyRBv8hnU6US0z58HhokX1Apwt3XrxH38Ksgf7D8JEi8aQC3t/0n/g
         rUUM9y8CNxuRBPeNqQzg1J+9BX7A/e+wtCxEGKIOh3kATf8UhJRipPD31m/mSXA8h2y1
         5dNSXVudGtM7y5+c1LfLaWuLk8H7l76bN2vg31NXzPVTwECyYT1OLyj4j0a/+ITtWZ/2
         TCgVQ+eVY2jCzku+MDVXXVoGJ/nw5lgoO/k54gfyklcSfqWgKUkqWSiolOX6PYZDIg49
         gHuA==
X-Gm-Message-State: AAQBX9f6ED7vQujo7ST6V2TuClEW9w3rq8GYseI9GazEa97Thf2eAv/c
        uCDY7/AwtacPhm5LhXFOBUjoELbaAH0yVECqt58=
X-Google-Smtp-Source: AKy350bnmzaGnqWjigYq8IFee8gaikToSb1uWywU73iuZEay7jMQPAI5fRto5XMHCI1iyymV2GJgqg==
X-Received: by 2002:a17:903:410c:b0:1a1:f0ce:bb8f with SMTP id r12-20020a170903410c00b001a1f0cebb8fmr18495480pld.65.1680189495257;
        Thu, 30 Mar 2023 08:18:15 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id f17-20020a63de11000000b004fc1d91e695sm23401177pgg.79.2023.03.30.08.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:18:14 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v5 bpf-next 1/7] bpf: tcp: Avoid taking fast sock lock in iterator
Date:   Thu, 30 Mar 2023 15:17:52 +0000
Message-Id: <20230330151758.531170-2-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330151758.531170-1-aditi.ghag@isovalent.com>
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously, BPF TCP iterator was acquiring fast version of sock lock that
disables the BH. This introduced a circular dependency with code paths that
later acquire sockets hash table bucket lock.
Replace the fast version of sock lock with slow that faciliates BPF
programs executed from the iterator to destroy TCP listening sockets
using the bpf_sock_destroy kfunc (implemened in follow-up commits).

Here is a stack trace that motivated this change:

```
1) sock_lock with BH disabled + bucket lock

lock_acquire+0xcd/0x330
_raw_spin_lock_bh+0x38/0x50
inet_unhash+0x96/0xd0
tcp_set_state+0x6a/0x210
tcp_abort+0x12b/0x230
bpf_prog_f4110fb1100e26b5_iter_tcp6_server+0xa3/0xaa
bpf_iter_run_prog+0x1ff/0x340
bpf_iter_tcp_seq_show+0xca/0x190
bpf_seq_read+0x177/0x450
vfs_read+0xc6/0x300
ksys_read+0x69/0xf0
do_syscall_64+0x3c/0x90
entry_SYSCALL_64_after_hwframe+0x72/0xdc

2) sock lock with BH enable

[    1.499968]   lock_acquire+0xcd/0x330
[    1.500316]   _raw_spin_lock+0x33/0x40
[    1.500670]   sk_clone_lock+0x146/0x520
[    1.501030]   inet_csk_clone_lock+0x1b/0x110
[    1.501433]   tcp_create_openreq_child+0x22/0x3f0
[    1.501873]   tcp_v6_syn_recv_sock+0x96/0x940
[    1.502284]   tcp_check_req+0x137/0x660
[    1.502646]   tcp_v6_rcv+0xa63/0xe80
[    1.502994]   ip6_protocol_deliver_rcu+0x78/0x590
[    1.503434]   ip6_input_finish+0x72/0x140
[    1.503818]   __netif_receive_skb_one_core+0x63/0xa0
[    1.504281]   process_backlog+0x79/0x260
[    1.504668]   __napi_poll.constprop.0+0x27/0x170
[    1.505104]   net_rx_action+0x14a/0x2a0
[    1.505469]   __do_softirq+0x165/0x510
[    1.505842]   do_softirq+0xcd/0x100
[    1.506172]   __local_bh_enable_ip+0xcc/0xf0
[    1.506588]   ip6_finish_output2+0x2a8/0xb00
[    1.506988]   ip6_finish_output+0x274/0x510
[    1.507377]   ip6_xmit+0x319/0x9b0
[    1.507726]   inet6_csk_xmit+0x12b/0x2b0
[    1.508096]   __tcp_transmit_skb+0x549/0xc40
[    1.508498]   tcp_rcv_state_process+0x362/0x1180

```

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 net/ipv4/tcp_ipv4.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ea370afa70ed..f2d370a9450f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2962,7 +2962,6 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 	struct sock *sk = v;
-	bool slow;
 	uid_t uid;
 	int ret;
 
@@ -2970,7 +2969,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 		return 0;
 
 	if (sk_fullsock(sk))
-		slow = lock_sock_fast(sk);
+		lock_sock(sk);
 
 	if (unlikely(sk_unhashed(sk))) {
 		ret = SEQ_SKIP;
@@ -2994,7 +2993,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
 
 unlock:
 	if (sk_fullsock(sk))
-		unlock_sock_fast(sk, slow);
+		release_sock(sk);
 	return ret;
 
 }
-- 
2.34.1

