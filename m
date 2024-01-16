Return-Path: <bpf+bounces-19676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE2382FAE4
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209891C264BB
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 21:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9489515CD6D;
	Tue, 16 Jan 2024 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFpPznPK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F515CD5D;
	Tue, 16 Jan 2024 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435292; cv=none; b=YzeW8iJ9J3loNoVOWg/xF0dHB7Qzq1sS/OcAG9cVPWlc4g9BPYLfGewuqbY1mT6hCFRCbqGWdJyiwAE75SNJP01abrC+DGVympL60Jw9IszwAaLIGL9yPdx0Q3cVQMaRPsQNTQU5/2ze/FKgtbsFWjLVQsJbk5UWD+tp6lzrNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435292; c=relaxed/simple;
	bh=vq364ttm36Xi3JMcm9u7oxJMHYbvzLLpKEWyuRmE7IY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=LyazN74PFuRPv4GHVV6umeWNK//vi2L9eNlIW4DBeP6keFW/y/I58tto6ev+1nM5o6b62xh0v30BDKy44grHFEA1zj6vNkibMd9AoeYyXGiDGceISq7wiunWf+gPlOh14bdBzhyMD+uJfCWuH7Rc87dmFrhHWLHXKUXqhrINLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFpPznPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D1EC43390;
	Tue, 16 Jan 2024 20:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435290;
	bh=vq364ttm36Xi3JMcm9u7oxJMHYbvzLLpKEWyuRmE7IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PFpPznPKjB5y8FSOUFj7ZAJycoiAcRAQM8M4jozviLNSHvkvoPSfaEQCYYHi5v9cl
	 WU0qGGeEdkMN+6AsntXs3ky5YpwHQiTL3QWCm0B1MEW6xuFS6Us/g4ud1HYCjfcy9Z
	 COEJZmtuTXTEazscNedSkP3Vs/kS5OWojy0HAdUvP2LQz4a172777xBFKnDy0SsudG
	 BWZGgPNXXF5sX1wpOZbscFsVDCc87P/kSZqajVwNv/MzvoXztjxr8DOF4tOMGURUQb
	 6LtCrMLR+uwRIAVBqHA944kmrPZYgms8EOxMTSNoqJ8JLkbGGdAt3AT5vr742q6DsX
	 NLM+7HeU1+hjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrei Matei <andreimatei1@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 18/44] bpf: Guard stack limits against 32bit overflow
Date: Tue, 16 Jan 2024 14:59:47 -0500
Message-ID: <20240116200044.258335-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Andrei Matei <andreimatei1@gmail.com>

[ Upstream commit 1d38a9ee81570c4bd61f557832dead4d6f816760 ]

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

Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20231207041150.229139-4-andreimatei1@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 45c50ee9b037..2ee5f859e024 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3883,7 +3883,7 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
  * The minimum valid offset is -MAX_BPF_STACK for writes, and
  * -state->allocated_stack for reads.
  */
-static int check_stack_slot_within_bounds(int off,
+static int check_stack_slot_within_bounds(s64 off,
 					  struct bpf_func_state *state,
 					  enum bpf_access_type t)
 {
@@ -3912,7 +3912,7 @@ static int check_stack_access_within_bounds(
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = regs + regno;
 	struct bpf_func_state *state = func(env, reg);
-	int min_off, max_off;
+	s64 min_off, max_off;
 	int err;
 	char *err_extra;
 
@@ -3925,7 +3925,7 @@ static int check_stack_access_within_bounds(
 		err_extra = " write to";
 
 	if (tnum_is_const(reg->var_off)) {
-		min_off = reg->var_off.value + off;
+		min_off = (s64)reg->var_off.value + off;
 		if (access_size > 0)
 			max_off = min_off + access_size - 1;
 		else
-- 
2.43.0


