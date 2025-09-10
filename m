Return-Path: <bpf+bounces-68052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFDBB520DB
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 21:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7A8484C13
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 19:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1572D5937;
	Wed, 10 Sep 2025 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbl/weVt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318832D5927
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532069; cv=none; b=O1dkYefeztg0q6W2F6mZ3ENt47NNG1RNhjKAZR45nC1NCBUc8C7Do1E1D55TYz+AlMcTHhxyHwKLr9CoEifGaQp45/QUZ9i0M1q5qQDYkPjbutCBigEusC5FEjSRv/44s95HMsd7ZzOnuqSpUWWZtYHqQUrJlvqO0CgXIcKsqeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532069; c=relaxed/simple;
	bh=G5V/ZboNsXobsS+rDKQ+3NH/kF2pPljkAibZ+K/OGXM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EkmpJe/zQDdpAR2f71JUeg9I6dUKij154Jcuwa8JxQzUjJdEXuoyBxkz1FsrbkLItL9WZpL1uqxjXlwkOvnT/OzzIJwtGsFtV682p4dDyRFazVCIvvjKowcIFWF5dvnWBrt0SWggL8BM5kjDfhSiH9BQg4yN3WM2raVzGH1MBvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pbl/weVt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24c8264a137so84391835ad.3
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757532066; x=1758136866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzzNVWMphdai6g1K8vLG3TreRAe/OsQX+77GzdePN6w=;
        b=pbl/weVtl4svyyh6tNXQzO6Y+a2M3GvM4KTB03NrBZkkHRV4ERudpSBY6/N9fZWPMP
         Tf9qy1EU8VwW+0umB2U13zsFS3zoK5DAh+wR0ebDk+INonYOs3mzhg0Sy7Ursi4juUFh
         2YrK3+pbTeiLMti5nt3wXt+GGs+v80vLEgP/DNUpdFauYSAjFdCbdCmO3wpFmehRadA/
         aaR0OIpfQSP4zfa0uXw7cO4O/2PusvKj3i2/sGro3wcWH0Ig0rO6nkBxaPYTv2uEKdaV
         j+TYFRPEyTm/MGW/HyWUeCwmkXLZvi0UtoAxy2u3RccOdameG7aMqMIqqzjh21YYpDmR
         Jmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757532066; x=1758136866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzzNVWMphdai6g1K8vLG3TreRAe/OsQX+77GzdePN6w=;
        b=u3o00DfiA7M8G6SwU31cTcfO+u/vv6lnhhkYRca8It+nhof4f08MscPefh25XSuEXe
         fdQGZk29DRYiPSJDDPRVonmRwldV+0wec+fSvfIYECs0NYbJix0Fvg7zWxzB4eD+pWW2
         lylOXpdxdB3u6EXYCQBm57xTXdyu7aPFvtmkWl2qF1DMowv246EarK8O5gDDTfvC2Z9i
         /EMP+3I/HOciLNBuPnhiztbYHCxfRQTHSO50aZ/99cjoAVRCwcsY6LKk2RySv9sZ2bdk
         1dXZ1XQokWjXuySE4M48i1os6YQ3b2/+Yb0KYST4eAOQTADwOKDXvL3z/KIDEzBiaT/6
         8TEA==
X-Forwarded-Encrypted: i=1; AJvYcCUx4cQUGDjUuOKWeI5+nR8cJ0Jj0g09ps9NOgoHDjSUD0mpEWMiM7S1qnOMkiF9fzQEhho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhcZJwt2FxNg72SUemCut6XIXflPNcHG/NPvoutSMEGnufWSc
	npgfgGFhYWncNhnB92wpx9D/HSj2ZshxZlTTwJ91Zhc+dOBKlK/xr4Oth2VOzjpTyxtDR2t9Cg5
	8meAvOA==
X-Google-Smtp-Source: AGHT+IEJ3MFBX5mBC1i+Q6pWVl09Sz9MXBQfLt9K/j0ggjjM+SITCYr/b15eWiSop1hY8R7sa5a+8tOwJj0=
X-Received: from pjbnb15.prod.google.com ([2002:a17:90b:35cf:b0:31e:a094:a39])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f609:b0:24c:1a84:f73f
 with SMTP id d9443c01a7336-25171bc0554mr154190935ad.51.1757532066447; Wed, 10
 Sep 2025 12:21:06 -0700 (PDT)
Date: Wed, 10 Sep 2025 19:19:30 +0000
In-Reply-To: <20250910192057.1045711-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250910192057.1045711-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250910192057.1045711-4-kuniyu@google.com>
Subject: [PATCH v8 bpf-next/net 3/6] net-memcg: Introduce net.core.memcg_exclusive
 sysctl.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If net.core.memcg_exclusive is 1 when sk->sk_memcg is allocated,
the socket is flagged with SK_MEMCG_EXCLUSIVE internally and skips
the global per-protocol memory accounting.

OTOH, for accept()ed child sockets, this flag is inherited from
the listening socket in sk_clone_lock() and set in __inet_accept().
This is to preserve the decision by BPF which will be supported later.

Given sk->sk_memcg can be accessed in the fast path, it would
be preferable to place the flag field in the same cache line as
sk->sk_memcg.

However, struct sock does not have such a 1-byte hole.

Let's store the flag in the lowest bit of sk->sk_memcg and check
it in mem_cgroup_sk_exclusive().

Tested with a script that creates local socket pairs and send()s a
bunch of data without recv()ing.

Setup:

  # mkdir /sys/fs/cgroup/test
  # echo $$ >> /sys/fs/cgroup/test/cgroup.procs
  # sysctl -q net.ipv4.tcp_mem="1000 1000 1000"

Without net.core.memcg_exclusive, charged to memcg & tcp_mem:

  # prlimit -n=524288:524288 bash -c "python3 pressure.py" &
  # cat /sys/fs/cgroup/test/memory.stat | grep sock
  sock 22642688 <-------------------------------------- charged to memcg
  # cat /proc/net/sockstat| grep TCP
  TCP: inuse 2006 orphan 0 tw 0 alloc 2008 mem 5376 <-- charged to tcp_mem
  # ss -tn | head -n 5
  State Recv-Q Send-Q Local Address:Port  Peer Address:Port
  ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53188
  ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:49972
  ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53868
  ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53554
  # nstat | grep Pressure || echo no pressure
  TcpExtTCPMemoryPressures        1                  0.0

With net.core.memcg_exclusive=1, only charged to memcg:

  # sysctl -q net.core.memcg_exclusive=1
  # prlimit -n=524288:524288 bash -c "python3 pressure.py" &
  # cat /sys/fs/cgroup/test/memory.stat | grep sock
  sock 2757468160 <------------------------------------ charged to memcg
  # cat /proc/net/sockstat | grep TCP
  TCP: inuse 2006 orphan 0 tw 0 alloc 2008 mem 0 <- NOT charged to tcp_mem
  # ss -tn | head -n 5
  State Recv-Q Send-Q  Local Address:Port  Peer Address:Port
  ESTAB 111000 0           127.0.0.1:36019    127.0.0.1:49026
  ESTAB 110000 0           127.0.0.1:36019    127.0.0.1:45630
  ESTAB 110000 0           127.0.0.1:36019    127.0.0.1:44870
  ESTAB 111000 0           127.0.0.1:36019    127.0.0.1:45274
  # nstat | grep Pressure || echo no pressure
  no pressure

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v8: Fix build failure when CONFIG_NET=n
---
 Documentation/admin-guide/sysctl/net.rst |  9 ++++++
 include/net/netns/core.h                 |  3 ++
 include/net/sock.h                       | 39 ++++++++++++++++++++++--
 mm/memcontrol.c                          | 12 +++++++-
 net/core/sock.c                          |  1 +
 net/core/sysctl_net_core.c               | 11 +++++++
 net/ipv4/af_inet.c                       |  4 +++
 7 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 2ef50828aff1..7272194dcf45 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -212,6 +212,15 @@ mem_pcpu_rsv
 
 Per-cpu reserved forward alloc cache size in page units. Default 1MB per CPU.
 
+memcg_exclusive
+---------------
+
+Skip charging socket buffers to the per-protocol global memory accounting
+(controlled by net.ipv4.tcp_mem, etc) if they are already charged to the
+cgroup memory controller ("sock" in memory.stat file).
+
+Default: 0
+
 rmem_default
 ------------
 
diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index 9b36f0ff0c20..ec511088e67d 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -16,6 +16,9 @@ struct netns_core {
 	int	sysctl_optmem_max;
 	u8	sysctl_txrehash;
 	u8	sysctl_tstamp_allow_data;
+#ifdef CONFIG_MEMCG
+	u8	sysctl_memcg_exclusive;
+#endif
 
 #ifdef CONFIG_PROC_FS
 	struct prot_inuse __percpu *prot_inuse;
diff --git a/include/net/sock.h b/include/net/sock.h
index 66501ab670eb..0f597f4deaa3 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2596,10 +2596,36 @@ static inline gfp_t gfp_memcg_charge(void)
 	return in_softirq() ? GFP_ATOMIC : GFP_KERNEL;
 }
 
+enum {
+	SK_MEMCG_EXCLUSIVE	= (1UL << 0),
+	SK_MEMCG_FLAG_MAX	= (1UL << 1),
+};
+
+#define SK_MEMCG_FLAG_MASK	(SK_MEMCG_FLAG_MAX - 1)
+#define SK_MEMCG_PTR_MASK	~SK_MEMCG_FLAG_MASK
+
 #ifdef CONFIG_MEMCG
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
-	return sk->sk_memcg;
+	unsigned long val = (unsigned long)sk->sk_memcg;
+
+	val &= SK_MEMCG_PTR_MASK;
+	return (struct mem_cgroup *)val;
+}
+
+static inline void mem_cgroup_sk_set_flags(struct sock *sk, unsigned short flags)
+{
+	unsigned long val = (unsigned long)mem_cgroup_from_sk(sk);
+
+	val |= flags;
+	sk->sk_memcg = (struct mem_cgroup *)val;
+}
+
+static inline unsigned short mem_cgroup_sk_get_flags(const struct sock *sk)
+{
+	unsigned long val = (unsigned long)sk->sk_memcg;
+
+	return val & SK_MEMCG_FLAG_MASK;
 }
 
 static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
@@ -2609,7 +2635,7 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 
 static inline bool mem_cgroup_sk_exclusive(const struct sock *sk)
 {
-	return false;
+	return mem_cgroup_sk_get_flags(sk) & SK_MEMCG_EXCLUSIVE;
 }
 
 static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
@@ -2634,6 +2660,15 @@ static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 	return NULL;
 }
 
+static inline void mem_cgroup_sk_set_flags(struct sock *sk, unsigned short flags)
+{
+}
+
+static inline unsigned short mem_cgroup_sk_get_flags(const struct sock *sk)
+{
+	return 0;
+}
+
 static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 {
 	return false;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index df3e9205c9e6..88028af8ac28 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4995,6 +4995,16 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
 EXPORT_SYMBOL(memcg_sockets_enabled_key);
 
+static void mem_cgroup_sk_set(struct sock *sk, struct mem_cgroup *memcg)
+{
+	sk->sk_memcg = memcg;
+
+#ifdef CONFIG_NET
+	if (READ_ONCE(sock_net(sk)->core.sysctl_memcg_exclusive))
+		mem_cgroup_sk_set_flags(sk, SK_MEMCG_EXCLUSIVE);
+#endif
+}
+
 void mem_cgroup_sk_alloc(struct sock *sk)
 {
 	struct mem_cgroup *memcg;
@@ -5013,7 +5023,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem_active(memcg))
 		goto out;
 	if (css_tryget(&memcg->css))
-		sk->sk_memcg = memcg;
+		mem_cgroup_sk_set(sk, memcg);
 out:
 	rcu_read_unlock();
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index 814966309b0e..348e599c3fbc 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2519,6 +2519,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 #ifdef CONFIG_MEMCG
 	/* sk->sk_memcg will be populated at accept() time */
 	newsk->sk_memcg = NULL;
+	mem_cgroup_sk_set_flags(newsk, mem_cgroup_sk_get_flags(sk));
 #endif
 
 	cgroup_sk_clone(&newsk->sk_cgrp_data);
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 8cf04b57ade1..c8b5fc3b8435 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -676,6 +676,17 @@ static struct ctl_table netns_core_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE
 	},
+#ifdef CONFIG_MEMCG
+	{
+		.procname	= "memcg_exclusive",
+		.data		= &init_net.core.sysctl_memcg_exclusive,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
+#endif
 	/* sysctl_core_net_init() will set the values after this
 	 * to readonly in network namespaces
 	 */
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 52d060bc9009..3fbb076ffd36 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -759,12 +759,16 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
 	    (!IS_ENABLED(CONFIG_IP_SCTP) ||
 	     sk_is_tcp(newsk) || sk_is_mptcp(newsk))) {
 		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
+		unsigned short flags;
 
+		flags = mem_cgroup_sk_get_flags(newsk);
 		mem_cgroup_sk_alloc(newsk);
 
 		if (mem_cgroup_from_sk(newsk)) {
 			int amt;
 
+			mem_cgroup_sk_set_flags(newsk, flags);
+
 			/* The socket has not been accepted yet, no need
 			 * to look at newsk->sk_wmem_queued.
 			 */
-- 
2.51.0.384.g4c02a37b29-goog


