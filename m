Return-Path: <bpf+bounces-40708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 469BD98C5B6
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 20:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D961C22C99
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 18:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99461CCB54;
	Tue,  1 Oct 2024 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQ+b0AVn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD91C6F7F;
	Tue,  1 Oct 2024 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808784; cv=none; b=XIvVgtpEFdzuOVYS1fS6UFtuUq+NPTZ6YxELmI7/xqriY5sFb8tIgns4WZfc2zZtWYkpV6rKNpBJ0OrYG/q0ZNFFnH48LmjzcnFhTBHWC1fSVG3cKV5BWQnKDpBXxAxqgiuq47vgzeKwgwV1VH56/JY1zYETN7ftLr0PyGwtxo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808784; c=relaxed/simple;
	bh=FJMNViwtwp7ygFcH9/LecGPB0XcxiIGp/deL05VLKwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxPHAWzP4YoW48TSlqpOsmdOfza8bawsiTumBrcKZ8RZN9No6xBEFz+k1hQVt0xxfqBoOwNMAbN6RFht+6ZRmVUcnwyIml3LluNtosm5ANXZC/oZ9ybCwZOju2Rkitmzga3bnZZloGpXrZwerbf8wJa3p2p8YK9Jenp/iecOLYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQ+b0AVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191D1C4CEC6;
	Tue,  1 Oct 2024 18:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727808783;
	bh=FJMNViwtwp7ygFcH9/LecGPB0XcxiIGp/deL05VLKwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQ+b0AVnGpHfRRX/UoQG6/kCr8R/kD94ZCXZUE1MyosbxSJjRNQTgzG0J0iuw9jLN
	 zJPiYZp31IndoY0ISkLK5XUBBV+T/b5Bo5u6RgBdr9+SiuxLJoqQRtq7ZGpiU07HFc
	 VGVqre8/SoR71qLmTqR0BoS8uTPZ4xq0+Tk7o26HD0/ylM4V2xY97PvVh+GaTCRNK1
	 m8hRLu/iKRtiKzzkYanPVoY7AvCYdMmPniSF6cfWdsW8YRAfiSLUe/IX3WV5KYxvGG
	 8NusZ6EzHkw3z6hbiws913/R1/4KoVbRgXd/gMgpekRajWjP2lmQUnsRBAg41oFPJm
	 Q3WtKA93PGCqQ==
Date: Tue, 1 Oct 2024 15:52:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves v2 4/4] btf_encoder: add global_var feature to
 encode globals
Message-ID: <ZvxFC99--p4W27ok@x1>
References: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
 <20240920081903.13473-5-stephen.s.brennan@oracle.com>
 <ZvwQR_LFnjxQNPIY@x1>
 <CAEf4BzaJXiEk03Tkcd2njf=0+pieZHrZ4gBhra0JL_7vF9uwpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaJXiEk03Tkcd2njf=0+pieZHrZ4gBhra0JL_7vF9uwpg@mail.gmail.com>

On Tue, Oct 01, 2024 at 10:13:29AM -0700, Andrii Nakryiko wrote:
> On Tue, Oct 1, 2024 at 8:10 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Fri, Sep 20, 2024 at 01:19:01AM -0700, Stephen Brennan wrote:
> > > Currently the "var" feature only encodes percpu variables. Add the
> > > ability to encode all global variables.
> > >
> > > This also drops the use of the symbol table to find variable names and
> > > compare them against DWARF names. We simply rely on the DWARF
> > > information to give us all the variables.
> >
> > I applied the three first patches to the next branch that soon will move
> > to master, but the last patch I think does too many things and ends up
> > being too big.
> >
> > For instance, you could have done the btf_encoder->skip_encoding_vars
> > transformation into a bitfield in a separate, prep patch, also you
> > mentions "this also drops the use of the symbol table", can this be made
> > a separate, prep patch?
> >
> > There was a conflict with some new options I added (--padding,
> > --padding_ge) and I fixed that up and made the series available in the
> > btf_global_vars branch, can you please go from there and split the last
> > patch into smaller chunks?
> >
> > Thanks for your work on this! I noticed that this is not the default,
> > i.e. one has to explicitely opt in to have the global variables encoded
> > in BTF, so that would be interesting to have spelled out in the chunked
> > out patch that introduces the feature, etc.
> 
> We probably shouldn't enable this option in kernel build until we work
> out details of loading vmlinux BTF(s) through the kernel module.

Sure, this should be completely opt-in, and for kernel features, even
for documentational purposes, we need to enable it via --btf_features in
the Kbuild files, etc.

But with the feature in pahole we can go on experimenting with it, etc.

- Arnaldo
 
> > Also since we have it as a feature and can ask for global variables
> > using --btf_features=global_var, I don't think we need
> > --encode_btf_global_vars, right?

> > That will also make the patch smaller, and even if it was required, that
> > would be something to have in a separate patch.

