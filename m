Return-Path: <bpf+bounces-699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6CA705E48
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 05:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169C51C20B0E
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 03:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2515623D8;
	Wed, 17 May 2023 03:45:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74BA2100
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 03:45:27 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9920430E8;
	Tue, 16 May 2023 20:45:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae454844edso2995535ad.1;
        Tue, 16 May 2023 20:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684295126; x=1686887126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uMSZdlVzbxeM11qsVcr0sdcteuxEXHjRqP1IVvopNU=;
        b=NaiABcWCkvK2DCfRgsRBZ/BumHoPpPMfbt+vLGTc6mJZBbSsqJ0Qfs1mqA7kr8myUo
         s7kSI/PYlCeuqR4ZbKL9S1vhuAY+ZO32SdCRVFiTtC3/xKk1CUQDuNXIMAh3wyt3/G64
         rQWz6cmVHkWp9jnZhxAKMfX2GMLup8u+aKqErt2ZO3RuFuVlpDjKXH4tL2d1zxJYDeRP
         ECA8Kbi6BULm0yKVVaAKuR3xEaYyCpEWicvFRD1kFGuO1KsnamVYvfWDtne7SmUss8Bi
         uvPjR3V/VweHcFPDZkGddzvzmyH6a+8PLhXzZqGWD0Fq589AY6UlUaV1QRpGrKEEYisb
         4R5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684295126; x=1686887126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uMSZdlVzbxeM11qsVcr0sdcteuxEXHjRqP1IVvopNU=;
        b=J4BMx1ya4BmdmL60ryHoZmFvThJnrJXVEsA4vdF+wvjX71fsKpl64LeKeqnxFlOyVq
         QEUQOs0rJDItpbkNRvO+3x0+tWwkz/AQwIQDnRGtJ9ui79RLcyIG6vN20E7FiaN1sP7T
         5SrOkl+Zz7d6If6NC1Vbnc4kBMmQF27lwNUtHit1JJL187YnhZWUoKwF1Edz/yeos7P6
         myzJKHEae5nFuj9f7REe7tTz9POnjw031fjJjoj11L+O2oaAuetDEnWmy9jV4U8O8g6u
         ACC0fT7y76A52gcmAdI5MZCnQoRu5Cgcszo9AXpOxjkUOWURQ1QPXI4MsILLiSqPV7rn
         gfAg==
X-Gm-Message-State: AC+VfDyjoN6lbjda/o5PRHkG9YQOxIoPx17PieAjPcXwOqyS+OrOcx1u
	fVN1woXYoNTgCG1Q9EEA3kA=
X-Google-Smtp-Source: ACHHUZ4VwlgfLZwJWUKsSA1KMAjkQD96iP+U3wN3PhFLqe4E4WOUqEU/zeGOhl4OyE2MLWqyzdNQQQ==
X-Received: by 2002:a17:903:32c5:b0:1aa:e5cd:647a with SMTP id i5-20020a17090332c500b001aae5cd647amr54727835plr.23.1684295126019;
        Tue, 16 May 2023 20:45:26 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.googlemail.com with ESMTPSA id t2-20020a170902e84200b001a19196af48sm16336746plg.64.2023.05.16.20.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 20:45:25 -0700 (PDT)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	Ze Gao <zegao@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/4] rethook: use preempt_{disable, enable}_notrace in rethook_trampoline_handler
Date: Wed, 17 May 2023 11:45:06 +0800
Message-Id: <20230517034510.15639-2-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517034510.15639-1-zegao@tencent.com>
References: <20230517034510.15639-1-zegao@tencent.com>
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
Link: https://lore.kernel.org/linux-trace-kernel/20230516071830.8190-2-zegao@tencent.com
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


