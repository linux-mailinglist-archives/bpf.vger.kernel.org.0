Return-Path: <bpf+bounces-70398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78829BB958C
	for <lists+bpf@lfdr.de>; Sun, 05 Oct 2025 12:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0A41897249
	for <lists+bpf@lfdr.de>; Sun,  5 Oct 2025 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2966C26CE0F;
	Sun,  5 Oct 2025 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="N3vnppGD"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF623815D
	for <bpf@vger.kernel.org>; Sun,  5 Oct 2025 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759660897; cv=none; b=gPSJs2Ck5R7G6DNXQp/USDSV6ENx/Nwb51ibZSVpmcCpdbON/ZN6ZClIPNLne8h6RT5oUl+iQeg8eZ1BBpyGW3qIuRgm/APxaZio35yCoXv7t8/tGl5YPgJbG3azHwujvqVxmFUHthzX6iSs5LC4L+J1T4JrJuTXEMZDIBKsSIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759660897; c=relaxed/simple;
	bh=T+R+ZAN+i6oZNxby4XecGdYgUouf/G9Cwd2Cc2iLqiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTOY0XCexooXeLAxBMpv7jSJr4HINesG8Nd4tV9Ro566Y69T+n+r5BGkPmefEpS18jsOuHy6OE6oaKhsBWtf602R3R7kRWPMBwDtQlcUQcCGW42EjvhiMf51q1jUnYIR9xreJZo8xfENUmjm6/vYNWxwXEB+RvufbORxCZGbAqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=N3vnppGD; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1759660887; bh=gh9koqm/xzCbWeUEtN4rA+PpTN8uang8ZJCu2irKFfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=N3vnppGDKSpKnxqmSe6ji7LkjicxtnJTsY2c9kglpRc8PsTro/JgjvtPSWWoBsMuA
	 q6bI6si5v4U3035Z25N6ZyURTUXupgKoaFmmxF5uZ8hT/gbhdkx39RtSHStGNqaCLI
	 bux+SKA1RZNoai1wbvGvsUSbmpY6wOZn7J/iO7x7e2Er4l8qb+Nv1Sy21p6EzJmJby
	 7+Mup6hdulRNU/aO6AVTH9EaZLxQ4by4RSEh5xdrYRvPOqd1EOlmLQNk2zbHxBL8C8
	 ZbT6iRutZ29RHCkXG+vWJTw+jcKfBuG+Ie93MwrT+Oajxy3/MARmFLUY+N1oxGT97f
	 dG+O8MiEIpbiw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4cff8R3KTYz8sfZ;
	Sun,  5 Oct 2025 12:41:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3632:e00:f174:1ae7:eb66:61e6
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3632:e00:f174:1ae7:eb66:61e6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/Sgwr1jAozJo8H5Yt+UBsB/Wj1gPi+l+0=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4cff8N0yrWz8srx;
	Sun,  5 Oct 2025 12:41:24 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: luis.gerhorst@fau.de
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	eddyz87@gmail.com,
	hengqi.chen@gmail.com,
	yangtiezhu@loongson.cn,
	yonghong.song@linux.dev
Subject: [RFC 2/3] selftests/bpf: Fix SPEC_V1/V4 for other archs
Date: Sun,  5 Oct 2025 12:41:12 +0200
Message-ID: <20251005104112.999368-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <87plb17ijl.fsf@fau.de>
References: <87plb17ijl.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, SPEC_V1/V4 is not defined for architectures except x86/arm64
even though bpf_jit_bypass_spec_v1/v4 is usually false (the default)
there.

To avoid triggering tests failures on these other archs when adding the
missing SPEC_V1-ifdefs, set it there (and on all other archs) to put it
in sync with bpf_jit_bypass_spec_v1/v4.

For PowerPC, setting the value correctly is complicated because it
depends on the exact CPU and security config. Instead, skip unpriv tests
there.

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 8 ++++++--
 tools/testing/selftests/bpf/unpriv_helpers.c | 7 +++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index a7a1a684eed1..b97fbf33fb3c 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -258,11 +258,15 @@
 #define CAN_USE_LOAD_ACQ_STORE_REL
 #endif
 
-#if defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86)
+/* Add architectures that always set bpf_jit_bypass_spec_v1/v4 here. If the
+ * value is determined at runtime, it is best to skip unpriv tests by adding a
+ * case for your architecture in get_mitigations_off().
+ */
+#if !defined(__TARGET_ARCH_loongarch)
 #define SPEC_V1
 #endif
 
-#if defined(__TARGET_ARCH_x86)
+#if !defined(__TARGET_ARCH_arm64) && !defined(__TARGET_ARCH_loongarch)
 #define SPEC_V4
 #endif
 
diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index f997d7ec8fd0..af532d6ea512 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -100,6 +100,12 @@ static bool cmdline_contains(const char *pat)
 
 static int get_mitigations_off(void)
 {
+#if defined(__TARGET_ARCH_powerpc)
+	/* Unknown, depends on return value of PowerPC's
+	 * bpf_jit_bypass_spec_v1/v4(). For simplicity, skip unpriv tests.
+	 */
+	return -1;
+#else
 	int enabled_in_config;
 
 	if (cmdline_contains("mitigations=off"))
@@ -108,6 +114,7 @@ static int get_mitigations_off(void)
 	if (enabled_in_config < 0)
 		return -1;
 	return !enabled_in_config;
+#endif
 }
 
 bool get_unpriv_disabled(void)
-- 
2.51.0


