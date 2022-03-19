Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8A84DE816
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 14:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbiCSNH1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 09:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242331AbiCSNH0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 09:07:26 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBDD25DAB0
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 06:06:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q1-20020a17090a4f8100b001c6575ae105so7265276pjh.0
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=muKmcBmqTBILlMxPHUMzF1gSqPvhx98DfMtjuCdy0fk=;
        b=BLJjmyoHxZhLDXcw1Pjnl6iKumxde35dfz0G7gRWVOaLnylaB+cUVLKcxeRHFXmbNb
         s0bgyu7WF7bW08rvhUMzezzxxdKXnYWKv9UkMXzSZ/8zw8X1lgRfcOkHxakfcEGUCgPH
         +OzY/luxFZs79X/1Ay3u7HPm4deEa1pZ4j+7n2f+1Hf6RVKq13i57b0db9qVwTea0sgW
         jyg9t8lCOWTbpg6/Iya+OQk9QPFJAAnikFuTfj1pQaq6ZPd6CtOqMqrhdJyjeMWrIOk3
         JuzQFcpsOnYmE8OYXQ98ZsSoS0xjDoLoSGTfID3dhMa3R4fyN1Q5TLvWPqCHMY8cxl4p
         0bnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=muKmcBmqTBILlMxPHUMzF1gSqPvhx98DfMtjuCdy0fk=;
        b=pi8sM/mbIxJn35i3z6m086dBm3zStajohuM1PVtFgbr/VAouz2kxpU9MS41LnYNwSX
         UgmmlBZKw78BJhovpP43SNY3pPT8feQxCB3rU8cOW09gFcPeqED4S1BsvUqx5ZBzW25S
         LZsX8RgyCvQhV83P5UGkQ/oyX/sqiq8Jrd4hSiJa/+yMI17EoHtabdbCp1eZ/gwQPmK3
         oe3TumBVv0oQvlmk3MWFXt4Lo98x04S4PhbOEbmanIouyWlZ5sjIKc2LqT4m0Jlx3NgW
         Bbgup3LKfOXtZcKjWKF/3ro1Ziv1HULrLe7LyeOus/x5g5s7c1o6VGc6WNf+5Oy6cPDc
         VpvQ==
X-Gm-Message-State: AOAM531hVkEXbY8J8ZflCQ1tqEIqKOmRKj17jQhsabgT+Eozg7F2melf
        PE0UyAuy1xEGQJHpJdbPMZKxVg==
X-Google-Smtp-Source: ABdhPJxw8Hr3E001S/jaTszlo/U+nx6aEx7nkWJ5Wbe7F97wTAHLPKa4bslu1mq1DQsqDD3cqtDTXw==
X-Received: by 2002:a17:902:cf05:b0:14d:5249:3b1f with SMTP id i5-20020a170902cf0500b0014d52493b1fmr4102915plg.135.1647695165120;
        Sat, 19 Mar 2022 06:06:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:483a:72c0:bdf5:8ebe:6be8:a257])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a000acb00b004f35ee129bbsm14007797pfl.140.2022.03.19.06.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 06:06:04 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     john.fastabend@gmail.com, kafai@fb.com, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        "kaixi.fan" <fankaixi.li@bytedance.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: add ipv6 vxlan tunnel source testcase
Date:   Sat, 19 Mar 2022 21:05:38 +0800
Message-Id: <20220319130538.55741-4-fankaixi.li@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220319130538.55741-1-fankaixi.li@bytedance.com>
References: <20220319130538.55741-1-fankaixi.li@bytedance.com>
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
 .../selftests/bpf/progs/test_tunnel_kern.c    | 46 ++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh    | 71 +++++++++++++++----
 2 files changed, 105 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 4a39556ef609..67cb7ca3e083 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -736,4 +736,50 @@ int _vxlan_get_tunnel_src(struct __sk_buff *skb)
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
+	return TC_ACT_OK;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 62ef5c998b6a..a0f9a5c5e0a5 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -67,6 +67,11 @@ add_second_ip()
   ip addr add dev veth1 172.16.1.20/24
 }
 
+add_second_ip6()
+{
+  ip addr add dev veth1 ::bb/96
+}
+
 add_gre_tunnel()
 {
 	# at_ns0 namespace
@@ -94,7 +99,7 @@ add_ip6gretap_tunnel()
 	# at_ns0 namespace
 	ip netns exec at_ns0 \
 		ip link add dev $DEV_NS type $TYPE seq flowlabel 0xbcdef key 2 \
-		local ::11 remote ::22
+		local ::11 remote $REMOTE_IP6
 
 	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
 	ip netns exec at_ns0 ip addr add dev $DEV_NS fc80::100/96
@@ -143,7 +148,7 @@ add_ip6erspan_tunnel()
 	if [ "$1" == "v1" ]; then
 		ip netns exec at_ns0 \
 		ip link add dev $DEV_NS type $TYPE seq key 2 \
-		local ::11 remote ::22 \
+		local ::11 remote $REMOTE_IP6 \
 		erspan_ver 1 erspan 123
 	else
 		ip netns exec at_ns0 \
@@ -196,7 +201,7 @@ add_ip6vxlan_tunnel()
 	# at_ns0 namespace
 	ip netns exec at_ns0 \
 		ip link add dev $DEV_NS type $TYPE id 22 dstport 4789 \
-		local ::11 remote ::22
+		local ::11 remote $REMOTE_IP6
 	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
 	ip netns exec at_ns0 ip link set dev $DEV_NS up
 
@@ -231,7 +236,7 @@ add_ip6geneve_tunnel()
 	# at_ns0 namespace
 	ip netns exec at_ns0 \
 		ip link add dev $DEV_NS type $TYPE id 22 \
-		remote ::22     # geneve has no local option
+		remote $REMOTE_IP6    # geneve has no local option
 	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
 	ip netns exec at_ns0 ip link set dev $DEV_NS up
 
@@ -266,7 +271,7 @@ add_ip6tnl_tunnel()
 	# at_ns0 namespace
 	ip netns exec at_ns0 \
 		ip link add dev $DEV_NS type $TYPE \
-		local ::11 remote ::22
+		local ::11 remote $REMOTE_IP6
 	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
 	ip netns exec at_ns0 ip addr add dev $DEV_NS 1::11/96
 	ip netns exec at_ns0 ip link set dev $DEV_NS up
@@ -307,12 +312,13 @@ test_ip6gre()
 	TYPE=ip6gre
 	DEV_NS=ip6gre00
 	DEV=ip6gre11
+	REMOTE_IP6=::22
 	ret=0
 
 	check $TYPE
 	config_device
 	# reuse the ip6gretap function
-	add_ip6gretap_tunnel
+	add_ip6gretap_tunnel $REMOTE_IP6
 	attach_bpf $DEV ip6gretap_set_tunnel ip6gretap_get_tunnel
 	# underlay
 	ping6 $PING_ARG ::11
@@ -337,11 +343,12 @@ test_ip6gretap()
 	TYPE=ip6gretap
 	DEV_NS=ip6gretap00
 	DEV=ip6gretap11
+	REMOTE_IP6=::22
 	ret=0
 
 	check $TYPE
 	config_device
-	add_ip6gretap_tunnel
+	add_ip6gretap_tunnel $REMOTE_IP6
 	attach_bpf $DEV ip6gretap_set_tunnel ip6gretap_get_tunnel
 	# underlay
 	ping6 $PING_ARG ::11
@@ -390,11 +397,12 @@ test_ip6erspan()
 	TYPE=ip6erspan
 	DEV_NS=ip6erspan00
 	DEV=ip6erspan11
+	REMOTE_IP6=::22
 	ret=0
 
 	check $TYPE
 	config_device
-	add_ip6erspan_tunnel $1
+	add_ip6erspan_tunnel $1 $REMOTE_IP6
 	attach_bpf $DEV ip4ip6erspan_set_tunnel ip4ip6erspan_get_tunnel
 	ping6 $PING_ARG ::11
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
@@ -438,11 +446,12 @@ test_ip6vxlan()
 	TYPE=vxlan
 	DEV_NS=ip6vxlan00
 	DEV=ip6vxlan11
+	REMOTE_IP6=::22
 	ret=0
 
 	check $TYPE
 	config_device
-	add_ip6vxlan_tunnel
+	add_ip6vxlan_tunnel $REMOTE_IP6
 	ip link set dev veth1 mtu 1500
 	attach_bpf $DEV ip6vxlan_set_tunnel ip6vxlan_get_tunnel
 	# underlay
@@ -490,11 +499,12 @@ test_ip6geneve()
 	TYPE=geneve
 	DEV_NS=ip6geneve00
 	DEV=ip6geneve11
+	REMOTE_IP6=::22
 	ret=0
 
 	check $TYPE
 	config_device
-	add_ip6geneve_tunnel
+	add_ip6geneve_tunnel $REMOTE_IP6
 	attach_bpf $DEV ip6geneve_set_tunnel ip6geneve_get_tunnel
 	ping $PING_ARG 10.1.1.100
 	check_err $?
@@ -539,11 +549,12 @@ test_ipip6()
 	TYPE=ip6tnl
 	DEV_NS=ipip6tnl00
 	DEV=ipip6tnl11
+	REMOTE_IP6=::22
 	ret=0
 
 	check $TYPE
 	config_device
-	add_ip6tnl_tunnel
+	add_ip6tnl_tunnel $REMOTE_IP6
 	ip link set dev veth1 mtu 1500
 	attach_bpf $DEV ipip6_set_tunnel ipip6_get_tunnel
 	# underlay
@@ -567,11 +578,12 @@ test_ip6ip6()
 	TYPE=ip6tnl
 	DEV_NS=ip6ip6tnl00
 	DEV=ip6ip6tnl11
+	REMOTE_IP6=::22
 	ret=0
 
 	check $TYPE
 	config_device
-	add_ip6tnl_tunnel
+	add_ip6tnl_tunnel $REMOTE_IP6
 	ip link set dev veth1 mtu 1500
 	attach_bpf $DEV ip6ip6_set_tunnel ip6ip6_get_tunnel
 	# underlay
@@ -693,6 +705,36 @@ test_vxlan_tunsrc()
         echo -e ${GREEN}"PASS: $TYPE"${NC}
 }
 
+test_ip6vxlan_tunsrc()
+{
+	TYPE=vxlan
+	DEV_NS=ip6vxlan00
+	DEV=ip6vxlan11
+	REMOTE_IP6=::bb
+	ret=0
+
+	check $TYPE
+	config_device
+	add_second_ip6
+	add_ip6vxlan_tunnel $REMOTE_IP6
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
+                echo -e ${RED}"FAIL: ip6$TYPE"${NC}
+                return 1
+        fi
+        echo -e ${GREEN}"PASS: ip6$TYPE"${NC}
+}
+
 attach_bpf()
 {
 	DEV=$1
@@ -818,6 +860,11 @@ bpf_tunnel_test()
 	test_vxlan_tunsrc
 	errors=$(( $errors + $? ))
 
+
+	echo "Testing IP6VXLAN tunnel source..."
+	test_ip6vxlan_tunsrc
+	errors=$(( $errors + $? ))
+
 	return $errors
 }
 
-- 
2.24.3 (Apple Git-128)

