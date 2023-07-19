Return-Path: <bpf+bounces-5222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5DD758A7F
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423C128186F
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61B6D2EA;
	Wed, 19 Jul 2023 00:50:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112ED2E1
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 00:50:26 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3681FC0
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:50:20 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-765a4ff26cdso583865485a.0
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689727819; x=1692319819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWt1YKpD8soekZyHz3lCaTewqjrH2L6FY0Axo6M4fj8=;
        b=W6pVQ6BRHiDGSffnATfPbkdw7LAkbCWNOgEeVD9GxenwUIT3vGKQ1XNpdCGV2dE5U0
         lJeJ+JLDX+zXBHDl/VjOXmwS8BMhZ5XSG25WsyCdQ1L7J1PUQeS7wchneIdZXrXnew5c
         KKW0gqXZEEH92kEOE7IFf+JTQHYcqqcD5rraPp2jJH3XKCssNhQOiNEh9IpZfQ4eBiwF
         aDJXTPexVb1OPGgbnTlIM42X66c35BOEx7O4i0WJKVhEhHUmfAKxktnatfdWGkr0RmVV
         O4BHQmBBgupnNG76/x2nogVrYfJ8M7gCIWAYec8ZDmCl1QIBGbUBLQtvMORRGTgded45
         YoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689727819; x=1692319819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWt1YKpD8soekZyHz3lCaTewqjrH2L6FY0Axo6M4fj8=;
        b=OLIfhCMrNYa9Zo5rfSilird2GbW9K51I0tXkTkyGLo+Lf6gzcMR+dBiEqUV1dzLdrl
         erNMr9ynWO10hi70KpUeyI1WqPuUDF3cU8bWr+eDpiG0WNdtQQj/DNvDtq4mX+Qc7oKE
         krA4gFtp90oec9dU/myST9iWho7JK8Tiybh9O0fErBPsBpT+dzKbP4ftiFP4BfQ3e0UG
         /xHfNK/D3mTc2sjlGqHE/9Fe5Ny5EW37C6RDapu3e2cDEkCEPpBphTVGhwNSW1KhYPmo
         J3jxhSK3H+xKB0jg9huv8RoBUTdI6SCJ2R2XQHQWyBGLb7Xjfo1QKSN5dSMSIH/4+kyj
         o7tQ==
X-Gm-Message-State: ABy/qLZr79Rn1vU0PbHnE/8Noj82ncIYVVtNkNZakqDeTUQPjZQTVCm0
	7BplPYGUMKXb86wztu7/ZFDq6Q==
X-Google-Smtp-Source: APBJJlHlr5fgVo8mkuODl1Dwkic1o2QVA09u8BmndZImg2CIQFGpHVbXt0o/MKbDV9LRej7dfBzW4w==
X-Received: by 2002:a05:620a:2401:b0:767:f2c2:7e64 with SMTP id d1-20020a05620a240100b00767f2c27e64mr19481527qkn.63.1689727819403;
        Tue, 18 Jul 2023 17:50:19 -0700 (PDT)
Received: from [172.17.0.7] ([130.44.212.112])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b0076738337cd1sm968696qkk.1.2023.07.18.17.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 17:50:19 -0700 (PDT)
From: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Wed, 19 Jul 2023 00:50:16 +0000
Subject: [PATCH RFC net-next v5 12/14] vsock/loopback: implement datagram
 support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v5-12-581bd37fdb26@bytedance.com>
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit implements datagram support for vsock loopback.

Not much more than simply toggling on "dgram_allow" and continuing to
use the common virtio functions.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 net/vmw_vsock/vsock_loopback.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 278235ea06c4..0459b2bf7b15 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -46,6 +46,7 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
 	return 0;
 }
 
+static bool vsock_loopback_dgram_allow(u32 cid, u32 port);
 static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
 
 static struct virtio_transport loopback_transport = {
@@ -62,7 +63,7 @@ static struct virtio_transport loopback_transport = {
 		.cancel_pkt               = vsock_loopback_cancel_pkt,
 
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = vsock_loopback_dgram_allow,
 
 		.stream_dequeue           = virtio_transport_stream_dequeue,
 		.stream_enqueue           = virtio_transport_stream_enqueue,
@@ -95,6 +96,11 @@ static struct virtio_transport loopback_transport = {
 	.send_pkt = vsock_loopback_send_pkt,
 };
 
+static bool vsock_loopback_dgram_allow(u32 cid, u32 port)
+{
+	return true;
+}
+
 static bool vsock_loopback_seqpacket_allow(u32 remote_cid)
 {
 	return true;

-- 
2.30.2


