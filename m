Return-Path: <bpf+bounces-36741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4941494C7CB
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 02:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012DA2817D7
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 00:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EBA8F58;
	Fri,  9 Aug 2024 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONOU0Jdc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6941FDA
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164709; cv=none; b=OlW6oApSnzbP3/61wtZKkW3CL/FxWj/wrQmRHmSe8rc9QsQUleUMS6y0sTFzeXYEe+lf+UsonrYjvd5cNj1gFqNaDHUagXlNXhxGwXjMxOg10fDWYh8j5TckKtkwFgxf6pogwr+V+toziPCZjilKZ2l9oqQ4G74lPQ80lTR3bng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164709; c=relaxed/simple;
	bh=CBTN153jJzwjME+dO9P/o9STqxs6koh4Yk5fYysLgEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qeea4Q4P688acbf+gXrSATPJSIAlWUKaujVjWPYbvj0lXLgIPRHWjsU70OsXt0+IQSh0+jGEmsVlYZUc1YEcVReZMZ5YH+t37HlIjEJJbFwgoSZUYrEAIT77tf8LX5nRc0VhX/dKczxadeG4kAqaKeyGP6K44s36N8s6JqTGfNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONOU0Jdc; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b795574f9dso8728776d6.0
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 17:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723164706; x=1723769506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6p8c1OUEhv+/PTai01JOAF17KOu2jscbjKAA2ruSl0=;
        b=ONOU0JdccLgBi/ml9hbHe4od557pZPZC4622zy6AE+fXwaEECcshPPjA3qzD+erjwG
         TeYSHGrXpMv6v1AVXqEBrJmTUVuY5p6g8e9lTYrBjLmLUOnUQjLrIUcn5mRwFvFFJC6K
         rBS7al8CPI8X7mm1BMab0vVtW54dozqTywvZ3sDzWSibdRnBKRvqCx1AOfBl6JUQozVV
         pMq7BzCuvLG3twEGdWYfDnHWsqlshXyKF51dU2FgIqC4fseGt5QuDsxfpjIwcjcFA5/H
         z6u1te100E3u8CEGnYN8UbJe1FGdmIrMEqlaPhiZnjSSZRSGP4612RGMv8+fuSSsc5eM
         rddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723164706; x=1723769506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6p8c1OUEhv+/PTai01JOAF17KOu2jscbjKAA2ruSl0=;
        b=daHLJj7x1RmJpNe8GLkYmIBbQcOx/IHCPMs3TTkcY/KMHnoYDi6slnoYIZG6HnK8uC
         K//eVoSQCUWHDmZvBbJy9g1KCUIihJ0Z6+0euTCV/V1Rz8YuPBvPC18iOf5hjELWf7Ar
         VACNonwkK3FXNswdNq57fhQ9sHLcW4uzgYlgG7MlBseVSMuEoISphf8jzNyx1871FUts
         qHtePO272f+SyZdMyq/rQfC5xb02F4AEyujuBtox2TDq5jmesYVKz+YMKHyd7uoK/AVd
         N2uebG5v3+whbHISevhu34vGF8CV+fCohAJ2DN5yqBHr6d6/6kSADQ1f3cmF8nDWnJrJ
         HzVg==
X-Gm-Message-State: AOJu0YwvbE1Pk3trK5WMiEa3xm8E2Be2s5jVEqUtoOXP+tDhhkN9tLCH
	Dsx+8k+dYmXoQVRH1++5u8mXtZoZGT/3MOe5V2ivukKFVIzAatOQ+7gzrw==
X-Google-Smtp-Source: AGHT+IEvWUGxiRWD+69fcSCQeJQMEbpj5Ln2HcF9UDldAdYi8DH7e51mJJPU+PhZ/70woiVKFfdvkA==
X-Received: by 2002:a05:6214:3385:b0:6b7:431c:1b19 with SMTP id 6a1803df08f44-6bd78da62efmr12246d6.6.1723164706321;
        Thu, 08 Aug 2024 17:51:46 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c797dbdsm71485826d6.52.2024.08.08.17.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 17:51:46 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	houtao@huaweicloud.com,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v3 bpf-next 3/5] bpf: Rename ARG_PTR_TO_KPTR -> ARG_KPTR_XCHG_DEST
Date: Fri,  9 Aug 2024 00:51:29 +0000
Message-Id: <20240809005131.3916464-4-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240809005131.3916464-1-amery.hung@bytedance.com>
References: <20240809005131.3916464-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Marchevsky <davemarchevsky@fb.com>

ARG_PTR_TO_KPTR is currently only used by the bpf_kptr_xchg helper.
Although it limits reg types for that helper's first arg to
PTR_TO_MAP_VALUE, any arbitrary mapval won't do: further custom
verification logic ensures that the mapval reg being xchgd-into is
pointing to a kptr field. If this is not the case, it's not safe to xchg
into that reg's pointee.

Let's rename the bpf_arg_type to more accurately describe the fairly
specific expectations that this arg type encodes.

This is a nonfunctional change.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/bpf.h   | 2 +-
 kernel/bpf/helpers.c  | 2 +-
 kernel/bpf/verifier.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7ad37cbdc815..f853e350c057 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -744,7 +744,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_STACK,	/* pointer to stack */
 	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
-	ARG_PTR_TO_KPTR,	/* pointer to referenced kptr */
+	ARG_KPTR_XCHG_DEST,	/* pointer to destination that kptrs are bpf_kptr_xchg'd into */
 	ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_flag for dynptr type */
 	__BPF_ARG_TYPE_MAX,
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..8ecd8dc95f16 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1636,7 +1636,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
 	.gpl_only     = false,
 	.ret_type     = RET_PTR_TO_BTF_ID_OR_NULL,
 	.ret_btf_id   = BPF_PTR_POISON,
-	.arg1_type    = ARG_PTR_TO_KPTR,
+	.arg1_type    = ARG_KPTR_XCHG_DEST,
 	.arg2_type    = ARG_PTR_TO_BTF_ID_OR_NULL | OBJ_RELEASE,
 	.arg2_btf_id  = BPF_PTR_POISON,
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1f5302fb0957..9f2964b13b46 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8399,7 +8399,7 @@ static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
 static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
-static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
+static const struct bpf_reg_types kptr_xchg_dest_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types dynptr_types = {
 	.types = {
 		PTR_TO_STACK,
@@ -8431,7 +8431,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
 	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
 	[ARG_PTR_TO_TIMER]		= &timer_types,
-	[ARG_PTR_TO_KPTR]		= &kptr_types,
+	[ARG_KPTR_XCHG_DEST]		= &kptr_xchg_dest_types,
 	[ARG_PTR_TO_DYNPTR]		= &dynptr_types,
 };
 
@@ -9031,7 +9031,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return err;
 		break;
 	}
-	case ARG_PTR_TO_KPTR:
+	case ARG_KPTR_XCHG_DEST:
 		err = process_kptr_func(env, regno, meta);
 		if (err)
 			return err;
-- 
2.20.1


