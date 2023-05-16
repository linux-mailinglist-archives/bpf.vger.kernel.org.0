Return-Path: <bpf+bounces-605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5DA704627
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 09:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0651C208E5
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 07:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159DB1D2CA;
	Tue, 16 May 2023 07:19:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB623D6
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 07:19:04 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1421F10D7;
	Tue, 16 May 2023 00:19:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64389a44895so10880056b3a.1;
        Tue, 16 May 2023 00:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684221541; x=1686813541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Od08TnngvcBflncwckirl6kWgx6glKrr7yMRy+3aZSY=;
        b=CAJyKRIESx3DfkZiuoGMR4C2xu1LepvOjbj6Zf2LgOQd1bzGTAjhH4yPeI3lg7tDaH
         w0yUUTLG1/8KEf/itsWApFOTAJ1oU7cARMd5yqayzEAi2Vkwyo3yYlUMRBcv5y0xIw7Q
         hhWKGL62YQI23mtOfagnADtYQEzNXSLjoNn3X1v31IVS1Iy4f63BBSTK9iaopbhcJvjn
         OniRvKfVVXe1LcYkBrXdP9fjYD3IgAW8igRwMTFSKHeGCpz1zahdxk9mnkIJqi5ZDd5i
         iCErNFvyRYDpVPPKSgHXQ1VJpZp3BkG35TDTLQyzUYbYE/MKcj27OAPYONJ5FxnOe70T
         MTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684221541; x=1686813541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Od08TnngvcBflncwckirl6kWgx6glKrr7yMRy+3aZSY=;
        b=HyHhHRd9CjdbCgNXa7njBBN7zmTmjSLxYMIGuvapiox9pfz5FiD3u5dDJ7GW+lCohi
         n1L1AKL8wXv3w7dYyXh+Y/aRsRlE5qg36Py0Dv68TzXYGDBn67dDVv3raof6uVcfL4Lg
         6M9ZqjEpBc8T2EhNMRJ/oRMvbAZV9G06anRvA4fgNpqxMywF7jK/dCWG6PdZzZrghGDR
         KV+ZDYhqU8arMdEIpx5VbKqnOrlup/ILOLsb/EdLDb6D8INYYbULeB6VAv3NdbcUEuQN
         ikj3Ex9mL1LFnMqYRx1sutLOla+p6z/MOQGY0X9YEXbWoGCKD2nRGSoh08OuJjf9HO1o
         s1RA==
X-Gm-Message-State: AC+VfDzEIsU7wJEUA8FGYZe+4eOKahWR2YdNhpZAosefKkEiLkWbczy1
	VYlYXhN7fqoh5jhGMencWNE=
X-Google-Smtp-Source: ACHHUZ5AkOuj7oHM//GSH6XREd6vp5E5lGilnWXlY/BIudf1XEHGTKjV4eeZLBZZGIOSbXLwRuYEyA==
X-Received: by 2002:a05:6a00:10d3:b0:641:3ca2:1aec with SMTP id d19-20020a056a0010d300b006413ca21aecmr47315732pfu.27.1684221541531;
        Tue, 16 May 2023 00:19:01 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.15])
        by smtp.googlemail.com with ESMTPSA id 17-20020aa79251000000b006468222af91sm12849830pfp.48.2023.05.16.00.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:19:01 -0700 (PDT)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	Ze Gao <zegao@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] rethook: use preempt_{disable, enable}_notrace in rethook_trampoline_handler
Date: Tue, 16 May 2023 15:18:27 +0800
Message-Id: <20230516071830.8190-2-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516071830.8190-1-zegao@tencent.com>
References: <20230516071830.8190-1-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch replaces preempt_{disable, enable} with its corresponding
notrace version in rethook_trampoline_handler so no worries about stack
recursion or overflow introduced by preempt_count_{add, sub} under
fprobe + rethook context.

Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
Signed-off-by: Ze Gao <zegao@tencent.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: <stable@vger.kernel.org>
---
 kernel/trace/rethook.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 32c3dfdb4d6a..60f6cb2b486b 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -288,7 +288,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 	 * These loops must be protected from rethook_free_rcu() because those
 	 * are accessing 'rhn->rethook'.
 	 */
-	preempt_disable();
+	preempt_disable_notrace();
 
 	/*
 	 * Run the handler on the shadow stack. Do not unlink the list here because
@@ -321,7 +321,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 		first = first->next;
 		rethook_recycle(rhn);
 	}
-	preempt_enable();
+	preempt_enable_notrace();
 
 	return correct_ret_addr;
 }
-- 
2.40.1


