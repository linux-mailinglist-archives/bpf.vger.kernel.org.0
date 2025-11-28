Return-Path: <bpf+bounces-75741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AB6C93487
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8507834B82C
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32B42F0689;
	Fri, 28 Nov 2025 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzXh1X7s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3CC2EC553
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764371753; cv=none; b=gIdBr65VxbO7DmxaO+Bccj8CxziJwWe9l6XZKKWx6BTrxKvc+d8tAayb+PFV3vhx7ICheLVTBsMjAWFtHFeMui4vob++vWJlT5k3ObvZhuuf2o7u8jWBf74Qh4fOy+rk1Xk/sZq9YnigvqSoHft5YXPBJTXbZG2dN+KJnTESgSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764371753; c=relaxed/simple;
	bh=c5hZNsHN/RQQsRzx3hzeCjcb29VJskXopUD6u+I+Z+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpTvbCyN16I2jhSHZujpAiSv6wCz+nSkgY7WjSaROhrWe9P41qaOYyVx/2JTH0MVl2vuslVDiy+Op0t7Nn/zx0lXv3kCevxYKQGvJvgDF0p0Tul45gHape7dnRxHRM0leGx9JCmihGqgVEegDDbZOFNdGBxUEIRzpKiXZHPIGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzXh1X7s; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso9622705e9.2
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764371750; x=1764976550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRS9nGB/iRdHAWJ8yzHVKZpM1im/WZXu5/twM1aBLIA=;
        b=SzXh1X7soZYvcF05+Ts26GeIEKD/znJhmDePt+n+tYP8E71vOmrgMCnqY0ZP1hPx0l
         jOj6VH0syIED81r8jwOCd6o56p9X7TAl5Zx6xI4kD+15yEGp8MPoPJmESpusNqLvTigV
         /zC8v6WIXWFLGf2txl5yZ99SgN+f8En2vmvc00V/wi5eatinuptVuxAuKhFaWnKHY+/H
         OXG1visLlTtk/H1Rj03uPNQ0N4g9BnVFo03xYlUf/xVzLJDtTYCpckCY1CftJ9xSyPmd
         JpvIx7/4O7yH1Z1ubQRM6k2d6s6gRP1Wk7oq86pymX7wzgrI1jLTWCIF+tp5lRZEtmG6
         poeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764371750; x=1764976550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CRS9nGB/iRdHAWJ8yzHVKZpM1im/WZXu5/twM1aBLIA=;
        b=e1BavfxvaRCLSLkm6yESssDP3CDSwPDzQHgNT4mzc7pXboHW0TSTIIpMzrHUey7PuP
         j0JXZ5CjKeF1od0AgG9E7Jg26aM1XT+zfCne7EZz3raie98JWQAn4GxySvHTsg0EXUPj
         PVqOOCx1CmTQ32CU+1odMaZvvhlMIm4B9G0Jrq64WwYAzEOyKa8n1tUH3j9P4mN6AZFC
         9gKLiEH1XO+0hIe6P703SPE4rpMozg9S1q256S2wokmYKWxIrUjGFxQ/OwzK5O+bRowz
         k0NQzZWnrwp0oGq5F/Q5P3DDXTatSF1ESF6EhgY6a48FpjDp/J1Qbqql//LXH+fuqa1s
         h53w==
X-Gm-Message-State: AOJu0Yzu1W4U+YC2KijVogBHh54KltwaH2atLpWv+XqkfRH6j2cYEAr0
	taGei6KRUhpfyavVyRBlTWvDRJbhV7Wtghnhg4Pn1Wqm8I1545sqAaY4vnfyS8L3
X-Gm-Gg: ASbGncsFM5Rap4kTyNGJM9mr4Z8zEmwLZy3MnAKaUR1el0wP7HZVwoyGHRNbMN4pfC5
	WHBnwMBx2kibveIBY1IR2rGRK7zl5+pOyHmNaXjxP4Z3zgqP8jmpizeR9KVgNhjMzF7HePGUlWG
	nvMaVO9fhI9x7o5TFHQoNNp57w05GoYHO+AwkcBC9Lv2ISnsGAgEBE5O21gUB0LPsH5Cu1aMpV5
	ZgHPaRYh5FZ/8TyhiGOjdl7ebuRbevnBdf4aUTtpsCivuDdT9/SsP32M1ombEmzoz+98lGdQM6l
	N5DypUyyGQLlkP3D3q9tLlxUjw8bmxVdutfYIzmSxrNv3arC3BRzFJGSt3NhKbwuJBHBM/OClu3
	K1Uai2SFCkyoXJiCBRVCJGuOaJRwB7FK1TOzdVEm+Ig2kTFWDrePe2rXvM+EJMdmPnSz5m0bkaW
	v3T6sOsW5ONRP6dJSzQdiWf5IwcJztcXbGfWlPCH/kb02UPtCcdTZ61e6H8w0rW6BC
X-Google-Smtp-Source: AGHT+IHd/IJQRfGBZ27oj8ziOY4EdjTvqOvxcAmJ9LTve7+RenFQi9WttokDH25G4fhI1gbCWlyD9w==
X-Received: by 2002:a05:600c:4e87:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-477c01ebc76mr289981215e9.30.1764371749562;
        Fri, 28 Nov 2025 15:15:49 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42e1ca4078csm11851760f8f.29.2025.11.28.15.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:15:49 -0800 (PST)
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
Subject: [PATCH bpf-next v1 4/6] rqspinlock: Disable spinning for trylock fallback
Date: Fri, 28 Nov 2025 23:15:41 +0000
Message-ID: <20251128231543.890923-5-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128231543.890923-1-memxor@gmail.com>
References: <20251128231543.890923-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2539; i=memxor@gmail.com; h=from:subject; bh=c5hZNsHN/RQQsRzx3hzeCjcb29VJskXopUD6u+I+Z+I=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpKiyQw73BqxOAp9YsmqglGXBLV1NVwoy0ynes5 yw1QQtgHyWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSoskAAKCRBM4MiGSL8R yqAQD/9QDVwuievYUJdHpfKCS7+qWZ93bqAYs0TackAXSbCMnSyy37wzOX4pcB/ygTK3RiE6Dwc q70RG+0vw3NGt8R4SOXoD0YR/thwtkJ045AqyPZoi4faVgPnwx0oEX0fCqf819EbVSEwprXDhtp OyUXE4SbpCq9ko4SMwtn+Py2itIEb0eRdMgxxfYHB0A6y32PKfsYBtq36NdOvX7k+/jNtKDSsSC 2FnC7gUHl9GTSyZ9dh18INBotVSlq3MwHUKXdIO6rBUQ6Pg78CvmdO8xEYswpuIbAsmHBBqUe50 44MG/9NYzUc6MX6pSqcOdNwc6bnQN1TpmZrBeby71uHChrwSPl0w5Lvq8FKOwfeim/neQnvXHY4 cy7OLunnL1SIwH04XoeeJurHwNiRVwMAnwV5WtUUhoBVC4GJRw9v2ljJwUTnb8ejcGMwQehQPcG LSC6gglEiLJNA3Y4V1wBDJ/YrpyP184q7++QDJbeCR/RgreLYhzZgZedelrFTHBDjWoBOzJqsG0 zdCIvDEv43LEn5TAVOtV2IsWK7GixBBTBj4T8rPZQSSaiTPFBLi0f895iSoa7k1DcGdFJSdO/ym 1r5gc8GtPmbFFemjQTVBskOYe3WSC2Ly2HRIyk83PbTGfw9YcJn6+1X4t99voBm8yKG9fbyYyUD k5QNrUbf5vqr01A==
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


