Return-Path: <bpf+bounces-40266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68178984A2C
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 19:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998E11C22A84
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 17:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E581ABEDD;
	Tue, 24 Sep 2024 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FN6GP3SU"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC41B85D2;
	Tue, 24 Sep 2024 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727198143; cv=none; b=FoZizrFJLEnkge/Hj6jhD91bYqO4y7yD7X9Ha9A0JoJVk2kOYnqPE/BLDzwFQiaojkhhJdcJm3cTNnsVi6S+z+RgdGPYd3JGCQIedIo1O9B0f3esS+ZhuDsvz1Sz7YhgJKGTgjkuQrI7WcTtoNcOrtRDSgUr42rlPNjbkaCt/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727198143; c=relaxed/simple;
	bh=qBXWmQulj4+bRaY1j5WtgTi0EYtaH2UYJLpcDVwM6qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLKc4LALs1AiEzub3NXiMCCqrW++A6wzdrxryauB0KjopdReQnK25bmXr+fVZRF+QekWNUUrO901YCeb3p3iyS3mqrl9HFnZ01YEzue0Lt3sIGafFSHzZaHrf5t0wRGsdCgg0KqXTR+3u7mlkvC75NulzVR/ykhcJtGRKrzEvT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FN6GP3SU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WJowBGyKSbxzXE1/4SfIgV1cnZ3niSXTshohFumyVyo=; b=FN6GP3SU7IBOOqvdNF+Slvk/CW
	icGmhjkq8DxlxknZq1FtXL5hFEmEOuHet7Yc8T3Xmoc89NetMzgIjgkuIxyrKMCWJURKscgz4VWDh
	01eRl3ZHrOt4DXCSKHJ23AnnZh4DRGlt12o3ma18+lZavmWoALXY6obv91jnEN7LfDxnbNdzOo8b+
	1TMMXRdTdv3baEQrq/ryN8fjj7btYQg+SBPKAxYvGxJBdwq/X9j6Wbna+dH4rShmywnqbfQ3VXaWX
	uxmA9xdOYlW7VuUZQtlbx8TvHaWZbbMjRoDh5vULaygl/Uf9weJ+0BADHCNR6BAH8XVA4XmjG0jJm
	QlTxjDUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1st98T-0000000253H-3S3Y;
	Tue, 24 Sep 2024 17:15:37 +0000
Date: Tue, 24 Sep 2024 18:15:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jann Horn <jannh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	mjguzik@gmail.com, brauner@kernel.org, andrii@kernel.org
Subject: Re: [PATCH v2 1/1] mm: introduce mmap_lock_speculation_{start|end}
Message-ID: <ZvLzueEY9Sbyz1H4@casper.infradead.org>
References: <CAJuCfpFFqqUWYOob_WYG_aY=PurnKvZjxznnx7V0=ESbNzHr_w@mail.gmail.com>
 <20240912210222.186542-1-surenb@google.com>
 <CAG48ez131NJWvo_RrxL7Ss0p4jd_aKOu71z1vm9wfaH7Qjn+qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez131NJWvo_RrxL7Ss0p4jd_aKOu71z1vm9wfaH7Qjn+qw@mail.gmail.com>

On Fri, Sep 13, 2024 at 12:52:39AM +0200, Jann Horn wrote:
> FWIW, I would still feel happier if this was a 64-bit number, though I
> guess at least with uprobes the attack surface is not that large even
> if you can wrap that counter... 2^31 counter increments are not all
> that much, especially if someone introduces a kernel path in the
> future that lets you repeatedly take the mmap_lock for writing within
> a single syscall without doing much work, or maybe on some machine
> where syscalls are really fast. I really don't like hinging memory
> safety on how fast or slow some piece of code can run, unless we can
> make strong arguments about it based on how many memory writes a CPU
> core is capable of doing per second or stuff like that.

You could repeatedly call munmap(1, 0) which will take the
mmap_write_lock, do no work and call mmap_write_unlock().  We could
fix that by moving the start/len validation outside the
mmap_write_lock(), but it won't increase the path length by much.
How many syscalls can we do per second?
https://blogs.oracle.com/linux/post/syscall-latency suggests 217ns per
syscall, so we'll be close to 4.6m syscalls/second or 466 seconds (7
minutes, 46 seconds).

