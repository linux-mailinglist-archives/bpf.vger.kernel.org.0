Return-Path: <bpf+bounces-3512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DBD73EF09
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 01:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247611C209D0
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 23:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA809168B9;
	Mon, 26 Jun 2023 23:02:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71700168A7
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 23:02:32 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B1C10E4;
	Mon, 26 Jun 2023 16:02:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 8706E5C015B;
	Mon, 26 Jun 2023 19:02:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 26 Jun 2023 19:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1687820550; x=
	1687906950; bh=7tQw2BRMSXqer2U0h2RL5L+2q6EBjYovWny1JwaX3dM=; b=i
	O5gWfm2dzI7yqK96A4KCyQtw2/F3ABwN1y3NYiR0ZPk1vePPbF52RPyKUSKLKuNQ
	1c8oX8EzX0GI6QJEHy5nzcXAlJsFF9/cIDHqsZ8PfSeaHWXqfqMdz4ncbkVIVkWp
	hv2s4aO0sIYT1FIX0Wve8lBiVpOmP7RBCg38SBRrjj8eoYDWVKjhXh418lMFmydo
	LbBelMEq3lHh50jQj1Ujy9C9MgLa44qlaHoWLcrt1Q+XkN6gvMe+nB9Qzn4id6mI
	UPb86Uc3Z2jq1E3K9WyRzepBEZMw711pdz3XAzQ13hbVEJ/ufa7AkdC2twAWue8V
	q74ZznTP0U7RvRhGaG4jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1687820550; x=
	1687906950; bh=7tQw2BRMSXqer2U0h2RL5L+2q6EBjYovWny1JwaX3dM=; b=S
	gntrF0HK33owWr4re6Z4QYIJ6qmSUAeI5BjtaoDkCEM8521klbFGvNzlVrjTZKHn
	rZMEiixKhvi6nOh1OP9I8CyRdjtgmC+xBxmVpgF6Rn0SMD/L8IZ75M9RVFjtV+cj
	U0B28l3udu6s+jnlvWNJ3BHXbNEchpL96S7ZPPI+g7OlhrMEto7rUJDTMLOnP60/
	+NhovERQKLMsxnNxOwtxKNSwKeKB8IX2aGL3+CwmVndKfa9WDAWFkSu9Jk5YaAht
	3y74H2xRKtaHjYnGAj2SFA48jESAVxkCapS53DQJsHZxSJG46xU3wXafW4MW02Dn
	QjwEOsNB/HvaU1QS2MDMA==
X-ME-Sender: <xms:BhmaZF1YQigPeZLXZMVPnsD1up7M_64qyuifVXwEIZXajpWxPWkm9w>
    <xme:BhmaZMFJVSNlahQ25g9M_g8o_uNDXcri5XwrsaWd5tNc_CUCIi_wB_GidzK5H3GlW
    WMFC1UwSc1e0n53Jg>
X-ME-Received: <xmr:BhmaZF4l4P621sqHOlrKRRVtW6nHRPIbcWvKCJegZq2KV3wf2DA9dHLnmetssdyhC2_YCobBVsB2mvtPV8eioB79T9ykBdPToAAZ4FmTQVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehgedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:BhmaZC3JjSJgFksTWUN6xOXh56pTIxjn_U_xrJ5w5e7exReYUZK5JQ>
    <xmx:BhmaZIHa3NDVnuoAVeYfxQTHPG3GVYfR929gF6byb8sRk4qbcb_YPA>
    <xmx:BhmaZD-LKygBq1eM1AKuFymftfAywJxjzy0H_PF_Ju_CPSMisTo5xA>
    <xmx:BhmaZNKgbrSvvjuv-ooUzPUzxJGpc-UYiYFS7_C18SJ_V_QcJwtt0w>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 19:02:28 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org,
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
Subject: [PATCH bpf-next 5/7] bpf: selftests: Support not connecting client socket
Date: Mon, 26 Jun 2023 17:02:12 -0600
Message-Id: <53ff90b203c955fd46a3cc7c0c5fdab7b1584595.1687819413.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687819413.git.dxu@dxuuu.xyz>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.40.1


