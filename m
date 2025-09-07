Return-Path: <bpf+bounces-67684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFD8B4812E
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 01:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A993C031E
	for <lists+bpf@lfdr.de>; Sun,  7 Sep 2025 23:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA94233727;
	Sun,  7 Sep 2025 23:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC0J26cp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB8022D7B5
	for <bpf@vger.kernel.org>; Sun,  7 Sep 2025 23:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757286276; cv=none; b=N+73bDmdSrUbhWLxQaY+OCX8zhvZaTffag4hAGxq+cDlAFsAr8gIZ8tRgXWeRxYji95xMmhgE1DmMs7cb6K5tmEz0YzPoFURYOZritNgb7tsnU4tx1f0p6qgE65N77HiafV8ETRicuGezo56ExdR1UES+Zyg+RrutZVAUyyUwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757286276; c=relaxed/simple;
	bh=iKBYToeiRMctq1ozdhGwoZA7uhN9va8F1zyyjYc24mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVbmivOSH9ZOxtJot9w9VeILVtrf3VIkes2RWTkD0DbZIILXLa5s5rKSEOljbpMxjU1DD9m08o10WH1a6yeGSBccBS9Bpwu3RP/6/q4JPVFqCalW4/+5izsZAFZXQ9XEHsca5bfpXyOuRv3SxAN2xBgli8dm6LkypGceh3X2SaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC0J26cp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7722c8d2694so3265548b3a.3
        for <bpf@vger.kernel.org>; Sun, 07 Sep 2025 16:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757286274; x=1757891074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcsaHvIZMp8uFjWT1HEwZb1esXkePszGBONrUtdnYUc=;
        b=DC0J26cpCODx66D6mZWhFewCHkNQIQEMN3RkBH4NyosKz0uLcY5A1opFJqM5IyVreN
         DYBDln1H+EwBIJHBwf8rMuMCXhz0HRj6IsKmnQloLCgoMcnrQc2vPPKRiKakAf9AI8UN
         YbeV5jQFQNvgtuAplTaKvxOGzGMZkk7YI4p7lkfDjeF5kbn0Db6Zgu4SZD/rfnXfOBFU
         ah73L6X/kCnVvG3beU9Cb4kUL8oV+f9dwj0mNSTxps5OsXnNOkMWRJG2aNI8IlE/G5mc
         OXQ1PX0JjDRz4hbuPFM8KeXHyqA+NuJpReYU+mMLb2RGO4GbGsLu2C2yBcr4uVgZtn4o
         8aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757286274; x=1757891074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcsaHvIZMp8uFjWT1HEwZb1esXkePszGBONrUtdnYUc=;
        b=ATsRpgVoFTFUnpbW1Ohh4AQfNMLJSA/vYUpleuRt1MDIKYSrwATAFTG0Y+sie9gWEv
         DaZYweJUFXQqTDgmCV/PQ9jXXM0PyyJ+SDgLPLvKtDVqJuaI6L+AboSW8+fYB329jhWs
         vwWgcy9WwPhixurSZqPaxAxwlTOJXSQuvOl/hLHdcPdz+GyVta0fX6RwGMA5/svvMlqa
         Y+bAPHEF/VhSBcOTyy3+wVCFn+jspU9OWju1rZXyIdo1+vD3BkDKqnC3U6o3dQc82OKY
         qxN+f3nDN0fAaITj4QoWwZBXs+67qpfTefvFaq020/2CcMenPh7OMHMUa5dxbAM3g4L7
         9M8A==
X-Gm-Message-State: AOJu0YyGmSSQmDJnFkYPWhkazH8Cp0ACSacXFLVYd7INmKQV70FHVame
	9xmj5OocXxGG/6wXB9jK6kKVzGt5S/8gLN5kBtO6mZTCf7qBhtsS0+ab1LEPnUDW
X-Gm-Gg: ASbGncsMtwj7uxbV5DjCj5+Udm59RoIcOcMijIHhHT50zewSL3gT4HO2vR+nLjq/l7q
	ZSF3bpEKQqlX8SJRJepMfazo2pAfEY2uHaKSzx/Fs9RxrA5hl/Lw7JcBWHN3wA5kDrVh+CILf88
	M0lKi33j9o8lnaX7qJCKlNUKP/ovqEkWU94rhm6cVItn+ZQmS+LbnO26/4Czx787gF5VEFuf6FY
	Vlf3tWhRS336UIIvUe46AHamtEbTkehl0qTx1iiifWSMQR4SFvfzX+beZDxpegMWtax/rt7jyHN
	o7GcdwH2cMhaGpke432h9kNZP/pMTm+1zEMqvBDZirNxLMMGtKLq7W074iFQjP/HGjg4ZbvNT3t
	D4o5fz0R0k4Op1ffqiDl4gtsPLjxvPzhNeLRPMIsnqJhxHTeRaG0Q8uMsKoYOlhsesHC5oai2Xv
	V9rCp1OQJrQpYeuMmSyMvC
X-Google-Smtp-Source: AGHT+IH15YaYC7M14M5HUxVlzMBQg6P1aW/n1I+68j8jih7B1bWxjPenOex1edpdFrxBur/UBKhH1w==
X-Received: by 2002:a17:902:f54d:b0:24e:e5c9:ed06 with SMTP id d9443c01a7336-25173118f11mr75882295ad.28.1757286273911;
        Sun, 07 Sep 2025 16:04:33 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24caf245690sm111254675ad.10.2025.09.07.16.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 16:04:33 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
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
	djwillia@vt.edu,
	miloc@vt.edu,
	ericts@vt.edu,
	rahult@vt.edu,
	doniaghazy@vt.edu,
	quanzhif@vt.edu,
	jinghao7@illinois.edu,
	sidchintamaneni@gmail.com,
	memxor@gmail.com,
	egor@vt.edu,
	sairoop10@gmail.com,
	rjsu26@gmail.com
Subject: [PATCH 3/4] bpf: runtime part of fast-path termination approach
Date: Sun,  7 Sep 2025 23:04:14 +0000
Message-ID: <20250907230415.289327-4-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250907230415.289327-1-sidchintamaneni@gmail.com>
References: <20250907230415.289327-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update softlock detection logic to detect any stalls due to
BPF programs. When softlockup is detected, bpf_die will be
added to a workqueue on a CPU. With this implementation termination
handler will only get triggered when CONFIG_SOFTLOCKUP_DETECTOR is
enabled.

Inside bpf_die, we perform the text_poke to stub helpers/kfuncs.
The current implementation handles termination of long running
bpf_loop iterators both inlining and non-inlining case.

The limitation of this implementation is that the termination handler
atleast need a single CPU to run.

Signed-off-by: Raj Sahu <rjsu26@gmail.com>
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 132 ++++++++++++++++++++++++++++++++++++
 include/linux/bpf.h         |   2 +
 include/linux/filter.h      |   6 ++
 kernel/bpf/core.c           |  35 +++++++++-
 kernel/watchdog.c           |   8 +++
 5 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 107a44729675..4de9a8cdc465 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2606,6 +2606,10 @@ st:			if (is_imm8(insn->off))
 				if (arena_vm_start)
 					pop_r12(&prog);
 			}
+			/* emiting 5 byte nop for non-inline bpf_loop callback */
+			if (bpf_is_subprog(bpf_prog) && bpf_prog->aux->is_bpf_loop_cb_non_inline) {
+				emit_nops(&prog, X86_PATCH_SIZE);
+			}
 			EMIT1(0xC9);         /* leave */
 			emit_return(&prog, image + addrs[i - 1] + (prog - temp));
 			break;
@@ -3833,6 +3837,8 @@ bool bpf_jit_supports_private_stack(void)
 	return true;
 }
 
+
+
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
 {
 #if defined(CONFIG_UNWINDER_ORC)
@@ -3849,6 +3855,132 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
 #endif
 }
 
+void in_place_patch_bpf_prog(struct bpf_prog *prog)
+{
+	struct call_aux_states *call_states;
+	unsigned long new_target;
+	unsigned char *addr;
+	u8 ret_jmp_size = 1;
+	if (cpu_wants_rethunk()) {
+		ret_jmp_size = 5;
+	}
+	call_states = prog->term_states->patch_call_sites->call_states;
+	for (int i = 0; i < prog->term_states->patch_call_sites->call_sites_cnt; i++) {
+		
+		new_target = (unsigned long) bpf_termination_null_func;
+		if (call_states[i].is_bpf_loop_cb_inline) {
+			new_target = (unsigned long) bpf_loop_term_callback;	
+		}
+		char new_insn[5];
+
+		addr = (unsigned char *)prog->bpf_func + call_states->jit_call_idx;
+
+		unsigned long new_rel = (unsigned long)(new_target - (unsigned long)(addr + 5));
+		new_insn[0] = 0xE8;
+		new_insn[1] = (new_rel >> 0) & 0xFF;
+		new_insn[2] = (new_rel >> 8) & 0xFF;
+		new_insn[3] = (new_rel >> 16) & 0xFF;
+		new_insn[4] = (new_rel >> 24) & 0xFF;
+
+		smp_text_poke_batch_add(addr, new_insn, 5 /* call instruction len */, NULL);
+	}
+
+	if (prog->aux->is_bpf_loop_cb_non_inline) {
+		
+		char new_insn[5] = { 0xB8, 0x01, 0x00, 0x00, 0x00 };
+		char old_insn[5] = { 0x0F, 0x1F, 0x44, 0x00, 0x00 };
+		smp_text_poke_batch_add(prog->bpf_func + prog->jited_len - 
+				(1 + ret_jmp_size) /* leave, jmp/ ret */ - 5 /* nop size */, new_insn, 5 /* mov eax, 1 */, old_insn);
+	}
+
+
+	/* flush all text poke calls */
+	smp_text_poke_batch_finish();
+}
+
+void bpf_die(struct bpf_prog *prog)
+{
+	u8 ret_jmp_size = 1;
+	if (cpu_wants_rethunk()) {
+		ret_jmp_size = 5;
+	}
+
+	/*
+	 * Replacing 5 byte nop in prologue with jmp instruction to ret
+	 */
+	unsigned long jmp_offset = prog->jited_len - (4 /* First endbr is 4 bytes */ 
+					+ 5 /* noop is 5 bytes */ 
+					+ ret_jmp_size /* 5 bytes of jmp return_thunk or 1 byte ret*/);
+
+	char new_insn[5];
+	new_insn[0] = 0xE9;
+	new_insn[1] = (jmp_offset >> 0) & 0xFF;
+	new_insn[2] = (jmp_offset >> 8) & 0xFF;
+	new_insn[3] = (jmp_offset >> 16) & 0xFF;
+	new_insn[4] = (jmp_offset >> 24) & 0xFF;
+
+	smp_text_poke_batch_add(prog->bpf_func + 4, new_insn, 5, NULL);
+
+	if (prog->aux->func_cnt) {
+		for (int i = 0; i < prog->aux->func_cnt; i++) {
+			in_place_patch_bpf_prog(prog->aux->func[i]);
+		}
+	} else {
+		in_place_patch_bpf_prog(prog);
+	}
+
+}
+
+void bpf_prog_termination_deferred(struct work_struct *work)
+{
+	struct bpf_term_aux_states *term_states = container_of(work, struct bpf_term_aux_states,
+						 work);
+	struct bpf_prog *prog = term_states->prog;
+
+	bpf_die(prog);
+}
+
+static struct workqueue_struct *bpf_termination_wq;
+
+void bpf_softlockup(u32 dur_s)
+{
+	unsigned long addr;
+	struct unwind_state state;
+	struct bpf_prog *prog;
+
+	for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
+	     unwind_next_frame(&state)) {
+		addr = unwind_get_return_address(&state);
+		if (!addr)
+			break;
+
+		if (!is_bpf_text_address(addr))
+			continue;
+
+		rcu_read_lock();
+		prog = bpf_prog_ksym_find(addr);
+		rcu_read_unlock();
+		if (bpf_is_subprog(prog))
+			continue;
+
+		if (atomic_cmpxchg(&prog->term_states->bpf_die_in_progress, 0, 1))
+			break;
+	
+		bpf_termination_wq = alloc_workqueue("bpf_termination_wq", WQ_UNBOUND, 1);
+		if (!bpf_termination_wq)
+			pr_err("Failed to alloc workqueue for bpf termination.\n");
+
+		queue_work(bpf_termination_wq, &prog->term_states->work);
+
+		/* Currently nested programs are not terminated together.
+		 * Removing this break will result in BPF trampolines being
+		 * identified as is_bpf_text_address resulting in NULL ptr
+		 * deref in next step.
+		 */
+		break;
+	}
+}
+
 void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 			       struct bpf_prog *new, struct bpf_prog *old)
 {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index caaee33744fc..03fce8f2c466 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -71,6 +71,7 @@ typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
 typedef void (*bpf_iter_fini_seq_priv_t)(void *private_data);
 typedef unsigned int (*bpf_func_t)(const void *,
 				   const struct bpf_insn *);
+
 struct bpf_iter_seq_info {
 	const struct seq_operations *seq_ops;
 	bpf_iter_init_seq_priv_t init_seq_private;
@@ -1600,6 +1601,7 @@ struct bpf_term_patch_call_sites {
 struct bpf_term_aux_states {
 	struct bpf_prog *prog;
 	struct work_struct work;
+	atomic_t bpf_die_in_progress;
 	struct bpf_term_patch_call_sites *patch_call_sites;
 };
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9092d8ea95c8..4f0f8fe478bf 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1123,6 +1123,8 @@ int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len);
 bool sk_filter_charge(struct sock *sk, struct sk_filter *fp);
 void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp);
 
+void *bpf_termination_null_func(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
+int bpf_loop_term_callback(u64 reg_loop_cnt, u64 *reg_loop_ctx);
 u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 #define __bpf_call_base_args \
 	((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
@@ -1257,6 +1259,10 @@ bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
 
 void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns);
 void bpf_prog_pack_free(void *ptr, u32 size);
+void bpf_softlockup(u32 dur_s);
+void bpf_prog_termination_deferred(struct work_struct *work);
+void bpf_die(struct bpf_prog *prog);
+void in_place_patch_bpf_prog(struct bpf_prog *prog);
 
 static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
 {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 93442ab2acde..7b0552d15be3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -41,6 +41,7 @@
 #include <linux/execmem.h>
 
 #include <asm/barrier.h>
+#include <asm/unwind.h>
 #include <linux/unaligned.h>
 
 /* Registers */
@@ -95,6 +96,37 @@ enum page_size_enum {
 	__PAGE_SIZE = PAGE_SIZE
 };
 
+void *bpf_termination_null_func(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5)
+{
+	return NULL;
+}
+
+int bpf_loop_term_callback(u64 reg_loop_cnt, u64 *reg_loop_ctx)
+{
+	return 1;
+}
+
+
+void __weak in_place_patch_bpf_prog(struct bpf_prog *prog)
+{
+	return;
+}
+
+void __weak bpf_die(struct bpf_prog *prog)
+{
+	return;
+}
+
+void __weak bpf_prog_termination_deferred(struct work_struct *work)
+{
+	return;
+}
+
+void __weak bpf_softlockup(u32 dur_s)
+{
+	return;
+}
+
 struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flags)
 {
 	gfp_t gfp_flags = bpf_memcg_flags(GFP_KERNEL | __GFP_ZERO | gfp_extra_flags);
@@ -134,11 +166,12 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	fp->jit_requested = ebpf_jit_enabled();
 	fp->blinding_requested = bpf_jit_blinding_enabled(fp);
 	fp->term_states = term_states;
+	atomic_set(&fp->term_states->bpf_die_in_progress, 0);
 	fp->term_states->patch_call_sites = patch_call_sites;
 	fp->term_states->patch_call_sites->call_sites_cnt = 0;
 	fp->term_states->patch_call_sites->call_states = NULL;
 	fp->term_states->prog = fp;
-
+	INIT_WORK(&fp->term_states->work, bpf_prog_termination_deferred);
 #ifdef CONFIG_CGROUP_BPF
 	aux->cgroup_atype = CGROUP_BPF_ATTACH_TYPE_INVALID;
 #endif
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 80b56c002c7f..59c91c18ca0e 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -25,6 +25,7 @@
 #include <linux/stop_machine.h>
 #include <linux/sysctl.h>
 #include <linux/tick.h>
+#include <linux/filter.h>
 
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
@@ -700,6 +701,13 @@ static int is_softlockup(unsigned long touch_ts,
 		if (time_after_eq(now, period_ts + get_softlockup_thresh() * 3 / 4))
 			scx_softlockup(now - touch_ts);
 
+		/*
+		 * Long running BPF programs can cause CPU's to stall.
+		 * So trigger fast path termination to terminate such BPF programs.
+		 */
+		if (time_after_eq(now, period_ts + get_softlockup_thresh() * 3 / 4))
+			bpf_softlockup(now - touch_ts);
+
 		/* Warn about unreasonable delays. */
 		if (time_after(now, period_ts + get_softlockup_thresh()))
 			return now - touch_ts;
-- 
2.43.0


