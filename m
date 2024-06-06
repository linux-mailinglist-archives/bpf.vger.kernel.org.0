Return-Path: <bpf+bounces-31491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB1D8FE2DA
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 11:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24702283DCF
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 09:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA8179206;
	Thu,  6 Jun 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKDVyk6L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4063C15382A;
	Thu,  6 Jun 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666083; cv=none; b=dn+ca3frdY7Dj/JDS0HQ7o3f8GszVoMppK2HSvfKY6hydBITv5RtBlCA/86EHwqVr9U8L80Ew7h/fgt6b5KxBPXt97pBo9kSWtpYwjo1A8zV4mUzVC/0mdE87RJs2bDKbuBrD6nldj+EzFXSczOS5dxkqi2j5sVT0ePyAiOTwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666083; c=relaxed/simple;
	bh=HaCO5EpmybPmkO6cIEht6Oez3hjJLdOYbQOAb1jCFiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F1abiDCfJ9ZLvxVBoGjkAwoyIKCHMYT8HowWyTQCuD8wNnCNAMVsdSYEhDjD+qAeyCdnxF6dqE79j4urNb3LzQBGyD7ZKsBbsHzhE1fTas8DxrGjc+E/Tqrhf2+Ub7lrzemdPq9gR9GhhEaqMq9qzVQDGJwvdrwVNWIG+If6VBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKDVyk6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2406C4AF64;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717666083;
	bh=HaCO5EpmybPmkO6cIEht6Oez3hjJLdOYbQOAb1jCFiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kKDVyk6LZeYe/pRoV641wsAKXdiw2HfFXxxwUw/nO2HjCMezY14LQZUlC5vx+8NSy
	 /21qHlV4sQhyrLmR0Pc6JWP1Nq8320fCrX77CxuPvghUyEqSqJposM91CgkB16WSq9
	 TQR0P4zoNRgAtTMsPqzuEKpBtc5PNx39qku9N0xFUTO83MEVsn0m3R/M64+shUqWkf
	 9GES/crw7NH4tXPCI101qb5zdXEKiH2aQGSnpN2hx62DO6thIitlZ3Y9BJSdPXMkCC
	 jXblCRzAvgNVRRmlD7Qu+ZZeo4Lfex5ezJBUwKRzXAEXjB60ySEs9J1iLpR5liSlFw
	 V8xayB/LGW7PQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F6AC27C65;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Date: Thu, 06 Jun 2024 11:27:56 +0200
Subject: [PATCH bpf-next 5/5] selftests/bpf: sockmap: Add basic splice(2)
 mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-sockmap-splice-v1-5-4820a2ab14b5@datadoghq.com>
References: <20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com>
In-Reply-To: <20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717666080; l=2849;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=qELVPIBlr9FpIjNgB+sL7xYA/TV1+f+XF9UJjqd3aMg=;
 b=ggN8lIeM5Plq+xrdoFVFgz3/EOKmVgaXdBF6crk8pcfSEFnlpkOVPB4YTad1KnUptDRtnS0wG
 wsG7QYpib2jAZ7sn2EUnsC7Cy8BUfeGv8mnenVH8K9uPCjlPjvhcRBb
X-Developer-Key: i=vincent.whitchurch@datadoghq.com; a=ed25519;
 pk=GwUiPK96WuxbUAD4UjapyK7TOt+aX0EqABOZ/BOj+/M=
X-Endpoint-Received: by B4 Relay for
 vincent.whitchurch@datadoghq.com/20240606 with auth_id=170
X-Original-From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Reply-To: vincent.whitchurch@datadoghq.com

From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>

Add a test mode which uses splice(2) to do a read from the
socket.  Can be run with something like the below:

 ./test_sockmap -t splice --txmsg_omit_skb_parser --txmsg_pass_skb

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 61 ++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 8d72901aa314..5be29ccb3323 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017-2018 Covalent IO, Inc. http://covalent.io
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/socket.h>
@@ -871,6 +872,61 @@ static int sendmsg_test(struct sockmap_options *opt)
 	return err;
 }
 
+static int splice_test(struct sockmap_options *opt)
+{
+	int pipefds[2];
+	char buf[1024] = {0};
+	ssize_t bytes;
+	int ret;
+
+	ret = pipe(pipefds);
+	if (ret < 0) {
+		perror("pipe");
+		return ret;
+	}
+
+	bytes = send(c1, buf, sizeof(buf), 0);
+	if (bytes < 0) {
+		perror("send failed");
+		return bytes;
+	}
+	if (bytes == 0) {
+		fprintf(stderr, "send wrote zero bytes\n");
+		return -1;
+	}
+
+	bytes = write(pipefds[1], buf, sizeof(buf));
+	if (bytes < 0) {
+		perror("pipe write failed");
+		return bytes;
+	}
+
+	bytes = splice(p1, NULL, pipefds[1], NULL, sizeof(buf), 0);
+	if (bytes < 0) {
+		perror("splice failed");
+		return bytes;
+	}
+	if (bytes == 0) {
+		fprintf(stderr, "spliced zero bytes\n");
+		return -1;
+	}
+
+	bytes = read(pipefds[0], buf, sizeof(buf));
+	if (bytes < 0) {
+		perror("pipe read failed");
+		return bytes;
+	}
+	if (bytes == 0) {
+		fprintf(stderr, "EOF from pipe\n");
+		return -1;
+	}
+
+	close(pipefds[1]);
+	close(pipefds[0]);
+
+	return 0;
+}
+
 static int forever_ping_pong(int rate, struct sockmap_options *opt)
 {
 	struct timeval timeout;
@@ -953,6 +1009,7 @@ enum {
 	BASE,
 	BASE_SENDPAGE,
 	SENDPAGE,
+	SPLICE,
 };
 
 static int run_options(struct sockmap_options *options, int cg_fd,  int test)
@@ -1284,6 +1341,8 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 		options->base = true;
 		options->sendpage = true;
 		err = sendmsg_test(options);
+	} else if (test == SPLICE) {
+		err = splice_test(options);
 	} else
 		fprintf(stderr, "unknown test\n");
 out:
@@ -2028,6 +2087,8 @@ int main(int argc, char **argv)
 				test = BASE_SENDPAGE;
 			} else if (strcmp(optarg, "sendpage") == 0) {
 				test = SENDPAGE;
+			} else if (strcmp(optarg, "splice") == 0) {
+				test = SPLICE;
 			} else {
 				usage(argv);
 				return -1;

-- 
2.34.1



