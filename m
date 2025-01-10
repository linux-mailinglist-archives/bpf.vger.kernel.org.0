Return-Path: <bpf+bounces-48524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC76A08A67
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 09:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 933D07A524B
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 08:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6426A209F49;
	Fri, 10 Jan 2025 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4CSYJHR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392D2080DF
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498126; cv=none; b=K/ca7JOiB/7boSptuqTAg1wyoEf/AW7k0+Sq5jX86y4kyqAlolboKD+7XmxpnOEjnTYGcZ+F+89BJAACWjYHvAQcFbMTlsQDBExgTWX8bT9igReZLNbgeO5mVREfvf875QiVypfwMWhqT0KkpjQZP75RFo1RTaYBOi0DlAmkjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498126; c=relaxed/simple;
	bh=gg9zwP3NuIW09DU6vGz9JHfMW8EBO0Kk4gY/BezPQf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KI5kAsAIG8rNOwHUEd5l2spAgg5qhF1o75dhk3cSG/6lp/kDWDy4ObZKy8PXfc54a/GPJ20BnDVA7nkl4jNh9w8l77Zno5eJw2cPIJjPRsnMDNKHmq8YJm2gqzYKPzD+IPpBLmwThzFfylUgFYQurdyxkgXYaguYuL0Fpfc/Aog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4CSYJHR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NbnJJOfD3lLHAPtW6xOg0cYnPxIPSN5ji63JO1T6TM=;
	b=f4CSYJHRpBP/Hb3JTzGF46s1rILYt43oHVpRyAp2UL6y7ZAlfZZJFzwhJV+Q4hVm/F7xdm
	hh9uwOHkO8owKGnx8tOauYOsLZvPCDyk0mqzpSjqO2FlkQFX3Bw28wRPXnhFx7sEWiUvHf
	+6QDQimY/yuoz+4qFle3y7YlZV+X484=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-67u7QNvrMR6IG_2Zg1KNQg-1; Fri, 10 Jan 2025 03:35:23 -0500
X-MC-Unique: 67u7QNvrMR6IG_2Zg1KNQg-1
X-Mimecast-MFC-AGG-ID: 67u7QNvrMR6IG_2Zg1KNQg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e27c5949so1069586f8f.3
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 00:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498122; x=1737102922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NbnJJOfD3lLHAPtW6xOg0cYnPxIPSN5ji63JO1T6TM=;
        b=TjHll/D1MmWEbPg3Nk4fN+pMd4Q1r4QY7NVcxTEE1CGqgas2VvPiTAgwGtMVP/sEiG
         3VAhsR0cGQKHyYsucEslBnkZc+rJgGnu2l4bCtI3uNLU1ijz4+uBzMuPdt0KLTqDYtHv
         qv14YMsuUHq7ttsuPtZhrFSqC61sLUIykTv3YQx4k/zVal5bbjAL3LnbFFSyjuLxTiNs
         jItpv9HJ9Zao1uHL89eoExO/TKEqkGH02hmbSOlN2BPJ8EbgFW3vDsYG72CyEPF/5S6S
         UT4G29A7Qup0/oqDOyUJTYwCGBXu8c6/gqH+5RhaT/AjNgKUlPYxVBltWfAAB2U8qbNw
         GsGg==
X-Forwarded-Encrypted: i=1; AJvYcCVoO1aDCHW9CtkvnqQZn4VVcZX0g2fW96pnMJnmzW2RGhTIzBNwn59h02Zq2CcLaQKGgWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeyD3vGd3CUa7so2Sork0SX9fbxmulSkdZxvAUf7Y+9/mJ2u9A
	+5I5afP3XSSpTscHeOeHyMoKRF+ppC5lVZT0rgYoB7d5WZL9hOd8OybrRdfCZbs2JfYeaBtqw/e
	VqoX5To1kxbFefFaY+lSnhZ4VVnCfo7fbVRvRO9I7e0xJ4UfYkw==
X-Gm-Gg: ASbGnctRMIWnKXPNh1cGCI48JYjrB1oBpMoJnYXxK9990q3HhnWV/9PqqMdLL4Pgk25
	oetXk3T+vhNWYsb3YG0xnEC84vuAC3xvUhGuYwQzWVN4x6IS1HUan/tbOUJXMriWwmtgDXjRm2Y
	0brMmfhSf/px5AjyOw0cH29Bh97XDDiuAYPGYR9gxn75RJq8jv2k7N1kfFlG17pZQl2lQOyIkBN
	/AK6/bqvJfyZmOWGKma9wD08mXb4oY4qNnbUKJkWBFil/M=
X-Received: by 2002:a5d:64ce:0:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-38a872eacdemr7037316f8f.24.1736498121726;
        Fri, 10 Jan 2025 00:35:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaMGGKjwRAwVyhTKqw23Ww9p2dwBHr6VnXJ4BcQwGregbXhxMe1Q9lXOo3WbQYlPlIlcZAdg==
X-Received: by 2002:a5d:64ce:0:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-38a872eacdemr7037271f8f.24.1736498121118;
        Fri, 10 Jan 2025 00:35:21 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c76esm3843166f8f.47.2025.01.10.00.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:20 -0800 (PST)
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
Subject: [PATCH net v2 1/5] vsock/virtio: discard packets if the transport changes
Date: Fri, 10 Jan 2025 09:35:07 +0100
Message-ID: <20250110083511.30419-2-sgarzare@redhat.com>
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

If the socket has been de-assigned or assigned to another transport,
we must discard any packets received because they are not expected
and would cause issues when we access vsk->transport.

A possible scenario is described by Hyunwoo Kim in the attached link,
where after a first connect() interrupted by a signal, and a second
connect() failed, we can find `vsk->transport` at NULL, leading to a
NULL pointer dereference.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
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


