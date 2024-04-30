Return-Path: <bpf+bounces-28266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 487B88B776F
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 15:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75670B21706
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39266171E69;
	Tue, 30 Apr 2024 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsX6ry2F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D12171E5D;
	Tue, 30 Apr 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484710; cv=none; b=oCOFL/8KehNeqIsQ6sG5ZffFOATO0feZ5sXcn5VsMiUhLEYSg2TnKpmJtDqDCvqhLKALWdiWjKgUwTej7+UNaGbkHRgytKKEEiMOxjLFJwWPM5nfCgIdHfrjCwVs8jwoXuNg9HzweANR2KVEzsoFKk/J7GKXIS7hNbbZd++5DcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484710; c=relaxed/simple;
	bh=1/d6d90eVlKLcsvBXV4d1xahMsnce0KYCF/p3Wcn21o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZj55LPvhULJi2qPdKMC83MTDspTyEJK05HSp8TnchtH+zEpqNWD0J8i0miZO1lPCsM4M6goj9dp/boy20TF9sZ1p9BQ4ZthghxHlHu/Hti2NAiKA0nsK+75mYxAR23bintMehffn7P6sxajY/yqRKWhjzrADZkwkexAfnMp4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsX6ry2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C79C2BBFC;
	Tue, 30 Apr 2024 13:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714484710;
	bh=1/d6d90eVlKLcsvBXV4d1xahMsnce0KYCF/p3Wcn21o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HsX6ry2FEW/Ro9IU6ra14nn3XmfuH6jBdGmwVObSGGUo4Q9cPTdZ5twM/eHcqFlAm
	 J8nNha1ADI6moLUBLPgEZ+Gf1eE5LgZfyIRRyJO8GG4vZRktqLQKDnRgR7EPNJseNX
	 E7/CNk1V5RUyKA6i3Z7+h6ZUZHQdeCJSoOsYx6XJrg4QbwAaaSiyPL+bouxz2/pVhd
	 4/vTU33k4nY1c1MLbaLj0njrv2mgN9UYyhBr+hJa0kv8PD94gPUyTa9x/WrWLB4GbL
	 OaON8BN7fkwX9fnlorifPVkYyCXsW7KEEBOFXANvBZjUqJXDfLwDZ3fERl/LQ7pn+O
	 JGujiDKtU3qYA==
Date: Tue, 30 Apr 2024 06:45:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2024-04-29
Message-ID: <20240430064508.13fa79a3@kernel.org>
In-Reply-To: <CAJ8uoz3jzO=nRTRH9OPjTu0iBn9Gdjn0pbgVGdjDKbV=Q_BUMg@mail.gmail.com>
References: <20240429131657.19423-1-daniel@iogearbox.net>
	<20240429132207.58ecf430@kernel.org>
	<CAJ8uoz3jzO=nRTRH9OPjTu0iBn9Gdjn0pbgVGdjDKbV=Q_BUMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 10:16:33 +0200 Magnus Karlsson wrote:
> > Could you follow up to remove this header?
> > Having to keep multiple headers in sync is annoying, and using
> > 'make headers' or including in-tree headers directly is not rocket
> > science.  
> 
> Just because I am curious, what was the reason/history behind the
> tools/include directory to start with? Most headers seem to be copies
> there.

I think it started as folks copying a handful of headers for perf tool
and snowballed from there. By the time I pulled this the copy of
ethtool.h was already out of date. So is if_xdp.h, BTW, as I am
reminded every time I built networking selftests. 

