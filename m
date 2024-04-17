Return-Path: <bpf+bounces-27080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E51068A8F7A
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 01:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACAF2838FC
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 23:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24F9176FAB;
	Wed, 17 Apr 2024 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n8cnXciS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27FC175549
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713396969; cv=none; b=QvZJufQtsgnlft4OkW1AFaZEOA/ZsUMyFSuCg2LW5HaWwd36IGZDBssNBEpCXeitAAA8dtfoYkvaPVqBa0OZho3gl1cTXQwEEaJEhDWJT1EKIGDZroVebpumBuZ7UoMKq2+qI+vpPPvzWnkqkqVZVEgpY7ujeS2Z/LKqDBppDmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713396969; c=relaxed/simple;
	bh=MbU7YSyF5IXinkJkjcfT0u+2sLXGMeKghessXGBFpX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i2X2eX/gRsxJ3qkgOx74RKp6S8MTeYb8cCjikq9xq7LzhmJXjghilg21pYwmBl6TQeRcFq5KyQJFTbGUKR0vsPH2Nj21RSufFmXEHnO12IQaCR8ubeQpfykGIkqdt4WI8WcFMBgAaOaPje6/wQo1UyslgiGnU/m4QYI6fNJKXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n8cnXciS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so532436276.3
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 16:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713396967; x=1714001767; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftfV9j6OBLIDvLqAVZnPAyLe0oFUXv4e5neRndjdTGc=;
        b=n8cnXciS0NWXEmuCHwCVNG0JcHytbOjl5JtXjLPkRNiaEoPXSDlAxoe0akxxOEH/Ks
         q17AUtn0CDdaSWdiDK3tnqeI1OE6PBEITBu4/GDqBIceIDWdLGVY6EBbcix3EhjONEMM
         DjTGPekHN98uCcfkGlQ+Fk1J/8fIS7meNXSFvT8Qxi28eLPn1AtcnaiGJ+EgOBTqlFQj
         Ms7gZBWl6r6ybvtm2ShbMQqUdhnDIDcyPdaemt3h7BzsGD5gDvRvaiSs+ii8hzZZhmKb
         UGpH0W6Yd23cRPTqEaB3Migs4KLSQVzW6+XhE/9UfByRCtVlgkbnAShSlyIuCv7FzIyR
         bUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713396967; x=1714001767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftfV9j6OBLIDvLqAVZnPAyLe0oFUXv4e5neRndjdTGc=;
        b=kOiSnHU61dGMgs56L/tx5CMPNNNkQ4MdouX6btgYgFbgjYJCXsFSh0yZ5uJm6XYiNf
         2S6DdIiI7ueJkMw6G2ASbuQqW52bX7uES1f4kdXgJf/slJ3CFMVxfh24D2iZt4RfkU19
         JzECPLbBCI+OtM1BbxgsCpdDz1PJwiGwrxZcG7qX/5Z2vmEazJO2E5qrIQk48VSyfffR
         veQuy6w577MV8vgAqKIBLWmks+bsOUON+q3YA1trYNi12M8roz5uOr8kbEz6O/eGmUIC
         j7mCi7dXXN/XVvlTk1MmLB/uhlSwo2SheRgBLcriTyJI5ykOynBRaMbLDh+EPfxt9zAu
         5+MQ==
X-Gm-Message-State: AOJu0YyiTugvEVm4XCXKRsTiJXbw9EmZ51kIbOZMmRKJkuzLqQzNg7wT
	irX/MNpEPU69bvPyBZXwtFk70ayGxjZ9pnEfMH0+k7lw0C335CPj/5ou7RiM4LmTN7R6NB/STRd
	oCA==
X-Google-Smtp-Source: AGHT+IEn/8F93q0gEr21PW94bWzVTKkwmkezMWmYKeDuPJa/ADXWCDOC22uKKgLsxTzcprae7vj45cH0Sdo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1543:b0:dcc:8927:7496 with SMTP id
 r3-20020a056902154300b00dcc89277496mr99387ybu.5.1713396967138; Wed, 17 Apr
 2024 16:36:07 -0700 (PDT)
Date: Wed, 17 Apr 2024 23:35:05 +0000
In-Reply-To: <20240417233517.3044316-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240417233517.3044316-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240417233517.3044316-4-edliaw@google.com>
Subject: [PATCH 5.15.y 3/5] bpf: Generally fix helper register offset check
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Daniel Borkmann <daniel@iogearbox.net>

Right now the assertion on check_ptr_off_reg() is only enforced for register
types PTR_TO_CTX (and open coded also for PTR_TO_BTF_ID), however, this is
insufficient since many other PTR_TO_* register types such as PTR_TO_FUNC do
not handle/expect register offsets when passed to helper functions.

Given this can slip-through easily when adding new types, make this an explicit
allow-list and reject all other current and future types by default if this is
encountered.

Also, extend check_ptr_off_reg() to handle PTR_TO_BTF_ID as well instead of
duplicating it. For PTR_TO_BTF_ID, reg->off is used for BTF to match expected
BTF ids if struct offset is used. This part still needs to be allowed, but the
dynamic off from the tnum must be rejected.

Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit 6788ab23508bddb0a9d88e104284922cb2c22b77)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 61b8a9c69b1c..14813fbebc9f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3792,14 +3792,15 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
-int check_ptr_off_reg(struct bpf_verifier_env *env,
-		      const struct bpf_reg_state *reg, int regno)
+static int __check_ptr_off_reg(struct bpf_verifier_env *env,
+			       const struct bpf_reg_state *reg, int regno,
+			       bool fixed_off_ok)
 {
 	/* Access to this pointer-typed register or passing it to a helper
 	 * is only allowed in its original, unmodified form.
 	 */
 
-	if (reg->off) {
+	if (!fixed_off_ok && reg->off) {
 		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
 			reg_type_str(env, reg->type), regno, reg->off);
 		return -EACCES;
@@ -3817,6 +3818,12 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
 	return 0;
 }
 
+int check_ptr_off_reg(struct bpf_verifier_env *env,
+		      const struct bpf_reg_state *reg, int regno)
+{
+	return __check_ptr_off_reg(env, reg, regno, false);
+}
+
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
@@ -5080,12 +5087,6 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 				kernel_type_name(btf_vmlinux, *arg_btf_id));
 			return -EACCES;
 		}
-
-		if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
-			verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
-				regno);
-			return -EACCES;
-		}
 	}
 
 	return 0;
@@ -5140,10 +5141,26 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	if (err)
 		return err;
 
-	if (type == PTR_TO_CTX) {
-		err = check_ptr_off_reg(env, reg, regno);
+	switch ((u32)type) {
+	case SCALAR_VALUE:
+	/* Pointer types where reg offset is explicitly allowed: */
+	case PTR_TO_PACKET:
+	case PTR_TO_PACKET_META:
+	case PTR_TO_MAP_KEY:
+	case PTR_TO_MAP_VALUE:
+	case PTR_TO_MEM:
+	case PTR_TO_MEM | MEM_RDONLY:
+	case PTR_TO_BUF:
+	case PTR_TO_BUF | MEM_RDONLY:
+	case PTR_TO_STACK:
+		break;
+	/* All the rest must be rejected: */
+	default:
+		err = __check_ptr_off_reg(env, reg, regno,
+					  type == PTR_TO_BTF_ID);
 		if (err < 0)
 			return err;
+		break;
 	}
 
 skip_type_check:
-- 
2.44.0.769.g3c40516874-goog


