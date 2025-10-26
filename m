Return-Path: <bpf+bounces-72284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9ABC0B365
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97B884EE6EE
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169BB2DF128;
	Sun, 26 Oct 2025 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTPUdPPT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89842EBDF4
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511161; cv=none; b=QN52udw/EJ8LtUphO6WyX8Pp9x4oSZtV7/1gi6ZBaCmM8aUXwj38yrhXzpvBpyNp/woVM/NlbnDgi2mu8VzMNcKMvt5zsy5rE8xaJDwSBqS55xVeEOlwtxwsdIvlj1sOZS6S6sT2YTQlW9I5BwpgPppAiGolBhAVaa6yqu7sA4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511161; c=relaxed/simple;
	bh=Yh21s1zUY2z1+0CR2jf55JqcyIVAunx89nxUqhCMbWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eb15yxbgV6lM+eL9r4JHUwTmrbdCshDGsu6HZzo3Iv1DiN9BhX1v96cbfYesFq2FwCwQ/aGXLKifgEY8rZGnzGfdfgQ9FOAWCGLQPFNdBLf22DukH5l8W6SaUmy8hd8ojNXMj/nucfYm7JQ01wKXUyUfg3V9WfzDSnGQRtqdl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTPUdPPT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so2536845f8f.1
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761511157; x=1762115957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HblCrJO2VQ9F6wTL+7zhibWFu5gVNIJXS6kFnUwNvQ=;
        b=YTPUdPPTBryvD8AnKvcg/R4HZQp+BFyrp4qQBvMkvzrxKPBfiWY9mlIewV3u2cxmOq
         GLicXi2XfGF+BTlXIJv1eXvwdSIzC4IhlbOkQSjOf2Dxd07MrbnBihYFcP1eZqd6JlbE
         vn4dQ85ml+S+rjRlxAh9k5WHEDq7MttMQnHp731kZ4w++vtyq4/AvUFGJJHDQt45hIW5
         ihbpSJ9RJvOzGpNlGQ9d2Gg//PKYdjznnsWw41OflP8Cx2dxlAv/EpzTCnpAyWp5r8tC
         6IR9RycRvgvcQ2EVFajIfOdm9zu5qjmccJ8jJ/wqtodKLlpL6FWdmHH5Vqxo/mGBFxSC
         hXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761511157; x=1762115957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HblCrJO2VQ9F6wTL+7zhibWFu5gVNIJXS6kFnUwNvQ=;
        b=MVjvQqtANmBHQs7uZBNKFxkjqGzLJi9GTH/00VaFIM10q7QitOz4Y75LDfFk0rXYul
         u5d1A+cDWSRI4RuMviUI6dwCTwhD8xTHV5/IKhfN/ZL94Dw2xjInDEMr95eD0WgSVlNr
         0/uvQ5yBudjq6PvPIaJfSoqqyp1uSrDX8abuCtBysa5ibuSnn9bhSDr4fY6EAad4tRxD
         7go9Ac1xYP/++dpjR6MwotoWTbzfWc/n/h+uJpBvNLDGUF2H4tttNsYXqd2SXspCYo2Y
         EYik8xHAm45/wNgy6MM6QxrUVMVsbTcScjRH+StSKRbK7J9zp+3XLhtPxHFVHELjXr7z
         RMug==
X-Gm-Message-State: AOJu0Yy52nb2TJFFeLs6mGjiWmhkW8Kzu03SqmlXQl/dS0zSf+mX0/9U
	3y5imN7YHanF4QEgZ5qWDS5D7ax6kg/4CYAUK1xQg4rlgdQyjaBo2RYXszZczA==
X-Gm-Gg: ASbGncthFwfGyvdagR0kibplxxJ07hQJ8n50oqtYJal7QO8XIQsmbvJp0DSKQ69ZijA
	Z8jIi+g66VOzDZrIywYKHOZHC70JlrfvUbajFPOJkn8Kr5ynjSfjo8bib2wRWPVjJS0WMcaMZ3m
	Wwc7Vx5O+QfRLGnH+sdp+NrRVmxpAk0NT/P6njRns6BBYVHrKbe95vTOgZ1EKXXeyRQnBAoG/5T
	DzMMXSUE3VX+3w9gVNqU+Xn44JTOC1H7boOt68HodwhuOjYbqbYn8QGPcw5A8qGU8jvrb2RDAn6
	NWM7QcFWdeyPMsW5nvKzsEIsOaT+A0TPtGzjQnoc6xrEAcUjmUqkH9/wHel3rHCpiyrb/FZiAXi
	5K4OvmNVT6RkTqqHE7r/zFoQzt1PDvfX/CQO+P7IaqMId9G92suZpC1mR0ud13ft3s7GgSA==
X-Google-Smtp-Source: AGHT+IHhwtTa9Bmh2Jv1DSX3+jRi7Q189PRlZdJkkH4O/pOa8yXy7W8rkgYOg0eOUT80yce8WFBJ0g==
X-Received: by 2002:a05:6000:1a8b:b0:428:3ee0:6953 with SMTP id ffacd0b85a97d-4299070192cmr7521190f8f.3.1761511157012;
        Sun, 26 Oct 2025 13:39:17 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:4ccd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952da12dsm10439502f8f.29.2025.10.26.13.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:39:16 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 09/10] bpf: dispatch to sleepable file dynptr
Date: Sun, 26 Oct 2025 20:38:52 +0000
Message-ID: <20251026203853.135105-10-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
References: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h   |  3 +++
 kernel/bpf/helpers.c  |  5 +++++
 kernel/bpf/verifier.c | 10 +++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 14f800773997..a47d67db3be5 100644
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
index 99a7def0b978..930e132f440f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4336,6 +4336,11 @@ __bpf_kfunc int bpf_dynptr_from_file(struct file *file, u32 flags, struct bpf_dy
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
index 61589be91c65..542e23fb19c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3124,7 +3124,8 @@ struct bpf_kfunc_btf_tab {
 	u32 nr_descs;
 };
 
-static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc);
+static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc,
+			    int insn_idx);
 
 static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
 {
@@ -21869,7 +21870,7 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 }
 
 /* replace a generic kfunc with a specialized version if necessary */
-static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc)
+static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc, int insn_idx)
 {
 	struct bpf_prog *prog = env->prog;
 	bool seen_direct_write;
@@ -21904,6 +21905,9 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	} else if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr]) {
 		if (bpf_lsm_has_d_inode_locked(prog))
 			addr = (unsigned long)bpf_remove_dentry_xattr_locked;
+	} else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
+		if (!env->insn_aux_data[insn_idx].non_sleepable)
+			addr = (unsigned long)bpf_dynptr_from_file_sleepable;
 	}
 
 set_imm:
@@ -21963,7 +21967,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 	}
 
-	err = specialize_kfunc(env, desc);
+	err = specialize_kfunc(env, desc, insn_idx);
 	if (err)
 		return err;
 
-- 
2.51.0


