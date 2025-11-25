Return-Path: <bpf+bounces-75420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF1FC83101
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 03:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C9D3ADC04
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 02:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29071BBBE5;
	Tue, 25 Nov 2025 02:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxch/CbL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D6196C7C
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764036479; cv=none; b=sPJuQAfzrxM+TSVrQPWG98MwJOpRgXS3oR3dQI0YiQoCWU/nm2k/vLqkRVhK6aGtGNhAr1KsxOGtYz6+ed00GG9AuTDT93KwEri+xCeAI1NdFKsBdEMhDukZjK1g8YFnx2VI4DxFtsHQY423tDBMYxT/eLQBEeF3OyqOiaZhEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764036479; c=relaxed/simple;
	bh=NsK5OYo4Pc9RzcfdO20pE7v9HB3wsK3Oykc7ikH2fow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFj8kcSiav6e0NQelnJTlx5EFJQnxd/+gB3UcxU9NNlkKC8mX+Tw5BI7KTu5SLrroSsHvaZFiEXKBJ/MMI1UPA/QNPdw2Tdb+GCOdv5szugYPvOJazfb8nPn1ekCCyyp9T0EqsNs09eypFPCHETYKhSIXobcZDoMDxGNZ3iDsUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jxch/CbL; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-477770019e4so42636695e9.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 18:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764036475; x=1764641275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lQumUpubHxttyTiG0r+DjyoGzfSi+4OnNneE8OBl94=;
        b=Jxch/CbLiGdN+eguO5W1ItrfmApe9S8jUnJFi9VY1BS5+vGm2ZdI+rZHN8h+ASE7g4
         w76u7iGu7usVGB3B4mYFX3KaEq/S3O8OJ1rYP6coQBtkNJddWzqaIiBIEinVkMTUgea/
         lRQt7J/TycPogXtXnyoXXxjnV7h5yZnvHWQfwQ3PgYQVOvjqroVd2PQGnMZkqVN5Fve1
         oLAaS9XX4z0nrS/85ZLmI5Hk8luEen85IX4QhveRnDIS7OwpBbCdsORNCmArotn7DoUK
         FQGCedd7wLwHlB0++ymCKPSvtiZnj19voohyibxvzSSA7Z6yzeNnPPwkXrEe9oU3LGs2
         5vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764036475; x=1764641275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8lQumUpubHxttyTiG0r+DjyoGzfSi+4OnNneE8OBl94=;
        b=DRQHN/LoWAsFXKoOqDVocPGOgUTBdRhKTt+J2mrpyLlTy4Jlm32/38F1SfAh5gOc2L
         G+pS3rmbFt7VWwCpblKpZQISUF2dOb1enPK9nCjVz1Q7jGBS8cz4YNWAK9gz2j9XLDj4
         +voQ3V/0OPbMkQDSkgxqH8umP4X8SpPSRD57THMxbOxbstKQnLocbYKPINjRD9U+DbYo
         vhhWL3IQIhIS+aJ9dY4v2R5cbW8J1lDvQnuNWfvz0j6BXsZhgVkTOM6tW1p8Gt6ZGidk
         KbQlLUQbx3VTiEmtsYYoqvESzlwPh3DMimPUrQOgAzPG2bZ2mGI3DkjYSW0YVNO6q6TS
         V1vQ==
X-Gm-Message-State: AOJu0YxxOIcf0ahzFfjVK2UQK7AwEQJWosOg/2466vJGGsjQK3GeOTwO
	yWdE4JJSyGjPazX+Ad/VlMnG/MAdaT3PKTxCQXpPfYqNSU7XZ/P0z+uXNG/CSxl4
X-Gm-Gg: ASbGncspgygs11fVeW/L15YN9vm1cNUNwaVgeteKJxpiurcmKMXiKnFbaz1pFwLCvUO
	9gbhWLiNvLMG42w/m2TJ63ExMn3lZ/Uxcm1f3hJNeW8RRrr2P1F7cNdp/ySDG/nUSzQSuAG5HAO
	e5mQ6ddJI89+bi8JNxR48lkrGTp7RY5DrZTfE9d3aa+HnrmHZMjN3mz7X+cBbBBEbUOmioz3q1r
	03somQv7h2RTBeHmgb3Ln3MC/na7fpETrC0YsOF88r5LE5oAy9rSPBQX3htFfWK/Rzw9t1cOLhn
	ORnSWn2c55z+Rt74CUBHlI2GGjU5EU23XmhyekJfDpsVLGKDrLx2vNncfGdm5/dI4A1XigEkbIF
	IQoj00duuSEiZ8VMkxzv2P7U6m9+16js1O9t/nTv3cRcDQWMIswoFmVtDrH15t5xI3Lv9JT3D/N
	M4aATXASaJxanXl38siT7hF84VR7pU+kCCFdAkOW6VtFbBMW6h2JB4f0fFrAAF/vGfsnxrfFTAb
	Bg=
X-Google-Smtp-Source: AGHT+IEkrBF4eTB6I6iT3mbidwO3sYgPrbb+BP3L0NsUZ1u9YNof/6p1PFixCUKNBJmOWFdRJsidVg==
X-Received: by 2002:a05:600c:1d20:b0:477:7a53:f493 with SMTP id 5b1f17b1804b1-47904b242fbmr8775205e9.23.1764036475447;
        Mon, 24 Nov 2025 18:07:55 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477bf22dfcesm227293925e9.13.2025.11.24.18.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 18:07:55 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/3] selftests/bpf: Add lock wait time stats to rqspinlock stress test
Date: Tue, 25 Nov 2025 02:07:48 +0000
Message-ID: <20251125020749.2421610-3-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125020749.2421610-1-memxor@gmail.com>
References: <20251125020749.2421610-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6227; i=memxor@gmail.com; h=from:subject; bh=NsK5OYo4Pc9RzcfdO20pE7v9HB3wsK3Oykc7ikH2fow=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpJQzvsPW2/1D3TLq7EKfmPwx0VhXvqQBu6PZbE 4zCU33qtuCJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSUM7wAKCRBM4MiGSL8R yhkLD/4+nt8Lp5Mn4cJEIVL0PO/CfhFDRlY9XU1V2HAh3V1btVpNTZ7nUL+jAHqm/5vAf/B+clJ i6U2y0HJdyTc7nAckO/NkmdtXATWCfq6CYl89Hb6qIwr9+aNrW6I9MuTigl6yTDggthctq5l7Go glTwoWAWmclDzNRHi4HqP8djyzs6p4cuQGgHIh7CjfxXgM8jBEyYu5eNzr4VTC1jLTkBBAe3in1 QHDj78hhtUHdz+3Na5en2tEIhG+W43JC7y3BJ2KcwgrUIn2drwhDTo+JFI8pjZO9z6Md9T3geev xZcljpz5e/4XjiZl8RcnrhF5dNdAlokyn5Y3goNrv6aQ8Y0KrryvVYa5AkOPYXSQVyElUSEyvdq nNo4stPlLjzOq49VIeVfZNt9ecB4ONDZeWpL5WchXpbc0t7IcEQvcwMUJaJX1se4Tqr90jyyz6A 0vYvTEnCkFBok9iB+vjvLD7feOgUQdqSHWk/LlU0DalLbQz24bAOizfyQTHY850YiX2TAKAUTSH 2tDIatehOY8luuPKJ6A98DmktijacYgpOKd/qQgMkewxblk+5s03R5CZ9JvMKQOmOI4lvvZq4BS r17gl8KwwU1ub+pQwpEMZN0HG9TugVdr7jeGnj+agbc8g4/TrCSm6ogX1GUQQWuyvL2KAKtuLM5 XZwOlxkhA+DAasQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add statistics per-CPU broken down by context and various timing windows
for the time taken to acquire an rqspinlock. Cases where all
acquisitions fit into the 10ms window are skipped from printing,
otherwise the full breakdown is displayed when printing the summary.
This allows capturing precisely the number of times outlier attempts
happened for a given lock in a given context.

A critical detail is that time is captured regardless of success or
failure, which is important to capture events for failed but long
waiting timeout attempts.

Output:

[   64.279459] rqspinlock acquisition latency histogram (ms):
[   64.279472]  cpu1: total 528426 (normal 526559, nmi 1867)
[   64.279477]    0-1ms: total 524697 (normal 524697, nmi 0)
[   64.279480]    2-2ms: total 3652 (normal 1811, nmi 1841)
[   64.279482]    3-3ms: total 66 (normal 47, nmi 19)
[   64.279485]    4-4ms: total 2 (normal 1, nmi 1)
[   64.279487]    5-5ms: total 1 (normal 1, nmi 0)
[   64.279489]    6-6ms: total 1 (normal 0, nmi 1)
[   64.279490]    101-150ms: total 1 (normal 0, nmi 1)
[   64.279492]    >= 251ms: total 6 (normal 2, nmi 4)
...

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/test_kmods/bpf_test_rqspinlock.c      | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
index 8096624cf9c1..4ea7ec420e4e 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
@@ -5,6 +5,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/prandom.h>
+#include <linux/ktime.h>
 #include <asm/rqspinlock.h>
 #include <linux/perf_event.h>
 #include <linux/kthread.h>
@@ -24,6 +25,21 @@ static rqspinlock_t lock_a;
 static rqspinlock_t lock_b;
 static rqspinlock_t lock_c;
 
+#define RQSL_SLOW_THRESHOLD_MS 10
+static const unsigned int rqsl_hist_ms[] = {
+	1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
+	12, 14, 16, 18, 20, 25, 30, 40, 50, 75,
+	100, 150, 200, 250, 1000,
+};
+#define RQSL_NR_HIST_BUCKETS ARRAY_SIZE(rqsl_hist_ms)
+
+struct rqsl_cpu_hist {
+	atomic64_t normal[RQSL_NR_HIST_BUCKETS];
+	atomic64_t nmi[RQSL_NR_HIST_BUCKETS];
+};
+
+static DEFINE_PER_CPU(struct rqsl_cpu_hist, rqsl_cpu_hists);
+
 enum rqsl_mode {
 	RQSL_MODE_AA = 0,
 	RQSL_MODE_ABBA,
@@ -79,10 +95,33 @@ static struct rqsl_lock_pair rqsl_get_lock_pair(int cpu)
 	}
 }
 
+static u32 rqsl_hist_bucket_idx(u32 delta_ms)
+{
+	int i;
+
+	for (i = 0; i < RQSL_NR_HIST_BUCKETS; i++) {
+		if (delta_ms <= rqsl_hist_ms[i])
+			return i;
+	}
+
+	return RQSL_NR_HIST_BUCKETS - 1;
+}
+
+static void rqsl_record_lock_time(u64 delta_ns, bool is_nmi)
+{
+	struct rqsl_cpu_hist *hist = this_cpu_ptr(&rqsl_cpu_hists);
+	u32 delta_ms = DIV_ROUND_UP_ULL(delta_ns, NSEC_PER_MSEC);
+	u32 bucket = rqsl_hist_bucket_idx(delta_ms);
+	atomic64_t *buckets = is_nmi ? hist->nmi : hist->normal;
+
+	atomic64_inc(&buckets[bucket]);
+}
+
 static int rqspinlock_worker_fn(void *arg)
 {
 	int cpu = smp_processor_id();
 	unsigned long flags;
+	u64 start_ns;
 	int ret;
 
 	if (cpu) {
@@ -96,7 +135,9 @@ static int rqspinlock_worker_fn(void *arg)
 				msleep(1000);
 				continue;
 			}
+			start_ns = ktime_get_mono_fast_ns();
 			ret = raw_res_spin_lock_irqsave(worker_lock, flags);
+			rqsl_record_lock_time(ktime_get_mono_fast_ns() - start_ns, false);
 			mdelay(20);
 			if (!ret)
 				raw_res_spin_unlock_irqrestore(worker_lock, flags);
@@ -130,13 +171,16 @@ static void nmi_cb(struct perf_event *event, struct perf_sample_data *data,
 	struct rqsl_lock_pair locks;
 	int cpu = smp_processor_id();
 	unsigned long flags;
+	u64 start_ns;
 	int ret;
 
 	if (!cpu || READ_ONCE(pause))
 		return;
 
 	locks = rqsl_get_lock_pair(cpu);
+	start_ns = ktime_get_mono_fast_ns();
 	ret = raw_res_spin_lock_irqsave(locks.nmi_lock, flags);
+	rqsl_record_lock_time(ktime_get_mono_fast_ns() - start_ns, true);
 
 	mdelay(10);
 
@@ -235,10 +279,70 @@ static int bpf_test_rqspinlock_init(void)
 
 module_init(bpf_test_rqspinlock_init);
 
+static void rqsl_print_histograms(void)
+{
+	int cpu, i;
+
+	pr_err("rqspinlock acquisition latency histogram (ms):\n");
+
+	for_each_online_cpu(cpu) {
+		struct rqsl_cpu_hist *hist = per_cpu_ptr(&rqsl_cpu_hists, cpu);
+		u64 norm_counts[RQSL_NR_HIST_BUCKETS];
+		u64 nmi_counts[RQSL_NR_HIST_BUCKETS];
+		u64 total_counts[RQSL_NR_HIST_BUCKETS];
+		u64 norm_total = 0, nmi_total = 0, total = 0;
+		bool has_slow = false;
+
+		for (i = 0; i < RQSL_NR_HIST_BUCKETS; i++) {
+			norm_counts[i] = atomic64_read(&hist->normal[i]);
+			nmi_counts[i] = atomic64_read(&hist->nmi[i]);
+			total_counts[i] = norm_counts[i] + nmi_counts[i];
+			norm_total += norm_counts[i];
+			nmi_total += nmi_counts[i];
+			total += total_counts[i];
+			if (rqsl_hist_ms[i] > RQSL_SLOW_THRESHOLD_MS &&
+			    total_counts[i])
+				has_slow = true;
+		}
+
+		if (!total)
+			continue;
+
+		if (!has_slow) {
+			pr_err(" cpu%d: total %llu (normal %llu, nmi %llu), all within 0-%ums\n",
+			       cpu, total, norm_total, nmi_total, RQSL_SLOW_THRESHOLD_MS);
+			continue;
+		}
+
+		pr_err(" cpu%d: total %llu (normal %llu, nmi %llu)\n",
+		       cpu, total, norm_total, nmi_total);
+		for (i = 0; i < RQSL_NR_HIST_BUCKETS; i++) {
+			unsigned int start_ms;
+
+			if (!total_counts[i])
+				continue;
+
+			start_ms = i == 0 ? 0 : rqsl_hist_ms[i - 1] + 1;
+			if (i == RQSL_NR_HIST_BUCKETS - 1) {
+				pr_err("   >= %ums: total %llu (normal %llu, nmi %llu)\n",
+				       start_ms, total_counts[i],
+				       norm_counts[i], nmi_counts[i]);
+			} else {
+				pr_err("   %u-%ums: total %llu (normal %llu, nmi %llu)\n",
+				       start_ms, rqsl_hist_ms[i],
+				       total_counts[i],
+				       norm_counts[i], nmi_counts[i]);
+			}
+		}
+	}
+}
+
 static void bpf_test_rqspinlock_exit(void)
 {
+	WRITE_ONCE(pause, 1);
 	free_rqsl_threads();
 	free_rqsl_evts();
+	rqsl_print_histograms();
 }
 
 module_exit(bpf_test_rqspinlock_exit);
-- 
2.51.0


