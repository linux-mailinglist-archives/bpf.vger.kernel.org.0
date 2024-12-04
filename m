Return-Path: <bpf+bounces-46056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEB39E32BD
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 05:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFC628154F
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 04:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B0B17B421;
	Wed,  4 Dec 2024 04:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKsqmO90"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E7074BE1
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 04:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287684; cv=none; b=tLTdqKzVfx+uo/IV1tQDH6tU6+pw9UZ5nif//ZiwF67H1XB6vLy2ZFy8CSNdaQogeDNm6f/rCz/1wNi3vEZQ6m4m37ZErdCMHUgWjd71A6c9Vesx1cNtVuJCt5sCu/Md2DZ6ERtLvskPZWbVdgtksOguRCeR8Kb8LDPcvvp5IuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287684; c=relaxed/simple;
	bh=DMSQH041gMQXVFBX+V15neIaExf6bFzGcrKcbhOTzdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Unno8jldNcSgVpbQARaSNx705uYUFhtlQZj/h9zDqdAwMKmgGWMOU7C1Kcly+VxSxlVBifru9x8e1+eJj3v0JZrpvBUFRHGK3+kyXx4IRTkDKhtozCPDrLvGtwyNi792ci9blElTrG+jx8kCH0ezlqHiA3CbSDCE5DHX1zbLIsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKsqmO90; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-385ea29eee1so2583688f8f.3
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 20:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733287680; x=1733892480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fndc2hQ/tqVYn8QVqQR4qo2NUwhcR20isyaN5F15Vd0=;
        b=XKsqmO90NRlRNwHxLMz0ajmjnMIWe/nB6oueuG79+tBYgalnzLn6g7LxhtdwHMj8Nm
         G9Ft/sV8TsyFgj1+fGf+onJnDAI/OiNBQIq/yd5vWJbUhD5p4Y/41W5VMOO7FL0E8Yju
         Ck/iqOnlOWzVi3Z5i8Fapo/vWR8gZptgf204jjizDgslEDd27gsDzZ07hCwcFqoLY8db
         Y/YgTau2tVkg1k59aSiAIzOFb6eo3W+w0PJ2NcNBZVYPO2TVXkFzdeS+KrLRdSghHrTJ
         0m2FRYppACs5UyI7w4VMOVtGkcSGHPB2XeQiiiuvEb0vPHL+gefotMVfjZ3cDrCjVEqd
         kqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733287680; x=1733892480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fndc2hQ/tqVYn8QVqQR4qo2NUwhcR20isyaN5F15Vd0=;
        b=kvi+GWr1srSQ2rz41H0mrDPVzLxJgmeERXPuLjwWGFhA4vKi+PJK9uM5l8wO9V3N3N
         gzRIhD8wIAdSulC7laOqOWNwq2LpASdYvgXRkPG7cyB8tXYOQW1fMOD7Xw4A2n6glzvM
         AvFz3rlnXdlP9uEmkcWBmsW5dWtaJFEOHxIOKFgfFByPeNXmsO+M3zYwgErv++hE1vyB
         zXlCCzgNThQlbgu1oJ8wmEyzUerucdsl5Fwmeq4oT6tcKOjI0EfwmYly4FPpy3E/eYdi
         JEtxKSL8tIwmhL7sx/VFbguj1UjwLv0NFZabI8svCgp6tN8mXgJhjlbFSbDPbjCDR8f7
         F5Yg==
X-Gm-Message-State: AOJu0Yyb++k8hCsXoZilW6oiYAst/3mvBKua79DioSjffa8QMKVRPcVU
	zzdm0sw6Jfio4Sx30d1RB4+ZpCDhuhXLHvZ6PKwcOrscGkxp0Db1BqluPatUZKw=
X-Gm-Gg: ASbGnctGqON39JOseOc6qJn+9NrSMRO0VGF7x4bTx5btNyYg8jOuglrtQhjDmU/awIZ
	VMewi+eYr04oshnb3PWKePAUhLE7kRrJN4f+zjQ2h7HEc28ViVOHMv7/au14Nfaz7dyYHmWrdbe
	TFvFhXw0hxVQ4Uuiilr1Aqgf8lfQRFHWRl6Lcp05hIoV7Uq5T6Ml1b4iMRpNn3eCS53ORpal3VL
	Ge37Mc6Irk1QiJSy1hLE70s44Agy09YjHRQmMzgm69CAanBigUovKs0T1G5Teqke3Y6fzhV0Jvi
X-Google-Smtp-Source: AGHT+IFBDZYCnpAfEVo1+moBLmYB9Jl/EqY7KcPMGvOiMR10tRZGQeN1THAtXkJLTvxQV7XFX1PBcw==
X-Received: by 2002:a5d:47a6:0:b0:385:e055:a294 with SMTP id ffacd0b85a97d-385fd55f1b4mr4398583f8f.59.1733287680357;
        Tue, 03 Dec 2024 20:48:00 -0800 (PST)
Received: from localhost (fwdproxy-cln-009.fbsv.net. [2a03:2880:31ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2e1bdsm17687017f8f.9.2024.12.03.20.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 20:47:59 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	kernel-team@fb.com
Subject: [PATCH bpf v4 1/5] bpf: Don't mark STACK_INVALID as STACK_MISC in mark_stack_slot_misc
Date: Tue,  3 Dec 2024 20:47:53 -0800
Message-ID: <20241204044757.1483141-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204044757.1483141-1-memxor@gmail.com>
References: <20241204044757.1483141-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; h=from:subject; bh=DMSQH041gMQXVFBX+V15neIaExf6bFzGcrKcbhOTzdk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT97Gfew9I+fXpK7cd7UBzQc5kDbXLcBNtB5cWhJk qmpnnKaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/exgAKCRBM4MiGSL8Rys+eD/ 4iy155zYhO60z/nN+DFkqIuHVbrcNW0ftGuO+e43338ewZgNsmTarp7nzIwLjIIfwoVBYXduzmK/sh EAdWkrW0xGux8Hxc+Whj015YkmyLyAWL4K5wHRkAs5vhTGIFFHIjG/PhTXEQaucYa/ZmbZsr4C8KrH xro+uowslnX0xAbGdjM/dMyfjdV1rIj9uaXAYhEUUwQYddcqxJxq5n5P4TXNuTUaYp+rUOKuqCwEI2 oyT5oSfu4CR9NoCSBKroKbJwaDITh9zAU147CFt9PTKPUJviH8GfqUIj8IhOvIb+Gzfsz8MoAhTegF lU16bpYVKfbSDJYV7ND+f+OexF9mZeh2UsB5XXdvFv2/vMpXMFJQ3PVsoSgBwNRg3jtgFbIHWfllnL C2+R0B3Nyw5jDWMqvRu2dZnk8UGflOp80nBcKFhTIgxgJEgqQrp4Gl7CS8/opC3AZS9EaFzn1K0ddQ 3tFnyRTs2VwK4/cAT+rnqkkrjSdb7Rfeofvhr6XJ/4gFqRLMEqQQP6O/LdbsjPK/qyR05sj5b/plWj gP1WrJUDYsnPin5NFlBUCCc8FxQU5FBp7Se1lxla+5gWMVYsnvZs5Tt8jraZ615Y26dsHXCnwAmexO e23A6gcs5cycHprHs119Cc2YcDtRjPHXfNUkL/kYL3uHnaUEeazxtuL6NBvQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Inside mark_stack_slot_misc, we should not upgrade STACK_INVALID to
STACK_MISC when allow_ptr_leaks is false, since invalid contents
shouldn't be read unless the program has the relevant capabilities.
The relaxation only makes sense when env->allow_ptr_leaks is true.

However, such conversion in privileged mode becomes unnecessary, as
invalid slots can be read without being upgraded to STACK_MISC.

Currently, the condition is inverted (i.e. checking for true instead of
false), simply remove it to restore correct behavior.

Fixes: eaf18febd6eb ("bpf: preserve STACK_ZERO slots on partial reg spills")
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reported-by: Tao Lyu <tao.lyu@epfl.ch>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2fd35465d650..f18aad339de8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1202,14 +1202,17 @@ static bool is_spilled_scalar_reg64(const struct bpf_stack_state *stack)
 /* Mark stack slot as STACK_MISC, unless it is already STACK_INVALID, in which
  * case they are equivalent, or it's STACK_ZERO, in which case we preserve
  * more precise STACK_ZERO.
- * Note, in uprivileged mode leaving STACK_INVALID is wrong, so we take
- * env->allow_ptr_leaks into account and force STACK_MISC, if necessary.
+ * Regardless of allow_ptr_leaks setting (i.e., privileged or unprivileged
+ * mode), we won't promote STACK_INVALID to STACK_MISC. In privileged case it is
+ * unnecessary as both are considered equivalent when loading data and pruning,
+ * in case of unprivileged mode it will be incorrect to allow reads of invalid
+ * slots.
  */
 static void mark_stack_slot_misc(struct bpf_verifier_env *env, u8 *stype)
 {
 	if (*stype == STACK_ZERO)
 		return;
-	if (env->allow_ptr_leaks && *stype == STACK_INVALID)
+	if (*stype == STACK_INVALID)
 		return;
 	*stype = STACK_MISC;
 }
-- 
2.43.5


