Return-Path: <bpf+bounces-6819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A8176E1FE
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E855D282047
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C903113AD5;
	Thu,  3 Aug 2023 07:38:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD79454
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E44C433C7;
	Thu,  3 Aug 2023 07:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691048308;
	bh=48ZHnhI5JC1xH5WFnKlJ8gMUNHaOdMEEaiqilbmDopw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iBxOSqud3YH4QrpweNZ2KLzI2Cz676PMTQ0DXgJ6oYFjgh0489oI+AFc81waXfCDf
	 yVk/xZcSePbb9mw4qa9i8gEH40k/lH9yfp19W9WgrWNA9SAOwSsFnHA+4BMX++uZvV
	 dRorE4H+k1ybaQLAHTGmliOSzF0eVbs+Cidy38eQXWxy80M0zz9bmhIS58zJ9xiBdH
	 ya/R3Pnii/Jlz5+ptk2ImqGucRJpUKqHTkYE6IJKeV8DZcBMwiAUIPCxsqXtxAJqCV
	 LBOzFczc0FrjrmwzwanG0qVmBy/iAFCW0iX82Me1Fqp3hYptqnBCeIClT6Kfmn6Kmd
	 ubP94blZLUfRQ==
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
Subject: [PATCHv6 bpf-next 24/28] selftests/bpf: Add uprobe_multi usdt test code
Date: Thu,  3 Aug 2023 09:34:16 +0200
Message-ID: <20230803073420.1558613-25-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803073420.1558613-1-jolsa@kernel.org>
References: <20230803073420.1558613-1-jolsa@kernel.org>
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


