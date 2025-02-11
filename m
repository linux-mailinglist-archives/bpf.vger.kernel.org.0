Return-Path: <bpf+bounces-51097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C38AA30186
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 03:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108B51660FE
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 02:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099CC43AA1;
	Tue, 11 Feb 2025 02:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5/ymU9N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389C26BD94
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 02:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739241258; cv=none; b=R1g/OAitzHguIXFNhceO206RoRodPYB+kHAb8tjLnOBDBop/TbQe1eKzJ2i2kVh5JcS//dW7967edwI6TKmgr/ZTZCalqt1HhjqATtG7hYyrK8yHmzPGPrp/tEKnH7MzUV+lwmNHvHoeMCKyRZLgJkOcHxSJmW3/AHM2iF30zss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739241258; c=relaxed/simple;
	bh=fjTm8Lkms7zjN+Hlww24jPFDWn0JPkfxj541FpDKhIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Re3TTUurleC/ALWWEJBuS5ZkqJH8AEsQurS3IfdHs0F1Wo4u2FEY19jXR7F8Cwmp391Rz9g2odKdzTTtxLL3bhZEFJ+z5Ksatg9hW/pRwv2ouwrIlTJxiohNSs7qHF/0AByLVSvEgt7BLN1Ey5G54TutSlYxBSuifaVybHBBA1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5/ymU9N; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f2339dcfdso79640975ad.1
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 18:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739241254; x=1739846054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDpFBTqQ/9RK4zP/64qABxou9YmF6/LNaiiq3GRHOF0=;
        b=m5/ymU9NjHpBOK3CpgpVm6sYBlYV136J4w3dGmEjp95YlR5Pd3csLigltUDPHZjvlr
         cfIo9FwRh6ixEV79glSAcJgLcu9hA3H9yIllsGvzl6vrUKFm3+12OyXazLc0urPCa85I
         Y6Y0dEBBo0e3JDDUN8Ea/etSFjL7aO3PPgXC6nT6Nft6M0x9tKygQdZvL1JXiBXxjqCN
         otmwJOR0U11+Vmyq85XxZmS/v31c9wNpMo7G+8WYA7D8qQ0XzoZ4grE7pDAJlJUlMmeR
         58+HqVo6sDi3xQRRiInjPBwujEe87FA+WsQwNrhkQNhjs6UBG+2/6AGPDfzF8oD9vsKd
         LKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739241254; x=1739846054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDpFBTqQ/9RK4zP/64qABxou9YmF6/LNaiiq3GRHOF0=;
        b=MRuJ5uGYcHbJOie7rXYD6wLv1N0Nz564rKE6L6f3oK1DrC0Oqdslw6gffhTXd0wDeL
         k3p0RSm61xqZSMTYcrpUFJmLpsZJsEINuNWBFalB4VLn1w44WP8A/+Oj/6MJI7MUbgrT
         DOiMFxRob0cSCX3R3j6G3ObPziirCOhN115acgNgiI1hLEMNsa9Ey71zo/W18dbA6yJE
         wBC73YYpt7YCxhCDEqLsNRiTM7+B3v8MW+7f4kD1+MUjIz1bH1JBYZF+gwk8/4EXQOzN
         R65T3JT3IrCCgGimsgYvs3iFXcVSuFBMmc/j/FTAvbucoY6G/75JQeMniEPaF2I1g7UI
         2oPQ==
X-Gm-Message-State: AOJu0YxfE0zx/7O3e18mokvTq27JwP9qI3DtDQHQzP5Y/9Zg5Vx1v1hv
	75vrjTuDT0cIgXHsLFHsazCpAq6NWBIryll2asrvl9sBHolFNjNf
X-Gm-Gg: ASbGnctV/naTgoxL7HTOS4cwZ/+Z0yG4dOpR60rvtwmN49lDufBqsaIVAInGiMrMoF9
	oLMRZzRQvRpDqTpJkO/3vb804NHubBIRkKTSlaUlpx3sGoGLdDPVOYXdm2GY3P0t/6Af9naMOB7
	3o53lYgK/aQFHP/AorQK0tGBVv+YdgZjJW2OK1IJo2zGX3paUwTCSVagWkKruqg4z2o7iSa/Syp
	9Zek1vVRHfOIgG2bhEqKBP+1sQrLjhiyYx7mnfFBE/M/uGRfEF0XPGq8YfKCD9hPU4QjVevVSzI
	vWqnMXD9bEfTFwV8bKXOkDHox/d0KNm93co7LT4=
X-Google-Smtp-Source: AGHT+IFVClfF+Qza3toZh/zL/MSyfhaiSQ6Dhq9r0R8iluHUMyYZka/2GJdIF1pO+Xrw+0ri4eU/1w==
X-Received: by 2002:a17:902:eccb:b0:215:b1e3:c051 with SMTP id d9443c01a7336-21fb6efda44mr24358095ad.11.1739241253887;
        Mon, 10 Feb 2025 18:34:13 -0800 (PST)
Received: from localhost.localdomain ([58.37.132.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f8dc43971sm30916315ad.66.2025.02.10.18.34.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Feb 2025 18:34:13 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 1/3] objtool: Move noreturns.h to a common location
Date: Tue, 11 Feb 2025 10:33:57 +0800
Message-Id: <20250211023359.1570-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250211023359.1570-1-laoar.shao@gmail.com>
References: <20250211023359.1570-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It will used by bpf to reject attaching fexit prog to functions
annotated with __noreturn.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 {tools/objtool => include/linux}/noreturns.h |  0
 tools/include/linux/noreturns.h              | 52 ++++++++++++++++++++
 tools/objtool/Documentation/objtool.txt      |  3 +-
 tools/objtool/check.c                        |  2 +-
 4 files changed, 55 insertions(+), 2 deletions(-)
 rename {tools/objtool => include/linux}/noreturns.h (100%)
 create mode 100644 tools/include/linux/noreturns.h

diff --git a/tools/objtool/noreturns.h b/include/linux/noreturns.h
similarity index 100%
rename from tools/objtool/noreturns.h
rename to include/linux/noreturns.h
diff --git a/tools/include/linux/noreturns.h b/tools/include/linux/noreturns.h
new file mode 100644
index 000000000000..b2174894f9f7
--- /dev/null
+++ b/tools/include/linux/noreturns.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This is a (sorted!) list of all known __noreturn functions in the kernel.
+ * It's needed for objtool to properly reverse-engineer the control flow graph.
+ *
+ * Yes, this is unfortunate.  A better solution is in the works.
+ */
+NORETURN(__fortify_panic)
+NORETURN(__ia32_sys_exit)
+NORETURN(__ia32_sys_exit_group)
+NORETURN(__kunit_abort)
+NORETURN(__module_put_and_kthread_exit)
+NORETURN(__stack_chk_fail)
+NORETURN(__tdx_hypercall_failed)
+NORETURN(__ubsan_handle_builtin_unreachable)
+NORETURN(__x64_sys_exit)
+NORETURN(__x64_sys_exit_group)
+NORETURN(arch_cpu_idle_dead)
+NORETURN(bch2_trans_in_restart_error)
+NORETURN(bch2_trans_restart_error)
+NORETURN(bch2_trans_unlocked_error)
+NORETURN(cpu_bringup_and_idle)
+NORETURN(cpu_startup_entry)
+NORETURN(do_exit)
+NORETURN(do_group_exit)
+NORETURN(do_task_dead)
+NORETURN(ex_handler_msr_mce)
+NORETURN(hlt_play_dead)
+NORETURN(hv_ghcb_terminate)
+NORETURN(kthread_complete_and_exit)
+NORETURN(kthread_exit)
+NORETURN(kunit_try_catch_throw)
+NORETURN(machine_real_restart)
+NORETURN(make_task_dead)
+NORETURN(mpt_halt_firmware)
+NORETURN(nmi_panic_self_stop)
+NORETURN(panic)
+NORETURN(panic_smp_self_stop)
+NORETURN(rest_init)
+NORETURN(rewind_stack_and_make_dead)
+NORETURN(rust_begin_unwind)
+NORETURN(rust_helper_BUG)
+NORETURN(sev_es_terminate)
+NORETURN(snp_abort)
+NORETURN(start_kernel)
+NORETURN(stop_this_cpu)
+NORETURN(usercopy_abort)
+NORETURN(x86_64_start_kernel)
+NORETURN(x86_64_start_reservations)
+NORETURN(xen_cpu_bringup_again)
+NORETURN(xen_start_kernel)
diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 7c3ee959b63c..726db5b2b1a5 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -326,7 +326,8 @@ the objtool maintainers.
 
    The call from foo() to bar() doesn't return, but bar() is missing the
    __noreturn annotation.  NOTE: In addition to annotating the function
-   with __noreturn, please also add it to tools/objtool/noreturns.h.
+   with __noreturn, please also add it to tools/include/linux/noreturns.h and
+   include/linux/noreturns.h.
 
 4. file.o: warning: objtool: func(): can't find starting instruction
    or
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 753dbc4f8198..2940ddc56b1a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -250,7 +250,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 
 #define NORETURN(func) __stringify(func),
 	static const char * const global_noreturns[] = {
-#include "noreturns.h"
+#include <linux/noreturns.h>
 	};
 #undef NORETURN
 
-- 
2.43.5


