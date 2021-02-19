Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5931F6D6
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 10:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBSJyM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 04:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhBSJxv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Feb 2021 04:53:51 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71B8C06178B
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 01:52:15 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o82so6490440wme.1
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 01:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sEgT8c4oZnUxglFmZCEU+sDrUl3YaIldCLk4AxLlgKg=;
        b=fnPyns3lbkPFdMhBxQ2qbAZtgWqeBcQShhGC1X/uOnDBBIl17kF2dBJO5dKLwrHUg+
         HROEiqPQB9eIC+TvA3f11T58VD7kvIdenFU+taAl0BSOv3pt2egK7trj8GBYS5DDy5N/
         3G/qpMMLvOIqM3ukKW0qaaISeDHFsIP9rivaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEgT8c4oZnUxglFmZCEU+sDrUl3YaIldCLk4AxLlgKg=;
        b=AqaIHW3sS9MesPbixKMNC56cnG/0t8qVaQPTTSDAdMQ7o6vbbvFJN91RdO2FlzB3Ks
         hFMiooPtN1DKassqD6mbiosUUDPUeMRkcnRKVU85foa5YTLTPHJHVt0pCKs3TBwlgQ9B
         3CAHDta2UHh+C0QppwRjlqvI0IzXMzalHieXfRzdDIAxCHuA6SRxZNPJGNgyn5YdrXCV
         dA3VEfL6OKL8YlFcAzSPtgT4Ga+dBuQb085a+aAZXDzbzSPYLskEHLbZ90UlTXxK3MyR
         rQEPRWsCieix9TTSwfBSrQFYrzLdGSOg2/YjwhIIbNJKFE4KNPuijhZVpv0VUFIFEZ4a
         2AgA==
X-Gm-Message-State: AOAM5317B8Q5bRdYnnvv/32eB2E0KT95dNX1XMlhrwksPINFa9juNAyV
        k4qACOmaCyw3FvPK8dkXTWztCg==
X-Google-Smtp-Source: ABdhPJx81zveBGfFzqcue+zDv5fRej1c7E5XmkxDnLS8Hig1VlCDAL5D+SVN67ultnWErC/IYYUZRQ==
X-Received: by 2002:a1c:c3c5:: with SMTP id t188mr7254113wmf.167.1613728334418;
        Fri, 19 Feb 2021 01:52:14 -0800 (PST)
Received: from antares.lan (b.3.5.8.9.a.e.c.e.a.6.2.c.1.9.b.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:b91c:26ae:cea9:853b])
        by smtp.gmail.com with ESMTPSA id a21sm13174910wmb.5.2021.02.19.01.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 01:52:14 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 2/4] nsfs: add an ioctl to discover the network namespace cookie
Date:   Fri, 19 Feb 2021 09:51:47 +0000
Message-Id: <20210219095149.50346-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210219095149.50346-1-lmb@cloudflare.com>
References: <20210219095149.50346-1-lmb@cloudflare.com>
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
 fs/nsfs.c                 | 8 ++++++++
 include/uapi/linux/nsfs.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 800c1d0eb0d0..b7e70ab80257 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -11,6 +11,7 @@
 #include <linux/user_namespace.h>
 #include <linux/nsfs.h>
 #include <linux/uaccess.h>
+#include <net/net_namespace.h>
 
 #include "internal.h"
 
@@ -191,6 +192,8 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 	struct user_namespace *user_ns;
 	struct ns_common *ns = get_proc_ns(file_inode(filp));
 	uid_t __user *argp;
+	struct net *net_ns;
+	u64 cookie;
 	uid_t uid;
 
 	switch (ioctl) {
@@ -209,6 +212,11 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
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

