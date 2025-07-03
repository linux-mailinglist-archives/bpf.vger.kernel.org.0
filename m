Return-Path: <bpf+bounces-62264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2F6AF73B9
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25C4A7B5FA1
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEC62EAB98;
	Thu,  3 Jul 2025 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WljxVFVO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D962EA758;
	Thu,  3 Jul 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545064; cv=none; b=l8ILzXuVb9fkos+xTlv+u4ZDGL88RjWVjkjunf2OSJEe0tJd2T6UNmO/Ww0KmiD3XfsdVQzCIqQ8ZSuJnoogTi2GCO9aEdoUyiyIyPloGXis39AKC04pcI6v0HFGsPdZ1pGaajDZtmRiL0e4ZkQPgArzIwrgF9mQQNZl2cZMg9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545064; c=relaxed/simple;
	bh=jxmQMYMo/g8j9c3m8/zYT3iwQ1cFh+0i13oC0PDn6tI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KZnDm4ZvOlYXliyIftIcQEOtmj0ZSGsnJH/tkH3aqRFMeHqeQw6rCAFLWuA0jPNjbSDoX7GjyoislNwp015HovUkV9ootaaOK5Apxr/wh7hIqRTznP8XObl5irSuYmvnQhZFXLsvhM7bYjn6N7vsA/x/Wmm5sdznPaisHO+zah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WljxVFVO; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-748e63d4b05so3582147b3a.2;
        Thu, 03 Jul 2025 05:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545062; x=1752149862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mheM0L5EqXLP+X642z1gm3rwVe94tlJM79DUk5IyCfo=;
        b=WljxVFVObSftaIvIF/QrkgovMJXpQBALKQx2N2jyHzU8iGeNikTv/WIz1fVr5HIPT0
         9H9kxJcfMIQLpQUu1vylgUq1I1RqvZwURyJb3PSpEbBkBs3dYYrfY7OWgv/04nz9EItF
         nUF2FGxSY42LPiA44PXh1iy3Cq8dzHjpzEZdBgZiLhDqaYiNknR4NdIANCkwbvcUJZJ1
         ehXa5286W6CifNEYPXcbQsmCJiTRohoEYaL7BWyj/3STQ7mBWlPA72eL5VITghz3Xrns
         vt5bR23OjsYxrtLjTfrBL4pmZC73WAbdVnYs2EM6xj7HhMSelKmF56HuJbcMESHgN1gH
         bTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545062; x=1752149862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mheM0L5EqXLP+X642z1gm3rwVe94tlJM79DUk5IyCfo=;
        b=efZWSHvhWE5FBcfM4z51BMaFkNBWxJTnOJvC7Vtu+qu2feFXV+RHlkaHg2CLuU1iin
         lb+mVXqBOVIaRZ5OWSl4m+WLJYHEEQOc3iA8p2q5TQUZ9ItBp46SRo4yahw8/jbXbzAw
         u+5Pb35YeuHvlLXNn0VbQVXmWdicWR2oRiSioeiyOevfNL2jcqWvsCc0dpzQSD5WmKIL
         g264B/IKoEYBO8Iu7Tn36wcDJbrWM6Xf2nAu/cjnJD8cMu/gmpGKkY77XvzthoYxfioZ
         HrMpJvwoM5JPEtbdfn9wcKj3oBQG3jTN9vMLEKjl0QrYTXFLV4uuYFJgcxfZqWqG3Aum
         9Rog==
X-Forwarded-Encrypted: i=1; AJvYcCWAmApNfr7otSFsJmQ5W9FMGR3gv5HzWONXLV9UDqcAFqK+k9pBC2qbrmFIWkYNfI2RtObjH8D6iJEv0kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQHJyHLwg2QqgPBR0LSbDGaq+av3dV55vqIKCF/VE4dJwHH3zf
	rKTRALm0GwbQprlaeWCPTqa+dZnu0jRF0GCuIzvftEzt9Oo4fmeE0S8Q
X-Gm-Gg: ASbGncss/Hcq1BBjkFMPvL0WQVe2bb55LB3iIgLk64/hVyo2W3yPLddUH1TsoNuJRf8
	MKqDodAPEI40EWigm+dO0/eBG2nTD0RO9N8N5MgfTFVg0EmHCqVe15ldSLqpICb+QhB5cV85uxA
	ccjMorfcBomc68cQ810O4Zf/G0qS1iLL9aj304qO4seC5lcNrkZDl5fnwvZVunJ6J2NDQoZoyKs
	jbx78AfVWzU+eBz/MUHaIqR6xTFlRqPl24r03vs7aW/9dfH4PUVnN+bsOCO9AofBL9gvQyBJnGR
	BoJHLcDhAUGOsUgOgrc89dOs1SWjLDKUnN4hbHTAW6ifaWgsgcaM58RILp9fh/P+k0MM1aNdexH
	aDcg=
X-Google-Smtp-Source: AGHT+IF4++fkMfJVjcYVYeaFsdsWRBD+ukE3CyKZEWkV3PMmDeeYoFVTBSyfMptMHZapLNGsCKDb5A==
X-Received: by 2002:a05:6a00:1a8e:b0:740:afda:a742 with SMTP id d2e1a72fcca58-74b50da219amr9455538b3a.0.1751545061663;
        Thu, 03 Jul 2025 05:17:41 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:17:41 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 09/18] bpf: verifier: move btf_id_deny to bpf_check_attach_target
Date: Thu,  3 Jul 2025 20:15:12 +0800
Message-Id: <20250703121521.1874196-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
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
index 8e5c4280745f..d6311be5a63a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23448,6 +23448,52 @@ static int check_non_sleepable_error_inject(u32 btf_id)
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
@@ -23771,6 +23817,25 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 
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
@@ -23778,52 +23843,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
@@ -23906,20 +23925,6 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
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


