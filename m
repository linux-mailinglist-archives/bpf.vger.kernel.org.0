Return-Path: <bpf+bounces-21953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083588542F5
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 07:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B0A1C20D52
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 06:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D712B168BC;
	Wed, 14 Feb 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ESIxsA0b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A725212B8A
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892651; cv=none; b=Idw3M3AIjoYpTkYHZ8SQBXshbuWRsH8+k2d3iNWk4zXQ2B2vOpq7WAgEJwEMHzRXMpoe5dfuI9pCqp9C8fElS/d1CD2hBLg6g2mwsah9zYraTm7WBiA4Fa2f9IiTbuwtBBMJp+ut9E0RLEPmT2K+K5nu+VxXV/rjEXmaTVP7nQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892651; c=relaxed/simple;
	bh=gi4txDdv0C9NQjjEzGpOMktXyzhWLm0PbyoiCg8lenM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Y3jPZeQz6jvbv8cT9LZdAZ4FYqb0Olxk9Lc10aYv4u7whuW782H0EbpHeJiVYnLDh3mYo6pA3NUoNTVxlazIYONbQljdMBKHvDzsmAuash1YQIZgqJ0HsXF5UMLzHEhyWs42ZGSifdHId01CwpzKPzu7mUU/vKBR1MBHei+wO4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ESIxsA0b; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60753c3fab9so6703557b3.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 22:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707892648; x=1708497448; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CANQqurHGmF5Ru8GYcuqg+/9JMey73Sl/dxU7/wCOGk=;
        b=ESIxsA0biR3o1+9gLHaK9lU9NuyJ3HJw8dfsMYdRxzdEbvKJSKymj7wfdcGS6+pCnt
         7uJr4q1gF9qcVGUd80IbaPzap8aTLBguMdLYiZMCgezMl9uN1P80Zzi2f90lhR6D3dJs
         v5Dwd3nT6LFpctpm2qV+bUkLMvp4gGjwsFraKvZ331HeaP2vCpzdEuqxIZ2a9iQfHs5z
         79JnYSpUGAeKYxGGclHdY5F58gJYvYUKA+fDDZkhPwYfnEQoiXBBTr+lyc50wVdkdPGd
         K5ObK6hZZ1dEVMMvgpzZFE330LSO+AO7ht0FWy25dbS5aoqm96sxb/7Ix54W6f1mu/AM
         iCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892648; x=1708497448;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CANQqurHGmF5Ru8GYcuqg+/9JMey73Sl/dxU7/wCOGk=;
        b=MNLvZpuGLVePZOanFANQb3Je1osZzGaUdtPxHDEJTfR5iVLZS/h+vryR8poTFZIbUG
         kh0dt8CiVX0dseB48v60GAdKSdhwfPvE0hZREAAtyIxLjdIbANLre3MBMFoDNcgr3HwX
         Sqy1z+cRXAtdFGDJ/tb1fcqRkJa30zFK+q2RtXwPjTD8WT5Q9xc/G5c6z1dnBqtMuRaZ
         em8dz0r33GhFK3A9UxjSzJw/FjnWFV3cLbAK4LB5x3A/7SrK3i6es1oYj+mlrsRisGN0
         OfyFI5N7wSaGgl7rHF9h13Zs9YgGcgT6nvn71LgXXJFQ6HMPYv4lA8+0FZzh6+8arNFW
         8/mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJhDwZDgGc2nTT6nOV48zh31LlzdcxhxUEqIgpoc5tzza21EsLMrcctqeCI6lsybj5KvPWcre0hjE2ihrZkN80qEVK
X-Gm-Message-State: AOJu0Yx0P3QeFlXkJu4ECG5UFqnZVOrYuHUYjNKqvVqWqb+yg3EShiqM
	2SRJRi2qf2O4Ot/MVhdHQxELQUTphqHu0i+YoRogwcK6LjHFq00npsnrl++hmRB/WB3dN4WVicb
	qMy2r8A==
X-Google-Smtp-Source: AGHT+IHGxTR+p0CnuoOK+VdU0lHFhbRYRprRzVqsZvfUFCN+ScY3VDeSQ24bNsXgrrxVtSJ52mhmdBCQBk5J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a81:4fc6:0:b0:604:125:f0cf with SMTP id
 d189-20020a814fc6000000b006040125f0cfmr232032ywb.2.1707892647799; Tue, 13 Feb
 2024 22:37:27 -0800 (PST)
Date: Tue, 13 Feb 2024 22:37:05 -0800
In-Reply-To: <20240214063708.972376-1-irogers@google.com>
Message-Id: <20240214063708.972376-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 3/6] perf machine: Move fprintf to for_each loop and a callback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid exposing the threads data structure by switching to the callback
machine__for_each_thread approach. machine__fprintf is only used in
tests and verbose >3 output so don't turn to list and sort. Add
machine__threads_nr to be refactored later.

Note, all existing *_fprintf routines ignore fprintf errors.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 43 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7872ce92c9fc..e072b2115b64 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1113,29 +1113,40 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
 	return printed;
 }
 
-size_t machine__fprintf(struct machine *machine, FILE *fp)
+struct machine_fprintf_cb_args {
+	FILE *fp;
+	size_t printed;
+};
+
+static int machine_fprintf_cb(struct thread *thread, void *data)
 {
-	struct rb_node *nd;
-	size_t ret;
-	int i;
+	struct machine_fprintf_cb_args *args = data;
 
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
+	/* TODO: handle fprintf errors. */
+	args->printed += thread__fprintf(thread, args->fp);
+	return 0;
+}
 
-		down_read(&threads->lock);
+static size_t machine__threads_nr(const struct machine *machine)
+{
+	size_t nr = 0;
 
-		ret = fprintf(fp, "Threads: %u\n", threads->nr);
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++)
+		nr += machine->threads[i].nr;
 
-		for (nd = rb_first_cached(&threads->entries); nd;
-		     nd = rb_next(nd)) {
-			struct thread *pos = rb_entry(nd, struct thread_rb_node, rb_node)->thread;
+	return nr;
+}
 
-			ret += thread__fprintf(pos, fp);
-		}
+size_t machine__fprintf(struct machine *machine, FILE *fp)
+{
+	struct machine_fprintf_cb_args args = {
+		.fp = fp,
+		.printed = 0,
+	};
+	size_t ret = fprintf(fp, "Threads: %zu\n", machine__threads_nr(machine));
 
-		up_read(&threads->lock);
-	}
-	return ret;
+	machine__for_each_thread(machine, machine_fprintf_cb, &args);
+	return ret + args.printed;
 }
 
 static struct dso *machine__get_kernel(struct machine *machine)
-- 
2.43.0.687.g38aa6559b0-goog


