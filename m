Return-Path: <bpf+bounces-47588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D37C89FBCB4
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 11:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC3518834C4
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 10:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4441C174E;
	Tue, 24 Dec 2024 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxuGCt3D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3382E1BDAAE
	for <bpf@vger.kernel.org>; Tue, 24 Dec 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735037081; cv=none; b=mmAp+jr2ZnTcYCrb/X5wUAKO8WnGPgeh+u4rngYM0tAPcUB6IIJnmJdd1eR/CmzxZHsI2LFsYpSumLUX5Cdxn12sexPhkiAJCTThoJFfbIoHTfPkWzG/ViHJpdguyGvkFIeXo6kxyiTaZrGgGCXaec7f06pdlbMPIWVjRm5llr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735037081; c=relaxed/simple;
	bh=yePtXUNb/r1DdBXxhuOfkHvg5tUlHsFB+j5qY2RIjQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/dcKJTl1ZiXlbOBrhlQ/A90fc1t0SC4uy7FjDV7m3g2jHDyh42JNFpN0DYRawkkTIPodLpBQ8jaLmwGk/Lvi2wHG1DgtQAEBPTuHmE+mU3MORcbS+d0oSXS5mUYJrv+9mXtlfqV6DtXD9K5NT45uhyxutXSB+PSg809HvPJL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IxuGCt3D; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso4329501f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Dec 2024 02:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735037077; x=1735641877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHAl/iVdRpFZ4l6Mby+FrJoyVvI8kLZuzTqR3xsa9gY=;
        b=IxuGCt3Dft/VHOLVlwvTCINTchX00rrdcGBrraTBOfGlRKdSlaSWRh5wFq4rd07AuZ
         VYr6Nh7j9XPRcy3908huWVbY1T60dNzv9CcB/uU0DCfeNClGKUmOdpDcY9XfgcPajNPp
         fpLrci69bvlmeaNTE8BusNeLBMm50I0LMqxT0NH4TvK74S8eolRIuVhZ7k/3YdRhxHwm
         l7H2JnjrL59I4sooz+7AOQUuTODecDO9VbeIhahhBVETfcE5ikDmu9UDYIBvAG1OflqE
         wr4ULejftyyXi7p5GbT3KxViGuLmXLaYeu1ToVuHzDExiLKq8Y9mJhAXHNX+EmGWmyiw
         qXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037077; x=1735641877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHAl/iVdRpFZ4l6Mby+FrJoyVvI8kLZuzTqR3xsa9gY=;
        b=TV63Tx8z1qnUNs3X2yH1/h6Pybv1YSkp4Skr8iakPEhDxxIbQbSXkS+h/NBVLQiZT0
         h0HI85LqVHEAhFH1T5qfEdWcMi4EPEr+G+oC32QMOwiZt2qSk09OFh7H05p1oUlcVmHT
         1o6ye62rGdiXEQKUptehcW4zAJTizVB9yJRERTLrYMUFNqhCG5/J1+Om6qehm3WIUca5
         C96wQYjWubi2Gb0kCxoCidqoGO2HQxA9cUecnckv2RlBpheCxyyGwJ+EJO1qi62x4LgY
         A7Qxrcb3/Pv3uLrvH+hza1j2D9+2mrDZn7DoIHYSJysznbPCpLSTEVndhf/Harv9K/yT
         3BeA==
X-Forwarded-Encrypted: i=1; AJvYcCWtTxm/IvyrXARYqKJfya63O7Z0UUvZxZuVrcCacoExusgZKtejLNohUevEH4hlNyeWXzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMPVuAIggUTmqiUXJTr/VhGvvpFUJgC3DDtqOfzL9n5TdqH/X
	ZnF5hH8Ld9/FUwkP0ETBD8zixsdBKpiyqBnfUrNcTV4abQQwOdbCOCvQpzGyd3U=
X-Gm-Gg: ASbGncv8FZ2DAHR067a0n50IYIrARh4/6aY5fwi7z3vW44LOH4k0BaFUtDxvplpS3bK
	yiQdQzYXo5E6EqIUFZ9NUXWTByYd8iNqlK87f4fUSYKTuLcMC2ytmyiOchIsQbuctTePICsKgD0
	SB1+e4+g21H5vxiAtXzLotjYtQ57d6y6vgwdsWtXwldEtle2nvDYBviVfT3zhxMEt6WQzLARPuF
	K1jyaWDoUsmangvXJDQiy0ubixfqlOUwsJUzk98XKnWjKcwMb1EWm8=
X-Google-Smtp-Source: AGHT+IH7n+am9veH0sjuso0VQt6cOhLb48Ywipt9+tQpA2guKm2WC+9l0VoxKlK8wBiZB7S6GwshiQ==
X-Received: by 2002:a05:6000:154f:b0:385:eeb9:a5bb with SMTP id ffacd0b85a97d-38a221f698amr13901717f8f.17.1735037077544;
        Tue, 24 Dec 2024 02:44:37 -0800 (PST)
Received: from pop-os.. ([145.224.66.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847714sm13938184f8f.54.2024.12.24.02.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 02:44:37 -0800 (PST)
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
Subject: [PATCH v2 1/5] perf: arm_spe: Add format option for discard mode
Date: Tue, 24 Dec 2024 10:44:08 +0000
Message-Id: <20241224104414.179365-2-james.clark@linaro.org>
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

FEAT_SPEv1p2 (optional from Armv8.6) adds a discard mode that allows all
SPE data to be discarded rather than written to memory. Add a format
bit for this mode.

If the mode isn't supported, the format bit isn't published and attempts
to use it will result in -EOPNOTSUPP. Allocating an aux buffer is still
allowed even though it won't be written to so that old tools continue to
work, but updated tools can choose to skip this step.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fd5b78732603..9aaf3f98e6f5 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -193,6 +193,9 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_store_filter_CFG		config	/* PMSFCR_EL1.ST */
 #define ATTR_CFG_FLD_store_filter_LO		34
 #define ATTR_CFG_FLD_store_filter_HI		34
+#define ATTR_CFG_FLD_discard_CFG		config	/* PMBLIMITR_EL1.FM = DISCARD */
+#define ATTR_CFG_FLD_discard_LO			35
+#define ATTR_CFG_FLD_discard_HI			35
 
 #define ATTR_CFG_FLD_event_filter_CFG		config1	/* PMSEVFR_EL1 */
 #define ATTR_CFG_FLD_event_filter_LO		0
@@ -216,6 +219,7 @@ GEN_PMU_FORMAT_ATTR(store_filter);
 GEN_PMU_FORMAT_ATTR(event_filter);
 GEN_PMU_FORMAT_ATTR(inv_event_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
+GEN_PMU_FORMAT_ATTR(discard);
 
 static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_ts_enable.attr,
@@ -228,9 +232,15 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_event_filter.attr,
 	&format_attr_inv_event_filter.attr,
 	&format_attr_min_latency.attr,
+	&format_attr_discard.attr,
 	NULL,
 };
 
+static bool discard_unsupported(struct arm_spe_pmu *spe_pmu)
+{
+	return spe_pmu->pmsver < ID_AA64DFR0_EL1_PMSVer_V1P2;
+}
+
 static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 						  struct attribute *attr,
 						  int unused)
@@ -238,6 +248,9 @@ static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
 
+	if (attr == &format_attr_discard.attr && discard_unsupported(spe_pmu))
+		return 0;
+
 	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
 		return 0;
 
@@ -502,6 +515,12 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
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
@@ -743,6 +762,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
 		return -EOPNOTSUPP;
 
+	if (ATTR_CFG_GET_FLD(&event->attr, discard) &&
+	    discard_unsupported(spe_pmu))
+		return -EOPNOTSUPP;
+
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
 	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
-- 
2.34.1


