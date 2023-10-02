Return-Path: <bpf+bounces-11235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1487B5DD6
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 01:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4669B2816D2
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 23:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE8A20B0C;
	Mon,  2 Oct 2023 23:47:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98661E521
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 23:47:13 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E00FBD;
	Mon,  2 Oct 2023 16:47:12 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-27740ce6c76so218614a91.0;
        Mon, 02 Oct 2023 16:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696290431; x=1696895231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVMLROc3eiE12rYXMNdufnFTC1ndnWQSfH8g24Ty96g=;
        b=syc24e3HDi4jCjnINXIafc+MiQ+6RKA29oVfw1zXZW3G2wMOkRPYg6gC1hj1v3k9A5
         gu8hl85I0/mjG5G3rlnvda4iiVflTRbQfqWcH85Wz3UhipYyqjOEYAqmoq75CBZ6ANhM
         rEtHQ9vzODiEAENam4WA0sN47xS+j3zyhh5SCeZvq390vW3165NR25jazfbkqoHboS7W
         FkoB0HqXLO/hJ2Qda35Q9v/xh0qqw57ObAyAyZwFuB/YyLa8vZ0g+yTbSKeWgY1mlaNs
         mnlye3r37TzLry7JUOV59wNOx/XBTndRjUwdblvtCtGz/hEP7Nw/sh71PHRnTlH84w1s
         0bWw==
X-Gm-Message-State: AOJu0YzygmUwIhKoH00gCsi7hSb0ncJuTegGWiPFYtriM9Oe+BTnx3mG
	iRU3cAARQhfFBNmh3C/4hl8p4WYS6XhrKSSG
X-Google-Smtp-Source: AGHT+IG1F0c9euUmaxbN5hsL+bTx3fCi+E4+ssLdYnBiRCxG58MXYD4AdJHDudvL7FGsq5lYARff5A==
X-Received: by 2002:a17:90a:16c1:b0:274:748c:9c55 with SMTP id y1-20020a17090a16c100b00274748c9c55mr10070476pje.20.1696290431298;
        Mon, 02 Oct 2023 16:47:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:d0e0])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001c444106bcasm28340plb.46.2023.10.02.16.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:47:10 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	himadrispandya@gmail.com,
	julia.lawall@inria.fr
Subject: [PATCH bpf-next 1/2] bpf: Add ability to pin bpf timer to calling CPU
Date: Mon,  2 Oct 2023 18:47:07 -0500
Message-ID: <20231002234708.331192-1-void@manifault.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

BPF supports creating high resolution timers using bpf_timer_* helper
functions. Currently, only the BPF_F_TIMER_ABS flag is supported, which
specifies that the timeout should be interpreted as absolute time. It
would also be useful to be able to pin that timer to a core. For
example, if you wanted to make a subset of cores run without timer
interrupts, and only have the timer be invoked on a single core.

This patch adds support for this with a new BPF_F_TIMER_CPU_PIN flag.
When specified, the HRTIMER_MODE_PINNED flag is passed to
hrtimer_start(). A subsequent patch will update selftests to validate.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/uapi/linux/bpf.h       | 4 ++++
 kernel/bpf/helpers.c           | 5 ++++-
 tools/include/uapi/linux/bpf.h | 4 ++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 70bfa997e896..a7d4a1a69f21 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5096,6 +5096,8 @@ union bpf_attr {
  *		**BPF_F_TIMER_ABS**
  *			Start the timer in absolute expire value instead of the
  *			default relative one.
+ *		**BPF_F_TIMER_CPU_PIN**
+ *			Timer will be pinned to the CPU of the caller.
  *
  *	Return
  *		0 on success.
@@ -7309,9 +7311,11 @@ struct bpf_core_relo {
  * Flags to control bpf_timer_start() behaviour.
  *     - BPF_F_TIMER_ABS: Timeout passed is absolute time, by default it is
  *       relative to current time.
+ *     - BPF_F_TIMER_CPU_PIN: Timer will be pinned to the CPU of the caller.
  */
 enum {
 	BPF_F_TIMER_ABS = (1ULL << 0),
+	BPF_F_TIMER_CPU_PIN = (1ULL << 1),
 };
 
 /* BPF numbers iterator state */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index dd1c69ee3375..d2840dd5b00d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1272,7 +1272,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 
 	if (in_nmi())
 		return -EOPNOTSUPP;
-	if (flags > BPF_F_TIMER_ABS)
+	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
 		return -EINVAL;
 	__bpf_spin_lock_irqsave(&timer->lock);
 	t = timer->timer;
@@ -1286,6 +1286,9 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 	else
 		mode = HRTIMER_MODE_REL_SOFT;
 
+	if (flags & BPF_F_TIMER_CPU_PIN)
+		mode |= HRTIMER_MODE_PINNED;
+
 	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 70bfa997e896..a7d4a1a69f21 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5096,6 +5096,8 @@ union bpf_attr {
  *		**BPF_F_TIMER_ABS**
  *			Start the timer in absolute expire value instead of the
  *			default relative one.
+ *		**BPF_F_TIMER_CPU_PIN**
+ *			Timer will be pinned to the CPU of the caller.
  *
  *	Return
  *		0 on success.
@@ -7309,9 +7311,11 @@ struct bpf_core_relo {
  * Flags to control bpf_timer_start() behaviour.
  *     - BPF_F_TIMER_ABS: Timeout passed is absolute time, by default it is
  *       relative to current time.
+ *     - BPF_F_TIMER_CPU_PIN: Timer will be pinned to the CPU of the caller.
  */
 enum {
 	BPF_F_TIMER_ABS = (1ULL << 0),
+	BPF_F_TIMER_CPU_PIN = (1ULL << 1),
 };
 
 /* BPF numbers iterator state */
-- 
2.41.0


