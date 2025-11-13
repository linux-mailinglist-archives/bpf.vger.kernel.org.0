Return-Path: <bpf+bounces-74387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A44ABC57540
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E13C8355209
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11CC34DCC5;
	Thu, 13 Nov 2025 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4EPI2xP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0B34D913
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035213; cv=none; b=RznQ3zi3/oqHZwxCdJJ84i+kNO1VTko+Hr6u25uPFVszBqnXs+NyAxN5CSFx+vOR8Iavok2i64Cb3V8QI3csNbyJYu0pQtGHng6axfMOKhzgAeXMoMMcuX+bFGJjCQlNgPGaZ+MPqBRAj6nb6CTdGocIr+62bYiAHryla4HjSn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035213; c=relaxed/simple;
	bh=JiFLmNqmjd/vjx2C0qtPvEbTcg8VXAhM7dTOW+8F6pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoZxfE5uprOMtaysN/TVeNV7PbazxO8ygROD2mT3orBZ9ZwR4KCaP4ca0kPhfrty8R8E029JRLzyv6B76/71EX5b2MJ02IwpbBjwIfGZBxNZI6sr8v8OFN03gs3Q7Mwp4KjVCY3oQFOgN0TFqegiTGGA/nf4T4mB0ajesBGecjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4EPI2xP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4777707a7c2so14921145e9.1
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 04:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763035210; x=1763640010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhjbIB7wkst0NSV7bgVK7c08B5hwQyZn5Dtcm/QFuRo=;
        b=X4EPI2xPZFXYYo3SlLHq0pOmGJioP8ZeEpENXTT23mqR+wAtIk4xkzD6AB7FIx7YuH
         4FWGs5bvXnqz3o2RhsWohlsdSl70hAFzVJI1EvvEebcPkT9GsBtVha5w24G5Oq5DcKX8
         kmtkr98y+wVwL2RET7EWm6aUkOXI/r5NM0fIOLMZeAVU7puGPJDkjdWhdci73MQ/Q/Ta
         ldY/uzS/9fa9q+AJFU69Hv/5UdX7v6U4cUQ+/Egg1CmfGQ171ERKr3tX/062f8GfXapu
         sJVNmMJX27FWox+Dajebna6FlKQw7a4juQT+8i1BriBwhoMuKOYKgORC4OmBGc8hiPk3
         WSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763035210; x=1763640010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rhjbIB7wkst0NSV7bgVK7c08B5hwQyZn5Dtcm/QFuRo=;
        b=X0xfqqWLfr52q9TTp7BeEzKKDiVcKOjyrjKCQuVef2GSIpaudUOOVjmJrYKDVMm2zJ
         utoXpbxxZ8R2EMB/vAv/mofWz82Df3y/yl+18dHwQV2ysHJr41dQF1eiBHkY56mQsIZ4
         WOzogdGbheC/hNPVRa5ysV7EAor1Pk/vLyt8A0ZKiLC99fqKuqVeibUaLdVM6U/sYur5
         ljWtMJpuz/xu1yvp3s5Tcr6rEkA1KFO1BBAVhCIzR/yCmGmQxKo9bEbcnxVwRjhNlqIB
         7P3w5+R3LpAaguamam7gViMDiOLoA1BAffrOVHyZBhWfAF9iMfwtzgzPPJujbz+60nGC
         YLQw==
X-Forwarded-Encrypted: i=1; AJvYcCUJjup90vCybJWdFEsYK/CGPsbaMMP12BQ7zq+0pdYVSMYrs6IefoT0zTiE92dN6x/g2Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYyykcw52tnKntf6KHzbi9LoHe1VZD27pYblNxAYbbNm3LESlm
	ErUPaq51IFLrGDTdD8E+yZF1PHI7jYu4jZPX+KJIXIzn+bbIEczzwMeZ
X-Gm-Gg: ASbGnctwE/SfBG4bwK0fXYN72IaPxX8gAdMjj1hyLRin/0zr6sP+6TtEpshrr8q3cuV
	mJhpMSjL3wz82tpwxcbBpBbpG6T+Zb/K6lIVjHV1WIKzAXkRqowegz1wrs+6MXan5nMEuWs/EL6
	JqPvA9PLcbkuMxTtgt7Dt+uCNVag34PvMcEVKsuDn7OK95xunPopjelrdXENfKqNrBNOLL0bmLx
	ZWJONAmVsXOhKccfzWWvxRM9TecHhZtQp7QqmzL9EiPzBaoDt72wSbK3jWu1MVrZRGFmLkZf94h
	OYZqo/vw2+wts7Gb5FBV8gqAqln04s2O+mkks5Ag8uFynbp/eA9apRBOnAJObbyqnnuSCqbnrR8
	BH4oQL58B8D4t/JOEAGkEv1tXIfcf9jLy+hn6iJt/TohPFJZJrgYVzfyAC574TbHA0/xbbg==
X-Google-Smtp-Source: AGHT+IFK3iiXM5qCCXBqD8NMgoGFdsSmnfI1rFnUAqA36dKLvrQFKZgIivV1Ps3+S+9eCW5FDOXzDg==
X-Received: by 2002:a05:600c:310b:b0:477:7ae1:f254 with SMTP id 5b1f17b1804b1-4778bd70fdfmr24321375e9.14.1763035209741;
        Thu, 13 Nov 2025 04:00:09 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:6794])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85e6fsm3686816f8f.18.2025.11.13.04.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:00:09 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	ming.lei@redhat.com
Subject: [PATCH v3 08/10] io_uring/bpf: add basic kfunc helpers
Date: Thu, 13 Nov 2025 11:59:45 +0000
Message-ID: <882545e8fec2dd36d9fc52aacb7387c80ebf8394.1763031077.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1763031077.git.asml.silence@gmail.com>
References: <cover.1763031077.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A handle_events program should be able to parse the CQ and submit new
requests, add kfuncs to cover that. The only essential kfunc here is
bpf_io_uring_submit_sqes, and the rest are likely be removed in a
non-RFC version in favour of a more general approach.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/bpf.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/io_uring/bpf.c b/io_uring/bpf.c
index 683e87f1a58b..006cea78cc10 100644
--- a/io_uring/bpf.c
+++ b/io_uring/bpf.c
@@ -3,10 +3,55 @@
 
 #include "bpf.h"
 #include "register.h"
+#include "memmap.h"
 
 static DEFINE_MUTEX(io_bpf_ctrl_mutex);
 static const struct btf_type *loop_state_type;
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_io_uring_submit_sqes(struct io_ring_ctx *ctx, u32 nr)
+{
+	return io_submit_sqes(ctx, nr);
+}
+
+__bpf_kfunc
+__u8 *bpf_io_uring_get_region(struct io_ring_ctx *ctx, __u32 region_id,
+			      const size_t rdwr_buf_size)
+{
+	struct io_mapped_region *r;
+
+	switch (region_id) {
+	case 0:
+		r = &ctx->ring_region;
+		break;
+	case 1:
+		r = &ctx->sq_region;
+		break;
+	case 2:
+		r = &ctx->param_region;
+		break;
+	default:
+		return NULL;
+	}
+
+	if (unlikely(rdwr_buf_size > io_region_size(r)))
+		return NULL;
+	return io_region_get_ptr(r);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(io_uring_kfunc_set)
+BTF_ID_FLAGS(func, bpf_io_uring_submit_sqes, KF_SLEEPABLE | KF_TRUSTED_ARGS);
+BTF_ID_FLAGS(func, bpf_io_uring_get_region, KF_RET_NULL | KF_TRUSTED_ARGS);
+BTF_KFUNCS_END(io_uring_kfunc_set)
+
+static const struct btf_kfunc_id_set bpf_io_uring_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &io_uring_kfunc_set,
+};
+
 static int io_bpf_ops__loop(struct io_ring_ctx *ctx, struct iou_loop_state *ls)
 {
 	return IOU_RES_STOP;
@@ -68,12 +113,20 @@ io_lookup_struct_type(struct btf *btf, const char *name)
 
 static int bpf_io_init(struct btf *btf)
 {
+	int ret;
+
 	loop_state_type = io_lookup_struct_type(btf, "iou_loop_state");
 	if (!loop_state_type) {
 		pr_err("io_uring: Failed to locate iou_loop_state\n");
 		return -EINVAL;
 	}
 
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&bpf_io_uring_kfunc_set);
+	if (ret) {
+		pr_err("io_uring: Failed to register kfuncs (%d)\n", ret);
+		return ret;
+	}
 	return 0;
 }
 
-- 
2.49.0


