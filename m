Return-Path: <bpf+bounces-71028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F88BDF994
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDC254242E
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3607335BDE;
	Wed, 15 Oct 2025 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV30P9iT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA943375D7
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544732; cv=none; b=KxIMaIPHerlFJziwMJWbcPKxcM+w4Pt8nxlMQaqBu2sb+j8g7stIW8Engj8OL9oarWqLb8C8gXTS0ZsJn3ki+KXbHNE0C+3NsjisrbtYemQ1lPYAUSBU5OYAoz/Cmn5LpdZGiKQ8K6yxpngdvG0y5CShIyegLc+zxyVz59KJLfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544732; c=relaxed/simple;
	bh=/615i2pw1YFMvUMLR0DgSVv80VGF1v3z0OrbKcksrvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgcCsTCG0vLVaJYFrigBRwcXGMj73ZkBF5dvzTusq3Ag8sHXi7gJlYg1mTaRwys1jIRqVJN9vnXOPjASD3se85F70Ik83FYclr+IfSa6AWuXqQC4IDSpP1GyUyadx24GogxrF76gX4yuqeVEWK1mlwLZajoocFrqHT6DlpnSaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV30P9iT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so4069960f8f.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760544729; x=1761149529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtPL9lkVxbDp3+1W56aqYHsEbyn++VoHj0R7799hYUQ=;
        b=GV30P9iTYKZ1ghz23yNoLVbULKImPf9sgOMsYkAJeprRPattUbNe1Y8CnSs7A9wDcN
         PV8HRFM4U3LPEkULUvt+gncyQZd7pt+9GgkZLi42tNizw0o/eEYJOKHBQO6jY/7Hkp4F
         iBLiwew8uBrOXo+/BdawZ5JrHhYF/rMd+TGtD/IDI9HrsCykOfpiqnbSTAh+4hOs5sBy
         R1PKLHqW2lMp6dVB025Ggo8JjBEyhSTCVgcEfhjxMS1smsTJvkB7S82xkCopOuz13TIK
         uDq7qHOYPbbMZuQvMOuYYZo4Mdxia6qfhDYQ9AzWBDS5dqcE9Up3ADfXYhPeeuHQE2Eu
         dccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760544729; x=1761149529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtPL9lkVxbDp3+1W56aqYHsEbyn++VoHj0R7799hYUQ=;
        b=ID6n+iGbi7dSnppYAtdqW/HrHfYR5zjg1c+NE8/eA/ykIWO+Ugz21w4ErRZg76eLaC
         mIHMZxSkOi+mUbQQH8yYmC723rRFLxHHZXVp7WFgcZ/d/T882eVAuBtHzvrr74FW9CVw
         NX1ZBRXruntiW0UfT6qkXFklT880jo0pr0gy27AD9NcRT+TeGI8AZBCgERl7AhkKkAdN
         QtAQ7t6GHLaJ+4geGqEzwXMg2rgQKBQj3VohG8INpVHOr+/pyxM7rZz0Pt46q3KY/lif
         A1mktAiBDDwCSYlhSRg2diAKREfjdaw9/WQ1nyPRiYAa2phOEn4HvAVD9W06J6JUWBt7
         wNdQ==
X-Gm-Message-State: AOJu0YzcARH8f5Va365x3L0PUl9j12dcb2GDv018I+NGn/5ek9xuv1th
	w0zi0XaTKmpsHMjPts3NDcmKM8DfQja1Lzt/AyCAMaLVt+nWERI4y/0gpbYemg==
X-Gm-Gg: ASbGncs2bBoCLG7ft7wlJdqkBflDjG7O+O31Sn8pnums2W9j6RrrKLwXtN/rZSR/KYC
	M51YZ7WTqo6d3WXxWQopvXpPxjT8QvwJP9RaXEQBGJhgem/LjY/YtBs2JQ+bhvQ0voq8nHEfd3o
	606vbzgEoDrSxbzh2J8AuxptRzBxfNgeAT8R7aC+2KpOJ9YMb1ikSckTS4lAzPrOuFuYYHEJg7B
	Np+WKRK4UYBoiKROGVcnm7mTAmIxAjopxFq+oJFbzHVL7u902Ds6iahOZ1Rri2HbtR4QQea8t/5
	RAP9sDSlDtTXCf4jyPmt+3veiMzSQzFLIDQIoxMXjs7BnVcQosgFn5K+2uL2oKYhfJrDoAwFgnb
	REz3xXJZYzitaSpRO9mkTUKHQY9v9GunBof9V16skwcKg
X-Google-Smtp-Source: AGHT+IF/ZubuzQmiEF4Aac/InZ3aE1/4RKtFM6hzQWeSKN+tfMux7WeUqKgq2mpnoTOTmsYJIL3d5A==
X-Received: by 2002:a05:6000:2f83:b0:414:6fe6:8fa1 with SMTP id ffacd0b85a97d-4266e7dfdbemr19570386f8f.38.1760544727268;
        Wed, 15 Oct 2025 09:12:07 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3cc939sm184743975e9.1.2025.10.15.09.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:12:06 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [RFC PATCH v2 10/11] bpf: dispatch to sleepable file dynptr
Date: Wed, 15 Oct 2025 17:11:54 +0100
Message-ID: <20251015161155.120148-11-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

File dynptr reads may sleep when the requested folios are not in
the page cache. To avoid sleeping in non-sleepable contexts while still
supporting valid sleepable use, given that dynptrs are non-sleepable by
default, enable sleeping only when bpf_dynptr_from_file() is invoked
from a sleepable context.

This change:
  * Introduces a sleepable constructor: bpf_dynptr_from_file_sleepable()
  * Override non-sleepable constructor with sleepable if it's always
  called in sleepable context

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h   |  3 +++
 kernel/bpf/helpers.c  |  5 +++++
 kernel/bpf/verifier.c | 11 ++++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1d7d50d0c587..73fca44a3dfa 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -670,6 +670,9 @@ static inline bool bpf_map_has_internal_structs(struct bpf_map *map)
 
 void bpf_map_free_internal_structs(struct bpf_map *map, void *obj);
 
+int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
+				   struct bpf_dynptr *ptr__uninit);
+
 extern const struct bpf_map_ops bpf_map_offload_ops;
 
 /* bpf_type_flag contains a set of flags that are applicable to the values of
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index da83298bf916..42e2add35589 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4337,6 +4337,11 @@ __bpf_kfunc int bpf_dynptr_from_file(struct file *file, u32 flags, struct bpf_dy
 	return make_file_dynptr(file, flags, false, (struct bpf_dynptr_kern *)ptr__uninit);
 }
 
+int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags, struct bpf_dynptr *ptr__uninit)
+{
+	return make_file_dynptr(file, flags, true, (struct bpf_dynptr_kern *)ptr__uninit);
+}
+
 __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 {
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)dynptr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f9f7151eaf1f..673923ecd465 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3126,7 +3126,8 @@ struct bpf_kfunc_btf_tab {
 
 static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_id);
 
-static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc);
+static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc,
+			     int insn_idx);
 
 static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
 {
@@ -21870,7 +21871,8 @@ static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_id)
 }
 
 /* replace a generic kfunc with a specialized version if necessary */
-static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc)
+static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc,
+			     int insn_idx)
 {
 	struct bpf_prog *prog = env->prog;
 	bool seen_direct_write;
@@ -21905,6 +21907,9 @@ static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	} else if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr]) {
 		if (bpf_lsm_has_d_inode_locked(prog))
 			addr = (unsigned long)bpf_remove_dentry_xattr_locked;
+	} else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
+		if (!env->insn_aux_data[insn_idx].non_sleepable)
+			addr = (unsigned long)bpf_dynptr_from_file_sleepable;
 	}
 
 	if (!addr) /* Nothing to patch with */
@@ -21954,7 +21959,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 	}
 
-	specialize_kfunc(env, desc);
+	specialize_kfunc(env, desc, insn_idx);
 
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm = BPF_CALL_IMM(desc->addr);
-- 
2.51.0


