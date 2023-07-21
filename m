Return-Path: <bpf+bounces-5653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6CB75D5B7
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 22:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B6E282460
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 20:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3410724176;
	Fri, 21 Jul 2023 20:24:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A12416A
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 20:24:35 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FE33AAA;
	Fri, 21 Jul 2023 13:24:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 663DC32009DE;
	Fri, 21 Jul 2023 16:23:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 21 Jul 2023 16:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1689970993; x=
	1690057393; bh=C5gTyD3ZK69kBeMGtv3ULDgMyW30wlIrQqdN4DdpOCA=; b=M
	r9lwz78/xU1bSmpNST9J0dqZqO5ngRibRoBWppfwe6I6Fzc9EeX2INch8yl2gzTB
	f/RlTJDyW6K5ykuTGv1lO2YxRoGh+IuvW1OdDCnfGXSzAqKMzFZASfT6ncddniYk
	c46Qf+G7Fngn2Q2hoov+akTMH478atdQKrxYD0B5Oq7oh3Vn7iTiYX5dkQURZ5Lu
	p7sZpM9MZ8RCJX6u4j23DqTQR5E9QUxQu6rWJ/8On9LsXXhmbRLPA/qNdBzOWOED
	cLcmr1QrqsHUV8Otso3sQk3icVchJIhLdMl2N21NYl8bbfZe9u0Sm/sL4z3EqchG
	BjaZNZQjIOMGf6hFiPcDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1689970993; x=
	1690057393; bh=C5gTyD3ZK69kBeMGtv3ULDgMyW30wlIrQqdN4DdpOCA=; b=E
	LwJaZ4dIvF/aTyE+ZtU+1nRXJDExp9MjPNU7m/zy/k39NQ7ulS5Tbgwv6ciH/tJF
	J8YvXcA3UiY5nvHXV6TJPCQIGwmFZ23uQ2HsGqpXqxscXmHMcpJJ16E71Xy77hzp
	vcIWr9lbB/zP8cdrIOTZKK04s+Xz58zUoRhpQ3Shc1d4PUiiXXKzxSlE6qCd9cfY
	8jkMO4mhQ9sSC6KJAqY/IP7dM0cE85MSxKTz9z5BqE6e1xLgX8aTKs6sCw14lMhc
	OjrEWXXQqsKNyJCp/d4wRoPnuHwr0v5/kf3QE7IP79jKdQ4HGSuW6b0uDpJ1feQh
	a02L8Qf8GSkKJT8w45O/g==
X-ME-Sender: <xms:Mem6ZCwEGh1IX3f0nNNMD81JjQzg2P2OuBMaGfAXD8dfiwX6aQ-BdA>
    <xme:Mem6ZORqWQyAdyv42xyNMKYBbzKmxJNkw38yljULXx8C_kKLVUZZtWJBX2luN72kj
    fJXXf6LrWd1Upm26g>
X-ME-Received: <xmr:Mem6ZEWzq9FxeMx_4o42JQuROdfXW_djTiyu1vHPOUB1aJ94uMRUmDRdnrWxHwNQSu3jSbEjU7IK-p8e9ewCSLT5SZw-vbym53TYYMJsySo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:Mem6ZIi-qucJBGR9tdEc9SSH2AssGFS_pUbaIU89rczsIW5Yupgsrg>
    <xmx:Mem6ZEAUhdxDKKP-P2mhrUvYI9Ew36tJ28e6ooqn5_1eiUoS-YXv1Q>
    <xmx:Mem6ZJK7wSBxu9DWqZ2JYfbibdzZ2Iw2fRhTJUIJ-O4WsDG-ZYo3eA>
    <xmx:Mem6ZM4rrU726s9rESJN2UMXHYH8vURw_scoLMgvP4g-widAwEUanQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 16:23:12 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	fw@strlen.de
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	dsahern@kernel.org
Subject: [PATCH bpf-next v6 3/5] bpf: selftests: Support not connecting client socket
Date: Fri, 21 Jul 2023 14:22:47 -0600
Message-ID: <525c13d66dac2d640a1db922546842c051c6f2e6.1689970773.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689970773.git.dxu@dxuuu.xyz>
References: <cover.1689970773.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
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


