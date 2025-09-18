Return-Path: <bpf+bounces-68785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B535B84CB9
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58EF7C3A2C
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A211E30C355;
	Thu, 18 Sep 2025 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKu2/RZD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF7830BB9B
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201997; cv=none; b=DoUyimezr/u8QN0cYN3CBJunXrfsKtOGsF1gki3zpi7T2RwcepsG6QquGAPrBFD8+YWuI8vHNZKGckYeoV60mOS4AYR5VBCqPbXfHSJQo/bq7d31q1PNhl3MwgpOPMqCZ649r145MK+E1TQ3f8ihzAyon2BhCsbJECLK2cwl7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201997; c=relaxed/simple;
	bh=IRfvfg5A7Vsw6vaJ7TEFUQ5Guyt8Fltr8hWLEByxZ+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kh4brpPRv9BYjqz4zGfg5LNAok0EhUJms4c2PZhew1F+PFEgHRO+xcaroKPBjhDOvA1hhEhDsc6MnVUnFcOe168Snqpk0R6tx0hKcaIa3MiB1QJdgY0QFPaCEjGb035KNL9wVIRNb2oI8fUeeGllzP3iBs1hWMccJh78y14O3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKu2/RZD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3e98c5adbbeso625873f8f.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758201994; x=1758806794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icA6Y/dNSEJnSM2nBSCiA3A8aZytxxIU2lGp49USpTw=;
        b=hKu2/RZD2Avf3SDMLAjVEJqelWp6f0WYzmSfjzJ8qLs+8QMmXCwDOfabhph6y8/Jqr
         Nuwzn4mdSkTNweuE7rYf7EhUgCBOlEKDYvCfWLgQRnlPtBNXN2B0uQPE8AsWism+I8e4
         fbT9YiZkuZUYj1aeBSL7MYO2iseiyHDV+rXC95JGgcc63Jp6sVaiTgJeNnEWjaD8hVRS
         z0/rAt0C6NdcB4YWScJdSZEbAshQv7yJU9l4sePYNDk/2R6n3xtuV4gb28GVFCWtUaeA
         PcyrL6npOHwxl5KEstFZn+ZuV7BqaaMEDglhvBkZx5vq88JYuGcOoJJtm6aCS1Dv3xh/
         sYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758201994; x=1758806794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icA6Y/dNSEJnSM2nBSCiA3A8aZytxxIU2lGp49USpTw=;
        b=ws5MLswgkTkjcMqMmUILBj4VDdRxfXD3yXBOivGrnPIjaAVTefC6zU6kjG3CPNqdEn
         w/nxNzbUg5KviUpzWujzLGesiAfWJc1Fer+7adcVkXicBHoXz7PuQR74WR0swHXETBJQ
         VCDd/tIUXb3pOJ5pwRjUqonC1UNtUj68Rmb8ySN9JGldLTg5NI8dbPaxIXzlxVxsGyl5
         c2u63+XWp2g5HASj5wTQ5XhMCLV7RUSRYrUxuJLmciTOOCtkqRlKk+RGni6lj1rEmER1
         hfi3Xx88BopvXNwLwrkoxF5cGVAZvjltDwvEO5BiMIohbPo8/Sdq5dWVY1azGkVDCc6G
         A1XQ==
X-Gm-Message-State: AOJu0YwxJ3HRQf34Uo86K9tH4llNIFE/amBJ6bLa2q8Dsm9Vt3qC5XIJ
	EAlQWNImRAnlbXzXPGioB3LxxW9XpPhF6J0iv5nw2PfhPE5noeLQBH/Qld8IUmb0
X-Gm-Gg: ASbGncs0WCPmWqAXod8QhAKV0X+/Obv4+lf07roSrsiS9H6+ilXZKjKONl9SyZcIapA
	26O5AAHnwFXXIS3wL3Guz9ltbn/S+l/4sMgXB+RpKeMuWMEh5CZlM4HxIrARqHJMlDxqUFa5sMv
	oYo1BpybCpqvwwF+7yu8pTsMs9SgpFR7dP7OfKte5+bNx3Cyh4JcgNzzCiuVuGj0nN1mlJGKY5l
	kKshUJPxjkykGqDU9iKiUxhtS7H7q78j3TTMAejckl7qTd3LpJll4dwR1johzO6Zq2X5u9lyefp
	80QTmakBpZ8mS11EZicD2Jb8q4IrAyJAS2SvCxq2nyPtRs76DsFnc/NfFM28jG/9PHf8ZI4OOv3
	+bcxDb0dHpxTrgXqr6stx
X-Google-Smtp-Source: AGHT+IGKTnVDF0DUKTw896F+emXl8YfwYnBF4Tcgtp9s1ArWYLU0auSeoWnzA0sh2q5V6DQvDfCeig==
X-Received: by 2002:adf:ed8f:0:b0:3ec:e152:e2ce with SMTP id ffacd0b85a97d-3ece152e644mr3406371f8f.32.1758201993503;
        Thu, 18 Sep 2025 06:26:33 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:ce66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32141ae9sm59012765e9.5.2025.09.18.06.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:26:33 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	syzbot@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v6 2/8] bpf: extract generic helper from process_timer_func()
Date: Thu, 18 Sep 2025 14:26:09 +0100
Message-ID: <20250918132615.193388-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
References: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Refactor the verifier by pulling the common logic from
process_timer_func() into a dedicated helper. This allows reusing
process_async_func() helper for verifying bpf_task_work struct in the
next patch.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Tested-by: syzbot@syzkaller.appspotmail.com
---
 kernel/bpf/verifier.c | 46 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b9394f8fac0e..c5a341ecbbaf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8520,34 +8520,58 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 	return 0;
 }
 
-static int process_timer_func(struct bpf_verifier_env *env, int regno,
-			      struct bpf_call_arg_meta *meta)
+/* Check if @regno is a pointer to a specific field in a map value */
+static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
+				   enum btf_field_type field_type)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	bool is_const = tnum_is_const(reg->var_off);
 	struct bpf_map *map = reg->map_ptr;
 	u64 val = reg->var_off.value;
+	const char *struct_name = btf_field_type_name(field_type);
+	int field_off = -1;
 
 	if (!is_const) {
 		verbose(env,
-			"R%d doesn't have constant offset. bpf_timer has to be at the constant offset\n",
-			regno);
+			"R%d doesn't have constant offset. %s has to be at the constant offset\n",
+			regno, struct_name);
 		return -EINVAL;
 	}
 	if (!map->btf) {
-		verbose(env, "map '%s' has to have BTF in order to use bpf_timer\n",
-			map->name);
+		verbose(env, "map '%s' has to have BTF in order to use %s\n", map->name,
+			struct_name);
 		return -EINVAL;
 	}
-	if (!btf_record_has_field(map->record, BPF_TIMER)) {
-		verbose(env, "map '%s' has no valid bpf_timer\n", map->name);
+	if (!btf_record_has_field(map->record, field_type)) {
+		verbose(env, "map '%s' has no valid %s\n", map->name, struct_name);
 		return -EINVAL;
 	}
-	if (map->record->timer_off != val + reg->off) {
-		verbose(env, "off %lld doesn't point to 'struct bpf_timer' that is at %d\n",
-			val + reg->off, map->record->timer_off);
+	switch (field_type) {
+	case BPF_TIMER:
+		field_off = map->record->timer_off;
+		break;
+	default:
+		break;
+	}
+	if (field_off != val + reg->off) {
+		verbose(env, "off %lld doesn't point to 'struct %s' that is at %d\n",
+			val + reg->off, struct_name, field_off);
 		return -EINVAL;
 	}
+	return 0;
+}
+
+static int process_timer_func(struct bpf_verifier_env *env, int regno,
+			      struct bpf_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_map *map = reg->map_ptr;
+	int err;
+
+	err = check_map_field_pointer(env, regno, BPF_TIMER);
+	if (err)
+		return err;
+
 	if (meta->map_ptr) {
 		verifier_bug(env, "Two map pointers in a timer helper");
 		return -EFAULT;
-- 
2.51.0


