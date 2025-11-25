Return-Path: <bpf+bounces-75425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2750C83AA7
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 08:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E173B0F2E
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 07:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EA52FA0DB;
	Tue, 25 Nov 2025 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRW5r56j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0172D838E;
	Tue, 25 Nov 2025 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054716; cv=none; b=bdsEJVDXnLB/eGB++yQ6SPC19TJRfRgKMbFDTduFKYdkh3dCM35up0uJRLEKdRyNArtA2YjmDHhTskzIOlyzFfwPDPeYAhIzvL39Cu3UyVt/Kq0jboc9zaq1DpFl9ApIOw4MVK4crdqVwjNN3ZgXgqYSkD+cYqIMamPI0i45mr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054716; c=relaxed/simple;
	bh=xflNeMqf7k1tQ8p2f9Vf/KT0VAo9WTDVCCFoPk6I900=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZL7uILjyrulsuty3d2j5/i0iskabaGEehkM2SNzF6DPgznKzU5Go470rtSjasXEOml+AWafqEv3mD4KeuJAZ2R9RLmBYf8Q94kciAL2YL8COUkDjRZfVF/W/+7fBSAfH4pvdVSFcAAkmhinSJJXFckAoo4nHXliDNMeVEGR7k64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRW5r56j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CDCC4CEF1;
	Tue, 25 Nov 2025 07:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764054715;
	bh=xflNeMqf7k1tQ8p2f9Vf/KT0VAo9WTDVCCFoPk6I900=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=vRW5r56jcgqXMxVPd0wuo6Asj/WFwwlD1sbbJn+TM5uvyv+LFWmulSpnq8gsEcoDB
	 9xM6Mo7+lurS8TbEynkUIWlNAssF1pYUcO0AklxAJ+AAiZl5seSlhrDuq68Kq/O2cn
	 cHh+bXZftIVMPHCe7c9IY57WuTMskj05VfhK5sKqpFNxgsSia9lA6h97quJQs3MzpF
	 T7eu7PHpjPa3mU7joudmxeoqPhsF+fvS6NPNj3DVzheWD1k8VSZpn7yTtlVBZCuOvs
	 aF8wrighi/0KfXj8IFm/XZmSEbiYeHktZXuy5rGJEVPsAvPHwmWoCB41m7uEAJI68x
	 uy5QFKvIGSBwQ==
Message-ID: <8e98a473-7991-43ae-a758-8ad324bb9393@kernel.org>
Date: Tue, 25 Nov 2025 15:11:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 song@kernel.org, yukuai@fnnas.com, sagi@grimberg.me, kch@nvidia.com,
 cem@kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH V3 5/6] f2fs: ignore discard return value
To: Christoph Hellwig <hch@lst.de>, jaegeuk@kernel.org
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-6-ckulkarnilinux@gmail.com>
 <9c8a6b5f-74c8-4e9f-ae46-24e1df5fe4e0@kernel.org>
 <20251125063358.GA14801@lst.de>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251125063358.GA14801@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/2025 2:33 PM, Christoph Hellwig wrote:
> On Tue, Nov 25, 2025 at 09:10:00AM +0800, Chao Yu wrote:
>> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Sending these all as a series might be confusing - it would be good
> if the individual patches get picked through the subsystem trees
> so that the function signature can be cleaned up after -rc1.
> 
> Can we get this queued up in the f2fs tree?

Yes, I think it's clean to queue this patch into f2fs tree.

Thanks,

