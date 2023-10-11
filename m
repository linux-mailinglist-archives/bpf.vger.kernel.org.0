Return-Path: <bpf+bounces-11936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AACD07C59E0
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 19:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06741C2112A
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9BB2230C;
	Wed, 11 Oct 2023 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr+XFdhh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E241204;
	Wed, 11 Oct 2023 17:03:38 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A6AB6;
	Wed, 11 Oct 2023 10:03:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32d3755214dso45110f8f.0;
        Wed, 11 Oct 2023 10:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697043814; x=1697648614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUgLd6uCTGmXiwt74h6Tnr+Ni8w2bJDpoH4TYmPjHoc=;
        b=fr+XFdhhgmPCnSauOpRCiWIEuz709m/Spx4GGcC2W2Ow65ZaXcxDg8GZiS+H69qLaq
         qSXFIy7Z/0EDDWJ0xGVhulS82qT0RtRuLJUrp+plEo9e5Kr8zuvW0Kjujshh1v8EobZF
         n4U7dTSwXsuSInp9FqeEQcK+bfiHwjW7X4cW6uejJJaKjZtvsvjhIu/wHz3yIF21rr+j
         D18t8L7eHPqSoesAx8UIfyr21643x+ohwLa7tOgg6mUMlm70UQkNeRSlFLSOfgJ4cYnG
         v1BG9YQyfDjjiDwlYkxCcDJy1Lb7XUQVuWOLNvGv9UUGEjRHVq7+jCsPF+40JWd6X+E4
         DeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043814; x=1697648614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUgLd6uCTGmXiwt74h6Tnr+Ni8w2bJDpoH4TYmPjHoc=;
        b=cyXFysfrdybenbpxDew7ZRKTLQpD3Nwkg7IeIRDoQ2Lr2FHWllAu/8QfgYoEccyEfs
         954sDZiuDTsejDPLmfJ9SuI8i1lQrPUxubW8fJQgULRXVoUz99u/0sbXsidQIqEFTVaX
         RqKuRruL6ioB/flomTUvj+uMe4W6YYUiKCoXX4CFUulRMQqbL4/xCCO3MlYityhW+i1r
         bmyz/ceoVnUz7JxyXTPi1wPFOqcWrp23PLNfRRJwQhCqKGf5BzCsF1AREAf4vWLpLDqC
         2fnvGTZC17ggJSUjkNJ564atL8v1JfDzceF0vsOwe/jSPWHDrzeXzi2hTfHPdDtjCPnf
         HUXw==
X-Gm-Message-State: AOJu0Yz8VQ9YmLIw2tknaTwXyQGhwL8KH7pt0pkOe8Em0xgW6ZPZsQsX
	on8lXl0Lj99SaV2NQzPXrVZJx9EkNYmRudDQ
X-Google-Smtp-Source: AGHT+IGtO2V1ViiGG8N0pHsSKBe3pL61bVX54DYAz22DGZAsTUsbX8/RMySs5MkoCt3y63J9HhQ6Lg==
X-Received: by 2002:a5d:6a01:0:b0:317:727f:3bc7 with SMTP id m1-20020a5d6a01000000b00317727f3bc7mr18785975wru.17.1697043814224;
        Wed, 11 Oct 2023 10:03:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id h28-20020adfa4dc000000b003296b913bbesm2335480wrb.12.2023.10.11.10.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:03:33 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v9 3/9] bpf: Add bpf_sock_addr_set_unix_addr() to allow writing unix sockaddr from bpf
Date: Wed, 11 Oct 2023 19:03:13 +0200
Message-ID: <20231011170321.73950-5-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011170321.73950-1-daan.j.demeyer@gmail.com>
References: <20231011170321.73950-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As prep for adding unix socket support to the cgroup sockaddr hooks,
let's add a kfunc bpf_sock_addr_set_unix_addr() that allows modifying a
sockaddr from bpf. While this is already possible for AF_INET and AF_INET6,
we'll need this kfunc when we add unix socket support since modifying the
address for those requires modifying both the address and the sockaddr
length.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 kernel/bpf/btf.c  |  1 +
 net/core/filter.c | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 69101200c124..15d71d2986d3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7850,6 +7850,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_SYSCALL:
 		return BTF_KFUNC_HOOK_SYSCALL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
+	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 		return BTF_KFUNC_HOOK_CGROUP_SKB;
 	case BPF_PROG_TYPE_SCHED_ACT:
 		return BTF_KFUNC_HOOK_SCHED_ACT;
diff --git a/net/core/filter.c b/net/core/filter.c
index a094694899c9..bd1c42b28483 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -81,6 +81,7 @@
 #include <net/xdp.h>
 #include <net/mptcp.h>
 #include <net/netfilter/nf_conntrack_bpf.h>
+#include <linux/un.h>
 
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id);
@@ -11752,6 +11753,26 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
 
 	return 0;
 }
+
+__bpf_kfunc int bpf_sock_addr_set_unix_addr(struct bpf_sock_addr_kern *sa_kern,
+					    const u8 *addr, u32 addrlen__sz)
+{
+	struct sockaddr *sa = sa_kern->uaddr;
+	struct sockaddr_un *un;
+
+	if (sa_kern->sk->sk_family != AF_UNIX)
+		return -EINVAL;
+
+	/* We do not allow changing the address of unnamed unix sockets. */
+	if (addrlen__sz == 0 || addrlen__sz > UNIX_PATH_MAX)
+		return -EINVAL;
+
+	un = (struct sockaddr_un *)sa;
+	memcpy(un->sun_path, addr, addrlen__sz);
+	sa_kern->uaddrlen = offsetof(struct sockaddr_un, sun_path) + addrlen__sz;
+
+	return 0;
+}
 __diag_pop();
 
 int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
@@ -11776,6 +11797,10 @@ BTF_SET8_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 BTF_SET8_END(bpf_kfunc_check_set_xdp)
 
+BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
+BTF_ID_FLAGS(func, bpf_sock_addr_set_unix_addr)
+BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -11786,6 +11811,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
 	.set = &bpf_kfunc_check_set_xdp,
 };
 
+static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_sock_addr,
+};
+
 static int __init bpf_kfunc_init(void)
 {
 	int ret;
@@ -11800,7 +11830,9 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
-	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
+						&bpf_kfunc_set_sock_addr);
 }
 late_initcall(bpf_kfunc_init);
 
-- 
2.41.0


