Return-Path: <bpf+bounces-78810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFF3D1C19F
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD99F301FF50
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B332F3C13;
	Wed, 14 Jan 2026 02:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2q2HmOA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12D234973
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768356766; cv=none; b=Zm+xs6xo685CaMFGZn+R4PU4bzAFiueVDZr+L0AHdT0Cd1kCi8HAZKBDLxuxtgSdM7gfjrSdatAzbDYmMzMM0UGxIufhlSppjZ4Q0ahQayoz6cB/Vhzd7FjlnNqoVjqT+DL296LpkSnMM4QepnEmCyRsW4gXdtr8KSu6BCTYMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768356766; c=relaxed/simple;
	bh=vsIfd/EdjmKj6EtYM12h7Vo4cjTqhM3wHJIyoo62cEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UV2s9Cq+DNDL07XGz9jUblnFAcDTbOzm2yZUXgMCP2N/t8OobMKtJhWdeaSuhj7MZAgR712eFtG4g6nCYATtLNG3bbnKjO1vF7GgVPZE8rMwZPb+jMEOHeM7f44eeWtvTOCbdapIEf33Wuo2FcI7e4WjRA3+6nzSNP1/IuDgHck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2q2HmOA; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso3140237a12.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 18:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768356765; x=1768961565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ohesoiOsCmzODawjFtqVNvqZy+tsvtD532ScSAoTgDw=;
        b=I2q2HmOAEeZXnYnWMZhaD7bcrk/+hJgr7gZAExhKf21PIK9OL9UBz3uuEokLvELvQE
         +u1tJriJXEyr0aUm0LoITnln7uwKyfYZelCxjRUxfQ5YGUN71BHxjUjur8DfcoUu/iBN
         cTiV3A6dc8y+JtqGqzl6v5uTEiQ06zwC/OyEiT+xCUqRdwsAFyh1JGQWsSykMQ367OcR
         VQ0mWyOxTxx8Q6beccogS6IAD9mBTPOg2YuIfvvIsxPyCXgAPoissMwQPgIAt0SNiM2W
         M3HruzIswIbcC4+3mIOyyD+2wbXgrMuKGaH/U0i4OLghOa1+CjO+rjLGeIwMd6qVIqh8
         tFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768356765; x=1768961565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohesoiOsCmzODawjFtqVNvqZy+tsvtD532ScSAoTgDw=;
        b=mCy5EbtzGh9bjRhaBYnBOTKOyzRc8PbyoUExbdCJMvD5HVs72JnDYPoDbmjh8CbLvy
         mRZ7cvu6EENOSlS48fR5MnZ+I3MZRNXv87GMVbsi3nPOvhsfp0Xh4NDYfohNmVdMQPQ3
         V2Ua8z8qf/9w/KR3jhXxB5REv3buMYxVHVjA5hrSMGqH+ZrO9AXuHIHYY0/M04XwzS8A
         wZAkolBQBqgg5TKHc/UBUa1F5vKfjFpuUgRFcETjTw0OirfDToLVKBDPikgYXu4AsebT
         6h38dzqsb7/YCuEt+U3b9sd9bbtRBTOc6RMxti6BACqCvMDXKORM5N8Oj6PPkecOlONa
         VKWQ==
X-Gm-Message-State: AOJu0YzI0z4RvR1xhwxxCum2HQ/5s5En8u48BYYbmuE/vCnAbhP4uFYG
	x3RF3HxDDLIMnMvIass4Qq1xH/Z7uiCjkVXg4rhC5xnnQs8cG5j5UpRnY+lNa8bJ
X-Gm-Gg: AY/fxX6OHJkEKdz/67g3oGWiKaE4tgYjBv48pD58RrEoLZ8tz+zaYeiwHcoI8zoYEpw
	vfM+Q+m/WxeN+vXImGqnO1MtKHgxAoiGUR3or7ExjRDMAi13kwUZuxCfwEQFwXk+LvtzjSpzfYP
	CVF+fenadrsbnTLmXQiYwelxJTf8iglHMQopV/owDurU6g83Z+UL8358jNcfxzCD05pWqRkhMat
	8+DcuMwcqD7dfhsCEjQ/wOPOybLwO1uLAIXky6cTiDFft2hQzQuZz4WjKshmUzVkDLJhJmfhtov
	XO2YXirJgqJefwsHV1Zy+YDThD1ZUpjTNVIvh+t2OvhGknQEXCss7zW9VkkmMPr8GxpTiQNdVFs
	TL9zOOX0trj5Qn40rfkbx/MyA+F/glvMZuF8RNNf+v/qBPcvuai1P4EL3cqlGh0tdPuK5lL/8Hw
	0ji0e8JY6LWafPuf1DTryufQFDA3cSj3k/LSF6vFEV0eB10sdU21k=
X-Received: by 2002:a05:6a20:918a:b0:35d:492e:2ed0 with SMTP id adf61e73a8af0-38bed1c45a4mr1025142637.52.1768356764609;
        Tue, 13 Jan 2026 18:12:44 -0800 (PST)
Received: from fedora (softbank036243121217.bbtec.net. [36.243.121.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8082aef9sm626827b3a.7.2026.01.13.18.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 18:12:44 -0800 (PST)
From: saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>
Subject: [PATCH] bpf: cpumap: report queue_index to xdp_rxq_info
Date: Wed, 14 Jan 2026 11:12:02 +0900
Message-ID: <20260114021202.1272096-1-saiaunghlyanhtet2003@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When packets are redirected via cpumap, the original queue_index
information from xdp_rxq_info was lost. This is because the
xdp_frame structure did not include a queue_index field.

This patch adds a queue_index field to struct xdp_frame and ensures
it is properly preserved during the xdp_buff to xdp_frame conversion.
Now the queue_index is reported to the xdp_rxq_info.

Resolves the TODO comment in cpu_map_bpf_prog_run_xdp().

Signed-off-by: saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>
---
 include/net/xdp.h   | 2 ++
 kernel/bpf/cpumap.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..feafeed327a2 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -303,6 +303,7 @@ struct xdp_frame {
 	struct net_device *dev_rx; /* used by cpumap */
 	u32 frame_sz;
 	u32 flags; /* supported values defined in xdp_buff_flags */
+	u32 queue_index;
 };
 
 static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
@@ -421,6 +422,7 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 	xdp_frame->metasize = metasize;
 	xdp_frame->frame_sz = xdp->frame_sz;
 	xdp_frame->flags = xdp->flags;
+	xdp_frame->queue_index = xdp->rxq->queue_index;
 
 	return 0;
 }
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 04171fbc39cb..f5b2ff17e328 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,7 +195,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		rxq.queue_index = xdpf->queue_index;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
-- 
2.52.0


