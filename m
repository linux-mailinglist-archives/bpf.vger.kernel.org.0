Return-Path: <bpf+bounces-62393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAC0AF8DB7
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 11:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD92767D85
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936362F85E0;
	Fri,  4 Jul 2025 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Vw4T7YWj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3121A2BE7B1;
	Fri,  4 Jul 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619650; cv=none; b=Cw10DNv//STuyObbf+HtJTvc0jcXJGawXFG8Jzi7kTtniLtDJG/1DQZNlPs2rutd1TLKfe68szXxE6Z3HpznLUQBzxGC6YpZSxgD6VwF1p6N8mTVgutDINAhBVGOdbxNhjppeyzDr5Uo75fvhDdW64xDyNE/6UwWBmjvFEPQ4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619650; c=relaxed/simple;
	bh=cLwWQyrB0mwed4cU0+cVqyYgNBtoPEX59tc7uNEyzC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRQ5L9D/eljrhxDMoZ/+XrUhPoDJuI60Hm+1o2/liVRZndPCY3fZ53TiaWpSqBJTdEbOUyWC8yfUQmZotoxHiaevA9KU7HUUY7vzc/H7xfxGf//oZbBGIZ8R44QhaP6WG3gh9u+b+PoGq3GFzxSoAJkgVZp3UOjGQWDMvKuL0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Vw4T7YWj; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bYSK33ksszLpZ;
	Fri,  4 Jul 2025 11:00:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1751619639;
	bh=d3B0Gl5NVIkFKbxEnnnoas390sBQL3HhXfp2/141yac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vw4T7YWjqqarK0hzIK+mYBSKByM3YmZa15/CNzENwM488+YCclY06+Q7b2iMPxEv0
	 Xyj5R7UTvG9FaWdeQRu/kX4AFt4xvHq2VHqL2zBxyvlCFJQDGE3BwnkgfWY27g+ihH
	 mpqujgWOXcwyos0XAMuUxRVDESIVsKIwzrUgYKtQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bYSK21vkQzMBN;
	Fri,  4 Jul 2025 11:00:38 +0200 (CEST)
Date: Fri, 4 Jul 2025 11:00:37 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "m@maowtm.org" <m@maowtm.org>, 
	"neil@brown.name" <neil@brown.name>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v5 bpf-next 2/5] landlock: Use path_walk_parent()
Message-ID: <20250704.quio1ceil4Xi@digikod.net>
References: <20250617061116.3681325-1-song@kernel.org>
 <20250617061116.3681325-3-song@kernel.org>
 <20250703.ogh0eis8Ahxu@digikod.net>
 <C62BF1A0-8A3C-4B58-8CC8-5BD1A17B1BDB@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C62BF1A0-8A3C-4B58-8CC8-5BD1A17B1BDB@meta.com>
X-Infomaniak-Routing: alpha

On Thu, Jul 03, 2025 at 10:27:02PM +0000, Song Liu wrote:
> Hi Mickaël,
> 
> > On Jul 3, 2025, at 11:29 AM, Mickaël Salaün <mic@digikod.net> wrote:
> > 
> > On Mon, Jun 16, 2025 at 11:11:13PM -0700, Song Liu wrote:
> >> Use path_walk_parent() to walk a path up to its parent.
> >> 
> >> No functional changes intended.
> > 
> > Using this helper actualy fixes the issue highlighted by Al.  Even if it
> > was reported after the first version of this patch series, the issue
> > should be explained in the commit message and these tags should be
> > added:
> > 
> > Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> > Closes: https://lore.kernel.org/r/20250529231018.GP2023217@ZenIV 
> > Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
> > 
> > I like this new helper but we should have a clear plan to be able to
> > call such helper in a RCU read-side critical section before we merge
> > this series.  We're still waiting for Christian.
> > 
> > I sent a patch to fix the handling of disconnected directories for
> > Landlock, and it will need to be backported:
> > https://lore.kernel.org/all/20250701183812.3201231-1-mic@digikod.net/
> > Unfortunately a rebase would be needed for the path_walk_parent patch,
> > but I can take it in my tree if everyone is OK.
> 
> The fix above also touches VFS code (makes path_connected available 
> out of namei.c. It probably should also go through VFS tree? 
> 
> Maybe you can send 1/5 and 2/5 of this set (with necessary changes) 
> and your fix together to VFS tree. Then, I will see how to route the
> BPF side patches. 

That could work, but because it would be much more Landlock-specific
code than VFS-specific code, and there will probably be a few versions
of my fixes, I'd prefer to keep this into my tree if VFS folks are OK.
BTW, my fixes already touch the VFS subsystem a bit.

However, as pointed out in my previous email, the disconnected directory
case should be carefully considered for the path_walk_parent() users to
avoid BPF LSM programs having the same issue I'm fixing for Landlock.
The safe approaches I can think of to avoid this issue for BPF programs
while making the interface efficient (by not calling path_connected()
after each path_walk_parent() call) is to either have some kind of
iterator as Tingmao proposed, or a callback function as Neil proposed.
The callback approach looks simpler and more future-proof, but I guess
you'll have to make it compatible with the eBPF runtime.  I think the
best approach would be to have a VFS API with a callback, and a BPF
helper (leveraging this VFS API) with an iterator state.

I'm aware that this disconnected directory fix might delay your patch
series, but the good news is that it's an opportunity for eBPF programs
to not have the issue I'm fixing for Landlock.

> 
> Thanks,
> Song
> 
> 

