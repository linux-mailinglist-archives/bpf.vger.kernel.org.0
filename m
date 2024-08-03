Return-Path: <bpf+bounces-36331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78133946666
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 02:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E872822B8
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 00:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4011C3E;
	Sat,  3 Aug 2024 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mboBGY0x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A885193
	for <bpf@vger.kernel.org>; Sat,  3 Aug 2024 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722643918; cv=none; b=byvCK8DuRU8TKvHZ2us1A6JRxzZ1//IAZbINp0bY7H4QXxZztVseO1NX2YkPANNiJbrVotw8CbgJE9hqH7xcu2/IbE+xyl0mNw3K8TU40q38gmoKSOu4xtZyY8NEVTj+8vUbd7hgGvVJcz2M6ixpBj4qhRt9Ynpojh+QukxaOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722643918; c=relaxed/simple;
	bh=CBTN153jJzwjME+dO9P/o9STqxs6koh4Yk5fYysLgEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSlwXWlXGe3bjdIw/8L9ipoXam4/WebkN6wXmhH7oaB9EvzVPAZU2uA7ilPcXwRqfG9piUqYrXsu4I7ca8p8Q5sIzp3PK1I5v1QTU4KD45MMLDR8rXsBEbiuppenbQxsCwPdm5uSvZmtBySfnj3GV9U/Mx6Y802+jUgyHdao9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mboBGY0x; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-49299323d71so2627563137.1
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 17:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722643915; x=1723248715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6p8c1OUEhv+/PTai01JOAF17KOu2jscbjKAA2ruSl0=;
        b=mboBGY0xKZvtNydyrvLBLV/HQwx5FJzy2Qaxoq8CQ8SpXr+AatGyFiluWntrI0+g9o
         HE3oO5kE5MybAkEru5EHClTts4hzP+HJilSCo7mj9ocYuYGWzqI4j5IVHQjlb4x8HIfU
         2EclLdfvq4rcF5cg9LQcLYJsv5ZFpoahWZ/7mC1bHJaXJuaUZrLiRKY35oLb1S9VWGYg
         5ujdZfAaqJPS8M4AudyKtnESQXWeHS6dRdK1knM7E1JybKr4Xhqknh49Vaw0dcW/6jIi
         APZOlpkxRWOzOfZA7dae55HrPBYrvxuIBzAisCywKIRj3FgjwrhWlzRYMLzZKnkqVh27
         WkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722643915; x=1723248715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6p8c1OUEhv+/PTai01JOAF17KOu2jscbjKAA2ruSl0=;
        b=HKdul62VFHlmf9a1gD1W84McGF+KQ69354M61ZOE0AuBh2PUjrHCtrDEv1vsivSH/h
         L/Tn8eyp3W44N5c3/EPbhG6I2EBfcmGgtc6zqlnRvrxkF/JvlBshJGvFewrLzrx8yV/I
         A9sEnPEcnitBWUVxzVuP3FBRkTEGDRbF38Nrk04h6INQ3sTPYtgOmewUsl6qGgG+AMs1
         loB+PfWRYvthr8RkaiVWdLLSptt+7e9HUtXZZhDfTIl5iUgS+/2RgTNkTnK/cOD3DPHw
         WoxBYsHIWe2a7X1J4Rq0xzc+GCmfZNRnBSYRKzuIrR8br/geGuUNcOtGvkHGheAYZdz9
         0PdA==
X-Gm-Message-State: AOJu0YyKBrVWbc4qRmJvpBPN5oilOzHp3peRvf5v+G/6nTsPTGURtnos
	Id5GyBIY8OqnCwid6g4l+n4NZ3tN1nabovXr29t2+t2IvXw7Aj7KFBYcOQ==
X-Google-Smtp-Source: AGHT+IGUqPdmbRM+YAk4qIrt5hEixupP7f3Yw9y3xvKEzl5nQ57oTjT3VEGo1sEE77TFD0xFXYDgpg==
X-Received: by 2002:a05:6102:4194:b0:492:9c55:aec5 with SMTP id ada2fe7eead31-4945be2278cmr6966153137.15.1722643915239;
        Fri, 02 Aug 2024 17:11:55 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dce75sm129547485a.14.2024.08.02.17.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 17:11:54 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 2/4] bpf: Rename ARG_PTR_TO_KPTR -> ARG_KPTR_XCHG_DEST
Date: Sat,  3 Aug 2024 00:11:43 +0000
Message-Id: <20240803001145.635887-3-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240803001145.635887-1-amery.hung@bytedance.com>
References: <20240803001145.635887-1-amery.hung@bytedance.com>
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


