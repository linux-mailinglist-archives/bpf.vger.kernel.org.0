Return-Path: <bpf+bounces-42945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD8C9AD481
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 21:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680CD1C22033
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4581C1D14E1;
	Wed, 23 Oct 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLhnYjtp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC3E14658F;
	Wed, 23 Oct 2024 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710377; cv=none; b=NS6Lh+KUVl9sP3EpnAa80/xRNd7bbiKx/t1nWROxrjlsCQ6Rw7YBSguOFLg9aPjqn7UhYRSK8REAz35pgy17wYpxr7TaJSUP+ev3j9XpAh61n417LhxJ+kdbWl1MxXadMmYsFM7G5JD55YH5a/dQ7FY2/StdZ6sp4F3IWfqq55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710377; c=relaxed/simple;
	bh=gWp4927ff/vjis/ydgB1oJFJZTwHRsCkZ3et52wPFDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ub/+xV4j2jrL8dJtldy6PgMt/J2jbSxFJ9jgrPurQml6No4e+utlgV0rWbJf7oj7H+zZtwjCtskjt4lWJtsp6mo1cHS5XIE041I/rwV+HY/mLU8mAtROOf4FD5MJ2fUYqOgUvdXTyfHty3bh6jgcXnBdpYDFM1jI05uj7+iJuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLhnYjtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35658C4CEC6;
	Wed, 23 Oct 2024 19:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729710377;
	bh=gWp4927ff/vjis/ydgB1oJFJZTwHRsCkZ3et52wPFDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLhnYjtpunpuAe7rDoNgI3v8Urfu6m5R6Bm6RXIQtnwKa7NUx7l1cX13yP1VPIA9p
	 +TxM+4/yhjT1zHxHeVbYwSQ8r0Zbb67xX6gLD+jZ1hJLm5eHWLtZd7ARbAh2jJdgCz
	 2Sm/4SLKB93+GZ/svJ+r0o6faeD5u/7VkLAfXN4gDzeGcGH8pLmUjAgVw0iICfNlPu
	 qsiW/tx2kvfZQjXa104pmCCMiJ7hiUC4wdtT7rXs6DmGwQN/JsDLACMhPXpQODzF5A
	 wrZL0vPK/sWfKobmwtrGFJ2lOcmBqd+k+m0kNtNZYvN2cRDDLGqm7x5+URxpn3R6L/
	 rUK2WDuIDyYUQ==
Date: Wed, 23 Oct 2024 09:06:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched-ext: Use correct annotation for strings in kfuncs
Message-ID: <ZxlJKC16Kp4aX6uL@slm.duckdns.org>
References: <20241021201143.2010388-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021201143.2010388-1-memxor@gmail.com>

On Mon, Oct 21, 2024 at 01:11:43PM -0700, Kumar Kartikeya Dwivedi wrote:
> The sched-ext kfuncs with bstr suffix need to take a string, but that
> requires annotating the parameters with __str suffix, as right now the
> verifier will treat this parameter as a one-byte memory region.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Fixes: 07814a9439a3 ("sched_ext: Print debug dump after an error exit")
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

I popped this patch from sched_ext/for-6.12-fixes along with the follow-up
fix. This breaks compatibility in a way which is difficult to work around.
If we want to do this, I think we should do it by introducing new set of
kfuncs and than phasing out the old ones. Also, it's unclear what the
practical benefits of the change are anyway.

Thanks.

-- 
tejun

