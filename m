Return-Path: <bpf+bounces-70516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1540BBC222B
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 18:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61D574F80CB
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC9C2DFF0D;
	Tue,  7 Oct 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d263XFZI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD0146585
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855176; cv=none; b=kgvl/dE3ru6W6Tx1jht6eMksgJCzisJ8cxL5mDre0z7YGIgR2XYNX2vzyPW2pqlwaNOWGrkj4s0gslL5AgWq1EO5tcnoOxxySPFSHuxAzzaFNIHZSDS13Da+3/rL2tBuwMzxFinWINqBhvWl6uvccgY8av6SiQaJTQV6U6TEPcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855176; c=relaxed/simple;
	bh=pt6uVl2va0017+usTJPtB2mgd02MUjIvG/vyseBfMA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i8122vIDvwhf1fZ+8f+YNh6ul8L1s+jQHP4OhwwlOGr6wJedsLy3ujqC857mYwLpTdXg7KbouO9z6tI+Gn6IqdZEyEfCXLAK9eoxFjYBFXxDV7t7SAPFlK3Jg908lgbA4ouBHCMMmAxapQTl+6Q1xwxZjvWIcQba5WTmWTZGl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d263XFZI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so69901465e9.0
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759855173; x=1760459973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTZb7gvf4mYiD/+BcSu2mE9chUq77bafq2p8amfYPNg=;
        b=d263XFZIF7vfVpOxrCR0JpY4lKn3u3Ag19uFeG7hl1dXwH+GF6e8f47ArXRt4JFoim
         xOl50n4fOoWTSMf0euU3YxTwR3MeW/wMiG5ofb43CmH8+Cqf7v2u2era+Tw8sh3tldig
         z/Uyhgvsywrthp6apGbrVgeTI0pF+0FmC/UIRp2POTDH4Fkm8f8aac9RxXbskKXWAT1n
         itbqTf384LLpwwz0xJy+Y/0bZuaTIiIcec1PhyRDp/tG3h9vKH4/ukjIUcdd5bFYpSb2
         L+fPXupqUMm3WDV+lxkDjIv68VlZ0x2ArdaHaL+5saB8X+jObEjmIAPTCg++b+8atWXh
         Oyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855173; x=1760459973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTZb7gvf4mYiD/+BcSu2mE9chUq77bafq2p8amfYPNg=;
        b=SqbKUtMqanVoNg3ZWQ37rRkd8hAmoiZ5/ik7HpVjdHi8FeD6DlrJKHBIBgfY06fPVA
         NdtCzGTunpw6XBb1uJGAEdkIYoE7zQS9aEB3M7aCOCuwXR35/2CONwpWd/iLeXqRnnpC
         0A/c7682lhwp4jFq48VWZexFY8qL3/ju2l0KDNvQrtMIa6lrPRZrpTbA8mkpWNRSgG5c
         +3owVFpfAPtLh+lr9d5iIJTeoOl0cTO/fYsO/SLyRMxKxytcnFuTOFAhBZ3nDLj6vo/R
         PSeX7KgNKXr8najMjQ0bqmgTYK9SlkmaMG4MDZZuXATuGTp5WD1HuU4lKuIrrsvT3wL8
         jxXg==
X-Gm-Message-State: AOJu0Ywf6Vncv44M5kUDj5KEfYOf/V8M55bVNjTJ7zgWnUF9d3oinIY8
	0Cvn52Lt2tHlO6nTA/xo6zh+8qVRXtFvonPtVxgN8QybMA4P+1/LCUSZGvK/KA==
X-Gm-Gg: ASbGncuTRhl8UxoKJtW0u4AMkJgvAyhIKIHXGx+FP2jsT25JZ0RCuzag7gBUCX57rII
	Z4I5raU4gcKE8Kw2WaN7ltTBC/W4rn02YatvvMjnd6UShMSAZFvoP1Fl2V6s3kqmTrUzpO0mPKz
	Cw98rKZE67wB2MIDzj0cWXOGXrv1z+0rzJcuUptQWb3CP3PG965CANyTiyPiZZxwy8jqAI6QXsa
	xu7Cl3Uqcpz55jT2CX9P/zQqStCsFGS0iJXHG7EU2NwhsIXScwqXosJIK779ZSbsdlyC0l8Hlu9
	hssQqyixYK5vpLkwYUIUZQlZnm4hw+r2Glt8cZCXHkUj2Jv/bVvTVxxL6P2fHg34Y7BTQkqkhb6
	RGtaT1CLHsT7V0NYumMW6XGeD93bmVhNUOd26CDt7CoXngA==
X-Google-Smtp-Source: AGHT+IFbLl2UwFMMnlzpOmFq8/qvdftgqU7+PXQKrlfP6HEY1UndGcvdYajSuWYBcgLaE/B8Xjtn+g==
X-Received: by 2002:a5d:588c:0:b0:407:77f9:949e with SMTP id ffacd0b85a97d-425671528dfmr11073536f8f.21.1759855173127;
        Tue, 07 Oct 2025 09:39:33 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e980dsm28463003f8f.36.2025.10.07.09.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:39:32 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 1/3] bpf: verifier: refactor bpf_wq handling
Date: Tue,  7 Oct 2025 17:39:28 +0100
Message-ID: <20251007163930.731312-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Move bpf_wq map-field validation into the common helper by adding a
BPF_WORKQUEUE case that maps to record->wq_off, and switch
process_wq_func() to use it instead of doing its own offset math.

Fix handling maps with no BTF and non-constant offsets for the bpf_wq.

This de-duplicates logic with other internal structs (task_work, timer),
keeps error reporting consistent, and makes future changes to the layout
handling centralized.

Fixes: d940c9b94d7e ("bpf: add support for KF_ARG_PTR_TO_WORKQUEUE")

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e892df386eed..b2d8847b25cf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8464,6 +8464,9 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 	case BPF_TASK_WORK:
 		field_off = map->record->task_work_off;
 		break;
+	case BPF_WORKQUEUE:
+		field_off = map->record->wq_off;
+		break;
 	default:
 		verifier_bug(env, "unsupported BTF field type: %s\n", struct_name);
 		return -EINVAL;
@@ -8505,13 +8508,17 @@ static int process_wq_func(struct bpf_verifier_env *env, int regno,
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	struct bpf_map *map = reg->map_ptr;
-	u64 val = reg->var_off.value;
+	int err;
 
-	if (map->record->wq_off != val + reg->off) {
-		verbose(env, "off %lld doesn't point to 'struct bpf_wq' that is at %d\n",
-			val + reg->off, map->record->wq_off);
-		return -EINVAL;
+	err = check_map_field_pointer(env, regno, BPF_WORKQUEUE);
+	if (err)
+		return err;
+
+	if (meta->map.ptr) {
+		verifier_bug(env, "Two map pointers in a bpf_wq helper");
+		return -EFAULT;
 	}
+
 	meta->map.uid = reg->map_uid;
 	meta->map.ptr = map;
 	return 0;
-- 
2.51.0


