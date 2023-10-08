Return-Path: <bpf+bounces-11657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2229C7BCC50
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 07:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB349281F07
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 05:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684B3440A;
	Sun,  8 Oct 2023 05:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="beWt45x9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CEF3D67
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 05:22:46 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3193D8
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 22:22:41 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso2601035b3a.0
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 22:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696742561; x=1697347361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNEYNcUIQ02Z47r7DMDdtClBgN2jorlreZmQMyrQ9r0=;
        b=beWt45x9XHhiZftn0IA9xjbSV2VX0nxSvGuDTo5NHegCwVpmWmV4boT3C6I3sfTYFx
         IwGg4740mYSy5vGofP6VuuA+25nr/rWU9BOALEwX/40ZnzTZqnT8Axg0XlhT9In9Xclz
         ZNyEGuJcnOuqnhdatsIviQlbwtLpTQVzwz/9cMV1dnvroh9TvlBCRvQ/HNcaLvP20dRj
         Sy53YEFoJXy0h+a9QRWNct32qmlkekzMC3YUN/jdUK/MQwap+t//40cYz6ywLrn8JfIi
         l8XcZ7dd+neDl4lIpfaMkUHpV6REbx73VBW+j03gbnpEDpW6PcSLUsdJkM3WKBmAgEu+
         2IYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696742561; x=1697347361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNEYNcUIQ02Z47r7DMDdtClBgN2jorlreZmQMyrQ9r0=;
        b=kng+lRNRMcBKuZLXnpEXKPvEKVpFtFkBuoh+JxMSS1EYzlmY8tGxHJT/90KWkX/jFw
         bcI978hiZ7Qocj1dhAbNYZv5FYg9DvkD2C/xsHYR5C5y8pCOL6TN7uHe1IpdChyGug48
         2IFs4X20MqihSoymcy8RYuNJM9S+tQpfT82j5eW89kVjjs8xO2WXw4jB7FtaYJ+0OTFW
         0kRYPhrbc5w1mnQsfJOTB55zK/hc6s23lw0Ch0aSH5h7fqERvt5NW+BKBd+GFvF1nZmo
         PKtOUGgX3G1/e3Z/vPKQLtxzJX1pKNDXnlAJgbGZYi0E99+XvFy1yoHnz+Jkv4gTUamw
         V6+g==
X-Gm-Message-State: AOJu0YzuPtQAdOXN4vYJsFtSt/s/PEUgYEKrH9ptishOBPhNUhleNKBO
	LfJj4/vwdGSOspWDxLBr+0gRSA==
X-Google-Smtp-Source: AGHT+IGY5tnRnPz8E+W9dEDOenN+gDxxh23v4PsChY6hQrk8ypyfQ6NhuytLuwAbjEnGq6UL78YBoQ==
X-Received: by 2002:a05:6a00:1ad1:b0:68f:d44c:22f8 with SMTP id f17-20020a056a001ad100b0068fd44c22f8mr12614847pfv.1.1696742561319;
        Sat, 07 Oct 2023 22:22:41 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id j20-20020a62b614000000b0068fe5a5a566sm4054525pff.142.2023.10.07.22.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 22:22:41 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo Shuah Khan <"xuanzhuo@linux.alibaba.comshuah"@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
	gustavoars@kernel.org, herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com, nogikh@google.com, pablo@netfilter.org,
	decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com,
	elver@google.com, pabeni@redhat.com,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
Date: Sun,  8 Oct 2023 14:20:49 +0900
Message-ID: <20231008052101.144422-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008052101.144422-1-akihiko.odaki@daynix.com>
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
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

virtio-net have two usage of hashes: one is RSS and another is hash
reporting. Conventionally the hash calculation was done by the VMM.
However, computing the hash after the queue was chosen defeats the
purpose of RSS.

Another approach is to use eBPF steering program. This approach has
another downside: it cannot report the calculated hash due to the
restrictive nature of eBPF.

Introduce the code to compute hashes to the kernel in order to overcome
thse challenges. An alternative solution is to extend the eBPF steering
program so that it will be able to report to the userspace, but it makes
little sense to allow to implement different hashing algorithms with
eBPF since the hash value reported by virtio-net is strictly defined by
the specification.

The hash value already stored in sk_buff is not used and computed
independently since it may have been computed in a way not conformant
with the specification.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tun.c           | 187 ++++++++++++++++++++++++++++++++----
 include/uapi/linux/if_tun.h |  16 +++
 2 files changed, 182 insertions(+), 21 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 89ab9efe522c..561a573cd008 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -171,6 +171,9 @@ struct tun_prog {
 	struct bpf_prog *prog;
 };
 
+#define TUN_VNET_HASH_MAX_KEY_SIZE 40
+#define TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH 128
+
 /* Since the socket were moved to tun_file, to preserve the behavior of persist
  * device, socket filter, sndbuf and vnet header size were restore when the
  * file were attached to a persist device.
@@ -209,6 +212,9 @@ struct tun_struct {
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
 	struct ethtool_link_ksettings link_ksettings;
+	struct tun_vnet_hash vnet_hash;
+	u16 vnet_hash_indirection_table[TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH];
+	u32 vnet_hash_key[TUN_VNET_HASH_MAX_KEY_SIZE / 4];
 	/* init args */
 	struct file *file;
 	struct ifreq *ifr;
@@ -219,6 +225,13 @@ struct veth {
 	__be16 h_vlan_TCI;
 };
 
+static const struct tun_vnet_hash_cap tun_vnet_hash_cap = {
+	.max_indirection_table_length =
+		TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH,
+
+	.types = VIRTIO_NET_SUPPORTED_HASH_TYPES
+};
+
 static void tun_flow_init(struct tun_struct *tun);
 static void tun_flow_uninit(struct tun_struct *tun);
 
@@ -320,10 +333,16 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 	if (get_user(be, argp))
 		return -EFAULT;
 
-	if (be)
+	if (be) {
+		if (!(tun->flags & TUN_VNET_LE) &&
+		    (tun->vnet_hash.flags & TUN_VNET_HASH_REPORT)) {
+			return -EINVAL;
+		}
+
 		tun->flags |= TUN_VNET_BE;
-	else
+	} else {
 		tun->flags &= ~TUN_VNET_BE;
+	}
 
 	return 0;
 }
@@ -558,15 +577,47 @@ static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 	return ret % numqueues;
 }
 
+static u16 tun_vnet_select_queue(struct tun_struct *tun, struct sk_buff *skb)
+{
+	u32 value = qdisc_skb_cb(skb)->tun_vnet_hash_value;
+	u32 numqueues;
+	u32 index;
+	u16 queue;
+
+	numqueues = READ_ONCE(tun->numqueues);
+	if (!numqueues)
+		return 0;
+
+	index = value & READ_ONCE(tun->vnet_hash.indirection_table_mask);
+	queue = READ_ONCE(tun->vnet_hash_indirection_table[index]);
+	if (!queue)
+		queue = READ_ONCE(tun->vnet_hash.unclassified_queue);
+
+	return queue % numqueues;
+}
+
 static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 			    struct net_device *sb_dev)
 {
 	struct tun_struct *tun = netdev_priv(dev);
+	u8 vnet_hash_flags = READ_ONCE(tun->vnet_hash.flags);
+	struct virtio_net_hash hash;
 	u16 ret;
 
+	if (vnet_hash_flags & (TUN_VNET_HASH_RSS | TUN_VNET_HASH_REPORT)) {
+		virtio_net_hash(skb, READ_ONCE(tun->vnet_hash.types),
+				tun->vnet_hash_key, &hash);
+
+		skb->tun_vnet_hash = true;
+		qdisc_skb_cb(skb)->tun_vnet_hash_value = hash.value;
+		qdisc_skb_cb(skb)->tun_vnet_hash_report = hash.report;
+	}
+
 	rcu_read_lock();
 	if (rcu_dereference(tun->steering_prog))
 		ret = tun_ebpf_select_queue(tun, skb);
+	else if (vnet_hash_flags & TUN_VNET_HASH_RSS)
+		ret = tun_vnet_select_queue(tun, skb);
 	else
 		ret = tun_automq_select_queue(tun, skb);
 	rcu_read_unlock();
@@ -2088,10 +2139,15 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 			    struct iov_iter *iter)
 {
 	struct tun_pi pi = { 0, skb->protocol };
+	struct virtio_net_hash vnet_hash = {
+		.value = qdisc_skb_cb(skb)->tun_vnet_hash_value,
+		.report = qdisc_skb_cb(skb)->tun_vnet_hash_report
+	};
 	ssize_t total;
 	int vlan_offset = 0;
 	int vlan_hlen = 0;
 	int vnet_hdr_sz = 0;
+	size_t vnet_hdr_content_sz;
 
 	if (skb_vlan_tag_present(skb))
 		vlan_hlen = VLAN_HLEN;
@@ -2116,31 +2172,49 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	}
 
 	if (vnet_hdr_sz) {
-		struct virtio_net_hdr gso;
+		union {
+			struct virtio_net_hdr hdr;
+			struct virtio_net_hdr_v1_hash v1_hash_hdr;
+		} hdr;
+		int ret;
 
 		if (iov_iter_count(iter) < vnet_hdr_sz)
 			return -EINVAL;
 
-		if (virtio_net_hdr_from_skb(skb, &gso,
-					    tun_is_little_endian(tun), true,
-					    vlan_hlen)) {
+		if ((READ_ONCE(tun->vnet_hash.flags) & TUN_VNET_HASH_REPORT) &&
+		    vnet_hdr_sz >= sizeof(hdr.v1_hash_hdr) &&
+		    skb->tun_vnet_hash) {
+			vnet_hdr_content_sz = sizeof(hdr.v1_hash_hdr);
+			ret = virtio_net_hdr_v1_hash_from_skb(skb,
+							      &hdr.v1_hash_hdr,
+							      true,
+							      vlan_hlen,
+							      &vnet_hash);
+		} else {
+			vnet_hdr_content_sz = sizeof(hdr.hdr);
+			ret = virtio_net_hdr_from_skb(skb, &hdr.hdr,
+						      tun_is_little_endian(tun),
+						      true, vlan_hlen);
+		}
+
+		if (ret) {
 			struct skb_shared_info *sinfo = skb_shinfo(skb);
 			pr_err("unexpected GSO type: "
 			       "0x%x, gso_size %d, hdr_len %d\n",
-			       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
-			       tun16_to_cpu(tun, gso.hdr_len));
+			       sinfo->gso_type, tun16_to_cpu(tun, hdr.hdr.gso_size),
+			       tun16_to_cpu(tun, hdr.hdr.hdr_len));
 			print_hex_dump(KERN_ERR, "tun: ",
 				       DUMP_PREFIX_NONE,
 				       16, 1, skb->head,
-				       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+				       min((int)tun16_to_cpu(tun, hdr.hdr.hdr_len), 64), true);
 			WARN_ON_ONCE(1);
 			return -EINVAL;
 		}
 
-		if (copy_to_iter(&gso, sizeof(gso), iter) != sizeof(gso))
+		if (copy_to_iter(&hdr, vnet_hdr_content_sz, iter) != vnet_hdr_content_sz)
 			return -EFAULT;
 
-		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
+		iov_iter_advance(iter, vnet_hdr_sz - vnet_hdr_content_sz);
 	}
 
 	if (vlan_hlen) {
@@ -3007,24 +3081,27 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
 	return ret;
 }
 
-static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
-			void __user *data)
+static struct bpf_prog *tun_set_ebpf(struct tun_struct *tun,
+				     struct tun_prog __rcu **prog_p,
+				     void __user *data)
 {
 	struct bpf_prog *prog;
 	int fd;
+	int ret;
 
 	if (copy_from_user(&fd, data, sizeof(fd)))
-		return -EFAULT;
+		return ERR_PTR(-EFAULT);
 
 	if (fd == -1) {
 		prog = NULL;
 	} else {
 		prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SOCKET_FILTER);
 		if (IS_ERR(prog))
-			return PTR_ERR(prog);
+			return prog;
 	}
 
-	return __tun_set_ebpf(tun, prog_p, prog);
+	ret = __tun_set_ebpf(tun, prog_p, prog);
+	return ret ? ERR_PTR(ret) : prog;
 }
 
 /* Return correct value for tun->dev->addr_len based on tun->dev->type. */
@@ -3082,6 +3159,11 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	int le;
 	int ret;
 	bool do_notify = false;
+	struct bpf_prog *bpf_ret;
+	struct tun_vnet_hash vnet_hash;
+	u16 vnet_hash_indirection_table[TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH];
+	u8 vnet_hash_key[TUN_VNET_HASH_MAX_KEY_SIZE];
+	size_t len;
 
 	if (cmd == TUNSETIFF || cmd == TUNSETQUEUE ||
 	    (_IOC_TYPE(cmd) == SOCK_IOC_TYPE && cmd != SIOCGSKNS)) {
@@ -3295,7 +3377,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			ret = -EFAULT;
 			break;
 		}
-		if (vnet_hdr_sz < (int)sizeof(struct virtio_net_hdr)) {
+		if (vnet_hdr_sz <
+		    (int)((tun->vnet_hash.flags & TUN_VNET_HASH_REPORT) ?
+			  sizeof(struct virtio_net_hdr_v1_hash) :
+			  sizeof(struct virtio_net_hdr))) {
 			ret = -EINVAL;
 			break;
 		}
@@ -3314,10 +3399,16 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			ret = -EFAULT;
 			break;
 		}
-		if (le)
+		if (le) {
 			tun->flags |= TUN_VNET_LE;
-		else
+		} else {
+			if (!tun_legacy_is_little_endian(tun)) {
+				ret = -EINVAL;
+				break;
+			}
+
 			tun->flags &= ~TUN_VNET_LE;
+		}
 		break;
 
 	case TUNGETVNETBE:
@@ -3360,11 +3451,17 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	case TUNSETSTEERINGEBPF:
-		ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
+		bpf_ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
+		if (IS_ERR(bpf_ret))
+			ret = PTR_ERR(bpf_ret);
+		else if (bpf_ret)
+			tun->vnet_hash.flags &= ~TUN_VNET_HASH_RSS;
 		break;
 
 	case TUNSETFILTEREBPF:
-		ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
+		bpf_ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
+		if (IS_ERR(bpf_ret))
+			ret = PTR_ERR(bpf_ret);
 		break;
 
 	case TUNSETCARRIER:
@@ -3382,6 +3479,54 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = open_related_ns(&net->ns, get_net_ns);
 		break;
 
+	case TUNGETVNETHASHCAP:
+		if (copy_to_user(argp, &tun_vnet_hash_cap,
+				 sizeof(tun_vnet_hash_cap)))
+			ret = -EFAULT;
+		break;
+
+	case TUNSETVNETHASH:
+		len = sizeof(vnet_hash);
+		if (copy_from_user(&vnet_hash, argp, len)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		if (((vnet_hash.flags & TUN_VNET_HASH_REPORT) &&
+		     (tun->vnet_hdr_sz < sizeof(struct virtio_net_hdr_v1_hash) ||
+		      !tun_is_little_endian(tun))) ||
+		     vnet_hash.indirection_table_mask >=
+		     TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH) {
+			ret = -EINVAL;
+			break;
+		}
+
+		argp = (u8 __user *)argp + len;
+		len = (vnet_hash.indirection_table_mask + 1) * 2;
+		if (copy_from_user(vnet_hash_indirection_table, argp, len)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		argp = (u8 __user *)argp + len;
+		len = virtio_net_hash_key_length(vnet_hash.types);
+
+		if (copy_from_user(vnet_hash_key, argp, len)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		tun->vnet_hash = vnet_hash;
+		memcpy(tun->vnet_hash_indirection_table,
+		       vnet_hash_indirection_table,
+		       (vnet_hash.indirection_table_mask + 1) * 2);
+		memcpy(tun->vnet_hash_key, vnet_hash_key, len);
+
+		if (vnet_hash.flags & TUN_VNET_HASH_RSS)
+			__tun_set_ebpf(tun, &tun->steering_prog, NULL);
+
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 287cdc81c939..dc591cd897c8 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -61,6 +61,8 @@
 #define TUNSETFILTEREBPF _IOR('T', 225, int)
 #define TUNSETCARRIER _IOW('T', 226, int)
 #define TUNGETDEVNETNS _IO('T', 227)
+#define TUNGETVNETHASHCAP _IO('T', 228)
+#define TUNSETVNETHASH _IOW('T', 229, unsigned int)
 
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
@@ -115,4 +117,18 @@ struct tun_filter {
 	__u8   addr[][ETH_ALEN];
 };
 
+struct tun_vnet_hash_cap {
+	__u16 max_indirection_table_length;
+	__u32 types;
+};
+
+#define TUN_VNET_HASH_RSS	0x01
+#define TUN_VNET_HASH_REPORT	0x02
+struct tun_vnet_hash {
+	__u8 flags;
+	__u32 types;
+	__u16 indirection_table_mask;
+	__u16 unclassified_queue;
+};
+
 #endif /* _UAPI__IF_TUN_H */
-- 
2.42.0


