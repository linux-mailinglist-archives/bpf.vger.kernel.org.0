Return-Path: <bpf+bounces-12235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A127F7C9983
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 16:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06148B20E6C
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 14:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B0279EF;
	Sun, 15 Oct 2023 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="kD2bkSBg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30751748C
	for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 14:18:01 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55498128
	for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 07:17:50 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c49f781855so2454345a34.3
        for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697379469; x=1697984269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke33nDzLmipl3SjRyYaM61RMA7lxXnZa/f+yQU5tzpk=;
        b=kD2bkSBghNq/T2hYpS/+oxZ4nmFIDOx2d5OGFwe4xd0xb4QQaNMZBDnOZUBio8NClX
         5kkU+58w4ozuf+5ZNbxkVilJolkY2iggu8riVS5yj4k9edM5VFyteazzSKUqHRQHk/df
         b58toKI0pGRWV1uFJFogEATh0GOr6UovIAo7EyYPaMhN7iSicVDVtNO78297q4NDBGJD
         kA+8FQPAtWx/p0r4UV1PdALCc7Lzjmqqe/BhxKVM0znwuwv33wLTLexTCiVp3kXXzFwv
         lkOoHsQDO7IubFJkHlwZNRzsBymWYHu/vf+OFJghENy3RezNTpitcdQwIBtUJkGzf+pn
         1evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697379469; x=1697984269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke33nDzLmipl3SjRyYaM61RMA7lxXnZa/f+yQU5tzpk=;
        b=pEjOEJo3DQTRlHFMyccWq15va/61C2U8IELMxDd3v7nXt2ZaoCW8qYh0AzQROK0ca6
         5u5onQ0zr828Fyb3mvBjoA1VlpaIRoniMXcPUqdoEGMWx+7kl0UO4v+tUDBZMg7IJJzK
         vUR8rgsHKR7Gh0ieIK38g1/mxlbOy/XwSKGflCA5SSS8l9OmWxwQp6kgfr/G3IkOwWct
         LjJsB1aa0nTdD3gSbc81/o5Oth0LylkckJOhcEdRQ6NfseY/4qqb5Twijr2nwAVqfI9F
         uNaToL9B3HJT4SSXKeMFDR2eaIBubm7hIRoF7FQRF7ZkKWxA9jZQB65hApLJzhND3CtE
         R/3g==
X-Gm-Message-State: AOJu0YwBs2WvvLlveJJVyQCvkzK+YWMmKOmCC/XCQlZJnl4K+6RKk5IX
	fvhD2EpwiEmFctKgNMpU7VbEyA==
X-Google-Smtp-Source: AGHT+IH7Nqw9l9pQGBIDLc7LROP4B9WO3/Rf0e7rU1BiIDInOq3e6XPZWZv49whJ5GeUl650syvp3w==
X-Received: by 2002:a05:6830:208:b0:6b8:82ed:ea2e with SMTP id em8-20020a056830020800b006b882edea2emr35127511otb.4.1697379469443;
        Sun, 15 Oct 2023 07:17:49 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id o14-20020aa7978e000000b006b5922221f4sm3556073pfp.8.2023.10.15.07.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 07:17:49 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH v2 5/7] tun: Support BPF_PROG_TYPE_VNET_HASH
Date: Sun, 15 Oct 2023 23:16:33 +0900
Message-ID: <20231015141644.260646-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015141644.260646-1-akihiko.odaki@daynix.com>
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Support BPF_PROG_TYPE_VNET_HASH with TUNSETSTEERINGEBPF ioctl to make
it possible to report hash values and types when steering packets.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tun.c | 158 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 117 insertions(+), 41 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 89ab9efe522c..e0b453572a64 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -543,19 +543,37 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 
 static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 {
+	struct bpf_skb_vnet_hash_end *cb = (struct bpf_skb_vnet_hash_end *)skb->cb;
+	struct tun_vnet_hash *ext;
 	struct tun_prog *prog;
 	u32 numqueues;
-	u16 ret = 0;
+	u16 queue = 0;
+
+	BUILD_BUG_ON(sizeof(*cb) > sizeof(skb->cb));
 
 	numqueues = READ_ONCE(tun->numqueues);
 	if (!numqueues)
 		return 0;
 
 	prog = rcu_dereference(tun->steering_prog);
-	if (prog)
-		ret = bpf_prog_run_clear_cb(prog->prog, skb);
+	if (prog) {
+		if (prog->prog->type == BPF_PROG_TYPE_VNET_HASH) {
+			memset(skb->cb, 0, sizeof(*cb) - sizeof(struct qdisc_skb_cb));
+			bpf_prog_run_clear_cb(prog->prog, skb);
+
+			ext = skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
+			if (ext) {
+				ext->value = cb->hash_value;
+				ext->report = cb->hash_report;
+			}
 
-	return ret % numqueues;
+			queue = cb->rss_queue;
+		} else {
+			queue = bpf_prog_run_clear_cb(prog->prog, skb);
+		}
+	}
+
+	return queue % numqueues;
 }
 
 static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
@@ -2116,31 +2134,74 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	}
 
 	if (vnet_hdr_sz) {
-		struct virtio_net_hdr gso;
+		struct bpf_skb_vnet_hash_end *cb = (struct bpf_skb_vnet_hash_end *)skb->cb;
+		struct tun_prog *prog;
+		struct tun_vnet_hash *vnet_hash_p;
+		struct tun_vnet_hash vnet_hash;
+		size_t vnet_hdr_content_sz = sizeof(struct virtio_net_hdr);
+		union {
+			struct virtio_net_hdr hdr;
+			struct virtio_net_hdr_v1_hash hdr_v1_hash;
+		} vnet_hdr;
+		int ret;
 
 		if (iov_iter_count(iter) < vnet_hdr_sz)
 			return -EINVAL;
 
-		if (virtio_net_hdr_from_skb(skb, &gso,
-					    tun_is_little_endian(tun), true,
-					    vlan_hlen)) {
+		if (vnet_hdr_sz >= sizeof(struct virtio_net_hdr_v1_hash)) {
+			vnet_hash_p = skb_ext_find(skb, SKB_EXT_TUN_VNET_HASH);
+			if (vnet_hash_p) {
+				vnet_hash = *vnet_hash_p;
+				vnet_hdr_content_sz = sizeof(struct virtio_net_hdr_v1_hash);
+			} else {
+				rcu_read_lock();
+				prog = rcu_dereference(tun->steering_prog);
+				if (prog && prog->prog->type == BPF_PROG_TYPE_VNET_HASH) {
+					memset(skb->cb, 0,
+					       sizeof(*cb) - sizeof(struct qdisc_skb_cb));
+					bpf_prog_run_clear_cb(prog->prog, skb);
+					vnet_hash.value = cb->hash_value;
+					vnet_hash.report = cb->hash_report;
+					vnet_hdr_content_sz =
+						sizeof(struct virtio_net_hdr_v1_hash);
+				}
+				rcu_read_unlock();
+			}
+		}
+
+		switch (vnet_hdr_content_sz) {
+		case sizeof(struct virtio_net_hdr):
+			ret = virtio_net_hdr_from_skb(skb, &vnet_hdr.hdr,
+						      tun_is_little_endian(tun), true,
+						      vlan_hlen);
+			break;
+
+		case sizeof(struct virtio_net_hdr_v1_hash):
+			ret = virtio_net_hdr_v1_hash_from_skb(skb, &vnet_hdr.hdr_v1_hash,
+							      tun_is_little_endian(tun), true,
+							      vlan_hlen,
+							      vnet_hash.value, vnet_hash.report);
+			break;
+		}
+
+		if (ret) {
 			struct skb_shared_info *sinfo = skb_shinfo(skb);
 			pr_err("unexpected GSO type: "
 			       "0x%x, gso_size %d, hdr_len %d\n",
-			       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
-			       tun16_to_cpu(tun, gso.hdr_len));
+			       sinfo->gso_type, tun16_to_cpu(tun, vnet_hdr.hdr.gso_size),
+			       tun16_to_cpu(tun, vnet_hdr.hdr.hdr_len));
 			print_hex_dump(KERN_ERR, "tun: ",
 				       DUMP_PREFIX_NONE,
 				       16, 1, skb->head,
-				       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+				       min((int)tun16_to_cpu(tun, vnet_hdr.hdr.hdr_len), 64), true);
 			WARN_ON_ONCE(1);
 			return -EINVAL;
 		}
 
-		if (copy_to_iter(&gso, sizeof(gso), iter) != sizeof(gso))
+		if (copy_to_iter(&vnet_hdr, vnet_hdr_content_sz, iter) != vnet_hdr_content_sz)
 			return -EFAULT;
 
-		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
+		iov_iter_advance(iter, vnet_hdr_sz - vnet_hdr_content_sz);
 	}
 
 	if (vlan_hlen) {
@@ -2276,13 +2337,13 @@ static void tun_prog_free(struct rcu_head *rcu)
 {
 	struct tun_prog *prog = container_of(rcu, struct tun_prog, rcu);
 
-	bpf_prog_destroy(prog->prog);
+	bpf_prog_put(prog->prog);
 	kfree(prog);
 }
 
-static int __tun_set_ebpf(struct tun_struct *tun,
-			  struct tun_prog __rcu **prog_p,
-			  struct bpf_prog *prog)
+static int tun_set_ebpf(struct tun_struct *tun,
+			struct tun_prog __rcu **prog_p,
+			struct bpf_prog *prog)
 {
 	struct tun_prog *old, *new = NULL;
 
@@ -2314,8 +2375,8 @@ static void tun_free_netdev(struct net_device *dev)
 	free_percpu(dev->tstats);
 	tun_flow_uninit(tun);
 	security_tun_dev_free_security(tun->security);
-	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
-	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
+	tun_set_ebpf(tun, &tun->steering_prog, NULL);
+	tun_set_ebpf(tun, &tun->filter_prog, NULL);
 }
 
 static void tun_setup(struct net_device *dev)
@@ -3007,26 +3068,6 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
 	return ret;
 }
 
-static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
-			void __user *data)
-{
-	struct bpf_prog *prog;
-	int fd;
-
-	if (copy_from_user(&fd, data, sizeof(fd)))
-		return -EFAULT;
-
-	if (fd == -1) {
-		prog = NULL;
-	} else {
-		prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SOCKET_FILTER);
-		if (IS_ERR(prog))
-			return PTR_ERR(prog);
-	}
-
-	return __tun_set_ebpf(tun, prog_p, prog);
-}
-
 /* Return correct value for tun->dev->addr_len based on tun->dev->type. */
 static unsigned char tun_get_addr_len(unsigned short type)
 {
@@ -3077,6 +3118,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	struct ifreq ifr;
 	kuid_t owner;
 	kgid_t group;
+	struct bpf_prog *prog;
+	int fd;
 	int sndbuf;
 	int vnet_hdr_sz;
 	int le;
@@ -3360,11 +3403,44 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	case TUNSETSTEERINGEBPF:
-		ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
+		if (copy_from_user(&fd, argp, sizeof(fd))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		if (fd == -1) {
+			prog = NULL;
+		} else {
+			prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_VNET_HASH);
+			if (IS_ERR(prog)) {
+				prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SOCKET_FILTER);
+				if (IS_ERR(prog)) {
+					ret = PTR_ERR(prog);
+					break;
+				}
+			}
+		}
+
+		ret = tun_set_ebpf(tun, &tun->steering_prog, prog);
 		break;
 
 	case TUNSETFILTEREBPF:
-		ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
+		if (copy_from_user(&fd, argp, sizeof(fd))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		if (fd == -1) {
+			prog = NULL;
+		} else {
+			prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SOCKET_FILTER);
+			if (IS_ERR(prog)) {
+				ret = PTR_ERR(prog);
+				break;
+			}
+		}
+
+		ret = tun_set_ebpf(tun, &tun->filter_prog, prog);
 		break;
 
 	case TUNSETCARRIER:
-- 
2.42.0


