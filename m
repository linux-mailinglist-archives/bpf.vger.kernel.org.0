Return-Path: <bpf+bounces-66067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5CBB2D839
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 11:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B4A3AEDBB
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3432E267B;
	Wed, 20 Aug 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJt+39o+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575DC2E22A9;
	Wed, 20 Aug 2025 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681765; cv=none; b=XYxF+B97Z2QOa8pQonLFzROZqnN8OlGU5vD2ITUUnYlW/2+J7Fh9yYuwWj2pIobS4vVq5NCaNnDHAPB+0gI3IwiU4VwZDVR7JyVX49njNrFqn8hWyvtr1TK5DEqN4TIKw87q+G3qa23MygavkuX086vIXECUrY3hx4ityMCz7eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681765; c=relaxed/simple;
	bh=eJ6WjgKVIsIOpyGHdORuYVWkUx9KS1agfZtjGvIXQfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kD1BQ8oAqNnY7Ic0K0l9yHBLTF9ccsinfgTPJG95vjAZ6flk0PcuYEgfzXIFIDfZGr6gJi93HYAvP6OxkGdBPUMBNx3KL7X1YDTFVWLqkEGnauQpiInw6S65sstAToZ+hrJfFmsddvsBi9tpr3CTr9UreIkGdGEBCbaIX/YCj8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJt+39o+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D037CC113D0;
	Wed, 20 Aug 2025 09:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755681764;
	bh=eJ6WjgKVIsIOpyGHdORuYVWkUx9KS1agfZtjGvIXQfI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nJt+39o+SEWLX9UKy60e4bd30oOCM4NFAM/2GxSQDWiStm9v7FtKgwBqXS9D2PCLS
	 NlOiGdUNpp7I6oBXrXhY+Lpjr61f2mG0uISoztei9YIqByI8qb8A6AUPiW1vNOveA+
	 kc7wmwttUj1I7bd2685oQwQbDN84aLcZR+F2OeSD31sPJlw1WdsBXfFGSdh9yioqrg
	 5oB6jMIE6FyPM+WqKtplyfrAaCBx7JCwsxysX1UixX8YZETpNv6wnCKtWRNtqME/4a
	 wqhelVPkJOfnuMThueMuf5tvF7fyfPREmJJmgI/4fyQOvTTu7QecowiCYkWBTh8PN7
	 UQhXeJjPjSEnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C61CA0EED;
	Wed, 20 Aug 2025 09:22:44 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Wed, 20 Aug 2025 17:22:42 +0800
Subject: [PATCH] libbpf: add documentation to version and error API
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-libbpf-doc-1-v1-1-13841f25a134@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAOGTpWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyMD3ZzMpKSCNN2U/GRdQ10DkyQDU9M0gzRLc3MloJaCotS0zAqwcdG
 xtbUAPRJMcF4AAAA=
X-Change-ID: 20250820-libbpf-doc-1-04b055f0f977
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 niecheng1@uniontech.com, guanwentao@uniontech.com, zhanjun@uniontech.com, 
 yt.xyxx@gmail.com, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755681763; l=1980;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=HqKLuwaahaE8X4oGAqmIDONf3wOJcCZcDPM6er4Q6CA=;
 b=0bW0OAnjBtipT/YwZfM4duneD+8q120OUp8cSpQzdLcmOJMiwfT5AOVOgCxEigeXOxBG86m7X
 Hyt2KCsq0ULCukJESeDbbYtyGLx7v6rbAgfb40kpGMkJwg4fhDAHLj/
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

This adds documentation for the following API functions:
- libbpf_major_version()
- libbpf_minor_version()
- libbpf_version_string()
- libbpf_strerror()

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 tools/lib/bpf/libbpf.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 455a957cb702cab53266ea948fec061f3b65c9ee..3b809cd08f01ce1576ac822fb89cfd589b9f0d44 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -24,8 +24,25 @@
 extern "C" {
 #endif
 
+/**
+ * @brief **libbpf_major_version()** provides the major version of libbpf.
+ * @return An integer, the major version number
+ */
 LIBBPF_API __u32 libbpf_major_version(void);
+
+/**
+ * @brief **libbpf_minor_version()** provides the minor version of libbpf.
+ * @return An integer, the minor version number
+ */
 LIBBPF_API __u32 libbpf_minor_version(void);
+
+/**
+ * @brief **libbpf_version_string()** provides the version of libbpf in a
+ * human-readable form, e.g., "v1.7".
+ * @return Pointer to a static string containing the version
+ *
+ * The format is *not* a part of a stable API and may change in the future.
+ */
 LIBBPF_API const char *libbpf_version_string(void);
 
 enum libbpf_errno {
@@ -49,6 +66,14 @@ enum libbpf_errno {
 	__LIBBPF_ERRNO__END,
 };
 
+/**
+ * @brief **libbpf_strerror()** converts the provided error code into a
+ * human-readable string.
+ * @param err The error code to convert
+ * @param buf Pointer to a buffer where the error message will be stored
+ * @param size The number of bytes in the buffer
+ * @return 0, on success; negative error code, otherwise
+ */
 LIBBPF_API int libbpf_strerror(int err, char *buf, size_t size);
 
 /**

---
base-commit: b19a97d57c15643494ac8bfaaa35e3ee472d41da
change-id: 20250820-libbpf-doc-1-04b055f0f977

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



