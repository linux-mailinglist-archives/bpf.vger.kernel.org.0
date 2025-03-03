Return-Path: <bpf+bounces-53087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C77BA4C550
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E837AAC56
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7522144D8;
	Mon,  3 Mar 2025 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnBKoaiU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47167231CAE;
	Mon,  3 Mar 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015417; cv=none; b=JvCPiSpQpr2myJxr3vNmr6Jtb3JAYsouwbs8AVhf8uKBhVEoZgm/jsJkAD6YGxKlkbQCMuFO7ojZw2JjMvnkSwRqZOhtCxUYiwDX6I+bS0gS0ZAuRmzsxDQkJ29vu0EG3BdJxJVfndo8fT09bxsEopjFp2WhXMgr+jQmZNeQq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015417; c=relaxed/simple;
	bh=qSIKPInVzZ0EbqaTg/PJPPvBSQOZHHVdC+CsMy/ps90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLCOhj+aI+MAbRb89H8F1BZ/Bhw71RG7PNwrhT1hKllfeUgkcGAD7061ZoBvLAR4EhVqYYaKnAkzVz0fwJ5eXGM441XGkyo2WKmGBEDL4X3IaPMYsCOH+5BSUDP/3bgKRmrXTcGIYeBplP9Lvse5ioha6qucs5T+SVnJBxS2WnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnBKoaiU; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-390ec7c2cd8so2125421f8f.1;
        Mon, 03 Mar 2025 07:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015413; x=1741620213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Uc01JwRLTx4LvOAU9cv3DgvL5O0RF1rRGwSEjckiRA=;
        b=TnBKoaiUodbGA0uOVg4hxvU7srRK28WThtS/o9qLwC/0es2dBI14SDdv+SIkMcSDTO
         1DkAcYhnM5L9NB4lgQLPInEHQWStaVwO5+VYMZkjvOIGyBTH0OW1xzgoJOcMYXb1kpwt
         oOO9PGlaLBB1hymbXGnKLGHSY/7d05UgoXy1uCXGe1jRdKc4Ik5Y/DPvCVhg4HBJy5pk
         ifCF6z7ckKETo0SVgdTtvl3fMxuQ68uWBM2gIyOxGFARWa2mwubUySI40Nae5g31UQha
         LkF3l/Tl/Kpylj6811E10PKPtANvTt0pt0Kyc7lZk++nEn14ti8Jpz9CRBq8DYL01tTf
         bofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015413; x=1741620213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Uc01JwRLTx4LvOAU9cv3DgvL5O0RF1rRGwSEjckiRA=;
        b=opNI5Kfqr4F6+co2uAT0bLkCbP4tvt6vK/K9cI1eKmKvqEtrIZGb5bVqC2CHd2VuPE
         qHj2q5/T+EaaewLsWE5U9kJfsDiBQ4SGGOvhjyTlm7/W+5IKUgLkl/eeSQlN6e7E73sz
         xkmU+1qpLueJaMOpriGkKYWAttlCVRlQm59qTx9nU0bLvGjAIg39zT6Qxvzc0HpPQk9D
         9VI56ztbD+r9nJ4gN2Hc/3H1d9K6Xjl6VcTs2WnF+E7Fq462pj/nUSrXVXfS/4qAB3Uh
         KA+ejEEVmmxkYurwwl3wxeehwi+rD5bOvUNV1pUluRWk1vuvelxvTyFvxVANFrejSB9A
         /dSg==
X-Forwarded-Encrypted: i=1; AJvYcCU64FhroOy9q5SbfqrjxWIjms0k78Rc4eBuKierI6HpevI6iwLGVXcUwaCJMlr0AdIMZFTjJo5WDvzzBFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqqroey/eRynecUXY5/a/YlgFOzHvd9lizgIryqrr4cY5svPXP
	MEXvkbjI7YnIaKTA+L5SNsRnggAIb0UpnVQMOPVElDULFBxm6DCq7BkOMKPRRXs=
X-Gm-Gg: ASbGnct7ZHyxTB/N/xeLYgLJvL2ISnBTKe3KPme8y1coIGPmgi3BQ5OVK/d7pnYL130
	+QC0wLnmFS0LeZHR70CpIJeef1/Ll6lNOTUZNoQfa9/FNDxFZNw+rUlE+WH49ddjbNzvxHzf7MU
	xOVpgdUjD6M7EShQBemCbyTfwcXQOArsjVyUpFuSeKPw7jgUl6W1iYBYW93agXwZAKnmPEjq42R
	OcK7wXu4jTOyp0NPvSfLJTMusIdSpnaoKSSwwlotKWDQjngRxXZv/GhrtKcqeOE/IKG2dp+hWuT
	NMfHbkXBd3wmcU0oQi+r0kdfxminMhbqFQ==
X-Google-Smtp-Source: AGHT+IE38gK5wJECZxFlCYL7vqyBrElWlJLLivqEZ8lVMAciRT4pe2f0X2OlAMW3qevmIMhBs6VcWg==
X-Received: by 2002:a5d:6489:0:b0:390:f641:d8bb with SMTP id ffacd0b85a97d-390f641d990mr8952175f8f.36.1741015412881;
        Mon, 03 Mar 2025 07:23:32 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4795d1asm14571262f8f.4.2025.03.03.07.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:32 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
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
	linux-arm-kernel@lists.infradead.org,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 18/25] rqspinlock: Add entry to Makefile, MAINTAINERS
Date: Mon,  3 Mar 2025 07:22:58 -0800
Message-ID: <20250303152305.3195648-19-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083; h=from:subject; bh=qSIKPInVzZ0EbqaTg/PJPPvBSQOZHHVdC+CsMy/ps90=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWYI9HLNzIFosVfpo/eAGZLrsdbAXI02uiFuv5j gAn43fCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFmAAKCRBM4MiGSL8RyraqD/ 429SlE3+raZFobBUUclVgrmx/5S5ghp0W6qHlpRJg15mqb/wQ7Nm7MfnP8Mt/cd/yugjieC5xXaIZZ 2gRGy1o4SiUDG91z7FYRxs5REy+twKo6/1wchd494MGNac2afJXVeogt88nnikDfs98ML1W3w4kR3r djShNfhU1YlT5UB9SixxXZsaVabsgXdlD37rG/rItcXLa2S3En21E7gq3ApgqdOWZE8a6/JpEG8kW4 1oXfdGyOuubLdfXTC9F1nuSlIdMSGnFINmAGPeE0mrtgS74cGYxE1pMpplfJMozQabn7YjTuU03xNZ 11p1zrVmvfoac73XycC6N+KM+AcpskEIKpjnp+SKHkhbf4PG513KLKQYTz3VNWwfUHh5AKOH6FYBPn sZ9LhuZ5FHOn+bfFHRURJQOjSlOHS088r968BsyQsVY1qv9RVyVM8VbqXS/C+frx/mSypWU0V8xVte r5NQyi+CfLnuOjZe5fyJo34b4gNNn+J/hqFR486kfOAD9hBD9pjSNnaD7P8U1z/36+m57yipbTlO3B QKtFBqPHAvNwGSaCkhb+JWZfcH7pd2jC83wadWyvMeixxn0WY4FwIP1tLyCP6lxkcbqNUICVYdOfqn LQ9KXmI+sQGaXI4NJ2OV88iI9YE445UWW9V+2WXlW683DUBbYbB8AjtUHjIg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that rqspinlock is built when qspinlock support and BPF subsystem
is enabled. Also, add the file under the BPF MAINTAINERS entry so that
all patches changing code in the file end up Cc'ing bpf@vger and the
maintainers/reviewers.

Ensure that the rqspinlock code is only built when the BPF subsystem is
compiled in. Depending on queued spinlock support, we may or may not end
up building the queued spinlock slowpath, and instead fallback to the
test-and-set implementation.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 MAINTAINERS                | 3 +++
 include/asm-generic/Kbuild | 1 +
 kernel/locking/Makefile    | 1 +
 3 files changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3864d473f52f..b0179ef867eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4297,6 +4297,9 @@ F:	include/uapi/linux/filter.h
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
index 0db4093d17b8..5645e9029bc0 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SMP) += spinlock.o
 obj-$(CONFIG_LOCK_SPIN_ON_OWNER) += osq_lock.o
 obj-$(CONFIG_PROVE_LOCKING) += spinlock.o
 obj-$(CONFIG_QUEUED_SPINLOCKS) += qspinlock.o
+obj-$(CONFIG_BPF_SYSCALL) += rqspinlock.o
 obj-$(CONFIG_RT_MUTEXES) += rtmutex_api.o
 obj-$(CONFIG_PREEMPT_RT) += spinlock_rt.o ww_rt_mutex.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
-- 
2.43.5


