Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBCB515B16
	for <lists+bpf@lfdr.de>; Sat, 30 Apr 2022 09:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382315AbiD3Hwu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Apr 2022 03:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382309AbiD3Hwu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Apr 2022 03:52:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722D7BF57
        for <bpf@vger.kernel.org>; Sat, 30 Apr 2022 00:49:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p8so8647590pfh.8
        for <bpf@vger.kernel.org>; Sat, 30 Apr 2022 00:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CjNJznFs9piF/QlgUBFdYy3MufW0mZcuOifScsIBWfc=;
        b=Z8F+d4spQ+1jXXIUoOnVB3LLmEYHcQdAVeRFPJcqg8YYdwi5+mRt/4UA/JIjwmDsrw
         zFQbwyV5KdCTNlDABdMtai8UF+g0xVw/oXv3Yhasg1mWVDQTBtL79DuVHehS2zGNrAqY
         dq6o/yY3W3cMCGUsCfLf1NLH0o3/itcsvFMJDKbuOydTwDHclTWenYiuPVsGEFDrQ5O9
         MidKF8iaO+YpZxjec386rQbJn81C07NOlblcMa7uflIDKYdwJ6Cz8uDmCJ5FghI5jLnf
         Ao16uBh9RIUL3uuemwDMXSlp51wN4Cz+pWb9wbV4DTn6h71HpCFdANB1alPzyfHvda/O
         WKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CjNJznFs9piF/QlgUBFdYy3MufW0mZcuOifScsIBWfc=;
        b=7KteN46xAjJxk2GwdWaYLMSv34/O2+z7HoDZO9eBrXWuHy4BQDx1ZST75LEZICB/XO
         0k79K3UJXdpHskgKm+INfKwQY9hL8OSmvONQtmGBW7Tfp7yFNQ4tnCoEWeJYMrRMTVeV
         /nzAMDdURoUPuqyIueqeZb1BQAFZH24MtaovlvaA/hmHLJXOANvtNfLw32jOB/J1tPyM
         AWW9/bfpdXSMte4+mdCEU23iTyE8JdPc8uxmQBHqt+r0FZLXWCYeox+pwPd1g/RmRzeS
         OQA2nvw6t0wb/qkOJKdNxmBEeyt4Fa/uIvhsmQbt/P2A9eeLq1TzlbcXVYmKrrfcURW9
         K4zA==
X-Gm-Message-State: AOAM531u2x6L8ExEU0SVylWX7dLsRCPwIpVDOxGUl4ZBqPELJ3A3iYD7
        IrKEQ3TVSaw/n55iJXylii081ZuvxReT6g==
X-Google-Smtp-Source: ABdhPJyuPWvvoxFeKLMmeoslTr9vKkwsNt+Yur1lIYodYYFPGncRQoHU8Yyc8VqGbKcETC1o06tc3w==
X-Received: by 2002:a63:4f1d:0:b0:3a6:d255:9d7e with SMTP id d29-20020a634f1d000000b003a6d2559d7emr2404031pgb.152.1651304968991;
        Sat, 30 Apr 2022 00:49:28 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:483c:22c0:2c47:6a7d:5be8:bdfa])
        by smtp.gmail.com with ESMTPSA id y15-20020a1709027c8f00b0015e8d4eb225sm818103pll.111.2022.04.30.00.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 00:49:28 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Kaixi Fan <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v6 1/3] bpf: Add source ip in "struct bpf_tunnel_key"
Date:   Sat, 30 Apr 2022 15:48:42 +0800
Message-Id: <20220430074844.69214-2-fankaixi.li@bytedance.com>
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

Add tunnel source ip field in "struct bpf_tunnel_key". Add related code
to set and get tunnel source field.

Signed-off-by: Kaixi Fan <fankaixi.li@bytedance.com>
---
 include/uapi/linux/bpf.h       | 4 ++++
 net/core/filter.c              | 9 +++++++++
 tools/include/uapi/linux/bpf.h | 4 ++++
 3 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 444fe6f1cf35..95a3d1ff6255 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5604,6 +5604,10 @@ struct bpf_tunnel_key {
 	__u8 tunnel_ttl;
 	__u16 tunnel_ext;	/* Padding, future use. */
 	__u32 tunnel_label;
+	union {
+		__u32 local_ipv4;
+		__u32 local_ipv6[4];
+	};
 };
 
 /* user accessible mirror of in-kernel xfrm_state.
diff --git a/net/core/filter.c b/net/core/filter.c
index b741b9f7e6a9..fe0da529d00f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4498,6 +4498,7 @@ BPF_CALL_4(bpf_skb_get_tunnel_key, struct sk_buff *, skb, struct bpf_tunnel_key
 	if (unlikely(size != sizeof(struct bpf_tunnel_key))) {
 		err = -EINVAL;
 		switch (size) {
+		case offsetof(struct bpf_tunnel_key, local_ipv6[0]):
 		case offsetof(struct bpf_tunnel_key, tunnel_label):
 		case offsetof(struct bpf_tunnel_key, tunnel_ext):
 			goto set_compat;
@@ -4523,10 +4524,14 @@ BPF_CALL_4(bpf_skb_get_tunnel_key, struct sk_buff *, skb, struct bpf_tunnel_key
 	if (flags & BPF_F_TUNINFO_IPV6) {
 		memcpy(to->remote_ipv6, &info->key.u.ipv6.src,
 		       sizeof(to->remote_ipv6));
+		memcpy(to->local_ipv6, &info->key.u.ipv6.dst,
+		       sizeof(to->local_ipv6));
 		to->tunnel_label = be32_to_cpu(info->key.label);
 	} else {
 		to->remote_ipv4 = be32_to_cpu(info->key.u.ipv4.src);
 		memset(&to->remote_ipv6[1], 0, sizeof(__u32) * 3);
+		to->local_ipv4 = be32_to_cpu(info->key.u.ipv4.dst);
+		memset(&to->local_ipv6[1], 0, sizeof(__u32) * 3);
 		to->tunnel_label = 0;
 	}
 
@@ -4597,6 +4602,7 @@ BPF_CALL_4(bpf_skb_set_tunnel_key, struct sk_buff *, skb,
 		return -EINVAL;
 	if (unlikely(size != sizeof(struct bpf_tunnel_key))) {
 		switch (size) {
+		case offsetof(struct bpf_tunnel_key, local_ipv6[0]):
 		case offsetof(struct bpf_tunnel_key, tunnel_label):
 		case offsetof(struct bpf_tunnel_key, tunnel_ext):
 		case offsetof(struct bpf_tunnel_key, remote_ipv6[1]):
@@ -4639,10 +4645,13 @@ BPF_CALL_4(bpf_skb_set_tunnel_key, struct sk_buff *, skb,
 		info->mode |= IP_TUNNEL_INFO_IPV6;
 		memcpy(&info->key.u.ipv6.dst, from->remote_ipv6,
 		       sizeof(from->remote_ipv6));
+		memcpy(&info->key.u.ipv6.src, from->local_ipv6,
+		       sizeof(from->local_ipv6));
 		info->key.label = cpu_to_be32(from->tunnel_label) &
 				  IPV6_FLOWLABEL_MASK;
 	} else {
 		info->key.u.ipv4.dst = cpu_to_be32(from->remote_ipv4);
+		info->key.u.ipv4.src = cpu_to_be32(from->local_ipv4);
 	}
 
 	return 0;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 444fe6f1cf35..95a3d1ff6255 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5604,6 +5604,10 @@ struct bpf_tunnel_key {
 	__u8 tunnel_ttl;
 	__u16 tunnel_ext;	/* Padding, future use. */
 	__u32 tunnel_label;
+	union {
+		__u32 local_ipv4;
+		__u32 local_ipv6[4];
+	};
 };
 
 /* user accessible mirror of in-kernel xfrm_state.
-- 
2.20.1

