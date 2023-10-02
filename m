Return-Path: <bpf+bounces-11191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F1E7B5316
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 14:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C593A2840E1
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 12:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D9C18C34;
	Mon,  2 Oct 2023 12:28:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C2415499;
	Mon,  2 Oct 2023 12:28:13 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C30D8;
	Mon,  2 Oct 2023 05:28:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so22167431a12.1;
        Mon, 02 Oct 2023 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696249690; x=1696854490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUgLd6uCTGmXiwt74h6Tnr+Ni8w2bJDpoH4TYmPjHoc=;
        b=JGL/HemztVYfv6pskCTrLoQIZKxlghX7hWVPbddXpymCCqmqk/jwhT9fcT0SWQVEjZ
         BbA9n7qa1hYNjSfoU+j/LIdspsupsTvgbTkuoC0jYfStiqRIWr5qeprkVDEuZnkmKvxC
         ApFLxfKMYG0Y71+Yo72d7pcJmbLIzwIFJIIiFaIGeTbQNrDwA3NuRB2T0BULXqaAGewp
         oqwHePCbY+dsftMtEbLcSMUcQptDlUfKiAkpvRyhqwNM09s5OZgxFxfFd1Mc0p9xgENz
         Al9j7CDuuC+ExpXZ9j9rxKkvsllyHhUWxWyZca909B7cPZ/Lox0r0wsOQJP32e6RX1ZM
         pfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696249690; x=1696854490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUgLd6uCTGmXiwt74h6Tnr+Ni8w2bJDpoH4TYmPjHoc=;
        b=bDW/fVL42K1Is+yW+wERXB9ZAAB+DwDMXtHdN90Wh859n4GmXdbZIqQ2ggJEF8pGq1
         jsbZJq1TsC8MOXNlmq5p1/qVgCMHDq+u3V7ie2m36zJ0GFszDvwfosyZrtYlJM6rgRFn
         2SU1XE1npDMhMkNf0/RoM70V1nPM10b4HoXeReU3HJsdxyXRq3quQJNLnO7k4JsS469l
         iVP9aVrRZaDSXOF9ls+uhGs8ldTnuVVaHQ2hbnI9prPT2AvCE4l29IDVw73SVZidJPlB
         2z8XJii5rC4QnIB4epjq3p86nIIjuLFAoFiekTEOie0vZRs9GHApdqgNj1ci3SpGfixJ
         I9IQ==
X-Gm-Message-State: AOJu0YwT9JUgWX7dxx6l0xMDWlqMi8YpWXlfPQSE5l8lQ8rS3U9t0uur
	27OH+IkkOhy9x6XdFSPZfbZErIVsIXop4+C+
X-Google-Smtp-Source: AGHT+IE6l0I51CtZjvffcxh4/4yQOKNbmAJYOofdV7hqWMhQkNQYtRXdeTjM1Pal15EFgJrnsvAyeA==
X-Received: by 2002:a05:6402:24a0:b0:538:53f9:44d1 with SMTP id q32-20020a05640224a000b0053853f944d1mr3024275eda.11.1696249690200;
        Mon, 02 Oct 2023 05:28:10 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-aa0d-0bb2-d029-8797.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:aa0d:bb2:d029:8797])
        by smtp.googlemail.com with ESMTPSA id v10-20020aa7dbca000000b005330b2d1904sm15263099edt.71.2023.10.02.05.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:28:09 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v7 3/9] bpf: Add bpf_sock_addr_set_unix_addr() to allow writing unix sockaddr from bpf
Date: Mon,  2 Oct 2023 14:27:49 +0200
Message-ID: <20231002122756.323591-4-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002122756.323591-1-daan.j.demeyer@gmail.com>
References: <20231002122756.323591-1-daan.j.demeyer@gmail.com>
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


