Return-Path: <bpf+bounces-56907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73C9AA02F5
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 08:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837F0842A6B
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 06:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BCC278E51;
	Tue, 29 Apr 2025 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V3tN3Bji"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149812749C2
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907352; cv=none; b=mXltRhrmyEj46r49TBe881K+aDA0w/AUUAE7kLGXiroIypbxJUk/sniWlmPUKzj+NpsLdlitTWdQ4mbL0UMm7KRvLzECZmKR3xiJhMsV/sWAQw8Bj3o0tVRmYPRgwNtVUM7AEaVclxnaew36CFzliD3/ZdF6DyiP85rE1L1CfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907352; c=relaxed/simple;
	bh=uSXZ8k5J9YzV5lHhd16LgKhvunzwi9SEfs7bVrIf7sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khulAYcXr0RfNBmK0sEYOMhXTTGBt5lbZLufij+nhDVKy6ItR8EkdpsRe83eaPaX/GNxf1tcQ4GAmzWK60TuSz3yeO9fsJkiS3P382RMnWv2kO8BfR6ZCJu2KKsj7SDykY3/Dlp3T+9ENBFgkTB8Ipm0MzkGKPR1B1BxPfOMn3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V3tN3Bji; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 28 Apr 2025 23:15:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745907339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uSXZ8k5J9YzV5lHhd16LgKhvunzwi9SEfs7bVrIf7sE=;
	b=V3tN3Bji80yaYHi55cE+tb0//VwtEYn3YaKTa6QEXFIjA7wzFaz8vvu+r6NHwmWsEQJDSO
	Q9ESdIdYcdx++JP+kV94quHtfAb1DD46miuY0g3/c0tqb6BZrn2ESTllFIODjEeE1IT1o6
	ARWg1+qTFavSgc33tYMoklaYKrr02Dc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	JP Kobryn <inwardvessel@gmail.com>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [OFFLIST PATCH 1/2] cgroup: use separate rstat trees for each
 subsystem
Message-ID: <kqwir45ryv427266yvtt7vmocqysesns7lrjxjvrt4kp3bxulo@giiqtzykumv4>
References: <20250429061211.1295443-1-shakeel.butt@linux.dev>
 <20250428174943.69803-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428174943.69803-1-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

Please ignore this patch as it was sent by mistake.

