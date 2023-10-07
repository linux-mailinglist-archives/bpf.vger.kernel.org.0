Return-Path: <bpf+bounces-11603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158717BC601
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 10:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1522B282339
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 08:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7430C17752;
	Sat,  7 Oct 2023 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lambda.lt header.i=@lambda.lt header.b="htBpFXJb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pgsVS/NF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95407156E7;
	Sat,  7 Oct 2023 08:14:58 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EFCB9;
	Sat,  7 Oct 2023 01:14:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 7BD993200A35;
	Sat,  7 Oct 2023 04:14:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 07 Oct 2023 04:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lambda.lt; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1696666495; x=
	1696752895; bh=A5IZZcvzMXdpUe09R1rNVH8GWXEm7LugfsQNxEN9U9w=; b=h
	tBpFXJbCElqhHfSxDmAIaRKE7GLESkCSDDGdutntTM8YuFtB5i7eNHWFF/P32KpP
	m6dHUJjIdt6003ibEdcFQQM+WaiLcQObD8Xsq+WENZuTfdrd+ylA47IOf8CRxfgC
	4UT4iiAntTS26ktgwKa7xluW3MnwfIbXVyNI/dp5CUnQ+I+hzgHpdOrov47H5HKJ
	zeg5vcxP8vPGZVjEN8TjAJaflHcWmorBTmlV4u4uE+iTx+dsKb/4+xIuxLvpUTaH
	FF9MxVJAEc5KD9qNkej811EoOwsNP4KAGANvTKnH7B+xuqM4Vp8SSHuAbhENyGy+
	5XNpt6uHORk2gPBA9kOFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1696666495; x=
	1696752895; bh=A5IZZcvzMXdpUe09R1rNVH8GWXEm7LugfsQNxEN9U9w=; b=p
	gsVS/NFemLTieEvFO3v7oKrjF58VzVEXumXQ80ZJeW89xNSxov+Mnsr+OB3h4b4L
	XPpiRBZvmQREd+tPKBCCtd3YZiCuY8hFZZMFKWUCuirfvSgXM+OUvyH87LilRd8+
	7vBcyIyDrD0teRQmtBY9wQBlRAuH17uVLMjyCrTLXb6YTHU2ac6DzOuwkH4Y7oDM
	GEvHGDYhKK7h3SiYBVB9VYChsPrkHkfx2ZKvz8JEmPlA9atawZAOuqDKbFV5Zdsq
	j1r42MHdbjlLoaQPb8tKpTqwHSwydXf6+3cMCW1Wy+QbWglQ2fiCGJWG3rxWDcWN
	4Orqp3cXcBysLE3TWVrIw==
X-ME-Sender: <xms:fhMhZevIKzoZ5oTUjz084n6gyrxW8VdCYv9cM1-PLSc8uJmC29Mlmw>
    <xme:fhMhZTfKwWWrSFV2j_CGXrtNHu-ZLPM0IHxtQhuRxea4LPEQ3D0y2oVVcp4kqGufW
    JCzAqIQsKCSHWvIK4Q>
X-ME-Received: <xmr:fhMhZZzbRIMzm8XwSXg4ukAe6LascbYyO7f7Y49UXpH4_O5RQA_1tReC6BoXb8ahYNppsicbQ7qe4bb5vj6cg9GLyB_pebn6Wmgv60oSXRtPJ0ud>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeelgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvg
    hrnhepgeduuddtjeefheeggfdtveeuhefgffeivdeuudelteeffeejfeffuefgjefhgfeu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmheslh
    grmhgsuggrrdhlth
X-ME-Proxy: <xmx:fhMhZZMVU8LPxayxvstC_WJl7DVKVvBB1iG8n21ec8PkdDE9JCyO6Q>
    <xmx:fhMhZe8FivyBVj-yR-n6h5-z4TL40QhTFxl72_BIVX2yA2-g4fC2wA>
    <xmx:fhMhZRXdU8NJv0DiUomWqSjO-fqEiLLn0ukI-qVSohni4Z8cb9Tt3A>
    <xmx:fxMhZSY4vxRplfHiuOS6t7yrHVD7vsri98MPYjrpqYxctgcJH9rxJA>
Feedback-ID: i215944fb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Oct 2023 04:14:52 -0400 (EDT)
From: Martynas Pumputis <m@lambda.lt>
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Add BPF_FIB_LOOKUP_SRC tests
Date: Sat,  7 Oct 2023 10:14:15 +0200
Message-ID: <20231007081415.33502-3-m@lambda.lt>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007081415.33502-1-m@lambda.lt>
References: <20231007081415.33502-1-m@lambda.lt>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch extends the existing fib_lookup test suite by adding two test
cases (for each IP family):

* Test source IP selection from the egressing netdev.
* Test source IP selection when an IP route has a preferred src IP addr.

Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 .../selftests/bpf/prog_tests/fib_lookup.c     | 83 +++++++++++++++++--
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index 2fd05649bad1..4ad4cd69152e 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -11,9 +11,13 @@
 
 #define NS_TEST			"fib_lookup_ns"
 #define IPV6_IFACE_ADDR		"face::face"
+#define IPV6_IFACE_ADDR_SEC	"cafe::cafe"
+#define IPV6_ADDR_DST		"face::3"
 #define IPV6_NUD_FAILED_ADDR	"face::1"
 #define IPV6_NUD_STALE_ADDR	"face::2"
 #define IPV4_IFACE_ADDR		"10.0.0.254"
+#define IPV4_IFACE_ADDR_SEC	"10.1.0.254"
+#define IPV4_ADDR_DST		"10.2.0.254"
 #define IPV4_NUD_FAILED_ADDR	"10.0.0.1"
 #define IPV4_NUD_STALE_ADDR	"10.0.0.2"
 #define IPV4_TBID_ADDR		"172.0.0.254"
@@ -31,6 +35,7 @@ struct fib_lookup_test {
 	const char *desc;
 	const char *daddr;
 	int expected_ret;
+	const char *expected_src;
 	int lookup_flags;
 	__u32 tbid;
 	__u8 dmac[6];
@@ -69,6 +74,22 @@ static const struct fib_lookup_test tests[] = {
 	  .daddr = IPV6_TBID_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
 	  .lookup_flags = BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID, .tbid = 100,
 	  .dmac = DMAC_INIT2, },
+	{ .desc = "IPv4 set src addr from netdev",
+	  .daddr = IPV4_NUD_FAILED_ADDR, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_src = IPV4_IFACE_ADDR,
+	  .lookup_flags = BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv6 set src addr from netdev",
+	  .daddr = IPV6_NUD_FAILED_ADDR, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_src = IPV6_IFACE_ADDR,
+	  .lookup_flags = BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv4 set prefsrc addr from route",
+	  .daddr = IPV4_ADDR_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_src = IPV4_IFACE_ADDR_SEC,
+	  .lookup_flags = BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv6 set prefsrc addr route",
+	  .daddr = IPV6_ADDR_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_src = IPV6_IFACE_ADDR_SEC,
+	  .lookup_flags = BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
 };
 
 static int ifindex;
@@ -97,6 +118,13 @@ static int setup_netns(void)
 	SYS(fail, "ip neigh add %s dev veth1 nud failed", IPV4_NUD_FAILED_ADDR);
 	SYS(fail, "ip neigh add %s dev veth1 lladdr %s nud stale", IPV4_NUD_STALE_ADDR, DMAC);
 
+	/* Setup for prefsrc IP addr selection */
+	SYS(fail, "ip addr add %s/24 dev veth1", IPV4_IFACE_ADDR_SEC);
+	SYS(fail, "ip route add %s/32 dev veth1 src %s", IPV4_ADDR_DST, IPV4_IFACE_ADDR_SEC);
+
+	SYS(fail, "ip addr add %s/64 dev veth1 nodad", IPV6_IFACE_ADDR_SEC);
+	SYS(fail, "ip route add %s/128 dev veth1 src %s", IPV6_ADDR_DST, IPV6_IFACE_ADDR_SEC);
+
 	/* Setup for tbid lookup tests */
 	SYS(fail, "ip addr add %s/24 dev veth2", IPV4_TBID_ADDR);
 	SYS(fail, "ip route del %s/24 dev veth2", IPV4_TBID_NET);
@@ -133,9 +161,12 @@ static int set_lookup_params(struct bpf_fib_lookup *params, const struct fib_loo
 
 	if (inet_pton(AF_INET6, test->daddr, params->ipv6_dst) == 1) {
 		params->family = AF_INET6;
-		ret = inet_pton(AF_INET6, IPV6_IFACE_ADDR, params->ipv6_src);
-		if (!ASSERT_EQ(ret, 1, "inet_pton(IPV6_IFACE_ADDR)"))
-			return -1;
+		if (!(test->lookup_flags & BPF_FIB_LOOKUP_SRC)) {
+			ret = inet_pton(AF_INET6, IPV6_IFACE_ADDR, params->ipv6_src);
+			if (!ASSERT_EQ(ret, 1, "inet_pton(IPV6_IFACE_ADDR)"))
+				return -1;
+		}
+
 		return 0;
 	}
 
@@ -143,9 +174,12 @@ static int set_lookup_params(struct bpf_fib_lookup *params, const struct fib_loo
 	if (!ASSERT_EQ(ret, 1, "convert IP[46] address"))
 		return -1;
 	params->family = AF_INET;
-	ret = inet_pton(AF_INET, IPV4_IFACE_ADDR, &params->ipv4_src);
-	if (!ASSERT_EQ(ret, 1, "inet_pton(IPV4_IFACE_ADDR)"))
-		return -1;
+
+	if (!(test->lookup_flags & BPF_FIB_LOOKUP_SRC)) {
+		ret = inet_pton(AF_INET, IPV4_IFACE_ADDR, &params->ipv4_src);
+		if (!ASSERT_EQ(ret, 1, "inet_pton(IPV4_IFACE_ADDR)"))
+			return -1;
+	}
 
 	return 0;
 }
@@ -156,6 +190,40 @@ static void mac_str(char *b, const __u8 *mac)
 		mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
 }
 
+static void assert_src_ip(struct bpf_fib_lookup *fib_params, const char *expected_src)
+{
+	int ret;
+	__u32 src6[4];
+	__be32 src4;
+
+	switch (fib_params->family) {
+	case AF_INET6:
+		ret = inet_pton(AF_INET6, expected_src, src6);
+		ASSERT_EQ(ret, 1, "inet_pton(expected_src)");
+
+		ret = memcmp(src6, fib_params->ipv6_src, sizeof(fib_params->ipv6_src));
+		if (!ASSERT_EQ(ret, 0, "fib_lookup ipv6 src")) {
+			char str_src6[64];
+
+			inet_ntop(AF_INET6, fib_params->ipv6_src, str_src6,
+				  sizeof(str_src6));
+			printf("ipv6 expected %s actual %s ", expected_src,
+			       str_src6);
+		}
+
+		break;
+	case AF_INET:
+		ret = inet_pton(AF_INET, expected_src, &src4);
+		ASSERT_EQ(ret, 1, "inet_pton(expected_src)");
+
+		ASSERT_EQ(fib_params->ipv4_src, src4, "fib_lookup ipv4 src");
+
+		break;
+	default:
+		PRINT_FAIL("invalid addr family: %d", fib_params->family);
+	}
+}
+
 void test_fib_lookup(void)
 {
 	struct bpf_fib_lookup *fib_params;
@@ -207,6 +275,9 @@ void test_fib_lookup(void)
 		ASSERT_EQ(skel->bss->fib_lookup_ret, tests[i].expected_ret,
 			  "fib_lookup_ret");
 
+		if (tests[i].expected_src)
+			assert_src_ip(fib_params, tests[i].expected_src);
+
 		ret = memcmp(tests[i].dmac, fib_params->dmac, sizeof(tests[i].dmac));
 		if (!ASSERT_EQ(ret, 0, "dmac not match")) {
 			char expected[18], actual[18];
-- 
2.42.0


