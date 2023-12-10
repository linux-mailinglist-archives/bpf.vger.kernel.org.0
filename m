Return-Path: <bpf+bounces-17340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04D480BAC0
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 14:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90054280D1D
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09F8C13E;
	Sun, 10 Dec 2023 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/ZM2PDZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A7CFE;
	Sun, 10 Dec 2023 05:00:34 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id 5614622812f47-3b9d2b8c3c6so2698890b6e.1;
        Sun, 10 Dec 2023 05:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702213233; x=1702818033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HKccvv63j0QYkaerqhaF/v4uQMT1J4GxnBO3+iS7dFM=;
        b=J/ZM2PDZx+8iD22133s9ewn8MBDANi8atyy2N/c29aetbwKoI8ViUdP42q8s4fczEH
         p9fqRp732GoaOvp/CbFeWAJfYO3ThXgDZOrvU7U+aBJrPpPQgtXXDy88S8WHHJJt8iL8
         /LpbuzfBIJ+Xc0SHPPsChO/XvFZLqk+0nXYIyyxqpqUGNa2xTsERs+i8Hk9N9DCIq4C4
         fKWpu1+0RmJE56w9Hj6Ld2Mgn3KqeXMkPAnWNuBEIJtsJoOi+Ta8WAJaNHwgxCvY9mO1
         ou2ZI4AWoEnZ+RzULd+D+2jIQu/+ILzWaTqD+ZIjbHh6+gFv8ELmD7ZcWN5dI25+TifV
         514g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702213233; x=1702818033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKccvv63j0QYkaerqhaF/v4uQMT1J4GxnBO3+iS7dFM=;
        b=lODqYAMmnHvB4qei7dxbe5heUoe2jUT5TRnmWwa3D0wgMyYzjL8MjGZCAt12WyuKm+
         FFd8aptY0WD13gk+UD3ViU2d/TH2tPyjlmChEbUYb+lm+3Ryv4E7LXsC1AhJ4AENw0Pr
         4WUhbQi7cd+nXNpOu4uiEnvw7kaIv1IBLc8g/OckDnhp+9aK6k2V4XMrZasjjxjn8cf/
         WFGF8sioPG1TXBc4TSlfy8AQ7H79BuzUxMOQfA4wx0N8gbztpjBnfWz6jj38UF3fnZaD
         bGrs20WII+jN5dAKewR56ztp0TMLbGjHpuHkEpt87WgeQmy4I1h7iz2r+r9Sr9gzf2db
         BKJQ==
X-Gm-Message-State: AOJu0YwM3V+8DMcLAP0t08KCa6tajC0ziAtLXBhmKl0wJ3lF4N8kC/Lh
	iIPL+b1S4q4Bsum/wSAtVwM=
X-Google-Smtp-Source: AGHT+IE79N063EOeL+PmxdMFNiRGGRq39aQYF376YYyPc7GzhJuS/FtoKW1XLbMoj5H+NP8rC0ut8A==
X-Received: by 2002:a54:411a:0:b0:3b9:e853:a423 with SMTP id l26-20020a54411a000000b003b9e853a423mr3313755oic.109.1702213233284;
        Sun, 10 Dec 2023 05:00:33 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b006cee656cb35sm3420067pfl.156.2023.12.10.05.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 05:00:32 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH bpf-next] bpf: make the verifier trace the "not qeual" for regs
Date: Sun, 10 Dec 2023 21:00:01 +0800
Message-Id: <20231210130001.2050847-1-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can derive some new information for BPF_JNE in regs_refine_cond_op().
Take following code for example:

  /* The type of "a" is u16 */
  if (a > 0 && a < 100) {
    /* the range of the register for a is [0, 99], not [1, 99],
     * and will cause the following error:
     *
     *   invalid zero-sized read
     *
     * as a can be 0.
     */
    bpf_skb_store_bytes(skb, xx, xx, a, 0);
  }

In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
TRUE branch, the dst_reg will be marked as known to 0. However, in the
fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
the [min, max] for a is [0, 99], not [1, 99].

For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
const and is exactly the edge of the dst reg.

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
---
 kernel/bpf/verifier.c | 45 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 727a59e4a647..7b074ac93190 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1764,6 +1764,40 @@ static void __mark_reg_const_zero(struct bpf_reg_state *reg)
 	reg->type = SCALAR_VALUE;
 }
 
+#define CHECK_REG_MIN(value)			\
+do {						\
+	if ((value) == (typeof(value))imm)	\
+		value++;			\
+} while (0)
+
+#define CHECK_REG_MAX(value)			\
+do {						\
+	if ((value) == (typeof(value))imm)	\
+		value--;			\
+} while (0)
+
+static void mark_reg32_not_equal(struct bpf_reg_state *reg, u64 imm)
+{
+		CHECK_REG_MIN(reg->s32_min_value);
+		CHECK_REG_MAX(reg->s32_max_value);
+		CHECK_REG_MIN(reg->u32_min_value);
+		CHECK_REG_MAX(reg->u32_max_value);
+}
+
+static void mark_reg_not_equal(struct bpf_reg_state *reg, u64 imm)
+{
+		CHECK_REG_MIN(reg->smin_value);
+		CHECK_REG_MAX(reg->smax_value);
+
+		CHECK_REG_MIN(reg->umin_value);
+		CHECK_REG_MAX(reg->umax_value);
+
+		CHECK_REG_MIN(reg->s32_min_value);
+		CHECK_REG_MAX(reg->s32_max_value);
+		CHECK_REG_MIN(reg->u32_min_value);
+		CHECK_REG_MAX(reg->u32_max_value);
+}
+
 static void mark_reg_known_zero(struct bpf_verifier_env *env,
 				struct bpf_reg_state *regs, u32 regno)
 {
@@ -14332,7 +14366,16 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		}
 		break;
 	case BPF_JNE:
-		/* we don't derive any new information for inequality yet */
+		/* try to recompute the bound of reg1 if reg2 is a const and
+		 * is exactly the edge of reg1.
+		 */
+		if (is_reg_const(reg2, is_jmp32)) {
+			val = reg_const_value(reg2, is_jmp32);
+			if (is_jmp32)
+				mark_reg32_not_equal(reg1, val);
+			else
+				mark_reg_not_equal(reg1, val);
+		}
 		break;
 	case BPF_JSET:
 		if (!is_reg_const(reg2, is_jmp32))
-- 
2.39.2


