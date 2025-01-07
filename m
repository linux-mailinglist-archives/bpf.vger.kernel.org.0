Return-Path: <bpf+bounces-48113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E27A04182
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240D71887D3E
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2389E1F428D;
	Tue,  7 Jan 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V93cn50g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED61F3D27;
	Tue,  7 Jan 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258442; cv=none; b=EQrghI1fGbLlBgapeDeK9HS1li4PofG5R31NhCZ3EeKsRNrbnWUAvJjh45IMLsijXIFhgORGHp1sKGbZffFeBuYesLXIJQyU+Uu6UZ8JsJ5QwE6u5PgvXCFQkIoeN3gm0q7bbpKnBnIQePmo12boHUvyUekZwaWNhihYFdhk9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258442; c=relaxed/simple;
	bh=TW8UI9TMxQcBoeFf9FYBebGoM/areyCYdGlRu4N2BqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wt4/NWKBRD1C7gry2yQTTCKfKjgfzkiLKbhhgTj1MWbeGVmAFX27D0aPAkoXc/1jXaThI1S7OsfOx6B5knqBo3BeNgFifX3K9Ty/lOSdfu+I4MuTakQQ/ik/Nsd99M4ztJyWHYxoDNkQzumIr38F14cjW1/x4W4tYXLsFuR8dXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V93cn50g; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso157900515e9.1;
        Tue, 07 Jan 2025 06:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258434; x=1736863234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3hVYvq+iuJzNA1UBjbhnwAU9BqFVDkKQftt6XH2r5A=;
        b=V93cn50gdMOkDypj6OOr9gW3TK8RGwVNmiE0T3Fbpy+yDubToNdmjoHvWd3Nok5gHF
         vVRXp9pMbeMFnJEthDupfsZ4U8jtIS1WZdiNQYl+HgTIsUWqAQ8UNpq38ec3hHb30waA
         f+a2v3VpbTKT2H43q7W1Nzp9hzFK0X7I/7oYFi7WyeY8MHmD7FWbzYG4sBoh+kl1d7OW
         0qZQYIOzL94qcqqx501KejAG/KxbVoPA3vY0VE05OxxxEofZ1NkRBX9aIuzkdvsLOxt8
         e/4AZncwPA7ygIYZWjkzA2KiwqZmnZfNB2xNDATRZ+uEfd+OCSxNacRCm7PdxFia8Jlx
         qlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258434; x=1736863234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3hVYvq+iuJzNA1UBjbhnwAU9BqFVDkKQftt6XH2r5A=;
        b=vDw7MeZNr5mr42lWkxaj+YedFkuWOvM45q0U8YeGFh+WeBqz/Bv9EcG+6px1YJgen/
         LNdOk6d8SEeoI1ZycvPuEavUMwKPEMkXb3VuMmaMALjb+h3hupuucy+1jgGiQTmmIkmd
         faMu2MR71+NRMnY+2V+xqbGugaEEXxp7ue0HdopIPH7tAgF++bY5XAr9a1yMsuYJ4XJL
         a2fW/zSSNmfv/+kp+6E0/DtzAFg+iFjIuNLR0YEIdhKOxmsbt7LYxlyLyrQtqsX7ceUH
         Ea8zI5Lzc+F4ys+Zp5CmMqXzvFKL8yFQYWUw2Q1eLCA2s9nK0MQVwNs71iNJWcMtKj6F
         xuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCViqiSmY+TqlaHhjIKtVqv8T02mdx2hJXc1uthM117YNOKMTMDxQ/pogo1tuQjuceOGPb41N+L3dEN3PQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYwO98ggwSZLvldm/oHq+NvBrDnfG3dcKb+jZlIE+X2V9VnLMJ
	f8oSF3xDrwWb39YD9AFqoM3FScSMteAQqI1pwrVlbZDb0AYYT/N9s3k3oQJb0OA3Pg==
X-Gm-Gg: ASbGncvsfVVIhsTtcn8z0C0b398b7bn9ikc5jgPik5ttY3bdw040gSq719RNmzIbfxr
	DVl1eDzBIlCKEh9Lc063/Y8a4qdbZcGU86wpXkDTIoff/P4wqBTvjt60KtpgBJPio315952xFDt
	J0jm4sC1mMjZ7m8im67srLF2dy6fELVaWu+KTnMwQlHztAV/8y2gX2ukVLEsegZAmN1lEENMOGm
	tk4MATND44YKbvSHVhrFm+qxCgb6gtrDUeEgCZ99sVLvg==
X-Google-Smtp-Source: AGHT+IFqL8ZFopa21eavo0wjWjO+SunkCkSTG5gMNIc1C8dYeldJRI3CGU+zbo6ardpIhWEHfdovVA==
X-Received: by 2002:a05:6000:704:b0:385:e9ba:acda with SMTP id ffacd0b85a97d-38a221e2738mr47348863f8f.2.1736258433714;
        Tue, 07 Jan 2025 06:00:33 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1fa2bdfbsm49735092f8f.102.2025.01.07.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:33 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 16/22] rqspinlock: Add entry to Makefile, MAINTAINERS
Date: Tue,  7 Jan 2025 05:59:58 -0800
Message-ID: <20250107140004.2732830-17-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881; h=from:subject; bh=TW8UI9TMxQcBoeFf9FYBebGoM/areyCYdGlRu4N2BqM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCe7SrjvqmS/EXU7ItmbhB4WfLS1DE8hA31do/W g6wfnLCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wngAKCRBM4MiGSL8RyrStD/ 4qLiHX14Iz9ND/8Fxu5UtRTZYPgn5uJvgoGwtR9Fxus0bftUPkl6rheOXoAc5pbPXKS1NuUvPUOA+j PxjzFhKILfk07HJRkkm4whkUJVYQr2wsblZA8P7CvYkuztP7kbwtG3hMdGvlkTFvZXiO3H6f5OgPul c53pY6wx1fUM8IJMfB2REHhnXq56guqY8OLKjVjCvkdr7ErmUlJ/1jRg9+Hr8ci/aqPD2kfgtG9DOt klXWz/JHOaZq++aYwRT8AiNz4XxjRlDUgP8zNGBIXp3t1FmXbX8w7Cgsfe6RbSVIPvCfxFdvbNbp09 DjMOXbqkw3e/xiWeAAG0paMPlyJthCvD27JyYNWdbVOUPgs/xUV7Qp2rlYcgJR3852RJca1w3MtuAk 0qxpq2qtR/OseJAwc76EHbbQMxGrmnBAUpT38HllA6as8GShlaaua4225j+S2J99AaERiCYS1G1Khu C8vmMDyeuApIvm7n2/4iYhQ6J00wpSWo6n/Cp+EIh8Qrlg1zVh4oGlDsIcqnnta+kIOyHQ6mv/Lqse vCCq50Njrm6fwcNZywoIL3YRafz6F0FtnJbr+z1fTTHh1dyDXXCC7CD1QCjTlEEAzd7VuDO7u9XYTM gJxlulmgeAokdzgKGm9LNwzTNhnrLljyabPWkfA6ylZQZ8Gn7vDMrsYOl4Uw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that rqspinlock is built when qspinlock support and BPF subsystem
is enabled. Also, add the file under the BPF MAINTAINERS entry so that
all patches changing code in the file end up Cc'ing bpf@vger and the
maintainers/reviewers.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 MAINTAINERS                | 3 +++
 include/asm-generic/Kbuild | 1 +
 kernel/locking/Makefile    | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index baf0eeb9a355..fde7ca94cc1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4257,6 +4257,9 @@ F:	include/uapi/linux/filter.h
 F:	kernel/bpf/
 F:	kernel/trace/bpf_trace.c
 F:	lib/buildid.c
+F:	arch/*/include/asm/rqspinlock.h
+F:	include/asm-generic/rqspinlock.h
+F:	kernel/locking/rqspinlock.c
 F:	lib/test_bpf.c
 F:	net/bpf/
 F:	net/core/filter.c
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 1b43c3a77012..8675b7b4ad23 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -45,6 +45,7 @@ mandatory-y += pci.h
 mandatory-y += percpu.h
 mandatory-y += pgalloc.h
 mandatory-y += preempt.h
+mandatory-y += rqspinlock.h
 mandatory-y += runtime-const.h
 mandatory-y += rwonce.h
 mandatory-y += sections.h
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 0db4093d17b8..9b241490ab90 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -24,6 +24,9 @@ obj-$(CONFIG_SMP) += spinlock.o
 obj-$(CONFIG_LOCK_SPIN_ON_OWNER) += osq_lock.o
 obj-$(CONFIG_PROVE_LOCKING) += spinlock.o
 obj-$(CONFIG_QUEUED_SPINLOCKS) += qspinlock.o
+ifeq ($(CONFIG_BPF_SYSCALL),y)
+obj-$(CONFIG_QUEUED_SPINLOCKS) += rqspinlock.o
+endif
 obj-$(CONFIG_RT_MUTEXES) += rtmutex_api.o
 obj-$(CONFIG_PREEMPT_RT) += spinlock_rt.o ww_rt_mutex.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
-- 
2.43.5


