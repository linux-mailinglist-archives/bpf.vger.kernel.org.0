Return-Path: <bpf+bounces-66583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E99B3725D
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 20:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A87FC4E2796
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B69037289F;
	Tue, 26 Aug 2025 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HT1ZEcQu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D0371EBD
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233610; cv=none; b=hWCRDQzOStdle94Nzbv9GYtVSU9Hnk3VoXKIapwNabeU7Tf72Nccb3Y1/pL/3lCUlU+gjVmZIv6Ich6CRendaulJdxBrBHkUzVhdQG4jAwbMSHsN+xq2a2sZS82MMG+uXi6gY6bS7O8dFuGMi3GgGBQFqWKZX6OAbfsyQsr7SB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233610; c=relaxed/simple;
	bh=gvLsmO4dGlj9dBHWIL4aYjHz5DUKMz7fscL7ce/U8rg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T0j8gw9ScjT94G1nYgIlN546F9LLtzUZgadR2jvAzBgY1Q082DWqfffx90/aDBClktHByDd0U80G8TozRgdPpZclaVBUJRIbDjNtrW2PAPF1W5GUHAxyasiG/ILzVMJLraBRi//iOnFxxuktOZQLoD6w3wn4k3hxO031rlMrN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HT1ZEcQu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3251961140bso4058854a91.2
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756233608; x=1756838408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TtucGp73XmcwhOeOUKXRwIuCG0YOFdYXRQJODEa9Q3s=;
        b=HT1ZEcQuFK8aBXB0Z6SqZL4g8mq8yPSVvBZiQUFw8dXkz5IpF4c8vJ7+Tcos1wdwiZ
         mR7NFdOU5qe1xVgLUHQIcOEElHbKPI+gJeWkvD9OfYifpxInv+DUaAjSEpab9flmdsV0
         EzTyY2I2ft9Ipzat1h3X9MQ8mdotYwBiAxGJcXQ9g1SScFn1Q926rUN/qlySZdN3ipWU
         2cAXvT8Ti8Uk95M3q5n2REszMfRxCTNbJDVwoD+oaCXv7SD1bbta5lGKNMdV4n2b6qoJ
         H4Ho/lYyqQJE++xFmpeXf7KNi00XgEfgNcx8k2chCv1vk6FJn2PIbCMu3jyS/U2K6/fx
         qVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756233608; x=1756838408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtucGp73XmcwhOeOUKXRwIuCG0YOFdYXRQJODEa9Q3s=;
        b=ITEBrsandO/5lMBx+0B9yJBpuRTQPj3EJ7/n5en2FtZh2mBQAkYQwomgydR3txas/5
         5IBaejgQc/k7jQ7fPsfzCqIIXrfG7AuLqXW6zWAdsnK9sbx6Wn55691lpBAmpO2MUzu6
         Un1squEGWQvYXZ1MID0apqswFFxgjio5ILu4UoR9kqLZNKdhFB/ucsY6HgjevhGUY584
         oYn2BSV+VB+xVFfCri9ZgNH4sINQWuz9HmGiHzyXL1hhuPlAShPzh6FpE0r4554gdyWG
         kJQeJalqHTayUWoqM+t3109xiutihYxGUXVF+w+tdVhR/faae82fMezZu9HPchRIcsS3
         5gOA==
X-Forwarded-Encrypted: i=1; AJvYcCXn4wnbwjDLl/kZvXOBmvRsDHXC4c3sbXzmMOsNf02eqMXWc/r+Gs3iZPxq6gwEl2hUXhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3qHHA/X0XIXGakd0KNSIsSTF6wKia4k8Mc6Xb95DeSRh25Bf7
	ZqGCn+oDVPVcamp4yO2Vs1zx2D9MiwSlzdFI1JbO3tZQkYCR70UelfSirB47Z7Wf95nX+mBamjJ
	g4fUxXA==
X-Google-Smtp-Source: AGHT+IEvZoUP+itkoaSLL6x3NpfurtGZIu0D//EaIT4VeY9gbjonY7+lFIHpfUtVCzbp6W+QXS5PdBUNOlU=
X-Received: from pjbqc7.prod.google.com ([2002:a17:90b:2887:b0:31e:eff2:4575])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b4c:b0:321:b975:abe5
 with SMTP id 98e67ed59e1d1-32515df1b9emr21082385a91.0.1756233608424; Tue, 26
 Aug 2025 11:40:08 -0700 (PDT)
Date: Tue, 26 Aug 2025 18:38:08 +0000
In-Reply-To: <20250826183940.3310118-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826183940.3310118-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250826183940.3310118-3-kuniyu@google.com>
Subject: [PATCH v3 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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

We will store a flag in sk->sk_memcg by bpf_setsockopt() during
socket() or before sk->sk_memcg is set in accept().

BPF_CGROUP_INET_SOCK_CREATE is invoked by __cgroup_bpf_run_filter_sk()
that passes a pointer to struct sock to the bpf prog as void *ctx.

But there are no bpf_func_proto for bpf_setsockopt() that receives
the ctx as a pointer to struct sock.

Let's add a new bpf_setsockopt() variant for BPF_CGROUP_INET_SOCK_CREATE.

Note that inet_create() is not under lock_sock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3: Remove bpf_func_proto for accept()
v2: Make 2 new bpf_func_proto static
---
 net/core/filter.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..443d12b7d3b2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5743,6 +5743,23 @@ static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_5(bpf_unlocked_sock_setsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return _bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_unlocked_sock_setsockopt_proto = {
+	.func		= bpf_unlocked_sock_setsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
 static int bpf_sock_ops_get_syn(struct bpf_sock_ops_kern *bpf_sock,
 				int optname, const u8 **start)
 {
@@ -8051,6 +8068,13 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_cg_sock_proto;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
+	case BPF_FUNC_setsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_unlocked_sock_setsockopt_proto;
+		default:
+			return NULL;
+		}
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
-- 
2.51.0.318.gd7df087d1a-goog


