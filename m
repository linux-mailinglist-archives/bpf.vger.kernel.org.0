Return-Path: <bpf+bounces-77204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B76FCD2030
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 22:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47F003093F98
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 21:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11E2344042;
	Fri, 19 Dec 2025 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I5Mdiaaw"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84C0274B51
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180154; cv=none; b=ZTyrKiKb0NKwJ3IHtG0ySKiUsS67Qzo4dopLhI/SkrRsICwjYlIThWM8WMMJUqi2Hbl0f/oTtg4yexYI5EAcF8UJ0l0FcYeCPb2ufW3NDAtO6SoNDGnPUpoquW2jIjr5A0zzsJB4JqXOAAXR5FqQARa4vvUJlY77n7m2As9YyjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180154; c=relaxed/simple;
	bh=rGh6MCNB4cwwnSZkbd4Kc0BcCaqNLQXoEeCBxCKIWXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mm4DtH0Zukuypw6hG8h+zknaDb6Cba+CQTZv97OBQRJAq9WVxRoqRSIU4SOT6t90w71VAQqDXY36B+IDMmx7l2HjEfSqg1WihVlgvKvq0gMItyElALm7RBwRGIiYv4lblh2SmkZcMAejOGDRXs4zctBPUOZcSmtmGQaSIa5+3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I5Mdiaaw; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 13:35:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766180144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hoY9/IDcgFQdzsApEf17OR3pJa8dK+OXIdOuLfuVqnA=;
	b=I5MdiaawFm8qPOQQo9LcDHYaUjyC5kT2hNwWSTXfITTiXKp8swl9KXW3F4PBpC3nnpZkWg
	1KJ8Jzmmgq4r/XeCqBtf5xgx4woKyXnLtPIRceiyRx+xelKUjteGOxYi/gJsKCmbz6iKWB
	JJgemPTAhHS30jZL64NRmZ5JoLrVw4E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH bpf-next v1 1/6] mm: declare memcg_page_state_output() in
 memcontrol.h
Message-ID: <rew7yioifnkg3br2upmfqe7ikol7cju5yysa6wx73vjmzxtthr@q6zw6a6m7plq>
References: <20251219015750.23732-1-roman.gushchin@linux.dev>
 <20251219015750.23732-2-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219015750.23732-2-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 18, 2025 at 05:57:45PM -0800, Roman Gushchin wrote:
> To use memcg_page_state_output() in bpf_memcontrol.c move the
> declaration from v1-specific memcontrol-v1.h to memcontrol.h.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

