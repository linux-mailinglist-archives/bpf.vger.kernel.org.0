Return-Path: <bpf+bounces-21221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227CD849A85
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 13:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486851C21896
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C8A28DD1;
	Mon,  5 Feb 2024 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpfXevTI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8F28DD5;
	Mon,  5 Feb 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136595; cv=none; b=I3LZ7NU+n3K7W0r5RDF04iLN7y4a5IsMXZTRCWFW6Eb3d9IgXIYrjZPI0xGOqpgH6IfHQVhx0ozMROPRHQ22vLgbHpJ6xJixHcrILzWrdvjPWfKass6I/aPvUFGgUsMOFDJeUe2NtWHVGH9HvWhHLKkaFbTe6WRC942+G9kYD6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136595; c=relaxed/simple;
	bh=U5qfE079FdT/mdUgNm+px/fvate8hxAsaMOyqIMJtDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bW8Lroo/CjrXKYKogXIKsrqgpDOi6V3vg+1669RvkGogvXbpzMNHWOEREhZwqNGXFdjYH5mimGb0ghyCJwm46Wv9Hqx0pJbEsu5W6qRIrkZzTd4r3eIUueejUowHweu5xMW59G3BsMio1wAdQShrvVl6br46dTg7bcCv7/b6ids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpfXevTI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fb7427044so11091615e9.0;
        Mon, 05 Feb 2024 04:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707136590; x=1707741390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ka0gTBRV+1YAdu1tmZJ+Pr8m3G6fsVPlqTQltgTjQl4=;
        b=EpfXevTIZjLLrjHp7QdebZLnXR4SqrEmXELFULlIXDuabH52xM7DNOkoHdzM43uUOn
         wCFk+AJV+QOGQM1kHVMsZxg6SV4Rn7WHWcuuuRIK9Q1PiouXDNZc6GRfagPp8HnQUpye
         ZA+a0bI3XoFNlaFBA6QGN+llFGHR/xu8aYVKjinmo4CaMcX97zNs+QmLfZGESF4L49FG
         +OsQFafqIVUU6Mpbu4GKsHMMUwC2z8n7iAzYLuuhaA6axtOqVzfjr8Ibma8j2qLyiuoA
         XdBuiZD7BRfDGT0Claj9Q9N2MM1dSVHYi6LhRn9ASnoCW13Y10cbymGlC4Mw93DGeZOi
         za5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136590; x=1707741390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ka0gTBRV+1YAdu1tmZJ+Pr8m3G6fsVPlqTQltgTjQl4=;
        b=hjR6T6XY0991Lbs+cS4tfqeQitDJtzuuzHKEJUH0BSXb5OXfktKd3ixwRORhZvDcbv
         h6zWjTSU7hURJSbRYIfc6Wzzbuha50L9bneB3GLe74x9XAVO2N/c1KbtCtOukQe1Gvgp
         OloBf4Xp9qrXSGISDlMYIS4ae9AhD5ReYaW2FwY4jFa3e7wkCml8pgzH4LAs3OdSe+wJ
         X92WheEMtlzujrY5a4P6GT+NAp2n7cw0EfIfuE9SAOf7NhifytGoEO8lBMIMf0Bj/TY4
         8WMGE8Jqz30eMZtOODOFhc3NyiC8EU2j8Ksd00qy9gk0fmI+10h7tRCsRE4NQUsOfJjm
         hiFQ==
X-Forwarded-Encrypted: i=0; AJvYcCVoARHFJXNT3DHhPzo2s2+prN4GCzirg5VxYp3H46mmz38TLnkrOPWuBCMVO2K+VXS8TEcQtmxKbbIxd7EABKaxxXfjLeLV
X-Gm-Message-State: AOJu0Yy8DjdYeqzw3IrUmqHVhfoEnNZEUhHFDTdkmR/wC43QSB8qB0We
	VeitvjEiliXt1dtb7j5m1s7CfU5WNWa1U9JeZtSffpSZCr7Pk/wt
X-Google-Smtp-Source: AGHT+IGLzEa/v587e9csuf5iXq3KoTZmrmAlvqHdqAAPcwMhTi2jdaKUyAdQBoZqmjmva2fFiRzyrg==
X-Received: by 2002:a05:6000:136d:b0:33b:18c7:5e64 with SMTP id q13-20020a056000136d00b0033b18c75e64mr7553713wrz.3.1707136590445;
        Mon, 05 Feb 2024 04:36:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXFCcDLqu71LR66Fp+tk5JcSreB/zuBzrfgWnaPWLXNXM/aHWGx+9roqnX55IMiPH+dhx2Bv5mEpV5W+rPUbJ1fWkkS8FUcsLep1fQr9GkjT5ujp0esdlZhRWyuwcKxXghVMM0GtQOPiFh/Lomny3l151qNpcZmxQym4HxHLxkWrLc5QYREAw9u96sodB2gQELcFPbSinqkD2zF0DQKrHdrc3TpNb0shskHlGl61oHjTA==
Received: from localhost.localdomain (c188-149-162-200.bredband.tele2.se. [188.149.162.200])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d400a000000b0033b17880eacsm7892894wrp.56.2024.02.05.04.36.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:36:30 -0800 (PST)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	yuvale@radware.com
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/2] xsk: document ability to redirect to any socket bound to the same umem
Date: Mon,  5 Feb 2024 13:35:51 +0100
Message-ID: <20240205123553.22180-3-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240205123553.22180-1-magnus.karlsson@gmail.com>
References: <20240205123553.22180-1-magnus.karlsson@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Magnus Karlsson <magnus.karlsson@intel.com>

Document the ability to redirect to any socket bound to the same umem.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 Documentation/networking/af_xdp.rst | 33 +++++++++++++++++------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index dceeb0d763aa..72da7057e4cf 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -329,23 +329,24 @@ XDP_SHARED_UMEM option and provide the initial socket's fd in the
 sxdp_shared_umem_fd field as you registered the UMEM on that
 socket. These two sockets will now share one and the same UMEM.
 
-There is no need to supply an XDP program like the one in the previous
-case where sockets were bound to the same queue id and
-device. Instead, use the NIC's packet steering capabilities to steer
-the packets to the right queue. In the previous example, there is only
-one queue shared among sockets, so the NIC cannot do this steering. It
-can only steer between queues.
-
-In libbpf, you need to use the xsk_socket__create_shared() API as it
-takes a reference to a FILL ring and a COMPLETION ring that will be
-created for you and bound to the shared UMEM. You can use this
-function for all the sockets you create, or you can use it for the
-second and following ones and use xsk_socket__create() for the first
-one. Both methods yield the same result.
+In this case, it is possible to use the NIC's packet steering
+capabilities to steer the packets to the right queue. This is not
+possible in the previous example as there is only one queue shared
+among sockets, so the NIC cannot do this steering as it can only steer
+between queues.
+
+In libxdp (or libbpf prior to version 1.0), you need to use the
+xsk_socket__create_shared() API as it takes a reference to a FILL ring
+and a COMPLETION ring that will be created for you and bound to the
+shared UMEM. You can use this function for all the sockets you create,
+or you can use it for the second and following ones and use
+xsk_socket__create() for the first one. Both methods yield the same
+result.
 
 Note that a UMEM can be shared between sockets on the same queue id
 and device, as well as between queues on the same device and between
-devices at the same time.
+devices at the same time. It is also possible to redirect to any
+socket as long as it is bound to the same umem with XDP_SHARED_UMEM.
 
 XDP_USE_NEED_WAKEUP bind flag
 -----------------------------
@@ -822,6 +823,10 @@ A: The short answer is no, that is not supported at the moment. The
    switch, or other distribution mechanism, in your NIC to direct
    traffic to the correct queue id and socket.
 
+   Note that if you are using the XDP_SHARED_UMEM option, it is
+   possible to switch traffic between any socket bound to the same
+   umem.
+
 Q: My packets are sometimes corrupted. What is wrong?
 
 A: Care has to be taken not to feed the same buffer in the UMEM into
-- 
2.42.0


