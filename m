Return-Path: <bpf+bounces-35279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E5D939708
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524961C21918
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 23:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A322F4F5FB;
	Mon, 22 Jul 2024 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRRbzgsj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D981CA84
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721691549; cv=none; b=JXEhVzFRMBdxdygSY6jv9opGsLRL1AZ6D81ZAjmVmy2napvz24AEE/uDuouHyCl9P1Suy2izVYRzW/UVcKHWY2GU+hVnKbY8iVh+RqMwhp+fp7EM4ayWyy5XrwUUXzOCyV39Dd24iy1XBj3VxMyPcnJp039j+e7ysGtmuftxhOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721691549; c=relaxed/simple;
	bh=7cYJXhTFxIxxPYBiozf+mIu6ZxhQw3y8L/aBmBZ/mBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGD8F7W4kS0bL6DlO+/VdBMJ/6nlLwjNHiktIYcmtOppvS0ETqbAAtq6ph7ZF1thgwpypGVLSC+AhGuaAGY6cu4rj8qCwHoZlLjI01a30hZB35IcW931caOSDkjA9te3P0a19rdxFOIZSzH1UiKSWI4+4HihiJCmL95NLPD8irQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRRbzgsj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d2b921c48so1017164b3a.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 16:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721691547; x=1722296347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSBUGRfQ9u7I9SmbnDZb2r14dwMIfKe26DU8uXfKB4s=;
        b=PRRbzgsjlRY4BfUBt6jTiRTTRbkZ4JfAV/4wykTCsMOFmQVZAj8mVKYhlzl9WTd9ha
         e2XYm0G2MOYjnb0axINPdEiFc9IwjGXSg3oMzjPeaVZ+InAnn6gwf8x1RS8EekrPhfPE
         dsvIXfbSVZY+YH/YOBbMao6C+1gp+fZzEtH4caheiCXfW+Fxw3jDHChSAfN7fAucYU6e
         Z+5NUCtW8mAQTW1BbiY4B7eovmtbQuSINjYjVUsKou1hRr1q5pdlxNWkyLtSen14b1+b
         WBWb3TwRHzG2+AfYbMiRT7SDqhOqLNxltzJy1y/MR4xWGAbVDatjhD8ursgCY0m5z2oW
         wj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721691547; x=1722296347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSBUGRfQ9u7I9SmbnDZb2r14dwMIfKe26DU8uXfKB4s=;
        b=cyCmzNMBcfM16DhTZK0+CE42iyatPjtfSJR5ri9QxYFFyOsdfwNiUc/OM/HVXM13jk
         HD4U+2k+I0mxclMc5T8ycNXbw0U8NVjFWYJfH21GXqSL4xJoGyQsguen1aZ53UiXIf7J
         jz83ORtWlkF53ST3AkuhqiYoNrbOz024y7qYbZImvi3gcA44638CBL7m5jY0PKz6+G9+
         y+BGsBlGTFxkOJ3q86qLRp9pZXtwpIn/kMS5m58nSF9l1GvRHl8TA7whRTEAa5o4M81U
         +VleT5EeBfuTnPUOB8Z8pmGaCmJrSJP83D7/aydQaUHIH0LaQn26ieRYNTcgUmrbww4O
         jfEA==
X-Gm-Message-State: AOJu0YyC+lUrbxKgCGSff7wXO1mFB+qs4E2PBxBmXDEHKctaqkGV15H5
	dD0oPftxYkbYIfemqD73vEchlD1Kyos23DqTaF1sxZZmgCzdfcP3yT44n/d46u4=
X-Google-Smtp-Source: AGHT+IHrQzjg/kMZabINMXUSBEVggT1UmicdmeCJUViWA2MU3OfaRbEyhMYKjfrsCajrl3lScJu8/g==
X-Received: by 2002:aa7:8887:0:b0:706:284f:6a68 with SMTP id d2e1a72fcca58-70d0f176db7mr5814005b3a.23.1721691546759;
        Mon, 22 Jul 2024 16:39:06 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2707fe14sm2479500b3a.163.2024.07.22.16.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 16:39:06 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 01/10] bpf: add a get_helper_proto() utility function
Date: Mon, 22 Jul 2024 16:38:35 -0700
Message-ID: <20240722233844.1406874-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722233844.1406874-1-eddyz87@gmail.com>
References: <20240722233844.1406874-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the part of check_helper_call() as a utility function allowing
to query 'struct bpf_func_proto' for a specific helper function id.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 656766dd76df..a799b97634c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10285,6 +10285,19 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
 				 state->callback_subprogno == subprogno);
 }
 
+static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
+			    const struct bpf_func_proto **ptr)
+{
+	if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID)
+		return -ERANGE;
+
+	if (!env->ops->get_func_proto)
+		return -EINVAL;
+
+	*ptr = env->ops->get_func_proto(func_id, env->prog);
+	return *ptr ? 0 : -EINVAL;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -10301,18 +10314,16 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	/* find function prototype */
 	func_id = insn->imm;
-	if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID) {
-		verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
-			func_id);
+	err = get_helper_proto(env, insn->imm, &fn);
+	if (err == -ERANGE) {
+		verbose(env, "invalid func %s#%d\n", func_id_name(func_id), func_id);
 		return -EINVAL;
 	}
 
-	if (env->ops->get_func_proto)
-		fn = env->ops->get_func_proto(func_id, env->prog);
-	if (!fn) {
+	if (err) {
 		verbose(env, "program of this type cannot use helper %s#%d\n",
 			func_id_name(func_id), func_id);
-		return -EINVAL;
+		return err;
 	}
 
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
-- 
2.45.2


