Return-Path: <bpf+bounces-63470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A13B07C76
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 19:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6184C17FB33
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 17:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7C8288C29;
	Wed, 16 Jul 2025 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSHtgeA1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282D19755B
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752688778; cv=none; b=ff3+JJH/np2fWjwFLZrJI2zQHatGDGLoRSD/OIBaz9whx66FSZXkDPSZWxDLQODIJAa+3o2XagUfQdx8kyULASbJPlvvXtFiUIzBycLf1BCM8PwbPi6RF9nD9oqYS/jBwssYn793slPpqZ0slvmVPtBV6por5EUFg26PhP0W62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752688778; c=relaxed/simple;
	bh=LoyjGtHbHT7s7LZRl7rfAQp1XIAnVbVfYYkmMIXZ2GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CC+a7FVp5L/hElwSLZeIiBeAuP5G6IltSepitSH100WHvgpCuDAstE0YgEJ1GD2E5100Um6NKuIFW10sAT4LEXzK8BlrT7w+3cc+PPUVkHQIolBF4KX9V+0hhGwBE4/iWg8rr1YFEqz090mAdjPuBQ1Aqf48a50/fds4IYIIxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSHtgeA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB37C4CEE7;
	Wed, 16 Jul 2025 17:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752688778;
	bh=LoyjGtHbHT7s7LZRl7rfAQp1XIAnVbVfYYkmMIXZ2GQ=;
	h=From:To:Cc:Subject:Date:From;
	b=GSHtgeA1dNVgHE7JT2Ss3WgQWjVMRR9X1Q+knJNNLKHaDP5K1PAbjrXQymC/FCbKy
	 aJEw2SMNrrnMYYesmQuWz9YsjmDjHUP5WXSAbkR1MqZLJCke8bdIQRCvRS8jw8Y84Z
	 3lGPta4SDpyeSTPCnRJZkPGRJTWL7XwzWmgHYULWcaOl7Flb7PD/HDCMteSywk7BtW
	 wYLtkj2ZDmH7VTcAlCC8hInazYWcaQCVEfdu/D514TZCvNBBdaxMWmyw/72sU4j6rP
	 xAhPeN6IGDpq9ou91zeuR4pWBDUZ/sSSs+F/byABUttjhFnMFKfqixQ7iR39XP1OVj
	 vZj081Zt7Obkw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] libbpf: start v1.7 dev cycle
Date: Wed, 16 Jul 2025 10:59:36 -0700
Message-ID: <20250716175936.2343013-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With libbpf 1.6.0 released, adjust libbpf.map and libbpf_version.h to
start v1.7 development cycles.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.map       | 3 +++
 tools/lib/bpf/libbpf_version.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 1bbf77326420..d7bd463e7017 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -446,3 +446,6 @@ LIBBPF_1.6.0 {
 		btf__add_decl_attr;
 		btf__add_type_attr;
 } LIBBPF_1.5.0;
+
+LIBBPF_1.7.0 {
+} LIBBPF_1.6.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index 28c58fb17250..99331e317dee 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 6
+#define LIBBPF_MINOR_VERSION 7
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.47.1


