Return-Path: <bpf+bounces-16783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E91805EAD
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 20:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51B4281FE0
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E036AB8D;
	Tue,  5 Dec 2023 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dII4yxi2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16671135
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 11:33:38 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-423e7e0a619so83771cf.1
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 11:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701804817; x=1702409617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKN5S5p5BrRsBONU1msN/AsNOFlD/8MoNWa9P8Foodc=;
        b=dII4yxi2/7hpJUHW0FM/w3qHHHdUaxEZmuTNu3t6hzs53Vlra+AMqYepW3ngMdUnsn
         eKour/0X3/L5vvcQbddHIgJY0vY3KeZPZPMq0KAW5eTlB+kSl7f6F+C0u9OnmuRnYN7Z
         WTq8Cz48X5Gh8NHgp+Yit0qR3+N5jfm5siWxuqt0TdeopE7IXe1bxsNZNAKl0MB+pma+
         mj+/U09ms0x+Y3GaOxMBRojrenIIsxxVLuEgTjiY03mvWCJLFsUF6ywKwvuBHzMQ8KZU
         ytE/dx9lUuZFSeLGanVJgUiHRL1iR2wvsgf7UFfCg5vJa30lcDw0gsU0lmFuz5vWG808
         ZHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701804817; x=1702409617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKN5S5p5BrRsBONU1msN/AsNOFlD/8MoNWa9P8Foodc=;
        b=sJJ3C4zO5TBbazchqzH0xJNaHfPX3hYcDTxoDWdX74BzxVCJsuWLKGU4jjj3hW8wgC
         3vfHFUqAfjsYR1L+XHspXvJBWmixGITuFadYlX15gwe+jhF1+C1ExZHYyovR7aEaToAL
         CeJpVF3tenAhDdwCQ11z+dibaSptmxgEmFCantwLWzb+EitAeZtbqL4PVnRf4wvH13Rw
         OeNuy5CUo6gbrIv9smCBm+EQJ+nRuqCXAMkwFtFAnmec/7X5qqTRsZ6DB1c2E09XwyCU
         kSbXpTG2J6fWmfA6HbNouT+iMALivEqPLheTYjZ4nineiENEnGOPZfAeucNNTUCeBlUk
         Q0ww==
X-Gm-Message-State: AOJu0Yy1lM5gJKK5oun+tZm74RPVpe0rOpN3jLcfWyyZ2KM8MEQwUDk4
	l5ZtuquyE0mnj+9okgfdV7NdAV10cuA=
X-Google-Smtp-Source: AGHT+IGk0aL/2xKIjk4zJV2g19poWKkeCNycP1D5gAIIDfAhpvEw3uq2dIqzg0oyR5ui5/9lWkjhsw==
X-Received: by 2002:a05:622a:181c:b0:418:11c9:ddb5 with SMTP id t28-20020a05622a181c00b0041811c9ddb5mr2419802qtc.25.1701804816783;
        Tue, 05 Dec 2023 11:33:36 -0800 (PST)
Received: from andrei-desktop.taildd130.ts.net ([71.125.252.241])
        by smtp.gmail.com with ESMTPSA id kg18-20020a05622a761200b00421c272bcbasm5334588qtb.11.2023.12.05.11.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 11:33:36 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	sunhao.th@gmail.com
Cc: Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf v3 2/2] bpf: guard stack limits against 32bit overflow
Date: Tue,  5 Dec 2023 14:32:50 -0500
Message-Id: <20231205193250.260862-3-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205193250.260862-1-andreimatei1@gmail.com>
References: <20231205193250.260862-1-andreimatei1@gmail.com>
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
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 29d39ebac196..ebebbb8feb17 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6761,7 +6761,7 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
  * The minimum valid offset is -MAX_BPF_STACK for writes, and
  * -state->allocated_stack for reads.
  */
-static int check_stack_slot_within_bounds(int off,
+static int check_stack_slot_within_bounds(s64 off,
 					  struct bpf_func_state *state,
 					  enum bpf_access_type t)
 {
@@ -6790,7 +6790,7 @@ static int check_stack_access_within_bounds(
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = regs + regno;
 	struct bpf_func_state *state = func(env, reg);
-	int min_off, max_off;
+	s64 min_off, max_off;
 	int err;
 	char *err_extra;
 
@@ -6803,7 +6803,7 @@ static int check_stack_access_within_bounds(
 		err_extra = " write to";
 
 	if (tnum_is_const(reg->var_off)) {
-		min_off = reg->var_off.value + off;
+		min_off = (s64)reg->var_off.value + off;
 		max_off = min_off + access_size;
 	} else {
 		if (reg->smax_value >= BPF_MAX_VAR_OFF ||
-- 
2.39.2


