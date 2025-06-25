Return-Path: <bpf+bounces-61563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EADCAE8C50
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 20:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB18188B18B
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207F92DAFA4;
	Wed, 25 Jun 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbAGANeU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371DD2DA752
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875869; cv=none; b=OuZAulnQBqtHam/jvoiccPfoKTxydsSTgPFJOQopUG3yI7iECo2TmB9EOAHn6+DD8ppkeAh/rO4A+q2vS1ay4/h8pgN0CPvE8qW96Y/bB5vCjjJmErBKJ5YJJkXMkwV456uh+GiHYPaS7Nul5b2AksqpDyIGRhi+LgS60tynBOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875869; c=relaxed/simple;
	bh=x9cIn1beRE//EPxRGD4AoK7GWDHcTRXnN115hgATNCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KltgT/3lpeQD+tUgkuMgf8NZsudPKbBph/6BHu1Ofh3+XeDnCf6r7Kae+54NhmP0pE3opQ716lCaO5HUzAKncGU6PEnvv83GCH7izUYnX0UGVWrSxJc1B1ADhM0S5WEqm/cFZ/g41VeaQO6fg280eN48/5PYdV339knT0lMbJgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbAGANeU; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b31c84b8052so195242a12.1
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750875867; x=1751480667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSPJF1PnRNgrZuQx1wJJjTuqhQaydgliqNqt+9X017Y=;
        b=bbAGANeUVL/UdQmgW/sk/nYoW3G1Zl7VkanTK83A2kW+b+icsTajXnClOqal69tSMu
         dtwUo+HpcgfLKGCABH3OgXqu7jSXEH7I86NHu6kx4tPvxCpKMhcKVMlVsb+fF8DREC8s
         kjrywqw19Zlpj8k5FmMRcsPjOEPP/wss9W40WsiUeYLUGFvxV2YfHNZ7olHBxtpDe9D+
         7/So+56gloNYsJ/HN59aeaHQqGftxdCApv5XZ8xJRYeoGCrBP5wHdbE4VBXu8i1eAztu
         l88Cj6Day44/rMJexJUagFfvBLiiDynJv8+O6m60R3L3tyo1zsio7OMwzgFBHMFWWod4
         SjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750875867; x=1751480667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSPJF1PnRNgrZuQx1wJJjTuqhQaydgliqNqt+9X017Y=;
        b=Mrqds2Uv2LrkZ6Si/k/dWgLHgoI1LBd8gF0J+YzxD1zPh6d3wdP4om8PjbN/ZzYj5H
         8wY3xYvizSbS8bcHyVHuw/dFlUBKI1LMEq+XLwm/9+EtuTy7GyqlUcIxAv0RzkA7CJEw
         LB4bjBCcHpVKaFifsOo8e1XoGALiR2H5YXadFZ3BL3SSgzBr0z7vaYCy32cvYWJJuU/D
         lKaPMImstBfi0Hc7Se18MjGOo6e3GP1a+U9h2IxjABwyiuSHM+x0OqkZL1RWuJG1qIqv
         xgX0K2l/88iAsHp2xkCbNin745Q9ckyqkuZ29zhwCMzjW5fvLEAefjG/3S8r9wFRBPe2
         Q4pA==
X-Gm-Message-State: AOJu0YwoCkdJmX4tWZz2VI7Ce1ajFBQVsYSgF8cCzi4ip93YXVqyGGv6
	/uGqa7eVaN4yNXQVDCnVk6pMFgSR0hVIsfIF4tc3lqQYzq7AWI+4GuCrTnLHGOdsDp4=
X-Gm-Gg: ASbGnctOh6LhaE5bsi2IiOA8a0KxsE+7pKnhwjt9Lpjaa2FjO1tjoHBzw62O+ZXw9Ak
	b5qlGOPEjcRGIkIvTytKtjAVLmmrB1hIiNCnA17o3VPjZPffpuvMgN3sG/pZ3M4VLlfOb7azZ1H
	1hLrTodpyOCaULSVhFEYRV8rqi0KfukurVar6I4loh9IQiWrv8FZwsqpNt9u/Tq1ElXDzuWQuHa
	2fh2qZTqz4qTEkBZPvvPWuJw7aLuDAlxs+U+8SgpSdWufgqO/ZbzzMhqf4T7ZYrpDNQeURmGp7A
	tEkcPJWUyz6mHV71JtJK0Ur8sbAe8ivcl6rbsMwbIWPKrYxJIHVppt1CeecAq/qtSNGkMw8RkpI
	zZ71JH/BnQQ==
X-Google-Smtp-Source: AGHT+IErY8f/igLKTTnXK4C2qbLWFC0gg6dD2H4dC68pnOL/7FWR4WpUMsUxh9HQ7QciFQyuz+Bq6Q==
X-Received: by 2002:a05:6a20:748f:b0:1f5:70d8:6a98 with SMTP id adf61e73a8af0-2207efa479dmr6827225637.0.1750875867101;
        Wed, 25 Jun 2025 11:24:27 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:1734])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1258b4asm13322939a12.60.2025.06.25.11.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 11:24:26 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 1/3] bpf: add bpf_features enum
Date: Wed, 25 Jun 2025 11:24:12 -0700
Message-ID: <20250625182414.30659-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625182414.30659-1-eddyz87@gmail.com>
References: <20250625182414.30659-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a kernel side enum for use in conjucntion with BTF
CO-RE bpf_core_enum_value_exists. The goal of the enum is to assist
with available BPF features detection. Intended usage looks as
follows:

  if (bpf_core_enum_value_exists(enum bpf_features, BPF_FEAT_<f>))
     ... use feature f ...

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 279a64933262..a55bd95a762e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -44,6 +44,10 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
 #undef BPF_LINK_TYPE
 };
 
+enum bpf_features {
+	__MAX_BPF_FEAT,
+};
+
 struct bpf_mem_alloc bpf_global_percpu_ma;
 static bool bpf_global_percpu_ma_set;
 
@@ -24388,6 +24392,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	u32 log_true_size;
 	bool is_priv;
 
+	BTF_TYPE_EMIT(enum bpf_features);
+
 	/* no program is valid */
 	if (ARRAY_SIZE(bpf_verifier_ops) == 0)
 		return -EINVAL;
-- 
2.47.1


