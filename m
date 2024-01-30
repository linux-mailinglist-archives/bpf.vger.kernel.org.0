Return-Path: <bpf+bounces-20767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3BC842CFD
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 20:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD14328B943
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3597B3FF;
	Tue, 30 Jan 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR+0qLpp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5407B3F4
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643418; cv=none; b=ZRpv6rGq5DDljnEg6vKN8JQCiUXRlNiEb/LQr+lsNwPnk9q2jujxOEs3wW0H4Ug2aUbwoG17+zHDHHEaIsu62UrmC+QcyaE5ECcKpxeK6PyLcEG/DIAlJho+wNgrNXwUVLI+zb9rCaRv8hHey6ZEu0FGtxchplVbUzurMV0H3ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643418; c=relaxed/simple;
	bh=rx6MS/4rw5emBKTmyPnT5Vrk3aalikxpzxkI2BKRfH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K9Z1WdTT6Cg/lmYXdX+LGD6Xw6Yf5pneQBj3FKiFodHN0LPoic5NRgatB+/t6H2CKgRb+kNRri4kgEgiFAvzru6BkQ6+/0Bkbm1CQInb+rua62Pi4lZJ/EXn1QUW7z99y/NM0qrz6wMMTRi92Y9TRi4SNrm/AxJ/26s3HajG9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR+0qLpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF50BC433F1;
	Tue, 30 Jan 2024 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706643417;
	bh=rx6MS/4rw5emBKTmyPnT5Vrk3aalikxpzxkI2BKRfH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oR+0qLppFFx1EGZoXrn/j+oEy7UCWhN9UZntwMhMf1bFYu3HUeZDv3AFgDmGrVMIb
	 hwm3Oq+DVyHu134LVqtpLKjKvrQ04TGcf1A1cc1huS9WSHtSuokDwqB9UuoZ+OI2eJ
	 JqBXpErWSJI2cGrOzdM32liOKxGgYMtCwp7NpDW7bdw4Ebf211jczRFyyZ+MbCUcZE
	 H3QTGPg9wY4fWTD/+a3Fg58EJT5ji2y1YCJIeV6ABy6TQsaldK/wPeHMIhlMkRSJJD
	 NzaZv1+c6ipHQcJyWowoX0gvYg2o59UpxW3UUnW/TlzaGUiKA6bLTuDc1lIYMxgcDc
	 0cMJX6NbhyRkQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/5] libbpf: add missing LIBBPF_API annotation to libbpf_set_memlock_rlim API
Date: Tue, 30 Jan 2024 11:36:46 -0800
Message-Id: <20240130193649.3753476-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130193649.3753476-1-andrii@kernel.org>
References: <20240130193649.3753476-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LIBBPF_API annotation seems missing on libbpf_set_memlock_rlim API, so
add it to make this API callable from libbpf's shared library version.

Fixes: e542f2c4cd16 ("libbpf: Auto-bump RLIMIT_MEMLOCK if kernel needs it for BPF")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 1441f642c563..f866e98b2436 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -35,7 +35,7 @@
 extern "C" {
 #endif
 
-int libbpf_set_memlock_rlim(size_t memlock_bytes);
+LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
 
 struct bpf_map_create_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
-- 
2.34.1


