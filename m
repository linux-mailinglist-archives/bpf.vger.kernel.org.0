Return-Path: <bpf+bounces-48074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA41A03EA4
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C241884F78
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660DE1F0E36;
	Tue,  7 Jan 2025 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0STvmqv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696CA1EF080;
	Tue,  7 Jan 2025 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251706; cv=none; b=hYl9+AaZ2QxR/6tnj/oGCDxcuRRMG3z4n/LFizRevJf627OmtBgGxf42Roz1ZwzwXBBn9/vssOyL/7Oi+4lIQtTxT+V6enJ2ak2BBpBj7gBmgTIzirC/2MPLHVvkYmm55mCD3YvOVyU21T/6pBQKev1huJgeQGBtwxmKy+GOTcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251706; c=relaxed/simple;
	bh=rwh/Sdvw8Cyqx4MZdZgM7ir/civJuEX2EqHleHtzMmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEEg/pN+K/dgA6d9qqEmqE4V7DVq1ftjMdS4HU1d0pA/qSjbCLv8rtZs3TcOt5nLXbfBG/Eyylz7/kew2tF23jzUROMww1wE5PPrNjJLV8NObxG8B2sOG6iiaAL54iFuwRxoBXg315UzR4pDv/IAHesrozPVmnXNREpoe5M/fPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0STvmqv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21a7ed0155cso4873555ad.3;
        Tue, 07 Jan 2025 04:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251697; x=1736856497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OCRtXrynCQq34YyOvSw6d6QSzz1lqkWDPmH7k10/UA=;
        b=B0STvmqvYoyuPMS4pAlkzvZ7rsPp3UCSiql1cD7bD40YW7xz9I2YDZQq1bN3FyXdX9
         zbtZPPiJnsHT8zHV9cBRJJJ2fM+n4QIGuKG4wqUybsGrYRfNOJivO+5APyha0vDWlRJ4
         WS7k7Muu1fWpHV5nSaJP9MnFwBfKSATeg4vKe1A0RCL35dP2vF4oIxT7bVhAYmymxFVu
         ASooHsnsgL7FF+U8fDPHc7tcyTbtC96XqQDx7wwvGb7jm9qXwTeCgSJ3FxabZomlj6NG
         z4cYWdTCUvBuGkGPan7OVhHP7OkhHk0w4lRF/PMoj9i90sEcLGKZV0mZ3+cXCnj1NeGC
         zqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251697; x=1736856497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OCRtXrynCQq34YyOvSw6d6QSzz1lqkWDPmH7k10/UA=;
        b=JVpF/RakXvmDEPEf2zMqHIPoHtg+T7Z6KeoRipEwGD+Nj70nlUvWKGHuJamgr8AT+Z
         zeVDrPyBzL7Dq52aPtJ/JZx2ewVRQDdG0FJ0asm4D94kyLNMgSDmUWHWr7O73jm2AN2v
         R+5lRjXp+5n+9fQuewlb5hhclnM6w77yGeRgNX0JZz5Y2XHVQkbFjusVYdtHSS25dEDE
         MBtNBZ4dxPFN56kRCoSfiRWOtgDOAtbe1iRBm2g3LL/EWvgNrfVK1g9R51LGcj9a1xsD
         pFfodyW+sZXoE1ITGaB5RNULYDG6lF7IUMZUKGt4NwQQSYJprk+ZjMw8nX8uH1y9/WwU
         8fyg==
X-Forwarded-Encrypted: i=1; AJvYcCUOXmu2r/j5OINB8vkbt3Hm9l+jqkSIfd9MN+Djrh01CSTSGcDA6MANYGQv2+vVny0W+xI8L3Ogmpr4SQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNrn9NXUZ+C/EYEmsJqmvO69OdbALLm++NyA2/QyQaxVfJDIY
	+obxhxSrI8pFvEXA3O240H63GipmgPRtCzeuZlfQiB8hkb7dcrpb
X-Gm-Gg: ASbGncsNVuRyJUcVtDMoTx49MyCMn71+ZBmy0M+C/5xjzL1XiwFMfAsgHrn800YZ5CC
	pcHFk3L18Ir47SXVyK46awjxKwf1y6LU46VUWSEqyN1ex3eF4KGt2/heyeUi3hZAkj00xqNdP9R
	UhtIja1xtaeR/oBbxHvw0k9s2OrZydz4aB62BligseCuS8LorFeh6HGMFWDjIhJdTooIpxm6jz7
	EnFu/5XfM9rosCUMoSdJsYEN/zQfv2smDo6dDx2KMxDL3iiFJQ/n9Vw4b/dsjWCSD1+
X-Google-Smtp-Source: AGHT+IHCFAXbWhFBOxYybnDYfv8S6jfPyrWW+tnhPMAI2bNhqoH8muMHe4XnlBcn4OymqwA7eOdodg==
X-Received: by 2002:a05:6a00:3cc1:b0:725:df1a:288 with SMTP id d2e1a72fcca58-72abe18acb0mr85121816b3a.24.1736251696623;
        Tue, 07 Jan 2025 04:08:16 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:15 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 07/22] ublk: bpf: add bpf prog attach helpers
Date: Tue,  7 Jan 2025 20:03:58 +0800
Message-ID: <20250107120417.1237392-8-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250107120417.1237392-1-tom.leiming@gmail.com>
References: <20250107120417.1237392-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf prog attach helpers and prepare for supporting ublk bpf, in which
multiple ublk device may attach to same bpf prog, and there can be
multiple bpf progs.

`bpf_prog_consumer` will be embedded in the bpf prog user side, such as
ublk device, `bpf_prog_provider` will be embedded in the bpf struct_ops
prog side.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk/bpf_reg.h | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 drivers/block/ublk/bpf_reg.h

diff --git a/drivers/block/ublk/bpf_reg.h b/drivers/block/ublk/bpf_reg.h
new file mode 100644
index 000000000000..79d02e93aea8
--- /dev/null
+++ b/drivers/block/ublk/bpf_reg.h
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#ifndef UBLK_INT_BPF_REG_HEADER
+#define UBLK_INT_BPF_REG_HEADER
+
+#include <linux/types.h>
+
+struct bpf_prog_consumer;
+struct bpf_prog_provider;
+
+typedef int (*bpf_prog_attach_t)(struct bpf_prog_consumer *consumer,
+				 struct bpf_prog_provider *provider);
+typedef void (*bpf_prog_detach_t)(struct bpf_prog_consumer *consumer,
+				  bool unreg);
+
+struct bpf_prog_consumer_ops {
+	bpf_prog_attach_t		attach_fn;
+	bpf_prog_detach_t		detach_fn;
+};
+
+struct bpf_prog_consumer {
+	const struct bpf_prog_consumer_ops	*ops;
+	unsigned int				prog_id;
+	struct list_head			node;
+	struct bpf_prog_provider		*provider;
+};
+
+struct bpf_prog_provider {
+	struct list_head	list;
+};
+
+static inline void bpf_prog_provider_init(struct bpf_prog_provider *provider)
+{
+	INIT_LIST_HEAD(&provider->list);
+}
+
+static inline bool bpf_prog_provider_is_empty(
+		struct bpf_prog_provider *provider)
+{
+	return list_empty(&provider->list);
+}
+
+static inline int bpf_prog_consumer_attach(struct bpf_prog_consumer *consumer,
+					   struct bpf_prog_provider *provider)
+{
+	const struct bpf_prog_consumer_ops *ops = consumer->ops;
+
+	if (!ops || !ops->attach_fn)
+		return -EINVAL;
+
+	if (ops->attach_fn) {
+		int ret = ops->attach_fn(consumer, provider);
+
+		if (ret)
+			return ret;
+	}
+	consumer->provider = provider;
+	list_add(&consumer->node, &provider->list);
+	return 0;
+}
+
+static inline void bpf_prog_consumer_detach(struct bpf_prog_consumer *consumer,
+					    bool unreg)
+{
+	const struct bpf_prog_consumer_ops *ops = consumer->ops;
+
+	if (!consumer->provider)
+		return;
+
+	if (!list_empty(&consumer->node)) {
+		if (ops && ops->detach_fn)
+			ops->detach_fn(consumer, unreg);
+		list_del_init(&consumer->node);
+		consumer->provider = NULL;
+	}
+}
+
+#endif
-- 
2.47.0


