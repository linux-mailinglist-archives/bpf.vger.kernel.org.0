Return-Path: <bpf+bounces-69882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFEDBA59CC
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 08:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FB53AC9FF
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 06:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BFA25DD0C;
	Sat, 27 Sep 2025 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKvZJDAJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87276258EE0
	for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953541; cv=none; b=b2JXYAjLds0z+6dYArKHWGcxIc33CmZheXzwMpNygGcbUCPeAWAxPiHjxjrZzr9B17zOegFalbWAKJ9JIxu7RnmZet+m7s9La0J8K+juWt8xi79CFZjMhI1YtWmDdAZ4A/r4tFWJMzOSbxq2csicsvXB2x4gXGN3SDDyBz9LogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953541; c=relaxed/simple;
	bh=qEjaAg7MkkdMQDjFjmkDjq7XcLyrEouJluZddB+eNqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPb+DnkCPT0GaTTgCbTt83Jlh9RrCgJvO0i1O2LV0jKY67LmxnPDg1Oqz92RUkdo4lQaCHm/RDsMmf9GMrPb8aqLucrz8BnqicnOOPOK2RnQugnNUmfduE8R6yb9fAVbEyemgtnCkazikFbx0OEbH5nWhHrXDpkRJtsEE/Lx/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKvZJDAJ; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so2728346b3a.1
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 23:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758953540; x=1759558340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABDRs5ioZceZJLzcJ8Ewc6tgp2gu+8s+nwYVCmKuGc0=;
        b=nKvZJDAJEfBZ9qKqELDwnXmDXKR8LYAm80xUkxI7LNrZhVvYcu1hjZ9DAGw0XrAuJ9
         ob11EjBKsGd3BSuBvpHhZX+fC+o/IRfUMxdz35E7CqASigxeDHC6UdNlqcB2SkAUSW0g
         TwN41+4+9UfLhOe2/0e+j+DEBbY50h/qVxYWDe20ISQkeQQg4KVQC7NQIPB5mykG95P0
         JWx/wLLgQgswJmqcJS8LU5MhrH6Wdip+HlfFWDjjqNmyWx6jbGDgunIZli6ff4bxHs6R
         jZJYdx/QLkjVAEyU0re1747R8m1Uf6eZI2GV1fbSZOifhkqHKkYMRL6ctmGjh3Y97DiC
         cv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953540; x=1759558340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABDRs5ioZceZJLzcJ8Ewc6tgp2gu+8s+nwYVCmKuGc0=;
        b=jQbqGiQoXlPjzU0fzbOx+GO7aO6di4zeHI880TLmWK7kaZF10r85ybrutdVN//qf76
         KB3zPiJ2S4iZiyFiFSgWBbQqwjQ72ghSapEii8R4YjVv0qiNW7mo4n7KxuWzub3yeHs1
         BiSwYmi7DYSY6lM2Aw8yjM9KBbWvw8Ha8z9Z+ILtQ4DoFCZDMFeNypi5uE3pKQbEpBa7
         kEVG+arSKYAmg617lGMBF5vQ4KUhLwB+gjoJPKeA+hi5Y8Cp2ZSk0EaUEiDQLNhgHeWP
         xf1GgWQAOsOkw8852gf88y8IXIQmStS6OptnF3Inzr4IbvWUhli7WlYDOyToeyd4o/Y2
         rZ9A==
X-Gm-Message-State: AOJu0YwYGms04y/USVNvjSXlPRSlwM2XS41MWjzyo8lPmpJCuHG5D4Je
	nScBDAkn21ln56UGSWqHzLqRkt6tGcW9sjyeI64AqrfhdAhMsncWR945fTgeymCLwgU=
X-Gm-Gg: ASbGncvGR1TDTuqc9HaqMlHmelzY9z4JyWWPX/JECiG/hZwbYFk/61mmLBke8sXQ0IJ
	i2YEzVIpFBAclM6hwCWoT4c+/jGgGG7i7BJWUIvMyHpqbtbWI8lbzbL5We9t1wqUFeEtRFCj5Al
	QvWwd39UJS9GXrcdalzz9k+CjMpmifgzBhDE54hFMGt28/v0wjKqKVzNuy+To8q8tVN4A5P2I4F
	+TF3NKlNQ5aAf6O9XkUuhzc8jS6GaMNumsqOaZOKGTn8BvsOpCWqLqVZso8eCsBlOL6n8i93KJ3
	42uDRvSKFIuyUTXEnbrC2L2u7cibIUQp6l/bnwJ4/GBZ8ugouYYnQbSsySjC1HJBFcZlq3THtNr
	2fJI8SGnrOci58JtlVLkvfChCe0BQYw==
X-Google-Smtp-Source: AGHT+IHPDRdOF1EEadfXGYb4KmdSc5RgqVg4fiVWRnpz61eUUanWy9Ud2BWVtzZyZWqIWeSNkD/t/Q==
X-Received: by 2002:a05:6a00:855:b0:77e:eb28:c59d with SMTP id d2e1a72fcca58-78100f77c50mr8198937b3a.5.1758953539680;
        Fri, 26 Sep 2025 23:12:19 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023edda8sm5891178b3a.43.2025.09.26.23.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 23:12:19 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH RFC bpf-next 1/3] bpf: report probe fault to BPF stderr
Date: Sat, 27 Sep 2025 14:12:08 +0800
Message-ID: <20250927061210.194502-2-menglong.dong@linux.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250927061210.194502-1-menglong.dong@linux.dev>
References: <20250927061210.194502-1-menglong.dong@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function bpf_prog_report_probe_violation(), which is used
to report the memory probe fault to the user by the BPF stderr.

Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
---
 include/linux/bpf.h      |  1 +
 kernel/trace/bpf_trace.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6338e54a9b1f..a31c5ce56c32 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2902,6 +2902,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
 void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
+void bpf_prog_report_probe_violation(bool write, unsigned long fault_ip);
 
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8f23f5273bab..9bd03a9f53db 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2055,6 +2055,24 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 	module_put(mod);
 }
 
+void bpf_prog_report_probe_violation(bool write, unsigned long fault_ip)
+{
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+
+	rcu_read_lock();
+	prog = bpf_prog_ksym_find(fault_ip);
+	rcu_read_unlock();
+	if (!prog)
+		return;
+
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_printk(ss, "ERROR: Probe %s access faule, insn=0x%lx\n",
+				  write ? "WRITE" : "READ", fault_ip);
+		bpf_stream_dump_stack(ss);
+	}));
+}
+
 static __always_inline
 void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 {
-- 
2.51.0


