Return-Path: <bpf+bounces-75315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996A6C7F0C7
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 07:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BCA3A590C
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 06:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB42D2490;
	Mon, 24 Nov 2025 06:28:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143026FDA8;
	Mon, 24 Nov 2025 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763965680; cv=none; b=kAUFZG5OZHZ6Kq8Oi25IGiDacelCXVKGSob1v3CtMylw+jGWgZdITbvuzrLyt/upm552MVrETgR+Pnz5OylRPSrMvDZT23OaecN2MRY5U1SS8kGgyl+ciSfXv/HrkE9lfMManiHM/qfsTa9zEDloDBGrHKQkDbVLio0rNAdo0ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763965680; c=relaxed/simple;
	bh=BsuXYppzHhMWNMF03oT3P8lKKTAnmJIXsUzVEvjOdiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTIEHuDbFcThtqqXrpC6MYr+/GxjxS4u26GJ9kunGSqhiKC8TWTPb79t8vqVrA+QGE4NMstbsHi8ha9pHkK5p8nw/06EsdgPkk7PUuyeSBmFzfX6PIIgWNu2cMFwemyO7BAVt1a8C6YTpwS+jXEKD1Z4G7XiyR1KlPqtoOOSrXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A37968B05; Mon, 24 Nov 2025 07:27:54 +0100 (CET)
Date: Mon, 24 Nov 2025 07:27:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai@fnnas.com>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	song@kernel.org, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH V2 2/5] dm: ignore discard return value
Message-ID: <20251124062754.GB16702@lst.de>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com> <20251124025737.203571-3-ckulkarnilinux@gmail.com> <d86b820a-46c9-43b6-9fe2-dbd991b76520@fnnas.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d86b820a-46c9-43b6-9fe2-dbd991b76520@fnnas.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 24, 2025 at 02:24:05PM +0800, Yu Kuai wrote:
> mdraid and dm are different drivers, please split them.

Yes.  Both parts looks fine to me, though.  So:

Reviewed-by: Christoph Hellwig <hch@lst.de>

for the next round.


