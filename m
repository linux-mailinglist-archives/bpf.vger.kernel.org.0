Return-Path: <bpf+bounces-30765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491E58D2347
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 20:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D62B224F3
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 18:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EA84C61B;
	Tue, 28 May 2024 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eRd7sY9D"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B3175AB
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716920868; cv=none; b=LZjF3QcAeieTjwAnPnirP29O9/2vj1M6yp2EPMnJRNcfYcOG5GgBePfJ6+Emr1NC6trd1KbPxsWzU8bceqd4swzKSTbWgkBPTo59hp6E6fl4zphtdHq35bZMcyYokLVcMRMCGBfifxRZoRIsdHAEPwWt0sr00GvGMcAuXtBLG9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716920868; c=relaxed/simple;
	bh=+l4rx26N4fqBHi6YyfVDAVSGKMrZyvctT227cKoi1+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNC+LgJ693We7XjMWwllA0klqiJG0BG4cUF9hMGAZ4VO4mE1QIU1hpnz6TjQdMW7Y/yauvJ5TA9/KXMWA+a+vmSiiQtkb7N2KiHQGdBU4n/e/uAe5AajB8V2bHsvvKoyn9A6pAMRH9Cqmw6UwuZQeD3lfwniGj5VpVqy/NwTkXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eRd7sY9D; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B/wKGfDTd/n3Mz1GexSiiao4hFfHSZNDaKQZchicEdQ=; b=eRd7sY9DIfFMFVYBJ4GtKJs3HV
	sEFsvh14ep/7P/RlHkyotOxVEZ8vtXQmapWZq/t5gu57P3VxAp5G71bDFUGKVGW5PI0tKJqtJ0oI8
	WrlChOqFoWQJAY4tNv+lgkZc4C1Gd9huap7veSbZ7FwkgeAMUNfAHlli8rpmvjsjydfcMh+kLyo60
	BoEz/QWttp50Qmgyjwwt7vXk7RQurOulBL+8yEucgvo0Q+PW36XpIg/iddAEJ810KUYq5mUFeYSB4
	rxcGbDs7QVOz3A2G7UPLOK/mPmYiszSeM1Ez+fIX7qoeC8YhK6CGXzPsCgVbXqJaIoCI2EdNSNq7r
	N2cTBP8w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC1Xu-00000001fkU-2WCy;
	Tue, 28 May 2024 18:27:38 +0000
Date: Tue, 28 May 2024 11:27:38 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	houtao1@huawei.com, bpf@vger.kernel.org, masahiroy@kernel.org,
	nathan@kernel.org
Subject: Re: [PATCH v5 bpf-next 7/9] module, bpf: store BTF base pointer in
 struct module
Message-ID: <ZlYiGnN1Q9I_aXvX@bombadil.infradead.org>
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
 <20240528122408.3154936-8-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528122408.3154936-8-alan.maguire@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, May 28, 2024 at 01:24:06PM +0100, Alan Maguire wrote:
> ...as this will allow split BTF modules with a base BTF
> representation (rather than the full vmlinux BTF at time of
> BTF encoding) to resolve their references to kernel types in a
> way that is more resilient to small changes in kernel types.
> 
> This will allow modules that are not built every time the kernel
> is to provide more resilient BTF, rather than have it invalidated
> every time BTF ids for core kernel types change.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

