Return-Path: <bpf+bounces-75441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CE4C84C49
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 12:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BDB74E981F
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C833931691E;
	Tue, 25 Nov 2025 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpl8KS9A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408DF31618F;
	Tue, 25 Nov 2025 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070842; cv=none; b=ua0Kge3uzGMPQUp3USY2dAJkOfoQf7go5ZhIhL7/DjCG9g56tQmq9Is9fzVCI8nuwms9t0IbEa5PVVAjc9Gjb2GvImHWLj7nN3a3StQXGICkloRSO7/920X5/yEqQDlkebNQWb/42R9TalaAdf5iJlgHnZnN9oz+IvddB14GNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070842; c=relaxed/simple;
	bh=zoilOKj8xpK77BIBvwS1r4ulMQuZUA1mGpZf+vNcPGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J13fO9nL4NDa5kyCHe6AKWqvCsnqr/nzT082xjiQmv7T7qW7QcXbo8OlWjNhKrb0jfGcFlGe3JeD9Z+PoGrYCaLrl3GRWRIA1+dea6OelwqcpRIjOFXJCXaymyv3+3wK8PWV69/Hjh7oTUixVRdXPoVaiTuD8wSQ5oeVQJjGM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpl8KS9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D32C19421;
	Tue, 25 Nov 2025 11:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764070841;
	bh=zoilOKj8xpK77BIBvwS1r4ulMQuZUA1mGpZf+vNcPGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpl8KS9As1NDLm97kiFeu1IfxvwOid1I4+QFq2AkU2cPQli+YNstBvz0OPIUmCQkr
	 ybD4oqRTade84WAbIbdD1Thc0GWnIbGV/nyhfHBYDM6K0CiPg2Ha9S3YuMUb3Dke6m
	 8Pg5JuFMZ+gomLeoAzn0qxeY/azwbx3XIhwGF7DDDnURej080I6/b3HkUXfTyKJSlp
	 kqhF7C9RZbRZUXhHIdN8oc1xcfMd5B9CL5mUfoMiOWfkCXcERJddMRq94FIb6oTtc3
	 ZWhqQtuaDi3scWijkOQDfSS6ZW0ZQ4TypCtbF2Zw5rNuAhtHC4qcE4LibVdk4fPOJA
	 37dOlyB7OklDg==
Date: Tue, 25 Nov 2025 11:40:36 +0000
From: Will Deacon <will@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 15/16] srcu: Optimize SRCU-fast-updown for arm64
Message-ID: <aSWVtDcuyuw4DlvZ@willie-the-truck>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <20251105203216.2701005-15-paulmck@kernel.org>
 <aQ9AoauJKLYeYvrn@willie-the-truck>
 <d53a5852-f84a-4dae-9bf4-312751880452@paulmck-laptop>
 <aRHLV8lLX0fxQICR@willie-the-truck>
 <ab6cd1c2-39c5-4b39-9585-6123835a6229@paulmck-laptop>
 <aSRX1HKNdks5pHsd@willie-the-truck>
 <c632fb32-dccb-4c61-9b2e-d0c2b55fb2e4@paulmck-laptop>
 <aSTgh8B0SiKz2t5c@pavilion.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSTgh8B0SiKz2t5c@pavilion.home>

On Mon, Nov 24, 2025 at 11:47:35PM +0100, Frederic Weisbecker wrote:
> Le Mon, Nov 24, 2025 at 09:20:25AM -0800, Paul E. McKenney a écrit :
> > On Mon, Nov 24, 2025 at 01:04:20PM +0000, Will Deacon wrote:
> > > It landed in Linus' tree here:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64?id=535fdfc5a228524552ee8810c9175e877e127c27
> > 
> > Again, thank you, and Breno has started backporting it for use in
> > our fleet.
> > 
> > > Please can you drop the SRCU change from -next? It still shows up in
> > > 20251121.
> > 
> > This one?
> > 
> > 11f748499236 ("srcu: Optimize SRCU-fast-updown for arm64")
> > 
> > if so, Frederic, could you please drop this commit?
> 
> Dropped, thanks!
> 
> (And I'm glad to do so given how error-prone it can be).

Thank you, both!

Will

