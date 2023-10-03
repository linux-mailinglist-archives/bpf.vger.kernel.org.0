Return-Path: <bpf+bounces-11249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1ED7B6244
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 09:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 96D69B20B4B
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 07:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BB5D2F3;
	Tue,  3 Oct 2023 07:10:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632EBD272;
	Tue,  3 Oct 2023 07:10:50 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C1E11F;
	Tue,  3 Oct 2023 00:10:46 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 7C65C5C02E6;
	Tue,  3 Oct 2023 03:10:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 03 Oct 2023 03:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lambda.lt; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1696317045; x=
	1696403445; bh=+c9JuJc40GWU11NJkKnugj8jUZQiuSP3W5JuycpXiPQ=; b=G
	QWaAQZHzmeXwGMr2AcH4fO5NtaHlsfIkMl88ZFbMVYiXZZ5vBeAtSexoOVUilZb9
	P65STNCmDdo+BBJmgeGEu+CiLT/UWlU1asIltSo8JO3W2JccvOL6HTBab/x6WcAl
	LWNqNEjjEZR25PnVKydxf7cIibzwqcbhYz6WhIvbI6mN2Cj2vNAvEoRvlRladk0r
	df9qT/yXXFNNiPJVBffZ2sJZR8OmIkhbnoTQqT/TLvjaq/iDXnlTPh2a58E/qV4J
	w+6t0xLBKEULi26jluyjQDQmGbwt8X2cCr7Zm9e12rrEnhL+dZsqJ76J/RWKC5oC
	zx2NUo/lFM+qa9VTGe4Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1696317045; x=
	1696403445; bh=+c9JuJc40GWU11NJkKnugj8jUZQiuSP3W5JuycpXiPQ=; b=r
	Qz3QwD9fILvzfJNFee/bWX5iIfECYgz4adUC0dESKqFnYh03Itpa/1M/OhD5pTBA
	4BGEIbbDNy3jrHsU1UZ/kxW7NgkshI/nOHM56qMr7UMPJOQ5QPoYSD4qV3lnFuTl
	Ht55GbDWuNIkD0elIrML1XpaJv0eHuiACDB7QbI5VCKjgolurgApBuia2dqaRWR4
	/8mME/Is0MPaWooV4TiqpkltqnAFSJCIKVVYxlGPLAqshaZyr4QVkcJd9MQx7BGx
	Ygnrqb198B6a+ox06Xkj4Z+1GBDLuWBEv4xeueXf83TkPTJa0R3zVhkngb6WL+ZT
	R2a2mwrY7GQQCP6xCuauw==
X-ME-Sender: <xms:db4bZewT-YXOqC0qVXSn4vhz9kl9rWc23uXjLncdIl8o9j06Xf2G4g>
    <xme:db4bZaSfeSDpSHJsEvgAMoH8py4BZ8IsenYfHxnumcc3Ih_Y9VbHqDPnTxM6OR8jQ
    -H9lOJG5zZN0-tOmhw>
X-ME-Received: <xmr:db4bZQWpxnOPHwfvns5n3hX8K6Y_315LaTAKf0BuxG77g1NqhLMH_qYyQG_MMQ0PL8lJf2rOqlc1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeehgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvg
    hrnhepgeduuddtjeefheeggfdtveeuhefgffeivdeuudelteeffeejfeffuefgjefhgfeu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmheslh
    grmhgsuggrrdhlth
X-ME-Proxy: <xmx:db4bZUjh7zKvj7r9xywiD9gZlU8ptJ8z3XZV5mnuihRSpzj7nYI65w>
    <xmx:db4bZQBgLY_3ul_eEXsGTU2qR0aWJp83Ii_Nd8lBh9ygrHnfXCNblw>
    <xmx:db4bZVJ8eLst0C_JfNCHafrpZkZroMqD5FceExk6x2RckaDzuoLzKg>
    <xmx:db4bZT_ZdHv3up66To0ThJcuqiW8O4LJuOSSAE-amok6us6ct_NPGw>
Feedback-ID: i215944fb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Oct 2023 03:10:44 -0400 (EDT)
From: Martynas Pumputis <m@lambda.lt>
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add BPF_FIB_LOOKUP_SET_SRC tests
Date: Tue,  3 Oct 2023 09:10:13 +0200
Message-ID: <20231003071013.824623-3-m@lambda.lt>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003071013.824623-1-m@lambda.lt>
References: <20231003071013.824623-1-m@lambda.lt>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch extends the existing fib_lookup test suite by adding two test
cases (for each IP family):

* Test source IP selection when default route is used.
* Test source IP selection when an IP route has a preferred src IP addr.

Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 .../selftests/bpf/prog_tests/fib_lookup.c     | 76 +++++++++++++++++--
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index 2fd05649bad1..1b0ab1dbd4f1 100644
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
@@ -31,6 +35,8 @@ struct fib_lookup_test {
 	const char *desc;
 	const char *daddr;
 	int expected_ret;
+	const char *expected_ipv4_src;
+	const char *expected_ipv6_src;
 	int lookup_flags;
 	__u32 tbid;
 	__u8 dmac[6];
@@ -69,6 +75,22 @@ static const struct fib_lookup_test tests[] = {
 	  .daddr = IPV6_TBID_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
 	  .lookup_flags = BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID, .tbid = 100,
 	  .dmac = DMAC_INIT2, },
+	{ .desc = "IPv4 set src addr",
+	  .daddr = IPV4_NUD_FAILED_ADDR, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_ipv4_src = IPV4_IFACE_ADDR,
+	  .lookup_flags = BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv6 set src addr",
+	  .daddr = IPV6_NUD_FAILED_ADDR, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_ipv6_src = IPV6_IFACE_ADDR,
+	  .lookup_flags = BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv4 set prefsrc addr from route",
+	  .daddr = IPV4_ADDR_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_ipv4_src = IPV4_IFACE_ADDR_SEC,
+	  .lookup_flags = BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv6 set prefsrc addr route",
+	  .daddr = IPV6_ADDR_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .expected_ipv6_src = IPV6_IFACE_ADDR_SEC,
+	  .lookup_flags = BPF_FIB_LOOKUP_SET_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
 };
 
 static int ifindex;
@@ -97,6 +119,13 @@ static int setup_netns(void)
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
@@ -133,9 +162,12 @@ static int set_lookup_params(struct bpf_fib_lookup *params, const struct fib_loo
 
 	if (inet_pton(AF_INET6, test->daddr, params->ipv6_dst) == 1) {
 		params->family = AF_INET6;
-		ret = inet_pton(AF_INET6, IPV6_IFACE_ADDR, params->ipv6_src);
-		if (!ASSERT_EQ(ret, 1, "inet_pton(IPV6_IFACE_ADDR)"))
-			return -1;
+		if (!(test->lookup_flags & BPF_FIB_LOOKUP_SET_SRC)) {
+			ret = inet_pton(AF_INET6, IPV6_IFACE_ADDR, params->ipv6_src);
+			if (!ASSERT_EQ(ret, 1, "inet_pton(IPV6_IFACE_ADDR)"))
+				return -1;
+		}
+
 		return 0;
 	}
 
@@ -143,9 +175,12 @@ static int set_lookup_params(struct bpf_fib_lookup *params, const struct fib_loo
 	if (!ASSERT_EQ(ret, 1, "convert IP[46] address"))
 		return -1;
 	params->family = AF_INET;
-	ret = inet_pton(AF_INET, IPV4_IFACE_ADDR, &params->ipv4_src);
-	if (!ASSERT_EQ(ret, 1, "inet_pton(IPV4_IFACE_ADDR)"))
-		return -1;
+
+	if (!(test->lookup_flags & BPF_FIB_LOOKUP_SET_SRC)) {
+		ret = inet_pton(AF_INET, IPV4_IFACE_ADDR, &params->ipv4_src);
+		if (!ASSERT_EQ(ret, 1, "inet_pton(IPV4_IFACE_ADDR)"))
+			return -1;
+	}
 
 	return 0;
 }
@@ -207,6 +242,35 @@ void test_fib_lookup(void)
 		ASSERT_EQ(skel->bss->fib_lookup_ret, tests[i].expected_ret,
 			  "fib_lookup_ret");
 
+		if (tests[i].expected_ipv4_src) {
+			__be32 expected_ipv4_src;
+
+			ret = inet_pton(AF_INET, tests[i].expected_ipv4_src,
+					&expected_ipv4_src);
+			ASSERT_EQ(ret, 1, "inet_pton(expected_ipv4_src)");
+
+			ASSERT_EQ(fib_params->ipv4_src, expected_ipv4_src,
+			  "fib_lookup ipv4 src");
+		}
+		if (tests[i].expected_ipv6_src) {
+			__u32 expected_ipv6_src[4];
+
+			ret = inet_pton(AF_INET6, tests[i].expected_ipv6_src,
+					expected_ipv6_src);
+			ASSERT_EQ(ret, 1, "inet_pton(expected_ipv6_src)");
+
+			ret = memcmp(expected_ipv6_src, fib_params->ipv6_src,
+				     sizeof(fib_params->ipv6_src));
+			if (!ASSERT_EQ(ret, 0, "fib_lookup ipv6 src")) {
+				char src_ip6[64];
+
+				inet_ntop(AF_INET6, fib_params->ipv6_src, src_ip6,
+					  sizeof(src_ip6));
+				printf("ipv6 expected %s actual %s ",
+				       tests[i].expected_ipv6_src, src_ip6);
+			}
+		}
+
 		ret = memcmp(tests[i].dmac, fib_params->dmac, sizeof(tests[i].dmac));
 		if (!ASSERT_EQ(ret, 0, "dmac not match")) {
 			char expected[18], actual[18];
-- 
2.42.0


