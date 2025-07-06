Return-Path: <bpf+bounces-62417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8735AF9A0E
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 19:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AF25A7E44
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 17:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF8429E0E7;
	Fri,  4 Jul 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IZC9S11P"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D49202997
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651145; cv=none; b=CWNZuwpmQlgw9IXLHgpIyVhsJwbh5bYKCLZ3ymY0+0UtOZruv8FLjLMQvVnsNn+o7cMXa461dXOLcCbaRCNGDRHs2j+/2iHacUvhFG3WmAlzofaxwgfnuAypGgOmG3xIrRC5ZwXJ24Jkgf+EtsWQEy5y2hqMHL7Exvs/yBEHkDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651145; c=relaxed/simple;
	bh=8vPUhSXPelKn26TK9gtb7UrYo8Gk0tjL+OPwnLrRbI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iE8jPl/EsZSpN+hsoeDlN544ywFicyC1shxvAnvyKnVqqQC4NgBAzrN+eFdL96M5T31i/Vwn/uhpFuRkYDqJWOsZ3aZRL5DWao/ICGuG2tQX0Uvidthg7dlL5q7bnXsTru5d2TR234ykANwUHeLposXUc5kbujyAJ8P9DwyQF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IZC9S11P; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 4 Jul 2025 10:45:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751651132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MaDn6SelIXcOlzjJrgBEMydXIUt+Gwx/T0S+5DVJELc=;
	b=IZC9S11P2XdARLncSFnnb/REFrgQMKWLolXvqM87bpMZzsUPgw7lPqRk16eQsCHXnwwNb8
	I//dmFRKUx0PDAEUtxMbeL6rY+gHadt3bQK7G3UKLkyOdaTHnxPlNF+SirVNPYYvuyPyxp
	k8qoqDz/Z82+B+dz7tr+XKApM+0gkqg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Ying Huang <huang.ying.caritas@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/2] cgroup: explain the race between updater and flusher
Message-ID: <edyai2zhaommoe6bqj6tggpp3eu5c6b4trv77vqmktjczkzcrd@ad55qjptzkd6>
References: <20250703200012.3734798-1-shakeel.butt@linux.dev>
 <20250703200012.3734798-2-shakeel.butt@linux.dev>
 <ae928815-d3ba-4ae4-aa8a-67e1dee899ec@paulmck-laptop>
 <l3ta543lv3fn3qhcbokmt2ihmkynkfsv3wz2hmrgsfxu4epwgg@udpv5a4aai7t>
 <f6900de7-bfab-47da-b29d-138c75c172fd@paulmck-laptop>
 <CAGj-7pUdbtumOmfmW52F3aHJfkd5F+nGeH5LAf5muKqYR+xV-w@mail.gmail.com>
 <da934450-db48-4ef9-ac1b-6b3fbb412862@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da934450-db48-4ef9-ac1b-6b3fbb412862@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 03, 2025 at 09:44:58PM -0700, Paul E. McKenney wrote:
[...]
> > 
> > Thanks a lot Paul for the awesome explanation. Do you think keeping
> > data_race() here would be harmful in a sense that it might cause
> > confusion in future?
> 
> Yes, plus it might incorrectly suppress a KCSAN warning for a very
> real bug.  So I strongly recommend removing the data_race() in this case.
> 

I will remove data_race() tags but keep the comments and squash into the
first one. I will keep your reviewed-by tag unless you disagree.

thanks,
Shakeel

