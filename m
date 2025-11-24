Return-Path: <bpf+bounces-75316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC236C7F0DF
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 07:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 886454E26D1
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 06:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830A72D2490;
	Mon, 24 Nov 2025 06:29:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12631B532F;
	Mon, 24 Nov 2025 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763965741; cv=none; b=iojUJ4kpju9HWTvv/w8a4frsoMzVPHIHlV4sJzhK1Kcrl5nC0k0QMXZZ4F7xOopARtWxbj0iNJvQEyb04/OUavLUw+8yxYSwkcakDjvrA3LuLboRCL6/6W7ilDPwImQIFdoW6DuJbQFisOtiw4MDdz8+t9tn6lUyrDHg9wAi9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763965741; c=relaxed/simple;
	bh=JCZkenvINcYp7DAr1tHSrS84c6l5AlHV8Lsy5kyAGPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWu65r59ms59DtYdtKlM8feLZZWb8Bz3NGcxHMQXzauqU5GC+vboUKBLETnNr4nMegJD4L81ppZ71Pttqg/O4ue/UbzD/h3OdEZLDUhopObn5ZAScbNpT16nWPqb20fUwJsFq4CCeDatU/V3803Iw1LUBKxDc0KP3+KKyeZV/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3976468B05; Mon, 24 Nov 2025 07:28:56 +0100 (CET)
Date: Mon, 24 Nov 2025 07:28:55 +0100
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
Subject: Re: [PATCH V2 3/5] nvmet: ignore discard return value
Message-ID: <20251124062855.GA16765@lst.de>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com> <20251124025737.203571-4-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124025737.203571-4-ckulkarnilinux@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +				nvmet_lba_to_sect(ns, range.slba),
> +				nr_sects,
> +				GFP_KERNEL, &bio);

This can be condensed a bit to:

				nvmet_lba_to_sect(ns, range.slba), nr_sects,
				GFP_KERNEL, &bio);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

