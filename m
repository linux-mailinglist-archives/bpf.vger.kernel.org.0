Return-Path: <bpf+bounces-8899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3250F78C238
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 12:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9791C209EA
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C6014F97;
	Tue, 29 Aug 2023 10:19:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12CC14F72
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 10:19:24 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE811BC
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:18 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50087d47d4dso6749441e87.1
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693304356; x=1693909156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO6GmuvSkO9b2OQ3rGX39zt1s0mpJ9lgcIC57zptS6Y=;
        b=Y4JQyzuLTxCxYuGHBQdmlsp3DaGL6LGqQupYLBe8mdBkm2nRjhRq4SWou+Dh6xdXZl
         VHyaQH/GRoQQneg7DeYZko8sJbnj2vlmwQkPMKw7w+q9XM/yeTH+mD4MwgeIC1iPX2rz
         eWeSCZhm+6gdcBPNEhW40YoFAWx6581SVxyeD5RIzegV0aXk2gYR9eMvlAPWUd8Adlj4
         Nn9/NMO+1YYdhsxzTQveE8JKkx3MeJEi9JhDxAc/vbLcF72xrH60NARzyXb/rUU62108
         LOJSfr4GQ/XxA6vt3V00So6oS7L1I8B6lE+uxFsy5Wtn8tFyce4KdQMqdGeGCKu0faAp
         mLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693304356; x=1693909156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO6GmuvSkO9b2OQ3rGX39zt1s0mpJ9lgcIC57zptS6Y=;
        b=bF957/OdmC6nIkaj83A32rwdo3eBVwnPVf/ecDqcUlzYpcPq89DRVjwfH3lekNAepi
         Ov6QWyMLvAY4gGKcq7sFmYzijDLTWKZ2uM/NigWb4vKcQxir43uJkSLsskgpHGKBFwzf
         e04CkDTZ93iz8fKj4WMVfXZag0W7fUODH16fxM5C8lvVJ2h8AgNmG9jmLyAVplKlOgcX
         2I2Lf5CqyXBPxAh4dEuNm3eblNkZYgSXh9Wm4uxwb88GWxuXQY/8vbQZfB0akZUaeIae
         ibQQgpaLL3p75gvvP7DvWUsbCNOu2mxKo8elm+dw63nzVpyePsdJnqWTcvHrXmxga/ss
         5ftQ==
X-Gm-Message-State: AOJu0Yyn2H+8Cp4srTXB0jJWFRhgxIC/km099nqUME8wQlq1ThZckqRg
	2rKZJoIFiSV0bf0Klf4JpQFG8hePXOi3ISmYylc=
X-Google-Smtp-Source: AGHT+IFGjMrWpqtk0+XiB4IMHqvfJJ4n3PVVt+N2pWNDL9x5lYG7Bkwh/nk5aj7r7FvczUFQWgkzZg==
X-Received: by 2002:a05:6512:1288:b0:500:c4f1:6bb6 with SMTP id u8-20020a056512128800b00500c4f16bb6mr846956lfs.61.1693304355535;
        Tue, 29 Aug 2023 03:19:15 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-67a4-023c-67c4-b186.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:67a4:23c:67c4:b186])
        by smtp.googlemail.com with ESMTPSA id f15-20020a50ee8f000000b0051e2670d599sm5545606edr.4.2023.08.29.03.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 03:19:15 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 3/9] bpf: Add bpf_sock_addr_set() to allow writing sockaddr len from bpf
Date: Tue, 29 Aug 2023 12:18:27 +0200
Message-ID: <20230829101838.851350-4-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
References: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
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
let's add a kfunc bpf_sock_addr_set() that allows modifying a sockaddr
from bpf. While this is already possible for AF_INET and AF_INET6, we'll
need this kfunc when we add unix socket support since modifying the
address for those requires modifying both the address and the sockaddr
length.

We also add the necessary hook to make the new kfunc work properly.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 kernel/bpf/btf.c  |  3 +++
 net/core/filter.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 249657c466dd..157342eaa2bb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -217,6 +217,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_SOCKET_FILTER,
 	BTF_KFUNC_HOOK_LWT,
 	BTF_KFUNC_HOOK_NETFILTER,
+	BTF_KFUNC_HOOK_SOCK_ADDR,
 	BTF_KFUNC_HOOK_MAX,
 };
 
@@ -7846,6 +7847,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_LWT;
 	case BPF_PROG_TYPE_NETFILTER:
 		return BTF_KFUNC_HOOK_NETFILTER;
+	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+		return BTF_KFUNC_HOOK_SOCK_ADDR;
 	default:
 		return BTF_KFUNC_HOOK_MAX;
 	}
diff --git a/net/core/filter.c b/net/core/filter.c
index a094694899c9..c58c3cd2cd55 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11752,6 +11752,35 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
 
 	return 0;
 }
+
+__bpf_kfunc int bpf_sock_addr_set_addr(struct bpf_sock_addr_kern *sa_kern,
+				       const u8 *addr, u32 addrlen__sz)
+{
+	struct sockaddr *sa = sa_kern->uaddr;
+	struct sockaddr_in *sa4;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_un *un;
+
+	switch (sa->sa_family) {
+	case AF_INET:
+		if (addrlen__sz != 4)
+			return -EINVAL;
+		sa4 = (struct sockaddr_in *)sa;
+		sa4->sin_addr.s_addr = *(__be32 *)addr;
+		break;
+	case AF_INET6:
+		if (addrlen__sz != 16)
+			return -EINVAL;
+		sa6 = (struct sockaddr_in6 *)sa;
+		memcpy(sa6->sin6_addr.s6_addr, addr, 16);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
 __diag_pop();
 
 int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
@@ -11776,6 +11805,10 @@ BTF_SET8_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 BTF_SET8_END(bpf_kfunc_check_set_xdp)
 
+BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
+BTF_ID_FLAGS(func, bpf_sock_addr_set_addr)
+BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -11786,6 +11819,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
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
@@ -11800,7 +11838,9 @@ static int __init bpf_kfunc_init(void)
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


