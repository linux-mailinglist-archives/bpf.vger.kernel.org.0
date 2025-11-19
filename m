Return-Path: <bpf+bounces-75111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D311C71564
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 23:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B17CC4E5288
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 22:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E2B32F771;
	Wed, 19 Nov 2025 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="tXEnrd0F"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881FD32C92B;
	Wed, 19 Nov 2025 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592166; cv=none; b=tcNEuFkJwTpWSBQTajwj5kQxd8k+vSvFz0ATSysNuvgrWFU5QNu3VYfjBqFU0S8N9eSFUbFRkA2v8BFyFxMhWNFyZmGWDwrHRSn7CwcY6RMaX2O6v3nzP4qfiubPRp1EitX/6akIaYYyjV+xBLk6bPoMWfEO0A9da6T+pabJ/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592166; c=relaxed/simple;
	bh=p/DR/FykffMserbGV6pix+DJEuXiCs5JkS8z/3JAX+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZ0K4UilTvcq09WN+TShdlxuCJPG+Qb3GT3KLOe7SaOVE9ynldDNSlfLLb+G0azY13Mli5WwnmeWnYF+QG+zQm8J0F4zrjcnRZizPmvHXY1pQic/04l3C78aQdUnDue/SNf0mjif7sWHB43QMJXYyW+5ek2ZJEEflyinCtRejhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=tXEnrd0F; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqss-006ktm-Ml; Wed, 19 Nov 2025 23:42:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=zMBuIAwUIhlU23riZVslwHF2pmtSGAEsu39ThErsacM=; b=tXEnrd0FsCIeJdJS23xtND5qma
	/nyz4LKFnCGT8cX0llevptwGUar6RlozBMNTjjI4qSDiv6Zo3IWFBbZyCjadX3oTN0HTvoszmtMCw
	Ub7syVi2ALmfPGqC1wAb//U7KFTiTI1m+E1k7vJsN/qI4QPZJsL7u7JX4xLDsmgeuuDubF4z0u6wL
	kf9iNyvkpqoJNzSUgoAmDW5sOdAYLdawnePjuCd01vo4lwZ7AKFPOhf8X6tkAPVr6rJMeFFTAgdVU
	XBfPiHxne2fNsTCHc39RFot23sa3jacc9UZdHGfYEmS5hc9aYhXQJ1n8hMzFVDN9YWGFtULZd5Zsp
	0fbgnv9g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsr-0000Bm-85; Wed, 19 Nov 2025 23:42:42 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsW-00Fos6-Mx; Wed, 19 Nov 2025 23:42:20 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 06/44] bpf: Verifier, remove some unusual uses of min_t() and max_t()
Date: Wed, 19 Nov 2025 22:41:02 +0000
Message-Id: <20251119224140.8616-7-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

min_t() and max_t() are normally used to change the signedness
of a positive value to avoid a signed-v-unsigned compare warning.

However they are used here to convert an unsigned 64bit pattern
to a signed to a 32/64bit signed number.
To avoid any confusion use plain min()/max() and explicitely cast
the u64 expression to the correct signed value.

Use a simple max() for the max_pkt_offset calulation and delete the
comment about why the cast to u32 is safe.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 kernel/bpf/verifier.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff40e5e65c43..22fa9769fbdb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2319,12 +2319,12 @@ static void __update_reg32_bounds(struct bpf_reg_state *reg)
 	struct tnum var32_off = tnum_subreg(reg->var_off);
 
 	/* min signed is max(sign bit) | min(other bits) */
-	reg->s32_min_value = max_t(s32, reg->s32_min_value,
-			var32_off.value | (var32_off.mask & S32_MIN));
+	reg->s32_min_value = max(reg->s32_min_value,
+			(s32)(var32_off.value | (var32_off.mask & S32_MIN)));
 	/* max signed is min(sign bit) | max(other bits) */
-	reg->s32_max_value = min_t(s32, reg->s32_max_value,
-			var32_off.value | (var32_off.mask & S32_MAX));
-	reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)var32_off.value);
+	reg->s32_max_value = min(reg->s32_max_value,
+			(s32)(var32_off.value | (var32_off.mask & S32_MAX)));
+	reg->u32_min_value = max(reg->u32_min_value, (u32)var32_off.value);
 	reg->u32_max_value = min(reg->u32_max_value,
 				 (u32)(var32_off.value | var32_off.mask));
 }
@@ -2332,11 +2332,11 @@ static void __update_reg32_bounds(struct bpf_reg_state *reg)
 static void __update_reg64_bounds(struct bpf_reg_state *reg)
 {
 	/* min signed is max(sign bit) | min(other bits) */
-	reg->smin_value = max_t(s64, reg->smin_value,
-				reg->var_off.value | (reg->var_off.mask & S64_MIN));
+	reg->smin_value = max(reg->smin_value,
+				(s64)(reg->var_off.value | (reg->var_off.mask & S64_MIN)));
 	/* max signed is min(sign bit) | max(other bits) */
-	reg->smax_value = min_t(s64, reg->smax_value,
-				reg->var_off.value | (reg->var_off.mask & S64_MAX));
+	reg->smax_value = min(reg->smax_value,
+				(s64)(reg->var_off.value | (reg->var_off.mask & S64_MAX)));
 	reg->umin_value = max(reg->umin_value, reg->var_off.value);
 	reg->umax_value = min(reg->umax_value,
 			      reg->var_off.value | reg->var_off.mask);
@@ -6128,15 +6128,8 @@ static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 		return err;
 	}
 
-	/* __check_mem_access has made sure "off + size - 1" is within u16.
-	 * reg->umax_value can't be bigger than MAX_PACKET_OFF which is 0xffff,
-	 * otherwise find_good_pkt_pointers would have refused to set range info
-	 * that __check_mem_access would have rejected this pkt access.
-	 * Therefore, "off + reg->umax_value + size - 1" won't overflow u32.
-	 */
-	env->prog->aux->max_pkt_offset =
-		max_t(u32, env->prog->aux->max_pkt_offset,
-		      off + reg->umax_value + size - 1);
+	env->prog->aux->max_pkt_offset = max(env->prog->aux->max_pkt_offset,
+					     off + reg->umax_value + size - 1);
 
 	return err;
 }
-- 
2.39.5


