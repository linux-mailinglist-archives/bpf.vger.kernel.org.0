Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC26EAF23
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjDUQba (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjDUQb2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:31:28 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D1114F7F
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f910ea993so254918766b.3
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094684; x=1684686684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1qUV/dG7+NVZv2qTukaomjnuJgvKWINudlvDAwyBJo=;
        b=ShukEpYuRPJ5Kkcal7f1iEvzl1xCyv5J+qWKZpHJGZhx4+bSYQF5QPdBJkf0BvwUQa
         C9+PwWTLhOcKJVD1c/+TM4HKdGXJfkpColpm13ldpMa5R98ZtOC7QuP4PJUXLsEU/jmf
         7LmA0+gy6Vjo6fM+595jQu+c4gZnxZFrNn0wwgO7TwnH/n35db7dZyeKWVVNNHZwLlYP
         XzcU9HUYD4/2jlpGMdEZZc3Lv1I52VZ7nTHOG0wEPmbJAqkG/NPqqU1k+D+Bx2DnmWqm
         m4yeg2pw9LMnR0MVKaZp9dn3XSuwPC1o2nK0+VkdPMaYI5PPhPx/oBIMFsEVEjKIUaez
         FVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094684; x=1684686684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1qUV/dG7+NVZv2qTukaomjnuJgvKWINudlvDAwyBJo=;
        b=S+AOB+xca4D4p9cKo+g4dwLpb2ZDrSq+xi2WA0x0TyEnKPaPqEQXVkcGWx5TrgI9eW
         z3zAsklkdkuwslADKAke4/1zLpjrFYvO1ZbZqaJ6+O5Na8tFEaiI+EFJn/u/lmz9l7+I
         voAptfd084L1h6reaBYDZwB51aFLTwXmdmzeibN5353qo0l+vOaaibvyDKLdB8fyM6zn
         WlTF/zC2PYqVkVFoQpaINCex2UC3Lyzb9KZjLBpsMtXgmW9MRxHztvEibHYzkTv1kf4+
         8x/tutweFal4Pj3ctJ37AbEg0o++bIhatuQ44Xm1fYfhXx2G396SyKHx1LMNSpLJYt6X
         azVQ==
X-Gm-Message-State: AAQBX9csZTeoCCIgbXpx0KADhdkyAJsD0M1QwmUJ7/QvmNWwBRNQMCfr
        J4MCB+WAnCBLDag5IJbf/W59ZROzAA8iVw==
X-Google-Smtp-Source: AKy350ZnkscX6I/5OtlHNMkQkESwbIdP9n0uAPnyDeeqAjhI8mrGqU8A7D6f/xppgBDKTcsAqG3Srw==
X-Received: by 2002:a17:906:300b:b0:951:756d:6542 with SMTP id 11-20020a170906300b00b00951756d6542mr2835934ejz.32.1682094683527;
        Fri, 21 Apr 2023 09:31:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k9-20020a170906970900b009534211cc97sm2248578ejx.159.2023.04.21.09.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:31:23 -0700 (PDT)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v3 05/10] bpf: Add bpf_sock_addr_set() to allow writing sockaddr len from bpf
Date:   Fri, 21 Apr 2023 18:27:13 +0200
Message-Id: <20230421162718.440230-6-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As prep for adding unix socket support to the cgroup sockaddr hooks,
let's add a kfunc bpf_sock_addr_set() that allows modifying the
sockaddr length from bpf. This is required to allow modifying AF_UNIX
sockaddrs correctly.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 net/core/filter.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 44fb997434ad..1c656e2d7b58 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -81,6 +81,7 @@
 #include <net/xdp.h>
 #include <net/mptcp.h>
 #include <net/netfilter/nf_conntrack_bpf.h>
+#include <linux/un.h>
 
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id);
@@ -11670,6 +11671,44 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
 
 	return 0;
 }
+
+__bpf_kfunc int bpf_sock_addr_set(struct bpf_sock_addr_kern *sa_kern,
+				  const void *addr, u32 addrlen__sz)
+{
+	const struct sockaddr *sa = addr;
+
+	if (addrlen__sz <= offsetof(struct sockaddr, sa_family))
+		return -EINVAL;
+
+	if (addrlen__sz > sizeof(struct sockaddr_storage))
+		return -EINVAL;
+
+	if (sa->sa_family != sa_kern->uaddr->sa_family)
+		return -EINVAL;
+
+	switch (sa->sa_family) {
+	case AF_INET:
+		if (addrlen__sz < sizeof(struct sockaddr_in))
+			return -EINVAL;
+		break;
+	case AF_INET6:
+		if (addrlen__sz < SIN6_LEN_RFC2133)
+			return -EINVAL;
+		break;
+	case AF_UNIX:
+		if (addrlen__sz <= offsetof(struct sockaddr_un, sun_path) ||
+		    addrlen__sz > sizeof(struct sockaddr_un))
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	memcpy(sa_kern->uaddr, sa, addrlen__sz);
+	sa_kern->uaddrlen = addrlen__sz;
+
+	return 0;
+}
 __diag_pop();
 
 int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
@@ -11694,6 +11733,10 @@ BTF_SET8_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 BTF_SET8_END(bpf_kfunc_check_set_xdp)
 
+BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
+BTF_ID_FLAGS(func, bpf_sock_addr_set)
+BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -11704,6 +11747,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
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
@@ -11717,6 +11765,8 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_IN, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
-	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
+						&bpf_kfunc_set_sock_addr);
 }
 late_initcall(bpf_kfunc_init);
-- 
2.40.0

