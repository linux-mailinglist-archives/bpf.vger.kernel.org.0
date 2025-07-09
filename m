Return-Path: <bpf+bounces-62790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5D7AFE95D
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 14:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921E01C81C95
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 12:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2062DCC08;
	Wed,  9 Jul 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEeNRFF4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E828DF42;
	Wed,  9 Jul 2025 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065286; cv=none; b=qo7feXsSVzb6hDCLEaAe9TtAMkPUDsMB2nUFuXj+ORw8USKZSJimxxWPsWjLL0K/tbFiB1kRT1+9MO6SkSKdVrkB1fhAYb4iXXVmRkd6/ZhXZoOzArhgWWOaIkId1plpnu8/kkxP1KRbSrn8zl698nlkAimDUAQp1tex1ma9Cmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065286; c=relaxed/simple;
	bh=KAxosOVOQ6l+B1NRsPIMYW/2Pb2Tn47aUOZur2xYXu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qfs7xbN3zQBl5eWklQ6Z1S4wwV00hkz4WYfQDFsXTvx/OPOH3UfKWkA/efhDtGUtjhUCiK7jf5vxPrY9EtSxeYktwSg8NMlzA9ORwEDw/Jyk4d4QdzE9P6R06C/JcEHHiiaFHcgFGnC4pIWCTAqViGlRzoP4dfkRtuMBRJWipaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEeNRFF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5298C4CEF8;
	Wed,  9 Jul 2025 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752065285;
	bh=KAxosOVOQ6l+B1NRsPIMYW/2Pb2Tn47aUOZur2xYXu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BEeNRFF41TLrKdDremt/jb8A4DgetZ5xFgGcm6vSsdF5LXAvEaOjTRmXTzJsUdLh3
	 MlZ8nWZl3HKcDNDczXzxsGg1JMd8n1rH974QW8fNKXtnY0tEiPr5nrBAahSEcMWFHv
	 TnflxIGJY5Knix1BAdt5sKPgjg9vE6N7y4vPbBHeWz4Im/78JRHUKelPKWtbsxR7Cq
	 l23sHOwVIoIKxCc8dN4RmabTjAFvV3bK7dVKzJ/NsEqIclc14nlo1anLffOFO9OEAk
	 YOZHQ2HxfWvXwC7g5m6Lt/pStMBSLBc28KCO2zhgabRgTY5GcBznAa/6MmnidAf/ro
	 iOZP7XDiKI4Qg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD143C83F15;
	Wed,  9 Jul 2025 12:48:05 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Date: Wed, 09 Jul 2025 14:48:00 +0200
Subject: [PATCH bpf-next v3 4/5] selftests/bpf: sockmap: Allow SK_PASS in
 verdict
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sockmap-splice-v3-4-b23f345a67fc@datadoghq.com>
References: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>
In-Reply-To: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752065284; l=2649;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=ttXkzBtePefhL92l8qDuBVl8NcBEWEyezoI06KE7GQg=;
 b=FRrlWWYinWhzF+G4Xad5WfD4U6xjBbvQHLf7gMQ13mmPt0TwvKc2hW+HiLOhH/DtIQMtd5v3V
 UJ9w1nqEU/FAQo8Yl7nL8OgYa4rbedwK/a60fwOu2Nk9Fa5eytITBBE
X-Developer-Key: i=vincent.whitchurch@datadoghq.com; a=ed25519;
 pk=GwUiPK96WuxbUAD4UjapyK7TOt+aX0EqABOZ/BOj+/M=
X-Endpoint-Received: by B4 Relay for
 vincent.whitchurch@datadoghq.com/20240606 with auth_id=170
X-Original-From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Reply-To: vincent.whitchurch@datadoghq.com

From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>

Add an option to always return SK_PASS in the verdict callback
instead of redirecting the skb.  This allows testing cases
which are not covered by the test program as of now.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index cf1c36ed32c1..8be2714dd573 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -80,6 +80,7 @@ int txmsg_end_push;
 int txmsg_start_pop;
 int txmsg_pop;
 int txmsg_ingress;
+int txmsg_pass_skb;
 int txmsg_redir_skb;
 int txmsg_ktls_skb;
 int txmsg_ktls_skb_drop;
@@ -114,6 +115,7 @@ static const struct option long_options[] = {
 	{"txmsg_start_pop",  required_argument,	NULL, 'w'},
 	{"txmsg_pop",	     required_argument,	NULL, 'x'},
 	{"txmsg_ingress", no_argument,		&txmsg_ingress, 1 },
+	{"txmsg_pass_skb", no_argument,		&txmsg_pass_skb, 1 },
 	{"txmsg_redir_skb", no_argument,	&txmsg_redir_skb, 1 },
 	{"ktls", no_argument,			&ktls, 1 },
 	{"peek", no_argument,			&peek_flag, 1 },
@@ -183,6 +185,7 @@ static void test_reset(void)
 	txmsg_pass = txmsg_drop = txmsg_redir = 0;
 	txmsg_apply = txmsg_cork = 0;
 	txmsg_ingress = txmsg_redir_skb = 0;
+	txmsg_pass_skb = 0;
 	txmsg_ktls_skb = txmsg_ktls_skb_drop = txmsg_ktls_skb_redir = 0;
 	txmsg_omit_skb_parser = 0;
 	skb_use_parser = 0;
@@ -1050,6 +1053,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 {
 	int i, key, next_key, err, zero = 0;
 	struct bpf_program *tx_prog;
+	struct bpf_program *skb_verdict_prog;
 
 	/* If base test skip BPF setup */
 	if (test == BASE || test == BASE_SENDPAGE)
@@ -1066,7 +1070,12 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 		}
 	}
 
-	links[1] = bpf_program__attach_sockmap(progs[1], map_fd[0]);
+	if (txmsg_pass_skb)
+		skb_verdict_prog = progs[2];
+	else
+		skb_verdict_prog = progs[1];
+
+	links[1] = bpf_program__attach_sockmap(skb_verdict_prog, map_fd[0]);
 	if (!links[1]) {
 		fprintf(stderr, "ERROR: bpf_program__attach_sockmap (sockmap): (%s)\n",
 			strerror(errno));
@@ -1455,6 +1464,8 @@ static void test_options(char *options)
 	}
 	if (txmsg_ingress)
 		append_str(options, "ingress,", OPTSTRING);
+	if (txmsg_pass_skb)
+		append_str(options, "pass_skb,", OPTSTRING);
 	if (txmsg_redir_skb)
 		append_str(options, "redir_skb,", OPTSTRING);
 	if (txmsg_ktls_skb)

-- 
2.34.1



