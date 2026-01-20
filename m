Return-Path: <bpf+bounces-79653-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCC+KdTPb2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79653-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:56:20 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E91B49E08
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C7C06C7816
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 16:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F94322B90;
	Tue, 20 Jan 2026 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xdzi0Kpk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E96320A05
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924778; cv=none; b=s1MUansNW0HnGP3exVqBNgnVu2KUVNc6si3rqgzFlnZKetC48eicTmweAGlDY87beL6hEdS957YxKFpEJVcXyfKJxuEdTak3m9+C/JZ0ve3OCQLEJfi3LslgsXi0448SdPIrSkZgOZCdnYMmHDq6ZNEsQQ2HwmmoLuvnxzTeebU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924778; c=relaxed/simple;
	bh=GhLUF0L0IpH45tda1zr/y9KpIGofV4tcu+8hyTPCFfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AiLBrpcxC56SaaU8+D/WD5sLrP57GX/iJ1Llo9LOSv2EEiSdVYvUz3rV8x96u05i+/XBdR64nTWgmIO8UA9eNBFIU3n/rSQvTMUBqOhA4nLUW4f3LBZX4XwyNr5NMf0W5HKa04VtDG9MX9zccK8T5Yqc8i4VFFSUwTRdAtZ5K2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xdzi0Kpk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-432755545fcso3196022f8f.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924775; x=1769529575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xLMYYolyJjqq6i9TpWAlkvvOL0WcqfDjXNv5Xko3nI=;
        b=Xdzi0Kpk6EA00ZyYdnnJCHP0eJmswuz3QPGaZMowPo9YYvWDYE8ScjdkNTgNUlUkD9
         Q7fnyv9CSyEQ9kCp9J/LsQnOs24HD6v0OJIEHiF/QSYRx0O13buSQMhRYztCEQMOpMzB
         yZJZUwCKww1AecuGDFelg46qwDpNke9HoUTJox6p7kqJLDCPFdD9bQ8JO6TcAuYXc0Nr
         oy/CPSt/TKiZ1Zx64R3C9+YDp3XzEX8wRJYml4e/sIpeyEVbh5hpUqz27AEAp+g/G06p
         ORRaJMzMTl7Omums2r1j2OsgPqVD8KltN+WIOp11jl8SBvBlK2eY5z/Nzi1IgYATj+mh
         hj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924775; x=1769529575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0xLMYYolyJjqq6i9TpWAlkvvOL0WcqfDjXNv5Xko3nI=;
        b=XlwTeFQx3hNt4PmzlFT+jQ9ZSseXLRQTfTODvqhNlTbjCWtAHcqPUk525fc7TxUu3m
         o5c0s9xgyZ7wRsVUdST8hsOCkfuhorbuX1h3ffyodFxyW1Q+fyaaohamQ9470my0Zsj1
         RL9jgCGIRjR8HYEMluLuBw/+TuwzlEBGpW/EL0kO8+x63Z5ILaFUi0qkgEtvXsKSC7Zz
         FfBlP1BdUFeNg8FOtFE1TewHElHp5OrqpVE6NQNAjKrQ0DJ2i+b2JVS2+0hc3O1P/0aU
         XIwQ1+eB6eyXqg0FNIvluhV7HyEHWAuutit5FT1p+eILiVfKwVc1uaBI9rpdlUdeSI/R
         5NHw==
X-Gm-Message-State: AOJu0YyGCWGkWf+dY3kpIZmmitaG4JTxh18NloKt8okvrGJwChI2qZGb
	5fuFjyjsCX1G0A9T3pbYasbCWk+0cQA/zIynxQgGZETUISCQ2Fm4jiuY
X-Gm-Gg: AZuq6aKHfiAtLjv9v0xSlPonDHBfFmhlkyfkoVUUf6Ob9pMovq+x+Wm+n/umeHzkyzc
	0t4scISJIF29TD2xky/Mg9f0VE6bf06VZDa8kB1wi7EAF5DXZ8YDNWASW8A3VCcBO1TPdNDC5SI
	lziydH5f1riC54FMeGCfDOJqUoXn1h1DfE6VXNEWGnMQrxWteby24hqpjQn78Ztkj9c0dNI9NnB
	s39+WSDbM6V+oQnYceEXv77KcITa7XwSIExfaj7G5MKCdZXqlp44VSZBr4YxDELX1aJI2Vz1w2P
	WqYwz5nHzp4aSn+DBwtgu4EeCzK5jOR3Mm+mrM9cJutxsTHYBOZISBJlXjKNPY7k9a0bLqyjq7j
	mJZknsk8O8NhqfQl2M8PRPyz4+zAgYSpRVOORz/S5uBxRWUsmBstnKKQPh/fodXdTv531KgWDpI
	cyuLhvtjm7tBaCPQ==
X-Received: by 2002:a05:6000:230f:b0:430:f7dc:7e8e with SMTP id ffacd0b85a97d-43569bbec67mr18288331f8f.34.1768924774943;
        Tue, 20 Jan 2026 07:59:34 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dadbsm29992913f8f.21.2026.01.20.07.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:59:34 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 20 Jan 2026 15:59:18 +0000
Subject: [PATCH bpf-next v6 09/10] selftests/bpf: Add stress test for timer
 async cancel
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-timer_nolock-v6-9-670ffdd787b4@meta.com>
References: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
In-Reply-To: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768924765; l=3034;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=8om38gAdspUYGhhX2UZoUsJGe+8wJ7bi5do3dC7FV58=;
 b=aRH6f0bQrVvxT++YLCVuHUD46CQkAjxzHVpq7Q54XbyqA21tjvHmaDALdPqpN8ejTOPFIOUJi
 EBTDitzZ1jJBrodTgNviRv1m6l0YWtcQQ1P+AjBglCPfaMlQ+1ZrtiE
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79653-lists,bpf=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,iogearbox.net,meta.com,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mykytayatsenko5@gmail.com,bpf@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[bpf];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,meta.com:email,meta.com:mid]
X-Rspamd-Queue-Id: 4E91B49E08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mykyta Yatsenko <yatsenko@meta.com>

Extend BPF timer selftest to run stress test for async cancel.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/timer.c | 18 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/timer.c      | 14 +++++++++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 4d853d1bd2a71b3d0f1ba0daa7a699945b4457fe..a157a2a699e638c9f21712b1e7194fc4b6382e71 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -23,13 +23,14 @@ static void *spin_lock_thread(void *arg)
 }
 
 
-static int timer_stress(struct timer *timer_skel)
+static int timer_stress_runner(struct timer *timer_skel, bool async_cancel)
 {
 	int i, err = 1, prog_fd;
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	pthread_t thread_id[NUM_THR];
 	void *ret;
 
+	timer_skel->bss->async_cancel = async_cancel;
 	prog_fd = bpf_program__fd(timer_skel->progs.race);
 	for (i = 0; i < NUM_THR; i++) {
 		err = pthread_create(&thread_id[i], NULL,
@@ -46,6 +47,16 @@ static int timer_stress(struct timer *timer_skel)
 	return err;
 }
 
+static int timer_stress(struct timer *timer_skel)
+{
+	return timer_stress_runner(timer_skel, false);
+}
+
+static int timer_stress_async_cancel(struct timer *timer_skel)
+{
+	return timer_stress_runner(timer_skel, true);
+}
+
 static int timer(struct timer *timer_skel)
 {
 	int err, prog_fd;
@@ -118,6 +129,11 @@ void serial_test_timer_stress(void)
 	test_timer(timer_stress);
 }
 
+void serial_test_timer_stress_async_cancel(void)
+{
+	test_timer(timer_stress_async_cancel);
+}
+
 void test_timer_interrupt(void)
 {
 	struct timer_interrupt *skel = NULL;
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index 4c677c001258a4c05cd570ec52363d49d8eea169..a81413514e4b07ef745f27eade71454234e731e8 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -1,13 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-#include <linux/bpf.h>
-#include <time.h>
+
+#include <vmlinux.h>
 #include <stdbool.h>
 #include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+#define CLOCK_MONOTONIC 1
+#define CLOCK_BOOTTIME 7
+
 char _license[] SEC("license") = "GPL";
+
 struct hmap_elem {
 	int counter;
 	struct bpf_timer timer;
@@ -63,6 +67,7 @@ __u64 callback_check = 52;
 __u64 callback2_check = 52;
 __u64 pinned_callback_check;
 __s32 pinned_cpu;
+bool async_cancel = 0;
 
 #define ARRAY 1
 #define HTAB 2
@@ -419,7 +424,10 @@ int race(void *ctx)
 
 	bpf_timer_set_callback(timer, race_timer_callback);
 	bpf_timer_start(timer, 0, 0);
-	bpf_timer_cancel(timer);
+	if (async_cancel)
+		bpf_timer_cancel_async(timer);
+	else
+		bpf_timer_cancel(timer);
 
 	return 0;
 }

-- 
2.52.0


