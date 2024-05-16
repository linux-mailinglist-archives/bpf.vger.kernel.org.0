Return-Path: <bpf+bounces-29834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBC38C70DF
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 06:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717501C22AD9
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 04:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EAE3C460;
	Thu, 16 May 2024 04:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQVeyQJ7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B353A1C7
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 04:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833208; cv=none; b=TvgTAHpc4TmqWLMNHSqCL2vcrn0EeFTmAVS1lVnQXB7MlfdOtUoLhcnHmPEhuvfPUnxPPpdgS56CeB0HG+xO3NznuZTcbCjv3Eg/i6vTyp0umwDQf+jF26/RvoVzY4DmzBH3bS9b4N36Dwlaxa9dqZC729aQ/no0TMnL+hUGzsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833208; c=relaxed/simple;
	bh=Nv+3HueaFBpq0ManiQPb2nzrakeW2xnnHkQ4j1i1l+g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HW83KWXl92hqIm9mdW8RpAAhscuWfi8Szw0Wc/MCYx/KWa+uhUqVSZ3s10pHszllVQsFeVdBkU8wk6jaiQk9Wpf/KK5SqcqGWVOG0oCOk5uI7XBOIu/Ce8lEtBCBTe1f1p5qVCXUQpe/02k1bwbSjSaNQhRAXfqNhxqteVQ3R2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BQVeyQJ7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be26af113so127790397b3.1
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 21:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715833206; x=1716438006; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHUNwY+jZJ4I56wa5Ovfy+1yS4DVUHS8CDe2LVh2L3Q=;
        b=BQVeyQJ7XKXZrZXLL7X8iztvqNbOOpz254i+azpr1V5mrM40Y2f2U/wm/maoYh/TW5
         ZGhciTehLCYUjfRIKf/BjUJVW1WFZMa0ovNSzfqpH+51P2f+pnxKBxKAB1R0U79oZOid
         kPHQXY/sSKBkmjSIfCvyvZR0pZsMYReDkVbMilXAqltt6+mu4NeDlPosPFjHl+BUajVU
         X7r1qmeupYBAk13WSzSlFwrnK/pJYZT2rF5GBVZ5W2h4Nd0OXG+PsvjjZ31X7cLFT9fc
         C0VesNyDt77q7lwhgmtEGdZlm8ht5NXej0aLEc8NUWfGAI6oBLOMbW2L9Qh+s2MEodCO
         9N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715833206; x=1716438006;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHUNwY+jZJ4I56wa5Ovfy+1yS4DVUHS8CDe2LVh2L3Q=;
        b=xJ/uAVcE7Nbfr8C0xHQ2setEYhz+fDvX65zfOxStzjxaBHo4dSPrmWRxBADo6/LXBf
         jhCHaa524dzEazar6ciN116fAifKZpSSudY6uCnWgQewbBlYGQfh8gss/opajDh/2mRf
         10OAcbnaQHCvnym/xleQH2rHKfHOB1CF1I/DCrmPGIAdDaiKoB2gZ+zHuzuVOIRMc0Gh
         P1WW3hHwHpaktleR5miI5qVR50pTf7/PQoPYEdmz4gDmLISN2I4dVD2qDUOA9zTMD9VF
         /Jw8X8P1u6ypli0d6325dqBv8CzkgpKiuxoifKbVKiMseKd0KEGPExSOxeP838eM9OjM
         HyVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuK9mhcolDS+0P4YpvwZiht0kwj6u5Nudn5wqLdNHzGFt++HJsekUUSfPes4/sTOdefOTbSkLBshSaiFOgwESCyoyj
X-Gm-Message-State: AOJu0YzXx4bYlfhTHEvBSNAIUQ6XeDjsbL3t62MHNkobEm8DN3N0x1ZA
	IxQUMpsU6ClOBYx6Zpgn29AG8I7k5GmLSV7WLPsJRSGuz1JEu6EE/mBU+1Ir6q5LPYat9rY0VNp
	IrQF/jQ==
X-Google-Smtp-Source: AGHT+IEmsYfZ191hEn2qs6aItqv20l4B4aEnLGlOMnKMlr+RTXfnPSmdUNe5GTDQqUISBptTpjDFi2GkkTA9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bac3:cca1:c362:572])
 (user=irogers job=sendgmr) by 2002:a05:690c:3601:b0:61b:e6fb:9e08 with SMTP
 id 00721157ae682-622b01333cbmr41173597b3.8.1715833206211; Wed, 15 May 2024
 21:20:06 -0700 (PDT)
Date: Wed, 15 May 2024 21:19:47 -0700
In-Reply-To: <20240516041948.3546553-1-irogers@google.com>
Message-Id: <20240516041948.3546553-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 2/3] perf bpf filter: Add uid and gid terms
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow the BPF filter to use the uid and gid terms determined by the
bpf_get_current_uid_gid BPF helper. For example, the following will
record the cpu-clock event system wide discarding samples that don't
belong to the current user.

$ perf record -e cpu-clock --filter "uid == $(id -u)" -a sleep 0.1

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt     | 2 +-
 tools/perf/util/bpf-filter.c                 | 4 ++++
 tools/perf/util/bpf-filter.l                 | 2 ++
 tools/perf/util/bpf_skel/sample-filter.h     | 3 +++
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 4 ++++
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6015fdd08fb6..059bc40c5ee1 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -200,7 +200,7 @@ OPTIONS
 	  ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
 	  code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
 	  p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
-	  mem_dtlb, mem_blk, mem_hops
+	  mem_dtlb, mem_blk, mem_hops, uid, gid
 
 	The <operator> can be one of:
 	  ==, !=, >, >=, <, <=, &
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 7e8d179f03dc..c5d6c192d33a 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -80,6 +80,10 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 		CHECK_TERM(DATA_PAGE_SIZE);
 		CHECK_TERM(WEIGHT_STRUCT);
 		CHECK_TERM(DATA_SRC);
+	case PBF_TERM_UID:
+	case PBF_TERM_GID:
+		/* Not dependent on the sample_type as computed from a BPF helper. */
+		return 0;
 	case PBF_TERM_NONE:
 	default:
 		break;
diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index 62c959813466..2a7c839f3fae 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -95,6 +95,8 @@ mem_lock	{ return sample_part(PBF_TERM_DATA_SRC, 5); }
 mem_dtlb	{ return sample_part(PBF_TERM_DATA_SRC, 6); }
 mem_blk		{ return sample_part(PBF_TERM_DATA_SRC, 7); }
 mem_hops	{ return sample_part(PBF_TERM_DATA_SRC, 8); }
+uid		{ return sample(PBF_TERM_UID); }
+gid		{ return sample(PBF_TERM_GID); }
 
 "=="		{ return operator(PBF_OP_EQ); }
 "!="		{ return operator(PBF_OP_NEQ); }
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index 161d5ff49cb6..3e64ccacc5e5 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -34,6 +34,9 @@ enum perf_bpf_filter_term {
 	PBF_TERM_DATA_PAGE_SIZE,
 	PBF_TERM_WEIGHT_STRUCT,
 	PBF_TERM_DATA_SRC,
+	/* Terms computed from BPF helpers. */
+	PBF_TERM_UID,
+	PBF_TERM_GID,
 };
 
 /* BPF map entry for filtering */
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 8666c85e9333..da4b5eb7cce3 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -146,6 +146,10 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		}
 		/* return the whole word */
 		return kctx->data->data_src.val;
+	case PBF_TERM_UID:
+		return bpf_get_current_uid_gid() & 0xFFFFFFFF;
+	case PBF_TERM_GID:
+		return bpf_get_current_uid_gid() >> 32;
 	default:
 		break;
 	}
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


