Return-Path: <bpf+bounces-11121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401787B3839
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 18:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3CC2328261C
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDF94175B;
	Fri, 29 Sep 2023 16:58:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA153D983;
	Fri, 29 Sep 2023 16:58:31 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00931B9;
	Fri, 29 Sep 2023 09:58:29 -0700 (PDT)
Date: Fri, 29 Sep 2023 18:58:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1696006708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DGTrTa2oPR16K6MOwRQM7Gg6xqy6vg6P1EZiOvKIbeo=;
	b=4NENvC2Xk9uiW74XLfROVtVdOq53rgz1mUWkvp46SdVgqvhHPc0lfU99/3ttbQlYTmOmD+
	k15HFF4dNZKbhfC65vjElNGN0Ms5JzmtJPUBVwzYBrIbq2uTnPGe3zK7kqpSBNoze0D/vW
	Gbphtw+qQrYF9lylRixakdgAEjC79RVNHxyEriWfEwrSYtJlSNIBjVBCZ6dfVRWeN71XIO
	mxLrrdhajlRkhGCXeRSxmaDVsvSwfIVQyRttFeKGYMK+yX1n02h6ui36wrNhMZmXbm7tGM
	WH2KDuhl8YmuunGULQnXLf9/GmsKK2S/HPHDnjyyPZBVFe3fxqUg4bAc+V866Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1696006708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DGTrTa2oPR16K6MOwRQM7Gg6xqy6vg6P1EZiOvKIbeo=;
	b=lriRz0vQom1h4B1IoGz9q8j5nwdMXmTCpOlBTUDKLW19SNCpVY9VXWOOQM9N/QLAV3VvzQ
	gLuFOPIMvnuMxuAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next] net: Add a warning if NAPI cb missed xdp_do_flush().
Message-ID: <20230929165825.RvwBYGP1@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A few drivers were missing a xdp_do_flush() invocation after
XDP_REDIRECT.

Add three helper functions each for one of the per-CPU lists. Return
true if the per-CPU list is non-empty and flush the list.
Add xdp_do_check_flushed() which invokes each helper functions and
creats a warning if one of the functions had a non-empty list.
Hide everything behind CONFIG_DEBUG_NET.

Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

This is follow-up to
	https://lore.kernel.org/all/cb2f7931-5ae5-8583-acff-4a186fed6632@kernel.org

It has been compile tested.

 include/linux/bpf.h    | 16 ++++++++++++++++
 include/linux/filter.h |  8 ++++++++
 include/net/xdp_sock.h | 10 ++++++++++
 kernel/bpf/cpumap.c    | 10 ++++++++++
 kernel/bpf/devmap.c    | 10 ++++++++++
 net/core/dev.c         |  2 ++
 net/core/filter.c      | 14 ++++++++++++++
 net/xdp/xsk.c          | 10 ++++++++++
 8 files changed, 80 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 30063a760b5af..a4eb8f23d35e6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2730,6 +2730,22 @@ static inline void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_DEBUG_NET)
+bool __dev_check_flush(void);
+bool __cpu_map_check_flush(void);
+
+#else
+static inline bool __dev_check_flush(void)
+{
+	return false;
+}
+
+static inline bool __cpu_map_check_flush(void)
+{
+	return false;
+}
+#endif
+
 static __always_inline int
 bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
 {
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 27406aee2d402..db095d731813e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1025,6 +1025,14 @@ int xdp_do_redirect_frame(struct net_device *dev,
 			  struct bpf_prog *prog);
 void xdp_do_flush(void);
 
+#ifdef CONFIG_DEBUG_NET
+void xdp_do_check_flushed(struct napi_struct *napi);
+
+#else
+static inline void xdp_do_check_flushed(struct napi_struct *napi) { }
+
+#endif
+
 /* The xdp_do_flush_map() helper has been renamed to drop the _map suffix, as
  * it is no longer only flushing maps. Keep this define for compatibility
  * until all drivers are updated - do not use xdp_do_flush_map() in new code!
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 69b472604b86f..c250b78712771 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -109,4 +109,14 @@ static inline void __xsk_map_flush(void)
 
 #endif /* CONFIG_XDP_SOCKETS */
 
+#if defined(CONFIG_XDP_SOCKETS) && defined(CONFIG_DEBUG_NET)
+bool __xsk_map_check_flush(void);
+
+#else
+static inline bool __xsk_map_check_flush(void)
+{
+	return false;
+}
+#endif
+
 #endif /* _LINUX_XDP_SOCK_H */
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index e42a1bdb7f536..2cded02d83815 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -764,6 +764,16 @@ void __cpu_map_flush(void)
 	}
 }
 
+#ifdef CONFIG_DEBUG_NET
+bool __cpu_map_check_flush(void)
+{
+	if (list_empty(this_cpu_ptr(&cpu_map_flush_list)))
+		return false;
+	__cpu_map_flush();
+	return true;
+}
+#endif
+
 static int __init cpu_map_init(void)
 {
 	int cpu;
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 4d42f6ed6c11a..8619ac1b879ed 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -418,6 +418,16 @@ void __dev_flush(void)
 	}
 }
 
+#ifdef CONFIG_DEBUG_NET
+bool __dev_check_flush(void)
+{
+	if (list_empty(this_cpu_ptr(&dev_flush_list)))
+		return false;
+	__dev_flush();
+	return true;
+}
+#endif
+
 /* Elements are kept alive by RCU; either by rcu_read_lock() (from syscall) or
  * by local_bh_disable() (from XDP calls inside NAPI). The
  * rcu_read_lock_bh_held() below makes lockdep accept both.
diff --git a/net/core/dev.c b/net/core/dev.c
index 606a366cc2095..9273b12ecf6fa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6526,6 +6526,8 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 	if (test_bit(NAPI_STATE_SCHED, &n->state)) {
 		work = n->poll(n, weight);
 		trace_napi_poll(n, work, weight);
+
+		xdp_do_check_flushed(n);
 	}
 
 	if (unlikely(work > weight))
diff --git a/net/core/filter.c b/net/core/filter.c
index a094694899c99..9841d0e32cb94 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4207,6 +4207,20 @@ void xdp_do_flush(void)
 }
 EXPORT_SYMBOL_GPL(xdp_do_flush);
 
+#ifdef CONFIG_DEBUG_NET
+void xdp_do_check_flushed(struct napi_struct *napi)
+{
+	bool ret;
+
+	ret = __dev_check_flush();
+	ret |= __cpu_map_check_flush();
+	ret |= __xsk_map_check_flush();
+
+	WARN_ONCE(ret, "Missing xdp_do_flush() invocation after NAPI by %ps\n",
+		  napi->poll);
+}
+#endif
+
 void bpf_clear_redirect_map(struct bpf_map *map)
 {
 	struct bpf_redirect_info *ri;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7482d0aca5046..4eae53478db07 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -391,6 +391,16 @@ void __xsk_map_flush(void)
 	}
 }
 
+#ifdef CONFIG_DEBUG_NET
+bool __xsk_map_check_flush(void)
+{
+	if (list_empty(this_cpu_ptr(&xskmap_flush_list)))
+		return false;
+	__xsk_map_flush();
+	return true;
+}
+#endif
+
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
 {
 	xskq_prod_submit_n(pool->cq, nb_entries);
-- 
2.42.0


