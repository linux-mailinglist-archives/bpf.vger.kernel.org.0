Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184814DE818
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 14:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiCSNHY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 09:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243015AbiCSNHX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 09:07:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA8925DABF
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 06:06:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id o26so7012999pgb.8
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 06:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vLh8VB2FgOtuTNgCu+bhu5c/jRPPojDpdYo5s0iuYlQ=;
        b=D0ebZh4OMVWcr/tkFFdMXCuZ6PWgkqEuCjiWgyM4TvqwofTIj/PJS6KP8gHPvLf57T
         P0JpBrYovIG0cF2+vI4k1DeIyEVJN/BbYDIlqCvcVr1DiIMzHkfQAyHKMTamq6z568mk
         vf4G8n/3yxVAAK7FduUwAund+cP3098nuhKP9OdcfgSO+22FkAn0mr/NKCgjPnf6oLma
         e4TC5EvaezI7zQ8YC1m9hT/Ak3iLRhJtJd3owFlLNM3vyMwN4/lHJ2FR6lHBp6B4op1T
         oG7PIanXHCHeFR+y7oEjjZecOSANTbQ+EK7/DP9PirMsFI02dQ9V+cj0PAonKW1Os6Az
         TsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vLh8VB2FgOtuTNgCu+bhu5c/jRPPojDpdYo5s0iuYlQ=;
        b=wB6jQLAYYk8TSQx11yR/w8Ptl/8oD3Da+bw/S2dHz2Rwh49RHM0rfqKTGvx+NfmOTh
         4v9bMFv+0hbhnyeDohFHWOoXPnS8bPrODdgxKbwQb3OYobz96QLFWanv4A8wnk7unSyz
         A2oG2pe8DTW86CRCsPg5VJztmhvzLQcxwv8tNHGC8PJ8pS1hPsOr5FUau7WLB7x1f52C
         kbv+Vt+vKf6C38LgwqjU02Y3ibrUEkacYpfquzgTfwsAL0v+7k0RytZL65i+ieQuN2Jf
         engcFOZOTWqVJGwjKFl59exenapY8XFVrnNET/5BpYhdD5Qm5yVZpofLK8/RkiyoPvhI
         niIw==
X-Gm-Message-State: AOAM530XPWoa3EN3ossKXCUEj5YcUeER8MK9vCRdNObH52Tdd4yOWttw
        b3mY8aoJrQ2oBaWZdAgDfnl8uQ==
X-Google-Smtp-Source: ABdhPJwLTHMayABpo6L6GVb/JygfZyURFgCIqBgcO75LZNXOrMZYj2gRiIcmYs/vWdFtVnjUKi/i4w==
X-Received: by 2002:a62:402:0:b0:4f7:81a3:7c47 with SMTP id 2-20020a620402000000b004f781a37c47mr14694257pfe.9.1647695161004;
        Sat, 19 Mar 2022 06:06:01 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:483a:72c0:bdf5:8ebe:6be8:a257])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a000acb00b004f35ee129bbsm14007797pfl.140.2022.03.19.06.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 06:06:00 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     john.fastabend@gmail.com, kafai@fb.com, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        "kaixi.fan" <fankaixi.li@bytedance.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: add ipv4 vxlan tunnel source testcase
Date:   Sat, 19 Mar 2022 21:05:37 +0800
Message-Id: <20220319130538.55741-3-fankaixi.li@bytedance.com>
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

Vxlan tunnel is chosen to test bpf code could configure tunnel
source ipv4 address. It's sufficient to prove that other types
tunnels could also do it.
In the vxlan tunnel testcase, two underlay ipv4 addresses
are configured on veth device in root namespace. Test bpf kernel
code would configure the secondary ipv4 address as the tunnel
source ip.

Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>
---
 .../selftests/bpf/progs/test_tunnel_kern.c    | 60 +++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh    | 38 +++++++++++-
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index ef0dde83b85a..4a39556ef609 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -676,4 +676,64 @@ int _xfrm_get_state(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
+SEC("vxlan_set_tunnel_src")
+int _vxlan_set_tunnel_src(struct __sk_buff *skb)
+{
+	int ret;
+	struct bpf_tunnel_key key;
+	struct vxlan_metadata md;
+
+	__builtin_memset(&key, 0x0, sizeof(key));
+	key.local_ipv4 = 0xac100114; /* 172.16.1.20 */
+	key.remote_ipv4 = 0xac100164; /* 172.16.1.100 */
+	key.tunnel_id = 2;
+	key.tunnel_tos = 0;
+	key.tunnel_ttl = 64;
+
+	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
+				     BPF_F_ZERO_CSUM_TX);
+	if (ret < 0) {
+		ERROR(ret);
+		return TC_ACT_SHOT;
+	}
+
+	md.gbp = 0x800FF; /* Set VXLAN Group Policy extension */
+	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
+	if (ret < 0) {
+		ERROR(ret);
+		return TC_ACT_SHOT;
+	}
+
+	return TC_ACT_OK;
+}
+
+SEC("vxlan_get_tunnel_src")
+int _vxlan_get_tunnel_src(struct __sk_buff *skb)
+{
+	int ret;
+	struct bpf_tunnel_key key;
+	struct vxlan_metadata md;
+	char fmt[] = "key %d remote ip 0x%x source ip 0x%x\n";
+	char fmt2[] = "vxlan gbp 0x%x\n";
+
+	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
+	if (ret < 0) {
+		ERROR(ret);
+		return TC_ACT_SHOT;
+	}
+
+	ret = bpf_skb_get_tunnel_opt(skb, &md, sizeof(md));
+	if (ret < 0) {
+		ERROR(ret);
+		return TC_ACT_SHOT;
+	}
+
+	bpf_trace_printk(fmt, sizeof(fmt),
+			 key.tunnel_id, key.remote_ipv4, key.local_ipv4);
+	bpf_trace_printk(fmt2, sizeof(fmt2),
+			 md.gbp);
+
+	return TC_ACT_OK;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index ca1372924023..62ef5c998b6a 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -62,6 +62,11 @@ config_device()
 	ip addr add dev veth1 172.16.1.200/24
 }
 
+add_second_ip()
+{
+  ip addr add dev veth1 172.16.1.20/24
+}
+
 add_gre_tunnel()
 {
 	# at_ns0 namespace
@@ -164,7 +169,7 @@ add_vxlan_tunnel()
 	# at_ns0 namespace
 	ip netns exec at_ns0 \
 		ip link add dev $DEV_NS type $TYPE \
-		id 2 dstport 4789 gbp remote 172.16.1.200
+		id 2 dstport 4789 gbp remote $REMOTE_IP
 	ip netns exec at_ns0 \
 		ip link set dev $DEV_NS address 52:54:00:d9:01:00 up
 	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
@@ -408,6 +413,7 @@ test_vxlan()
 	TYPE=vxlan
 	DEV_NS=vxlan00
 	DEV=vxlan11
+	REMOTE_IP=172.16.1.200
 	ret=0
 
 	check $TYPE
@@ -661,6 +667,32 @@ test_xfrm_tunnel()
 	echo -e ${GREEN}"PASS: xfrm tunnel"${NC}
 }
 
+test_vxlan_tunsrc()
+{
+	TYPE=vxlan
+	DEV_NS=vxlan00
+	DEV=vxlan11
+	REMOTE_IP=172.16.1.20
+	ret=0
+
+	check $TYPE
+	config_device
+	add_second_ip
+	add_vxlan_tunnel
+	attach_bpf $DEV vxlan_set_tunnel_src vxlan_get_tunnel_src
+	ping $PING_ARG 10.1.1.100
+	check_err $?
+	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
+	check_err $?
+	cleanup
+
+	if [ $ret -ne 0 ]; then
+                echo -e ${RED}"FAIL: $TYPE"${NC}
+                return 1
+        fi
+        echo -e ${GREEN}"PASS: $TYPE"${NC}
+}
+
 attach_bpf()
 {
 	DEV=$1
@@ -782,6 +814,10 @@ bpf_tunnel_test()
 	test_xfrm_tunnel
 	errors=$(( $errors + $? ))
 
+	echo "Testing VXLAN tunnel source..."
+	test_vxlan_tunsrc
+	errors=$(( $errors + $? ))
+
 	return $errors
 }
 
-- 
2.24.3 (Apple Git-128)

