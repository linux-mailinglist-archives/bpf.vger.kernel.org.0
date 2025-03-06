Return-Path: <bpf+bounces-53504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6CDA55612
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 19:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63E11732ED
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB24426D5B6;
	Thu,  6 Mar 2025 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYM86yF7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F62B26B0A9;
	Thu,  6 Mar 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287509; cv=none; b=CglQWQdXF93/Fj2HuqgOQxZYZlW/SBsKPofi0mNDX+RRHLX/ANgMgpeLzEhyFZmX1cOPhQLaH967nXDwQyQyxPu+S1jnbweQnmICdBFrigTOD5SDJNla6Mp0I+JgAoH0VmdLna/+2Ndyx9JQavLoIN5JYoUcHsc/RKmFe/szCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287509; c=relaxed/simple;
	bh=rwfUO0J9P1TXYdNPDAnZ1tOoZuZipVHA2cIDBBpGgwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXlLx6yxz+tteJkgkyflT8jhbOJ2R1m/rCLQeYmjzklyHZp1PPgvZkaCCzqscfqGVP7Eazdcc+rurW/tkhPOAq3Bf7wxV70SwNbNS4mS5Tw4QxWVYPMIFH1QgCK5uNG/wsTb88SENoIvvwfdnVAy7vJ5dYm8bkGVRjUBrV9lEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYM86yF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EA9C4CEE0;
	Thu,  6 Mar 2025 18:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741287508;
	bh=rwfUO0J9P1TXYdNPDAnZ1tOoZuZipVHA2cIDBBpGgwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYM86yF7UY3tYUmiu4z1JT5PFyThhjhlWBDGvAlh3eZT1srcpyCMXNmjZC+mSGmsv
	 G4CLvtQ+3zpSPz/UuKZ1lrBVNb1I+QGt84x90FssA9JL6OLa5vjbqn9AvdKfZoL2jq
	 G0oqWjARqV2G43OTRnU1hPa/NhK6JsqIbYfq9tKcf1Z2U6EFRdXlG8mltvqc5DWxfj
	 XHerBKYcXY4v+rgExH1M498NFxAU/PiUMu7ivsMu3YL1VgAPPppUiI8lYnkXMR2hDQ
	 c8j3FvgjFx8HRntq2ysrnbzGLqI5BdIenH/8n2PN0AqNPytrQgmowLkAswGLO0jfbc
	 zedRKRYSk9LPA==
Date: Thu, 6 Mar 2025 08:58:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-6.15] sched_ext: Enhance built-in idle
 selection with preferred CPUs
Message-ID: <Z8nwU3C-WiWN7eia@slm.duckdns.org>
References: <20250306182544.128649-1-arighi@nvidia.com>
 <Z8nqpyEQmmff9E8X@slm.duckdns.org>
 <Z8nvam-WarNqdLw9@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8nvam-WarNqdLw9@gpd3>

On Thu, Mar 06, 2025 at 07:54:34PM +0100, Andrea Righi wrote:
> Just to make sure I understand, you mean provide two separate kfuncs:
> scx_bpf_select_cpu_and() and scx_bpf_select_cpu_pref(), instead of
> introducing the flag?

Oh I meant just having scx_bpf_select_cpu_and(). The caller can just call it
twice for _pref() behavior, right?

Thanks.

-- 
tejun

