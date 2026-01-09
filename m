Return-Path: <bpf+bounces-78310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73264D08F1E
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 12:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36CD83032941
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90FA35BDAC;
	Fri,  9 Jan 2026 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwZdNikX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526EE35BDC2
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958162; cv=none; b=A0CQ67XsbUkVDQhfk6QxkxkffSbhMBxfXCcm7YPxIUR6AJwdQaDXTHzoLqOp+S7LxljAK830B2+yDj8xiz+CSWFh88IzU7l5pfdhzAtdYll23qZqaYRz+NHh6NgkB7DoeqdaqxNfXh32478AfTBz6T5m5BXRiF46kVyI4jjI7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958162; c=relaxed/simple;
	bh=axdc3q5KY7YeHULab/TvgzOYs0oof9ugiogriyYfhIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwVWztOAVfPlxWIWFHWZDQTx511QfYU+A3SafhLU7/kaBEULUWa0PoDiIG+hpYLARbmTd9Sn7j5sCuotJZk9+60sZnfGj9HdNrU1UA3eJkirHrcMe9cWXAsDSEiwYa6X0OciqkNLQKaHq6g3y3N8YPqLWWy3eL4iso6T5axdUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwZdNikX; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so39239245e9.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 03:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767958157; x=1768562957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiBEtLY6CE0u/w5HMF7IyfpDPmY7qzN3np9POU+8r/k=;
        b=QwZdNikXMmUiWaP6LrA6Ss+L4IlbzqbF8LAkHZkrSJYHJAwJQzeZm6Hovf0wIRcqhB
         PexztlOhMNAPcHnKno9bvafz3SBPHuPe1N7aTJkWq4qn5RX2N0DAbGl8jfVmU8Pzq1o6
         FvOIooIaqyNuWlJfMg1Rv0KcZ2IBryt5yp4e8HRITnG2mhY5v8pSnqUDdS0cR8H5jQmV
         TdNAm/O3qnO5a4/RMRYI/H+6j9zwcW+NQ/Kr2oZnB1oA3WbpZqAi6YFG9a4nhi9r1ekM
         3d/nerDRq2lYdG8wL7uo6OszlN/QB0A6zKiLWKvDRusPD82tpNIL64qInLSG2s2XojGf
         jOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767958157; x=1768562957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kiBEtLY6CE0u/w5HMF7IyfpDPmY7qzN3np9POU+8r/k=;
        b=TwSgKhoPS+HFzdK0ubuq6/jbxBWERGsoV2lHL6rf5N6SgEuKLqhSFehINirTucf44H
         IdzWBc9G3s8WO6YotEk0lpV/6PmJyzNEeY9wkvRjjivqr13bvUFcrYu533iW/kz0AyUj
         QuveI0BqBJAsowmd4GWMVdvcb5riSlf3/2XBGcrLtB+TYJcdxbxeck9FYNhuodwWePai
         cAhQsoUAPEaQ4GN8WLy+cpMdXaml7B5Q/04sIGm6R/X2aJlVLonfpzynsXemUkrwUPzv
         w2lChZUdJtxP2ZmujNstuaDc+YPjKo4OhG956XoYJYXoo/5Tv44RlzcK+ZM98/vGFKw+
         ovLA==
X-Forwarded-Encrypted: i=1; AJvYcCWks9ndMw4IXEdMbCeZITNwswFs++m7jS3fPx0mfdna0sxsMEW21PjoiQ3ZrOhlyx8/TjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjK9hzTO1t2D+K5C4WCuuA9KYL2oyExEOAOKa/f/mPXQkYDXQv
	hyRF0VTXo0vpypJrevuCbYd6F1iW8CwT5RtfRLgrOIpWupjO6U7mxa7G
X-Gm-Gg: AY/fxX6MsXOP/O6giQb7yLk+GqPbuxSxcTjo/ywjUs3QWo1sUKZVY0mBjN19uWj8RP5
	xTovsVyvu7QVzZ3LsBjUTSJ/3ZGjVhIZ9hd85gEY26ErADe6XNOXkxm2KyqMlCzKdACCqb2zLyf
	UWdK/nUtlXwIQ41L/y2suqPKUgELPedpNKcR1nCsVziO9lTO0KJzLfyQp3jhKp7609gEd0Qhu8g
	cYOEO2Se0SEVSNNJP5iS6GkuAWBrP/KPlsZB/w+1PYe+y3NymMcyXy+XedgGJUAD8lYDndYmWAK
	caIgEZIj6t3xmHUu+PI+8VNX92g0z2xSfOjnEBSEhWMGCA4z0mWyio6GciiCLCAWvGe22xXsELX
	CXKqrvWAn6UlxpOLsjFWW+XQzLMgO3uBggrOBDobz+zBgk/ZQ6SLNvE6WD/kg0M3/tit4n9zf9R
	kRvM7BPKWbi4AmdgvAEAA2Nhs4ooJySusIgjzlfDMZWJSQIQZA5bqJtEdGRS0v1/EX0ZFyTnaQG
	dZF5QG1
X-Google-Smtp-Source: AGHT+IF6sUa9JMjq/7LpBs2cdH8SCduGosXSIcxXOG6syAloBrtUa/I4hJziDJatmkaPD68dJ1oitQ==
X-Received: by 2002:a05:600c:1d0c:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-47d84b1fcf9mr101969345e9.14.1767958156631;
        Fri, 09 Jan 2026 03:29:16 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:69b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636c610sm60056985e9.0.2026.01.09.03.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:29:15 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v8 9/9] io_uring/zcrx: document area chunking parameter
Date: Fri,  9 Jan 2026 11:28:48 +0000
Message-ID: <65585c411f066a0565880ef0a9843e244d511bcf.1767819709.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767819709.git.asml.silence@gmail.com>
References: <cover.1767819709.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct io_uring_zcrx_ifq_reg::rx_buf_len is used as a hint specifying
the kernel what buffer size it should use. Document the API and
limitations.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 Documentation/networking/iou-zcrx.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/networking/iou-zcrx.rst b/Documentation/networking/iou-zcrx.rst
index 54a72e172bdc..7f3f4b2e6cf2 100644
--- a/Documentation/networking/iou-zcrx.rst
+++ b/Documentation/networking/iou-zcrx.rst
@@ -196,6 +196,26 @@ Return buffers back to the kernel to be used again::
   rqe->len = cqe->res;
   IO_URING_WRITE_ONCE(*refill_ring.ktail, ++refill_ring.rq_tail);
 
+Area chunking
+-------------
+
+zcrx splits the memory area into fixed-length physically contiguous chunks.
+This limits the maximum buffer size returned in a single io_uring CQE. Users
+can provide a hint to the kernel to use larger chunks by setting the
+``rx_buf_len`` field of ``struct io_uring_zcrx_ifq_reg`` to the desired length
+during registration. If this field is set to zero, the kernel defaults to
+the system page size.
+
+To use larger sizes, the memory area must be backed by physically contiguous
+ranges whose sizes are multiples of ``rx_buf_len``. It also requires kernel
+and hardware support. If registration fails, users are generally expected to
+fall back to defaults by setting ``rx_buf_len`` to zero.
+
+Larger chunks don't give any additional guarantees about buffer sizes returned
+in CQEs, and they can vary depending on many factors like traffic pattern,
+hardware offload, etc. It doesn't require any application changes beyond zcrx
+registration.
+
 Testing
 =======
 
-- 
2.52.0


