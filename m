Return-Path: <bpf+bounces-13844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE807DE7D2
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F24C1C20E27
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FC61BDDE;
	Wed,  1 Nov 2023 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="iTweySaL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XTVXXA6w"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB011C29B
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 21:58:51 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE78B110;
	Wed,  1 Nov 2023 14:58:45 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id C47643200A00;
	Wed,  1 Nov 2023 17:58:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 01 Nov 2023 17:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1698875923; x=
	1698962323; bh=gWSN/HD6jkDzCgr6AOl1OtKUYd5UCibpC8lpxwnriyM=; b=i
	TweySaLixGEkTOpoi6207D1OlbfZhRLRNcttugAZEq7yDPWrVlGN2GLChPRkeaPO
	eq5Xz8F861iun5+bY6blXPu+7vUTuQlVeKQs6cgyMZyzqsiXbc6kE88TcKPjqwma
	aXFAZCuc3h+HsxzGcjfcqqC7UlcKtdDMNlLnRXSV5rKRXNaKtAX89eL0/mdzL8z4
	3JpxU85+T0jsfdUnS7Ihlcdpc0/e9/5VCS1tdfG/LPnwmzyJol3riygHbKty/Wjw
	MT/isjY1Qn7ikBG9mhYaXMxSc/DFwYI7tZ6/lhgb8TE5p1W+S6dUchy22aFWVp+G
	1c4yjVgqzRmTrFAVbFUfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698875923; x=
	1698962323; bh=gWSN/HD6jkDzCgr6AOl1OtKUYd5UCibpC8lpxwnriyM=; b=X
	TVXXA6wV3K0lVqQys+T2pC7AtVSNXXW4Q6EYZrDNlj48r0BzXcEwDjRvjwHwmMnB
	v3PEO5Yqe2I+2Om8M5rcMP5lMyysgYbahDPS7peR5a5lhm7Vp5dhJBwlaRPNaV69
	7+a3s7DxtTuHB+IEw2daNQSLxSFB0Z/k0fhpZu7jHEWOyO+eYoWFfwTVF6XX9aux
	E8nKmvZOHjuyj/pc7eox9Y7IVpilFO2oXiAFVO2ReU1INIFtnb7k3UMUc2LXD9Vn
	8NgPTg/qp2sNQSe0ejiDQhpMlEKvGRdvmoe8r4CEc881L62pk4sIV7UH1tFSoCIi
	9iep0L7nJjtGQ5Cz0DjLw==
X-ME-Sender: <xms:EspCZYMF7rUfggTUeD1Co_x8nbD2z2xZDzlv1S6naJhCr4welCb2Lw>
    <xme:EspCZe8mBkbDBQaIX4dBUKUh69B6vGKIzBPrVE32IKQSqPL17-qNrTdTuUMFiW862
    4jEY4LY9E05suG2OA>
X-ME-Received: <xmr:EspCZfSlTXUHII1ZrOvbrMFh_ro_tigKCAatPDyXf5IzOCbCvYsG-P9A0lc2WWvVZUZ6yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeevtdekjeffkefgfe
    fhvefffeetgfeuueeutdetjeduudehheeiffdvgefhhfevhfenucffohhmrghinhepghhi
    thhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:EspCZQtN_I6SRU0t1wSMuzsTgMKXipmLBKbf5PISYb60Gl0cqtNSLw>
    <xmx:EspCZQd0DFvyp7y9DUe1dBztJJExnVgeCt6QjbOpYu6cu8s8vL9T0w>
    <xmx:EspCZU1N5n2hpPRiYtRoUnUnJDftjdG8AXeDOcpQnuFw7HcahutmEQ>
    <xmx:E8pCZfAl_gX0Xi2t4HYaOQv3sWMhIj2tWURN2eJwhWPXDyZBT4-YZQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 17:58:40 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	shuah@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [RFCv2 bpf-next 3/7] bpf: selftests: test_tunnel: Use ping -6 over ping6
Date: Wed,  1 Nov 2023 14:57:47 -0700
Message-ID: <50d62fb4fd7838d158ccd59460f0b021b34cecd0.1698875025.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698875025.git.dxu@dxuuu.xyz>
References: <cover.1698875025.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ping6 binary went away over 7 years ago [0].

[0]: https://github.com/iputils/iputils/commit/ebad35fee3de851b809c7b72ccc654a72b6af61d

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/test_tunnel.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 2dec7dbf29a2..85ba39992461 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -295,13 +295,13 @@ test_ip6gre()
 	add_ip6gretap_tunnel
 	attach_bpf $DEV ip6gretap_set_tunnel ip6gretap_get_tunnel
 	# underlay
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	# overlay: ipv4 over ipv6
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
 	ping $PING_ARG 10.1.1.100
 	check_err $?
 	# overlay: ipv6 over ipv6
-	ip netns exec at_ns0 ping6 $PING_ARG fc80::200
+	ip netns exec at_ns0 ping -6 $PING_ARG fc80::200
 	check_err $?
 	cleanup
 
@@ -324,13 +324,13 @@ test_ip6gretap()
 	add_ip6gretap_tunnel
 	attach_bpf $DEV ip6gretap_set_tunnel ip6gretap_get_tunnel
 	# underlay
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	# overlay: ipv4 over ipv6
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
 	ping $PING_ARG 10.1.1.100
 	check_err $?
 	# overlay: ipv6 over ipv6
-	ip netns exec at_ns0 ping6 $PING_ARG fc80::200
+	ip netns exec at_ns0 ping -6 $PING_ARG fc80::200
 	check_err $?
 	cleanup
 
@@ -376,7 +376,7 @@ test_ip6erspan()
 	config_device
 	add_ip6erspan_tunnel $1
 	attach_bpf $DEV ip4ip6erspan_set_tunnel ip4ip6erspan_get_tunnel
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
 	check_err $?
 	cleanup
@@ -474,7 +474,7 @@ test_ipip6()
 	ip link set dev veth1 mtu 1500
 	attach_bpf $DEV ipip6_set_tunnel ipip6_get_tunnel
 	# underlay
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	# ip4 over ip6
 	ping $PING_ARG 10.1.1.100
 	check_err $?
@@ -502,11 +502,11 @@ test_ip6ip6()
 	ip link set dev veth1 mtu 1500
 	attach_bpf $DEV ip6ip6_set_tunnel ip6ip6_get_tunnel
 	# underlay
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	# ip6 over ip6
-	ping6 $PING_ARG 1::11
+	ping -6 $PING_ARG 1::11
 	check_err $?
-	ip netns exec at_ns0 ping6 $PING_ARG 1::22
+	ip netns exec at_ns0 ping -6 $PING_ARG 1::22
 	check_err $?
 	cleanup
 
-- 
2.42.0


