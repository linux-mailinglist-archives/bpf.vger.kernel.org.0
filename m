Return-Path: <bpf+bounces-52264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C12A40CF6
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 07:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4F23BC2F6
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 06:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397D1DC9AF;
	Sun, 23 Feb 2025 06:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se1m/x1u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A853213C81B;
	Sun, 23 Feb 2025 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740292080; cv=none; b=hpQA/LyQP3xJHNEULVWMPdaCA/tqMX+TlspLfC4p7+PB+xzVASUFmqX+vzKXQrgIvGo5NTYtJ9Wr4KK0xkckTE26Cii2VVW1B6U1NAWZZKJk+3NBwQgnEuY3DMbeQmLZf2brnroYUQdQt46w3c45OV9cSfbqns9/7RxDmVJaKVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740292080; c=relaxed/simple;
	bh=mfKnlYQ6h+CAGEvlf3+X0qv7vJYe8FoqOuLp2ezsbNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fewZ0rsnf2O9Zm+2WuNAp4gaumZd0XYoIovOlJ1Bmm7EJxEW/2m21bLfR8GpMDSQLx//VnQx5H4I9wYyigwTbs3s/Gi/xl1gcyvw641Z/8iaQvGBoXdqPwn26/tRw66QS8uS27wEitN6Nq8qOQUFSe3/t1rkYhaPh97gn7xqscg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Se1m/x1u; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220d39a5627so51325525ad.1;
        Sat, 22 Feb 2025 22:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740292078; x=1740896878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtD7K/ok3N2f0SQcigiS/DoIRtdegc5aEVvlfFavEeg=;
        b=Se1m/x1uJEhmVgXoIM8EFLrgtV2LnZBt9seuZ5kcksErr3Jf82zp9MXcUACrkqKd3+
         kZBjw3OaINmO3omrgFl5LGH7JWHFjHix4OG65PnETlShs/FPAosO9lbm7vJmc08vZ2UR
         RCsA9cEaVlzzA2TjiK/l2mMUXGWjW3rZAOaxvgc66FgpqCGkx0GfGD8KYn7OeuN1f9VH
         a7oXRDmB/I1R9b5PGoj4Qv6nh0hvKqiVV+t2vYUAxe+2RCEw2wmcwllzVPhF1Qj4ZQLS
         RrESwvdMuqbTe3Spw5Wl+sbEOa6PP/gF8zwTH/XUGtUggR4ZIhLL8zB9lJYjpYFglaJR
         pg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740292078; x=1740896878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtD7K/ok3N2f0SQcigiS/DoIRtdegc5aEVvlfFavEeg=;
        b=NMkAhlXRmC6StoN8mPKLdcyeihbVfrNnnjcBolryGlvdxKBRhweIoa/145tuJCbKWT
         vgteTREly52dniWwvNiUBcWZjuAh03OzH/f/1jwXXJKnOmk2anAL8jc/3AilykU/YTcU
         R/V6z68BIMSUkSKmvHx2BjECBXUcs2ZuC6j9Dlvih2R8tLF/VfxMZRK7FD6y7/Jdkihk
         e4/7BXQHNoBt2Oex3mHhJcDnB2tAv3eWssUXvLuWhvQE5G85DyRdOGQ8Wi1dm1Ir97uf
         K5z2ncg2+9Ei3OxTrEDspfaMmhtIybE4kcgOTSKo9Hx4fJCyGfIBGtZ6/EmbARShayvz
         HJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1u8p8RTr2SdQ53+nxX771UH/T1q0n8q6u8CoBm+jij54BjmQQzPMCHdVHHI2Asp7Y8KLxzw+LALz1OGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoBitFkEeOrYkXM/yH6vAtPuw8+cNeKUry2WNeKYOFHZ9zXL7z
	3h2I8QmMw6eCcemzT29U8bxeYg3E2LvtIdcPolMj++Dx66pBJlCbahwWLzVJ+6g=
X-Gm-Gg: ASbGncs7mvCNa4gnph2o1Sk+iReLGFExkBtH6SO+Xwq2L9KOhNMqEq56OLnjMIYTPBu
	pJ0Gl25loIgr+lzYL8nH7rw1Sa6w1Fk3PgVdzBEnimnxOwA87h6cqajwqkV/KDo+tHH8hfexw6S
	hwu3rv+rC6vPFysUNXyhHrRvYHbkxoWj4PIi+kLyrSpSMwe/3yqKlfkscR23KBofpqLrvMqaJQa
	OeKGcsT+YIK5bkeEAhmktuNZxJWXMWislMVxXEfLYgs21Q6lA2xrADSJ+PzV0iVrLo2ecDik8W1
	shHU3FIzjipi5IvSxeS8Rge1STnjjtHT9phoDDXjFRH2VVVV6L8=
X-Google-Smtp-Source: AGHT+IEdj074QAlc4Pw1jVN7n1yq03rDf0CORBHg6vJxQmqbmoQJnRBESmH/HgioTDRKk2b4/AZFRQ==
X-Received: by 2002:a05:6a20:c891:b0:1ee:db10:a4e1 with SMTP id adf61e73a8af0-1eef3c56738mr14443340637.9.1740292077801;
        Sat, 22 Feb 2025 22:27:57 -0800 (PST)
Received: from localhost.localdomain ([39.144.244.105])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732521b82b3sm16693128b3a.92.2025.02.22.22.27.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Feb 2025 22:27:57 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 1/3] objtool: Copy noreturns.h to include/linux
Date: Sun, 23 Feb 2025 14:27:33 +0800
Message-Id: <20250223062735.3341-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250223062735.3341-1-laoar.shao@gmail.com>
References: <20250223062735.3341-1-laoar.shao@gmail.com>
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
---
 include/linux/noreturns.h               | 52 +++++++++++++++++++++++++
 tools/objtool/Documentation/objtool.txt |  3 +-
 tools/objtool/sync-check.sh             |  2 +
 3 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/noreturns.h

diff --git a/include/linux/noreturns.h b/include/linux/noreturns.h
new file mode 100644
index 000000000000..b2174894f9f7
--- /dev/null
+++ b/include/linux/noreturns.h
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
index 7c3ee959b63c..70a878e4dc36 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -326,7 +326,8 @@ the objtool maintainers.
 
    The call from foo() to bar() doesn't return, but bar() is missing the
    __noreturn annotation.  NOTE: In addition to annotating the function
-   with __noreturn, please also add it to tools/objtool/noreturns.h.
+   with __noreturn, please also add it to tools/objtool/noreturns.h and
+   include/linux/noreturns.h.
 
 4. file.o: warning: objtool: func(): can't find starting instruction
    or
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 81d120d05442..23b9813cd5e9 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -17,6 +17,7 @@ arch/x86/include/asm/emulate_prefix.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
 include/linux/static_call_types.h
+tools/objtool/noreturns.h
 "
 
 SYNC_CHECK_FILES='
@@ -24,6 +25,7 @@ arch/x86/include/asm/inat.h
 arch/x86/include/asm/insn.h
 arch/x86/lib/inat.c
 arch/x86/lib/insn.c
+include/linux/noreturns.h
 '
 fi
 
-- 
2.43.5


