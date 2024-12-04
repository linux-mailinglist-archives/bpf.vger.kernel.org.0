Return-Path: <bpf+bounces-46107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 435279E44FD
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 20:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B2516696F
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 19:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F91C1E2306;
	Wed,  4 Dec 2024 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/bYc45/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A918BBB4;
	Wed,  4 Dec 2024 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733341636; cv=none; b=SXLsafYyVaJoEKMSEdsnvVO/4xv7cs/2MHiGqFLJysNa4Q2lUw+KbuCttsoK7BETmZmTjSDcv85SNHo/MuB7+wN9ePaWeRYPJ0bnI4nesH+sPISSPiK3a6imw0hW/mr08oPLxiqQ1BiQLPLvrcbMaPOYAeZMKyRCrF4FOj/WSEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733341636; c=relaxed/simple;
	bh=1OGZpRc+ULhWIyWSqSSIA2IfgVKHpxpKwNocmASXf2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPgyEO4OtkPbhsH054oZTu0pVF/aslD1K2eAE7dbbtwbshKl9jme7KREvtuoin7R1Y/j0zV25ub+REB4OLmxOUEYrT77EZuz7ALvAeAqq6zFryAFGRIBXp+3wj+rhbCo/NuydGw8tvPU6HkBqdLk+I5eKUtdsuzKnZ7DdnSiJUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/bYc45/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B9FC4CECD;
	Wed,  4 Dec 2024 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733341634;
	bh=1OGZpRc+ULhWIyWSqSSIA2IfgVKHpxpKwNocmASXf2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/bYc45/+FYb0Ao32E0MD+jyw/FUJB0Ea86EdXA0Jam8iquYpRvHAAsIunus0Li97
	 IOVl0bXYYv+J8KRdSUEugkqavNTM18qns2xwCPYc+SBm8IWeUjPGat3y725leQBxsL
	 q3Y/uS3v1jA2Mehp7npoIJsfwM4QU/y23uY5y2BjINp7d9aKkylIvl02PXsZaxbhb8
	 C95svouPb5tRKq0LwbP9jhEbW5okjc+43T2MYu+YrYIMELRm+7yxMdJG4QZuUf4ub4
	 eXzsE+bZ9z5DZBxb6hw1YgDBe3BMdALfEwOwaLnhJwLiVNTGrDKtNCGjfaWT0YEp+T
	 AElegKTGjjuTA==
Date: Wed, 4 Dec 2024 09:47:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	andrii@kernel.org, mykolal@fb.com
Subject: Re: [PATCH] selftests/sched_ext: fix build after renames in
 sched_ext API
Message-ID: <Z1CxwdiIyzFSpY2U@slm.duckdns.org>
References: <20241121214014.3346203-1-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121214014.3346203-1-ihor.solodrai@pm.me>

On Thu, Nov 21, 2024 at 09:40:17PM +0000, Ihor Solodrai wrote:
> The selftests are falining to build on current tip of bpf-next and
> sched_ext [1]. This has broken BPF CI [2] after merge from upstream.
> 
> Use appropriate function names in the selftests according to the
> recent changes in the sched_ext API [3].
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=fc39fb56917bb3cb53e99560ca3612a84456ada2
> [2] https://github.com/kernel-patches/bpf/actions/runs/11959327258/job/33340923745
> [3] https://lore.kernel.org/all/20241109194853.580310-1-tj@kernel.org/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

Applied to sched_ext/for-6.13-fixes.

Thanks.

-- 
tejun

