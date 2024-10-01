Return-Path: <bpf+bounces-40652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8314B98B68C
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 10:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B49283357
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 08:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42371BDAB0;
	Tue,  1 Oct 2024 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H5bmyulF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C6A29A1;
	Tue,  1 Oct 2024 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770156; cv=none; b=ZOiDSeCBqWqpyXG5snFOl5+Lg5iGqLHbrrIYQy6PYbMiqJmwABe1DmW/PnQXPsu2GWPZz84Bp0sbFY+N5qHTdUVoYsj+001x2Ezl9d3xz/kb6YLfNwbNPlt+WzlckVhvq4EGWmOJwvx4SO7LeDWJli1ECwHqa0YiMTJsiyc0Mu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770156; c=relaxed/simple;
	bh=BbdV2MpOXM0MywSHpVfEnV95Cp3niOy+IjyLx/CtawU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwBuppnSk1NiVVfcfeSEzngEN6qLUR37CvXf8IbU9/6s6gUuh4jCNfqGUvM1Thx4aFdcUjbcLIN24iizCwPOTdjh+w8biCV+c7Zzz0+rENUuu22TcExb89Vt1p6YI/YHYF1S3wxMvv7uybL35GKYyBSIwOxm3pHeGCUGCVPYB2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H5bmyulF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E62C4CEC6;
	Tue,  1 Oct 2024 08:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727770156;
	bh=BbdV2MpOXM0MywSHpVfEnV95Cp3niOy+IjyLx/CtawU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5bmyulFME58s3XSV5Wg6NwXJJDLIdpznTUujnIpCIMfwnxc0xv6dUUZLYdlapEUp
	 ivBSTpoV+iuaXwq2YTSSDr8Q3aR78xaC3CZy14KKEnJWGT90pvnqvREE5LszA7gsEL
	 H5bf5hIZbTcMSb+Xv6gQwFmnX6GZGyd8kBIg1eow=
Date: Tue, 1 Oct 2024 10:09:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH 5.10 v2 0/3] Re-adapt "bpf: Fix DEVMAP_HASH overflow
 check on 32-bit arches"
Message-ID: <2024100108-limit-decree-c642@gregkh>
References: <20240927135118.1432057-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240927135118.1432057-1-pulehui@huaweicloud.com>

On Fri, Sep 27, 2024 at 01:51:15PM +0000, Pu Lehui wrote:
> Commit 70294d8bc31f ("bpf: Eliminate rlimit-based memory accounting for
> devmap maps") relies on the v5.11+ basic mechanism of memcg-based memory
> accounting [0]. The commit cannot be independently backported to the
> 5.10 stable branch, otherwise the related memory when creating devmap
> will be unrestricted and the associated bpf selftest map_ptr will fail.
> Let's roll back to rlimit-based memory accounting mode for devmap and
> re-adapt the commit 225da02acdc9 ("bpf: Fix DEVMAP_HASH overflow check
> on 32-bit arches") to the 5.10 stable branch.
> 
> Link: https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com [0]
> 
> Pu Lehui (2):
>   Revert "bpf: Fix DEVMAP_HASH overflow check on 32-bit arches"
>   Revert "bpf: Eliminate rlimit-based memory accounting for devmap maps"
> 
> Toke Høiland-Jørgensen (1):
>   bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
> 
>  kernel/bpf/devmap.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

Now queud up, thanks.

greg k-h

