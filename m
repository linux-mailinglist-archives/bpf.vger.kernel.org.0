Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07C0504A7E
	for <lists+bpf@lfdr.de>; Mon, 18 Apr 2022 03:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiDRBeu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Apr 2022 21:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiDRBet (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 17 Apr 2022 21:34:49 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA8813E99
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 18:32:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c23so11269189plo.0
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 18:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/FMQ5uQfp8GLKW+FVyd05UOUenwL1l7x8rDuUJ7ReBs=;
        b=KYUwVx6IuIgXWnL0IY7pd1RTAsd+erazpOIYZK93wl03gELsyCDrL8jXTyGYdUYI1L
         Ai5QNITgulJAw6+DYpcZFYultunMQ/rtEOtIOSM8YwHRJz6zALW2UslK0WZoqUQEX2Nk
         j6vrov+1MdZVgaqJGZSOt9U7NxE5/3gHBXcvnS/CvKdMADYgM7IWo1lLtfsJ4dP6YzuW
         8q98M6lsO6915Drg7rulDpdYhzOBqLNGjG0D3Q5cFEpULhUAvaiJx7VcyYKwgeWMa9K6
         10iDlwSDqMRslawW63yv+5DD7gDu2Sm4tX0f+85KBgOP4WJfdbwQKjSl58hgWwXgYplC
         5JJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/FMQ5uQfp8GLKW+FVyd05UOUenwL1l7x8rDuUJ7ReBs=;
        b=7A3oSUZXZvQlxi5+YfSnhX06aS7bIO+UvIfl3eWP+JmHGwP/Zm0Q7c+/jRn/RhKIdE
         jUTJrOQ1nMsfiWOKrv/5WDcLkFOcRyVAPTiFl8KY1ZG2oniCtSEkBRFHMVTrvIM+MkPL
         5cwCfLzF29c6oQPumy1aQLub7Mtgn3czIoAj0u6E8dx2tRyifX1DVLV4O9JlGDewx8xb
         zby7XRTNyIfrR/UYatXNK1Pf4tFaHPG9NB/EG3L70TkvcSZdatd3o/IRl422mdGpkWCu
         u2g1A6sRNDcIv8uS1z5Du2yybQ+z/2xS+i4AxZARR9SNHi8zrQDZYNN0/V4NUUBd/5oc
         XMuQ==
X-Gm-Message-State: AOAM531QakxzQ113k24EF0/0gPVSibVgbTZ7hTqnoq+eEGcuLI1Ji8Wx
        Ccw1WP5JlJYDvtpqqw6B/u/JAg==
X-Google-Smtp-Source: ABdhPJy7SAE+C8C2VvLalCi2I5mUIAEzdjTk92AglVqnDthHH8odkqubvdQoQrhbaXiY12kiRO08Hg==
X-Received: by 2002:a17:902:ef46:b0:153:81f7:7fc2 with SMTP id e6-20020a170902ef4600b0015381f77fc2mr8769812plx.26.1650245531213;
        Sun, 17 Apr 2022 18:32:11 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:4832:de00:590a:cbcb:f71b:54e5])
        by smtp.gmail.com with ESMTPSA id c2-20020a63a442000000b0039cc5a6af1csm10807333pgp.30.2022.04.17.18.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 18:32:10 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Kaixi Fan <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v4 3/3] selftests/bpf: replace bpf_trace_printk in tunnel kernel code
Date:   Mon, 18 Apr 2022 09:31:36 +0800
Message-Id: <20220418013136.26098-4-fankaixi.li@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220418013136.26098-1-fankaixi.li@bytedance.com>
References: <20220418013136.26098-1-fankaixi.li@bytedance.com>
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

