Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6564E4346
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 16:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbiCVPoj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 11:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbiCVPoi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 11:44:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADAE8C7EE
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 08:43:10 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a5so18541804pfv.2
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HP0YNW+0u96Ia8rwBJd6p/ML7EekNHcaKnhFQtsT8es=;
        b=Gv4k9Ya4xq/SQucppejn/mKJfTf66S0KPCH+iuOBFNb3raeIzQENeLH6VsFOL2pZtv
         QD/irS+ye5vWw6eJYyaQxByL4iI678tLbFH4HAYuTV7rY/uF06yTLM0dYqQIPHnHgXWz
         fbMepNHWsajrF+iaUU/0AU5nRCpUEvC+u0u3EWAGe6sZPSD4I4/GGd9wQ4nKOagRHZeB
         qjS5RMHrv8+1XkN0KMBDvAr3l9EMaqMOIVIDuSDHoZddOMo432nk6I8Tdmi5nfOmFnOM
         vNLookYWlSRn4GcVQ3OYBZJYthyShFTw35WRH1drfJE+PNu42HzBGZaYDvqFvmZtP9ZP
         th3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HP0YNW+0u96Ia8rwBJd6p/ML7EekNHcaKnhFQtsT8es=;
        b=1SMjYXfmpAU3WSBVrkUTUABqrN0JxXvgevzaUseNkUDAkADwAhRiP52vg/btAyxq0h
         dSpDTN4i1YU53nXbxPaA1HG9JwqADut2n1Pf3VEoxU7iT8FQpEZA3vju7xTxmC3DjnDy
         CZIWoDsb2vbw8wobaUGS5RPDFupaDRgZCY+/8/Gwvs0DonGh+YLzgcg/hJQU5WFjdEZY
         sZvXTu3xyegiirWSD7FroKuThiyca1XBTm25g+pOBGuF7vEcaZnmck4DPZ+NLchTJoHu
         c//VgX1HbAu5XYfJQg8JC+1kuwdpSB+cF0DEt30RXYuotE/jzGKlhNjVJd9+lhurl1rz
         TWoQ==
X-Gm-Message-State: AOAM531LGYsuKvSDyr7qfCjUtbIGKJLpMkKcyVNRX9IGd86EW05B9awp
        CyJ9gscuol6iaRthsK1hQUpCOw==
X-Google-Smtp-Source: ABdhPJzChtBCH+rfC3qu7y3C6AlqxCPDV6F4ydl/WWBoWGxkiUfOipM+wz8Pp2oZQBi9EzQOxumjkQ==
X-Received: by 2002:a05:6a02:184:b0:373:a24e:5ab with SMTP id bj4-20020a056a02018400b00373a24e05abmr22317679pgb.400.1647963790299;
        Tue, 22 Mar 2022 08:43:10 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:483a:72c0:3435:f390:36c7:be7a])
        by smtp.gmail.com with ESMTPSA id d14-20020a056a0024ce00b004f7281cda21sm24719158pfv.167.2022.03.22.08.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 08:43:09 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, andrii@kernel.org,
        "kaixi.fan" <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v2 1/3] bpf: Add source ip in "struct bpf_tunnel_key"
Date:   Tue, 22 Mar 2022 23:42:29 +0800
Message-Id: <20220322154231.55044-2-fankaixi.li@bytedance.com>
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

Add tunnel source ip field in "struct bpf_tunnel_key".
Add code in "bpf_skb_set_tunnel_key" and "bpf_skb_get_tunnel_key" to set
and get this field based on the tunnel key from "struct ip_tunnel_info".

Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>
---
 include/uapi/linux/bpf.h       | 4 ++++
 net/core/filter.c              | 9 +++++++++
 tools/include/uapi/linux/bpf.h | 4 ++++
 3 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4eebea830613..3007d3bc1f7a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5562,6 +5562,10 @@ struct bpf_tunnel_key {
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
index 88767f7da150..cbd8471f4db4 100644
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
index 4eebea830613..3007d3bc1f7a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5562,6 +5562,10 @@ struct bpf_tunnel_key {
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
2.24.3 (Apple Git-128)

