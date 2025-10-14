Return-Path: <bpf+bounces-70951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C171BDBD73
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 01:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B287C3E6E9B
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 23:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE992F067A;
	Tue, 14 Oct 2025 23:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y6SHkDUX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A636C2EBB87
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760486175; cv=none; b=sP4ckfq5OZcrHTbu7f0fxu25FlV0jhUMdpXF5nO/YmdVDtWdofo6ML53yisMGdEoOpiot0jz0ESuPWEamDbDpq/yTNpx5fBl/e0lSnzgOnGKBzbUl70RJz/1vsdL/65ifqZQCGHLCg8m9YWIxkIJZ96X6UX/sS2ejkxYBHIbmcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760486175; c=relaxed/simple;
	bh=Ayn372PAhRcvI+nHsbUuCvWiMh/ePpZHFkSbbtjQrho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NZN07laI4pRRDiGcutlRx7pT04iQcrj2FumZrr5CtL5Ip45oZPHjJcQW+aKuMWj6ZWH7Fo/dpa9nhn5UgnwWT++T8Z+I761yhI5GUsEwC+3O0KeGMpDonTFLmlbXb9x0Ws7V4NjQ+tCvLMILXPAG3EICBV/s2Qj3bUx9UBkhAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y6SHkDUX; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32edda89a37so9722198a91.1
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 16:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760486172; x=1761090972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkMGz3z9AcP8ndOWtKXwgJOYtduiE1p/LMD8mE1xD+w=;
        b=Y6SHkDUXKCE0Vy9jexqVPfWSVRMjz1HgDhOnlXMSyK4JbvtHfEyjNRfOB65h/GrXXN
         TbYJmufXtPJ82QdUib+yNDd2XfIM7mBdktAbDGbCJhHAcb1UCItVWpgD8EpdtEYdyWed
         3nziZSgkG6rQpv7ytmBWqziwbFyndH2iCxEkLOSIUvxQ2ObfKKW+2pNyX+3xO2l0lttJ
         hw3DL4Z0HyCtQciUC8G6AFM7BtYWRIVSq29QFHPB1uyXYuNtY7Yooe1vLBO9TGT8XaFi
         L8PGIeicLVJZv9IsU+YWCSMKIMfwCR1c7vgPxkelpSb2qpMAjvUAc9mx6JB0fiP0Fk2N
         bP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760486172; x=1761090972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkMGz3z9AcP8ndOWtKXwgJOYtduiE1p/LMD8mE1xD+w=;
        b=pF7Mig5eoDvfWOJOUF6Y7CfCkUbbl3etmff23rpAMygpwHwya10+eos/G88IZ/yxnN
         LblFSxZnR5nToDzQZ/IeRfYB3OBIsZaA04p87G2OksB8tV1NvsO6xZovhAY35QOP1Fzd
         d7dyOEy6nGGE5oqmfDWED4KoaJq7tfAEwyhMyjU3Zd0xeoYqrprb1HWQ4u/wA8/Se8yt
         62QliHhmu8GgD/ce+4cAox111noc7fSV385A+AhBzFVHT4e5s6gw1WDbI5xe6/FsT49n
         m/Z2H/X3c6zKXJIFeP3+/d66ImUel2oG3N9CBjvlEYKL5tMYPANEjjRZ975I5JPpK6EE
         X+CA==
X-Forwarded-Encrypted: i=1; AJvYcCWmF0Ee+FjwMkqOWkUxibW4389nNucz+rrK4l1VhqbaltXL4LOIiDU4BQEex6aAEenLRfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDiTS/VzBJCZ0eRjAK9uv0h7kov7WqpVEi9EqY4pJNsuB+dxbE
	iRmaAmBlNBeyobGbTo0vv7a9M0GuHXERFXGrHa7UFFPvNS6UmUhn/z9M/stKSValRzBTojMCj94
	ffwMKVw==
X-Google-Smtp-Source: AGHT+IEiHimrgfpAzrW83/IDIFg3bQ/7vg2Px1o2QRdIC841HPosVY3EfhtqR13Knjq6uEtibQQfr8OGkec=
X-Received: from pjqc13.prod.google.com ([2002:a17:90a:a60d:b0:330:82c6:d413])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c06:b0:339:eff5:ef26
 with SMTP id 98e67ed59e1d1-33b513ced9cmr36967058a91.30.1760486171979; Tue, 14
 Oct 2025 16:56:11 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:54:56 +0000
In-Reply-To: <20251014235604.3057003-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014235604.3057003-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014235604.3057003-4-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 3/6] net: Introduce net.core.bypass_prot_mem sysctl.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
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
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/admin-guide/sysctl/net.rst | 8 ++++++++
 include/net/netns/core.h                 | 1 +
 net/core/sock.c                          | 5 +++++
 net/core/sysctl_net_core.c               | 9 +++++++++
 4 files changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 2ef50828aff16..3dbe0ea212e81 100644
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
index 9b36f0ff0c200..e9053d64c8efc 100644
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
index 7de189ec2556a..b28373e20d743 100644
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
index 8cf04b57ade1e..2e91fe728969b 100644
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
2.51.0.788.g6d19910ace-goog


