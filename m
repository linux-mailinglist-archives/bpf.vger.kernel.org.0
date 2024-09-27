Return-Path: <bpf+bounces-40390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B192988013
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 10:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B5C1F26AFB
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA3E1898EA;
	Fri, 27 Sep 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u2YBqcP1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3E189524;
	Fri, 27 Sep 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424664; cv=none; b=Nfmd6Rzys4sF2GPUazLeTw1adU5hMFxP+mD6lfgPZVW8Qxy9x8IxdqNYoLVqZ4IyY4D00nxE3x3UvJTtrXv/zaU477Id56sQb6okUEc9WMmqWE4qUKq2dOL3Ho5Vmq08uR3D4jAxoE0AqdXS+JIeyRQI72TjNqRSgbAVZ64sJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424664; c=relaxed/simple;
	bh=0wMiZ2baa2l/kVUX/vRu3bE6uPUvrLbMQvu1NbVnOaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ib0/rkhIKw9U1YuVR4p+ZCOSLtmbCQLSwv/dQhZi2gCZiE2QmNxZW3yXX39Ju+vvXZmYHnvI2NuMzP2u1PGyJal6FGhapg/cJKzROZ40ihnPsQiIgQd+54dqZKZ7l/mnXA/xrZUZEM72SZEnm4DTQDMaxn49iVxpXgbG4PMh8p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u2YBqcP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1847BC4CEC7;
	Fri, 27 Sep 2024 08:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727424663;
	bh=0wMiZ2baa2l/kVUX/vRu3bE6uPUvrLbMQvu1NbVnOaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u2YBqcP1D9+vchrrwaDQo+mWfcFZ8oe4u5vjON0+Svm5rUTBcYlq7RuXUsO6V7sl7
	 jjwISBRTZ3DtWhEWPoEuqci5QBD+6f1myz2sHf0ovyNzStg036p/3CEtUs9cD98Vl7
	 OjeaksT2scv+hz+xUaIRvfMBheNC9IHlDqr7BaVI=
Date: Fri, 27 Sep 2024 10:11:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Roman Gushchin <guro@fb.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH 5.10] bpf: Fix mismatch memory accounting for devmap maps
Message-ID: <2024092752-dormitory-getting-94b2@gregkh>
References: <20240920103950.3931497-1-pulehui@huaweicloud.com>
 <2024092737-flick-commodity-20d5@gregkh>
 <a27e36c6-bf71-40d8-85de-4797d764046c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a27e36c6-bf71-40d8-85de-4797d764046c@huaweicloud.com>

On Fri, Sep 27, 2024 at 04:03:36PM +0800, Pu Lehui wrote:
> 
> 
> On 2024/9/27 15:56, Greg Kroah-Hartman wrote:
> > On Fri, Sep 20, 2024 at 10:39:50AM +0000, Pu Lehui wrote:
> > > From: Pu Lehui <pulehui@huawei.com>
> > > 
> > > Commit 70294d8bc31f ("bpf: Eliminate rlimit-based memory accounting for
> > > devmap maps") relies on the v5.11+ basic mechanism of memcg-based memory
> > > accounting [0]. The commit cannot be independently backported to the
> > > 5.10 stable branch, otherwise the related memory when creating devmap
> > > will be unrestricted and the associated bpf selftest map_ptr will fail.
> > > Let's roll back to rlimit-based memory accounting mode for devmap and
> > > re-adapt the commit 225da02acdc9 ("bpf: Fix DEVMAP_HASH overflow check
> > > on 32-bit arches") to the 5.10 stable branch.
> > > 
> > > Link: https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com [0]
> > > Fixes: 225da02acdc9 ("bpf: Fix DEVMAP_HASH overflow check on 32-bit arches")
> > > Fixes: 70294d8bc31f ("bpf: Eliminate rlimit-based memory accounting for devmap maps")
> > 
> > Should we just revert these changes instead?
> 
> Yes, Greg. My patch is to revert these two commits and re-adapt commit
> 225da02acdc9 ("bpf: Fix DEVMAP_HASH overflow check on 32-bit arches").
> 
> Shall we need to split this patch into multiple patches?

Yes, please do so.

