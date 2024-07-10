Return-Path: <bpf+bounces-34457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DFB92D930
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 21:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30361C20A64
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 19:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6718C197A9B;
	Wed, 10 Jul 2024 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/EitetZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D3329D06;
	Wed, 10 Jul 2024 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639892; cv=none; b=YCSRkqzfvHBdPn10roFSwvcSwJ4FarTN8wSClzmnwTGkH/hODg3GuaIsoR13kmvsrXfzdDFigxLvcZpckxZfm4YNmOAGLCdHV6PkzR/mByqQlXs+QdUZf89zm4sQE4py4vSXktFgmYqFZFdeOGF350sAP9ASQ8nRuhpW7iFIjA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639892; c=relaxed/simple;
	bh=GeP6s8hYw3uoLVKQes4gx1SgdUcoOS4Sb+XUb70wW8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTvnzeyfXMK1Wv+vrwN0H/NgDV4nHIVPtiC3nw7BoL+6k2viwRVzvI7P/4oLV9zpp9AUbc0/oS8vgbR6RQ37qzLtunhT/qWRKLMg8qQuh7HL99TdbWqjxVPD3BBZAWE9ZtMLLI2CrYw6DeAF/6xRfIKXmTm2bK9p/MPMdlTlko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/EitetZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98222C32781;
	Wed, 10 Jul 2024 19:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720639890;
	bh=GeP6s8hYw3uoLVKQes4gx1SgdUcoOS4Sb+XUb70wW8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/EitetZXc2kPvzI48hCIDVfX90JHwHsoFXhOzkxf8T+npUbnE4H3+tls5T+9hyCA
	 nF2Q+TH9OcZD+LPX3Mju3T6sXKKxzqN0eMvhQIwoSs8I/TBTEyCQ+dxA8jcFGFFaeQ
	 SFMAV34zQksUGsNMQ+F+r8pZvhBAFlHIo2rJfyYFPSnwXcekKUMD1J+OAU9dm/5o2l
	 9uEUfe4FUabkT9xo9aXVGsTvC3ailUkZxHydCivA/qenk8AuD9axOqEkL3M/NVMRKH
	 0jsIqma+OL0sgwUwulxMTeO5LuiG2Pm9+6LXAt/UH4V2316S3hOPLqohZ7/GJmSiQH
	 0lwXyTk/Gv3Lg==
Date: Wed, 10 Jul 2024 12:31:28 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Jan Engelhardt <jengelh@inai.de>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Viktor Malik <vmalik@redhat.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Daniel Xu <dxu@dxuuu.xyz>, Yonghong Song <yonghong.song@linux.dev>,
	llvm@lists.linux.dev, Tom Stellard <tstellar@redhat.com>
Subject: Re: [PATCH/RFT] Re: ANNOUNCE: pahole v1.27 (reproducible builds, BTF
 kfuncs)
Message-ID: <20240710193128.GA1934835@thelio-3990X>
References: <ZmjBHWw-Q5hKBiwA@x1>
 <20240613214019.GA1423015@thelio-3990X>
 <ZnCQ-Psf_WswMk1W@x1>
 <ZnCWRMfRDMHqSxBb@x1>
 <20240617210810.GA1877676@thelio-3990X>
 <ZnGQ8CDRaMBIj5R5@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnGQ8CDRaMBIj5R5@x1>

Hi Arnaldo,

On Tue, Jun 18, 2024 at 10:51:44AM -0300, Arnaldo Carvalho de Melo wrote:
> >From 6a2b27c0f512619b0e7a769a18a0fb05bb3789a5 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Tue, 18 Jun 2024 10:37:30 -0300
> Subject: [PATCH 1/1] core: Initialize cu->node with INIT_LIST_HEAD()

Could a new release be cut for this issue? Several people have been bit
by this (including CI systems) and two distributions have talked about
backporting this change on top of 1.27 to resolve it:

https://gitlab.archlinux.org/archlinux/packaging/packages/pahole/-/issues/1
https://src.fedoraproject.org/rpms/dwarves/pull-request/4

Cheers,
Nathan

