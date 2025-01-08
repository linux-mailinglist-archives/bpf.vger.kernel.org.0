Return-Path: <bpf+bounces-48276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BD7A063FB
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 19:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0F73A6BDF
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA75200BA2;
	Wed,  8 Jan 2025 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bc1qGnB3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B6202C4A
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359596; cv=none; b=NB2aPmBMFBL3q2JfUtprPymPOjZS9pvzRP6g/AT8N6EKMkysFs1a297k0J+LBHhaVEgijwN9iQ4aV0OgjjYUiIqxALIlT3vqqBn3QXX0nutUPPXILXalqZFcs80/1V9NVU0PBrsSzUZdPHYgGTANSTqV82VB4hxLsDfn57MMa/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359596; c=relaxed/simple;
	bh=NW1NN64WPOb8zvTk9pQc9y9wJMAUw7k5KI4tbn3qy4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTNCKAIWPZpoT1h18RoPo0iVM8/uBq+KZa8znLodjTpXE94XcZOpKTo1ZI2q851h6xtqdQV86hSf3ODSnSFKIuY7MBo2aJV6ldLPtoI2uReweRcH1WAiDf4wiB/qNHB/90zQYwkXuxMId08SPrl9dlc52Ut6WMl2COXKp1GB+Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bc1qGnB3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736359594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTpnjYdFe65i9cQrDrcRqhmpYDaSR/fVnChURrprIX4=;
	b=bc1qGnB3bW6W0rYY89SyhwbWMM/ahLBNdXr2GQO6uG6SYN8HHNUl6Rnonz7kEhh1MqChEt
	yVCoTEPT1pPX15jQbSqgFZg22CI3SsoRvOSZthh2ypsAR113lIXnAupD0EqX4dLaQjgziX
	lv/3zT9M2BZIrz1DvTTLH9XhPtaItfU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-0KKISGKPPQGXP4ItUjm-fg-1; Wed, 08 Jan 2025 13:06:33 -0500
X-MC-Unique: 0KKISGKPPQGXP4ItUjm-fg-1
X-Mimecast-MFC-AGG-ID: 0KKISGKPPQGXP4ItUjm-fg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4362b9c1641so468125e9.3
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 10:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736359592; x=1736964392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTpnjYdFe65i9cQrDrcRqhmpYDaSR/fVnChURrprIX4=;
        b=lTifMP6hyktXKAPBpy4tt6spGRNpNa2MxLH2BiqlPjxJQf+kEnssLaxGHnfa6y46eG
         s55D+NcC6TTAL9WAw9ylSM4XfoJRSVTtkXDlnQQ31kmT+sr2ySqR+cu+o499j+kEI5ou
         hLCEqpZvV0NA9JlORJe2Fuk58rGTMBUyMCG2FOTE1724cWw6WT5zL3pslaaXI/E1iJE5
         /12QLAIonCbMuk04kno7S4AgNrhDsCAmgMhBQ7RGkvPDv1drkjm4TKMeCWoazagZI9I/
         nYyZQ9GtRktCSNMuT28hO71I8/Z1zvRaJHiYFQdKQ8F0NtT1FsOaEhuJPvUv9gPrBYBi
         C31A==
X-Forwarded-Encrypted: i=1; AJvYcCW8GKaUKQsv8jFRILnimePaD/guB92/Sclc5uaxf065OzLKhCOKr9KLybnTDnKv0lkYXjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6dvY2LRxTvabiiRqxXu/5vSdiTClAE8eOLKbpcqj8X47O8zxU
	n/JNiOw4m4nVjK7kDNKe9c1PYeMbJG39LkVL+8EouSdRLZ0wUtmcUbMhtUN3KQpiUnDbTsyrSjA
	sz/hgkWtcD6B9QtjC0QkYMDyUVhHt4hbvJgsLkcrEqdx2VbFvYw==
X-Gm-Gg: ASbGncu41sBe4I628JKOuPkhxKn6ZEYcVBtBMZQ/WiZNY03JJ6D+rAbR1FrUIfQYjYy
	E1YoKj/A0HNDBjx2EL6mCzaSqHPSwguYL7TjDweq1M1u/8MY9560ZVRvAmRK5OCWMz2ul67YhO2
	/78eX6rLM3rlYuy4WcXnA0SCGyCNzjA2XJvtmqJaUGCvuLhFMrsGVrPwrmD94XwphtAZQY4yvO+
	lkaivJQqKqTJBI1eg5C38V02Nt2HHKfSmfJ1amyE4yz+1U=
X-Received: by 2002:a05:600c:1d14:b0:436:5fc9:309d with SMTP id 5b1f17b1804b1-436e26f6d80mr37371055e9.30.1736359591820;
        Wed, 08 Jan 2025 10:06:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTv/Bx6C2k5LOcLLY/XN2JmilQSz5qyKDCjlMy44PV1BJ3rFBTpqkU5iqtg5HftWkhRLAW+A==
X-Received: by 2002:a05:600c:1d14:b0:436:5fc9:309d with SMTP id 5b1f17b1804b1-436e26f6d80mr37370685e9.30.1736359591257;
        Wed, 08 Jan 2025 10:06:31 -0800 (PST)
Received: from step1.. ([5.77.93.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89fc3sm28849325e9.30.2025.01.08.10.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 10:06:30 -0800 (PST)
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
Subject: [PATCH net 2/2] vsock/bpf: return early if transport is not assigned
Date: Wed,  8 Jan 2025 19:06:17 +0100
Message-ID: <20250108180617.154053-3-sgarzare@redhat.com>
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

Some of the core functions can only be called if the transport
has been assigned.

As Michal reported, a socket might have the transport at NULL,
for example after a failed connect(), causing the following trace:

    BUG: kernel NULL pointer dereference, address: 00000000000000a0
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 12faf8067 P4D 12faf8067 PUD 113670067 PMD 0
    Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
    CPU: 15 UID: 0 PID: 1198 Comm: a.out Not tainted 6.13.0-rc2+
    RIP: 0010:vsock_connectible_has_data+0x1f/0x40
    Call Trace:
     vsock_bpf_recvmsg+0xca/0x5e0
     sock_recvmsg+0xb9/0xc0
     __sys_recvfrom+0xb3/0x130
     __x64_sys_recvfrom+0x20/0x30
     do_syscall_64+0x93/0x180
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

So we need to check the `vsk->transport` in vsock_bpf_recvmsg(),
especially for connected sockets (stream/seqpacket) as we already
do in __vsock_connectible_recvmsg().

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Reported-by: Michal Luczaj <mhal@rbox.co>
Closes: https://lore.kernel.org/netdev/5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co/
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/vsock_bpf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 4aa6e74ec295..f201d9eca1df 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -77,6 +77,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 			     size_t len, int flags, int *addr_len)
 {
 	struct sk_psock *psock;
+	struct vsock_sock *vsk;
 	int copied;
 
 	psock = sk_psock_get(sk);
@@ -84,6 +85,13 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 		return __vsock_recvmsg(sk, msg, len, flags);
 
 	lock_sock(sk);
+	vsk = vsock_sk(sk);
+
+	if (!vsk->transport) {
+		copied = -ENODEV;
+		goto out;
+	}
+
 	if (vsock_has_data(sk, psock) && sk_psock_queue_empty(psock)) {
 		release_sock(sk);
 		sk_psock_put(sk, psock);
@@ -108,6 +116,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 		copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	}
 
+out:
 	release_sock(sk);
 	sk_psock_put(sk, psock);
 
-- 
2.47.1


