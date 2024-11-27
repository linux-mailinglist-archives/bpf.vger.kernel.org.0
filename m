Return-Path: <bpf+bounces-45732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13239DAC25
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 17:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F9D1B20E1C
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3089D201011;
	Wed, 27 Nov 2024 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaaNzXmB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DFD25760
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726734; cv=none; b=gjKQGmYCw7EEYVdrfiyX+RhI+TgsWiFDK+o74AofjhGyrD6q+Ae1H+2FHTI3Dc5howGKggQ1NOxwzcfVeAtg4vcu8Cluc6jpJQuM6/Em4hititSFcj5/9OqxuLTbX+uv+SpOSI8Pn6SAPVS6TXZoM7UVkpXfXOL4XTsI2T8xemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726734; c=relaxed/simple;
	bh=mCbV2hzfoSvQXfT9CUwMciZZAlSpMRDDqFj2bBCWrIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Emkrvbq5IEUm1w/YwhDRpbPUP9cI5aO4sVybFmH1SlpOTyAMWUVD4J34XVMAxMUkeKX3TL4Z/tT+Leb3LroOmZ0coPyYt6kuD8dsYt83XIArG20yNxIN8wYSTztvSTxGoRrSwihnBtGzbgkfeHDs1djChld/f2lwcAGbCVhqSgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaaNzXmB; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so9420175e9.2
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732726731; x=1733331531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdwiHmAk6OhdkiUA9Ev7EZPLqHFZB5MK41Iiedr0ApI=;
        b=WaaNzXmBRtQrcUKaKJoa/9WbrjNgMa5YyGPh+jEDVFa13D0DAaUUBTrTaGnPqHMO2Y
         j0EOW84j06Q2iD8W6Gk44afUBuX2OYVSzkCqvc0erWuFjZG6/qkqU1d9/tem+b9ifqQY
         buSHhs3E9wgim3KOHGdB6XYk9hvohOMvxmP6Vgwbf036JIPS/3pJUx+AoZU912vwEpRQ
         2HTU7aXg0Cco0Lwse1zdEhiVUsYgwU9eG9ECzAjJAiDvJlIkzby8adsN58Fc3FbWmlTk
         twZB6QqZRcbfoTZFYba99iEchmKHi2SsHWCgzrE+HaE2/6hjNDAO6nYy3/PcYlEU8UFo
         htSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732726731; x=1733331531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdwiHmAk6OhdkiUA9Ev7EZPLqHFZB5MK41Iiedr0ApI=;
        b=HTieulR02WOvuOyIfyT6IgU0k/82gn1RGjOACsVHOdfAhFSnIZ4Zy9pM7aq+QNzI53
         gElg99lgC0ifmM94JZPI+VYUwWP/QY4H2izWklY2T95Ig0MheQdaEX2xEeSKu+IHS+VG
         HFR1Gmv8xFfHx5MoQkYJ1lJKfhgSLOZ6ocVvvPi9wcaOXLGSxmBPzHTtiB8U83rxim4h
         PnZpqWC4+d9kjrG87IFmHKzgocybh8D2sq0b0dkADc73PYO0WeDn7LUZ7zpZBOIwptM3
         wfhTG7tK2ZmjK39afO0lNh4Sk7MWKUKc26d2NyBkzZ+uW+svlsyBiXQ5arwuuvZaCNzS
         bppw==
X-Gm-Message-State: AOJu0Yyc6pBjsanjHGPTMx5vHFiO/7hVvmUMoBtNfIWxsvykmYDuozpZ
	bP06euzNnXnKyN1S+qGaUq/rdhnZMVem0QK/1Bpb/5SSaoidvTMpmgZKxconkG4=
X-Gm-Gg: ASbGncvYD+Q3SMqM7C6GY8bjfvrMN8sdCFYmq2HxVpoyPaCCjx+SaH4/1nLEOLJfjSj
	g/PI7pZhIc0t6dhJ8JzcydzCNYUEvvohW6aWB1IXNI0y/iKFYUhhbxvprdmpZuS4vQNUoLZ3F2S
	czw3iqwKrv+ow8xWRGeQYNlk9JrlqROCF+MAhV8sCZi0Dy3JdSsefBDOabpXArTHp0R015D6OMv
	z1skG4WpVG/3pifU19DbUFRQKMbVymGi+OxSvUP4KgNkX4RAN54DX3Ksw6SX+gCBPmPG8mDjYmw
X-Google-Smtp-Source: AGHT+IGe6llC8YoyCdLXHjA8UlYEYGAANQ1n87soY2j6W9UwMAtZce2t69WnJValfAF75xWXylzjQA==
X-Received: by 2002:a05:600c:45cd:b0:431:50cb:2398 with SMTP id 5b1f17b1804b1-434a9db8b4emr35161685e9.2.1732726730950;
        Wed, 27 Nov 2024 08:58:50 -0800 (PST)
Received: from localhost (fwdproxy-cln-003.fbsv.net. [2a03:2880:31ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc42d4sm17194508f8f.85.2024.11.27.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:58:50 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 3/7] bpf: Refactor mark_{dynptr,iter}_read
Date: Wed, 27 Nov 2024 08:58:42 -0800
Message-ID: <20241127165846.2001009-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127165846.2001009-1-memxor@gmail.com>
References: <20241127165846.2001009-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; h=from:subject; bh=mCbV2hzfoSvQXfT9CUwMciZZAlSpMRDDqFj2bBCWrIk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR0+55JREANWkAQkTq9sY5tFPCMEqN0mVIp6AlRAX NqsjPXSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0dPuQAKCRBM4MiGSL8RyrZND/ wMH0ooML93w+x1DHr4JzmW1l3nRAcTbURrG8NeQm9WyJrgE4GFR1LPXz0LsF8SwoGBfE/117SphQ5g PoVGkDoISP5D7MMD1TNTXkiUGxKgdOxeLbgP79eSKcZ8JXVzEu2K4dkv1uIBPzb09ciIgLQbwo0Z8e SGA2VNlaqMqenLs5L71QaL16g898pvCnNy3uUfvCZZ7ClfVhNUc8kAZhkz47LTUmJIPMHWUgScX7Xm 7ygYK937Y2JVj5KdPZWyXxvJKRvAtRUVEV+tjuxV7HWnvHh0E+eCHApsJwJ/sbPfI9Sq1pcQ3EHtuZ Xygf8fAlXCOyxhQCrYd1/Qdf1qdqcXwlkkCreyBhxp58GmeaXktbeMy2Dz/fvBqEctFCmRKjEa8JW3 0lScv6Kfe4ZqrlMs5p7RJBe7BzWAzcC+Nsgwmz0BDzF+vjPKkdR3Hj+Dm73HzdQ9MhF/29/z0xRZsP XFA0xYYg32Xn9u9h6ui1F++5Om6uYaOAGOsPM4wPGnun4Pc+AEg0GxJ1xszviW88L8bH33GeFnVBlx s7jP+OgQaS9SGDi2iHnI6qH6PD7N3UZU3Gy7kV+1gX4Q03AlysL1I3yxQN4pRT0uTYTQlFX0IUOA7J doOfEo5/rwxdH0UgSXnR9wcON1Vuo8K5lDXtDiRoEkiQahDT+wwH/PqdZaog==
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
index 474cca3e8f66..be2365a9794a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3192,10 +3192,27 @@ static int mark_reg_read(struct bpf_verifier_env *env,
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
@@ -3210,31 +3227,13 @@ static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *
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


