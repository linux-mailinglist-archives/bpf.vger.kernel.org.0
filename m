Return-Path: <bpf+bounces-67724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9C9B4942D
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBE84C1F1B
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5253112C4;
	Mon,  8 Sep 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZV9Bc2V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F830EF99;
	Mon,  8 Sep 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346238; cv=none; b=CCpyx0a4MUIrP/fo0mAUvYJf4ejVSk7vHhcxf4Ga4EuvYcH3F3bsFNaNlsT6Xim1JjJG9InulrU8QTjUBH39bcqmncVOZxGBChMQNg4kxQgQE5DMXHJYNgGnl3Q5PIeWCs3DCdR03NVapWRtbtjra9ab20EjEyI6R7Y1R9zzJ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346238; c=relaxed/simple;
	bh=O+GqvBl37vVGKUkF14V2sGgLUL3STC2FU7lgdKw3bdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOjUs5HYXMNOrbHUQfnL8OlRclF6fY1g8BnY4y0MIzyrW7r3jtptlK1c4ybBj7bH11/L/GhZ5H62aV5lcBGmO5B+SGQpmA4RdxaQIl6cp/hjOKdX2duUS+c5UUk3XjAYYh+aS4c85H10A6ICuY/dt6e0tfxzcyDmUEUkd0q+XB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZV9Bc2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED2AC4CEF1;
	Mon,  8 Sep 2025 15:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346237;
	bh=O+GqvBl37vVGKUkF14V2sGgLUL3STC2FU7lgdKw3bdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZV9Bc2VTRw9zY6xD5WAsmvpnzdhNBVqfITjqLY8z0bdjWiuPhUPfc+GPrkQJVAXv
	 eZyu7nz79b0olB8T2jrJe4F2bUnP4Jn2UDEHWT3v1u/80tRiNX5dWnXVXHFlwuvp8I
	 qUn/G9XCRCsYjAz556+t9CitQgKHmv8Q1ajXB4D5sw4hGOsWeC/GyRPPx+D0EhIGHs
	 LZBLGBasmt1YDAvxnX9vwopH5sTh8minyuh9AjLUZaxteBs/p8PrbGoUYQYYPTF8Lz
	 ulYMualLzyQhLKe+xe+AiOllG6/7VYpceHVo4TDQ8yPajLxCCy52G7EiWUvDxNx6a6
	 xKhz5p0OivdSQ==
Date: Mon, 8 Sep 2025 05:43:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 0/3] bpf: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
Message-ID: <aL75vF5aPYu0HeCM@slm.duckdns.org>
References: <20250905085309.94596-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905085309.94596-1-marco.crivellari@suse.com>

On Fri, Sep 05, 2025 at 10:53:06AM +0200, Marco Crivellari wrote:
...
> Marco Crivellari (3):
>   bpf: replace use of system_wq with system_percpu_wq
>   bpf: replace use of system_unbound_wq with system_dfl_wq
>   bpf: WQ_PERCPU added to alloc_workqueue users

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

