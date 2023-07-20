Return-Path: <bpf+bounces-5465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD42F75AD32
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 13:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E1B281DCF
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 11:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEEE17FED;
	Thu, 20 Jul 2023 11:40:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0B174E9
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 11:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D45C433C8;
	Thu, 20 Jul 2023 11:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689853203;
	bh=CUEHN+QEmEay3VqfBoz4mXyiK1GqAL/N/ictXXbupi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CfgmOsoQ6tq8BvxOytVay2L18b1frsd/JgxQC6/YeVf5T5Z1KtheCWjeHuLqmmcKo
	 U7i1YLdTl9Y6iUoZo85uRT7cmpIaQNwGpzRDYHM49yDf86ewfAlTbW5pG7XmoB1jLU
	 uGA9/nbIhL13rwzbYDgJZSokhpWLMvcQkX9fak9GCIqKmru3qntY5hx93DLhMi3bg0
	 VLoKo07wYSlAMpOdkgs8x94i59V5/+AbmxCLO8Tz6LvOLlOfRroq4Y+PEz9+ue6Vxa
	 NJgXy1n5VQ/zkCtKvnBV48A7dgAjuSB2XFSLwSfNQw2zS/baZkUj4hXzRnFDWeIIoP
	 exHxU9irru5nA==
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
	Hao Luo <haoluo@google.com>
Subject: [PATCHv4 bpf-next 24/28] selftests/bpf: Add uprobe_multi usdt test code
Date: Thu, 20 Jul 2023 13:35:46 +0200
Message-ID: <20230720113550.369257-25-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720113550.369257-1-jolsa@kernel.org>
References: <20230720113550.369257-1-jolsa@kernel.org>
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


