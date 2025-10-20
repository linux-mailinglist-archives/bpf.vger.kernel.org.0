Return-Path: <bpf+bounces-71469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D288BF3E3F
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 807E44FE046
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34432F2600;
	Mon, 20 Oct 2025 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuLIwhUT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E52F1FCA
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999154; cv=none; b=hTeDEYulmcsmiQhqfJzE7ZqCIm8ZIwkkTJHFk1TQTfNDWQYVLI4YyYbRdSrs7zpfkrTXNM08hrR9hzjhMpGmg0L+Jeyg/9tvJtDXS0pJ7zWA7ekJM3CIxIZdqv3pto5ynrxiD7wKRhNHvgwafNcU1uPKg8tk//vYjHbPIBIgoyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999154; c=relaxed/simple;
	bh=oNUFvWfInTuGrt36stksFp67gbQekI9BJskeo8/qH38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ay2uFF6ehODq6miy4SP7g5BYokyXHAlpD4wPoeLvUwLq3IuEjI9PGqjHU8H4bAntoLuuzmWD0wP91QmFQe5Px+v5wf1eOaC/ieILMKn+BlMM12/NrbauccAAX4jeI5rvm3+mWXJ9ERgGSAfrOdAU8JQTR+lVHXysDCKy9RYFoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuLIwhUT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47157119d8bso6332805e9.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 15:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760999151; x=1761603951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdeR4xOE21nSUSdowOevNyf+AEOxeu6NhRwR0H0Qhm4=;
        b=IuLIwhUTEgekj1UY1eHKUqTVO+lsv4TATbsdveVWhyE1qeOciyPuHmkwPWEtgKjhIe
         BB1yi+DK61mFxtU7Ika1m2EGa/SVePHKDt2hs4wi6ceYaIqsXd+r4kO4U6NDOgoDVzcv
         1Ehb/tehuDWuk1FmYKSeF7OVjNPQZGaqQUp41Iy1dK/mwWOkreqAH3ZSpqG33ypi1gKn
         o2rAoohjIzHmzorgqFetqfRWm/urN40FXQN31SFEmteopayylXZfXGKDEGvfA/J7Asob
         0Rt3TYAw5hSXL1QzJ6QIC6kg5LtEtrUSPuQmi0HZYtkgLFiMT/IBlQpUQdoCFBC/hXqa
         e90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999151; x=1761603951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdeR4xOE21nSUSdowOevNyf+AEOxeu6NhRwR0H0Qhm4=;
        b=lPJo29a/tNQPVbhpn8GuLDuJSkQPR2A8H9/CHUpSdrs2dWV6JehwJooWXXnSOKag/M
         2dTHrOXsry0c1Qx4yMyMd+YEGDt98U/FzvDSLiGlp3ypQgJhElWo4+mRW8z2nB7RGvMG
         AUae3gHoZGO75t4syF1TgnUTsjSaAXQfHdomzqIPgak4xpxavdd7iTSkUdsTqVTgYbk+
         ZwUzAdNv7UvE2u89NTbRKkJxz/qPayL1v87bzXD6H5hjVl3uhuHZicvOoGgu7ieauAV5
         qDJDvLYvgYPQDQxZJK1XplO005LFwcA2uCDEsrzaXYJQXsvDQxWKjb/SuOYoH40blOLI
         LCEg==
X-Gm-Message-State: AOJu0YxTdmei175LC27T/wa9raMZGNWmlZczIm0WusSyW8CT+ZhhrBfZ
	2E5mpdBd4LzAO7BHsqKNSC4bRhhFLmKP96FIHakIiMOYk9DGiPulpIxknq62gQ==
X-Gm-Gg: ASbGncvhcLVUKCDoOe3fK0nKHDH/3BPkvugFpvvp5dAS3U1r7gmJ0NOcFMAG6DhyKz1
	ZRTVNTtgV6tvqw6NRniaSeMgwJcG/7zPD7A7/wBDZ7QAVB/SmaMbjRKfKAxS61pq7njwaIYNg1z
	6G5RkCt89D9TiRwzkhkAiOiGj2PAryUzFSNgUZxq6W7cItLUOU1k8twThWLdOI2VeGIHbMxlT59
	8Um2kUD9yVczl0pMI6cX9KR1U8i69NJY/EXuQqYUQ6Tf9p/CGQCTTWJoWF1/O5dJWJEIplYx/rA
	WWHBsC1Jo90xm6cw2fYmTOF6+am8xLvDz2s376RqyNgbtqiO0JM//5RWcFXygMjpn/NlVRi3Szi
	0Gah/kZ7vQy/3kXOj4Gh5vggKZ5+U6VW8kV0PIxShcLWxSQW6r9Ghs7nJ24n7/8hjBu/nYg==
X-Google-Smtp-Source: AGHT+IExw5z4IHYvoJu662NE0G12kpEr/EdDaQv33AFj3TO5Jy9DqcSayrTG9ArO6+bixMBJvYwMVg==
X-Received: by 2002:a05:600c:1493:b0:471:1c48:7c5a with SMTP id 5b1f17b1804b1-4711c487d74mr69769525e9.9.1760999150931;
        Mon, 20 Oct 2025 15:25:50 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:2617])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494ae5510sm4516985e9.3.2025.10.20.15.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:25:50 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 05/10] bpf: verifier: centralize const dynptr check in unmark_stack_slots_dynptr()
Date: Mon, 20 Oct 2025 23:25:33 +0100
Message-ID: <20251020222538.932915-6-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Move the const dynptr check into unmark_stack_slots_dynptr() so callers
don’t have to duplicate it. This puts the validation next to the code
that manipulates dynptr stack slots and allows upcoming changes to reuse
it directly.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9b4f6920f79b..157088595788 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -828,6 +828,15 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	struct bpf_func_state *state = func(env, reg);
 	int spi, ref_obj_id, i;
 
+	/*
+	 * This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
+	 * be released by any dynptr helper. Hence, unmark_stack_slots_dynptr
+	 * is safe to do directly.
+	 */
+	if (reg->type == CONST_PTR_TO_DYNPTR) {
+		verifier_bug(env, "CONST_PTR_TO_DYNPTR cannot be released");
+		return -EFAULT;
+	}
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
 		return spi;
@@ -11514,15 +11523,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	if (meta.release_regno) {
 		err = -EINVAL;
-		/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
-		 * be released by any dynptr helper. Hence, unmark_stack_slots_dynptr
-		 * is safe to do directly.
-		 */
 		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) {
-			if (regs[meta.release_regno].type == CONST_PTR_TO_DYNPTR) {
-				verifier_bug(env, "CONST_PTR_TO_DYNPTR cannot be released");
-				return -EFAULT;
-			}
 			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
 		} else if (func_id == BPF_FUNC_kptr_xchg && meta.ref_obj_id) {
 			u32 ref_obj_id = meta.ref_obj_id;
-- 
2.51.0


