Return-Path: <bpf+bounces-48254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F71A05EAE
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 15:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020FC165178
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D491FE468;
	Wed,  8 Jan 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjGj4xth"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40BD1FECBB
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346637; cv=none; b=ahA595/uEhnU+MCzLQbSAy02hXAMYKQZw+HV3oyBEnrQfF/v0j/zhh9GwbKuQ/R67cSTEYhZ3M3iQ/3dn5bSM+SHUAnqmNKEFhNR2Zv0/zDm0VNqsiu4Z2eC5+F3qLJTK/nLtN2ikYZFA9oJ4+vwvIvwmOAh32Zs5NSBQUyv0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346637; c=relaxed/simple;
	bh=HJMe93LWOIndT8K0R5G7ezfVXY9GgrzNRpECoxcqcxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqfuFRS8QMkPhAeC8v1fmKCukzgezlzQZpfiy3pSUCZcQaPj3gSfG+mSzvwsV9EV1PUdSAJak8e5vKk++bEqhUvQ0hVdNQwvAp92BwojkkLKBPjXWDb2d9fnffMs2khW5UuOfFogZ5NTYd5jrRboB8/pODF77FCitlX1gfDp/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sjGj4xth; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso8878413f8f.3
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736346634; x=1736951434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1j+BIbB70BfH6p+H3D0C/f2KwCH22I9fsAuqIEouAI=;
        b=sjGj4xthcnusiWMlxR/w5ooLBd6P+p2EOt6slHOKl8sr4r9wKcZAS2HSFE2LhQLb9s
         44vqhRMcOm2iuw7wl4u/mUjrw2zP579mP7+ExMYHcS8ZNhFo86QQpXcKuSeOtHH0rQoe
         QseyF1dlvPLMZCneXBkcNwgHUCUFHCPmtfYC7nX69Jz9hA57jDHZPCOwT9xLt3uhzctL
         Xm7MRXGmgkBU0IDgRx6+45k4Ab9M5NCzqMgJIqHrjTNzvaXhmnoIMiUm09nwraBOl5o/
         zDCoEuHG9w078mmoyQ/poLrt9V+5UwrdY/alyhpxr0RgF4g6+zN2IvHxhrNbasF5WpZh
         BhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346634; x=1736951434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1j+BIbB70BfH6p+H3D0C/f2KwCH22I9fsAuqIEouAI=;
        b=OdwaR6EMpAmyI5GLJCUufoUiZY3V7j473RQ0BxeUDpHDdbbq5ukITM9C4bIx1cEIOe
         tWiY963cRrtrc9aAli9hkZkXVIadztAGDRv7RvZkPOMMehCANB+hIdPL22jYkRlW41v7
         mpT3X9MbW/hMg2+vu4Z1yPxeR8uVXUUOM1kPJH0euD4zdiySmAq1oCTsOoQvGOL/5k+b
         UXHc6ogPwmOtSPumsGZJ5Ty+zgX4rWCcw++Tb5R0FOLebb7Tr2mA4AMiImnX+zuyqaZQ
         8PqGcfzpAsTsR4+j+ClQnUL457kQp3Cp147adlT3BiwfIpYmw2oClFxSgbokGR/iONTw
         Vn2w==
X-Forwarded-Encrypted: i=1; AJvYcCUz39/PvhjxKJSuk/OqsLMOtpyL0guN7X2P2QvZnAtipnotoiabXb1VfGbnOBymZwzdz5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPyFfpQ4lCxqkgUQBHpQt+rJ3v50sfLx49IkAjkeLY7sXSgixj
	EhrElpVC69rvALZmO3nvidYSMSRb9zODdqu9TjyzKCh6kwVhd00Ko9Oqae+Ri1M=
X-Gm-Gg: ASbGncsJX8rad/C6rIgt33zMGxMkiJpMfTKqYtWXV6S+U+5oditcdc1WpyhoLdclWSf
	zD6eEeMxCrjL3pGmg/TEtW8BTGVAQhr0PnDdNCJgGH+jduVi2oxhN9IsQnj+VJ/VrgSLXnSi7Y4
	WXE7OJK83fjuy1yhCZutlN3GCPTg80FmSKP9RNBPpvZ4uWbfC5PTQgDzT8MycH/CP8GjM9zBmHE
	Dj7cGuCSTesCjym9mRwnfPAihk+OaICzeeLPWIPLAw5gBsx+XnswzFO
X-Google-Smtp-Source: AGHT+IGPG2fbcdAWI2kWNuJul9oexF8hk5Ad1KOrWrlN7IkVYSCPH+BLbdTguMj87I9RIg+5zb7CeQ==
X-Received: by 2002:a5d:47a3:0:b0:38a:4184:2510 with SMTP id ffacd0b85a97d-38a872db629mr2716682f8f.23.1736346634083;
        Wed, 08 Jan 2025 06:30:34 -0800 (PST)
Received: from pop-os.. ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddccf4sm22836965e9.19.2025.01.08.06.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:30:33 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	namhyung@kernel.org,
	acme@kernel.org
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 5/5] perf test: arm_spe: Add test for discard mode
Date: Wed,  8 Jan 2025 14:29:00 +0000
Message-Id: <20250108142904.401139-6-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108142904.401139-1-james.clark@linaro.org>
References: <20250108142904.401139-1-james.clark@linaro.org>
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


