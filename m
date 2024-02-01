Return-Path: <bpf+bounces-20972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF88845E63
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 18:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBD7283106
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4341F5B048;
	Thu,  1 Feb 2024 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dP2t6ZUA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA545B036
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808075; cv=none; b=smvfJ0YqBe1PMHpIvSLEiAx1p9B804GSvjl1Rv54Tk982iS8Ll+LLdP/OvA/innGjuYQyfsX1aw2pZzrdLAoJU/9ixgioIe+OWunY6MksVeGwKftLCQal8ZaQxeCCjdFFkZ7T/y5vmw41zYCxxJFSEhjbf1CpgOAMGfxophi0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808075; c=relaxed/simple;
	bh=L+eZFxcUFuMBBvoa3ThQWD/xOVAWLnTTYQNuKJHiaaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n3xa6jGk2yBf1L4kL7i4WKjwNN8JncXMasETHRe0jZPASwm1GMF2iW7RejtamJtCB3OCOQSSWeBHqgGe3BYgduBUzXCnB7z4aLHPNNp4Blev1qVuZE3Atfmy6flk7BxZ39hPY2K50l0RfILzeE96JL93tKjLAVSxxnwMKvPYPKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dP2t6ZUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C82CC433F1;
	Thu,  1 Feb 2024 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706808075;
	bh=L+eZFxcUFuMBBvoa3ThQWD/xOVAWLnTTYQNuKJHiaaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dP2t6ZUAXbsK/8dxbE94DP92Zwh8o9Rmmx9fhcNACe7fESuy8Ot0R0Cdz5lv+itI2
	 JhKmGdT2obS70F6d/JpdgaxNDkK6g3soYujX73BGx7U37ZA7btc+sMumgKTNRwl5ho
	 A93PDDVdR3EphhIkdo9mlzF4Ir+pzwIXXyMk43+p8F3iYOcAnFNzoXMGmieo+hSgBc
	 sg3+87c1TsWfKBXEJfuIM2wbfLwM0MaDH23MyLtI0oG5WR1IewdI5mSkViH5hT9Q7Z
	 lqzyAZUphJ6AHhWjL87pnCgJNe6O4b3ndRCVn8cGJB63FtvfiRNMlcxnG3UlebG9e1
	 6AixeFrDf9/iA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 2/5] libbpf: add missing LIBBPF_API annotation to libbpf_set_memlock_rlim API
Date: Thu,  1 Feb 2024 09:20:24 -0800
Message-Id: <20240201172027.604869-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201172027.604869-1-andrii@kernel.org>
References: <20240201172027.604869-1-andrii@kernel.org>
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
Fixes: ab9a5a05dc48 ("libbpf: fix up few libbpf.map problems")
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


