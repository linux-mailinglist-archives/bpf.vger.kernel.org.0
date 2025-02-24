Return-Path: <bpf+bounces-52445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07CBA42FDB
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF48A17A015
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA701C84D3;
	Mon, 24 Feb 2025 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcBv+dpu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4261C5383
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435403; cv=none; b=gmFDefS4J9fL3Sl5iDTUnFodlntPIPDq2ALVn14b9jekA+T6KVskdxBmr1HZhieWhd1U8IiJsMGReyorkzEXnVSur3tX88Yw/gGrvam6as06LHHIn59VL4KscZyi0nC3lr1OnWsD5bdSDw/SBr3DMWykuRDAvEQTniP8nrUqzgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435403; c=relaxed/simple;
	bh=GnrO/gmwKRNyOXiaf80+Zbkig6kMujtKaAokDX7ylvs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XQTPjesXHgyxx5rz48VeFP8eBu/ZdVkLigQ3jvAsKL/DQpzEfmEoHQXZh0Kr9F1YiuCN+Edi3hGMCkRQ7xhcHkAYlrlctvtEjxmajaWcybFhgfYFtVFeETmiZJEdP9r3yfOirhrEedFguuYXMrvfiVbMI44RVJC37ps/bWzJLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcBv+dpu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-221050f3f00so111916795ad.2
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 14:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740435401; x=1741040201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmwutcFofBOXrbc27clOHkWALypONt4dDrNhqzmo9vE=;
        b=UcBv+dpumyO/rqNRey2unlVLzN5JDSzONhfedgttxVR/3uLPvjUWwFbxR+HCknuTnK
         q93yoA8yJU2zFMiLgtronMsfhfb5Pm7oVhfLGkldW4UFq1eeMO2gikm9lggzZSa2jW/G
         JyqDN0KdI1swwfIw9boHXu7dnEUTNjjN7oAXcjnu4MGpMk3vhFug2GvMSwiWtLHgQon4
         YPrW9Lr95SnEGFEGB1Wvq//Pym+cVC5VaTnLD7i29WHPCa7V2kw8zPEMhOdH7JVsTAWj
         3ouNpEdEikApEqdPppOKVNeU7LV+DC9b2BYAEqIJS/qcObJ7RzgDy5HZpJdltwIwSinc
         iXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740435401; x=1741040201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmwutcFofBOXrbc27clOHkWALypONt4dDrNhqzmo9vE=;
        b=Ft7mufj6YTJeA43DRT0IStsnDgFTdoXHcKJzfW2AoQgW73tipGkX0OK4190nICOqc3
         Tr1PstP8i5Ob2wkT3j9hHAIgkmq4QiEH6d5NPa32WcwVs0sMQV6H99yrwfeMoc+IwCUX
         OGYoCm+rcPgjBre5xjIzug559KND2s0O3n9Lwzf4ZyNUFHOsm1+9vpgxfoPjyN0fYj5C
         NMMIhrX+jhPUjdgWb7h6oMxQSrn8WQw5iY/84QwbLIDFWkzc+1c/7gW8OTN09yxAU03m
         mImAvtsG4aQJ9rnlOKlYen2AXTGbFCIAEOQc/uey7N+KsyZbQ9Lt6h3NauTHtLAMuzMF
         uYCA==
X-Gm-Message-State: AOJu0YzqnaSfyd4SWNVDmk3sQ0CRV32OvAb20Zf8lqmaLY3DRT17n8dD
	TsgkM6ZnSNWAxHsZ82BDDsC5GZLFV24U8xESVlda8HS2EptfpffOGLKIuw==
X-Gm-Gg: ASbGncvjU/oQ1ZUOWau4SEX6Qpo7YmITEF8LbSEtgYBIL8DPSyzTSV2OHdLUGIQOwjf
	tazotAO6z92N1Ttk7UZxrKRLCk3cAVATKPoY3ecf7AEodwe3oxp9CJ/FdxwjPs1MmMdxaZN8wDz
	1yz1/o9RgzjIZbbglHX2WtfJHlLJOJckcW6yKDzqCVGAwcNu8NAk2Qs8XRqkzrQB918p0B0TZRZ
	9vRBFESYw4/rHJdPtvVZyqaJS3JnCJ8wgvwEzafluSJeKL+UhviV3f7iNA+N4Z0sslqOt9Lms8J
	jEVITblaFXl3pb3yXphBGxJuZYf1OIo9sH1qvHu8dUioJCtkaVnUbg==
X-Google-Smtp-Source: AGHT+IHFOasEbWlrLIVv0/Vot12ldDlsPeYzZGKhfDeV+vl6i7AmK8hT8/R9+WFCysQnnR3sIWEdMA==
X-Received: by 2002:a05:6a21:6daa:b0:1ee:c8e7:203a with SMTP id adf61e73a8af0-1f0fc99ca0cmr1173549637.40.1740435400749;
        Mon, 24 Feb 2025 14:16:40 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:fd1b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81b9aesm141994b3a.124.2025.02.24.14.16.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Feb 2025 14:16:40 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Fix deadlock between rcu_tasks_trace and event_mutex.
Date: Mon, 24 Feb 2025 14:16:37 -0800
Message-Id: <20250224221637.4780-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Fix the following deadlock:
CPU A
_free_event()
  perf_kprobe_destroy()
    mutex_lock(&event_mutex)
      perf_trace_event_unreg()
        synchronize_rcu_tasks_trace()

There are several paths where _free_event() grabs event_mutex
and calls sync_rcu_tasks_trace. Above is one such case.

CPU B
bpf_prog_test_run_syscall()
  rcu_read_lock_trace()
    bpf_prog_run_pin_on_cpu()
      bpf_prog_load()
        bpf_tracing_func_proto()
          trace_set_clr_event()
            mutex_lock(&event_mutex)

Delegate trace_set_clr_event() to workqueue to avoid
such lock dependency.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/trace/bpf_trace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a612f6f182e5..13bef2462e94 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -392,7 +392,7 @@ static const struct bpf_func_proto bpf_trace_printk_proto = {
 	.arg2_type	= ARG_CONST_SIZE,
 };
 
-static void __set_printk_clr_event(void)
+static void __set_printk_clr_event(struct work_struct *work)
 {
 	/*
 	 * This program might be calling bpf_trace_printk,
@@ -405,10 +405,11 @@ static void __set_printk_clr_event(void)
 	if (trace_set_clr_event("bpf_trace", "bpf_trace_printk", 1))
 		pr_warn_ratelimited("could not enable bpf_trace_printk events");
 }
+static DECLARE_WORK(set_printk_work, __set_printk_clr_event);
 
 const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
 {
-	__set_printk_clr_event();
+	schedule_work(&set_printk_work);
 	return &bpf_trace_printk_proto;
 }
 
@@ -451,7 +452,7 @@ static const struct bpf_func_proto bpf_trace_vprintk_proto = {
 
 const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
 {
-	__set_printk_clr_event();
+	schedule_work(&set_printk_work);
 	return &bpf_trace_vprintk_proto;
 }
 
-- 
2.43.5


