Return-Path: <bpf+bounces-26665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614D78A37A7
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9301C1C22AB8
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDB115532F;
	Fri, 12 Apr 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9ph+h6q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1C1514DC
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956109; cv=none; b=o5/RDCj7UJb/qiV74vgOa8FtnJcbfPL8lpq7i6BZWfpaIxsHju4pDWCtWMljYQ/5+mLtOd1ADnf4z6oYotNU4VHderW6twkegqDS8y4T71Tk4UdKtcFJ04BJtpvAJ89cnnuQnRpsR+wM89X84OdenN7OqOy0pA5AuWslUHZ0m0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956109; c=relaxed/simple;
	bh=Ez+l1VleCaf3f4r1vE+m+duR7QZfwt8rVoI9ub1KDEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rbr1623Ef8U/GcMIJMfBRv92drGXi4uM22c8SPQVrlzFhTFthFy+5dh8oCYdW9GcPPztyH8SVcQ/Q7ghIV74VRLsYNF0po7SM+PoCsAP43lGTw3Qs+lgDWPD25RFH6ciMqQm50VLJuqWs3K0n7mY4E7SZWzTnR6NsUZKTfmWIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9ph+h6q; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5aa1e9527d1so868055eaf.1
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 14:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712956106; x=1713560906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSxlDb9lcWN1aGaSHOqa6Mi308SXNva/SP10QJMLung=;
        b=i9ph+h6qoBb1Xr1/KIVMZzWdyn3YmfyxG45dffEZ3iSej6IMpl8U+mHzhnrje1HbjX
         lA9FtAaesiDhLaeJxf6Rmbd3/zuuXNK0mRTm0maN2qqzJrZcyC6Bh6iJE8gAqkhWmnwV
         gjSoOnBB235uYNJiOiOb1sRbUqjudL4cVBiwXwYI3zKA3mNRKSpbWPewlFf7LPCwnH1W
         cZpHvBFNaJeL9O4O5ffPSEBAUU3ECsIRGCLjdpR81q+piX+lRg+xxPi+lD13JblB82nS
         zL592qSUwBz+l6l515PI1/+oDh3SmGO8d2uLY6u59w0URYwI559THOQ5ua1y3VCopTQm
         qI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956106; x=1713560906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSxlDb9lcWN1aGaSHOqa6Mi308SXNva/SP10QJMLung=;
        b=GdkClkDclAKECzYSRwPzfpZZT8hxgC6Pwwjgr0WpamqzIFwvHdFmZQJvr8Vupwk5YP
         jyHIXi4oSk3Cobrw/X2fUx7h8kcIIt5HKSNFBabOgYeMBLhbjhgZASFoSC54bYEG9EyT
         aEfmTyA873lcT6HCqIu10+ogicGwizuDp7okrh1K67XLtBcHdJkwkXLizZUgGxDnhN1W
         Qx5hFad56P/AFiSxjbU8lG8Yf6G72/CpeQjpNU8tYx2+mn0Mp5ka86Pp04lWl7HgRFzP
         ehM8nddNS1gk4G8obAZOfY77m2zZdjyxusV7lgicuoOI57zUkOiWiLRT24ggdhH7M+k/
         KEyw==
X-Gm-Message-State: AOJu0YzbTLKwjMQJrDX+jCGBHI3Wpc/mJNZA7gUQqvQo2I1bv+CM9atn
	k4TQP4kBcWBBebjs5z6S6pPvHrG4Ag3yr1AHpSnjOH48/Txd3WB0zbFjCQ==
X-Google-Smtp-Source: AGHT+IHt0J1iJlgEHFlORG2unlRI4XSXyqLa3oUS2uKS/LnZGZLrE8gvmkwshgET6Wt6FiSWOdO0VA==
X-Received: by 2002:a05:6870:f21a:b0:229:f035:f5b2 with SMTP id t26-20020a056870f21a00b00229f035f5b2mr4632853oao.17.1712956106267;
        Fri, 12 Apr 2024 14:08:26 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id pk22-20020a056871d21600b002334685aedbsm1015117oac.11.2024.04.12.14.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:08:25 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 07/11] bpf: check_map_kptr_access() compute the offset from the reg state.
Date: Fri, 12 Apr 2024 14:08:10 -0700
Message-Id: <20240412210814.603377-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412210814.603377-1-thinker.li@gmail.com>
References: <20240412210814.603377-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, check_map_kptr_access() assumed that the accessed offset was
identical to the offset in the btf_field. However, once field array is
supported, the accessed offset no longer matches the offset in the
bpf_field. It may refer to an element in an array while the offset in the
bpf_field refers to the beginning of the array.

To handle arrays, it computes the offset from the reg state instead.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/verifier.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 302aad33a7f4..67b89d4ea1ba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5349,18 +5349,19 @@ static u32 btf_ld_kptr_type(struct bpf_verifier_env *env, struct btf_field *kptr
 }
 
 static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
-				 int value_regno, int insn_idx,
+				 u32 offset, int value_regno, int insn_idx,
 				 struct btf_field *kptr_field)
 {
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	int class = BPF_CLASS(insn->code);
-	struct bpf_reg_state *val_reg;
+	struct bpf_reg_state *val_reg, *reg;
 
 	/* Things we already checked for in check_map_access and caller:
 	 *  - Reject cases where variable offset may touch kptr
 	 *  - size of access (must be BPF_DW)
 	 *  - tnum_is_const(reg->var_off)
-	 *  - kptr_field->offset == off + reg->var_off.value
+	 *  - kptr_field->offset + kptr_field->size * i / kptr_field->nelems
+	 *    == off + reg->var_off.value where n is an index into the array
 	 */
 	/* Only BPF_[LDX,STX,ST] | BPF_MEM | BPF_DW is supported */
 	if (BPF_MODE(insn->code) != BPF_MEM) {
@@ -5393,8 +5394,9 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 			return -EACCES;
 	} else if (class == BPF_ST) {
 		if (insn->imm) {
-			verbose(env, "BPF_ST imm must be 0 when storing to kptr at off=%u\n",
-				kptr_field->offset);
+			reg = reg_state(env, regno);
+			verbose(env, "BPF_ST imm must be 0 when storing to kptr at off=%llu\n",
+				reg->var_off.value + offset);
 			return -EACCES;
 		}
 	} else {
@@ -6784,7 +6786,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			kptr_field = btf_record_find(reg->map_ptr->record,
 						     off + reg->var_off.value, BPF_KPTR);
 		if (kptr_field) {
-			err = check_map_kptr_access(env, regno, value_regno, insn_idx, kptr_field);
+			err = check_map_kptr_access(env, regno, off, value_regno,
+						    insn_idx, kptr_field);
 		} else if (t == BPF_READ && value_regno >= 0) {
 			struct bpf_map *map = reg->map_ptr;
 
-- 
2.34.1


