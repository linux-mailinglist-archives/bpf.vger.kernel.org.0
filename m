Return-Path: <bpf+bounces-75317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C14C7F0FD
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 07:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95E394E382F
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 06:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A43B2D663B;
	Mon, 24 Nov 2025 06:30:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405462D5C67;
	Mon, 24 Nov 2025 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763965817; cv=none; b=YCAS+61xzpspYd6K20tXgXuTLghmiS49m4YNR7J8NG6UbHG57nt6bi5exe27EJA9Gj5AWN70rvWGPYyqo0Gn+/cRaA6k/SJuYX6zt0YR3ZBbWFJ5rkOpW8l7p1wVnpdUPutriDRO/9Cbhbnqef7aPkpq4JmGQP0LPEJ67huzsZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763965817; c=relaxed/simple;
	bh=WIVG4JvopaUAhb6ikTuILxILFdoaTMcY/q5G1Hl4Ync=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeHO1aJ5OjHi5bW/Kk8AO9I0tgr0e3/3Y4VkCdKWMQmGT8sqSAoraBGrXtawZM6zSLf3mIrSU+pPBpe5FIEgUCyEd5l7e0Uo2tC8VOY1GtahPue0jVCZUYVQiEl16vs0Rr+bXxSy5gOsJslklHvyh05NY1Xxbwds+SJjt/Xfl0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B44AD68B05; Mon, 24 Nov 2025 07:30:11 +0100 (CET)
Date: Mon, 24 Nov 2025 07:30:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
	mpatocka@redhat.com, song@kernel.org, yukuai@fnnas.com, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, jaegeuk@kernel.org,
	chao@kernel.org, cem@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH V2 4/5] f2fs: ignore discard return value
Message-ID: <20251124063011.GA16808@lst.de>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com> <20251124025737.203571-5-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124025737.203571-5-ckulkarnilinux@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Nov 23, 2025 at 06:57:36PM -0800, Chaitanya Kulkarni wrote:
> +		__blkdev_issue_discard(bdev,
> +				SECTOR_FROM_BLOCK(start),
> +				SECTOR_FROM_BLOCK(len),
> +				GFP_NOFS, &bio);

This can be shortened a bit as well:

		__blkdev_issue_discard(bdev, SECTOR_FROM_BLOCK(start),
				SECTOR_FROM_BLOCK(len), GFP_NOFS, &bio);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

