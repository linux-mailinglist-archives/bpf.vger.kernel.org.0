Return-Path: <bpf+bounces-38554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEB39662CA
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 15:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A44CB22BD7
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EC0199952;
	Fri, 30 Aug 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIMw4lHf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25561DA26;
	Fri, 30 Aug 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023993; cv=none; b=UoFmHkQyrpt6qxMGtAyxoZ2urslQ8iYPnxa+0wYMUYVDQkI+NdGVkO2ztZce8Vnut0rfRLUd/Yc8tw22qaOWHDzs1NVSqEBtCGPzEQB7+eoj1aEUHE/cpxGUkqFR/FO49oUE2w7p2lJ1jDIWbOq1zGeu2GPlWlYmB7QQ6L1gj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023993; c=relaxed/simple;
	bh=fJ4fGXKDz1JV/Osz3qsin1BifrFjuycJNDUCpma1rv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHlPQxubtehyq+1YU3xmqgK8gnjSlFaRUoh9yJjDzFx3zrgJmyNUvORz7b0/EXt9wdBfOPxeMRtwj40CfBVocrM2hrkwNF5yfTL3GX7eIvrHLpTfovuylC/dqE1ZzZufJEb6WS1GbgbAFzQcNH5+wghH5ceDjnTmZDB+o0/JtH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIMw4lHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A060BC4CEC2;
	Fri, 30 Aug 2024 13:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023993;
	bh=fJ4fGXKDz1JV/Osz3qsin1BifrFjuycJNDUCpma1rv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIMw4lHfY5AFhf6VGi5jfc5Pe6xooh/gKN6P8g+rl76xfiH0tn5L0Sxg99SPY0S6h
	 AomkbCIXB0Kg42ULtVu0OVQQwSOgHTpXyIHlcUkCU4BFBRqYwhNhDUSKOdM7ImxLML
	 rE7IA9Un/KuslLDZKeeBPv+MVIbo+6HpHvyqzB6+/vV73nNGKZ4zwbmHTjndz8i7re
	 hif5krOsTMD/po3vQNYDdecbvJaBMbIPOfnQYqZeW++4gmmv9yG+jgpqKU1rRYQS05
	 JN8k0y5H3f1Ejk1VOauRwKfbCYizh+muEMaYEPcIxKvdjASijrZ8C73erF659j/l1i
	 DrK834f9hs/jw==
Date: Fri, 30 Aug 2024 10:19:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@meta.com>,
	"dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent pahole
 changes
Message-ID: <ZtHG9YwwG5kwiRFt@x1>
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
 <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com>
 <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
 <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com>

On Fri, Aug 30, 2024 at 11:05:30AM +0100, Alan Maguire wrote:
> On 30/08/2024 10:21, Eduard Zingerman wrote:
> > On Fri, 2024-08-30 at 02:49 +0000, Song Liu wrote:
> >> With the regression, _both_ .BTF and .BTF.base sections (or at 
> >> least part of these sections) are in little endian for s390:

> > Hi Song,

> > Understood, thank you for clarification and sorry for confusion.
> > This makes sense because btf__distill_base() generates
> > two new BTF structures and both need to inherit endianness.
 
> thanks all for the quick root-cause analysis and proposed fixes!
> Explicitly checking these cases in the btf_endian selftest is probably
> worthwhile; I've put together tests that do that for non-native
> endianness but just noticed you mentioned you're working on tests
> Eduard. Is that what you had in mind?
 
> Arnaldo: apologies but I think we'll either need to back out the
> distilled stuff for 1.28 or have a new libbpf resync that captures the
> fixes for endian issues once they land. Let me know what works best for
> you. Thanks!

It was useful, we got it tested more widely and caught this one.

Andrii, what do you think? Can we get a 1.5.1 with this soon so that we
do a resying in pahole and then release 1.28?

- Arnaldo

