Return-Path: <bpf+bounces-59100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2841CAC605B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E18168031
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A61219A8C;
	Wed, 28 May 2025 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbv1heEL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9DB218ADE;
	Wed, 28 May 2025 03:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404202; cv=none; b=K1JZFt3dokFLmMykTXb/O1+lnaIQJoCMK+HaR/ItZXznQyQ6mVr93Eu0E3olH/UKqhUF1sZm+8nBuSK5jHB19oexhVAWRmt3WW1meUTD214XA6q6uJ0yQICuH9PzipS3p2P0QizvSJDiyRAdLgZw3aFWH7REPwAb/Jv4swMmSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404202; c=relaxed/simple;
	bh=XfHTqGgIuYKDaki6V1V1qv8At05h/K/OYdumPMde5mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m8hcvXczdKFzgZYT/WINiNLxJiLwgXjJQ4X0+gBTDpydKkW+6QR/Tj49KSLqS20SaEcq9g/2mqA0SIgW2ztAL+zDPffe1ns2Slg36BwglnD22bf/FQAftByD3J393a3iDzJvpxrgawJr/7Kp0pwhjmmx7XrYNlzMly6/IaZi9h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbv1heEL; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2347b7d6aeeso25626295ad.2;
        Tue, 27 May 2025 20:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404200; x=1749009000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7XLlY7hAS+lvBDHPoWxg90r1GSSdzm3rmlEr8zDuWw=;
        b=mbv1heELfk+dc+hyx+YuDRJ6RzNzVgkmCFf16r5kUaeJHS6AgtX0KAtS7b9ZeiVKWv
         lau4YzIU4/xXLKpcF1W7G7vM0Fi6mjtcVwPV8syKHNP2b6gL8NVRt2Ei/6UQlM5B8rWx
         tZ1NCkH7fkgiLGb9LYO0QuzLWgVfTwIAZShsxukTe2qyhIJHPui+rFtXOHGD1XsVbSp1
         pMlz5dJvQMhxCkQuESu0JRP4ZSPeOxWWEFZ/XwJQ13IvVQwrhXZEN8lucHwKejdfaR7u
         BoQk64JaRC2bBf7fFyxSx6KsdBTvcGa8sfOCNib6JtoAbnpriA/C7en9WhsbafiqkThe
         qwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404200; x=1749009000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7XLlY7hAS+lvBDHPoWxg90r1GSSdzm3rmlEr8zDuWw=;
        b=W1ykDD5BmExx2X8VlF7Uy94/FJa8hHfAbxGspdRbddxXWYtSuXYIzP//A9IzNOCj3l
         Mb2k63lrQcIgRrLm3IIDuHGmgLHXDuvXbHiMmKwpO3UMryd62Au3homWqVk7POsXwuLx
         HxuR7v0GJmwmcB55hD9XZAtzSjwUxxcXFdReqEUxysTpKi+fzTxp5+Sp2FB9VFgbO0Jn
         wlRPpRXLQetlkKwYMWFGx3PQReFIZnd0Nh2RCl+SImO6qLu6OZK1cC4AXBlEK+Eiifvk
         KTcP4Ec2ZljFu6nde2Q39s+Lp7HArn7fWCn56BvCZeKkRwlp2qUfUWUv9r+1ySpVvaFC
         TpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCViEFtoOATvda8jCqf8abdfs8iJKl06JXLPmHxFEWKKmxnxpPMLniNAFiZnlNYyQU49SUBedo8gIX+geXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/wgFQnnd4cqdmVz38ug2bemAleT4b4u0lL117P52rjX+Et/u
	wz4AbRzn46YMEXg78vtoX4khbyh8VPOSerafdgS97Uf6i/To8D3i7Xhc+hb03yrg
X-Gm-Gg: ASbGncseaoQ+/qFOiOe5N/JmA0kk+JqvuvEWVm6fNF902yw+raK14kuvchP0OGji901
	t8VgrKqO8HgMs6VoRZLTL6cHjEm5p2nxDjYJ7XBTwS+NVdU5I/8Tcrslfpbi/Izw75Z0cDONfNJ
	ps8kFvLxuutTr9KuufDSgN7rSV+790KM1KqmXTH4LNX7pfh997viNbh4pwYguMUAwh/fcn6SgEn
	Hg8Hy2A7QcKi/+S/S+DtLm5DMQ4WlQBvI6b+jXCkIkW14Vxiq+Y9kT+HSCAkZF7z2A59SyRmwT8
	WGgmxQEasJ9QZI/NASHCjefZlVeP0HiUGJsGc+X6ziEmlC9qKufE1/I1NGq8fAQ7JANSqu6ZZ2U
	WTh4=
X-Google-Smtp-Source: AGHT+IFgGdV9N1DbyDMHm8JQfixq2yy5gE1OVQFBwQtcwt5vNfeEYP2KUBZc9OT9Zl5GgvxilgA5CQ==
X-Received: by 2002:a17:902:c412:b0:234:a44c:ff8c with SMTP id d9443c01a7336-234a44d0091mr58217715ad.18.1748404200323;
        Tue, 27 May 2025 20:50:00 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:49:59 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 11/25] bpf: verifier: add btf to the function args of bpf_check_attach_target
Date: Wed, 28 May 2025 11:46:58 +0800
Message-Id: <20250528034712.138701-12-dongml2@chinatelecom.cn>
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

Add target btf to the function args of bpf_check_attach_target(), then
the caller can specify the btf to check.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/syscall.c         | 6 ++++--
 kernel/bpf/trampoline.c      | 1 +
 kernel/bpf/verifier.c        | 8 +++++---
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 78c97e12ea4e..85ed52a4e50b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -894,6 +894,7 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
+			    struct btf *btf,
 			    u32 btf_id,
 			    struct bpf_attach_target_info *tgt_info);
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e22a23aa03d1..60865a27d7d3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3593,9 +3593,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		 * need a new trampoline and a check for compatibility
 		 */
 		struct bpf_attach_target_info tgt_info = {};
+		struct btf *btf;
 
-		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
-					      &tgt_info);
+		btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
+		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf,
+					      btf_id, &tgt_info);
 		if (err)
 			goto out_unlock;
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index be06dd76505a..3d7fd59107ed 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -907,6 +907,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 	int err;
 
 	err = bpf_check_attach_target(NULL, prog, NULL,
+				      prog->aux->attach_btf,
 				      prog->aux->attach_btf_id,
 				      &tgt_info);
 	if (err)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d5807d2efc92..b3927db15254 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23078,6 +23078,7 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
+			    struct btf *btf,
 			    u32 btf_id,
 			    struct bpf_attach_target_info *tgt_info)
 {
@@ -23090,7 +23091,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	const struct btf_type *t;
 	bool conservative = true;
 	const char *tname, *fname;
-	struct btf *btf;
 	long addr = 0;
 	struct module *mod = NULL;
 
@@ -23098,7 +23098,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		bpf_log(log, "Tracing programs must provide btf_id\n");
 		return -EINVAL;
 	}
-	btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
 	if (!btf) {
 		bpf_log(log,
 			"FENTRY/FEXIT program can only be attached to another program annotated with BTF\n");
@@ -23477,6 +23476,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	struct bpf_attach_target_info tgt_info = {};
 	u32 btf_id = prog->aux->attach_btf_id;
 	struct bpf_trampoline *tr;
+	struct btf *btf;
 	int ret;
 	u64 key;
 
@@ -23501,7 +23501,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	    prog->type != BPF_PROG_TYPE_EXT)
 		return 0;
 
-	ret = bpf_check_attach_target(&env->log, prog, tgt_prog, btf_id, &tgt_info);
+	btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
+	ret = bpf_check_attach_target(&env->log, prog, tgt_prog, btf,
+				      btf_id, &tgt_info);
 	if (ret)
 		return ret;
 
-- 
2.39.5


