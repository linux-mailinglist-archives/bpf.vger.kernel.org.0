Return-Path: <bpf+bounces-54190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B119A64E78
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 13:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7AD3AD62F
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 12:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1324238154;
	Mon, 17 Mar 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ8udo2j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2C23370B
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213882; cv=none; b=Fn4cq3oPvNRdtFaJxxXBeZ1YMuu5m+bYJYLCGxrjqTBeGVeMsyC1AwhEE+dE9Z5RAaC6i5SYGG1mjasc96vyg/41/t4JYoccdqhxnj8wDu3Y1BaCvxeOAqaEZ4nSv/GJorpzG/gsUQ7SEfJlNgHmjMLkq8hfSiJABA+0ShMg9t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213882; c=relaxed/simple;
	bh=8ZSVt+M8o6J3sLjXmvflzshxtFPLTAeGcs/zNxpwn4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P+T6wROG9P+BAlEKI6rkGPfnlwEUVMCWc+/21ZOYHAZM3F1EklgyJuafmAiZ1oTySZDWVPR1mUzi9s7j0oEzxcg70mceHQdLJodCUKZwzqLBsLuuLiKXjn+I3tXYsj++Nxt5PSoGDsOoI+7Pu8RseZa32Aot7C23roLAoFl0k1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQ8udo2j; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22580c9ee0aso71457975ad.2
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 05:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742213880; x=1742818680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEAO1TJTX9Z3NWdKJoyVf1OFcqzwtV9wJRjFzJHp4Rk=;
        b=nQ8udo2jgvmGo2bJrgNAc5ZwQAgTNxQCxzeQF2B+JX9AJY8vPPXPzLdyFECGObekRp
         x4Ihk3t2BTAZuLLWMxxLr/I/MLRkXg7BJvOqjBZVUBpzNTQPSPNmA+JaAzQs8HYO0njY
         qHz8D41AGL7FShl/3xz+OZDnGzeOq7RIVCVKXZyry8waI21vU5EJlxaIX7bf9N8ll/Pp
         pppBHechjED1KvjeAqyoF4MfPY7xHQXELSHA0TCiN9f/l3jIc0ZD8tOy0z2Y2aENGSvv
         tbWPjlIFciiFK5I29sRRthzYvGz9bRBS8/ode5P6bHdifoBci87ga4md0uG7yFNcaj10
         EEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742213880; x=1742818680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEAO1TJTX9Z3NWdKJoyVf1OFcqzwtV9wJRjFzJHp4Rk=;
        b=YaZp+9dqhF8sz2nawdVgMwRwJ33Z6k+xw+ZOXyY/DadpVbBoDYPlUCrSwwj76JO6M7
         y3tzf/RCwbB1nUfdhUSjHRidOPM5RWH7OfyhZSRyHdhElY75wCOLA1NT8VWiPQ5mRffA
         10t5u/5UXBUpbG+MdLfr/l87amywknzS1f+fGtTsZKIrnj8mnoSfuAX7tBBMzgh7jE0L
         w6RF7XX0dDbn6oqwpTpt52mXTapzOc3bu/7JwXETpQAzp5Ljdh3WZVU9L6XsGzCJt/HF
         cuzAJ3C3K40ytljI7l+euhXV0BF9efeJHwhhghrXXMxk0X+72xfpIRgUylotOVn1hSgb
         CpSQ==
X-Gm-Message-State: AOJu0Yzy1La0Gz4cQGesbAThnMhIP0iuiexpMCfJMMfK5dqZDytHYaII
	udRmWJUZnEHeeGkHBLELVUf5DZY/YqXGYZJiMpk8NKEqtHu6kGic
X-Gm-Gg: ASbGncu5OIAWvOS9MVLaBixkbKkqpmCDJWcQYyehgC39JSfgrhPFfSSuunWdVxTVa1f
	3wrtbMSo9HswwL85uP/FCpHnUvhxpzuL+6xZnCeA7zB8KzgCftBq5OLVPCMR2PpemuyuBoa6XuI
	iLd+F54lQV4pzg/8Dp70Go9eaQI9WuUza+BghC/2M47/GnC8ANPyNCZ1lAOhZRCa/91EWGJxRgI
	+VoZToK+wkHcralXRGx5AcjBWVZt3C2uO31Upg7uizIZHBhG1AuJXSL3jMECIKNwCaFVDujCBX+
	qW2IENqshcaiVChk2i1zf+2xpEp3P6id500DSFiA30ah5n06XgAGPMHVUEcJbgmoJ1+k
X-Google-Smtp-Source: AGHT+IG/imYLegl3W+UhQ6UZvcWBC7LsBgpICtdom4pxPWsoqIPP1aLFIRSkpQgDJKiL2c+kDdhlTA==
X-Received: by 2002:a17:903:2445:b0:223:47b4:aaf8 with SMTP id d9443c01a7336-225e0b29932mr140885405ad.52.1742213879914;
        Mon, 17 Mar 2025 05:17:59 -0700 (PDT)
Received: from localhost.localdomain ([61.173.25.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe7c1sm73445555ad.187.2025.03.17.05.17.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Mar 2025 05:17:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v4] bpf: Reject attaching fexit/fmod_ret to __noreturn functions
Date: Mon, 17 Mar 2025 20:17:34 +0800
Message-Id: <20250317121735.86515-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250317121735.86515-1-laoar.shao@gmail.com>
References: <20250317121735.86515-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we attach fexit/fmod_ret to __noreturn functions, it will cause an
issue that the bpf trampoline image will be left over even if the bpf
link has been destroyed. Take attaching do_exit() with fexit for example.
The fexit works as follows,

  bpf_trampoline
  + __bpf_tramp_enter
    + percpu_ref_get(&tr->pcref);

  + call do_exit()

  + __bpf_tramp_exit
    + percpu_ref_put(&tr->pcref);

Since do_exit() never returns, the refcnt of the trampoline image is
never decremented, preventing it from being freed. That can be verified
with as follows,

  $ bpftool link show                                   <<<< nothing output
  $ grep "bpf_trampoline_[0-9]" /proc/kallsyms
  ffffffffc04cb000 t bpf_trampoline_6442526459    [bpf] <<<< leftover

In this patch, all functions annotated with __noreturn are rejected, except
for the following cases:
- Functions that result in a system reboot, such as panic,
  machine_real_restart and rust_begin_unwind
- Functions that are never executed by tasks, such as rest_init and
  cpu_startup_entry
- Functions implemented in assembly, such as rewind_stack_and_make_dead and
  xen_cpu_bringup_again, lack an associated BTF ID.

With this change, attaching fexit probes to functions like do_exit() will
be rejected.

$ ./fexit
libbpf: prog 'fexit': BPF program load failed: -EINVAL
libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
Attaching fexit/fmod_ret to __noreturn functions is rejected.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/verifier.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..b7d7d5c4989f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22841,6 +22841,49 @@ BTF_ID(func, __rcu_read_unlock)
 #endif
 BTF_SET_END(btf_id_deny)
 
+/* fexit and fmod_ret can't be used to attach to __noreturn functions.
+ * Currently, we must manually list all __noreturn functions here. Once a more
+ * robust solution is implemented, this workaround can be removed.
+ */
+BTF_SET_START(noreturn_deny)
+#define NORETURN(fn) BTF_ID(func, fn)
+#ifdef CONFIG_IA32_EMULATION
+NORETURN(__ia32_sys_exit)
+NORETURN(__ia32_sys_exit_group)
+#endif
+#ifdef CONFIG_KUNIT
+NORETURN(__kunit_abort)
+NORETURN(kunit_try_catch_throw)
+#endif
+#ifdef CONFIG_MODULES
+NORETURN(__module_put_and_kthread_exit)
+#endif
+#ifdef CONFIG_X86_64
+NORETURN(__x64_sys_exit)
+NORETURN(__x64_sys_exit_group)
+#endif
+#ifdef CONFIG_XEN_PV_SMP
+NORETURN(cpu_bringup_and_idle)
+#endif
+NORETURN(do_exit)
+NORETURN(do_group_exit)
+#if defined(CONFIG_X86) && defined(CONFIG_SMP)
+NORETURN(hlt_play_dead)
+#endif
+#ifdef CONFIG_HYPERV
+NORETURN(hv_ghcb_terminate)
+#endif
+NORETURN(kthread_complete_and_exit)
+NORETURN(kthread_exit)
+NORETURN(make_task_dead)
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+NORETURN(sev_es_terminate)
+NORETURN(snp_abort)
+#endif
+NORETURN(stop_this_cpu)
+#undef NORETURN
+BTF_SET_END(noreturn_deny)
+
 static bool can_be_sleepable(struct bpf_prog *prog)
 {
 	if (prog->type == BPF_PROG_TYPE_TRACING) {
@@ -22929,6 +22972,11 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	} else if (prog->type == BPF_PROG_TYPE_TRACING &&
 		   btf_id_set_contains(&btf_id_deny, btf_id)) {
 		return -EINVAL;
+	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
+		   btf_id_set_contains(&noreturn_deny, btf_id)) {
+		verbose(env, "Attaching fexit/fmod_ret to __noreturn functions is rejected.\n");
+		return -EINVAL;
 	}
 
 	key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
-- 
2.43.5


