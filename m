Return-Path: <bpf+bounces-5317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E0B7597D1
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 16:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDE5281723
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059A91641F;
	Wed, 19 Jul 2023 14:10:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81161401B;
	Wed, 19 Jul 2023 14:10:19 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C6EF7;
	Wed, 19 Jul 2023 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=z4dwNKJkH2a5CkXpaJ0QuiUi1NgLn8MRUyYIYVLInw4=; b=MCAL+8Ag1Yj0TUIbOhPRegFTWm
	D4CjGIuOhqalJZNcOhXIToYl6jdXYQkhw+jGIzQS3teHX+7IURzJzWTuFKNQ71fGUPM6xyIxHsGMi
	6vYjyiJGtZipvqYJ6V33AmmzaEJytsE7fH8wcKtvbuHXuBa8+Vs2K9D5AzC96u0ixJFnzcBSwhj9S
	5M3iHnAdUi9a7Rych4d557f3xi8X5MM8j5s123tTypyKKCvJV6/L1YtimOWUPQbMP4zBQnNcsxC1j
	y3C3gFscCIbe6iUSXzsJzXYjfrITk3WWweN8TOebHqzEX6GWjSQmHb/GwEhrKJLVHRyeEvQwNLldS
	9HqeePkg==;
Received: from [124.148.184.141] (helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qM7sb-00086K-EI; Wed, 19 Jul 2023 16:10:15 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	martin.lau@linux.dev,
	razor@blackwall.org,
	sdf@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	dxu@dxuuu.xyz,
	joe@cilium.io,
	toke@kernel.org,
	davem@davemloft.net,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v6 5/8] libbpf: Add helper macro to clear opts structs
Date: Wed, 19 Jul 2023 16:08:55 +0200
Message-Id: <20230719140858.13224-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230719140858.13224-1-daniel@iogearbox.net>
References: <20230719140858.13224-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26974/Wed Jul 19 09:28:18 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a small and generic LIBBPF_OPTS_RESET() helper macros which clears an
opts structure and reinitializes its .sz member to place the structure
size. Additionally, the user can pass option-specific data to reinitialize
via varargs.

I found this very useful when developing selftests, but it is also generic
enough as a macro next to the existing LIBBPF_OPTS() which hides the .sz
initialization, too.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/libbpf_common.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index 9a7937f339df..b7060f254486 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -70,4 +70,20 @@
 		};							    \
 	})
 
+/* Helper macro to clear and optionally reinitialize libbpf options struct
+ *
+ * Small helper macro to reset all fields and to reinitialize the common
+ * structure size member. Values provided by users in struct initializer-
+ * syntax as varargs can be provided as well to reinitialize options struct
+ * specific members.
+ */
+#define LIBBPF_OPTS_RESET(NAME, ...)					    \
+	do {								    \
+		memset(&NAME, 0, sizeof(NAME));				    \
+		NAME = (typeof(NAME)) {					    \
+			.sz = sizeof(NAME),				    \
+			__VA_ARGS__					    \
+		};							    \
+	} while (0)
+
 #endif /* __LIBBPF_LIBBPF_COMMON_H */
-- 
2.34.1


