Return-Path: <bpf+bounces-60374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB92AD5FD5
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9ED3A8F55
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 20:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A872BDC3E;
	Wed, 11 Jun 2025 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsYrH9yq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45B2BDC28
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672531; cv=none; b=fReI4P1bPwvbIXXDfHneaaIFN96WH6BHo10dWJx+Q9Ebh2r2qGn7yUoPoDt2pLv6rYlH/US+u2WkPMBlehbYhnvILVjXzUDUR9VSrPYkwmB3zzUeZHFtNOdLiCapp1TPFDG8N/cT2yFdfjufWWRQEHnOqdKHScR1foiwTdVVSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672531; c=relaxed/simple;
	bh=WfX5lns/8NUvYGuoyTYQP6zfPVvS5WWcVyZsq2jgjd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OI1G93AM9aNEciIatGshwDhiX8SsX+Ieht1sC3WSkX0GjVFqTT0vXml5a4GUlVJeTepoo8dj5YzJ+4tHYkvyJzUo0p871WwpgFKu1Qyh8lDe4sMPx6cV0RPMscRKOR8qNXmQWSnzdgDi+XOOXpGLDqJjBNg7u8KC4Y+HANaRcRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsYrH9yq; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e102eada9so1755457b3.2
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672528; x=1750277328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOxUAq6sNldoM2hasjptzlG08e2zZ0FCxmhQ2RgaZSU=;
        b=HsYrH9yq1Gd24K1QurRoJMl5qcYiUCPFVeoa8BGBUw1JcyYBvfL5IuogXReMnwSiWe
         Hzn0QgXyekPXIUz/OCuqY2DWZ/JnBn3qQuF/oVcCAJ6z/WjZcnXXGuoVQHnPXDbIundW
         /wLCeuiVH3a2CrVNZtbrj566OspfOel1M1li5lLgORLUtdjMuI2v9qR2xS0mT2olYoal
         RTaWxTnhsxJ83kzv02T6xFycIIGDI0mz5RbwdgrLavEA9ktzHLr4fH0OE8QaAln+hw16
         liHj17iYcPTawei+Uub5onuYjHBKRzmDfvledMj7CShcEBzAZzlhA5sixf11Lmt6KXbn
         R4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672528; x=1750277328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOxUAq6sNldoM2hasjptzlG08e2zZ0FCxmhQ2RgaZSU=;
        b=E4zDITofwQyCA09JM1drGhP+B7lnpn9RkkdB6xbDuufBCcUYSP5Ik5TwctyOtXtV16
         o/n6PogndOPE7AGZtLgmEjKgwTMQQ0//4IKXBFs0ShaZMKbo0qero/qESUJIT0oEd9vZ
         c/ODymfMHraRiR1YgQaLI1u3NJJv9nM3Qd1QdCzKCBK7ffHUu9e450reXFAWKX0Cbq3n
         dv8hRzC4Eg+cigHP7XBQpRFKrWA0CVYM1hk284lSGI5/nzIYc4soIb+C2fWyg9cZoQKo
         tCum0w2fIKOM2wsdMs0WeQDZeMaAxgdx/+ZTrEQF/gmjvCzJPGbV199laE1G+mlh+jXw
         KZ0w==
X-Gm-Message-State: AOJu0Yzs1fyhqr6UpZ8VNfhN/sgVDsB0Ajb0Eb3uJawECCLcAijUiMcv
	/XXAyKjDxaLA90gudh+C8lrNVNsa0Bnhvds6GgzUp0Z152m4lP/fXSrmXC1XVQoC
X-Gm-Gg: ASbGncvO1WxM6QK1z41RymSXOmMMLBWmLWeuCWGwbn9iNO68KBaYg3cNQ+9aiGwwhkx
	/76QD8WXoyWnF3mdxb44FyLZHrDwkrzYKgypDr4ji+IR1bk7vowceQAO40lgsnHjx4V2vAVdFe9
	wKGMbivSBjekLWnthJXZiJAvENG2wWHjbqlbTzUQkuRHfeLD1v4y0HEkJsuArNKzXbJAn9ZU09Q
	prdwisCvlVbVsW/tZK0kgpFiG6lC4LYDwcSeT6ZXRzSKMfQaLm31AnFnHiDciW4rZ1/vaR/zCsf
	dGyMiLrM/tEjx+MQLrw23KybQf5wbYIVK9ypbv3AutBGZBaS934JNg==
X-Google-Smtp-Source: AGHT+IFSET5fEYpxLKrekl/CT6K48xSChCPnERE0PSQetWRgGAxd5xhRuz8vreEzr/m9wFmt/Nn0bw==
X-Received: by 2002:a05:690c:4a10:b0:70e:2881:2f5f with SMTP id 00721157ae682-71140ab83e5mr71737657b3.20.1749672528309;
        Wed, 11 Jun 2025 13:08:48 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71152090d35sm155347b3.46.2025.06.11.13.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:08:48 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 03/11] bpf: frame_insn_idx() utility function
Date: Wed, 11 Jun 2025 13:08:28 -0700
Message-ID: <20250611200836.4135542-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611200836.4135542-1-eddyz87@gmail.com>
References: <20250611200836.4135542-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A function to return IP for a given frame in a call stack of a state.
Will be used by a next patch.

The `state->insn_idx = env->insn_idx;` assignment in the do_check()
allows to use frame_insn_idx with env->cur_state.
At the moment bpf_verifier_state->insn_idx is set when new cached
state is added in is_state_visited() and accessed only in the contexts
when the state is already in the cache. Hence this assignment does not
change verifier behaviour.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 882079f16291..002d1e9b2260 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1964,6 +1964,14 @@ static void update_loop_entry(struct bpf_verifier_env *env,
 	}
 }
 
+/* Return IP for a given frame in a call stack */
+static u32 frame_insn_idx(struct bpf_verifier_state *st, u32 frame)
+{
+	return frame == st->curframe
+	       ? st->insn_idx
+	       : st->frame[frame + 1]->callsite;
+}
+
 static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
 	struct bpf_verifier_state_list *sl = NULL, *parent_sl;
@@ -18790,9 +18798,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 	 * and all frame states need to be equivalent
 	 */
 	for (i = 0; i <= old->curframe; i++) {
-		insn_idx = i == old->curframe
-			   ? env->insn_idx
-			   : old->frame[i + 1]->callsite;
+		insn_idx = frame_insn_idx(old, i);
 		if (old->frame[i]->callsite != cur->frame[i]->callsite)
 			return false;
 		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx, exact))
@@ -19687,6 +19693,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		state->last_insn_idx = env->prev_insn_idx;
+		state->insn_idx = env->insn_idx;
 
 		if (is_prune_point(env, env->insn_idx)) {
 			err = is_state_visited(env, env->insn_idx);
-- 
2.47.1


