Return-Path: <bpf+bounces-56202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FF1A92DCB
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 047EC7A3B8C
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01570255E3E;
	Thu, 17 Apr 2025 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1oazZ2/a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A1253B7F
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931312; cv=none; b=e5BFKv6CxaBfdmXjiR/VGbMEz6UXudNIZysAuCH3cgUwO/K3oAWgSCUoVyACFZnrPju8IOCN3jZAFnlwNN4IsdTvcWlnVxlzmVlXTmROwx/c2CiG4Ci5d7gNya/l4VmKJiMsgnU5lG5PpdSrz3r4pYny/k9wqqn0D4kV4JQYCMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931312; c=relaxed/simple;
	bh=4z4gW1zRYCCwysIUyAe3e8VCBdOYyrgGoIXqH8yEfYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Oa8p0zmdlThb5uPuE6mKL6hhQuyd2raPh9Bc7Itm40f/NXCETdHzjh0Fs0F1qFCOxT0uOlMleFuRqZc2ku+jQC92sGJ8pE9lfTC9wLSALWrRb8xaowLf1hyU9VUAHKZy/bxx5HMhv0kLnh4uuY6xqmrbkhVcqNWwpdRQpa1LpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1oazZ2/a; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225107fbdc7so12734665ad.0
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931310; x=1745536110; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DtBD4ZMv9kOd8HctqbtqQiXkO3Y0PBpeScsbHocvr8Q=;
        b=1oazZ2/a1fAxXCagIPUMxygIfb7jHq4TRGeOmDDqTyYfF+CZC0QgJd6AE4OsvwBHoG
         7QSuitWUfWm3erM/Z0RTCCTAw+XvqTXLfl8miQaB2LmIjIxPaLjYZaoblf1niASED8+J
         T+A5u711s4uPTLnCi/AU3NSL2pZGuDY/yxUn1mvXvUI5M7/BHRxdYNo0HLJUXBsUT1J7
         bnG1/41whRkpWUvD6bvynjjL6KVGNKe+cwwl5dEr+gfnqcJetovfL6PWWbCvPiguJkbY
         8jg2NtC4jxvOmgnMKJQtWflgS7kOIof8LjiPzVP3KbR0zh0wt8oXlJYaTKm1hHJd9mSV
         ZKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931310; x=1745536110;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtBD4ZMv9kOd8HctqbtqQiXkO3Y0PBpeScsbHocvr8Q=;
        b=LZkVcR7QvEe6k2mkoq0+X3tmqoUfHAsx8zWiiEbhqgMnLLsxscldENCLY53rt2skeH
         VvFiFnalAosO87QPLvX3z66Dfujwk6f6gY0Cy4pTZMt6yHNL73JJMVBJm81XAk9ORAtl
         wx0RbNo2M9Lh3Uq+y8ED2XHN5tEFvl2VV+UVFmlOk0sDn5HJn9tbqNCiGDr3T1Dt0uuW
         0D/qK9+ULYFmZy0TrTBrGziO39wvx4XtK9q+M+EOY4/YHWdZWrU2EUeJOAhMRURxAOpF
         EYVzMIFJ6Tvp8UUGMb2edxQuJ7TDd8T14crwf5Nw8SdAda9cNCR7Do7NQmQNy4PURkOk
         +h3w==
X-Forwarded-Encrypted: i=1; AJvYcCVV6jiQk24tpAOQExxqkwxT1NRxsh7rG9W/w/3aCpyVS8SPnWeBkfaKYaoWg/tftaPUtWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq5k/4Od9u8Is1k3iZpfP8VnbvvWowWdvS54tVwaS/88j+6TUw
	yTbpiuRobRGWRb3XkY2v9vvvcS7NCF6KEupQysCYhxI7atNaxfuUv1rLQo35EbSnCBO+OHlIYE9
	tdfw4cw==
X-Google-Smtp-Source: AGHT+IHMtsZutPRyIyx14Pp7e7dCE8WR3NROHmlpPvZEjnfl9ohpt846ZUWL5TFfQkuwyyo4WIfiJ8YKJMLR
X-Received: from plrf20.prod.google.com ([2002:a17:902:ab94:b0:223:6930:304e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b66:b0:220:ec62:7dc8
 with SMTP id d9443c01a7336-22c535738f3mr11016455ad.2.1744931310034; Thu, 17
 Apr 2025 16:08:30 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:38 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-18-irogers@google.com>
Subject: [PATCH v4 17/19] perf disasm: Make ins__scnprintf and ins__is_nop static
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reduce the scope of ins__scnprintf and ins__is_nop that aren't used
outside of disasm.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 6 +++---
 tools/perf/util/disasm.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 683eb6aa7b53..72e7f1312fb4 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -246,8 +246,8 @@ static int ins__raw_scnprintf(struct ins *ins, char *bf, size_t size,
 	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->raw);
 }
 
-int ins__scnprintf(struct ins *ins, char *bf, size_t size,
-		   struct ins_operands *ops, int max_ins_name)
+static int ins__scnprintf(struct ins *ins, char *bf, size_t size,
+			  struct ins_operands *ops, int max_ins_name)
 {
 	if (ins->ops->scnprintf)
 		return ins->ops->scnprintf(ins, bf, size, ops, max_ins_name);
@@ -824,7 +824,7 @@ static struct ins_ops ret_ops = {
 	.scnprintf = ins__raw_scnprintf,
 };
 
-bool ins__is_nop(const struct ins *ins)
+static bool ins__is_nop(const struct ins *ins)
 {
 	return ins->ops == &nop_ops;
 }
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 2cb4e1a6bd30..09c86f540f7f 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -110,13 +110,10 @@ struct arch *arch__find(const char *name);
 bool arch__is(struct arch *arch, const char *name);
 
 struct ins_ops *ins__find(struct arch *arch, const char *name, struct disasm_line *dl);
-int ins__scnprintf(struct ins *ins, char *bf, size_t size,
-		   struct ins_operands *ops, int max_ins_name);
 
 bool ins__is_call(const struct ins *ins);
 bool ins__is_jump(const struct ins *ins);
 bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
-bool ins__is_nop(const struct ins *ins);
 bool ins__is_ret(const struct ins *ins);
 bool ins__is_lock(const struct ins *ins);
 
-- 
2.49.0.805.g082f7c87e0-goog


