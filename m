Return-Path: <bpf+bounces-54144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C8CA636E0
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 19:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B42316CB47
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5C21C8638;
	Sun, 16 Mar 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="ybz8OP7a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4C1494A8
	for <bpf@vger.kernel.org>; Sun, 16 Mar 2025 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742148072; cv=none; b=mSgDKk0VljKBtKWra5/znWYCCn8w/vdOU0rLt7/ntWdiJ6WNTVCSZthsjLKsIZsuKLlb/+FA32+9Rq3vVKsSgAgh3gU68aI6E+896uG/g1UbuSdx7oCMAXzCJbc5BR6PfMaDyaScm4SUTFU9EN5zkeS0BB/M+tHai0/KrFz0xM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742148072; c=relaxed/simple;
	bh=amYWoLNYuX+MsfbfeQspCZ/qADXf0GWTt5SNQtxVrJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTIERJZNyhi/TV+FOLObbWlKk+BOI3GOrQkZiByWdjyF4i5OElUCK/AfCVmcRGGnOmaVaL+VForGaCZzpEpfxL+CdTxX3TFWj0YhfREgKREBO25ixk7UAFD/60pSqM6VUW5wCNmBS+bwHAoPhjHLzvcsRACbv/RNXrlmy8kT/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=ybz8OP7a; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c55500d08cso323959785a.0
        for <bpf@vger.kernel.org>; Sun, 16 Mar 2025 11:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1742148068; x=1742752868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=44gA1Fsb8qr5aE07Ld6MoDHJfeGgY+/vsAgWSRinW+c=;
        b=ybz8OP7arjOYf2FgjSulSNGaTFPggJrRq11BKOH75uLlDy5tJHjbudaXnLM8S3+HAG
         ONWMgbO+0ey5hELc3XlR+/bwZg6UtG/Cg+N1yXN7ZAT5sUHr0xwLKwIGw1rZtyylrxgF
         skCWdmh9+elbmG5Peujv8yOxw8dJ8avAA/I5sc3PntNhQrmteB6YlddslxGoDf/SEdCg
         PSKHdRb+bzQp/gxxD887NRLV0X7vUfHhu7DSVVdof7dVz3MzeGGMPzv7qEXEI0xP3/Ap
         5h/g8PV0hMv8tihWdQJSMNhMX5kulpirH6a4YCNo7EGiHjIy/kS8F7mHZ7zqSo/Qy/+r
         cd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742148068; x=1742752868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44gA1Fsb8qr5aE07Ld6MoDHJfeGgY+/vsAgWSRinW+c=;
        b=Htj0ztM/M8TIvZWZFECU8y0PsG2sAV3UT49hdEJrPkuhBQTZLE9fZuMbM8gvXbuQRm
         QnFLxOSL3CPU9vrs7azs7zI2gWdAMV3960gLXEa62kq5emHTTMks44o42LIx0aGtOM84
         px9h3/ADWghuAsbWkBwe0+s5euMOjY8NobVg8J/D8cNnkUjTiaqRFXKyDN+hwP9xMvqm
         X/o4zoPEn0GmL5ExumIA2MlO7momh1oo0mvCyifNL6BdgKEpwoJFy00sIjhiC2RaXLkb
         3UfTq6+FOirZ2eJJVLDRqiglxIuOPnRbnKIm4eGPBaGXTh7ndePPUWD0EjfHIei/3gHN
         1m2Q==
X-Gm-Message-State: AOJu0Yx54dEVZ+FmFp3OBMQc2y+GOUCrsfVZocL6She8kxAKk2deU5m9
	+ntFWHXPt0T89JDu54yaEHEg0QqjvhGR39559VUOcfoYGTp/EIoZ74fbtLPTCgIm3LJb6esZ30e
	54Ds=
X-Gm-Gg: ASbGncuBbyA2mvMaUK3Cp1V3L1Jc+aEB/95G+P0xF04KbwATYnNRqF0GFOsHWuXr/sO
	westZQhD+/xZC8f6kUcZfXQfvFhP4IbXPdZUtyWA9xrDdB8fdaecT1V4HOgZrRcI0tjrWq9F0Hb
	DDVWCn9ckz12/N4HxzTa/wrIPpVMoYLckxunra++I/ZFJYZLSY7NwYWZp5CNni/474crBG0TFEx
	rpCqvasTMIK6vwpyId97Nz6VvWmzJjqu+L61cWFp9DFpHTb9z2I1AIh10TG2Wk9JgEZfTF+PYfs
	PwxFNn/rHBy6wzd7lRz8LPITBXBuW9Em5Nlw/zABMw/UcXC0qxg6
X-Google-Smtp-Source: AGHT+IHU4PcdBR6cRG4XCVoWw1z5Q5tBiwAhc6PMGhRO1Wwgh/XrGCXCl9xAyoRTVXTAVQI+Afj6xg==
X-Received: by 2002:a05:620a:46a0:b0:7c5:5d13:f188 with SMTP id af79cd13be357-7c57c80f088mr1212200285a.26.1742148067766;
        Sun, 16 Mar 2025 11:01:07 -0700 (PDT)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c7e26bsm494282385a.41.2025.03.16.11.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:01:07 -0700 (PDT)
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
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH] bpf: make perf_event_read_output accessible from BPF core when available
Date: Sun, 16 Mar 2025 14:01:03 -0400
Message-ID: <20250316180103.12386-1-emil@etsalapatis.com>
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


