Return-Path: <bpf+bounces-49876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F01A1DC31
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 19:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117FF3A4F72
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 18:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1716718D649;
	Mon, 27 Jan 2025 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuYHIaqU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C667DF59;
	Mon, 27 Jan 2025 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738003535; cv=none; b=IXt0ESHvs9xTGJ2UR8sC96RVcHO8n2lqYpqrUoeiqEZhVC1tsAKXh8+OrVXy7OZ4JbqO/ASXUuaCjFfZ6FheULWTm74tW1LvcV8N/0/yiQ64F1Qo8pYz2728V3BmtTBBJpQ0tzL5E1RkNq1bdqA1nTucwAlAg1Cxzzkbdn8eoGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738003535; c=relaxed/simple;
	bh=jnDmEpSDq0PFVPbXiepfrCbTdyRWCuwp/qraR5xQEwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHGykOmr9iKUjFJ+EpvbcRhQtwZscdH5orHas+wb8t/jJCeIzIZZ3kR1PUp5RV99GqnnWJK7mriWZjdQfXk2z4+9iHkohlfNTnCWd+l0fkN64eTB1z1e5Xrd74bV39LNtBfcxQ+qWEoKrCuXzoeDVGp1+JA8aBWyoQb+Q2I3AUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuYHIaqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09EBC4CED2;
	Mon, 27 Jan 2025 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738003535;
	bh=jnDmEpSDq0PFVPbXiepfrCbTdyRWCuwp/qraR5xQEwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuYHIaqU0wmoFSAtaaACtFGNWox54BRfIDa997YKtRsQcw+6Yf8w/oSyvbDvetJuN
	 7+6OEbGmyScv7bQYzcny33dploz83URG3f0hgJ6C73p6c1a8h3c1B4Niop1RDIlUxQ
	 FO7J7jhP2aygeu80SuZfScBO8STQT1eKuH7JaxEEEqBV65TpFmLgptT+sL7tK9xIJq
	 2Mk0T1eF2TqU0Rmsav/63AbLLXmc4BBuowqGHVZW0KGSymK3LbJIYGS60DIzhX56I0
	 CwP65Xq5jCuPO0bW/EahLWxZ0+sfsPic+zSIaDowupKiL+3Q7hTD9kYgPRXBQTFOOB
	 Z21quFJDQqZwQ==
Date: Mon, 27 Jan 2025 08:45:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, sched-ext@meta.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.14-fixes] sched_ext:
 selftests/dsp_local_on: Fix sporadic failures
Message-ID: <Z5fUTUMVlbkvcvhs@slm.duckdns.org>
References: <Z2tNK2oFDX1OPp8C@slm.duckdns.org>
 <QHB1r-3fBPQIaDS8iz26J-zoMbn3O6VLlwlZP1NQdkMzlQTsCX_xrfTPBoGt6SQOGgtg6vN7aXles4CndepTvjIVQ7bVXDBrvPaiRH5R8tc=@pm.me>
 <Z5BMkyJ8I7cth1GH@slm.duckdns.org>
 <m94EAn-xiPWJ1dRFTqcm6urBNNOPza94BmyYvp_5ti06uAZF0Izg2mBC9rpbc3PEfWWvDf7UyDt1x_2gB-7y3esTH3f54s05QBxcTXh4YhQ=@pm.me>
 <Z5IOpOD9cs2fLaIg@gpd3>
 <Z5J1Ft2YwSRpedzx@slm.duckdns.org>
 <Z5KOLqwLq96HjkwH@gpd3>
 <Z5LCHVHZPl2fjPyc@gpd3>
 <Z5QNhsWw0P1iPd2q@slm.duckdns.org>
 <Z5Ruf3o2f4sC0J5N@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5Ruf3o2f4sC0J5N@gpd3>

On Sat, Jan 25, 2025 at 05:54:23AM +0100, Andrea Righi wrote:
...
> > -	if (p->nr_cpus_allowed == nr_cpus)
> > +	if (p->nr_cpus_allowed == nr_cpus && !p->migration_disabled)
> 
> This doesn't work with !CONFIG_SMP, maybe we can introduce a helper like:
> 
> static bool is_migration_disabled(const struct task_struct *p)
> {
> 	if (bpf_core_field_exists(p->migration_disabled))
> 		return p->migration_disabled;
> 	return false;

Ah, right. Would you care to send the patch?

Thanks.

-- 
tejun

