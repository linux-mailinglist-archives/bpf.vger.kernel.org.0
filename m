Return-Path: <bpf+bounces-16987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C520807F73
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 05:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4BBB20DA6
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 04:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E476F8498;
	Thu,  7 Dec 2023 04:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu70WAmz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72271D5C
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 20:12:18 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77ecedad216so13038885a.3
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 20:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701922337; x=1702527137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJNOZXW/19vdyac9iHcxbBhS2H5cmLHne945AbcBJZg=;
        b=Eu70WAmzwT2TMGY0rU/OkBChP3/qM5dfFatpieBMjRl63i6si7pnqjc50YxzZdm/LB
         GgAdvy83GJRUkaNtUfejXMDnbVxGeh9aPd0JkTW+MXZ2HxNkt52XW7KdnecO4Ly0tKZd
         V+Y9aCCcDPIpwFgiMeZSM43mcWj0XHWi7EhECBKZ3el9RoCxQeZ0ebTINSnrvBJNo39D
         8rzuf1jyy5HSWcEEMyw2MSOf+txKRge4+dwYIfeNQ9IKm+3yVUnB5/alx2b/5m4J2W7l
         un6Y+eoo2zwGw6M0JCBwjvcmSnw4UFNBwB64fZ02HlfShoQM8IOHlt9ScQaXFl8QkR2t
         eyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701922337; x=1702527137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJNOZXW/19vdyac9iHcxbBhS2H5cmLHne945AbcBJZg=;
        b=QnbeVXf28bsVoGhSQjjoRjBdsNWMSf03IzLmmAhOlemdeidHb+rXoPco5gsiTB11uP
         oz9GdvltI3D/efATabp2F2XTUZ2eE8c/Z2DSx/iLM/eca49DQVsPLD0vE+JAZIxRrOxB
         uc3VKKfO1pPiS6bk0/C6YHuFvYHhPY8d0JFcYTg/xp0FJMvBdm+iG3ZDClo5UGyu4oLK
         5zQVUoGSqqj1kl6EjkIKPh6TpM9v/k7vRMwzVAVcme7xDy3xMxswYtKqjsYLFr9JM5gM
         sKI86/3rK24sY+EmY5ToaqGrLa1r13MCxfv7WLB6MAjOd/vmQlQb3g7jFTxJQKFSEyZV
         joLA==
X-Gm-Message-State: AOJu0Yxo4pbP20KmfEPhqCr7qfVaEVIT0GzJETXXCU4FYzhaFi+BbZ5k
	WRQTipCUzZdKTNkA24J//UCrtqPX1KQHzw==
X-Google-Smtp-Source: AGHT+IHisPmqs1x1oPJg1GBYRGZ69mGfuA81o+/VccNwrbkIY+LmTPOEWZbxSikb/voJl2tG+KAX1Q==
X-Received: by 2002:a05:6214:805:b0:67a:b459:b594 with SMTP id df5-20020a056214080500b0067ab459b594mr1983322qvb.119.1701922336610;
        Wed, 06 Dec 2023 20:12:16 -0800 (PST)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:225d:9ebb:8c9b:7326])
        by smtp.gmail.com with ESMTPSA id o6-20020a056214108600b0066cf4fa7b47sm172808qvr.4.2023.12.06.20.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 20:12:16 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: sunhao.th@gmail.com,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v5 3/3] bpf: guard stack limits against 32bit overflow
Date: Wed,  6 Dec 2023 23:11:50 -0500
Message-Id: <20231207041150.229139-4-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207041150.229139-1-andreimatei1@gmail.com>
References: <20231207041150.229139-1-andreimatei1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch promotes the arithmetic around checking stack bounds to be
done in the 64-bit domain, instead of the current 32bit. The arithmetic
implies adding together a 64-bit register with a int offset. The
register was checked to be below 1<<29 when it was variable, but not
when it was fixed. The offset either comes from an instruction (in which
case it is 16 bit), from another register (in which case the caller
checked it to be below 1<<29 [1]), or from the size of an argument to a
kfunc (in which case it can be a u32 [2]). Between the register being
inconsistently checked to be below 1<<29, and the offset being up to an
u32, it appears that we were open to overflowing the `int`s which were
currently used for arithmetic.

[1] https://github.com/torvalds/linux/blob/815fb87b753055df2d9e50f6cd80eb10235fe3e9/kernel/bpf/verifier.c#L7494-L7498
[2] https://github.com/torvalds/linux/blob/815fb87b753055df2d9e50f6cd80eb10235fe3e9/kernel/bpf/verifier.c#L11904

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 137240681fa9..6832ed743765 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6577,7 +6577,7 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
  * The minimum valid offset is -MAX_BPF_STACK for writes, and
  * -state->allocated_stack for reads.
  */
-static int check_stack_slot_within_bounds(int off,
+static int check_stack_slot_within_bounds(s64 off,
 					  struct bpf_func_state *state,
 					  enum bpf_access_type t)
 {
@@ -6606,7 +6606,7 @@ static int check_stack_access_within_bounds(
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = regs + regno;
 	struct bpf_func_state *state = func(env, reg);
-	int min_off, max_off;
+	s64 min_off, max_off;
 	int err;
 	char *err_extra;
 
@@ -6619,7 +6619,7 @@ static int check_stack_access_within_bounds(
 		err_extra = " write to";
 
 	if (tnum_is_const(reg->var_off)) {
-		min_off = reg->var_off.value + off;
+		min_off = (s64)reg->var_off.value + off;
 		max_off = min_off + access_size;
 	} else {
 		if (reg->smax_value >= BPF_MAX_VAR_OFF ||
-- 
2.40.1


