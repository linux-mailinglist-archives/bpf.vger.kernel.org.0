Return-Path: <bpf+bounces-75417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB85BC82FC1
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 02:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63AE64E363F
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 01:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEE421ABDC;
	Tue, 25 Nov 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQJwBRIe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E7536D4E8;
	Tue, 25 Nov 2025 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764032999; cv=none; b=GubYGsrduHy8KlN6ROYqFgCrqovgGrrIABcJmsrHRqmTbVjg4BpY4at9JhRqUk6ijIzuuEBkJ6NB/6vQ0ipgy73TiVAK75ZMC6NMw3KkPTuos2RBoToBYp5J5LIoGam2WhA+3unLdlOU2qt9l8qxVJf3u1bt8d2X7QkSSmZz+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764032999; c=relaxed/simple;
	bh=p+RQE8h6QFhjvlBxPivIpSfBdKHxPiCLXqbTGtWf46M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=szxc+QWhe0EfIwqB2+DP/JoHm3WSb4TQpLpzVNdH73T5/wz87iVvqEPfAcPksresSaSlTs9XrSzHMvEhrzz3jLW4bdrAbKvQjFMPG0W1LOORAPqY54hP1RtlexVSS4wipvmNhxblpayxvvKTA2xdo7kUEPxL1VbQhYi2Uy+xjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQJwBRIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A996EC4CEF1;
	Tue, 25 Nov 2025 01:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764032998;
	bh=p+RQE8h6QFhjvlBxPivIpSfBdKHxPiCLXqbTGtWf46M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kQJwBRIeltEvdGX/fAzab87jUDhTkk9++PHTM3qoEmNCswD5CsY5f1W7YtjrR/vUq
	 LnALvZVuJEgGzptHvE6j3cCAhVedGqzRCrYyf1Fu00EXD6d6rEfAz9S+2YXLZBAQtJ
	 HxEQgduuPzo3Dd+9t3obcRy/Orvao8Wxj81DLFib2yxL6imPcs0CmgyKSODJ+S1VHT
	 CSCwwIQ5J/04Sxuq09AA5BVjAA/u3mNTjQ8XH4pJIhkIh/la8Ku+qYTUYAT/pLiICH
	 QJi87G1lUUrrxvn8l9VYu75SCwr+C+d3qno/7HTOSdpLH0GK1OOjpnIjQmZ4x+gudR
	 oNNSBkRlqrvOg==
Message-ID: <9c8a6b5f-74c8-4e9f-ae46-24e1df5fe4e0@kernel.org>
Date: Tue, 25 Nov 2025 09:10:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 bpf@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH V3 5/6] f2fs: ignore discard return value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
 agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
 yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, cem@kernel.org
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-6-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251124234806.75216-6-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/2025 7:48 AM, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() always returns 0, making the error assignment
> in __submit_discard_cmd() dead code.
> 
> Initialize err to 0 and remove the error assignment from the
> __blkdev_issue_discard() call to err. Move fault injection code into
> already present if branch where err is set to -EIO.
> 
> This preserves the fault injection behavior while removing dead error
> handling.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

