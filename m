Return-Path: <bpf+bounces-45025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569229D00C4
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 21:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264A6285EFA
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4005A198A11;
	Sat, 16 Nov 2024 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKYi9PBk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B251018E361;
	Sat, 16 Nov 2024 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731787922; cv=none; b=eRtE6NEyC7CnJzPS4BavALXd4jSBlBH1gL4BBo2ekTuykIBOVv990RkJPLcq+1cgqbt5JoMHWS36sC6566WSNBt/CSSqDhk74x/IfGN9iDI/g86auTrTPYwCuZeT2UpybW600jvCJtOzkv71CrfsobSDbnNLMAyQVyk2B/WfLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731787922; c=relaxed/simple;
	bh=Ryq2kn48uu4ymfZuietzNaWodpXhlmCk7EGkdD9BX0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9sHv/hiZoJDfGPPkY7C63Q47ZEy6F46jGNAkZUouFf46B5qufgY6GX61ueuVh3H1wMTYJuGHDJEpY8qHODZuic741iHfoNVCg3QpQgSamEowyBK0qTR1J5GY621EpOAbjUjAqXKMZgXJPoe6WBBCo/yUWkAhNFjgaCOEkXX9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKYi9PBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9855AC4CEC3;
	Sat, 16 Nov 2024 20:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731787922;
	bh=Ryq2kn48uu4ymfZuietzNaWodpXhlmCk7EGkdD9BX0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tKYi9PBkt9MFw2BWf8pZysah4ESW2n4h7fdP6WbVPkanoi36rutS+rSXIlOWi8tk4
	 HPJu/wyLiM+ec/5P5LE3C3LCCwBFXL/kwNFrIdaVKYAq1r8napG24gi8ayEXw8CiYs
	 PIAggcJgFJZEVvuR+OnEp1jDVLcouClaMBK+ln0GkYL3yTZpFbyBCb7Op57b7lIpRV
	 MNqROr6tHU1khPyeAosaz0tEaFMhjWFs50ArAXcGRPYVaQfG4hJ5liCswLwIsF8BnQ
	 Ad77rHWg6/AtXjRAVYCdegV61nuiL2MyH7nfkQAg8KvbtByMO5cjDkc7mz6iTMLP5c
	 Lqw2O1eYZEccw==
Date: Sat, 16 Nov 2024 17:11:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
	andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	kernel-team@fb.com, song@kernel.org, eddyz87@gmail.com,
	olsajiri@gmail.com
Subject: Re: [PATCH v3 dwarves 0/2] Check DW_OP_[GNU_]entry_value for
 possible parameter matching
Message-ID: <Zzj8jl4TKSEDnPrL@x1>
References: <20241115113605.1504796-1-alan.maguire@oracle.com>
 <a1ffc678-5d72-45f5-a304-07be3cca7f86@oracle.com>
 <Zzdupj2ifjERTijl@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzdupj2ifjERTijl@x1>

On Fri, Nov 15, 2024 at 12:54:17PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Nov 15, 2024 at 11:40:16AM +0000, Alan Maguire wrote:
> > On 15/11/2024 11:36, Alan Maguire wrote:
> > > Currently, pahole relies on DWARF to find whether a particular func
> > > has its parameter mismatched with standard or optimized away.
> > > In both these cases, the func will not be put in BTF and this
> > > will prevent fentry/fexit tracing for these functions.
> > > 
> > > The current parameter checking focuses on the first location/expression
> > > to match intended parameter register. But in some cases, the first
> > > location/expression does not have expected matching information,
> > > but further location like DW_OP_[GNU_]entry_value can provide
> > > information which matches the expected parameter register.
> > > 
> > > Patch 1 supports this; patch 2 adds locking around dwarf_getlocation*
> > > as it is unsafe in a multithreaded environment.
> > >
> > 
> > apologies, forgot to note
> > 
> > Changes since v2:
> > 
> > - handle multiple DW_OP_entry_value expressions by bailing if the
> > register matches expected, otherwise save reg in return value (Eduard
> > Yonghong, Jiri, patch 1)
> 
> Thanks, applied locally, will perform tests and push publicly later
> today.

Did the tests/tests run, passes, pushed out to the master branch.

Thanks!

- Arnaldo

