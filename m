Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE1031FC59
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 16:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBSPqb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 10:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBSPqZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Feb 2021 10:46:25 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A7EC06178C
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 07:44:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h98so4345242wrh.11
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 07:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLUar0GBv1kl/h4dDDbdQCty3Ws8vM15aVP5+B7vwqk=;
        b=HBZXBmP7OrpfTB9ZNXcqmBKzijoOPzo9briR/UJQVJ2pitulYDW0PtDkDJpaRrO/po
         jj7cv0B3AeI7kgXm5S5TDG/Ql4BviiFs3T4np20lgzc4zjOwM56CmKlU8IbNrhTjiVFr
         x0/UFW3alRkHtozTBzLCLE3KMkM1MAgXQgtow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLUar0GBv1kl/h4dDDbdQCty3Ws8vM15aVP5+B7vwqk=;
        b=Kvaeqy+tyvdamVgyYetr72gjaPNlq1u3Km+nf6UqP0jQfK3nGHg9vaoHauks/q1U4t
         pzH0HE20iI3o/vDr/ZvnATwqmJ0nhjzojKki3siqS7N4FOQ8+mw8rJBtpBvau7Lm1N/Z
         a7nsDMhotEs8FI5bRko+HKfpEPUZayzRQ8m99spCBKjlls86JdfSXuXOoItmCsclyYLi
         YT1dhB6XdZ9YKPZtGqAZJFq7SCARcVXiQIAhoOT298n1xuHatw1KYuyIspGbU8QuKsoC
         XFD2x6INwA0eQcM709c/AgbApfmXrdx9ZEU487ddSnVkKjiWgm+t+1KQQISZ9Iruq5e8
         IKgA==
X-Gm-Message-State: AOAM530Q9THVzj7uTH5eUDnbNBPuLSObipGpJ9ZEsgeACfzcFh40FSUJ
        Q9tZCU0aqf8QFl9uZ5GGXuxNMA==
X-Google-Smtp-Source: ABdhPJzrUPEIMi3Vc8+hHDyl9Aix09NjQEgKESGp4zNTvEDE4IFQRXBEe8yZk2MNrjhErMCsWPVh9A==
X-Received: by 2002:adf:f6c3:: with SMTP id y3mr9828784wrp.24.1613749451858;
        Fri, 19 Feb 2021 07:44:11 -0800 (PST)
Received: from antares.lan (b.3.5.8.9.a.e.c.e.a.6.2.c.1.9.b.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:b91c:26ae:cea9:853b])
        by smtp.gmail.com with ESMTPSA id v204sm12321929wmg.38.2021.02.19.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 07:44:11 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     eric.dumazet@gmail.com, daniel@iogearbox.net, ast@kernel.org,
        andrii@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 2/4] nsfs: add an ioctl to discover the network namespace cookie
Date:   Fri, 19 Feb 2021 15:43:28 +0000
Message-Id: <20210219154330.93615-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210219154330.93615-1-lmb@cloudflare.com>
References: <20210219154330.93615-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Network namespaces have a globally unique non-zero identifier aka a
cookie, in line with socket cookies. Add an ioctl to retrieve the
cookie from user space without going via BPF.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 fs/nsfs.c                 | 7 +++++++
 include/uapi/linux/nsfs.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 800c1d0eb0d0..48198a1b1685 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -11,6 +11,7 @@
 #include <linux/user_namespace.h>
 #include <linux/nsfs.h>
 #include <linux/uaccess.h>
+#include <net/net_namespace.h>
 
 #include "internal.h"
 
@@ -191,6 +192,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 	struct user_namespace *user_ns;
 	struct ns_common *ns = get_proc_ns(file_inode(filp));
 	uid_t __user *argp;
+	struct net *net_ns;
 	uid_t uid;
 
 	switch (ioctl) {
@@ -209,6 +211,11 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		argp = (uid_t __user *) arg;
 		uid = from_kuid_munged(current_user_ns(), user_ns->owner);
 		return put_user(uid, argp);
+	case NS_GET_COOKIE:
+		if (ns->ops->type != CLONE_NEWNET)
+			return -EINVAL;
+		net_ns = container_of(ns, struct net, ns);
+		return put_user(net_ns->net_cookie, (u64 __user *)arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index a0c8552b64ee..86611c2cf908 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -15,5 +15,7 @@
 #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
 /* Get owner UID (in the caller's user namespace) for a user namespace */
 #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
+/* Returns a unique non-zero identifier for a network namespace */
+#define NS_GET_COOKIE		_IO(NSIO, 0x5)
 
 #endif /* __LINUX_NSFS_H */
-- 
2.27.0

