Return-Path: <bpf+bounces-75755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B89C934C2
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248B03A94B1
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC6B2F60C1;
	Fri, 28 Nov 2025 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G47pfJls"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051D2F3C2A
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764372494; cv=none; b=CDF9MbOh8fKUu2i1doHjmRswcZR6mMwhNuHBVuRWU4fUx4fSeMOcSU+aRKISW9ZKDNIS/z1xOA/9SImI8qPsgFFyzi3De+f9KKu5mU+IM3ccmEPb1mRbibWH/4z9IK3fD4/WMup6PpwsGjKIG8nrvA1JFeWf/LyLn3iFbQRdD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764372494; c=relaxed/simple;
	bh=QMCJK4fPNJoANX0nTroINnUWsKFwJRZb4SH4XDpD2wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZRPIyH3tJ8PseDuTpG5slXTVZmVqas46FdP/fMPKwKQRhfYHDCQ20i++klNrW6y3V5k2Tj/TQ7dCbBsEw+MbsKXHIkBRgSQOzTrR26yGenCX/+JQOHHPh22EdIuuBsbAs6CjN2Lnax3vmV5SrfwaOT587VSBjfrTR6wa4yVw5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G47pfJls; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47778b23f64so13288785e9.0
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764372490; x=1764977290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxqLZL28Ppaox8tsOa1qySRq1fbpY+EejLK2u0zwo04=;
        b=G47pfJlsx2PUmzGssKny6/8DKsfPkNKG6xi3THfHu55VoRT4Rf9w1EY4N5IXPnbzRI
         a2z8cz2IU/noZ2/oqyMwnXbSYNZ7soX6UtTzoSYDW4Pzwf1g7t6NQNyDDJX/vUdZAAOW
         FZIJukwROP/315S2GUNM5Yj84vnypWirI2MJItkph9E/sGITGhabdAJ2OUuOTQ92RI1o
         eo5fXESNlos82vzdj89B5MMLcPO97gjYM1GMBESbR7rTfawGrDtdY3oEF3JSzOt86/qc
         YqULmKtwSXuoULyvsUdMx2ZQnQ8kzQhzqC+f6GTHTkhDVORjycZgQNtT1W7LbRp1LVoX
         wuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764372490; x=1764977290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wxqLZL28Ppaox8tsOa1qySRq1fbpY+EejLK2u0zwo04=;
        b=HnAtY3dBWGZZ6SLRoQx+VNMGUNP7nSiS9CTLe5au9S3d5CRcpww3qzQjQkuRjFef2n
         7tDM+b0ZzH4qLZcBzGDe6GI++Ruv9F8janRfSj41jXERute9T8zKuXi/uvHQdpxxD91c
         axrnjfnbUdAaeF543cXIvlI5PvvdHsexRsyBLN2eLjIroKPxCHPhxpfVFTSSyIsvt/vq
         DSQ5z2npHR2lxIGE+iqvJomHD/FoVXalUNdSekEvHCnr0wS8nnt2NSzvOuJDAbN3H9Fc
         kMpgp1xDxvgD55Daps+mYeq8LDiYt9yJfYjzO7i/zletah+gaJX+90WAyFVQZ7tupAR7
         Ftiw==
X-Gm-Message-State: AOJu0YzAb8Uw1s6lv+wWEiu1pcvVsyjnUVo9MBfWFjNs7Nepce0K3QfL
	My0pCP5nj9X+qEL2XK18fPiGnYtZ+qHpfKyGTfuVttUh39Wy8Pe/8Luk/ptLw4SK
X-Gm-Gg: ASbGncuLWXHJsOhSKqNYE4lDJuZwtyIxsMwNhlLpfljaWRX3elfuU+EPki8tp1yQfoB
	sVDsI4CZY0YrgQV2kbzRLKCMBCN1GtyUZjbGDbf8/+U42J/r/MpfovCFK1tU9tZZFr13NC5y1KQ
	pOgO12HuA6PkXaH7kCe0qR+C+hoRyFA9dEstIVpjPPhh94cEOepsn7Xqq13mFKNZe4gAF/lOi2m
	7d0lsEIxDsufj2suhbEUJOQF5eJ1pcqe3Gt4nyoGKjJibep1LwzOzhxxX+EnZlzhAU/VP8qOzqo
	sj2jOWkiHIkfjrQ1hBYzDUrB7sVIXbjxSdTnk2J4/QCDsZDbynDbCfD9Je0LXjdpM2bSDshhVlm
	BHVaN5qsenLHxd+AlsRpJGuNMZ27Bjgc9E9X0LAWSLcCFdFcZmtXJVMPCKicl6piEjlMH7JdHUg
	I3ut6hKx6A55YI4ZCypwWt8O0sat1x7Jv55sjXP7v8FOQVYViY1pSIkAgdHog8qZig
X-Google-Smtp-Source: AGHT+IGenhlXQojLO4A8snuodIELpz/s6UvZ4WXH6vmgEgP5RHjjATF0F/R2rvjoEPjbKZb2jgjwBg==
X-Received: by 2002:a05:600c:4691:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-477c110e521mr301001765e9.11.1764372490115;
        Fri, 28 Nov 2025 15:28:10 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-479052c9621sm103603185e9.5.2025.11.28.15.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:28:09 -0800 (PST)
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
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: Add success stats to rqspinlock stress test
Date: Fri, 28 Nov 2025 23:28:02 +0000
Message-ID: <20251128232802.1031906-7-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128232802.1031906-1-memxor@gmail.com>
References: <20251128232802.1031906-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5089; i=memxor@gmail.com; h=from:subject; bh=QMCJK4fPNJoANX0nTroINnUWsKFwJRZb4SH4XDpD2wg=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpKi/ynA+PQEKmEpNE/kRU8RI1Ir+4WTk+6VJdV aiA62itWAWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSov8gAKCRBM4MiGSL8R yj5mD/9zmBpsqJJzUZx0oF3/2WMI0POe2txBvvwJWXHeP9sskTwIJ27aqOTQgt4NFhJZfxwfOgK oJ8j6gZnXelR1coRk35JFW5yYUeFwag1RZ6tGkzaampUuDGWS0gXkb6az0+ikxISE0Iefna8YEi Fh6C6s4vUnWRD+5WN7ulbf/KrlcGuJEvSDPz4cLGoSnO4GOkFEQvsZJS9ZdiKHtcLsKPSgmw5Cc ON15MMv015nIhn7uCLYTdgIM4PR6TyIKIXKj80p8xfeBvSPW1P2t9MapR72dwnoTuntIHII4m+3 sQan/PJQUzZqwG2UyQ2Geotj9fNPNOxTR3jEhMArg6K/mA7AgObcWl9PaZ2L+9w1NDB7cSibGRE ZpdZKUS39jRIrW7++5l8uzpYmAPlC8SlGTRsJXSUfALuZWoR2jD1D03hJrZjj2fQvSrHNzomqd7 lLxKIjiU9okof0IdkXnLEHktZiGrYdMQVBl2cQhUhYrasY8kzPBWrP3ePHzp4+LqptaRdKwiWuN W3l7ng/Ep9nadXi4Q+oJWsnJA6wZqP5BJ++aqZEDA+Woi9VpYnib2RLY5eXci0jG9LQRmL4UYup rv/u329yJWEj0MiN9l3a3p5a3NpnrA98dWfppVfA3k44ows4IRbUPEmZYiknDFoAOrJ6lmdSDzz 7oWOr4xH6fRX/iw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add stats to observe the success and failure rate of lock acquisition
attempts in various contexts.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/test_kmods/bpf_test_rqspinlock.c      | 55 +++++++++++++++----
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
index e8dd3fbc6ea5..7b4ae5e81d32 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
@@ -33,9 +33,16 @@ static const unsigned int rqsl_hist_ms[] = {
 };
 #define RQSL_NR_HIST_BUCKETS ARRAY_SIZE(rqsl_hist_ms)
 
+enum rqsl_context {
+	RQSL_CTX_NORMAL = 0,
+	RQSL_CTX_NMI,
+	RQSL_CTX_MAX,
+};
+
 struct rqsl_cpu_hist {
-	atomic64_t normal[RQSL_NR_HIST_BUCKETS];
-	atomic64_t nmi[RQSL_NR_HIST_BUCKETS];
+	atomic64_t hist[RQSL_CTX_MAX][RQSL_NR_HIST_BUCKETS];
+	atomic64_t success[RQSL_CTX_MAX];
+	atomic64_t failure[RQSL_CTX_MAX];
 };
 
 static DEFINE_PER_CPU(struct rqsl_cpu_hist, rqsl_cpu_hists);
@@ -117,14 +124,18 @@ static u32 rqsl_hist_bucket_idx(u32 delta_ms)
 	return RQSL_NR_HIST_BUCKETS - 1;
 }
 
-static void rqsl_record_lock_time(u64 delta_ns, bool is_nmi)
+static void rqsl_record_lock_result(u64 delta_ns, enum rqsl_context ctx, int ret)
 {
 	struct rqsl_cpu_hist *hist = this_cpu_ptr(&rqsl_cpu_hists);
 	u32 delta_ms = DIV_ROUND_UP_ULL(delta_ns, NSEC_PER_MSEC);
 	u32 bucket = rqsl_hist_bucket_idx(delta_ms);
-	atomic64_t *buckets = is_nmi ? hist->nmi : hist->normal;
+	atomic64_t *buckets = hist->hist[ctx];
 
 	atomic64_inc(&buckets[bucket]);
+	if (!ret)
+		atomic64_inc(&hist->success[ctx]);
+	else
+		atomic64_inc(&hist->failure[ctx]);
 }
 
 static int rqspinlock_worker_fn(void *arg)
@@ -147,7 +158,8 @@ static int rqspinlock_worker_fn(void *arg)
 			}
 			start_ns = ktime_get_mono_fast_ns();
 			ret = raw_res_spin_lock_irqsave(worker_lock, flags);
-			rqsl_record_lock_time(ktime_get_mono_fast_ns() - start_ns, false);
+			rqsl_record_lock_result(ktime_get_mono_fast_ns() - start_ns,
+						RQSL_CTX_NORMAL, ret);
 			mdelay(normal_delay);
 			if (!ret)
 				raw_res_spin_unlock_irqrestore(worker_lock, flags);
@@ -190,7 +202,8 @@ static void nmi_cb(struct perf_event *event, struct perf_sample_data *data,
 	locks = rqsl_get_lock_pair(cpu);
 	start_ns = ktime_get_mono_fast_ns();
 	ret = raw_res_spin_lock_irqsave(locks.nmi_lock, flags);
-	rqsl_record_lock_time(ktime_get_mono_fast_ns() - start_ns, true);
+	rqsl_record_lock_result(ktime_get_mono_fast_ns() - start_ns,
+				RQSL_CTX_NMI, ret);
 
 	mdelay(nmi_delay);
 
@@ -300,12 +313,14 @@ static void rqsl_print_histograms(void)
 		u64 norm_counts[RQSL_NR_HIST_BUCKETS];
 		u64 nmi_counts[RQSL_NR_HIST_BUCKETS];
 		u64 total_counts[RQSL_NR_HIST_BUCKETS];
+		u64 norm_success, nmi_success, success_total;
+		u64 norm_failure, nmi_failure, failure_total;
 		u64 norm_total = 0, nmi_total = 0, total = 0;
 		bool has_slow = false;
 
 		for (i = 0; i < RQSL_NR_HIST_BUCKETS; i++) {
-			norm_counts[i] = atomic64_read(&hist->normal[i]);
-			nmi_counts[i] = atomic64_read(&hist->nmi[i]);
+			norm_counts[i] = atomic64_read(&hist->hist[RQSL_CTX_NORMAL][i]);
+			nmi_counts[i] = atomic64_read(&hist->hist[RQSL_CTX_NMI][i]);
 			total_counts[i] = norm_counts[i] + nmi_counts[i];
 			norm_total += norm_counts[i];
 			nmi_total += nmi_counts[i];
@@ -315,17 +330,33 @@ static void rqsl_print_histograms(void)
 				has_slow = true;
 		}
 
+		norm_success = atomic64_read(&hist->success[RQSL_CTX_NORMAL]);
+		nmi_success = atomic64_read(&hist->success[RQSL_CTX_NMI]);
+		norm_failure = atomic64_read(&hist->failure[RQSL_CTX_NORMAL]);
+		nmi_failure = atomic64_read(&hist->failure[RQSL_CTX_NMI]);
+		success_total = norm_success + nmi_success;
+		failure_total = norm_failure + nmi_failure;
+
 		if (!total)
 			continue;
 
 		if (!has_slow) {
-			pr_err(" cpu%d: total %llu (normal %llu, nmi %llu), all within 0-%ums\n",
-			       cpu, total, norm_total, nmi_total, RQSL_SLOW_THRESHOLD_MS);
+			pr_err(" cpu%d: total %llu (normal %llu, nmi %llu) | "
+			       "success %llu (normal %llu, nmi %llu) | "
+			       "failure %llu (normal %llu, nmi %llu), all within 0-%ums\n",
+			       cpu, total, norm_total, nmi_total,
+			       success_total, norm_success, nmi_success,
+			       failure_total, norm_failure, nmi_failure,
+			       RQSL_SLOW_THRESHOLD_MS);
 			continue;
 		}
 
-		pr_err(" cpu%d: total %llu (normal %llu, nmi %llu)\n",
-		       cpu, total, norm_total, nmi_total);
+		pr_err(" cpu%d: total %llu (normal %llu, nmi %llu) | "
+		       "success %llu (normal %llu, nmi %llu) | "
+		       "failure %llu (normal %llu, nmi %llu)\n",
+		       cpu, total, norm_total, nmi_total,
+		       success_total, norm_success, nmi_success,
+		       failure_total, norm_failure, nmi_failure);
 		for (i = 0; i < RQSL_NR_HIST_BUCKETS; i++) {
 			unsigned int start_ms;
 
-- 
2.51.0


