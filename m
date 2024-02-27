Return-Path: <bpf+bounces-22812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C8A86A20C
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 23:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057B9285A43
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F03155A4D;
	Tue, 27 Feb 2024 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4dleXVlg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6829153BC7
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071331; cv=none; b=kGUDv95yHPEvGdfekEeB7ppBiZnW6XUjUojqONH19iQF6I48VJ5Pptjg7nE4f1EG/tUQ573EhTEqffAN2At6rhfFXCNXLnaLP/3c4GcEcyb3pVj8DLQplZy3c7XXw2NQuwjxdpnd02nM963LBI4U5tCdGjxpbJDn2mL0mJY1C/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071331; c=relaxed/simple;
	bh=/yGeJM1MC3xrnGlw+YrOzjUeVSCpkNh+lS2W25QBImY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QKdjn+ZmAMWmPgUKbKpExgHj4GL20lp54OI9+uFuPjhbwOZm56lLW3VTX2s89HrS/Bd9vUcORTzNhECFsCsN7X5IQib3bm679IdvnLfAzK4Fe0uWvcCcAs6MmjhqhjQptpE3JmEvwzFS7tgEbRTItm5pcDLE5RoYqDAEBHD9SyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4dleXVlg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608ac8c5781so83446837b3.3
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 14:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709071329; x=1709676129; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LLvFhK5uL/QCeGE47QDYifrDggRxdFdeVaa+ektv4Ks=;
        b=4dleXVlggqGls83VLDgVmaAYqUTq7J/uiSL0iJc+KNyKLNICbsipEW97LvJweK32Hv
         XCGViPHcDRN0RZ9MzTlYCKWgog99NebLaguxMTvpcQJxNJf/Nwo7FWdzlMiE0VSMyvut
         RcNvasddobo2cv9jO/pwsLSS5swYhqMc1N/EhvgjCp7YmAyg/nkN8JGo82rYbHN+EKGa
         H3sdYTUZPFJdYf0nJOi8GloAulR6WFLIo114Gm1Ovwt5e7K6/iXsHgXSbm+N2VpDXrkN
         Sa0jJEbxXjdsnmU0bpuECXAJkR0DYXJT+5lKwsBNkRRtJ+Qo5Aq7NXTALOoh0FZxcOHH
         2stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071329; x=1709676129;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLvFhK5uL/QCeGE47QDYifrDggRxdFdeVaa+ektv4Ks=;
        b=ngYogmhHY6t5BarQ6WYPzHv8wjt0frhjkS3NK8jabOVzdEnO0EGimCPJaUF/kXB4d8
         7zAEXmNnw1whh4HYb+G4m7tS3qt+S4hk62EmLyDD8XlO8QUEywzyu0kSaN4NnwG1HByF
         1VIUWx4cYIeR2CClwfHXgKIqYnv5TyCjQmgbnfdqYW9SYJQkC3zGuIPSOVyey204zxR+
         ijHyS0ut8naCrP/aS3+/vphm/IrzryMLHqPxuf9xKh4j2UELdPouwZLhGy0sJlOgq/zH
         VEmRkhEFVPjerGhPqTQ/pW2+OqwZT7qLxZjRBeRYfYc5S6Vc6IeziF24xIesVKNk0dwT
         7fsA==
X-Forwarded-Encrypted: i=1; AJvYcCVbsqVctnwCQ+3HLkkADJBl2cRLi6y0Kql5vpcEvVGUmoMfEGXgm26YuWaoUlFt0xwpIXLsckiEoyCXdxK382xwsUrL
X-Gm-Message-State: AOJu0YytVLW1wYFqQwmXoWCXDire5hzyaUNu3ZViVzweHTZ8Jt9GEd0W
	aVoiJ1jD5bgh4UVLpLxx3qw/RDimrZJgZSOsnnPdNmDz/gJiOUOqdO7MGJuAZhQOVWmo0FNDJIr
	eYSllaQ==
X-Google-Smtp-Source: AGHT+IGZSMnaIsAQtX/ldCpU/7po8oMpdQxnfEczmc5sne5RHle1yvyEtqmQ/soBLtduA34btzf9Vr/IMJAe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ff1:8af6:9e1a:6382])
 (user=irogers job=sendgmr) by 2002:a81:a08f:0:b0:608:e711:5a5a with SMTP id
 x137-20020a81a08f000000b00608e7115a5amr807524ywg.1.1709071328756; Tue, 27 Feb
 2024 14:02:08 -0800 (PST)
Date: Tue, 27 Feb 2024 14:01:47 -0800
In-Reply-To: <20240227220150.3876198-1-irogers@google.com>
Message-Id: <20240227220150.3876198-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227220150.3876198-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v2 3/6] perf machine: Move fprintf to for_each loop and a callback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
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
2.44.0.rc1.240.g4c46232300-goog


