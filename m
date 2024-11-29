Return-Path: <bpf+bounces-45848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421009DBE31
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 01:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8D1B2267C
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 00:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62416F9D9;
	Fri, 29 Nov 2024 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUq/zh6a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AAB8F5A
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732839401; cv=none; b=WVXf67CvdwknAZ/Ts4Vvymw2PzOvYlrwwKOT5D2i+Y17m45kTac7LuXmMANwChYDil09p3m4H9WVBqbAHtPg6lfQOVewEW53OTBAfAxbF6fQvxmeAHzuDF4J3gpDacMB8YUu05cVFv8fcfGxTquNNNPGGLkK1ig5VQ2jbBhXqBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732839401; c=relaxed/simple;
	bh=+1jGcsA5me/hlPtY6hZN+nlVDplCt+F3jgrFmdOXZhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvEjyDOcWGG0ofhwn+XsC9bzOM4CMnj3nOwz37XIPVm63muKoGJj0qKerM0YxlrnSBXjnjpxekhjykFO4uXb0SS4TXS0yV9KYpkQCRdOwZW5e3x51j/31mQiOAjEDvbTMux4QfAvAytxKK1ke/ypw1geL3tB4NK8Gq6whCKG+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUq/zh6a; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43494a20379so12070255e9.0
        for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 16:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732839398; x=1733444198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbFSU8mfSp+C4J8C7xfrYeS7VVgXZgy3mIP4Mj4oc4Q=;
        b=jUq/zh6afnJ8UgOecBlPAmd3BJTf4POj+gnqcLoOymzP88ojyf/WaErIleckIUaivI
         f4Ee0wSlHYlFlGnmZvUuUt+K9euHxrFqPvTrbQuotp/Xj6+OAvHOvp8wusmCMrmAsmdi
         2T7ydaXZ3JwBGQfTeC6wbH+BjfCYDhQ0vrHOFmq2L5HFUtw0vN5m1b5wBDO2qy4AJKZr
         3kPNAOOPebVN7beaQBEtNAN0ewizph25J9B2ClzyyqmJChp1bTmbAsxGS0AyX1oUI/z4
         u6bmT4N4MdR0yn8hyZKQAwB3OvNlabx7fRKLtkyKzorA5FbLxg5EEFB29HNwWCi8DFzh
         K9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732839398; x=1733444198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbFSU8mfSp+C4J8C7xfrYeS7VVgXZgy3mIP4Mj4oc4Q=;
        b=pdwLdXu+I/KLROZ4e+vZEhxmCC0WKgXtEArhF0e0Jo41FTXsPoM3NX7cdOeXXzc2/r
         k/KVsEuNLIr4mvieh0vpsk8mXOrGL9Yu6vk+TQECQu9ritUP+uaTCbRgQVMVtYcUNb5s
         H6v1aHovodS2kqOzSG2MIUBQaRcMHlkHUDAzVxBUvVl8fQiZPZALHW6APvSoYbsJN8Cx
         3Cu19DspOZpdI5dgPr6O5w9nol4GE6pyEjBD05sVL1+KQjFSS30R3+uOB8RyEKdVzJud
         B701COAJ+Jyc64jPbdk6W4qEvSW9RIAiJNULBk6lEKrQWSpvAVb+nv44eOD+USlza25a
         /lxQ==
X-Gm-Message-State: AOJu0YxItuVDNgiwSR5n2ueqe63k1+ZUuOGAKKX2hhO0ZyDeM0y36ZYF
	3qkJTveRALjLUZ+XYMvz0CsogFcZPjuzDf/xFr1vYPwQvwyn4xqg7848IhmhPrY=
X-Gm-Gg: ASbGncuIx0+NWow3ENCkQa87+VeMSxRSDDUFi3LQmKctcMV+SjMwA8x95dFKN61Zqgj
	FEBtDpGa/wOJZUu1KWgtUu+x1Cc3/5hHjMcPIlamtPvBp3vP1tOeLI6Se9WZGVlrs4eacbofhvz
	DwHmbKMW7vzwzGXEPR2VnhGrINpu/qSFH7BqO6kFIvP1Vna0nSUwtNbL0SqwoSlUuWqwRue0tWu
	j+ouYNKP7Tjx8KSagfNpQkMy96SUxegV0pd4exuiVnkSKGwqM72LltBsx6an4hp+nl9Zy7Hdgi+
	bg==
X-Google-Smtp-Source: AGHT+IHUpOnAuCbPsOpiWKu27UcOZWanoYAL3OUlqQTLNVKEQ9MpMCyuQ0Ge9vdBj42mHkUFt/XhCA==
X-Received: by 2002:a5d:6d08:0:b0:382:4b40:becc with SMTP id ffacd0b85a97d-385c6eb7f82mr7343813f8f.3.1732839398241;
        Thu, 28 Nov 2024 16:16:38 -0800 (PST)
Received: from localhost (fwdproxy-cln-025.fbsv.net. [2a03:2880:31ff:19::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385dec66e0esm234116f8f.43.2024.11.28.16.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 16:16:37 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 3/7] bpf: Refactor mark_{dynptr,iter}_read
Date: Thu, 28 Nov 2024 16:16:28 -0800
Message-ID: <20241129001632.3828611-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241129001632.3828611-1-memxor@gmail.com>
References: <20241129001632.3828611-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; h=from:subject; bh=+1jGcsA5me/hlPtY6hZN+nlVDplCt+F3jgrFmdOXZhE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnSQfbW7HRLItTgiTR2U8WHCh+Om8JhHHyEs01xMPd qTRbedGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0kH2wAKCRBM4MiGSL8RyohfD/ 4rt8fYu/HgZX6o1M73JqWObDMYz0BZXDC8IGVxQf/r5lLpeX0qW++m8J0isE2FeQXNQUseJ5ieIsvt SRbR0SbYt0ZDHk22YttYM+PQLIwFoG8Ksg6XszKYp4wZ45RQ5SDp9JcxTwlKtmYqEj716ONk3Px42G qQ918EDeO8fg3KqkvMJ2CPtspE9AmwFH/UDYmCWodHkf7niRwEv2kVIky5HKXhcwIzmw6tQ27Fkmy1 HrQ5YNLKFabgQceycbe8KShSX9NSJZqS9EGTgRuSLfZ1TA3AVsBlHp4QLHPHlsRKpxC1/eQxgkTg77 gp3zHxLKjD685UVtfJHX91aCO/2FbPYvQS3PbJcPmbYr3vtlBH1mDIhHZ+K4yXAHnzXtVFHkE0ZfjU ztPH82npnxYno2P4PZSegPq/MiF2L/LUzz8qKkRaAqwRW51sH7D+yW5yuFDxWd1f/6P1nZxQ6MWC87 Ffa0hjhU4I86FHgRLSWlus2mEIZjqS7aMcsyou+UJAACCkK2lehJvRVTM0VjTFw3ZnCAFhheZsd0Ok kRo2RYWkzw6T1JO8hT65Ddh9Xocm7uihnxlD0edYXxoXNsgBKSpsCE5htpITGRj8OtesZzfv/XimAb pT0/NLe+rBvr3mtn6sS+yqpo8ttBJL3mcXPrOS+4ucFKJwvSNylsoYh+QhQQ==
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
index 91bcd84fabff..992992816308 100644
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


