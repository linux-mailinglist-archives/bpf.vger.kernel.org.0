Return-Path: <bpf+bounces-10662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0422A7ABC6A
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 01:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DC7DC282675
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 23:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5853948E98;
	Fri, 22 Sep 2023 23:44:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B3171D2;
	Fri, 22 Sep 2023 23:44:49 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345DE1A2;
	Fri, 22 Sep 2023 16:44:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c328b53aeaso27243215ad.2;
        Fri, 22 Sep 2023 16:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695426287; x=1696031087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MZpY1IZ4bUrCy8aga9AziYMkBusuoXKm+AQsy7SMzlw=;
        b=I7qHZ9FGWnL1tI9P5bkbztyAZgioK+j4J0gCHGbOsoaH+8+JD0ZE1fRwRbKZVoWHSx
         +jjoDB42lb/HZHYQk4WZu+FsCWpV9itrI/UeyMtpsQKCSCOQNHu/q/MG2haYr6lHqPib
         q57qW/x5l8vOw0InM0lD3JZeCm4lsRBD/uelVV/GqDDxdDO74z+18fsoLo16Xs57y5XM
         8efU7SDOjXI+nb9khHcC2JpaQLA1cDvcHl4kuXztrYXPTGll/ve5Qjd1WcJ8R/+x8N7U
         VKp1MPWqbyRMFnnEKyWs2AWBoRYe3HwbjXwD3yYyRI9BAGlXHEEU8R9BHcoxDo2/g0OR
         wdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695426287; x=1696031087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZpY1IZ4bUrCy8aga9AziYMkBusuoXKm+AQsy7SMzlw=;
        b=ETSpG2vvgIS12V7H20jnw7Z63xi/SYYP312uWc3EN0CHoK7DUD1lTJQGBCgntUbFQ3
         oHoYS4wFZaYChd0I8RMr0eEhxTxaHJER7HfNf3wMs5MU1l/NbGhMy5cPVqXuiKsskbqM
         dN6uphzzWw/i7A3NfkhIT91xwJWRkPqtimCZEmonvyzQMYnK8Wx+/urisQYMxCifACrw
         EY1Jx8A7AKYmItXs5tTV4Lwnmtl0xuQWaxVRUfEqI9Cyk/PuDKowg3iJbOx1EiwpNu3q
         vziyHrzzfTeVQyoigT9C/PLK505//4Sy7l7WGgsmbFAVxkhUEj30HVpOzP+aMwc+C/E4
         PJLQ==
X-Gm-Message-State: AOJu0Yx+qbIrJpTk5gJGlASL1Og7BXYf3m/ARdLLbBpg4ub4WLs4gstZ
	pKobyFGG9C+j76Ie9ne6LPY=
X-Google-Smtp-Source: AGHT+IHPZg/jEObdNDGRmdgw7+V6Y5CcHs7Cn0XPXcjakXuhni912sY281xDPaXUI/vI2QikxYCUEQ==
X-Received: by 2002:a17:902:ab01:b0:1b8:66f6:87a3 with SMTP id ik1-20020a170902ab0100b001b866f687a3mr802257plb.52.1695426287474;
        Fri, 22 Sep 2023 16:44:47 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:32b8:255a:115:8538])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d35300b001bf5e24b2a8sm4076519plk.174.2023.09.22.16.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 16:44:46 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	bpf@vger.kernel.org
Subject: [PATCH] perf record: Fix BTF type checks in the off-cpu profiling
Date: Fri, 22 Sep 2023 16:44:44 -0700
Message-ID: <20230922234444.3115821-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The BTF func proto for a tracepoint has one more argument than the
actual tracepoint function since it has a context argument at the
begining.  So it should compare to 5 when the tracepoint has 4
arguments.

  typedef void (*btf_trace_sched_switch)(void *, bool, struct task_struct *, struct task_struct *, unsigned int);

Also, recent change in the perf tool would use a hand-written minimal
vmlinux.h to generate BTF in the skeleton.  So it won't have the info
of the tracepoint.  Anyway it should use the kernel's vmlinux BTF to
check the type in the kernel.

Fixes: b36888f71c85 ("perf record: Handle argument change in sched_switch")
Cc: Song Liu <song@kernel.org>
Cc: Hao Luo <haoluo@google.com>
CC: bpf@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_off_cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 01f70b8e705a..21f4d9ba023d 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -98,7 +98,7 @@ static void off_cpu_finish(void *arg __maybe_unused)
 /* v5.18 kernel added prev_state arg, so it needs to check the signature */
 static void check_sched_switch_args(void)
 {
-	const struct btf *btf = bpf_object__btf(skel->obj);
+	const struct btf *btf = btf__load_vmlinux_btf();
 	const struct btf_type *t1, *t2, *t3;
 	u32 type_id;
 
@@ -116,7 +116,8 @@ static void check_sched_switch_args(void)
 		return;
 
 	t3 = btf__type_by_id(btf, t2->type);
-	if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) == 4) {
+	/* btf_trace func proto has one more argument for the context */
+	if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) == 5) {
 		/* new format: pass prev_state as 4th arg */
 		skel->rodata->has_prev_state = true;
 	}
-- 
2.42.0.515.g380fc7ccd1-goog


