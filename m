Return-Path: <bpf+bounces-70467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF301BBFD74
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 02:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CA5189D537
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 00:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F3F1C3306;
	Tue,  7 Oct 2025 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjFDTW/b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA68419E7F7
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795892; cv=none; b=A0HLMKihjKhXY6Oqk/QA7mtp/IAVM5s+LbeL3lZ+j6QknjQiGD4ketqnjTzNlaCRubiW/lOpAM5UkfFOypMeZeoPiKAu2cuSD6af1e1qn/5J00b/Pfs0CtNogk3RyITMTqMWOqxRg/xzXbvygQVEIDcEDiwpeH78cyLqrM5awUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795892; c=relaxed/simple;
	bh=AvHdvBzaT5W6WfIMuD//wC5v6JFAFOsoBUTpHGLde+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AxK/tiaLvjQYStQdDpsgtrqJ4VtehEq6U6XUFQZvq/VHyL9lhNAfO+HozFbbzTfPK7yF9YXogEdmYg3vHLgVL6oSfcOUa5Z5gSbaSFPJ4X17lQ/6jl0B1tBhT+SYBex2LmiC1d8jCf2w3U3HL/pfwjzfQWnTmg41To6nktXQjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NjFDTW/b; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ec2211659so4639387a91.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 17:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795890; x=1760400690; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DRmn3t/LTxVjsQ+PkkfTspIBT9SJX3CyI9ciu5LsHX4=;
        b=NjFDTW/bKaT/tHtXDA2Bt7BguqtwrcvX7eQQXEC0Q/aJpnSPxQqt/Y3MmR8AW2MCQk
         MTQao8ZgYu8HDrZttkhWsQKGLe7OlanZHdWJdUaYjSAZErlAOkiLm6j/t/IHcZtvYVk4
         nK/o2/u67c6OEJ9TPz1ucVykkRDYHYrSjt4K/aIhQ1RcyyaLuL/6kkyCOzQLr1GhEVrt
         O75Dnfr8bA+9//FPnTRAUdkg2Ro9kneyxbWpNJxqkuewzv6zIITL6pH/3E9eYk1/PVtJ
         7U5/hf/Get+/4ddxyzWr/KC7tfLLu8vrWVS8fPkssVijSvSPYo/mS9zkEUpShFUybKcv
         Dk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795890; x=1760400690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRmn3t/LTxVjsQ+PkkfTspIBT9SJX3CyI9ciu5LsHX4=;
        b=Oxi0zpDOII+UyM34+WTlKuDsrdkp9z3QyhzbuImSaLDx+cin78fQn/OSR/ButB+cE4
         60cZjeV2pPGZFMKZpyyNYcGT7tARnUy7VGUt30VXrYIIz2X/cQvP0bZvFDHjXFK0XfEo
         s++ACxtA9ej9/gv0R5DkmUh85ru6oe/BX2sYLr8Wi2CArgkFkuFY5tfyG+7JiQY2ciPr
         XTDSaDxfYt59wK4EOD9j+m/Uoes8R5ibbu1lR5sLK2Gw6AajRS7pyKQcI9uxvufsgJwF
         s56EE+liJ4vXNi7TVoyy4z1OIbh2p276R+X059I5RzX5C/fqybLl/3cIX9Zyh04A8vJR
         iZWw==
X-Forwarded-Encrypted: i=1; AJvYcCVfIplHpPI/Byk868hJLoIIAO7g3TvzeNDG+zxtC4BD7Ht2HeAY8d9OWGb96nmlMjzFxRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhW2gU7OuXIATnb0Tb1D7p8pjb60QcfOFJnDnmFIPnqpBRMTL8
	6pdmYwReGrnLqr7H9VdoDx9peifHKltQe8pqbaeSCEwKuMub+gg/WN8wf18gJKe1RVJVSroILLO
	mWJrFvg==
X-Google-Smtp-Source: AGHT+IFhpj4pkO3kn4lYlxlN+n2bz/fWGASoUdPw0JTyTKU9sgBH9usYR6DTXxthcShyLBXzC0CPdrxi86c=
X-Received: from pjm4.prod.google.com ([2002:a17:90b:2fc4:b0:330:7be2:9bdc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1651:b0:32c:2cd:4d67
 with SMTP id 98e67ed59e1d1-339c2726d8dmr17760627a91.13.1759795890298; Mon, 06
 Oct 2025 17:11:30 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:07:29 +0000
In-Reply-To: <20251007001120.2661442-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007001120.2661442-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007001120.2661442-5-kuniyu@google.com>
Subject: [PATCH bpf-next/net 4/6] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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

We will support flagging sk->sk_bypass_prot_mem via bpf_setsockopt()
at the BPF_CGROUP_INET_SOCK_CREATE hook.

BPF_CGROUP_INET_SOCK_CREATE is invoked by __cgroup_bpf_run_filter_sk()
that passes a pointer to struct sock to the bpf prog as void *ctx.

But there are no bpf_func_proto for bpf_setsockopt() that receives
the ctx as a pointer to struct sock.

Also, bpf_getsockopt() will be necessary for a cgroup with multiple
bpf progs running.

Let's add new bpf_setsockopt() and bpf_getsockopt() variants for
BPF_CGROUP_INET_SOCK_CREATE.

Note that inet_create() is not under lock_sock() and has the same
semantics with bpf_lsm_unlocked_sockopt_hooks.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5d1838ff1ab9..83f40ac3392f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5731,6 +5731,40 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
+BPF_CALL_5(bpf_sock_create_setsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_setsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_sock_create_setsockopt_proto = {
+	.func		= bpf_sock_create_setsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
+BPF_CALL_5(bpf_sock_create_getsockopt, struct sock *, sk, int, level,
+	   int, optname, char *, optval, int, optlen)
+{
+	return __bpf_getsockopt(sk, level, optname, optval, optlen);
+}
+
+static const struct bpf_func_proto bpf_sock_create_getsockopt_proto = {
+	.func		= bpf_sock_create_getsockopt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
 BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
@@ -8060,6 +8094,20 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_cg_sock_proto;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
+	case BPF_FUNC_setsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_sock_create_setsockopt_proto;
+		default:
+			return NULL;
+		}
+	case BPF_FUNC_getsockopt:
+		switch (prog->expected_attach_type) {
+		case BPF_CGROUP_INET_SOCK_CREATE:
+			return &bpf_sock_create_getsockopt_proto;
+		default:
+			return NULL;
+		}
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
-- 
2.51.0.710.ga91ca5db03-goog


