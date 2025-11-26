Return-Path: <bpf+bounces-75574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC0CC89548
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 11:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72B25358CD3
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1CB31C567;
	Wed, 26 Nov 2025 10:34:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA1E31B137;
	Wed, 26 Nov 2025 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153253; cv=none; b=HWK4O++UsMVL6TC0zDJ1RECBDy4QIPs1+CyNaKWjZIp3pMVjEOPQB+sjRrMn5z9lFsZu4BZohecqGBt+y6tD+4qNtiXS64x9ukC+nnLX1URiVU5SZfsN8pmFwInqdlw6HUkdOB9Y6mCOZoxxqcCu9MUP2yPLHB4ZD7YqitJ/c4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153253; c=relaxed/simple;
	bh=5DqQpJxCWRGjTCWBnCKukPtWgMg6rSODdCIUzico59w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiHXNYZD5tduCygyH19O3POskrvTzEEGY8XxIJ6woHzzVrN3A5zXlHJBngoNKTfFTwdlDDSe2C1ScQU2rlAKG6kC7e6Wtx3qEAX6u3715BP6Q4ezDRuwo1lyC+0rENE92nSpp9DcJ7wk4ef+DcV1Zgs8s9+MppJDFtP+CAd3+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9137668C7B; Wed, 26 Nov 2025 11:34:08 +0100 (CET)
Date: Wed, 26 Nov 2025 11:34:08 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"agk@redhat.com" <agk@redhat.com>,
	"snitzer@kernel.org" <snitzer@kernel.org>,
	"mpatocka@redhat.com" <mpatocka@redhat.com>,
	"song@kernel.org" <song@kernel.org>,
	"yukuai@fnnas.com" <yukuai@fnnas.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"chao@kernel.org" <chao@kernel.org>,
	"cem@kernel.org" <cem@kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [f2fs-dev] [PATCH V3 6/6] xfs: ignore discard return value
Message-ID: <20251126103408.GC26228@lst.de>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com> <20251124234806.75216-7-ckulkarnilinux@gmail.com> <b18c489f-d6ee-4986-94be-a9aade7d3a47@gmail.com> <218f0cd0-61bf-4afa-afb0-a559cd085d4a@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218f0cd0-61bf-4afa-afb0-a559cd085d4a@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 26, 2025 at 08:07:21AM +0000, Chaitanya Kulkarni wrote:
> The retry for discard bio memory allocation is not desired I think,
> since it's only a hint to the controller.

Yes, it is.  The command is defined as a hint, but it's required for
a lot of workloads to work.  It's not just a speculative readahead.


