Return-Path: <bpf+bounces-52595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81581A45156
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 01:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2446D189FEC3
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 00:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C918B8F6B;
	Wed, 26 Feb 2025 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="cxXdZ6Xs"
X-Original-To: bpf@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CEDB67A
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740529069; cv=none; b=mJ8HsW7dMcKoRYtzyft6GzeFus4QJTbxcY9pvdhnrEF+pC+yLyMgtXqB/oTEEg6AU3d54grtRt2b5icY0RXVjSZ1muscOA828hxFXNPQYjrHkgsAvWXFxqLbtovq18pKzX5fSQSTxYzndPdi5wWBqw5BCaxN4e5z/rWXP6M6MTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740529069; c=relaxed/simple;
	bh=JqtvX/GAnigh8qhIsbXu+YjWzqwKsOTCbDk5t5lrV2A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jldHiy/agYh++DIZOtlTI/1XSXWDXtTxUpl/ZuYHeT2L8atsFTnkGTgHiDHjm5xbpxlE6o+pBLG0mP9HXWsKPbjxTDRWdwDAGIbIpGmwoZInpnQoBPu0SDUoyYBStcjp7mBGNDmlMndNRlQAfzvTZU1lhO7fiOKV+AzwTHLUA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=cxXdZ6Xs; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1740529061;
	bh=JqtvX/GAnigh8qhIsbXu+YjWzqwKsOTCbDk5t5lrV2A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=cxXdZ6XsGMUvuy1BRqnCd5bkgbQ5oVDPQ4067KTsca5HXJxEcB+y4md31h5BFPmfS
	 pZGYLKjmtdd6HMEKoVirHJPXsdjVTzE4ijOYAHktYywgzAQelGQI7BpE/bGBv9q8vV
	 E+HynTbihMK4CG62CzdPRWgA9tRym+EHjTxMw4Nk=
Received: by gentwo.org (Postfix, from userid 1003)
	id F418B4025D; Tue, 25 Feb 2025 16:17:40 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id F03CF4010D;
	Tue, 25 Feb 2025 16:17:40 -0800 (PST)
Date: Tue, 25 Feb 2025 16:17:40 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Vlastimil Babka <vbabka@suse.cz>
cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
    bpf <bpf@vger.kernel.org>, David Rientjes <rientjes@google.com>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    "Uladzislau Rezki (Sony)" <urezki@gmail.com>, 
    Alexei Starovoitov <ast@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] SLUB allocator, mainly the sheaves caching
 layer
In-Reply-To: <14422cf1-4a63-4115-87cb-92685e7dd91b@suse.cz>
Message-ID: <ddcf9941-80c5-f2bd-1ef6-1336fe43272c@gentwo.org>
References: <14422cf1-4a63-4115-87cb-92685e7dd91b@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


Let me just express my general concern. SLUB was written because SLAB
became a Byzantine mess with layer upon layer of debugging and queues
here and there and with "maintenance" for these queues going on every 2
seconds staggered on all processors. This caused a degree of OS noise that
caused HPC jobs (and today we see similar issues with AI jobs) to not be
able to accomplish a deterministic rendezvous. On some large machines
we had ~10% of the whole memory vanish into one of the other queue on boot
up with  the customers being a bit upset were all the expensive memory
went.

It seems that were have nearly recreated the old nightmare again.

I would suggest rewriting the whole allocator once again trying to
simplify things as much as possible and isolating specialized allocator
functionality needed for some subsystems into different APIs.

The main allocation / free path needs to be as simple and as efficient as
possible. It may not be possible to accomplish something like that given
all the special casing that we have been pushing into it. Also consider the
runtime security measures and verification stuff that is on by default at
runtime as well.

