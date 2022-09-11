Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6632F5B4CB4
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 10:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiIKIqr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 04:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIKIqp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 04:46:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F3E3206E
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 01:46:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s11so8628012edd.13
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GDmBcP+6ghXcfR6E5lq/BwYeyvFs0vGrwCup9rQ3VtY=;
        b=F759KSIOVobtMqfX/OdyzuNwkKJAs4FVlwmw435VQ1A4mp45FgL/VEL7SZcxx1GbHa
         Q9jgXRopH/ma/zMzVJsSTyMK2pvnqhVqkMuwkpwYT+aqvAYSLLFcKEut4lZYlJliG+tl
         cNwTTbdt6PBtpZiW6mDaz9qkrCVmJl3YFixSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GDmBcP+6ghXcfR6E5lq/BwYeyvFs0vGrwCup9rQ3VtY=;
        b=tfso9ZoF7Md4136D+cL7Vbw2TYBqjKuHNKPfIUQKLURRNggyZliIu8aJft3HK7X/Fo
         9W4mReUHqk7fwKZVlomSKbqZb/b0HVew6kSFEIIdfrNJIZqSptCb31QXyPNWXznoYerm
         Wla8qfyNLlmTXrzMcCRxJ0xT/ffEXM9+7suPKilI2WFqivbvF7Xr8Nyjnp+xOD7v3AIx
         5eYhZVjQKZFYqMAXbwhieKUStpvZPitJbWjZKk/2JRCjMUauTLAmPOFiONvfovOnOz8g
         n9pnHnR4eKTz11dShMdK8f0r0kB3uoezP3zFsqUqDdr7TKJaL2XNMdkwGgB6XdopcIdj
         luNA==
X-Gm-Message-State: ACgBeo1gseUgLT3tne1vzg+ElJueL4X7Jsa8T3nq0ZfW1unQL6N42XCH
        5LuDcE76NeF1ACmLWpKhzw/pk8MR1L//ne8hHQtaX1iOHD4sfdtyLQy89F9bD6ZIIT3T2gF3uhe
        RbPzQEv88Evwi55vUCKZ/y1RWtojwNhLWQH8+UeA4bQqP6xQ3JYoooYzmX2RB+s4uNpnMPa645J
        Y=
X-Google-Smtp-Source: AA6agR4zK4HPOeu4wE1RTwDDYAbnjUAXtC3jGPIRkCpdL6slfmRs1n0vjhXlzVDSvAu9JIC2QfS7RQ==
X-Received: by 2002:a05:6402:4cf:b0:446:42cf:e49d with SMTP id n15-20020a05640204cf00b0044642cfe49dmr18100413edw.41.1662886002149;
        Sun, 11 Sep 2022 01:46:42 -0700 (PDT)
Received: from localhost.localdomain ([141.226.162.95])
        by smtp.gmail.com with ESMTPSA id q10-20020a170906360a00b007309a570bacsm2713591ejb.176.2022.09.11.01.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 01:46:41 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v6 bpf-next 4/4] selftests/bpf: Add geneve with bpf_skb_set_tunnel_opt_dynptr test-case to test_progs
Date:   Sun, 11 Sep 2022 11:46:09 +0300
Message-Id: <20220911084609.102519-5-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911084609.102519-1-shmulik.ladkani@gmail.com>
References: <20220911084609.102519-1-shmulik.ladkani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add geneve test to test_tunnel. The test setup and scheme resembles the
existing vxlan test.

The test also exercises tunnel option assignment using
bpf_skb_set_tunnel_opt_dynptr.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
v6:
- Fix missing retcodes in progs/test_tunnel_kern.c
  spotted by John Fastabend <john.fastabend@gmail.com>
- Simplify bpf_skb_set_tunnel_opt_dynptr's interface, removing the
  superfluous 'len' parameter
  suggested by Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 .../selftests/bpf/prog_tests/test_tunnel.c    | 108 ++++++++++++++
 .../selftests/bpf/progs/test_tunnel_kern.c    | 138 ++++++++++++++++++
 2 files changed, 246 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 852da04ff281..9aae03c720e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -87,6 +87,8 @@
 #define VXLAN_TUNL_DEV1 "vxlan11"
 #define IP6VXLAN_TUNL_DEV0 "ip6vxlan00"
 #define IP6VXLAN_TUNL_DEV1 "ip6vxlan11"
+#define GENEVE_TUNL_DEV0 "geneve00"
+#define GENEVE_TUNL_DEV1 "geneve11"
 
 #define PING_ARGS "-i 0.01 -c 3 -w 10 -q"
 
@@ -133,6 +135,38 @@ static void cleanup(void)
 	SYS_NOFAIL("ip rule del to %s table 20 2> /dev/null", IP4_ADDR2_VETH1);
 	SYS_NOFAIL("ip link del %s 2> /dev/null", VXLAN_TUNL_DEV1);
 	SYS_NOFAIL("ip link del %s 2> /dev/null", IP6VXLAN_TUNL_DEV1);
+	SYS_NOFAIL("ip link del %s 2> /dev/null", GENEVE_TUNL_DEV1);
+}
+
+static int add_geneve_tunnel(void)
+{
+	/* at_ns0 namespace */
+	SYS("ip netns exec at_ns0 ip link add dev %s type geneve external",
+	    GENEVE_TUNL_DEV0);
+	SYS("ip netns exec at_ns0 ip link set dev %s address %s up",
+	    GENEVE_TUNL_DEV0, MAC_TUNL_DEV0);
+	SYS("ip netns exec at_ns0 ip addr add dev %s %s/24",
+	    GENEVE_TUNL_DEV0, IP4_ADDR_TUNL_DEV0);
+	SYS("ip netns exec at_ns0 ip neigh add %s lladdr %s dev %s",
+	    IP4_ADDR_TUNL_DEV1, MAC_TUNL_DEV1, GENEVE_TUNL_DEV0);
+
+	/* root namespace */
+	SYS("ip link add dev %s type geneve external", GENEVE_TUNL_DEV1);
+	SYS("ip link set dev %s address %s up", GENEVE_TUNL_DEV1, MAC_TUNL_DEV1);
+	SYS("ip addr add dev %s %s/24", GENEVE_TUNL_DEV1, IP4_ADDR_TUNL_DEV1);
+	SYS("ip neigh add %s lladdr %s dev %s",
+	    IP4_ADDR_TUNL_DEV0, MAC_TUNL_DEV0, GENEVE_TUNL_DEV1);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static void delete_geneve_tunnel(void)
+{
+	SYS_NOFAIL("ip netns exec at_ns0 ip link delete dev %s",
+		   GENEVE_TUNL_DEV0);
+	SYS_NOFAIL("ip link delete dev %s", GENEVE_TUNL_DEV1);
 }
 
 static int add_vxlan_tunnel(void)
@@ -248,6 +282,79 @@ static int attach_tc_prog(struct bpf_tc_hook *hook, int igr_fd, int egr_fd)
 	return 0;
 }
 
+static void test_geneve_tunnel(void)
+{
+	struct test_tunnel_kern *skel = NULL;
+	struct nstoken *nstoken;
+	int local_ip_map_fd = -1;
+	int set_src_prog_fd, get_src_prog_fd;
+	int set_dst_prog_fd;
+	int key = 0, ifindex = -1;
+	uint local_ip;
+	int err;
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+			    .attach_point = BPF_TC_INGRESS);
+
+	/* add genve tunnel */
+	err = add_geneve_tunnel();
+	if (!ASSERT_OK(err, "add geneve tunnel"))
+		goto done;
+
+	/* load and attach bpf prog to tunnel dev tc hook point */
+	skel = test_tunnel_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
+		goto done;
+	ifindex = if_nametoindex(GENEVE_TUNL_DEV1);
+	if (!ASSERT_NEQ(ifindex, 0, "geneve11 ifindex"))
+		goto done;
+	tc_hook.ifindex = ifindex;
+	get_src_prog_fd = bpf_program__fd(skel->progs.geneve_get_tunnel_src);
+	set_src_prog_fd = bpf_program__fd(skel->progs.geneve_set_tunnel_src);
+	if (!ASSERT_GE(get_src_prog_fd, 0, "bpf_program__fd"))
+		goto done;
+	if (!ASSERT_GE(set_src_prog_fd, 0, "bpf_program__fd"))
+		goto done;
+	if (attach_tc_prog(&tc_hook, get_src_prog_fd, set_src_prog_fd))
+		goto done;
+
+	/* load and attach prog set_md to tunnel dev tc hook point at_ns0 */
+	nstoken = open_netns("at_ns0");
+	if (!ASSERT_OK_PTR(nstoken, "setns src"))
+		goto done;
+	ifindex = if_nametoindex(GENEVE_TUNL_DEV0);
+	if (!ASSERT_NEQ(ifindex, 0, "geneve00 ifindex"))
+		goto done;
+	tc_hook.ifindex = ifindex;
+	set_dst_prog_fd = bpf_program__fd(skel->progs.geneve_set_tunnel_dst);
+	if (!ASSERT_GE(set_dst_prog_fd, 0, "bpf_program__fd"))
+		goto done;
+	if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd))
+		goto done;
+	close_netns(nstoken);
+
+	/* use veth1 ip 1 as tunnel source ip */
+	local_ip_map_fd = bpf_map__fd(skel->maps.local_ip_map);
+	if (!ASSERT_GE(local_ip_map_fd, 0, "bpf_map__fd"))
+		goto done;
+	local_ip = IP4_ADDR1_HEX_VETH1;
+	err = bpf_map_update_elem(local_ip_map_fd, &key, &local_ip, BPF_ANY);
+	if (!ASSERT_OK(err, "update bpf local_ip_map"))
+		goto done;
+
+	/* ping test */
+	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV0);
+	if (!ASSERT_OK(err, "test_ping"))
+		goto done;
+
+done:
+	/* delete geneve tunnel */
+	delete_geneve_tunnel();
+	if (local_ip_map_fd >= 0)
+		close(local_ip_map_fd);
+	if (skel)
+		test_tunnel_kern__destroy(skel);
+}
+
 static void test_vxlan_tunnel(void)
 {
 	struct test_tunnel_kern *skel = NULL;
@@ -408,6 +515,7 @@ static void *test_tunnel_run_tests(void *arg)
 
 	RUN_TEST(vxlan_tunnel);
 	RUN_TEST(ip6vxlan_tunnel);
+	RUN_TEST(geneve_tunnel);
 
 	cleanup();
 
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index b11f6952b0c8..1b7e89ac7006 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -24,6 +24,20 @@
 
 #define log_err(__ret) bpf_printk("ERROR line:%d ret:%d\n", __LINE__, __ret)
 
+#define GENEVE_OPTS_LEN0 12
+#define GENEVE_OPTS_LEN1 20
+
+struct tun_opts_raw {
+	__u8 data[64];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct tun_opts_raw);
+} geneve_opts SEC(".maps");
+
 struct geneve_opt {
 	__be16	opt_class;
 	__u8	type;
@@ -286,6 +300,130 @@ int ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
+SEC("tc")
+int geneve_set_tunnel_dst(struct __sk_buff *skb)
+{
+	int ret;
+	struct bpf_tunnel_key key;
+	struct tun_opts_raw *opts;
+	struct bpf_dynptr dptr;
+	__u32 index = 0;
+	__u32 *local_ip = NULL;
+
+	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
+	if (!local_ip) {
+		log_err(-1);
+		return TC_ACT_SHOT;
+	}
+
+	index = 0;
+	opts = bpf_map_lookup_elem(&geneve_opts, &index);
+	if (!opts) {
+		log_err(-1);
+		return TC_ACT_SHOT;
+	}
+
+	__builtin_memset(&key, 0x0, sizeof(key));
+	key.local_ipv4 = 0xac100164; /* 172.16.1.100 */
+	key.remote_ipv4 = *local_ip;
+	key.tunnel_id = 2;
+	key.tunnel_tos = 0;
+	key.tunnel_ttl = 64;
+
+	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
+				     BPF_F_ZERO_CSUM_TX);
+	if (ret < 0) {
+		log_err(ret);
+		return TC_ACT_SHOT;
+	}
+
+	/* set empty geneve options (of runtime length) using a dynptr */
+	__builtin_memset(opts, 0x0, sizeof(*opts));
+	if (*local_ip % 2)
+		bpf_dynptr_from_mem(opts, GENEVE_OPTS_LEN1, 0, &dptr);
+	else
+		bpf_dynptr_from_mem(opts, GENEVE_OPTS_LEN0, 0, &dptr);
+	ret = bpf_skb_set_tunnel_opt_dynptr(skb, &dptr);
+	if (ret < 0) {
+		log_err(ret);
+		return TC_ACT_SHOT;
+	}
+
+	return TC_ACT_OK;
+}
+
+SEC("tc")
+int geneve_set_tunnel_src(struct __sk_buff *skb)
+{
+	int ret;
+	struct bpf_tunnel_key key;
+	__u32 index = 0;
+	__u32 *local_ip = NULL;
+
+	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
+	if (!local_ip) {
+		log_err(-1);
+		return TC_ACT_SHOT;
+	}
+
+	__builtin_memset(&key, 0x0, sizeof(key));
+	key.local_ipv4 = *local_ip;
+	key.remote_ipv4 = 0xac100164; /* 172.16.1.100 */
+	key.tunnel_id = 2;
+	key.tunnel_tos = 0;
+	key.tunnel_ttl = 64;
+
+	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
+				     BPF_F_ZERO_CSUM_TX);
+	if (ret < 0) {
+		log_err(ret);
+		return TC_ACT_SHOT;
+	}
+
+	return TC_ACT_OK;
+}
+
+SEC("tc")
+int geneve_get_tunnel_src(struct __sk_buff *skb)
+{
+	int ret;
+	struct bpf_tunnel_key key;
+	struct tun_opts_raw opts;
+	int expected_opts_len;
+	__u32 index = 0;
+	__u32 *local_ip = NULL;
+
+	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
+	if (!local_ip) {
+		log_err(-1);
+		return TC_ACT_SHOT;
+	}
+
+	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
+	if (ret < 0) {
+		log_err(ret);
+		return TC_ACT_SHOT;
+	}
+
+	ret = bpf_skb_get_tunnel_opt(skb, &opts, sizeof(opts));
+	if (ret < 0) {
+		log_err(ret);
+		return TC_ACT_SHOT;
+	}
+
+	expected_opts_len = *local_ip % 2 ? GENEVE_OPTS_LEN1 : GENEVE_OPTS_LEN0;
+	if (key.local_ipv4 != *local_ip || ret != expected_opts_len) {
+		bpf_printk("geneve key %d local ip 0x%x remote ip 0x%x opts_len %d\n",
+			   key.tunnel_id, key.local_ipv4,
+			   key.remote_ipv4, ret);
+		bpf_printk("local_ip 0x%x\n", *local_ip);
+		log_err(ret);
+		return TC_ACT_SHOT;
+	}
+
+	return TC_ACT_OK;
+}
+
 SEC("tc")
 int vxlan_set_tunnel_dst(struct __sk_buff *skb)
 {
-- 
2.37.3

