Return-Path: <bpf+bounces-77380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CCECDA655
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 20:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6B47300A858
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768753093AE;
	Tue, 23 Dec 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eU9K0RjU"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2A199EAD
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766519192; cv=none; b=VJn7Gx/EsnX5DrUcc0VEvu8jBPha+kMZ+BnzmyxesuZ4788q6sxXi1QoUGFDfa4mOIzWJB+IZcK8gp7B3NPM//swvVMB17458KslHIuu4pcYQRtpJwKUoqxRjXI8EKK+GWTeuie++2ghJ7B50V6iTJ52MHmpT2bjVjALHXZ8C8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766519192; c=relaxed/simple;
	bh=1OziSPJS2KyXe8QgN4pumgHdfr+6YRnhUOLvgwJcuso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZh+aNGfhvGWRinmBXSHnPJ1YrNcC4R9DAHAjM3FmMgz5vp0o9FdJQ2EGCgp/ohMcjbJQNw71WCtuclu4Z7loVu+hE9gZZR8NJKx168lARsL8dxYEpLeXtEyEtyePmCWxn8T9/0hQx2cyB5nb+OtPgdcn7EWMF6F+ZuPrnjQ860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eU9K0RjU; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 23 Dec 2025 11:46:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766519187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6vzEZcO5hVRV8zIXh0SZ6K9qj2jT+ZzhCbLviEbk4mk=;
	b=eU9K0RjU0zeKvccQ9oR5fEIkzhnG8y76apeoFH01jiVk905Jwv1zT6cFYhRE8YRkQBEbWA
	V9pkhZQ00aBkVdRlwTyfU2uMoqHr68W30/+CIZ4hRWeI3kcX4BlCgNts+t1PN3/GNOSGU0
	hxp7Me3b8nWtiUVNDnuP4BfYV+IhVPY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v4 0/6] mm: bpf kfuncs to access memcg data
Message-ID: <gy7vymh74pfh2oeo7ge3d27rkctbumunrkfcsqnhsl5jafs6yv@weu5dmztpvz4>
References: <20251223044156.208250-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223044156.208250-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 22, 2025 at 08:41:50PM -0800, Roman Gushchin wrote:
> Introduce kfuncs to simplify the access to the memcg data.
> These kfuncs can be used to accelerate monitoring use cases and
> for implementing custom OOM policies once BPF OOM is landed.
> 
> This patchset was separated out from the BPF OOM patchset to simplify
> the logistics and accelerate the landing of the part which is useful
> by itself. No functional changes since BPF OOM v2.

For the series:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

