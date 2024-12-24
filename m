Return-Path: <bpf+bounces-47591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314729FBCBC
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 11:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C2218850F8
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 10:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAA11D86C0;
	Tue, 24 Dec 2024 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QIsL4g9S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BAC1D7989
	for <bpf@vger.kernel.org>; Tue, 24 Dec 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735037092; cv=none; b=hKXiHuwurqBdnCfLa13MwzcugoF9vXVjv7CzeSc/moydXRyieElWqe0dvvOwKosTqAKjoIv+1m7SUmihj+d2Ye+NphH1cCuFzeA1nK1wHv0BJa9vvIAOA/L170R+6IG7/ajTktvr4o2k6ENdY4ZWEuWciXrLyDKAualeaWCs5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735037092; c=relaxed/simple;
	bh=HJMe93LWOIndT8K0R5G7ezfVXY9GgrzNRpECoxcqcxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uG0yk1Rnhm6b5ySrtygcGxaXQUYia4/IFL8z6G8DO6Do4Lz0CRi0nsmB+48+owcTLjdazor055RGT+4jkVszt7oyJaBy4yx9gHIfP+V78wxWG4rD17AVa2xX6s5AS01upwL4vvdObHuzfrl5zH0mzX8KGOqmZWwtbHCJNSzOqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QIsL4g9S; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38637614567so2268353f8f.3
        for <bpf@vger.kernel.org>; Tue, 24 Dec 2024 02:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735037089; x=1735641889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1j+BIbB70BfH6p+H3D0C/f2KwCH22I9fsAuqIEouAI=;
        b=QIsL4g9SqfvBiWEXjofNuKU7xAkggtYLmRD4I+1QY+pcbJkMInKKEsW9EY03fpo7j9
         tgk22TwN0NWaJRu0Q4DbqXksLVsKDUW/2iDdTyVyhxsXGELEeC5wHaqO3H3qH9zKmNds
         uyyoLd8aGWoqvyq427HUfhHfxMrLfxZp7hbvp6HRn1HNuTrKvf3xHHjTuhWQhxH2hHCz
         AqMaRI5AXbvXVOcF4/cEMRrOUKhlwXwwH5pdyUXZwn7XSE0UV3gT5PZQFIS2Op4FukKb
         1K2PpDeREOqttOLECsC7V582EiZ0Jt8jyapaBJXtEaphhSG8NngWGILRA1dDrvCMor9u
         T3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037089; x=1735641889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1j+BIbB70BfH6p+H3D0C/f2KwCH22I9fsAuqIEouAI=;
        b=J96ZbHVaMeJH7bakItT26ODMDYfJEuc8Ai0iuQvIs0B0ndm2Lj02QxKRzU6PJZzrEp
         JwgGw1i9hYdRwUOCjHcyL/k6hQLtQ9A6LQrlIMOHefjr4vrcbgGiUVE984fHpM2fexiG
         DYfRt6kFfoA3bDdDu/2QN8QXDbLXnOw21GsKLTIhVLGtZ5SdubfdpvUXXeSLn7DBanba
         jb4WulPnSrTCvNtxVcBDW53q69oNXwQayaeSEE0O96nWp57UhxXUJe63CV2m1OS+30vf
         1rM1X9rxgYu5koqw9tSCeHV8kLzZ9fi1KchJj2Ux8JG62zNoyqKa2Ec21KNHjqmhDEh8
         x89A==
X-Forwarded-Encrypted: i=1; AJvYcCWZnn54y3m5vd+DAn4l7pZAB46fQ2vqQMCgAgm4RJnMy0v4eWuSXLFC0ndU7M7U4WyRZr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw24MpbIaZSKGLTyikIfai20oXIITuxojCqAEaTFxSBIoCCPS+l
	/WKTICXabo95I+GiT6vHgYXgszm3bCbY4Cr1lAbKmCe0YfBxPXGAmYlhdwvkI4A=
X-Gm-Gg: ASbGncv41GaRN3Vh590qvKcs80WKDSbetf4GNMMII1sMzEnDlwnrd7/3nm94Ux84oE1
	dkr6l8tcjMvVMom6K0VoX5iLoe11OyA08IZV/jiOtqLzDAAxVz2aHKp3RhWkIRjlKrielRjJRS1
	kU3mUwwxvQCFCqk5Enyq6QKYanqFO0UGnGoQmkq8rVkN8j/VfAzmrqsLigDvjVS9876v4KiJqL6
	2BBdhhm7xy+NdFhXS4Q4P4gYP41LfaRTQi9UH3m73K5LCaYBry4TsE=
X-Google-Smtp-Source: AGHT+IH+dfpgTuFz+C7tBaq/J7Dc+pyrOC6X4KjPHRcroZadLExb0vNcsLRnA0H4zbAjsKClBUrHAA==
X-Received: by 2002:a5d:64ad:0:b0:385:e67d:9e0 with SMTP id ffacd0b85a97d-38a221ffe1bmr13551020f8f.29.1735037089043;
        Tue, 24 Dec 2024 02:44:49 -0800 (PST)
Received: from pop-os.. ([145.224.66.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847714sm13938184f8f.54.2024.12.24.02.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 02:44:48 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 4/5] perf test: arm_spe: Add test for discard mode
Date: Tue, 24 Dec 2024 10:44:11 +0000
Message-Id: <20241224104414.179365-5-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224104414.179365-1-james.clark@linaro.org>
References: <20241224104414.179365-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that checks that there were no AUX or AUXTRACE events
recorded when discard mode is used.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
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


