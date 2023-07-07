Return-Path: <bpf+bounces-4460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484B374B5CE
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299FF1C20F62
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 17:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43366174D7;
	Fri,  7 Jul 2023 17:26:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCB1171D0;
	Fri,  7 Jul 2023 17:26:03 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1714126A4;
	Fri,  7 Jul 2023 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=h7U7dig1T0neKDxwyLo1oyopN7YqmyEEZZoBQ26zUKA=; b=JowWxjUMP/OLgAN5Y6Ir8T1WSx
	hZBF/h8D8d87zmww+i0iQXO6MlVC006/vFXVjKGjrd66LwFpAebiWmRKgRuxsvvexojTz41VpGD1/
	sfsvEIBiZTQUgQvtpRJjd9e0Z4cUn82IdtkzMeDvfSyWEyFqzBMEs12fUWKjlQ6K9uGZzALc8MDKX
	Sr7y55gf5ieVuWs2eXW0p/Wb6fTzuaobYWIydJyhMCGuyWKKfXtC2q1dcWtoDkl+RKlFg9+2wq7Ud
	72hZUqmjUjrF5O3X8+VlnIgsBi5CLOERCkd1do8kwtvO55qNonDVGpwCagfRt9azlIgSAC/0RRn8J
	+hXyB6YQ==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qHpCg-000Ay0-5z; Fri, 07 Jul 2023 19:25:10 +0200
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
Subject: [PATCH bpf-next v3 5/8] libbpf: Add helper macro to clear opts structs
Date: Fri,  7 Jul 2023 19:24:52 +0200
Message-Id: <20230707172455.7634-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230707172455.7634-1-daniel@iogearbox.net>
References: <20230707172455.7634-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26962/Fri Jul  7 09:29:02 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a small and generic LIBBPF_OPTS_CLEAR() helper macros which clears
an opts structure and reinitializes its .sz member to place the structure
size. I found this very useful when developing selftests, but it is also
generic enough as a macro next to the existing LIBBPF_OPTS() which hides
the .sz initialization, too.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/libbpf_common.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index 9a7937f339df..eb180023aa97 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -70,4 +70,15 @@
 		};							    \
 	})
 
+/* Helper macro to clear a libbpf options struct
+ *
+ * Small helper macro to reset all fields and to reinitialize the common
+ * structure size member.
+ */
+#define LIBBPF_OPTS_CLEAR(NAME)						    \
+	do {								    \
+		memset(&NAME, 0, sizeof(NAME));				    \
+		NAME.sz = sizeof(NAME);					    \
+	} while (0)
+
 #endif /* __LIBBPF_LIBBPF_COMMON_H */
-- 
2.34.1


