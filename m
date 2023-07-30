Return-Path: <bpf+bounces-6376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAE17685CC
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 15:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12281C2032B
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB132119;
	Sun, 30 Jul 2023 13:46:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3B363
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 13:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65819C433C7;
	Sun, 30 Jul 2023 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690724789;
	bh=CUEHN+QEmEay3VqfBoz4mXyiK1GqAL/N/ictXXbupi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VvwZjI32g1B2AjLbuXTrvx6kA0inRbZzBD+kBVuKcP/QtPE58xlaoh1CSD0bYpjqD
	 68oLbH7syjhLo04vvzLrcoeUhBzaLnvuUGsRy9dTKlFD2U+0qgWeoVZFOSQZ6qcsh6
	 Z0RqmeDUI8q0cXX5lYT45iB93YwAK+dhsd2cjL/l3gcNZGQNk+y0bIuSK8JN2YPVX+
	 e2G5vdKNjzkuI0KMmcuFMvreskJYHjZ+iKW7phHr3UzPETzEMlr+qdzllXylRMwQYT
	 H1btxYisZKmAzX5kNeyB3o3zMf2HQSTgjEespBMXX8B3t4mDhZbOqS4VcobP7CaqTY
	 2lCq9xrdACJ1w==
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
Subject: [PATCHv5 bpf-next 24/28] selftests/bpf: Add uprobe_multi usdt test code
Date: Sun, 30 Jul 2023 15:42:19 +0200
Message-ID: <20230730134223.94496-25-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730134223.94496-1-jolsa@kernel.org>
References: <20230730134223.94496-1-jolsa@kernel.org>
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
 tools/testing/selftests/bpf/uprobe_multi.c | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
index d19184103fa3..850bf2d5a8bc 100644
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
@@ -60,6 +82,8 @@ int main(int argc, char **argv)
 
 	if (!strcmp("bench", argv[1]))
 		return bench();
+	if (!strcmp("usdt", argv[1]))
+		return usdt();
 
 error:
 	fprintf(stderr, "usage: %s <bench>\n", argv[0]);
-- 
2.41.0


