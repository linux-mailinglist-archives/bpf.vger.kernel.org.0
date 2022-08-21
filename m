Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B85C59B567
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 18:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiHUQSK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 12:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiHUQSJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 12:18:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E7A14088
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 09:18:08 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so3456940wmk.3
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HpLye7gV/KN4ONfts84OhQjFW6Z3RGrtIVbLKn9RpIw=;
        b=T3u5ZiwtYm0JMw07S9yYrdcMYqD6WpdT2X9G4DMOj2C0BmF26o+nMQJLnuLHUnJNB0
         ObAu0lxYYYp1ZEvxzhzzdVHtos1gZqIx30Vvsu1n2Q7EzJlahLbVJOa7XR/0y3GAL3Nc
         DVB2y93Gtc9sPt3ki4lbNPo+Pix3dkkXsmMIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HpLye7gV/KN4ONfts84OhQjFW6Z3RGrtIVbLKn9RpIw=;
        b=dF0Hnq7ZlqE/4FSb9NbFVJ0whd0LtTG5y9qV2KAIYqTcRyVfFQh7eft/1BmfpekXpi
         pgY9azzrrsfD+4vlg5gAm+xHFlL7pd7VbhneLfiFVWcfS1ioDqJVC1a+HTox/Q7eVuwA
         khmeF6+44Bw9nR8Re4RpUIAVd+0gTyfZIzJaY0fudvj4o0VLPespqunPE6Aftu9vjGc5
         kTRsvpBkc7WoUtC6knxGMQO03lYNJjH1Cgxp+p2vZVFnfskm0XDJ1StgJd534PngEzAi
         GwQ8TkxR8moZ3UOo4Bk/aSh4aAd1V3aZAUy4OM+qFhlrkAcDPsnQ/wXPQMO/0FlCGsqn
         T83w==
X-Gm-Message-State: ACgBeo0AeFgjK8VM9OhtXAy/5ePFztUP0LQvvIOUMikGTwwgfosGlMvs
        LtgPpCVizlQUGD41Lr8qruYmIjxGjp+T8zyjFabRedpVo5ZxfxtKfSFnGheZY5NW7fsn2gA5Co+
        6eCjbFOS/snCKKThjCZHBxLDKZLiH4fWDNLQbh6/SDXhON0N+0bqG132F2MtOmpnsDKDBOF7w
X-Google-Smtp-Source: AA6agR73jRAScEikEqp76NM/gQslSL0n14m/V+hG+cDCm32cz9b6v9zHtTwLgXkBf30tWavNwpbRlA==
X-Received: by 2002:a1c:7916:0:b0:3a6:3540:5b3c with SMTP id l22-20020a1c7916000000b003a635405b3cmr7109220wme.178.1661098686536;
        Sun, 21 Aug 2022 09:18:06 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003a32251c3f9sm17659002wmg.5.2022.08.21.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 09:18:06 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add geneve with bpf_skb_set_var_tunnel_opt test-case to test_progs
Date:   Sun, 21 Aug 2022 19:17:40 +0300
Message-Id: <20220821161740.166682-4-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821161740.166682-1-shmulik.ladkani@gmail.com>
References: <20220821161740.166682-1-shmulik.ladkani@gmail.com>
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

The test also checks variable length tunnel option assignment using
bpf_skb_set_var_tunnel_opt.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
 .../selftests/bpf/prog_tests/test_tunnel.c    | 108 ++++++++++++++++
 .../selftests/bpf/progs/test_tunnel_kern.c    | 118 ++++++++++++++++++
 2 files changed, 226 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 3ccff66355b8..48e65c95328f 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -87,6 +87,8 @@
 #define VXLAN_TUNL_DEV1 "vxlan11"
 #define IP6VXLAN_TUNL_DEV0 "ip6vxlan00"
 #define IP6VXLAN_TUNL_DEV1 "ip6vxlan11"
+#define GENEVE_TUNL_DEV0 "geneve00"
+#define GENEVE_TUNL_DEV1 "geneve11"
 
 #define PING_ARGS "-i 0.01 -c 3 -w 10 -q"
 
@@ -127,6 +129,38 @@ static void cleanup(void)
 	SYS_NOFAIL("ip link del veth1 2> /dev/null");
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
@@ -242,6 +276,79 @@ static int attach_tc_prog(struct bpf_tc_hook *hook, int igr_fd, int egr_fd)
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
@@ -402,6 +509,7 @@ static void *test_tunnel_run_tests(void *arg)
 
 	RUN_TEST(vxlan_tunnel);
 	RUN_TEST(ip6vxlan_tunnel);
+	RUN_TEST(geneve_tunnel);
 
 	cleanup();
 
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 17f2f325b3f3..f724b1ce48d8 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -23,6 +23,8 @@
 
 #define log_err(__ret) bpf_printk("ERROR line:%d ret:%d\n", __LINE__, __ret)
 
+#define GENEVE_DYN_OPTS_SIZE 64
+
 struct geneve_opt {
 	__be16	opt_class;
 	__u8	type;
@@ -285,6 +287,122 @@ int ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
+SEC("tc")
+int geneve_set_tunnel_dst(struct __sk_buff *skb)
+{
+	int ret;
+	struct bpf_tunnel_key key;
+	__u8 opts[GENEVE_DYN_OPTS_SIZE];
+	__u32 index = 0;
+	__u32 *local_ip = NULL;
+	int opts_len;
+
+	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
+	if (!local_ip) {
+		log_err(ret);
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
+	__builtin_memset(opts, 0x0, sizeof(opts));
+	/* dynamic number of empty geneve options (4 bytes each).
+	 * total len capped at sizeof(opts) and is multiple of 4
+	 */
+	opts_len = (skb->len % sizeof(opts)) & ~(sizeof(__u32) - 1);
+	ret = bpf_skb_set_var_tunnel_opt(skb, opts, sizeof(opts), opts_len);
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
+		log_err(ret);
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
+	__u8 opts[GENEVE_DYN_OPTS_SIZE];
+	int expected_opts_len;
+	__u32 index = 0;
+	__u32 *local_ip = NULL;
+
+	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
+	if (!local_ip) {
+		log_err(ret);
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
+	expected_opts_len = (skb->len % sizeof(opts)) & ~(sizeof(__u32) - 1);
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
2.37.2

