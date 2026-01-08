Return-Path: <bpf+bounces-78177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A85DAD00A6E
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 03:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 493D8302B51C
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 02:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF6E26B76A;
	Thu,  8 Jan 2026 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RubomMqy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4459B26ED4F
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839120; cv=none; b=KoDJBt8x4drY5foYe8ifJoo4+FLfvJgUS1N237OocIo/ujHJrg7xcDb66rcd00TO8YigvIDLkNddPtHLWht/zFNHg3yqsRAfHpE6a4CNXQkyVumuRRBZNoQLNU5Zf2nEEE1foWMproLaBWWFJjYy2O00Zrs1e4gY13AU/z+aj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839120; c=relaxed/simple;
	bh=VH19+bgFV1Ar6zkGFMkPmgaENggN19J/WBKWnJQlIEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgEc+1yNA56QNeDcrTT61TECoETttEv8s6sJZC62mwHU2u3C3Xp1qrOSdWWSkX8E2p4ytLWp3QG9DWV1MSPG/hP27lHdty9LeOon3iBcWYpFe37q7Txncs5NKhnshx8IhMrQy3JVbApQiccI5F3hfRQkb648otKKbGgkIvjNNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RubomMqy; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78fba1a1b1eso24159387b3.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 18:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839117; x=1768443917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoUpDl8ePvedaTbwb3CC+oM/qrK1PAmOwF480RyM+do=;
        b=RubomMqy+Pc+oB70Nlf8KvAWMdqZmHa/+jWUdwdEGLMt1dwc0D87+iOZTMHwG7SFiW
         xh8XaT3NvwsdVpR9Fs/iucHSoqrRBeHcsvcRTZruTuvDHNB905pkLmNKluOpNoNNiAAY
         qqyt2HyYTcUl77LD3yR70SwmaNyud7ikc810JSCFkkZR5mtYq3OxirI4WkP4ZdRlojNl
         0xieYWkowEXcpDqVds7c+ZUIYt3okfrTzEmswKJ9BggUpsnGZDZWE/r6qDRTn+Tj54nM
         iw1Kp44/7R4MQz+uZLwvid081w4XgtBUVE7YFRTOW74n8uaqH0a+f1PlsRUn6w7rct4k
         pYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839117; x=1768443917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FoUpDl8ePvedaTbwb3CC+oM/qrK1PAmOwF480RyM+do=;
        b=NJNARrdZ7g7it837WTAeiWf4SXFca8scXJ465YQNghfpJp5c2OyDq/JhFHD4UyS/b3
         yOdJu0Mk5TCIFL3Aa89dKDgR/5H7uSnl/nFGsiAaDywkrGcAi4bzWm7sEfXSOMamXPM3
         C12mkLAolgll04nPkJCzgdGy8JaspSuvQUz0NPffDLefPIYvhYGYZ+aBpU4zPJ9P/Giu
         d7sna2II8bVnVKf98HInTVBCXSTUjaeBHZ3ZKiYs74dBlo9G2n7eGBngMk0a3qDByjNw
         WPwF4zxvMKgi2Y1B+WsOn1sOswO2s96RXzAc1R0D1ZCFpwAS2OfdzawXuajmmY6W2tuN
         VICg==
X-Forwarded-Encrypted: i=1; AJvYcCUHIrkGpDxrNjVcJ3acNsDmxgM0zh90vlVWE0Qdibasw6Et+5rny+Hy+njRGbMcGoICk9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgcRANTrVqi6LkW6yp924RoYRmYJE/8QTbAanvh7uZOoVWSgiI
	lPTkpco1IABPQCmJKbn/3y/DBjUGKlwAklM2vm63Oz9ZZhkUCZlz6Zu3
X-Gm-Gg: AY/fxX4T+vVDSD1kdmLHFe7IuAmjPj6gA+FlblYrziXqNLvotaa13OW+09XhPF6KHEB
	LhN0zl9oPiOY2O22C9vGFL8S9Vddk1b2cO7v5raQZSdO4v9ckW13fEpURTBuZx95ue0Vp1mWosn
	ZozJbBTfc7l3MnqtGDbtxMlmgwDeMAD1+4J+lTXM0ihF0rWh+tR3jORNLezZw+M7FyySWAPmZc/
	E3CX7DzozeEkSYMafp2h6xigSaeIH/GtjZJRSvbVb5qzgri3BLYu5R2G/SRgsCyXBv3/Mu1WMqE
	koxg72X3zuNLI2lthTba2Dv0CzuaGKkjzOWJyJCNHylLM7QwRhNx0NQTWmN7cQ5QW4DlzJrNEPl
	CzJJpw4zloYSoNmJc60FKn8r1uwwFBiG7+uftXsNeX3y7sMJwpPKywNDQnJeWtGfrqx4UOhOqHb
	lmkKTQQm8=
X-Google-Smtp-Source: AGHT+IHNn3z0rztu7s7lhSKQVVgaT2IbOnNBSvR2I5UE//tEV7oKfW5QbqHb7UoHopceCEaA8SmM7g==
X-Received: by 2002:a05:690c:1e:b0:78f:f30f:e74b with SMTP id 00721157ae682-790a96e817emr67416367b3.25.1767839117193;
        Wed, 07 Jan 2026 18:25:17 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:25:16 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v8 01/11] bpf: add fsession support
Date: Thu,  8 Jan 2026 10:24:40 +0800
Message-ID: <20260108022450.88086-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108022450.88086-1-dongml2@chinatelecom.cn>
References: <20260108022450.88086-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fsession is something that similar to kprobe session. It allow to
attach a single BPF program to both the entry and the exit of the target
functions.

Introduce the struct bpf_fsession_link, which allows to add the link to
both the fentry and fexit progs_hlist of the trampoline.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v5:
- unify the name to "fsession"
- use more explicit way in __bpf_trampoline_link_prog()

v4:
- instead of adding a new hlist to progs_hlist in trampoline, add the bpf
  program to both the fentry hlist and the fexit hlist.
---
 include/linux/bpf.h                           | 19 +++++++++
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/btf.c                              |  2 +
 kernel/bpf/syscall.c                          | 18 ++++++++-
 kernel/bpf/trampoline.c                       | 40 ++++++++++++++++---
 kernel/bpf/verifier.c                         | 12 ++++--
 net/bpf/test_run.c                            |  1 +
 net/core/bpf_sk_storage.c                     |  1 +
 tools/include/uapi/linux/bpf.h                |  1 +
 .../bpf/prog_tests/tracing_failure.c          |  2 +-
 10 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5936f8e2996f..41228b0add52 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1309,6 +1309,7 @@ enum bpf_tramp_prog_type {
 	BPF_TRAMP_MODIFY_RETURN,
 	BPF_TRAMP_MAX,
 	BPF_TRAMP_REPLACE, /* more than MAX */
+	BPF_TRAMP_FSESSION,
 };
 
 struct bpf_tramp_image {
@@ -1875,6 +1876,11 @@ struct bpf_tracing_link {
 	struct bpf_prog *tgt_prog;
 };
 
+struct bpf_fsession_link {
+	struct bpf_tracing_link link;
+	struct bpf_tramp_link fexit;
+};
+
 struct bpf_raw_tp_link {
 	struct bpf_link link;
 	struct bpf_raw_event_map *btp;
@@ -2169,6 +2175,19 @@ static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_op
 
 #endif
 
+static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
+{
+	struct bpf_tramp_links fentries = links[BPF_TRAMP_FENTRY];
+	int cnt = 0;
+
+	for (int i = 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
+		if (fentries.links[i]->link.prog->expected_attach_type == BPF_TRACE_FSESSION)
+			cnt++;
+	}
+
+	return cnt;
+}
+
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 			       const struct bpf_ctx_arg_aux *info, u32 cnt);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2a2ade4be60f..44e7dbc278e3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1145,6 +1145,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_TRACE_FSESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 539c9fdea41d..8b1dcd440356 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6107,6 +6107,7 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_FSESSION:
 			/* allow u64* as ctx */
 			if (btf_is_int(t) && t->size == 8)
 				return 0;
@@ -6704,6 +6705,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			fallthrough;
 		case BPF_LSM_CGROUP:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FSESSION:
 			/* When LSM programs are attached to void LSM hooks
 			 * they use FEXIT trampolines and when attached to
 			 * int LSM hooks, they use MODIFY_RETURN trampolines.
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ecc0929ce462..c65e7a70cb78 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3577,6 +3577,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	case BPF_PROG_TYPE_TRACING:
 		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
 		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
+		    prog->expected_attach_type != BPF_TRACE_FSESSION &&
 		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
 			err = -EINVAL;
 			goto out_put_prog;
@@ -3626,7 +3627,21 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		key = bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
 	}
 
-	link = kzalloc(sizeof(*link), GFP_USER);
+	if (prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		struct bpf_fsession_link *fslink;
+
+		fslink = kzalloc(sizeof(*fslink), GFP_USER);
+		if (fslink) {
+			bpf_link_init(&fslink->fexit.link, BPF_LINK_TYPE_TRACING,
+				      &bpf_tracing_link_lops, prog, attach_type);
+			fslink->fexit.cookie = bpf_cookie;
+			link = &fslink->link;
+		} else {
+			link = NULL;
+		}
+	} else {
+		link = kzalloc(sizeof(*link), GFP_USER);
+	}
 	if (!link) {
 		err = -ENOMEM;
 		goto out_put_prog;
@@ -4350,6 +4365,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 	case BPF_MODIFY_RETURN:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_LSM_MAC:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 2a125d063e62..11e043049d68 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -111,7 +111,7 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 
 	return (ptype == BPF_PROG_TYPE_TRACING &&
 		(eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
-		 eatype == BPF_MODIFY_RETURN)) ||
+		 eatype == BPF_MODIFY_RETURN || eatype == BPF_TRACE_FSESSION)) ||
 		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
 }
 
@@ -559,6 +559,8 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
 		return BPF_TRAMP_FEXIT;
+	case BPF_TRACE_FSESSION:
+		return BPF_TRAMP_FSESSION;
 	case BPF_LSM_MAC:
 		if (!prog->aux->attach_func_proto->type)
 			/* The function returns void, we cannot modify its
@@ -596,6 +598,8 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 {
 	enum bpf_tramp_prog_type kind;
 	struct bpf_tramp_link *link_exiting;
+	struct bpf_fsession_link *fslink;
+	struct hlist_head *prog_list;
 	int err = 0;
 	int cnt = 0, i;
 
@@ -621,24 +625,44 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 					  BPF_MOD_JUMP, NULL,
 					  link->link.prog->bpf_func);
 	}
+	if (kind == BPF_TRAMP_FSESSION) {
+		prog_list = &tr->progs_hlist[BPF_TRAMP_FENTRY];
+		cnt++;
+	} else {
+		prog_list = &tr->progs_hlist[kind];
+	}
 	if (cnt >= BPF_MAX_TRAMP_LINKS)
 		return -E2BIG;
 	if (!hlist_unhashed(&link->tramp_hlist))
 		/* prog already linked */
 		return -EBUSY;
-	hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind], tramp_hlist) {
+	hlist_for_each_entry(link_exiting, prog_list, tramp_hlist) {
 		if (link_exiting->link.prog != link->link.prog)
 			continue;
 		/* prog already linked */
 		return -EBUSY;
 	}
 
-	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
-	tr->progs_cnt[kind]++;
+	hlist_add_head(&link->tramp_hlist, prog_list);
+	if (kind == BPF_TRAMP_FSESSION) {
+		tr->progs_cnt[BPF_TRAMP_FENTRY]++;
+		fslink = container_of(link, struct bpf_fsession_link, link.link);
+		hlist_add_head(&fslink->fexit.tramp_hlist,
+			       &tr->progs_hlist[BPF_TRAMP_FEXIT]);
+		tr->progs_cnt[BPF_TRAMP_FEXIT]++;
+	} else {
+		tr->progs_cnt[kind]++;
+	}
 	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 	if (err) {
 		hlist_del_init(&link->tramp_hlist);
-		tr->progs_cnt[kind]--;
+		if (kind == BPF_TRAMP_FSESSION) {
+			tr->progs_cnt[BPF_TRAMP_FENTRY]--;
+			hlist_del_init(&fslink->fexit.tramp_hlist);
+			tr->progs_cnt[BPF_TRAMP_FEXIT]--;
+		} else {
+			tr->progs_cnt[kind]--;
+		}
 	}
 	return err;
 }
@@ -659,6 +683,7 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 					struct bpf_trampoline *tr,
 					struct bpf_prog *tgt_prog)
 {
+	struct bpf_fsession_link *fslink;
 	enum bpf_tramp_prog_type kind;
 	int err;
 
@@ -672,6 +697,11 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 		guard(mutex)(&tgt_prog->aux->ext_mutex);
 		tgt_prog->aux->is_extended = false;
 		return err;
+	} else if (kind == BPF_TRAMP_FSESSION) {
+		fslink = container_of(link, struct bpf_fsession_link, link.link);
+		hlist_del_init(&fslink->fexit.tramp_hlist);
+		tr->progs_cnt[BPF_TRAMP_FEXIT]--;
+		kind = BPF_TRAMP_FENTRY;
 	}
 	hlist_del_init(&link->tramp_hlist);
 	tr->progs_cnt[kind]--;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53635ea2e41b..774c9b0aafa3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17403,6 +17403,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		switch (env->prog->expected_attach_type) {
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FSESSION:
 			range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
@@ -23300,6 +23301,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_ret) {
 			if (eatype == BPF_TRACE_FEXIT ||
+			    eatype == BPF_TRACE_FSESSION ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
@@ -24244,7 +24246,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog_extension &&
 		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -24259,7 +24262,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			 * beyond reasonable stack size. Hence extending fentry
 			 * is not allowed.
 			 */
-			bpf_log(log, "Cannot extend fentry/fexit\n");
+			bpf_log(log, "Cannot extend fentry/fexit/fsession\n");
 			return -EINVAL;
 		}
 	} else {
@@ -24343,6 +24346,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_LSM_CGROUP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -24509,6 +24513,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
+		case BPF_TRACE_FSESSION:
 			return true;
 		default:
 			return false;
@@ -24590,9 +24595,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 			tgt_info.tgt_name);
 		return -EINVAL;
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		   prog->expected_attach_type == BPF_TRACE_FSESSION ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 		   btf_id_set_contains(&noreturn_deny, btf_id)) {
-		verbose(env, "Attaching fexit/fmod_ret to __noreturn function '%s' is rejected.\n",
+		verbose(env, "Attaching fexit/fsession/fmod_ret to __noreturn function '%s' is rejected.\n",
 			tgt_info.tgt_name);
 		return -EINVAL;
 	}
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 655efac6f133..3b0d9bd039de 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -685,6 +685,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 		if (bpf_fentry_test1(1) != 2 ||
 		    bpf_fentry_test2(2, 3) != 5 ||
 		    bpf_fentry_test3(4, 5, 6) != 15 ||
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 850dd736ccd1..de111818f3a0 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -365,6 +365,7 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 		return true;
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 		return !!strncmp(prog->aux->attach_func_name, "bpf_sk_storage",
 				 strlen("bpf_sk_storage"));
 	default:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b816bc53d2e1..3ca7d76e05f0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1145,6 +1145,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_TRACE_FSESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
index 10e231965589..f9f9e1cb87bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
@@ -73,7 +73,7 @@ static void test_tracing_deny(void)
 static void test_fexit_noreturns(void)
 {
 	test_tracing_fail_prog("fexit_noreturns",
-			       "Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.");
+			       "Attaching fexit/fsession/fmod_ret to __noreturn function 'do_exit' is rejected.");
 }
 
 void test_tracing_failure(void)
-- 
2.52.0


