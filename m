Return-Path: <bpf+bounces-43051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3480F9AE92D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 16:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9874B24886
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 14:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696EF1E7640;
	Thu, 24 Oct 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnTfV4bz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C991B3937;
	Thu, 24 Oct 2024 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780949; cv=none; b=eKVhoXfPwxSJVnxQCLsJVEez93vkouGedGR7Z6dycirGFAbjuesN5BJK5ZlD/G4m2/txi6lC12Q5EW/b3ET/AurqLJnYNDSpNEVwOeUpBhnMN+JhwxI9XYphVrpP4sLpgx5EFcdqTLoc8NhGWHq4IKPMm6GcqHgI2S+z/zE2TvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780949; c=relaxed/simple;
	bh=eKCbwTRUi3K9eoFQ01WUece1BuLYrc4wAZhMVMb0wi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NERqIPZwCRWlXYzwWYkNupyf4VqrZWobXGttqWyaF7we+bOOB8A8G0RYxFDv2ElDrLWn3j4aV90Iuqx83nHMOD4GLI7krlBiCLqfNdV+bPLKLyrtZkveBEWrY6U0BCyC61PxP79yjbVnNneWg+gr0fGd2TJI9yWSw+udAnqail4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnTfV4bz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A00AC4CEC7;
	Thu, 24 Oct 2024 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729780949;
	bh=eKCbwTRUi3K9eoFQ01WUece1BuLYrc4wAZhMVMb0wi0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rnTfV4bzva8dzHglzHybXTXMG1dnOyaUs1nOrfI4BXZGqAsVAqLgBUp5uau1WH7vL
	 OY0rD8J46B+mBoeiXFRt+RhSMy67m/oXo0vvVpdL1J8WcIj/vNYD9IKZPZsXw6zM9B
	 t7Z4x1uKCirHcnSFiuCf2QXxL29b3hybcynvZPK7BYZh/CdUP6753LBuuqO+fSB8Z2
	 DttuBkQzoA2bdCSaG917CR9E6jI5XAXnfMcTDGrW7UvviqI+NCVgs6YmYMPonYD4mg
	 7++xMC37T7fn4h0qr+7RbfU+T4ITQt4Y5Wq7SURf8SuM84VkRYXgyeLI+qseLhnQhN
	 ERPuRk2t1OxMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CA403CE0C56; Thu, 24 Oct 2024 07:42:28 -0700 (PDT)
Date: Thu, 24 Oct 2024 07:42:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>, bpf@vger.kernel.org,
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Some observations (results) on BPF acquire and release
Message-ID: <7d968f29-63d2-4def-9caa-dae489cea7f3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Zxk2wNs4sxEIg-4d@andrea>
 <35bed95a-3203-43a7-972d-f3fd3c7da6f9@huaweicloud.com>
 <mb61pr085bt0g.fsf@kernel.org>
 <ecb585c5-7f56-4249-b525-66d9757a6f2f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb585c5-7f56-4249-b525-66d9757a6f2f@huaweicloud.com>

On Thu, Oct 24, 2024 at 02:21:15PM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 10/24/2024 um 2:11 PM schrieb Puranjay Mohan:
> > Jonas Oberhauser <jonas.oberhauser@huaweicloud.com> writes:
> > 
> > > Am 10/23/2024 um 7:47 PM schrieb Andrea Parri:
> > > > Hi Puranjay and Paul,
> > > > 
> > > > These remarks show that the proposed BPF formalization of acquire and
> > > > release somehow, but substantially, diverged from the corresponding
> > > > LKMM formalization.  My guess is that the divergences mentioned above
> > > > were not (fully) intentional, or I'm wondering -- why not follow the
> > > > latter (the LKMM's) more closely? -  This is probably the first question
> > > > I would need to clarify before trying/suggesting modifications to the
> > > > present formalizations.  ;-)  Thoughts?
> > > > 
> > > 
> > > I'm also curious why the formalization (not just in the semantics but
> > > also how it is structured) is so completely different from LKMM's.
> > 
> 
> Thanks Puranjay for your response!
> 
> 
> > BPF memory model is an instruction level memory model
> 
> You mean BPF has no optimizing byte code compiler?
> Is it guaranteed to stay this way?
> WASM does JIT optimizations as far as I know, which would bring back a lot
> of the complexity of software models like LKMM.

Sadly (at least from a simplicity viewpoint), BPF assembly goes at least
through compiler backends.  So there will be some issues of this sort.
We have started on them, but as Puranjay says, there is more to be done.

							Thanx, Paul

> > much simpler than LKMM
> 
> LKMM has a simple core, roughly like this:
> 
> ppo = ... (* all the ppo related rules that are relevant to you -- some
> fences don't matter and you can just remove them *)
> prop = (coe | fre) (* remove reflexive closure *) ; ...
> hb = [Marked] ; (ppo | rfe | prop & int | prop ; strong-sync) ; [Marked]
> 
> acyclic hb
> (* ... also add the atomicity & sc-per-loc axioms *)
> 
> If you can exclude compiler optimizations, you can remove the Marked bits.
> 
> 
> Best wishes,
> 
>   jonas
> 

