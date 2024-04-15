Return-Path: <bpf+bounces-26812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661A68A5182
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 15:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B6CB21396
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 13:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AB912FF7C;
	Mon, 15 Apr 2024 13:22:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D48F768EE;
	Mon, 15 Apr 2024 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187352; cv=none; b=m7MQFbJ5SwNWBLBb4bLPlJjHrXtgg7bcly7TNuRXJxiAvg+dVHrOmP4YK5gqooveFYYnLfQwcyrYESuTgqzrRtK7LP5cBGIP0dEOmJKIUPc21Sh56vWHaUaR4g75664e8UmIJYkE9/uGNdHy8EiMWhIktfl1W+Nt5GGpo4Wt9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187352; c=relaxed/simple;
	bh=wqfRzqFFXAXF04LuSe96hAIVpW/EW+/Fh2CLbhRZR/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAerZbB9Awk39w1uC8gVoCoBfzHYG2NcljcPVENP+9pWoID5moYKF1fekPZGTVEnveRO9qF9EhvTjNP8WFZItr+RUHsPS/LjwOEssEbq+F0iB/nnqeRpp6CvfIj8VGDCek566o11bszYfB83X72ny4G8fbP2UMRp9vfiwRu6o6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VJ7753CR7z1hwfC;
	Mon, 15 Apr 2024 21:19:29 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A37E21A016C;
	Mon, 15 Apr 2024 21:22:25 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 21:22:25 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Ayush Sawal <ayush.sawal@chelsio.com>, Eric Dumazet
	<edumazet@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de
 Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, John
 Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>,
	David Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Boris
 Pismenny <borisp@nvidia.com>, <bpf@vger.kernel.org>, <mptcp@lists.linux.dev>
Subject: [PATCH net-next v2 13/15] net: replace page_frag with page_frag_cache
Date: Mon, 15 Apr 2024 21:19:38 +0800
Message-ID: <20240415131941.51153-14-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240415131941.51153-1-linyunsheng@huawei.com>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

Use the newly introduced prepare/commit API to replace
page_frag with page_frag_cache for sk_page_frag().

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 .../chelsio/inline_crypto/chtls/chtls.h       |   3 -
 .../chelsio/inline_crypto/chtls/chtls_io.c    | 101 ++++---------
 .../chelsio/inline_crypto/chtls/chtls_main.c  |   3 -
 drivers/net/tun.c                             |  34 ++---
 include/linux/sched.h                         |   4 +-
 include/net/sock.h                            |  14 +-
 kernel/exit.c                                 |   3 +-
 kernel/fork.c                                 |   2 +-
 net/core/skbuff.c                             |  32 ++--
 net/core/skmsg.c                              |  22 +--
 net/core/sock.c                               |  46 ++++--
 net/ipv4/ip_output.c                          |  35 +++--
 net/ipv4/tcp.c                                |  35 ++---
 net/ipv4/tcp_output.c                         |  28 ++--
 net/ipv6/ip6_output.c                         |  35 +++--
 net/kcm/kcmsock.c                             |  30 ++--
 net/mptcp/protocol.c                          |  74 ++++++----
 net/tls/tls_device.c                          | 139 ++++++++++--------
 18 files changed, 342 insertions(+), 298 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
index 7ff82b6778ba..fe2b6a8ef718 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
@@ -234,7 +234,6 @@ struct chtls_dev {
 	struct list_head list_node;
 	struct list_head rcu_node;
 	struct list_head na_node;
-	unsigned int send_page_order;
 	int max_host_sndbuf;
 	u32 round_robin_cnt;
 	struct key_map kmap;
@@ -453,8 +452,6 @@ enum {
 
 /* The ULP mode/submode of an skbuff */
 #define skb_ulp_mode(skb)  (ULP_SKB_CB(skb)->ulp_mode)
-#define TCP_PAGE(sk)   (sk->sk_frag.page)
-#define TCP_OFF(sk)    (sk->sk_frag.offset)
 
 static inline struct chtls_dev *to_chtls_dev(struct tls_toe_device *tlsdev)
 {
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
index d567e42e1760..8f2dfbe9d3a4 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
@@ -825,12 +825,6 @@ void skb_entail(struct sock *sk, struct sk_buff *skb, int flags)
 	ULP_SKB_CB(skb)->flags = flags;
 	__skb_queue_tail(&csk->txq, skb);
 	sk->sk_wmem_queued += skb->truesize;
-
-	if (TCP_PAGE(sk) && TCP_OFF(sk)) {
-		put_page(TCP_PAGE(sk));
-		TCP_PAGE(sk) = NULL;
-		TCP_OFF(sk) = 0;
-	}
 }
 
 static struct sk_buff *get_tx_skb(struct sock *sk, int size)
@@ -882,16 +876,12 @@ static void push_frames_if_head(struct sock *sk)
 		chtls_push_frames(csk, 1);
 }
 
-static int chtls_skb_copy_to_page_nocache(struct sock *sk,
-					  struct iov_iter *from,
-					  struct sk_buff *skb,
-					  struct page *page,
-					  int off, int copy)
+static int chtls_skb_copy_to_va_nocache(struct sock *sk, struct iov_iter *from,
+					struct sk_buff *skb, char *va, int copy)
 {
 	int err;
 
-	err = skb_do_copy_data_nocache(sk, skb, from, page_address(page) +
-				       off, copy, skb->len);
+	err = skb_do_copy_data_nocache(sk, skb, from, va, copy, skb->len);
 	if (err)
 		return err;
 
@@ -1114,82 +1104,45 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			if (err)
 				goto do_fault;
 		} else {
+			struct page_frag_cache *pfrag = &sk->sk_frag;
 			int i = skb_shinfo(skb)->nr_frags;
-			struct page *page = TCP_PAGE(sk);
-			int pg_size = PAGE_SIZE;
-			int off = TCP_OFF(sk);
-			bool merge;
-
-			if (page)
-				pg_size = page_size(page);
-			if (off < pg_size &&
-			    skb_can_coalesce(skb, i, page, off)) {
+			unsigned int offset, size;
+			bool merge = false;
+			struct page *page;
+			void *va;
+
+			size = 32U;
+			page = page_frag_alloc_prepare(pfrag, &offset, &size,
+						       &va, sk->sk_allocation);
+			if (unlikely(!page))
+				goto wait_for_memory;
+
+			if (skb_can_coalesce(skb, i, page, offset))
 				merge = true;
-				goto copy;
-			}
-			merge = false;
-			if (i == (is_tls_tx(csk) ? (MAX_SKB_FRAGS - 1) :
-			    MAX_SKB_FRAGS))
+			else if (i == (is_tls_tx(csk) ? (MAX_SKB_FRAGS - 1) :
+				       MAX_SKB_FRAGS))
 				goto new_buf;
 
-			if (page && off == pg_size) {
-				put_page(page);
-				TCP_PAGE(sk) = page = NULL;
-				pg_size = PAGE_SIZE;
-			}
-
-			if (!page) {
-				gfp_t gfp = sk->sk_allocation;
-				int order = cdev->send_page_order;
-
-				if (order) {
-					page = alloc_pages(gfp | __GFP_COMP |
-							   __GFP_NOWARN |
-							   __GFP_NORETRY,
-							   order);
-					if (page)
-						pg_size <<= order;
-				}
-				if (!page) {
-					page = alloc_page(gfp);
-					pg_size = PAGE_SIZE;
-				}
-				if (!page)
-					goto wait_for_memory;
-				off = 0;
-			}
-copy:
-			if (copy > pg_size - off)
-				copy = pg_size - off;
+			copy = min_t(int, copy, size);
 			if (is_tls_tx(csk))
 				copy = min_t(int, copy, csk->tlshws.txleft);
 
-			err = chtls_skb_copy_to_page_nocache(sk, &msg->msg_iter,
-							     skb, page,
-							     off, copy);
-			if (unlikely(err)) {
-				if (!TCP_PAGE(sk)) {
-					TCP_PAGE(sk) = page;
-					TCP_OFF(sk) = 0;
-				}
+			err = chtls_skb_copy_to_va_nocache(sk, &msg->msg_iter,
+							   skb, va, copy);
+			if (unlikely(err))
 				goto do_fault;
-			}
+
 			/* Update the skb. */
 			if (merge) {
 				skb_frag_size_add(
 						&skb_shinfo(skb)->frags[i - 1],
 						copy);
+				page_frag_alloc_commit_noref(pfrag, offset,
+							     copy);
 			} else {
-				skb_fill_page_desc(skb, i, page, off, copy);
-				if (off + copy < pg_size) {
-					/* space left keep page */
-					get_page(page);
-					TCP_PAGE(sk) = page;
-				} else {
-					TCP_PAGE(sk) = NULL;
-				}
+				skb_fill_page_desc(skb, i, page, offset, copy);
+				page_frag_alloc_commit(pfrag, offset, copy);
 			}
-			TCP_OFF(sk) = off + copy;
 		}
 		if (unlikely(skb->len == mss))
 			tx_skb_finalize(skb);
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
index 455a54708be4..ba88b2fc7cd8 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
@@ -34,7 +34,6 @@ static DEFINE_MUTEX(notify_mutex);
 static RAW_NOTIFIER_HEAD(listen_notify_list);
 static struct proto chtls_cpl_prot, chtls_cpl_protv6;
 struct request_sock_ops chtls_rsk_ops, chtls_rsk_opsv6;
-static uint send_page_order = (14 - PAGE_SHIFT < 0) ? 0 : 14 - PAGE_SHIFT;
 
 static void register_listen_notifier(struct notifier_block *nb)
 {
@@ -273,8 +272,6 @@ static void *chtls_uld_add(const struct cxgb4_lld_info *info)
 	INIT_WORK(&cdev->deferq_task, process_deferq);
 	spin_lock_init(&cdev->listen_lock);
 	spin_lock_init(&cdev->idr_lock);
-	cdev->send_page_order = min_t(uint, get_order(32768),
-				      send_page_order);
 	cdev->max_host_sndbuf = 48 * 1024;
 
 	if (lldi->vr->key.size)
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 0b3f21cba552..5939dfacb6e2 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1598,7 +1598,8 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 }
 
 static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
-				       struct page_frag *alloc_frag, char *buf,
+				       struct page_frag_cache *alloc_frag,
+				       char *buf, unsigned int offset,
 				       int buflen, int len, int pad)
 {
 	struct sk_buff *skb = build_skb(buf, buflen);
@@ -1609,9 +1610,7 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
 	skb_reserve(skb, pad);
 	skb_put(skb, len);
 	skb_set_owner_w(skb, tfile->socket.sk);
-
-	get_page(alloc_frag->page);
-	alloc_frag->offset += buflen;
+	page_frag_alloc_commit(alloc_frag, offset, buflen);
 
 	return skb;
 }
@@ -1660,9 +1659,10 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     struct virtio_net_hdr *hdr,
 				     int len, int *skb_xdp)
 {
-	struct page_frag *alloc_frag = &current->task_frag;
+	struct page_frag_cache *alloc_frag = &current->task_frag;
 	struct bpf_prog *xdp_prog;
 	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	unsigned int offset, size;
 	char *buf;
 	size_t copied;
 	int pad = TUN_RX_PAD;
@@ -1675,14 +1675,13 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	buflen += SKB_DATA_ALIGN(len + pad);
 	rcu_read_unlock();
 
-	alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
-	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
+	size = buflen;
+	buf = page_frag_alloc_va_prepare_align(alloc_frag, &offset, &size,
+					       SMP_CACHE_BYTES, GFP_KERNEL);
+	if (unlikely(!buf))
 		return ERR_PTR(-ENOMEM);
 
-	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
-	copied = copy_page_from_iter(alloc_frag->page,
-				     alloc_frag->offset + pad,
-				     len, from);
+	copied = copy_from_iter(buf + pad, len, from);
 	if (copied != len)
 		return ERR_PTR(-EFAULT);
 
@@ -1692,8 +1691,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	 */
 	if (hdr->gso_type || !xdp_prog) {
 		*skb_xdp = 1;
-		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
-				       pad);
+		return __tun_build_skb(tfile, alloc_frag, buf, offset, buflen,
+				       len, pad);
 	}
 
 	*skb_xdp = 0;
@@ -1710,13 +1709,12 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		if (act == XDP_REDIRECT || act == XDP_TX) {
-			get_page(alloc_frag->page);
-			alloc_frag->offset += buflen;
+			page_frag_alloc_commit(alloc_frag, offset, buflen);
 		}
 		err = tun_xdp_act(tun, xdp_prog, &xdp, act);
 		if (err < 0) {
 			if (act == XDP_REDIRECT || act == XDP_TX)
-				put_page(alloc_frag->page);
+				page_frag_free_va(buf);
 			goto out;
 		}
 
@@ -1731,8 +1729,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	rcu_read_unlock();
 	local_bh_enable();
 
-	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad);
-
+	return __tun_build_skb(tfile, alloc_frag, buf, offset, buflen, len,
+			       pad);
 out:
 	rcu_read_unlock();
 	local_bh_enable();
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..55c4b5fbe845 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -35,7 +35,6 @@
 #include <linux/sched/types.h>
 #include <linux/signal_types.h>
 #include <linux/syscall_user_dispatch_types.h>
-#include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers_types.h>
 #include <linux/restart_block.h>
@@ -45,6 +44,7 @@
 #include <linux/rv.h>
 #include <linux/livepatch_sched.h>
 #include <linux/uidgid_types.h>
+#include <linux/page_frag_cache.h>
 #include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
@@ -1338,7 +1338,7 @@ struct task_struct {
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
 
-	struct page_frag		task_frag;
+	struct page_frag_cache		task_frag;
 
 #ifdef CONFIG_TASK_DELAY_ACCT
 	struct task_delay_info		*delays;
diff --git a/include/net/sock.h b/include/net/sock.h
index d214aeca72ad..a9c76fa623ce 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -461,7 +461,7 @@ struct sock {
 	struct sk_buff_head	sk_write_queue;
 	u32			sk_dst_pending_confirm;
 	u32			sk_pacing_status; /* see enum sk_pacing */
-	struct page_frag	sk_frag;
+	struct page_frag_cache	sk_frag;
 	struct timer_list	sk_timer;
 
 	unsigned long		sk_pacing_rate; /* bytes per second */
@@ -2573,7 +2573,7 @@ static inline void sk_stream_moderate_sndbuf(struct sock *sk)
  * Return: a per task page_frag if context allows that,
  * otherwise a per socket one.
  */
-static inline struct page_frag *sk_page_frag(struct sock *sk)
+static inline struct page_frag_cache *sk_page_frag(struct sock *sk)
 {
 	if (sk->sk_use_task_frag)
 		return &current->task_frag;
@@ -2581,7 +2581,15 @@ static inline struct page_frag *sk_page_frag(struct sock *sk)
 	return &sk->sk_frag;
 }
 
-bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag);
+struct page *sk_page_frag_alloc_prepare(struct sock *sk,
+					struct page_frag_cache *pfrag,
+					unsigned int *size,
+					unsigned int *offset, void **va);
+
+struct page *sk_page_frag_alloc_pg_prepare(struct sock *sk,
+					   struct page_frag_cache *pfrag,
+					   unsigned int *size,
+					   unsigned int *offset);
 
 /*
  *	Default write policy as shown to user space via poll/select/SIGIO
diff --git a/kernel/exit.c b/kernel/exit.c
index 41a12630cbbc..8203275fd5ff 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -913,8 +913,7 @@ void __noreturn do_exit(long code)
 	if (tsk->splice_pipe)
 		free_pipe_info(tsk->splice_pipe);
 
-	if (tsk->task_frag.page)
-		put_page(tsk->task_frag.page);
+	page_frag_cache_drain(&tsk->task_frag);
 
 	exit_task_stack_account(tsk);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 39a5046c2f0b..8e5abc30c47a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1158,10 +1158,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->btrace_seq = 0;
 #endif
 	tsk->splice_pipe = NULL;
-	tsk->task_frag.page = NULL;
 	tsk->wake_q.next = NULL;
 	tsk->worker_private = NULL;
 
+	page_frag_cache_init(&tsk->task_frag);
 	kcov_task_init(tsk);
 	kmsan_task_create(tsk);
 	kmap_local_fork(tsk);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index cdbfdf651001..2b68f69bc1e9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2961,23 +2961,25 @@ static void sock_spd_release(struct splice_pipe_desc *spd, unsigned int i)
 	put_page(spd->pages[i]);
 }
 
-static struct page *linear_to_page(struct page *page, unsigned int *len,
-				   unsigned int *offset,
-				   struct sock *sk)
+static struct page *linear_to_page(struct page_frag_cache *pfrag,
+				   struct page *page, unsigned int *offset,
+				   unsigned int *len, struct sock *sk)
 {
-	struct page_frag *pfrag = sk_page_frag(sk);
+	unsigned int new_len, new_offset;
+	struct page *frag_page;
+	void *va;
 
-	if (!sk_page_frag_refill(sk, pfrag))
+	frag_page = sk_page_frag_alloc_prepare(sk, pfrag, &new_offset,
+					       &new_len, &va);
+	if (!frag_page)
 		return NULL;
 
-	*len = min_t(unsigned int, *len, pfrag->size - pfrag->offset);
+	*len = min_t(unsigned int, *len, new_len);
 
-	memcpy(page_address(pfrag->page) + pfrag->offset,
-	       page_address(page) + *offset, *len);
-	*offset = pfrag->offset;
-	pfrag->offset += *len;
+	memcpy(va, page_address(page) + *offset, *len);
+	*offset = new_offset;
 
-	return pfrag->page;
+	return frag_page;
 }
 
 static bool spd_can_coalesce(const struct splice_pipe_desc *spd,
@@ -2999,19 +3001,23 @@ static bool spd_fill_page(struct splice_pipe_desc *spd,
 			  bool linear,
 			  struct sock *sk)
 {
+	struct page_frag_cache *pfrag = sk_page_frag(sk);
+
 	if (unlikely(spd->nr_pages == MAX_SKB_FRAGS))
 		return true;
 
 	if (linear) {
-		page = linear_to_page(page, len, &offset, sk);
+		page = linear_to_page(pfrag, page, &offset, len,  sk);
 		if (!page)
 			return true;
 	}
 	if (spd_can_coalesce(spd, page, offset)) {
 		spd->partial[spd->nr_pages - 1].len += *len;
+		page_frag_alloc_commit_noref(pfrag, offset, *len);
 		return false;
 	}
-	get_page(page);
+
+	page_frag_alloc_commit(pfrag, offset, *len);
 	spd->pages[spd->nr_pages] = page;
 	spd->partial[spd->nr_pages].len = *len;
 	spd->partial[spd->nr_pages].offset = offset;
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 4d75ef9d24bf..803f3903c019 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -27,23 +27,25 @@ static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
 		 int elem_first_coalesce)
 {
-	struct page_frag *pfrag = sk_page_frag(sk);
+	struct page_frag_cache *pfrag = sk_page_frag(sk);
 	u32 osize = msg->sg.size;
 	int ret = 0;
 
 	len -= msg->sg.size;
 	while (len > 0) {
+		unsigned int frag_offset, frag_len;
 		struct scatterlist *sge;
-		u32 orig_offset;
+		struct page *page;
 		int use, i;
 
-		if (!sk_page_frag_refill(sk, pfrag)) {
+		page = sk_page_frag_alloc_pg_prepare(sk, pfrag, &frag_offset,
+						     &frag_len);
+		if (!page) {
 			ret = -ENOMEM;
 			goto msg_trim;
 		}
 
-		orig_offset = pfrag->offset;
-		use = min_t(int, len, pfrag->size - orig_offset);
+		use = min_t(int, len, frag_len);
 		if (!sk_wmem_schedule(sk, use)) {
 			ret = -ENOMEM;
 			goto msg_trim;
@@ -54,9 +56,10 @@ int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
 		sge = &msg->sg.data[i];
 
 		if (sk_msg_try_coalesce_ok(msg, elem_first_coalesce) &&
-		    sg_page(sge) == pfrag->page &&
-		    sge->offset + sge->length == orig_offset) {
+		    sg_page(sge) == page &&
+		    sge->offset + sge->length == frag_offset) {
 			sge->length += use;
+			page_frag_alloc_commit_noref(pfrag, frag_offset, use);
 		} else {
 			if (sk_msg_full(msg)) {
 				ret = -ENOSPC;
@@ -65,14 +68,13 @@ int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
 
 			sge = &msg->sg.data[msg->sg.end];
 			sg_unmark_end(sge);
-			sg_set_page(sge, pfrag->page, use, orig_offset);
-			get_page(pfrag->page);
+			sg_set_page(sge, page, use, frag_offset);
+			page_frag_alloc_commit(pfrag, frag_offset, use);
 			sk_msg_iter_next(msg, end);
 		}
 
 		sk_mem_charge(sk, use);
 		msg->sg.size += use;
-		pfrag->offset += use;
 		len -= use;
 	}
 
diff --git a/net/core/sock.c b/net/core/sock.c
index fe9195186c13..a8318c7f6391 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2191,10 +2191,7 @@ static void __sk_destruct(struct rcu_head *head)
 		pr_debug("%s: optmem leakage (%d bytes) detected\n",
 			 __func__, atomic_read(&sk->sk_omem_alloc));
 
-	if (sk->sk_frag.page) {
-		put_page(sk->sk_frag.page);
-		sk->sk_frag.page = NULL;
-	}
+	page_frag_cache_drain(&sk->sk_frag);
 
 	/* We do not need to acquire sk->sk_peer_lock, we are the last user. */
 	put_cred(sk->sk_peer_cred);
@@ -2935,16 +2932,43 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 }
 EXPORT_SYMBOL(skb_page_frag_refill);
 
-bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
+struct page *sk_page_frag_alloc_prepare(struct sock *sk,
+					struct page_frag_cache *pfrag,
+					unsigned int *offset,
+					unsigned int *size, void **va)
 {
-	if (likely(skb_page_frag_refill(32U, pfrag, sk->sk_allocation)))
-		return true;
+	struct page *page;
+
+	*size = 32U;
+	page = page_frag_alloc_prepare(pfrag, offset, size, va,
+				       sk->sk_allocation);
+	if (likely(page))
+		return page;
 
 	sk_enter_memory_pressure(sk);
 	sk_stream_moderate_sndbuf(sk);
-	return false;
+	return NULL;
+}
+EXPORT_SYMBOL(sk_page_frag_alloc_prepare);
+
+struct page *sk_page_frag_alloc_pg_prepare(struct sock *sk,
+					   struct page_frag_cache *pfrag,
+					   unsigned int *offset,
+					   unsigned int *size)
+{
+	struct page *page;
+
+	*size = 32U;
+	page = page_frag_alloc_pg_prepare(pfrag, offset, size,
+					  sk->sk_allocation);
+	if (likely(page))
+		return page;
+
+	sk_enter_memory_pressure(sk);
+	sk_stream_moderate_sndbuf(sk);
+	return NULL;
 }
-EXPORT_SYMBOL(sk_page_frag_refill);
+EXPORT_SYMBOL(sk_page_frag_alloc_pg_prepare);
 
 void __lock_sock(struct sock *sk)
 	__releases(&sk->sk_lock.slock)
@@ -3478,8 +3502,8 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
 	sk->sk_error_report	=	sock_def_error_report;
 	sk->sk_destruct		=	sock_def_destruct;
 
-	sk->sk_frag.page	=	NULL;
-	sk->sk_frag.offset	=	0;
+	page_frag_cache_init(&sk->sk_frag);
+
 	sk->sk_peek_off		=	-1;
 
 	sk->sk_peer_pid 	=	NULL;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 1fe794967211..28b66922e298 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -952,7 +952,7 @@ static int __ip_append_data(struct sock *sk,
 			    struct flowi4 *fl4,
 			    struct sk_buff_head *queue,
 			    struct inet_cork *cork,
-			    struct page_frag *pfrag,
+			    struct page_frag_cache *pfrag,
 			    int getfrag(void *from, char *to, int offset,
 					int len, int odd, struct sk_buff *skb),
 			    void *from, int length, int transhdrlen,
@@ -1228,31 +1228,40 @@ static int __ip_append_data(struct sock *sk,
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
 			int i = skb_shinfo(skb)->nr_frags;
+			unsigned int frag_offset, frag_size;
+			struct page *page;
+			void *va;
 
 			err = -ENOMEM;
-			if (!sk_page_frag_refill(sk, pfrag))
+			page = sk_page_frag_alloc_prepare(sk, pfrag,
+							  &frag_offset,
+							  &frag_size, &va);
+			if (!page)
 				goto error;
 
 			skb_zcopy_downgrade_managed(skb);
-			if (!skb_can_coalesce(skb, i, pfrag->page,
-					      pfrag->offset)) {
+			copy = min_t(int, copy, frag_size);
+
+			if (!skb_can_coalesce(skb, i, page, frag_offset)) {
 				err = -EMSGSIZE;
 				if (i == MAX_SKB_FRAGS)
 					goto error;
 
-				__skb_fill_page_desc(skb, i, pfrag->page,
-						     pfrag->offset, 0);
+				__skb_fill_page_desc(skb, i, page, frag_offset,
+						     copy);
 				skb_shinfo(skb)->nr_frags = ++i;
-				get_page(pfrag->page);
+				page_frag_alloc_commit(pfrag, frag_offset,
+						       copy);
+			} else {
+				skb_frag_size_add(
+					&skb_shinfo(skb)->frags[i - 1], copy);
+				page_frag_alloc_commit_noref(pfrag, frag_offset,
+							     copy);
 			}
-			copy = min_t(int, copy, pfrag->size - pfrag->offset);
-			if (getfrag(from,
-				    page_address(pfrag->page) + pfrag->offset,
-				    offset, copy, skb->len, skb) < 0)
+
+			if (getfrag(from, va, offset, copy, skb->len, skb) < 0)
 				goto error_efault;
 
-			pfrag->offset += copy;
-			skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
 			skb_len_add(skb, copy);
 			wmem_alloc_delta += copy;
 		} else {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f23b97777ea5..53c66d6c886b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1180,13 +1180,17 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		if (zc == 0) {
 			bool merge = true;
 			int i = skb_shinfo(skb)->nr_frags;
-			struct page_frag *pfrag = sk_page_frag(sk);
-
-			if (!sk_page_frag_refill(sk, pfrag))
+			struct page_frag_cache *pfrag = sk_page_frag(sk);
+			unsigned int offset, size;
+			struct page *page;
+			void *va;
+
+			page = sk_page_frag_alloc_prepare(sk, pfrag, &offset,
+							  &size, &va);
+			if (!page)
 				goto wait_for_space;
 
-			if (!skb_can_coalesce(skb, i, pfrag->page,
-					      pfrag->offset)) {
+			if (!skb_can_coalesce(skb, i, page, offset)) {
 				if (i >= READ_ONCE(sysctl_max_skb_frags)) {
 					tcp_mark_push(tp, skb);
 					goto new_segment;
@@ -1194,7 +1198,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 				merge = false;
 			}
 
-			copy = min_t(int, copy, pfrag->size - pfrag->offset);
+			copy = min_t(int, copy, size);
 
 			if (unlikely(skb_zcopy_pure(skb) || skb_zcopy_managed(skb))) {
 				if (tcp_downgrade_zcopy_pure(sk, skb))
@@ -1206,22 +1210,19 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			if (!copy)
 				goto wait_for_space;
 
-			err = skb_copy_to_page_nocache(sk, &msg->msg_iter, skb,
-						       pfrag->page,
-						       pfrag->offset,
-						       copy);
+			err = skb_copy_to_va_nocache(sk, &msg->msg_iter, skb,
+						     va, copy);
 			if (err)
 				goto do_error;
 
 			/* Update the skb. */
 			if (merge) {
 				skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
+				page_frag_alloc_commit_noref(pfrag, offset, copy);
 			} else {
-				skb_fill_page_desc(skb, i, pfrag->page,
-						   pfrag->offset, copy);
-				page_ref_inc(pfrag->page);
+				skb_fill_page_desc(skb, i, page, offset, copy);
+				page_frag_alloc_commit(pfrag, offset, copy);
 			}
-			pfrag->offset += copy;
 		} else if (zc == MSG_ZEROCOPY)  {
 			/* First append to a fragless skb builds initial
 			 * pure zerocopy skb
@@ -3108,11 +3109,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 
 	WARN_ON(inet->inet_num && !icsk->icsk_bind_hash);
 
-	if (sk->sk_frag.page) {
-		put_page(sk->sk_frag.page);
-		sk->sk_frag.page = NULL;
-		sk->sk_frag.offset = 0;
-	}
+	page_frag_cache_drain(&sk->sk_frag);
 	sk_error_report(sk);
 	return 0;
 }
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 61119d42b0fd..dfc96a433481 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3930,9 +3930,12 @@ static int tcp_send_syn_data(struct sock *sk, struct sk_buff *syn)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_fastopen_request *fo = tp->fastopen_req;
-	struct page_frag *pfrag = sk_page_frag(sk);
+	struct page_frag_cache *pfrag = sk_page_frag(sk);
+	unsigned int offset, size;
 	struct sk_buff *syn_data;
 	int space, err = 0;
+	struct page *page;
+	void *va;
 
 	tp->rx_opt.mss_clamp = tp->advmss;  /* If MSS is not cached */
 	if (!tcp_fastopen_cookie_check(sk, &tp->rx_opt.mss_clamp, &fo->cookie))
@@ -3951,30 +3954,31 @@ static int tcp_send_syn_data(struct sock *sk, struct sk_buff *syn)
 
 	space = min_t(size_t, space, fo->size);
 
-	if (space &&
-	    !skb_page_frag_refill(min_t(size_t, space, PAGE_SIZE),
-				  pfrag, sk->sk_allocation))
-		goto fallback;
+	if (space) {
+		size = min_t(size_t, space, PAGE_SIZE);
+		page = page_frag_alloc_prepare(pfrag, &offset, &size, &va,
+					       sk->sk_allocation);
+		if (!page)
+			goto fallback;
+	}
+
 	syn_data = tcp_stream_alloc_skb(sk, sk->sk_allocation, false);
 	if (!syn_data)
 		goto fallback;
 	memcpy(syn_data->cb, syn->cb, sizeof(syn->cb));
 	if (space) {
-		space = min_t(size_t, space, pfrag->size - pfrag->offset);
+		space = min_t(size_t, space, size);
 		space = tcp_wmem_schedule(sk, space);
 	}
 	if (space) {
-		space = copy_page_from_iter(pfrag->page, pfrag->offset,
-					    space, &fo->data->msg_iter);
+		space = _copy_from_iter(va, space, &fo->data->msg_iter);
 		if (unlikely(!space)) {
 			tcp_skb_tsorted_anchor_cleanup(syn_data);
 			kfree_skb(syn_data);
 			goto fallback;
 		}
-		skb_fill_page_desc(syn_data, 0, pfrag->page,
-				   pfrag->offset, space);
-		page_ref_inc(pfrag->page);
-		pfrag->offset += space;
+		skb_fill_page_desc(syn_data, 0, page, offset, space);
+		page_frag_alloc_commit(pfrag, offset, space);
 		skb_len_add(syn_data, space);
 		skb_zcopy_set(syn_data, fo->uarg, NULL);
 	}
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index b9dd3a66e423..95a4dbf1a7b1 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1404,7 +1404,7 @@ static int __ip6_append_data(struct sock *sk,
 			     struct sk_buff_head *queue,
 			     struct inet_cork_full *cork_full,
 			     struct inet6_cork *v6_cork,
-			     struct page_frag *pfrag,
+			     struct page_frag_cache *pfrag,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
 			     void *from, size_t length, int transhdrlen,
@@ -1745,32 +1745,41 @@ static int __ip6_append_data(struct sock *sk,
 			copy = err;
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
+			unsigned int frag_offset, frag_size;
 			int i = skb_shinfo(skb)->nr_frags;
+			struct page *page;
+			void *va;
 
 			err = -ENOMEM;
-			if (!sk_page_frag_refill(sk, pfrag))
+			page = sk_page_frag_alloc_prepare(sk, pfrag,
+							  &frag_offset,
+							  &frag_size, &va);
+			if (!page)
 				goto error;
 
 			skb_zcopy_downgrade_managed(skb);
-			if (!skb_can_coalesce(skb, i, pfrag->page,
-					      pfrag->offset)) {
+			copy = min_t(int, copy, frag_size);
+
+			if (!skb_can_coalesce(skb, i, page, frag_offset)) {
 				err = -EMSGSIZE;
 				if (i == MAX_SKB_FRAGS)
 					goto error;
 
-				__skb_fill_page_desc(skb, i, pfrag->page,
-						     pfrag->offset, 0);
+				__skb_fill_page_desc(skb, i, page, frag_offset,
+						     copy);
 				skb_shinfo(skb)->nr_frags = ++i;
-				get_page(pfrag->page);
+				page_frag_alloc_commit(pfrag, frag_offset,
+						       copy);
+			} else {
+				skb_frag_size_add(
+					&skb_shinfo(skb)->frags[i - 1], copy);
+				page_frag_alloc_commit_noref(pfrag, frag_offset,
+							     copy);
 			}
-			copy = min_t(int, copy, pfrag->size - pfrag->offset);
-			if (getfrag(from,
-				    page_address(pfrag->page) + pfrag->offset,
-				    offset, copy, skb->len, skb) < 0)
+
+			if (getfrag(from, va, offset, copy, skb->len, skb) < 0)
 				goto error_efault;
 
-			pfrag->offset += copy;
-			skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
 			skb->len += copy;
 			skb->data_len += copy;
 			skb->truesize += copy;
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 2f191e50d4fc..6b837e85b683 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -803,13 +803,17 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	while (msg_data_left(msg)) {
 		bool merge = true;
 		int i = skb_shinfo(skb)->nr_frags;
-		struct page_frag *pfrag = sk_page_frag(sk);
-
-		if (!sk_page_frag_refill(sk, pfrag))
+		struct page_frag_cache *pfrag = sk_page_frag(sk);
+		unsigned int offset, size;
+		struct page *page;
+		void *va;
+
+		page = sk_page_frag_alloc_prepare(sk, pfrag, &offset, &size,
+						  &va);
+		if (!page)
 			goto wait_for_memory;
 
-		if (!skb_can_coalesce(skb, i, pfrag->page,
-				      pfrag->offset)) {
+		if (!skb_can_coalesce(skb, i, page, offset)) {
 			if (i == MAX_SKB_FRAGS) {
 				struct sk_buff *tskb;
 
@@ -850,15 +854,12 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 			if (head != skb)
 				head->truesize += copy;
 		} else {
-			copy = min_t(int, msg_data_left(msg),
-				     pfrag->size - pfrag->offset);
+			copy = min_t(int, msg_data_left(msg), size);
 			if (!sk_wmem_schedule(sk, copy))
 				goto wait_for_memory;
 
-			err = skb_copy_to_page_nocache(sk, &msg->msg_iter, skb,
-						       pfrag->page,
-						       pfrag->offset,
-						       copy);
+			err = skb_copy_to_va_nocache(sk, &msg->msg_iter, skb,
+						     va, copy);
 			if (err)
 				goto out_error;
 
@@ -866,13 +867,12 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 			if (merge) {
 				skb_frag_size_add(
 					&skb_shinfo(skb)->frags[i - 1], copy);
+				page_frag_alloc_commit_noref(pfrag, offset, copy);
 			} else {
-				skb_fill_page_desc(skb, i, pfrag->page,
-						   pfrag->offset, copy);
-				get_page(pfrag->page);
+				skb_fill_page_desc(skb, i, page, offset, copy);
+				page_frag_alloc_commit(pfrag, offset, copy);
 			}
 
-			pfrag->offset += copy;
 		}
 
 		copied += copy;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f8bc34f0d973..368dd480c4cd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -959,17 +959,16 @@ static bool mptcp_skb_can_collapse_to(u64 write_seq,
 }
 
 /* we can append data to the given data frag if:
- * - there is space available in the backing page_frag
- * - the data frag tail matches the current page_frag free offset
+ * - the data frag tail matches the current page and offset
  * - the data frag end sequence number matches the current write seq
  */
 static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
-				       const struct page_frag *pfrag,
+				       const struct page *page,
+				       const unsigned int offset,
 				       const struct mptcp_data_frag *df)
 {
-	return df && pfrag->page == df->page &&
-		pfrag->size - pfrag->offset > 0 &&
-		pfrag->offset == (df->offset + df->data_len) &&
+	return df && page == df->page &&
+		offset == (df->offset + df->data_len) &&
 		df->data_seq + df->data_len == msk->write_seq;
 }
 
@@ -1084,30 +1083,36 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
 /* ensure we get enough memory for the frag hdr, beyond some minimal amount of
  * data
  */
-static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
+static struct page *mptcp_page_frag_alloc_prepare(struct sock *sk,
+						  struct page_frag_cache *pfrag,
+						  unsigned int *offset,
+						  unsigned int *size, void **va)
 {
-	if (likely(skb_page_frag_refill(32U + sizeof(struct mptcp_data_frag),
-					pfrag, sk->sk_allocation)))
-		return true;
+	struct page *page;
+
+	page = page_frag_alloc_prepare(pfrag, offset, size, va,
+				       sk->sk_allocation);
+	if (likely(page))
+		return page;
 
 	mptcp_enter_memory_pressure(sk);
-	return false;
+	return NULL;
 }
 
 static struct mptcp_data_frag *
-mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
-		      int orig_offset)
+mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page *page,
+		      unsigned int orig_offset)
 {
 	int offset = ALIGN(orig_offset, sizeof(long));
 	struct mptcp_data_frag *dfrag;
 
-	dfrag = (struct mptcp_data_frag *)(page_to_virt(pfrag->page) + offset);
+	dfrag = (struct mptcp_data_frag *)(page_to_virt(page) + offset);
 	dfrag->data_len = 0;
 	dfrag->data_seq = msk->write_seq;
 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
 	dfrag->already_sent = 0;
-	dfrag->page = pfrag->page;
+	dfrag->page = page;
 
 	return dfrag;
 }
@@ -1792,7 +1797,7 @@ static u32 mptcp_send_limit(const struct sock *sk)
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct page_frag *pfrag;
+	struct page_frag_cache *pfrag;
 	size_t copied = 0;
 	int ret = 0;
 	long timeo;
@@ -1831,9 +1836,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	while (msg_data_left(msg)) {
 		int total_ts, frag_truesize = 0;
 		struct mptcp_data_frag *dfrag;
-		bool dfrag_collapsed;
-		size_t psize, offset;
+		bool dfrag_collapsed = false;
+		unsigned int offset, size;
+		struct page *page;
+		size_t psize;
 		u32 copy_limit;
+		void *va;
 
 		/* ensure fitting the notsent_lowat() constraint */
 		copy_limit = mptcp_send_limit(sk);
@@ -1844,21 +1852,31 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		 * page allocator
 		 */
 		dfrag = mptcp_pending_tail(sk);
-		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
+		size = 32U;
+		page = mptcp_page_frag_alloc_prepare(sk, pfrag, &offset, &size,
+						     &va);
+		if (!page)
+			goto wait_for_memory;
+
+		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, page, offset,
+							     dfrag);
 		if (!dfrag_collapsed) {
-			if (!mptcp_page_frag_refill(sk, pfrag))
+			size = 32U + sizeof(struct mptcp_data_frag);
+			page = mptcp_page_frag_alloc_prepare(sk, pfrag, &offset,
+							     &size, &va);
+			if (!page)
 				goto wait_for_memory;
 
-			dfrag = mptcp_carve_data_frag(msk, pfrag, pfrag->offset);
+			dfrag = mptcp_carve_data_frag(msk, page, offset);
 			frag_truesize = dfrag->overhead;
+			va += dfrag->overhead;
 		}
 
 		/* we do not bound vs wspace, to allow a single packet.
 		 * memory accounting will prevent execessive memory usage
 		 * anyway
 		 */
-		offset = dfrag->offset + dfrag->data_len;
-		psize = pfrag->size - offset;
+		psize = size - frag_truesize;
 		psize = min_t(size_t, psize, msg_data_left(msg));
 		psize = min_t(size_t, psize, copy_limit);
 		total_ts = psize + frag_truesize;
@@ -1866,8 +1884,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		if (!sk_wmem_schedule(sk, total_ts))
 			goto wait_for_memory;
 
-		ret = do_copy_data_nocache(sk, psize, &msg->msg_iter,
-					   page_address(dfrag->page) + offset);
+		ret = do_copy_data_nocache(sk, psize, &msg->msg_iter, va);
 		if (ret)
 			goto do_error;
 
@@ -1876,7 +1893,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		copied += psize;
 		dfrag->data_len += psize;
 		frag_truesize += psize;
-		pfrag->offset += frag_truesize;
 		WRITE_ONCE(msk->write_seq, msk->write_seq + psize);
 
 		/* charge data on mptcp pending queue to the msk socket
@@ -1884,11 +1900,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		 */
 		sk_wmem_queued_add(sk, frag_truesize);
 		if (!dfrag_collapsed) {
-			get_page(dfrag->page);
+			page_frag_alloc_commit(pfrag, offset, frag_truesize);
 			list_add_tail(&dfrag->list, &msk->rtx_queue);
 			if (!msk->first_pending)
 				WRITE_ONCE(msk->first_pending, dfrag);
+		} else {
+			page_frag_alloc_commit_noref(pfrag, offset,
+						     frag_truesize);
 		}
+
 		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
 			 !dfrag_collapsed);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index ab6e694f7bc2..47829f3b229e 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -256,25 +256,43 @@ static void tls_device_resync_tx(struct sock *sk, struct tls_context *tls_ctx,
 	clear_bit_unlock(TLS_TX_SYNC_SCHED, &tls_ctx->flags);
 }
 
-static void tls_append_frag(struct tls_record_info *record,
-			    struct page_frag *pfrag,
-			    int size)
+static void tls_append_pfrag(struct tls_record_info *record,
+			     struct page_frag_cache *pfrag, struct page *page,
+			     unsigned int offset, unsigned int size)
 {
 	skb_frag_t *frag;
 
 	frag = &record->frags[record->num_frags - 1];
-	if (skb_frag_page(frag) == pfrag->page &&
-	    skb_frag_off(frag) + skb_frag_size(frag) == pfrag->offset) {
+	if (skb_frag_page(frag) == page &&
+	    skb_frag_off(frag) + skb_frag_size(frag) == offset) {
 		skb_frag_size_add(frag, size);
+		page_frag_alloc_commit_noref(pfrag, offset, size);
 	} else {
 		++frag;
-		skb_frag_fill_page_desc(frag, pfrag->page, pfrag->offset,
-					size);
+		skb_frag_fill_page_desc(frag, page, offset, size);
 		++record->num_frags;
-		get_page(pfrag->page);
+		page_frag_alloc_commit(pfrag, offset, size);
+	}
+
+	record->len += size;
+}
+
+static void tls_append_page(struct tls_record_info *record, struct page *page,
+			    unsigned int offset, unsigned int size)
+{
+	skb_frag_t *frag;
+
+	frag = &record->frags[record->num_frags - 1];
+	if (skb_frag_page(frag) == page &&
+	    skb_frag_off(frag) + skb_frag_size(frag) == offset) {
+		skb_frag_size_add(frag, size);
+	} else {
+		++frag;
+		skb_frag_fill_page_desc(frag, page, offset, size);
+		++record->num_frags;
+		get_page(page);
 	}
 
-	pfrag->offset += size;
 	record->len += size;
 }
 
@@ -315,11 +333,12 @@ static int tls_push_record(struct sock *sk,
 static void tls_device_record_close(struct sock *sk,
 				    struct tls_context *ctx,
 				    struct tls_record_info *record,
-				    struct page_frag *pfrag,
+				    struct page_frag_cache *pfrag,
 				    unsigned char record_type)
 {
 	struct tls_prot_info *prot = &ctx->prot_info;
-	struct page_frag dummy_tag_frag;
+	unsigned int offset, size;
+	struct page *page;
 
 	/* append tag
 	 * device will fill in the tag, we just need to append a placeholder
@@ -327,13 +346,14 @@ static void tls_device_record_close(struct sock *sk,
 	 * increases frag count)
 	 * if we can't allocate memory now use the dummy page
 	 */
-	if (unlikely(pfrag->size - pfrag->offset < prot->tag_size) &&
-	    !skb_page_frag_refill(prot->tag_size, pfrag, sk->sk_allocation)) {
-		dummy_tag_frag.page = dummy_page;
-		dummy_tag_frag.offset = 0;
-		pfrag = &dummy_tag_frag;
+	size = prot->tag_size;
+	page = page_frag_alloc_pg_prepare(pfrag, &offset, &size,
+					  sk->sk_allocation);
+	if (unlikely(!page)) {
+		tls_append_page(record, dummy_page, 0, prot->tag_size);
+	} else {
+		tls_append_pfrag(record, pfrag, page, offset, prot->tag_size);
 	}
-	tls_append_frag(record, pfrag, prot->tag_size);
 
 	/* fill prepend */
 	tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
@@ -341,23 +361,33 @@ static void tls_device_record_close(struct sock *sk,
 			 record_type);
 }
 
-static int tls_create_new_record(struct tls_offload_context_tx *offload_ctx,
-				 struct page_frag *pfrag,
+static int tls_create_new_record(struct sock *sk,
+				 struct tls_offload_context_tx *offload_ctx,
+				 struct page_frag_cache *pfrag,
 				 size_t prepend_size)
 {
 	struct tls_record_info *record;
+	unsigned int offset, size;
+	struct page *page;
 	skb_frag_t *frag;
 
+	size = prepend_size;
+	page = page_frag_alloc_pg_prepare(pfrag, &offset, &size,
+					  sk->sk_allocation);
+	if (!page) {
+		READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk);
+		sk_stream_moderate_sndbuf(sk);
+		return -ENOMEM;
+	}
+
 	record = kmalloc(sizeof(*record), GFP_KERNEL);
 	if (!record)
 		return -ENOMEM;
 
 	frag = &record->frags[0];
-	skb_frag_fill_page_desc(frag, pfrag->page, pfrag->offset,
-				prepend_size);
+	skb_frag_fill_page_desc(frag, page, offset, prepend_size);
 
-	get_page(pfrag->page);
-	pfrag->offset += prepend_size;
+	page_frag_alloc_commit(pfrag, offset, prepend_size);
 
 	record->num_frags = 1;
 	record->len = prepend_size;
@@ -365,33 +395,21 @@ static int tls_create_new_record(struct tls_offload_context_tx *offload_ctx,
 	return 0;
 }
 
-static int tls_do_allocation(struct sock *sk,
-			     struct tls_offload_context_tx *offload_ctx,
-			     struct page_frag *pfrag,
-			     size_t prepend_size)
+static struct page *tls_do_allocation(struct sock *sk,
+				      struct tls_offload_context_tx *ctx,
+				      struct page_frag_cache *pfrag,
+				      size_t prepend_size, unsigned int *offset,
+				      unsigned int *size, void **va)
 {
-	int ret;
-
-	if (!offload_ctx->open_record) {
-		if (unlikely(!skb_page_frag_refill(prepend_size, pfrag,
-						   sk->sk_allocation))) {
-			READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk);
-			sk_stream_moderate_sndbuf(sk);
-			return -ENOMEM;
-		}
+	if (!ctx->open_record) {
+		int ret;
 
-		ret = tls_create_new_record(offload_ctx, pfrag, prepend_size);
+		ret = tls_create_new_record(sk, ctx, pfrag, prepend_size);
 		if (ret)
-			return ret;
-
-		if (pfrag->size > pfrag->offset)
-			return 0;
+			return NULL;
 	}
 
-	if (!sk_page_frag_refill(sk, pfrag))
-		return -ENOMEM;
-
-	return 0;
+	return sk_page_frag_alloc_prepare(sk, pfrag, offset, size, va);
 }
 
 static int tls_device_copy_data(void *addr, size_t bytes, struct iov_iter *i)
@@ -428,8 +446,8 @@ static int tls_push_data(struct sock *sk,
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	struct tls_offload_context_tx *ctx = tls_offload_ctx_tx(tls_ctx);
 	struct tls_record_info *record;
+	struct page_frag_cache *pfrag;
 	int tls_push_record_flags;
-	struct page_frag *pfrag;
 	size_t orig_size = size;
 	u32 max_open_record_len;
 	bool more = false;
@@ -466,8 +484,13 @@ static int tls_push_data(struct sock *sk,
 	max_open_record_len = TLS_MAX_PAYLOAD_SIZE +
 			      prot->prepend_size;
 	do {
-		rc = tls_do_allocation(sk, ctx, pfrag, prot->prepend_size);
-		if (unlikely(rc)) {
+		unsigned int frag_offset, frag_size;
+		struct page *page;
+		void *va;
+
+		page = tls_do_allocation(sk, ctx, pfrag, prot->prepend_size,
+					 &frag_offset, &frag_size, &va);
+		if (unlikely(!page)) {
 			rc = sk_stream_wait_memory(sk, &timeo);
 			if (!rc)
 				continue;
@@ -495,8 +518,8 @@ static int tls_push_data(struct sock *sk,
 
 		copy = min_t(size_t, size, max_open_record_len - record->len);
 		if (copy && (flags & MSG_SPLICE_PAGES)) {
-			struct page_frag zc_pfrag;
-			struct page **pages = &zc_pfrag.page;
+			struct page *splice_page;
+			struct page **pages = &splice_page;
 			size_t off;
 
 			rc = iov_iter_extract_pages(iter, &pages,
@@ -508,24 +531,22 @@ static int tls_push_data(struct sock *sk,
 			}
 			copy = rc;
 
-			if (WARN_ON_ONCE(!sendpage_ok(zc_pfrag.page))) {
+			if (WARN_ON_ONCE(!sendpage_ok(splice_page))) {
 				iov_iter_revert(iter, copy);
 				rc = -EIO;
 				goto handle_error;
 			}
 
-			zc_pfrag.offset = off;
-			zc_pfrag.size = copy;
-			tls_append_frag(record, &zc_pfrag, copy);
+			tls_append_page(record, splice_page, off, copy);
 		} else if (copy) {
-			copy = min_t(size_t, copy, pfrag->size - pfrag->offset);
+			copy = min_t(size_t, copy, frag_size);
 
-			rc = tls_device_copy_data(page_address(pfrag->page) +
-						  pfrag->offset, copy,
-						  iter);
+			rc = tls_device_copy_data(va, copy, iter);
 			if (rc)
 				goto handle_error;
-			tls_append_frag(record, pfrag, copy);
+
+			tls_append_pfrag(record, pfrag, page, frag_offset,
+					 copy);
 		}
 
 		size -= copy;
-- 
2.33.0


