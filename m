Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6D5A806F
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 16:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiHaOk2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 10:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiHaOkY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 10:40:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E742520B0
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 07:40:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w5so2387449wrn.12
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HsDYXDQR7cqxDXDeDGTk8Q6RD+bOYzIbYBsibJWzoaQ=;
        b=cj5LiTAPzdSx/bHjPgCDEljdwX+/teIkS/VzPdAHMFpLoMzUNxbr5/v9Lpn+CuEqEm
         gNt71yATNv5WZ4WuTNNLSHksmmEoRj+nvJk/HON5rsaBOd7cuhv6aFT/1RewMh8cfvG4
         j1nc+cQTuB8segu98Mcq7BgSGCPovyg/pKx1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HsDYXDQR7cqxDXDeDGTk8Q6RD+bOYzIbYBsibJWzoaQ=;
        b=HtZvP9j/yNSrTSGRceIrnLORkejEztDTIBuP0Pb6eSGjeOrbHQCvbqRkLVorM82uNR
         e34L8GI1I6jYptF1tHSBng78h59DSDgN75n5oR7hPyQ7s4GZEO6S7dC/Rk90/2bTbaBc
         1cH/OCF2mT19VRjhsBM2FBC7CpyilLMUT6MXQRBhM/+lYMkLZlljLcrR8yK1Rou1S+Gp
         ITOfpPCxt9rJTr/kWiwJTewzDEdLeE33K5jmZiD4Xf24E6tLmyruFluKLIU+C3/po2hd
         qrknc8UHarSNWp/1O2I0PZDvaBQ4t8oJwp5IzsiPz5/hcAX0s0xompXV6uYQfwE0FSOq
         GAdQ==
X-Gm-Message-State: ACgBeo0R8CGQ1vh69+oI+grVErCzLaT188UPm06WPdtUxTHB1bG2zKVN
        HVpqDwjjCUFfCpjhUhC8t5EWX4mnceyBSgOTmXtSVblutK9EMvKSdegJ8G27IX2Cv0DYUedRt1J
        HA1XtjZ8P3JZT/LNv/xAL79rwp/lGEBLxOV5W4guQ1sqzOATGU/5CfZB1KaoSgwJ7IHRzHoOa
X-Google-Smtp-Source: AA6agR4U5RXNYonVdr9fHAUtHKQ20rhqwxdJKtXxOLDF6JtCdo11Phzpn4WHCikIoNxjfGRc+1nQjg==
X-Received: by 2002:a05:6000:1ac8:b0:220:6af3:935d with SMTP id i8-20020a0560001ac800b002206af3935dmr12063449wry.549.1661956821101;
        Wed, 31 Aug 2022 07:40:21 -0700 (PDT)
Received: from blondie.home ([5.102.239.127])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c424900b003a61306d79dsm2239315wmm.41.2022.08.31.07.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 07:40:20 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Amend test_tunnel to exercise BPF_F_TUNINFO_FLAGS
Date:   Wed, 31 Aug 2022 17:40:10 +0300
Message-Id: <20220831144010.174110-2-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831144010.174110-1-shmulik.ladkani@gmail.com>
References: <20220831144010.174110-1-shmulik.ladkani@gmail.com>
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

Get the tunnel flags in {ipv6}vxlan_get_tunnel_src and ensure they are
aligned with tunnel params set at {ipv6}vxlan_set_tunnel_dst.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
 .../selftests/bpf/progs/test_tunnel_kern.c    | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index df0673c4ecbe..98af55f0bcd3 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -12,6 +12,7 @@
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
+#include <linux/if_tunnel.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/icmp.h>
@@ -386,7 +387,8 @@ int vxlan_get_tunnel_src(struct __sk_buff *skb)
 	__u32 orig_daddr;
 	__u32 index = 0;
 
-	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
+	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
+				     BPF_F_TUNINFO_FLAGS);
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
@@ -398,10 +400,13 @@ int vxlan_get_tunnel_src(struct __sk_buff *skb)
 		return TC_ACT_SHOT;
 	}
 
-	if (key.local_ipv4 != ASSIGNED_ADDR_VETH1 || md.gbp != 0x800FF) {
-		bpf_printk("vxlan key %d local ip 0x%x remote ip 0x%x gbp 0x%x\n",
+	if (key.local_ipv4 != ASSIGNED_ADDR_VETH1 || md.gbp != 0x800FF ||
+	    !(key.tunnel_flags & TUNNEL_KEY) ||
+	    (key.tunnel_flags & TUNNEL_CSUM)) {
+		bpf_printk("vxlan key %d local ip 0x%x remote ip 0x%x gbp 0x%x flags 0x%x\n",
 			   key.tunnel_id, key.local_ipv4,
-			   key.remote_ipv4, md.gbp);
+			   key.remote_ipv4, md.gbp,
+			   bpf_ntohs(key.tunnel_flags));
 		log_err(ret);
 		return TC_ACT_SHOT;
 	}
@@ -541,16 +546,19 @@ int ip6vxlan_get_tunnel_src(struct __sk_buff *skb)
 	}
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key),
-				     BPF_F_TUNINFO_IPV6);
+				     BPF_F_TUNINFO_IPV6 | BPF_F_TUNINFO_FLAGS);
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
 	}
 
-	if (bpf_ntohl(key.local_ipv6[3]) != *local_ip) {
-		bpf_printk("ip6vxlan key %d local ip6 ::%x remote ip6 ::%x label 0x%x\n",
+	if (bpf_ntohl(key.local_ipv6[3]) != *local_ip ||
+	    !(key.tunnel_flags & TUNNEL_KEY) ||
+	    !(key.tunnel_flags & TUNNEL_CSUM)) {
+		bpf_printk("ip6vxlan key %d local ip6 ::%x remote ip6 ::%x label 0x%x flags 0x%x\n",
 			   key.tunnel_id, bpf_ntohl(key.local_ipv6[3]),
-			   bpf_ntohl(key.remote_ipv6[3]), key.tunnel_label);
+			   bpf_ntohl(key.remote_ipv6[3]), key.tunnel_label,
+			   bpf_ntohs(key.tunnel_flags));
 		bpf_printk("local_ip 0x%x\n", *local_ip);
 		log_err(ret);
 		return TC_ACT_SHOT;
-- 
2.37.2

