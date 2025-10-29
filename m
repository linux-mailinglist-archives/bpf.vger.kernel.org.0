Return-Path: <bpf+bounces-72845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BD3C1CBED
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B031893170
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 18:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B999355809;
	Wed, 29 Oct 2025 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB21Cq1r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF683009E3
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761918; cv=none; b=Ak8ImNPCpgUpurMPsaEGdWP3YBSBNHENleaAdRAch2LET5AVQdaCf3zrMYrCdxbX8G69iKIsa94OYXzAuTpDMEezOLxRZI7dBUQk51idXd+Nd5JqqH0MDKjb+sVos7APc7NteWtzCYxYt2p11QjcgfoQeGwjxsZ2gyfgFfl4g78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761918; c=relaxed/simple;
	bh=EOhERjzvWC7Bj7y1PUq7vAL3U2w4wgkpGYr1Mzkl+Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTQALsfONJ2gNGpIDS6Vs+Ybe7wEhUp/iKrkUP91yWbi8l4tYEsxWujls2QoED4h1cr+/H025VLOU/7xKYAGpjMZ0++2YfYO5ysral7/XhVlaTGykQ5c8I4ZK4kRqwN6P2bmt1i9HD0CgLtxMMpUvbIuOoO8mioB+bA3HJpkguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB21Cq1r; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso1952725e9.1
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761761915; x=1762366715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r9U+l2WGp+iZuRD7sVyPjwCGDyon5a1TUHIkdEs8IQ=;
        b=HB21Cq1rfVMJya5nx4W66rzqWSTZO6eA+S14Kld+6rrxQO7ZNPCXPQ2uaXpazbQNsG
         71SVfQu45jcK7UUdfBu09JQnT+U9vBM09boIaxiFf1Ro5ggaFsY+h62qih84zPZMmOZ/
         2WG9DownhWNuwT23ZN26qJuQqXd4RQMg1qw7/ld7UGkAvJQegU2TTUz26q7W7wIpo5kD
         gSEJMU68V5drE62G2lAsQP7526Bbf4TFF6734q2BVfYNPD3UuUZKCVgNWb6jUNlWj2qI
         4Vd+ECPtvG/Lr4MaXaQaGV0+RAkPHMqijJvc1DxZaJ5Tu1eFm/bOOjYKLk3xu9Hm8ji0
         d90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761915; x=1762366715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r9U+l2WGp+iZuRD7sVyPjwCGDyon5a1TUHIkdEs8IQ=;
        b=O6qaaxhikjII0QA2c0Rprp1Aki9fhzCjpfVtFlab3uvJdlzlES6IU7xh5BiksJ+Zb2
         9Oph74EfLKHdkY4bVlgDRiJ31koLgfyp91R16lzyfbPuJXbZikSgy4kDPqH6TLfhtpBN
         XzcpvSep3xg/4dlbukLBuudJJQy5Bp3JVoU2GqsJ8Tz6nz7Vj5bHyw56g66OULSAll+L
         efNzC1sVnrM8lsJMdw9mqJEtEoI0jDhhCiuzd5Q3/U5hhoOz5D38fdgr6RDZoQ1fEjD9
         aApr+RFz5XCpt9/gUdLr0F//oPel8KUCu5gb6Bh3Q2jcN9q+htbQTjR/gz5Bvh2wDRIk
         4gdg==
X-Gm-Message-State: AOJu0YwxA4tgeOC4x/DQzrj8AVxM9XIdkhoosMC1K3y7Ls6Y4OXEPXdJ
	R6KudyE0mSUFnTy6QE9GEsL2/j3JtsKqD2HhrOX30GE4WeWnjJ8Zgfcyg38i4vpw
X-Gm-Gg: ASbGncsnPW8XnddSBrfefJwwDOYs5Ma4c6/E4UVCrsnnyeUAZf0KKGFbOzKIGfom+4e
	DIn2GrLJejGMtKQJEK1Von/j61JKDEizYwenWwCGTCgVmS1DAaxCXaTlcoqieC6/y6sZc0DKZcj
	HLdjt23CtmveCmMnjFJ9ZPCtir4BkWl+UMcmO0SRAJ0MJ8eHIpgJPYWT7k/uOa4CX8UdBmAdULL
	m2FNczfyhrqB1BKsehY0BnUxTWMd8DX85yo+bksgO6QBom/3BxnaLgRndBmPaK9Gsj1m1f2/0Yt
	gz3Ek650qvw2ed7OmiY/pDN9ute8C6EpSnkRK4IPZijwF54lDbEgn1JJzfrSgPlFGPIZPf7O5VV
	jmIHbavDR1n1Sb0Z3C+ZQZKCJDplN1LkleNNIAuPm3lomLpTmF4CqyfRRVvX7LlhXfArLTjqrzZ
	tNaVNvMC9AHy4G4FYqUrOK9iloAG1iO8ielbBu761oyaPpAtcTLL5fUw==
X-Google-Smtp-Source: AGHT+IGXEqYDaqrF94/eFohiY5TSxxmhfW8Dk99hxVnPA2uzYCUQlbaqRMX1XSLEs7WhptWE8gevcQ==
X-Received: by 2002:a05:600c:8489:b0:46e:1d01:11dd with SMTP id 5b1f17b1804b1-4771e166d60mr43491495e9.2.1761761915035;
        Wed, 29 Oct 2025 11:18:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4771e3aae1fsm58757555e9.12.2025.10.29.11.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:18:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] rqspinlock: Disable queue destruction for deadlocks
Date: Wed, 29 Oct 2025 18:18:27 +0000
Message-ID: <20251029181828.231529-2-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029181828.231529-1-memxor@gmail.com>
References: <20251029181828.231529-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3091; i=memxor@gmail.com; h=from:subject; bh=EOhERjzvWC7Bj7y1PUq7vAL3U2w4wgkpGYr1Mzkl+Lk=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpAlY4YEEgXvpTUOkyf6kWpRh1Kq//YrZf15eEH 2gI5ejm7YKJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaQJWOAAKCRBM4MiGSL8R ylTQD/4iuz/WTpEgIQeM+BhB1uNMLZ39xQ8sg8bxZzMs1bJlIHUk33HliBn8lNvI9fBKTGMSX61 aHm0HrPUdrS/i5pJFlWHluulOq3vshpEEpVTRkpjgvLlvin0tPeQ3UE+F58zsuYH/8te6/yEeqS mes9C4pMrXNB5MbSruP0TzxSE1UAiZ9/Lb8hYH3PZYfVJYVFyoSI75xeAg2PmoqVSNjaDO7vX+e a+MSYV1UctS2vHOmOvL6Bn99gNsCdwnmEcFI9KTTIc34TADU+9XhwkfXtH5PkS3a89BSb9Zuv/y Ygg24iaPfahVLtrgii0XwjvsUaH6jk8ktaXfx5+STpw0BNTJs+x82JsbBqS6y4SWOv/N32zQ+7G J3Ha1JF7nSvoG/Pn9EtoDaaRno1TG745XCZGK7HB1CqwB4n9cVkuh1xXXyc+32OsTFZPC10ubdt v4EyJSf09O27qSDxU/e7X+YB5d9CimGcLZrh9hSRmh4DQNV05B7mM/KH5go8o/NMg/QLgHFx3ev 0V6COxsro8ngzatiBv1hJydEI78Ztvbqmtyca5a22y46oPY8wDstx/8QqBNKfhAdDE7wLL0PvJp foidGcRYmQLGyRzujz61MgF3jQbfyqTTHKpYZT2fVoAc+rlRsKW/svhmxmFvLuQZSd4Lug/tCVG Gdl41FkJ38hoSCQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Disable propagation and unwinding of the waiter queue in case the head
waiter detects a deadlock condition, but keep it enabled in case of the
timeout fallback.

Currently, when the head waiter experiences an AA deadlock, it will
signal all its successors in the queue to exit with an error. This is
not ideal for cases where the same lock is held in contexts which can
cause errors in an unrestricted fashion (e.g., BPF programs, or kernel
paths invoked through BPF programs), and core kernel logic which is
written in a correct fashion and does not expect deadlocks.

The same reasoning can be extended to ABBA situations. Depending on the
actual runtime schedule, one or both of the head waiters involved in an
ABBA situation can detect and exit directly without terminating their
waiter queue. If the ABBA situation manifests again, the waiters will
keep exiting until progress can be made, or a timeout is triggered in
case of more complicated locking dependencies.

We still preserve the queue destruction in case of timeouts, as either
the locking dependencies are too complex to be captured by AA and ABBA
heuristics, or the owner is perpetually stuck. As such, it would be
unwise to continue to apply the timeout for each new head waiter without
terminating the queue, since we may end up waiting for more than 250 ms
in aggregate with all participants in the locking transaction.

The patch itself is fairly simple; we can simply signal our successor to
become the next head waiter, and leave the queue without attempting to
acquire the lock.

With this change, the behavior for waiters in case of deadlocks
experienced by a predecessor changes. It is guaranteed that call sites
will no longer receive errors if the predecessors encounter deadlocks
and the successors do not participate in one. This should lower the
failure rate for waiters that are not doing improper locking opreations,
just because they were unlucky to queue behind a misbehaving waiter.
However, timeouts are still a possibility, hence they must be accounted
for, so users cannot rely upon errors not occuring at all.

Suggested-by: Amery Hung <ameryhung@gmail.com>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/rqspinlock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 21be48108e96..b94e258bf2b9 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -572,6 +572,14 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
 					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
 
+	/* Disable queue destruction when we detect deadlocks. */
+	if (ret == -EDEADLK) {
+		if (!next)
+			next = smp_cond_load_relaxed(&node->next, (VAL));
+		arch_mcs_spin_unlock_contended(&next->locked);
+		goto err_release_node;
+	}
+
 waitq_timeout:
 	if (ret) {
 		/*
-- 
2.51.0


