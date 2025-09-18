Return-Path: <bpf+bounces-68840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAF4B86830
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D9916A47B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DA92D3A9C;
	Thu, 18 Sep 2025 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itjplROj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B529A9CD
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221288; cv=none; b=usqSY53Vif9NOV4YyDbolMvtlPG9oBPEBJrPCKxrj7H5JsFYktiFKyRElqn1gQmPyihyvryPYjQLoN1TP7Cr9ZuOAyeSHh+ZmIMjCXNVSuXuAbF09yGBcRlMWCPG5cniqSDHZd/5m0QovCHHVFzsu1xDw1uOpUe6BKMu+bqC7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221288; c=relaxed/simple;
	bh=+dIgtOL6B11dhU9LUTehvO0482fIII//FtqSfrn3iL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kkd/FOTED2daUMmLuSyAejpvvR6+u8AwiGj23ObeCI8xPe7INBMzn5xXldewl35B+esSj7kkMi3RQS6iwiSkqWTfux421iz3XI0uG0PIi+zTm6K8SB+pkDrncZfwkRP6mFMxOnkSiXVLpNSyM0c6awMbjgbcBPlC+GelHOTNBT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itjplROj; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso1219806a12.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758221286; x=1758826086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBQEJwDEzUlEBvdgiHs9qbExKnPUtOGsBsiGHvYGFFw=;
        b=itjplROjZccfssRuzGtxwIUY9qPgFAXVClIMtWi+h9FFwg30Pmqkc+9Jr1whNyJRar
         F4rbMfNA+UOjmyGuOIMHh0YnjC2Sa/0Iob/jpkfvOcwRJJ4AwH/im45QyEbzO99I7I/H
         c7jq+aEj90OU+ceTZnPKH4zxZCgfRibvwNnf06OVvwX+N0ERqFKO/qqg97LxqAXjgLzJ
         9Dnl/O84RwzekN4Dh9rIpIisC+2I+Lwn+PjbLFZ5qlqsmLX1IQjIPq0MXmpmkj7Wi21u
         IeEEahtG8XVbINSGdf1CHRi5zuSTd5UPZCK1TcdqdjN8oqMjTeVpsd4EUf6Q+keUb7Sm
         Q8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221286; x=1758826086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBQEJwDEzUlEBvdgiHs9qbExKnPUtOGsBsiGHvYGFFw=;
        b=xN5RLhVVBGXRQG+bivB6Zc9lNBkfs2md+6akpnp90N27i4v1L3u3zR4rn1YikEd0Fb
         Z/HKTz6pnmns+BuvMrFZfTobly7qVPNDHz7Ch6fTTgxHiNPZKU1QcDv/Zm7fKuHYXtbz
         I5ctvxJlCNiEARn8p9FnsjtIp4q5NIrQUbCHdF/0Ah94giO5gVDRYtoo5mYDGpTRNOd7
         FGDFPQh2iOFQbc5tIG1sHW0rob7gLx0uR0/mbPn1uQnrN7uV9VPnc3hHgt9HPNzK09PI
         KAdMBl/DpY9NrdlRFQEfam7CL/jLNylgkZdeRTitE3mbva8c8RqZqWdKEAYctCHVgslm
         AIfQ==
X-Gm-Message-State: AOJu0YwOB+GM6Vkm6v99JtFs+29rJCwhR1MgVCmYAxDLkHd1meT+oKon
	jzwJ7M5q6BWK3kHsHmLFbVMuPTE6HSCHZSU/MSVBs0z6M87PaQgV/+QX18NhDgAw
X-Gm-Gg: ASbGncsbThWKVfZfk/pG5GyA28tjnrNA5hU8j8T5EnRhufEyRo8cMP68dw0AO1FIXfm
	qOZ70F/nBUkiSt/a/JrTs6o/PaUM38f3oPVbEUVuCSX0iMvdRxOeo6AOTOq0bzxTYEUX2K5+ieI
	2bzKK9x5O6wg8wfoTeic35Z8QFzdAP7XZ0IwYsCpNAnCBPJe2M+m6VtB2r86yFA8mKS/YfN0ggk
	WCSYhUbXJTb+iJ9F1mWUmBobYxg6aQqhWXtJdGZSNISIdEenv+8QoadifJmihosxBu+FlXG7Rbx
	iX+7qHRP+5iU1XuRbGQZLx5E0A1jG7O9BcniibfFYwCIfKys6kj16v//5ZHpMfvrs+eK+KU9X+V
	nmdRYqu1hOol7Fv1PdZwoOKYwwdn1hK5v3wdnSf1FhNHx6Q==
X-Google-Smtp-Source: AGHT+IEnmodh+MgQNGAey7XnAoQtPoVQiopsm4Yq9GVHE4eIkLakbB714YxN5Bi4goVS85+qA3w3rQ==
X-Received: by 2002:a17:902:fc44:b0:265:89c:251b with SMTP id d9443c01a7336-269ba50106amr6842375ad.29.1758221286252;
        Thu, 18 Sep 2025 11:48:06 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm32361505ad.90.2025.09.18.11.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:48:05 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 02/12] bpf: use compute_live_registers() info in clean_func_state
Date: Thu, 18 Sep 2025 11:47:31 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v2-2-214ed2653eee@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
References: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
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
index 861628f4baf8788b80a5cf5eba182db3372bdce2..42157709fd6b2ceb5ac056f1008d7a34f4aac292 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18464,15 +18464,16 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
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
@@ -18493,11 +18494,13 @@ static void clean_func_state(struct bpf_verifier_env *env,
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

