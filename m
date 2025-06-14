Return-Path: <bpf+bounces-60660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB420AD9A79
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 08:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE20189EC35
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 06:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B3A1E5B64;
	Sat, 14 Jun 2025 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV4ZJ6lz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D4A2E11AC
	for <bpf@vger.kernel.org>; Sat, 14 Jun 2025 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749883304; cv=none; b=WAbwnTIvtBxtKqj1doqxjfWRNJ64EfYB6T8vEVM4f89mJ53wk0FQrGPquWqHpXFlJNeXHJOObZMxNrKnHeGtPvAeARAKl93cGC+HsoFkatJHb8QrwqqwiNnDQYHm0tkcn1vD7rqFdIK5vmvhRX3nkLbAsj/9iD1GYqE8vaG2g5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749883304; c=relaxed/simple;
	bh=kraXXxj386rmaYNEsAIetnnU8xdQBJ/wMdLDN1R+I3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d80tiTnabRHkjBBjsYI+qoXAvddLkYfhQ1HoWEwcU+XD9tr9vKh6CBACNFLYM+1QSoWE6Z/O4KYe1JyzZi9tsHrL1k7EmfZxM2AMbT/ezyCpulbJ0PcDah2Jm44kK1LS1pGnEb4wDd+zzrm+jBCJUfizCFo8YT2Te1h1W/OTxjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV4ZJ6lz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2fa3957661so2471007a12.2
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 23:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749883302; x=1750488102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/VQQWSklAKuGqU16nm2mLHSRuVOe4AWBN0aDjFejtE=;
        b=KV4ZJ6lziUk3u/byBguGNAOxHw3L/HyVHebCSCkoML1YbZ60FVXWO9kV6KdAysen2M
         A1z7Z5a4fZK5Q1kU3pGC807gEEg6JCjRem24pceWiaGw8J/1OtemvgLPAXO5VVPaqFD8
         dvcne+Yl5prdvcrENRalttT2SM5muw02hxFEg0EPDWHcu9hJiN/oQbzcIbhkG0xHIFZa
         saK5EvWYTZn+Hf+vDM7Lr/UhyWoJeqovGQasnaUeXZYmOprO631yXIaAba3Lp7XDkAz7
         Y2ZyrwSMR1eI5dEEu/+Wj+ofxmRFyL3oQ95ADFtnxZtwl7HpY5OgJPTb+sVzFmN8p6Ng
         v5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749883302; x=1750488102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/VQQWSklAKuGqU16nm2mLHSRuVOe4AWBN0aDjFejtE=;
        b=YnbSfsvoxIgVBMN+PW4dOaei7m3PFDhnPPqd274ZpPXNj2ZkRApcJmgHVgHLTnPbym
         QP9SP8JWwMaw2KaAwK1+Q/y5CfQvTI+2tjrEzhXgfj0r8D05v8MFxMXXsnYgruDVZQSg
         fuid0gHEC9v1tR1ZS3ijjx1WPIkH4Eu7meIpF+BRrXVhiafyZy8Nyu5hJBMwnS8VO2zx
         pIu74ayvmlSpDUE/tHgp6pNl9oR/4n1mKgYBu3FCdBYhGMGv+fmnTSf234pdKxXPVbb/
         ZfxSBhok2zRinkqlD+xYOWQdLbUTF13L/gO/zllO0q+XhSEq5FMooJV/EzvBMzeO3Ar4
         l8Qw==
X-Gm-Message-State: AOJu0Yxc36YPl9an4r7tCHFUISlKw8P4GAigM+dsizZ3304I5l4qr+iu
	mFOqH96A+U0UwzCEyDwwoeTB1DEbp/jvkzZwv3w/6vQaocE2Dm4ufDg6ayXE4JKd
X-Gm-Gg: ASbGnctWGA/ulTkdbLdojebT2weZNkW86A/k8vXOrJLEaA/ROGsmsUnOdz4fsJ56x/N
	0/4Yegx7av2jP7XPSSOBG2G2nKfUqdZJaB2XUTzM5owgwtXI3veXefLHAxGttzQK6xJx7aOal6/
	trepYUYada5L7vKGIGFdZ3zn40saSSUcuqUzPH5iYvqpRkoUMB9gXqzaPIxXnJHmGgg3L0UWmkI
	Wx11kufprsNHihFM+yZZY78CrUJFicL+fmIPW3rA+2CHFIpFY9Pl9gklpp7TA7vBwivkdq6f4cg
	16+dc92wgsQ5jq02/FCNS79UxQP0v1RiqIlQa7fkK25HkVuiCAxDroHcLTZfZCtK95GHj1EGvrK
	YetLwxuV8fNILwTgXfh8VMG9M7EFwaKoBUoo5ilLRUw7EP16kLbtz44G3tKdGB64=
X-Google-Smtp-Source: AGHT+IG7XibloOlO0UOj8H/uWuLvKxyzJ0EXCXNAVwJ7l2sLc4wKmBFapzediSc1k19pqCNZlOA41w==
X-Received: by 2002:a05:6a21:998a:b0:1f5:7eb5:72dc with SMTP id adf61e73a8af0-21fbd505f61mr3172019637.3.1749883302384;
        Fri, 13 Jun 2025 23:41:42 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([20.120.208.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083ba7sm2812124b3a.102.2025.06.13.23.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 23:41:42 -0700 (PDT)
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
	Raj Sahu <rjsu26@gmail.com>
Subject: [RFC bpf-next v2 1/4] bpf: Introduce new structs and struct fields
Date: Sat, 14 Jun 2025 06:40:53 +0000
Message-ID: <20250614064056.237005-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250614064056.237005-1-sidchintamaneni@gmail.com>
References: <20250614064056.237005-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduced the definition of struct bpf_term_aux_states
required to support fast-path termination of BPF programs.
Added the memory allocation and free logic for newly added
term_states feild in struct bpf_prog.

Signed-off-by: Raj Sahu <rjsu26@gmail.com>
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 include/linux/bpf.h | 18 +++++++++++++++++-
 kernel/bpf/core.c   | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5dd556e89cce..1c534b3e10d8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -31,6 +31,7 @@
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
 #include <asm/rqspinlock.h>
+#include <linux/hrtimer.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -39,6 +40,7 @@ struct bpf_prog;
 struct bpf_prog_aux;
 struct bpf_map;
 struct bpf_arena;
+struct bpf_term_aux_states;
 struct sock;
 struct seq_file;
 struct btf;
@@ -1538,6 +1540,17 @@ struct btf_mod_pair {
 
 struct bpf_kfunc_desc_tab;
 
+struct cpu_aux {
+	u8 cpu_flag;
+	spinlock_t lock;
+};
+
+struct bpf_term_aux_states {
+	struct bpf_prog *patch_prog;
+	struct cpu_aux *per_cpu_state;
+	struct hrtimer hrtimer;
+};
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
 	u32 used_map_cnt;
@@ -1664,7 +1677,8 @@ struct bpf_prog {
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
-				sleepable:1;	/* BPF program is sleepable */
+				sleepable:1,	/* BPF program is sleepable */
+				is_termination_prog:1; /* Is patch prog? */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
@@ -1676,6 +1690,7 @@ struct bpf_prog {
 					    const struct bpf_insn *insn);
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
 	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
+	struct bpf_term_aux_states *term_states; /* Program termination aux fields */
 	/* Instructions for interpreter */
 	union {
 		DECLARE_FLEX_ARRAY(struct sock_filter, insns);
@@ -2385,6 +2400,7 @@ static inline struct btf *__btf_get_by_fd(struct fd f)
 	return fd_file(f)->private_data;
 }
 
+enum hrtimer_restart bpf_termination_wd_callback(struct hrtimer *hr);
 void bpf_map_inc(struct bpf_map *map);
 void bpf_map_inc_with_uref(struct bpf_map *map);
 struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e536a34a32c8..756ed575741e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -99,6 +99,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	gfp_t gfp_flags = bpf_memcg_flags(GFP_KERNEL | __GFP_ZERO | gfp_extra_flags);
 	struct bpf_prog_aux *aux;
 	struct bpf_prog *fp;
+	struct bpf_term_aux_states *term_states = NULL;
 
 	size = round_up(size, __PAGE_SIZE);
 	fp = __vmalloc(size, gfp_flags);
@@ -117,11 +118,28 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 		return NULL;
 	}
 
+	term_states = kzalloc(sizeof(*term_states), bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
+	if (!term_states)
+		goto free_alloc_percpu;
+
+	term_states->per_cpu_state = kzalloc(sizeof(struct cpu_aux) * NR_CPUS, 
+						bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
+	if (!term_states->per_cpu_state)
+		goto free_bpf_term_states;
+	
+	for (int i = 0; i < NR_CPUS; i++) {
+		term_states->per_cpu_state[i].cpu_flag = 0;
+		spin_lock_init(&term_states->per_cpu_state[i].lock);
+	}
+
+
 	fp->pages = size / PAGE_SIZE;
 	fp->aux = aux;
 	fp->aux->prog = fp;
 	fp->jit_requested = ebpf_jit_enabled();
 	fp->blinding_requested = bpf_jit_blinding_enabled(fp);
+	fp->term_states = term_states;
+	fp->term_states->patch_prog = NULL;
 #ifdef CONFIG_CGROUP_BPF
 	aux->cgroup_atype = CGROUP_BPF_ATTACH_TYPE_INVALID;
 #endif
@@ -135,6 +153,15 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	mutex_init(&fp->aux->dst_mutex);
 
 	return fp;
+
+free_bpf_term_states:
+	kfree(term_states);
+free_alloc_percpu:
+	free_percpu(fp->active);
+	kfree(aux);
+	vfree(fp);
+
+	return NULL;
 }
 
 struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
@@ -268,6 +295,7 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 		fp_old->aux = NULL;
 		fp_old->stats = NULL;
 		fp_old->active = NULL;
+		fp_old->term_states = NULL;
 		__bpf_prog_free(fp_old);
 	}
 
@@ -282,6 +310,15 @@ void __bpf_prog_free(struct bpf_prog *fp)
 		kfree(fp->aux->poke_tab);
 		kfree(fp->aux);
 	}
+	if (fp->term_states) {
+		if (fp->term_states->patch_prog) {
+			kfree(fp->term_states->patch_prog->aux->poke_tab);
+			kfree(fp->term_states->patch_prog->aux);
+			vfree(fp->term_states->patch_prog);
+		}
+		kfree(fp->term_states->per_cpu_state);
+		kfree(fp->term_states);
+	}
 	free_percpu(fp->stats);
 	free_percpu(fp->active);
 	vfree(fp);
-- 
2.43.0


