Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2265047E1
	for <lists+bpf@lfdr.de>; Sun, 17 Apr 2022 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiDQNXb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Apr 2022 09:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQNXa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 17 Apr 2022 09:23:30 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9FB140CD
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 06:20:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t13so14388921pgn.8
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etSSmSqBvg/i+KSC+3duS4cIpCAG7NHljkjr/mgyTwE=;
        b=pq027EyvgTw3xCC4emBr+yAF83WEH5uJu0oEMKGecFNPQuAgobdPJ4S/w2Cnc6xrer
         MsS5rgCZ2aZyxnkVk48vFMdyV3jNtKWja3dqGwNqjPJthnd/5YR9jVZDyPvCtjIEOCyr
         9t6Ni3f04rwu3GfjsbUVl1up8+/oqE2VinnSt++Kflgbdsu56Udh0dNJmX7epM0YSks0
         5xs8hg5wc/mGkEWsmkDCXZHlBfGz7WwR4vsCsvtzOMOVTobY0FKy1+ndzj4PqpyhCafp
         PYLf9JpFL0AF5Nxwl10g0OQh7ubhC7avtotlPUOXVfn+KypBQ85cplPioB0RifJJkL8K
         XFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etSSmSqBvg/i+KSC+3duS4cIpCAG7NHljkjr/mgyTwE=;
        b=XtJ5Jv0LlPFDvXWUUk2d6vtkbOvn14jeaa8DIO/7cLYxQ6atS5gIlxTH8jqil3Sk96
         6vXOB8Bs6Pq2oq3U1jhJSego7fTW8KWXlfI0slWNSztBpV5tk5LR9cL8vE6jSrX/8zD6
         VxvRXkpGs2w6yv7JV/8Pdvtr+oQLtan48hia10/4BVBiwUMrCOFsAA7lH/ejLNzN6Pfo
         kxohlUvmwQJAHqPs3/0jJO+hzawbCM72y4n8Fp0QYj8mBWetSaE+qzmQVDQ7UgQmdqCu
         YNt2qpHExbb8PiW1EZN8hHLXBKZ+/wzsg1sMHGmwmTDi54kP6KOpd5c0ZMPOVC53lqoN
         t2tQ==
X-Gm-Message-State: AOAM532lkvzG6adhQykmGC0Jyzb/OT6PZirPBNSLnCgUjgvrbywrZGap
        g3e4cuhrWxf10LsD3mCEuDa6Xg==
X-Google-Smtp-Source: ABdhPJz4dS8vB7mShKQSL1VrBeFqXeLCiVBO7/gPLLkwGlBnfdWaX5W8wn6tGWh8nicgl7CK30+BYw==
X-Received: by 2002:a63:fc05:0:b0:3a9:f17d:3f4f with SMTP id j5-20020a63fc05000000b003a9f17d3f4fmr1045754pgi.590.1650201654866;
        Sun, 17 Apr 2022 06:20:54 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:4832:de00:bc27:698e:1fca:c5bb])
        by smtp.gmail.com with ESMTPSA id l10-20020a17090aec0a00b001d27f7fb42csm1936907pjy.13.2022.04.17.06.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 06:20:54 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Kaixi Fan <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v3 1/3] bpf: Add source ip in "struct bpf_tunnel_key"
Date:   Sun, 17 Apr 2022 21:20:28 +0800
Message-Id: <20220417132030.17067-2-fankaixi.li@bytedance.com>
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

