Return-Path: <bpf+bounces-56284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E457A94784
	for <lists+bpf@lfdr.de>; Sun, 20 Apr 2025 12:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7F53AF8AF
	for <lists+bpf@lfdr.de>; Sun, 20 Apr 2025 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812141E377F;
	Sun, 20 Apr 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGORTJ7z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745811BD4F7
	for <bpf@vger.kernel.org>; Sun, 20 Apr 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745146568; cv=none; b=A7VQXxYCWmKlP+gXF1TsnIMFG8g9JpXYhrWcRQlZFBX6royCkZ8uEe+IEMuZZTTgbfZHApWelBa65IGnoEKf/YeIDkx2dl187EnLt8V7w4EV8K+shm2jLOgA9N0kl9DgiIFHb/uwMDKr1aThEoD8a0UBcSSrDLq1Wx87o41UW1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745146568; c=relaxed/simple;
	bh=2flmpj4ggNBo6NEYaFIGRGEfc2qaLDOdu1Pf3Pfit3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZtgrVCok77QnuqEsE0CuEDCXxhk50CUmdAMhy/4ZAqlXSNsH1pijSb3VKtNtRi/u3RRLkfgiHsZjvXimKIZYJHI0jVMBAce87fdz+u31r2qAgmJDMF68tnScFcPv+KZ413fmLiABxZbhEdnP7/vtZJfm04HgcBirdI4O9pV9YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGORTJ7z; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-477296dce76so27834221cf.3
        for <bpf@vger.kernel.org>; Sun, 20 Apr 2025 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745146565; x=1745751365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKS18w5jPtthAClr/qzcbbJeJ2idJTNr68ummcX/Ugg=;
        b=bGORTJ7zGeHy8pqIb8Bj2UMuo+uRpSSUYh6MuFf9aXWSWejhFBoSlRT6wWZr5J996R
         qEIhGEq9hUKSe+pJXTuB2pTt4Bnf4oFUHkhW39xkifW78gS0EKAmlYFY6prrMpkELWxz
         qjcfzS1zb4XMzKDXFgAKiA9+lVD91tGTUMHsjNg+b1aL3J1zx6EjnroeuUyUbhfX0Kkx
         KOwm/MWK4y6pDhHLD8qKvm/KN/bHwkJhtb2vqSOEASqFXogdds2i3oTOonOlUJ5bny3d
         c8qp1gCFY8OSbvm9Eee38jxCGmvGCJmoV7eDxvtWiz9SNs0eceV5ncFey2YZQf5/QSLH
         b4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745146565; x=1745751365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKS18w5jPtthAClr/qzcbbJeJ2idJTNr68ummcX/Ugg=;
        b=jw3T/tYzuJAlAwPV2BnwHdNkaOE90PTzBC1ENm2RhjrD7adMBUJEdUIVNWBQ8Scf/O
         2ro54yp3v3xFGrrrLeeyZ7kbcq9jCwyQcBzv/lY77iReeGBroX/OLRGk2Kf43fKCKMr2
         ro1rpoW17Aj8cmt58GNSVjVgUCgvbTacwmyxOKniMOqrb51oUCCNOVkgu3UIGUxePer8
         bYGhfF1vUp8JFe7x2TDKNvCpUshqSX/ZAwix+SEVWWIplILjozHtvstZpxshgNMY7QjJ
         cnr2+c+2WaTYxhqMZf90MsbX4KFY3OnryR/TZrWEsgyPdSUt2qi2qjcqBsAgJQ1+aXTM
         D3sA==
X-Gm-Message-State: AOJu0YxiZIv2CWOHRXViEmAr1mpq5zS+knDDtqlyFoxDeMzsqR8KXE0a
	sv5X9BjF/cFezjLa1wtk6esqxTpYNYgLkSF7BmNUmz1hsNK9uHIoDMYyZwyL
X-Gm-Gg: ASbGncurRocnPJ9JXAElazjkwEmLvw1TzcmRD4kUs0e42nLJgXhXxhC7iKcnrvCzAI0
	pRljW9g8oUT3nm2nbfkbXqXDDKurPGUWCxMc3SeV6YkOswjEUXcEdq+hseq5pelsA2h4lxu0m/o
	2Eu7/BK9iYJI3RFNtkryM9vH3VttwlHO23xxFiaEbUKOMoUc9+g59ZSr7vJNfvei/ceEN+nayMK
	hSHq35EIsjp1ELBKbwcVJvNnsSv9yDu8PvT4uAUZ73Rzzl4d8a7JnZUb7SDCHmayYWXBOAucfIR
	eY4Qtgh3YKzEDDsRD+vncp9Ez8EYrCMHKl4jmDRMtbQLbOqv
X-Google-Smtp-Source: AGHT+IH4ez4PNX+ibIIx+4pXEOeZiHdcqOqTaY54OcYYY4s1LyG/w8+FmTjq3KO/MBrxuK1brMweXw==
X-Received: by 2002:a05:622a:1a06:b0:476:b783:c94d with SMTP id d75a77b69052e-47aec4a1173mr115644621cf.35.1745146564965;
        Sun, 20 Apr 2025 03:56:04 -0700 (PDT)
Received: from rajGilbertMachine.. ([2607:b400:30:a100:a5e9:b904:d3d9:b816])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c4c608sm30851771cf.41.2025.04.20.03.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 03:56:04 -0700 (PDT)
From: Raj Sahu <rjsu26@gmail.com>
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
	sidchintamaneni <sidchintamaneni@vt.edu>,
	Raj <rjsu26@gmail.com>
Subject: [RFC bpf-next 1/4] bpf: Introduce new structs and struct fields
Date: Sun, 20 Apr 2025 06:55:19 -0400
Message-ID: <20250420105524.2115690-2-rjsu26@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420105524.2115690-1-rjsu26@gmail.com>
References: <20250420105524.2115690-1-rjsu26@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: sidchintamaneni <sidchintamaneni@vt.edu>

Introduces the definition of struct termination_aux_states
required to support fast-path termination of BPF programs.
Adds the memory allocation and free logic for newly added
termination_states feild in struct bpf_prog.

Signed-off-by: Raj <rjsu26@gmail.com>
Signed-off-by: Siddharth <sidchintamaneni@gmail.com>
---
 include/linux/bpf.h | 14 ++++++++++++++
 kernel/bpf/core.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3f0cc89c0622..5141f189b79b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -57,6 +57,7 @@ struct cgroup;
 struct bpf_token;
 struct user_namespace;
 struct super_block;
+struct termination_aux_states;
 struct inode;
 
 extern struct idr btf_idr;
@@ -1518,6 +1519,18 @@ struct btf_mod_pair {
 
 struct bpf_kfunc_desc_tab;
 
+struct cpu_aux {
+	u8 cpu_flag;
+	spinlock_t lock;
+};
+
+struct termination_aux_states {
+	struct cpu_aux *per_cpu_state;
+	struct pt_regs *pre_execution_state;
+	struct bpf_prog *patch_prog;
+	bool is_termination_prog;
+};
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
 	u32 used_map_cnt;
@@ -1656,6 +1669,7 @@ struct bpf_prog {
 					    const struct bpf_insn *insn);
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
 	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
+	struct termination_aux_states *termination_states;
 	/* Instructions for interpreter */
 	union {
 		DECLARE_FLEX_ARRAY(struct sock_filter, insns);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ba6b6118cf50..27dcf59f4445 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -99,6 +99,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	gfp_t gfp_flags = bpf_memcg_flags(GFP_KERNEL | __GFP_ZERO | gfp_extra_flags);
 	struct bpf_prog_aux *aux;
 	struct bpf_prog *fp;
+	struct termination_aux_states *termination_states = NULL;
 
 	size = round_up(size, __PAGE_SIZE);
 	fp = __vmalloc(size, gfp_flags);
@@ -117,11 +118,35 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 		return NULL;
 	}
 
+	termination_states = kzalloc(sizeof(*termination_states),
+					bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
+	if (!termination_states)
+		goto free_bpf_struct_ptr_alloc;
+
+	termination_states->per_cpu_state = kzalloc(sizeof(struct cpu_aux) * NR_CPUS,
+					bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
+	if (!termination_states->per_cpu_state)
+		goto free_bpf_termination_states;
+
+	for (int i = 0; i < NR_CPUS; i++) {
+		termination_states->per_cpu_state[i].cpu_flag = 0;
+		spin_lock_init(&termination_states->per_cpu_state[i].lock);
+	}
+
+	termination_states->pre_execution_state = kzalloc(
+					sizeof(struct pt_regs) * NR_CPUS,
+					bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags)
+					);
+	if (!termination_states->pre_execution_state)
+		goto free_per_cpu_state;
+
+	termination_states->is_termination_prog = false;
 	fp->pages = size / PAGE_SIZE;
 	fp->aux = aux;
 	fp->aux->prog = fp;
 	fp->jit_requested = ebpf_jit_enabled();
 	fp->blinding_requested = bpf_jit_blinding_enabled(fp);
+	fp->termination_states = termination_states;
 #ifdef CONFIG_CGROUP_BPF
 	aux->cgroup_atype = CGROUP_BPF_ATTACH_TYPE_INVALID;
 #endif
@@ -135,6 +160,16 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	mutex_init(&fp->aux->dst_mutex);
 
 	return fp;
+
+free_per_cpu_state:
+	kfree(termination_states->per_cpu_state);
+free_bpf_termination_states:
+	kfree(termination_states);
+free_bpf_struct_ptr_alloc:
+	free_percpu(fp->active);
+	vfree(fp);
+	kfree(aux);
+	return NULL;
 }
 
 struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
@@ -282,6 +317,13 @@ void __bpf_prog_free(struct bpf_prog *fp)
 		kfree(fp->aux->poke_tab);
 		kfree(fp->aux);
 	}
+
+	if (fp->termination_states) {
+		kfree(fp->termination_states->pre_execution_state);
+		kfree(fp->termination_states->per_cpu_state);
+		kfree(fp->termination_states);
+	}
+
 	free_percpu(fp->stats);
 	free_percpu(fp->active);
 	vfree(fp);
-- 
2.43.0


