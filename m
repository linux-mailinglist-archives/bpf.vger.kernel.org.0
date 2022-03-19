Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A7A4DE819
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 14:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiCSNHX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 09:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239864AbiCSNHV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 09:07:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB5525DAB0
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 06:05:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p5so5687016pfo.5
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 06:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HP0YNW+0u96Ia8rwBJd6p/ML7EekNHcaKnhFQtsT8es=;
        b=I3il8GrQfe/e/Vo6r8XUBgv0dLjzc1+j8icdM90ZnR/l4fpENH2o7ZFwHkWvNqDxN6
         llNfbY7FcJhM4cI2V805POCJ2H7ezW/+6HsNP3QJGmKzhCL569EDKLDoDvkSyxW5AfuG
         0l3QYjM1taibWggJqW3gSv8WZvf6oQVeHGHqGpIai1LcfB7dwnUcAQvopcmXJtVsfvW2
         CeBzG/mgsNvd9jKnDkQNatpTLe9rm2IGIyigvztjjGk0uHerCAYhxD+sNCHjSmXnVxqY
         99DgmdrRnw9heeD1jfMAZewVvoZE31jm1aIxWU55B7Jh+gUJf1ooNthCqlJ+bsQfUTuP
         GSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HP0YNW+0u96Ia8rwBJd6p/ML7EekNHcaKnhFQtsT8es=;
        b=4WxU193XNS/JlFp+T7J8EbjvkjI8weGYGwjOiDp2ltm/0wuGv1NmlYHs3YLwNry4fL
         0cYJINxNepIqGw4dC1ZbgUOhsEeO7hq0o3CLaw9ZhLKWNQ4QwYHyTTbA+pgPPgBRoxxb
         f8KVtj/7QXFpig6TEg8UsqsXfXdV764DjL7BCt/RneCES1T0yNLKLBkjw5TfmTORcj2o
         X6t/Kt5sxqWU+3bvvB8EVbXDoqWnRePkixfmEAblFU8/rVBu5arEY1OND/gqbEe3rkv/
         aYk+r7GZsqpsiEBIdmC83T7WPEcivVOTFQrbXe0CFxgqb0S1YeJgF4AFjdF8AaoYL7vm
         E44g==
X-Gm-Message-State: AOAM531cOgflAlpaadfsugWgU8ezsQnrezvLAjFq8C//NYsubz2UuCcH
        XL47t0tlghAEtj96u3q5OY+ahA==
X-Google-Smtp-Source: ABdhPJz2vO6FtVbgacZVIB88QfyR0bfokeYzB+rKD329m0gcyHUnVhjK7URU45RDqFalbBPueKlITQ==
X-Received: by 2002:a05:6a00:1a11:b0:4f7:bf07:c068 with SMTP id g17-20020a056a001a1100b004f7bf07c068mr14851221pfv.81.1647695156718;
        Sat, 19 Mar 2022 06:05:56 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:483a:72c0:bdf5:8ebe:6be8:a257])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a000acb00b004f35ee129bbsm14007797pfl.140.2022.03.19.06.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 06:05:56 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     john.fastabend@gmail.com, kafai@fb.com, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        "kaixi.fan" <fankaixi.li@bytedance.com>
Subject: [PATCH bpf-next 1/3] bpf: Add source ip in "struct bpf_tunnel_key"
Date:   Sat, 19 Mar 2022 21:05:36 +0800
Message-Id: <20220319130538.55741-2-fankaixi.li@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220319130538.55741-1-fankaixi.li@bytedance.com>
References: <20220319130538.55741-1-fankaixi.li@bytedance.com>
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

