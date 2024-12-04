Return-Path: <bpf+bounces-46050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3139E9E31C5
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 04:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70F5284560
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 03:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E408013D24D;
	Wed,  4 Dec 2024 03:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDgkVGAd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5DE126C1E
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 03:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281453; cv=none; b=UrwNHfwoYtRpVTmZN04C73i2skLSVOdUGEP1lDd91QiHNGeoIB2f3Jfecl7jX/3o2J+QVPZuv0PNh4/Ipb4b/Xz2PcksAPTO63ssN5vs/JPaK7e7a+IDEqk/wIgb36qHOkeUkIlGz+ClItnnvT94f5R42MbaGXHZdlK9F/hOoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281453; c=relaxed/simple;
	bh=57qSfzqNWdM68fEvHBN8TFelxnu11wjWt/bN39hl92s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXx8i1OqZ9FpjPblDbrGSSQy+M7N0hKKgYz3n1aZXxDzAYVDkdyq9SuRhF3jYC0IKsp2ZRIiPv8+Fh/D+Lv4FFammoU3NCaelCYd9xUmvboPMYuRxmdBPRCY6MC4siDLw6GqzSawN3uqUBTUzJz1et+C4ZCcFg8I+yB/pdhXcvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDgkVGAd; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434a736518eso76705045e9.1
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 19:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733281450; x=1733886250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMGh0z6cq+JkeqtzlQVAOThgczFnVyH3wUz6lcaHUR0=;
        b=GDgkVGAdQ2glk2p6K+0Wypxz1pb+o+bY6a0uOfNOAs5Fc2HHs6T44o9HAUMKFN6Ybl
         Eg4AZu2AoXyTczD4I0e7RfYiTPaLl3AR+3j8VWnHt2TvG8oK3EswFjTjr+L8kGDCaPrV
         2PA0qvNGUqKBug8INVqyk3ePTJLD0JcPGFdpNxcWTQ5pMUJZLuzW9PzMw1Moi3OkJ+mh
         ccJz52dpsyu9CgrVtdWxrKTHDPrwNS493NCYcvl0aHqtUThTtj4DGlPgPwquMadMAR3v
         tZAdU69R4zo4/RyVDcBcMDHSFpip2Gd7CeQsBb+8wqEDxkKeb5wK0wzjh4j5jlK7+rxo
         S8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281450; x=1733886250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMGh0z6cq+JkeqtzlQVAOThgczFnVyH3wUz6lcaHUR0=;
        b=CBG+SHVHmvHSn6SCzDd4n9ziIwA/FmMHkPf+peob4mhSb8xNT4m5DeKdYKh2ZUqbdh
         oITofoWtLzVxMqdhIu2aIi3pAGLEQOinmc1IwK13GWlsHO1ZZhwGbZhlax24YNWSGWTU
         C9ox2ba9/+Yi8mP/Og88ZvutOsoIe1tytIhqeuOSEyjtL4tpfnYngtKo7IlTL4E21e0v
         yieigPY/zem4J5Y0kiLYv9ia23slxLWcdH/G2dKoCBAtGwuCP3Y8ZbpbybFi+O/S/nbX
         Tuqw38dTc2Bs4MMVUL1leDwreHortJITiQUk6z15Kp+33D17/0TDygIkdl2v80zg/Iwz
         t1TA==
X-Gm-Message-State: AOJu0YzI+RlNskRE2M/j0f8P3KmZZJWCvXZdX4/7EhJwysVPcDpKMst/
	0VV30G/sq3HBzTeN+/QCskjqFCG/MnUcBhswf/w61iKtZQdUCA6jUEl5666QFWs=
X-Gm-Gg: ASbGncvRpDki1q/fWaPbggyF52wMijvJdR5X8VszhPA10wx/FvuMgNZHZlag8il49CB
	OnqSVlwt+gPxZrY++1Hoo72a69Je+3vrQxRRZ4OO82LVfLLKd6W1n90krMlFDnUk/PvzAsrK3e/
	2O1cRohZjqbcjJw7/fj4NiLznpzZXwk67RFsWwIHni9/lYWyKzP5uatCx6G+akGaWNAdgRR7X7R
	Tboryv0TQ65rbZ47X2C0nGCG4lGcC1R96icvcutyPibkzEMbOjomTzcEYwaiCwpbrVIa41K5b/P
	eQ==
X-Google-Smtp-Source: AGHT+IEkcKp3wNIzLefhxiarIvhOiY4GfpwORu9tEhlKa+8BiadbSQQnPrH8ZpA79Lcj560S4+o/mQ==
X-Received: by 2002:a05:600c:3546:b0:434:9fac:b157 with SMTP id 5b1f17b1804b1-434d09c10a5mr47903155e9.13.1733281449881;
        Tue, 03 Dec 2024 19:04:09 -0800 (PST)
Received: from localhost (fwdproxy-cln-025.fbsv.net. [2a03:2880:31ff:19::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0bfasm7674215e9.32.2024.12.03.19.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:04:08 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 3/7] bpf: Refactor mark_{dynptr,iter}_read
Date: Tue,  3 Dec 2024 19:03:56 -0800
Message-ID: <20241204030400.208005-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204030400.208005-1-memxor@gmail.com>
References: <20241204030400.208005-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; h=from:subject; bh=57qSfzqNWdM68fEvHBN8TFelxnu11wjWt/bN39hl92s=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT8Q/yxTRIlNDljrjf+vNp1cNjUoWpdCJJ6SMlX0A R2y4Q1SJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/EPwAKCRBM4MiGSL8Ryg6ZEA DAwNE9M5j4cPHELKQwoBGQtkCaRM6CLpDCiFVjDuZDUSnGlvGoX133GvF/KZ8661fxqCZKESxB0qaP 6Wb966Y/y7bpwsKyQyJIqR4Ck+NU45VJGF4zgeEX84OUW+XNZ/6+5m3n5/Z3MWa8ydT8cmvUYcHeOr 6Gfo5TxS+IkgLfdhd18g3lKQ4Nid34ozXvyETVPo518pumdqF29bldAHgPXqaPwtbx0eY6IAaUIXMS C5z5ShKpiXpY1eAXUyOXeCNwOWBJcjbw15FqAxmVsJGyf3uAiHSZZ+s29tZUq1EXtuUMOo9kfIntt4 VSN9iU5fXqFdsQnI7nEdqgIOXFsSj51NOUf8AcvDwYvyUYFsaA1VM0qbQXa7hH+JbO0v0qWudMXXj6 rITrCUrCmF8fvZ6Z4ZCxDfsjbHSbZw1ghfZtmujP1l511hVXdMC4D80caivHJ6Tyy/ir+MTJERTWeO 81UPTCJWSZIM+HzB3SfN/K6pHXGEnuyD4aG05pce0aCFBlX7+clXGpsmDu8+NO35k3dD2v5ipnpG8f MvI9vcIRsqIixkB/nPXc//VlQlkk0ZTirx44+cgQBN4vrnWsDas85dziCz37vYrZ8gwpjVfHKxhCkG 4WhwO4P4DQGO9Co98dnZokNa6c6RRlPe02yVJazgZsdZy4ij2y3nbABTk3Sw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

There is possibility of sharing code between mark_dynptr_read and
mark_iter_read for updating liveness information of their stack slots.
Consolidate common logic into mark_stack_slot_obj_read function in
preparation for the next patch which needs the same logic for its own
stack slots.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 41b3dc1ce450..b4a486abe134 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3191,10 +3191,27 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				    int spi, int nr_slots)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, ret;
+	int err, i;
+
+	for (i = 0; i < nr_slots; i++) {
+		struct bpf_reg_state *st = &state->stack[spi - i].spilled_ptr;
+
+		err = mark_reg_read(env, st, st->parent, REG_LIVE_READ64);
+		if (err)
+			return err;
+
+		mark_stack_slot_scratched(env, spi - i);
+	}
+	return 0;
+}
+
+static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	int spi;
 
 	/* For CONST_PTR_TO_DYNPTR, it must have already been done by
 	 * check_reg_arg in check_helper_call and mark_btf_func_reg_size in
@@ -3209,31 +3226,13 @@ static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *
 	 * bounds and spi is the first dynptr slot. Simply mark stack slot as
 	 * read.
 	 */
-	ret = mark_reg_read(env, &state->stack[spi].spilled_ptr,
-			    state->stack[spi].spilled_ptr.parent, REG_LIVE_READ64);
-	if (ret)
-		return ret;
-	return mark_reg_read(env, &state->stack[spi - 1].spilled_ptr,
-			     state->stack[spi - 1].spilled_ptr.parent, REG_LIVE_READ64);
+	return mark_stack_slot_obj_read(env, reg, spi, BPF_DYNPTR_NR_SLOTS);
 }
 
 static int mark_iter_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			  int spi, int nr_slots)
 {
-	struct bpf_func_state *state = func(env, reg);
-	int err, i;
-
-	for (i = 0; i < nr_slots; i++) {
-		struct bpf_reg_state *st = &state->stack[spi - i].spilled_ptr;
-
-		err = mark_reg_read(env, st, st->parent, REG_LIVE_READ64);
-		if (err)
-			return err;
-
-		mark_stack_slot_scratched(env, spi - i);
-	}
-
-	return 0;
+	return mark_stack_slot_obj_read(env, reg, spi, nr_slots);
 }
 
 /* This function is supposed to be used by the following 32-bit optimization
-- 
2.43.5


