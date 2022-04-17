Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01345047E3
	for <lists+bpf@lfdr.de>; Sun, 17 Apr 2022 15:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiDQNXt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Apr 2022 09:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiDQNXq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 17 Apr 2022 09:23:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD8A140C7
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 06:21:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o5so11109495pjr.0
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/FMQ5uQfp8GLKW+FVyd05UOUenwL1l7x8rDuUJ7ReBs=;
        b=sZzANQhA3upNYu6htkN5KPi/2YhUXgCHPjc4TEk/aSEh1KRC8oAtQoxdy8yVazYcMz
         gF1PV7LOuIu7VyVBdm6HGndYsxkPP7/LFflQPa8b9kA48ZJ0FcArK5EYVjBpJyLDJHrw
         RZXBhDMw/eVY4mwtH/7+lPDjH9W5433BsdelmWcdXYNqMgelNUoWUjLKT7unKJTkxjCm
         69v4zrduKr1Z+GJiOULfZj9Ka9vdyEZrafDPhB88HwOR15hU65QpK/0hOWFXOGI0AgZw
         jswLaML/uoGAKGSEcAcUDfxBAe6NZweR5tIS3yEi+xyGkAZJwfASEz/p6KtTCzFkQGgZ
         OeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/FMQ5uQfp8GLKW+FVyd05UOUenwL1l7x8rDuUJ7ReBs=;
        b=UUtkA6T8JYReCthcd2ewMh4mLGqNnUX3G3ttuq3eSukkW7X7sTOYaf+weFRYgwJ8R5
         UWDYrYi60snz8pc8A4PNJaVO0kZ7T4LedfmLke5Y2BD0t4MUHof27kW578+Bshzo3SsR
         wHSsjDKJGq48yZVWU2a2gh+ECeVPXf/pQEKwN+5SVsg5oqm4ubDvgovuALXEgA1yQC7I
         p5BIWH5D3+lyZvF6yvX+wClCU6cylPaKIbq8+aHGzYp2m0qH1F5BymwHbylqNZw+coPc
         Cp8KCbNU55mw7tjoV1CgCkSIkLr+zJzNnh9xbLigerF/Rh3e2SYQM+jSw4QRSlBumTxV
         Jq2g==
X-Gm-Message-State: AOAM530kYb12Y55A971hZDdnQIZ+0NJfBPdPb2wgyZkNZaY/8+jLStnW
        qDp+2gfLrpMWXSYc7kWCiKJ6wQ==
X-Google-Smtp-Source: ABdhPJwxyG+u2T8KCyM9+K8v/UjZ1AtWWo5isJUQbLC9S4v13e562LEHGwXRKdgcbuguJ69SOvJcNQ==
X-Received: by 2002:a17:90b:4d81:b0:1d2:8525:5f1c with SMTP id oj1-20020a17090b4d8100b001d285255f1cmr2756762pjb.27.1650201669968;
        Sun, 17 Apr 2022 06:21:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:4832:de00:bc27:698e:1fca:c5bb])
        by smtp.gmail.com with ESMTPSA id l10-20020a17090aec0a00b001d27f7fb42csm1936907pjy.13.2022.04.17.06.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 06:21:09 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Kaixi Fan <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v3 3/3] selftests/bpf: replace bpf_trace_printk in tunnel kernel code
Date:   Sun, 17 Apr 2022 21:20:30 +0800
Message-Id: <20220417132030.17067-4-fankaixi.li@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220417132030.17067-1-fankaixi.li@bytedance.com>
References: <20220417132030.17067-1-fankaixi.li@bytedance.com>
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

From: Kaixi Fan <fankaixi.li@bytedance.com>

Replace bpf_trace_printk with bpf_printk in test_tunnel_kern.c.

Signed-off-by: Kaixi Fan <fankaixi.li@bytedance.com>
---
 .../selftests/bpf/progs/test_tunnel_kern.c    | 157 ++++++++----------
 1 file changed, 67 insertions(+), 90 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index c6ddaea9e3fa..d525d81ad6af 100644
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
@@ -63,7 +60,7 @@ int gre_set_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_ZERO_CSUM_TX | BPF_F_SEQ_NUMBER);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -75,15 +72,14 @@ int gre_get_tunnel(struct __sk_buff *skb)
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
 
@@ -104,7 +100,7 @@ int ip6gretap_set_tunnel(struct __sk_buff *skb)
 				     BPF_F_TUNINFO_IPV6 | BPF_F_ZERO_CSUM_TX |
 				     BPF_F_SEQ_NUMBER);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -114,19 +110,18 @@ int ip6gretap_set_tunnel(struct __sk_buff *skb)
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
+			key.tunnel_id, key.remote_ipv6[3], key.tunnel_label);
 
 	return TC_ACT_OK;
 }
@@ -147,7 +142,7 @@ int erspan_set_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_ZERO_CSUM_TX);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -167,7 +162,7 @@ int erspan_set_tunnel(struct __sk_buff *skb)
 
 	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -177,7 +172,6 @@ int erspan_set_tunnel(struct __sk_buff *skb)
 SEC("tc")
 int erspan_get_tunnel(struct __sk_buff *skb)
 {
-	char fmt[] = "key %d remote ip 0x%x erspan version %d\n";
 	struct bpf_tunnel_key key;
 	struct erspan_metadata md;
 	__u32 index;
@@ -185,28 +179,24 @@ int erspan_get_tunnel(struct __sk_buff *skb)
 
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
+	bpf_printk("key %d remote ip 0x%x erspan version %d\n",
 			key.tunnel_id, key.remote_ipv4, md.version);
 
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
+	bpf_printk("\tdirection %d hwid %x timestamp %u\n",
 			 md.u.md2.dir,
 			 (md.u.md2.hwid_upper << 4) + md.u.md2.hwid,
 			 bpf_ntohl(md.u.md2.timestamp));
@@ -231,7 +221,7 @@ int ip4ip6erspan_set_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -252,7 +242,7 @@ int ip4ip6erspan_set_tunnel(struct __sk_buff *skb)
 
 	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -262,7 +252,6 @@ int ip4ip6erspan_set_tunnel(struct __sk_buff *skb)
 SEC("tc")
 int ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
 {
-	char fmt[] = "ip6erspan get key %d remote ip6 ::%x erspan version %d\n";
 	struct bpf_tunnel_key key;
 	struct erspan_metadata md;
 	__u32 index;
@@ -271,28 +260,24 @@ int ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
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
+	bpf_printk("ip6erspan get key %d remote ip6 ::%x erspan version %d\n",
 			key.tunnel_id, key.remote_ipv4, md.version);
 
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
+	bpf_printk("\tdirection %d hwid %x timestamp %u\n",
 			 md.u.md2.dir,
 			 (md.u.md2.hwid_upper << 4) + md.u.md2.hwid,
 			 bpf_ntohl(md.u.md2.timestamp));
@@ -312,7 +297,7 @@ int vxlan_set_tunnel(struct __sk_buff *skb)
 
 	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
 	if (!local_ip) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -326,14 +311,14 @@ int vxlan_set_tunnel(struct __sk_buff *skb)
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
 
@@ -346,34 +331,33 @@ int vxlan_get_tunnel(struct __sk_buff *skb)
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
 
 	if (key.local_ipv4 != *local_ip) {
-		bpf_trace_printk(fmt, sizeof(fmt),
-				 key.tunnel_id, key.remote_ipv4, md.gbp);
-		bpf_trace_printk(fmt2, sizeof(fmt2), key.local_ipv4);
-		ERROR(ret);
+		bpf_printk("vxlan key %d local ip 0x%x remote ip 0x%x gbp 0x%x\n",
+			   key.tunnel_id, key.local_ipv4,
+			   key.remote_ipv4, md.gbp);
+		bpf_printk("local_ip 0x%x\n", *local_ip);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -390,7 +374,7 @@ int ip6vxlan_set_tunnel(struct __sk_buff *skb)
 
 	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
 	if (!local_ip) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -404,7 +388,7 @@ int ip6vxlan_set_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -414,8 +398,6 @@ int ip6vxlan_set_tunnel(struct __sk_buff *skb)
 SEC("tc")
 int ip6vxlan_get_tunnel(struct __sk_buff *skb)
 {
-	char fmt[] = "key %d remote ip6 ::%x label %x\n";
-	char fmt2[] = "local ip6 ::%x\n";
 	struct bpf_tunnel_key key;
 	int ret;
 	__u32 index = 0;
@@ -423,23 +405,23 @@ int ip6vxlan_get_tunnel(struct __sk_buff *skb)
 
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
 
@@ -471,13 +453,13 @@ int geneve_set_tunnel(struct __sk_buff *skb)
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
 
@@ -490,11 +472,10 @@ int geneve_get_tunnel(struct __sk_buff *skb)
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
 
@@ -502,8 +483,8 @@ int geneve_get_tunnel(struct __sk_buff *skb)
 	if (ret < 0)
 		gopt.opt_class = 0;
 
-	bpf_trace_printk(fmt, sizeof(fmt),
-			key.tunnel_id, key.remote_ipv4, gopt.opt_class);
+	bpf_printk("key %d remote ip 0x%x geneve class 0x%x\n",
+		   key.tunnel_id, key.remote_ipv4, gopt.opt_class);
 	return TC_ACT_OK;
 }
 
@@ -523,7 +504,7 @@ int ip6geneve_set_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -538,7 +519,7 @@ int ip6geneve_set_tunnel(struct __sk_buff *skb)
 
 	ret = bpf_skb_set_tunnel_opt(skb, &gopt, sizeof(gopt));
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -548,7 +529,6 @@ int ip6geneve_set_tunnel(struct __sk_buff *skb)
 SEC("tc")
 int ip6geneve_get_tunnel(struct __sk_buff *skb)
 {
-	char fmt[] = "key %d remote ip 0x%x geneve class 0x%x\n";
 	struct bpf_tunnel_key key;
 	struct geneve_opt gopt;
 	int ret;
@@ -556,7 +536,7 @@ int ip6geneve_get_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -564,8 +544,8 @@ int ip6geneve_get_tunnel(struct __sk_buff *skb)
 	if (ret < 0)
 		gopt.opt_class = 0;
 
-	bpf_trace_printk(fmt, sizeof(fmt),
-			key.tunnel_id, key.remote_ipv4, gopt.opt_class);
+	bpf_printk("key %d remote ip 0x%x geneve class 0x%x\n",
+		   key.tunnel_id, key.remote_ipv4, gopt.opt_class);
 
 	return TC_ACT_OK;
 }
@@ -581,7 +561,7 @@ int ipip_set_tunnel(struct __sk_buff *skb)
 
 	/* single length check */
 	if (data + sizeof(*iph) > data_end) {
-		ERROR(1);
+		log_err(1);
 		return TC_ACT_SHOT;
 	}
 
@@ -592,7 +572,7 @@ int ipip_set_tunnel(struct __sk_buff *skb)
 
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key), 0);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -604,15 +584,14 @@ int ipip_get_tunnel(struct __sk_buff *skb)
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
 
@@ -627,7 +606,7 @@ int ipip6_set_tunnel(struct __sk_buff *skb)
 
 	/* single length check */
 	if (data + sizeof(*iph) > data_end) {
-		ERROR(1);
+		log_err(1);
 		return TC_ACT_SHOT;
 	}
 
@@ -640,7 +619,7 @@ int ipip6_set_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -652,16 +631,15 @@ int ipip6_get_tunnel(struct __sk_buff *skb)
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
+	bpf_printk("remote ip6 %x::%x\n", bpf_htonl(key.remote_ipv6[0]),
 			 bpf_htonl(key.remote_ipv6[3]));
 	return TC_ACT_OK;
 }
@@ -677,7 +655,7 @@ int ip6ip6_set_tunnel(struct __sk_buff *skb)
 
 	/* single length check */
 	if (data + sizeof(*iph) > data_end) {
-		ERROR(1);
+		log_err(1);
 		return TC_ACT_SHOT;
 	}
 
@@ -689,7 +667,7 @@ int ip6ip6_set_tunnel(struct __sk_buff *skb)
 	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
 				     BPF_F_TUNINFO_IPV6);
 	if (ret < 0) {
-		ERROR(ret);
+		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
@@ -701,16 +679,15 @@ int ip6ip6_get_tunnel(struct __sk_buff *skb)
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
+	bpf_printk("remote ip6 %x::%x\n", bpf_htonl(key.remote_ipv6[0]),
 			 bpf_htonl(key.remote_ipv6[3]));
 	return TC_ACT_OK;
 }
@@ -719,15 +696,15 @@ SEC("tc")
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

