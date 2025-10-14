Return-Path: <bpf+bounces-70952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DC1BDBD77
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 01:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B9219A314A
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 23:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA632F99AE;
	Tue, 14 Oct 2025 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Os7JnQOl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C422F5320
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760486175; cv=none; b=ugeJHUgALqevH6dX0qL6nO04jPOVXnveiE9oHjnqohMB5jzCPJPX2Wd89EoBtjism+rG9uKLzLhMFa+kMThCbXHscCYpuCLgWvIQ4hD3T/Sxf02+K2HTI3IPMfsi+8bk5AWxdlX+Xcfkv10bMYYJJ9AdeLtg+mAzmmEAj63XpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760486175; c=relaxed/simple;
	bh=Wx3oonPnxTQAfbSYtCzb3IA6bDpF1UtjNCV0U7bhOy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZCgu/OvyplDvXw/1K28vqFCZ+hBIILO9LZaawKFgjT9xdDJ2c7j9WXqgCshnD1aRG8/hIU7kF5gjWth/e36AYtHmbK+G7C3zYWeDJrgFjwNtFJQ9camZdiGmhkUT93ypGpF80zSOMh6SCEo1xkxmwKHYnss7qdsnfR+ALP6QIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Os7JnQOl; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a153ba0009so850671b3a.1
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 16:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760486174; x=1761090974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/RCVCGaPK6LjlPKGEvZncrbwe4KtV9jki2AWAAnogk=;
        b=Os7JnQOlc+Jx/0w/XwkF8pU53CKVqBz7lmSRKDeLQi/0acY8gffeT0QlmIUavUuawd
         LuyKsKMSb8MLf2aeTlMyeUgO/SBkeJ32upMG2NWsVOnevZHDRIC0KL2GXo1v6BY6caf9
         CJdPo9oEdhC37Axx7cf05GxrqzbbDfcwFoBmKHJjN/4I3n7/lcayk175nFxaWCGKZqby
         hfgGmHulatSxbjBItEPhePF2qSNIlUVdZVT0SjTVnlB9ANaBpOxHP6s0PU0U8yM+tRcy
         YRnQBQ2p/FvIC3dTacr3+vTMw6oX/IXmbfpabl/iLymUELIl8SjNrYXuj1qxnmYPOgRo
         PMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760486174; x=1761090974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/RCVCGaPK6LjlPKGEvZncrbwe4KtV9jki2AWAAnogk=;
        b=iVHMPG4eWQX8nc4tfz86jJJlyKU/1pX3aBaRlvwkWt87YU5+7bnLCzybKHztTYSG2H
         FhSZ7OeNrRGHBphSDEy/6YXDJ/+vSZ40hVMbV4YwyQ753uQqo1e5ujbw7JmXRySvVR8B
         NMmdp4E21+2eUY+65HheL4J7J3ZWyfll1wkhdzdtknsGNX02mONKzosKQYGVGhYwl+Xm
         Jo7hCDH7zXSoruTkhY56Wb44v19W6DzZDOjzOSqrJj36kDIz/P+O6Q/KgUCn+niKOAE2
         CWuOYaG2cf0av3PylPQtC2XvEQnb8Ba6NmLq3iRMLZf/swk0yI72HBksMsZTN7hOlNjy
         NA0A==
X-Forwarded-Encrypted: i=1; AJvYcCU/qXLcBwXt1XjoGy5qqf+rYmH/v7YePj7G7kOLer+21mwUBpumhxZZTNR1IDxVJ5xrAsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyazv9fRTF1ywBaEmOJzDALDTH36a7boLIxtnmXLqUiruBHL7Ed
	b7KUWUzP1aGRaBwvDS2TLjXsdud8en0dSyt6QUi6G0sglbVgOEg8o3YRiOHRM8lD7GZO4S7jSl/
	+sefOKg==
X-Google-Smtp-Source: AGHT+IFAB4XV4F12HPB1uOsT3Hefu/mSk4BZ2sJZZSN7huJgUsy/c6ZkatLRWl2WmtL7dTGtG7rc88+y/TY=
X-Received: from pgnb6.prod.google.com ([2002:a63:7146:0:b0:b54:f4ad:a4aa])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:999c:b0:2ef:1d19:3d3
 with SMTP id adf61e73a8af0-32da8139359mr38371184637.14.1760486173580; Tue, 14
 Oct 2025 16:56:13 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:54:57 +0000
In-Reply-To: <20251014235604.3057003-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014235604.3057003-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014235604.3057003-5-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 4/6] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 net/core/filter.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 76628df1fc82f..ed3f0e5360595 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5733,6 +5733,40 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
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
@@ -8062,6 +8096,20 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
2.51.0.788.g6d19910ace-goog


