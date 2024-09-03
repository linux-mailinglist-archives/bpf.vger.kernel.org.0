Return-Path: <bpf+bounces-38773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6999969EEC
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 15:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925481F24FF2
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 13:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369F1188010;
	Tue,  3 Sep 2024 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IEEeFUM3"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102561CA690;
	Tue,  3 Sep 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369672; cv=none; b=NJxPkJQHSYzlIhjI9O3A+WR3Bvv7GSTwolZwZunEXVPibUZKVo7H5tbBq2c5oIY+LxmEGxaEI3RrOz1JzgIQai6cDjlA/pJSeBPVYf43tVUREcF/HcGs+jGQ2O5CranDuYsXxH2Iq3roaXHFlaaBUDIVVgRtjxODnCkgtjl6KiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369672; c=relaxed/simple;
	bh=dHhlrEFwbRxkjtHs3ZKFTkvOPcWuAhJ0IOGksPzPY5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jae7Mlf7kjB8ZzOoz7aRW53nNmEVWQx1o7Vtw0jyNiLNuCGZcfL32CAKgH/ukoZIIsQ2EseYdb0xEh4Rcv8fx/popQaK5Jp3pjlj4eVFS5OxqWDiooHImXoRcfAqoBjYFKAtNUxcDgIbfD9B8oh2WqwYa4jUaitfpunm7TQISJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IEEeFUM3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=shDKnG0dPktgg3ItOIAvP1fgIyBWxt5km4UrHeqmXgM=; b=IEEeFUM3MBmpCgF1/SnRthmzDo
	u+Yl0VLDhvD3iNKzkgFq6CqoLxQvVVwo2mfpi5tsjU7tAEpzssgcGdV2FxlOv0cLgA/wHE8TtO8Jz
	aRxwzRb4cy6pKAw66MIiTkqdhbYf5/aJuFHPcmxWs1W2tKI8C0dZPT/0bfgH6bxIzo2zrcITJODd/
	KTJJXEeLuABX6zuVvNZjhgJpZSE4JQ/FeA+TdjkwR/41vdu28Am38jzxhu8py7bU10KhhYqCkSxRR
	KY1H1pdDqEDNR7p/2osa6lcU9BQKwNifY0UJBJoF2+DuhRwRSK6J1QH1G1fR+jAXjWqNFXJ5B4hSY
	9Ux3pwcg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slTSx-0000000CKje-419l;
	Tue, 03 Sep 2024 13:21:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3A26530050D; Tue,  3 Sep 2024 15:21:03 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:21:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 0/8] uprobes: RCU-protected hot path optimizations
Message-ID: <20240903132103.GV4723@noisy.programming.kicks-ass.net>
References: <20240829183741.3331213-1-andrii@kernel.org>
 <20240830102400.GA20163@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830102400.GA20163@redhat.com>

On Fri, Aug 30, 2024 at 12:24:01PM +0200, Oleg Nesterov wrote:
> On 08/29, Andrii Nakryiko wrote:
> >
> > v3->v4:
> >   - added back consumer_rwsem into consumer_del(), which was accidentally
> >     omitted earlier (Jiri);
> 
> still,
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 

Let me go queue this in perf/core then. Thanks!

