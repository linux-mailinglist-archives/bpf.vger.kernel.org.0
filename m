Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E892F3AEA
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 20:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436829AbhALTnn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 14:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436825AbhALTnl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 14:43:41 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EF2C0617BF
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 11:42:12 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id a6so2970185wmc.2
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 11:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZIRhmzhJTza1eg/duDC8aSWDJ8wELCNq6nzGwLtOGgE=;
        b=d9NxmNZSQNFWQVyP7EOF6ws9upmBjMm7Uu4vcCvAagQcJvjqLbg5+r9m2RsQFFiJis
         Phmfncl8NVLjetiCUd7//m3Bmb/XboSynU2+TTlz7fnQQrc7Jpxc4hbmaw8FZqV5TH7y
         sRRNBzmxv6jAlGIonq5UpuL7dMdRW+ftT3cnGIa3N0L2U2c/1jaGnLRqD4+8bMh4rAPo
         vOvc7I+Tm890KsTLrvzdfciGgT5p7v9XHa51iZ9aT1MwsRe8bYEEqZSNxG/W4qodptly
         zpZ2A26Vz1arJqMbfke1ek2319CmQxsbEOY6yJmN8LiK+JJsd/aLYiWW1hD2hgKV/tZM
         NhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZIRhmzhJTza1eg/duDC8aSWDJ8wELCNq6nzGwLtOGgE=;
        b=NSmcWJajvWdOQfVI4uqgAt6qKHTexLuD8ArHvD8wV8yibnIXXiVkfdVw7e+Lgt95A1
         SPv1N0WhHbko71/YRFyPbUwOAylQjYdzUr1OGObU/6VIiaY2g4oq1Fvu0nsyg5E8PMwS
         fOXIpJfggp/j0wEKNdfWACZDJeEBrvpBtEnENUjEymgJt4wfZ3oCd/H9Pjol27JNjxs/
         BeiGs3xOYGvwSJijR9eZL9n8Fm9H/i9KPliKyZ8OzcBZyXNMRl09vkh0sfw5D6ySTJh6
         //zNKBAM8is4sWrHRSMVGvxqFm4FZUVhOQXu3omTULBr6Pp/sAv+YvLmFpkCZYo5JYfq
         2xOA==
X-Gm-Message-State: AOAM530MAmU9RqqZ+d1/IDuLy87K+pQx2TaWTtiD33ab8VjWUGbhYOq6
        FRylTL7WEyZGiTHVAaIOu2Qo9w==
X-Google-Smtp-Source: ABdhPJxgkunWSUTHmZ71tMmXeTXU/QgKZnSQGKYYciKcgoVgRx0jy5oBLeyU4zrM4dUfJdLaLRdw1g==
X-Received: by 2002:a7b:c45a:: with SMTP id l26mr755038wmi.91.1610480530694;
        Tue, 12 Jan 2021 11:42:10 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net. [79.183.72.147])
        by smtp.gmail.com with ESMTPSA id z63sm4885315wme.8.2021.01.12.11.42.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jan 2021 11:42:09 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     davem@davemloft.net, kuba@kernel.org, mst@redhat.com,
        jasowang@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        rdunlap@infradead.org, willemb@google.com, gustavoars@kernel.org,
        herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
        nogikh@google.com, pablo@netfilter.org, decui@microsoft.com,
        cai@lca.pw, jakub@cloudflare.com, elver@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Cc:     yan@daynix.com
Subject: [RFC PATCH 5/7] tun: add ioctl code TUNSETHASHPOPULATION
Date:   Tue, 12 Jan 2021 21:41:41 +0200
Message-Id: <20210112194143.1494-6-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112194143.1494-1-yuri.benditovich@daynix.com>
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
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

