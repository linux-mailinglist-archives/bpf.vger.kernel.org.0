Return-Path: <bpf+bounces-74062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D3913C468EA
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 13:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BB7D34955E
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 12:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D8819D07E;
	Mon, 10 Nov 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct+faKxR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1048CFC
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777098; cv=none; b=NeDOK4xqHQuleJW6Jj+BD/3IXyL7O6aQN46VR6HudacOrJUa6T3hjp5zH+7rxz8eBu6ibUDPRLXNtTVsH54D+r+G5N6J5UMzbVqMYpTr2wtq9x8KcpmvqTOikmIEbOxN/13k88ABUvpmFRKGZntLo2mddkWRVhdowj0cuZpLr9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777098; c=relaxed/simple;
	bh=yiAV/fd/N37LsByBzQjNfuQsL1HCbFqYPib3ufTbct8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYtnYGLqvlAqRl/qm/HTuDcwMDpeVDTtAu3Dd3l4fi6XJs4Iyz9QCuRUTpcUZNoOitzNhRd6NZVGI55aeJKZj38NytGz3L78xnPHZyLQ0aa81B7QLj8yXiY8tvoNgITyzaUwXhGbYPdfQNgwO/ZO5SRcBsG3rkRO3o9iZf5/x6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct+faKxR; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2953e415b27so25832425ad.2
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 04:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762777096; x=1763381896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3js87s4uRJTX6J5wR1Akhgx1Ub9JhRGdk0bxXqN53yk=;
        b=Ct+faKxRDJuIZwIEukLItMP2Mfn4BESSr9u2UTnHure2YaRykmtcGApHGvaQpLDCUM
         WQUxLJzPOXS2089W+CmFeTvVV3YLtmVZyK9ljWwTPqmQ+ld6ZvtpKpmkmOcEMz8sfVGf
         Y0ropQijuqAt7AShED6pb1vxec3jLLIJ2gjTr7R/f8aXhjJNPg8Z/VjD/DQv0p14GNI0
         yNqATBFUnLHuiRJuboA+cip3kF1z/SV7RLNpTjVG9rYKi7ZJNmyzvL7NcTCfh77XGkO1
         ivcHtymR9SmfdXlkGkkjQrBerKAJt8OJsg1fs24VdkjNJL7PDUPkB1mlApzeLC8SlDHT
         9izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777096; x=1763381896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3js87s4uRJTX6J5wR1Akhgx1Ub9JhRGdk0bxXqN53yk=;
        b=PlxzR7C5vtEnPtxPkGRN70OUThjr8znfPtcUKCYWL3h22n0eUfRlcdfEXUs+NjYzEb
         shLK00hBAFhlwNFyvYYeS+hrA2oB+E0ACvvfGAX9S9iRhQSiDwDVwm0tCHEf4OPSPcnC
         YHlG2/HQ0sCD0E25oFWNS88QTscX9fAAmf4aUzUY9yGFktKkFge6xICCJTax/2OA2soE
         SCOoM86edOOmWQY2jbqaEaIODd+KbX3tFc6RwEoLXXO9xRIOxRGoBpAZ9ZsWK/F1GKah
         unNcD3NV3eJOSRhfTAFWc68fWqxA86cXSePFr6sKKiakW8/l5adPj/uTtoV/H+fU8Xsa
         H1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTgSzaKJ6tOtAq/Hx2rMzp9zSa5+AT2lF9/v+Z76BmAG9YGbe6Kg8w85b5fmnBlKQ6vk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9owNSglI/8F7sgIQiHSoDzj4DAGgAWZZyvW27WBHeaFUklBq
	nAfJ34gRRr8HCrAqrGpTka/fSINWL2GIxvJPYTm10UyHnXIZV3eyr0YS
X-Gm-Gg: ASbGnct9x/Qp9Ws3yMGRD8Yl0Cqox4vvnv09Ur1X+tj0J0SnIZe6NPCtwGLuOhlVBFN
	+FD/9DlFP6NK5z8QJOUTUN3qcBXYwnJ+2UBZ87HC6/AbBdU4goiH+RFn02IdZ29VwmEMe2AB6hd
	v0wWYmRm5Jz10ptS7K7xH5z1vCKsZb3BndMIRmX86gm755MleSVpEmBsLSVm3umcH5ufDsP2SPy
	KtMWiIU5X5bI1GDWQuWsYoCMFgbC2cM0ReXTI7jI59HvY3eCpxTJdoMR6is1L0Li104C8Uf1lmH
	8BM3oITnuRBdnYCnXdbdnm+ylzkYLZ4veAXEoF5Q8fX0wUwHF4fUmmpouLz/7OO7Rux3Z0+qX5O
	/T/byLGDqyHz0ypUNGhkmcztItTUefuSETZidmDWphOy4VXzVb7nrkGWWy/9Kyl2ZTOSpkBu23W
	TcHjOGT9+YXsM4RzSRAqOCKA==
X-Google-Smtp-Source: AGHT+IEPwrYX6YCYhn6Q9zCx3HRfyuBq/4dWxpo0SHeeQsQ3hYDLG1ZkKZZn3/tm4vviI6ZKMPZscA==
X-Received: by 2002:a17:903:1450:b0:298:2cdf:56c8 with SMTP id d9443c01a7336-2982cdf5987mr23147225ad.60.1762777095893;
        Mon, 10 Nov 2025 04:18:15 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8f2b3sm147271785ad.76.2025.11.10.04.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:18:15 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: rostedt@goodmis.org,
	jolsa@redhat.com
Cc: mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] ftrace: avoid redundant initialization in register_ftrace_direct
Date: Mon, 10 Nov 2025 20:18:08 +0800
Message-ID: <20251110121808.1559240-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FTRACE_OPS_FL_INITIALIZED flag is cleared in register_ftrace_direct,
which can make it initialized by ftrace_ops_init() even if it is already
initialized. It seems that there is no big deal here, but let's still fix
it.

Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 42bd2ba68a82..efb5ce32298f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6043,7 +6043,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	new_hash = NULL;
 
 	ops->func = call_direct_funcs;
-	ops->flags = MULTI_FLAGS;
+	ops->flags |= MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
 	ops->direct_call = addr;
 
-- 
2.51.2


