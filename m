Return-Path: <bpf+bounces-75424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1163C837E4
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 07:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16E3334B611
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 06:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F13529D27E;
	Tue, 25 Nov 2025 06:34:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D465295DBD;
	Tue, 25 Nov 2025 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764052450; cv=none; b=cwRpkTtp9Nekdy/6N2uyngREuhvYuL9ks+my9YGmFufn9gYN4tLGIk2Zb1WRKB2oQW6S/VGZw/EslyjuW9AyryUGCUHkzklVfOzPc7Gu9UyKfGOokDDjO6xjz18Bb24PJtH9XKPUew1vbiH0FDBTKh1yWgfyHnWjaVx7FmQLDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764052450; c=relaxed/simple;
	bh=ja/dybNRZjiFc4BwhelBUXC1g5mym/a7FtVQoXLnDWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfSTO7OFJNdrGwJce2EUB3+CtrIYj6U8ttnSBQsShLlMnRUOvWtk+IkM1lNYcZjgyq+7xqMwoxLa4Qu5fszp+SbXK04N9M8ZNkMRZkWLtWaz1KqV9Dam5BePYP6gWW3fRIrSxQ7NNdyeiZJTmtLGL3petF+7niFlfQ6K97+Gd5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA0A868B05; Tue, 25 Nov 2025 07:33:58 +0100 (CET)
Date: Tue, 25 Nov 2025 07:33:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chao Yu <chao@kernel.org>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, jaegeuk@kernel.org, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH V3 5/6] f2fs: ignore discard return value
Message-ID: <20251125063358.GA14801@lst.de>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com> <20251124234806.75216-6-ckulkarnilinux@gmail.com> <9c8a6b5f-74c8-4e9f-ae46-24e1df5fe4e0@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8a6b5f-74c8-4e9f-ae46-24e1df5fe4e0@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 25, 2025 at 09:10:00AM +0800, Chao Yu wrote:
> Reviewed-by: Chao Yu <chao@kernel.org>

Sending these all as a series might be confusing - it would be good
if the individual patches get picked through the subsystem trees
so that the function signature can be cleaned up after -rc1.

Can we get this queued up in the f2fs tree?


