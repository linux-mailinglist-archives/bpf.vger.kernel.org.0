Return-Path: <bpf+bounces-31490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBB08FE2E7
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 11:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78EFEB2FF60
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 09:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB04A178CD9;
	Thu,  6 Jun 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ntq0LUnu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F5153824;
	Thu,  6 Jun 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666083; cv=none; b=SC4U1rhbsQ/684Qu71/AX4/UjnG1bRRgQzpalnJTk0ikrE43pJY2mO8HFBmacb+4azI/cPe3CIwfIpA+vjtdD4QWFvN2uQfOVZlKV1th5AdPpzpF3+AHxOeIMFcMGC07HJf4/MH8cj5VThFBGNVs8i3q7NCVo4lVDe9iUyODdh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666083; c=relaxed/simple;
	bh=5cIo0LhZe3qW4KnCWS9hXU2YJ2ZAuBeZ0XTzpw/hIzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQdXVpljxAOCOUHelZHRWfFUyC5a57VsihXiYhY+HNfuhVHFv3zZx3n7RAdIJD+ODH20PXcxyWCBZ/vYoEIHElXakc2dGkBBFuievw4MC31JOiZgGA2aW2ej/umKt5mm1cV2Bc2gSYGI3UgRhYHOEF+lLH0acGhx4FY5+D1iG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ntq0LUnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF05AC4AF67;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717666082;
	bh=5cIo0LhZe3qW4KnCWS9hXU2YJ2ZAuBeZ0XTzpw/hIzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ntq0LUnuaHTzJvKecgC4VIPJtvLL6BnJpOdiJ6C8UvLq6bQL8fwxXw1JU4F64S9iB
	 m5DypaOxEU9eE+vDqXPZv64kYj51G0xyKZrmPVggAnykLm016xbxXw4DN/oPLb1G3B
	 i7PHv8RIC7YRloqNY3S+fagNRHGNnAwHmN9paoGdNIsU1zZIDOL8qL1HrgnSEefLlj
	 ZRTVz8l/20BulhnlMI5hQmNzBbt4aeXy+aYHCRzqA0SyrGe7Sr2Lq5NNkqiTQfk3PM
	 vBWzFR75zT2GS66ha05AzvlCKzo1bR6sDENXk65hLoEpqD+7Piu4/OM3NMHhE9p5JZ
	 OAIY/Je4CYWBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7401C27C5E;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Date: Thu, 06 Jun 2024 11:27:55 +0200
Subject: [PATCH bpf-next 4/5] selftests/bpf: sockmap: Allow SK_PASS in
 verdict
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-sockmap-splice-v1-4-4820a2ab14b5@datadoghq.com>
References: <20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com>
In-Reply-To: <20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717666080; l=2645;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=9C8FQo5IAJEB0CbCQagfo20n2t3AYZrxNI2oWgYOYkQ=;
 b=z7WpbmR3uI95n3ar81qghGJ3w86yNIeiFMShtDHN9d2hqvhnicrauoPo6dzdeWBsFtutMLeZg
 YZJfagOZsNlATWe06ljeA6kJH1MPdNeC+4vs5VTasJHZPPIati9nTvD
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
index ab7e169f5afa..8d72901aa314 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -78,6 +78,7 @@ int txmsg_end_push;
 int txmsg_start_pop;
 int txmsg_pop;
 int txmsg_ingress;
+int txmsg_pass_skb;
 int txmsg_redir_skb;
 int txmsg_ktls_skb;
 int txmsg_ktls_skb_drop;
@@ -108,6 +109,7 @@ static const struct option long_options[] = {
 	{"txmsg_start_pop",  required_argument,	NULL, 'w'},
 	{"txmsg_pop",	     required_argument,	NULL, 'x'},
 	{"txmsg_ingress", no_argument,		&txmsg_ingress, 1 },
+	{"txmsg_pass_skb", no_argument,		&txmsg_pass_skb, 1 },
 	{"txmsg_redir_skb", no_argument,	&txmsg_redir_skb, 1 },
 	{"ktls", no_argument,			&ktls, 1 },
 	{"peek", no_argument,			&peek_flag, 1 },
@@ -177,6 +179,7 @@ static void test_reset(void)
 	txmsg_pass = txmsg_drop = txmsg_redir = 0;
 	txmsg_apply = txmsg_cork = 0;
 	txmsg_ingress = txmsg_redir_skb = 0;
+	txmsg_pass_skb = 0;
 	txmsg_ktls_skb = txmsg_ktls_skb_drop = txmsg_ktls_skb_redir = 0;
 	txmsg_omit_skb_parser = 0;
 	skb_use_parser = 0;
@@ -956,6 +959,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 {
 	int i, key, next_key, err, zero = 0;
 	struct bpf_program *tx_prog;
+	struct bpf_program *skb_verdict_prog;
 
 	/* If base test skip BPF setup */
 	if (test == BASE || test == BASE_SENDPAGE)
@@ -972,7 +976,12 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
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
@@ -1361,6 +1370,8 @@ static void test_options(char *options)
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



