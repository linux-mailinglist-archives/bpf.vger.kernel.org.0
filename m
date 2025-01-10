Return-Path: <bpf+bounces-48528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A816AA08A74
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 09:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36ED165160
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6568520B7FD;
	Fri, 10 Jan 2025 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWoQpmNj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4E320B7EB
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498150; cv=none; b=VCTtaugBAawN49p2SS+XDSUpm4hysU3tzIvxSalKBNNLzLY9xvhDC25BCc33MirZ8K6Vx00/RVAwOiGG9Q8Y3fWa/wMTr45ol1pso1LbixFkv98rDvCakj6/sh97LjKsxuejB6hzmIMdIKEEz6bQ0C6m34WgDubcxrYuRTjGD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498150; c=relaxed/simple;
	bh=ZkTGYail/OHpw8whko7T8HSpEewACyZ6yzZNkHMM848=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sW+o2mNE3tqQxNhUoE1buVML77NHMpNeeIEOU3/4CndFRkWhPA3kFeGbKRbrV2NGYQhVKjagtlGby6gEkQtz/h8br9+8WOnjPIZioRiBXPCmkdk7yRtpzkq9kHnJi8X5qKVSWp43Jxnkwp+JtEp8BfkDooX5XpGCSeTYyjuEnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWoQpmNj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5v5m4rv3lPn2u8LD9NON66qt3Pvib6QUvVJIVTGvfw=;
	b=hWoQpmNjaZ9KNQGE+LwN5kZc6fi0+Qe4Xqan99Z7WjYHMu+UEYtAoSAn28HHmH8jctwwj5
	CzY1UTuaeI0yq3w3/0spm8YOyYh+1hvtJ/fJFnsqffjajjQ59NpmKdZoDoldMu7GyNk1FN
	KZnyW2owg/BwZ26aPAJKZazANZ4trzg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-ypIRo5QhPTmZDuN8V1OBiw-1; Fri, 10 Jan 2025 03:35:46 -0500
X-MC-Unique: ypIRo5QhPTmZDuN8V1OBiw-1
X-Mimecast-MFC-AGG-ID: ypIRo5QhPTmZDuN8V1OBiw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361ac8b25fso9525045e9.2
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 00:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498145; x=1737102945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5v5m4rv3lPn2u8LD9NON66qt3Pvib6QUvVJIVTGvfw=;
        b=cx3Jl35X59slwsq2og0pBd1PzT/r4YnXhiWKBpN5FJjbFrrIdw+FQi5oWCyDTgql1q
         /RgjKslK4AmIGBbR7kQT26MbGd+t7s7Xoecry+pXExyzvbu2YyM7C5TBqPKscwj9U/zC
         6dlir+u5TT0xYP5ugs6tLpBKEHCG65LZ1MnVoCTP4oqlCAX0KvrN8JR5cZ0QV/K1xurN
         rVcnp/3O4jDMZ3qsU8sxdOFnOqPRovttytbXD+hpzeNlj8HINdD2ZW99stJ6Ho60EOWm
         nxFV3dGpYk+/uPXHhZmw/6VBZuVysOWg9QnhDnh0eiLQ+LNP78/aybwBI+aaKZ8ZuwiA
         1sUw==
X-Forwarded-Encrypted: i=1; AJvYcCVqFmIMD7vWI+bbr3rMrvrngYbKlaJhWUqeL+PsLHjmdiVBy9uSRjW4ahHJE9qTpfsHzSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfrdmgGm35DSrCOt5lrz9Lk2o3qIws+Qj/wiwVSg/jVr55XOr/
	Cs6Ae/8wp4WebCRALX7oUxkFcgSDgXsuS1GGfeCWymAEzX3/eLODZomzk2ap+aN2hpbumKkSo+X
	Z5RoU9W4zhPWkbHQRDi/vz9SusOThvPlzK0d4JWBqIPw+RfDokg==
X-Gm-Gg: ASbGncu8ZkX6+cSXYP7My+MqIun3a2x8MBktr8FGaeofQ55nRl5KlCHtjlnnTREOAfn
	Cg9hnPurcVuH3jnKN5Aox3WvY2NYJCMilCB5zCbTbNhKT5+8MZkulxiBbpirGR0gzoEvotYHaCB
	pIwoDYdDrOoL+G8f1orm788F+/+hVTU1JyQz9VVsDdbhA1rInEMX9TyRx7m6TFqZiJ0ok02EDcX
	dNjYXOR0JjePrkJMQ8AaCBN/d8sJ7n20FJ9u6nVYpdXIws=
X-Received: by 2002:a05:600c:4fc2:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-436e26803f4mr84609955e9.3.1736498144877;
        Fri, 10 Jan 2025 00:35:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpqRZ6c+WoEWD0O+MqMW8gszvq2OTzZ1nbLSdaSb4uThngbiKtv0ftXVfyIYyqEi2yR41t1A==
X-Received: by 2002:a05:600c:4fc2:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-436e26803f4mr84609315e9.3.1736498144222;
        Fri, 10 Jan 2025 00:35:44 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92dc4sm78738505e9.39.2025.01.10.00.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:43 -0800 (PST)
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
Subject: [PATCH net v2 5/5] vsock: prevent null-ptr-deref in vsock_*[has_data|has_space]
Date: Fri, 10 Jan 2025 09:35:11 +0100
Message-ID: <20250110083511.30419-6-sgarzare@redhat.com>
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

Recent reports have shown how we sometimes call vsock_*_has_data()
when a vsock socket has been de-assigned from a transport (see attached
links), but we shouldn't.

Previous commits should have solved the real problems, but we may have
more in the future, so to avoid null-ptr-deref, we can return 0
(no space, no data available) but with a warning.

This way the code should continue to run in a nearly consistent state
and have a warning that allows us to debug future problems.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/Z2K%2FI4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX/
Link: https://lore.kernel.org/netdev/5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co/
Link: https://lore.kernel.org/netdev/677f84a8.050a0220.25a300.01b3.GAE@google.com/
Co-developed-by: Hyunwoo Kim <v4bel@theori.io>
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
Co-developed-by: Wongi Lee <qwerty@theori.io>
Signed-off-by: Wongi Lee <qwerty@theori.io>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 74d35a871644..fa9d1b49599b 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -879,6 +879,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
 
 s64 vsock_stream_has_data(struct vsock_sock *vsk)
 {
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	return vsk->transport->stream_has_data(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_data);
@@ -887,6 +890,9 @@ s64 vsock_connectible_has_data(struct vsock_sock *vsk)
 {
 	struct sock *sk = sk_vsock(vsk);
 
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	if (sk->sk_type == SOCK_SEQPACKET)
 		return vsk->transport->seqpacket_has_data(vsk);
 	else
@@ -896,6 +902,9 @@ EXPORT_SYMBOL_GPL(vsock_connectible_has_data);
 
 s64 vsock_stream_has_space(struct vsock_sock *vsk)
 {
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	return vsk->transport->stream_has_space(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_space);
-- 
2.47.1


