Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F32B2B0418
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 12:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgKLLmZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 06:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgKLLlV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 06:41:21 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE67EC061A47;
        Thu, 12 Nov 2020 03:41:19 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d3so2646697plo.4;
        Thu, 12 Nov 2020 03:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JDjKkrZHW9cU8J1KikSg6JLqEf+0NjFDlMbUYIB+L5o=;
        b=HbpPcrhd2OEAq7SOOJZRGsxXdCDLPcxaQA0+9HrMiMoeiYCw+90F9spQa+RVlMDowU
         8BaBfYWmMgGRYtowfMaV4vTpW2emZV74vnQGuafu9+cvdcTUrNHPUUqirjpexeYrwiU1
         t8GfEhr1W1h8xdTnRAyKfab6Wf/NpOXCKAqf3qFyi94gAhYTdqvsD3uZNlwD3mrcvkm+
         DPJu2A1Y/C6Trjk+iVhj3POizt3ekUVviIeI9sKyGYBQi8adp1gkEQxB1gliLd6b3UiS
         iDly7amfl/83g2+0F7tcgP1CHDdfzF4Fz8T2Ze2RmyrXtF9rp6ZJKNq7IqwxJfSzxqW+
         zN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDjKkrZHW9cU8J1KikSg6JLqEf+0NjFDlMbUYIB+L5o=;
        b=CIlOLtSVb13M9vIByCq2vJUau4qreHWRpDkN4p5lN1NFaDC9Nk1USmS46gpIKuWo9v
         K79fVhhAk1BLLfYMLYwN86aXZKmNhQH06TAFRHzZIgt3Vzb+7IP+HkGrYbRUDlYDEDYt
         1I8wCGiJD72AWkM0IdxefpCMwR3nbRC8weMxnesBb3LMG9oG/nBHsjV7o7NLFVw+pajz
         u9mjUiclk1cYzW27JThlhcVOmHRoyv5i5r5ySpeO27RAq/QxJa+MgKYDztHJE+1op6yY
         nOluSBsoacTeuDvLPJIKzU0kTJz9TC2XKU53oEHZK10oC1402J8xPTxNiqJyJih+9LMU
         t0LQ==
X-Gm-Message-State: AOAM530AjGM9CnZMqqFUYuhYRtFRKqANCBAObXoy6yMsHZi72l067u1D
        6RIOXOjN5Ff51SgfBXJwbsB+2Nnfly3wPg==
X-Google-Smtp-Source: ABdhPJzgvqn5ANrc3JjxDK6umU5CA8tYwuYdtiKbkqXbZiKH9MhvfV91bYP44t/QA+lXFVBH3D0o5Q==
X-Received: by 2002:a17:902:7e88:b029:d6:74c4:7a82 with SMTP id z8-20020a1709027e88b02900d674c47a82mr24110390pla.64.1605181278704;
        Thu, 12 Nov 2020 03:41:18 -0800 (PST)
Received: from btopel-mobl.ger.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id y8sm6161629pfe.33.2020.11.12.03.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 03:41:17 -0800 (PST)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
        maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
        jesse.brandeburg@intel.com, qi.z.zhang@intel.com, kuba@kernel.org,
        edumazet@google.com, jonathan.lemon@gmail.com, maximmi@nvidia.com
Subject: [PATCH bpf-next 2/9] net: add SO_BUSY_POLL_BUDGET socket option
Date:   Thu, 12 Nov 2020 12:40:34 +0100
Message-Id: <20201112114041.131998-3-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201112114041.131998-1-bjorn.topel@gmail.com>
References: <20201112114041.131998-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

This option lets a user set a per socket NAPI budget for
busy-polling. If the options is not set, it will use the default of 8.

Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 arch/alpha/include/uapi/asm/socket.h  |  1 +
 arch/mips/include/uapi/asm/socket.h   |  1 +
 arch/parisc/include/uapi/asm/socket.h |  1 +
 arch/sparc/include/uapi/asm/socket.h  |  1 +
 fs/eventpoll.c                        |  3 ++-
 include/net/busy_poll.h               |  7 +++++--
 include/net/sock.h                    |  1 +
 include/uapi/asm-generic/socket.h     |  1 +
 net/core/dev.c                        | 21 ++++++++++-----------
 net/core/sock.c                       | 10 ++++++++++
 10 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 538359642554..57420356ce4c 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -125,6 +125,7 @@
 #define SO_DETACH_REUSEPORT_BPF 68
 
 #define SO_PREFER_BUSY_POLL	69
+#define SO_BUSY_POLL_BUDGET	70
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index e406e73b5e6e..2d949969313b 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -136,6 +136,7 @@
 #define SO_DETACH_REUSEPORT_BPF 68
 
 #define SO_PREFER_BUSY_POLL	69
+#define SO_BUSY_POLL_BUDGET	70
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 1bc46200889d..f60904329bbc 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -117,6 +117,7 @@
 #define SO_DETACH_REUSEPORT_BPF 0x4042
 
 #define SO_PREFER_BUSY_POLL	0x4043
+#define SO_BUSY_POLL_BUDGET	0x4044
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 99688cf673a4..848a22fbac20 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -118,6 +118,7 @@
 #define SO_DETACH_REUSEPORT_BPF  0x0047
 
 #define SO_PREFER_BUSY_POLL	 0x0048
+#define SO_BUSY_POLL_BUDGET	 0x0049
 
 #if !defined(__KERNEL__)
 
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e11fab3a0b9e..73c346e503d7 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -397,7 +397,8 @@ static void ep_busy_loop(struct eventpoll *ep, int nonblock)
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
 
 	if ((napi_id >= MIN_NAPI_ID) && net_busy_loop_on())
-		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false);
+		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
+			       BUSY_POLL_BUDGET);
 }
 
 static inline void ep_reset_busy_poll_napi_id(struct eventpoll *ep)
diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index 0292b8353d7e..b4f653cc15a7 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -23,6 +23,8 @@
  */
 #define MIN_NAPI_ID ((unsigned int)(NR_CPUS + 1))
 
+#define BUSY_POLL_BUDGET 8
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
 
 struct napi_struct;
@@ -43,7 +45,7 @@ bool sk_busy_loop_end(void *p, unsigned long start_time);
 
 void napi_busy_loop(unsigned int napi_id,
 		    bool (*loop_end)(void *, unsigned long),
-		    void *loop_end_arg, bool prefer_busy_poll);
+		    void *loop_end_arg, bool prefer_busy_poll, u16 budget);
 
 #else /* CONFIG_NET_RX_BUSY_POLL */
 static inline unsigned long net_busy_loop_on(void)
@@ -106,7 +108,8 @@ static inline void sk_busy_loop(struct sock *sk, int nonblock)
 
 	if (napi_id >= MIN_NAPI_ID)
 		napi_busy_loop(napi_id, nonblock ? NULL : sk_busy_loop_end, sk,
-			       READ_ONCE(sk->sk_prefer_busy_poll));
+			       READ_ONCE(sk->sk_prefer_busy_poll),
+			       sk->sk_busy_poll_budget ?: BUSY_POLL_BUDGET);
 #endif
 }
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 716960a15e83..1ddfb4a2dac2 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -481,6 +481,7 @@ struct sock {
 	kuid_t			sk_uid;
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	u8			sk_prefer_busy_poll;
+	u16			sk_busy_poll_budget;
 #endif
 	struct pid		*sk_peer_pid;
 	const struct cred	*sk_peer_cred;
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 7dd02408b7ce..4dcd13d097a9 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -120,6 +120,7 @@
 #define SO_DETACH_REUSEPORT_BPF 68
 
 #define SO_PREFER_BUSY_POLL	69
+#define SO_BUSY_POLL_BUDGET	70
 
 #if !defined(__KERNEL__)
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 49015b059549..33c67004f2ad 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6492,8 +6492,6 @@ static struct napi_struct *napi_by_id(unsigned int napi_id)
 
 #if defined(CONFIG_NET_RX_BUSY_POLL)
 
-#define BUSY_POLL_BUDGET 8
-
 static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
 {
 	if (!skip_schedule) {
@@ -6513,7 +6511,8 @@ static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
 	clear_bit(NAPI_STATE_SCHED, &napi->state);
 }
 
-static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock, bool prefer_busy_poll)
+static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock, bool prefer_busy_poll,
+			   u16 budget)
 {
 	bool skip_schedule = false;
 	unsigned long timeout;
@@ -6545,21 +6544,21 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock, bool
 	/* All we really want here is to re-enable device interrupts.
 	 * Ideally, a new ndo_busy_poll_stop() could avoid another round.
 	 */
-	rc = napi->poll(napi, BUSY_POLL_BUDGET);
+	rc = napi->poll(napi, budget);
 	/* We can't gro_normal_list() here, because napi->poll() might have
 	 * rearmed the napi (napi_complete_done()) in which case it could
 	 * already be running on another CPU.
 	 */
-	trace_napi_poll(napi, rc, BUSY_POLL_BUDGET);
+	trace_napi_poll(napi, rc, budget);
 	netpoll_poll_unlock(have_poll_lock);
-	if (rc == BUSY_POLL_BUDGET)
+	if (rc == budget)
 		__busy_poll_stop(napi, skip_schedule);
 	local_bh_enable();
 }
 
 void napi_busy_loop(unsigned int napi_id,
 		    bool (*loop_end)(void *, unsigned long),
-		    void *loop_end_arg, bool prefer_busy_poll)
+		    void *loop_end_arg, bool prefer_busy_poll, u16 budget)
 {
 	unsigned long start_time = loop_end ? busy_loop_current_time() : 0;
 	int (*napi_poll)(struct napi_struct *napi, int budget);
@@ -6602,8 +6601,8 @@ void napi_busy_loop(unsigned int napi_id,
 			have_poll_lock = netpoll_poll_lock(napi);
 			napi_poll = napi->poll;
 		}
-		work = napi_poll(napi, BUSY_POLL_BUDGET);
-		trace_napi_poll(napi, work, BUSY_POLL_BUDGET);
+		work = napi_poll(napi, budget);
+		trace_napi_poll(napi, work, budget);
 		gro_normal_list(napi);
 count:
 		if (work > 0)
@@ -6616,7 +6615,7 @@ void napi_busy_loop(unsigned int napi_id,
 
 		if (unlikely(need_resched())) {
 			if (napi_poll)
-				busy_poll_stop(napi, have_poll_lock, prefer_busy_poll);
+				busy_poll_stop(napi, have_poll_lock, prefer_busy_poll, budget);
 			preempt_enable();
 			rcu_read_unlock();
 			cond_resched();
@@ -6627,7 +6626,7 @@ void napi_busy_loop(unsigned int napi_id,
 		cpu_relax();
 	}
 	if (napi_poll)
-		busy_poll_stop(napi, have_poll_lock, prefer_busy_poll);
+		busy_poll_stop(napi, have_poll_lock, prefer_busy_poll, budget);
 	preempt_enable();
 out:
 	rcu_read_unlock();
diff --git a/net/core/sock.c b/net/core/sock.c
index 248f6a763661..e08d5a6ae9d4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1165,6 +1165,16 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		else
 			sk->sk_prefer_busy_poll = valbool;
 		break;
+	case SO_BUSY_POLL_BUDGET:
+		if (val > sk->sk_busy_poll_budget && !capable(CAP_NET_ADMIN)) {
+			ret = -EPERM;
+		} else {
+			if (val < 0)
+				ret = -EINVAL;
+			else
+				sk->sk_busy_poll_budget = val;
+		}
+		break;
 #endif
 
 	case SO_MAX_PACING_RATE:
-- 
2.27.0

