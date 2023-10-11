Return-Path: <bpf+bounces-11935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CDE7C59DD
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 19:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C501C211B2
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435C89CA60;
	Wed, 11 Oct 2023 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHpLLugM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70B23AC0F;
	Wed, 11 Oct 2023 17:03:36 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAD9B0;
	Wed, 11 Oct 2023 10:03:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso951855e9.2;
        Wed, 11 Oct 2023 10:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697043813; x=1697648613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZafyabJ7QNnzUmzPOmK7GS48QO6+DM1/N/DiaDuDpl4=;
        b=YHpLLugM98JS/wcpsaego+LjRtqhDSvFyRoaGiVLTegYqx2pkUhEjLSCqPMyIOWvsq
         eGjIDmj+K0TIpM610g3qpsflFWqyQJV33KZKI9rACG7O2ocnQ8mqVmSHwDcOBnB/EtoI
         6Zj2OHf3NlX18O4cWQ8807UHO0VENK+G1rF2Py8Nx8UhtDJcp0fisLalVti3ABTH+aFy
         alJY4gu71bQWkKn4KOTDRb66u/L+2qhgDbpzRBeyXpMWgfC/ddivNCP/myIZvwW5qOjx
         MXiNpIW14hBvbsTNsH+e0Ln6codB3NSDbaMnCppbn5YQFpyfMduoaqcDcuzSZ4R+WIvS
         xZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043813; x=1697648613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZafyabJ7QNnzUmzPOmK7GS48QO6+DM1/N/DiaDuDpl4=;
        b=en2nIIeDKMN9Wfpz7AYj/ayOg5vdpC7QnnP8+/25sHvgeT+OtZm3LqDteEFZkZWfUJ
         BGBDccgqUVVvEPdTwDsh0Flz+UKIqXAfwM7AqCKxT51mBSG0800V1wNWAqmEDzMb+pP2
         HgtbsM64ibx/kdPk3xUV5cjIBolOWYw9wflIgIfsOcrKOK3burOYZRbUMld6KcyzhopA
         AWJiO+3UYH7aL3WigWFwoSVVjXyI2RFa/7GM1wcLlkoefuheB/GaviHS4W5/Ov1vLycJ
         L37FZpqySowawVexXGcGfDB6XKr5pmgQZKNaNG1/gscfomm9r14AaEsXMn+3ACq2+d04
         Xn0w==
X-Gm-Message-State: AOJu0Yy0rO+boqDpEIURb7iElJ8EY9pxpbEVacGZ3wn09V/ke9d4tvvN
	BsruqVIAj4yHCwclSPqrxRi4s2R/mT2q800C
X-Google-Smtp-Source: AGHT+IFDZ64VaV2GkgaedZlAPYzShDGg/fjOrN6ktx2FAVPJC+rLlhZ8W3eW+5ZmdnNwggFrvKFwug==
X-Received: by 2002:adf:e191:0:b0:32d:8872:aac8 with SMTP id az17-20020adfe191000000b0032d8872aac8mr1743148wrb.31.1697043813233;
        Wed, 11 Oct 2023 10:03:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id h28-20020adfa4dc000000b003296b913bbesm2335480wrb.12.2023.10.11.10.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:03:32 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v10 3/9] bpf: Add bpf_sock_addr_set_sun_path() to allow writing unix sockaddr from bpf
Date: Wed, 11 Oct 2023 19:03:12 +0200
Message-ID: <20231011170321.73950-4-daan.j.demeyer@gmail.com>
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
let's add a kfunc bpf_sock_addr_set_sun_path() that allows modifying a unix
sockaddr from bpf. While this is already possible for AF_INET and AF_INET6,
we'll need this kfunc when we add unix socket support since modifying the
address for those requires modifying both the address and the sockaddr
length.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 kernel/bpf/btf.c  |  1 +
 net/core/filter.c | 40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

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
index a094694899c9..12fbd8a560c8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -81,6 +81,7 @@
 #include <net/xdp.h>
 #include <net/mptcp.h>
 #include <net/netfilter/nf_conntrack_bpf.h>
+#include <linux/un.h>
 
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id);
@@ -11752,6 +11753,32 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
 
 	return 0;
 }
+
+__bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
+					   const u8 *sun_path, u32 sun_path__sz)
+{
+	struct sockaddr *sa = sa_kern->uaddr;
+	struct sockaddr_un *un;
+
+	if (sa_kern->sk->sk_family != AF_UNIX)
+		return -EINVAL;
+
+	/* We do not allow changing the address of unnamed unix sockets. */
+	if (sa_kern->uaddrlen == 0)
+		return -EINVAL;
+
+	/* We do not allow changing the address to unnamed or larger than the
+	 * maximum allowed address size for a unix sockaddr.
+	 */
+	if (sun_path__sz == 0 || sun_path__sz > UNIX_PATH_MAX)
+		return -EINVAL;
+
+	un = (struct sockaddr_un *)sa;
+	memcpy(un->sun_path, sun_path, sun_path__sz);
+	sa_kern->uaddrlen = offsetof(struct sockaddr_un, sun_path) + sun_path__sz;
+
+	return 0;
+}
 __diag_pop();
 
 int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
@@ -11776,6 +11803,10 @@ BTF_SET8_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 BTF_SET8_END(bpf_kfunc_check_set_xdp)
 
+BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
+BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
+BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -11786,6 +11817,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
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
@@ -11800,7 +11836,9 @@ static int __init bpf_kfunc_init(void)
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


