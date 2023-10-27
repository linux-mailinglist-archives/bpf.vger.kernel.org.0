Return-Path: <bpf+bounces-13470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBDA7DA0EC
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976A0B2146B
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2D73C6A9;
	Fri, 27 Oct 2023 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ncOlPQs+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hoEWc5JX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF9D38DCF
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:46:53 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68220192;
	Fri, 27 Oct 2023 11:46:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 99A295C01F8;
	Fri, 27 Oct 2023 14:46:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 27 Oct 2023 14:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1698432406; x=
	1698518806; bh=r9QySCSR1RQvS3mDA4gvRgEb3+CSuEqmuwH7tokfHzY=; b=n
	cOlPQs+q45zUZEihzWQ/aMVtQqZR9I30SWvUsKooSNJMWN6KgbGeBZSU07rd0QkT
	lvrnjsOv+yLTL1T3Is1X5QzHayCAwvmagp8k5h4h05OXofmHcG8I4p9Wg6aeBTVn
	ePZhIVjnXM7UPeaNBraSSGDraQmxc1bKBJ0YWsG+M0Bb2yOhI3LI6kUHRz88lB5p
	EyMxqwXOUrUXzLGgO9yF/ZlcERjG/r0TpI0XDhhluIKww1n3/ShDv5pDHhY9GJnx
	YagX4UMxlEoc3BWmUbyVbCFFSLuNAYj9o1CUg4BI5mC3ay6o7Qj+CUAv6MitI2Ae
	j4VkIVwXur8a4dda0oSlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698432406; x=
	1698518806; bh=r9QySCSR1RQvS3mDA4gvRgEb3+CSuEqmuwH7tokfHzY=; b=h
	oEWc5JX+w2LE9ddRlsklXy7ua4Va1ZkFGY05uMGLBMc2exl9x4qrFA0FOSQ0/c54
	Y3YBk27G77cOIWK0iYJcSRu2B1iL/1ZRCfwwLvx2a/MuJpVBRyubsi0vZzTC4Q3Y
	QuDxqfSWTfoptAZBhArBQbbTOo9Bq5IyJahdWxBlPbKnwfRpRzTaDkjbOP57wbRD
	eEx8V6pUDFQOaw80PCWzXNZUR0o7oabZyTL4M5XSWVHWFbjQu25GNA4hDPzI5d7I
	ZPiBcGDV5SqjPiuopbbVZoQ6wxLoIZ4vuyAKAqrJuKXCVixRuP27N92EoUD/R1C2
	PeehHoht+iIaL8leC6ZbQ==
X-ME-Sender: <xms:lgU8ZZ0KX-edKk3G9UNqTsTeTrj8JZFzosoKnm17GicjJC7PaU6k9w>
    <xme:lgU8ZQGvsh3UJIazZv-VKGavK0zoKqRgukMLouXrgnoNv65LbPxzYAwQL5QvZQZqn
    rtZdX9dj-MEkKqcYQ>
X-ME-Received: <xmr:lgU8ZZ7Bm1i68V3p-e8AWxlm4vttv6HO1ywsc3z8SD_WMHYbEsdIM2nXfLxgCh05rQnCes0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvedtkeejffekgfefhf
    evffeftefgueeuuedtteejudduheehieffvdeghffhvefhnecuffhomhgrihhnpehgihht
    hhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:lgU8ZW3Q0HAoMvAxKEbW0Ei844tlHQzO-b1hjGzTZBxWzHpSbyqGcg>
    <xmx:lgU8ZcFw6ooSp0iK6S4wIt6lspIVY1Yrp9or8eaWOO-5AHQLUzB2Fw>
    <xmx:lgU8ZX8E8pc89QmZN4FiW28B7Pn4Cr4WkuuRrPfx7jVQXnodHKYphA>
    <xmx:lgU8ZRKgXYRXxxx0FkGThgbBOFwHabBzYuus6Po56S-1sIYez3kegA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 14:46:45 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	andrii@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [RFC bpf-next 2/6] bpf: selftests: test_tunnel: Use ping -6 over ping6
Date: Fri, 27 Oct 2023 12:46:18 -0600
Message-ID: <1cc959a4173b60dd18f4eec64214fc3198e95164.1698431765.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698431765.git.dxu@dxuuu.xyz>
References: <cover.1698431765.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ping6 binary went away over 7 years ago [0].

[0]: https://github.com/iputils/iputils/commit/ebad35fee3de851b809c7b72ccc654a72b6af61d

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


