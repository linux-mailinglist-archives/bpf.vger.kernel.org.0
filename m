Return-Path: <bpf+bounces-50652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FB3A2A683
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D131888052
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AF1231A37;
	Thu,  6 Feb 2025 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/NCpswX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB1A22F3BF;
	Thu,  6 Feb 2025 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839306; cv=none; b=U9JnDoQ7dL/F+og+a5z2kBpp3qwfyZvDHTvFKMpTC7Wkyin40LGAgGEh8aGdo6iUf+KnEdk/uRTV8/SZvaDgzMchZuyIDTDQ54yrCEPQCUvN+dtcI75J1lP8z79L62Ms3Hz7XNo6acdqL/G6fH1FYIZ+X5xqULexx6myl7GARrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839306; c=relaxed/simple;
	bh=E+oadE0wJWqBDHpLclZmcj/fTawgs/RCGY18+MKVeJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0fWWk7692ZXe/hbv+6IH0qY0JNtODIdpiDe5INlTOA+FpI11aRnEd2Fra+5VJLub1Ww6ZDj8z4fL7UKNdOMl/5/5jJ7+LWLNNN6+5pRcpql3ayXdOgJUX2bxeKP0bLQcvYeNHETeo+8lwtpefBFAg/cVs2f1n1tgT4eF9DYELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/NCpswX; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-38dba1cc632so429644f8f.0;
        Thu, 06 Feb 2025 02:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839302; x=1739444102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSwd0Ic/zADHNPGibPzB3vfQZwdDu0cIcYcU2UTlBE0=;
        b=U/NCpswXPsupXzvY8PX2azXWLYEfA5Hp4IznwBrq1WDvH+qXR/KSpL3rH7hnVqnnhv
         t2wEB1H8vwcw44LZgJ+/hNKh8frM591lyWGoZvi95PwW8Zs2BBZCpVW3tDKPWIWVK/xc
         JryOAG2M/yv6Y8M8o3XbOrka6mOfaURw1ebBmqNWM0lSbZUEzE+XVr1J60wwklbuH4Pn
         LpziQ+OsMB1sOC04uO7eNQ99qWop5csvVS9iFxmuqKj92Q6ZKfeshpqOAem8pDKcVVIp
         XqHVrtZXqDga+iWWvKYSpXT0Xwfia6HunFObSx1SgEt6XTdOOVlJjaHZVdhRXPnqd8YY
         banQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839302; x=1739444102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSwd0Ic/zADHNPGibPzB3vfQZwdDu0cIcYcU2UTlBE0=;
        b=YVnWGDh5VEjC6ylHJLrAENv3390qp8F1iMTnQA18tEhGiQPTeKHEaXh8x81Jub9GrE
         8JNd2fxxgT+XRyoybIjijXQrbx5pBJUDe5FRRYXXicOwJ/9WMZZz39hf7Xs2nkwd1GuR
         AAPhEwrFeIAu/lM+NcRkUA8QFM7MRJj9FXXLsrbu4hDyhJ2TTdbvivLop9CWzL6i3CgK
         mdrNF6x+9Iu2GvLfeE8S2vwrmOx4hZ/4yYyRobw8ScUKmirp7FdWuxojMsSoj8gbCNlP
         Mv+oMgL3buH1WmUH3klY7UdJCP8ZDZSU5kaJ7QE34hwt2BfFV1Y341UaL9P6vjI/1Nbg
         T5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXlC8zuuURW5G5ETj5/3xcrpvZ85iU+i5/FnFm+v9jGPqfBgwsNQ6GDwbJX4zvYsJ7oq7Q9oZeWxB3e3lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym5VnowTW8+fmgaIrWMBgo+KSC6TliICgf4Siy4nP+mwRAplgu
	S1UZnYOfp46bOF6gPc7zhzcPnr7st4jEANr9t7ExpX1vr5exRoUHV91OWx47T8U=
X-Gm-Gg: ASbGncvKIvD75OOXphGust36koGHdGRccGtDM/Wwcoeh4yRobUEfXUXeiHjqxv4Fth3
	p3b2OZO/wuGRboL3fCgDkU80PJr84UVXzUm3FAnFZcOC5jK7ZRyq3BGxUghZcqcAWfIVXG6JipS
	NxXyMLgbR9xxHZddJB5UCErSnUfT6OZ1NpL2FfHCbcts0D53o70u7vT+x4LZni6gU4oVJZGIhFI
	KMolx1y+99oc6GC/ZIx9u8A+RmZeaK6Uo49bCEJoDCulgBJNVvctGSdlhYKhe9EgXktKos6B9up
	Hrel
X-Google-Smtp-Source: AGHT+IHKdNt/2i2niit9x9Q/R1mWsETc05ExweAVXJWi6Fe7g9aArrjNh6K5B0b8g58nbAsrLJyEOg==
X-Received: by 2002:a5d:59ac:0:b0:38d:bf6e:adca with SMTP id ffacd0b85a97d-38dbf6eae30mr869218f8f.48.1738839302123;
        Thu, 06 Feb 2025 02:55:02 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:2::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc31b9394sm473848f8f.11.2025.02.06.02.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:55:01 -0800 (PST)
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 18/26] rqspinlock: Add entry to Makefile, MAINTAINERS
Date: Thu,  6 Feb 2025 02:54:26 -0800
Message-ID: <20250206105435.2159977-19-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083; h=from:subject; bh=E+oadE0wJWqBDHpLclZmcj/fTawgs/RCGY18+MKVeJ0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRmodQ4/VhA2GYFRoJhLQZknuv2U5hRh8VIgaN5 gjWRV/OJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZgAKCRBM4MiGSL8Ryq+SD/ 94tOt0FPzLcovxJ8PvSGMSImDYXVh0wToZsIW+lhBs3jfHW5GETrWPgvHrSUxGhML9no+RKLfirkp4 E1cPXorlRj2ki4xsWzLSlHk+EH2PWoH8jCjs6jMrtK+SMqCA7Oj4Ice6DQmaMIN6/hB/xu6chupbLc 1lXBQZPtFxk1eXA75g9LS8ZVQ3WXOnPj+t6OewmPFulHGjMCCRR9/1M8sw89gkNsM3aB5E5I7YGAoV DP5513oBCDAn8tJPZqTzddkWfZoi+q6onyMLx6WoRPWwd6fk/EKwhICv1Ikg+RI9MkK5qeIiUkhtsh FX/jfVeTi3znO3Ae+dZqpxdGdwDobONfyOditGEf38ImSjAUAeUfyJe4K8xYbvfWnk1WOMn8G3jHmE c9muj11DGHiIVfw/ynoQqr4v5vyuNYzu5FWY81NdA3Evh0nXgKo18riB8GKo1moM5Ga4Cc9rhmReue T30PWz9HdqaEAV4ligZ3OeXxNDjK8YNM2P3ccL8sziaBme2U8G5uVWyFh3wSuGZextoI1/7fUBWFY7 QuxUlV8b1+apMH6nrCBDVCO4LpBI+7ZQ9qDWn1MUzT7DTYAHwa19++ndXSIA4NCiycMOqEvocmJYpe V+70XrThPEC4JgdWBMXps/15vB9J+B+z1zka8ksy3fY9si4XlMK2GSNw1VjA==
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
index 896a307fa065..4d81f3303c79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4305,6 +4305,9 @@ F:	include/uapi/linux/filter.h
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


