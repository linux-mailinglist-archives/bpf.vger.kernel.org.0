Return-Path: <bpf+bounces-77863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D32FCF518D
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 18:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C8453062D6E
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 17:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF8346782;
	Mon,  5 Jan 2026 17:49:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A4532F77B;
	Mon,  5 Jan 2026 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635370; cv=none; b=ZoyA3KCq0Oy8UWICABOKDbrIsN1O13VUjv2YJM1OxcpBTTSvKErl8AejDSndqQ4+tEkEKZfBoK4B28I1axCObznREiR6F8H9y8TuTthnJ6S78ChJgbWXM2I/w/aad/DATBjpydyM3zwFHO5TcVaGl5t4VRrWXZE0R3xaV7mUtt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635370; c=relaxed/simple;
	bh=LHhp0BPM0+l9H2W7V25rYnLvMmxm19SEfo+ha/WF/sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUGpVIRku1u/fk4uWO6e9TshXTlBGQzUf8+4jPRlvD7SbSzZu2lLNitqf6mfqG0bpiVX4Vyt6oPU0c0rbjiRWxHPJVuFhPCBji4bYAHGOI5tCxViATo+jh7/Crc64PWXZ7EoabMz0QyM3Eij5xezFcnajVlRZVjjRdC1LAim930=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 706F9339;
	Mon,  5 Jan 2026 09:49:20 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 926AF3F5A1;
	Mon,  5 Jan 2026 09:49:24 -0800 (PST)
Date: Mon, 5 Jan 2026 17:49:18 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Rob Herring <robh@kernel.org>, Breno Leitao <leitao@debian.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH] perf/arm64: Add BRBE support for
 bpf_get_branch_snapshot()
Message-ID: <aVv5nq5QTVDOz1Zk@J2N7QTR9R3>
References: <20260102214043.1410242-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102214043.1410242-1-puranjay@kernel.org>

Hi Puranjay,

I have a number of techincal concerns with this, noted below. At a high
level, I don't think this makes sense without a better description of
the usage, and I suspect we'd need changes to bpf_get_branch_snapshot()
to be able to implement something useful.

On Fri, Jan 02, 2026 at 01:40:41PM -0800, Puranjay Mohan wrote:
> Enable the bpf_get_branch_snapshot() BPF helper on ARM64 by implementing
> the perf_snapshot_branch_stack static call for ARM's Branch Record
> Buffer Extension (BRBE).
> 
> The BPF helper bpf_get_branch_snapshot() allows BPF programs to capture
> hardware branch records on-demand. This was previously only available on
> x86 (Intel LBR, AMD BRS) but not on ARM64 despite BRBE being available
> since ARMv9.

When exactly can bpf_get_branch_snapshot() be called?

How is it expected to be used?

The driver is written on the expectation that BRBE records are only read
in the PMUv3 overflow handler.

> This implementation:
> 
> - Follows the x86 snapshot pattern (intel_pmu_snapshot_branch_stack)
> - Performs atomic snapshot by pausing BRBE, reading records, and
>   restoring previous state without disrupting ongoing perf events

If BRBE is stopped, then we lost contiguity of branch records (e.g. for
a series of branches A->B->C->D->E, we could record A->B->D->E). The
driver is intended to ensure contiguity of those records, and if that's
lost, we deliberately discard. That's why brbe_enable() calls
brbe_invalidate().

Restarting BRBE without discarding will produce bogus data for other
consumers. If BRBE is stopped, we *must* discard.

> - Reads branch records directly from BRBE registers without
>   event-specific filtering to minimize branch pollution

If BRBE is paused, there's no polution, so this rationale doesn't make
sense to me.

BRBE can be configured with various filters (specific to the event),
multiple events with distinct filters can be active simultaneously, and
if no branch-sampling events are active, BRBE won't record anything. I
do not think it makes sense to record whatever happens to be present,
without filtering. Regardless, BRBE won't be recording if you don't have
events. so this doesn't seem to make sense.

> - Handles all BRBE record types (complete, source-only, target-only)
> - Complies with ARM ARM synchronization requirements (ISB barriers per
>   rule PPBZP)
> - Reuses existing BRBE infrastructure (select_brbe_bank,
>   __read_brbe_regset, brbe_set_perf_entry_type, etc.)

This duplicates other code (e.g. the body of
brbe_read_filtered_entries()), and I don't think this is justified.

> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
> 
> This patch is only compile tested as I don't have access to hardware with BRBE.
> 
> ---
>  drivers/perf/arm_brbe.c  | 95 ++++++++++++++++++++++++++++++++++++++++
>  drivers/perf/arm_brbe.h  |  9 ++++
>  drivers/perf/arm_pmuv3.c |  5 ++-
>  3 files changed, 108 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> index ba554e0c846c..cda7bf522c06 100644
> --- a/drivers/perf/arm_brbe.c
> +++ b/drivers/perf/arm_brbe.c
> @@ -803,3 +803,98 @@ void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
>  done:
>  	branch_stack->nr = nr_filtered;
>  }
> +
> +/*
> + * ARM-specific callback invoked through perf_snapshot_branch_stack static
> + * call, defined in include/linux/perf_event.h. See its definition for API
> + * details. It's up to caller to provide enough space in *entries* to fit all
> + * branch records, otherwise returned result will be truncated to *cnt* entries.
> + *
> + * This is similar to brbe_read_filtered_entries but optimized for snapshot mode:
> + * - No filtering based on event attributes (captures everything)
> + * - Minimal branches to avoid polluting the branch buffer
> + * - Direct register reads without event-specific processing
> + */

As above I don't think these differences are necessary nor do I think we
should be duplicating this.

> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
> +{
> +	unsigned long flags;
> +	int nr_hw, nr_banks, nr_copied = 0;
> +	u64 brbidr, brbfcr, brbcr;
> +
> +	/*
> +	 * The sequence of steps to freeze BRBE should be completely inlined
> +	 * and contain no branches to minimize contamination of branch snapshot.
> +	 */
> +	local_irq_save(flags);

The PMU overflow interrupt can be delivered as a pNMI, so this can race
with that. Disabling interrupts is not sufficient.

If this is only called within a perf event overflow handler, then we
already have the necessary serialization.

> +
> +	/* Save current BRBE configuration */
> +	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> +	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
> +
> +	/* Pause BRBE to freeze the buffer */
> +	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> +	isb();
> +
> +	/* Read BRBIDR to determine number of records */
> +	brbidr = read_sysreg_s(SYS_BRBIDR0_EL1);
> +	if (!valid_brbidr(brbidr))
> +		goto out_restore;
> +
> +	nr_hw = FIELD_GET(BRBIDR0_EL1_NUMREC_MASK, brbidr);
> +	nr_banks = DIV_ROUND_UP(nr_hw, BRBE_BANK_MAX_ENTRIES);
> +
> +	/* Read branch records from BRBE banks */
> +	for (int bank = 0; bank < nr_banks; bank++) {
> +		int nr_remaining = nr_hw - (bank * BRBE_BANK_MAX_ENTRIES);
> +		int nr_this_bank = min(nr_remaining, BRBE_BANK_MAX_ENTRIES);
> +
> +		select_brbe_bank(bank);
> +
> +		for (int i = 0; i < nr_this_bank; i++) {
> +			struct brbe_regset bregs;
> +			struct perf_branch_entry *entry;
> +
> +			if (nr_copied >= cnt)
> +				goto out_restore;
> +
> +			if (!__read_brbe_regset(&bregs, i))
> +				goto out_restore;
> +
> +			entry = &entries[nr_copied];
> +			perf_clear_branch_entry_bitfields(entry);
> +
> +			/* Simple conversion without filtering */
> +			if (brbe_record_is_complete(bregs.brbinf)) {
> +				entry->from = bregs.brbsrc;
> +				entry->to = bregs.brbtgt;
> +			} else if (brbe_record_is_source_only(bregs.brbinf)) {
> +				entry->from = bregs.brbsrc;
> +				entry->to = 0;
> +			} else if (brbe_record_is_target_only(bregs.brbinf)) {
> +				entry->from = 0;
> +				entry->to = bregs.brbtgt;
> +			}
> +
> +			brbe_set_perf_entry_type(entry, bregs.brbinf);
> +			entry->cycles = brbinf_get_cycles(bregs.brbinf);
> +
> +			if (!brbe_record_is_target_only(bregs.brbinf)) {
> +				entry->mispred = brbinf_get_mispredict(bregs.brbinf);
> +				entry->predicted = !entry->mispred;
> +			}
> +
> +			if (!brbe_record_is_source_only(bregs.brbinf))
> +				entry->priv = brbinf_get_perf_priv(bregs.brbinf);
> +
> +			nr_copied++;
> +		}
> +	}
> +
> +out_restore:
> +	/* Restore BRBE to its previous state */
> +	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
> +	isb();
> +	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
> +	local_irq_restore(flags);
> +	return nr_copied;
> +}

As above, this is duplicating a lot of logic we already have. If we
really need this function, we should be sharing much more logic with
brbe_read_filtered_entries(), if not using that directly.

Mark.

> diff --git a/drivers/perf/arm_brbe.h b/drivers/perf/arm_brbe.h
> index b7c7d8796c86..c2a1824437fb 100644
> --- a/drivers/perf/arm_brbe.h
> +++ b/drivers/perf/arm_brbe.h
> @@ -10,6 +10,7 @@
>  struct arm_pmu;
>  struct perf_branch_stack;
>  struct perf_event;
> +struct perf_branch_entry;
>  
>  #ifdef CONFIG_ARM64_BRBE
>  void brbe_probe(struct arm_pmu *arm_pmu);
> @@ -22,6 +23,8 @@ void brbe_disable(void);
>  bool brbe_branch_attr_valid(struct perf_event *event);
>  void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
>  				const struct perf_event *event);
> +int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries,
> +				   unsigned int cnt);
>  #else
>  static inline void brbe_probe(struct arm_pmu *arm_pmu) { }
>  static inline unsigned int brbe_num_branch_records(const struct arm_pmu *armpmu)
> @@ -44,4 +47,10 @@ static void brbe_read_filtered_entries(struct perf_branch_stack *branch_stack,
>  				       const struct perf_event *event)
>  {
>  }
> +
> +static inline int arm_brbe_snapshot_branch_stack(struct perf_branch_entry *entries,
> +						 unsigned int cnt)
> +{
> +	return 0;
> +}
>  #endif
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 8014ff766cff..1a9f129a0f94 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -1449,8 +1449,11 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>  	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
>  
>  	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
> -	if (brbe_num_branch_records(cpu_pmu))
> +	if (brbe_num_branch_records(cpu_pmu)) {
>  		cpu_pmu->pmu.sched_task		= armv8pmu_sched_task;
> +		static_call_update(perf_snapshot_branch_stack,
> +				   arm_brbe_snapshot_branch_stack);
> +	}
>  
>  	cpu_pmu->name			= name;
>  	cpu_pmu->map_event		= map_event;
> 
> base-commit: c286e7e9d1f1f3d90ad11c37e896f582b02d19c4
> -- 
> 2.47.3
> 

