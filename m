Return-Path: <bpf+bounces-5217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C12758A6C
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4502815E0
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116CD525A;
	Wed, 19 Jul 2023 00:50:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62865239
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 00:50:19 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1DE19B0
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:50:16 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-765942d497fso575185385a.1
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689727815; x=1692319815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obFj4SuWwNEDydCXYPra7zizeyW2jR3T9h3NMhd9EHc=;
        b=NUyO+OfSBwygJujqqAlusnhc8WL36GpDGlOSMNLrUMALVwy9C+eLf/gmADp5e2Cvdl
         RoxYMjnlm9to1SPFtrXu1eRiaDKIaHRn7U5Gw43KRFon2ohnUGIbnHrzI+y6hPywKwij
         PiwDJMc0PYE43Lp01hG48NJP7F9ojPjgzzPHD3GdMUhU4sCPOclubU6J2xW3pyzue4rk
         7dMq/WYhfHxufcyjzThwQER4VlREp4hqAwyKaHW090tW2j8ZZ0/TwaXZNxzIJ7uHUpR8
         wDT/venpG53iqv+C/PcE08F+s25Nk5YqUK+0bFTbp2Zw7AX18c2/2bHEiJ+3+x2r4T3m
         iRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689727815; x=1692319815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obFj4SuWwNEDydCXYPra7zizeyW2jR3T9h3NMhd9EHc=;
        b=L2N/0A5E07jPpZZoqWyXMvl7erZKROftMfLMtoogWXhWObFkk9uUQUcvhcC5wr+sFo
         G6bQEc+J8wrwCu1P2MUz9gp+MsDdTCaldHMb1ZRUz46yR6meWKpfKGUTLe7qpbnSUe3q
         brtKmaDE4PjIqwcKFhqxHTzZiJOfH7w6IW4ysZ3orxhES4Gf5Dz8/qZlYCuTOQ5Wv5CY
         eDTcnDw2DmJ99dOdjOTV0yb23Fh4KByQVPJ5sJPO2sgFXnihaaTG+fuEu2UogSjuPRha
         6WobprNQQFsRVuC9yGk72vh1rBQNPitiRfHMuCPqJarquGIc86NvkeD/oIWO1IFmhaWS
         0Tfw==
X-Gm-Message-State: ABy/qLYQyNlTq3rqoILOvubU9p/IYXBhwEW7lzamlCUaL/HyLEWmz4d2
	XsLdldj3xbdpbbl8wFbxqtazNg==
X-Google-Smtp-Source: APBJJlH2qBZQH1qWGCaN+VQmrmpisuAoTXdqGyO0+X8WfXFZcOKKbLFZjpv8WQo8vDTHZeos5kgd6A==
X-Received: by 2002:a05:620a:2686:b0:767:32cd:5fe8 with SMTP id c6-20020a05620a268600b0076732cd5fe8mr19266292qkp.14.1689727815276;
        Tue, 18 Jul 2023 17:50:15 -0700 (PDT)
Received: from [172.17.0.7] ([130.44.212.112])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b0076738337cd1sm968696qkk.1.2023.07.18.17.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 17:50:14 -0700 (PDT)
From: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Wed, 19 Jul 2023 00:50:11 +0000
Subject: [PATCH RFC net-next v5 07/14] virtio/vsock: add common datagram
 send path
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v5-7-581bd37fdb26@bytedance.com>
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit implements the common function
virtio_transport_dgram_enqueue for enqueueing datagrams. It does not add
usage in either vhost or virtio yet.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 net/vmw_vsock/virtio_transport_common.c | 76 ++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index ffcbdd77feaa..3bfaff758433 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -819,7 +819,81 @@ virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
 			       struct msghdr *msg,
 			       size_t dgram_len)
 {
-	return -EOPNOTSUPP;
+	/* Here we are only using the info struct to retain style uniformity
+	 * and to ease future refactoring and merging.
+	 */
+	struct virtio_vsock_pkt_info info_stack = {
+		.op = VIRTIO_VSOCK_OP_RW,
+		.msg = msg,
+		.vsk = vsk,
+		.type = VIRTIO_VSOCK_TYPE_DGRAM,
+	};
+	const struct virtio_transport *t_ops;
+	struct virtio_vsock_pkt_info *info;
+	struct sock *sk = sk_vsock(vsk);
+	struct virtio_vsock_hdr *hdr;
+	u32 src_cid, src_port;
+	struct sk_buff *skb;
+	void *payload;
+	int noblock;
+	int err;
+
+	info = &info_stack;
+
+	if (dgram_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
+		return -EMSGSIZE;
+
+	t_ops = virtio_transport_get_ops(vsk);
+	if (unlikely(!t_ops))
+		return -EFAULT;
+
+	/* Unlike some of our other sending functions, this function is not
+	 * intended for use without a msghdr.
+	 */
+	if (WARN_ONCE(!msg, "vsock dgram bug: no msghdr found for dgram enqueue\n"))
+		return -EFAULT;
+
+	noblock = msg->msg_flags & MSG_DONTWAIT;
+
+	/* Use sock_alloc_send_skb to throttle by sk_sndbuf. This helps avoid
+	 * triggering the OOM.
+	 */
+	skb = sock_alloc_send_skb(sk, dgram_len + VIRTIO_VSOCK_SKB_HEADROOM,
+				  noblock, &err);
+	if (!skb)
+		return err;
+
+	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
+
+	src_cid = t_ops->transport.get_local_cid();
+	src_port = vsk->local_addr.svm_port;
+
+	hdr = virtio_vsock_hdr(skb);
+	hdr->type	= cpu_to_le16(info->type);
+	hdr->op		= cpu_to_le16(info->op);
+	hdr->src_cid	= cpu_to_le64(src_cid);
+	hdr->dst_cid	= cpu_to_le64(remote_addr->svm_cid);
+	hdr->src_port	= cpu_to_le32(src_port);
+	hdr->dst_port	= cpu_to_le32(remote_addr->svm_port);
+	hdr->flags	= cpu_to_le32(info->flags);
+	hdr->len	= cpu_to_le32(dgram_len);
+
+	skb_set_owner_w(skb, sk);
+
+	payload = skb_put(skb, dgram_len);
+	err = memcpy_from_msg(payload, msg, dgram_len);
+	if (err)
+		return err;
+
+	trace_virtio_transport_alloc_pkt(src_cid, src_port,
+					 remote_addr->svm_cid,
+					 remote_addr->svm_port,
+					 dgram_len,
+					 info->type,
+					 info->op,
+					 0);
+
+	return t_ops->send_pkt(skb);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_dgram_enqueue);
 

-- 
2.30.2


