Return-Path: <bpf+bounces-5221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 429AF758A7E
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B8D1C20F1B
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A75CC8CF;
	Wed, 19 Jul 2023 00:50:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108CC8DA
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 00:50:26 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50761BFD
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:50:19 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-765a4ff26cdso583864185a.0
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689727818; x=1692319818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPwhBmtD9OJVg+4DzOYL256xxaoXc/AZRhsCaKboFfQ=;
        b=Zfsg98WIgY3dgqQOhdM9OAVFqPKJRz3yNitUZviHPLo8OICH8/ZXeMciH1E2lvVC1/
         WQvvNe6PKKqimbaiIqj3LDH7lfrsKB75ErVF7KEisUxO81NDcKvEP1ksOG0gS0q1uina
         NKwbA9SMEAQ2Shk1tQNxk3aIFrV6Cb5K3YTvQcaifZDHat7ikr/1J3s/lnHkOZg7/7k0
         uAqN7l2ohxoCr4PLTpodnRAgI7ZI8bktML3sVuatZHFX0PZII/lQpXB/KCJ69kPptn+Q
         Y7BvncJSgJ3X7J0wjOrbBcMg96cQK58DPadsZuENr1qj2c7auxRvhplDNYUOWhSiijFv
         mdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689727818; x=1692319818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPwhBmtD9OJVg+4DzOYL256xxaoXc/AZRhsCaKboFfQ=;
        b=YfeSWQNz3e8sSy4n7x6PSETFcAgyZWbMC0wDS+CFKW2LQf0A5im/ddsb2hWmsYNMpX
         T7bbwigjH8QEiu9sxWCQ+4egrG4183jf31YfKDX30Wsz+J4dLcdWplVy9qgBQFNDzPSm
         l/wEHgX6+QZ7qhtxbNSXKzCXydeE0XPfgCX90zn/2SWt8M4nJm0/ouLEtZTmCETCJ3L7
         BsM45NF0KHsk40HMgmojzd1RvNCR7jpgZDwpo1v6RkImkWM4zft9+iQyc5SxYSBR/vK6
         E+AlamqcQMRN1TT6osAbaXhVTii2Dygsqw4H+aZzUR2BN/THdJT8kiMdO/o4r5XoZLL9
         wLRw==
X-Gm-Message-State: ABy/qLYvDOTbzXOFbcPiNFnufh5sOLfDxMT3DzNlyipkb48iIoAt5hAn
	AUt3oE1dUfBYoZv2CSVpyFV6JQ==
X-Google-Smtp-Source: APBJJlGXGRD0guPH/Jjx0e35MhLHJF0cvmxP5fhz+u5q+QQsjgsXv0HLDTaM2Pxw5w2Z5rNWOkfgmQ==
X-Received: by 2002:a05:620a:2447:b0:767:1293:f43e with SMTP id h7-20020a05620a244700b007671293f43emr22685654qkn.49.1689727818622;
        Tue, 18 Jul 2023 17:50:18 -0700 (PDT)
Received: from [172.17.0.7] ([130.44.212.112])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b0076738337cd1sm968696qkk.1.2023.07.18.17.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 17:50:18 -0700 (PDT)
From: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Wed, 19 Jul 2023 00:50:15 +0000
Subject: [PATCH RFC net-next v5 11/14] vhost/vsock: implement datagram
 support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v5-11-581bd37fdb26@bytedance.com>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
In-Reply-To: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>, 
 Vishnu Dasa <vdasa@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Simon Horman <simon.horman@corigine.com>, 
 Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 bpf@vger.kernel.org, Bobby Eshleman <bobby.eshleman@bytedance.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit implements datagram support for vhost/vsock by teaching
vhost to use the common virtio transport datagram functions.

If the virtio RX buffer is too small, then the transmission is
abandoned, the packet dropped, and EHOSTUNREACH is added to the socket's
error queue.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 drivers/vhost/vsock.c    | 62 +++++++++++++++++++++++++++++++++++++++++++++---
 net/vmw_vsock/af_vsock.c |  5 +++-
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index d5d6a3c3f273..da14260c6654 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -8,6 +8,7 @@
  */
 #include <linux/miscdevice.h>
 #include <linux/atomic.h>
+#include <linux/errqueue.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/vmalloc.h>
@@ -32,7 +33,8 @@
 enum {
 	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
 			       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
-			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET)
+			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET) |
+			       (1ULL << VIRTIO_VSOCK_F_DGRAM)
 };
 
 enum {
@@ -56,6 +58,7 @@ struct vhost_vsock {
 	atomic_t queued_replies;
 
 	u32 guest_cid;
+	bool dgram_allow;
 	bool seqpacket_allow;
 };
 
@@ -86,6 +89,32 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 	return NULL;
 }
 
+/* Claims ownership of the skb, do not free the skb after calling! */
+static void
+vhost_transport_error(struct sk_buff *skb, int err)
+{
+	struct sock_exterr_skb *serr;
+	struct sock *sk = skb->sk;
+	struct sk_buff *clone;
+
+	serr = SKB_EXT_ERR(skb);
+	memset(serr, 0, sizeof(*serr));
+	serr->ee.ee_errno = err;
+	serr->ee.ee_origin = SO_EE_ORIGIN_NONE;
+
+	clone = skb_clone(skb, GFP_KERNEL);
+	if (!clone)
+		return;
+
+	if (sock_queue_err_skb(sk, clone))
+		kfree_skb(clone);
+
+	sk->sk_err = err;
+	sk_error_report(sk);
+
+	kfree_skb(skb);
+}
+
 static void
 vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			    struct vhost_virtqueue *vq)
@@ -160,9 +189,15 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		hdr = virtio_vsock_hdr(skb);
 
 		/* If the packet is greater than the space available in the
-		 * buffer, we split it using multiple buffers.
+		 * buffer, we split it using multiple buffers for connectible
+		 * sockets and drop the packet for datagram sockets.
 		 */
 		if (payload_len > iov_len - sizeof(*hdr)) {
+			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM) {
+				vhost_transport_error(skb, EHOSTUNREACH);
+				continue;
+			}
+
 			payload_len = iov_len - sizeof(*hdr);
 
 			/* As we are copying pieces of large packet's buffer to
@@ -394,6 +429,7 @@ static bool vhost_vsock_more_replies(struct vhost_vsock *vsock)
 	return val < vq->num;
 }
 
+static bool vhost_transport_dgram_allow(u32 cid, u32 port);
 static bool vhost_transport_seqpacket_allow(u32 remote_cid);
 
 static struct virtio_transport vhost_transport = {
@@ -410,7 +446,8 @@ static struct virtio_transport vhost_transport = {
 		.cancel_pkt               = vhost_transport_cancel_pkt,
 
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = vhost_transport_dgram_allow,
+		.dgram_addr_init          = virtio_transport_dgram_addr_init,
 
 		.stream_enqueue           = virtio_transport_stream_enqueue,
 		.stream_dequeue           = virtio_transport_stream_dequeue,
@@ -443,6 +480,22 @@ static struct virtio_transport vhost_transport = {
 	.send_pkt = vhost_transport_send_pkt,
 };
 
+static bool vhost_transport_dgram_allow(u32 cid, u32 port)
+{
+	struct vhost_vsock *vsock;
+	bool dgram_allow = false;
+
+	rcu_read_lock();
+	vsock = vhost_vsock_get(cid);
+
+	if (vsock)
+		dgram_allow = vsock->dgram_allow;
+
+	rcu_read_unlock();
+
+	return dgram_allow;
+}
+
 static bool vhost_transport_seqpacket_allow(u32 remote_cid)
 {
 	struct vhost_vsock *vsock;
@@ -799,6 +852,9 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	if (features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))
 		vsock->seqpacket_allow = true;
 
+	if (features & (1ULL << VIRTIO_VSOCK_F_DGRAM))
+		vsock->dgram_allow = true;
+
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];
 		mutex_lock(&vq->mutex);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index e73f3b2c52f1..449ed63ac2b0 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1427,9 +1427,12 @@ int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 		return prot->recvmsg(sk, msg, len, flags, NULL);
 #endif
 
-	if (flags & MSG_OOB || flags & MSG_ERRQUEUE)
+	if (unlikely(flags & MSG_OOB))
 		return -EOPNOTSUPP;
 
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return sock_recv_errqueue(sk, msg, len, SOL_VSOCK, 0);
+
 	transport = vsk->transport;
 
 	/* Retrieve the head sk_buff from the socket's receive queue. */

-- 
2.30.2


