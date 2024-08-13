Return-Path: <bpf+bounces-37108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10191950F1F
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 23:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F5B1F231B6
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 21:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424DA1AAE11;
	Tue, 13 Aug 2024 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X06mwvHs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0281A76CD
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723584275; cv=none; b=Mwn4/U89/2eMCUs5fSijZYNXIo9Az7fumDebFsaQ+K6JlLfsr0cb+KRJEX2MqGh2qUQdwop5Hnb7eemM/E+GvHbBypGf9vF3Vq9pixFIpbF25oEllTOyhLPaKfJ+MTbj9Clo8k3YYp1n3RiiwJ74083MJxPskaV+CkQrnJnguSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723584275; c=relaxed/simple;
	bh=CBTN153jJzwjME+dO9P/o9STqxs6koh4Yk5fYysLgEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R3Xoaj8kIeiNCUaK04M5pY6m8yWSLRjW/+vDuk1pysNmHXpeHv8JIt3m/efvsgGQESLbS0N7RBP/r1XpEg4Xwlyryc9looKYkPZNwbDcoAMCGUK0uh+I7Hyaj2nwSWMHehALkGn446C/cRI0QcVAdUMTFy6T3bP721MT/asw4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X06mwvHs; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0bfa541c05so5234040276.0
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 14:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723584273; x=1724189073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6p8c1OUEhv+/PTai01JOAF17KOu2jscbjKAA2ruSl0=;
        b=X06mwvHs7t7ucHp7jVdyRvWt1GsI7n6tf8DqCXRQpGG4in5VufC4lhBx5TTK5QlKIh
         jNIweqZfBdmxvANo15FlqMruRCPkfoyB0ADOA1Sx5WgUqqpu757ywCML8GOJBJromT5i
         mV4x90qWuTIhoBjNQnDoJeGaLQEb1HW1/EhWb3MvC/qWIM6nj86FWvXbkGoBK49SNSwS
         7K+WMe06bgFTZV9kVGsaHAJPRmCsonm9Ccw4/2gQo2G92I28zogGsaRHrgVnCnvyNuFh
         BHQrE2MhFR+wqFA1lVTjo4VxnVwLnxWEHjuOf+5RJifwjU0DlhXZq71JN7goRMcRkKMK
         k0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723584273; x=1724189073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6p8c1OUEhv+/PTai01JOAF17KOu2jscbjKAA2ruSl0=;
        b=dpbotxVXBzDMSLjGE2/7Q6+qBqX6Vsb+YZ52Oxd2lWSDeYcRCy+nlIE8gHN4Oz5eG+
         TXN+DpHuQZGt76sBk+OeYY2WZ8sjwTqSmGEi/PhhPjyK/AuCWApjpswVzmUcmX2I3Yq+
         HiAjNolAfItlZvpCoaGZkCbnntcDwKwWCboJjY/EG7+oZBxQrdHb7LPwbZ+RHSLKqNSm
         pGLn3czv2xPmkap0n+Dn+cTQM9OcOJGUtU4qgqblrdP6HRfRsAlFCniLi7YTxycRALyV
         8FRpNusdsx5p5IWo9COqPMf5Qlm/N+laaPCfOGhDibakfDD/QrzXx9dMQl3jjgdtcjrM
         pmfw==
X-Gm-Message-State: AOJu0YwifX3xEuFemAp1Xh9AdxUGo3DDkszJK3UvaqkW7C1IQYbRmKan
	A3rbLF2OQvYZuf4IGZpboqCWA1KIvxT+G+fxEdqqr4EYsoyCtkMDFMZjGZHdVkauHn5K0dbKAsI
	4X6c=
X-Google-Smtp-Source: AGHT+IFpN/c0k0Ealux7lB+a8xpJ82Of6TwMQndmbFPYTJPbxW2IP0KZEJ9qUkXje59QO3zZnbQphQ==
X-Received: by 2002:a05:6902:2102:b0:e0e:3d6a:8713 with SMTP id 3f1490d57ef6-e1155bc7f51mr792086276.56.1723584272930;
        Tue, 13 Aug 2024 14:24:32 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.116])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf432fb61dsm21390786d6.52.2024.08.13.14.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 14:24:32 -0700 (PDT)
From: Amery Hung <amery.hung@bytedance.com>
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
Subject: [PATCH v4 bpf-next 3/5] bpf: Rename ARG_PTR_TO_KPTR -> ARG_KPTR_XCHG_DEST
Date: Tue, 13 Aug 2024 21:24:22 +0000
Message-Id: <20240813212424.2871455-4-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240813212424.2871455-1-amery.hung@bytedance.com>
References: <20240813212424.2871455-1-amery.hung@bytedance.com>
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


