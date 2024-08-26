Return-Path: <bpf+bounces-38087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F195F64A
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 18:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE87B1C21E92
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CBF194A73;
	Mon, 26 Aug 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3ZiB9E2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9AC186619;
	Mon, 26 Aug 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689131; cv=none; b=M1NXHqzVsJtM0h72mFukt5zfiWHtWmkuPTZtJwh7zUqJXOR7Rl8HyDPltFpdO/Snq9wDhsjMhajuFD7JeZ8iSLy4ce6S4byg+PAkTvGr1PxgQl1PM5SSdKJUsei4jtTtOLyKtTB7+x8iSIMu7rTI3riCb4T9eAqZ3/XxWERFWN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689131; c=relaxed/simple;
	bh=XW3K/UbAx1X82t/8mkYMp8NrJ0RO76JH6LHCKsvoGOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTUcFSda4WMQIqdfqrt7oK4MgzwAymhIODJlCsyszZjIYUbMCCbYEWEpZlDp5UWm7ZOAlsT3ne+Ngcttn7LmXlKoxzXypfzAa9GeltLrQFF3ok8l6DiGa3e41WWjWpl3hjAHuvajM3PR2mwzhNF8AuP/PYqCtgxXc3Cusw1tejM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3ZiB9E2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECFFC52FC0;
	Mon, 26 Aug 2024 16:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724689131;
	bh=XW3K/UbAx1X82t/8mkYMp8NrJ0RO76JH6LHCKsvoGOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3ZiB9E2MHAn4BytMBqpqUaQiyvCmTLptpPApCxFWhVUKOeoRcy0D5Q7hlVOoOxE6
	 nyr60dFmpTSHCsq4yTuJhyf2+0t6lhaAt1ySBG4Q/hIrkhccLiWKuMWEaWEa0Oataw
	 XfyKpw4MvgLUfsRfRLhfMn6tnZm9tFzbFLnDwK2o9txW/nIHsJbPG9NIuekLfuvLyT
	 R1BbBZ8XayJRa7gv/q8HF54xTHCQY9+4AFlYsdv92QhuCpTH0G3y4DXxo/NiPpvXU3
	 WjWlVOG36Lmy27/HiXiVZjRtQdHxxwc5GP3vgYnDN+tjsY9Q+ESat+373GeRTIZcLM
	 epbrJnhbmGlNw==
Date: Mon, 26 Aug 2024 13:18:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: jolsa@kernel.org, andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com,
	dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 0/2] add distilled base BTF support to pahole
Message-ID: <Zsyq6KqACD8Kjq58@x1>
References: <20240729111317.140816-1-alan.maguire@oracle.com>
 <ZsyqxJbItYZqKwBD@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsyqxJbItYZqKwBD@x1>

On Mon, Aug 26, 2024 at 01:18:16PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Jul 29, 2024 at 12:13:15PM +0100, Alan Maguire wrote:
> > Patch 1 updates the libbpf commit to use latest libbpf with
> > btf__distill_base() support; patch 2 adds support for the
> > 'distilled_base' BTF feature, used to support resilient
> > split BTF for kernel modules.
> 
> Thanks, applied to perf-tools-next,

To the next branch, canned reply, sorry :-)

- Arnaldo
 
> - Arnaldo
>  
> > Alan Maguire (2):
> >   pahole: Sync with libbpf-1.5
> >   btf_encoder: add "distilled_base" BTF feature to split BTF generation
> > 
> >  btf_encoder.c      | 50 ++++++++++++++++++++++++++++++++++------------
> >  dwarves.h          |  1 +
> >  lib/bpf            |  2 +-
> >  man-pages/pahole.1 |  4 ++++
> >  pahole.c           |  1 +
> >  5 files changed, 44 insertions(+), 14 deletions(-)
> > 
> > -- 
> > 2.43.5

