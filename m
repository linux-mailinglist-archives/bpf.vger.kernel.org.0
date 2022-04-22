Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3FB50B6BE
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 14:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447145AbiDVMHu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 08:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447320AbiDVMHj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F353A56777
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 05:03:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w16so1376478pfj.2
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 05:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etSSmSqBvg/i+KSC+3duS4cIpCAG7NHljkjr/mgyTwE=;
        b=OIda6ZhfVr6fMoXMmexrXi58Ubq2N7sfoOiEMKHkf2ICW6POUASMRw4IvNk0R8IAeg
         lm+nfdVey+GJABzjyr0t+F9mWRDkM6Jy6v3Yi2+BfstOGI0ocKE615nMGF7NlAHkO7BA
         Vh/RDoeJSykpCYptAB5ZRLo4t8Ue8BgFr86wlq3xb5tt8jMNK5I0fvmHWpKJdqNj0SgG
         5JseOBAA5GuAxBIiFoiN2A2KlNXxiTDI30+OIzFM+F6J6+OfCsCf8+x1Sp4UEFtzJ38K
         aZXosDx5of0tx1R0P8xYZCUbffNfaen8ycF+CHwE9XdrabVaovb+l2i4HfahJdK+oLOe
         vS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etSSmSqBvg/i+KSC+3duS4cIpCAG7NHljkjr/mgyTwE=;
        b=jd0xl/sEEVbTm/fillJprBWDRgL56wb4dKoINkTpOPDgl5Pd8GRbZp0J0kZ9T1lqFU
         ow6nkZcSN7sUHbq+oJaDCKnXqKt4VtGWaBrBp5gWuK3/2g9BN/cp6JqOAcGnmRGawira
         x7Ype/riq2/Uvj350tlFm0La8AOy8apUUVHRDfKnDAdd5aecbFzSddhtaUK8qqMhstqh
         eNJzP9daXIJWHMLrISnO5IgTpjyS6TIaPimaQ5WOO5R1mLSmEBihSEJnX9sLd3zwEAit
         MBey6CCeq5/5uDpCl5owOcyprrCjylS0OfQKcg+Sm6S4lfRyv0wNTfoAZNOBqjvUaHxC
         BcLA==
X-Gm-Message-State: AOAM530/Fcbl8h4E414Z25BKOArNm4XkOhLRjEyhW+163H+8y4Ivbs26
        EV018vhMRT9budBxiYKSWLz5KQ==
X-Google-Smtp-Source: ABdhPJw71lpVJ6hlHcJTLgMq19Et2+8tGBJuhHv4dBK+rc9eND9GePuJYEP3N5UenmpEGpSaYOm1HA==
X-Received: by 2002:a63:7e4b:0:b0:3a5:6636:5b94 with SMTP id o11-20020a637e4b000000b003a566365b94mr3723573pgn.173.1650629020408;
        Fri, 22 Apr 2022 05:03:40 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:4832:de00:7c31:9ae8:33d2:1fe7])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090aac0c00b001cd4989ff41sm5588555pjq.8.2022.04.22.05.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:40 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Kaixi Fan <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v5 1/3] bpf: Add source ip in "struct bpf_tunnel_key"
Date:   Fri, 22 Apr 2022 20:02:57 +0800
Message-Id: <20220422120259.10185-2-fankaixi.li@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220422120259.10185-1-fankaixi.li@bytedance.com>
References: <20220422120259.10185-1-fankaixi.li@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

