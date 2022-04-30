Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B5C515B19
	for <lists+bpf@lfdr.de>; Sat, 30 Apr 2022 09:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379088AbiD3HxG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Apr 2022 03:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353132AbiD3HxE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Apr 2022 03:53:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7047060D9B
        for <bpf@vger.kernel.org>; Sat, 30 Apr 2022 00:49:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g8so6248133pfh.5
        for <bpf@vger.kernel.org>; Sat, 30 Apr 2022 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aklexUdGmBZ4BlpYptu3dL21oi8ybYbv/sEa2ECKEXQ=;
        b=LCL/JkgIJ7ZeDOYWEpWmDUEhTWysrZdqs/yfqB3/pbPfucSD3Hcg1iWweui7x0U2vD
         f0Vksbt4NFpeajjzf8etJJg7GJDeXACxrEG/SSRcq3UDlipFnW78Yc9iwiR5eMKGEhZ8
         FmmnnE/1D9vdgsr5ZUGtBq06top/CSH0HI7oMgFn0b2EBbKa7uu0x7N3Awek05GKMqfL
         r5oSfaa9XdLM44YvBJ2OsSFYXT1YUU4/rg7VoDfLbfq9ZxPfmdQLQF/dRP+zqKUE6pp+
         obDUjx7mVR6WFuIPeqXFozL4oyAUEF0BSkCYv3cdseiDglrtqvrkDHYhiqhXEwleDCOp
         LF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aklexUdGmBZ4BlpYptu3dL21oi8ybYbv/sEa2ECKEXQ=;
        b=SOJStDnCr+UuteY+HDEjuIY/2GCIv8AB0ZQuxqkArP4e49AxIKA4MMbdG+6znLihEt
         +eL0DFvDuy3hFvHdNkKLdPtzoHZaS9nNd7vJ0EGjiGuFGnW5U6psPP8smBMk4jqOexSA
         VW/9nwHpWbBfrIPwb4Nha9hiwnsvOax+K621vieEU1baciF2MXyHBRnykvtU7TJYFtWj
         5AdVne5lYCPe9QENn7877GMQp2sQYDBdCyPUSuQwCFq6DZQCdjVOG5b4neOKfXXxQATf
         I6sEy/TmcgV1YEqoVo65RCxKKSf6+nOvZcyp9DfzKC2Yn+8vA3LMxdNQAXUJ/7/P2f+/
         BBjg==
X-Gm-Message-State: AOAM533ukSlVc2jrEdYx904DD4NhrSyo7LAEXHKWvkqm1bxxz+g/O7Q8
        nvIHce4M9vAj95JmejoW4dDn9Q==
X-Google-Smtp-Source: ABdhPJwkUZyLT40tp5Vc9/MJYxUzMI3GA9KKPgh2v5uGX4pX9gkro9lA2MGalrgU9trJJj25LXPpHw==
X-Received: by 2002:a63:8943:0:b0:3aa:f1ce:4f24 with SMTP id v64-20020a638943000000b003aaf1ce4f24mr2338866pgd.34.1651304980880;
        Sat, 30 Apr 2022 00:49:40 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:483c:22c0:2c47:6a7d:5be8:bdfa])
        by smtp.gmail.com with ESMTPSA id y15-20020a1709027c8f00b0015e8d4eb225sm818103pll.111.2022.04.30.00.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 00:49:40 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Kaixi Fan <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v6 3/3] selftests/bpf: Replace bpf_trace_printk in tunnel kernel code
Date:   Sat, 30 Apr 2022 15:48:44 +0800
Message-Id: <20220430074844.69214-4-fankaixi.li@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220430074844.69214-1-fankaixi.li@bytedance.com>
References: <20220430074844.69214-1-fankaixi.li@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Kaixi Fan <fankaixi.li@bytedance.com>

Replace bpf_trace_printk with bpf_printk in test_tunnel_kern.c.
function bpf_printk is more easier and useful than bpf_trace_printk.

Signed-off-by: Kaixi Fan <fankaixi.li@bytedance.com>
---
 .../selftests/bpf/progs/test_tunnel_kern.c    | 169 ++++++++----------
 1 file changed, 72 insertions(+), 97 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index b33ceff2f74d..17f2f325b3f3 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -21,10 +21,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
-#define ERROR(ret) do {\
-		char fmt[] = "ERROR line:%d ret:%d\n";\
-		bpf_trace_printk(fmt, sizeof(fmt), __LINE__, ret); \
-	} while (0)
+#define log_err(__ret) bpf_printk("ERROR line:%d ret:%d\n", __LINE__, __ret)
 
 struct geneve_opt {
 	__be16	opt_class;
@@ -47,7 +44,6 @@ struct {
 	__type(value, __u32);
 } local_ip_map SEC(".maps");
 
-
 SEC("tc")
 int gre_set_tunnel(struct __sk_buff *skb)
 {
@@ -63,7 +59,7 @@ int gre_set_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_ZERO_CSUM_TX | BPF_F_SEQ_NUMBER);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -75,15 +71,14 @@ int gre_get_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key;
-	char fmt[] = "key %d remote ip 0x%x\n";
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
-	bpf_trace_printk(fmt, sizeof(fmt), key.tunnel_id, key.remote_ipv4);
+	bpf_printk("key %d remote ip 0x%x\n", key.tunnel_id, key.remote_ipv4);
 	return TC_ACT_OK;
 }
 
@@ -104,7 +99,7 @@ int ip6gretap_set_tunnel(struct __sk_buff *skb)
 				     BPF_F_TUNINFO_IPV6 | BPF_F_ZERO_CSUM_TX |
 				     BPF_F_SEQ_NUMBER);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -114,19 +109,18 @@ int ip6gretap_set_tunnel(struct __sk_buff *skb)
 SEC("tc")
 int ip6gretap_get_tunnel(struct __sk_buff *skb)
 {
-	char fmt[] = "key %d remote ip6 ::%x label %x\n";
 	struct bpf_tunnel_key key;
 	int ret;
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
-	bpf_trace_printk(fmt, sizeof(fmt),
-			 key.tunnel_id, key.remote_ipv6[3], key.tunnel_label);
+	bpf_printk("key %d remote ip6 ::%x label %x\n",
+		   key.tunnel_id, key.remote_ipv6[3], key.tunnel_label);
 
 	return TC_ACT_OK;
 }
@@ -147,7 +141,7 @@ int erspan_set_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_ZERO_CSUM_TX);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -167,7 +161,7 @@ int erspan_set_tunnel(struct __sk_buff *skb)
 
 	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -177,7 +171,6 @@ int erspan_set_tunnel(struct __sk_buff *skb)
 SEC("tc")
 int erspan_get_tunnel(struct __sk_buff *skb)
 {
-	char fmt[] = "key %d remote ip 0x%x erspan version %d\n";
 	struct bpf_tunnel_key key;
 	struct erspan_metadata md;
 	__u32 index;
@@ -185,31 +178,27 @@ int erspan_get_tunnel(struct __sk_buff *skb)
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
 	ret = bpf_skb_get_tunnel_opt(skb, &md, sizeof(md));
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
-	bpf_trace_printk(fmt, sizeof(fmt),
-			key.tunnel_id, key.remote_ipv4, md.version);
+	bpf_printk("key %d remote ip 0x%x erspan version %d\n",
+		   key.tunnel_id, key.remote_ipv4, md.version);
 
 #ifdef ERSPAN_V1
-	char fmt2[] = "\tindex %x\n";
-
 	index = bpf_ntohl(md.u.index);
-	bpf_trace_printk(fmt2, sizeof(fmt2), index);
+	bpf_printk("\tindex %x\n", index);
 #else
-	char fmt2[] = "\tdirection %d hwid %x timestamp %u\n";
-
-	bpf_trace_printk(fmt2, sizeof(fmt2),
-			 md.u.md2.dir,
-			 (md.u.md2.hwid_upper << 4) + md.u.md2.hwid,
-			 bpf_ntohl(md.u.md2.timestamp));
+	bpf_printk("\tdirection %d hwid %x timestamp %u\n",
+		   md.u.md2.dir,
+		   (md.u.md2.hwid_upper << 4) + md.u.md2.hwid,
+		   bpf_ntohl(md.u.md2.timestamp));
 #endif
 
 	return TC_ACT_OK;
@@ -231,7 +220,7 @@ int ip4ip6erspan_set_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -252,7 +241,7 @@ int ip4ip6erspan_set_tunnel(struct __sk_buff *skb)
 
 	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -262,7 +251,6 @@ int ip4ip6erspan_set_tunnel(struct __sk_buff *skb)
 SEC("tc")
 int ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
 {
-	char fmt[] = "ip6erspan get key %d remote ip6 ::%x erspan version %d\n";
 	struct bpf_tunnel_key key;
 	struct erspan_metadata md;
 	__u32 index;
@@ -271,31 +259,27 @@ int ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
 	ret = bpf_skb_get_tunnel_opt(skb, &md, sizeof(md));
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
-	bpf_trace_printk(fmt, sizeof(fmt),
-			key.tunnel_id, key.remote_ipv4, md.version);
+	bpf_printk("ip6erspan get key %d remote ip6 ::%x erspan version %d\n",
+		   key.tunnel_id, key.remote_ipv4, md.version);
 
 #ifdef ERSPAN_V1
-	char fmt2[] = "\tindex %x\n";
-
 	index = bpf_ntohl(md.u.index);
-	bpf_trace_printk(fmt2, sizeof(fmt2), index);
+	bpf_printk("\tindex %x\n", index);
 #else
-	char fmt2[] = "\tdirection %d hwid %x timestamp %u\n";
-
-	bpf_trace_printk(fmt2, sizeof(fmt2),
-			 md.u.md2.dir,
-			 (md.u.md2.hwid_upper << 4) + md.u.md2.hwid,
-			 bpf_ntohl(md.u.md2.timestamp));
+	bpf_printk("\tdirection %d hwid %x timestamp %u\n",
+		   md.u.md2.dir,
+		   (md.u.md2.hwid_upper << 4) + md.u.md2.hwid,
+		   bpf_ntohl(md.u.md2.timestamp));
 #endif
 
 	return TC_ACT_OK;
@@ -351,7 +335,7 @@ int vxlan_set_tunnel_src(struct __sk_buff *skb)
 
 	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
 	if (!local_ip) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -365,14 +349,14 @@ int vxlan_set_tunnel_src(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_ZERO_CSUM_TX);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
 	md.gbp = 0x800FF; /* Set VXLAN Group Policy extension */
 	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -385,26 +369,24 @@ int vxlan_get_tunnel_src(struct __sk_buff *skb)
 	int ret;
 	struct bpf_tunnel_key key;
 	struct vxlan_metadata md;
-	char fmt[] = "key %d remote ip 0x%x vxlan gbp 0x%x\n";
-	char fmt2[] = "local ip 0x%x\n";
 	__u32 index = 0;
 	__u32 *local_ip = NULL;
 
 	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
 	if (!local_ip) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
 	ret = bpf_skb_get_tunnel_opt(skb, &md, sizeof(md));
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -461,7 +443,7 @@ int ip6vxlan_set_tunnel_src(struct __sk_buff *skb)
 
 	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
 	if (!local_ip) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -475,7 +457,7 @@ int ip6vxlan_set_tunnel_src(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -485,8 +467,6 @@ int ip6vxlan_set_tunnel_src(struct __sk_buff *skb)
 SEC("tc")
 int ip6vxlan_get_tunnel_src(struct __sk_buff *skb)
 {
-	char fmt[] = "key %d remote ip6 ::%x label %x\n";
-	char fmt2[] = "local ip6 ::%x\n";
 	struct bpf_tunnel_key key;
 	int ret;
 	__u32 index = 0;
@@ -494,23 +474,23 @@ int ip6vxlan_get_tunnel_src(struct __sk_buff *skb)
 
 	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
 	if (!local_ip) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
 	if (bpf_ntohl(key.local_ipv6[3]) != *local_ip) {
-		bpf_trace_printk(fmt, sizeof(fmt),
-				 key.tunnel_id,
-				 key.remote_ipv6[3], key.tunnel_label);
-		bpf_trace_printk(fmt2, sizeof(fmt2), key.local_ipv6[3]);
-		ERROR(ret);
+		bpf_printk("ip6vxlan key %d local ip6 ::%x remote ip6 ::%x label 0x%x\n",
+			   key.tunnel_id, bpf_ntohl(key.local_ipv6[3]),
+			   bpf_ntohl(key.remote_ipv6[3]), key.tunnel_label);
+		bpf_printk("local_ip 0x%x\n", *local_ip);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -542,13 +522,13 @@ int geneve_set_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_ZERO_CSUM_TX);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
 	ret = bpf_skb_set_tunnel_opt(skb, &gopt, sizeof(gopt));
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -561,11 +541,10 @@ int geneve_get_tunnel(struct __sk_buff *skb)
 	int ret;
 	struct bpf_tunnel_key key;
 	struct geneve_opt gopt;
-	char fmt[] = "key %d remote ip 0x%x geneve class 0x%x\n";
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -573,8 +552,8 @@ int geneve_get_tunnel(struct __sk_buff *skb)
 	if (ret < 0)
 		gopt.opt_class = 0;
 
-	bpf_trace_printk(fmt, sizeof(fmt),
-			key.tunnel_id, key.remote_ipv4, gopt.opt_class);
+	bpf_printk("key %d remote ip 0x%x geneve class 0x%x\n",
+		   key.tunnel_id, key.remote_ipv4, gopt.opt_class);
 	return TC_ACT_OK;
 }
 
@@ -594,7 +573,7 @@ int ip6geneve_set_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -609,7 +588,7 @@ int ip6geneve_set_tunnel(struct __sk_buff *skb)
 
 	ret = bpf_skb_set_tunnel_opt(skb, &gopt, sizeof(gopt));
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -619,7 +598,6 @@ int ip6geneve_set_tunnel(struct __sk_buff *skb)
 SEC("tc")
 int ip6geneve_get_tunnel(struct __sk_buff *skb)
 {
-	char fmt[] = "key %d remote ip 0x%x geneve class 0x%x\n";
 	struct bpf_tunnel_key key;
 	struct geneve_opt gopt;
 	int ret;
@@ -627,7 +605,7 @@ int ip6geneve_get_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -635,8 +613,8 @@ int ip6geneve_get_tunnel(struct __sk_buff *skb)
 	if (ret < 0)
 		gopt.opt_class = 0;
 
-	bpf_trace_printk(fmt, sizeof(fmt),
-			key.tunnel_id, key.remote_ipv4, gopt.opt_class);
+	bpf_printk("key %d remote ip 0x%x geneve class 0x%x\n",
+		   key.tunnel_id, key.remote_ipv4, gopt.opt_class);
 
 	return TC_ACT_OK;
 }
@@ -652,7 +630,7 @@ int ipip_set_tunnel(struct __sk_buff *skb)
 
 	/* single length check */
 	if (data + sizeof(*iph) > data_end) {
-		ERROR(1);
+		log_err(1);
 		return TC_ACT_SHOT;
 	}
 
@@ -663,7 +641,7 @@ int ipip_set_tunnel(struct __sk_buff *skb)
 
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key), 0);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -675,15 +653,14 @@ int ipip_get_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key;
-	char fmt[] = "remote ip 0x%x\n";
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
-	bpf_trace_printk(fmt, sizeof(fmt), key.remote_ipv4);
+	bpf_printk("remote ip 0x%x\n", key.remote_ipv4);
 	return TC_ACT_OK;
 }
 
@@ -698,7 +675,7 @@ int ipip6_set_tunnel(struct __sk_buff *skb)
 
 	/* single length check */
 	if (data + sizeof(*iph) > data_end) {
-		ERROR(1);
+		log_err(1);
 		return TC_ACT_SHOT;
 	}
 
@@ -711,7 +688,7 @@ int ipip6_set_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -723,17 +700,16 @@ int ipip6_get_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key;
-	char fmt[] = "remote ip6 %x::%x\n";
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
-	bpf_trace_printk(fmt, sizeof(fmt), bpf_htonl(key.remote_ipv6[0]),
-			 bpf_htonl(key.remote_ipv6[3]));
+	bpf_printk("remote ip6 %x::%x\n", bpf_htonl(key.remote_ipv6[0]),
+		   bpf_htonl(key.remote_ipv6[3]));
 	return TC_ACT_OK;
 }
 
@@ -748,7 +724,7 @@ int ip6ip6_set_tunnel(struct __sk_buff *skb)
 
 	/* single length check */
 	if (data + sizeof(*iph) > data_end) {
-		ERROR(1);
+		log_err(1);
 		return TC_ACT_SHOT;
 	}
 
@@ -760,7 +736,7 @@ int ip6ip6_set_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -772,17 +748,16 @@ int ip6ip6_get_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key;
-	char fmt[] = "remote ip6 %x::%x\n";
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
-	bpf_trace_printk(fmt, sizeof(fmt), bpf_htonl(key.remote_ipv6[0]),
-			 bpf_htonl(key.remote_ipv6[3]));
+	bpf_printk("remote ip6 %x::%x\n", bpf_htonl(key.remote_ipv6[0]),
+		   bpf_htonl(key.remote_ipv6[3]));
 	return TC_ACT_OK;
 }
 
@@ -790,15 +765,15 @@ SEC("tc")
 int xfrm_get_state(struct __sk_buff *skb)
 {
 	struct bpf_xfrm_state x;
-	char fmt[] = "reqid %d spi 0x%x remote ip 0x%x\n";
 	int ret;
 
 	ret = bpf_skb_get_xfrm_state(skb, 0, &x, sizeof(x), 0);
 	if (ret < 0)
 		return TC_ACT_OK;
 
-	bpf_trace_printk(fmt, sizeof(fmt), x.reqid, bpf_ntohl(x.spi),
-			 bpf_ntohl(x.remote_ipv4));
+	bpf_printk("reqid %d spi 0x%x remote ip 0x%x\n",
+		   x.reqid, bpf_ntohl(x.spi),
+		   bpf_ntohl(x.remote_ipv4));
 	return TC_ACT_OK;
 }
 
-- 
2.20.1

