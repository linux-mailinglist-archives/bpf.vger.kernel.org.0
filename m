Return-Path: <bpf+bounces-37731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51FB95A0FC
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 17:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D1F2857F8
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED8E1494B1;
	Wed, 21 Aug 2024 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaQ9bkDk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179184E1C;
	Wed, 21 Aug 2024 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252892; cv=none; b=juXCUM6kIXwt59o5f+HRTPj0ODsB0LD8OTk58MA0ng8LQjtg+YRMZqYiQGN2SOUYlPXLjzEaekHHTuZ2YLQT945fsKNw4FOrjFMklHiKZ+JyGjzti9CDNGpLlINJ4gGA6jgzhhHRMN4MG1O08BZbSIoOpQ/RySbZDG75Ok6JUZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252892; c=relaxed/simple;
	bh=2leKkclemGUqO8l2N7G3iOV1WlTVVLsk21MWQfXZYhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLu7OxJm7SVxIIDr6iG8Nk1Of3fI9lqKUJ2aPxQxab34eScJLfE8zMaR3K6thmNimwZN7aA2SU1JtWV0EdYMFafxM75GWtoQdv/gd2PT+lCOq2y5KILhQFDSQfInqFIIBtYqXVI1BNHkd9CxdOGNmu7UfE5V9BTYs43gxUaAXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaQ9bkDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4EAC32781;
	Wed, 21 Aug 2024 15:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252891;
	bh=2leKkclemGUqO8l2N7G3iOV1WlTVVLsk21MWQfXZYhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jaQ9bkDkh9Fc1XzcIKpgF2fSVfdm6/DR5s5aZTDvipkQcdb7wvYRyJnfOUrd+JlB5
	 vB2di9aPicz5yEqTGx04JEgbAoV/mmnXjG1qsPnPlGC3ji2CxGVDrXQZ1HBgW0/+/b
	 TYCIpWlWX4JHrksLCRZjdaqN7CezkxHWH9wvJz9znm38yebGj/RmfRG4KhtvaUUAVk
	 A9fWUvV+vBUg6uT6fwztf31FlvmaPrUqjzl+WQOIg/BPM+OuqzX9vYJgposDii0eje
	 gXyV9keiGvzd6LyfbW5Xvwdzk/3al1g0VlC8d+MNJDcWpbhVH6SwfgoypitkLqOqGk
	 nQGtDjNaAM5bQ==
Date: Wed, 21 Aug 2024 16:08:07 +0100
From: Simon Horman <horms@kernel.org>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Louis Peens <louis.peens@corigine.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org, oss-drivers@corigine.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] nfp: bpf: Use kmemdup_array instead of kmemdup for
 multiple allocation
Message-ID: <20240821150807.GC2164@kernel.org>
References: <20240821081447.12430-1-yujiaoliang@vivo.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821081447.12430-1-yujiaoliang@vivo.com>

On Wed, Aug 21, 2024 at 04:14:45PM +0800, Yu Jiaoliang wrote:
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>

Reviewed-by: Simon Horman <horms@kernel.org>


