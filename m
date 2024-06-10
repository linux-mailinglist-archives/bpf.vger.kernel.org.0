Return-Path: <bpf+bounces-31710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBD29021CC
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 14:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DED5B21222
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 12:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2073A80BE5;
	Mon, 10 Jun 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzDtJY2V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B180633
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023358; cv=none; b=IAfCWovNyADPXDfBaVeQHqeddPso79tbsUEmrZS/1DXFzaZtqO9Vqi5lSaHiTI6frh81o0jJ9+NBL6eFHngh9pFhxEM2WF8n0jl1j3tMlRntjFibfja65FLh2PNk16/6uAByUGKTzVI0o3ZQVGKnNh/7cgS7W7GokuGJOXhpmu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023358; c=relaxed/simple;
	bh=gjIMlJRVXCwpgyayrO4MG7FK69uQKiPeROc8/Y1ffQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnOyg6Nuk8yF74ju/gH4Y0y/OelULOeeHeI+EyFxSD6XeLh/whq+AdwXX9qRUXagqcmSy0QFSMwRPIOa31UC06WH4gvv9CqNbiUNpBY2wE9ZT5i29X/RR4CyO3O0qPNKkJZf7RTepJb5Usm1eceHKZ1sAhq2F+1HaSBoaGffFOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzDtJY2V; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6a837e9a3so25301115ad.1
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718023356; x=1718628156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDpwLzr0L7zA4xsFnyk7mtAO43zcO6Ss3Gr2y+uDv2s=;
        b=FzDtJY2Vzkrnqe9NA3pGNMT7ccCZkZGJ8ObY4mYVEzg8EVq/E7/DwPObxRb8uB9WRC
         tL0/gVrXq7I8ReTi5TbChgB5+PPA5TcAyoEZs2a2dWmCgqMakiyZD11uEmp/1mPqEQJM
         KZy4u1VcX2StLjRJ0YH0aJJrWaGMlbcWpTmAx6dSFZhD47+TKPlbe+8z+FSeaNw1u32i
         aP0/IIiaQcgMEFZqPu/ooklxVfsFBf8G3EPb6yyWaRxyBdsvb1homI7jQQMvrxLKpDln
         AqXyzQ3RxYISfHRCTFoS6TDiOVEsubIWGTqIYNKyhqAOTDznMqqyPVuV+0EPya2alY34
         OEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718023356; x=1718628156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDpwLzr0L7zA4xsFnyk7mtAO43zcO6Ss3Gr2y+uDv2s=;
        b=cYQTMcuVYdsIQGoZNo1FvAz+T06LolKG3UMlZZDqp8srxneYcVDYAxjmjWNaBHGeSD
         xNacAdfNGUH2xzz0S3kAPZPixy9ms1RFbxheOLSd35sK9TBIlWwq85jvdkbr/pDwIGSF
         vgIaVosgfcPvoifVP7QgzXN2rea/MgUPnIm7PVLQE+6pwSQrEksf1Su947Bp7JUKrKVC
         sCUKGJvjXvmLF406qCKow7+0o81+YUb4aKTK5CwDM4bBLKeIeofojcp48ahg3h5LYN1k
         Orw9xjeY7ZUZxUlKye45+Q6sPS+hkieqXigFKxJ+khgoo4/cMXeJh1YKYqxijmkYZPnf
         bEaw==
X-Gm-Message-State: AOJu0Yxz1XE6HSUW+kbh6UVn04j6Xjg/9lm8BN2B6zHpcIrmzWVvdMds
	+4nrBTXPAUXPgHDkQXyEvxMJ3pSyJZpaNPQzO9QI41Y9ePBeimwqIxsWew==
X-Google-Smtp-Source: AGHT+IGy4UUVTeLJg/7hSl7AmDh4/crwuut0PSLTy+Jn4bgBN/JaHUPMvCKCsc1+dBcusTgrNoy4Ag==
X-Received: by 2002:a17:902:d4c3:b0:1f4:a36c:922c with SMTP id d9443c01a7336-1f6d02de0d6mr113435545ad.20.1718023356055;
        Mon, 10 Jun 2024 05:42:36 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6d859ea3csm61578855ad.178.2024.06.10.05.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:42:35 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH v2 bpf-next 1/2] bpf, verifier: Correct tail_call_reachable for bpf prog
Date: Mon, 10 Jun 2024 20:42:23 +0800
Message-ID: <20240610124224.34673-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240610124224.34673-1-hffilwlqm@gmail.com>
References: <20240610124224.34673-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's confusing to inspect 'prog->aux->tail_call_reachable' with drgn[0],
when bpf prog has tail call but 'tail_call_reachable' is false.

This patch corrects 'tail_call_reachable' when bpf prog has tail call.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 81a3d2ced78d5..d7045676246a7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2982,8 +2982,10 @@ static int check_subprogs(struct bpf_verifier_env *env)
 
 		if (code == (BPF_JMP | BPF_CALL) &&
 		    insn[i].src_reg == 0 &&
-		    insn[i].imm == BPF_FUNC_tail_call)
+		    insn[i].imm == BPF_FUNC_tail_call) {
 			subprog[cur_subprog].has_tail_call = true;
+			subprog[cur_subprog].tail_call_reachable = true;
+		}
 		if (BPF_CLASS(code) == BPF_LD &&
 		    (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
 			subprog[cur_subprog].has_ld_abs = true;
-- 
2.44.0


