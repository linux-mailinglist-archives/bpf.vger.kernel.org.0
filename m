Return-Path: <bpf+bounces-33876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86949273F0
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 12:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6315C284F1B
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 10:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3F61AB919;
	Thu,  4 Jul 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzPzzOtB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68391BC4E
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088662; cv=none; b=Jvsxw5LfK5t+QXrH66uOtAYxcao/JjavJClMvIV9ImYtkKfzH/TEgu3FtTfBaiQCPCr3aLiuPwn0ELHJNdVUwqkyJtCrkNvEPJc3miJFSKyP8VdgcEcLePvAVkQZhwKrIGAMaGo+KtGvJpkyK5XoDdYz9q8mTLKH2OIGlyCft4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088662; c=relaxed/simple;
	bh=MjIfO8uP/iqo7X+m/k1uKOlGdQI8ptMEjXgjANf3WUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUAyVhSiEDR5GNfwUxDgtDEanhxMXfg2wzVCEDgj460ZfIt6sxsjCyNKVb/sxy0cn0VsjpuIn24zJl3HD1VSVfMsT20YlGMmEY3uqP0yIiVEtVqyJa2KrBjbQwDDFNhtCdMB+UDpFmGNS79JK5y5tr/iU4otCmdyDaZtzsSNPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzPzzOtB; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c2d25b5432so342349a91.2
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 03:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720088660; x=1720693460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xXAwELzpALDrMLBpWnJA7MUy/dCPT5AhcwukZUjp2Q=;
        b=LzPzzOtBk2JtvrVc4y1xQocKVN3teM5I51MnV/w3Y32zvl58ewWjjLy5eQrSy/XRLr
         R1Cb930/Hj70C1ZmsdVnS80NKdcGYpYbN/U/5Yn6eB3WyaiptcRnsrv+9qbqk/U3zosb
         bgucHCXc7QRrDRGfJYALzeojveWDPEwzLxqNIsoUWLjUoxc9jGBmCuZQuqG74bYma6Xq
         bDDHCgZS5aKAkIgkB6qxr9WPndgXoNqFwkiXc1LCS0EHUPpG+N3le3+SdrAewJixoDGK
         RjT/M3hAj1IdaFgaW6LS94lgducoGBbVHJ2VBGeIEK1Oau5bSrFjDS++PDWIErr/IHSA
         Macw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720088660; x=1720693460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xXAwELzpALDrMLBpWnJA7MUy/dCPT5AhcwukZUjp2Q=;
        b=WD6y2wPMzgx9YabBTrWWrfY/0CLwaTQu+ID+g+vkB2nRncSWS4mGAvPDvht6NaYKzV
         6GqVEBoP9OBhIBpSv5i/PEhKPjZssYKx5Bs/ccqyE6eg2j5QDE+Q1eX4OvvAm7nu4hfK
         Dlbss3XDdydO00riy8z0eUvnEMDhkWQshBJqtLiBn0ucI0Eno5+azCvQBxlCR/XCrr+v
         N1EXzQBXch81BzAJ0jHRHKAEsb8t0mJu4+SpoHgRZWfihWqFVCpKC+giqToMS9p52Og1
         Amd04Xl1c6ASczGfaSeiFnYESP1QGNQaEKJUY6yt3/PMzWynx7Rp3VtP5O0eTOQeRSJU
         MjXg==
X-Gm-Message-State: AOJu0YxRAI+Hbe1kARWeKIQCo/Xd0IsuH8fyWS3gH51W2TF2ZAS/ogMA
	5N3YiuxFP3N3rAXR5feBfq+6o4jKNkfFSpBC09CXZfBHadSfBlWqtnkP9Q==
X-Google-Smtp-Source: AGHT+IFfi61otj6tqEHL/209wfyCVMD19buRhcnSRUoMIIvXE68U0iW9lE4e1v3vywyJNiFuDdI/sQ==
X-Received: by 2002:a17:90a:34ca:b0:2c3:7e3:6be0 with SMTP id 98e67ed59e1d1-2c99c6e49bdmr889804a91.31.1720088659850;
        Thu, 04 Jul 2024 03:24:19 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c9a4c0fe8dsm216693a91.0.2024.07.04.03.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 03:24:19 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v2 1/9] bpf: add a get_helper_proto() utility function
Date: Thu,  4 Jul 2024 03:23:53 -0700
Message-ID: <20240704102402.1644916-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102402.1644916-1-eddyz87@gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the part of check_helper_call() as a utility function allowing
to query 'struct bpf_func_proto' for a specific helper function id.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d3927d819465..4869f1fb0a42 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10261,6 +10261,24 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
 				 state->callback_subprogno == subprogno);
 }
 
+static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
+			    const struct bpf_func_proto **ptr)
+{
+	const struct bpf_func_proto *result = NULL;
+
+	if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID)
+		return -ERANGE;
+
+	if (env->ops->get_func_proto)
+		result = env->ops->get_func_proto(func_id, env->prog);
+
+	if (!result)
+		return -EINVAL;
+
+	*ptr = result;
+	return 0;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -10277,18 +10295,16 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
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


