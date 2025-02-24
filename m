Return-Path: <bpf+bounces-52335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21228A41E1E
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 13:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D36421F69
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62661248872;
	Mon, 24 Feb 2025 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXuGoQSq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A124886B
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397590; cv=none; b=uCb8jPsK7b0Jz54Ek5zEwKtpOiPl4usCqS2FlLF6tN3a+uoJDVC4UXAlY43IrOYmP1JOGLjeYA389eyqVw2IR7VoIG+SpPxRIvrxbqCz+PSNuNzX5mRKqhyjPYYD6oWdpAFtQdWZkEQ3xJ1Bn+bmDeEdRi/0svE7m6opD9BnoBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397590; c=relaxed/simple;
	bh=7eReNgfjeo9fwLR5Y9/AXwyTubSTDK4ST5YAy+yrQ5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SjE6aEHd+kMqoGv/aDJfTWZihoe6u2Con+jOj0/nAvEDXs51gzviJHtIHySDABmA69Opu6E+XQXAUmqTuTx9wBANcHFtW6WxLcYFU+lgT/m55d2Yzt48u8E5YrlVgeF1xZEUlXJZNTSQEWoszAleYV2Swp8mgoo6GoFCLR7VEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXuGoQSq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-221206dbd7eso83489495ad.2
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 03:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397588; x=1741002388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Bw8vT5KJ0VlloIvIOkvVIQ1NKrqLKrep7rEBwjc1v0=;
        b=EXuGoQSqS/jTaqDPfMyEO37fx9zL7l+qc3eZG5RCtUgbrfrPt9aywlOFdARJEuKD/J
         2Yxq6yf+5rCt5wgm6PTzy1fQMy5NseKWtlsIVu/7X1tavNpX8xKneOSqjtKl1kqvICpa
         1SdXdKefpRGXrQ1FJUaFuExJ9vMfNpbJO6pdHHLw8I+cxus9kIQgQzNRHic97I9zTMra
         b/0JZVVmi/2s5KQ3yP+zrKN/WvMzcL4JsJqpVSR+tZoUPD5ugu68z4mZ3U+w3BIWeMrM
         7nhDrI30qIfrQE/WOPrswbpavSNDdhr7R1F/D5pgc9mgPsBdN7G1llWMHASNC7PvXr8l
         l22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397588; x=1741002388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Bw8vT5KJ0VlloIvIOkvVIQ1NKrqLKrep7rEBwjc1v0=;
        b=pUK0sp8jJjaTewvg/Ascir1/0hUtwrtitSxigpY9rXR8veoK9wducD4fsA/b98jg0D
         td9w1123AQOctGu/hwGz53VjdlN8FM3cJtYYmNHUJSZrmLT+9veV7WtpQNREXnXJ2wPi
         x/dRRVPMfDVvkabU010A8Gt/CyJR0Hvcfwqlr/V/RZMvTBWeh6NRR/J1EMOX+BzjNyjL
         XZyW5fhw6AbHgWCbg7KalsE85pLZNLNQ8SIjpxfFovnrl3XrXvntlQQX4aEYAB7pb1GS
         1u0pQ1dKdDiV8wEBDr1K5aS5eT4aLBW7Q2u3C734pe8BvdaitPAUSyFt75Ir888gX+ua
         YBvg==
X-Gm-Message-State: AOJu0YzJAwubQOiRQc4hNfWDYZ1VsvQjFcTj07FJDJ0mAjNbWIratdJ0
	dCoTzaxwqbg2WdXwZTlh6wmO9Xo5tgpGc/tOaVmdQoh81LbwW3pL
X-Gm-Gg: ASbGncuuoAzxxBoqyrbvVlDK29XQdvV03oabHrxnzKDL5jh9RyrPrAt5bFbSUMT3FGt
	efdigo+r6LnTYjFy4vyyDQqvQw31iOYat/Fc8J861JhMF1BoYV0gyAW4mzB215u2Hml7FCFAFBy
	6KyWckAGbc2l8TnorJ4VBqqHmRl8RC5pSzLcugo7ePZHabOMvp3CmCAgAOwTF+tmQuUU4A76tOO
	vUMekISCX+15zQNeVRRSKm6vW6bC5s4deZfhmrDzY3xhoil1vMQweuLwVG7oZb5kTaz+e+4DxzZ
	uZ4WDrZWqJY0KByNmOSx9UFWy5vYYc3BjW6DtpNF9SpF/BY=
X-Google-Smtp-Source: AGHT+IF3rguqUAZKxMY6HzKz2vxzI/rhxD/UwuHtscILVFM+B/2FQtLPeLCojTg4f1rxpHzRNHp0lQ==
X-Received: by 2002:a05:6a20:4394:b0:1ee:8c93:c90e with SMTP id adf61e73a8af0-1eef3c77105mr23038988637.17.1740397588201;
        Mon, 24 Feb 2025 03:46:28 -0800 (PST)
Received: from localhost.localdomain ([39.144.45.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325f063782sm18095080b3a.148.2025.02.24.03.46.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Feb 2025 03:46:27 -0800 (PST)
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
Subject: [PATCH v3 1/2] bpf: Reject attaching fexit to functions annotated with __noreturn
Date: Mon, 24 Feb 2025 19:46:05 +0800
Message-Id: <20250224114606.3500-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250224114606.3500-1-laoar.shao@gmail.com>
References: <20250224114606.3500-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we attach fexit to a function annotated with __noreturn, it will
cause an issue that the bpf trampoline image will be left over even if
the bpf link has been destroyed. Take attaching do_exit() for example. The
fexit works as follows,

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

With this change, attaching fexit probes to functions like do_exit() will
be rejected.

$ ./fexit
libbpf: prog 'fexit': BPF program load failed: -EINVAL
libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
Attaching fexit to __noreturn functions is rejected.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/verifier.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..6b0d3ed7dbd9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22841,6 +22841,59 @@ BTF_ID(func, __rcu_read_unlock)
 #endif
 BTF_SET_END(btf_id_deny)
 
+/* Functions annotated with __noreturn are denied. Currently, we must manually
+ * list all __noreturn functions here. Once a more robust solution is
+ * implemented, this workaround can be removed.
+ */
+BTF_SET_START(fexit_deny)
+#define NORETURN(fn) BTF_ID(func, fn)
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
+#undef NORETURN
+BTF_SET_END(fexit_deny)
+
 static bool can_be_sleepable(struct bpf_prog *prog)
 {
 	if (prog->type == BPF_PROG_TYPE_TRACING) {
@@ -22929,6 +22982,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	} else if (prog->type == BPF_PROG_TYPE_TRACING &&
 		   btf_id_set_contains(&btf_id_deny, btf_id)) {
 		return -EINVAL;
+	} else if (prog->expected_attach_type == BPF_TRACE_FEXIT &&
+		   btf_id_set_contains(&fexit_deny, btf_id)) {
+		verbose(env, "Attaching fexit to __noreturn functions is rejected.\n");
+		return -EINVAL;
 	}
 
 	key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
-- 
2.43.5


