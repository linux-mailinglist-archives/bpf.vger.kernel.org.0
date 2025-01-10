Return-Path: <bpf+bounces-48526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ECBA08A68
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 09:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E564188986F
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 08:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE32F20ADE2;
	Fri, 10 Jan 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZanrMgX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C912208979
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498138; cv=none; b=a0/sxv3w++LxZqy6M/VsO0qJXuW22/g/p0WfO7kLkUmxMsG5gM+D3BXAUdSc9pzTWnjRO7nNut50inhfvSHf4BzGCpeg/DqUiHEzpUMbBsqnt0h/p+BCLnS8MIcj/V4zg3tMiVW0IDIQWKhHImhbuqRd1fcCpo3IBzYfATBV+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498138; c=relaxed/simple;
	bh=QjfOQgTaUWrmSTlG/geSr55nIlTbnhvRsiGytk5OSls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEoNmfYhQOHP3qd0iA7t/QDX+tMByP0kzm9Rr+H5+QK0eIP2t/GL+OtyG1N+VGg39SStdRwqGvCQ4CASARk7GzJRHPXRYvrjpjIpwZsT0lOiwiLpfTsNLyYnTQVS/gpKhoku7WAGb00EqQdRZk194RNfdIPYlsE29fL/XA4pSKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZanrMgX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBLDY4DTw2zaWMjga9j81VUizG/Z+zQDnv2kJoLZ4eU=;
	b=NZanrMgXpBV3R/3XasJAoMyv8/AGj9S10YT3QUZA08R85lje4u7gEfPIZbSz3jY1U+wFnR
	aTXmpXDawB5sO0OK14rsTiJoh8E+c7gyclXOi4jo6JzhnCK2Wf3UUCUwKqe92emg+d8phA
	nV+gnEzSrMP2R67HvesGkg+A5vPmCJ8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-pC3Ub7mTPLGxq61bPMBuLw-1; Fri, 10 Jan 2025 03:35:34 -0500
X-MC-Unique: pC3Ub7mTPLGxq61bPMBuLw-1
X-Mimecast-MFC-AGG-ID: pC3Ub7mTPLGxq61bPMBuLw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d51ba2f5so930918f8f.2
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 00:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498133; x=1737102933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBLDY4DTw2zaWMjga9j81VUizG/Z+zQDnv2kJoLZ4eU=;
        b=FZPvug/CkdFxSGO+Q3689ewMxwwKOCe2sVMWrI/ClC+N+jXRDGYp+9TJJXGHDbwon2
         EHFTiHWeR1MgD0awrhgJ2vZkkXCguLSf+o6PajQJxa5snunHCVfbZFBl/zqlvSqXqGjW
         SBZ+EZ+URGLuYejJBIvi+FZ9lXmrEPLcLWE911MAjum7PyETe1VNN0+kVEglogNbAc8/
         gQFneDU25dshBDt6A/7mCL5d6+Dr+qfZk3N/9n6jUC0dS6JrrTKO3Tp/VLOneN+fK3N6
         hu2yfp7fhRmxop5HbLPvfnigK+HMojChIRkzyGwnIXlIJjLveUr8zCXapENU0FHEFhNI
         TjNA==
X-Forwarded-Encrypted: i=1; AJvYcCVE4byqJDe/xdthzFsvY3cy67eFBIwhkK+vXdWtQ9zhxBcdGZvrmxmosL0ELJSUSpt/7q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+V0n5WBu/OsxC3X+8CZ+NE1f1i5I64fXzIrKVRoaKYvuZAOr
	0oZ8A+lb4ir+erotLQYLgXX29C05td96dIa9CD6pKuzrTVNG3/+dsR4U5Ejjp3pjYWrERXwHR5Q
	eil7/H7iVlmVSI7PW2M63nbtcyxd0G7fSf1TpcjR1541ONLgIiA==
X-Gm-Gg: ASbGnct7EwTMNaiFIhAIEynTFei/q0m+iHayud0eTpEEcMylkTTJGCGtqnpOIFfQbHR
	mBZHcYeZWu94xWrHY6jPK7FktI9g0M/sfZ0zwD0aw9/FP6zLW7Hz1fQRR0s9DE5qA0kC48E75Jd
	4uQapPtsBrfCctcZViuHuupR01FGBvR383FxAUWOWqb9QXUUp0NIFujhlE9fIdliFwffWBMCeg7
	LsfY/t4JWzwqePKrn4DEU889EfR0DG13lVeB+mzkV0B9HY=
X-Received: by 2002:a5d:64eb:0:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-38a87312d2emr8464165f8f.32.1736498133296;
        Fri, 10 Jan 2025 00:35:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkY+6wyisWu9I5OnlNIAEaCc1RkfYRMe4WOOPOqI9L+4Q6XFHZJA9lRe1HqGdOwc7Z+AC+ww==
X-Received: by 2002:a5d:64eb:0:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-38a87312d2emr8464107f8f.32.1736498132691;
        Fri, 10 Jan 2025 00:35:32 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dcc8ddddsm73101805e9.0.2025.01.10.00.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:31 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wongi Lee <qwerty@theori.io>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hyunwoo Kim <v4bel@theori.io>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/5] vsock/virtio: cancel close work in the destructor
Date: Fri, 10 Jan 2025 09:35:09 +0100
Message-ID: <20250110083511.30419-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110083511.30419-1-sgarzare@redhat.com>
References: <20250110083511.30419-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During virtio_transport_release() we can schedule a delayed work to
perform the closing of the socket before destruction.

The destructor is called either when the socket is really destroyed
(reference counter to zero), or it can also be called when we are
de-assigning the transport.

In the former case, we are sure the delayed work has completed, because
it holds a reference until it completes, so the destructor will
definitely be called after the delayed work is finished.
But in the latter case, the destructor is called by AF_VSOCK core, just
after the release(), so there may still be delayed work scheduled.

Refactor the code, moving the code to delete the close work already in
the do_close() to a new function. Invoke it during destruction to make
sure we don't leave any pending work.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Reported-by: Hyunwoo Kim <v4bel@theori.io>
Closes: https://lore.kernel.org/netdev/Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX/
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++-------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 51a494b69be8..7f7de6d88096 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -26,6 +26,9 @@
 /* Threshold for detecting small packets to copy */
 #define GOOD_COPY_LEN  128
 
+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
+					       bool cancel_timeout);
+
 static const struct virtio_transport *
 virtio_transport_get_ops(struct vsock_sock *vsk)
 {
@@ -1109,6 +1112,8 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
 
+	virtio_transport_cancel_close_work(vsk, true);
+
 	kfree(vvs);
 	vsk->trans = NULL;
 }
@@ -1204,17 +1209,11 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
 	}
 }
 
-static void virtio_transport_do_close(struct vsock_sock *vsk,
-				      bool cancel_timeout)
+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
+					       bool cancel_timeout)
 {
 	struct sock *sk = sk_vsock(vsk);
 
-	sock_set_flag(sk, SOCK_DONE);
-	vsk->peer_shutdown = SHUTDOWN_MASK;
-	if (vsock_stream_has_data(vsk) <= 0)
-		sk->sk_state = TCP_CLOSING;
-	sk->sk_state_change(sk);
-
 	if (vsk->close_work_scheduled &&
 	    (!cancel_timeout || cancel_delayed_work(&vsk->close_work))) {
 		vsk->close_work_scheduled = false;
@@ -1226,6 +1225,20 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
 	}
 }
 
+static void virtio_transport_do_close(struct vsock_sock *vsk,
+				      bool cancel_timeout)
+{
+	struct sock *sk = sk_vsock(vsk);
+
+	sock_set_flag(sk, SOCK_DONE);
+	vsk->peer_shutdown = SHUTDOWN_MASK;
+	if (vsock_stream_has_data(vsk) <= 0)
+		sk->sk_state = TCP_CLOSING;
+	sk->sk_state_change(sk);
+
+	virtio_transport_cancel_close_work(vsk, cancel_timeout);
+}
+
 static void virtio_transport_close_timeout(struct work_struct *work)
 {
 	struct vsock_sock *vsk =
-- 
2.47.1


