Return-Path: <bpf+bounces-11113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B1B7B365D
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 17:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id EE5941C2091F
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E201751B98;
	Fri, 29 Sep 2023 15:08:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7AB516FC;
	Fri, 29 Sep 2023 15:08:05 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783FD6;
	Fri, 29 Sep 2023 08:08:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 3C6CA5C2612;
	Fri, 29 Sep 2023 11:08:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 29 Sep 2023 11:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lambda.lt; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1696000083; x=
	1696086483; bh=+c9JuJc40GWU11NJkKnugj8jUZQiuSP3W5JuycpXiPQ=; b=c
	6xdkHOZb7eaPX/LTBkiB+rq17zXcjOkSbRQWow42OkI3JUwJRZF9PkydkZOMjU28
	9OVYbBv+CFL18holIyDZpyWFjj86AgP8AViAKhi+XIu6s2knyBcZ1+SgmgtbAxTN
	fgXbTN0Sf4VfO9hctUi0TJyVstEW2ZJHeH72YG1cTv0N0LtEGgW3yaL75OxLCiMv
	2y3iRkhMCc/0LMt9ABUHzKW8w9EqgziJer3ZUhbFmbMwRLRh93WCXQAXy2AbBcEa
	PbG9/SqgsvdhSWRpkFAbvZVxTGrlEzSHdaEHMNORaGQvVM+zIuRnYhpq+I23SZLU
	MoDccqH/CkLEph+opEdog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1696000083; x=
	1696086483; bh=+c9JuJc40GWU11NJkKnugj8jUZQiuSP3W5JuycpXiPQ=; b=m
	iHkQFoppoMH20c+ycZ/7eaFyfpCZBn5G0nPoWQ5ozwIgOZseIlqDaU4IfKWX/phC
	m1Ff1GVARAJSBNGNvFW5tpcZIV8o7mtOoz0Y31kVuVPxlBdw3pPMF2dKKAlAMkFw
	z2B9IURVuIqQcO4eqb13pV0MgL/YlrdVXxYUGXLbnEnpdF7IpEUoBRK8//K5cbYV
	IAGxUStcNIs7hfRiFWBI0J+ZfvTVIsdlqHRPUtFFmP7MNW2CQpokKlJB9cDn7QXc
	9WbXMhiPjFxdxVzWpbmSKcVE8XDT4n0nNKXERyoBqMgAxKRl4KAxrWoFXygbATLC
	6g9MArtPNxk4Z3oYq9xVQ==
X-ME-Sender: <xms:UugWZdLgjnz35DZwHJoYOy7q7hNVaLiQvyRP140qnsVwvDjfYZA7Bg>
    <xme:UugWZZKBYAx72Marn3lE13KyV8foBHsCLNFF2Gj4u57LXTfKoBRfS_W75Bhr8V3-v
    GJH1ZqszMJvTJ8_E4c>
X-ME-Received: <xmr:UugWZVuveP8-yCWJffX-l_5HjO-lFY4YUGcMzC2lEKO_IsckDiKWwhJ9TBQEK31V1EOrx90GNISA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddvgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvg
    hrnhepgeduuddtjeefheeggfdtveeuhefgffeivdeuudelteeffeejfeffuefgjefhgfeu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmheslh
    grmhgsuggrrdhlth
X-ME-Proxy: <xmx:UugWZebXtQoraC-M8_dPfqHlW3aCPRbSkkP463uV5DisZRL1MsoFBw>
    <xmx:UugWZUZVsaeFB0ECScHeaSHy4f3P23haqP8KuKg8gj7hsmUdz2INCQ>
    <xmx:UugWZSDPjIoiLPcFzP0uC03K14oPhsuEqseu-TvLxdF7w00xHw6Wkw>
    <xmx:U-gWZbXvfRCtkrz659SKX77pntvAfRgEpQWzrjLcjbrqBM7nMNtInQ>
Feedback-ID: i215944fb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Sep 2023 11:08:01 -0400 (EDT)
From: Martynas Pumputis <m@lambda.lt>
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf 2/2] selftests/bpf: Add BPF_FIB_LOOKUP_SET_SRC tests
Date: Fri, 29 Sep 2023 17:07:17 +0200
Message-ID: <20230929150717.120463-3-m@lambda.lt>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929150717.120463-1-m@lambda.lt>
References: <20230929150717.120463-1-m@lambda.lt>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
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


