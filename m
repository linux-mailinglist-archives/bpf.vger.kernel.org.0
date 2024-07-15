Return-Path: <bpf+bounces-34853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7C2931D69
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1511C214DD
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 23:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF82143738;
	Mon, 15 Jul 2024 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htWefzjA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E761C13E88B
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084550; cv=none; b=JlI1GGFu/JLvhdhuVuqXtiJKJOpebhnOUTC3OGyp4P4DAVBFxiOXf/POiJvnig3feffpOZmaghdt7hYZGeI3CWQXFYepjQfmsDqJXSuwb72ssKSbm//tIlDY0NKnJunwu3uc14MQ6jj6zRjK6H2dbBeNnDzxpFSRanE/2Jn2Mh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084550; c=relaxed/simple;
	bh=7prInfI/5GZApFnoJnQaZKAb4LIudu4TCYFYsFK4BQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNaJ91b+NavOni/h3t9AMJXgU76f+FozB1/yj/lTAjpOG4XrsNiwkwBtxDIK2yTs+CBH4N2TErACCjUocqSViet4b/kkLPmfZBuTG6j7mRcePlR/JCKd+6URMvX0eFm1BCe3QFJ0CDXNapq8agx9fp7jkRlnESfkR+M0RFPs0/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htWefzjA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70b1808dee9so3194848b3a.2
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721084548; x=1721689348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZu2FQzE3OujfDryDYsk+2bhemJiXfipmm1gVXp59Ag=;
        b=htWefzjALZ0Mpx3RuDkecwshdmy/E/saVBwYnai3y08szEpNBw+R3V6ox+l+zvYo1f
         sv7Y5PsCrD3Eo4O0OWpHrjYkanHRkYOT6weMEDKIPWMb+nGiWW7FFQLTQvTmokoNm/m7
         znsrPmMq2uGYR09CgoUNw3TKZLIGQnTKKRIhjcp+2reJtCuK8AfQw4O4oofX/NtArO1m
         uM9JIeScg9m948AV4cSvBB6oP6B3Ye0FL2r5MoO8pik2BQwXXF/2q5MsNpQAOx3y2Ize
         FZvR47M+za7+BHWHjk8hxuc+eTxGSQazZEs5iJaeZA5LOHPdWXUgvXDiPif1Tje0MrOI
         XNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721084548; x=1721689348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZu2FQzE3OujfDryDYsk+2bhemJiXfipmm1gVXp59Ag=;
        b=fEkf3VzZ3UNQlKvxOM2gPMeTVCfHkG0RlpZ1GunYDJRmbkcPkbhDwe9U5vkR4QqUeD
         XRbyvhUPpCC871ednZeB/jlMOdqN+pAEzktihc9D7OSILBfgv/S4b0w96e5n7zlEvr9r
         grtmGA/1824mKYTBxyd2wQ5QWir2brG+1F2+R1b7/5ndYJ8sjoWBlcyFyLj9Ea58TwCx
         H19NqDdFtsjTOjUpX4fPkpRgPjFKx7hj0y/mrlt55l08YBmfpPyrZdGLlVbeFVCgpcPp
         IQAoqBw5dLb3nxZXqaB7F6JelzE7S1VhjXCc+HyUsKpfSUOuz6OhuxMHzdIona7ZOQMv
         LItA==
X-Gm-Message-State: AOJu0Yw+R3CCm9qwDTk69jhrOoBmID7CFONJqSBoum8cToEeBV/KVL+h
	fxH5pFxdQKKBuCaShZwsbt1N1AtmKvnXAiRF4oPEZcg7FIqE3ZSRwTCz4Q==
X-Google-Smtp-Source: AGHT+IGR4N5fTD8OkV6sxz3/zUw7tX8BzszVIGvZAU/XeUocVHv9KZPH4JTX1iDJSEV6lqxapdlzKg==
X-Received: by 2002:a05:6a00:b45:b0:704:209a:c59e with SMTP id d2e1a72fcca58-70c1fba0bb1mr634579b3a.9.1721084547695;
        Mon, 15 Jul 2024 16:02:27 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc9d36sm4915344b3a.205.2024.07.15.16.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:02:27 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [bpf-next v3 01/12] bpf: add a get_helper_proto() utility function
Date: Mon, 15 Jul 2024 16:01:50 -0700
Message-ID: <20240715230201.3901423-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715230201.3901423-1-eddyz87@gmail.com>
References: <20240715230201.3901423-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the part of check_helper_call() as a utility function allowing
to query 'struct bpf_func_proto' for a specific helper function id.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c0263fb5ca4b..3cef46134a51 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10265,6 +10265,19 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
 				 state->callback_subprogno == subprogno);
 }
 
+static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
+			    const struct bpf_func_proto **ptr)
+{
+	if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID)
+		return -ERANGE;
+
+	if (!env->ops->get_func_proto)
+		return -EINVAL;
+
+	*ptr = env->ops->get_func_proto(func_id, env->prog);
+	return *ptr ? 0 : -EINVAL;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -10281,18 +10294,16 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	/* find function prototype */
 	func_id = insn->imm;
-	if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID) {
-		verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
-			func_id);
+	err = get_helper_proto(env, insn->imm, &fn);
+	if (err == -ERANGE) {
+		verbose(env, "invalid func %s#%d\n", func_id_name(func_id), func_id);
 		return -EINVAL;
 	}
 
-	if (env->ops->get_func_proto)
-		fn = env->ops->get_func_proto(func_id, env->prog);
-	if (!fn) {
+	if (err) {
 		verbose(env, "program of this type cannot use helper %s#%d\n",
 			func_id_name(func_id), func_id);
-		return -EINVAL;
+		return err;
 	}
 
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
-- 
2.45.2


