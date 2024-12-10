Return-Path: <bpf+bounces-46487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A147B9EA718
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAA1188AE39
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 04:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EBF226181;
	Tue, 10 Dec 2024 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by8qyGAY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585622578E
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 04:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803881; cv=none; b=PZ0TVR6zKSCTW246aSAxtXj09T6Rp+U6yqxg3zleOOQD57JsatyAMS2gW2pmHDboAvRqzcTzZhMaXYNLygWsGj9JxoVVOv/t/0zgi1KfljJtKKG66qiT4uFLE9S0+WZrgjOH2ZqC2onRcQDXCFQPr9vljX92iorH1iMxp2NK4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803881; c=relaxed/simple;
	bh=Hcc9UsySMTbXqeCveyrKB76fa3d50tQ5MKht1qHx3RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kt/rpsT+zbyV0sv7BJ0VE31lqXfztSbCClpmfLj5fwS3dI6s/mT0b46143KBBfXC6uTS94kk/PxbichrHf+G4jPKONogBR5CYGimFTDtcNpqp3RPfAx6yXdQmAuMRvubVuhS+Yern8VqbRkPB1vVFoPPFE6JhKiVpLwGBoyq2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by8qyGAY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21631789fcdso14783495ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 20:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733803878; x=1734408678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwPZMQhI00m6ciQ91kVp9l5KLtSM+iYorvVb0YUw0d0=;
        b=by8qyGAYQOH9mwBOUT/hgxiwSDyA1gGilp0u2pGojyrXEgAsOVZ1HETlU+DnvzTrmt
         B+nyhNRyqSnoInJEwmQ7QFhr5PafgWtACZdnhX9UFt1MIyOJVHFojHbLpCJ1kzor8z79
         bYOWq+jdF3QjUK/qtVQ7ip/DHpXIwxM7O3LnqSZ6SFFrzYZmshZVBFYKpm1Mk3RWNrOZ
         X2C7k0wLmUuDC17eiSQMHIOPNx5ae42jmOVTS/WxVC6+HU3IN/LkQ/gUj8ozqrhZFpdH
         iSs/kVzlBbD9yVPr8zlFJWciiiThdQBYcCg2kg8GE9KftOQIFUJXY1yjGF7/BxVzg5V5
         fUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733803878; x=1734408678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwPZMQhI00m6ciQ91kVp9l5KLtSM+iYorvVb0YUw0d0=;
        b=WOKCppKd8IMsYyIW1iaj2l3T3K3x8+hCES+2SxcGfSk+hxON/ZAYUQYbHhmUPfeyW/
         bvO2+5WXBvHmv3FbOK3ejAOUvfwpqU3x2IuO5y99TnXPEVgm4SllN//dorP7oyUFFy1c
         uvX8frTMsaVa8Rmi6MKIa66t5fzq/BgFl6uHr+wAoxiDZSBvBI1tJ5DdbDLx4tu3lxDI
         nE9wH2B8W+cKdxfrjIRUTfSV1zRWnb8aMDbEvuSVzCQlYIyoJbbk2I5JOLvI0YIKG454
         odIksrUBqJ0XeRONnN+5lhr9RbVknUhP6pxoKWc8W36qf4Ms0XsJ88fp93TT33ulk7Af
         0r9A==
X-Gm-Message-State: AOJu0Yyl7gZx/ZFFFzLW9YItqbmhDgqGMy6V3ylaCJJm8s+it7mucGgc
	5dPRvnzldNjcvcSBnyDczD8GPcW0mn4DqRqC+d6xYrLjKj2nRWd+n+McxQ==
X-Gm-Gg: ASbGncuI7kdNvppoQUl+jFVuzTBg4rNYcqS4WlZStC2nv45em+ow5oGzOoIPKQSrByH
	h66I9zGfIRXHV3w7O2+9pYko8rFLjd2GlSmIgUQ5mQJEULCp+IisMFV08lQvyn1igXqet3T3yuT
	VbZWsP/niwqmV8lu0ojRh2rDn/y7Q0ZNZ7i9uRHfXvhoATZEjSvFS/ALMC825c7JOqEsnNOm6C2
	LdJpMd90qs/RFobbnToS6U6xyYgx3HOITcPLk21k1PsVCSt2Q==
X-Google-Smtp-Source: AGHT+IGCXcBBeSpxglu8urOHhS1eJ7Ytj9Lss1hk8e3k7SEfxvu8sDPpSo8eNTV/M55SEzfS3od06w==
X-Received: by 2002:a17:903:22ca:b0:215:7e49:8202 with SMTP id d9443c01a7336-21670a19629mr35934575ad.13.1733803878162;
        Mon, 09 Dec 2024 20:11:18 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21631d6b3b8sm44296265ad.136.2024.12.09.20.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 20:11:17 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	mejedi@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf v2 5/8] bpf: check changes_pkt_data property for extension programs
Date: Mon,  9 Dec 2024 20:10:57 -0800
Message-ID: <20241210041100.1898468-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210041100.1898468-1-eddyz87@gmail.com>
References: <20241210041100.1898468-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing calls to global sub-programs, verifier decides whether
to invalidate all packet pointers in current state depending on the
changes_pkt_data property of the global sub-program.

Because of this, an extension program replacing a global sub-program
must be compatible with changes_pkt_data property of the sub-program
being replaced.

This commit:
- adds changes_pkt_data flag to struct bpf_prog_aux:
  - this flag is set in check_cfg() for main sub-program;
  - in jit_subprogs() for other sub-programs;
- modifies bpf_check_attach_btf_id() to check changes_pkt_data flag;
- moves call to check_attach_btf_id() after the call to check_cfg(),
  because it needs changes_pkt_data flag to be set:

    bpf_check:
      ...                             ...
    - check_attach_btf_id             resolve_pseudo_ldimm64
      resolve_pseudo_ldimm64   -->    bpf_prog_is_offloaded
      bpf_prog_is_offloaded           check_cfg
      check_cfg                     + check_attach_btf_id
      ...                             ...

The following fields are set by check_attach_btf_id():
- env->ops
- prog->aux->attach_btf_trace
- prog->aux->attach_func_name
- prog->aux->attach_func_proto
- prog->aux->dst_trampoline
- prog->aux->mod
- prog->aux->saved_dst_attach_type
- prog->aux->saved_dst_prog_type
- prog->expected_attach_type

Neither of these fields are used by resolve_pseudo_ldimm64() or
bpf_prog_offload_verifier_prep() (for netronome and netdevsim
drivers), so the reordering is safe.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/verifier.c | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eaee2a819f4c..fe392d074973 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1527,6 +1527,7 @@ struct bpf_prog_aux {
 	bool is_extended; /* true if extended by freplace program */
 	bool jits_use_priv_stack;
 	bool priv_stack_requested;
+	bool changes_pkt_data;
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
 	struct bpf_arena *arena;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6a29b68cebd6..c2e5d0e6e3d0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16872,6 +16872,7 @@ static int check_cfg(struct bpf_verifier_env *env)
 		}
 	}
 	ret = 0; /* cfg looks good */
+	env->prog->aux->changes_pkt_data = env->subprog_info[0].changes_pkt_data;
 
 err_free:
 	kvfree(insn_state);
@@ -20361,6 +20362,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->num_exentries = num_exentries;
 		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
+		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
 		func[i] = bpf_int_jit_compile(func[i]);
@@ -22225,6 +22227,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Extension programs should be JITed\n");
 				return -EINVAL;
 			}
+			if (prog->aux->changes_pkt_data &&
+			    !aux->func[subprog]->aux->changes_pkt_data) {
+				bpf_log(log,
+					"Extension program changes packet data, while original does not\n");
+				return -EINVAL;
+			}
 		}
 		if (!tgt_prog->jited) {
 			bpf_log(log, "Can attach to only JITed progs\n");
@@ -22690,10 +22698,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = check_attach_btf_id(env);
-	if (ret)
-		goto skip_full_check;
-
 	ret = resolve_pseudo_ldimm64(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -22708,6 +22712,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = check_attach_btf_id(env);
+	if (ret)
+		goto skip_full_check;
+
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
-- 
2.47.0


