Return-Path: <bpf+bounces-67049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A854B3C606
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 02:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA66DA639E5
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 00:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180774A32;
	Sat, 30 Aug 2025 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze7hvBCo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49A38B;
	Sat, 30 Aug 2025 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756512571; cv=none; b=Dn7Ht6llc2kHNtIMyNxgcB3EfRo5xAQGDxLl7MncgrpkeCpuP7QN9B1oRfiJyuBA4hD033NxHOZ/X0PtCa7YSRETNpd2EpUtKx2RrufJk+/lAGmtqyHpWmpjaSwPahGe4WGgsTUpryvKUbv1llawPOSpEKHulBGSIdpasvbrFFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756512571; c=relaxed/simple;
	bh=Q65X842gmGha/sTM4YHLDwsWn6jiBB9jsK3aMU9HN2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCFQoqAfc2YfHgsr1vg0nYO/obaV5Oz19kUOgy7xPctf5iAoZlFbxuWuJqQkoENFOmx7Pr6aOpsokbJI94HH+aKs0U5CgVQBZ3qjFJ5eRXtFiqV+6lsWGgJS0XkUZdQDQrqIdhv52VP3B95J4H9n4xCOxUgRD4cpRJblZjc8BnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze7hvBCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88786C4CEF0;
	Sat, 30 Aug 2025 00:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756512571;
	bh=Q65X842gmGha/sTM4YHLDwsWn6jiBB9jsK3aMU9HN2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ze7hvBCo5pzZJ3siNveNh6IcVjIBFv+HBfco20INHlqGvP0OwtFIHEhbHnugeY3cr
	 G4qkX3l3nzczCWjE+9sSCtDyMvbJedmaxvFKczUxnXyFQ4krp/xQPojPs86JXtsGaZ
	 AoRJifB0dUOpjgdTcW6AV0db6QPz0H44pecVN2qgA5I7r7YqIuySIOT3VOJwbcYnrB
	 VwfjYIWiLOeHlYavOmX0+jjagj+WSYHKB4AoVuvG8SP17OszL/vpBMVB4qlLHNSAx4
	 MXo68tv/+/W9YmDffOgxGO0WuzqX6UPHrxCB+uJ0UJkA/GiNQU24FzNMoepSUDDpzE
	 sQEO52C4glE2g==
Date: Fri, 29 Aug 2025 17:09:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: Nimrod Oren <noren@nvidia.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, mohsin.bashr@gmail.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maciej.fijalkowski@intel.com, kernel-team@meta.com, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
Message-ID: <20250829170929.28cfac72@kernel.org>
In-Reply-To: <CAMB2axPpaoDfFEBzNTaTjp4GnFKtWy0k-sTez56ap+FBZzLFeA@mail.gmail.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
	<7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
	<CAMB2axPpaoDfFEBzNTaTjp4GnFKtWy0k-sTez56ap+FBZzLFeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 00:26:29 -0700 Amery Hung wrote:
> > I'm currently working on a series that converts the xdp_native program
> > to use dynptr for accessing header data. If accepted, it should provide
> > better performance, since dynptr can access without copying the data.
> 
> I feel that bpf_xdp_pull_data() is a more generic approach, but yeah
> dynptr may yield better performance. Looking forward to seeing the
> numbers.

To be 100% clear, being able to push and pull custom UDP encap headers
(that the NIC may not even be able to parse) is one of the main use
cases for XDP, for L3 load balances. dynptr may be slower or faster 
for reading and writing to the packet, but it can't push or pull.
So this is a bit of a side conversation. Sorry if I'm stating the
obvious.

