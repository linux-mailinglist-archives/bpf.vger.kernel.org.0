Return-Path: <bpf+bounces-69280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F587B93928
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE854810DD
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C45301466;
	Mon, 22 Sep 2025 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfC15hyS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF262F0C63
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583584; cv=none; b=bYzvkEqZwOvuXCbiVI3V+2utfUnVnDcDtS8Z/yhIAc5ll7pWG2dFC9pPElAyyqv/KXkHycAnLiNNTBZNTEQUTWnvx24sBa4xZwd8Vaw9ShdrxCehkK24xbV47cutQAAoufA63uqo/fZnvw66XwwYSxNjDRQcwuZTkT2/VpzJzfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583584; c=relaxed/simple;
	bh=mYjZflfraofIdIrqNcyASv3dE+/T+CixX0RdQcAvzkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKcmjS3aczO+25RN5pMwkkfeXRAzrHelJe8UpU1FRsVvuVP2uG0Z3G3JRu4Pmv9glj5vkfLpX90PIjbQmT+4yujNbWZIf2VERMqhQg0WDN8KDGup/og9AiH/GG80Ian9G0HN0UjEk9EF1gYUtL1TeDg9FHHZXRFdhEbzgaXCl3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfC15hyS; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so696223066b.3
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758583581; x=1759188381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PonWviSEZ7cyWph0UVcu7ayGQBsHDfA/+HZsNb1jRKE=;
        b=PfC15hyShwVb5Z3BtX0Lkl/q+LuDZPxnBifcLrzmPb9Jya3mfzBRu3sHNFWwIEGH8J
         +TU0UHmmtaxugx95yDNIiAeRrqsOhaEWiFAK8OV2hdRud+JbyNMUSQmNOpRTM7wsYmbe
         Z+mpPpvlEAMuOZnBcilz9IH5CHDbGnV+yjX69KOGtFunss+bWHLBQVHLH92djNEho0S1
         QF5L8k9MToPXdPThNRbMKEGyzhnWWOjQabj+0kkZgT4LI3Qz52uxLsX548/BVRg2fqRQ
         vOBEl1aH7tSwvkif3otkTYuONpk3eq3fXRNGiRSq8T38qkdjUFYFYyEU50E8v4molkiO
         nEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758583581; x=1759188381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PonWviSEZ7cyWph0UVcu7ayGQBsHDfA/+HZsNb1jRKE=;
        b=lJOQYSidFMGi8ZsJSOhTTpXYyLam47kxIrxUcm47Gp6jW0jeZmg6b6UK7EMF7Vg9sH
         4pEddhiicU2POOz0upigY1wQoozWIUoxv3FfMiFz3ZF0xkA+ZJ1hbH+aHp6WM3oJLpec
         v5w39axCEJGSnW8GkCoUG9jIxqtqgSq0Af7n0hzK+8hNdUIjFaaGHzcZWA2O9bhswt6K
         I+9gxYJ57H9y+ijA8BxEy22Z0o15KELOsqL9+vS1mQMJlSjD/a08me0Q80B5ojfdfEt/
         rYKjmh2EDBJtyTlfyNiQUjpEx74ONJNN6TPh3Y/Z39zs3b43CzEN/LWLH5bjDn2CS5tl
         gYdw==
X-Gm-Message-State: AOJu0YxQY8b3lLCB3Kx9z4gVBTdSry17aAG5MIFbFMwHUmNeHi4xObQ2
	5Mt5hpnqH0OMvV4FMoijdpIvkzwgIh7u0iPzFGoHrg59hy+aYe3/Yyj9OK2qbw==
X-Gm-Gg: ASbGnctXrfTOXTxzb/3nupNt0XWoUaHFNdY+2eh+SXoP8QYUemRHhIhWcex8rPEg9oT
	nSHVpsJB99ztami2D7mOV8y9vEkiSWiilR1blswPfY1E5EygQjGOVxdZcbTVhNnww0N3PJQ8dCX
	Y/jqQ0yjMzHQfIbEZ9zcaKFL/BtgqWtQFCSXIWwz/mUY0inzrxt8byaPEG5U8vKrVjj4/oGzVuy
	DVul/SaWWAmzfiwMZHFzPeGG0JM6d+sYv/isV5p32g/uWL5SXTlA0FxazVQui4jctUerCDbQFcL
	xXbKBnG6+YH5WVQHrcDbCmQZPuIuwp8WL+eFWkPImt+3NQUmb69HRHKcfTPP/oxLu7TRXOP7P1V
	5Aw632SeDrbeEjP04x8J0
X-Google-Smtp-Source: AGHT+IGao1+eX/myQiwpEf7G5smh6LbTh23X/ubv9QvCaI4ar8ldRs3aFNpVVGWgrZzVgvYizkzmpw==
X-Received: by 2002:a17:907:3c82:b0:b2a:b44a:dd4e with SMTP id a640c23a62f3a-b302ac2b8a6mr37748166b.30.1758583580885;
        Mon, 22 Sep 2025 16:26:20 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd2814abdsm1191390266b.108.2025.09.22.16.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:26:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 2/9] bpf: extract generic helper from process_timer_func()
Date: Tue, 23 Sep 2025 00:26:03 +0100
Message-ID: <20250922232611.614512-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
References: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
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
 kernel/bpf/verifier.c | 47 +++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1d4183bc3cd1..c1b726fb22c8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8431,34 +8431,59 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
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
+		verifier_bug(env, "unsupported BTF field type: %s\n", struct_name);
 		return -EINVAL;
 	}
+	if (field_off != val + reg->off) {
+		verbose(env, "off %lld doesn't point to 'struct %s' that is at %d\n",
+			val + reg->off, struct_name, field_off);
+		return -EINVAL;
+	}
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


