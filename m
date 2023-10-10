Return-Path: <bpf+bounces-11792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63EA7BF372
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 08:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6BC281E45
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F71947D;
	Tue, 10 Oct 2023 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JjTB7ai8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3nSWcial"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F93BA43;
	Tue, 10 Oct 2023 06:57:53 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588D09E;
	Mon,  9 Oct 2023 23:57:51 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:57:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1696921069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocBRzcNMIXw6sB6Dlrdgxxq3UgUm//dm8YBA/u9nzME=;
	b=JjTB7ai863jcZx4MDNQNBo093ozlRT5rwjZPL3EYCkrjBbZptjiDAbin+yas6+dPdt1QuI
	OTiVlEQW5TrAVhz4SCuA2EuyudPuxU97uCJaG5t44kFQZbbBo0vYsbk1BEEp+euW37+0Pg
	G0AJJ33EtJreH5NM5DHY0y62KhxvzQc8Yz8XpM0VbfZURPTvzGbXmm2NfWWtz9s/E1/8zr
	lGajOpoCa6lwt3+1GIiBM2euVEis0RvrwPzJWSArmkK3S8HVX+GN4KRUOBdzzvir58I1ck
	8n4jDi7SgIPut1AAkWXMn7g8CFkOL/d7l7l0KlHr+YBaWbp+hqnTzzejgxdx+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1696921069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocBRzcNMIXw6sB6Dlrdgxxq3UgUm//dm8YBA/u9nzME=;
	b=3nSWcialgU2AqSNY3kCDgz8WJuZCZNrQJwfjHHZiOUxR3iNZ6tJEd3biU4wn5nA3fAQFb9
	qKpkrMjBxC9H/CDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>,
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
	Yonghong Song <yonghong.song@linux.dev>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next -v4] net: Add a warning if NAPI cb missed
 xdp_do_flush().
Message-ID: <20231010065745.lJLYdf_X@linutronix.de>
References: <20230929165825.RvwBYGP1@linutronix.de>
 <20231004070926.5b4ba04c@kernel.org>
 <20231006154933.mQgxQHHt@linutronix.de>
 <20231006123139.5203444e@kernel.org>
 <20231007154351.UvncuBMF@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231007154351.UvncuBMF@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A few drivers were missing a xdp_do_flush() invocation after
XDP_REDIRECT.

Add three helper functions each for one of the per-CPU lists. Return
true if the per-CPU list is non-empty and flush the list.
Add xdp_do_check_flushed() which invokes each helper functions and
creates a warning if one of the functions had a non-empty list.
Hide everything behind CONFIG_DEBUG_NET.

Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v3=E2=80=A6v4:
  - s/creats/creates as per Simon Horman.

v2=E2=80=A6v3:
  - Collected Reviewed/Acked from the list.
  - Added an include dev.h to filter.c, the robot pointed out a missing
    prototype.

v1=E2=80=A6v2:
  - Moved xdp_do_check_flushed() to net/core/dev.h.
  - Stripped __ from function names.
  - Removed empty lines within an ifdef block.
  - xdp_do_check_flushed() is now behind CONFIG_DEBUG_NET &&
    CONFIG_BPF_SYSCALL. dev_check_flush and cpu_map_check_flush are now
    only behind CONFIG_DEBUG_NET. They have no empty inline function for
    the !CONFIG_DEBUG_NET case since they are only called in
    CONFIG_DEBUG_NET case.

 include/linux/bpf.h    |  3 +++
 include/net/xdp_sock.h |  9 +++++++++
 kernel/bpf/cpumap.c    | 10 ++++++++++
 kernel/bpf/devmap.c    | 10 ++++++++++
 net/core/dev.c         |  2 ++
 net/core/dev.h         |  6 ++++++
 net/core/filter.c      | 16 ++++++++++++++++
 net/xdp/xsk.c          | 10 ++++++++++
 8 files changed, 66 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a34ac7f00c86c..584adabd411fc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2478,6 +2478,9 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, voi=
d *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
+
+bool dev_check_flush(void);
+bool cpu_map_check_flush(void);
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 69b472604b86f..7dd0df2f6f8e6 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -109,4 +109,13 @@ static inline void __xsk_map_flush(void)
=20
 #endif /* CONFIG_XDP_SOCKETS */
=20
+#if defined(CONFIG_XDP_SOCKETS) && defined(CONFIG_DEBUG_NET)
+bool xsk_map_check_flush(void);
+#else
+static inline bool xsk_map_check_flush(void)
+{
+	return false;
+}
+#endif
+
 #endif /* _LINUX_XDP_SOCK_H */
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index e42a1bdb7f536..8a0bb80fe48a3 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -764,6 +764,16 @@ void __cpu_map_flush(void)
 	}
 }
=20
+#ifdef CONFIG_DEBUG_NET
+bool cpu_map_check_flush(void)
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
index 4d42f6ed6c11a..a936c704d4e77 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -418,6 +418,16 @@ void __dev_flush(void)
 	}
 }
=20
+#ifdef CONFIG_DEBUG_NET
+bool dev_check_flush(void)
+{
+	if (list_empty(this_cpu_ptr(&dev_flush_list)))
+		return false;
+	__dev_flush();
+	return true;
+}
+#endif
+
 /* Elements are kept alive by RCU; either by rcu_read_lock() (from syscall=
) or
  * by local_bh_disable() (from XDP calls inside NAPI). The
  * rcu_read_lock_bh_held() below makes lockdep accept both.
diff --git a/net/core/dev.c b/net/core/dev.c
index 606a366cc2095..9273b12ecf6fa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6526,6 +6526,8 @@ static int __napi_poll(struct napi_struct *n, bool *r=
epoll)
 	if (test_bit(NAPI_STATE_SCHED, &n->state)) {
 		work =3D n->poll(n, weight);
 		trace_napi_poll(n, work, weight);
+
+		xdp_do_check_flushed(n);
 	}
=20
 	if (unlikely(work > weight))
diff --git a/net/core/dev.h b/net/core/dev.h
index e075e198092cc..f66125857af77 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -136,4 +136,10 @@ static inline void netif_set_gro_ipv4_max_size(struct =
net_device *dev,
 }
=20
 int rps_cpumask_housekeeping(struct cpumask *mask);
+
+#if defined(CONFIG_DEBUG_NET) && defined(CONFIG_BPF_SYSCALL)
+void xdp_do_check_flushed(struct napi_struct *napi);
+#else
+static inline void xdp_do_check_flushed(struct napi_struct *napi) { }
+#endif
 #endif
diff --git a/net/core/filter.c b/net/core/filter.c
index a094694899c99..af2d34d5e1815 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -82,6 +82,8 @@
 #include <net/mptcp.h>
 #include <net/netfilter/nf_conntrack_bpf.h>
=20
+#include "dev.h"
+
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id);
=20
@@ -4207,6 +4209,20 @@ void xdp_do_flush(void)
 }
 EXPORT_SYMBOL_GPL(xdp_do_flush);
=20
+#if defined(CONFIG_DEBUG_NET) && defined(CONFIG_BPF_SYSCALL)
+void xdp_do_check_flushed(struct napi_struct *napi)
+{
+	bool ret;
+
+	ret =3D dev_check_flush();
+	ret |=3D cpu_map_check_flush();
+	ret |=3D xsk_map_check_flush();
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
index f5e96e0d6e01d..ba070fd37d244 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -391,6 +391,16 @@ void __xsk_map_flush(void)
 	}
 }
=20
+#ifdef CONFIG_DEBUG_NET
+bool xsk_map_check_flush(void)
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
--=20
2.42.0


