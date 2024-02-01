Return-Path: <bpf+bounces-20901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC06084502B
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F5C28FEC2
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD9F3C478;
	Thu,  1 Feb 2024 04:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+xzgyRw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416993C46C
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761293; cv=none; b=nvFoOvPutrivAPptY58VE0BMiCIQKcP+eGal684Yxdwk9+8fCgDmC1bcAj1kcplevQWqgjWpTF3dVDDwUGzsbbbhjzhs3KxJY9GwV9FOsIF1kcZIMoBV3Cjvzo4OoK688gC2lXXjisJcMOM+S8WmcdyMaVyT+EtG7QfsMVOT74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761293; c=relaxed/simple;
	bh=ZSPFWnHn9tpYuXlwy/W39jwhB+YgpL3iD+6Fxtkp4Uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MeK5ukFceKsV6WpVEDYKBhAy76NDRtpRMjZDcTA+Vibn5jUP7cXeYHB4zt5qYusJ4UYtHbavi14v4iB3b8Xmvc62k2huax64Ei27syq3NuWkh31Hr5Ys1X6MPpDc3xmkcwk72XBjUbZqq71VwO1wm9UqWvdfvbafvn6lAALV05I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+xzgyRw; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a36126ee41eso51946366b.2
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761289; x=1707366089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jHG+muzkbV4bFwdgTxkuBTkEK2OJnBsTWFCEVngZrY=;
        b=V+xzgyRwpqfWE39ZkvcTDrj5mOVARDfc9f0+Fndw5D2vLpCsdx1SnERmMB6TK4FCaX
         jv2uY1mvoP0+K0dCBM7iERa4t4PN4jowcBz7oQF3/BvPvQnmg+oFvt4dcFHmEBNE/aF4
         xfkrI+rEYgGJUXCrM1JIczrJ9a2tMmOJ9NEetxSLmuJBd2qxqvJ0e5h5nQMSasR2TD7k
         9yInWPW/Q0C4SiJptr4AJm2vIm1oldrFmu/BY9aZK4Unj+k0EaCNpgfDTbUynJGAvmFv
         WTEXpOB8eOir5xmvnE72MA+FP/dADfYWKledhXN3N9HbinFv63Hi9ZUdy4kMJP41rvGn
         eIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761289; x=1707366089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jHG+muzkbV4bFwdgTxkuBTkEK2OJnBsTWFCEVngZrY=;
        b=lHzW0mJJ9Ku/8Xcw+s9QrrwrT/ZzJknQT4CmrOto6kvbeML+2qNA9e8fqPoYZsqtm6
         I1F22rcOFb4+4EmgYEGCACkTYM7Z0NNM/e6i34fIqxQXby7IRVdOuNTYAHQhUtaogARS
         9gLdqJ5WdCGWmmWVNZljkydjDUqc+2CFJmam9KFJ6rEmdzWjc/4oqxFaUt6KvEnWmJuv
         T4nRtddANHZA7Hh+fPVnNe8nr4SoMJqd3P8/s9JA4ynXCMfY8R8BNMppkvzn7zaG1RcR
         QpcJ/AwyaDH3I7CiseVEAdYcRGLIPFJlQhy13UXHhkO8GN+LnAxx7nxy8e+FTwsTANa1
         AkwA==
X-Gm-Message-State: AOJu0Yy4Td0fySZ2LVM/Rst0OMM0C8F7sXkUTokmPHKOrQbnQu8NRwdi
	KVefThsfGtJZNVz6YpewYYcSHwnPvx+r8BYsy1u0Aa7WRFergwxpfymFumZYr9U=
X-Google-Smtp-Source: AGHT+IHlYYcn/V+BMe7I6gj7t48GKk5F6UbXn+94t2YzfPGcvwWjPTecTx+mx0ewnFdNcNs9b0fUFA==
X-Received: by 2002:a17:906:a399:b0:a36:6a6e:8104 with SMTP id k25-20020a170906a39900b00a366a6e8104mr2296026ejz.39.1706761288755;
        Wed, 31 Jan 2024 20:21:28 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id og16-20020a1709071dd000b00a28aba1f56fsm6759608ejc.210.2024.01.31.20.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:28 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>,
	Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [RFC PATCH v1 12/14] bpf: Register cleanup dtors for runtime unwinding
Date: Thu,  1 Feb 2024 04:21:07 +0000
Message-Id: <20240201042109.1150490-13-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11863; i=memxor@gmail.com; h=from:subject; bh=ZSPFWnHn9tpYuXlwy/W39jwhB+YgpL3iD+6Fxtkp4Uw=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwQinYX8KREDrGuREgIcoEHWemmoetEzUhP6 PwyDf6PWz2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscEAAKCRBM4MiGSL8R yuBtD/0X/de92rEhn/m5jC6lF9h5mYMDS/L7StiRpBLcDz9T9ycm9Y2jrH3JSqF/VwEElFktUS/ eGn44iQuaVMcTg/TllQc1gV+wKPWBk9dV4mmUrHUcBLRLyNwci9Fnxn9RWQgZwqZ46ks54odSEy TMjtJWuKpEz38VlFR+rW+TITqtwoVt8qcgajXO0wJZ6qQOu9ReRAvCbE/pgoP5T5++Cgn1PU5q+ ayvJXpMPi3EobaxBkIvVfs9i75rQSgNF4ykTNDZu5iuir0fLFYQdoQNBrR0/hxf4dMv8gHMcXVT s0Mir2SmW+uRXv9YYPf+z5AlKU48Nap7J3lVkOgA0NWjF7uJ3nRRiBOfuyP1oNURQQzbnbwV8bN PgJNr1IVy6w9ey6odaZAjx0SXidXJdrOGXrAJ/G0m3d+YfIW7oFwO3C+IhNtQmIQc/KAKAu4UpN NzgYaZkGwql8em4YAU4VsN3nBFZAW5ucQRt7il6GOrXebfXXpHCk6zaH4SUdsVlBrbanvRkX9+H zFCMxHA66TghSBW/WCCFbqH8sSS8xYNN83xegaqkMFxnNX338bwcju9V1mg7+KWuUbfKuDQ38A2 tcSnbEDK7FlgVMHhOWzKdvNRgd4LDvjqAZmlvz1zb0y3WI6cE417N9Q7nzXeh3Tt45gLwTPKDGC Jm15cB77423yuQg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Reuse exist BTF dtor infrastructure to also include dtor kfuncs that can
be used to release PTR_TO_BTF_ID pointers and other BTF objects
(iterators). For this purpose, we extend btf_id_dtor_kfunc object with a
flags field, and ensure that entries that cannot work as kptrs are not
allowed to be embedded in map values.

Prior to this change, btf_id_dtor_kfunc served a dual role of allow list
of kptrs and finding their dtors. To separate this role, we must now
explicitly pass only BPF_DTOR_KPTR to ensure we don't look up other
cleanup kfuncs in the dtor table.

Finally, set up iterator and other objects that can be acquired to be
released by adding their cleanup kfunc dtor entries and registering them
with the BTF.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 17 ++++++++++++
 include/linux/btf.h                | 10 +++++--
 kernel/bpf/btf.c                   | 11 +++++---
 kernel/bpf/cpumask.c               |  3 ++-
 kernel/bpf/helpers.c               | 43 +++++++++++++++++++++++++++---
 kernel/trace/bpf_trace.c           | 16 +++++++++++
 net/bpf/test_run.c                 |  4 ++-
 net/netfilter/nf_conntrack_bpf.c   | 14 +++++++++-
 net/xfrm/xfrm_state_bpf.c          | 16 +++++++++++
 9 files changed, 123 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 02c441aaa217..eea1699b91cc 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -452,6 +452,10 @@ static const struct btf_kfunc_id_set hid_bpf_syscall_kfunc_set = {
 	.set   = &hid_bpf_syscall_kfunc_ids,
 };
 
+BTF_ID_LIST(hid_bpf_dtor_id_list)
+BTF_ID(struct, hid_bpf_ctx)
+BTF_ID(func, hid_bpf_release_context)
+
 int hid_bpf_connect_device(struct hid_device *hdev)
 {
 	struct hid_bpf_prog_list *prog_list;
@@ -496,6 +500,13 @@ EXPORT_SYMBOL_GPL(hid_bpf_device_init);
 
 static int __init hid_bpf_init(void)
 {
+	const struct btf_id_dtor_kfunc dtors[] = {
+		{
+			.btf_id = hid_bpf_dtor_id_list[0],
+			.kfunc_btf_id = hid_bpf_dtor_id_list[1],
+			.flags = BPF_DTOR_CLEANUP,
+		},
+	};
 	int err;
 
 	/* Note: if we exit with an error any time here, we would entirely break HID, which
@@ -505,6 +516,12 @@ static int __init hid_bpf_init(void)
 	 * will not be available, so nobody will be able to use the functionality.
 	 */
 
+	err = register_btf_id_dtor_kfuncs(dtors, ARRAY_SIZE(dtors), THIS_MODULE);
+	if (err) {
+		pr_warn("error while registering hid_bpf cleanup dtors: %d", err);
+		return 0;
+	}
+
 	err = register_btf_fmodret_id_set(&hid_bpf_fmodret_set);
 	if (err) {
 		pr_warn("error while registering fmodret entrypoints: %d", err);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1ee8977b8c95..219cc4a5d22d 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -120,9 +120,15 @@ struct btf_kfunc_id_set {
 	btf_kfunc_filter_t filter;
 };
 
+enum {
+	BPF_DTOR_KPTR	 = (1 << 0),
+	BPF_DTOR_CLEANUP = (1 << 1),
+};
+
 struct btf_id_dtor_kfunc {
 	u32 btf_id;
 	u32 kfunc_btf_id;
+	u32 flags;
 };
 
 struct btf_struct_meta {
@@ -521,7 +527,7 @@ u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 			      const struct btf_kfunc_id_set *s);
 int register_btf_fmodret_id_set(const struct btf_kfunc_id_set *kset);
-s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
+s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id, u32 flags);
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner);
 struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id);
@@ -555,7 +561,7 @@ static inline int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 {
 	return 0;
 }
-static inline s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id)
+static inline s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id, u32 flags)
 {
 	return -ENOENT;
 }
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ef380e546952..17b9c04a71dd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3657,7 +3657,7 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
 		 * can be used as a referenced pointer and be stored in a map at
 		 * the same time.
 		 */
-		dtor_btf_id = btf_find_dtor_kfunc(kptr_btf, id);
+		dtor_btf_id = btf_find_dtor_kfunc(kptr_btf, id, BPF_DTOR_KPTR);
 		if (dtor_btf_id < 0) {
 			ret = dtor_btf_id;
 			goto end_btf;
@@ -8144,7 +8144,7 @@ int register_btf_fmodret_id_set(const struct btf_kfunc_id_set *kset)
 }
 EXPORT_SYMBOL_GPL(register_btf_fmodret_id_set);
 
-s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id)
+s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id, u32 flags)
 {
 	struct btf_id_dtor_kfunc_tab *tab = btf->dtor_kfunc_tab;
 	struct btf_id_dtor_kfunc *dtor;
@@ -8156,7 +8156,7 @@ s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id)
 	 */
 	BUILD_BUG_ON(offsetof(struct btf_id_dtor_kfunc, btf_id) != 0);
 	dtor = bsearch(&btf_id, tab->dtors, tab->cnt, sizeof(tab->dtors[0]), btf_id_cmp_func);
-	if (!dtor)
+	if (!dtor || !(dtor->flags & flags))
 		return -ENOENT;
 	return dtor->kfunc_btf_id;
 }
@@ -8171,6 +8171,11 @@ static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc
 	for (i = 0; i < cnt; i++) {
 		dtor_btf_id = dtors[i].kfunc_btf_id;
 
+		if (!dtors[i].flags) {
+			pr_err("missing flag for btf_id_dtor_kfunc entry\n");
+			return -EINVAL;
+		}
+
 		dtor_func = btf_type_by_id(btf, dtor_btf_id);
 		if (!dtor_func || !btf_type_is_func(dtor_func))
 			return -EINVAL;
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index dad0fb1c8e87..7209adc1af6b 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -467,7 +467,8 @@ static int __init cpumask_kfunc_init(void)
 	const struct btf_id_dtor_kfunc cpumask_dtors[] = {
 		{
 			.btf_id	      = cpumask_dtor_ids[0],
-			.kfunc_btf_id = cpumask_dtor_ids[1]
+			.kfunc_btf_id = cpumask_dtor_ids[1],
+			.flags = BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
 		},
 	};
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 304fe26cba65..e1dfc4053f45 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2685,9 +2685,19 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 BTF_ID_LIST(generic_dtor_ids)
 BTF_ID(struct, task_struct)
 BTF_ID(func, bpf_task_release_dtor)
+BTF_ID(struct, bpf_iter_num)
+BTF_ID(func, bpf_iter_num_destroy)
+BTF_ID(struct, bpf_iter_task)
+BTF_ID(func, bpf_iter_task_destroy)
+BTF_ID(struct, bpf_iter_task_vma)
+BTF_ID(func, bpf_iter_task_vma_destroy)
 #ifdef CONFIG_CGROUPS
 BTF_ID(struct, cgroup)
 BTF_ID(func, bpf_cgroup_release_dtor)
+BTF_ID(struct, bpf_iter_css)
+BTF_ID(func, bpf_iter_css_destroy)
+BTF_ID(struct, bpf_iter_css_task)
+BTF_ID(func, bpf_iter_css_task_destroy)
 #endif
 
 BTF_KFUNCS_START(common_btf_ids)
@@ -2732,12 +2742,39 @@ static int __init kfunc_init(void)
 	const struct btf_id_dtor_kfunc generic_dtors[] = {
 		{
 			.btf_id       = generic_dtor_ids[0],
-			.kfunc_btf_id = generic_dtor_ids[1]
+			.kfunc_btf_id = generic_dtor_ids[1],
+			.flags        = BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
 		},
-#ifdef CONFIG_CGROUPS
 		{
 			.btf_id       = generic_dtor_ids[2],
-			.kfunc_btf_id = generic_dtor_ids[3]
+			.kfunc_btf_id = generic_dtor_ids[3],
+			.flags        = BPF_DTOR_CLEANUP,
+		},
+		{
+			.btf_id       = generic_dtor_ids[4],
+			.kfunc_btf_id = generic_dtor_ids[5],
+			.flags        = BPF_DTOR_CLEANUP,
+		},
+		{
+			.btf_id       = generic_dtor_ids[6],
+			.kfunc_btf_id = generic_dtor_ids[7],
+			.flags        = BPF_DTOR_CLEANUP,
+		},
+#ifdef CONFIG_CGROUPS
+		{
+			.btf_id       = generic_dtor_ids[8],
+			.kfunc_btf_id = generic_dtor_ids[9],
+			.flags        = BPF_DTOR_KPTR | BPF_DTOR_CLEANUP,
+		},
+		{
+			.btf_id       = generic_dtor_ids[10],
+			.kfunc_btf_id = generic_dtor_ids[11],
+			.flags        = BPF_DTOR_CLEANUP,
+		},
+		{
+			.btf_id       = generic_dtor_ids[12],
+			.kfunc_btf_id = generic_dtor_ids[13],
+			.flags        = BPF_DTOR_CLEANUP,
 		},
 #endif
 	};
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 241ddf5e3895..7a4bab3e698c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1426,8 +1426,24 @@ static const struct btf_kfunc_id_set bpf_key_sig_kfunc_set = {
 	.set = &key_sig_kfunc_set,
 };
 
+BTF_ID_LIST(bpf_key_dtor_id_list)
+BTF_ID(struct, bpf_key)
+BTF_ID(func, bpf_key_put)
+
 static int __init bpf_key_sig_kfuncs_init(void)
 {
+	const struct btf_id_dtor_kfunc dtors[] = {
+		{
+			.btf_id = bpf_key_dtor_id_list[0],
+			.kfunc_btf_id = bpf_key_dtor_id_list[1],
+			.flags = BPF_DTOR_CLEANUP,
+		},
+	};
+	int ret;
+
+	ret = register_btf_id_dtor_kfuncs(dtors, ARRAY_SIZE(dtors), THIS_MODULE);
+	if (ret < 0)
+		return 0;
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
 					 &bpf_key_sig_kfunc_set);
 }
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 5535f9adc658..4f506b27bb13 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1691,11 +1691,13 @@ static int __init bpf_prog_test_run_init(void)
 	const struct btf_id_dtor_kfunc bpf_prog_test_dtor_kfunc[] = {
 		{
 		  .btf_id       = bpf_prog_test_dtor_kfunc_ids[0],
-		  .kfunc_btf_id = bpf_prog_test_dtor_kfunc_ids[1]
+		  .kfunc_btf_id = bpf_prog_test_dtor_kfunc_ids[1],
+		  .flags = BPF_DTOR_KPTR,
 		},
 		{
 		  .btf_id	= bpf_prog_test_dtor_kfunc_ids[2],
 		  .kfunc_btf_id = bpf_prog_test_dtor_kfunc_ids[3],
+		  .flags = BPF_DTOR_KPTR,
 		},
 	};
 	int ret;
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index d2492d050fe6..00eb111d9c1a 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -485,11 +485,23 @@ static const struct btf_kfunc_id_set nf_conntrack_kfunc_set = {
 	.set   = &nf_ct_kfunc_set,
 };
 
+BTF_ID_LIST(nf_dtor_id_list)
+BTF_ID(struct, nf_conn)
+BTF_ID(func, bpf_ct_release)
+
 int register_nf_conntrack_bpf(void)
 {
+	const struct btf_id_dtor_kfunc dtors[] = {
+		{
+			.btf_id = nf_dtor_id_list[0],
+			.kfunc_btf_id = nf_dtor_id_list[1],
+			.flags = BPF_DTOR_CLEANUP,
+		},
+	};
 	int ret;
 
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &nf_conntrack_kfunc_set);
+	ret = register_btf_id_dtor_kfuncs(dtors, ARRAY_SIZE(dtors), THIS_MODULE);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &nf_conntrack_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &nf_conntrack_kfunc_set);
 	if (!ret) {
 		mutex_lock(&nf_conn_btf_access_lock);
diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
index 2248eda741f8..fdf6c22d145f 100644
--- a/net/xfrm/xfrm_state_bpf.c
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -127,8 +127,24 @@ static const struct btf_kfunc_id_set xfrm_state_xdp_kfunc_set = {
 	.set   = &xfrm_state_kfunc_set,
 };
 
+BTF_ID_LIST(dtor_id_list)
+BTF_ID(struct, xfrm_state)
+BTF_ID(func, bpf_xdp_xfrm_state_release)
+
 int __init register_xfrm_state_bpf(void)
 {
+	const struct btf_id_dtor_kfunc dtors[] = {
+		{
+			.btf_id = dtor_id_list[0],
+			.kfunc_btf_id = dtor_id_list[1],
+			.flags = BPF_DTOR_CLEANUP,
+		},
+	};
+	int ret;
+
+	ret = register_btf_id_dtor_kfuncs(dtors, ARRAY_SIZE(dtors), THIS_MODULE);
+	if (ret < 0)
+		return ret;
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
 					 &xfrm_state_xdp_kfunc_set);
 }
-- 
2.40.1


