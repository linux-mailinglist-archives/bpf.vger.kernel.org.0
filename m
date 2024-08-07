Return-Path: <bpf+bounces-36566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD57794A5F7
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 12:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABF91C20DEB
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 10:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD791E3CA2;
	Wed,  7 Aug 2024 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUEH5h6s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BEC15B57D;
	Wed,  7 Aug 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027333; cv=none; b=MDK5+/mTWsqgtUuKvPX2xa3Uz4pea4Ji3ms9/dnAn/JTrN2Cu0oyaqfHasdDsKleOlDyjSKpIlrCChCfR5mSuLrhfj7lY5XSBN0lJfyEnjSOqDmQSnPY6mEyZtOCl3kw08WxMtho01JKZNFIWq72DvFWDmNsnOLZKYW43Dfg/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027333; c=relaxed/simple;
	bh=tONnesJKB0d3wmCUvtM0dzk4tozOeZN25ZXfasSP1Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEw6rCVmmI2ojrc6SV/u4ZPkNesk/OVLdCt3ARNfo3MhX7hWXvtbD3MzNDEnqBhFxgM+4QhTMFAAGBPTvZwc+xVz5NXR8k0hMIXiGO/EktZ2lIAV7gFZSOihv/78OVkxMrnT0xMW8iNwWrzqalYqPQhAhtRhkP+Kbc2DzlY4zUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUEH5h6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67755C32782;
	Wed,  7 Aug 2024 10:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027332;
	bh=tONnesJKB0d3wmCUvtM0dzk4tozOeZN25ZXfasSP1Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUEH5h6soXupOSz1hVk2qh6T+YBRcHcd2OloaZgQJq6tDR4vk+XWbNdJFqv7fKnkm
	 PiHbhlFD76cWkon0RdKgpnNNJUM0a7dbL2u/e1MEBSpR1iYkl3Wy/TnZoloHdhI0Yk
	 smXeG7pSsgEWll0ZhFRzDUHGHzvpCAxSgeHqnFQpLJCT6/6GqtilkVRTs4m5y5ZhdT
	 /2AT8WDeMdLpu3RCCc2+FeuuEqD65HNjuQBIeDs3f3VPfQoW31zQQER5ssKxk4ZuSU
	 25ezHf4P1hLFPLIYKAsESzsrPHu57Qx2/59Lo6KqukAqwULE9Lue+eiZ2hlf8FMdA9
	 AXMyCEGIUhBQw==
Date: Wed, 7 Aug 2024 12:42:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 32/39] convert vfs_dedupe_file_range().
Message-ID: <20240807-einnimmt-tonart-f300afffd5f7@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-32-viro@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-32-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:18AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> fdput() is followed by checking fatal_signal_pending() (and aborting
> the loop in such case).  fdput() is transposable with that check.
> Yes, it'll probably end up with slightly fatter code (call after the
> check has returned false + call on the almost never taken out-of-line path
> instead of one call before the check), but it's not worth bothering with
> explicit extra scope there (or dragging the check into the loop condition,
> for that matter).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

