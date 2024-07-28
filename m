Return-Path: <bpf+bounces-35823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A20D93E374
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 05:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53A828170B
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 03:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E85C4A15;
	Sun, 28 Jul 2024 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFn/xxOC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA81878
	for <bpf@vger.kernel.org>; Sun, 28 Jul 2024 03:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722135705; cv=none; b=m9NHlrAQGB3/mmw6gWplSevQtXxy61l8WdRyjBg+hMZWMqvY7McMfxCyJxgoiamYomT+VFjxTiRdlrMxU640xBOiqsxPDW57DcGcQB1wqXA9b8sSne4SdnXfjsoa5PcMrj/HoMe3tDYRUtkMrs8FZAY8JuSwOFSeVKt/+FAEDYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722135705; c=relaxed/simple;
	bh=FI+7PpmYERHcN7kZKiPxVQPdW9F9QF+EU5ns2A9gpaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HheWk2laVh+BnLWpXAHc87yjIdBktpFNgxVc537k2FXtxo4TEmMV6AXeKcZ86Lk2If/2VlRH2Q8ediVug+h4ccsVUUhyQDcCeBJfRaqX0fyONbhoGpqfjFZF0Zo2X2+GYPln1F0pgFxH8cLrqGRD3Ixe6n/HdxTgRZTMtoGndVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFn/xxOC; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b5dfcfb165so12009216d6.0
        for <bpf@vger.kernel.org>; Sat, 27 Jul 2024 20:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722135703; x=1722740503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clVPQtJRsi/+mven7CF4nTrZtDHLvSg6be5RIZKCKoY=;
        b=aFn/xxOCdhU7sB7VQxtDKPc6OgoPbOdb+R9BHvR4l7VkMDynTggnf4m4MK/FxTkuvv
         AtpWplDz35MCroq6fKMW7gK2qkZOZih/9IIW81LNpT+0wi6SnZ13djQQ2kDZ1VDfSrdR
         mA4UC380HqH4t7UtCqu1ym/nZupLbgtEwDnQdRsxS2spSXna4BJCYdXRBn/6sNCwBOlQ
         ya6Mhy77bTIkV5/YJ0B7Y5Jg+aLgG85T7nAOpPI84ONHCTqj9o+NJ194Umr6nuYbk+G9
         bjKP1vCKnEPtDaDoQ+093MUxVpBUgLVrKFjoCGCejNfQjtKUjbINeIl/7/H3StDqqAP6
         UW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722135703; x=1722740503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clVPQtJRsi/+mven7CF4nTrZtDHLvSg6be5RIZKCKoY=;
        b=T4nW95F94hfPiKygREekwMW+b3LN21eMJpUFks35/3bIzxu0uxCCibIoR6tuaXQHjo
         HJ80UPosjVsZ+URTUKhq8rvxNjpu1oJJQPKZzEvPJpB/S4I5onRzTn5ALuQshkMMw96D
         lP2g0Wi6KtyUpFJJ6Ow7c+UtW5D+vB5nBGOWoT+zBojiC+C4mhGpVxZNH6UYRN9Iq8Z0
         CmmKIAd6O0byjaLIUslehPbXvm5smtGdO0LvRiNClpPr/ZKi4Bd6dPUCwIGPrkm2ycwc
         BjKtM3VSh1A16IxONskZIV0ddoceQob6iYzDvlKzvcVXsTFqVNK0zRR4kMQfmq6a2yP6
         Jhww==
X-Gm-Message-State: AOJu0Yy6qLPX3w+eeldjyUGU6ljEuxAcVQsBzdQDN7WxzTu1X3dLJigf
	cLCtIwStSAeCm7+RQQBMKod2J2E887YBenXmonaC36DAanwEOiF2Dg5oRw==
X-Google-Smtp-Source: AGHT+IEKceGUpqGLO9XBTfVEayLnulCK/LDZNFDI64XqnIhfaEtbWLAEKWNj4a6VITbpLFkp56loIg==
X-Received: by 2002:ad4:4ea8:0:b0:6b7:ac31:ad19 with SMTP id 6a1803df08f44-6bb55a700dbmr44620366d6.24.1722135702679;
        Sat, 27 Jul 2024 20:01:42 -0700 (PDT)
Received: from n36-183-057.byted.org ([139.177.233.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f90e7b9sm37953306d6.52.2024.07.27.20.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 20:01:42 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v1 bpf-next 2/4] bpf: Rename ARG_PTR_TO_KPTR -> ARG_KPTR_XCHG_DEST
Date: Sun, 28 Jul 2024 03:01:13 +0000
Message-Id: <20240728030115.3970543-3-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240728030115.3970543-1-amery.hung@bytedance.com>
References: <20240728030115.3970543-1-amery.hung@bytedance.com>
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


