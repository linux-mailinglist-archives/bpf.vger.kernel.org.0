Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1C5504A79
	for <lists+bpf@lfdr.de>; Mon, 18 Apr 2022 03:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiDRBee (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Apr 2022 21:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbiDRBee (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 17 Apr 2022 21:34:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6042F17E34
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 18:31:57 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t4so16188103pgc.1
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 18:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etSSmSqBvg/i+KSC+3duS4cIpCAG7NHljkjr/mgyTwE=;
        b=P3+dB8afxPBIuDn62ccMJ8xHilCfLS8oH70W9snmKU8NmIK/r0J+5geExQpTITNmM6
         wVg3RLXq/rfqDpi3J1WcPngJxhy7woIWdg1nCpmMziACTO61XyL00HxbqcQvUnDohOC2
         ZcpLvwnrCoRjgU04JjProZWJKRdeXD8n0TIzSSNr6L77+gKOIUR/COSwOd9G1Pd+k6wh
         gfNWr3x+EekuiNPvXeh0x6+o2q/BytXClQyftqc0D75CCO5+8xF0/M7hZ/RUG2kIQDgo
         2J1WL0L1Cady1yk4bDN1Xb+QJYzGTZRz6mx0uU5qw5xPVE07AEwGvDsOh4BsxjXNppCE
         U/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etSSmSqBvg/i+KSC+3duS4cIpCAG7NHljkjr/mgyTwE=;
        b=bHaHJO1bGnI+jWNHh/QKJf/vjSpqTHs8iio4C4o+eN+cW/tqs+kEfX56EJaYQBED/n
         5kO++oCAw4v8MaYybCBVy2N9k70AEM0cjVkj8pz8rYP8K10JpY+wgk3RrPEok7mxdn9V
         4uIw+vbo/hM/gglbdJ2Pj19WSi0BTu3TtiEMbqtbkNr4sVGFH9JvAenKDK/f/r3047UJ
         wVnNZT3J2Cy+qG6JB6cOHJseil0WRGicHpr53iIiHJfC+faM2es3zI9QxPZqx3Tffn55
         D7fwhPiyUyHYbE4nPGPGLpgakVA33AHeMDV2XbSqPcToB40c3rrmtduwCVqwdPfb4Drl
         9QXw==
X-Gm-Message-State: AOAM533hVnRl1UfMvaXeY/+KBTErPoe20lHovf7TwotBPAD/H8JrbEEe
        8nGyrJYi+Uyyoi82H6g7wjsA0A==
X-Google-Smtp-Source: ABdhPJxVlVSToqIj7YArllKBO5ZYHFN61n08U4TJxYmggdVOmKuC2gR+HwRTmXKwPW8PCs1t/Cstog==
X-Received: by 2002:a05:6a00:24cf:b0:508:3278:8c21 with SMTP id d15-20020a056a0024cf00b0050832788c21mr9819090pfv.57.1650245516924;
        Sun, 17 Apr 2022 18:31:56 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:4832:de00:590a:cbcb:f71b:54e5])
        by smtp.gmail.com with ESMTPSA id c2-20020a63a442000000b0039cc5a6af1csm10807333pgp.30.2022.04.17.18.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 18:31:56 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Kaixi Fan <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v4 1/3] bpf: Add source ip in "struct bpf_tunnel_key"
Date:   Mon, 18 Apr 2022 09:31:34 +0800
Message-Id: <20220418013136.26098-2-fankaixi.li@bytedance.com>
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

Add tunnel source ip field in "struct bpf_tunnel_key". Add related code
to set and get tunnel source field.

Signed-off-by: Kaixi Fan <fankaixi.li@bytedance.com>
---
 include/uapi/linux/bpf.h       | 4 ++++
 net/core/filter.c              | 9 +++++++++
 tools/include/uapi/linux/bpf.h | 4 ++++
 3 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d14b10b85e51..dca2c29746ab 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5592,6 +5592,10 @@ struct bpf_tunnel_key {
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
index 143f442a9505..2c89d8dea826 100644
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
index d14b10b85e51..dca2c29746ab 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5592,6 +5592,10 @@ struct bpf_tunnel_key {
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

