Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE8C5A806E
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 16:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiHaOkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 10:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiHaOkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 10:40:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E496B178
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 07:40:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so8121363wms.5
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 07:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=HWdOrGZSqpM8AqTLpomSymY1vHAqULXeHUWNRw9A/8g=;
        b=P2iV13CFymQy5eA08gqURDQUroxtF3kPunSryej9MlGDPctact306mum2MPAON1yT9
         1lIU+FGjsF2apL57+Xnn81S7KwiCvTwRXEGOdtAH1fR7o9PZ2opETkGK9r7AE9Y6U1sx
         8kc5LYQvfDviqEfAeRz+qmDqhvzcUyEA/ae/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=HWdOrGZSqpM8AqTLpomSymY1vHAqULXeHUWNRw9A/8g=;
        b=T2/5TvUzJe9rlEhZuyL/s533DfRCikxQyswNu3jpJaqWDGdqX7nxhOvMs4eqGb67Md
         T3Hic2AL3gcdaJYh5e8wBuCZB1eYFc5Trw1JGrpxA1s6eD9e6r29sQGbSTvf8078fmI7
         6fg1Z6Yov87pf/FgXTNeXR/jdPPlHEM0U/onub3/9x1w2plJF3t5lzXW7YFptlQoPsa4
         A9e4w1AkGfH7iMXt+TIGyftafTb6s5ek1nCMLmJzQqD93KFP42b8JKiBBoAnSrJl3+H5
         y+YBo5CwudEmKrGjSCdHHGqLAuJjjBTlidyIEpe71BveCzMQGpeRCQ8zPt0vBINYpihj
         LYRA==
X-Gm-Message-State: ACgBeo3n4+Mxb1cDP0ZnVJmo9qmfzvLhDXtR0m0b6Hu4K1niSGxJkRii
        KBWxLA+0qDj8ZGJFGqZW4pxQMXCmaHhbNeZmVgJA8VAQuqVrViip7Ctjc/xI38kqTS2OGaV+zAI
        StdwkDl0yN2u8n2OpDJKbjTaqmwD+XhtDRHetBDd9NPbNuWRj7g9TyqKSUuHjruORhfaPRjBs
X-Google-Smtp-Source: AA6agR5Hy41st5299M36ad0UzjkozueaOwqbQUR93R+/pD8p73TGp/Kl+CK5EKQyL+0J5SEJkt9QEQ==
X-Received: by 2002:a05:600c:89a:b0:3a5:4ea9:d5ee with SMTP id l26-20020a05600c089a00b003a54ea9d5eemr2257299wmp.8.1661956816016;
        Wed, 31 Aug 2022 07:40:16 -0700 (PDT)
Received: from blondie.home ([5.102.239.127])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c424900b003a61306d79dsm2239315wmm.41.2022.08.31.07.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 07:40:15 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Support getting tunnel flags
Date:   Wed, 31 Aug 2022 17:40:09 +0300
Message-Id: <20220831144010.174110-1-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Existing 'bpf_skb_get_tunnel_key' extracts various tunnel parameters
(id, ttl, tos, local and remote) but does not expose ip_tunnel_info's
tun_flags to the bpf program.

It makes sense to expose tun_flags to the bpf program.

Assume for example multiple GRE tunnels maintained on a single GRE
interface in collect_md mode. The program expects origins to initiate
over GRE, however different origins use different GRE characteristics
(e.g. some prefer to use GRE checksum, some do not; some pass a GRE key,
some do not, etc..).

A bpf program getting tun_flags can therefore remember the relevant
flags (e.g. TUNNEL_CSUM, TUNNEL_SEQ...) for each initiating remote.
In the reply path, the program can use 'bpf_skb_set_tunnel_key' in order
to correctly reply to the remote, using similar characteristics, based on
the stored tunnel flags.

Introduce BPF_F_TUNINFO_FLAGS flag for bpf_skb_get_tunnel_key.
If specified, 'bpf_tunnel_key->tunnel_flags' is set with the tun_flags.

Decided to use the existing unused 'tunnel_ext' as the storage for the
'tunnel_flags' in order to avoid changing bpf_tunnel_key's layout.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
 include/uapi/linux/bpf.h       | 10 +++++++++-
 net/core/filter.c              |  8 ++++++--
 tools/include/uapi/linux/bpf.h | 10 +++++++++-
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 962960a98835..837c0f9b7fdd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5659,6 +5659,11 @@ enum {
 	BPF_F_SEQ_NUMBER		= (1ULL << 3),
 };
 
+/* BPF_FUNC_skb_get_tunnel_key flags. */
+enum {
+	BPF_F_TUNINFO_FLAGS		= (1ULL << 4),
+};
+
 /* BPF_FUNC_perf_event_output, BPF_FUNC_perf_event_read and
  * BPF_FUNC_perf_event_read_value flags.
  */
@@ -5848,7 +5853,10 @@ struct bpf_tunnel_key {
 	};
 	__u8 tunnel_tos;
 	__u8 tunnel_ttl;
-	__u16 tunnel_ext;	/* Padding, future use. */
+	union {
+		__u16 tunnel_ext;	/* compat */
+		__be16 tunnel_flags;
+	};
 	__u32 tunnel_label;
 	union {
 		__u32 local_ipv4;
diff --git a/net/core/filter.c b/net/core/filter.c
index 63e25d8ce501..74e2a4a0d747 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4488,7 +4488,8 @@ BPF_CALL_4(bpf_skb_get_tunnel_key, struct sk_buff *, skb, struct bpf_tunnel_key
 	void *to_orig = to;
 	int err;
 
-	if (unlikely(!info || (flags & ~(BPF_F_TUNINFO_IPV6)))) {
+	if (unlikely(!info || (flags & ~(BPF_F_TUNINFO_IPV6 |
+					 BPF_F_TUNINFO_FLAGS)))) {
 		err = -EINVAL;
 		goto err_clear;
 	}
@@ -4520,7 +4521,10 @@ BPF_CALL_4(bpf_skb_get_tunnel_key, struct sk_buff *, skb, struct bpf_tunnel_key
 	to->tunnel_id = be64_to_cpu(info->key.tun_id);
 	to->tunnel_tos = info->key.tos;
 	to->tunnel_ttl = info->key.ttl;
-	to->tunnel_ext = 0;
+	if (flags & BPF_F_TUNINFO_FLAGS)
+		to->tunnel_flags = info->key.tun_flags;
+	else
+		to->tunnel_ext = 0;
 
 	if (flags & BPF_F_TUNINFO_IPV6) {
 		memcpy(to->remote_ipv6, &info->key.u.ipv6.src,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f4ba82a1eace..793103b10eab 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5659,6 +5659,11 @@ enum {
 	BPF_F_SEQ_NUMBER		= (1ULL << 3),
 };
 
+/* BPF_FUNC_skb_get_tunnel_key flags. */
+enum {
+	BPF_F_TUNINFO_FLAGS		= (1ULL << 4),
+};
+
 /* BPF_FUNC_perf_event_output, BPF_FUNC_perf_event_read and
  * BPF_FUNC_perf_event_read_value flags.
  */
@@ -5848,7 +5853,10 @@ struct bpf_tunnel_key {
 	};
 	__u8 tunnel_tos;
 	__u8 tunnel_ttl;
-	__u16 tunnel_ext;	/* Padding, future use. */
+	union {
+		__u16 tunnel_ext;	/* compat */
+		__be16 tunnel_flags;
+	};
 	__u32 tunnel_label;
 	union {
 		__u32 local_ipv4;
-- 
2.37.2

