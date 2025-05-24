Return-Path: <bpf+bounces-58898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB6AC310C
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 21:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005F99E1676
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 19:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F29D18BB8E;
	Sat, 24 May 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCDHe2hL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4591C84DE
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748114395; cv=none; b=TFd3wh09cfhQKna8Vp2gvjw5+GhGg9KI8Z/5g8W/LFW0FiayOUm43LdTLskVBggXAKYj9fi/lx3l/anCLgdjxLXcpRhv99799AZqNhFjo8x3RGyndMUO4hxSNQ8yHtvMF49DrJZxBmxFfBfhUNf9pC5url/Od2N12Yl9MdkqoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748114395; c=relaxed/simple;
	bh=iNt6x/WxDqTdfQAmSyTA6+/EDQm3Ms5gP5nCDJY9CS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFIOJ2Dxl5+25Co0hp6aLLDGaGbBSlaagnmSC66VY/cTfBGijY814thP+WWlfoOYWfKGc9BYH8+xPakjMGvvVf7RgKWroRncURmsX/LY1Sgfw4wnP+2B6NFCH8myqJ6bznYxPEO7mJ7uIfQbUhTm4NTCJjoQ+YwVtnFhsN123z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCDHe2hL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74068f95d9fso752131b3a.0
        for <bpf@vger.kernel.org>; Sat, 24 May 2025 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748114393; x=1748719193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjdhEDtylZvpsJfllfyYD+A/mKQiilprV9uBGziDe0U=;
        b=lCDHe2hLAGRtkSjtjUr5foVMgiQn5VOx13VzISXJsPtkes9XsPPWbTxh189H3vnAJu
         b+vetVVcWX0PWQDT3u5bPx5DD0qMaaTcsADaMf3oHaPUDuQ7mkEXw+PAzQ4luB8UaCBc
         6NXQS3ZQfeJCsXTu1Tc5WQjTyMBSts+xqtexq5QYv2HOCIk+hJOGrR9DIJ9c2Q43SU4F
         fjfXrFHnk033e0EMT9D9d1MrOYNW/HkrrtyYYoLVOnsWGmmkiNwgMuRyrBa7Fubtxuvb
         q9vZbPutX0yaINAB79BocHF7iKvSV+zsVEWpLAjslhoMfcg5u4B9vOLQAaPOUorRHhNf
         FA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748114393; x=1748719193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjdhEDtylZvpsJfllfyYD+A/mKQiilprV9uBGziDe0U=;
        b=YJlav75gUWE1WonHz0bYoJxEWkHAOgy9h2GuKRYwfPX4fRtexPSYLXKacdDdjCh/qV
         Tek7e6U4TsRPykjGXiPzu11jnrm1i3mr5u9UY4p9tDoKMa1FU66AXQVjs6IA+86ISQ7P
         hsdzCW16RXs9oDMwDPthgQ8z1slu08yHa3Mf4w8hh7YfBlkKlTps81+rKQTaabHrXiDu
         K2ikE+PJbtTaWPF5yJ4f8NJHG2QxyqzAXlao6YcZVJoHqB6ATgE5+BasUJwCXdCFowY/
         /acSvWj6+/PYvPydCAreIGWvWXPzpAJLVgzO5xHrrEdTqfYuPbq3TRqJ67Q8iXSfzDwP
         8o/g==
X-Gm-Message-State: AOJu0Yz+pu+WekIe7//d3sDll1/jQCwA7ofGqc1Km+wTSTT+KIQWkDGd
	JUOdi49KT8hDkiYLQwQjaVVimkXf5WduhXj0XEBxl/NdM2XOGG1VaKrSkMxn8V4C
X-Gm-Gg: ASbGncteDAmQ1sJ9wkigwr84/Aqe7/wp20Yicsl+b1CjzhRdklto4ZC7svoxENToR8j
	3+psw1DBtEtZBUm5aiMPjo3xVbNfmAnCtGRp+qCOVgL01mwhfRI7o4DKTq8zoTjo/ibHQp0frZD
	Yh/np4CL1vjV4F7bjZL+rkX9UEIMNRKqJwMoJjXEKznfTIE34Nx+1mgGZABlyL4fmKdPV3lIMBv
	palmsUs1gRxsp49HG/3qABcg29BiLx4/MMYq/V1GkT+hY9FlJiIKunA9XrE224bEbzbLORrO645
	8PiAYRtUo+NjJyb2OaSHQoOm96ui5moc1Ag3mmBR2O+xMzs=
X-Google-Smtp-Source: AGHT+IFKjWKGrD5zODgPAHNpwLgeP2b8vEY+fNdx03nAL9nSIys6zsUbYw+BVL+SQAf5qvuOsfidCw==
X-Received: by 2002:a05:6a00:3924:b0:73f:e8c:1aac with SMTP id d2e1a72fcca58-745fde5fe58mr6003454b3a.2.1748114392991;
        Sat, 24 May 2025 12:19:52 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986b38bsm14558298b3a.129.2025.05.24.12.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 12:19:52 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 06/11] bpf: set 'changed' status if propagate_liveness() did any updates
Date: Sat, 24 May 2025 12:19:27 -0700
Message-ID: <20250524191932.389444-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250524191932.389444-1-eddyz87@gmail.com>
References: <20250524191932.389444-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an out parameter to `propagate_liveness()` to record whether any
new liveness bits were set during its execution.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 59d7e29dd637..0d7fb2e0e1c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18831,12 +18831,15 @@ static int propagate_liveness_reg(struct bpf_verifier_env *env,
  */
 static int propagate_liveness(struct bpf_verifier_env *env,
 			      const struct bpf_verifier_state *vstate,
-			      struct bpf_verifier_state *vparent)
+			      struct bpf_verifier_state *vparent,
+			      bool *changed)
 {
 	struct bpf_reg_state *state_reg, *parent_reg;
 	struct bpf_func_state *state, *parent;
 	int i, frame, err = 0;
+	bool tmp;
 
+	changed = changed ?: &tmp;
 	if (vparent->curframe != vstate->curframe) {
 		WARN(1, "propagate_live: parent frame %d current frame %d\n",
 		     vparent->curframe, vstate->curframe);
@@ -18855,6 +18858,7 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 						     &parent_reg[i]);
 			if (err < 0)
 				return err;
+			*changed |= err > 0;
 			if (err == REG_LIVE_READ64)
 				mark_insn_zext(env, &parent_reg[i]);
 		}
@@ -18866,6 +18870,7 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 			state_reg = &state->stack[i].spilled_ptr;
 			err = propagate_liveness_reg(env, state_reg,
 						     parent_reg);
+			*changed |= err > 0;
 			if (err < 0)
 				return err;
 		}
@@ -19241,7 +19246,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * they'll be immediately forgotten as we're pruning
 			 * this state and will pop a new one.
 			 */
-			err = propagate_liveness(env, &sl->state, cur);
+			err = propagate_liveness(env, &sl->state, cur, NULL);
 
 			/* if previous state reached the exit with precision and
 			 * current state is equivalent to it (except precision marks)
-- 
2.48.1


