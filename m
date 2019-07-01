Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6485C475
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 22:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfGAUs1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 16:48:27 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37483 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfGAUs1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 16:48:27 -0400
Received: by mail-pf1-f201.google.com with SMTP id x18so9475268pfj.4
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=INF3BhAYxiC5zN7sI0E/1ejr1GqqfZAk7apZjO1QaBg=;
        b=v2SizwqEzo0HRILTfG8hKxn7HR13u+sEEwA0E2mO0W6/SZR7mMFwY+758HE5rxyQCY
         VD/dggiH60mX67ZVxSLvFNiWjPucZAhEm5O52i7Fn/4hCZUr4nZkv081l3/Ef7bExx5q
         bFV81flb81bsZczZgRa4WfJ3BdwAYoen4RpuxzY/BzOB5X3tb00X9PyutYI5Yr9HUrB8
         IlkOfc/k+60toNvVS7sCneoOhkFHHSSdwO9f60rekNvED0hAqNPCqFDg7EZ/7uI2bK6M
         Jx9OMyP31TVJEi96s55nTQTRWgSTD3X5MJuAXY2vqdeNfxXsg0XjqlS9icviBqZgfiyc
         326A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=INF3BhAYxiC5zN7sI0E/1ejr1GqqfZAk7apZjO1QaBg=;
        b=t8PwCQ32ewZNKEmZm05naotaON+HWzvlrual3w5USMU2gZKfxSqVKcQ/PU1T6P856t
         rpnlJcLLiT73+aZAtJeGfiX89NhubBmg8LcEQiOFAR5YrXH1zdIrVgUHoNUdmGoXvihm
         Ibqxef3FP2tSj2jdSrc+CadlHfzUNIZ9PdWX7XbwDTx5rithNppMoI44LjWxuZnFWgoQ
         aferJhk5+hU10tVJGTzAEpBrAPiyr4C6VTmjw9mmDmysNzrD5dwt2gMJhdecQTVyf2mY
         KZPa66vL+FvA1/lQyVaKoQ07LdlbhXzWxwGGAsPYkpTonH2S+XeY/n+zSGMgZin8UewT
         3l3g==
X-Gm-Message-State: APjAAAXX7QtnTi8aWT9/4ueStPx4011sRoJcUulLPBmhRI7agOxcqFu5
        A/MmXCIM+f05sVmIsn4mBUcVhFI=
X-Google-Smtp-Source: APXvYqzKhBy10PewYzuyN7H79WKX0/koGTFebHygP4NeE8AacXlN2HnrwjKNM0sSDjoyFhVV3C8IUEg=
X-Received: by 2002:a65:6541:: with SMTP id a1mr26318110pgw.409.1562014106370;
 Mon, 01 Jul 2019 13:48:26 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:48:14 -0700
In-Reply-To: <20190701204821.44230-1-sdf@google.com>
Message-Id: <20190701204821.44230-2-sdf@google.com>
Mime-Version: 1.0
References: <20190701204821.44230-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next 1/8] bpf: add BPF_CGROUP_SOCK_OPS callback that is
 executed on every RTT
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Performance impact should be minimal because it's under a new
BPF_SOCK_OPS_RTT_CB_FLAG flag that has to be explicitly enabled.

Suggested-by: Eric Dumazet <edumazet@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Priyaranjan Jha <priyarjha@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/tcp.h        | 8 ++++++++
 include/uapi/linux/bpf.h | 6 +++++-
 net/ipv4/tcp_input.c     | 4 ++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9d36cc88d043..e16d8a3fd3b4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2221,6 +2221,14 @@ static inline bool tcp_bpf_ca_needs_ecn(struct sock *sk)
 	return (tcp_call_bpf(sk, BPF_SOCK_OPS_NEEDS_ECN, 0, NULL) == 1);
 }
 
+static inline void tcp_bpf_rtt(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RTT_CB_FLAG))
+		tcp_call_bpf(sk, BPF_SOCK_OPS_RTT_CB, 0, NULL);
+}
+
 #if IS_ENABLED(CONFIG_SMC)
 extern struct static_key_false tcp_have_smc;
 #endif
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index cffea1826a1f..9cdd0aaeba06 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1770,6 +1770,7 @@ union bpf_attr {
  * 		* **BPF_SOCK_OPS_RTO_CB_FLAG** (retransmission time out)
  * 		* **BPF_SOCK_OPS_RETRANS_CB_FLAG** (retransmission)
  * 		* **BPF_SOCK_OPS_STATE_CB_FLAG** (TCP state change)
+ * 		* **BPF_SOCK_OPS_RTT_CB_FLAG** (every RTT)
  *
  * 		Therefore, this function can be used to clear a callback flag by
  * 		setting the appropriate bit to zero. e.g. to disable the RTO
@@ -3314,7 +3315,8 @@ struct bpf_sock_ops {
 #define BPF_SOCK_OPS_RTO_CB_FLAG	(1<<0)
 #define BPF_SOCK_OPS_RETRANS_CB_FLAG	(1<<1)
 #define BPF_SOCK_OPS_STATE_CB_FLAG	(1<<2)
-#define BPF_SOCK_OPS_ALL_CB_FLAGS       0x7		/* Mask of all currently
+#define BPF_SOCK_OPS_RTT_CB_FLAG	(1<<3)
+#define BPF_SOCK_OPS_ALL_CB_FLAGS       0xF		/* Mask of all currently
 							 * supported cb flags
 							 */
 
@@ -3369,6 +3371,8 @@ enum {
 	BPF_SOCK_OPS_TCP_LISTEN_CB,	/* Called on listen(2), right after
 					 * socket transition to LISTEN state.
 					 */
+	BPF_SOCK_OPS_RTT_CB,		/* Called on every RTT.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index b71efeb0ae5b..c21e8a22fb3b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -778,6 +778,8 @@ static void tcp_rtt_estimator(struct sock *sk, long mrtt_us)
 				tp->rttvar_us -= (tp->rttvar_us - tp->mdev_max_us) >> 2;
 			tp->rtt_seq = tp->snd_nxt;
 			tp->mdev_max_us = tcp_rto_min_us(sk);
+
+			tcp_bpf_rtt(sk);
 		}
 	} else {
 		/* no previous measure. */
@@ -786,6 +788,8 @@ static void tcp_rtt_estimator(struct sock *sk, long mrtt_us)
 		tp->rttvar_us = max(tp->mdev_us, tcp_rto_min_us(sk));
 		tp->mdev_max_us = tp->rttvar_us;
 		tp->rtt_seq = tp->snd_nxt;
+
+		tcp_bpf_rtt(sk);
 	}
 	tp->srtt_us = max(1U, srtt);
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

