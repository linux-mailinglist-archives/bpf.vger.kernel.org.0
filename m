Return-Path: <bpf+bounces-41813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A9399B46A
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 13:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5A21C22B50
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 11:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8CF204929;
	Sat, 12 Oct 2024 11:30:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13993206966;
	Sat, 12 Oct 2024 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732609; cv=none; b=I5GQHgDHk8GQ1gq0vP5craBPQ/gemWX3qLNp+wDI5TczTFqJh5y3Iogql7PrjfCGbf2kY8LdHqaeyXsnCCYKnYxQRm5zASkRCWOY0cR4GGW7AnxRnEl6xPHLMYId2wvaBNiVZosrjAVdsTHts6jAhoMyJlFjPvURrwuXyiZMMpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732609; c=relaxed/simple;
	bh=4Z2b01QFqMFEqwfaRTID2v3jHt1DkLmJej/XD11+Bm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+TtnJSDdkFfi6+KkjqBJYv/p/eSM3n9a9yzHcVwxy97snQuTfsTR1gtOSmvGiHTHB0Gjl9JrocOoFH78bIuHGZ7DqIJmQZXoJLIQgGWZM2lK1oVxTfK/ekmkx6Gh7pZpwsAeFHq13Hq1Bnr7A8fD/t+WEcymNEo/IHRuNlkCB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XQh8P0pLzz2DdSh;
	Sat, 12 Oct 2024 19:28:53 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B48914037D;
	Sat, 12 Oct 2024 19:30:02 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 12 Oct 2024 19:30:01 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Ayush
 Sawal <ayush.sawal@chelsio.com>, Eric Dumazet <edumazet@google.com>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang
	<jasowang@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, John
 Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>,
	David Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Jamal
 Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri
 Pirko <jiri@resnulli.us>, Boris Pismenny <borisp@nvidia.com>,
	<bpf@vger.kernel.org>, <mptcp@lists.linux.dev>
Subject: [PATCH net-next v21 12/14] net: replace page_frag with page_frag_cache
Date: Sat, 12 Oct 2024 19:23:18 +0800
Message-ID: <20241012112320.2503906-13-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241012112320.2503906-1-linyunsheng@huawei.com>
References: <20241012112320.2503906-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Use the newly introduced prepare/probe/commit API to
replace page_frag with page_frag_cache for sk_page_frag().

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 .../chelsio/inline_crypto/chtls/chtls.h       |   3 -
 .../chelsio/inline_crypto/chtls/chtls_io.c    | 101 +++++-------------
 .../chelsio/inline_crypto/chtls/chtls_main.c  |   3 -
 drivers/net/tun.c                             |  47 ++++----
 include/linux/sched.h                         |   2 +-
 include/net/sock.h                            |  21 ++--
 kernel/exit.c                                 |   3 +-
 kernel/fork.c                                 |   3 +-
 net/core/skbuff.c                             |  58 +++++-----
 net/core/skmsg.c                              |  12 ++-
 net/core/sock.c                               |  32 ++++--
 net/ipv4/ip_output.c                          |  28 +++--
 net/ipv4/tcp.c                                |  23 ++--
 net/ipv4/tcp_output.c                         |  25 +++--
 net/ipv6/ip6_output.c                         |  28 +++--
 net/kcm/kcmsock.c                             |  18 ++--
 net/mptcp/protocol.c                          |  47 ++++----
 net/sched/em_meta.c                           |   2 +-
 net/tls/tls_device.c                          | 100 ++++++++++-------
 19 files changed, 294 insertions(+), 262 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
index 21e0dfeff158..85ce0b2f1f3f 100644
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
index d567e42e1760..48a61b1142a3 100644
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
+			struct page_frag_cache *nc = &sk->sk_frag;
+			struct page_frag page_frag, *pfrag;
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
+			bool merge = false;
+			void *va;
+
+			pfrag = &page_frag;
+			va = page_frag_alloc_refill_prepare(nc, 32U, pfrag,
+							    sk->sk_allocation);
+			if (unlikely(!va))
+				goto wait_for_memory;
+
+			if (skb_can_coalesce(skb, i, pfrag->page,
+					     pfrag->offset))
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
+			copy = min_t(int, copy, pfrag->size);
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
+				page_frag_commit_noref(nc, pfrag, copy);
 			} else {
-				skb_fill_page_desc(skb, i, page, off, copy);
-				if (off + copy < pg_size) {
-					/* space left keep page */
-					get_page(page);
-					TCP_PAGE(sk) = page;
-				} else {
-					TCP_PAGE(sk) = NULL;
-				}
+				skb_fill_page_desc(skb, i, pfrag->page,
+						   pfrag->offset, copy);
+				page_frag_commit(nc, pfrag, copy);
 			}
-			TCP_OFF(sk) = off + copy;
 		}
 		if (unlikely(skb->len == mss))
 			tx_skb_finalize(skb);
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
index 96fd31d75dfd..7284269174c5 100644
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
index d7a865ef370b..13113a1dca29 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1599,21 +1599,19 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 }
 
 static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
-				       struct page_frag *alloc_frag, char *buf,
-				       int buflen, int len, int pad)
+				       char *buf, int buflen, int len, int pad)
 {
 	struct sk_buff *skb = build_skb(buf, buflen);
 
-	if (!skb)
+	if (!skb) {
+		page_frag_free(buf);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	skb_reserve(skb, pad);
 	skb_put(skb, len);
 	skb_set_owner_w(skb, tfile->socket.sk);
 
-	get_page(alloc_frag->page);
-	alloc_frag->offset += buflen;
-
 	return skb;
 }
 
@@ -1661,8 +1659,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     struct virtio_net_hdr *hdr,
 				     int len, int *skb_xdp)
 {
-	struct page_frag *alloc_frag = &current->task_frag;
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+	struct page_frag_cache *nc = &current->task_frag;
 	struct bpf_prog *xdp_prog;
 	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	char *buf;
@@ -1677,16 +1675,16 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	buflen += SKB_DATA_ALIGN(len + pad);
 	rcu_read_unlock();
 
-	alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
-	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
+	buf = page_frag_alloc_align(nc, buflen, GFP_KERNEL,
+				    SMP_CACHE_BYTES);
+	if (unlikely(!buf))
 		return ERR_PTR(-ENOMEM);
 
-	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
-	copied = copy_page_from_iter(alloc_frag->page,
-				     alloc_frag->offset + pad,
-				     len, from);
-	if (copied != len)
+	copied = copy_from_iter(buf + pad, len, from);
+	if (copied != len) {
+		page_frag_alloc_abort(nc, buflen);
 		return ERR_PTR(-EFAULT);
+	}
 
 	/* There's a small window that XDP may be set after the check
 	 * of xdp_prog above, this should be rare and for simplicity
@@ -1694,8 +1692,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	 */
 	if (hdr->gso_type || !xdp_prog) {
 		*skb_xdp = 1;
-		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
-				       pad);
+		return __tun_build_skb(tfile, buf, buflen, len, pad);
 	}
 
 	*skb_xdp = 0;
@@ -1712,21 +1709,23 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		xdp_prepare_buff(&xdp, buf, pad, len, false);
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
-		if (act == XDP_REDIRECT || act == XDP_TX) {
-			get_page(alloc_frag->page);
-			alloc_frag->offset += buflen;
-		}
 		err = tun_xdp_act(tun, xdp_prog, &xdp, act);
 		if (err < 0) {
-			if (act == XDP_REDIRECT || act == XDP_TX)
-				put_page(alloc_frag->page);
+			if (act == XDP_REDIRECT || act == XDP_TX) {
+				page_frag_alloc_abort(nc, 0);
+				goto out;
+			}
+
+			page_frag_alloc_abort(nc, buflen);
 			goto out;
 		}
 
 		if (err == XDP_REDIRECT)
 			xdp_do_flush();
-		if (err != XDP_PASS)
+		if (err != XDP_PASS) {
+			page_frag_alloc_abort(nc, buflen);
 			goto out;
+		}
 
 		pad = xdp.data - xdp.data_hard_start;
 		len = xdp.data_end - xdp.data;
@@ -1735,7 +1734,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	rcu_read_unlock();
 	local_bh_enable();
 
-	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad);
+	return __tun_build_skb(tfile, buf, buflen, len, pad);
 
 out:
 	bpf_net_ctx_clear(bpf_net_ctx);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 449dd64ed9ac..f248381a6a3a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1379,7 +1379,7 @@ struct task_struct {
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
 
-	struct page_frag		task_frag;
+	struct page_frag_cache		task_frag;
 
 #ifdef CONFIG_TASK_DELAY_ACCT
 	struct task_delay_info		*delays;
diff --git a/include/net/sock.h b/include/net/sock.h
index 3d9c8949a02f..2bcb92b1f596 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -303,7 +303,7 @@ struct sk_filter;
   *	@sk_stamp: time stamp of last packet received
   *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
   *	@sk_tsflags: SO_TIMESTAMPING flags
-  *	@sk_use_task_frag: allow sk_page_frag() to use current->task_frag.
+  *	@sk_use_task_frag: allow sk_page_frag_cache() to use current->task_frag.
   *			   Sockets that can be used under memory reclaim should
   *			   set this to false.
   *	@sk_bind_phc: SO_TIMESTAMPING bind PHC index of PTP virtual clock
@@ -462,7 +462,7 @@ struct sock {
 	struct sk_buff_head	sk_write_queue;
 	u32			sk_dst_pending_confirm;
 	u32			sk_pacing_status; /* see enum sk_pacing */
-	struct page_frag	sk_frag;
+	struct page_frag_cache	sk_frag;
 	struct timer_list	sk_timer;
 
 	unsigned long		sk_pacing_rate; /* bytes per second */
@@ -2482,22 +2482,22 @@ static inline void sk_stream_moderate_sndbuf(struct sock *sk)
 }
 
 /**
- * sk_page_frag - return an appropriate page_frag
+ * sk_page_frag_cache - return an appropriate page_frag_cache
  * @sk: socket
  *
- * Use the per task page_frag instead of the per socket one for
+ * Use the per task page_frag_cache instead of the per socket one for
  * optimization when we know that we're in process context and own
  * everything that's associated with %current.
  *
  * Both direct reclaim and page faults can nest inside other
- * socket operations and end up recursing into sk_page_frag()
- * while it's already in use: explicitly avoid task page_frag
+ * socket operations and end up recursing into sk_page_frag_cache()
+ * while it's already in use: explicitly avoid task page_frag_cache
  * when users disable sk_use_task_frag.
  *
  * Return: a per task page_frag if context allows that,
  * otherwise a per socket one.
  */
-static inline struct page_frag *sk_page_frag(struct sock *sk)
+static inline struct page_frag_cache *sk_page_frag_cache(struct sock *sk)
 {
 	if (sk->sk_use_task_frag)
 		return &current->task_frag;
@@ -2505,7 +2505,12 @@ static inline struct page_frag *sk_page_frag(struct sock *sk)
 	return &sk->sk_frag;
 }
 
-bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag);
+bool sk_page_frag_refill_prepare(struct sock *sk, struct page_frag_cache *nc,
+				 struct page_frag *pfrag);
+
+void *sk_page_frag_alloc_refill_prepare(struct sock *sk,
+					struct page_frag_cache *nc,
+					struct page_frag *pfrag);
 
 /*
  *	Default write policy as shown to user space via poll/select/SIGIO
diff --git a/kernel/exit.c b/kernel/exit.c
index 619f0014c33b..5f9b7f58098d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -974,8 +974,7 @@ void __noreturn do_exit(long code)
 	if (tsk->splice_pipe)
 		free_pipe_info(tsk->splice_pipe);
 
-	if (tsk->task_frag.page)
-		put_page(tsk->task_frag.page);
+	page_frag_cache_drain(&tsk->task_frag);
 
 	exit_task_stack_account(tsk);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 89ceb4a68af2..38be5b6e160a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -81,6 +81,7 @@
 #include <linux/tty.h>
 #include <linux/fs_struct.h>
 #include <linux/magic.h>
+#include <linux/page_frag_cache.h>
 #include <linux/perf_event.h>
 #include <linux/posix-timers.h>
 #include <linux/user-return-notifier.h>
@@ -1159,10 +1160,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
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
index 6841e61a6bd0..128366ab29a1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3062,25 +3062,6 @@ static void sock_spd_release(struct splice_pipe_desc *spd, unsigned int i)
 	put_page(spd->pages[i]);
 }
 
-static struct page *linear_to_page(struct page *page, unsigned int *len,
-				   unsigned int *offset,
-				   struct sock *sk)
-{
-	struct page_frag *pfrag = sk_page_frag(sk);
-
-	if (!sk_page_frag_refill(sk, pfrag))
-		return NULL;
-
-	*len = min_t(unsigned int, *len, pfrag->size - pfrag->offset);
-
-	memcpy(page_address(pfrag->page) + pfrag->offset,
-	       page_address(page) + *offset, *len);
-	*offset = pfrag->offset;
-	pfrag->offset += *len;
-
-	return pfrag->page;
-}
-
 static bool spd_can_coalesce(const struct splice_pipe_desc *spd,
 			     struct page *page,
 			     unsigned int offset)
@@ -3091,6 +3072,37 @@ static bool spd_can_coalesce(const struct splice_pipe_desc *spd,
 		 spd->partial[spd->nr_pages - 1].len == offset);
 }
 
+static bool spd_fill_linear_page(struct splice_pipe_desc *spd,
+				 struct page *page, unsigned int offset,
+				 unsigned int *len, struct sock *sk)
+{
+	struct page_frag_cache *nc = sk_page_frag_cache(sk);
+	struct page_frag page_frag, *pfrag;
+	void *va;
+
+	pfrag = &page_frag;
+	va = sk_page_frag_alloc_refill_prepare(sk, nc, pfrag);
+	if (!va)
+		return true;
+
+	*len = min_t(unsigned int, *len, pfrag->size);
+	memcpy(va, page_address(page) + offset, *len);
+
+	if (spd_can_coalesce(spd, pfrag->page, pfrag->offset)) {
+		spd->partial[spd->nr_pages - 1].len += *len;
+		page_frag_commit_noref(nc, pfrag, *len);
+		return false;
+	}
+
+	page_frag_commit(nc, pfrag, *len);
+	spd->pages[spd->nr_pages] = pfrag->page;
+	spd->partial[spd->nr_pages].len = *len;
+	spd->partial[spd->nr_pages].offset = pfrag->offset;
+	spd->nr_pages++;
+
+	return false;
+}
+
 /*
  * Fill page/offset/length into spd, if it can hold more pages.
  */
@@ -3103,11 +3115,9 @@ static bool spd_fill_page(struct splice_pipe_desc *spd,
 	if (unlikely(spd->nr_pages == MAX_SKB_FRAGS))
 		return true;
 
-	if (linear) {
-		page = linear_to_page(page, len, &offset, sk);
-		if (!page)
-			return true;
-	}
+	if (linear)
+		return spd_fill_linear_page(spd, page, offset, len,  sk);
+
 	if (spd_can_coalesce(spd, page, offset)) {
 		spd->partial[spd->nr_pages - 1].len += *len;
 		return false;
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index b1dcbd3be89e..b19eafeeb8ac 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -27,23 +27,25 @@ static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
 		 int elem_first_coalesce)
 {
-	struct page_frag *pfrag = sk_page_frag(sk);
+	struct page_frag_cache *nc = sk_page_frag_cache(sk);
 	u32 osize = msg->sg.size;
 	int ret = 0;
 
 	len -= msg->sg.size;
 	while (len > 0) {
+		struct page_frag page_frag, *pfrag;
 		struct scatterlist *sge;
 		u32 orig_offset;
 		int use, i;
 
-		if (!sk_page_frag_refill(sk, pfrag)) {
+		pfrag = &page_frag;
+		if (!sk_page_frag_refill_prepare(sk, nc, pfrag)) {
 			ret = -ENOMEM;
 			goto msg_trim;
 		}
 
 		orig_offset = pfrag->offset;
-		use = min_t(int, len, pfrag->size - orig_offset);
+		use = min_t(int, len, pfrag->size);
 		if (!sk_wmem_schedule(sk, use)) {
 			ret = -ENOMEM;
 			goto msg_trim;
@@ -57,6 +59,7 @@ int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
 		    sg_page(sge) == pfrag->page &&
 		    sge->offset + sge->length == orig_offset) {
 			sge->length += use;
+			page_frag_commit_noref(nc, pfrag, use);
 		} else {
 			if (sk_msg_full(msg)) {
 				ret = -ENOSPC;
@@ -66,13 +69,12 @@ int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
 			sge = &msg->sg.data[msg->sg.end];
 			sg_unmark_end(sge);
 			sg_set_page(sge, pfrag->page, use, orig_offset);
-			get_page(pfrag->page);
+			page_frag_commit(nc, pfrag, use);
 			sk_msg_iter_next(msg, end);
 		}
 
 		sk_mem_charge(sk, use);
 		msg->sg.size += use;
-		pfrag->offset += use;
 		len -= use;
 	}
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 083d438d8b6f..4f8d944b7b3d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2273,10 +2273,7 @@ static void __sk_destruct(struct rcu_head *head)
 		pr_debug("%s: optmem leakage (%d bytes) detected\n",
 			 __func__, atomic_read(&sk->sk_omem_alloc));
 
-	if (sk->sk_frag.page) {
-		put_page(sk->sk_frag.page);
-		sk->sk_frag.page = NULL;
-	}
+	page_frag_cache_drain(&sk->sk_frag);
 
 	/* We do not need to acquire sk->sk_peer_lock, we are the last user. */
 	put_cred(sk->sk_peer_cred);
@@ -3035,16 +3032,33 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 }
 EXPORT_SYMBOL(skb_page_frag_refill);
 
-bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
+bool sk_page_frag_refill_prepare(struct sock *sk, struct page_frag_cache *nc,
+				 struct page_frag *pfrag)
 {
-	if (likely(skb_page_frag_refill(32U, pfrag, sk->sk_allocation)))
+	if (likely(page_frag_refill_prepare(nc, 32U, pfrag, sk->sk_allocation)))
 		return true;
 
 	sk_enter_memory_pressure(sk);
 	sk_stream_moderate_sndbuf(sk);
 	return false;
 }
-EXPORT_SYMBOL(sk_page_frag_refill);
+EXPORT_SYMBOL(sk_page_frag_refill_prepare);
+
+void *sk_page_frag_alloc_refill_prepare(struct sock *sk,
+					struct page_frag_cache *nc,
+					struct page_frag *pfrag)
+{
+	void *va;
+
+	va = page_frag_alloc_refill_prepare(nc, 32U, pfrag, sk->sk_allocation);
+	if (likely(va))
+		return va;
+
+	sk_enter_memory_pressure(sk);
+	sk_stream_moderate_sndbuf(sk);
+	return NULL;
+}
+EXPORT_SYMBOL(sk_page_frag_alloc_refill_prepare);
 
 void __lock_sock(struct sock *sk)
 	__releases(&sk->sk_lock.slock)
@@ -3566,8 +3580,8 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
 	sk->sk_error_report	=	sock_def_error_report;
 	sk->sk_destruct		=	sock_def_destruct;
 
-	sk->sk_frag.page	=	NULL;
-	sk->sk_frag.offset	=	0;
+	page_frag_cache_init(&sk->sk_frag);
+
 	sk->sk_peek_off		=	-1;
 
 	sk->sk_peer_pid 	=	NULL;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e5c55a95063d..5e5f4e7350ee 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -953,7 +953,7 @@ static int __ip_append_data(struct sock *sk,
 			    struct flowi4 *fl4,
 			    struct sk_buff_head *queue,
 			    struct inet_cork *cork,
-			    struct page_frag *pfrag,
+			    struct page_frag_cache *nc,
 			    int getfrag(void *from, char *to, int offset,
 					int len, int odd, struct sk_buff *skb),
 			    void *from, int length, int transhdrlen,
@@ -1233,13 +1233,19 @@ static int __ip_append_data(struct sock *sk,
 			copy = err;
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
+			struct page_frag page_frag, *pfrag;
 			int i = skb_shinfo(skb)->nr_frags;
+			void *va;
 
 			err = -ENOMEM;
-			if (!sk_page_frag_refill(sk, pfrag))
+			pfrag = &page_frag;
+			va = sk_page_frag_alloc_refill_prepare(sk, nc, pfrag);
+			if (!va)
 				goto error;
 
 			skb_zcopy_downgrade_managed(skb);
+			copy = min_t(int, copy, pfrag->size);
+
 			if (!skb_can_coalesce(skb, i, pfrag->page,
 					      pfrag->offset)) {
 				err = -EMSGSIZE;
@@ -1247,18 +1253,18 @@ static int __ip_append_data(struct sock *sk,
 					goto error;
 
 				__skb_fill_page_desc(skb, i, pfrag->page,
-						     pfrag->offset, 0);
+						     pfrag->offset, copy);
 				skb_shinfo(skb)->nr_frags = ++i;
-				get_page(pfrag->page);
+				page_frag_commit(nc, pfrag, copy);
+			} else {
+				skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1],
+						  copy);
+				page_frag_commit_noref(nc, pfrag, copy);
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
@@ -1373,7 +1379,7 @@ int ip_append_data(struct sock *sk, struct flowi4 *fl4,
 	}
 
 	return __ip_append_data(sk, fl4, &sk->sk_write_queue, &inet->cork.base,
-				sk_page_frag(sk), getfrag,
+				sk_page_frag_cache(sk), getfrag,
 				from, length, transhdrlen, flags);
 }
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d5d2fca8a688..fcc76d7051af 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1193,9 +1193,13 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		if (zc == 0) {
 			bool merge = true;
 			int i = skb_shinfo(skb)->nr_frags;
-			struct page_frag *pfrag = sk_page_frag(sk);
+			struct page_frag_cache *nc = sk_page_frag_cache(sk);
+			struct page_frag page_frag, *pfrag;
+			void *va;
 
-			if (!sk_page_frag_refill(sk, pfrag))
+			pfrag = &page_frag;
+			va = sk_page_frag_alloc_refill_prepare(sk, nc, pfrag);
+			if (!va)
 				goto wait_for_space;
 
 			if (!skb_can_coalesce(skb, i, pfrag->page,
@@ -1207,7 +1211,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 				merge = false;
 			}
 
-			copy = min_t(int, copy, pfrag->size - pfrag->offset);
+			copy = min_t(int, copy, pfrag->size);
 
 			if (unlikely(skb_zcopy_pure(skb) || skb_zcopy_managed(skb))) {
 				if (tcp_downgrade_zcopy_pure(sk, skb))
@@ -1220,20 +1224,19 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 				goto wait_for_space;
 
 			err = skb_copy_to_frag_nocache(sk, &msg->msg_iter, skb,
-						       page_address(pfrag->page) +
-						       pfrag->offset, copy);
+						       va, copy);
 			if (err)
 				goto do_error;
 
 			/* Update the skb. */
 			if (merge) {
 				skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
+				page_frag_commit_noref(nc, pfrag, copy);
 			} else {
 				skb_fill_page_desc(skb, i, pfrag->page,
 						   pfrag->offset, copy);
-				page_ref_inc(pfrag->page);
+				page_frag_commit(nc, pfrag, copy);
 			}
-			pfrag->offset += copy;
 		} else if (zc == MSG_ZEROCOPY)  {
 			/* First append to a fragless skb builds initial
 			 * pure zerocopy skb
@@ -3393,11 +3396,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 
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
index 06200bb111f8..be9b06d7c801 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3970,9 +3970,11 @@ static int tcp_send_syn_data(struct sock *sk, struct sk_buff *syn)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_fastopen_request *fo = tp->fastopen_req;
-	struct page_frag *pfrag = sk_page_frag(sk);
+	struct page_frag_cache *nc = sk_page_frag_cache(sk);
+	struct page_frag page_frag, *pfrag;
 	struct sk_buff *syn_data;
 	int space, err = 0;
+	void *va;
 
 	tp->rx_opt.mss_clamp = tp->advmss;  /* If MSS is not cached */
 	if (!tcp_fastopen_cookie_check(sk, &tp->rx_opt.mss_clamp, &fo->cookie))
@@ -3991,21 +3993,25 @@ static int tcp_send_syn_data(struct sock *sk, struct sk_buff *syn)
 
 	space = min_t(size_t, space, fo->size);
 
-	if (space &&
-	    !skb_page_frag_refill(min_t(size_t, space, PAGE_SIZE),
-				  pfrag, sk->sk_allocation))
-		goto fallback;
+	if (space) {
+		pfrag = &page_frag;
+		va = page_frag_alloc_refill_prepare(nc,
+						    min_t(size_t, space, PAGE_SIZE),
+						    pfrag, sk->sk_allocation);
+		if (!va)
+			goto fallback;
+	}
+
 	syn_data = tcp_stream_alloc_skb(sk, sk->sk_allocation, false);
 	if (!syn_data)
 		goto fallback;
 	memcpy(syn_data->cb, syn->cb, sizeof(syn->cb));
 	if (space) {
-		space = min_t(size_t, space, pfrag->size - pfrag->offset);
+		space = min_t(size_t, space, pfrag->size);
 		space = tcp_wmem_schedule(sk, space);
 	}
 	if (space) {
-		space = copy_page_from_iter(pfrag->page, pfrag->offset,
-					    space, &fo->data->msg_iter);
+		space = _copy_from_iter(va, space, &fo->data->msg_iter);
 		if (unlikely(!space)) {
 			tcp_skb_tsorted_anchor_cleanup(syn_data);
 			kfree_skb(syn_data);
@@ -4013,8 +4019,7 @@ static int tcp_send_syn_data(struct sock *sk, struct sk_buff *syn)
 		}
 		skb_fill_page_desc(syn_data, 0, pfrag->page,
 				   pfrag->offset, space);
-		page_ref_inc(pfrag->page);
-		pfrag->offset += space;
+		page_frag_commit(nc, pfrag, space);
 		skb_len_add(syn_data, space);
 		skb_zcopy_set(syn_data, fo->uarg, NULL);
 	}
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f7b4608bb316..be3d7ecc1f00 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1416,7 +1416,7 @@ static int __ip6_append_data(struct sock *sk,
 			     struct sk_buff_head *queue,
 			     struct inet_cork_full *cork_full,
 			     struct inet6_cork *v6_cork,
-			     struct page_frag *pfrag,
+			     struct page_frag_cache *nc,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
 			     void *from, size_t length, int transhdrlen,
@@ -1762,13 +1762,19 @@ static int __ip6_append_data(struct sock *sk,
 			copy = err;
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
+			struct page_frag page_frag, *pfrag;
 			int i = skb_shinfo(skb)->nr_frags;
+			void *va;
 
 			err = -ENOMEM;
-			if (!sk_page_frag_refill(sk, pfrag))
+			pfrag = &page_frag;
+			va = sk_page_frag_alloc_refill_prepare(sk, nc, pfrag);
+			if (!va)
 				goto error;
 
 			skb_zcopy_downgrade_managed(skb);
+			copy = min_t(int, copy, pfrag->size);
+
 			if (!skb_can_coalesce(skb, i, pfrag->page,
 					      pfrag->offset)) {
 				err = -EMSGSIZE;
@@ -1776,18 +1782,18 @@ static int __ip6_append_data(struct sock *sk,
 					goto error;
 
 				__skb_fill_page_desc(skb, i, pfrag->page,
-						     pfrag->offset, 0);
+						     pfrag->offset, copy);
 				skb_shinfo(skb)->nr_frags = ++i;
-				get_page(pfrag->page);
+				page_frag_commit(nc, pfrag, copy);
+			} else {
+				skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1],
+						  copy);
+				page_frag_commit_noref(nc, pfrag, copy);
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
@@ -1850,7 +1856,7 @@ int ip6_append_data(struct sock *sk,
 	}
 
 	return __ip6_append_data(sk, &sk->sk_write_queue, &inet->cork,
-				 &np->cork, sk_page_frag(sk), getfrag,
+				 &np->cork, sk_page_frag_cache(sk), getfrag,
 				 from, length, transhdrlen, flags, ipc6);
 }
 EXPORT_SYMBOL_GPL(ip6_append_data);
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 051fbddbf0a6..875ff26a4661 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -804,9 +804,13 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	while (msg_data_left(msg)) {
 		bool merge = true;
 		int i = skb_shinfo(skb)->nr_frags;
-		struct page_frag *pfrag = sk_page_frag(sk);
+		struct page_frag_cache *nc = sk_page_frag_cache(sk);
+		struct page_frag page_frag, *pfrag;
+		void *va;
 
-		if (!sk_page_frag_refill(sk, pfrag))
+		pfrag = &page_frag;
+		va = sk_page_frag_alloc_refill_prepare(sk, nc, pfrag);
+		if (!va)
 			goto wait_for_memory;
 
 		if (!skb_can_coalesce(skb, i, pfrag->page,
@@ -851,14 +855,12 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 			if (head != skb)
 				head->truesize += copy;
 		} else {
-			copy = min_t(int, msg_data_left(msg),
-				     pfrag->size - pfrag->offset);
+			copy = min_t(int, msg_data_left(msg), pfrag->size);
 			if (!sk_wmem_schedule(sk, copy))
 				goto wait_for_memory;
 
 			err = skb_copy_to_frag_nocache(sk, &msg->msg_iter, skb,
-						       page_address(pfrag->page) +
-						       pfrag->offset, copy);
+						       va, copy);
 			if (err)
 				goto out_error;
 
@@ -866,13 +868,13 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 			if (merge) {
 				skb_frag_size_add(
 					&skb_shinfo(skb)->frags[i - 1], copy);
+				page_frag_commit_noref(nc, pfrag, copy);
 			} else {
 				skb_fill_page_desc(skb, i, pfrag->page,
 						   pfrag->offset, copy);
-				get_page(pfrag->page);
+				page_frag_commit(nc, pfrag, copy);
 			}
 
-			pfrag->offset += copy;
 		}
 
 		copied += copy;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1f5c63eb21f0..65c917d221ed 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -978,7 +978,6 @@ static bool mptcp_skb_can_collapse_to(u64 write_seq,
 }
 
 /* we can append data to the given data frag if:
- * - there is space available in the backing page_frag
  * - the data frag tail matches the current page_frag free offset
  * - the data frag end sequence number matches the current write seq
  */
@@ -987,7 +986,6 @@ static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
 				       const struct mptcp_data_frag *df)
 {
 	return df && pfrag->page == df->page &&
-		pfrag->size - pfrag->offset > 0 &&
 		pfrag->offset == (df->offset + df->data_len) &&
 		df->data_seq + df->data_len == msk->write_seq;
 }
@@ -1103,14 +1101,20 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
 /* ensure we get enough memory for the frag hdr, beyond some minimal amount of
  * data
  */
-static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
+static void *mptcp_page_frag_alloc_refill_prepare(struct sock *sk,
+						  struct page_frag_cache *nc,
+						  struct page_frag *pfrag)
 {
-	if (likely(skb_page_frag_refill(32U + sizeof(struct mptcp_data_frag),
-					pfrag, sk->sk_allocation)))
-		return true;
+	unsigned int fragsz = 32U + sizeof(struct mptcp_data_frag);
+	void *va;
+
+	va = page_frag_alloc_refill_prepare(nc, fragsz, pfrag,
+					    sk->sk_allocation);
+	if (likely(va))
+		return va;
 
 	mptcp_enter_memory_pressure(sk);
-	return false;
+	return NULL;
 }
 
 static struct mptcp_data_frag *
@@ -1813,7 +1817,7 @@ static u32 mptcp_send_limit(const struct sock *sk)
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct page_frag *pfrag;
+	struct page_frag_cache *nc;
 	size_t copied = 0;
 	int ret = 0;
 	long timeo;
@@ -1847,14 +1851,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (unlikely(sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)))
 		goto do_error;
 
-	pfrag = sk_page_frag(sk);
+	nc = sk_page_frag_cache(sk);
 
 	while (msg_data_left(msg)) {
+		struct page_frag page_frag, *pfrag;
 		int total_ts, frag_truesize = 0;
 		struct mptcp_data_frag *dfrag;
 		bool dfrag_collapsed;
-		size_t psize, offset;
 		u32 copy_limit;
+		size_t psize;
+		void *va;
 
 		/* ensure fitting the notsent_lowat() constraint */
 		copy_limit = mptcp_send_limit(sk);
@@ -1865,21 +1871,26 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		 * page allocator
 		 */
 		dfrag = mptcp_pending_tail(sk);
-		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
+		pfrag = &page_frag;
+		va = page_frag_alloc_refill_probe(nc, 1, pfrag);
+		dfrag_collapsed = va && mptcp_frag_can_collapse_to(msk, pfrag,
+								   dfrag);
 		if (!dfrag_collapsed) {
-			if (!mptcp_page_frag_refill(sk, pfrag))
+			va = mptcp_page_frag_alloc_refill_prepare(sk, nc,
+								  pfrag);
+			if (!va)
 				goto wait_for_memory;
 
 			dfrag = mptcp_carve_data_frag(msk, pfrag, pfrag->offset);
 			frag_truesize = dfrag->overhead;
+			va += dfrag->overhead;
 		}
 
 		/* we do not bound vs wspace, to allow a single packet.
 		 * memory accounting will prevent execessive memory usage
 		 * anyway
 		 */
-		offset = dfrag->offset + dfrag->data_len;
-		psize = pfrag->size - offset;
+		psize = pfrag->size - frag_truesize;
 		psize = min_t(size_t, psize, msg_data_left(msg));
 		psize = min_t(size_t, psize, copy_limit);
 		total_ts = psize + frag_truesize;
@@ -1887,8 +1898,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		if (!sk_wmem_schedule(sk, total_ts))
 			goto wait_for_memory;
 
-		ret = do_copy_data_nocache(sk, psize, &msg->msg_iter,
-					   page_address(dfrag->page) + offset);
+		ret = do_copy_data_nocache(sk, psize, &msg->msg_iter, va);
 		if (ret)
 			goto do_error;
 
@@ -1897,7 +1907,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		copied += psize;
 		dfrag->data_len += psize;
 		frag_truesize += psize;
-		pfrag->offset += frag_truesize;
 		WRITE_ONCE(msk->write_seq, msk->write_seq + psize);
 
 		/* charge data on mptcp pending queue to the msk socket
@@ -1905,10 +1914,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		 */
 		sk_wmem_queued_add(sk, frag_truesize);
 		if (!dfrag_collapsed) {
-			get_page(dfrag->page);
+			page_frag_commit(nc, pfrag, frag_truesize);
 			list_add_tail(&dfrag->list, &msk->rtx_queue);
 			if (!msk->first_pending)
 				WRITE_ONCE(msk->first_pending, dfrag);
+		} else {
+			page_frag_commit_noref(nc, pfrag, frag_truesize);
 		}
 		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d\n", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
index 8996c73c9779..4da465af972f 100644
--- a/net/sched/em_meta.c
+++ b/net/sched/em_meta.c
@@ -590,7 +590,7 @@ META_COLLECTOR(int_sk_sendmsg_off)
 		*err = -1;
 		return;
 	}
-	dst->value = sk->sk_frag.offset;
+	dst->value = page_frag_cache_page_offset(&sk->sk_frag);
 }
 
 META_COLLECTOR(int_sk_write_pend)
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index dc063c2c7950..0ea2cee5dffe 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -253,8 +253,8 @@ static void tls_device_resync_tx(struct sock *sk, struct tls_context *tls_ctx,
 }
 
 static void tls_append_frag(struct tls_record_info *record,
-			    struct page_frag *pfrag,
-			    int size)
+			    struct page_frag_cache *nc,
+			    struct page_frag *pfrag, int size)
 {
 	skb_frag_t *frag;
 
@@ -262,15 +262,34 @@ static void tls_append_frag(struct tls_record_info *record,
 	if (skb_frag_page(frag) == pfrag->page &&
 	    skb_frag_off(frag) + skb_frag_size(frag) == pfrag->offset) {
 		skb_frag_size_add(frag, size);
+		page_frag_commit_noref(nc, pfrag, size);
 	} else {
 		++frag;
 		skb_frag_fill_page_desc(frag, pfrag->page, pfrag->offset,
 					size);
 		++record->num_frags;
+		page_frag_commit(nc, pfrag, size);
+	}
+
+	record->len += size;
+}
+
+static void tls_append_dummy_frag(struct tls_record_info *record,
+				  struct page_frag *pfrag, int size)
+{
+	skb_frag_t *frag;
+
+	frag = &record->frags[record->num_frags - 1];
+	if (skb_frag_page(frag) == pfrag->page &&
+	    skb_frag_off(frag) + skb_frag_size(frag) == pfrag->offset) {
+		skb_frag_size_add(frag, size);
+	} else {
+		++frag;
+		skb_frag_fill_page_desc(frag, pfrag->page, pfrag->offset, size);
+		++record->num_frags;
 		get_page(pfrag->page);
 	}
 
-	pfrag->offset += size;
 	record->len += size;
 }
 
@@ -311,11 +330,11 @@ static int tls_push_record(struct sock *sk,
 static void tls_device_record_close(struct sock *sk,
 				    struct tls_context *ctx,
 				    struct tls_record_info *record,
-				    struct page_frag *pfrag,
+				    struct page_frag_cache *nc,
 				    unsigned char record_type)
 {
 	struct tls_prot_info *prot = &ctx->prot_info;
-	struct page_frag dummy_tag_frag;
+	struct page_frag dummy_tag_frag, *pfrag;
 
 	/* append tag
 	 * device will fill in the tag, we just need to append a placeholder
@@ -323,13 +342,16 @@ static void tls_device_record_close(struct sock *sk,
 	 * increases frag count)
 	 * if we can't allocate memory now use the dummy page
 	 */
-	if (unlikely(pfrag->size - pfrag->offset < prot->tag_size) &&
-	    !skb_page_frag_refill(prot->tag_size, pfrag, sk->sk_allocation)) {
+	pfrag = &dummy_tag_frag;
+	if (unlikely(!page_frag_refill_probe(nc, prot->tag_size, pfrag) &&
+		     !page_frag_refill_prepare(nc, prot->tag_size, pfrag,
+					       sk->sk_allocation))) {
 		dummy_tag_frag.page = dummy_page;
 		dummy_tag_frag.offset = 0;
-		pfrag = &dummy_tag_frag;
+		tls_append_dummy_frag(record, pfrag, prot->tag_size);
+	} else {
+		tls_append_frag(record, nc, pfrag, prot->tag_size);
 	}
-	tls_append_frag(record, pfrag, prot->tag_size);
 
 	/* fill prepend */
 	tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
@@ -338,6 +360,7 @@ static void tls_device_record_close(struct sock *sk,
 }
 
 static int tls_create_new_record(struct tls_offload_context_tx *offload_ctx,
+				 struct page_frag_cache *nc,
 				 struct page_frag *pfrag,
 				 size_t prepend_size)
 {
@@ -352,8 +375,7 @@ static int tls_create_new_record(struct tls_offload_context_tx *offload_ctx,
 	skb_frag_fill_page_desc(frag, pfrag->page, pfrag->offset,
 				prepend_size);
 
-	get_page(pfrag->page);
-	pfrag->offset += prepend_size;
+	page_frag_commit(nc, pfrag, prepend_size);
 
 	record->num_frags = 1;
 	record->len = prepend_size;
@@ -361,33 +383,34 @@ static int tls_create_new_record(struct tls_offload_context_tx *offload_ctx,
 	return 0;
 }
 
-static int tls_do_allocation(struct sock *sk,
-			     struct tls_offload_context_tx *offload_ctx,
-			     struct page_frag *pfrag,
-			     size_t prepend_size)
+static void *tls_do_allocation(struct sock *sk,
+			       struct tls_offload_context_tx *offload_ctx,
+			       struct page_frag_cache *nc,
+			       size_t prepend_size, struct page_frag *pfrag)
 {
 	int ret;
 
 	if (!offload_ctx->open_record) {
-		if (unlikely(!skb_page_frag_refill(prepend_size, pfrag,
-						   sk->sk_allocation))) {
+		void *va;
+
+		if (unlikely(!page_frag_refill_prepare(nc, prepend_size, pfrag,
+						       sk->sk_allocation))) {
 			READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk);
 			sk_stream_moderate_sndbuf(sk);
-			return -ENOMEM;
+			return NULL;
 		}
 
-		ret = tls_create_new_record(offload_ctx, pfrag, prepend_size);
+		ret = tls_create_new_record(offload_ctx, nc, pfrag,
+					    prepend_size);
 		if (ret)
-			return ret;
+			return NULL;
 
-		if (pfrag->size > pfrag->offset)
-			return 0;
+		va = page_frag_alloc_refill_probe(nc, 1, pfrag);
+		if (va)
+			return va;
 	}
 
-	if (!sk_page_frag_refill(sk, pfrag))
-		return -ENOMEM;
-
-	return 0;
+	return sk_page_frag_alloc_refill_prepare(sk, nc, pfrag);
 }
 
 static int tls_device_copy_data(void *addr, size_t bytes, struct iov_iter *i)
@@ -424,8 +447,8 @@ static int tls_push_data(struct sock *sk,
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	struct tls_offload_context_tx *ctx = tls_offload_ctx_tx(tls_ctx);
 	struct tls_record_info *record;
+	struct page_frag_cache *nc;
 	int tls_push_record_flags;
-	struct page_frag *pfrag;
 	size_t orig_size = size;
 	u32 max_open_record_len;
 	bool more = false;
@@ -454,7 +477,7 @@ static int tls_push_data(struct sock *sk,
 			return rc;
 	}
 
-	pfrag = sk_page_frag(sk);
+	nc = sk_page_frag_cache(sk);
 
 	/* TLS_HEADER_SIZE is not counted as part of the TLS record, and
 	 * we need to leave room for an authentication tag.
@@ -462,8 +485,12 @@ static int tls_push_data(struct sock *sk,
 	max_open_record_len = TLS_MAX_PAYLOAD_SIZE +
 			      prot->prepend_size;
 	do {
-		rc = tls_do_allocation(sk, ctx, pfrag, prot->prepend_size);
-		if (unlikely(rc)) {
+		struct page_frag page_frag, *pfrag;
+		void *va;
+
+		pfrag = &page_frag;
+		va = tls_do_allocation(sk, ctx, nc, prot->prepend_size, pfrag);
+		if (unlikely(!va)) {
 			rc = sk_stream_wait_memory(sk, &timeo);
 			if (!rc)
 				continue;
@@ -512,16 +539,15 @@ static int tls_push_data(struct sock *sk,
 
 			zc_pfrag.offset = off;
 			zc_pfrag.size = copy;
-			tls_append_frag(record, &zc_pfrag, copy);
+			tls_append_dummy_frag(record, &zc_pfrag, copy);
 		} else if (copy) {
-			copy = min_t(size_t, copy, pfrag->size - pfrag->offset);
+			copy = min_t(size_t, copy, pfrag->size);
 
-			rc = tls_device_copy_data(page_address(pfrag->page) +
-						  pfrag->offset, copy,
-						  iter);
+			rc = tls_device_copy_data(va, copy, iter);
 			if (rc)
 				goto handle_error;
-			tls_append_frag(record, pfrag, copy);
+
+			tls_append_frag(record, nc, pfrag, copy);
 		}
 
 		size -= copy;
@@ -539,7 +565,7 @@ static int tls_push_data(struct sock *sk,
 		if (done || record->len >= max_open_record_len ||
 		    (record->num_frags >= MAX_SKB_FRAGS - 1)) {
 			tls_device_record_close(sk, tls_ctx, record,
-						pfrag, record_type);
+						nc, record_type);
 
 			rc = tls_push_record(sk,
 					     tls_ctx,
-- 
2.33.0


