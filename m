Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1931314911
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 07:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhBIGp2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 01:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhBIGp1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 01:45:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0AC06178A
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 22:44:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q7so20230052wre.13
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 22:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpDUqNF0M4QYO/TuCaiKAW6jXm6UXRKdoVma2CCuAgc=;
        b=FmxEwy1dtHrQCNsO5Ad+8t4ZXG7k4PIXlJJIwEMHXTVVxO99VxX71I57DAxJdRc/Kv
         v7+vteWcZWaheikdDTDqBg7NxhYqR2U1qEqoX/j+0H2M1C3FIputZkapKH3WJqUEgWxb
         aCTke1yb0X5H/mbpLMMitTz0finPCZE0/Ia/631zbq8+KXcdRmyQmSwndCXUoFGkh3cI
         vlO+hjWX3q4JbTPdB3rBLVRxW0JJ2Yi779Yo2Mr21X4N4szIBaa1h1m4YFPl2/kFryLC
         DZd/iIgh8WSZXM/s2H66slpblhJxiu1k5K9k+JONhkESSxTtK5jykFvyFJfl9XX8hcVG
         xzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpDUqNF0M4QYO/TuCaiKAW6jXm6UXRKdoVma2CCuAgc=;
        b=gEZjJKUme5f2BG0MFR+kIqRAmSmcZVK8Lq1AMx5VlV9T5yNxy+674ydKGVjdtR7t+l
         61hbXw4HAlPhpoMEMxpi6i4c/wEuG3k7ApqgW1S4exoQTtt6xsAnpK49qxOr9WpAfq6L
         HSr/iCGROjOfiruGefcE1osksHU60cMcoIp/8pQeJbzQhvOyIgAMyaDupJdnMnOGzr4H
         W5zDVYk7KkghUcEj18nskGj2gICQ+sjNNBvWXYuLBP09exHsNAeziIqPPgpvUrxJ6vaE
         tDGqeApmYCOn9ieUH74tnqNTVWdt5GnOAjOCUZxjyDib/869iwfOSe0uubO0GpoAAD0Y
         jAqg==
X-Gm-Message-State: AOAM5320FULuZ66zcA53qQY0JWvJllq1uOnL7eXjcbFhbzEtKzzeY+xt
        d8BVT4gBBtKwV0ZjZINY1pYjGDyBvkL4QOS2zbw=
X-Google-Smtp-Source: ABdhPJyZu19pMNq6fyvbDkMGjXB7KzRs6tq/BrGFxsCyuUGw5WGwd+4sATBkPL5YzrW6TVkim4M9sw==
X-Received: by 2002:adf:8104:: with SMTP id 4mr11197173wrm.265.1612853086002;
        Mon, 08 Feb 2021 22:44:46 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id o8sm2666677wmc.34.2021.02.08.22.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 22:44:45 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH v2 bpf-next 2/4] bpf: Extract nullable reg type conversion into a helper function
Date:   Tue,  9 Feb 2021 10:44:19 +0400
Message-Id: <20210209064421.15222-3-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209064421.15222-1-me@ubique.spb.ru>
References: <20210209064421.15222-1-me@ubique.spb.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extract conversion from a register's nullable type to a type with a
value. The helper will be used in mark_ptr_not_null_reg().

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
v1 -> v2:
 - Simplify logic for is_null case
 - Add WARN_ON on an uknown nullable register type
 - Use switch instead of ifs

 kernel/bpf/verifier.c | 83 +++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 15694246f854..d68ea6eb4f9b 100644
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
@@ -7373,43 +7418,19 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
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

