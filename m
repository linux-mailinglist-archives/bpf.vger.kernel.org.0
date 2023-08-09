Return-Path: <bpf+bounces-7316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4640B7755C4
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007ED28136C
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD6818C16;
	Wed,  9 Aug 2023 08:38:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C472D6AAB
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7962C433C7;
	Wed,  9 Aug 2023 08:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691570330;
	bh=48ZHnhI5JC1xH5WFnKlJ8gMUNHaOdMEEaiqilbmDopw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntAm8yEyG/U2nzKsgRgIJfTLp+3ClJXsFE5gisGaJXGjCNPcPLQXCJcseHXfyOvFm
	 lfcpo6Qj8rK/xDRMaqCTpVqYLcz5x+DXhmuR/6jbyyVjHDqdgCnMmraZGZirCyJmxk
	 BhvAoX4Qy8dTACQl475aHzJIbRZaKmumfgCeKht4tYNNi92WV9RO9q+KaA2sQIpboR
	 yd8Y4rIthQS4h3Ei+Z6wMv6F1DajobmadoeTpTpCR8CbiuHxQaHGoj/jCH9hXCRgG/
	 7wC8C/6CEWliwfmnRuSUHEHhkKoKl4smwmhfmOaw56tjg3KBqZQ4DFW1Fj34Ph+d53
	 wmTPW4UXq4XsA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv7 bpf-next 24/28] selftests/bpf: Add uprobe_multi usdt test code
Date: Wed,  9 Aug 2023 10:34:36 +0200
Message-ID: <20230809083440.3209381-25-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083440.3209381-1-jolsa@kernel.org>
References: <20230809083440.3209381-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding code in uprobe_multi test binary that defines 50k usdts
and will serve as attach point for uprobe_multi usdt bench test
in following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/uprobe_multi.c | 26 +++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
index d19184103fa3..a61ceab60b68 100644
--- a/tools/testing/selftests/bpf/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -2,6 +2,7 @@
 
 #include <stdio.h>
 #include <string.h>
+#include <sdt.h>
 
 #define __PASTE(a, b) a##b
 #define PASTE(a, b) __PASTE(a, b)
@@ -53,6 +54,27 @@ static int bench(void)
 	return 0;
 }
 
+#define PROBE STAP_PROBE(test, usdt);
+
+#define PROBE10    PROBE PROBE PROBE PROBE PROBE \
+		   PROBE PROBE PROBE PROBE PROBE
+#define PROBE100   PROBE10 PROBE10 PROBE10 PROBE10 PROBE10 \
+		   PROBE10 PROBE10 PROBE10 PROBE10 PROBE10
+#define PROBE1000  PROBE100 PROBE100 PROBE100 PROBE100 PROBE100 \
+		   PROBE100 PROBE100 PROBE100 PROBE100 PROBE100
+#define PROBE10000 PROBE1000 PROBE1000 PROBE1000 PROBE1000 PROBE1000 \
+		   PROBE1000 PROBE1000 PROBE1000 PROBE1000 PROBE1000
+
+static int usdt(void)
+{
+	PROBE10000
+	PROBE10000
+	PROBE10000
+	PROBE10000
+	PROBE10000
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	if (argc != 2)
@@ -60,8 +82,10 @@ int main(int argc, char **argv)
 
 	if (!strcmp("bench", argv[1]))
 		return bench();
+	if (!strcmp("usdt", argv[1]))
+		return usdt();
 
 error:
-	fprintf(stderr, "usage: %s <bench>\n", argv[0]);
+	fprintf(stderr, "usage: %s <bench|usdt>\n", argv[0]);
 	return -1;
 }
-- 
2.41.0


