Return-Path: <bpf+bounces-5023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE768753CFD
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 16:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA479282205
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D1513AF2;
	Fri, 14 Jul 2023 14:16:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1297134D9;
	Fri, 14 Jul 2023 14:16:05 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9F730EF;
	Fri, 14 Jul 2023 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=z4dwNKJkH2a5CkXpaJ0QuiUi1NgLn8MRUyYIYVLInw4=; b=IVXgt0geQEaTJVZwk5P5tp4m3V
	ISq49Im6WlMVOJLBkEr8kSVlXOX9v4VQAjXPXfuSnDG+AVkGQ37dcYC5iGZop0HPGcxB5CVGP6vHI
	g3otiJvAqgxSTVHEIbg29q+AhSLoOe12uzu9WiCEm0I6n8G/PejjPpfZLEssmVCB27o8b1d3VgRvP
	fGAYIQpZzsMbAMlkS4GBMnZukjA5Hu53yTxm2IvSG9LAk5vkF3B7ooG9wXuwfea2lrhu+MkwP8X0o
	mf56DMdR39prF0YTVhYU5tMqumLf1vewxW8b7gUPl+ZBhlpNNDx+OU8Wx+EGnlPbR+fR3VpwhVVY0
	meffJK7w==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qKJaU-000B2u-TF; Fri, 14 Jul 2023 16:16:02 +0200
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
Subject: [PATCH bpf-next v5 5/8] libbpf: Add helper macro to clear opts structs
Date: Fri, 14 Jul 2023 16:15:42 +0200
Message-Id: <20230714141545.26904-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230714141545.26904-1-daniel@iogearbox.net>
References: <20230714141545.26904-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26969/Fri Jul 14 09:28:15 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
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


