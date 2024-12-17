Return-Path: <bpf+bounces-47119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C638A9F4A67
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 12:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695FF16F24F
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DC91F4279;
	Tue, 17 Dec 2024 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPC/ActJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E61F3D56
	for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436600; cv=none; b=o44P8ll45tfyeUnjcuLuRfXgUwYM8Zl2TqXJ24ktxI9p4WeNZjuSOG76+7kcehuFOpf56pYqTMWxH1WYiZ2dfiwh5mIp9KoJRIo8S4YFDiA4Jc+LDOsYMipVMTpigL6u9qddCoCdxZK5Don5T/+3D5SpsAWSh8SaUGm5OvjAiUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436600; c=relaxed/simple;
	bh=uz/cOheGCgnwGt6ic1N6Vuscq6Gm3oMspfGnxKGBRG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uVnOPI50Q6tJkpCkPt0tk1TZ3TTv5EAK77Gt7bvrknDuTe6RcJ6o1C3WM6AnlsyRLU7f1KRilg7Tt2nBb/SUgZX63c3NU7jws3kMirMiRl+LNz0RY0qzD5voP9/Tr/OzuFLJmXGD8+5C3KzsP/RlShqXh3F8eYeoSbOtme6LkkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CPC/ActJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso32288365e9.1
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 03:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734436597; x=1735041397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwqWh99mkwgFG4i731gC0ut6m4bysgrlep8nFs6msoA=;
        b=CPC/ActJOpYZ+JDgY+WdKiEYlPAtj6pCGNhMRC9v4rm+p9UUs63iqwTgy9cYRJb46j
         dELYdiQJo0rnQNy0RnJU/GuFbWaCuViGAAOdptsjVUwZCaI4JytuT5QuL56d3/hTBUXE
         qWFKB3p03f9Atcp3UuJ0h9GQ/5n69xUei8cKJOk+ktsZv6f897UyxBK5LvYgljqmwsbu
         OBLziQ3VukHKvtTb86VCr4rh7ui8bHIQ7/nSUeRewkmbkwyOFUr8wTOR8eJp5azI0M2I
         erfte0MFWU/Ic7OAsukuADoNRXIbpciuZ7Dr1QnqEDUaENpLyxstnFg29TOCnzL6yxTX
         gSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436597; x=1735041397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwqWh99mkwgFG4i731gC0ut6m4bysgrlep8nFs6msoA=;
        b=erzCCUSrtbqybQh3phlTpL843tDQZnR3MkzNBxPmp3FWnxI11T3p8Lxtcjd8yj7D6R
         nzHLDh8v+L6RNenkXN6nAt24+8Lba3AvVAQlTXZTR1tjO3I1s5H9TIDpR2UXm1Iuf3hr
         wvuNUN7Kov2iGqILrkA2KOxMjnJ1Q12qfLh8n0qfBylxSyKJgihDMjtjlLTHLExX0MiS
         oqJ2JXBuIRGhMcoDNnntkW7BztqiY4iWLugzLHYF36CMDA2PvfuW1aNs9fjeRL9DClXh
         /ZXEyLa2cRNTaYWFL7trgTnEO620VbuxRPMJnMk/C3cnXLtwKMjp2X1a8wIWYzc1j5kN
         MIqA==
X-Forwarded-Encrypted: i=1; AJvYcCVxSfx+NKgfNAJ7I3wzqdlHcRx/B329ZsLUPbLRaEuvcZm28FXagiEZBjQDW8GBV43zPZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQJWUiuC0gJoVeF5BEf2Y7rd7IaKYerppi6OmgnfBJ7XAcn24k
	vehuF1FbAtci5RgbBtOEO6bm72UPmJRurg7Y7FiHeCWdt8GeempUC/eS4Pr/P0Q=
X-Gm-Gg: ASbGnctJdH7RXRCL5SCDDBa50ZCEUm5koHviioGcKicdD9+hbVC2ufPb0sOBxZFQw4t
	pMy3rWc1U3E/6OL4zhHOMj+xZQ7hn5iaU0W/miRwu6mfQ0R51uHeHszg5if2uRwpeWYkYcJ8npc
	pheYHCmP5rZ+CUEMJQf5v/jRdlHGMgQ/Ku63a7BTQuu9FoRdZD8vb9oauCy8SCJ3r9odTQiOKdH
	hZY7UXkmCPWi/gUKrUqlETdMzuiaC6ixEOaMrxjJ6kBR5BhCGMi8Tzg
X-Google-Smtp-Source: AGHT+IGwdSY4bxXI25oDz+FWewMmRHe9+KuuRiSPfZFzGZSjSm8Hi3QlFSfDLHoAEpYFbRs2avKTiw==
X-Received: by 2002:a05:600c:3b22:b0:434:fa73:a906 with SMTP id 5b1f17b1804b1-4364814eefdmr23438715e9.4.1734436597154;
        Tue, 17 Dec 2024 03:56:37 -0800 (PST)
Received: from pop-os.. ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm114935825e9.6.2024.12.17.03.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:56:36 -0800 (PST)
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
Subject: [PATCH 4/5] perf test: arm_spe: Add test for discard mode
Date: Tue, 17 Dec 2024 11:56:07 +0000
Message-Id: <20241217115610.371755-5-james.clark@linaro.org>
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

Add a test that checks that there were no AUX or AUXTRACE events
recorded when discard mode is used.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_spe.sh | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
index 3258368634f7..a69aab70dd8a 100755
--- a/tools/perf/tests/shell/test_arm_spe.sh
+++ b/tools/perf/tests/shell/test_arm_spe.sh
@@ -107,7 +107,37 @@ arm_spe_system_wide_test() {
 	arm_spe_report "SPE system-wide testing" $err
 }
 
+arm_spe_discard_test() {
+	echo "SPE discard mode"
+
+	for f in /sys/bus/event_source/devices/arm_spe_*; do
+		if [ -e "$f/format/discard" ]; then
+			cpu=$(cut -c -1 "$f/cpumask")
+			break
+		fi
+	done
+
+	if [ -z $cpu ]; then
+		arm_spe_report "SPE discard mode not present" 2
+		return
+	fi
+
+	# Test can use wildcard SPE instance and Perf will only open the event
+	# on instances that have that format flag. But make sure the target
+	# runs on an instance with discard mode otherwise we're not testing
+	# anything.
+	perf record -o ${perfdata} -e arm_spe/discard/ -N -B --no-bpf-event \
+		-- taskset --cpu-list $cpu true
+
+	if perf report -i ${perfdata} --stats | grep 'AUX events\|AUXTRACE events'; then
+		arm_spe_report "SPE discard mode found unexpected data" 1
+	else
+		arm_spe_report "SPE discard mode" 0
+	fi
+}
+
 arm_spe_snapshot_test
 arm_spe_system_wide_test
+arm_spe_discard_test
 
 exit $glb_err
-- 
2.34.1


