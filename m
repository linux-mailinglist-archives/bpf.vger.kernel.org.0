Return-Path: <bpf+bounces-48250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F85FA05E98
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 15:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B6D27A13C6
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 14:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D411FDE24;
	Wed,  8 Jan 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoJQsvAS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DBC1FDE14
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346617; cv=none; b=JR+B3sGyH+xcBCVs/ycus6Rp9dvkl46ktQ4+ZOCVmsBsLwOeSlz9ipHDYgk36bsfTVfgVHc8+ovvHUzUzlMa770gkUrnfIiAy1qjzARYwNvYRzBU/c1VseCY6YAR4zYc3I4ZaHfEhOMXE4EnBvYTPBIScXnCQiVtsMMqxAVTZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346617; c=relaxed/simple;
	bh=kPHLZrDNKrarvsG+2cdGymsw5D7aOVxFWnWlmvzi7lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VyGTIkfecQYI4WPEzJ1uQHeg6VrgAFM+yXz+zCq9FChr9S2zlAdu03U7OKrDY3rFP4yODBSaLUCswUf5bRiSDtuYaXjyr/8g44DDJJmClVeRy8PcOg1izr5C4EgSd4xNnJDhDkLjCVyODHU6DDtvlgbmq4B7RPEiqqegHPtvt3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DoJQsvAS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso122055035e9.2
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 06:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736346613; x=1736951413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGOb+QzXOCupJHbixt2wd4hm1wKT1vTFMOcKSfrV7BU=;
        b=DoJQsvASnWMFRujCq682Nv1wS1DakpBs+XLeZBVzZIOnO11iahneuNuz+LQQ0all5a
         M4vf1PCPhIk5gPA6rw/HxnK7qAWOSDHlAYzMWLPGqOmUIIM8u6DxMk+XBjInJVrfWeNp
         +OD/2BXrX2GLaCXfnE5DkCjgbF1ClEFMvwVhNR+gRlI+srrIYi3/s8ihFlHFbcq8h0Nx
         V7e9DGmSCQdEJ/XNJXH0AretZ2ExgW43MB8+cjduufxRbDB0LRFQs/PrvcU9YXY4WS5F
         yonCY01IskrQrOMH/2Sf5rf0XgWfQ6PHY/OiHoVleDIwF8jOOlvGgc1Qhj7mtcG38XuV
         p/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346613; x=1736951413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGOb+QzXOCupJHbixt2wd4hm1wKT1vTFMOcKSfrV7BU=;
        b=C6lNXSoAZFJXLozS8K1Ed3JLznO8phDGWqBZSGKg0DKSkr11zg89iSuLHsRrlOEO0K
         LAb46HeNy52tKeZ/prMfGe8czStNmkpJVPAp4oqXomYXvlCcHmo00fUgUywQ/tVJAh5b
         +ITr4dmtcV5Vuekmf3sfn2gA5g+PctBJQSTJn6M53NL2Q/zjqDsQxMkDANrlPD1CBzln
         XI6dTnikLzqXKAJrs77S+L5Wi1BeOWjP0UlzZ+0QdW/7ar5vvRcNdC3gcisxCt7sZR9I
         jVGwdN4VTSGQd7s/C0Qb/wWZ9DS6GhbCuGLqiTdO2FmvbJ0j/0blvqIKXF/STbSqmCoP
         FPPA==
X-Forwarded-Encrypted: i=1; AJvYcCWZHp7djvSybrfFpGeCAysWZiE4WUZ01qbbL2mmw6QmGlsJBKmCsayMPxKagGOwnh3aqBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/STpMJlgCY7R7Yy3MLvPZHllliOAWORK5MGoUEOvqyHJyvMS
	sxpqZCQxfxVeeE5uOe6MRyAzWLzCw+lcp6u4bVL1xDjiP9AIAMWB/2hIvDUM3ps=
X-Gm-Gg: ASbGncsLXqXjeL/WM6uYEB0xQYJgkQwxwdc+j9ddKiVO0jQh4bDUzryfZKrq5Xc/RRw
	zQF6W/idpdwx2Za+G7Eq6G/gwFSh4mzVHmmKb6zXQ4QRLtqdXRjxabILg0enhHMEh6C2UnUHZ/X
	kxI1wvl8NZ8wOv+Mx7kE9V6h0Z7drX+jsirAVQSMAzlfldEHrwy43OS1bGEg6io8fk6V8Bhk0ah
	cT6qslEdBEFeUZ+urBYvDqGYnffcHtC/sUHoGwT+zfPCtPtK62w0Jxa
X-Google-Smtp-Source: AGHT+IHN1A9cX6z/xhhtgrQjHkaDM0PpDq23z/ArfmpMTg/+JIa+MQk4qZUtvdK5AFfi/widPNwZ7g==
X-Received: by 2002:a05:600c:1d07:b0:434:9934:575 with SMTP id 5b1f17b1804b1-436e26a8f4dmr28940535e9.16.1736346612923;
        Wed, 08 Jan 2025 06:30:12 -0800 (PST)
Received: from pop-os.. ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddccf4sm22836965e9.19.2025.01.08.06.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:30:12 -0800 (PST)
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
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 1/5] perf: arm_spe: Add format option for discard mode
Date: Wed,  8 Jan 2025 14:28:56 +0000
Message-Id: <20250108142904.401139-2-james.clark@linaro.org>
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

FEAT_SPEv1p2 (optional from Armv8.6) adds a discard mode that allows all
SPE data to be discarded rather than written to memory. Add a format
bit for this mode.

If the mode isn't supported, the format bit isn't published and attempts
to use it will result in -EOPNOTSUPP. Allocating an aux buffer is still
allowed even though it won't be written to so that old tools continue to
work, but updated tools can choose to skip this step.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fd5b78732603..f5e6878db9d6 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -85,6 +85,7 @@ struct arm_spe_pmu {
 #define SPE_PMU_FEAT_LDS			(1UL << 4)
 #define SPE_PMU_FEAT_ERND			(1UL << 5)
 #define SPE_PMU_FEAT_INV_FILT_EVT		(1UL << 6)
+#define SPE_PMU_FEAT_DISCARD			(1UL << 7)
 #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
 	u64					features;
 
@@ -193,6 +194,9 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_store_filter_CFG		config	/* PMSFCR_EL1.ST */
 #define ATTR_CFG_FLD_store_filter_LO		34
 #define ATTR_CFG_FLD_store_filter_HI		34
+#define ATTR_CFG_FLD_discard_CFG		config	/* PMBLIMITR_EL1.FM = DISCARD */
+#define ATTR_CFG_FLD_discard_LO			35
+#define ATTR_CFG_FLD_discard_HI			35
 
 #define ATTR_CFG_FLD_event_filter_CFG		config1	/* PMSEVFR_EL1 */
 #define ATTR_CFG_FLD_event_filter_LO		0
@@ -216,6 +220,7 @@ GEN_PMU_FORMAT_ATTR(store_filter);
 GEN_PMU_FORMAT_ATTR(event_filter);
 GEN_PMU_FORMAT_ATTR(inv_event_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
+GEN_PMU_FORMAT_ATTR(discard);
 
 static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_ts_enable.attr,
@@ -228,6 +233,7 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_event_filter.attr,
 	&format_attr_inv_event_filter.attr,
 	&format_attr_min_latency.attr,
+	&format_attr_discard.attr,
 	NULL,
 };
 
@@ -238,6 +244,9 @@ static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
 
+	if (attr == &format_attr_discard.attr && !(spe_pmu->features & SPE_PMU_FEAT_DISCARD))
+		return 0;
+
 	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
 		return 0;
 
@@ -502,6 +511,12 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 	u64 base, limit;
 	struct arm_spe_pmu_buf *buf;
 
+	if (ATTR_CFG_GET_FLD(&event->attr, discard)) {
+		limit = FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
+		limit |= PMBLIMITR_EL1_E;
+		goto out_write_limit;
+	}
+
 	/* Start a new aux session */
 	buf = perf_aux_output_begin(handle, event);
 	if (!buf) {
@@ -743,6 +758,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
 		return -EOPNOTSUPP;
 
+	if (ATTR_CFG_GET_FLD(&event->attr, discard) &&
+	    !(spe_pmu->features & SPE_PMU_FEAT_DISCARD))
+		return -EOPNOTSUPP;
+
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
 	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
@@ -1027,6 +1046,9 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	if (FIELD_GET(PMSIDR_EL1_ERND, reg))
 		spe_pmu->features |= SPE_PMU_FEAT_ERND;
 
+	if (spe_pmu->pmsver >= ID_AA64DFR0_EL1_PMSVer_V1P2)
+		spe_pmu->features |= SPE_PMU_FEAT_DISCARD;
+
 	/* This field has a spaced out encoding, so just use a look-up */
 	fld = FIELD_GET(PMSIDR_EL1_INTERVAL, reg);
 	switch (fld) {
-- 
2.34.1


