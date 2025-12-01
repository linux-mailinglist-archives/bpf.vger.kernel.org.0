Return-Path: <bpf+bounces-75838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAC7C99030
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 21:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E5B3A4ACC
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 20:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3902652B6;
	Mon,  1 Dec 2025 20:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkNbt3ou"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B42278E47
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764620695; cv=none; b=Qci6mN8ha9iXMHjiWEzjiOStYsCsCTk3gB9GHvXnsP7rAM39sqOdrRm6b7GzpTFWBg5KeAm9ImaPJZbitr3TcCeM47XatFL46Upf+Ev7PgWsnoN4DQ+jX8OSCHgE701JboSlWqKXlrSYS6rQmj6xRA0O9G/l86VAgFJFGXYwscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764620695; c=relaxed/simple;
	bh=9VtX2NvFz0RoQVJ8SSqGMuTYPnLO3r9LWpqks/kmpMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WTKK6tLdyXqLTe+teVRNEaXD9cMU97GP4f9SKpTXn8RyFVDEQ4nkRm/+0aA5ll+of7gPJMROfRwiG1/oRzuOx59DmWgV5WlDswlWz5f8xHVUhyEhvTTTVdeNBhpc/VYdt765lYOrW7IaGC+ujo3GXx7ZOv4sQBCcHZduHEGDMcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jkNbt3ou; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bde2e654286so3723826a12.3
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 12:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764620691; x=1765225491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iuYJ8a9yf5YfCIOX0vDCxkx5Zc9d0WA0EbWHTfFbCpI=;
        b=jkNbt3ouuc6NmxFq5apXPbnMYpm1+zjWpeLCHENUhZshBHu5HtyWtBRrtrgDl7yalQ
         OtXQasM1U+p8W2X/IYCa2cUExCHo0oVWoB8FJsSl1BeopyHbTrYz+9YzTGuqlAKYUaQI
         IJapEgCG+EizpaCFsG6l5ATwt5rzAJ4+tDTdFaxXAEItPwJu0MKHQ7YGAErlkZb1XXhU
         MWgjhSmcDoofFGwbkjtHo5nMbpLoUUNjN5loYr7jv9kC3Q+I/88Ak23hMapuj4HFYfBO
         son19Lz+dHz87y71srH8WwtEHospUet67m9ZKRWT2Iyh2vFf+e/JVNXH8Z5jFwFJqBQ3
         1TiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764620691; x=1765225491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuYJ8a9yf5YfCIOX0vDCxkx5Zc9d0WA0EbWHTfFbCpI=;
        b=GNmS2THla8wgMd++rXVRdkThQlsUrN0XX0yuM/mnuzZn6gBHTcqCgl2mF8izalSyUq
         7759m329sT6Y72rOX9XvMS3hLhN7IKD4tdzxDXNZK54IY+imdO1fYPzbqZ2UJUf5b9/Z
         6vQZiX1WYKho3Lq6ugrxRaDuRujGmZO8UC1Po88t+IfRZXFkYFS9AuK8gP4Vu0nlfr5F
         KpjWHM84eaJFLyiROfLSvdLhaDU3D3LUze4nhP3QwTX//i3wKFbmr/MT5Kb9+n8g2DHv
         uAbcKwwq2fblrJelfPphL4C3s/gwxzvSRgYsZQcLNrytPPmSGv4+EhW85i7eH+hdRyo2
         TQdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXteAXTWvM0v9xkPov/z9Ji0BIh35/0nYTUFoHjzk3YOwTMxHx/P1xubTW88QnOi8ChyAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfhs4BnmRmzYQijKKKJJfwQam6/SG+yY8kpN3IPVsKwFpj7JM5
	f1YQ/4TM2XWsaICVjzlPLe18YbFZ4obKqRrevOvu/yIatcVsrmZYGVvHSNz8YNqAMoqeluIv/tZ
	9dEY0Gx9EN4bCHA==
X-Google-Smtp-Source: AGHT+IGsvk85QlzW667SyDst19B1vMCsdIZFkhsIWO+5Oz5JLmlMK/v87N6vvqpae9OjXI/Z5iDlf2o2nXomaQ==
X-Received: from dlbdd25.prod.google.com ([2002:a05:7022:a99:b0:11c:58e4:e325])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:6726:b0:119:e56b:98ab with SMTP id a92af1059eb24-11cb3ede9dcmr19616669c88.18.1764620691371;
 Mon, 01 Dec 2025 12:24:51 -0800 (PST)
Date: Mon,  1 Dec 2025 12:24:35 -0800
In-Reply-To: <20251201202437.3750901-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201202437.3750901-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251201202437.3750901-3-wusamuel@google.com>
Subject: [PATCH v3 2/2] cpufreq: Documentation update for trace_policy_frequency
From: Samuel Wu <wusamuel@google.com>
To: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
Cc: christian.loehle@arm.com, Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Documentation update corresponding to replace the cpu_frequency trace
event with the policy_frequency trace event.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst   | 10 +++++-----
 Documentation/admin-guide/pm/intel_pstate.rst | 14 +++++++-------
 Documentation/trace/events-power.rst          |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index e1771f2225d5..e110854ece88 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -503,8 +503,8 @@ Trace Events
 --------------
 
 There are two static trace events that can be used for ``amd-pstate``
-diagnostics. One of them is the ``cpu_frequency`` trace event generally used
-by ``CPUFreq``, and the other one is the ``amd_pstate_perf`` trace event
+diagnostics. One of them is the ``policy_frequency`` trace event generally
+used by ``CPUFreq``, and the other one is the ``amd_pstate_perf`` trace event
 specific to ``amd-pstate``.  The following sequence of shell commands can
 be used to enable them and see their output (if the kernel is
 configured to support event tracing). ::
@@ -531,9 +531,9 @@ configured to support event tracing). ::
           <idle>-0       [003] d.s..  4995.980971: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=3 changed=false fast_switch=true
           <idle>-0       [011] d.s..  4995.980996: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=11 changed=false fast_switch=true
 
-The ``cpu_frequency`` trace event will be triggered either by the ``schedutil`` scaling
-governor (for the policies it is attached to), or by the ``CPUFreq`` core (for the
-policies with other scaling governors).
+The ``policy_frequency`` trace event will be triggered either by the
+``schedutil`` scaling governor (for the policies it is attached to), or by the
+``CPUFreq`` core (for the policies with other scaling governors).
 
 
 Tracer Tool
diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index fde967b0c2e0..274c9208f342 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -822,23 +822,23 @@ Trace Events
 ------------
 
 There are two static trace events that can be used for ``intel_pstate``
-diagnostics.  One of them is the ``cpu_frequency`` trace event generally used
-by ``CPUFreq``, and the other one is the ``pstate_sample`` trace event specific
-to ``intel_pstate``.  Both of them are triggered by ``intel_pstate`` only if
-it works in the :ref:`active mode <active_mode>`.
+diagnostics.  One of them is the ``policy_frequency`` trace event generally
+used by ``CPUFreq``, and the other one is the ``pstate_sample`` trace event
+specific to ``intel_pstate``.  Both of them are triggered by ``intel_pstate``
+only if it works in the :ref:`active mode <active_mode>`.
 
 The following sequence of shell commands can be used to enable them and see
 their output (if the kernel is generally configured to support event tracing)::
 
  # cd /sys/kernel/tracing/
  # echo 1 > events/power/pstate_sample/enable
- # echo 1 > events/power/cpu_frequency/enable
+ # echo 1 > events/power/policy_frequency/enable
  # cat trace
  gnome-terminal--4510  [001] ..s.  1177.680733: pstate_sample: core_busy=107 scaled=94 from=26 to=26 mperf=1143818 aperf=1230607 tsc=29838618 freq=2474476
- cat-5235  [002] ..s.  1177.681723: cpu_frequency: state=2900000 cpu_id=2
+ cat-5235  [002] ..s.  1177.681723: policy_frequency: state=2900000 cpu_id=2 policy_cpus=04
 
 If ``intel_pstate`` works in the :ref:`passive mode <passive_mode>`, the
-``cpu_frequency`` trace event will be triggered either by the ``schedutil``
+``policy_frequency`` trace event will be triggered either by the ``schedutil``
 scaling governor (for the policies it is attached to), or by the ``CPUFreq``
 core (for the policies with other scaling governors).
 
diff --git a/Documentation/trace/events-power.rst b/Documentation/trace/events-power.rst
index f45bf11fa88d..f013c74b932f 100644
--- a/Documentation/trace/events-power.rst
+++ b/Documentation/trace/events-power.rst
@@ -26,8 +26,8 @@ cpufreq.
 ::
 
   cpu_idle		"state=%lu cpu_id=%lu"
-  cpu_frequency		"state=%lu cpu_id=%lu"
   cpu_frequency_limits	"min=%lu max=%lu cpu_id=%lu"
+  policy_frequency	"state=%lu cpu_id=%lu policy_cpus=%*pb"
 
 A suspend event is used to indicate the system going in and out of the
 suspend mode:
-- 
2.52.0.107.ga0afd4fd5b-goog


