Return-Path: <bpf+bounces-53029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C07A4B92E
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 09:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E58D3B1C29
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 08:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5E41F1314;
	Mon,  3 Mar 2025 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p7F306IK"
X-Original-To: bpf@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813E1F0E33;
	Mon,  3 Mar 2025 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990185; cv=none; b=nIJW1Y6jHoDqXkX5DUzMsALUA+9VBR7V3t+HeyYHkAf4GFni+7VQ5hGJuQ7FH/p8byzuoaom0CHiTpwFaTEDE9iwc+z0oSD8i9RBPqIzEbazsqjAb2dOt7Re5/GQ2uYgSSrzomJFnqjj77RO/3HkjkC98hlGLrMfZrdayX8KV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990185; c=relaxed/simple;
	bh=DLb+kC1uvEhmBCVhzWxb76oHegZQEMeQ8pFfnrbUdkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WaGp3S2uJpAIbu0sCSR3RVo+gfFgqC/cF2wlx6r/igkLkLce8e+uwKIV99+IId3GutVrUylHFUYPlPpfR708BYxe4PvT55qx0RS1gLwWiMlORNAvvblneY1y8nPpYFnHpTUiwF3r7CkeP2Ba6qdpBymKoMWd2dA44s8LXXuO9hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p7F306IK; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E666944368;
	Mon,  3 Mar 2025 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740990182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0GUh+DQGnmEkb4YfirW4vH0ak6X+T55tKrGKJHVFhQ=;
	b=p7F306IKxrvwW8Bti9UfXJTq7uJ1tWZT1v1bIEscxrCA/66NlD0qf8CI5gWffr0tAJwEf8
	vi3NPAdkSX/OGMhbUuF9+vb+fF73bLUhPAQKshjOztzsVKybV/ahou3G7eq6ucFIBdUmZb
	wxYD97Tv+wYVlfCGa30aDEFZpniAzEywINYfR56TniGaHIC2e16/5OcjamKnPk9Tzfq1VI
	ji2PWYrr5P3zrVJwPaTqwAl2tM0rD2aMcyx22ziSDzUzNLrMooSNVxzJnZYihs5h3The5y
	70VSGaoV2jH6ej+UTzCEwA06UhochvkoUjpfZZmT0SuB/NeiWMmnM4adKp6/Ug==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Mon, 03 Mar 2025 09:22:56 +0100
Subject: [PATCH bpf-next v2 08/10] selftests/bpf: test_tunnel: Move
 ip6geneve tunnel test to test_progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-tunnels-v2-8-8329f38f0678@bootlin.com>
References: <20250303-tunnels-v2-0-8329f38f0678@bootlin.com>
In-Reply-To: <20250303-tunnels-v2-0-8329f38f0678@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguugihiiekjeesghhmr
 ghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

ip6geneve tunnels are tested in the test_tunnel.sh but not in the
test_progs framework.

Add a new test in test_progs to test ip6geneve tunnels. It uses the same
network topology and the same BPF programs than the script.
Remove test_ip6geneve() from the script.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 48 +++++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh         | 49 ----------------------
 2 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 2210a1d768362634b5baa729121c460f99244756..b5d48d4fd423a4eb1dc541e2c242943a5f3110aa 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -115,6 +115,9 @@
 #define GENEVE_TUNL_DEV0 "geneve00"
 #define GENEVE_TUNL_DEV1 "geneve11"
 
+#define IP6GENEVE_TUNL_DEV0 "ip6geneve00"
+#define IP6GENEVE_TUNL_DEV1 "ip6geneve11"
+
 #define PING_ARGS "-i 0.01 -c 3 -w 10 -q"
 
 static int config_device(void)
@@ -462,6 +465,22 @@ static int add_geneve_tunnel(const char *dev0, const char *dev1,
 	return -1;
 }
 
+static int add_ip6geneve_tunnel(const char *dev0, const char *dev1,
+			     const char *type, const char *opt)
+{
+	if (!type || !opt || !dev0 || !dev1)
+		return -1;
+
+	SYS(fail, "ip -n at_ns0 link add dev %s type %s id 22 %s remote %s",
+	    dev0, type, opt, IP6_ADDR1_VETH1);
+
+	SYS(fail, "ip link add dev %s type %s %s external", dev1, type, opt);
+
+	return set_ipv6_addr(dev0, dev1);
+fail:
+	return -1;
+}
+
 static int test_ping(int family, const char *addr)
 {
 	SYS(fail, "%s %s %s > /dev/null", ping_command(family), PING_ARGS, addr);
@@ -999,6 +1018,34 @@ static void test_geneve_tunnel(void)
 	delete_tunnel(GENEVE_TUNL_DEV0, GENEVE_TUNL_DEV1);
 	test_tunnel_kern__destroy(skel);
 }
+
+static void test_ip6geneve_tunnel(void)
+{
+	struct test_tunnel_kern *skel;
+	int set_fd, get_fd;
+	int err;
+
+	skel = test_tunnel_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
+		return;
+
+	err = add_ip6geneve_tunnel(IP6GENEVE_TUNL_DEV0, IP6GENEVE_TUNL_DEV1,
+				   "geneve", "");
+	if (!ASSERT_OK(err, "add tunnel"))
+		goto done;
+
+	set_fd = bpf_program__fd(skel->progs.ip6geneve_set_tunnel);
+	get_fd = bpf_program__fd(skel->progs.ip6geneve_get_tunnel);
+	if (generic_attach(IP6GENEVE_TUNL_DEV1, get_fd, set_fd))
+		goto done;
+
+	ping_dev0();
+	ping_dev1();
+done:
+	delete_tunnel(IP6GENEVE_TUNL_DEV0, IP6GENEVE_TUNL_DEV1);
+	test_tunnel_kern__destroy(skel);
+}
+
 #define RUN_TEST(name, ...)						\
 	({								\
 		if (test__start_subtest(#name)) {			\
@@ -1027,6 +1074,7 @@ static void *test_tunnel_run_tests(void *arg)
 	RUN_TEST(ip6erspan_tunnel, V1);
 	RUN_TEST(ip6erspan_tunnel, V2);
 	RUN_TEST(geneve_tunnel);
+	RUN_TEST(ip6geneve_tunnel);
 
 	return NULL;
 }
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 7f2b1c846a72f07f578afbc9b4bb9882cabc838b..f46628f70399e2a049859709e9db9e8419e74770 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -64,26 +64,6 @@ config_device()
 	ip addr add dev veth1 172.16.1.200/24
 }
 
-add_ip6geneve_tunnel()
-{
-	ip netns exec at_ns0 ip addr add ::11/96 dev veth0
-	ip netns exec at_ns0 ip link set dev veth0 up
-	ip addr add dev veth1 ::22/96
-	ip link set dev veth1 up
-
-	# at_ns0 namespace
-	ip netns exec at_ns0 \
-		ip link add dev $DEV_NS type $TYPE id 22 \
-		remote ::22     # geneve has no local option
-	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
-	ip netns exec at_ns0 ip link set dev $DEV_NS up
-
-	# root namespace
-	ip link add dev $DEV type $TYPE external
-	ip addr add dev $DEV 10.1.1.200/24
-	ip link set dev $DEV up
-}
-
 add_ipip_tunnel()
 {
 	# at_ns0 namespace
@@ -121,30 +101,6 @@ add_ip6tnl_tunnel()
 	ip link set dev $DEV up
 }
 
-test_ip6geneve()
-{
-	TYPE=geneve
-	DEV_NS=ip6geneve00
-	DEV=ip6geneve11
-	ret=0
-
-	check $TYPE
-	config_device
-	add_ip6geneve_tunnel
-	attach_bpf $DEV ip6geneve_set_tunnel ip6geneve_get_tunnel
-	ping $PING_ARG 10.1.1.100
-	check_err $?
-	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
-	check_err $?
-	cleanup
-
-	if [ $ret -ne 0 ]; then
-                echo -e ${RED}"FAIL: ip6$TYPE"${NC}
-                return 1
-        fi
-        echo -e ${GREEN}"PASS: ip6$TYPE"${NC}
-}
-
 test_ipip()
 {
 	TYPE=ipip
@@ -247,7 +203,6 @@ cleanup()
 	ip link del ipip11 2> /dev/null
 	ip link del ipip6tnl11 2> /dev/null
 	ip link del ip6ip6tnl11 2> /dev/null
-	ip link del ip6geneve11 2> /dev/null
 }
 
 cleanup_exit()
@@ -283,10 +238,6 @@ bpf_tunnel_test()
 {
 	local errors=0
 
-	echo "Testing IP6GENEVE tunnel..."
-	test_ip6geneve
-	errors=$(( $errors + $? ))
-
 	echo "Testing IPIP tunnel..."
 	test_ipip
 	errors=$(( $errors + $? ))

-- 
2.48.1


