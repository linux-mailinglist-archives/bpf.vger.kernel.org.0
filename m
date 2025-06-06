Return-Path: <bpf+bounces-59932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC74AD0947
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3CE169B7F
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E41220680;
	Fri,  6 Jun 2025 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P31PqTJ2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1338A31
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243877; cv=none; b=sJ8I5p9O27QRuFKw6QVbg5qaardlrCtVMJI3PMZUNKOsx9m9zUZu/jENnfzmIoADtLfHlSk5BkDP4dstweGJqv9kvhagnhVEfdY+1Ux7vIl85LDhBVeMEEP6Ib/g1iZXdm6PoVi3xe+k/7usrhR84IPVDrZooyzBeo4ijv90r+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243877; c=relaxed/simple;
	bh=h3uxqMe6vDAQXaknbP+UFVRjenPlb8fWyZjMZWImk/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V21ZqxI+uVXmLH8v/GTsIWB78WogeqK94I7noCt3L2/zdiuBXFVs6ckhMn+RmymY/KaXvVGr5wdDbLakqjmYAEXAXfdJHDTMtnOK7256ElAsqwS5UnfRmXxUeUSdKPT1kUR+yoTlriDTD6llB0Te3OQrG9vLXKB/X8JE8LsZ2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P31PqTJ2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c27df0daso2424080b3a.1
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749243875; x=1749848675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1zcJeBEAS5cWkTtXPw4Rq+kykjM6Fk85IbF+ClcTvc=;
        b=P31PqTJ2FmJW1dkThpjT/qCxFdpNlZVhqFUYJfoLvFK5CzMbwRLIJolm2YOWota9Ub
         ntYMIIjin81dS2CoiWMnxO8M+kfWw89h4G1IxmB3ga0T+SbSv/Z5/W7AwcwHbQ9qA0C5
         YH3n5qlFgxHZNrE6ADTBR58x79gdna/3tNTEopq8955c/xQSRpodUs2gBO4VHUekLSa4
         aRaa1HT1oKqpkvuOF42OUThvDHlq/YeSR7uuHHmsrdmxTAzKlDmveB3P7hIkOKhWN6ug
         4qqnj+htft6VJzZHuYUIt5LuKXt62z6sEdA23hfkQ5rHI92gp2IeSJAHLZPgDlbowgFi
         cBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749243875; x=1749848675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1zcJeBEAS5cWkTtXPw4Rq+kykjM6Fk85IbF+ClcTvc=;
        b=AFR2Vm9ZEUlRX6Win2JlqtZaP6wKLT1i+pNqxpMV6NUttJCUPFgI0KdJPp27c9uasX
         og4ea70jkYT0SC3FtrC6eskCVFhaGLRxCC33RYGX17YgSZLDyASxQjag6u4u9Uf8c9lR
         GeUSrtMJdJvfBeHWNxCvUyDTmcoHwsVN77CPytITAGF3t/ailBQGkVOeUD5CqmOMxd9e
         tySsMVxELBZT8kuoaJUFNxTiBAlqCp0N5hCuPQvJ5pr1jzpxO9fnMMokCsE9b7h191BI
         c+DjNS/19OekLM63Ls0dNQcCb4tUTpTxgGV8z2JvXjAwP1DPuXSspiVuTk3ZVE4+wVUZ
         qs8g==
X-Gm-Message-State: AOJu0YxFQ5fgFo3GI12caE1WB7pBfOJ8CHjTeviysxlVbPxVr/ObOvno
	JCKt6GyLl3ifaJIYzxFKI5HaEKGtOuSNYuLHLp9j2/7DPac+msOjdAsFeE+GOSTu
X-Gm-Gg: ASbGnctKysT0KJ7TEsaY3/RSaczmEjgxQghpvW2YRiLi8Z4fxYNFgkw9YUmkWRbKMZj
	40uG83ALFYxms6ncQZM3t5b5z1GdATHaKv9PrMNr6vQaMHSg5r1/QcrLnXEGC3xY3JrswdtdR/A
	SHNGMqG3wPVy2PRtKQhfF5JMR7C6AmItG6Y6n+N+A8a9rgFcQfgC0I2PAOuqHVxhRh8J01157Eo
	IJDnH6pGENFTSwiqwQUPl/gU0m2EdtMvkqsj4RPymEhsZLDO2uaXJXYOY7h2VIlcE6YHRWxj9kV
	aD5MkcYJjFm2yGayIEdsORhZddx1uHHiObBThgzMoraPoofZKkRIIAafA8UY/NF9s+Vc
X-Google-Smtp-Source: AGHT+IFq+IkHpP2xeIj1QcaPoWcO1WnIstlxwCdN/oiqQozogYrMNAXG59iLoqLnLYdFFdEvJ5lpSg==
X-Received: by 2002:a05:6a21:e8f:b0:1ee:d8c8:4b82 with SMTP id adf61e73a8af0-21ee25e079amr6571663637.31.1749243874789;
        Fri, 06 Jun 2025 14:04:34 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ed58beasm1352640a12.15.2025.06.06.14.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:04:34 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 06/11] bpf: set 'changed' status if propagate_liveness() did any updates
Date: Fri,  6 Jun 2025 14:03:47 -0700
Message-ID: <20250606210352.1692944-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606210352.1692944-1-eddyz87@gmail.com>
References: <20250606210352.1692944-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an out parameter to `propagate_liveness()` to record whether any
new liveness bits were set during its execution.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 046d5515008b..8e2062e38307 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18841,12 +18841,15 @@ static int propagate_liveness_reg(struct bpf_verifier_env *env,
  */
 static int propagate_liveness(struct bpf_verifier_env *env,
 			      const struct bpf_verifier_state *vstate,
-			      struct bpf_verifier_state *vparent)
+			      struct bpf_verifier_state *vparent,
+			      bool *changed)
 {
 	struct bpf_reg_state *state_reg, *parent_reg;
 	struct bpf_func_state *state, *parent;
 	int i, frame, err = 0;
+	bool tmp;
 
+	changed = changed ?: &tmp;
 	if (vparent->curframe != vstate->curframe) {
 		WARN(1, "propagate_live: parent frame %d current frame %d\n",
 		     vparent->curframe, vstate->curframe);
@@ -18865,6 +18868,7 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 						     &parent_reg[i]);
 			if (err < 0)
 				return err;
+			*changed |= err > 0;
 			if (err == REG_LIVE_READ64)
 				mark_insn_zext(env, &parent_reg[i]);
 		}
@@ -18876,6 +18880,7 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 			state_reg = &state->stack[i].spilled_ptr;
 			err = propagate_liveness_reg(env, state_reg,
 						     parent_reg);
+			*changed |= err > 0;
 			if (err < 0)
 				return err;
 		}
@@ -19251,7 +19256,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * they'll be immediately forgotten as we're pruning
 			 * this state and will pop a new one.
 			 */
-			err = propagate_liveness(env, &sl->state, cur);
+			err = propagate_liveness(env, &sl->state, cur, NULL);
 
 			/* if previous state reached the exit with precision and
 			 * current state is equivalent to it (except precision marks)
-- 
2.48.1


