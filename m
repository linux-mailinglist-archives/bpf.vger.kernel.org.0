Return-Path: <bpf+bounces-62335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B385AF8216
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75794A8218
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37A2BE656;
	Thu,  3 Jul 2025 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VC4N1DMr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E7D2BDC2B
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575714; cv=none; b=D8l1k3w2hKjXLhvDTGqsHyYcwzBFmngnjj9kKfOLJZMCQgAV+YsLzqoko/8kc6NBYnY2qWCpxzK6hJd43jftj7JKOzCnbDeueAiBObckmlJ0Vb3/lpg3VEJ1o1voJpt3R9rZbMQSyGvLfySxQqfe26uCXRcB/Bjb1xH1Wp7Xnf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575714; c=relaxed/simple;
	bh=QiPCJAw6Fc9qG2is7o7Iy0lTsvJVqQqpMc156evlcJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3TVJgvTJY7j6slZNLkqbA+lQGkKS/AnlpPZw+/DI4Rchewu8BrzG4yShbyswCP1mb7JJvcwmGZK3bHvyC1lgvyLDsFLuYDhH/Z0BcVsp+qZGcPubbqaEw3CE6jkx0KQXr9O1zGNAqw6hCcBIBDbcIQt5sSX1RrFyE0EN5AVgTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VC4N1DMr; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so584900a12.0
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 13:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751575711; x=1752180511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqIEkhQ8/rK1fFhdJGmUCtRWZzcUvQsQqeZeEKBd4iU=;
        b=VC4N1DMrzNAhfJYt0kRjewpe2lT8PedQqDdTRCoeYkFcUHSPmmkUlUM71GknX5hmig
         39oUYcQRpgvLyNCMpC0s/PaitEklDBuCDWkXVjVV849IbwydsZMX6M/m6nmwKBgxJUYo
         shkSzV5XRt4NSWm4aM9ZVF6QWfX4jHNHScznLlHQiVNIiup9qy6AE1VplIGE6iZJ8Cus
         U+YBI1tZ2xqNEQiky0huimk7Yo9XZ3ATptB9W81B04h/9kjQFnHRYWoGg0wF0LIGPiUw
         UO/ihcZMDeWEEyFZsbQGU5wUCMjuSiexFHeoakH47WboQGJmLBDDF9d00+Ej465ee/T+
         3Yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751575711; x=1752180511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqIEkhQ8/rK1fFhdJGmUCtRWZzcUvQsQqeZeEKBd4iU=;
        b=U6F2FErpzCYFVvdWKJkK/w/LaAAsUU1B95dS7jFERHHnvn2D5vKuQ5zHXGFVgUmhTv
         q8wM64qVuDwxV8dEYfDbtqlukjBHq3slF5zlWsR6vTxqYNgAmMq8bwaqCpMN8WVbwvTA
         7w9asP3CajlcRCmvWTV6uA/rYHTNFPa/HFqIqUnsfHN2mlU4gJR8XFxjRl0eQTyTVYA4
         BYhL6i2tfv434/H12sBqwYs7FxNZtWtNtnBIKhELVgx5X0O/hQBAqFQAbpDPsW7O+8ek
         gtBLwmHWZZi3ApwFh0iWv9jE3l9p1II5boUMipnNbUh9Cx91yokSeX8OWzbWFpmFJJx4
         scwA==
X-Gm-Message-State: AOJu0YyOFHsRYTe1WNtA4NDncmQIMp8tWnH7Xmy1fu5JOAnxwK95FVBq
	Zn4cY+q+1EFPHE50unOVk9BjQKAajzb/J/A1c2IWIQ2NJF9QO5AQnYm3JJzWyoXxoYQ=
X-Gm-Gg: ASbGncsUZ+vQ0CLdH+TeqiKo/ZjPNQh2s9oZwacvAQ4TCOc6OoQTBx4gnduogSpTF1j
	RqJ3/Mbgo3xgBRR2+Lr+tWPWL0l+izvjJyokuLzsVJHTQDdJorqGokPiPhWU6u16DZkP8y0h2aE
	iKaGJF21Uoxh+DbfPvgR96d1eq6dpJv3j+TJzemeA1fW7PIvyNaNRaFIOcKiPOlCtfBqUVqNoOS
	0H3qyUetXvtE0KiDb0m4+5QKNz2XEroEAn8/+fHI+ayksI5UY20QTQ08XOP6CV8l9mss6kA18qQ
	tb1Jqe4GMIjIJ4H2j/BqopwvGjJcf5WuUtI6rZivluVAEamzjGgV
X-Google-Smtp-Source: AGHT+IFSjqntAC/WgyEdZCFagfyksw4oLbAoELGOwHCtaO2ZnXhzpJ31WaloB5U1YhxBPGWvaROBXQ==
X-Received: by 2002:a05:6402:3114:b0:607:7cb2:7a5a with SMTP id 4fb4d7f45d1cf-60fd0192dcdmr179190a12.13.1751575710914;
        Thu, 03 Jul 2025 13:48:30 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca6976f6sm285565a12.20.2025.07.03.13.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 13:48:30 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 05/12] bpf: Add function to find program from stack trace
Date: Thu,  3 Jul 2025 13:48:11 -0700
Message-ID: <20250703204818.925464-6-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703204818.925464-1-memxor@gmail.com>
References: <20250703204818.925464-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3195; h=from:subject; bh=QiPCJAw6Fc9qG2is7o7Iy0lTsvJVqQqpMc156evlcJw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZudLSXygEJNOYU/PQ4SKPy1jpp4h45w+BZiEzUVB Um6FFwGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGbnSwAKCRBM4MiGSL8RyrQBD/ 9sN6o4gznOALv2Z7u4B8gynKvSjN6IvDUmVhqi1oNuc2qRJq05dGN8UgWgJfjE8SGiIjYtaBl99hMp IaZdUbAhSGq4Yp9U7HAreXu2Yv/zrQMm3wGXowBQUPLVEKrBVx1wE+d+G15HB77oRJjoQJt5PPxnr/ KUCNUnBAWRi/5UUemvT8G5yjwMG2L/GyNcYUeo/lYxIg7y5iYhrTud2gPkm+X2NZySzPVsYuc/h/Yp gpEIITtH4d7ml9I0mln2zoV6CWpdAZKqMpkHybHTyfZuKEyx+pWNHCKfXSu+XJsUoTPCa62Ni74mrJ ReMwrigtc8OCZJXZgUGgZoLCZK3PXcrPsKmdCbYvVkj1H/sIgVbDsYzWuEPHikF0M8AAFab6YKJkiT 0PHU8ClWuYLYFNwd/AcEzE6v+NdPehH/HGq+NNlG0agN0biJZdp/hCzGZb7n+DOJU93xWgZnbLhg3J EQsek8j1TVFGbrFTPV5DveL0L8QrL7wGLVMvitBzjTktpa3qATdczHEOKLJld/VwznSMnTInnxkfJN UdcIwr28JWF1Bvw/1YAupHNGrEecfA6dKW6hT83ynznYtVwP1d71vO5gn5NfH9f5mTGqTrfgd1EqAr LUXVA2+Qjf1LWEoYT2xBEoYICratBnWkK1tK8YyJVyzcMuph3G0p5wI8Y6NQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

In preparation of figuring out the closest program that led to the
current point in the kernel, implement a function that scans through the
stack trace and finds out the closest BPF program when walking down the
stack trace.

Special care needs to be taken to skip over kernel and BPF subprog
frames. We basically scan until we find a BPF main prog frame. The
assumption is that if a program calls into us transitively, we'll
hit it along the way. If not, we end up returning NULL.

Contextually the function will be used in places where we know the
program may have called into us.

Due to reliance on arch_bpf_stack_walk(), this function only works on
x86 with CONFIG_UNWINDER_ORC, arm64, and s390. Remove the warning from
arch_bpf_stack_walk as well since we call it outside bpf_throw()
context.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c |  1 -
 include/linux/bpf.h         |  1 +
 kernel/bpf/core.c           | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 15672cb926fc..40e1b3b9634f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3845,7 +3845,6 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
 	}
 	return;
 #endif
-	WARN(1, "verification of programs using bpf_throw should have failed\n");
 }
 
 void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 09f06b1ea62e..4d577352f3e6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3662,5 +3662,6 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
 			   const char **linep, int *nump);
+struct bpf_prog *bpf_prog_find_from_stack(void);
 
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 833442661742..037d67cf5fb1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3262,4 +3262,37 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 	return 0;
 }
 
+struct walk_stack_ctx {
+	struct bpf_prog *prog;
+};
+
+static bool find_from_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
+{
+	struct walk_stack_ctx *ctxp = cookie;
+	struct bpf_prog *prog;
+
+	/*
+	 * The RCU read lock is held to safely traverse the latch tree, but we
+	 * don't need its protection when accessing the prog, since it has an
+	 * active stack frame on the current stack trace, and won't disappear.
+	 */
+	rcu_read_lock();
+	prog = bpf_prog_ksym_find(ip);
+	rcu_read_unlock();
+	if (!prog)
+		return true;
+	if (bpf_is_subprog(prog))
+		return true;
+	ctxp->prog = prog;
+	return false;
+}
+
+struct bpf_prog *bpf_prog_find_from_stack(void)
+{
+	struct walk_stack_ctx ctx = {};
+
+	arch_bpf_stack_walk(find_from_stack_cb, &ctx);
+	return ctx.prog;
+}
+
 #endif
-- 
2.47.1


