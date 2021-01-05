Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9295A2EAAA3
	for <lists+bpf@lfdr.de>; Tue,  5 Jan 2021 13:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbhAEMZz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jan 2021 07:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbhAEMZw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jan 2021 07:25:52 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB93CC0617A6
        for <bpf@vger.kernel.org>; Tue,  5 Jan 2021 04:24:37 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 190so2862373wmz.0
        for <bpf@vger.kernel.org>; Tue, 05 Jan 2021 04:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZIRhmzhJTza1eg/duDC8aSWDJ8wELCNq6nzGwLtOGgE=;
        b=oM7Uaab4ruWgkghbIDEOJNIaXwqhUApJ0Q1qI8YZ7j2FgLmvh+kbEF87EClI/IK6yY
         yzjECu0tIzEYKTcKptZaeGef9Tu2KzA64wGHRRhZc93RzR6IxBp0KTOxPJULx4GwghGG
         sWD+qdT2OHiG+Pk/wZ5gUJYyoOtL2PuW+nTQwoxHRhhI3wHRR98wd0bb9UrUoZ74qBI5
         xoOzlWrzQxH6A1m8YE/qrHaW/WAzS5sUozTF1XzxT0BhELThcof6y2efIbU3iq6/RycR
         qnpBb8vk3foVmiig+dknBebuqWRau1IWgxnJfww81uTk7HSLNbG9Q68be0v5UZAIJQ3+
         8SfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZIRhmzhJTza1eg/duDC8aSWDJ8wELCNq6nzGwLtOGgE=;
        b=RArkL7S2nmObabuNW23y4BIp6/DgU+O7DY8CjUKh2jNAE0obUVLRNiNtldgt7oMlQW
         sjsZK6HXXfDjLeOHLZt7Py3vX3dQURp2D9rKe9/9ff86SJ69+Cty+li+sxRxhUJC8fvX
         gF8tKOpmFEfpqzXSbJSf37KF980sY1KYsSEzH8TMyLho+zq4QMCO4rHWUXZyueCQyrbe
         3/wT2jF0Ept71FeZ0Yqhl7mz40MkieOHydl/NVR1GWfuklQg2NEqnZWGOC/OCyM8Stq/
         F9S+zoqz07lRtozxpMN0Q7+Wc5AGwg8InA/4n8CP08pY5kkTO5ss1nmZQviIIiUbBnAn
         2N/g==
X-Gm-Message-State: AOAM533+/Eh1LBuBXKclSMTf9Rj1adUb7sG72BKXJ7Z66SW4qgaDo7em
        gGJTXRxnrC8zkEHwJYlCOl3HYA==
X-Google-Smtp-Source: ABdhPJwsZIfp2E0WD/WaUPQr2r1SKukjbwPMIEk+a83Sf+F25hCwt+3IhYcYUSeVGBgsrzC1+osq+A==
X-Received: by 2002:a1c:2288:: with SMTP id i130mr3350183wmi.78.1609849476766;
        Tue, 05 Jan 2021 04:24:36 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net. [79.183.72.147])
        by smtp.gmail.com with ESMTPSA id 138sm4242281wma.41.2021.01.05.04.24.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jan 2021 04:24:36 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     yan@daynix.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC PATCH 5/7] tun: add ioctl code TUNSETHASHPOPULATION
Date:   Tue,  5 Jan 2021 14:24:14 +0200
Message-Id: <20210105122416.16492-6-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105122416.16492-1-yuri.benditovich@daynix.com>
References: <20210105122416.16492-1-yuri.benditovich@daynix.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

User mode program calls this ioctl before loading of
BPF program to inform the tun that the BPF program has
extended functionality, i.e. sets hash value and returns
the virtqueue number in the lower 16 bits and the type
of the hash report in the upper 16 bits.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 drivers/net/tun.c           | 12 +++++++++++-
 include/uapi/linux/if_tun.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 18c1baf1a6c1..45f4f04a4a3e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -197,6 +197,7 @@ struct tun_struct {
 	struct sock_fprog	fprog;
 	/* protected by rtnl lock */
 	bool			filter_attached;
+	bool                    bpf_populates_hash;
 	u32			msg_enable;
 	spinlock_t lock;
 	struct hlist_head flows[TUN_NUM_FLOW_ENTRIES];
@@ -2765,6 +2766,7 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 
 		tun->align = NET_SKB_PAD;
 		tun->filter_attached = false;
+		tun->bpf_populates_hash = false;
 		tun->sndbuf = tfile->socket.sk->sk_sndbuf;
 		tun->rx_batched = 0;
 		RCU_INIT_POINTER(tun->steering_prog, NULL);
@@ -2997,7 +2999,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	struct net *net = sock_net(&tfile->sk);
 	struct tun_struct *tun;
 	void __user* argp = (void __user*)arg;
-	unsigned int ifindex, carrier;
+	unsigned int ifindex, carrier, populate_hash;
 	struct ifreq ifr;
 	kuid_t owner;
 	kgid_t group;
@@ -3298,6 +3300,14 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = open_related_ns(&net->ns, get_net_ns);
 		break;
 
+	case TUNSETHASHPOPULATION:
+		ret = -EFAULT;
+		if (copy_from_user(&populate_hash, argp, sizeof(populate_hash)))
+			goto unlock;
+		tun->bpf_populates_hash = !!populate_hash;
+		ret = 0;
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 454ae31b93c7..0fd43533da26 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -61,6 +61,7 @@
 #define TUNSETFILTEREBPF _IOR('T', 225, int)
 #define TUNSETCARRIER _IOW('T', 226, int)
 #define TUNGETDEVNETNS _IO('T', 227)
+#define TUNSETHASHPOPULATION _IOR('T', 228, int)
 
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
-- 
2.17.1

