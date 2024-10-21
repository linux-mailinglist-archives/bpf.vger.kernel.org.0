Return-Path: <bpf+bounces-42673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBEA9A9086
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 22:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748CD1C21B88
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5D419E968;
	Mon, 21 Oct 2024 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZq7KagU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607811C7B68;
	Mon, 21 Oct 2024 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541011; cv=none; b=j1RTtmRo0jXcmb7eABzDJfYPd/e7NsjlfKZBEpp7TZrXnHRC42wC+Za7xyS7CueObNhmGOwlFPXzvJesrDwbLJB/Yk/mvoA6JKsTuRS/P6jED66kke1QhtYAA8uzan1VVMy8VAOI9vGhkpcMBN1XLpRgEaOjxYiooAW2jMf/eeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541011; c=relaxed/simple;
	bh=sD10DBlg01qhCNJYHcQ+IAgWJ459cwJbzGBdUa+jktY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGP5HgutuENUi22ZWuANFYlBxCc3QGMldrMqt17u0GjHILwSVaxP6PD+l5+ujHyUIqpL+tZzOqc730sjp+k7oTZTMOo9DTH3h8lL8QVTdi3lvF/JRmbfZFO+czcywrfyfap8hrt8+UHN+32OPMJ2WT+dC29rczw9GeUZjs2SY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZq7KagU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBF8C4CEC3;
	Mon, 21 Oct 2024 20:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729541010;
	bh=sD10DBlg01qhCNJYHcQ+IAgWJ459cwJbzGBdUa+jktY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZq7KagU5Pmzy0HRTHRadL54AZsH5ZmDbsiHaSoZ4povYXXZGFAb3oFzzThKY7+Kg
	 D39wS9/GdSbYOcAOhKke7v58NlLzfErNKTsGkDIbYqQ9gWfy95vLEg3Tk+zUX7HPEJ
	 TwpmY5+fITc+3o+lythfjAWUERqX4uxgCj4cNCnQ6aAFPU/poscFNGAHvuN/Lg5Wpj
	 AKJ7dQ8FtcQgf93kemOm3mW2wqBTa1pbb45Icx/upwmJxQoA9FTKWC6M10CEMrEIcA
	 i7xMlMpsZIXqS1X+DRRT0LFzsXOfSKXHtRux27+e9sQKS2oJHTleYz3JFehfu79ZUz
	 Y/SpBn39M+IBQ==
Date: Mon, 21 Oct 2024 10:03:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	mkoutny@suse.com, john.fastabend@gmail.com,
	roman.gushchin@linux.dev, quanyang.wang@windriver.com,
	ast@kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v1 0/2] Only cgroup v2 can be attached by bpf programs
Message-ID: <ZxazkW-OcK_nSqYg@slm.duckdns.org>
References: <20241018081520.694139-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018081520.694139-1-chenridong@huaweicloud.com>

On Fri, Oct 18, 2024 at 08:15:18AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Only cgroup v2 can be attached by bpf programs. This patchset reverts
> commit 04f8ef5643bc ("cgroup: Fix memory leak caused by missing
> cgroup_bpf_offline") and avoid cgroup_bpf_inherit and cgroup_bpf_offline
> being call in cgroup v1.

Applied to cgroup/for-6.13.

Thanks.

-- 
tejun

