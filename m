Return-Path: <bpf+bounces-75743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CDEC9348D
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17C414E1FDE
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110AB2F12C1;
	Fri, 28 Nov 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pkw/L1Wd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920E2F0665
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764371755; cv=none; b=OzkCmxJxipqq/6g/i9ICPegVMDxxoBZxaMGBwc0Azr8Ne/aLwdCKA4uITfkDk3ZS9YyLZ3Rx4B1yDt786KUBNFvPxSpbkwA5Sjqqy7XFzlDVWNPejuEbbReJCZYMSKyHRsJJchfBqD0SzJvjtpGaLbKbwMrennanzEi4jYwRrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764371755; c=relaxed/simple;
	bh=QMCJK4fPNJoANX0nTroINnUWsKFwJRZb4SH4XDpD2wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDlhIIl3jLUIb+GiXg1AeELKdEs6QT2+vVLoSqwqXLj5NENnOr2O3we3ggA0vI+pK4vv6UU6jrqUR+sesHnxPxshK/PaFZABuqgY4rLeTG3q2ChQKu8hVurK2obz5TyBTKaaPT7rnuvbnXaYCOLFD5e46/sh87qLXXCQCWum0uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pkw/L1Wd; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4779d47be12so18422085e9.2
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764371752; x=1764976552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxqLZL28Ppaox8tsOa1qySRq1fbpY+EejLK2u0zwo04=;
        b=Pkw/L1Wd9HGxKyM+0XZa3QPNIpgl49ChzG39Vk88SGZBvpbPvshEtMsBpk8OROIADP
         7djZI8ZK/nEIj6p7XF33SSBBTtpmuqWpHgd09AcIO3Y/yncjisegvdD+qQyS83TcMJco
         gdfNYbKHxeYy7t1j16Ih8KqlEdunQqt3AeTBAerEu/E7g2HDN63U8qzHHffy7lshcV5e
         WRqsOu2jWsYsgzkR2S1/B49kKn2LBs/qsJ+XxkhcgmP1WroOMIenwb5Hb7tzyQeOx7XF
         8wpqAR7t/D/Ig1/jAzc339fabhqrk5BbJMKxTrwzxASsvgPjEujTRDN0r/NcbYKlFuAs
         ZZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764371752; x=1764976552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wxqLZL28Ppaox8tsOa1qySRq1fbpY+EejLK2u0zwo04=;
        b=H/ke0Mu3PGWNDZ735M7VcUUyal5G0EZtBlhteau7Bh4d+jimPPz83c8KImeAFaeQb7
         HjRYuWqCxhxg4TueM/7BzzCPbayyeJLyUppYmTmjArIQDIn2A8pPRx8nH2lb+UpaXO0H
         xmx9vrU22BmlE7yw8iX8sbBq0mACOqnb5qq/7EAJ5iEW2ksiIuDH2zY9TFz2E5U9KhmP
         R97AGGcZ/wmFp8v2G4bYmeLZeVKkyovwFX0vDiKaBirDhfUSbElxF7TC+Y9nS9388kQQ
         qmvZ8VBTxANt6SwFcLIzzXnpYNKUbOfdoSRktJw3xcQNhAxNVrhjFKkGXGa76UgfZxpW
         TFLQ==
X-Gm-Message-State: AOJu0Yw0YJ20cwI1zU9H15/9VDsNkq4HZqKssY/wNhHbvrKLvbBmXW5k
	bNkMArWjhlQuP+/uUhTUFAlMfdwJB7nqZdfVZmz7adXJI7aJO4bpVWe2ZmLU86q+
X-Gm-Gg: ASbGncs5YOCmL0xopOpiRJjlBvwTrC4E/41fFowarSEsgjdTIvmcpemXSA8bsOMobMh
	Y4lJX2Kjr9QaJSzkbQ8xHlOHy8Di7zpeaiFp/vQsyp8soFwWPhJkbNSbx5HVcX7yn07eee6dDdx
	2GTBq5n6et0zs0zT2uag+PRqF90U71xoIVF54ERFsfFZ/CsFujwgPP3TDCFr3PC2seEsEOys0J0
	LiPiBPuIICMwwNRc0x9Yc7UzP6O1z+NLKfSKnJsfM7Zi0IGfwwxqyDH7pBphPKwHzrfxxpR5KIj
	9HsK4lDURCS/86nTqFONwcaAFujK+3pyaQVL5MqHKmjPUqgqd76tvPILblL6g/MSjmB+efyT5n+
	KJTUNtVgnkXml+K6I7vCU/LSL2IKi2YrZB7aHDVWkQsvkaeEeZpwpl2d+nKT0bR9t2iRJAjs0+D
	ZH2wEcJ6TN48SVUeQMGZuYujVoIOo7lWPKSDtTLBi39CpN5q2CNxzZFZQMWKHHpvfO
X-Google-Smtp-Source: AGHT+IHp+JFXKTGpy2qERjAo9omEPjce+OZp89fYm16TQ84zwM3Rg47Yf2FmfE7M0laEtZ/0A6OzAw==
X-Received: by 2002:a05:600c:45c9:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-477c0212123mr315279355e9.35.1764371751837;
        Fri, 28 Nov 2025 15:15:51 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4790ab8bb21sm177186545e9.0.2025.11.28.15.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:15:51 -0800 (PST)
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
Subject: [PATCH bpf-next v1 6/6] selftests/bpf: Add success stats to rqspinlock stress test
Date: Fri, 28 Nov 2025 23:15:43 +0000
Message-ID: <20251128231543.890923-7-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128231543.890923-1-memxor@gmail.com>
References: <20251128231543.890923-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5089; i=memxor@gmail.com; h=from:subject; bh=QMCJK4fPNJoANX0nTroINnUWsKFwJRZb4SH4XDpD2wg=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpKiyRnA+PQEKmEpNE/kRU8RI1Ir+4WTk+6VJdV aiA62itWAWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSoskQAKCRBM4MiGSL8R yr9CD/0Q3X0/J8Pvp9q3VR7jlYJC6lGI27HS62mh33atP9lyDpkvWRus/ONr7WcSaU8jWb4/Jgu Zd5ivzdwb6MkbYThDcg+vtyeNacjeMWlPvNeH9iJnhDc1wRytNc3x1Dm8zwuUHO75hvvpaDdD4T 3RrTnLll6drXpMzLDMwhgPT9u0l8T5DFbXAjLQGxRpIOPSzQ7s13tKIV2nH6Xxl7uSeEF8KNiAs tCdfT327bIIXjA9nrQDPnmRT9/r5VjlZ8zSDpeRQuMNVASwKsZdV6+0HxZRNELvqFeSzfFgu60C nsdvWvNY4wsuL8vXWJZ9vBhchnM64lz0hPg9OhApaxfYw9yYrR8z1lIGB8D1XTDNMGW+fPinEo+ 1xaspx6R6z/ZqkpTdL4rUOp3O7uWXTA4qonbHDfajGGhIBBoxRkqekUW52dkAB/0TzyrseCeimB CywV2TNVzDgVSjYX7KkjO46oWVjhHAOqHH8kH0H81zCC2ZEfh/1iRqFKxKADy/Aws7pOTuUjlva OEruS6vUAVM6TOS0T9G1Te6L5HE3ccS5CgZ0SS7urA2bwFWEeCsFEKkZuTU9Tci8nfgTeDN78K/ 0BP2UpZdW29v/iiC4EnjNf4rBj/Ei/rnmlM5Q3f6Y4cBYkFf2shE6F8Wt8nRVHBv5LV+Htmr+J7 0EgH/WIMtoXpEmw==
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


