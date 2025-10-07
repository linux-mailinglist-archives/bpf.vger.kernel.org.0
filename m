Return-Path: <bpf+bounces-70466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B56BBFD6C
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 02:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39867189D6EB
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 00:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899AC7082A;
	Tue,  7 Oct 2025 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nUkZUofA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573223741
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795891; cv=none; b=aiHKMGW2Hm/EJgXW+Ju7uddQPmbNohhN4NIVVufRIiF+AiMkPdBLqR6uKGDnIOFiZJJPL79B6LRJlNUjj1zBfB6Qv5oJCQoJBhV4rPyQkHVwHc4CkoBLqBA0aRr2NkFPQlP5Z8GXvkLiSM83aqaOaoSXowZWNuYU3W1lOcxyZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795891; c=relaxed/simple;
	bh=vlEedhQIKxq/ZNMGycnTYfb2Ex/ay6qJbQaJZLR+7Lc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UqJf4h6iGkY/P9CxQA9EP8l0a7UA1+6WFV7IS3aY1we8bTfpFj3Ef0kOTh/Xlc/eVU3PxJsse+2iYixJJ11qgHbO5RAKiAJkuLiqFfg0gxrYrcpeQrE1UY31vZQBa9tB7FsKtO6oM8gWx3xET8zqz3lOV0lKLOdXcEVcaxOknlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nUkZUofA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28eb14e3cafso42302755ad.1
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 17:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795889; x=1760400689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pcrTlZa8xE3hi6V4oxOodIsPLy9iNjdMsygWAzaOjgM=;
        b=nUkZUofAYLL88HfRqR2JG84x27n5rZohAH2XczzYF89F+rmo01ZMDMQ1XIp2ndGQjD
         6Hk3CdS2AEovIol4623YC/qj3W5xVGbp56tKoWxndnCyibgLIHteDg41qn2dLdpH/m3K
         IWfO4jahJl1a95RoswHUvjW6zFtdksdzsw5J0W94qsbAOB1IXRmnOIfq6GCZGTE43cDi
         hvAkwePyQ/WTxP7Arz/Z6qtxjc2S1J6ppqj6fHGugq+meVAvIPacFuwdN1JgSJ38jP0J
         PYe2PMPYrueYhdiN7IBwXFILkFlN94bAu8Hs2BSVKtmhNSIWf3aq4xfMKI1nWTxxF7ak
         APxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795889; x=1760400689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcrTlZa8xE3hi6V4oxOodIsPLy9iNjdMsygWAzaOjgM=;
        b=t3c4EiPlBFUCq8wZBJbJvZjZcS16qUF0VIfgYKjorpl8NT2+iBBl6v1RzIw7zUVF/o
         UxfTNzwFy1b0Fguo2/f0Tqc8BWYjJhYRzOZyJb2QJ5gxYBQh0CO1JgTakygSOcox5MGB
         ZmGSYCdLWjvq8Y9kmArGB+3N82/Nyt/gVFCCJWq1uYRVboEaG4oWrgOBXoU5xSc9gjyj
         enuoHWE4CTLmjky/a9r4h1dR2PZoe0oKq+WA2/mUdYpNR+6C4kaEDqXgW8hRs8r64fZZ
         rYqS5SN7yrYK/93O4OvUX80E/WO9LMF5SZYZV0AjvNA815ZaHZOtQ+lAfFs5bhEe1FRS
         5ang==
X-Forwarded-Encrypted: i=1; AJvYcCXXnDuqtexoIIYpEuq0d4BSZVlxUc73ad83TIoX1kOaPO1xREtZJny/If2gIh+59Fkcu/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv4zDtYeCFRUqZKoMXHNxZZ5SUceEkfyKA1RTgkgAPOpbK7SHm
	eJ8JZs7AJwzK8RzC+4NJHCoN0HxHCEamPqbJy24OhI/prm1x5wsxaBtiTp+wUtrJZhwOnSsi2Ne
	Wduccvw==
X-Google-Smtp-Source: AGHT+IF87VNEWY1ifch7msbf5i6YonTnkf3fKpH5U501ahjV1gsYS9Ug+SOJ66qeqdwuN+EQbQa0pB4eKL4=
X-Received: from pjbei9.prod.google.com ([2002:a17:90a:e549:b0:330:9af8:3e1d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19f0:b0:25b:a5fc:8664
 with SMTP id d9443c01a7336-28e9a6b0e6bmr148566095ad.51.1759795888718; Mon, 06
 Oct 2025 17:11:28 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:07:28 +0000
In-Reply-To: <20251007001120.2661442-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007001120.2661442-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007001120.2661442-4-kuniyu@google.com>
Subject: [PATCH bpf-next/net 3/6] net: Introduce net.core.bypass_prot_mem sysctl.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If a socket has sk->sk_bypass_prot_mem flagged, the socket opts out
of the global protocol memory accounting.

Let's control the flag by a new sysctl knob.

The flag is written once during socket(2) and is inherited to child
sockets.

Tested with a script that creates local socket pairs and send()s a
bunch of data without recv()ing.

Setup:

  # mkdir /sys/fs/cgroup/test
  # echo $$ >> /sys/fs/cgroup/test/cgroup.procs
  # sysctl -q net.ipv4.tcp_mem="1000 1000 1000"
  # ulimit -n 524288

Without net.core.bypass_prot_mem, charged to tcp_mem & memcg

  # python3 pressure.py &
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

With net.core.bypass_prot_mem=1, charged to memcg only:

  # sysctl -q net.core.bypass_prot_mem=1
  # python3 pressure.py &
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
 Documentation/admin-guide/sysctl/net.rst | 8 ++++++++
 include/net/netns/core.h                 | 1 +
 net/core/sock.c                          | 5 +++++
 net/core/sysctl_net_core.c               | 9 +++++++++
 4 files changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 2ef50828aff1..3dbe0ea212e8 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -212,6 +212,14 @@ mem_pcpu_rsv
 
 Per-cpu reserved forward alloc cache size in page units. Default 1MB per CPU.
 
+bypass_prot_mem
+---------------
+
+Skip charging socket buffers to the global per-protocol memory
+accounting controlled by net.ipv4.tcp_mem, net.ipv4.udp_mem, etc.
+
+Default: 0 (off)
+
 rmem_default
 ------------
 
diff --git a/include/net/netns/core.h b/include/net/netns/core.h
index 9b36f0ff0c20..e9053d64c8ef 100644
--- a/include/net/netns/core.h
+++ b/include/net/netns/core.h
@@ -16,6 +16,7 @@ struct netns_core {
 	int	sysctl_optmem_max;
 	u8	sysctl_txrehash;
 	u8	sysctl_tstamp_allow_data;
+	u8	sysctl_bypass_prot_mem;
 
 #ifdef CONFIG_PROC_FS
 	struct prot_inuse __percpu *prot_inuse;
diff --git a/net/core/sock.c b/net/core/sock.c
index 7de189ec2556..b28373e20d74 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2306,8 +2306,13 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		 * why we need sk_prot_creator -acme
 		 */
 		sk->sk_prot = sk->sk_prot_creator = prot;
+
+		if (READ_ONCE(net->core.sysctl_bypass_prot_mem))
+			sk->sk_bypass_prot_mem = 1;
+
 		sk->sk_kern_sock = kern;
 		sock_lock_init(sk);
+
 		sk->sk_net_refcnt = kern ? 0 : 1;
 		if (likely(sk->sk_net_refcnt)) {
 			get_net_track(net, &sk->ns_tracker, priority);
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 8cf04b57ade1..2e91fe728969 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -676,6 +676,15 @@ static struct ctl_table netns_core_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE
 	},
+	{
+		.procname	= "bypass_prot_mem",
+		.data		= &init_net.core.sysctl_bypass_prot_mem,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
 	/* sysctl_core_net_init() will set the values after this
 	 * to readonly in network namespaces
 	 */
-- 
2.51.0.710.ga91ca5db03-goog


