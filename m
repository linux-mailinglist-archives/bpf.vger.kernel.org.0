Return-Path: <bpf+bounces-29835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FD08C70E3
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 06:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883BF1C22A07
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 04:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CEA4C627;
	Thu, 16 May 2024 04:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXA/O0ag"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AEB3A1C7
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 04:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833211; cv=none; b=lSq9kwiuzLpgAD25xupXnLiDLBymnAxgNMxIp54M8OcXeeb/GdekYpG8KHPKaFZ1+WyfQ1YmYO/UbXLjmGykoxYVlxohANrcErWeqCgY4vi4zKQ/G8x1N2GmJ9AHfwMLf02/cMvGo0e4aJm0abIVulDar+CgiREA+mKd27WnnIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833211; c=relaxed/simple;
	bh=tm50rM0/vPAY35AZcNIkh9G+ITQ1yOK+pmrR/wf9O70=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kOSJHLb6kE34MdDUnAdRYpZbqPufUQisYIfC+G/dJ4HQDhxog4RwojNUWSRAofQdRgLn0uvM3v2pKkmNC9uEwJoacPyGWwP0gq+avLej0QIlrf2G7pPb5jEXLhY1p9F8Szi16S8TCvk6xf3nGJ57GwaSgX/1XidruFiQmEY7RKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sXA/O0ag; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de54ccab44aso14315009276.3
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 21:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715833208; x=1716438008; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6nxXyVAqYg+7CILkdLqmh6c58xAPU1gAIUJoi7JwDM=;
        b=sXA/O0agGCg+1UF0X3HIuqhuczwjWjicjB94RD1GtFoRXMM/6rIR8/A3Lg08ST7POc
         n7r6ui04LJHJp2DNfCNJ3U3cCMU2Po2XQz1dXlU6rHY0fH/8IrkOtqTAxTh8R+fx5jEK
         7YZ1+eEufd9ogb8Q/hpn9cEqn5XUftkAu9B271zIw5vIFc9qlG+mhjj3/bc7VTasKhhH
         MELJ6QpT5ioYkF9P/6kpV6k9frLexBxw3qvRu8oZHZkUEjBnDOh3yHfEg3lnoB2KwEEN
         AB1cpWaNHwt+fURgPwJ3ufrD1PV2hWqklx8hkGE85s0bZlBg0x6y9gSLkQGo7VE/QnGF
         Uocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715833208; x=1716438008;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6nxXyVAqYg+7CILkdLqmh6c58xAPU1gAIUJoi7JwDM=;
        b=suY4rB5xwvUPfkVG2CR67ADvGbWQkNyZmBZ1E1LLqZGaj4jD0xbc9gUyMvnmE4dZvC
         uptzuhcZ3JgIGMk05m36xVbui6w2qAwdalxtzlNDWWZ//HARKYbX74AMImISUH5SPl0E
         P9bBDt4bzwlc11sSK/VbGEcLoTHkWNGad7dtf4ly2M53cpjXdaRv/hCyOakVnNa7e3Vq
         FxrRHnv+Ee0bpX4KJdxLcmbLDwquPC+uMbnTOKmS3CGIsKkzNUworpl8bPuE6tu1/swv
         XYzTQMp1oFRKA2vNFLoAWR5mRE/f0ebjlqgqX0efPf+401ot0fTcUzxUkmQ4qSyPpZ9F
         Hcmw==
X-Forwarded-Encrypted: i=1; AJvYcCVf42Tcja8Ai/r76A56YQLPOGdVF2r+TYsujfPar3M1GfzeFOyvy3ZTcP6pfkQvxXNqKfvUmJO1qu+U3Vd2T5ucPvKF
X-Gm-Message-State: AOJu0YwVmgOJ7LILAZherVlIJmJcPR3SacHhRlrvO6w66wDt+Bn8pypj
	CH6Yw1GS9tS0ztzFNcTBSqfr8LyCw86S8oDRyGQnvVW4gTJXSDZ1r44fGYGuxjMhdYWPPL7VG/F
	P7cj1uQ==
X-Google-Smtp-Source: AGHT+IFa1kPJs1KsUvyTEmNoS/ubhW5OW5/ldB9W6PN5lhmb7Eya9ytsv10yFVGmu5YQXG3Ep5oQwmxgecGx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bac3:cca1:c362:572])
 (user=irogers job=sendgmr) by 2002:a25:7486:0:b0:de5:2325:72a1 with SMTP id
 3f1490d57ef6-dee4f192850mr4368968276.4.1715833208535; Wed, 15 May 2024
 21:20:08 -0700 (PDT)
Date: Wed, 15 May 2024 21:19:48 -0700
In-Reply-To: <20240516041948.3546553-1-irogers@google.com>
Message-Id: <20240516041948.3546553-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 3/3] perf top: Allow filters on events
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

Allow filters to be added to perf top events. One use is to workaround
issues with:
```
$ perf top --uid="$(id -u)"
```
which tries to scan /proc find processes belonging to the uid and can
fail in such a pid terminates between the scan and the
perf_event_open reporting:
```
Error:
The sys_perf_event_open() syscall returned with 3 (No such process) for event (cycles:P).
/bin/dmesg | grep -i perf may provide additional information.
```
A similar filter:
```
$ perf top -e cycles:P --filter "uid == $(id -u)"
```
doesn't fail this way.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-top.txt | 4 ++++
 tools/perf/builtin-top.c              | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index a754875fa5bb..667e5102075e 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -43,6 +43,10 @@ Default is to monitor all CPUS.
 	encoding with the layout of the event control registers as described
 	by entries in /sys/bus/event_source/devices/cpu/format/*.
 
+--filter=<filter>::
+	Event filter.  This option should follow an event selector (-e). For
+	syntax see linkperf:perf-record[1].
+
 -E <entries>::
 --entries=<entries>::
 	Display this many functions.
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1d6aef51c122..e8cbbf10d361 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1055,6 +1055,13 @@ static int perf_top__start_counters(struct perf_top *top)
 		}
 	}
 
+	if (evlist__apply_filters(evlist, &counter)) {
+		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
+			counter->filter ?: "BPF", evsel__name(counter), errno,
+			str_error_r(errno, msg, sizeof(msg)));
+		goto out_err;
+	}
+
 	if (evlist__mmap(evlist, opts->mmap_pages) < 0) {
 		ui__error("Failed to mmap with %d (%s)\n",
 			    errno, str_error_r(errno, msg, sizeof(msg)));
@@ -1462,6 +1469,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
 		     "event selector. use 'perf list' to list available events",
 		     parse_events_option),
+	OPT_CALLBACK(0, "filter", &top.evlist, "filter",
+		     "event filter", parse_filter),
 	OPT_U64('c', "count", &opts->user_interval, "event period to sample"),
 	OPT_STRING('p', "pid", &target->pid, "pid",
 		    "profile events on existing process id"),
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


