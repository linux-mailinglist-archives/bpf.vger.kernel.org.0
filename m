Return-Path: <bpf+bounces-20951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE984582C
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 13:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A421B24970
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 12:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C02C5336F;
	Thu,  1 Feb 2024 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIoUF8AW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579A11DFF3;
	Thu,  1 Feb 2024 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791972; cv=none; b=NhI2Fj+6lWdZihSqHOJ0klSykgdH/KXf8p1QF9TksAeEfAto40KsuRcxRpdNM0RisScXVE4sTdQP7XvLfrqry8U96AGIASwAXLzQmeXxMMOdNO5hzy6IbAiNJqK5X0UieR5bgiUh3h2byraWDnfl9DjjHW4BcjrH5CJfkvH6g9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791972; c=relaxed/simple;
	bh=BRXd7Tdn2fKOM1WoZqHdsPF3Uo151RUlA6ToYqeA9uI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEiHMUoRTW3ivY6ZPc/9+zE8TwA6IV3faG7WiDlQnjWGfn6Tr0jWlhrvtTpMBI2kbqb3Y0YNOhlIMyH5QtRc0bvSV3V5MmUVrmxfBRCfhKqgUuFo9ELoHA9WKKWPieMWrrW5yYxCOVMWhFB/g93yN2H6+oZR/jNom2Yhu7Qy1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIoUF8AW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e800461baso7980565e9.3;
        Thu, 01 Feb 2024 04:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706791968; x=1707396768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Z+EJFZpEuuwaeylDdMVXwrB+zfZxw9ouTIGewC5rpI=;
        b=JIoUF8AWF0RAl54Hj/3CHiU82TUfizqjrdVbvsnJkj5qm0K3R4QvjklM0Oye750Moy
         hl0VyruStMpQFWcT7/6TcsOUtUvR78kC/bjfoLvXhODLyAPikCMdmfDuAmMJ1QtQa8Y4
         AZgVufIxMGHb17Lrikmb+FH5tqxZDc7yaospYIKPoZ0yS/u2E0F6qREMCk2Ql2RCZizR
         hlxowNL7oJP06g45n4+MWgkJ8XGHiZyc0Jw6+8vXOhfUiR1Sp1GWDr81C24t0juBnSG1
         9MmG4QJ5wYQShH67DNjBZDawVdiIACEwRCppKpLVzfORjov2WAnU5RI2FURdAmmn2s5c
         hJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706791968; x=1707396768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Z+EJFZpEuuwaeylDdMVXwrB+zfZxw9ouTIGewC5rpI=;
        b=mocAnPWvBPOIcT9HCrOn2AfI4pkIF6vPdr98+iLJodOfSvNydE/7Dq7I5cBeug11XE
         czezjPwqITphOYe3BDe+hA2ST4oqeyq9yGpQDkzkpm923WB7Zi5fMh4EtNVLW8ddG5CL
         9ZYl2Quzh8iTit9J4UWvjgUoEbtQOlShutmVbKDFmCQ51AWxeE1FTmkGhMWhIFCln+p9
         8gRhiG5F4p5QzgiEMbi3wyRQ79IDLQS5ClQyR2PZFVJ2/XyQXcE/nJ6QTY0iiJHhfc98
         2uDcGpQ6B7+yU7hmmyvtbBi9h2cYTuHaMPouqwbuV+ZivK6ercWHWSJIDN1MmsMyG2Jo
         FMWA==
X-Gm-Message-State: AOJu0YyIlvTPyUYHRZbYt7cs8adIBphfogANMuHiz4pr0z5X6qqgfulH
	jMxGr3MLpiCcNY9BdoVT6v024M5g8y8sETrawD6No8rx4e+R5Ldp
X-Google-Smtp-Source: AGHT+IGTMK7XQp7iF4IDr0TpDZGBRyCM3MhuXPCpoD1p/qdWnwKIbPEdTe/VC1xYZeppYuIxQN0xxA==
X-Received: by 2002:a05:600c:4f82:b0:40e:f536:cff2 with SMTP id n2-20020a05600c4f8200b0040ef536cff2mr4074854wmq.2.1706791968330;
        Thu, 01 Feb 2024 04:52:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWHgD5rN5YetrM1Nc56KSl9RzlcGotJ0aNpjd7oRytX1ETCxj/luETj2mKRMRT/6tOjFLhV3KzLjku6oKWsr3sdZjR/lRNVZbxeH37ztTwfRsYQFai/FawAturIJcS4cPjGhksMK2oNZ/aAeECcX41YR6iM3lWfAFcrLn71AiZZOX2NnDUTaKlQJ6F9pTYjiHXSM86scoeNUwgEXCjSgMRM/l80oET8sroXz0XXtl2A4i0RnClVo0f7BoiNXZBx1E675M1YTBlPMAxmUM0rBYndbriX3jvAQsvodBdIDMw9xSA0UNv4V9RGT6mJCM9VczcBxzY/1hO+nNZvnqXUdlU6DSChxfoDizqLYF2DNhe77khIkkOKpod9LXiXWSEV9CU6OpGtEotiTC+rLmr0EJAdHxcwxGIxoTODtR7RKURAup2AX2covHHMF8AYVE6w8a8jDvvZVffkcWF4kGy5lHm0ZsQD8paU1OThlaVI3DfVy/Q95QwkracQrdKgiW3M7V1PXtuzYqLonwEx+MjkzGwOp6ptbnFJeP5ix3an7u5e8vJuKA==
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c190d00b0040e88d1422esm4397968wmq.31.2024.02.01.04.52.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2024 04:52:48 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v3 1/2] arm64: stacktrace: Implement arch_bpf_stack_walk() for the BPF JIT
Date: Thu,  1 Feb 2024 12:52:24 +0000
Message-Id: <20240201125225.72796-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201125225.72796-1-puranjay12@gmail.com>
References: <20240201125225.72796-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used by bpf_throw() to unwind till the program marked as
exception boundary and run the callback with the stack of the main
program.

This is required for supporting BPF exceptions on ARM64.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/kernel/stacktrace.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 7f88028a00c0..66cffc5fc0be 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/efi.h>
 #include <linux/export.h>
+#include <linux/filter.h>
 #include <linux/ftrace.h>
 #include <linux/kprobes.h>
 #include <linux/sched.h>
@@ -266,6 +267,31 @@ noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry,
 	kunwind_stack_walk(arch_kunwind_consume_entry, &data, task, regs);
 }
 
+struct bpf_unwind_consume_entry_data {
+	bool (*consume_entry)(void *cookie, u64 ip, u64 sp, u64 fp);
+	void *cookie;
+};
+
+static bool
+arch_bpf_unwind_consume_entry(const struct kunwind_state *state, void *cookie)
+{
+	struct bpf_unwind_consume_entry_data *data = cookie;
+
+	return data->consume_entry(data->cookie, state->common.pc, 0,
+				   state->common.fp);
+}
+
+noinline noinstr void arch_bpf_stack_walk(bool (*consume_entry)(void *cookie, u64 ip, u64 sp,
+								u64 fp), void *cookie)
+{
+	struct bpf_unwind_consume_entry_data data = {
+		.consume_entry = consume_entry,
+		.cookie = cookie,
+	};
+
+	kunwind_stack_walk(arch_bpf_unwind_consume_entry, &data, current, NULL);
+}
+
 static bool dump_backtrace_entry(void *arg, unsigned long where)
 {
 	char *loglvl = arg;
-- 
2.40.1


