Return-Path: <bpf+bounces-4634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D3074DEED
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 22:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228CB2813F8
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6121640C;
	Mon, 10 Jul 2023 20:12:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68886156DB;
	Mon, 10 Jul 2023 20:12:31 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ECDBB;
	Mon, 10 Jul 2023 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=h7U7dig1T0neKDxwyLo1oyopN7YqmyEEZZoBQ26zUKA=; b=LvvG31PRj7DeXO8hRPKNEh/Jw6
	FxKRuaNN0uyavqiK9T6eAAWrXc3w4TLtQ32tGrk0ZHiL61RfiyQpx+9YiNxHi2T+2FWBk1Z7W7c7p
	DRDmikohJ6lm/1HUu7rjcT+fJbIijdp9f7dqVqZo4hqrbwxM90Qw5kkg2S3/+NgJDNCQCP0nM1IPQ
	WtjBW92Fekfqt0QNAY5ESzO+nlQMOysoF+Mu6HcpNW6Oa33I6tboSd7D9qI38POP4OamzmW0Ugdho
	l2fnNO/bHUCEiWuK50jB13zhqnXWgcbvNDatMYKjM9OMuU3Un6GFdIzZ5Br/asE/U/D32gRoH2nyP
	dr6sNcBQ==;
Received: from 12.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.12] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIxFE-000E5F-B7; Mon, 10 Jul 2023 22:12:28 +0200
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
Subject: [PATCH bpf-next v4 5/8] libbpf: Add helper macro to clear opts structs
Date: Mon, 10 Jul 2023 22:12:15 +0200
Message-Id: <20230710201218.19460-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230710201218.19460-1-daniel@iogearbox.net>
References: <20230710201218.19460-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26965/Mon Jul 10 09:29:40 2023)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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


