Return-Path: <bpf+bounces-75753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C7C934BC
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7D784E33AD
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1D2EFD80;
	Fri, 28 Nov 2025 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/XAB/oE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1308D2ECD1A
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764372491; cv=none; b=oHS7y0u/ameklB+T0oC4Z4MYQ8a6mRyVPUUi4jkbzaX6ym2kJXzz2KYtCHcjhR3U1LGT32dkcGzYiq/iUwL8AsiI1f3P/WydCpI+TNwYvZ500jW6kzdmXHxq2TCzR353A4rxD4F4s9J6yo2Ha6aFBFk/TTYg7MgXUevqj9NeM2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764372491; c=relaxed/simple;
	bh=c5hZNsHN/RQQsRzx3hzeCjcb29VJskXopUD6u+I+Z+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjnEvWJk+r1j7d5BMUf3KVXLp1SvnzT87z4NEd+5vQUscnEJlC/y44R4TWMyIhNEoHuHMeBoCpQOLAKIlpqCRuIGzmkttJVpo2TgsaLbPvwb6Vp0hjptkQhUXG7e/d2Ka5XVQSZSmCAsYbYjTWluc+u2F6w103rrPQYYlfwHe8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/XAB/oE; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42b38693c4dso844674f8f.3
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764372488; x=1764977288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRS9nGB/iRdHAWJ8yzHVKZpM1im/WZXu5/twM1aBLIA=;
        b=N/XAB/oEzGaOcotTmeQvPu2xtqaQ9xzscNGU0/INGKlFoHjzb038sipkJDfn58voce
         RH18jssdvEq0F8LIm6ThtDQnz+4vVmuHEm6IRQscaGtb4l+pL4ufEbrUV2VBM0iThM6e
         p8M5At5FJFNJP8wQSbmxOXzLQWDwdVKQZSh84FRCsAZR1GgywGYUcz45wQ5lBVeAEkqZ
         ilEUMHBJfKWqagRzhu8lRJ6xqjcIDtuKLXePd+40JOuMazkk/MPevmSMPa5sMuVyguvV
         2qPy29CrNEQFJeB76fFczY6+CUbdZjtRyEtQ5YrmHAp/tx0OwuDUddkTPTPTd427zi3X
         hHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764372488; x=1764977288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CRS9nGB/iRdHAWJ8yzHVKZpM1im/WZXu5/twM1aBLIA=;
        b=VgGji3EAWnvMe5kldmEg/DzQQ8rzTilxQWN7bHZ++V3cbOaaYszBVZ3Fw4yaiwpkcD
         LRVOVxLlZ0/4qVDjKRJUVDo+xt0Ku9pRFX3MAb5ntlBXTrs0ebeigI0RqvQZCVrnpfJi
         dptWme3lnaCF93EzENa0qQPTe37NJRE7FBhJTyttZq2duOR0DRbHOT2427vDASxZqjJD
         bW4yKcTceH5iTU9E0Rrqlup+nDCi0aEBmcA17UoA525NCoJYvla2uTjVtP9N957aLULI
         1ss6hJpTvoFAs0zVOfcwRQk84WwmsZG2oQkC9WZeJeGLirJYNq+w71f08T45tSO+f+Fz
         vQYg==
X-Gm-Message-State: AOJu0Yw3YthVVbrND9Z1Ss4dMRqb6hWAfJ7mgJW9EDKRHptQ6GXXt7cC
	RzYLlAhxc6iYpANUxeHwNymI9syaqmnAP9EeA8WjSFvF8XsJglt7yz6/uUd1JGXz
X-Gm-Gg: ASbGncuK+AzibztE5TENFRfSVKbZeBtptkMgFFJHYg4+W6+vtDP6rypVes2GG7a+dvI
	/a9i5wh1y6qAtv3s6idOn6We/SErKNcM8z1wzyCx/+PBgXIa38EC0UAYKWHDxuW7EfiW7EmfwqO
	WkYbaMg16om+wleynVeQ+OZWbpVVH5+aA+0gVcYxwUu5d5Ke7nF49AvBP4cuENEvuP2i1LC8R2b
	pZfvLmb4rk92miGOYJo4WK+v2C4hYCAQC6WY3DbCF83yHEs39n8+r0h5W9kLiDOP9M3UMT3jmGy
	5Zx+mKyNfRjU49AQ9+Gn9oBYl6BC+JO7IVcJgABHt93o2msGtHx1z5BayE2VCGkf0JSoxKpHi4Y
	+6aTolqw8QgbetxTJWbR5W64bkHFIbRE3h4i8xYU09F39hMLn7ISaiHIEFbvZUj701x0jOnimfQ
	99m9JpospodUTC4bhDaY+vmuS9AnY3oGMDc3ZDZE8YMMSj8t4UW1BcRH2YiTK5hUXF
X-Google-Smtp-Source: AGHT+IHeBFlOT7lf1Bz5uPa0xV6TOhiafWAlc4rsw0VOboYOZAvwybYbFe8SolEFI9GphxnCS9rTFg==
X-Received: by 2002:a05:6000:2c0d:b0:42b:3bfc:d5b4 with SMTP id ffacd0b85a97d-42e0f35bc39mr18648836f8f.51.1764372487989;
        Fri, 28 Nov 2025 15:28:07 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42e1ca1a310sm12295696f8f.26.2025.11.28.15.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:28:07 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>,
	Jelle van der Beek <jelle@superluminal.eu>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/6] rqspinlock: Disable spinning for trylock fallback
Date: Fri, 28 Nov 2025 23:28:00 +0000
Message-ID: <20251128232802.1031906-5-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128232802.1031906-1-memxor@gmail.com>
References: <20251128232802.1031906-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2539; i=memxor@gmail.com; h=from:subject; bh=c5hZNsHN/RQQsRzx3hzeCjcb29VJskXopUD6u+I+Z+I=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpKi/xw73BqxOAp9YsmqglGXBLV1NVwoy0ynes5 yw1QQtgHyWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSov8QAKCRBM4MiGSL8R yleqD/4nCixOJXyNNACuaxcwS9e49729JeZnlWVIHldhQNMeZbtkFpsXhrR7T0X8bmeuNvOB0kN M1Sss+17VCcdonxBPE/SmR1blAD152ssJ7ryj2La0NyVlCCYL3o7z4tOC5xs1unhRR3o2Rq+pjJ NXMwCL+fJ10suSxBf8Z52dDEIEqNPs9SNB3tuVYFr+KUhlmYYapaKg6kcvBCj8S2+NxZccv4NTu jIwrGgeSZseDPYQaOJp6ZnEJkcj5Y33AGyFiKg0ffRD4CSO08KO1GDtcOeP+K2C8378QG+b2B6g lvDHjlFf56eZ2cbXUDttNvenraP2k91ka8G3WNIzVfC7lak9GvDtKWeLb50bPoCpg2CuGXi9lIS HkSJUTT+XPl/1Cp1RhyPoC6h1unCxXbwTv9dvwQrD3R5hMWWifCidoMvdeSWFtPlW81uzVlg8Ju NvHtKCKhRz6Ee+vejGr184kiO5PSZlzq+J0y63y3rfocouNDJjvDVwI7xhLKTcoGgYyudR0I20n AzvGaVbyLUhEaL+OHwG92l49A1y2oC5CgW5EgStcptMQ17f9jFjykworDuJTz8sepxV+24YWeZK mlY5ysg40Ph1ZBYvp+QAqX5Zj6xV/KwfGCITJSTSZmUmtIwBRcEPlcBTa3EI8+NRKt4Ve/hbG2L UXJwnGQnOmd8C0g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The original trylock fallback was inherited from qspinlock, and then
reused for the reentrant NMIs while the slow path is active. However,
under contention, it is very unlikely for the trylock to succeed in
taking the lock. In addition, a trylock also has no fairness guarantees,
and thus is prone to starvation issues under extreme scenarios.

The original qspinlock had no choice in terms of returning an error the
caller; if the node count was breached, it had to fall back to trylock
to attempt to take the lock. In case of rqspinlock, we do have the
option of returning to the user. Thus, simply attempt the trylock once,
and instead of spinning, return an error in case the lock cannot be
taken.

This ends up significantly reducing the time spent in the trylock
fallback, since we no longer wait for the timeout duration trying to
aimlessly acquire the lock when there's a high-probability that under
contention, it won't be available to us anyway.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/rqspinlock.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index e602cbbbd029..e35b06fcf9ee 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -450,19 +450,17 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * not be nested NMIs taking spinlocks. That may not be true in
 	 * some architectures even though the chance of needing more than
 	 * 4 nodes will still be extremely unlikely. When that happens,
-	 * we fall back to spinning on the lock directly without using
-	 * any MCS node. This is not the most elegant solution, but is
-	 * simple enough.
+	 * we fall back to attempting a trylock operation without using
+	 * any MCS node. Unlike qspinlock which cannot fail, we have the
+	 * option of failing the slow path, and under contention, such a
+	 * trylock spinning will likely be treated unfairly due to lack of
+	 * queueing, hence do not spin.
 	 */
 	if (unlikely(idx >= _Q_MAX_NODES || (in_nmi() && idx > 0))) {
 		lockevent_inc(lock_no_node);
-		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		while (!queued_spin_trylock(lock)) {
-			if (RES_CHECK_TIMEOUT(ts, ret, ~0u)) {
-				lockevent_inc(rqspinlock_lock_timeout);
-				goto err_release_node;
-			}
-			cpu_relax();
+		if (!queued_spin_trylock(lock)) {
+			ret = -EDEADLK;
+			goto err_release_node;
 		}
 		goto release;
 	}
-- 
2.51.0


