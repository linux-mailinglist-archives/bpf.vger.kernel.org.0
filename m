Return-Path: <bpf+bounces-53744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E51A59A97
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 17:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9AD1888E5E
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0D722B8AC;
	Mon, 10 Mar 2025 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="obSrsY9Q"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D5922A4F6
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622625; cv=none; b=NaSX/fGssJrHk2iiF2RgfEJxt1SFc7w/3pMnxIaLKoT4HdbHbuXya5NFIBpEpS4x8aDMjg6MrYhJHNSZOgGQs86u2vftxkeR0bMQJ4qbfdPCWdUEgVn/FIOhuGg7vZgMzsZ3ZNI1bPbELK1isnCNboBPbzBkTaoYEVz4ew9q+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622625; c=relaxed/simple;
	bh=P0UBYSOXgyZE2jqr07c2dsyGOk5aTg+T83X+NNWm89g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkUasUuq8iYydt0Lb5HNZNqwum2MYPVg6oTjrzwgV2owZRFK+PW8iui7NYTJew0l44JD/dff5xOd8mPdE1Ix0yJiI6/s4hwBAJNTg5vhY39vKl+5BBN3ZwOwqkjdgbWlkuzlfbkgWzYUubMtc/U+6SeqdLI2GSBvbzAuGhj/VwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=obSrsY9Q; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Mar 2025 09:03:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741622621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jDP8foTVVgk27fqQaSRqxaSXV1ijBYALJsl4BoAz1bE=;
	b=obSrsY9Q97HdSqEmKqeolS+XkYBSyN7EaQHYpUEITAXPONDlf9Nr6cxU426aTqIl67D+09
	oVvaHRuZzzkiDMR9tpP806tAnXmgjnJeZnotomz+SPimn3rvtIPODV9uMFF5BIsj22P+h7
	MN419vfAxyVFFJKNPDvzL2XD2mozcCI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] mm: Fix the flipped condition in
 gfpflags_allow_spinning()
Message-ID: <yrmfflkuyn34a4qngucou4fyfc3wcb7uhyd7tz3jthfonrvz2n@ewuedxmgr7ga>
References: <202503101254.cfd454df-lkp@intel.com>
 <7c41d8d7-7d5a-4c3d-97b3-23642e376ff9@suse.cz>
 <CAADnVQ+NKZtNxS+jBW=tMnmca18S2jfuGCR+ap1bPHYyhxy6HQ@mail.gmail.com>
 <a30e2c60-e01b-4eac-8a40-e7a73abebfd3@suse.cz>
 <CAADnVQ+g=VN6cOVzhF2ory0isXEc52W8fKx4KdwpYfOMvk372A@mail.gmail.com>
 <9d8f5f92-5f4b-4732-af48-3ecaa41af81a@suse.cz>
 <CAADnVQ+MCxQsrVWC_DmQfwBxwv8pUw_9gXFJmO54Syybwwp6oQ@mail.gmail.com>
 <CAADnVQ+XGfYX0EzLJMVYDa05zY3DS4Ahvpq0XkKuzifwTJdY9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+XGfYX0EzLJMVYDa05zY3DS4Ahvpq0XkKuzifwTJdY9w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 10, 2025 at 01:16:45PM +0100, Alexei Starovoitov wrote:
> From 69b3d1631645c82d9d88f17fb01184d24034df2b Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Mon, 10 Mar 2025 11:57:52 +0100
> Subject: [PATCH] mm: Fix the flipped condition in gfpflags_allow_spinning()
> 
> The function gfpflags_allow_spinning() has a bug that makes it return
> the opposite result than intended. This could contribute to deadlocks as
> usage profilerates, for now it was noticed as a performance regression
> due to try_charge_memcg() not refilling memcg stock when it could. Fix
> the flipped condition.
> 
> Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for
> opportunistic page allocation")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202503101254.cfd454df-lkp@intel.com
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

