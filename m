Return-Path: <bpf+bounces-60521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181B9AD7B6C
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155D63A3D99
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 19:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03F52D8796;
	Thu, 12 Jun 2025 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mzv98nda"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDDB2D876E
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757792; cv=none; b=N3P6UHC9BT697BNRI2amoKzgK6xR11PNHSMhRXt12hvY95vrQZYnkBx6pkpmFCK8gvWtN9FNODnwC7U5RB8z2UYrRFSI7Ux3L5n7D2ugMhKvNJsVHuB4aZhP2BTIT6SfqCpCAKn0CEZUiT7wYjY1u7GAa3RKE+VVQWJzrzcbn68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757792; c=relaxed/simple;
	bh=Zpl+gL2iTdwOtoVI5LL2teb9gquZyRVctFv0bvAwr08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MWOOMMSEjYqs+MiO8Yl6dj8yK0c4zbL94FOyJaUoaN9008MCJfz5sLdwhV/B/kvckC2ff3RQ6n+MvPSr0l9oXIBcx74Cccv4u9mg4V5d7w5qBh5eAQeIz3mipFtOEohZb+1/72xRZnU80sqEYEzsgaXIsNqxjX71Cu+MxiS/ISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mzv98nda; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2362e130be8so11813525ad.0
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749757789; x=1750362589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CMS8RaOBfbTI0bE4f4YZc13pYHrZ07AfQzpRmzcnsGg=;
        b=Mzv98nda/DQZhtE2tTTwiRWOoxE/JMPye1u/9w2xVMerL3k7U31gRQ7WPI5jN62jSm
         WH5gkM3l9lVy1B+8vCeGDnYxGs41CIaq4n6FmSewfnbkgyhnBvmcqIJ1F+v8CWltRWUL
         sKYSaA2ftdTdEXtjrrEOrGuR8ZvhbR6vK3ujhGy6zzb0lipZgxyk+uLDRorDDhRaDRm1
         l4YJLR/Dnur4SxWXAMkGeQH9aoKznojoPerzRoZokORTkp7X/fMJWrF49F6ZNfb1JrzO
         Il+41Gx394+mIq2Qs9PbnK/4fz7TDpLfprA4FiH7ADLXa9eShHXrzYmUWN9uF9B/0VGe
         +CbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749757789; x=1750362589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMS8RaOBfbTI0bE4f4YZc13pYHrZ07AfQzpRmzcnsGg=;
        b=PJNci5tBqQopy0mcQRE3q7+1Awal1hLMWEFDqCup6J3uCEXrnRv/882sl8jCt+9tjD
         PcvhcpIbGBufa7GgPKjAezhl4X1gPzm4e/PWok7qMtj5MKhIYCtWGvKFJWng9I9QQszg
         fXhoj9NUkPPE9KUV+8S0LcCS5EdV9sCUslWK5Yxg1zvkclQJ3GrWemR2wEksWQE5vUHT
         WTxGbLCIlNp+hyNr2GVQaISw8b8K9tyF6zDuIubXITrclfc+vQY9O2O80mxPt3E5W1Ip
         xMRIOGT6XW3w01DEzSbTAA3ETalHaaajwAGmztX1d/T2pXTsRC+agncTyqzksK5Ac5+M
         Y6EA==
X-Forwarded-Encrypted: i=1; AJvYcCVtkSxrjrW9F02M0XrCY0eGm26G4HJ7csXG1/C1RTkq06MEDyyRLzMv2f7himTjRRXaN0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCeLei+YOt3keYUv6AwYBqk32ma/EFbtC0IxwvF/IwKTVirwJ5
	9bvtpiDQzQvGQA2PFYS0WBU2an85lqkWYruX64kPuJwKU4yEkRAe/uzoBLbG8P3eNYJw3AWNE8x
	ltN15lnTtOESISomolXNE7Q==
X-Google-Smtp-Source: AGHT+IGijBJNdMzlmqcrnuW61J+eMb7bY/1t6JzudPAqfBJ4Jq8Dm1Qx+hCW1yYkPQ17bT9aX+jWCEUm1c6CuFer
X-Received: from plbmm15.prod.google.com ([2002:a17:903:a0f:b0:234:9673:1d13])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f689:b0:235:ea0d:ae21 with SMTP id d9443c01a7336-2365dc09ad7mr4825965ad.35.1749757789645;
 Thu, 12 Jun 2025 12:49:49 -0700 (PDT)
Date: Thu, 12 Jun 2025 12:49:38 -0700
In-Reply-To: <20250612194939.162730-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612194939.162730-1-blakejones@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612194939.162730-5-blakejones@google.com>
Subject: [PATCH v4 4/5] perf: display the new PERF_RECORD_BPF_METADATA event
From: Blake Jones <blakejones@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

Here's some example "perf script -D" output for the new event type. The
": unhandled!" message is from tool.c, analogous to other behavior there.
I've elided some rows with all NUL characters for brevity, and I wrapped
one of the >75-column lines to fit in the commit guidelines.

0x50fc8@perf.data [0x260]: event: 84
.
. ... raw event: size 608 bytes
.  0000:  54 00 00 00 00 00 60 02 62 70 66 5f 70 72 6f 67  T.....`.bpf_prog
.  0010:  5f 31 65 30 61 32 65 33 36 36 65 35 36 66 31 61  _1e0a2e366e56f1a
.  0020:  32 5f 70 65 72 66 5f 73 61 6d 70 6c 65 5f 66 69  2_perf_sample_fi
.  0030:  6c 74 65 72 00 00 00 00 00 00 00 00 00 00 00 00  lter............
.  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[...]
.  0110:  74 65 73 74 5f 76 61 6c 75 65 00 00 00 00 00 00  test_value......
.  0120:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[...]
.  0150:  34 32 00 00 00 00 00 00 00 00 00 00 00 00 00 00  42..............
.  0160:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[...]

0 0x50fc8 [0x260]: PERF_RECORD_BPF_METADATA \
      prog bpf_prog_1e0a2e366e56f1a2_perf_sample_filter
  entry 0:           test_value = 42
: unhandled!

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/perf/builtin-inject.c |  1 +
 tools/perf/builtin-script.c | 15 +++++++++++++--
 tools/perf/util/event.c     | 21 +++++++++++++++++++++
 tools/perf/util/event.h     |  1 +
 tools/perf/util/session.c   |  4 ++++
 tools/perf/util/tool.c      | 14 ++++++++++++++
 tools/perf/util/tool.h      |  3 ++-
 7 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 11e49cafa3af..b15eac0716f7 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2530,6 +2530,7 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.finished_init	= perf_event__repipe_op2_synth;
 	inject.tool.compressed		= perf_event__repipe_op4_synth;
 	inject.tool.auxtrace		= perf_event__repipe_auxtrace;
+	inject.tool.bpf_metadata	= perf_event__repipe_op2_synth;
 	inject.tool.dont_split_sample_group = true;
 	inject.session = __perf_session__new(&data, &inject.tool,
 					     /*trace_event_repipe=*/inject.output.is_pipe);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6c3bf74dd78c..4001e621b6cb 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -38,6 +38,7 @@
 #include "print_insn.h"
 #include "archinsn.h"
 #include <linux/bitmap.h>
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
@@ -50,6 +51,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <signal.h>
+#include <stdio.h>
 #include <sys/param.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -2755,6 +2757,14 @@ process_bpf_events(const struct perf_tool *tool __maybe_unused,
 			   sample->tid);
 }
 
+static int
+process_bpf_metadata_event(struct perf_session *session __maybe_unused,
+			   union perf_event *event)
+{
+	perf_event__fprintf(event, NULL, stdout);
+	return 0;
+}
+
 static int process_text_poke_events(const struct perf_tool *tool,
 				    union perf_event *event,
 				    struct perf_sample *sample,
@@ -2877,8 +2887,9 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.finished_round = process_finished_round_event;
 	}
 	if (script->show_bpf_events) {
-		script->tool.ksymbol = process_bpf_events;
-		script->tool.bpf     = process_bpf_events;
+		script->tool.ksymbol	  = process_bpf_events;
+		script->tool.bpf	  = process_bpf_events;
+		script->tool.bpf_metadata = process_bpf_metadata_event;
 	}
 	if (script->show_text_poke_events) {
 		script->tool.ksymbol   = process_bpf_events;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 7544a3104e21..14b0d3689137 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1,9 +1,12 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <perf/cpumap.h>
+#include <perf/event.h>
+#include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -78,6 +81,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
 	[PERF_RECORD_FINISHED_INIT]		= "FINISHED_INIT",
 	[PERF_RECORD_COMPRESSED2]		= "COMPRESSED2",
+	[PERF_RECORD_BPF_METADATA]		= "BPF_METADATA",
 };
 
 const char *perf_event__name(unsigned int id)
@@ -505,6 +509,20 @@ size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp)
 		       event->bpf.type, event->bpf.flags, event->bpf.id);
 }
 
+size_t perf_event__fprintf_bpf_metadata(union perf_event *event, FILE *fp)
+{
+	struct perf_record_bpf_metadata *metadata = &event->bpf_metadata;
+	size_t ret;
+
+	ret = fprintf(fp, " prog %s\n", metadata->prog_name);
+	for (__u32 i = 0; i < metadata->nr_entries; i++) {
+		ret += fprintf(fp, "  entry %d: %20s = %s\n", i,
+			       metadata->entries[i].key,
+			       metadata->entries[i].value);
+	}
+	return ret;
+}
+
 static int text_poke_printer(enum binary_printer_ops op, unsigned int val,
 			     void *extra, FILE *fp)
 {
@@ -602,6 +620,9 @@ size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FIL
 	case PERF_RECORD_AUX_OUTPUT_HW_ID:
 		ret += perf_event__fprintf_aux_output_hw_id(event, fp);
 		break;
+	case PERF_RECORD_BPF_METADATA:
+		ret += perf_event__fprintf_bpf_metadata(event, fp);
+		break;
 	default:
 		ret += fprintf(fp, "\n");
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 664bf39567ce..67ad4a2014bc 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -370,6 +370,7 @@ size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_bpf_metadata(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *machine,FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FILE *fp);
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a320672c264e..38075059086c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -12,6 +12,7 @@
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <perf/cpumap.h>
+#include <perf/event.h>
 
 #include "map_symbol.h"
 #include "branch.h"
@@ -1491,6 +1492,9 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	case PERF_RECORD_FINISHED_INIT:
 		err = tool->finished_init(session, event);
 		break;
+	case PERF_RECORD_BPF_METADATA:
+		err = tool->bpf_metadata(session, event);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 37bd8ac63b01..204ec03071bc 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -1,12 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "data.h"
 #include "debug.h"
+#include "event.h"
 #include "header.h"
 #include "session.h"
 #include "stat.h"
 #include "tool.h"
 #include "tsc.h"
+#include <linux/compiler.h>
 #include <sys/mman.h>
+#include <stddef.h>
 #include <unistd.h>
 
 #ifdef HAVE_ZSTD_SUPPORT
@@ -237,6 +240,16 @@ static int perf_session__process_compressed_event_stub(struct perf_session *sess
 	return 0;
 }
 
+static int perf_event__process_bpf_metadata_stub(struct perf_session *perf_session __maybe_unused,
+						 union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_bpf_metadata(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
 void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 {
 	tool->ordered_events = ordered_events;
@@ -293,6 +306,7 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 	tool->compressed = perf_session__process_compressed_event_stub;
 #endif
 	tool->finished_init = process_event_op2_stub;
+	tool->bpf_metadata = perf_event__process_bpf_metadata_stub;
 }
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index db1c7642b0d1..18b76ff0f26a 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -77,7 +77,8 @@ struct perf_tool {
 			stat,
 			stat_round,
 			feature,
-			finished_init;
+			finished_init,
+			bpf_metadata;
 	event_op4	compressed;
 	event_op3	auxtrace;
 	bool		ordered_events;
-- 
2.50.0.rc1.591.g9c95f17f64-goog


