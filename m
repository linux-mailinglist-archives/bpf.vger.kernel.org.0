Return-Path: <bpf+bounces-5218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66148758A71
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974A91C20F27
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4725C9D;
	Wed, 19 Jul 2023 00:50:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78EF5669
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 00:50:20 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B9C18D
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:50:16 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76754b9eac0so591017085a.0
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689727816; x=1692319816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jDdPbzH4onHNW5mQ+nHZzIsBXIDVnlx9OcaE5Mwsjc=;
        b=eepobj0Vc1efSCz7ybajZtwpgJ5AghKHP5/txHgJFHHyY4FHoRmuQTm5LGfIesiqT/
         PD2ZTDjYtuPJ8w+SRAsKlf9SW1Ib1pYpdFc84jBiO4Y0y16uLALHKiYXgvuGWkyfqOw2
         oljI0n/oJhPluX28Ya2d//kILPfh1ZUF/MMYgawk3dKZjJ9oe5nOBGUQyNi8SIIIm7c0
         DTD5w9IYzqxsaAfBozvvoYSNWWlOsx0KjrDpjNiA32/Tivs28ml9xEjAwGuMBfpc3bKv
         z6IhJoR+YcKaXykod/FSL6o2Y+i/IWqmY0UulvwuRxY56EXpN3w9sHfLd323IuK7M8Tu
         AOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689727816; x=1692319816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jDdPbzH4onHNW5mQ+nHZzIsBXIDVnlx9OcaE5Mwsjc=;
        b=RO0K4eUNAVKARZq4dMkNUQZnGxnUwF6w8Hq5TYteeEJitdo9BJzewvib0kiOYrY8Rn
         aU/Fltvm7Bvm5FqwSoJkvjpT3DMpwEoFBh85KlAqvRSMI8XtBfggS38gZxWF4RWPhuFV
         /o6v5+7z48EQmDau0quFpN9BAXtw5+FGdE3Sdh9iJKFdE5XEwAvIvfhXe3SjO7xwqa1a
         BFoCQ6s6wHiL7EjjfcjGeOJb8JgcxuL0b6Cfe4oMuyq64wISQ6FPtDj963NxxRwq2PDh
         x+NJ+PbNh7xZBi3DgoiTaAtokWCHejW6jX75In8jFLWdgOTBdK/OPGoC9O23bAIKTo5s
         5lrA==
X-Gm-Message-State: ABy/qLb1mvYJAsTI5hoEsqN+23y1/E9+qBzK9ud7mRFsn/3JekU7Z/N/
	TtymU9W3+U4lNkgt8oxOztnPOw==
X-Google-Smtp-Source: APBJJlFK4k8p+Ccs+dRT+RZiQ+t53CIizMdNsu9Q4x5KgBks0HqA9n612FswA/1ba47aAoZuL7DUyA==
X-Received: by 2002:a05:620a:3998:b0:767:2f4a:e07a with SMTP id ro24-20020a05620a399800b007672f4ae07amr1182364qkn.68.1689727816119;
        Tue, 18 Jul 2023 17:50:16 -0700 (PDT)
Received: from [172.17.0.7] ([130.44.212.112])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b0076738337cd1sm968696qkk.1.2023.07.18.17.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 17:50:15 -0700 (PDT)
From: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Wed, 19 Jul 2023 00:50:12 +0000
Subject: [PATCH RFC net-next v5 08/14] af_vsock: add
 vsock_find_bound_dgram_socket()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v5-8-581bd37fdb26@bytedance.com>
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

This commit adds vsock_find_bound_dgram_socket() which allows transports
to find bound dgram sockets in the global dgram bind table. It is
intended to be used for "routing" incoming packets to the correct
sockets if the transport uses the global bind table.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 include/net/af_vsock.h   |  1 +
 net/vmw_vsock/af_vsock.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index f6a0ca9d7c3e..ae6b6cdf6a4d 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -215,6 +215,7 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
 bool vsock_find_cid(unsigned int cid);
+struct sock *vsock_find_bound_dgram_socket(struct sockaddr_vm *addr);
 
 /**** TAP ****/
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 0895f4c1d340..e73f3b2c52f1 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -264,6 +264,22 @@ static struct sock *vsock_find_bound_socket_common(struct sockaddr_vm *addr,
 	return NULL;
 }
 
+struct sock *
+vsock_find_bound_dgram_socket(struct sockaddr_vm *addr)
+{
+	struct sock *sk;
+
+	spin_lock_bh(&vsock_dgram_table_lock);
+	sk = vsock_find_bound_socket_common(addr, vsock_bound_dgram_sockets(addr));
+	if (sk)
+		sock_hold(sk);
+
+	spin_unlock_bh(&vsock_dgram_table_lock);
+
+	return sk;
+}
+EXPORT_SYMBOL_GPL(vsock_find_bound_dgram_socket);
+
 static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
 {
 	return vsock_find_bound_socket_common(addr, vsock_bound_sockets(addr));

-- 
2.30.2


