Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD331A658
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 21:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhBLU5y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 15:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhBLU5m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 15:57:42 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B732C061786
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 12:57:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id g10so861261wrx.1
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 12:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VkeQ4sHYCqEVYcX9t1pqyz1UsRgr3a5a2E4u9FREoSY=;
        b=iNcUhQr8kaNVc9qo5G4egczPnS3nDEQr4C1aIAW+84R4pD4RTXi1EtA7Q6fZW9wcxu
         b727nizEkQ7QzX28++gfgLdVS6d2Ey65eJjVQhv8X+dPSQAjvSyKMt6W1+K0qwdDqvEo
         YofHa2aCgV1Z1qulbS+9ED7btHjJbCKCVf3VW672xDBIDvq48mcBbhMM23S6GSm0jj7P
         T/YJzjqReYV9Z5BAwxXnVQ2Y643Oav738p/jPxSRdfNRTgaG0D/Ugp1XKmT5DtlDbO+t
         lBfool4aOzFkT93LsVtFnHQP94mCR+BzxTeI4J8dpBoIjmayHKB29DXVAWeVSIQu9kVg
         bgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkeQ4sHYCqEVYcX9t1pqyz1UsRgr3a5a2E4u9FREoSY=;
        b=SqAEDIXna6Iinva/lefv6YSp6kBWlAJnBvoGXzLwqnA1iJrUpy6WHW5F+1Ej3RNatP
         9Pdv3PEktm7DFoQS1ahvrQtIi2M3RXc34VhKIhAwdyHQIU7IJUMZuI1XeHVLClVCi1x1
         UXzhqLkrqeOpA03orDDtSMkf5v0F5KDB4H4deWgbKjmj0TZVsQbrvqZLG5nFijTnsWb/
         DXt5pYo/BGFZb+G+1SIaZm3qEfXJRYjOKF3w68tMqM8YLGBMgnK7P70V1gJpkO15dZ+I
         w+uHB0faMDuySDTAlan5WpGpWJpPr008NTqwNyPRb1Ayipam52LlQb+pqaVtl4fEcO6m
         BIhg==
X-Gm-Message-State: AOAM531wEp0y1deFpn51n6zvJdI9/jODMVuZA9LtLmIY2RvgGzFxXinj
        kKxft/a5sC2P1nzxANLW3IRsmu3Rh+9Q0h06VYM=
X-Google-Smtp-Source: ABdhPJx1aSWEOTSn3ZhAbOqV4wF1o5Va6m7GR94Y+67bYIU8ph1tquk6KdHuaM7Mo7OF76sExhXHvA==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr5677625wrd.118.1613163421093;
        Fri, 12 Feb 2021 12:57:01 -0800 (PST)
Received: from localhost ([91.73.148.48])
        by smtp.gmail.com with ESMTPSA id w8sm11755549wrm.21.2021.02.12.12.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 12:57:00 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH v3 bpf-next 2/4] bpf: Extract nullable reg type conversion into a helper function
Date:   Sat, 13 Feb 2021 00:56:40 +0400
Message-Id: <20210212205642.620788-3-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210212205642.620788-1-me@ubique.spb.ru>
References: <20210212205642.620788-1-me@ubique.spb.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extract conversion from a register's nullable type to a type with a
value. The helper will be used in mark_ptr_not_null_reg().

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 kernel/bpf/verifier.c | 83 +++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 15c15ea0abf5..e391ed325249 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1079,6 +1079,51 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
 	__mark_reg_known_zero(regs + regno);
 }
 
+static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
+{
+	switch (reg->type) {
+	case PTR_TO_MAP_VALUE_OR_NULL: {
+		const struct bpf_map *map = reg->map_ptr;
+
+		if (map->inner_map_meta) {
+			reg->type = CONST_PTR_TO_MAP;
+			reg->map_ptr = map->inner_map_meta;
+		} else if (map->map_type == BPF_MAP_TYPE_XSKMAP) {
+			reg->type = PTR_TO_XDP_SOCK;
+		} else if (map->map_type == BPF_MAP_TYPE_SOCKMAP ||
+			   map->map_type == BPF_MAP_TYPE_SOCKHASH) {
+			reg->type = PTR_TO_SOCKET;
+		} else {
+			reg->type = PTR_TO_MAP_VALUE;
+		}
+		break;
+	}
+	case PTR_TO_SOCKET_OR_NULL:
+		reg->type = PTR_TO_SOCKET;
+		break;
+	case PTR_TO_SOCK_COMMON_OR_NULL:
+		reg->type = PTR_TO_SOCK_COMMON;
+		break;
+	case PTR_TO_TCP_SOCK_OR_NULL:
+		reg->type = PTR_TO_TCP_SOCK;
+		break;
+	case PTR_TO_BTF_ID_OR_NULL:
+		reg->type = PTR_TO_BTF_ID;
+		break;
+	case PTR_TO_MEM_OR_NULL:
+		reg->type = PTR_TO_MEM;
+		break;
+	case PTR_TO_RDONLY_BUF_OR_NULL:
+		reg->type = PTR_TO_RDONLY_BUF;
+		break;
+	case PTR_TO_RDWR_BUF_OR_NULL:
+		reg->type = PTR_TO_RDWR_BUF;
+		break;
+	default:
+		WARN_ON("unknown nullable register type");
+	}
+}
+
 static bool reg_is_pkt_pointer(const struct bpf_reg_state *reg)
 {
 	return type_is_pkt_pointer(reg->type);
@@ -7737,43 +7782,19 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 		}
 		if (is_null) {
 			reg->type = SCALAR_VALUE;
-		} else if (reg->type == PTR_TO_MAP_VALUE_OR_NULL) {
-			const struct bpf_map *map = reg->map_ptr;
-
-			if (map->inner_map_meta) {
-				reg->type = CONST_PTR_TO_MAP;
-				reg->map_ptr = map->inner_map_meta;
-			} else if (map->map_type == BPF_MAP_TYPE_XSKMAP) {
-				reg->type = PTR_TO_XDP_SOCK;
-			} else if (map->map_type == BPF_MAP_TYPE_SOCKMAP ||
-				   map->map_type == BPF_MAP_TYPE_SOCKHASH) {
-				reg->type = PTR_TO_SOCKET;
-			} else {
-				reg->type = PTR_TO_MAP_VALUE;
-			}
-		} else if (reg->type == PTR_TO_SOCKET_OR_NULL) {
-			reg->type = PTR_TO_SOCKET;
-		} else if (reg->type == PTR_TO_SOCK_COMMON_OR_NULL) {
-			reg->type = PTR_TO_SOCK_COMMON;
-		} else if (reg->type == PTR_TO_TCP_SOCK_OR_NULL) {
-			reg->type = PTR_TO_TCP_SOCK;
-		} else if (reg->type == PTR_TO_BTF_ID_OR_NULL) {
-			reg->type = PTR_TO_BTF_ID;
-		} else if (reg->type == PTR_TO_MEM_OR_NULL) {
-			reg->type = PTR_TO_MEM;
-		} else if (reg->type == PTR_TO_RDONLY_BUF_OR_NULL) {
-			reg->type = PTR_TO_RDONLY_BUF;
-		} else if (reg->type == PTR_TO_RDWR_BUF_OR_NULL) {
-			reg->type = PTR_TO_RDWR_BUF;
-		}
-		if (is_null) {
 			/* We don't need id and ref_obj_id from this point
 			 * onwards anymore, thus we should better reset it,
 			 * so that state pruning has chances to take effect.
 			 */
 			reg->id = 0;
 			reg->ref_obj_id = 0;
-		} else if (!reg_may_point_to_spin_lock(reg)) {
+
+			return;
+		}
+
+		mark_ptr_not_null_reg(reg);
+
+		if (!reg_may_point_to_spin_lock(reg)) {
 			/* For not-NULL ptr, reg->ref_obj_id will be reset
 			 * in release_reg_references().
 			 *
-- 
2.25.1

