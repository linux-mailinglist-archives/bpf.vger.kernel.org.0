Return-Path: <bpf+bounces-5541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5071D75B91F
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149C3281CEE
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 20:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C61BE8E;
	Thu, 20 Jul 2023 20:58:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191391BE8B
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 20:58:27 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2512D56;
	Thu, 20 Jul 2023 13:58:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id A73E632029D5;
	Thu, 20 Jul 2023 16:58:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 20 Jul 2023 16:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1689886700; x=
	1689973100; bh=C5gTyD3ZK69kBeMGtv3ULDgMyW30wlIrQqdN4DdpOCA=; b=D
	NXQDHLmLlq9V0w5xJg6vy6vC5CnXCwfCwMfj5xCgNKjVkTLraBkubKnhaHDAYnfc
	8g4xyt2wyr+ZMSz4tOijKWmjSJB2x3KvHLcTs6x1MNL55Yp4XLui7+xtTyLnkN52
	rccNMn0AyttAERQKL/zYI5RcUemxWlCSKX0K1eYXoSum85wk60012VnvN9HkYQsI
	vdXUt9LvYWgixS3BREJdnL2DA5FlKT5X5ShBRf8iFOHXmBhcmVC7rULAI/Bi/H+r
	4VsUWYWsgFJ2Yi4dWJz9C2D52hZ5/lCzOiH+I1Yrr1F0B75o3ljb6fEKvKDIOMxH
	mFhwgfmq7JwBhViYPklQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1689886700; x=
	1689973100; bh=C5gTyD3ZK69kBeMGtv3ULDgMyW30wlIrQqdN4DdpOCA=; b=v
	qUOwPN7J73WxH/UC7oywQ7efCGwkoqBIV0K5juSqWrhxE5LnUAlku46R0MyEtevF
	gF9Fxp1+ry+AEITkVGGQRhpaT7kcnWmZoUnkNrYnJyUKzKVmmVEtSrZ/Han/PzSn
	cpzBITqlc0G2Ub9xstckBYJ1jMTG3spWtU5vvfxLxInCozx+ELtGcBfNs/hMMiBT
	CYMCZyg6S4w2KwCf4T+PQOQLt4JqE0Le1pJ/KazZnxcQMJ7Yu3UJRRvy7hDnqy5c
	Qr3BhMWMxcPeXghmTn+zxO6CyOnDvM16HDXkaWZA/xBpe8uLRPNe2uvUB31b4coG
	X7mngZofRvK7bgCnwy8FQ==
X-ME-Sender: <xms:7J-5ZOjndd2GzW4KJC85iE-P7gHKV3mJO7kDz6HSb7slKReDePwoQw>
    <xme:7J-5ZPBJZHtPdyb_2wRvhRIHvf9JvkahCFfaU9cOXq-xulJDrszsuh-NjRkzELeLI
    _FlI5fBxjmXVfaM2g>
X-ME-Received: <xmr:7J-5ZGFzweSthJriwYmJNUiBXoMSJ9TDJeL8QfXA_sUIIq-RX3E0RoQAtLB0EsO6KgUIexGqLl3Ag25IzgrOonF5LvxIQ8v8zEwPdULQ6rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:7J-5ZHSyVvT-87l_gdUKsojJj07MZnsP_JY-4Bin0hvSeQRt2_znhQ>
    <xmx:7J-5ZLz3cURdD9yec2forpZk4glEszFbsVGG9erNV68Rq4EzMOl6cA>
    <xmx:7J-5ZF7_T3Na5Ps0E88_D3C0fNzls3w_Ib9ZFOZGq4huZNgCp7hT_Q>
    <xmx:7J-5ZMo5IBObMj0qvJdtM939sGw4lfI_B92GI_gf1A5Fff4RO-lwGA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 16:58:18 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	andrii@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	alexei.starovoitov@gmail.com,
	fw@strlen.de
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	dsahern@kernel.org
Subject: [PATCH bpf-next v5 3/5] bpf: selftests: Support not connecting client socket
Date: Thu, 20 Jul 2023 14:57:37 -0600
Message-ID: <aaab1f2500976d0dd672628a94879ed33d08bcea.1689884827.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689884827.git.dxu@dxuuu.xyz>
References: <cover.1689884827.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For connectionless protocols or raw sockets we do not want to actually
connect() to the server.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/network_helpers.c | 5 +++--
 tools/testing/selftests/bpf/network_helpers.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index a105c0cd008a..d5c78c08903b 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -301,8 +301,9 @@ int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
 		       strlen(opts->cc) + 1))
 		goto error_close;
 
-	if (connect_fd_to_addr(fd, &addr, addrlen, opts->must_fail))
-		goto error_close;
+	if (!opts->noconnect)
+		if (connect_fd_to_addr(fd, &addr, addrlen, opts->must_fail))
+			goto error_close;
 
 	return fd;
 
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 694185644da6..87894dc984dd 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -21,6 +21,7 @@ struct network_helper_opts {
 	const char *cc;
 	int timeout_ms;
 	bool must_fail;
+	bool noconnect;
 };
 
 /* ipv4 test vector */
-- 
2.41.0


