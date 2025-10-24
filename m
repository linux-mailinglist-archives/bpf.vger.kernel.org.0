Return-Path: <bpf+bounces-72093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D286EC0662A
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 15:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70CF1A02C4B
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 13:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14D431AF2C;
	Fri, 24 Oct 2025 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dPR2QtJ9"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C7306B3E;
	Fri, 24 Oct 2025 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310878; cv=none; b=mbIGNwic6Ij9PcOu7+33/RoZyprTed0cWPLiQJ1r906mELIiXhqk4ztvlbJrbqCeLVb6kEtfHnJtwzBHG9Lzt67GWJsCQKH0sGAC2llwnPArGlzXEjvGi1XNjmhr4tgmoJ5fWNwCzIEG2++p/4nazCTbO1yc204+YHRMtr5XkwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310878; c=relaxed/simple;
	bh=l1MEcFp/OGu3LphR4OJF9AFCdbSAPnHpk6BxRdwlwJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMhnOY66g+2kuGmh27fMAhi543WIyVp/U/olDvItK8tArMWJQxKWiVKS+JW+Cy8RPD7HYjP7YKK+7udn/hK7Lsu7U4MOIIoO6ZwIAkjeaQXZ/x1RuzDaX0VjX4n0LXB7GEveMti2ez9ctEddh1ABqISaFgXSgYDbeNkrjfTpaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dPR2QtJ9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oLmXwixI0J2SyZ00m22yRqTkDayeJUXrIpJlJp7E7fU=; b=dPR2QtJ91UWUhHHUx2BRs5MXSA
	RySmOP9YuKQS7uT0aPZQ786krePmifcPkDq8WLo7zxMHj2SwHJXwzrTafEFbcV4kdPt5bWQLjEPmp
	wRIf26erKHHM/AhI4UGe8nEGOh3e+mfOX/470/mG2sP7PTpgaybgpNmKOj6gLH0OaC9uAlHJ9d51V
	/SqnFpykmiiCogsfYXGVpTiLSGy1rGJlEfPC1kWDIeFDbGnH9/7UaazOAnL/b5obwudymtMVrtDRM
	CIzDswhgcxFCxZW1r2OO1YsEARz6dNudWUrp4Hp2b2W6f5kH3kAK3cVbotUniGaVVRARy6+J2ADJp
	vxVdhTYA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCHPm-00000000rYf-3hcf;
	Fri, 24 Oct 2025 13:01:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A3A52300323; Fri, 24 Oct 2025 15:01:07 +0200 (CEST)
Date: Fri, 24 Oct 2025 15:01:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [PATCH v16 0/4] perf tool: Support the deferred unwinding
 infrastructure
Message-ID: <20251024130107.GB3245006@noisy.programming.kicks-ass.net>
References: <20250908175319.841517121@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908175319.841517121@kernel.org>



Per the hackery I did:

  https://lkml.kernel.org/r/20251023150002.GR4067720@noisy.programming.kicks-ass.net

The userspace bits need something like so on top..

---
 tools/perf/util/callchain.c               |    2 +-
 tools/perf/util/evsel.c                   |   10 +++++++---
 tools/perf/util/perf_event_attr_fprintf.c |    1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1832,7 +1832,7 @@ int sample__for_each_callchain_node(stru
 int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
 				     struct perf_sample *sample_callchain)
 {
-	u64 nr_orig = sample_orig->callchain->nr - PERF_DEFERRED_ITEMS;
+	u64 nr_orig = sample_orig->callchain->nr - 1;
 	u64 nr_deferred = sample_callchain->callchain->nr;
 	struct ip_callchain *callchain;
 
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1520,6 +1520,7 @@ void evsel__config(struct evsel *evsel,
 	attr->mmap2    = track && !perf_missing_features.mmap2;
 	attr->comm     = track;
 	attr->build_id = track && opts->build_id;
+	attr->defer_output = track && !perf_missing_features.defer_callchain;
 
 	/*
 	 * ksymbol is tracked separately with text poke because it needs to be
@@ -2206,8 +2207,10 @@ static int __evsel__prepare_open(struct
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
-	if (perf_missing_features.defer_callchain)
+	if (perf_missing_features.defer_callchain) {
 		evsel->core.attr.defer_callchain = 0;
+		evsel->core.attr.defer_output = 0;
+	}
 	if (perf_missing_features.inherit_sample_read && evsel->core.attr.inherit &&
 	    (evsel->core.attr.sample_type & PERF_SAMPLE_READ))
 		evsel->core.attr.inherit = 0;
@@ -2489,6 +2492,7 @@ static bool evsel__detect_missing_featur
 	perf_missing_features.defer_callchain = true;
 	pr_debug2("switching off deferred callchain support\n");
 	attr.defer_callchain = false;
+	attr.defer_output = false;
 	attr.sample_type = 0;
 
 	attr.inherit = true;
@@ -3255,8 +3259,8 @@ int evsel__parse_sample(struct evsel *ev
 			return -EFAULT;
 		sz = data->callchain->nr * sizeof(u64);
 		if (evsel->core.attr.defer_callchain &&
-		    data->callchain->nr >= PERF_DEFERRED_ITEMS &&
-		    data->callchain->ips[data->callchain->nr - PERF_DEFERRED_ITEMS] == PERF_CONTEXT_USER_DEFERRED) {
+		    data->callchain->nr >= 2 &&
+		    data->callchain->ips[data->callchain->nr - 2] == PERF_CONTEXT_USER_DEFERRED) {
 			data->deferred_callchain = true;
 			data->deferred_cookie = data->callchain->ips[data->callchain->nr - 1];
 		}
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -344,6 +344,7 @@ int perf_event_attr__fprintf(FILE *fp, s
 	PRINT_ATTRf(remove_on_exec, p_unsigned);
 	PRINT_ATTRf(sigtrap, p_unsigned);
 	PRINT_ATTRf(defer_callchain, p_unsigned);
+	PRINT_ATTRf(defer_output, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned, false);
 	PRINT_ATTRf(bp_type, p_unsigned);

