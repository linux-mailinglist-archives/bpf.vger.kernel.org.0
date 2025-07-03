Return-Path: <bpf+bounces-62334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A216AF8217
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 515597A1849
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161C62BE645;
	Thu,  3 Jul 2025 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+VLsEXD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF804258CDC
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575713; cv=none; b=ETnEw8NZcIyUp0M6R9uyfqc+U2HinqMRu89HDoXFLKv/tpwQNYY9sbY9RYIggA15zoCETMxrULoyUUI+JOa4WGcSqVox1BFpNe/Dt9i5EFIr0YWQk9408j6+ed/qN1LfaaRs/o5CPSBx0aaikX60uXVHfIsuSyu7WViQ4YYFln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575713; c=relaxed/simple;
	bh=gumr+xxSUYFcCvf/7ZCSy9bAYjalSkvaBJ8Gb9N0AvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLxYbO15zLHbg88yEa8itxYf9htRKsAeDtDurYgJDhNigUYGaQAJZ6ZEvgGYT5Hj4Wxo8Ykfc3y3Vv60EWF41f3SXNqwvpy+Dnw1+Gyu4IykOznD1qEE+I40S0pw9xFPzTxkY+dwbnVfXl4VBNCVxZMhnDFGghkRf1IxdYm+rho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+VLsEXD; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so547118a12.3
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751575710; x=1752180510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIDowG5z0aD7iUnFn2quQuuMQZ6poYViKEmwY3MdDa4=;
        b=K+VLsEXDkwdQ5Xm6styobkunoUy3QM71M0aqT6CA6iNaTav2+PsFHaXJ9ejdxBRiTJ
         DOjEdFgZSUEYNUTQIjlW5DParnJ8gmQHSc1lDEfwjAqJ7O+TI0bpEOvxCjhdPPv7lsum
         Hmd9QAEaxVCIS411e3bcdmXLXLW7SbLybHbyezKp5TnxrTXoEPXUCAJ4qn+pp3tOTVOO
         7vqNnvnqwFstXe/GQK3vqoUz33X4XEmSsAcV143w7VgVFWzro6J6RMZu/gb3YL+LmuR3
         YNltBP11+bwabuLqjtvG60e7I0ltD2RtCluiLjyXbTC6n2Xv+Y9nHV/hpQrAwdHcsQYi
         QbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751575710; x=1752180510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIDowG5z0aD7iUnFn2quQuuMQZ6poYViKEmwY3MdDa4=;
        b=tf0xEQZfTok1N8/xqSVuPYuUkKY5Q1JeebNtbQ5dpToddzx4bzfAtyKGmmerUMScsS
         F0E6+0g8WnxWxU9AJuFxC+hJX1IVAuWy5wRgPeXX1uWObpH0LJz+9HDZb9gmR+eHm3Ql
         d7qJZQP2KeCez2Xb0gfN++pYg2vKObXfXRtNDhG6HZn5fF/M/4TRuy9oKYXVZU2Hhsa/
         LXC94k4OwTqCcwvS8OVw4vZVvmTNf4kz4vdBdwRgw7eLyxScloyZNMyWRQdeFfNc0968
         w+LhAYN0LxLkSePxhJTk2wGeRjuWqab2WCV4Nq7ynNP6qO7Nt3Y4YzVPYTTNadybrZiJ
         R3zA==
X-Gm-Message-State: AOJu0Yzs0FKnlUt7ngcCGJhn6Kp3OeHzArj1VpgbKkRHGiIb1vYhN4BU
	TtVqeBkvlW7Jk/bTLXrmduDsjcc+T60jgELmNB0BWAneSOFjMnITVqWpREfYJxhS+jE=
X-Gm-Gg: ASbGncs5gIlJr3LmIHjt8l1r/1peDFX1hy2WStbZerDctLcyihfKz4k/58UFbh9naft
	onkgoJ+o5TZZCFcvxI4kB69k0uXX9EHYSu+iAI3MrsyVR/RLKI8+dWxCTgjnpFwkiO6NI6b0dEL
	GoAEvss6zhtIUf0mnkCEzgGU7xtm9nCbEsoegqSv5kusCsmWU3XbXhM7yenXuAMTbSnF7OdgMeG
	AFg0blsMjqWl1sGV65hURjucWV4/rFpirFJKpOkTbnN54XGX7L7rLT5dl6WF58JcrxdCjlhV5DY
	FIrj1vXiJ+YPDbYjOUTQWeEUNg2C0twTHPRN15xAQXooBB3rocw=
X-Google-Smtp-Source: AGHT+IHDLKf27gZnTwOUf5/GEZqcoqAj3aaoBYupKOhRarhoIkZxfP9BKS28U4rpD3ySU5N5rYLi2A==
X-Received: by 2002:a05:6402:2347:b0:607:20b1:7485 with SMTP id 4fb4d7f45d1cf-60fd2f7e777mr28619a12.2.1751575709659;
        Thu, 03 Jul 2025 13:48:29 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca6641f0sm283303a12.4.2025.07.03.13.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 13:48:29 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 04/12] bpf: Ensure RCU lock is held around bpf_prog_ksym_find
Date: Thu,  3 Jul 2025 13:48:10 -0700
Message-ID: <20250703204818.925464-5-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703204818.925464-1-memxor@gmail.com>
References: <20250703204818.925464-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867; h=from:subject; bh=gumr+xxSUYFcCvf/7ZCSy9bAYjalSkvaBJ8Gb9N0AvI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZudLpMcwtNilm5pwvq/VotTB+8LRm31sJ0y5T3eQ e+mAJYqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGbnSwAKCRBM4MiGSL8RymokD/ 9SpfxpyDr/v/zYpgqfUHtq/bQVt3dyfWDFkTi3dW/Zts8A9eXWlKOCu390Tv7/AutTdHy6jc1S9tr+ HiYBV65A2GXaiCQGTplGvCwJPp046Wct9GCH1lVBslDURQrtUV37aNh2AQiYnKBD9EpFMCAJyQ3DYc t8BWHncCaLCqdMQbGAxMqtrFZL8V4wTiDOjvmaPl80pYfiGhfKc6zFfo1jA6MsNq2QsTJ0xHxDxcOe 5aeTybh5qn9XzIKTldcYRrwTyWSPliX1BcEgAXdZ7kPBgZ5TL/tMm4FHAla42Gx9eAmlUhq5l2Rywm mkd7Eicr2rtYAbx/AqyeNLX+5QNcER37lMFZrHk+dwhZk9ZbQXCwG5XDaz+F4LniPH28ukHwzWivOE QNw5WyxF4CIyxtkcTpC6wZmnYF79MNH+nbBiz+Qp3YcMWMLKPUOoBcJSZpsFbv/4URo2qp8E2bxyBT fLxR0LBgHi/C1MeLmNS6CG6GnIdxvDuxvL/VVeZkw3UEft5+Mt200NDh7pe5zUzgC+sv1T0ZGJme1s 5KSlJEvDoIbr06WxuinbYOQ5US408LjqlP8t6f6mWKKHn+zTxrXR26QFieVnvxbPk/ZKFrnt85E81X qNbsjHWXzKWgLfgeYJi3gBfLN9ZaTaEh76Y6lYmE0wHfEMn8jBViPysj2YtA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a warning to ensure RCU lock is held around tree lookup, and then
fix one of the invocations in bpf_stack_walker. The program has an
active stack frame and won't disappear. Use the opportunity to remove
unneeded invocation of is_bpf_text_address.

Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/core.c    |  5 ++++-
 kernel/bpf/helpers.c | 11 +++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2dc5b846ae50..833442661742 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -782,7 +782,10 @@ bool is_bpf_text_address(unsigned long addr)
 
 struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
 {
-	struct bpf_ksym *ksym = bpf_ksym_find(addr);
+	struct bpf_ksym *ksym;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	ksym = bpf_ksym_find(addr);
 
 	return ksym && ksym->prog ?
 	       container_of(ksym, struct bpf_prog_aux, ksym)->prog :
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 61fdd343d6f5..659b5d133f3e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2935,9 +2935,16 @@ static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 	struct bpf_throw_ctx *ctx = cookie;
 	struct bpf_prog *prog;
 
-	if (!is_bpf_text_address(ip))
-		return !ctx->cnt;
+	/*
+	 * The RCU read lock is held to safely traverse the latch tree, but we
+	 * don't need its protection when accessing the prog, since it has an
+	 * active stack frame on the current stack trace, and won't disappear.
+	 */
+	rcu_read_lock();
 	prog = bpf_prog_ksym_find(ip);
+	rcu_read_unlock();
+	if (!prog)
+		return !ctx->cnt;
 	ctx->cnt++;
 	if (bpf_is_subprog(prog))
 		return true;
-- 
2.47.1


