Return-Path: <bpf+bounces-60049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07176AD1ED2
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BB73AAAF8
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 13:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9B525A327;
	Mon,  9 Jun 2025 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQhfZ2gY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332A259C83;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749475634; cv=none; b=Z2PH479KP/sAxEiJpLe/jiREKDCRhduTZ7Hw+MABGp+J5P+gTFmnhHkgRbc7Q4FyW0S7IGGCohi4NLgPP7SYvKeGd/QTwjRrCPYvqZt/yvNElO+2Au1Fo1j9NgBZ3hsD/pFc2dvKhMZmA5H0F0+/IH1o9RGxwDRijG272tJP6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749475634; c=relaxed/simple;
	bh=xZml02WCQ994/V4RlPqFg4+yIuwCYDka9Oaz38kEodM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XT1cl/B0g4WWinuMK4GrlQs9Qkpvo/I351SvMQ0+VodteKpDM71GURgtRbuVRwMR/p72tPDhANEgAMxDbos6uxr2bh9uT3Amcy0Utgpsr/RNFaUZUqZTqbRmim1xDLH2oLXRJVw9Ay7CgEIZ4uVPXIUwce4aQe0iSBfb8uF0fG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQhfZ2gY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0503C4CEF8;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749475633;
	bh=xZml02WCQ994/V4RlPqFg4+yIuwCYDka9Oaz38kEodM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YQhfZ2gYtAWzxK4b56JNo6WQJYEUNphOCsw5UW6p4jiMJeZ+HLNqmrKFYEufCUy+e
	 PJJtqz8FR1GUAbqeAl/ta7Vma/BuLuzvrd0UD2KXg+d4BpDQxLMSxmb0jtWlen5khh
	 uSTMBEHqhahuhEbEpZeTaggMyc+a1QA1aa/GTgM6hhDnqVXdgtYWV5TvSqOtiFFbwX
	 0Eyz0PcyI1oAHataRVttc+Yk7WQZb+QC3nZYQA0zqkERXUMTwUKitjJikMA2zyXSva
	 Ke6vM2DvHRNZcerT6jzMwfvaKcTXn2vObqZBPHSKBPpaC2IG0v5ixCRgMoHXImof4a
	 KSmoLjU4Yk2Wg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4169C5B552;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Date: Mon, 09 Jun 2025 15:27:02 +0200
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: sockmap: Add splice +
 SK_PASS regression test
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-sockmap-splice-v2-5-9c50645cfa32@datadoghq.com>
References: <20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com>
In-Reply-To: <20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749475632; l=3614;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=2akB6neBnN7soD9RxBYPWNSQma3x6Mu7ppi7sqIUp90=;
 b=qe0AI+VKgweti4Dya20MEVWQ+GSspGh4qO+E1PVz1e9jjczLEZE7pwbXheBaqDMmTt0u7k9I3
 MzWE4i7etzXCJASEpOc88fK95qvlQRlm1cJMrmG0twtf+cl6hDAEBu1
X-Developer-Key: i=vincent.whitchurch@datadoghq.com; a=ed25519;
 pk=GwUiPK96WuxbUAD4UjapyK7TOt+aX0EqABOZ/BOj+/M=
X-Endpoint-Received: by B4 Relay for
 vincent.whitchurch@datadoghq.com/20240606 with auth_id=170
X-Original-From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Reply-To: vincent.whitchurch@datadoghq.com

From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>

Add a test which checks that splice(2) is still able to read data from
the socket if it is added to a verdict program which returns SK_PASS.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 73 ++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 8be2714dd573..b4102161db62 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017-2018 Covalent IO, Inc. http://covalent.io
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/socket.h>
@@ -965,6 +966,61 @@ static int sendmsg_test(struct sockmap_options *opt)
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
@@ -1047,6 +1103,7 @@ enum {
 	BASE,
 	BASE_SENDPAGE,
 	SENDPAGE,
+	SPLICE,
 };
 
 static int run_options(struct sockmap_options *options, int cg_fd,  int test)
@@ -1378,6 +1435,8 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 		options->base = true;
 		options->sendpage = true;
 		err = sendmsg_test(options);
+	} else if (test == SPLICE) {
+		err = splice_test(options);
 	} else
 		fprintf(stderr, "unknown test\n");
 out:
@@ -1993,6 +2052,17 @@ static int populate_progs(char *bpf_file)
 	return 0;
 }
 
+static void test_txmsg_splice_pass(int cgrp, struct sockmap_options *opt)
+{
+	txmsg_omit_skb_parser = 1;
+	txmsg_pass_skb = 1;
+
+	__test_exec(cgrp, SPLICE, opt);
+
+	txmsg_omit_skb_parser = 0;
+	txmsg_pass_skb = 0;
+}
+
 struct _test test[] = {
 	{"txmsg test passthrough", test_txmsg_pass},
 	{"txmsg test redirect", test_txmsg_redir},
@@ -2009,6 +2079,7 @@ struct _test test[] = {
 	{"txmsg test push/pop data", test_txmsg_push_pop},
 	{"txmsg test ingress parser", test_txmsg_ingress_parser},
 	{"txmsg test ingress parser2", test_txmsg_ingress_parser2},
+	{"txmsg test splice pass", test_txmsg_splice_pass},
 };
 
 static int check_whitelist(struct _test *t, struct sockmap_options *opt)
@@ -2187,6 +2258,8 @@ int main(int argc, char **argv)
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



