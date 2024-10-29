Return-Path: <bpf+bounces-43414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339AD9B53AD
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 21:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6553A1C22CC6
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 20:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D347209691;
	Tue, 29 Oct 2024 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C3tvZs9R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D465207A03
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233715; cv=none; b=dA/TBoxSEvgI1OvKrdwLiuNd+yU1XI29LsI+Zgps7+D21iEKBLhhi5NgqF6cyl2PpTdTL2l8U/RWERjB5658NEj4C26tPAkoInHRnyGlKXAQ5CKPZ+7RGeBE7W4qVFfgdDuDbodnqV7a9S6bOoNgwlJseYiQ7x3zp+aOkDjFeN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233715; c=relaxed/simple;
	bh=XgU1S587L1KF0F6meIVhE+CM9m7QZIs3PRbmQItDE9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TG2zbZKP234QS8mEdgUrqo2lU/UHv0Aby2ObPNKx2+qvshbujpbWrTgcaVK5z9OKEVTtYl5le1MzsBjWjuXHFdD+mGrErpkBH64avmKaiXNjN0/Qz61iadhnaU1ferVhowdGqORK7cPBLNMXy5OeOO0CROlsS0LmhRfbRfkLvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C3tvZs9R; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbd12b38b4so31585566d6.2
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730233712; x=1730838512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BjSUPvA5x1CUaax6pPT6axwhBslSTkTdYv/QYqZdXCY=;
        b=C3tvZs9RKJxfEpHJuzgPATa0PeFMQwMP1bzvgJBxM8/KwLYeD+5Ml+bG+onDtfhC4g
         0Zv6O6CDq+4FhvmnKFHUi6E0+a1mS1+rYm5F1P8LycWzPKveeMB2Gi4HZv2yqc0ZQdo4
         5XSKvGBiqEt7NtGtkmFkqBKvNAq/nfWeZT9z+dKiA78Wu4O2blvSV7yL+AuJ8YWCcHkq
         g6cKULuU43bEgJzF3ihPV4+R9thJcHpsaz7uXDa3mcivEzDA1NiI0WF8fae1Yd6SRr/2
         Id8V3vf1eYAfic+tma95xueqhGDscz9B3/4ywJivVYvm+cg00L+Jz4ghsR2lIR7iamZt
         q2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233712; x=1730838512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjSUPvA5x1CUaax6pPT6axwhBslSTkTdYv/QYqZdXCY=;
        b=eLj/rhEU8gtgJ55Ptj2gEm44iyZUmeUctdNigMhRxoHJjizbmRFeYXuKl+5E5ccTVC
         4eSydkDTxMskM/ScXZzfh1pZGQvnZ0w+h/BB0PboIAuo4N0VnCOjNaaItl1yR7Q3OeLK
         D0J1qhEUE+PKRHzlqj8b7ttwx88DZnz6mE8iHtjUYff3twvTu3tqhMqn8yQQYPlQtR8f
         +/PnLsJXYUf66CfBKYqo7SlSLsqAgGXadcgZRMyWN9a9wrqOS+lNFS4o/iWIgLDTEoKZ
         EMCsulwiaRcdf0ZLxpqR3hPXHGBIae1wlQ3gQoxA2x7+Vzv+Ci+E9CtNVEVtCUU5CMVd
         VffQ==
X-Gm-Message-State: AOJu0YxIq8pIShKzsr6ojannTtRpSZY/1RYwxBAWXikbAwMqZ8CQN1QF
	I3ZgzNV2tQOfKcftef2xka/5LZl0NKMpgNVc6b1MSFJ5dx98xBZt6ynaAIW1absqqleSbCZPCJB
	n
X-Google-Smtp-Source: AGHT+IGAaEACsZBbX0HKTTDxyTlPCwMr24OuFZsAdTacHaIkLUhbIoWSm6kTsugSKNhzqf8LNjkAVw==
X-Received: by 2002:a05:6214:b10:b0:6d1:87bc:1931 with SMTP id 6a1803df08f44-6d187bc19b1mr144292816d6.50.1730233712329;
        Tue, 29 Oct 2024 13:28:32 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a09498sm45281656d6.93.2024.10.29.13.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:28:31 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	cong.wang@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH bpf] bpf: Add sk_is_inet check in tls_sw_has_ctx_tx/rx
Date: Tue, 29 Oct 2024 20:28:30 +0000
Message-Id: <20241029202830.3121552-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

As the introduction of the support for vsock and unix sockets in sockmap,
tls_sw_has_ctx_tx/rx cannot presume the socket passed in must be inet.
Otherwise, tls_get_ctx may return an invalid pointer and result in page
fault in function tls_sw_ctx_rx.

BUG: unable to handle page fault for address: 0000000000040030
Workqueue: vsock-loopback vsock_loopback_work
RIP: 0010:sk_psock_strp_data_ready+0x23/0x60
Call Trace:
 ? __die+0x81/0xc3
 ? no_context+0x194/0x350
 ? do_page_fault+0x30/0x110
 ? async_page_fault+0x3e/0x50
 ? sk_psock_strp_data_ready+0x23/0x60
 virtio_transport_recv_pkt+0x750/0x800
 ? update_load_avg+0x7e/0x620
 vsock_loopback_work+0xd0/0x100
 process_one_work+0x1a7/0x360
 worker_thread+0x30/0x390
 ? create_worker+0x1a0/0x1a0
 kthread+0x112/0x130
 ? __kthread_cancel_work+0x40/0x40
 ret_from_fork+0x1f/0x40

Fixes: 0608c69c9a80 ("bpf: sk_msg, sock{map|hash} redirect through ULP")
Fixes: e91de6afa81c ("bpf: Fix running sk_skb program types with ktls")

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 include/net/tls.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 3a33924db2bc..a65939c7ad61 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -390,8 +390,12 @@ tls_offload_ctx_tx(const struct tls_context *tls_ctx)
 
 static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
 {
-	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_context *ctx;
+
+	if (!sk_is_inet(sk))
+		return false;
 
+	ctx = tls_get_ctx(sk);
 	if (!ctx)
 		return false;
 	return !!tls_sw_ctx_tx(ctx);
@@ -399,8 +403,12 @@ static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
 
 static inline bool tls_sw_has_ctx_rx(const struct sock *sk)
 {
-	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_context *ctx;
+
+	if (!sk_is_inet(sk))
+		return false;
 
+	ctx = tls_get_ctx(sk);
 	if (!ctx)
 		return false;
 	return !!tls_sw_ctx_rx(ctx);
-- 
2.20.1


