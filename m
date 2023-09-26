Return-Path: <bpf+bounces-10895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9307AF51B
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 22:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C661A282879
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 20:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A724B205;
	Tue, 26 Sep 2023 20:28:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20BA4A553;
	Tue, 26 Sep 2023 20:28:14 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CB013A;
	Tue, 26 Sep 2023 13:28:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c16bc71e4cso60617821fa.0;
        Tue, 26 Sep 2023 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695760091; x=1696364891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BstfFZI+kHKIEaZZ+H4hdhpYXYgW1vSYYhuyFZdMRU8=;
        b=fbNv+xHNOI23S1rhsKBMftVl00geZ6hA6giGMtXMVmAlvjVJF6CL+MfX2xbaJWUON0
         ++Fb+FlpgFWg2e6FA4BomwHmIItkDYKYOlpOrof5Tc8tJoefqMnvCAGgCaNmmUlfOaca
         wbuNNknrSDFL5YC2BUuUfKo50kbJeZtb/Og+Xx+j/t3X4Wgu2mecz11JKe6iIgtgbR66
         rXju9FMntaPZpTLdlGOarAvLJ29qm8hbK3V6tbUUrwHd0n7a/XJbj2KnK/RZVRxFtd3m
         XIFLpXLMqFJWxpd0uHEMN3wlphPKkiPmGWxVjr8HrAwT70euS9a5nxwsFMfIhDZLgHBl
         xIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695760091; x=1696364891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BstfFZI+kHKIEaZZ+H4hdhpYXYgW1vSYYhuyFZdMRU8=;
        b=SojxCSSlMogRirF9+bqLklFzBDAk4anN/hZb0iaD+MnV7ZpqUe7xGkVnjQ0fkHImAA
         ir1EehaX1p1AR/R4uTiAaPdZDPg/IaAljTZx3mO5RtFzjrx0lVQXE/zvX3LJR4NSowyB
         K4b1GhlGHqeA+ZCI4JkMgwd9zF0PcWcTWBoHIJKQIZ+ebBGQQ4k3pBgUkpcNE7o1paCC
         GIA5dYfcL1OJxcLFckWiFxQneP4AyhOi7JsQpiL38kFVzGrhFQFRyxjkIlIQ9hokJ6gL
         l928LzNGa+/EYdfv/yROR2kTJ1D9RfLeKgxivEP36SiZqW2O4TnxU+pv7YQs1JRcNTbw
         gAnA==
X-Gm-Message-State: AOJu0YxuNnZU+Jak0MX29aQGW/zZYTtKEtXCVWO96kMnahbj8IqZz+R1
	ynzZSvXQRAbv7kXsbZvmkNWt4UrTb5/OhlNW
X-Google-Smtp-Source: AGHT+IErgBnnFYWSK+wT7VstOJ99vRjChMHWcupmtFAUoFI9q7ibVMLlt7EEw9TR7yDBc6IneGipKA==
X-Received: by 2002:a2e:b60d:0:b0:2c1:7d85:73e3 with SMTP id r13-20020a2eb60d000000b002c17d8573e3mr98150ljn.49.1695760090741;
        Tue, 26 Sep 2023 13:28:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id c19-20020a170906529300b00992e94bcfabsm8204664ejm.167.2023.09.26.13.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 13:28:10 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v6 3/9] bpf: Add bpf_sock_addr_set_unix_addr() to allow writing unix sockaddr from bpf
Date: Tue, 26 Sep 2023 22:27:42 +0200
Message-ID: <20230926202753.1482200-4-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926202753.1482200-1-daan.j.demeyer@gmail.com>
References: <20230926202753.1482200-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index f93e835d90af..55765632059e 100644
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


