Return-Path: <bpf+bounces-62453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32252AF9CA7
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 01:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E8058711A
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F280328E611;
	Fri,  4 Jul 2025 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlnJTTEo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBEE28DEE9
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751670250; cv=none; b=YBnKrKuwlB1XcJJ2CBcALHYEtE+gjOV2apj0au+seLV3FZMibVa6+NagyrT+zdzSJpVaxFieXiXOhWuEZq+r1WIEvj6HzW5DZYv2RH7pcQKJKK+IpmZ8mEGMw/ckmuFeH39zdPuCH0Hjxgxu/g0Z6H2KnP7ZM8MG/7XIdGlJTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751670250; c=relaxed/simple;
	bh=t3HSqqFmD+MBLK2b+2JqmKmmC07Kk5Z5iPxS0ra76M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S14A6NHI7QXeWAUDRtA70uVoPTdM7kx7cSMI/tSzFxgzrXsRgNqL0Ouek+/p4Dw4OMgZjFu8qiLOSepLa7Lj1bSipTu1aySQHB9a/cGfsLHhj27yVY9VcwP9+Rja68FAaHDqQuMq2Jx5KAbPDzsRRSNZ54CAqFn/R5umv3EGhRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlnJTTEo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso1159487b3a.2
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 16:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751670248; x=1752275048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqzF56c9DqmzdfDObp0vELhH+hY7w7CJh6ZxJg+Zwgo=;
        b=YlnJTTEoAhV9ghimnEiGWpZ0BeHo30/AasCrWGur9+ls9sAkh9YjvXQPL2YMS/ehYT
         vPyWXALhsldyLzIGO7z+ijnmiK850zp4qw/oCI3bwFmFSM7gwcwXPWhf1g1fHDEvD0hx
         hmG+8+hUwEdreyxJi+RPmuK7Ip1ErfT4FNlkNVB/wVbVBMzO8dVkqlPfPSPNrpraYZfa
         LQ0ttxE39Mw/qZuJw1znH30w9yDn5nQkhv4dmBisTYjPm/aXwU+kpQfFcwUbxbat9w3v
         qygvUdaKKcznx5oJMNqpNUVBdbTyfH0cZWifVW8S85eCZlEU2fb55RmxK4WTHPOH3P0G
         Vmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751670248; x=1752275048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqzF56c9DqmzdfDObp0vELhH+hY7w7CJh6ZxJg+Zwgo=;
        b=d5DlFzdF5qkBT3o5NzwE9RhxbA2yF03uLZTqgufzEXHnlmv/G8czYdBMw26aGviF7h
         BrtdX83s/NWVripPrqS8bHvXU/xUr5ki9OSCbGmsqttkN6fTxODQWBDJTDgwiWVmqznT
         1irZcfEmdnOFhEOYmhGWS8UwjSfzEDscUePnAL1bH21O4dbqxtSbU14mapdIw7etrQSN
         E6fVfquH/KXddK9TwNPyPe35vQQIXYto5S6wkRHVkBc9kWUoDoMDwKWRjZ04N215T7Se
         gt85uRvwAPtTvrV41zYW2Oy7ujufxuRowKdW76bxCuixG/8euY8yFx+LwcVbX4U2CvTl
         rzrA==
X-Gm-Message-State: AOJu0YyRQBj6DsAP33OhJIi80sTHD50tLYegaZCP9ldrRzNZ91m9WS5M
	lh91/FO9Wm+fVmd9QhpGXp8QA+iUiFmgb46GXLwI6d/7y0XFRhtClvIch5P6dQ==
X-Gm-Gg: ASbGncvPko2pjibmR0ehwuqDdRqGkiD3TkvQSvV8T7MjqvKoachw0A1Udw0K4NsjTAM
	6NZh1DbMy/A4YVpW1MzJPA/Wb6WIn4AjvO8/FnT5HNNG5oZpVk8s36eZitPnSNCGMMpc+CmJ9mc
	ULE8xUy1DsRDtGFrsJN7yUSh7EEQA2+LsEJdoE5f23g1WUgeVBEdUFVAxY1ik1nlfGEOBdsJa/G
	vnm2Yv1Pu4ayoV13DmnaDnVtJeIJSgIMBjqzVahgtgXDo+4g4g1nzSNyd8MWckHZftZvBaMa36R
	Bbw7jfbAFwlFaSIIC9eYAyNd/2Q9Y3mh7X4w6cdhWz1ccxWfHOWsZL61Xt3JP63kXuN6
X-Google-Smtp-Source: AGHT+IGuaYjghdtaNbvKZTlkycWc1wjKHcvTf/vyj06PV2tmlYlj4wSa5DtWU5McMCaWHIuXeJn7dw==
X-Received: by 2002:a05:6a20:7284:b0:220:90a9:a91b with SMTP id adf61e73a8af0-22608fbba1dmr5371298637.9.1751670248111;
        Fri, 04 Jul 2025 16:04:08 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38f879d040sm1764447a12.44.2025.07.04.16.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 16:04:07 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 4/8] bpf: attribute __arg_untrusted for global function parameters
Date: Fri,  4 Jul 2025 16:03:50 -0700
Message-ID: <20250704230354.1323244-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704230354.1323244-1-eddyz87@gmail.com>
References: <20250704230354.1323244-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for PTR_TO_BTF_ID | PTR_UNTRUSTED global function
parameters. Anything is allowed to pass to such parameters, as these
are read-only and probe read instructions would protect against
invalid memory access.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/btf.c      | 38 +++++++++++++++++++++++++++++++++-----
 kernel/bpf/verifier.c |  6 ++++++
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b3c8a95d38fb..e0414d9f5e29 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7646,11 +7646,12 @@ static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg_idx,
 }
 
 enum btf_arg_tag {
-	ARG_TAG_CTX	 = BIT_ULL(0),
-	ARG_TAG_NONNULL  = BIT_ULL(1),
-	ARG_TAG_TRUSTED  = BIT_ULL(2),
-	ARG_TAG_NULLABLE = BIT_ULL(3),
-	ARG_TAG_ARENA	 = BIT_ULL(4),
+	ARG_TAG_CTX	  = BIT_ULL(0),
+	ARG_TAG_NONNULL   = BIT_ULL(1),
+	ARG_TAG_TRUSTED   = BIT_ULL(2),
+	ARG_TAG_UNTRUSTED = BIT_ULL(3),
+	ARG_TAG_NULLABLE  = BIT_ULL(4),
+	ARG_TAG_ARENA	  = BIT_ULL(5),
 };
 
 /* Process BTF of a function to produce high-level expectation of function
@@ -7758,6 +7759,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 				tags |= ARG_TAG_CTX;
 			} else if (strcmp(tag, "trusted") == 0) {
 				tags |= ARG_TAG_TRUSTED;
+			} else if (strcmp(tag, "untrusted") == 0) {
+				tags |= ARG_TAG_UNTRUSTED;
 			} else if (strcmp(tag, "nonnull") == 0) {
 				tags |= ARG_TAG_NONNULL;
 			} else if (strcmp(tag, "nullable") == 0) {
@@ -7818,6 +7821,31 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			sub->args[i].btf_id = kern_type_id;
 			continue;
 		}
+		if (tags & ARG_TAG_UNTRUSTED) {
+			struct btf *vmlinux_btf;
+			int kern_type_id;
+
+			if (tags & ~ARG_TAG_UNTRUSTED) {
+				bpf_log(log, "arg#%d untrusted cannot be combined with any other tags\n", i);
+				return -EINVAL;
+			}
+
+			kern_type_id = btf_get_ptr_to_btf_id(log, i, btf, t);
+			if (kern_type_id < 0)
+				return kern_type_id;
+
+			vmlinux_btf = bpf_get_btf_vmlinux();
+			ref_t = btf_type_by_id(vmlinux_btf, kern_type_id);
+			if (!btf_type_is_struct(ref_t)) {
+				tname = __btf_name_by_offset(vmlinux_btf, t->name_off);
+				bpf_log(log, "arg#%d has type %s '%s', but only struct types are allowed\n",
+					i, btf_type_str(ref_t), tname);
+				return -EINVAL;
+			}
+			sub->args[i].arg_type = ARG_PTR_TO_BTF_ID | PTR_UNTRUSTED;
+			sub->args[i].btf_id = kern_type_id;
+			continue;
+		}
 		if (tags & ARG_TAG_ARENA) {
 			if (tags & ~ARG_TAG_ARENA) {
 				bpf_log(log, "arg#%d arena cannot be combined with any other tags\n", i);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 87ab00b40d9f..7af902c3ecc3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10437,6 +10437,12 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				bpf_log(log, "R%d is not a scalar\n", regno);
 				return -EINVAL;
 			}
+		} else if (arg->arg_type & PTR_UNTRUSTED) {
+			/*
+			 * Anything is allowed for untrusted arguments, as these are
+			 * read-only and probe read instructions would protect against
+			 * invalid memory access.
+			 */
 		} else if (arg->arg_type == ARG_PTR_TO_CTX) {
 			ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
 			if (ret < 0)
-- 
2.49.0


