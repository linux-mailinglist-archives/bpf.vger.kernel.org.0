Return-Path: <bpf+bounces-47117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11E99F4A60
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 12:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A511C16BB28
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 11:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB201F37D6;
	Tue, 17 Dec 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6QTUKrY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27241F2390
	for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436592; cv=none; b=C3yS79QwOUEuI29Q6Z5gC/ItJIYQMM+RAIYWq7+7UBeA5lkgWKu2g0LNDz2ipkZtWQCubhvD3mU/yyHG0AcLBQaAHaghg+gdJs/b5IzAULi5W4zD47vXlhHBdYAjOsp8M4Oot8JNufLjfXuWbqJE51CNE3C9SvHXnHaVPSh6JgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436592; c=relaxed/simple;
	bh=tpnlelcMbJ7A8lxnHi41TMdRMlFf/pMqWGQuvroX664=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/4ek9JEj8YBauewc2Ep9pwxXSp1UsoFgKPQW4P1ew7xU/ivtZRUDLuwDqN0sy0PJNETJn9Nj1Lw9J2+LE5GRxI/pOhHf9nKszYAyg1LwJrVxb/zA9TswY0vCa+UweAZvVl4cd1l0zURpyjYe97ALYAjo4btivt6KT1YMnP9L8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a6QTUKrY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e06af753so2720457f8f.2
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 03:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734436589; x=1735041389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Swt8An6cH0UytiEm5BcU77Mv2Ddjr7IJCM9GFGK4Ig=;
        b=a6QTUKrYjFhtafekqJdaynKjbNhAAMY7O2v41wmwEQydeLW4sXdiVSBGWCMUBtHuy/
         pUaBE/NaN14J46TANmNMFzB/lJhG3vpWQbNCZZESmmPhSYdEKWXWzKPZU9E2tVQa8di5
         sla3CkmbrPdK+TDRlKbgVD8sFPgxZ7ObBY7OHwuKQ+5gYMO1DHNjRhZnYtSzZS2Au8rY
         0lCDgxnuafM/RnbSIRS7VCXW6la4MuhoRhU7ncrzATeQuur/ZfEX1mfH9fmEWk2FdJgI
         +i7hkkIPWLbeoTKV7Y3iEPcVzsrjh1OX+ZxgVf/O51K3fITcPRrtImrqGyWaBPy4aRoO
         kRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436589; x=1735041389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Swt8An6cH0UytiEm5BcU77Mv2Ddjr7IJCM9GFGK4Ig=;
        b=CqpNkZjPcS3bwJYQrVZI7kNuhifOv44YNyqpXQyFLQC0t3acQuByRE4t5MQQjqtrWD
         XTIQfFEMStgie8d6WJeR1FIo6enmcPUbjAFeFenE7bDhGIm0BsX9+HyaN8mYPxIyVNnH
         SeWBpvpIUnXhW/v0xEVS417pYrVnKD90Eh85ymgXvsul5MMIGB6RA6HffGydoN3r615w
         FnQjKOLRvUrniezSdt6laPIp6ZXUTIJxvR4ZEtrIzWQjYL93VV92UlE9pZ786DHQ+761
         JWZmZHB9Y6fzG/Kq/NSTkKpl+d5InA/gR/JApS9p9BIqd21Esk4E7AvVCsgZRtk3L88R
         +Lpg==
X-Forwarded-Encrypted: i=1; AJvYcCXMM4RXQQvn+kSngogxK4q5Z7SMqozSgdyweEdQ3FvyfhZwFHsd8SVZVhfG+8t5KPpVhck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXF0dE6YURUVRwEsSr2rpS0mX3KTDbDOV9PwR/0XBTF5CCoJxe
	kgPxyVkxSZ/AN38gFn3Wa/eCIPo62pOwmuEDk2Ccu7ADveyS+OnCTgkFiDUts6Y=
X-Gm-Gg: ASbGnctPxn6HuKvtExZqNAhuiSH44l9OdZPNKAGLy209nxxV8JBQYi3J5RIEB97YYzj
	GYzO4ttq8bMGpfwPZW0Ne91ytSU+2gNNCCYX1dxvoyblo22Vz7jszgQ1ai6E5QKFKDCMcELpq3a
	PtQadLaea3RcNk1ATPQfGSegWvutxWXPBOj/Xep7Fv4XKI0U2eHw6PaBs6L/zbOGhUV28Bj32/3
	mars0TFlpzJ/LVDDmG6l8VZw4JYlEC+TuoNBASial+oBnLB4OVYoZvI
X-Google-Smtp-Source: AGHT+IHYPBPQkQDRXyVGehPAmC7A1dmxHnikbhEhvzazvTv4q/sZtDwu0z2Pco+deD3aSmH2xXPBEw==
X-Received: by 2002:a05:6000:1f82:b0:385:ed16:cac with SMTP id ffacd0b85a97d-3889ad33ff4mr10801795f8f.56.1734436589050;
        Tue, 17 Dec 2024 03:56:29 -0800 (PST)
Received: from pop-os.. ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm114935825e9.6.2024.12.17.03.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:56:28 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 2/5] perf tool: arm-spe: Pull out functions for aux buffer and tracking setup
Date: Tue, 17 Dec 2024 11:56:05 +0000
Message-Id: <20241217115610.371755-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217115610.371755-1-james.clark@linaro.org>
References: <20241217115610.371755-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These won't be used in the next commit in discard mode, so put them in
their own functions. No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 83 +++++++++++++++++-----------
 1 file changed, 51 insertions(+), 32 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 22b19dcc6beb..1b543855f206 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -274,33 +274,9 @@ static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
 		evsel__set_sample_bit(evsel, PHYS_ADDR);
 }
 
-static int arm_spe_recording_options(struct auxtrace_record *itr,
-				     struct evlist *evlist,
-				     struct record_opts *opts)
+static int arm_spe_setup_aux_buffer(struct record_opts *opts)
 {
-	struct arm_spe_recording *sper =
-			container_of(itr, struct arm_spe_recording, itr);
-	struct evsel *evsel, *tmp;
-	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 	bool privileged = perf_event_paranoid_check(-1);
-	struct evsel *tracking_evsel;
-	int err;
-
-	sper->evlist = evlist;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel__is_aux_event(evsel)) {
-			if (!strstarts(evsel->pmu->name, ARM_SPE_PMU_NAME)) {
-				pr_err("Found unexpected auxtrace event: %s\n",
-				       evsel->pmu->name);
-				return -EINVAL;
-			}
-			opts->full_auxtrace = true;
-		}
-	}
-
-	if (!opts->full_auxtrace)
-		return 0;
 
 	/*
 	 * we are in snapshot mode.
@@ -330,6 +306,9 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			pr_err("Failed to calculate default snapshot size and/or AUX area tracing mmap pages\n");
 			return -EINVAL;
 		}
+
+		pr_debug2("%sx snapshot size: %zu\n", ARM_SPE_PMU_NAME,
+			  opts->auxtrace_snapshot_size);
 	}
 
 	/* We are in full trace mode but '-m,xyz' wasn't specified */
@@ -355,14 +334,15 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		}
 	}
 
-	if (opts->auxtrace_snapshot_mode)
-		pr_debug2("%sx snapshot size: %zu\n", ARM_SPE_PMU_NAME,
-			  opts->auxtrace_snapshot_size);
+	return 0;
+}
 
-	evlist__for_each_entry_safe(evlist, tmp, evsel) {
-		if (evsel__is_aux_event(evsel))
-			arm_spe_setup_evsel(evsel, cpus);
-	}
+static int arm_spe_setup_tracking_event(struct evlist *evlist,
+					struct record_opts *opts)
+{
+	int err;
+	struct evsel *tracking_evsel;
+	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 
 	/* Add dummy event to keep tracking */
 	err = parse_event(evlist, "dummy:u");
@@ -388,6 +368,45 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	return 0;
 }
 
+static int arm_spe_recording_options(struct auxtrace_record *itr,
+				     struct evlist *evlist,
+				     struct record_opts *opts)
+{
+	struct arm_spe_recording *sper =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct evsel *evsel, *tmp;
+	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
+
+	int err;
+
+	sper->evlist = evlist;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_aux_event(evsel)) {
+			if (!strstarts(evsel->pmu->name, ARM_SPE_PMU_NAME)) {
+				pr_err("Found unexpected auxtrace event: %s\n",
+				       evsel->pmu->name);
+				return -EINVAL;
+			}
+			opts->full_auxtrace = true;
+		}
+	}
+
+	if (!opts->full_auxtrace)
+		return 0;
+
+	evlist__for_each_entry_safe(evlist, tmp, evsel) {
+		if (evsel__is_aux_event(evsel))
+			arm_spe_setup_evsel(evsel, cpus);
+	}
+
+	err = arm_spe_setup_aux_buffer(opts);
+	if (err)
+		return err;
+
+	return arm_spe_setup_tracking_event(evlist, opts);
+}
+
 static int arm_spe_parse_snapshot_options(struct auxtrace_record *itr __maybe_unused,
 					 struct record_opts *opts,
 					 const char *str)
-- 
2.34.1


