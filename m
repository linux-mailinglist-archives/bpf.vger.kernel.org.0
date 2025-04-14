Return-Path: <bpf+bounces-55873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3237BA8883B
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B4C188F40F
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C8527FD46;
	Mon, 14 Apr 2025 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly6IffQG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F35027FD57
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647293; cv=none; b=ji8I2+ighgSrbcwEdTrG11WpS5bS5g/nEf3CiftjSWpaaDhg2Vi0U1cyIh+FO1wVr9o+XeDtzet6Z/8oLLDLcIG4yBQWGdj6YlI61+Ty/T5GC1VhcERuMJ+ruF81YTvqfxSSI+fCQiPQweLfyvpHgM9vPs3izn9owPMgBJyTCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647293; c=relaxed/simple;
	bh=5K4TDnlIjE8v/7hHJk/725YzZ9arPP2wmLJbEmtt+hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9OGBWpjwKF8DIK8J+rhph9yfCh5fkLKL+c+0qOrZCR7o2BjF5zn/18yNBKrZG8w1AU7AAdTCGxcmgqzZrcr982qhWcZHDDI3k65uiryrg68fJWah27Xl5NuyF49PQ9Q222DTu4x84W8Yh6S/F68K1cujOq6YfNKjg5rl/grzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ly6IffQG; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso46105485e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647289; x=1745252089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR9HrXHE5/l7dO3H5pkTrp5KXd9PnBCvuVAcTnpVvDA=;
        b=Ly6IffQGfzErd8+pqSj5VVfjkJPEz5Vn2SD55rTVznnJanBOr0I2ayeUqQHOIwUYPX
         pFVAKuu8mX8mBySql6wpKP4B26NAfOEVOfFJ+1avbJfsR8DFlYZ25MzzaGPeC+H8ZLO5
         dSaCXQ1Pb4iuXw+F4zTT6xjEVJzMG0pB0nxTsQlikkheVybU0PTge5j4DQitGtA8NWOf
         8zSDWsDgxTd2k0iA6IwQLK+mDY8I4hE91GaE8UGtekfaVlLt9dxjs7S2C7gXwmrOMnHM
         ELLXcHWZTsY5ldQNyTSAT+FPEZQiEs1gcLqx8QnKtyjU1sCK5bqPRZbF+2pezuhsul9M
         cvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647289; x=1745252089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zR9HrXHE5/l7dO3H5pkTrp5KXd9PnBCvuVAcTnpVvDA=;
        b=ahtAMC4PZtB+/Tvnq7rUaWBPliCnHh8R1rXo3PbgUlWwhu9pkeUiYdWy5zkUyXbc1R
         W5K2KvhwwP2DvphKKH77AwN67e9Bb9WctGhRkNv5VLIysM6ZI54rD730u/kbPPboA8je
         dgeT69pmQ7FyA9Z8X16aze+xB9YLyt/R/XYNy4YI77hRC/9LpJIPTvWqMim1oXAo2/zs
         fq17CCyMa+jEL32wBEMmsqxWi1oAD6VxntXAT45Hd01B6ofy6yWJ4JRczXWzBp4Ik0pm
         tKsC2JKvbec7SwrILaA+6OpaqXx4/WPZXkeSvMQjpTIRxrBbeu9mKzhijWr6bmwuh02+
         eXLg==
X-Gm-Message-State: AOJu0YyDAbKaMH/XGcBH7FqbAZKmRbOJhiyAhairmydYhFRgQUncKm82
	OYXNh8RjfzJd6QuWCxjsw0e8edM6SeDmBbSblSBSWt2PAWVX/i0zlBtI78wXJ1U=
X-Gm-Gg: ASbGncsKoHKO7RFfTZFB9rotxHDd2ofOnU4QFXDu/+p7UrxIGSl0SZlUs02V4qK0H2k
	9ZnLN2JaQFLAr6rNB6Ad99B4E4in4OrIJPZFvbM5ue5NzDTDtivPd1L9kLidTu9t9LGTeykxif8
	0l5pBsPezNnOPqqAz9ENPEg1FLhM4tGqqWgqUFM+ItdJTASeKiMdNs2QPx/BJpZCLBEWkPeKpwW
	2sSAZY6aob6jOU+kdaoiw8FXs18xzfm9KoP/KZ2Xac37l1Z9/8v2wfzYaUxgKdN7ivGYf+Qk+de
	4SXuRo3FBUaVhhLRDZspmWY3KBEY0Xk=
X-Google-Smtp-Source: AGHT+IF8+PCNHo3vyusMKMw6MrCpZ3v6vMOO2VYf6JiQV4sQiei9XzbKeRxAErJBg6BT5Hb8W6jmIw==
X-Received: by 2002:a05:600c:1389:b0:43c:f75a:eb54 with SMTP id 5b1f17b1804b1-43f3a93d3e0mr108003265e9.13.1744647288840;
        Mon, 14 Apr 2025 09:14:48 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:41::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445270sm11272169f8f.81.2025.04.14.09.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:14:48 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next/net v1 03/13] selftests/bpf: Convert dynptr_fail to use vmlinux.h
Date: Mon, 14 Apr 2025 09:14:33 -0700
Message-ID: <20250414161443.1146103-4-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414161443.1146103-1-memxor@gmail.com>
References: <20250414161443.1146103-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428; h=from:subject; bh=5K4TDnlIjE8v/7hHJk/725YzZ9arPP2wmLJbEmtt+hc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn/TOJktqCA71LdbXi+pt3bcnwUL/HYMb2kqXLVJ1p /qV/youJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/0ziQAKCRBM4MiGSL8RyphBEA C8TUCA5Ji/7EU9n4SxZZ/3VjtBbWU0y2v/vwMIfrDKxZCfQqKd3pkj7SAb4UPxFGk2BCdZyz2G9sAP CvI6JBvnTOxmspOeoNHFj7SBTO3fjJY2eMfgRKpaYT9Njmw1gEHjvVuUhMHoh4FttwGqG5lGSADCew vmc9+8OAAhBkaDTSkpb7V9PB36bDKIxrLRELKtQH1SQKWxsRnf3N1vJ48gipSSCrhkQd0t92VSOxBT bWAtse+VPcoezRb/+OPpd1SuPasNTq1ers5lKc4m6Pr2DOkm2nFBN8XWyKpC/Do/ePvlp7Ar7feGd0 G9xUq+NlaOTW3rublGGXg3toYAtcDmkGJt7YyOyDBF1gehLKa+bJ3it81MhjZwDQs1364j3n2FiY3F 7Ws+04lvjkN0wlScmtRkFal8RkX2EFiiY1DMvgOGtRgAmujti7yo62MEwgKh3vEmj0mvuyZ05OJ7zH dQbhDpxSnwfwKQDOESBjj9mLvCbZo8UmiVrwUP2EQoeVf5K2ezawl0pWLsGoCRRwclOuKx2ari2bv3 A/mxd4Z1V0CZ2FY8iU4wn3XtGUThHFcMt3kSYc0q08w13ipYmxWJP836u6NpCdMs5G6hNR2d0s6ltX 8rPIvqab+mmnpOaM+MDoOXTOs5uYCaImM9dbfe4rYky0FylaquRAKLZxMFNg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Let's make use of vmlinux.h in dynptr_fail.c. No functional change
intended, just a drive-by improvement.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/dynptr_fail.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index bd8f15229f5c..345e704e5346 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1,13 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Facebook */
-
+#include <vmlinux.h>
 #include <errno.h>
 #include <string.h>
 #include <stdbool.h>
-#include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include <linux/if_ether.h>
 #include "bpf_misc.h"
 #include "bpf_kfuncs.h"
 
@@ -46,7 +44,7 @@ struct {
 	__type(value, __u64);
 } array_map4 SEC(".maps");
 
-struct sample {
+struct dynptr_sample {
 	int pid;
 	long value;
 	char comm[16];
@@ -95,7 +93,7 @@ __failure __msg("Unreleased reference id=4")
 int ringbuf_missing_release2(void *ctx)
 {
 	struct bpf_dynptr ptr1, ptr2;
-	struct sample *sample;
+	struct dynptr_sample *sample;
 
 	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr1);
 	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
@@ -173,7 +171,7 @@ __failure __msg("type=mem expected=ringbuf_mem")
 int ringbuf_invalid_api(void *ctx)
 {
 	struct bpf_dynptr ptr;
-	struct sample *sample;
+	struct dynptr_sample *sample;
 
 	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
 	sample = bpf_dynptr_data(&ptr, 0, sizeof(*sample));
@@ -295,7 +293,7 @@ __failure __msg("invalid mem access 'scalar'")
 int data_slice_use_after_release1(void *ctx)
 {
 	struct bpf_dynptr ptr;
-	struct sample *sample;
+	struct dynptr_sample *sample;
 
 	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
 	sample = bpf_dynptr_data(&ptr, 0, sizeof(*sample));
@@ -327,7 +325,7 @@ __failure __msg("invalid mem access 'scalar'")
 int data_slice_use_after_release2(void *ctx)
 {
 	struct bpf_dynptr ptr1, ptr2;
-	struct sample *sample;
+	struct dynptr_sample *sample;
 
 	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr1);
 	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
-- 
2.47.1


