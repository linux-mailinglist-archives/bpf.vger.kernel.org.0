Return-Path: <bpf+bounces-68888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB5CB87B53
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771753A892F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9195A26FD97;
	Fri, 19 Sep 2025 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1o2JJUv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A325B2E7
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248345; cv=none; b=YoZkMSG+OlXTHnxQZeRu6MEUZiBcetfctIuw7K9rhClpJmQjLknDuO8Fq6WZVP1aSqruaLIcaxJb+rvzV3cf/PWNy+0DuEF2aSmZiMGgIS+2PTta9bWVDV48YpEsur8Yk/jklw9/zKLZeDExcl48pkiFW0R7L25MG5awcfEKPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248345; c=relaxed/simple;
	bh=5riqiPhYwZAuClykhEXTE1yRDlbr0ivYxJWlmpayt3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdBw3+xkhDljS2J9+n2xCAXv5yPpjaMxoFzcxgMUHUEmwMlFJtG3zVTH3i4vCM9BRjvHc05ej2iVClntRzkOBhBuY+ne65rNTOUf6CCi+xjGsFQO5baiGN4d3/TicO/7VOl+WhSXaf4Sc0p8YZA6zYwnujpM3glCEuFiaJbdZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1o2JJUv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-267f0fe72a1so10205415ad.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758248343; x=1758853143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=augIrb/pJO40UWpSxQKJZ8udaMStVsRGwui2gczqMug=;
        b=e1o2JJUvQvMiOknbUFrAdIqNlnTQaiR9ZebOr2m1qcZ73BoF2VB6WPlllpvXWHWdj4
         jKzImIkEjdCoZZkakJAFoRz6y+PKrPhv7H5VGGmeTrRC4GA1mIGUdLjCLryAI5UJUH+h
         PFNhbvTaGTXtobvU/raqjto+/At9AkTXJ8K2BiSQ2ldPSI3gmkDlPbyD5PEh3RO+HEGp
         qJSqBTDttVNoMS5Qt5m6+nKycXOzCNUobY5vEyAHSWygOPTCdZvWH3GKBeA7No0rlm3a
         HE6WEzj/kJXT71cMW/64hGQNitxAlLk0TpQ8xEwXjAMN3604IQJeILo46b9iiZIq/XVm
         Brcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248343; x=1758853143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=augIrb/pJO40UWpSxQKJZ8udaMStVsRGwui2gczqMug=;
        b=dWsW4e04UaOpS0HX+JlXQDLQz0z8QxnO2AG2nwLpR9ELOgi/FLSXrM/vh++RAqJHUh
         /ulM4SQYL9mAY8FA3FMytJK/W3fpLhSoPEtGWPxXPkuVb/gSjgiE7OWi7BVQ9WVYl5D+
         wcFU1fj7j0/9XI1/KVMF6xaCGzTixaVXD2zIDU9NtnXd3nvhrDRXHxyJwDkxGflrR66T
         e7R4qSZoa9szeaTg7ett0ojAnQAgQ1vb0Exav0eNvooV0PPGbutU5kfIKeDBvjGAC/z5
         RddDikVXIdpXu6O+wpTRWoguldkS84juaNCbrySd08SsmzQfwffAweiuSbZl7g/GcqCq
         SQCw==
X-Gm-Message-State: AOJu0Yw60bxmT4twKlkVNRkkSPtGXhLtCcGDI4u7yeGGy1IkkV1im6yk
	RILHIQSH7CWOIr/Hm+j+KWt8Rx9+3UHTWTqByeypRZ/sMVH0fjH5BJDSJ8qaJQ==
X-Gm-Gg: ASbGncsvLWX+aSrQpt3YMQnXb5/5jy63Kb/4SFcJLeqz0RXv6zPayLBkshWXJ+XgpsR
	qN9sWyCSb+qObfAJy1TdA5DpEEo/r1nPWQZDFSji7YPmu4WntK46ssDb+XGMxh7gDMcyQiMt+KX
	tNAXN/gej+LeAMxVoYQEp3W7bI6jZ2XQQxH5j2vyXmmu0w1z8Bca8Jj3ZHSgquNiQehrS3bVnCO
	/XGsk3Hhwsf2NfB8YjN/9aN9DuzwV56T9WmSgHPu8Mlyl10YQMafuyEpHOyk1FQhWi4RwQDB7vR
	mNuoiC1bUmUvV7cfCQ2Z5f5KsMwLBbq/omc5KabfvXeOx61FcAvTbjt74yG6AauITfrgAblaY5U
	f2Y6sNxl2bO4xy+/D
X-Google-Smtp-Source: AGHT+IEaMgY47rdK7GcxuKeyKd7u5QfwJalIG0C68U9kXBm+ji2sbIRrm38T8qVTYOWJfgjrlw+ZDA==
X-Received: by 2002:a17:902:da8c:b0:267:c172:970a with SMTP id d9443c01a7336-269ba426240mr30181015ad.17.1758248342669;
        Thu, 18 Sep 2025 19:19:02 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033a3e5sm39186235ad.126.2025.09.18.19.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:19:02 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 02/12] bpf: use compute_live_registers() info in clean_func_state
Date: Thu, 18 Sep 2025 19:18:35 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v3-2-c3cd27bacc60@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
References: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Prepare for bpf_reg_state->live field removal by leveraging
insn_aux_data->live_regs_before instead of bpf_reg_state->live in
compute_live_registers(). This is similar to logic in
func_states_equal(). No changes in verification performance for
selftests or sched_ext.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 02bfe3e4a2f01ed702fa14ee49374444fb7efe2d..62eb6e92e897d12e12226fd9ff172cb0ccf76119 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18489,15 +18489,16 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 }
 
 static void clean_func_state(struct bpf_verifier_env *env,
-			     struct bpf_func_state *st)
+			     struct bpf_func_state *st,
+			     u32 ip)
 {
+	u16 live_regs = env->insn_aux_data[ip].live_regs_before;
 	enum bpf_reg_liveness live;
 	int i, j;
 
 	for (i = 0; i < BPF_REG_FP; i++) {
-		live = st->regs[i].live;
 		/* liveness must not touch this register anymore */
-		if (!(live & REG_LIVE_READ))
+		if (!(live_regs & BIT(i)))
 			/* since the register is unused, clear its state
 			 * to make further comparison simpler
 			 */
@@ -18518,11 +18519,13 @@ static void clean_func_state(struct bpf_verifier_env *env,
 static void clean_verifier_state(struct bpf_verifier_env *env,
 				 struct bpf_verifier_state *st)
 {
-	int i;
+	int i, ip;
 
 	st->cleaned = true;
-	for (i = 0; i <= st->curframe; i++)
-		clean_func_state(env, st->frame[i]);
+	for (i = 0; i <= st->curframe; i++) {
+		ip = frame_insn_idx(st, i);
+		clean_func_state(env, st->frame[i], ip);
+	}
 }
 
 /* the parentage chains form a tree.

-- 
2.51.0

