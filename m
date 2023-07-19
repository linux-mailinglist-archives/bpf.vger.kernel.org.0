Return-Path: <bpf+bounces-5219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A40758A76
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FCA281858
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1643BA5F;
	Wed, 19 Jul 2023 00:50:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A3BA35
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 00:50:23 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162B91BDD
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:50:18 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-765a4ff26cdso583861885a.0
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689727817; x=1692319817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+JsHAVeQKqCNEF0CRYlofIAoy5flsel9yo94Vo/+Eo=;
        b=k3FRG1PMx0ejaOyKjb+qIvS2h2qh7nI25WPMOBcv4beZE+hxTM+Z5dNRyCx59FHH/b
         19EQavh8h8Fe/FtWPDeJXA2VB/UD3SZAStjnuS428zwlVMgS4h5Cq8YubGwGoC2Y0DgJ
         ICRqDvKNoFWj4AXdVQ2AM/hZY+upLLwgtrtt9r+MrZLkxQf43EBC7BF+Kb+Xw2Wa+mDY
         UFfWUjaqqRe2UeFbdp4qVgUravI0Bcl2TuHpPBiDMVj98CXTkvOzV7f4w2SIpgP57UvU
         6H9DIVWaVTJQibyeFjCoc6gw8ufkYUDdCcNyG1e/HxzCIUUXnqCllHDoaMmiQ2uMFzoD
         UYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689727817; x=1692319817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+JsHAVeQKqCNEF0CRYlofIAoy5flsel9yo94Vo/+Eo=;
        b=E0bOSPoMMVQOie+6sMfBUkxtJWIMLadE/xHgaZ/VMtLU4nxn1nssUX4tf2N5ZbbFMn
         RxVfNScox/bP7CWi14AA9fxO9svESqup14eiEpYH6hBKppzNsRRKlVtv4sADjXDERSFT
         YX8T9cciHz3YRrwvGoTqXXRoKOY1I8I97kq0OzRmEAbswipPxwpBspvw5cHAeS6YHELt
         gklMV0pTTxyzs5WtOfRVaBnTs+L0qBYU/YADpRMXk2xGlTOJnzfgfqBKWSebdZeX2zbQ
         pWnh7JSUT80NbuR364kVEZLC08GiLWkwKAfMTUANeu9m82aCoWwIUz8X2VoyVgQwUrH/
         axXg==
X-Gm-Message-State: ABy/qLaadyFDm4kHCXQO62K5u1lEzHi2ab5XaU7YEuHRyy0bOXEQiF/c
	cGvq0dhE5sl3p2ihqVfdLP/PnQ==
X-Google-Smtp-Source: APBJJlES5UNWy7xyLcCb+hHXmsb/T3heNMPhBM5LsuvJ02FTiFE5jZYgHOUduAvRHfjXMpgiJUg74g==
X-Received: by 2002:a05:620a:2588:b0:767:18b5:f6d6 with SMTP id x8-20020a05620a258800b0076718b5f6d6mr20219811qko.2.1689727816973;
        Tue, 18 Jul 2023 17:50:16 -0700 (PDT)
Received: from [172.17.0.7] ([130.44.212.112])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b0076738337cd1sm968696qkk.1.2023.07.18.17.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 17:50:16 -0700 (PDT)
From: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Wed, 19 Jul 2023 00:50:13 +0000
Subject: [PATCH RFC net-next v5 09/14] virtio/vsock: add common datagram
 recv path
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v5-9-581bd37fdb26@bytedance.com>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit adds the common datagram receive functionality for virtio
transports. It does not add the vhost/virtio users of that
functionality.

This functionality includes:
- changes to the virtio_transport_recv_pkt() path for finding the
  bound socket receiver for incoming packets.
- a virtio_transport_dgram_addr_init() function to be used as the
  ->dgram_addr_init callback for initializing sockaddr_vm inside
  the generic recvmsg() caller.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 include/linux/virtio_vsock.h            |  2 +
 net/vmw_vsock/virtio_transport_common.c | 92 ++++++++++++++++++++++++++++-----
 2 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 7632552bee58..b3856b8a42b3 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -212,6 +212,8 @@ u64 virtio_transport_stream_rcvhiwat(struct vsock_sock *vsk);
 bool virtio_transport_stream_is_active(struct vsock_sock *vsk);
 bool virtio_transport_stream_allow(u32 cid, u32 port);
 bool virtio_transport_dgram_allow(u32 cid, u32 port);
+void virtio_transport_dgram_addr_init(struct sk_buff *skb,
+				      struct sockaddr_vm *addr);
 
 int virtio_transport_connect(struct vsock_sock *vsk);
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 3bfaff758433..96118e258097 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -183,7 +183,9 @@ EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
 
 static u16 virtio_transport_get_type(struct sock *sk)
 {
-	if (sk->sk_type == SOCK_STREAM)
+	if (sk->sk_type == SOCK_DGRAM)
+		return VIRTIO_VSOCK_TYPE_DGRAM;
+	else if (sk->sk_type == SOCK_STREAM)
 		return VIRTIO_VSOCK_TYPE_STREAM;
 	else
 		return VIRTIO_VSOCK_TYPE_SEQPACKET;
@@ -1184,6 +1186,35 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 		kfree_skb(skb);
 }
 
+static void
+virtio_transport_dgram_kfree_skb(struct sk_buff *skb, int err)
+{
+	if (err == -ENOMEM)
+		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_RCVBUFF);
+	else if (err == -ENOBUFS)
+		kfree_skb_reason(skb, SKB_DROP_REASON_PROTO_MEM);
+	else
+		kfree_skb(skb);
+}
+
+/* This function takes ownership of the skb.
+ *
+ * It either places the skb on the sk_receive_queue or frees it.
+ */
+static void
+virtio_transport_recv_dgram(struct sock *sk, struct sk_buff *skb)
+{
+	int err;
+
+	err = sock_queue_rcv_skb(sk, skb);
+	if (err) {
+		virtio_transport_dgram_kfree_skb(skb, err);
+		return;
+	}
+
+	sk->sk_data_ready(sk);
+}
+
 static int
 virtio_transport_recv_connected(struct sock *sk,
 				struct sk_buff *skb)
@@ -1347,7 +1378,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 static bool virtio_transport_valid_type(u16 type)
 {
 	return (type == VIRTIO_VSOCK_TYPE_STREAM) ||
-	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
+	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET) ||
+	       (type == VIRTIO_VSOCK_TYPE_DGRAM);
 }
 
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
@@ -1361,40 +1393,52 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	struct vsock_sock *vsk;
 	struct sock *sk;
 	bool space_available;
+	u16 type;
 
 	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
 	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
 			le32_to_cpu(hdr->dst_port));
 
+	type = le16_to_cpu(hdr->type);
+
 	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
 					dst.svm_cid, dst.svm_port,
 					le32_to_cpu(hdr->len),
-					le16_to_cpu(hdr->type),
+					type,
 					le16_to_cpu(hdr->op),
 					le32_to_cpu(hdr->flags),
 					le32_to_cpu(hdr->buf_alloc),
 					le32_to_cpu(hdr->fwd_cnt));
 
-	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
+	if (!virtio_transport_valid_type(type)) {
 		(void)virtio_transport_reset_no_sock(t, skb);
 		goto free_pkt;
 	}
 
-	/* The socket must be in connected or bound table
-	 * otherwise send reset back
+	/* For stream/seqpacket, the socket must be in connected or bound table
+	 * otherwise send reset back.
+	 *
+	 * For datagrams, no reset is sent back.
 	 */
 	sk = vsock_find_connected_socket(&src, &dst);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
-		if (!sk) {
-			(void)virtio_transport_reset_no_sock(t, skb);
-			goto free_pkt;
+		if (type == VIRTIO_VSOCK_TYPE_DGRAM) {
+			sk = vsock_find_bound_dgram_socket(&dst);
+			if (!sk)
+				goto free_pkt;
+		} else {
+			sk = vsock_find_bound_socket(&dst);
+			if (!sk) {
+				(void)virtio_transport_reset_no_sock(t, skb);
+				goto free_pkt;
+			}
 		}
 	}
 
-	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
-		(void)virtio_transport_reset_no_sock(t, skb);
+	if (virtio_transport_get_type(sk) != type) {
+		if (type != VIRTIO_VSOCK_TYPE_DGRAM)
+			(void)virtio_transport_reset_no_sock(t, skb);
 		sock_put(sk);
 		goto free_pkt;
 	}
@@ -1410,12 +1454,18 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	/* Check if sk has been closed before lock_sock */
 	if (sock_flag(sk, SOCK_DONE)) {
-		(void)virtio_transport_reset_no_sock(t, skb);
+		if (type != VIRTIO_VSOCK_TYPE_DGRAM)
+			(void)virtio_transport_reset_no_sock(t, skb);
 		release_sock(sk);
 		sock_put(sk);
 		goto free_pkt;
 	}
 
+	if (sk->sk_type == SOCK_DGRAM) {
+		virtio_transport_recv_dgram(sk, skb);
+		goto out;
+	}
+
 	space_available = virtio_transport_space_update(sk, skb);
 
 	/* Update CID in case it has changed after a transport reset event */
@@ -1447,6 +1497,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		break;
 	}
 
+out:
 	release_sock(sk);
 
 	/* Release refcnt obtained when we fetched this socket out of the
@@ -1515,6 +1566,21 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 }
 EXPORT_SYMBOL_GPL(virtio_transport_read_skb);
 
+void virtio_transport_dgram_addr_init(struct sk_buff *skb,
+				      struct sockaddr_vm *addr)
+{
+	struct virtio_vsock_hdr *hdr;
+	unsigned int cid, port;
+
+	WARN_ONCE(skb->head == skb->data, "virtio vsock bug: bad dgram skb");
+
+	hdr = virtio_vsock_hdr(skb);
+	cid = le64_to_cpu(hdr->src_cid);
+	port = le32_to_cpu(hdr->src_port);
+	vsock_addr_init(addr, cid, port);
+}
+EXPORT_SYMBOL_GPL(virtio_transport_dgram_addr_init);
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Asias He");
 MODULE_DESCRIPTION("common code for virtio vsock");

-- 
2.30.2


