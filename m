Return-Path: <bpf+bounces-56272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E03A9416A
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 05:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CE38A55A8
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 03:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBC212D758;
	Sat, 19 Apr 2025 03:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRq7Apug"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C15475E;
	Sat, 19 Apr 2025 03:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745033329; cv=none; b=hsucU2vEMEbpkYxMM8DUoNpXcxy6avk4fQHQN+nlOkXgBGgtT90KXQbOXVHmcQCFuyyRjGTND1MqGGnoTIfkgqHS1p/ibhS7pLw/aBOZPKlfbWm0ptSV4IF1KccNtrtqfgXY1AeIqr+oMksm/bmTYlBXfjz9dNvwT3jkxGYOvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745033329; c=relaxed/simple;
	bh=grYkpy13uvTbL4jpygETR+16CED7VC9/nzFQH0bCwUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo4VTrG1ZTT8lzm5uzl8CPlDnQoQtqWAorcPx+P8j336HwS2CUKyVecOfxjbmoSld2eEdNjwB0GRpP1uWRg/keRYDURZYrIKSwsNUKP1VbR3CY4MOpwkmenhuZYYQyPlt+Xf+g9UPL2SLHCikfQ1LjwqYrSY7z4fwwDgR4F5Xk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRq7Apug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD48C4CEE2;
	Sat, 19 Apr 2025 03:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745033329;
	bh=grYkpy13uvTbL4jpygETR+16CED7VC9/nzFQH0bCwUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRq7ApugnOofrz3zLoTZ0Jf3UYqbu7Zj+osD6ZRLo0k5ckvckaLvSNLHAhe1/uMA0
	 hSP1MggiktkdSBSvjhLvbBnxYwW8mmBIy6AuvhCVE5nm54xhVtKG21VKi1caJCWs+6
	 kOhQhMYXKl6cxWkvifcsq1wuUMuVLq5Suppptrb3xz2s2ya0V5BBpiCCPFvz4vlgTP
	 T6ADfbEdFneSosgfRJ5WYzdWj+vMB9xh6sF0ORhcWqFpF2isdBaOGJwVRmEdMw1wWR
	 IzdlL5+Sp8fh9nufWVYfIoN0cOqC4p56IrQyamw2u2tHLyw2H/2+AJ9waHic6Yca3+
	 v8CS1S5L2oKFw==
Date: Fri, 18 Apr 2025 17:28:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Honglei Wang <jameshongleiwang@126.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, joshdon@google.com, brho@google.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/2] rename var for slice refill event and add helper
Message-ID: <aAMYcL-AnobJYjeU@slm.duckdns.org>
References: <20250418032603.61803-1-jameshongleiwang@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418032603.61803-1-jameshongleiwang@126.com>

On Fri, Apr 18, 2025 at 11:26:01AM +0800, Honglei Wang wrote:
> SCX_EV_ENQ_SLICE_DFL gives the impression that the event only occurs
> when the tasks were enqueued, which seems not accurate. So rename the
> variable to SCX_EV_REFILL_SLICE_DFL.
> 
> The slice refilling with default slice always come with event
> statistics together, add a helper routine to make it cleaner.
> 
> Changes in v2:
> Refine the comments base on Andrea's suggestion.
> 
> Honglei Wang (2):
>   sched_ext: change the variable name for slice refill event
>   sched_ext: add helper for refill task with default slice

Applied to sched_ext/for-6.16.

Thanks.

-- 
tejun

