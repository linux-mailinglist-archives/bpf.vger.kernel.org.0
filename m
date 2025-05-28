Return-Path: <bpf+bounces-59101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72842AC605E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D8F17C935
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7543A21ABB0;
	Wed, 28 May 2025 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJhFYxel"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640D61EF38F;
	Wed, 28 May 2025 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404205; cv=none; b=iqjKu5PTrvWr7NNZu85UVcAL0StfhZNiAJdz9lLz0L3UeUJisoGIjRiu2x7sy5hJS8ZSzGXRJNOvJLwLvhZGifGG2SpHX3fFUfliT9Lnxw7R4Cevo/yFaknZZ6BeoZ/JHlongQNLzvB5WN3i/zWpvI7LLzMX4rp9zmDM6aZB9mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404205; c=relaxed/simple;
	bh=Zs3cP7UFli99gzff2jGHioUvnLhMgTpoIoM6EBMVvUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EWPTlc0wO0XGjXAeje5Xt83wLnf8GqdhLIOkz7HIWlwe8s0PKREK5iMf6VeREzhB+aSmvIQvDphPmSaKR2LqokB2t0G+l3R9MwnUgC/b5B2Xa17g/d5jHiGclIcYMKE6uC1cO+KnvmEQzPj9okBPXbmo9r9U0ecaov0lyF19Cf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJhFYxel; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b26c5fd40a9so359780a12.1;
        Tue, 27 May 2025 20:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404202; x=1749009002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTd0uBOUtnBte3BNrocZYUMCmEJy6MJODQUX7kabL/c=;
        b=BJhFYxelILflZwKebl6L1twkLIRAJ6Pw+hj6sqxIEn3sra/Y/vO3NKR/8wiDrPBZRb
         gwdpeOpLhyDKBLb5dm1G+yVla7+NM6ZuO/JJ6q1nSO1xi6wVgNvQCK81C/YsZX+7TsLu
         DLKduDLMmBbODpHdiEMxg765vkzJnAvMo1fO5tz7ItF8zAk3JoPXZKAD7ubF68+OdW/w
         H0G1wviIGxrN17O676sSMQNgeQzSvbjZ3/LHNB1S2qggxG8WNv335p3qSGhd5EhYLs4Y
         YeyvTm2t/YzU6hgya4t+vDvxVYvhZ94dWqXjJ+432aOncBXKnc3R3fT8/7ehy6LX0Beh
         TXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404202; x=1749009002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTd0uBOUtnBte3BNrocZYUMCmEJy6MJODQUX7kabL/c=;
        b=I/natiuMdcNSFge+UC35lAFsF18GNjHopTsmE6VTanfByj4rijFQFStQkSXDy85MCh
         wt/WC2jlwUOdD4IL7k3qsR1u6TihstvJnksYkBW9LjHQ9wMKRa8Svs6NpnSwSrsQKJQB
         kKCIWPkPjiQmeZSn+fbpW8bSAVkmqm9Kz4rPGGGzhZm2ENFZ9egKPWKshnqX8rKPbHTU
         HYwnzpc9WsTMi7HMtARFSF23WoOBFYQ0bV+vgd8ddn7aoyRmb2vF6eqvUhZJtwNlywlo
         2i1ridl+LURTPUX/YNxtd7fpN1Nh8TPT2uikV28ABZxnOc/eKt5gNpyA229nLDA1Sa0W
         CWXA==
X-Forwarded-Encrypted: i=1; AJvYcCUCqNgnkzgdF5j4OyBu6gV0qNipk4Xo99TRxadPdA7khtyMSFfT4AtuVoHwD1z0REnrOPdQkkzx8zEJOyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn6NMqTUeV5zro+9eilSv7OkbPfeIDGccRAJVbtnGN/TxSfmqA
	XRNUaTPpme36Hwwl/fyAmSc4zeTyR0RN544nN7cR+aZZyLqLsbsU7oIj
X-Gm-Gg: ASbGncs1eJ0OW8n1Hbub1Wsy4w/+abjA3+4P4A/6SOt61Ey9KtZLh9eOC1FgoZjDkFh
	WTeQnW0HsPVB5MLFMJNlWgD6Zq1mpSt3Q9zPxTC9nmf8fxZXUZGZZ7WRJkP/rbivfC0sskevfVi
	pc7W+2iy7Rd+SvPMi3sSxAzUdmqKjBnmHEXmpG1TUnmqEFK6VZjMZSiEw/leKNdzHkH12Errbo0
	/gbaPCzI+6NRfTRrmObI2cV7Oehk1mOWbJ+nVAyFp4G6ve1abIJ2qDmPGQEcJoli5xUdeXXtJOC
	77fvAHRdt2zvAQ0Y1d5tRHXdy6PSHO402+xiIHS36eMxGL6Gdp8MywHNLLZxCeH/WqhTku+wSfY
	4d+Y=
X-Google-Smtp-Source: AGHT+IGQDQDeKxLuC6waHd36AvNbYhvq1YmynrRV69vPb94pJiDcTkMsvXDljCzNwZn40vkbp6Bx9A==
X-Received: by 2002:a17:902:ea03:b0:234:adce:3eb8 with SMTP id d9443c01a7336-234b749ddf5mr48676305ad.12.1748404202391;
        Tue, 27 May 2025 20:50:02 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:50:02 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 12/25] bpf: verifier: move btf_id_deny to bpf_check_attach_target
Date: Wed, 28 May 2025 11:46:59 +0800
Message-Id: <20250528034712.138701-13-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the checking of btf_id_deny and noreturn_deny from
check_attach_btf_id() to bpf_check_attach_target(). Therefore, we can do
such checking during attaching for tracing multi-link in the later
patches.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/verifier.c | 125 ++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 60 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b3927db15254..5d2e70425c1d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23075,6 +23075,52 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
 }
 
+BTF_SET_START(btf_id_deny)
+BTF_ID_UNUSED
+#ifdef CONFIG_SMP
+BTF_ID(func, migrate_disable)
+BTF_ID(func, migrate_enable)
+#endif
+#if !defined CONFIG_PREEMPT_RCU && !defined CONFIG_TINY_RCU
+BTF_ID(func, rcu_read_unlock_strict)
+#endif
+#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
+BTF_ID(func, preempt_count_add)
+BTF_ID(func, preempt_count_sub)
+#endif
+#ifdef CONFIG_PREEMPT_RCU
+BTF_ID(func, __rcu_read_lock)
+BTF_ID(func, __rcu_read_unlock)
+#endif
+BTF_SET_END(btf_id_deny)
+
+/* fexit and fmod_ret can't be used to attach to __noreturn functions.
+ * Currently, we must manually list all __noreturn functions here. Once a more
+ * robust solution is implemented, this workaround can be removed.
+ */
+BTF_SET_START(noreturn_deny)
+#ifdef CONFIG_IA32_EMULATION
+BTF_ID(func, __ia32_sys_exit)
+BTF_ID(func, __ia32_sys_exit_group)
+#endif
+#ifdef CONFIG_KUNIT
+BTF_ID(func, __kunit_abort)
+BTF_ID(func, kunit_try_catch_throw)
+#endif
+#ifdef CONFIG_MODULES
+BTF_ID(func, __module_put_and_kthread_exit)
+#endif
+#ifdef CONFIG_X86_64
+BTF_ID(func, __x64_sys_exit)
+BTF_ID(func, __x64_sys_exit_group)
+#endif
+BTF_ID(func, do_exit)
+BTF_ID(func, do_group_exit)
+BTF_ID(func, kthread_complete_and_exit)
+BTF_ID(func, kthread_exit)
+BTF_ID(func, make_task_dead)
+BTF_SET_END(noreturn_deny)
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -23398,6 +23444,25 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 
 		break;
 	}
+
+	if (prog->type == BPF_PROG_TYPE_LSM) {
+		ret = bpf_lsm_verify_prog(log, prog);
+		if (ret < 0) {
+			module_put(mod);
+			return ret;
+		}
+	} else if (prog->type == BPF_PROG_TYPE_TRACING &&
+		   btf_id_set_contains(&btf_id_deny, btf_id)) {
+		module_put(mod);
+		return -EINVAL;
+	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
+		   btf_id_set_contains(&noreturn_deny, btf_id)) {
+		module_put(mod);
+		bpf_log(log, "Attaching fexit/fmod_ret to __noreturn functions is rejected.\n");
+		return -EINVAL;
+	}
+
 	tgt_info->tgt_addr = addr;
 	tgt_info->tgt_name = tname;
 	tgt_info->tgt_type = t;
@@ -23405,52 +23470,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	return 0;
 }
 
-BTF_SET_START(btf_id_deny)
-BTF_ID_UNUSED
-#ifdef CONFIG_SMP
-BTF_ID(func, migrate_disable)
-BTF_ID(func, migrate_enable)
-#endif
-#if !defined CONFIG_PREEMPT_RCU && !defined CONFIG_TINY_RCU
-BTF_ID(func, rcu_read_unlock_strict)
-#endif
-#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
-BTF_ID(func, preempt_count_add)
-BTF_ID(func, preempt_count_sub)
-#endif
-#ifdef CONFIG_PREEMPT_RCU
-BTF_ID(func, __rcu_read_lock)
-BTF_ID(func, __rcu_read_unlock)
-#endif
-BTF_SET_END(btf_id_deny)
-
-/* fexit and fmod_ret can't be used to attach to __noreturn functions.
- * Currently, we must manually list all __noreturn functions here. Once a more
- * robust solution is implemented, this workaround can be removed.
- */
-BTF_SET_START(noreturn_deny)
-#ifdef CONFIG_IA32_EMULATION
-BTF_ID(func, __ia32_sys_exit)
-BTF_ID(func, __ia32_sys_exit_group)
-#endif
-#ifdef CONFIG_KUNIT
-BTF_ID(func, __kunit_abort)
-BTF_ID(func, kunit_try_catch_throw)
-#endif
-#ifdef CONFIG_MODULES
-BTF_ID(func, __module_put_and_kthread_exit)
-#endif
-#ifdef CONFIG_X86_64
-BTF_ID(func, __x64_sys_exit)
-BTF_ID(func, __x64_sys_exit_group)
-#endif
-BTF_ID(func, do_exit)
-BTF_ID(func, do_group_exit)
-BTF_ID(func, kthread_complete_and_exit)
-BTF_ID(func, kthread_exit)
-BTF_ID(func, make_task_dead)
-BTF_SET_END(noreturn_deny)
-
 static bool can_be_sleepable(struct bpf_prog *prog)
 {
 	if (prog->type == BPF_PROG_TYPE_TRACING) {
@@ -23533,20 +23552,6 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		return bpf_iter_prog_supported(prog);
 	}
 
-	if (prog->type == BPF_PROG_TYPE_LSM) {
-		ret = bpf_lsm_verify_prog(&env->log, prog);
-		if (ret < 0)
-			return ret;
-	} else if (prog->type == BPF_PROG_TYPE_TRACING &&
-		   btf_id_set_contains(&btf_id_deny, btf_id)) {
-		return -EINVAL;
-	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
-		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
-		   btf_id_set_contains(&noreturn_deny, btf_id)) {
-		verbose(env, "Attaching fexit/fmod_ret to __noreturn functions is rejected.\n");
-		return -EINVAL;
-	}
-
 	key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
 	tr = bpf_trampoline_get(key, &tgt_info);
 	if (!tr)
-- 
2.39.5


