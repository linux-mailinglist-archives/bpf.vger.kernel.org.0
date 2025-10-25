Return-Path: <bpf+bounces-72193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD36C09D83
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 19:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D188D582755
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4129430EF69;
	Sat, 25 Oct 2025 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgGPhXIg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E5C30DEAD
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410009; cv=none; b=glBJJ3B9kUzDTJQKSOF8J6CWMiriG36PQjP6BJ6aIV5ec+1gt2aZZ7ppNuJFaUlL7Q4bajmjcu4TNydjoEZxgDIpn58xRUtc7G5BUgmTkaOTWD7YBZNBvOlxbmFxtboFCf67c44VgoeZiiM/y/gzYTDZWu4nDhwIf7Q7Dg1HK8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410009; c=relaxed/simple;
	bh=BQ3V3TJBGcgRl9M8TTeR9VPGV9MIeZxMNrPM3NKIWvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siyvk4zqE/rTd7DTbzpf0Ok/td85HxrjfnvhNAjy/NxGfmA4/0ztm0pdteruFn8KnWOrS1lPsV3zf+e8vxsu/GGRwU3SfaNiw5Ofzm5GwUkG4sNOIHqr5qa0/0Qfs/0/zqaVtPAbhGyLf+B/7w0REdFMOy/oy2wbnY3rMTUf9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgGPhXIg; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4eba313770dso8278991cf.3
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410007; x=1762014807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsJVQgpn61zq+Ge6F8BtEeBoOu3oJNRDvnauUG9sJYA=;
        b=MgGPhXIg0rTs9nmYtvb/bgsKyqiLVN7NdRQ4G2mUrJJ24tquypioARmvbsG+6FkCBB
         szepg08P5WF4NdGZqI0Xo7O8CDdNIiHW0NIeL37ESqFd7lRzgRTmFLOWrq11fPdVjDtl
         K7J0NuKz2cxxrT07ZUXP3dIQAOWjQ8FtWkS2DLI0YqbFSP5QAYiwuPndTkvuwkz+sRTD
         0KRkl62eFG8JDwll390+qZ3Aq1c4aUpQ15vVVOL5GCsMn2xAK8lN+x2f5eJDprckfdOM
         +ol53XJfFVdmcHYbhxZ0ZRWz1nysaDRKGRXj1MDAkbIA9VSsDeADodehyZQYIjpVLeYr
         N1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410007; x=1762014807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsJVQgpn61zq+Ge6F8BtEeBoOu3oJNRDvnauUG9sJYA=;
        b=bIroPtKCBev1hO7jXvCnXEam5vEAKh2ghQoVFjcuNE61iGSM4G3AgWZ1YK8N02Q7Yw
         Dfu/6Fx/KBT9CT+aPBLdmvAi+C9HW/HDTIziDpxtejLIQDHvpBtg4//BnPwAmnoyrxZ5
         IpKyoAEIhlQzeZqyFWTzKOw1Xd5WWsmIwxZhOqb595v2lCJh3Uj1AcwSWFRLIOr9+LNT
         DQ/dessVMYSBbJQi875IO1oA5P+NRnnengEvJb69MppyLalr+Gqv4W/ye/IOIBvy89aI
         dLLqrzkYv3ytygzilqOSgJf4JiPotqlZGWQOlxpK60levna/LY7K5X8ivKy5y+UhUcZa
         SKmA==
X-Forwarded-Encrypted: i=1; AJvYcCWpvx/CWSbvPq6480bIfdnHZZ2/L6X3p7+7SL8UCMrLaOEDZhvkCuaLyc7f6St9XcHkf+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIntk8/XLh7tpFaAeslalc931DSoVaDbHAQjz94Lhmu/RqYN3J
	UgGSXqSQWAo4tXdMEjY1zZnxfdO70H4hPn4EPlwS+HER7f2QF/U+dqQi
X-Gm-Gg: ASbGnctGt7S+9icG68Z7OijaJ5r+TJIDm1D5fkuJzrUAluiSnJdteZWWtQva0mZUeqc
	ChZe4S9FUSlJt/lq/2VLgz2SpdIc7LseDZ9J8JtiOelMjCXcZ4P5tV1ha+g2NaMus510VfCApst
	wJqDFptInlUoho0pUSqEQNudpLtc1XvEXXhpsV+YwVpN01ImBoL5xw1A6b9KodCzKjhVd1npxJI
	mfAiHVHhzwrI7Kj7Ib5IKrnA5H/227usXtFGyjSkRTuMSup4+JAsJ8vHaR3UhEXgU6VGPO8WZLo
	IIpsEI64REYQIFxyhtRepS48gxoISwfdhA/2rNJsN9rnqCERfypc8RCjT+KeuPhXnGHtwxmt8XG
	HXiFH8IkCnD8MOVCRDc5e44cMwGhdS8njgLFAQ9ZAr2941ixM+rgcNfaL6P4w9+4eq1OWPyfvUJ
	GfzvwDDE4=
X-Google-Smtp-Source: AGHT+IEi0gU3nsclmOfIhkatsK1ylhMxi3V/RcKHP2qNLsK4jpBPuV25o1zZOF+JE24zBQDJY9wwQA==
X-Received: by 2002:ac8:5d13:0:b0:4e8:a2dd:34a8 with SMTP id d75a77b69052e-4eb94912a08mr76566831cf.64.1761410007043;
        Sat, 25 Oct 2025 09:33:27 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25896d52sm172754385a.38.2025.10.25.09.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:25 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 15/21] bpf: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:32:57 -0400
Message-ID: <20251025163305.306787-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. BITS(low, high) is more
appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff40e5e65c43..a9d690d3a507 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17676,7 +17676,7 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 	 * - includes R1-R5 if corresponding parameter has is described
 	 *   in the function prototype.
 	 */
-	clobbered_regs_mask = GENMASK(cs.num_params, cs.is_void ? 1 : 0);
+	clobbered_regs_mask = BITS(cs.is_void ? 1 : 0, cs.num_params);
 	/* e.g. if helper call clobbers r{0,1}, expect r{2,3,4,5} in the pattern */
 	expected_regs_mask = ~clobbered_regs_mask & ALL_CALLER_SAVED_REGS;
 
@@ -24210,7 +24210,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			def = ALL_CALLER_SAVED_REGS;
 			use = def & ~BIT(BPF_REG_0);
 			if (get_call_summary(env, insn, &cs))
-				use = GENMASK(cs.num_params, 1);
+				use = BITS(1, cs.num_params);
 			break;
 		default:
 			def = 0;
-- 
2.43.0


