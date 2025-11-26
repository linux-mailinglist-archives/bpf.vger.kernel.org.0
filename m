Return-Path: <bpf+bounces-75575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13004C89557
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 11:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 588CF348F12
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 10:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8848230BF74;
	Wed, 26 Nov 2025 10:37:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DD42E54CC;
	Wed, 26 Nov 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153428; cv=none; b=B3VhKt+yBN2tDwEFVJ/X7V1YMuKW/i28Besoq2XjkN3tsb7kYRNyMrc9kR0cP60HI64/77i8GvrUCYBwzoY/aVCOF0tiB81tU+WegaVn+dWwdRtiJO9/3zO7vXx6Sof9lq0F56zJt7IMmQ3eHsV3ZXMk+V7CTsfwVoy2LWViK0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153428; c=relaxed/simple;
	bh=ukBIqhXL124A1LC4/GYfmWEEH/Usi1jbg10qg9sUhKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK6oakTXA6UP3hG6il2sEGkLD4NNPbyY7f7rZIYUuU7bKMIbd59qc5mk2dP8Dcz+Midq5p5SrZ5Kypdg27UEKriNAtiI2oriBz10E5SFc5v+SERBXQmYfz2aHmGABTR72DysRVh06c8vA+V9Oegi8G0vLP16VR3Z/l3ye9vX+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E56676732A; Wed, 26 Nov 2025 11:37:00 +0100 (CET)
Date: Wed, 26 Nov 2025 11:37:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	bpf@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH V3 4/6] nvmet: ignore discard return value
Message-ID: <20251126103700.GA28056@lst.de>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com> <20251124234806.75216-5-ckulkarnilinux@gmail.com> <e40cb47c-9f92-4982-bf3f-45ec9f2a1681@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e40cb47c-9f92-4982-bf3f-45ec9f2a1681@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 26, 2025 at 06:14:32PM +0800, Yongpeng Yang wrote:
> We also need to check for memory allocation errors in
> __blkdev_issue_discard().

No, we still don't.  What is so hard to grasp about mempool allocations
even after repeated explanations?


