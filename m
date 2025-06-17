Return-Path: <bpf+bounces-60784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF505ADBE12
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 02:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5163B7AD4
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 00:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE17E153BED;
	Tue, 17 Jun 2025 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNnOH2QI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E014C5B0;
	Tue, 17 Jun 2025 00:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750119770; cv=none; b=PW+WEASmMu2URZFw7rCxQM6q+MzMVhcR40mK7DKJBHuBsKlzaTnxwC/rJJF7S5iOc5kGHoe9O3BUXGpG+pmQxhimbsrvOUMsQ5BcqK1aaNH/oeCOGaTcx+Ge6lNfZC5U3RBAkdOCQZm6M/mqfQff8quCWQ78kDmwo0jmk9pJ4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750119770; c=relaxed/simple;
	bh=0oMNTrjJ5mBlFK3WFTCa8yIwRp9BprqheNSskY3veN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vodp2QyauWsSmf2wPpE87zatsgTRoNvdlBQu3ikfFVtkYJmhoDMbs8P0PSN08EtTJFizdOEElFKq6Gcp3heo5tTiLsGFDUulNzeac/cQ611UXi0y/fKU9Lw9U0r2sUer98XJNw10XjPoHvpas9WPzuNZqOpGts0SDWaGlXm5354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNnOH2QI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74877ac9d42so3193945b3a.1;
        Mon, 16 Jun 2025 17:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750119768; x=1750724568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeJD9wKyLLpFIsA5ncT/RAbofdGZWGxOOArLLFRMAvQ=;
        b=RNnOH2QIS0AYz2xryUI0C4T37iaRIeEu8W3gN6JySsda02WJ9PHQVC3XmG3SpVYpxp
         yTN8sJ5l4uY1wPRfIgk/dyT8CsIbobnFTPCYtXvLvrNF05cMe978qe7sN264TQK1fTIz
         DkHo5VxcAjpa0aMGsKNbj2ZJEXYmJsBNuQAEJ6RW5k1Lj8ZBJzfJFMaGaVkdlh+j0VCL
         C3IUBkVLB4kLc2leNS0xB9aHsdEAOfZSdrHh6Hz12f6AmiC7S9G2wJ9KIT6+padkHQBV
         l97W9M8psRKxPc7lkc8VFqew33wsWs9g32F2cZXJDolBLve/02zwQy3tMnTJCHe07EIk
         5fEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750119768; x=1750724568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeJD9wKyLLpFIsA5ncT/RAbofdGZWGxOOArLLFRMAvQ=;
        b=goLP/ZBlLjZaYQTQ9IH3JIgeOHEYTfnPklM0RiPg6njZnmw2OVoIeu0dQzuGN2vpmq
         4zGCeGX8JMfTTcflV4mnjhLl2o8qLWxlcn9fDxyrUCuC5T1KS3dgmejfnYK1s4PYiCvd
         3va/FSYQvJDA9xaOiyXiwaZsKpKMULx4QJu27xA+pfRkFufEVbXgLmITcQmrrxGR9FuP
         TFz8fnFWeoY49tLYAoWS07ELZAqJXE3Io7W2KlM/KNRz/I+RlxjIhhsbri8/j8aH8slZ
         lM85WrBNVkwfjgfH1GxQcU91wO3som/qDrMIiEeZE2Bv3YAInJRlxeJj6ScQaiZ7uk8f
         juZA==
X-Forwarded-Encrypted: i=1; AJvYcCXJP8hWLIlxXVo5UVtqFJ7JrvZqu6zsMoc8a+cR47VIHt3QN0Pawr2Y4CniVS4HCkJp8oFoOtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pOp9Yf7tMGvLDQ15cPnXb1+dlYJQcFZTjiJPl9Ql/FwS2XqW
	2UDBgQ/krdNBsEr2lJKzVbEGHxktKVets7a/uslcd/dnVDbG/1cIiqpH
X-Gm-Gg: ASbGnctKMphnHkNQ8RzkIYcnBAtiojcfGhmmw0c0lDqm69piyNWOvqj7rV6RxAGx0r3
	9vp0FY/DBEARz9xDlQthYPdrf6RUhowbEPFZL4E7rClczPknM2+znj1lA8j7+couzP5u9VHsugc
	5CvOp+FUT025GNQQIZ3/HGGE+42l3q1P/C7blKad8z4Un6RM244n2Emxu9fRcdg1ZD/+BXuuLT2
	u6e78XchqYxaqI2ZUG085+PzuHAEnTskAwygnfE9kIAZq/ixT+G5WAaYsepVhh3p+YYv04MNAL1
	g7fZzzmoEDGEasCTX55H4mSp0EtSGp6SrO8YaLwKQyH24jaMsZXLL8wEKJMuFnFladVDcUrz2LW
	uuduscJEi3Ix7fTTZ7BKpvYe/
X-Google-Smtp-Source: AGHT+IHbmkLIDLKHR7ue3VcIQHUYdjijcgHnS26Mt2ZAUpP2++chfwIWwLfmtOV3K791PcykXyutNg==
X-Received: by 2002:a05:6a00:2e1a:b0:740:b372:be5 with SMTP id d2e1a72fcca58-7489ce45fe5mr13390389b3a.9.1750119767974;
        Mon, 16 Jun 2025 17:22:47 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.27.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d252esm7488606b3a.163.2025.06.16.17.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 17:22:47 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/2] net: xsk: make MAX_PER_SOCKET_BUDGET tunable
Date: Tue, 17 Jun 2025 08:22:35 +0800
Message-Id: <20250617002236.30557-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250617002236.30557-1-kerneljasonxing@gmail.com>
References: <20250617002236.30557-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Make MAX_PER_SOCKET_BUDGET tunable and let users decide how many descs
they expect to peek at one time.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/hotdata.h      | 1 +
 net/core/hotdata.c         | 3 ++-
 net/core/sysctl_net_core.c | 7 +++++++
 net/xdp/xsk.c              | 6 ++++--
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index fda94b2647ff..2df1e8175a85 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -40,6 +40,7 @@ struct net_hotdata {
 	int			sysctl_max_skb_frags;
 	int			sysctl_skb_defer_max;
 	int			sysctl_mem_pcpu_rsv;
+	int			sysctl_xsk_max_per_socket_budget;
 };
 
 #define inet_ehash_secret	net_hotdata.tcp_protocol.secret
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index 0bc893d5f07b..5131714eee63 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -19,6 +19,7 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 	.dev_rx_weight = 64,
 	.sysctl_max_skb_frags = MAX_SKB_FRAGS,
 	.sysctl_skb_defer_max = 64,
-	.sysctl_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE
+	.sysctl_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE,
+	.sysctl_xsk_max_per_socket_budget = 32
 };
 EXPORT_SYMBOL(net_hotdata);
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 5dbb2c6f371d..9f9946b7ffc0 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -640,6 +640,13 @@ static struct ctl_table net_core_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
+	{
+		.procname	= "xsk_max_per_socket_budget",
+		.data		= &net_hotdata.sysctl_xsk_max_per_socket_budget,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec
+	},
 };
 
 static struct ctl_table netns_core_table[] = {
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72c000c0ae5f..95027f964858 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -28,13 +28,13 @@
 #include <net/netdev_lock.h>
 #include <net/netdev_rx_queue.h>
 #include <net/xdp.h>
+#include <net/hotdata.h>
 
 #include "xsk_queue.h"
 #include "xdp_umem.h"
 #include "xsk.h"
 
 #define TX_BATCH_SIZE 32
-#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
 
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
@@ -424,7 +424,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 	rcu_read_lock();
 again:
 	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
-		if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
+		int max_budget = READ_ONCE(net_hotdata.sysctl_xsk_max_per_socket_budget);
+
+		if (xs->tx_budget_spent >= max_budget) {
 			budget_exhausted = true;
 			continue;
 		}
-- 
2.43.5


