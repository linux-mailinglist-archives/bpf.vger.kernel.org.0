Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103522DA0E5
	for <lists+bpf@lfdr.de>; Mon, 14 Dec 2020 20:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502859AbgLNTyB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 14:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502856AbgLNTx7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 14:53:59 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E37C0613D3
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 11:53:18 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id dk8so18515544edb.1
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 11:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31fJCR82BsbBke40rmpflWa3sSApV5mPUqlCTPLF8jo=;
        b=XrB5QRzVm6IDnKBHYOni3pOhJ6KFsgoMOCIkM57TkA/IphuZp/VmULohoWtTjALPj6
         Dbzls6SnxvFqnoEyBlApfojsEVl4HNT9LD7/xNBsJE5pSxaqdjBSuVddomRKrLoj4deT
         Ta5b9XAIPAAmGkiOVCGen85v1UqxONe3tyZqGOuYR7LuJjywtKyJyizA6uLCQ19mYDCq
         4debtR5t4GcHNaNeFQKGGBuUkBVKCv53h+ZqRibId7v4H5twhlFtHRKeGE1vEoDhmi+5
         0dm6Hsr+bM5uwsU9a4uGs5mf8zM4WKfcPQhwAhLkgTbIyI56/2RKwKG1tnaVeG0vJMwJ
         IrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31fJCR82BsbBke40rmpflWa3sSApV5mPUqlCTPLF8jo=;
        b=bLhdYcGpSgQ6VMRcQ8yLoUA0hJvbKwI71kzJMnE6LGYx1Mli8TiVsMFGSVN2v43dUY
         u3uiPxSNJf2k9KPuIOpl5EpU1Tg32uHb+2qZeAL5Ot/E8t0exijvYCsT20xXy913yy7r
         QwdWNDK6QyJGrWCFL26daSsKMPn/jwlVkgVWeV5NP6p81PsfIrU8Ore3tnEqli0pK+Pv
         1h0aJWcV6d4tpYkkeIy9e6SkVNf4MiqnZTWiyDSRCghVlyOhl0NS+3NIkZl/B98Iq4Tz
         IIC4USPGayqWiLpWeL84uyGA4f8ddGKVWxiR6+N9k6lrcnRTB7koVM4XKkNMMlcfJ8o6
         cj4w==
X-Gm-Message-State: AOAM532Dds9+vlJ64fE7wfDfU/SmXJT5z8wOUU46YOXObr6UscUUp0U4
        3vx51vCv+3K6aBbvkz+WOyoRiE16KIg+iSMUCmw=
X-Google-Smtp-Source: ABdhPJxI/YKISoFcvucVLx2AQXGLgI4YvixH63+FqkN2Dkx3kR6D3i+VuYVpMDcg5Z8PdlT0tsCIRQ==
X-Received: by 2002:aa7:da01:: with SMTP id r1mr26847786eds.45.1607975596958;
        Mon, 14 Dec 2020 11:53:16 -0800 (PST)
Received: from localhost (bba163592.alshamil.net.ae. [217.165.22.16])
        by smtp.gmail.com with ESMTPSA id j7sm16849273edp.52.2020.12.14.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:53:16 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH bpf-next 1/3] bpf: Factor out nullable reg type conversion
Date:   Mon, 14 Dec 2020 23:52:48 +0400
Message-Id: <0ff8927166f6e18e72adab8a94cb6d694c610cc0.1607973529.git.me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1607973529.git.me@ubique.spb.ru>
References: <cover.1607973529.git.me@ubique.spb.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Factor out helper function for conversion nullable register type to its
corresponding type with value.

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 kernel/bpf/verifier.c | 77 ++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 93def76cf32b..dee296dbc7a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1073,6 +1073,43 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
 	__mark_reg_known_zero(regs + regno);
 }
 
+static int mark_ptr_not_null_reg(struct bpf_reg_state *reg)
+{
+	if (reg->type == PTR_TO_MAP_VALUE_OR_NULL) {
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
+	} else if (reg->type == PTR_TO_SOCKET_OR_NULL) {
+		reg->type = PTR_TO_SOCKET;
+	} else if (reg->type == PTR_TO_SOCK_COMMON_OR_NULL) {
+		reg->type = PTR_TO_SOCK_COMMON;
+	} else if (reg->type == PTR_TO_TCP_SOCK_OR_NULL) {
+		reg->type = PTR_TO_TCP_SOCK;
+	} else if (reg->type == PTR_TO_BTF_ID_OR_NULL) {
+		reg->type = PTR_TO_BTF_ID;
+	} else if (reg->type == PTR_TO_MEM_OR_NULL) {
+		reg->type = PTR_TO_MEM;
+	} else if (reg->type == PTR_TO_RDONLY_BUF_OR_NULL) {
+		reg->type = PTR_TO_RDONLY_BUF;
+	} else if (reg->type == PTR_TO_RDWR_BUF_OR_NULL) {
+		reg->type = PTR_TO_RDWR_BUF;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool reg_is_pkt_pointer(const struct bpf_reg_state *reg)
 {
 	return type_is_pkt_pointer(reg->type);
@@ -7323,50 +7360,24 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
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
-			/* For not-NULL ptr, reg->ref_obj_id will be reset
+		} else {
+			mark_ptr_not_null_reg(reg);
+
+			if (!reg_may_point_to_spin_lock(reg)) {
+				/* For not-NULL ptr, reg->ref_obj_id will be reset
 			 * in release_reg_references().
 			 *
 			 * reg->id is still used by spin_lock ptr. Other
 			 * than spin_lock ptr type, reg->id can be reset.
 			 */
-			reg->id = 0;
+				reg->id = 0;
+			}
 		}
 	}
 }
-- 
2.25.1

