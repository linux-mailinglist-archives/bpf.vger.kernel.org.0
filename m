Return-Path: <bpf+bounces-37578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8E3957D8F
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 08:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973541F222C3
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 06:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276F315CD64;
	Tue, 20 Aug 2024 06:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xteuARAc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A252165EEB
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 06:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133914; cv=none; b=HftvEpo5rMamg2k9gJ7dW5S99dV7Cgh9At1RR7Giyeabx3gTpU2j64jlFs8YTrc7YKNL7SACFLe8r71EyUHfdiHFtwv2Lcr1Jxq5Fe+l7CoMMOMEB8tra6hFnytzR4P38c9c7q52bmeygRRjGGgZR3Vx9awrqLORv72GWBLVNtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133914; c=relaxed/simple;
	bh=z/wP08F4XLl8xr8rBaIeLysK1RTf0qiDz6dJBx54WGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cU9F30YphgTuquRTkTeqdem7y48tcesEe68AQkrbmQyQDn+WzsJ4ySgLWrwFIyKhX7SBsPxD1D33utddZkS/OOajsPBjbJ2s5Z0DTjf4bANo/pV/Sr6nzEUFJzR1FtxMOxAeAJfUbA72upFNRgrhpBUiK99LJfF3wK1CE/ZLonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xteuARAc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70eb4de4eb9so4852479b3a.2
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 23:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724133906; x=1724738706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=10IGmDK6vVQONppS0ZoKRqZPmK4GV7o8/7Q997RBAno=;
        b=xteuARAcIEteD2anRIM4OKaPTvFLEIkRqRjkyVdjJvRonbB4qpk+i40s57tPq2wPkk
         zdFFY9MzxkyF2gcOjWv3L178ggH7+Dx+FAJwccksaB878bZBWyNbfsQhP2D9RnKIq1Gm
         TUopiEEFZqRgzjRzb+sDaqlfLxcE8u8/TSonbSi1xqMEvmWq1rlJKoBW2Ewxpx1ux9uG
         23ktzbvWle5s34MsEJ5LxB9E3GM+bVvppc/Q/hAFQ9SCg44o6fSG6sCKDExRK+71ofF9
         xlVW1Fw+d8eXRP0JoW0pnu7ovgr1IZNr00eM0pY+T5LUi2Bv5jq38BpGyltDbgU8AA5T
         Li4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724133906; x=1724738706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10IGmDK6vVQONppS0ZoKRqZPmK4GV7o8/7Q997RBAno=;
        b=Z9+fOTPI9kCO4AaRm2/HMdBFWA4IdOASICBvQ/3O27tFIHX1ISXbzcAU735LcqltWf
         F5JI7MH36KNah5X6gQRAFU/TKHxYZ+Oz1tRuZ3OUEkyySRaAZT24IlaKA890rH2qI3rh
         h1Kc5nQgrW6KEjnryyYXa4em2DmLmPP3uV3i/Fb5ijra6wGbNoxltmj3hynnUQCoahDF
         lK75iPbNXAz/GsSfC3kFn5qAjtk/HdAScTXb69U2Q62WbX5yW6bgVdSucnBTlC6Z4J0v
         Rw1WkdIwlmsi/SKFEGH4hjMviZ+98fyPqPbNCfZiCtg+odl1xzh7iMTsS7L2o3KnSKsg
         ny7A==
X-Forwarded-Encrypted: i=1; AJvYcCWVzH5QTeFTPQepPHoxOvpZQvHl9N4RT3C/q/ItJ+/aSiosEnvi1x65lLy7oFwZjepCDfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAtp96JTRlLB56yxzRSGKWfqCy6qG0xvJ0doQCK+QetapEGkg
	D4y9DJwhRStAGQV68TEDXqxTlxNXlAQxkvxoQD71RRe181cUHG0O8LPyIR1cSOoRg0LGiO8Vr9r
	6o7Fd8BtlDt5vShBGGbVWzA==
X-Google-Smtp-Source: AGHT+IGGDDJJOlW/qbbvZl0spAXBnd1H/egjrD+ZFgYp/a6xssIRDA3pdPhIjGNJKo3CWfILJy2FFl1udqpvsNd8iA==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:6a00:6f14:b0:706:3153:978a with
 SMTP id d2e1a72fcca58-713c82bafe2mr169807b3a.6.1724133905516; Mon, 19 Aug
 2024 23:05:05 -0700 (PDT)
Date: Tue, 20 Aug 2024 06:04:47 +0000
In-Reply-To: <20240820060456.1485518-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240820060456.1485518-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240820060456.1485518-5-almasrymina@google.com>
Subject: [PATCH net-next v21 04/13] netdev: netdevice devmem allocator
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
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement netdev devmem allocator. The allocator takes a given struct
netdev_dmabuf_binding as input and allocates net_iov from that
binding.

The allocation simply delegates to the binding's genpool for the
allocation logic and wraps the returned memory region in a net_iov
struct.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

---

v20:
- Removed dma_addr field in dmabuf_genpool_chunk_owner not used in this
  patch (moved to later patch where it's used).

v19:
- Don't reset dma_addr on allocation/free (Jakub)

v17:
- Don't acquire a binding ref for every allocation (Jakub).

v11:
- Fix extraneous inline directive (Paolo)

v8:
- Rename netdev_dmabuf_binding -> net_devmem_dmabuf_binding to avoid
  patch-by-patch build error.
- Move niov->pp_magic/pp/pp_ref_counter usage to later patch to avoid
  patch-by-patch build error.

v7:
- netdev_ -> net_devmem_* naming (Yunsheng).

v6:
- Add comment on net_iov_dma_addr to explain why we don't use
  niov->dma_addr (Pavel)
- Refactor new functions into net/core/devmem.c (Pavel)

v1:
- Rename devmem -> dmabuf (David).

---
 include/net/devmem.h | 13 +++++++++++++
 include/net/netmem.h | 17 +++++++++++++++++
 net/core/devmem.c    | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/include/net/devmem.h b/include/net/devmem.h
index c7bd6a0a6b9e..2e7cc46d4d3c 100644
--- a/include/net/devmem.h
+++ b/include/net/devmem.h
@@ -69,7 +69,20 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding);
 void dev_dmabuf_uninstall(struct net_device *dev);
+struct net_iov *
+net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
+void net_devmem_free_dmabuf(struct net_iov *ppiov);
 #else
+static inline struct net_iov *
+net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
+{
+	return NULL;
+}
+
+static inline void net_devmem_free_dmabuf(struct net_iov *ppiov)
+{
+}
+
 static inline void
 __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 {
diff --git a/include/net/netmem.h b/include/net/netmem.h
index 41e96c2f94b5..0fbc0999091a 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -16,6 +16,23 @@ struct net_iov {
 	struct dmabuf_genpool_chunk_owner *owner;
 };
 
+static inline struct dmabuf_genpool_chunk_owner *
+net_iov_owner(const struct net_iov *niov)
+{
+	return niov->owner;
+}
+
+static inline unsigned int net_iov_idx(const struct net_iov *niov)
+{
+	return niov - net_iov_owner(niov)->niovs;
+}
+
+static inline struct net_devmem_dmabuf_binding *
+net_iov_binding(const struct net_iov *niov)
+{
+	return net_iov_owner(niov)->binding;
+}
+
 /* netmem */
 
 /**
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 0787311a8cdf..831a637a86f4 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -35,6 +35,14 @@ static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
 	kfree(owner);
 }
 
+static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
+{
+	struct dmabuf_genpool_chunk_owner *owner = net_iov_owner(niov);
+
+	return owner->base_dma_addr +
+	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
+}
+
 void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 {
 	size_t size, avail;
@@ -57,6 +65,36 @@ void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 	kfree(binding);
 }
 
+struct net_iov *
+net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
+{
+	struct dmabuf_genpool_chunk_owner *owner;
+	unsigned long dma_addr;
+	struct net_iov *niov;
+	ssize_t offset;
+	ssize_t index;
+
+	dma_addr = gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
+					(void **)&owner);
+	if (!dma_addr)
+		return NULL;
+
+	offset = dma_addr - owner->base_dma_addr;
+	index = offset / PAGE_SIZE;
+	niov = &owner->niovs[index];
+
+	return niov;
+}
+
+void net_devmem_free_dmabuf(struct net_iov *niov)
+{
+	struct net_devmem_dmabuf_binding *binding = net_iov_binding(niov);
+	unsigned long dma_addr = net_devmem_get_dma_addr(niov);
+
+	if (gen_pool_has_addr(binding->chunk_pool, dma_addr, PAGE_SIZE))
+		gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
+}
+
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 {
 	struct netdev_rx_queue *rxq;
-- 
2.46.0.184.g6999bdac58-goog


