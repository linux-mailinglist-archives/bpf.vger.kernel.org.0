Return-Path: <bpf+bounces-5215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EEB758A69
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF59428182C
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B840D440A;
	Wed, 19 Jul 2023 00:50:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1F3FF5
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 00:50:18 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA8A198E
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:50:14 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7654e1d83e8so521047285a.1
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689727813; x=1692319813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVG6/fd8/TheeZKmbnuDQmZdww8fyIwE/W3lpq/H1bc=;
        b=M1eAJpu3CrxziEpHRP2XtbX8TUaYeVu0Z7OFMz3BDmc+5Zu6FVi4kVgFeg0IMOBIuK
         CbMVnZLS9QwWEcl2SBAlk6NmUL7L2NI5FNnpakeq9h2XDhWrIj91ZkPueFOVWfrnPRj7
         3OCUpGxk/hRy2rDb1B6+dyRg1zS+an1cw2SxJJAU30HWMiSrwRDCrU+KAFJDSH0+VmLd
         PNKfLsyqBT491jiB8zcaZRd6P37+KFR2uOeseT5s+z8dYLH6G7S5tM8Muxl1fR1lzZbQ
         EKSEQfb1GYzVISzT3tiPw3q9u4FdlVzQ5uihYjuK3rqMwiT5cEbfDayk24sCb0Ct/mD8
         UncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689727813; x=1692319813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVG6/fd8/TheeZKmbnuDQmZdww8fyIwE/W3lpq/H1bc=;
        b=V3aOzDOMEP8rF9u21lgKKDrN/rCLGAa5dLBTV2r4W+fiBi4sGoT7oGkUUbqI0oMFar
         sM0WGISh4W0+QO/EKm8EqGXT4kjsSffFYy7AiujtklfcPhqW4/g+mQ041cIlbdk3qC3D
         A3Na9rccZK0iUJzrt/wbzI+avhTj80Koxd2vo9lbkonU+vVAaf+QFBEvWNGs9y8qP2GV
         H1mYgIxbPVILlxuXzgUAM6JDYa5bg0f5I7AQmV1qX8ayp/H+r69LaoRseQKtaGxs/fT4
         kc0GfL1ksZeGOGLFhyNMAEdATtrBRkfVkf3NEC/s54EtcgVK5VFgEebIEOjZc+UoImMY
         fnAg==
X-Gm-Message-State: ABy/qLZzk9r+hV78tL9PKLCAi4J7pN9kew+Qgor6mK7nNSFXbk2x4e6h
	qwbX4Zj/p9l7a4PvT4qAj57bpg==
X-Google-Smtp-Source: APBJJlEdgeIMmEal/enOtz263yYRYOJgRea96+xgnNW5OxmQtleUTPIHOcy9i3mblRLEcUh0PSkGUQ==
X-Received: by 2002:a05:620a:45ab:b0:766:fa7b:8b20 with SMTP id bp43-20020a05620a45ab00b00766fa7b8b20mr868491qkb.50.1689727813660;
        Tue, 18 Jul 2023 17:50:13 -0700 (PDT)
Received: from [172.17.0.7] ([130.44.212.112])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b0076738337cd1sm968696qkk.1.2023.07.18.17.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 17:50:13 -0700 (PDT)
From: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Wed, 19 Jul 2023 00:50:09 +0000
Subject: [PATCH RFC net-next v5 05/14] af_vsock: use a separate dgram bind
 table
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v5-5-581bd37fdb26@bytedance.com>
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

This commit adds support for bound dgram sockets to be tracked in a
separate bind table from connectible sockets in order to avoid address
collisions. With this commit, users can simultaneously bind a dgram
socket and connectible socket to the same CID and port.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 net/vmw_vsock/af_vsock.c | 103 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 27 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 88100154156c..0895f4c1d340 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -10,18 +10,23 @@
  * - There are two kinds of sockets: those created by user action (such as
  * calling socket(2)) and those created by incoming connection request packets.
  *
- * - There are two "global" tables, one for bound sockets (sockets that have
- * specified an address that they are responsible for) and one for connected
- * sockets (sockets that have established a connection with another socket).
- * These tables are "global" in that all sockets on the system are placed
- * within them. - Note, though, that the bound table contains an extra entry
- * for a list of unbound sockets and SOCK_DGRAM sockets will always remain in
- * that list. The bound table is used solely for lookup of sockets when packets
- * are received and that's not necessary for SOCK_DGRAM sockets since we create
- * a datagram handle for each and need not perform a lookup.  Keeping SOCK_DGRAM
- * sockets out of the bound hash buckets will reduce the chance of collisions
- * when looking for SOCK_STREAM sockets and prevents us from having to check the
- * socket type in the hash table lookups.
+ * - There are three "global" tables, one for bound connectible (stream /
+ * seqpacket) sockets, one for bound datagram sockets, and one for connected
+ * sockets. Bound sockets are sockets that have specified an address that
+ * they are responsible for. Connected sockets are sockets that have
+ * established a connection with another socket. These tables are "global" in
+ * that all sockets on the system are placed within them. - Note, though,
+ * that the bound tables contain an extra entry for a list of unbound
+ * sockets. The bound tables are used solely for lookup of sockets when packets
+ * are received.
+ *
+ * - There are separate bind tables for connectible and datagram sockets to avoid
+ * address collisions between stream/seqpacket sockets and datagram sockets.
+ *
+ * - Transports may elect to NOT use the global datagram bind table by
+ * implementing the ->dgram_bind() callback. If that callback is implemented,
+ * the global bind table is not used and the responsibility of bound datagram
+ * socket tracking is deferred to the transport.
  *
  * - Sockets created by user action will either be "client" sockets that
  * initiate a connection or "server" sockets that listen for connections; we do
@@ -115,6 +120,7 @@
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
 static void vsock_sk_destruct(struct sock *sk);
 static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
+static bool sock_type_connectible(u16 type);
 
 /* Protocol family. */
 struct proto vsock_proto = {
@@ -151,21 +157,25 @@ static DEFINE_MUTEX(vsock_register_mutex);
  * VSocket is stored in the connected hash table.
  *
  * Unbound sockets are all put on the same list attached to the end of the hash
- * table (vsock_unbound_sockets).  Bound sockets are added to the hash table in
- * the bucket that their local address hashes to (vsock_bound_sockets(addr)
- * represents the list that addr hashes to).
+ * tables (vsock_unbound_sockets/vsock_unbound_dgram_sockets).  Bound sockets
+ * are added to the hash table in the bucket that their local address hashes to
+ * (vsock_bound_sockets(addr) and vsock_bound_dgram_sockets(addr) represents
+ * the list that addr hashes to).
  *
- * Specifically, we initialize the vsock_bind_table array to a size of
- * VSOCK_HASH_SIZE + 1 so that vsock_bind_table[0] through
- * vsock_bind_table[VSOCK_HASH_SIZE - 1] are for bound sockets and
- * vsock_bind_table[VSOCK_HASH_SIZE] is for unbound sockets.  The hash function
- * mods with VSOCK_HASH_SIZE to ensure this.
+ * Specifically, taking connectible sockets as an example we initialize the
+ * vsock_bind_table array to a size of VSOCK_HASH_SIZE + 1 so that
+ * vsock_bind_table[0] through vsock_bind_table[VSOCK_HASH_SIZE - 1] are for
+ * bound sockets and vsock_bind_table[VSOCK_HASH_SIZE] is for unbound sockets.
+ * The hash function mods with VSOCK_HASH_SIZE to ensure this.
+ * Datagrams and vsock_dgram_bind_table operate in the same way.
  */
 #define MAX_PORT_RETRIES        24
 
 #define VSOCK_HASH(addr)        ((addr)->svm_port % VSOCK_HASH_SIZE)
 #define vsock_bound_sockets(addr) (&vsock_bind_table[VSOCK_HASH(addr)])
+#define vsock_bound_dgram_sockets(addr) (&vsock_dgram_bind_table[VSOCK_HASH(addr)])
 #define vsock_unbound_sockets     (&vsock_bind_table[VSOCK_HASH_SIZE])
+#define vsock_unbound_dgram_sockets     (&vsock_dgram_bind_table[VSOCK_HASH_SIZE])
 
 /* XXX This can probably be implemented in a better way. */
 #define VSOCK_CONN_HASH(src, dst)				\
@@ -181,6 +191,8 @@ struct list_head vsock_connected_table[VSOCK_HASH_SIZE];
 EXPORT_SYMBOL_GPL(vsock_connected_table);
 DEFINE_SPINLOCK(vsock_table_lock);
 EXPORT_SYMBOL_GPL(vsock_table_lock);
+static struct list_head vsock_dgram_bind_table[VSOCK_HASH_SIZE + 1];
+static DEFINE_SPINLOCK(vsock_dgram_table_lock);
 
 /* Autobind this socket to the local address if necessary. */
 static int vsock_auto_bind(struct vsock_sock *vsk)
@@ -203,6 +215,9 @@ static void vsock_init_tables(void)
 
 	for (i = 0; i < ARRAY_SIZE(vsock_connected_table); i++)
 		INIT_LIST_HEAD(&vsock_connected_table[i]);
+
+	for (i = 0; i < ARRAY_SIZE(vsock_dgram_bind_table); i++)
+		INIT_LIST_HEAD(&vsock_dgram_bind_table[i]);
 }
 
 static void __vsock_insert_bound(struct list_head *list,
@@ -270,13 +285,28 @@ static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
 	return NULL;
 }
 
-static void vsock_insert_unbound(struct vsock_sock *vsk)
+static void __vsock_insert_dgram_unbound(struct vsock_sock *vsk)
+{
+	spin_lock_bh(&vsock_dgram_table_lock);
+	__vsock_insert_bound(vsock_unbound_dgram_sockets, vsk);
+	spin_unlock_bh(&vsock_dgram_table_lock);
+}
+
+static void __vsock_insert_connectible_unbound(struct vsock_sock *vsk)
 {
 	spin_lock_bh(&vsock_table_lock);
 	__vsock_insert_bound(vsock_unbound_sockets, vsk);
 	spin_unlock_bh(&vsock_table_lock);
 }
 
+static void vsock_insert_unbound(struct vsock_sock *vsk)
+{
+	if (sock_type_connectible(sk_vsock(vsk)->sk_type))
+		__vsock_insert_connectible_unbound(vsk);
+	else
+		__vsock_insert_dgram_unbound(vsk);
+}
+
 void vsock_insert_connected(struct vsock_sock *vsk)
 {
 	struct list_head *list = vsock_connected_sockets(
@@ -288,6 +318,14 @@ void vsock_insert_connected(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_insert_connected);
 
+static void vsock_remove_dgram_bound(struct vsock_sock *vsk)
+{
+	spin_lock_bh(&vsock_dgram_table_lock);
+	if (__vsock_in_bound_table(vsk))
+		__vsock_remove_bound(vsk);
+	spin_unlock_bh(&vsock_dgram_table_lock);
+}
+
 void vsock_remove_bound(struct vsock_sock *vsk)
 {
 	spin_lock_bh(&vsock_table_lock);
@@ -339,7 +377,10 @@ EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
 void vsock_remove_sock(struct vsock_sock *vsk)
 {
-	vsock_remove_bound(vsk);
+	if (sock_type_connectible(sk_vsock(vsk)->sk_type))
+		vsock_remove_bound(vsk);
+	else
+		vsock_remove_dgram_bound(vsk);
 	vsock_remove_connected(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_remove_sock);
@@ -722,11 +763,19 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 	return vsock_bind_common(vsk, addr, vsock_bind_table, VSOCK_HASH_SIZE + 1);
 }
 
-static int __vsock_bind_dgram(struct vsock_sock *vsk,
-			      struct sockaddr_vm *addr)
+static int vsock_bind_dgram(struct vsock_sock *vsk,
+			    struct sockaddr_vm *addr)
 {
-	if (!vsk->transport || !vsk->transport->dgram_bind)
-		return -EINVAL;
+	if (!vsk->transport || !vsk->transport->dgram_bind) {
+		int retval;
+
+		spin_lock_bh(&vsock_dgram_table_lock);
+		retval = vsock_bind_common(vsk, addr, vsock_dgram_bind_table,
+					   VSOCK_HASH_SIZE);
+		spin_unlock_bh(&vsock_dgram_table_lock);
+
+		return retval;
+	}
 
 	return vsk->transport->dgram_bind(vsk, addr);
 }
@@ -757,7 +806,7 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 		break;
 
 	case SOCK_DGRAM:
-		retval = __vsock_bind_dgram(vsk, addr);
+		retval = vsock_bind_dgram(vsk, addr);
 		break;
 
 	default:

-- 
2.30.2


