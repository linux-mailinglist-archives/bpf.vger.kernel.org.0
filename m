Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8624E4344
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 16:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbiCVPon (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 11:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbiCVPom (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 11:44:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFA18C7EA
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 08:43:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c23so4698101plo.0
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Gf4PFN+q2sI9J4U8Vm/W7BrTxMyTJ2z0eZIbeg7XTY=;
        b=hJs7H6DzCc+L7VOuv4znwiD64iHm7U02s/EXSDHe1xn/6LlyCDiT0LXvM+V81Cj5bg
         Hp0zqWk1SgK4AdiObde4cqKdryAvJVLja7YS2UAkZVO70J4Ege0bmqqAFN3UaC4g8sc4
         KCEK/EebsEihKZw9GOLzRUWCN75aJvlTmaLnbFY74s+j65U/Jc9PMMVgiyTIm6otdhop
         JheVFbPa5xbpJg4SZAXxoliAbbp5fQ2sHBIWrW0RMPHpU4A93iX0PFs9it7mhdo6TGSh
         LgTkm0IXxZk93+huhDC2DzTX3mC7/h+p7Vq8F6e4K4NLh9s/sOiUxJdNFoGwhdVd5vFZ
         qDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Gf4PFN+q2sI9J4U8Vm/W7BrTxMyTJ2z0eZIbeg7XTY=;
        b=YEFaJKlsnrdsnD1fLOIYUTl3tcNHNIGcEcXuA1/kghVac0/YIr4DZr7NtTi/vc52Li
         jSasIzZIKP1bTiblVmPutCrXkOHPZgc/webufTWAvtReT7Gw7f9Wst1TjsUxvipzJ+rj
         GUUYUyPzwTc2wSpfr7K7ShLtbAu06yEi90y3wGSo6ZJ5MUG95DtQYX79LHFHdW0fmI4b
         9catS0IygrbU5M1Q1Cfz5Nz1fKY2v3uEa0B//sjzJtrGjNylgsFgDNKRgWmVEOm74oHO
         px5rPhKzxUIPsxGEhm1mZEXiZi5VpEPgIPlwrqtBWAKxeJ4Y1j2poajPbJAR/3owReru
         F86w==
X-Gm-Message-State: AOAM530R3dtunSrJqE6th5QC4UTBNRUfX9Kw5LU34Vi2OMmRJr1WCh4k
        y//qDwsNq1B0cMiLO2Hrr3VQm/KV2wDJNg==
X-Google-Smtp-Source: ABdhPJyUO3IPPiKHS6l52Vrb6XaYeyT9/pjnujVNDOyzxurlL0Df1CeYFiLacc4hJBquBzdfYh2tXA==
X-Received: by 2002:a17:903:2348:b0:154:dd0:aba8 with SMTP id c8-20020a170903234800b001540dd0aba8mr19330499plh.51.1647963794166;
        Tue, 22 Mar 2022 08:43:14 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:483a:72c0:3435:f390:36c7:be7a])
        by smtp.gmail.com with ESMTPSA id d14-20020a056a0024ce00b004f7281cda21sm24719158pfv.167.2022.03.22.08.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 08:43:13 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, andrii@kernel.org,
        "kaixi.fan" <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v2 2/3] selftests/bpf: add ipv4 vxlan tunnel source testcase
Date:   Tue, 22 Mar 2022 23:42:30 +0800
Message-Id: <20220322154231.55044-3-fankaixi.li@bytedance.com>
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

Vxlan tunnel is chosen to test bpf code could configure tunnel
source ipv4 address. It's sufficient to prove that other types
tunnels could also do it.
In the vxlan tunnel testcase, two underlay ipv4 addresses
are configured on veth device in root namespace. Test bpf kernel
code would configure the secondary ipv4 address as the tunnel
source ip.

Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>
---
 .../selftests/bpf/progs/test_tunnel_kern.c    | 64 +++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh    | 37 ++++++++++-
 2 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index ef0dde83b85a..ab635c55ae9b 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -676,4 +676,68 @@ int _xfrm_get_state(struct __sk_buff *skb)
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
+	if (key.local_ipv4 != 0xac100114) {
+		ERROR(ret);
+		return TC_ACT_SHOT;
+	}
+	return TC_ACT_OK;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index ca1372924023..b6923392bf16 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -161,10 +161,15 @@ add_vxlan_tunnel()
 	# on L3 packet, as a result not applying to ARP packets,
 	# causing errors at get_tunnel_{key/opt}.
 
+	# add a secondary ip
+	if [ "$2" == "2" ]; then
+		ip addr add dev veth1 172.16.1.20/24
+	fi
+
 	# at_ns0 namespace
 	ip netns exec at_ns0 \
 		ip link add dev $DEV_NS type $TYPE \
-		id 2 dstport 4789 gbp remote 172.16.1.200
+		id 2 dstport 4789 gbp remote $1
 	ip netns exec at_ns0 \
 		ip link set dev $DEV_NS address 52:54:00:d9:01:00 up
 	ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
@@ -412,7 +417,7 @@ test_vxlan()
 
 	check $TYPE
 	config_device
-	add_vxlan_tunnel
+	add_vxlan_tunnel 172.16.1.200 1
 	attach_bpf $DEV vxlan_set_tunnel vxlan_get_tunnel
 	ping $PING_ARG 10.1.1.100
 	check_err $?
@@ -661,6 +666,30 @@ test_xfrm_tunnel()
 	echo -e ${GREEN}"PASS: xfrm tunnel"${NC}
 }
 
+test_vxlan_tunsrc()
+{
+	TYPE=vxlan
+	DEV_NS=vxlan00
+	DEV=vxlan11
+	ret=0
+
+	check $TYPE
+	config_device
+	add_vxlan_tunnel 172.16.1.20 2
+	attach_bpf $DEV vxlan_set_tunnel_src vxlan_get_tunnel_src
+	ping $PING_ARG 10.1.1.100
+	check_err $?
+	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
+	check_err $?
+	cleanup
+
+	if [ $ret -ne 0 ]; then
+                echo -e ${RED}"FAIL: ${TYPE}_tunsrc"${NC}
+                return 1
+        fi
+        echo -e ${GREEN}"PASS: ${TYPE}_tunsrc"${NC}
+}
+
 attach_bpf()
 {
 	DEV=$1
@@ -782,6 +811,10 @@ bpf_tunnel_test()
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

