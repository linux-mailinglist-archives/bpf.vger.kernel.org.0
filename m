Return-Path: <bpf+bounces-49688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE93A1BBFC
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 19:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3344016CD71
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 18:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C811FDE1B;
	Fri, 24 Jan 2025 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuXFIbXe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99119005D;
	Fri, 24 Jan 2025 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737742817; cv=none; b=dVJUxaFI3HEiZmMiMfAVwRlCcIbC6zINg3Zts3Te0HI23n2noUWqXT4BUb8PSM25e6te1YI3v3d6TXD7XXyXJeDzX8KwZ8a2Ib8TdXeh7StYs+/51pwrXpA4J0AJVpZBegNlk2sdmVEPj2Gv9Tmbc0nQpKOr8rIiwjt+t8sRgPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737742817; c=relaxed/simple;
	bh=MBn5w6ynUcZEg9gZKJq0cPfCoQz3jVB2+a9ZfzeJRGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8qQzU7JbnFMX+UxSi3fDSmec7te+RYT7OUV4mMIsrmZZ4TDZjyPUjzwKAzj8+eLIxLj2jbQfcs4N2B48b+0FQ3mz/TySCw8JKtIEO3lzib2NDY3JPJ7EabgqQau9TPVyrzgufVF2+LUCw6vSll6owL+5OLfPlFHpV8eIFnWdo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuXFIbXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202CBC4CED2;
	Fri, 24 Jan 2025 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737742816;
	bh=MBn5w6ynUcZEg9gZKJq0cPfCoQz3jVB2+a9ZfzeJRGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuXFIbXe4CLv3suygY3Eg/TW4Gt1e9AgwQwCD54PMimHpiZqFjFiu/i1FqCpvH8rE
	 N8+Cf/8RidjHHWMjpvJltls3IyZ63S0edqTb9T+8bkLmlswTZrBcShrVSK/iXmZqD6
	 MEmdme4k4yhrQDKnKHoLmimrQu7E++g71+IeN0CQuJNY4849weHC2n+9NSSKivUd5L
	 YW1hCgsVrTxfDh5a0bkoDOz2a3iLpvj9lnbsZCBpzp54W+ZUWgjZj8BCtqoCZtruAV
	 shuu0hbiq8Yp50+ZCSSWuQ1otTQlvAMdTDfvOel8cv/vcB5F26VS1FpYgsYPQvZ/+S
	 s2BKjRptDfIOw==
Date: Fri, 24 Jan 2025 08:20:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.14] selftests/sched_ext: Fix enum
 resolution
Message-ID: <Z5PZ3xaywu5Fo2Vr@slm.duckdns.org>
References: <20250123124606.242115-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123124606.242115-1-arighi@nvidia.com>

On Thu, Jan 23, 2025 at 01:46:06PM +0100, Andrea Righi wrote:
> All scx enums are now automatically generated from vmlinux.h and they
> must be initialized using the SCX_ENUM_INIT() macro.
> 
> Fix the scx selftests to use this macro to properly initialize these
> values.
> 
> Fixes: 8da7bf2cee27 ("tools/sched_ext: Receive updates from SCX repo")
> Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
> Closes: https://lore.kernel.org/all/Z2tNK2oFDX1OPp8C@slm.duckdns.org/
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.14-fixes.

Thanks.

-- 
tejun

