Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAA44E4345
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 16:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbiCVPos (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 11:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbiCVPor (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 11:44:47 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB905E14C
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 08:43:18 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o8so12905202pgf.9
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 08:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=siDI8QW4Z3Xr8UOvjjEK4iOqz9aVw8LFlSZ2bLQHLtg=;
        b=I3LwXSoepaR7L51Ecrh+JF/wVt4erJSiMtDDQ9lRBOOKYZsIVHICl37+eVEyF4j3kG
         BwpVyETrWmypEB5JulWBzm42HoaaoaT44sldtsWAUzhLK9+VshENBI+NvWlZuhyXHRfj
         enaXN7iMu0NM0E6+8y4vc2SDVzOyOfj3TVRzpohDCGjCQIVg+WldwWgkaVBpee89TXw7
         tDUJDTvHfUCoKlvZ9pvzaA+gNb6xsamY1HDz2NfSbdpyBfTmXG/EiJ4oRZ2z5SeY5zZz
         D9qokiXaciLJfz/b0OA3cp2WmvfvJP8vJdLq/P+doemB86ODbkyB6WG9tCiIBpGWoBAw
         COuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=siDI8QW4Z3Xr8UOvjjEK4iOqz9aVw8LFlSZ2bLQHLtg=;
        b=kcEfnlNoBvATZPnEN5pdMkrnFF3MeKibIwBiz69784x1TXrf9M0xsz+5dpv8zNvpzA
         xnfp7EUh1ZpalefSsVjYq/yjlQ4fksZf38OIseqPRNYxZ8WgliiHvG6ZT6DgbaOObkwV
         wpZi6wYWKGIhyKTEdrGX3z8veuoEhDuVK6Fbdyuyxr6xduK5VDb758ISGHNF1gb8vsMO
         qe9Z40iVgr0ZWD0cTfXrbWYwA8JH+ptLpSWBDzVZxtmxRRycRoRqVrW4fQJSPhPsdgDZ
         mYECdlzr4MrWzhyTk0FiLheY96rUj0PfTUr0InhToYju/7bqn6xXnsBbMpWZCimGSNJK
         +haw==
X-Gm-Message-State: AOAM531Q4Wskb7qQTUiRgSjXvYHFe3oN+3PU7t5StoyZZJ5Nep48FYlT
        VfekQ3+C39oFMWTtuvUH6yPt+A==
X-Google-Smtp-Source: ABdhPJz7L7r5MMGh6g68DdpR0SwM2Saqb37LYmqypUCUQgP8CJyzXi9Ajx+8hbRj43e753a2kBBFBA==
X-Received: by 2002:a63:1918:0:b0:382:1cfa:eefa with SMTP id z24-20020a631918000000b003821cfaeefamr19478274pgl.510.1647963798079;
        Tue, 22 Mar 2022 08:43:18 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:483a:72c0:3435:f390:36c7:be7a])
        by smtp.gmail.com with ESMTPSA id d14-20020a056a0024ce00b004f7281cda21sm24719158pfv.167.2022.03.22.08.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 08:43:17 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, andrii@kernel.org,
        "kaixi.fan" <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v2 3/3] selftests/bpf: add ipv6 vxlan tunnel source testcase
Date:   Tue, 22 Mar 2022 23:42:31 +0800
Message-Id: <20220322154231.55044-4-fankaixi.li@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220322154231.55044-1-fankaixi.li@bytedance.com>
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "kaixi.fan" <fankaixi.li@bytedance.com>

Add two ipv6 address on underlay nic interface, and use bpf code to
configure the secondary ipv6 address as the vxlan tunnel source ip.
Then check ping6 result and log contains the correct tunnel source
ip.

Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>
---
 .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh    | 43 ++++++++++++++--
 2 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index ab635c55ae9b..56e1aee0ba5a 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -740,4 +740,55 @@ int _vxlan_get_tunnel_src(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
+SEC("ip6vxlan_set_tunnel_src")
+int _ip6vxlan_set_tunnel_src(struct __sk_buff *skb)
+{
+	struct bpf_tunnel_key key;
+	int ret;
+
+	__builtin_memset(&key, 0x0, sizeof(key));
+	key.local_ipv6[3] = bpf_htonl(0xbb); /* ::bb */
+	key.remote_ipv6[3] = bpf_htonl(0x11); /* ::11 */
+	key.tunnel_id = 22;
+	key.tunnel_tos = 0;
+	key.tunnel_ttl = 64;
+
+	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
+				     BPF_F_TUNINFO_IPV6);
+	if (ret < 0) {
+		ERROR(ret);
+		return TC_ACT_SHOT;
+	}
+
+	return TC_ACT_OK;
+}
+
+SEC("ip6vxlan_get_tunnel_src")
+int _ip6vxlan_get_tunnel_src(struct __sk_buff *skb)
+{
+	char fmt[] = "key %d remote ip6 ::%x source ip6 ::%x\n";
+	char fmt2[] = "label %x\n";
+	struct bpf_tunnel_key key;
+	int ret;
+
+	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
+				     BPF_F_TUNINFO_IPV6);
+	if (ret < 0) {
+		ERROR(ret);
+		return TC_ACT_SHOT;
+	}
+
+	bpf_trace_printk(fmt, sizeof(fmt),
+			 key.tunnel_id, key.remote_ipv6[3], key.local_ipv6[3]);
+	bpf_trace_printk(fmt2, sizeof(fmt2),
+			 key.tunnel_label);
+
+	if (bpf_ntohl(key.local_ipv6[3]) != 0xbb) {
+		ERROR(ret);
+		return TC_ACT_SHOT;
+	}
+
+	return TC_ACT_OK;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index b6923392bf16..4b7bf9c7bbe1 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -191,12 +191,15 @@ add_ip6vxlan_tunnel()
 	ip netns exec at_ns0 ip link set dev veth0 up
 	#ip -4 addr del 172.16.1.200 dev veth1
 	ip -6 addr add dev veth1 ::22/96
+	if [ "$2" == "2" ]; then
+		ip -6 addr add dev veth1 ::bb/96
+	fi
 	ip link set dev veth1 up
 
 	# at_ns0 namespace
 	ip netns exec at_ns0 \
 		ip link add dev $DEV_NS type $TYPE id 22 dstport 4789 \
-		local ::11 remote ::22
+		local ::11 remote $1
 	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
 	ip netns exec at_ns0 ip link set dev $DEV_NS up
 
@@ -231,7 +234,7 @@ add_ip6geneve_tunnel()
 	# at_ns0 namespace
 	ip netns exec at_ns0 \
 		ip link add dev $DEV_NS type $TYPE id 22 \
-		remote ::22     # geneve has no local option
+		remote ::22    # geneve has no local option
 	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
 	ip netns exec at_ns0 ip link set dev $DEV_NS up
 
@@ -394,7 +397,7 @@ test_ip6erspan()
 
 	check $TYPE
 	config_device
-	add_ip6erspan_tunnel $1
+	add_ip6erspan_tunnel
 	attach_bpf $DEV ip4ip6erspan_set_tunnel ip4ip6erspan_get_tunnel
 	ping6 $PING_ARG ::11
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
@@ -441,7 +444,7 @@ test_ip6vxlan()
 
 	check $TYPE
 	config_device
-	add_ip6vxlan_tunnel
+	add_ip6vxlan_tunnel ::22 1
 	ip link set dev veth1 mtu 1500
 	attach_bpf $DEV ip6vxlan_set_tunnel ip6vxlan_get_tunnel
 	# underlay
@@ -690,6 +693,34 @@ test_vxlan_tunsrc()
         echo -e ${GREEN}"PASS: ${TYPE}_tunsrc"${NC}
 }
 
+test_ip6vxlan_tunsrc()
+{
+	TYPE=vxlan
+	DEV_NS=ip6vxlan00
+	DEV=ip6vxlan11
+	ret=0
+
+	check $TYPE
+	config_device
+	add_ip6vxlan_tunnel ::bb 2
+	ip link set dev veth1 mtu 1500
+	attach_bpf $DEV ip6vxlan_set_tunnel_src ip6vxlan_get_tunnel_src
+	# underlay
+	ping6 $PING_ARG ::11
+	# ip4 over ip6
+	ping $PING_ARG 10.1.1.100
+	check_err $?
+	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
+	check_err $?
+	cleanup
+
+	if [ $ret -ne 0 ]; then
+                echo -e ${RED}"FAIL: ip6${TYPE}_tunsrc"${NC}
+                return 1
+        fi
+        echo -e ${GREEN}"PASS: ip6${TYPE}_tunsrc"${NC}
+}
+
 attach_bpf()
 {
 	DEV=$1
@@ -815,6 +846,10 @@ bpf_tunnel_test()
 	test_vxlan_tunsrc
 	errors=$(( $errors + $? ))
 
+	echo "Testing IP6VXLAN tunnel source..."
+	test_ip6vxlan_tunsrc
+	errors=$(( $errors + $? ))
+
 	return $errors
 }
 
-- 
2.24.3 (Apple Git-128)

