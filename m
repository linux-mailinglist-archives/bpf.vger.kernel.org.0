Return-Path: <bpf+bounces-48145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B7BA0487B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 18:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EDB3A65D7
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE451990A7;
	Tue,  7 Jan 2025 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqyVLnXj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D518D62A;
	Tue,  7 Jan 2025 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736271598; cv=none; b=KnirfJgPCCRlR5tqc2YA6wjLaAW82D702M0wjBlzSSNMel6jO+uUXm5wy11sdHxPRiYkoxdYEELp1zAtGHNXdcXj2ZWVodwojZicHuC09Qi6U9Bmgkvd2fJCFXr8ztpjnyI89D9pEcAzYgZ40R1NCuORm5kA/Bp+UKpqhHklWTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736271598; c=relaxed/simple;
	bh=bC0Vjd7rRZHPln6p604z6wqdtBBsP1GgN3w/1l4oKoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff+Pwrku7NarIMxMxFLOVpyVl6o4ZSOM8TFzBwuO6KOsv87b8YjY3ZKqmTVaDo97Cfpz/RLSLGcUzEbVEjMBSXy4A650iBvOYSF4mhYgbaTKEYTVE1638mICJa4fcBOoYb4fo+OcDpfSMJdhPyR8FG4u3lvesbCK2B1T2uHL/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqyVLnXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8E2C4CED6;
	Tue,  7 Jan 2025 17:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736271597;
	bh=bC0Vjd7rRZHPln6p604z6wqdtBBsP1GgN3w/1l4oKoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqyVLnXjjRsPz9sT60cqkyLe+0aJppf2xeVF2/aVlPTMNpSIhwmUZ/l2TpHI7LM9b
	 m0IeLxWD7yTzJZmPzOPOR2jT3O3QwhxAqapmFHtVHW0QRx71zyV7TgDSXtRpTiWqIV
	 eXAFymlyfpJe5JQ33ms2SwdjgVGfTKrlF4QgEsbLGCz1bDVH4OkBZ5ZxiCwazuIaiE
	 QtOejTF/pF7IOJQTDk3NMh548h/uYHrRrosK7Ntd+anHvU2HON2QGBZDm5XkahhfVx
	 FpeU36MT4cbyVKbCVCIRdzpd96w+CxYVgRGwZylpK7TFypf9JpjGtoyKhvTu42qteE
	 GK3qykviouzAA==
Date: Tue, 7 Jan 2025 17:39:51 +0000
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
	irogers@google.com, yeoreum.yun@arm.com, mark.rutland@arm.com,
	robh@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/5] perf: arm_spe: Add format option for discard mode
Message-ID: <20250107173950.GA8111@willie-the-truck>
References: <20241224104414.179365-1-james.clark@linaro.org>
 <20241224104414.179365-2-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224104414.179365-2-james.clark@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 24, 2024 at 10:44:08AM +0000, James Clark wrote:
> FEAT_SPEv1p2 (optional from Armv8.6) adds a discard mode that allows all
> SPE data to be discarded rather than written to memory. Add a format
> bit for this mode.
> 
> If the mode isn't supported, the format bit isn't published and attempts
> to use it will result in -EOPNOTSUPP. Allocating an aux buffer is still
> allowed even though it won't be written to so that old tools continue to
> work, but updated tools can choose to skip this step.
> 
> Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/perf/arm_spe_pmu.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index fd5b78732603..9aaf3f98e6f5 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -193,6 +193,9 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
>  #define ATTR_CFG_FLD_store_filter_CFG		config	/* PMSFCR_EL1.ST */
>  #define ATTR_CFG_FLD_store_filter_LO		34
>  #define ATTR_CFG_FLD_store_filter_HI		34
> +#define ATTR_CFG_FLD_discard_CFG		config	/* PMBLIMITR_EL1.FM = DISCARD */
> +#define ATTR_CFG_FLD_discard_LO			35
> +#define ATTR_CFG_FLD_discard_HI			35
>  
>  #define ATTR_CFG_FLD_event_filter_CFG		config1	/* PMSEVFR_EL1 */
>  #define ATTR_CFG_FLD_event_filter_LO		0
> @@ -216,6 +219,7 @@ GEN_PMU_FORMAT_ATTR(store_filter);
>  GEN_PMU_FORMAT_ATTR(event_filter);
>  GEN_PMU_FORMAT_ATTR(inv_event_filter);
>  GEN_PMU_FORMAT_ATTR(min_latency);
> +GEN_PMU_FORMAT_ATTR(discard);
>  
>  static struct attribute *arm_spe_pmu_formats_attr[] = {
>  	&format_attr_ts_enable.attr,
> @@ -228,9 +232,15 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
>  	&format_attr_event_filter.attr,
>  	&format_attr_inv_event_filter.attr,
>  	&format_attr_min_latency.attr,
> +	&format_attr_discard.attr,
>  	NULL,
>  };
>  
> +static bool discard_unsupported(struct arm_spe_pmu *spe_pmu)
> +{
> +	return spe_pmu->pmsver < ID_AA64DFR0_EL1_PMSVer_V1P2;
> +}

Why not add a new SPE_PMU_FEAT_* for this and handle it in a similar
way to other optional hardware features?

Will

