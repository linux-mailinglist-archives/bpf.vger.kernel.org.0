Return-Path: <bpf+bounces-70478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A1EBBFF9B
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 03:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5485034C1A4
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 01:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7C819F111;
	Tue,  7 Oct 2025 01:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKx6MnM+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A04719AD5C
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 01:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759801395; cv=none; b=bwKo13UIO+h3FBMxPzO2Y79TZ5W4wtmm1SfUtkDDniFzsOkLuvXKynlT+IliL7LMs7SVZzljsqSZFo1M1Z9RH0vVu5vglVco7MbN8z+L+cS3NSElhJjFpHpSIAAKM804s+YZtpgZgQNxAXuu1lOtqADjGTVfjTBCYaTETpMwtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759801395; c=relaxed/simple;
	bh=g0op8CHy26yJ2NusSDGtHL953JarBs5kqxtsxTs0FCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTWVoEOGA6XxviNSQNcrZueKeBb6bYNmOgOzweR8eOrEfTt1eiFutsu3Q3KKheJaW/BFKEmt9wUunihuIsYZGoszd6PwIKjIU5ail1ZhIfTpUJNJ6noGzBe5dkCgBGWI4DfmV53+MxQ2uNOc8TwEiT3S4AvuuDQkf5WU8byKCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKx6MnM+; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b3e9d633b78so815089066b.1
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 18:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759801392; x=1760406192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8Z7AM0dUllVtddn1TqTa/QYuvBkx0RdzxC011HADkY=;
        b=PKx6MnM+FN8/VjBOGlL2j5/l66s2KStRUcJHNDTvGM7VkT/aBbt8NFSAKDH1XHBXru
         EDzHt36452iAALkyuXpPxjHZAv0a54Fytyy4Zcm977d9MlVR32EA0/L4AD/cS4c89Bqu
         eG6oHe/vWDAFLpeLd5OjGLb+pwTMesze6Ct6PQm5KBeM0HUXY5zf2g66qo0ZanRYM/CM
         Nn2n6LJtNunmCXe5Qxgl5BkbjtTX9wVDTP0jS34BhYuUegmTmvn9/LjXwodu9+emDZyG
         h9OZ7cA4jKJZDiB4xT9yqdrCbAdnWFCv1UKbGkoanwXm/PotgbCoZFZcgi7fQHMfWydx
         sPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759801392; x=1760406192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8Z7AM0dUllVtddn1TqTa/QYuvBkx0RdzxC011HADkY=;
        b=HyUS8oeQXjmwu1oYWGgklgt1SFxFWIcJ71ZBEnUgr1ysqLj3wOAsxZ1+lvWOcM0xxe
         IFD9f9jHO0nmog0W0f5ajpj2QsISRvit3odqFpJli4PI+sy/nPZlAEXBnIXr3/eqvYHU
         DUs2JwNGKWC07axbcBvxgL/FIPxqreyvzCUziHmYdVbOCUTf0yZnOdUnfsDvSrAG3VQa
         2easwUbSzLk3gGMAy2ii5L07Xzir9suDV+P/J1hc508Jm0Uxh9faEqba9TC7oX8RPsgm
         WDfjzB3R/W+igaqHGBGsA+3RClQ3teEOPeH2zipQqUP3b6QWCGmZ9fNAl4kC+1XqxDvr
         2g/A==
X-Gm-Message-State: AOJu0Ywf0jeZGUsMNQ//gU4NAI0Vaysxd36B+wSgVKaYkbmQS/815qFl
	6b5H7uib73v/aApxrF/KR87mpfv4x4Woobq5mRgMpP3r4nmt4OI13/waJygU28E2
X-Gm-Gg: ASbGncviVAYMGi9nxFTrNCiKWISf0I8lu1T/BbpnFa/Vo9D3tIIi7/oPWDEWJ784tZ/
	TU8k1EXlkZiqMP26RPeS1IJvB2WPhZLFadld2wVh3jmZaF7Fl7hQ9rAYZo8iQUij+IxAFMK+xNz
	aZg1Sdh8zkAi1YJ+uEHNI9QODMu2EnenDwCAOGAwIQFQQgnPuUje16GkYyDlTCLTrE1AM89DAQK
	zVUBb4fy222/qvtEiGPCMi7FilGTsWTfGK7wkPaZ6+nieRNSwV+dyOb3cXmrq6RTsoDAtYdJkjl
	0+JbIelCL6eHcjuaI8lTMHOxkGuJkda+CJJUxt8RSiWb9wH8c0Bz/28WsfSGEYpoCv/96Xj0j0t
	PGZhM+uhnJZHUNqy4QSJb6lS+h8P/bCLzvJB8Ps39cJ6xQyc3l68sjzu7S7rkJtgN1WOHuYHrFH
	ZZqsc1S4JXHDVkporH2d6YHuqU
X-Google-Smtp-Source: AGHT+IGhuM8ipN7LnXYRby4v55Jdxdj6I8sJYhhFBy5GEQvJuYaPCcFvMSASBEiSW9w/oWZO5v6sjg==
X-Received: by 2002:a17:906:f343:b0:b41:c602:c75d with SMTP id a640c23a62f3a-b4f42dfcccbmr172711066b.31.1759801391867;
        Mon, 06 Oct 2025 18:43:11 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b4869b4d9f5sm1276605266b.66.2025.10.06.18.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 18:43:11 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/3] Fix sleepable context tracking for async callbacks
Date: Tue,  7 Oct 2025 01:43:07 +0000
Message-ID: <20251007014310.2889183-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; i=memxor@gmail.com; h=from:subject; bh=g0op8CHy26yJ2NusSDGtHL953JarBs5kqxtsxTs0FCE=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBo5HAVOkM4ZWGaVY5N1dyhH71hsWPGr772QpMvn /ssGS5aPFmJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaORwFQAKCRBM4MiGSL8R yv56D/sEfiOidxtc+p9ksO389gACUK2hMyajdzcaH1pQGUEI37/Ik7NruvHI+JqofmQWWSmEYiy 7SR3SFl9KLifU6/HP5/+yh564Bf4GRMyJQiIC90vfiqU3BFWd33TWhILm1yDltyXN7wHs9bbNg3 ob2Es/Y8zQR2aZS4GLvwXeuCaH+5yxfaU9fgY0O8Da1ehXouhEs5GimJ1gZXLDekX7pGvWI+29l 0LO9tLusRj0/0RzJoRqkTbpMokARTJixYk/h1xGePjVKLa8aRvAWQzZglpfDtZ3OLIxE6KOUgkf l6uqVMblmTccOLPs1XzaFl9smALUJ3OmCzBkO5Bsd0k5dcNT1RnZZeYY1n3RN66vOZF9YCNxWzC JwRTpMvkcCXeaccrwwvpHVQYyAU+7EJzF8AduTZRgGpAsbhzbr+/+WONqb12jb/46SZMGgkhx9q CEVjekHvlAox9WmxSQyPGvnD1BK8in6cQ+y1g7+ZCG1m9tyOtO2thmbzKevptKn7HMwb3weJ7Qz eVfvLeHFvulu0/aliZmhg5yLv+lTNBPCDbTKmVt5inlIdt9OZsYCKbTBSSBE7GQzdCv5Dp+IMeG J+J2Ahm62RXk06d/meA02rTDBlU3ZCaeHDUWboEtRzuPmk3cEdJiZfFebjRzbOU0Kf+NO0rRADI XzHjatT1ZsmctiQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, asynchronous execution primitives set up their callback
execution simulation using push_async_cb, which will end up inheriting
the sleepable or non-sleepable bit from the program triggering the
simulation of the callback. This is incorrect, as the actual execution
context of the asynchronous callback has nothing to do with the program
arming its execution.

This set fixes this oversight, and supplies a few test cases ensuring
the correct behavior is tested across different types of primitives
(i.e. timer, wq, task_work).

While looking at this bug, it was noticed that the GFP flag setting
logic for storage_get helpers is also broken, hence fix it while we
are at it.

PSA: These fixes and unit tests were primarily produced by prompting an
AI assistant (Claude), and then modified in minor ways, in an exercise
to understand how useful it can be at general kernel development tasks.

Kumar Kartikeya Dwivedi (3):
  bpf: Fix sleepable context for async callbacks
  bpf: Fix GFP flags for non-sleepable async callbacks
  selftests/bpf: Add tests for async cb context

 kernel/bpf/verifier.c                         |  41 ++--
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_async_cb_context.c     | 181 ++++++++++++++++++
 3 files changed, 213 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_async_cb_context.c


base-commit: de7342228b7343774d6a9981c2ddbfb5e201044b
-- 
2.51.0


