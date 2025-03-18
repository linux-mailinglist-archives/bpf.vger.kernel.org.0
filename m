Return-Path: <bpf+bounces-54256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 819BBA666B5
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 04:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797E77A5000
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 03:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DEB192D68;
	Tue, 18 Mar 2025 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="oUIpNQFq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B9157487
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742267287; cv=none; b=nfgEWQ/ukl4sMrEo08M+W4/eDV5SX4jPr4HZdgpf44kc33R5NTjQarAtCtiJmGYDIMo/eOJkHq3DS+hmHUzNTzass4N7LJv6/Iu5uqGwQ/dx0/3bcvp9b6Bf3pCehZQk2/FfwSwIULo0JtcW5D2Gc9Wj/t4S6YahkBfMw5kZqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742267287; c=relaxed/simple;
	bh=NZjyXIhJOne8kO0CoVnIYfiDrmx7Cum0n5x9KYOa8/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCgCL9kM8oBLdRrlxXKk5OZqiq0/Gc0Jmh8JNY/lafgfV+36NMhZcMGzwJXpLXu0Mx74rzzVnNzy8CE8U5eH3pzsK2p6DVkxs3wo38qgzxnRqHKNvqRnt5Uah0b6RLOS80ooAPHA0/oqI9la81/wrGqsPAIChiudd1fJZpSf5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=oUIpNQFq; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so35930076d6.1
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 20:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1742267277; x=1742872077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xMQ/EAqrnjEoXW8vv/E/KWSWd2ZuawXqZWw59r5W3Y=;
        b=oUIpNQFqMJbKadctqqjjbFb8OH4RQMjTQ3nrwaDBXmgEFqO2UTlzSTDoBqcKIarbPD
         +tepk9BizVudyTW1MlKlgtq1T+fH8SzEEylMkh+yISpvuMQR2Ut1TR3jiuX7SJqcAj55
         qNmoMFLNB71EbJnHgPuHGdRdp3yiK3Tukrb+4/tcz8Kj8jpdumdxKL+/aoKg87aRXO2r
         nU9ynx08lIVBllNNQFNB5zA4sXAiDLKLBOjaBI66DLznDIpq1QM83tE8uJPFMbwmi4xo
         dOdHG42Gkd+u6UsBuyQTS3gAZK/GQXM6jKNwj+hXj1VNZ6HNdIWX0X8hAd97FB+7MY+7
         1x1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742267277; x=1742872077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xMQ/EAqrnjEoXW8vv/E/KWSWd2ZuawXqZWw59r5W3Y=;
        b=Q6AGMKLURMCxZnVX5b2lO2yM6Kf5gnVQgbfprykHgQTLAsA/9kevNRF8rAcKTrOrOz
         EnJGsysZnBNgmauD/rntoLTycxR6HEk+1UlhvvWIXfsOOHHPqPpaQcevzMTqzlwawMNV
         VUB6xm2LS0brnNkktV4oWtXjlEZ5lnEKpNZKQTdwAe5y41amC7lK6uZDzalBAC26BG4f
         0CWfqbewxPxPkPGnQApR+MbOzsqULKf3kmKOB4/tiKVcWNR3GTUtj/iIjiWSlZe7dF8+
         VFjfceS0vy6QkLfkheYRtIfcH06rtQZtvlE/BAzm3T3Gemh4x40qoDWMLOF1fjdeHPKT
         FDrw==
X-Gm-Message-State: AOJu0YxkHpIIN13swKCGbEvRQ4Gb4yKjti7GGmyDBUGacrH6a1hmZL8P
	6aKcOOHPqhByP/Avgx5yONlY4GJX63faVL1QzTKRepaz40auHlv04hAMCD4wXKvYJGFKtz7e4cM
	urr61Zg==
X-Gm-Gg: ASbGncsFYkkqJnYINRZCiuIUanVmQSbmPUAtXKw14Uyu+HHA0F68qFlF2TbUKHn+X8E
	c+Bx3wfzGwryZNXzT2Whk6kKIxlxjffc9T6EvD9TVHv2cP5+4+gAYct5eWHdT90NT7vt/T/uoOW
	ybOyAhfCuyqwjGmQv+DSrzaskvbRiPoIx1vxlL1/urxvoSh6eDHxrp6NR/VtqNB02SPRjuNw5jd
	uQTs9nvjrJHJXNt20Djqw2HhA3d2ISSwUga+dsGEPxQ6NpR3wxDP9DOifEZ7W7JBuYmF4AijG5E
	wxNZ/2D5lFDC1Wjgh0L3gAL/JfYL8NoWbsID+0O9amPBmxpjIvy7
X-Google-Smtp-Source: AGHT+IHjKgeYIvD5IfjVK5zeUivnnRKsR9jlxgcXl6Ot4ioSJnjZx3SzdHXznmZVvW5WnqmMMeHNAQ==
X-Received: by 2002:ad4:5ba4:0:b0:6e8:fcc9:a29c with SMTP id 6a1803df08f44-6eaeaa642b6mr209377526d6.19.1742267277188;
        Mon, 17 Mar 2025 20:07:57 -0700 (PDT)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb1f7039a3sm2656616d6.69.2025.03.17.20.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 20:07:56 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	jolsa@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2] bpf: make perf_event_read_output accessible from BPF core when available
Date: Mon, 17 Mar 2025 23:07:53 -0400
Message-ID: <20250318030753.10949-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf_event_read_event_output helper is currently only available to
tracing protrams, but is useful for other BPF programs like sched_ext
schedulers. When the helper is available, provide its bpf_func_proto
directly from the bpf core.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h      | 2 ++
 kernel/bpf/core.c        | 5 +++++
 kernel/bpf/helpers.c     | 2 ++
 kernel/trace/bpf_trace.c | 5 +++++
 4 files changed, 14 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0d7b70124d81..973a88d9b52b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2059,6 +2059,8 @@ int bpf_prog_calc_tag(struct bpf_prog *fp);
 const struct bpf_func_proto *bpf_get_trace_printk_proto(void);
 const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void);
 
+const struct bpf_func_proto *bpf_get_perf_event_read_value_proto(void);
+
 typedef unsigned long (*bpf_ctx_copy_t)(void *dst, const void *src,
 					unsigned long off, unsigned long len);
 typedef u32 (*bpf_convert_ctx_access_t)(enum bpf_access_type type,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 62cb9557ad3b..ba6b6118cf50 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2972,6 +2972,11 @@ const struct bpf_func_proto * __weak bpf_get_trace_vprintk_proto(void)
 	return NULL;
 }
 
+const struct bpf_func_proto * __weak bpf_get_perf_event_read_value_proto(void)
+{
+	return NULL;
+}
+
 u64 __weak
 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 		 void *ctx, u64 ctx_size, bpf_ctx_copy_t ctx_copy)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5449756ba102..ddaa41a70676 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2056,6 +2056,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_task_pt_regs_proto;
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
+	case BPF_FUNC_perf_event_read_value:
+		return bpf_get_perf_event_read_value_proto();
 	default:
 		return NULL;
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 13bef2462e94..6b07fa7081d9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -607,6 +607,11 @@ static const struct bpf_func_proto bpf_perf_event_read_value_proto = {
 	.arg4_type	= ARG_CONST_SIZE,
 };
 
+const struct bpf_func_proto *bpf_get_perf_event_read_value_proto(void)
+{
+	return &bpf_perf_event_read_value_proto;
+}
+
 static __always_inline u64
 __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
 			u64 flags, struct perf_raw_record *raw,
-- 
2.47.1


