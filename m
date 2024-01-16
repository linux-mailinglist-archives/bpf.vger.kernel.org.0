Return-Path: <bpf+bounces-19684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEC482FC38
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 23:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82AE1B257D2
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E941BC33;
	Tue, 16 Jan 2024 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nametag.social header.i=@nametag.social header.b="FXHI7rMq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7BB1D68E
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437013; cv=none; b=aR0Cb99+0Pui1eraykP58AQtdtNCjag095FFBuooei0z2ODHSWUqGEoRBlL7l4XEoFDgKdLtqS92D/SUdDAizd74E8O5DSjczC+uUCpc+7nPeilUxPpqShjstCwY9SGTLJ6SzhJ5dLxGkOJxtJJgvpAWI1XknS2lspVsFY/ZhXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437013; c=relaxed/simple;
	bh=MBq8ZxD517/cVqQuntfz9TUT37KOhQ2K3vkie+0LLY4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=ag0JGPfePir8V0kVqQNMT/7leoiAjZ2StL+2dAi1yPphO0WS5905/Oh8jhMEizAYd8rZspARrBa3sStigOoeRI4FIjBXMhs2I9IA8KqYwT4BlPzPujPUgXBwgFb/HawF+D+TmHyF1/escKi4v4d+Ao1dCO20cfsBXS27vlSONcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nametag.social; spf=pass smtp.mailfrom=nametag.social; dkim=pass (2048-bit key) header.d=nametag.social header.i=@nametag.social header.b=FXHI7rMq; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nametag.social
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nametag.social
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bd5c4cffefso4401558b6e.1
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 12:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nametag.social; s=google; t=1705437010; x=1706041810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GEiuDDGZ7yJfP3jaaAdiMXsKQuVidWJh/astRVgD+dc=;
        b=FXHI7rMqmGmz4wZSG+ViWzycVKDjQz80ouD+YewPqGlPGfaJv4l7gOIU01jaLKKJOg
         ziJyK2S3L93Jmk1bLDrz5WtKA/5k6OrXlXjKtV5PZsoKGcu+0WMLc5nNxoYDPeUkaNM4
         a5mr/hPPBT7/yhNdBOfi9e/X8X9tMq5XDSeNWBDTQxa90HC41mgDoC2RYbeWDrrxoHt2
         xGJk6vCS5kmIICtfMjz3bT7zF1yT6fDYeQ+lVRskCRcAByq7IGQxKnfu/SnMF7qpHsA0
         B3bB7mAUozyWfaoTMXYZ/tfoz/hD5y4a5e+/j2eBwW9yV+5ECBWEmgaeUxRt5n1vS8dE
         tnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705437010; x=1706041810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEiuDDGZ7yJfP3jaaAdiMXsKQuVidWJh/astRVgD+dc=;
        b=ok7/H3IeCzLqfFK4bmXqeGvcbxmLPPC9Df2LyV9lEyAFqg8rsoKEHxxZmvdsh7ZSsc
         HpTpS+fHWqo17XdJUjrqNjJ9gfh+p7dACSNK/H1UKko73moT7/fZs8i3Sgw3twkjKjkF
         UCM0sKk70KT4+7FzF6hgPnDf3mPYOFYNxtxHBgOXr7OaNw2pGQMQvTrTzdnMNqDkNMkh
         +CXrtG4O9BgcpWvGuggQpDymrlH+5sQoduFKu/JBx0njUUySKsRf59ycbDkG0+3iifqF
         Qg60EdOVUqbf0HaBVyRZwjGNTBTB2Kd4GhIdlfKzufupF9AMwTobyD4ODEiETmaS1dIf
         t7wA==
X-Gm-Message-State: AOJu0YxB/eQZA/CzIe1Q1f85y7IeY6RHIfT1y0ATlNv4dqP0wvBaJU1K
	iQB0YuT4HBjv4jwkwaksvKlVYywHmVod01TrlZq5J6EEXBs=
X-Google-Smtp-Source: AGHT+IHaPJdRlZ93kkjPakTjx1JDrET3snk6dRaDKb09oTSbCSn7asSHjH60UQ7kyoQRO7VGHEyVXg==
X-Received: by 2002:a05:6808:1396:b0:3bd:9129:faf8 with SMTP id c22-20020a056808139600b003bd9129faf8mr676113oiw.83.1705437010164;
        Tue, 16 Jan 2024 12:30:10 -0800 (PST)
Received: from 2603-7000-3200-684c-0000-0000-0000-1ac2.res6.spectrum.com (2603-7000-3200-684c-0000-0000-0000-1ac2.res6.spectrum.com. [2603:7000:3200:684c::1ac2])
        by smtp.gmail.com with ESMTPSA id p24-20020a05620a113800b00783183a9b03sm3924759qkk.134.2024.01.16.12.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 12:30:09 -0800 (PST)
From: Victor Stewart <v@nametag.social>
To: borkmann@iogearbox.net,
	bpf@vger.kernel.org
Cc: Victor Stewart <v@nametag.social>
Subject: [PATCH] fix bpf_redirect_peer header doc
Date: Tue, 16 Jan 2024 20:29:52 +0000
Message-ID: <20240116202952.241009-1-v@nametag.social>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ammend bpf_redirect_peer header doc to mention tcx and netkit

---
 include/uapi/linux/bpf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 754e68ca8..01cc6abe2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4839,9 +4839,9 @@ union bpf_attr {
  * 		going through the CPU's backlog queue.
  *
  * 		The *flags* argument is reserved and must be 0. The helper is
- * 		currently only supported for tc BPF program types at the ingress
- * 		hook and for veth device types. The peer device must reside in a
- * 		different network namespace.
+ * 		currently only supported for tc and tcx BPF program types at the 
+ * 		ingress hook and for veth and netkit target device types. The peer 
+ * 		device must reside in a different network namespace.
  * 	Return
  * 		The helper returns **TC_ACT_REDIRECT** on success or
  * 		**TC_ACT_SHOT** on error.
-- 
2.43.0

