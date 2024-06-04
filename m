Return-Path: <bpf+bounces-31305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D308FB234
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64703B234A8
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 12:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BA914658F;
	Tue,  4 Jun 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnCYjX78"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD303236;
	Tue,  4 Jun 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504218; cv=none; b=Ulte5cl33K0eVQWLNnLoiIjpXxKcWxa/+alSd9PkEE8XtZio9dkqsGIAIGniXWMmWbxi9VFE8V+M8SImDGJ0ZG3zVXi7drLSlKLCAAIvj4Yp7D6SwtleV4TseYao+YU1OqgT55QH21szp9eYNNcf8vLHEx0GphBbs2zw8Tx5rXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504218; c=relaxed/simple;
	bh=MV30rtHfPPlHnZDcV8Nv0rH4R7ufIL/lJb4TF1YRKPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzjZETh5p1FW0VFy81SIkDNsdU4jiiu+8nxxc/Ob+dZawAwcsSAR+3brOsmGNUFdm+/hK+qf2AY680Qfxm9x2knKEQOy7j1QlGFj9nog7DOrY8YynkmXgZ0784MbnpVnBRdr9/O6xzGBuv1N5ikmlz3qpEou1KUn4WGjJtTsxfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnCYjX78; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42111cf2706so5404725e9.0;
        Tue, 04 Jun 2024 05:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717504215; x=1718109015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QV5178kq3A+ohCLOgGIMrjEKOo8kZ9b5SnrcxWS2AG0=;
        b=NnCYjX78rlXpRbqlEq3Wl2ORDRearjDGywJc5Hzvyv1LJGbCZMb4f5gVtmxtT4IP/3
         If4YFbUXk5w9Zb/PpcwLWD4eAHEktALJfnTgONQDsESOWnw6SgJ1i4oC44d57h2ZqsQK
         CuZdp5rZknTe3tTn/d8JvuVfvDyzcs9FFOBToiy7P1fIbhVFfot+ZOIvijFAbk+4JaIj
         3ixOcEheaVumdLBy2Ml1jLrCXicyDuuEyUWMvb0y+SMvPaKXZIhcZFQXKaA3Ncvvq6XO
         dEyV1Zqf/kGIKGKPEwCVjjlI1DNKYc4XydD3VGsCMzW2Hnt3LOcl5e/9nZIPPiYSVOue
         B3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717504215; x=1718109015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QV5178kq3A+ohCLOgGIMrjEKOo8kZ9b5SnrcxWS2AG0=;
        b=EudAoPC9ZwPwcmwn1MYngCSQwRF7L1EgYIfKA/BusEYdTr9ADtMh+gd8DkUZZDEY0H
         mw7Jy1op0TMWapiqjDywsrY8xtJXfZRxVfAwlTddRInpczBG9+Bhx9y/AAZL/Wb/nlgA
         zzDsjDNsFea9KpAAsmi/V77EkyHZETgih8m79eCtbrrrowH9WaCypa4l5FgyfROoo6q1
         3/c37TpvZD6BrXbB9x6FODdfAE1/7yoPZ5u6BxieilWXkykP96jUQ3+YGdAWZvFRYDBO
         5xp7BDszaCgsv7yVb9ROe10TZ/BgNIBtfe4Qzzg3SSZdCX5unuNeVwfO5Y/uInUJ2tvW
         ptYg==
X-Forwarded-Encrypted: i=1; AJvYcCVFCa2LBe+qap3vsOIca4tCdX6a3A7ZDfeo7tMNzlmX23xxMwbgckO+Rr88eEO6YepaGG6uJwkGbNEH3fD+KhiNqTcObM0v1JJyHLv2j2mc7mIMxjIho/MUWRVc
X-Gm-Message-State: AOJu0YxHVW4qPlZ4Om0U/Rekvig5Na7PVPn7dj3/J27URobDYre+vGaX
	9U6+kzDdFC74yyUYm8cMGK0zFF5Pvd8EUUwWSj3NncbOqSN1VaFiCx5w4qoms+o=
X-Google-Smtp-Source: AGHT+IHhzkkFVpck0g22o5SFzatZ2y6OdCdEgwraAFEdBVUkp5jFwhWk8m8R2K4c3j0ORoqJPw7fzw==
X-Received: by 2002:a5d:452b:0:b0:358:3a1:2643 with SMTP id ffacd0b85a97d-35e0f306439mr7994492f8f.3.1717504214333;
        Tue, 04 Jun 2024 05:30:14 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-45.NA.cust.bahnhof.se. [158.174.22.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c10f2sm11409863f8f.10.2024.06.04.05.30.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:30:14 -0700 (PDT)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	bpf@vger.kernel.org
Cc: YuvalE@radware.com
Subject: [PATCH bpf 2/2] Revert "xsk: document ability to redirect to any socket bound to the same umem"
Date: Tue,  4 Jun 2024 14:29:26 +0200
Message-ID: <20240604122927.29080-3-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604122927.29080-1-magnus.karlsson@gmail.com>
References: <20240604122927.29080-1-magnus.karlsson@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Magnus Karlsson <magnus.karlsson@intel.com>

This reverts commit 968595a93669b6b4f6d1fcf80cf2d97956b6868f.

Reported-by: Yuval El-Hanany <YuvalE@radware.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Link: https://lore.kernel.org/xdp-newbies/8100DBDC-0B7C-49DB-9995-6027F6E63147@radware.com/
---
 Documentation/networking/af_xdp.rst | 33 ++++++++++++-----------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index 72da7057e4cf..dceeb0d763aa 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -329,24 +329,23 @@ XDP_SHARED_UMEM option and provide the initial socket's fd in the
 sxdp_shared_umem_fd field as you registered the UMEM on that
 socket. These two sockets will now share one and the same UMEM.
 
-In this case, it is possible to use the NIC's packet steering
-capabilities to steer the packets to the right queue. This is not
-possible in the previous example as there is only one queue shared
-among sockets, so the NIC cannot do this steering as it can only steer
-between queues.
-
-In libxdp (or libbpf prior to version 1.0), you need to use the
-xsk_socket__create_shared() API as it takes a reference to a FILL ring
-and a COMPLETION ring that will be created for you and bound to the
-shared UMEM. You can use this function for all the sockets you create,
-or you can use it for the second and following ones and use
-xsk_socket__create() for the first one. Both methods yield the same
-result.
+There is no need to supply an XDP program like the one in the previous
+case where sockets were bound to the same queue id and
+device. Instead, use the NIC's packet steering capabilities to steer
+the packets to the right queue. In the previous example, there is only
+one queue shared among sockets, so the NIC cannot do this steering. It
+can only steer between queues.
+
+In libbpf, you need to use the xsk_socket__create_shared() API as it
+takes a reference to a FILL ring and a COMPLETION ring that will be
+created for you and bound to the shared UMEM. You can use this
+function for all the sockets you create, or you can use it for the
+second and following ones and use xsk_socket__create() for the first
+one. Both methods yield the same result.
 
 Note that a UMEM can be shared between sockets on the same queue id
 and device, as well as between queues on the same device and between
-devices at the same time. It is also possible to redirect to any
-socket as long as it is bound to the same umem with XDP_SHARED_UMEM.
+devices at the same time.
 
 XDP_USE_NEED_WAKEUP bind flag
 -----------------------------
@@ -823,10 +822,6 @@ A: The short answer is no, that is not supported at the moment. The
    switch, or other distribution mechanism, in your NIC to direct
    traffic to the correct queue id and socket.
 
-   Note that if you are using the XDP_SHARED_UMEM option, it is
-   possible to switch traffic between any socket bound to the same
-   umem.
-
 Q: My packets are sometimes corrupted. What is wrong?
 
 A: Care has to be taken not to feed the same buffer in the UMEM into
-- 
2.45.1


