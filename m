Return-Path: <bpf+bounces-47599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3AC9FC289
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 22:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8827A132B
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 21:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E68196D8F;
	Tue, 24 Dec 2024 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqIHC793"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83F16DEB3;
	Tue, 24 Dec 2024 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735075263; cv=none; b=Ta0xAGk4WW8pvFvULTRFatQEsZwsya+BFsMr1NU0ytacCQmibNt+N7wLCzjHnND/NoSX3sJofdkDlS4a/SIaKG6vUWasOSBLvBDgvDDi4sX2I7r1L8NpPVdzeVzW/2MuZo1aAbQC2tbpusYPAnuZwAvvLTXdwg87FRIyQxnzsyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735075263; c=relaxed/simple;
	bh=gbnRG1PkESeqDZOIOYur8y4oQWN845gud9D+xu5QWtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnAsuQPdYLBmbdSa6t8+eZVHJYVra/FthbhdZWA/SWvoYlS+slnSkcrgyYuquh2oC9eT08WIeMSOtCLAGtDqAFIXHEK0LRbXfNeqPZ5lgdfATr0KAT4S21GK6aQEausLBYdKeTZP/iMZKvDsqSRojy9SdI9tqYeSOhUqVSbyy5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqIHC793; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19ACC4CED0;
	Tue, 24 Dec 2024 21:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735075263;
	bh=gbnRG1PkESeqDZOIOYur8y4oQWN845gud9D+xu5QWtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mqIHC793Al+XFdjPJZRgdFd691Z3nogvBCxQEQ8v7zpaUfMO7AamDmCAOwoHNoP4x
	 UrZtSwKW7QBGa3W9KW5GYLgn2LQadVrdgwiLW9d63Tda6p7rnaJVALWLsRTYFP412B
	 rZI/E45c/8XTxSsv4v7IVVcLphHLDgdwUB3EZIVDKOOAsX8I2cJSO1oJ+KG5nMcZIi
	 UZWRFTUnk0cL+wNdjcmGHyL1Tdpva2XTAcOW99gZOk4t2KXWiRQdhQj0Zdam++oYS6
	 D93MkQvUBZBKK+dqughvfNNvqzYr2doSlvcxONg7HCvLofxm84JNyaxROR94Ew/m1f
	 z5CvyHoOPNVeA==
Date: Tue, 24 Dec 2024 11:21:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] sched_ext: Move built-in idle CPU selection policy
 to a separate file
Message-ID: <Z2slvawqXMplUBow@slm.duckdns.org>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220154107.287478-3-arighi@nvidia.com>

Hello,

On Fri, Dec 20, 2024 at 04:11:34PM +0100, Andrea Righi wrote:
...
> +/* Built-in idle CPU selection policy */
> +#include "ext_idle.c"

While it's true that sched is built by inlining all the source files for
build performance, I think it'd be better to keep source files compatible
with independent compilation units as much as possible - ie. put interface
in .h and pretend that .c's are built separately so that we can maintain
some semblance to code organization people are more used to if for nothing
else.

Thanks.

-- 
tejun

