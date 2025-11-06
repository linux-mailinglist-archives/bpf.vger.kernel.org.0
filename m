Return-Path: <bpf+bounces-73901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACA4C3D3EF
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 20:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF713B84DA
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 19:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB77C35581B;
	Thu,  6 Nov 2025 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1gZxOib"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0283035028B
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457301; cv=none; b=JZ2nX+FNg9/XispT8WTi2YCB1EAABaTfYnAgIQ0ktcESp1XR3dnteXOLF2H/jmXuhlivsVSXr8HQ1dTBxWpuFdSoa+psI8RYRyBizQQTLWE2nq2FTemyY8SQb8DCAHJdhEpoTYvXlSu+NTnyV/Abgyc+fHGXZaNbOHFW5ABQedU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457301; c=relaxed/simple;
	bh=1Y+YpubDp1qb7oc7hg3w1PWoz9inIa15b2wdhzuZk9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y3KC/RsDcKePmVZ4kPhwoBro87ocd568iSsoSCz5H37xNdS09LPcOhiu/gKgzWOKy4oSnte2MEIVt4DWjIAXQxiJoqD7+Y0qucnCPZJbQEhDfd5JOnHtBk+3BIdfGvnr3Fh31IDL1aa8Vqb45T7Qk/cKNAB5Yofw/35LnI95+Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1gZxOib; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3405e02ff45so672a91.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 11:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762457299; x=1763062099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3U2BLp1AgEXNIvYOhrj08jJ81pfESpJT+bWqtR6/KU=;
        b=r1gZxOibS8MW3Iw6vmRpRh1GkWyj97wcxCi3EdHBnefAwMvhaahGQ1HvzN2VFfi2bT
         LrseiW5LMELcRDQX7gf8rwAKhpPzs30pW85AJiCEGU4a2GHseWJP66l/HAeXSYdu5YYu
         ra2zEZXpyptrzoKZCq/Sdp56e5waWJtZ+KthMiYTXihhLjTKF+nW2/C5vfy8P2G82njP
         qXKFlyMrqlk+lrFqzI4+K1JNQ5O8PZhWbZbwp1nD+mEauAcU15K1tz7KYHBzAN3hu4T/
         d8vfXKfjvhUupXPDnQ8hNpLUZ+5DIazI++spbDbKMwUp1XXKwG0Dga8r3nqHVMlDqxsD
         LUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457299; x=1763062099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3U2BLp1AgEXNIvYOhrj08jJ81pfESpJT+bWqtR6/KU=;
        b=c1Akb7cEsRODxbIbrYkxJyYCuKyGnUsX9NinCGkr27YOEMOvWVwRzy92Qbhm8zYkOx
         XMzzphLb6w+nWk7R++NviLPTjbYbk1BkcmHEs1aDCYtCmLTJxzCs4bviXwBD7rFp9OcX
         bMpU2ixq0+YYZ7yOXv8b/281Eirtwufkb+cePbFgwOfaUX+F/c7kvATh6AqeveCrXhJo
         CMLsnDaq897kSeLKa8F4FvXIErhWW9dZjynNpTAbGk80kag05d3L/lHGtEJ1Rjgs93iq
         H5AdD0M/dgVJwTiNt+K4lKR/GVQyz8U5L+ldxKaK+q6WpOiSl48CmZkorfqE2YjVrZOd
         /znQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0sC0fHSDG8UrLXPPKk7AV7Anpu7BTAvQTw/69oVUIgVfkiGU1J0WN9K6Ui/ecUco7tWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzyufFuAy+PvjXSDEYbREazj9b9mOfmAwnTn0R4swmpl/uf95j
	QeT+hZXY6CzRruYWbjRzVtxng/NcXcoNz9Zsgc9lYv7eU8seRF6JE5n6Sg9sJ89DGs3eTur0/ud
	NXRCRPQFZVquYMQ==
X-Google-Smtp-Source: AGHT+IEsIfGYhZdZ2tqtBbcVUZ7ueSUHICQoVDbIm+m6yTPLyYNJ4OIu36HZ71hM7vJ6QPPO9Ilb5TFmeTcycw==
X-Received: from pjbrm14.prod.google.com ([2002:a17:90b:3ece:b0:341:2141:d814])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3809:b0:32d:dc3e:5575 with SMTP id 98e67ed59e1d1-3434c4e0e7emr325363a91.5.1762457299298;
 Thu, 06 Nov 2025 11:28:19 -0800 (PST)
Date: Thu,  6 Nov 2025 11:27:46 -0800
In-Reply-To: <20251106192746.243525-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106192746.243525-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106192746.243525-5-joshwash@google.com>
Subject: [PATCH net-next v3 4/4] gve: Default to max_rx_buffer_size for DQO if
 device supported
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	John Fraker <jfraker@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Ankit Garg <nktgrg@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Change the driver's default behavior to prefer the largest available RX
buffer length supported by the device for DQO format, rather than always
using the hardcoded 2K default.

Previously, the driver would initialize with
`GVE_DEFAULT_RX_BUFFER_SIZE` (2K), even if the device advertised support
for a larger length (e.g., 4K).

Performance observations:
- With LRO disabled, we observed >10% improvement in RX single stream
throughput when MTU >=2048.
- With LRO enabled, we observed >10% improvement in RX single stream
throughput when MTU >=1460.
- No regressions were observed.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 4f33d09..b72cc0f 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -987,6 +987,10 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 		dev_info(&priv->pdev->dev,
 			 "BUFFER SIZES device option enabled with max_rx_buffer_size of %u, header_buf_size of %u.\n",
 			 priv->max_rx_buffer_size, priv->header_buf_size);
+		if (gve_is_dqo(priv) &&
+		    priv->max_rx_buffer_size > GVE_DEFAULT_RX_BUFFER_SIZE)
+			priv->rx_cfg.packet_buffer_size =
+				priv->max_rx_buffer_size;
 	}
 
 	/* Read and store ring size ranges given by device */
-- 
2.51.2.997.g839fc31de9-goog


