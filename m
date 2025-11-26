Return-Path: <bpf+bounces-75573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 726ECC89518
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 11:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1274E4E458C
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 10:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9AF31A81F;
	Wed, 26 Nov 2025 10:33:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF37C2F6188;
	Wed, 26 Nov 2025 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153217; cv=none; b=o6kl8DP+6YWswWBg5PL1Xx19MPNbeiZFGTWXtlFID667oAcLqOCbY9kfgu2DVAYlDrni0J5rwVu8nrbzkng2gn5nhYgA9zITJFb3LTdOgxM0qc5xlpsII2JErWvlDT0Nh7mVVP/C4W9Sx1GxGBPe9iMPZJ+R0odm2sV9Qau6Ouk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153217; c=relaxed/simple;
	bh=XLY64ehmipVyzEFnEB41AwP+0BgCfBS7Y2jrR4GUubs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOclur6YnoIiLWwEbZmTIXrVdbHZEVrn0u5pQdLeenTvRrEFSFZ8dxEUbN9wRw8+1XHdCoQ/rxUscoRmeDlyZxQL2kNPP/qo++zITr4j2/8P2kV6DNRSppiSquHikHn7fiulAalDGw69L71RuZDZJK7YFCJ7z/IkM63rC7t65uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3FC8868CFE; Wed, 26 Nov 2025 11:33:24 +0100 (CET)
Date: Wed, 26 Nov 2025 11:33:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	bpf@vger.kernel.org, linux-xfs@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [f2fs-dev] [PATCH V3 6/6] xfs: ignore discard return value
Message-ID: <20251126103323.GB26228@lst.de>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com> <20251124234806.75216-7-ckulkarnilinux@gmail.com> <b18c489f-d6ee-4986-94be-a9aade7d3a47@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b18c489f-d6ee-4986-94be-a9aade7d3a47@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 26, 2025 at 10:37:10AM +0800, Yongpeng Yang wrote:
>>   				xfs_gbno_to_daddr(xg, busyp->bno),
>>   				XFS_FSB_TO_BB(mp, busyp->length),
>>   				GFP_KERNEL, &bio);
>
> If blk_alloc_discard_bio() fails to allocate a bio inside
> __blkdev_issue_discard(),

It won't, because mempool allocations will not fail if they can
sleep as they can here.


