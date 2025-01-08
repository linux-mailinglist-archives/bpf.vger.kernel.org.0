Return-Path: <bpf+bounces-48275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67584A063F8
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 19:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90274165282
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453DA202C2D;
	Wed,  8 Jan 2025 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxuBkGJG"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F759201271
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359592; cv=none; b=OBLxhCj0OzieSFFv7gYtee/0h2JugX75CAiDYXfZSXosp/DRqMBqhNZHGQQFSON+Qjm7l1eubq0CaVw7TI58ff5XDErS9G2t00Mo1boAFRXl3FObzyBtqHxpY42JLNrBTv1f2BUq4tcOVRFjKNsz2eo9yFeYl1S6uXBKHc9mYeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359592; c=relaxed/simple;
	bh=XhT2B/XMcI2q+vQQF0C3xrDtTRflQwJMsW4aCd7eL48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhWnEsJZEWP0+tFXSA5+cPcMFRCjLj0RbwQWA07B2iWPaDQoijQml6V8+n37nG5C+oeRa/9p0kIcslUS2ohlkVMYRP4NHG1hjbD+BS6Z2yLnOuzCcmFYHgKnF61Lt/hVLcsPqLCTU6LUjEMxDGl0pehL5O8njE6ZQs5hCYMw2nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxuBkGJG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736359590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P81z0YmLvdT8m64Ix0hrS5vpO81KiskzyN+gGNFCQNI=;
	b=LxuBkGJGO2dzjgcQsryGFfqvRyWIt+q3CfwpTMt6LqzV6UScCHpE7cI0NXpnY+5BGH2l+T
	9+82CKERC2FkA6/8F/5HYSzOtaYrtiDtmz/yewgCtIkraD6k8AFQx89P60vqgENZvx7NMr
	OvhpyhQ4LYPewvITBoLg5/GOqmySTLc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-pMru0CXDPgur_0LwUljotg-1; Wed, 08 Jan 2025 13:06:29 -0500
X-MC-Unique: pMru0CXDPgur_0LwUljotg-1
X-Mimecast-MFC-AGG-ID: pMru0CXDPgur_0LwUljotg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385ed79291eso578495f8f.0
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 10:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736359586; x=1736964386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P81z0YmLvdT8m64Ix0hrS5vpO81KiskzyN+gGNFCQNI=;
        b=AHcTAx7wga2n1mDhO5u7XBSfsq1IbLKO3Uy0Xt+C1pCaq6hgums6MgcNTOPYh1CbMG
         TTAmXX/YaXZg6pq08iLKXHd2mQghQMqX7TB7X0mmAQiL29brZdodZYMpghBx+1dli/V9
         RgBu/IxUZDgWh6seTCeJyeX7F/etpYm/aYabqqUfmkkV3sSKfKJ8FIQxnzefNtPLf6vH
         ZiUPp2G2k9KVL12crLEE1GrGIKi1A0kywU36265AxJHNN96UfTOXB5ZdS4s4UI2x3cG4
         6bDrReg9eycDTwbKUt9r89DNs2byA5tAfeKwjelblEEw505uHzCWysrhph2sAmeK2o9P
         obfg==
X-Forwarded-Encrypted: i=1; AJvYcCUajyjAi/h/7RFh26HTe9Jy1QF4y1CAeQfypdAzgu6GdIOHHro380IaruKp5YNgP7YIv34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDhEffhmQDm+AJi65MT/hDgVFPNQ5OmT6ASKLTD3ZZC8iyRz6R
	4MecGzILioM9zKnZiDN9yTeXP4OSWhfdLFFRlIGmvJSaiMhFAe2aOCJPjrzwCK5wUScZE/KCUBs
	MEBeFEk4r/jwjLg3P9xp6bUUc+ajWfb1WQjYmbV896C3Xk/Ph1g==
X-Gm-Gg: ASbGncsZpynoo31mukX9bFgScTtsquBpFMzmSLRGu+TJnjfN/p99RCz2sDO040n7a5W
	6Yilhd0z0yS7mpnEGxgYBumw6/yrGB1+vycH9Krtk88uQUipvzEjxFAUuyZAay73awcLWVxz+5z
	39NpbYxj/YTIdAyoqUfWmssW5MpQ9defI6ooGq4Hm3/03dVwRMxomQo9xigjQ8TRbrJxThswECa
	6xRhOGVnMWX+V8IyofQl4jYcOLLC7i1uh8zOg90zSwsC3o=
X-Received: by 2002:a5d:64af:0:b0:386:1ab3:11f0 with SMTP id ffacd0b85a97d-38a8b0fa39dmr213701f8f.28.1736359586606;
        Wed, 08 Jan 2025 10:06:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyImssYlGKFMwIIkelKFtn5EBvRpRzebX/KbLVJOoRVPg+AYW6dhCm61RcqZ/eZtr4R9nAwQ==
X-Received: by 2002:a5d:64af:0:b0:386:1ab3:11f0 with SMTP id ffacd0b85a97d-38a8b0fa39dmr213656f8f.28.1736359585987;
        Wed, 08 Jan 2025 10:06:25 -0800 (PST)
Received: from step1.. ([5.77.93.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8292f4sm54344839f8f.3.2025.01.08.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 10:06:25 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wongi Lee <qwerty@theori.io>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hyunwoo Kim <v4bel@theori.io>,
	Michal Luczaj <mhal@rbox.co>,
	kvm@vger.kernel.org
Subject: [PATCH net 1/2] vsock/virtio: discard packets if the transport changes
Date: Wed,  8 Jan 2025 19:06:16 +0100
Message-ID: <20250108180617.154053-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108180617.154053-1-sgarzare@redhat.com>
References: <20250108180617.154053-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the socket has been de-assigned or assigned to another transport,
we must discard any packets received because they are not expected
and would cause issues when we access vsk->transport.

A possible scenario is described by Hyunwoo Kim in the attached link,
where after a first connect() interrupted by a signal, and a second
connect() failed, we can find `vsk->transport` at NULL, leading to a
NULL pointer dereference.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Reported-by: Hyunwoo Kim <v4bel@theori.io>
Reported-by: Wongi Lee <qwerty@theori.io>
Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9acc13ab3f82..51a494b69be8 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 
-	/* Check if sk has been closed before lock_sock */
-	if (sock_flag(sk, SOCK_DONE)) {
+	/* Check if sk has been closed or assigned to another transport before
+	 * lock_sock (note: listener sockets are not assigned to any transport)
+	 */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
 		(void)virtio_transport_reset_no_sock(t, skb);
 		release_sock(sk);
 		sock_put(sk);
-- 
2.47.1


