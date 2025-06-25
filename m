Return-Path: <bpf+bounces-61557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049EDAE8BE7
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 20:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A69F4A3D5E
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE29285C82;
	Wed, 25 Jun 2025 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF1uAAY8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F77C17A2E3
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874508; cv=none; b=nbiC05aPuVeBB2iMqG0o/vXUMHj2SpFd+F1c+7dqK+6pPHkZDRtEcrDeLYGWGf7HwTYRcaNpbIGQHLa4ZYk9BmhGiRldzb5n2pKUFkfdaAVUPsVgNJgpcCsGWLm1sw2AQol3rkVlOwzf9Xk6rvKEXtvzI38ySbE824cK6K+ds5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874508; c=relaxed/simple;
	bh=oNnIE8WDhul1DyROfgSN+os/CXCd8vlbW0GQb9H+3xE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KazTjwXX60UzkIIExxvtSZzigLVz57t1x0vJLaK438DcXmGPwdbFrsrAe9I8T+5NJPJWeiZQeJvzX0+0LEVCxpsJ3iKZnWrYBkKqBrBZuIyhWr+713gASQ95VpKl8B9CothIE0JrZbbmxvTl2Bkj8rH/NUiIm5zeb7iWqhSQO4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lF1uAAY8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so1461345e9.1
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 11:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750874505; x=1751479305; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3uldPgfb5J91roohCeUKzXXqUd6R+oFg1sLEV2Tz3E=;
        b=lF1uAAY8DGEa11azsp65gRCY/nP4UfSndQu8VPG8bt5OwDfOIkzJ5UsLtS1p4oPdon
         1DL1lcINJM/nhFVAU91OfcC0z+xryHAIC6JuJPiJtHiyNHCCntAg3m8bAQxiiQwoUss1
         OpJW9IInrrc12KieVPXPxWRtv2KIwEftbgOYIzd8fWnAur4YJ+ixSL9JT9ekzpYV17/f
         LMIl3wa/gEBJfZPkZXWd21CZeEvHVQGfmT0Fr9wNRPjaaB9opSDIKh51CYfmFgOfL5g9
         Ev0W5CQ95XyA2ALKvUwborU+5xqoMOZEbSoNWd5CavX4ZKGqo+i5ATvYbja8NWBZTd0t
         xp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750874505; x=1751479305;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3uldPgfb5J91roohCeUKzXXqUd6R+oFg1sLEV2Tz3E=;
        b=XK6WUYG2Wf0pvwPoav1+5lZvmfqz1S963yf7AprItqtb9KNHH1YTHZApkeL9yoJkHa
         2XDxubbtn3IBml19iQoS1vKC5YLkH8/ZocfFDAv0rgj/W7VqQSnMnXD+yQpfex5UnZ14
         llB6gnUknod+9+U2ZbGtxCnIxqIaRRcTjhd8uMzbitZXklxamM/7lDGnrS+vroF88r5X
         Dc5IujOzsfwWQWqvtWt12QRlWRCIv393sdZjt7XUzsg1bWgau+6ICdE7M8Js20rHLR+0
         BJ2QxRBBwRjyrqvx7cmlVjHnNjbSHcPnsXQHhOU5w4jDYiMDv2GjTXFTYvZ+Fi5uHgn6
         AXHg==
X-Gm-Message-State: AOJu0YxZf1Nyjw8A8RfS03btl+yQkuzQIXeovgEvOjmXSj4A0JXbjNrd
	QknvkX6jPPekB3eT+otkUkvIAHE5+I1Byi6PH4qkZIuQhar+T10pBf3dOBH/KEyG
X-Gm-Gg: ASbGncsUwJuqm4xQirl5QOiqSKOoXNDIGQrWhyM6BDIFosCVtK+cNx7p5JKy6We3yob
	LDrF443CvPCxrMX8Z3ZUZdsOE4BVlqHs6+BGURvAXo0FA/dRY25HpsIgl0dL4jSkzIVzmMEmyZy
	bXgsFrB11R/dtmFjNIA2Jm+UkuTiwgvVjM/DQmB2iIkSrbxG091RfzMlqxIFTbjzW/IAtmZxQDQ
	OHFihS6+8DTCwfPFjejh5jAUPINZCSBhQyCDTOwpRJdj2SUKBm5mRWljR7gD4EfRY7yC5JnZDrz
	vHRmT4/Km5SfbIsaPqWH+QkF5lTSI7w2hJKK+FpQByI6rQZMHruAu5wLH8VesMEx3U8J+TblmiU
	ixlPOrduPso974pTh1mGSnmMeb5oaQ4yh+PTBsZDJ3LUy/F/Hm+kTUvDiHuZ4vQ==
X-Google-Smtp-Source: AGHT+IGYdnCrgN9SHWAXliSBomSTZXAe6BMb80es7UaLTa1iiur4Me9eSItCUnwWKUgvIDsDRGMg6g==
X-Received: by 2002:a05:600c:1993:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-453889e736bmr5190765e9.10.1750874504912;
        Wed, 25 Jun 2025 11:01:44 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b67e3b4611bd9a64.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b67e:3b46:11bd:9a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45382363f7fsm26917285e9.27.2025.06.25.11.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 11:01:44 -0700 (PDT)
Date: Wed, 25 Jun 2025 20:01:41 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Luis Gerhorst <luis.gerhorst@fau.de>
Subject: [PATCH bpf-next] bpf: Fix unwarranted warning on speculative path
Message-ID: <aFw5ha9TAf84MUdR@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1") added a
WARN_ON_ONCE to check that we're not skipping a nospec due to a jump.
It however failed to take into account LDIMM64 instructions as below:

    15: (18) r1 = 0x2020200005642020
    17: (7b) *(u64 *)(r10 -264) = r1

This bytecode snippet generates a warning because the move from the
LDIMM64 instruction to the next instruction is seen as a jump. This
patch fixes it.

Reported-by: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 279a64933262..66841ed6dfc0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19819,6 +19819,7 @@ static int do_check(struct bpf_verifier_env *env)
 	int insn_cnt = env->prog->len;
 	bool do_print_state = false;
 	int prev_insn_idx = -1;
+	int insn_sz;
 
 	for (;;) {
 		struct bpf_insn *insn;
@@ -19942,7 +19943,8 @@ static int do_check(struct bpf_verifier_env *env)
 			 * to document this in case nospec_result is used
 			 * elsewhere in the future.
 			 */
-			WARN_ON_ONCE(env->insn_idx != prev_insn_idx + 1);
+			insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
+			WARN_ON_ONCE(env->insn_idx != prev_insn_idx + insn_sz);
 process_bpf_exit:
 			mark_verifier_state_scratched(env);
 			err = update_branch_counts(env, env->cur_state);
-- 
2.43.0


