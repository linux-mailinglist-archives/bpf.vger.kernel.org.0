Return-Path: <bpf+bounces-608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA2370462F
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 09:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDD51C20D7F
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 07:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789151D2D0;
	Tue, 16 May 2023 07:19:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BB423D6
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 07:19:43 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85254C0A;
	Tue, 16 May 2023 00:19:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso7937981b3a.1;
        Tue, 16 May 2023 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684221576; x=1686813576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6U/vkmAUFZZcdBk+KokFbNf1ZvkKNw6bCUwh7L5Br9E=;
        b=MFxu44NHbkQCaNnciSPrfna7rqyLC2dxpiPT8iIxN4YMSmvNT5WNxmBHJuu8yUW1J5
         EynI7VMJwAZLG3DgUCgj7G+xrxpokr5IS3ZRrGAJGBkw+eW2iHCYr1OVfGHC2+2dVCeC
         7t2aGksNm18G+S2p1Kymzqk15eMpkxaiyb0tE34Y+/zfabMobsqav4iB5A1iXlLrKhDK
         lEZMaL3xbrp8jePUEgNVtpLBTg/oRqWZojM+xWwnnz4TUFn3Lq/fkYXul2S9MFpzPdEN
         BPO4ZOcnazHWeen45gEA8Cdk2tUC2dGTEKbnZkzL+XRjjJnaFOo+R/RMKJjlV4ho0L/6
         Nv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684221576; x=1686813576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6U/vkmAUFZZcdBk+KokFbNf1ZvkKNw6bCUwh7L5Br9E=;
        b=HyIsLtuvUWgtq0+8nHvr71xltk9UpBFwBbCg+KcEMKFMJ+6VmJumYW4ambOnlwOWUm
         86PljMJjXM5ispv66pdSn9ASMpd+6RtU2K86Cu68HmAOUxQj5FYRdx4TOOTVTGnUbCvM
         yMiu3Z+V1vIAfI813iLFqiKI+K9UjzFbgnlVZpImIhX3R9FIC7Ebd8K/4IC+o3KQJQds
         jnPRHBFu6ZyNOVt/bInLA6Hps+mFWMfkD/P3tcFf0jit0jhJzLY4MFqNxm9ghZB2ZyGE
         B5y0vhu5+fhihcRDTB251fsyzpcKFD3t3iw8aF59LYdOWQSUBC1EkP74jp3ecYPZIa9P
         UcVQ==
X-Gm-Message-State: AC+VfDxwi9529cQCRBqw6WEeJSNFidVBigeAd7OdkRu+A0g9XfTBmPeb
	tAmyE2GSGzjZ8rvjviIELqI=
X-Google-Smtp-Source: ACHHUZ4nXjQYnByDI6oida9jX5iVkTZZXuNHP++wV9HBdBJ3e54nyEcPN/xLIHFq7HmESmFZpkuHGw==
X-Received: by 2002:aa7:88c8:0:b0:64a:2dd6:4f18 with SMTP id k8-20020aa788c8000000b0064a2dd64f18mr23142160pff.13.1684221575773;
        Tue, 16 May 2023 00:19:35 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.15])
        by smtp.googlemail.com with ESMTPSA id 17-20020aa79251000000b006468222af91sm12849830pfp.48.2023.05.16.00.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:19:35 -0700 (PDT)
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
	Ze Gao <zegao@tencent.com>
Subject: [PATCH v2 4/4] rehook, fprobe: do not trace rethook related functions
Date: Tue, 16 May 2023 15:18:30 +0800
Message-Id: <20230516071830.8190-5-zegao@tencent.com>
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

These functions are already marked as NOKPROBE to prevent recursion and
we have the same reason to blacklist them if rethook is used with fprobe,
since they are beyond the recursion-free region ftrace can guard.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 arch/riscv/kernel/probes/Makefile | 2 ++
 arch/s390/kernel/Makefile         | 1 +
 arch/x86/kernel/Makefile          | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
index c40139e9ca47..8265ff497977 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -4,3 +4,5 @@ obj-$(CONFIG_RETHOOK)		+= rethook.o rethook_trampoline.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_rethook.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_rethook_trampoline.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 8983837b3565..6b2a051e1f8a 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -10,6 +10,7 @@ CFLAGS_REMOVE_ftrace.o		= $(CC_FLAGS_FTRACE)
 
 # Do not trace early setup code
 CFLAGS_REMOVE_early.o		= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_rethook.o		= $(CC_FLAGS_FTRACE)
 
 endif
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index dd61752f4c96..4070a01c11b7 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -17,6 +17,7 @@ CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
+CFLAGS_REMOVE_rethook.o = -pg
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
-- 
2.40.1


