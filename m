Return-Path: <bpf+bounces-34322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 030E592C71F
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 02:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8715A1F20FBE
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 00:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CFD1EB39;
	Wed, 10 Jul 2024 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFEYJyq4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E55CB8
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720570680; cv=none; b=icYzQOJ13yG5oXeHlm5P8SogeEf4yPtISsAr5bJ0Tb1j2o7fly0DvatVoGEVGFdRovFeqilUxBNhAtlAjO7sXh5LJzBGTy6ZXSc4vCOgAvr7u2MLltIWwlgXr4VS23J4Qu5xKss4ddOtAq1Iq56CSgtppO3Sr661uUhjFqcPMJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720570680; c=relaxed/simple;
	bh=NASvmeUVRYxoiBeyQzqO+tdiFDaWH1wjGIepnf+7V1U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k00JWPW4LWCVvhHnztN7BfL+CZdX+l9RnIRzwxVtHXRxh5zWH8L2yF2ujWsCghUEoOXOOiNb3tiD+6gDHHmH7zHEfitTelq+dpA1fgV7yigbqObAy7kMgXQjy9DS7x/qjnQTtU4MxaZ2odJmWVfRRRocVng6MlJFs42DZuMLXf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iFEYJyq4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-650b621f4cdso81364947b3.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 17:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720570677; x=1721175477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t25q4Vt6u4y3Md0WfEfNskFRWJQTLqNWKOxWySegb40=;
        b=iFEYJyq4rBVinRBs9g3rk58TkzxLW236c2IIu/Wb8bjSv/jn/KF1NCc6Su/L/3LlmT
         lWRpmUzweppW+txiZI9Ca7BUofDYPq9zXAEjEU3vy14+S94OflsIOYUL6SRI8mr60Ch3
         Q6f5sGPt952zfCloyM0PrU6s2hkS4Tsm1xxR+fWb0pMikJ+fUPHe1FA1D6a/f5OkfaWN
         9wvEidLWUKIYTOYUJAe5p9uFgcoPStigjLj699eRgXDOX/1ESN9FL+QdSWhsOW/tz4NT
         5rpf6nImc8GVHmgRsJgjRqJrHeRk6GVCIllqfDvH8Dk1FSY4pfBzBpLjuWMm0YLgJ2/t
         2r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720570677; x=1721175477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t25q4Vt6u4y3Md0WfEfNskFRWJQTLqNWKOxWySegb40=;
        b=X3io4CNsACi7hkOFOIiCjkgx+lXpqgdaZkl26Lmrw91zaxS8VVPEBehKi0jdXwAZLk
         wQz6afE/XMQZcxCMNdRiFK9npCM8PwZs5dQqBcsaBHXUXQKYjSaassurVKacT89/MFtZ
         5nMGohSBzphF/BNs94vd30D3+TvBy2ZzHe1qo00uag38qArhRn04HTIVCvANzX8Mvu4F
         W4UVWsidJf5a+lUrBJLfmzXNqsIgKKROWflb2pPN9zijMaOqRaS9nwHDBFC6ulO5Dzuk
         /Ya5rWGQ+DTgrnHOu2EnMnilFWS6pRNUhwXGyLngQJxPnr3s4AjA2nUsfXvE6ejkpnk+
         OCng==
X-Forwarded-Encrypted: i=1; AJvYcCVzp3ScFEo9AAYJZgzX9nF3VoHX3oXyUyM3Q1KKMaEnAdLAZOHPfGP+yOizX1g3JukCdnuwgk6zjkFcZkT5WhIb4IyB
X-Gm-Message-State: AOJu0YyZLyy0XyGCEVFouyI+y4y4RPKqwjzTqzdIlHlqaBnbQ5G67wu0
	9X5oG9LIrrFy/cXfDZvEXZFkaVVVLERF89gZnQD3L3Cm3axn0O6AOGyfDePewaXEXWYiOnP/jwF
	wvoVElMq44Td0Ltb152c+Zg==
X-Google-Smtp-Source: AGHT+IEO5cRNgTTA6lCiSg2LFmG0S6QiVkF4ZWqNtPIkJ9SZsPybQcqek2eHXoMLgA5hf+tXL82YIJRfHIQ9jbmmRw==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:188f:b0:dfb:b4e:407a with
 SMTP id 3f1490d57ef6-e041b1153e5mr430541276.9.1720570676630; Tue, 09 Jul 2024
 17:17:56 -0700 (PDT)
Date: Wed, 10 Jul 2024 00:17:35 +0000
In-Reply-To: <20240710001749.1388631-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710001749.1388631-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710001749.1388631-3-almasrymina@google.com>
Subject: [PATCH net-next v16 02/13] net: netdev netlink api to bind dma-buf to
 a net device
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"

API takes the dma-buf fd as input, and binds it to the netdevice. The
user can specify the rx queues to bind the dma-buf to.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v16:
- Use subset-of: queue queue-id instead of queue-dmabuf (Jakub).
- Rename attribute 'bind-dmabuf' to more generic 'dmabuf' (Jakub).
- Use 'dmabuf' everywhere instead of mix of 'dma-buf' and 'dmabuf'
  (Donald).
- Remove repetitive 'dmabuf' naming that appeared in some places
  (Jakub).
- Reordered where the new operations went so I don't break the enum UAPI
  (Jakub).

v7:
- Use flags: [ admin-perm ] instead of a CAP_NET_ADMIN check.

Changes in v1:
- Add rx-queue-type to distingish rx from tx (Jakub)
- Return dma-buf ID from netlink API (David, Stan)

Changes in RFC-v3:
- Support binding multiple rx rx-queues

---
 Documentation/netlink/specs/netdev.yaml | 47 +++++++++++++++++++++++++
 include/uapi/linux/netdev.h             | 11 ++++++
 net/core/netdev-genl-gen.c              | 19 ++++++++++
 net/core/netdev-genl-gen.h              |  2 ++
 net/core/netdev-genl.c                  |  6 ++++
 tools/include/uapi/linux/netdev.h       | 11 ++++++
 6 files changed, 96 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 959755be4d7f9..4930e8142aa63 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -457,6 +457,39 @@ attribute-sets:
           Number of times driver re-started accepting send
           requests to this queue from the stack.
         type: uint
+  -
+    name: queue-id
+    subset-of: queue
+    attributes:
+      -
+        name: id
+      -
+        name: type
+  -
+    name: dmabuf
+    attributes:
+      -
+        name: ifindex
+        doc: netdev ifindex to bind the dmabuf to.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: queues
+        doc: receive queues to bind the dmabuf to.
+        type: nest
+        nested-attributes: queue-id
+        multi-attr: true
+      -
+        name: fd
+        doc: dmabuf file descriptor to bind.
+        type: u32
+      -
+        name: id
+        doc: id of the dmabuf binding
+        type: u32
+        checks:
+          min: 1
 
 operations:
   list:
@@ -619,6 +652,20 @@ operations:
             - rx-bytes
             - tx-packets
             - tx-bytes
+    -
+      name: bind-rx
+      doc: Bind dmabuf to netdev
+      attribute-set: dmabuf
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - ifindex
+            - fd
+            - queues
+        reply:
+          attributes:
+            - id
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 43742ac5b00da..91bf3ecc5f1d9 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -173,6 +173,16 @@ enum {
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
 };
 
+enum {
+	NETDEV_A_DMABUF_IFINDEX = 1,
+	NETDEV_A_DMABUF_QUEUES,
+	NETDEV_A_DMABUF_FD,
+	NETDEV_A_DMABUF_ID,
+
+	__NETDEV_A_DMABUF_MAX,
+	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
@@ -186,6 +196,7 @@ enum {
 	NETDEV_CMD_QUEUE_GET,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
+	NETDEV_CMD_BIND_RX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 8350a0afa9ec7..6b7fe6035067b 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -27,6 +27,11 @@ const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFIND
 	[NETDEV_A_PAGE_POOL_IFINDEX] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_page_pool_ifindex_range),
 };
 
+const struct nla_policy netdev_queue_id_nl_policy[NETDEV_A_QUEUE_TYPE + 1] = {
+	[NETDEV_A_QUEUE_ID] = { .type = NLA_U32, },
+	[NETDEV_A_QUEUE_TYPE] = NLA_POLICY_MAX(NLA_U32, 1),
+};
+
 /* NETDEV_CMD_DEV_GET - do */
 static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1] = {
 	[NETDEV_A_DEV_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
@@ -74,6 +79,13 @@ static const struct nla_policy netdev_qstats_get_nl_policy[NETDEV_A_QSTATS_SCOPE
 	[NETDEV_A_QSTATS_SCOPE] = NLA_POLICY_MASK(NLA_UINT, 0x1),
 };
 
+/* NETDEV_CMD_BIND_RX - do */
+static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1] = {
+	[NETDEV_A_DMABUF_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
+	[NETDEV_A_DMABUF_QUEUES] = NLA_POLICY_NESTED(netdev_queue_id_nl_policy),
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -151,6 +163,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_QSTATS_SCOPE,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NETDEV_CMD_BIND_RX,
+		.doit		= netdev_nl_bind_rx_doit,
+		.policy		= netdev_bind_rx_nl_policy,
+		.maxattr	= NETDEV_A_DMABUF_FD,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 4db40fd5b4a9e..67c34005750c3 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -13,6 +13,7 @@
 
 /* Common nested types */
 extern const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1];
+extern const struct nla_policy netdev_queue_id_nl_policy[NETDEV_A_QUEUE_TYPE + 1];
 
 int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
@@ -30,6 +31,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 				struct netlink_callback *cb);
+int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 05f9515d2c05c..2d726e65211dd 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -721,6 +721,12 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	return err;
 }
 
+/* Stub */
+int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return 0;
+}
+
 static int netdev_genl_netdevice_event(struct notifier_block *nb,
 				       unsigned long event, void *ptr)
 {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 43742ac5b00da..91bf3ecc5f1d9 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -173,6 +173,16 @@ enum {
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
 };
 
+enum {
+	NETDEV_A_DMABUF_IFINDEX = 1,
+	NETDEV_A_DMABUF_QUEUES,
+	NETDEV_A_DMABUF_FD,
+	NETDEV_A_DMABUF_ID,
+
+	__NETDEV_A_DMABUF_MAX,
+	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
@@ -186,6 +196,7 @@ enum {
 	NETDEV_CMD_QUEUE_GET,
 	NETDEV_CMD_NAPI_GET,
 	NETDEV_CMD_QSTATS_GET,
+	NETDEV_CMD_BIND_RX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.45.2.803.g4e1b14247a-goog


