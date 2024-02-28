Return-Path: <bpf+bounces-22867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5C686AF46
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 13:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A56028802D
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 12:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68A573515;
	Wed, 28 Feb 2024 12:37:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDE13B29F;
	Wed, 28 Feb 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123844; cv=none; b=R617cTBr9LKc9owRhGhe6ywil3+k3CD15OxIZlXo1+q9wz2aHX4/pZZ/4Ps+C0tdC7dOje4Thrv8k41ePuh0XJ2C0aHG+v6SDgt+kXVY9Q2QGIoPGf2LTs/bKAHPyIbIdgFyJiEjMrDOrRPl09edysxWm4+x9UWvv9vJUTIpqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123844; c=relaxed/simple;
	bh=27bEplVsKBtrBi7cwoJwvwFBNz5/tf65qGb8rdLTl6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOXiS/j+nsxJ0jDuiwt2JpRhbDxGpng5gnYvEoxd0LvoyIsShCo5dy2a5pMryiTK72mpWu/kr644GVVVJzV00zAtQ09YQXTKLFnLDQNgq5xJuaw1C+Yi+jmZ8MnyDJCU1NHIgv8cVoWwqdM9/WUc9JvhWDE4LHWZbBVo1O4fKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6C3C433F1;
	Wed, 28 Feb 2024 12:37:21 +0000 (UTC)
Date: Wed, 28 Feb 2024 12:37:19 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, mark.rutland@arm.com,
	bpf@vger.kernel.org, kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xukuohai@huaweicloud.com
Subject: Re: [PATCH bpf-next v8 0/2] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
Message-ID: <Zd8o__ow2F6-ENVh@arm.com>
References: <20240221145106.105995-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221145106.105995-1-puranjay12@gmail.com>

On Wed, Feb 21, 2024 at 02:51:04PM +0000, Puranjay Mohan wrote:
> Puranjay Mohan (2):
>   arm64: patching: implement text_poke API
>   bpf, arm64: use bpf_prog_pack for memory management
> 
>  arch/arm64/include/asm/patching.h |   2 +
>  arch/arm64/kernel/patching.c      |  75 ++++++++++++++++
>  arch/arm64/net/bpf_jit_comp.c     | 139 ++++++++++++++++++++++++------
>  3 files changed, 192 insertions(+), 24 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Feel free to take it through the bpf tree.

-- 
Catalin

