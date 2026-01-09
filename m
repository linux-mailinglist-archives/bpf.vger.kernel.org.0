Return-Path: <bpf+bounces-78306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11301D08EDF
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 12:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6617330EECEB
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 11:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0704B35B13D;
	Fri,  9 Jan 2026 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHHhRw72"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4F6359F80
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958152; cv=none; b=o88V1lXjQZ5cZdN63txQPR8DTVrN9J4N5NeN+PeIBzf05QxuPStELkCPvhHDs4SmXX45dFGi7DWz3BD65v8t/uibZNCRCKCFVzuQB6EGXkrBylDV27ejUys6nz6NAmhQ6qtY0BclZeMFActzBph2BhRj1xbUD6sKnK8/2c2B4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958152; c=relaxed/simple;
	bh=hKOxjq4fxJ+iQfib8Cm75gZgmDPHfB9Dr0qLWGLYXFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpoxmojvt8indru7tfW7Hjly5q3qvmybKd1AFQYJfjBAtI/6rC+NuF0iGUGGGdP/iIj2OUH0iFxDXEXi5AHt3IzQDncWy+79D0ff/DmD+B5FjDHrP35xOkIWWZ2v2Zglcg/Ov0ILCl+UPVnrnvR/m2VCg06wpBqFKLNpwqjFI9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHHhRw72; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so29123885e9.2
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 03:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767958146; x=1768562946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWL7hbAkNRsIM9hHu4g4BkFlYyqPgZDU68a7iQIhzDo=;
        b=HHHhRw72TWPZCJ341hwOHL6/05wsgcs23mXP7RxJGEyIoqolIVbOMIqTOfpQt19zRM
         05n786aOs0DWt84e8XLXAC5urr/+RJonEsXhgsyEH819l3O5KdywIuIfw0WnfhAmedEg
         uElfdPLyHABR9T9kn2/wImSEOSjFbFraxvGE4IWOrY27GvqYIpRjZdw0Tasra0/Bjn9X
         T2ihfDVlOFFSlA0l5EaD/n4v4vOGSjXZHeH81b4UhXAztYFI/Pix/7Hn/20PAtoPvrO0
         5dG/AjptJRhve38dtYwUa/tU1t2/T36wZ7vM52kc4sQM6AhFBe28pqD+JAL4a8l7eHnk
         rDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767958146; x=1768562946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWL7hbAkNRsIM9hHu4g4BkFlYyqPgZDU68a7iQIhzDo=;
        b=DY5dLEBIs45iIyMrsaqjDvCVe+vfXuqkX1Nb8ybhsa2ft8EEivdsys+43UaFyL572V
         thftjWyhJb5IAoGibmp6BarRlxCPrmWOzetlevoHh08NGQTrQ46cY6p280i565w7zGcw
         dGxnTaFWmmGTBFzkIvWPqQuy0MFmz0calBEcVt4M0LaWdDLN+RlDGZD+nfnKCpPgXCKh
         x14MKuRcNbAIxnYFy9p6WKTMO4RRuqgXA9174UKNava/IYOVBmZkrMuS1RO6oWXyNZgi
         dbZJz6YxTL8AUimdqoqSzKvfJnSGPP6lOilGQe39Vwm6UtbWH1XZFkSWCdlvNbIpiK6o
         V0HA==
X-Forwarded-Encrypted: i=1; AJvYcCUEnoFH924O4oTfgKY9Dm8yX1ipoZFjWINwhx+TxLTPSJGIc9nxpCATQuH1+NKBLfwPQ+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7OzlFQmuC6GLQxfMmqmBCoSQgGC3mUuKIgaTfkMgmP+QW8RBR
	m+YdZCjIhPmgAxAFyhuugetilKynYPA/0DidoJqyfaQGN9Nj00MUy7bO
X-Gm-Gg: AY/fxX5H4NXxfrfCgTQqSvGxCsjwrNXrwx7pEQZSn1PUdG9WyE6EPYl07Pt/mBWjKqx
	p+K33WtQ6bHrQNcjmymlw3lTda+a6XJ3avOzIPN0AcOv58qzA25ceUFrfYvfAPy2oHBYnOWRuN6
	d1hubmAeZfTO3r1fIRWl7+4YrtUroPWwU6ePlhcb+srtgQhUM2mds2TvynnEGF3HQo6ffJcYmlQ
	znXdgGoQQYdSYVdrsnc9b1YawAFFYFiCiv9yV5rHIWb1S3QDf8xtf82jPrfgst3lsMcjmp8/qdp
	yy1OZy7Wrt32nPC/5FVC2xGJIjhtoryP+WyQEnyb+2YSbTvQFXPlDHCNskdPXIHYeWZJAPlenPp
	YzBZh57K7iY5mqpWdVjobVNUp4rZql3vfFTsoM20PA0lIptl61FzR5+Gst30vQt6KTgFYWAW5J0
	c/M+RUzXg9InXWzXbB3VZ/R2nCzS82mJfMhIsNRK6qkVJZjHdNySwnRoa8RcfoVBpc2TAUkQ==
X-Google-Smtp-Source: AGHT+IEtu//eEPFSMQCQc0x4+ohl+/zP3PbtVY9Fq75VCKqTNmy1GQDGxEUmS6COuOk11FJ2AmC1hg==
X-Received: by 2002:a05:600c:1f8c:b0:477:7d94:5d0e with SMTP id 5b1f17b1804b1-47d84b40955mr99606675e9.27.1767958145751;
        Fri, 09 Jan 2026 03:29:05 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:69b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636c610sm60056985e9.0.2026.01.09.03.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:29:05 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v8 4/9] net: pass queue rx page size from memory provider
Date: Fri,  9 Jan 2026 11:28:43 +0000
Message-ID: <da8aa10eaa0e4dce52a0b39ed7e3829eb70e22f5.1767819709.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767819709.git.asml.silence@gmail.com>
References: <cover.1767819709.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow memory providers to configure rx queues with a custom receive
page size. It's passed in struct pp_memory_provider_params, which is
copied into the queue, so it's preserved across queue restarts. Then,
it's propagated to the driver in a new queue config parameter.

Drivers should explicitly opt into using it by setting
QCFG_RX_PAGE_SIZE, in which case they should implement ndo_default_qcfg,
validate the size on queue restart and honour the current config in case
of a reset.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h   | 10 ++++++++++
 include/net/page_pool/types.h |  1 +
 net/core/netdev_rx_queue.c    |  9 +++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index f6f1f71a24e1..feca25131930 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -15,6 +15,7 @@ struct netdev_config {
 };
 
 struct netdev_queue_config {
+	u32	rx_page_size;
 };
 
 /* See the netdev.yaml spec for definition of each statistic */
@@ -114,6 +115,11 @@ void netdev_stat_queue_sum(struct net_device *netdev,
 			   int tx_start, int tx_end,
 			   struct netdev_queue_stats_tx *tx_sum);
 
+enum {
+	/* The queue checks and honours the page size qcfg parameter */
+	QCFG_RX_PAGE_SIZE	= 0x1,
+};
+
 /**
  * struct netdev_queue_mgmt_ops - netdev ops for queue management
  *
@@ -135,6 +141,8 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  *
  * @ndo_default_qcfg:	Populate queue config struct with defaults. Optional.
  *
+ * @supported_params:	Bitmask of supported parameters, see QCFG_*.
+ *
  * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
  * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
  * be called for an interface which is open.
@@ -158,6 +166,8 @@ struct netdev_queue_mgmt_ops {
 				    struct netdev_queue_config *qcfg);
 	struct device *	(*ndo_queue_get_dma_dev)(struct net_device *dev,
 						 int idx);
+
+	unsigned int supported_params;
 };
 
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 1509a536cb85..0d453484a585 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -161,6 +161,7 @@ struct memory_provider_ops;
 struct pp_memory_provider_params {
 	void *mp_priv;
 	const struct memory_provider_ops *mp_ops;
+	u32 rx_page_size;
 };
 
 struct page_pool {
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 86d1c0a925e3..b81cad90ba2f 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -30,12 +30,21 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	    !qops->ndo_queue_mem_alloc || !qops->ndo_queue_start)
 		return -EOPNOTSUPP;
 
+	if (WARN_ON_ONCE(qops->supported_params && !qops->ndo_default_qcfg))
+		return -EINVAL;
+
 	netdev_assert_locked(dev);
 
 	memset(&qcfg, 0, sizeof(qcfg));
 	if (qops->ndo_default_qcfg)
 		qops->ndo_default_qcfg(dev, &qcfg);
 
+	if (rxq->mp_params.rx_page_size) {
+		if (!(qops->supported_params & QCFG_RX_PAGE_SIZE))
+			return -EOPNOTSUPP;
+		qcfg.rx_page_size = rxq->mp_params.rx_page_size;
+	}
+
 	new_mem = kvzalloc(qops->ndo_queue_mem_size, GFP_KERNEL);
 	if (!new_mem)
 		return -ENOMEM;
-- 
2.52.0


