Return-Path: <bpf+bounces-56908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95E2AA02F8
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 08:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A0A1B64507
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 06:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3700227CB18;
	Tue, 29 Apr 2025 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uvJVYtl3"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C37275878;
	Tue, 29 Apr 2025 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907367; cv=none; b=QB6S9C96lFz8F+wox1AjTQx2lDkWETDXy5yNMe/lvam8669wdR3i0AJORm1BbXqm7QSDdXO/1zZCkgHtJLKzUX39ayZX4rUISnCy3cAYftiOgy8DcI4RX+5wK6IbLrYsrll7RuRlS930C+4fyGBU1yfJCS0nGnaiPz6gOz4x2E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907367; c=relaxed/simple;
	bh=uSXZ8k5J9YzV5lHhd16LgKhvunzwi9SEfs7bVrIf7sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lh94VFYyZNQQEY5dx8W7Sknv7Z9ZcMlU9OV0AeNuDgLG46Gg8k8582/VL//PyXc8C3h1GuA+bHxd0UkQvWxySkzw5enlZNhve/vCbhAXvoI0B898dNQiqbqqANTbeGcp6R/fqjeW9hjWy4gJjkC6lirBrtDapJverbnEn2/8jLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uvJVYtl3; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 28 Apr 2025 23:15:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745907364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uSXZ8k5J9YzV5lHhd16LgKhvunzwi9SEfs7bVrIf7sE=;
	b=uvJVYtl3rwpS9Zx+T098xd950uosYMmZYepWQbnI4JXbFLu+OSKCuhjcd9Fp17Ohjdy8x4
	1bT2xB0GTMXGIFAJk3VMnc11CQ9fKMPFND8aQns1iILopZyPD7nBtNFzr/tgCsieLxCLOA
	LyfzurLzWFXAx4lG0jY8T0IBbIN4eIk=
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
Subject: Re: [OFFLIST PATCH 2/2] cgroup: use subsystem-specific rstat locks
 to avoid contention
Message-ID: <ad2otaw2zrzql4dch72fal6hlkyu2mt7h2eeg4rxgofzyxsb2f@7cfodklpbexu>
References: <20250428174943.69803-1-inwardvessel@gmail.com>
 <20250428174943.69803-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428174943.69803-2-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

Please ignore this patch as it was sent by mistake.

