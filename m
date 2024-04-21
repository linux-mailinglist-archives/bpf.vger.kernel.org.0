Return-Path: <bpf+bounces-27349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60608AC224
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 01:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D6FB20ECA
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 23:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F83B46433;
	Sun, 21 Apr 2024 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzgTMR5U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671DE45BF1
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713743291; cv=none; b=XL32eRUrBNR2wV+wPtklTJuvySJT+D2v6Ki/iT+MB5eGnn7s0amxUW6US6/hWD06n8nPNB6h3q6oek6XdGM2Zq7ymS7zp/VvOOq4yzKUXYiem0HLTq4MQDPAJu2/gDDxyv6584QZlwR/24f0POQqLMK6QGD/f3Rh/ugBk+fTtq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713743291; c=relaxed/simple;
	bh=LV7yOmj0vEDEf7MxxwWNX2GO/ZMfXhMdVJLTEuXSjco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWF2nWyA+pr/hwWz96rz/bOPyYOEpt7XFDDaYer1m7TPaTDo8da8Mr6VsZWyhJOt7LLW4U8quLpW19oFJrw9yiTiu6XmMSkzVLg7dRgNlrfYpExnEIhbV7OXquFUfHk7gRgUUL2EHZBbsZFwsGPIyzQJbKwNIprS6ch87xCWyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzgTMR5U; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ad2a15374eso1148604eaf.3
        for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 16:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713743289; x=1714348089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0CxJuwpvOzEOqzYfyAwHTzK85EjW29lHibFHXfSGJU0=;
        b=gzgTMR5UuMJOYPxkrqtPXwKNX7+PZMTW64Su6dSYwUrudwKmcq/KAYjWTfF4BE2TJp
         bi6pJo4i4VJavtic5rdH6G5lRepTYVkJlOfO8eJn9lC8Evuql8f4LVLi44QR7QEVdgv2
         ih0Txe+mLSa8q+f8xLynZ74CpPUWkyWoDFpfy9tCwScl5oThy18M5rs2I9teLswaKrGO
         pquB0mFppsVqYKUjLqc3mT8y8jlW1sUcpGIAGecu2vC0QYhLiNo/V/qfxoFoaRUMvzMF
         k7wmo1DVskh/IsTqOrJSWS6cpUfGm9eFZUbkMfc2FItfbq4M9t6Z6rhPy0BdNHWKz2YH
         oQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713743289; x=1714348089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CxJuwpvOzEOqzYfyAwHTzK85EjW29lHibFHXfSGJU0=;
        b=rIRdeKZGwyx/e+obyRYzv3R60XSyjlBpg7/OyN5FGrtVWVqk/6uY7LHYbp63CAAteB
         LY+Z3sNS7zJJmTUAgbNrVVweYm9DOjdtOuVtPhYkKnzBpBEYldWZF8mBeFenvowcSPK+
         71SVlW4jKD4K8dwdOzX5mNWkgfdgJ7ikRZZAg5Ipg1yus+TxnSVYAgl9/u0+x1ZrRHIm
         2AZ4kz0vwClwo3w8wK8dEB58K0gYR1SmktcZ0uGWyUFPGssB9RfYoU23DEd2ti24RnlF
         4mbs9nB/pobh5tVkqyEOjja/2bR3iwLN+jMzqZn6I8E+XsS1zv0RlDYC4QGscgc2ddH/
         jjTA==
X-Gm-Message-State: AOJu0YyGSz5JaPO5PyORqiteRmJ57iozoNZYnxBvAInjKIsX2V9/3pCc
	m+cbAhSpuRX1mAPg1eakPpf3RmJ+B88WplAedttyzb3C3gcAov2ILJ3n+WbV
X-Google-Smtp-Source: AGHT+IG3PSeXEDIh+809FahSGYWNO2uHw3koFPcAlJPJ/dWhrYWMWOA68u7PjhMs1iWi8jwltISsmg==
X-Received: by 2002:a05:6358:6914:b0:186:2ac7:317c with SMTP id d20-20020a056358691400b001862ac7317cmr10217590rwh.25.1713743288990;
        Sun, 21 Apr 2024 16:48:08 -0700 (PDT)
Received: from fedora.. ([2607:b400:30:a100:6442:5b0e:54ab:110b])
        by smtp.gmail.com with ESMTPSA id r13-20020ad4404d000000b006a056f65896sm3500881qvp.106.2024.04.21.16.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 16:48:08 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
X-Google-Original-From: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	daniel@iogearbox.net,
	olsajiri@gmail.com,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	miloc@vt.edu,
	rjsu26@vt.edu,
	sairoop@vt.edu,
	djwillia@vt.edu,
	Siddharth Chintamaneni <sidchintamaneni@vt.edu>
Subject: [PATCH bpf-next v2] Add notrace to queued_spin_lock_slowpath
Date: Sun, 21 Apr 2024 19:43:36 -0400
Message-ID: <20240421234336.542607-1-sidchintamaneni@vt.edu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is to prevent deadlocks when multiple bpf
programs are attached to queued_spin_locks functions. This issue is similar
to what is already discussed[1] before with the spin_lock helpers.

The addition of notrace macro to the queued_spin_locks
has been discussed[2] when bpf_spin_locks are introduced.

[1] https://lore.kernel.org/bpf/CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0KHWtpvoXxf1OAQ@mail.gmail.com/#r
[2] https://lore.kernel.org/all/20190117011629.efxp7abj4bpf5yco@ast-mbp/t/#maf05c4d71f935f3123013b7ed410e4f50e9da82c

Fixes: d83525ca62cf ("bpf: introduce bpf_spin_lock")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
---
 kernel/locking/qspinlock.c                    |  2 +-
 .../bpf/prog_tests/tracing_failure.c          | 24 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_failure.c     |  6 +++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ebe6b8ec7cb3..4d46538d8399 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -313,7 +313,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
  * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
  *   queue               :         ^--'                             :
  */
-void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+notrace void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
 	u32 old, tail;
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
index a222df765bc3..822ee6c559bc 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
@@ -28,10 +28,34 @@ static void test_bpf_spin_lock(bool is_spin_lock)
 	tracing_failure__destroy(skel);
 }
 
+static void test_queued_spin_lock(void)
+{
+	struct tracing_failure *skel;
+	int err;
+
+	skel = tracing_failure__open();
+	if (!ASSERT_OK_PTR(skel, "tracing_failure__open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.test_queued_spin_lock, true);
+
+	err = tracing_failure__load(skel);
+	if (!ASSERT_OK(err, "tracing_failure__load"))
+		goto out;
+
+	err = tracing_failure__attach(skel);
+	ASSERT_ERR(err, "tracing_failure__attach");
+
+out:
+	tracing_failure__destroy(skel);
+}
+
 void test_tracing_failure(void)
 {
 	if (test__start_subtest("bpf_spin_lock"))
 		test_bpf_spin_lock(true);
 	if (test__start_subtest("bpf_spin_unlock"))
 		test_bpf_spin_lock(false);
+	if (test__start_subtest("queued_spin_lock_slowpath"))
+		test_queued_spin_lock();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_failure.c b/tools/testing/selftests/bpf/progs/tracing_failure.c
index d41665d2ec8c..2d2e7fc9d4f0 100644
--- a/tools/testing/selftests/bpf/progs/tracing_failure.c
+++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
@@ -18,3 +18,9 @@ int BPF_PROG(test_spin_unlock, struct bpf_spin_lock *lock)
 {
 	return 0;
 }
+
+SEC("?fentry/queued_spin_lock_slowpath")
+int BPF_PROG(test_queued_spin_lock, struct qspinlock *lock, u32 val)
+{
+	return 0;
+}
-- 
2.43.0


