Return-Path: <bpf+bounces-62689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F162AFCDC5
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 16:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90182580A9E
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 14:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E822E0405;
	Tue,  8 Jul 2025 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW0lNDp6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BE213957E;
	Tue,  8 Jul 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985280; cv=none; b=KuwekP+zOO207VR/KxXCa+BCVYX3ryp+V9CLsOu0sKOHddL+cBabWhPzWPqFrc8yJ/Yv9Mv32O2LRYy8+2AjQJzEQ7FBjB+X5tJWhYyqgtYrYg9BL74Ex+iVwM81EYI6fZKLRk98g81mkMLJ+3GM4bAauVHsJlfn+xbbXzwpL3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985280; c=relaxed/simple;
	bh=wszQK8fm1ArUjjQQdCE2DZm7Xw6xIb92NR0FqLsutXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEYQjrIdRypdMii8o9Na9Pf++eQ+2sksd/Z8WjQhoaHvNqnuIXHD/uKGCrWp5yWvkCWnyIAqLXWh7CIuDyXs2S4pokUQZEoBTlFVJ+qw1ip1GWgF5qumutb3KQTTPhMHju+BEjdiWXyeH9fc6EdeyIurfbdRZ9ihUy0oD2ZSF7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW0lNDp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22FBC4CEED;
	Tue,  8 Jul 2025 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751985280;
	bh=wszQK8fm1ArUjjQQdCE2DZm7Xw6xIb92NR0FqLsutXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QW0lNDp64mrDGBM6oPe7z9/DiWNW0P4nMJ7y4O0CXD+3y9YwScw9iqKVK2yiZk+kk
	 D4Xmznt4uPSZJVcqDDBwwvZ+R36X35yQM9FDJgcNyMG0jUUsoWuvy+Wx+GBfzIJo/1
	 aWSew4MoJLLlKB7MOz97avPaBFTK1q2mnAYssE9OKzZ1f0aIHL/saJGrQR8ErFmDYW
	 +NPv7SmkneXwFmHtbYWXtjRDMcF6a61+PcBbOrGfmT6WF20LZM2CBcmEAwl80OvLTY
	 iUwqCTGlJo33FmJiDmwIqjibXJ4t0G2sd72v9zadn24nsSuj+svnKNV/5mnx4JT4ki
	 dQG2CGdtwh8Ww==
Date: Tue, 8 Jul 2025 07:34:36 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v8 10/12] unwind_user/sframe: Enable debugging in uaccess
 regions
Message-ID: <orpxec72lzxzkwhcu3gateqbcw6cdlojxvxmvopa2jxr67d4az@rvgfflvrbzk5>
References: <20250708021115.894007410@kernel.org>
 <20250708021200.058879671@kernel.org>
 <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
 <20250708092351.4548c613@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708092351.4548c613@gandalf.local.home>

On Tue, Jul 08, 2025 at 09:23:51AM -0400, Steven Rostedt wrote:
> On Mon, 7 Jul 2025 20:38:35 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Mon, 7 Jul 2025 at 19:12, Steven Rostedt <rostedt@kernel.org> wrote:
> 
> > This patch is disgusting, in other words. It's wrong. STOP IT.
> > 
> 
> No problem, I can easily drop it.
> 
> I just took Josh's PoC patches and posted them. This particular series
> still needs a bit of work. That's one of the reasons I split it out of the
> other series. The core series is at the stage for acceptance and looking
> for feedback from other maintainers. This series is still a work in
> progress. Others have asked me to post them so they can start playing with
> it.
> 
> We still need to come up with a system call with a robust API to allow the
> dynamic linker to tell the kernel where the SFrames are for the libraries
> it loads. Hence the "DO NOT APPLY" patch at the end (which I just noticed the
> subject text got dropped when I pulled it into git from patchwork and sent
> out this version, at least the change long still suggest it shouldn't be
> applied).
> 
> But I will remove this patch from the queue. I never even used this
> debugging. What I did was inject trace_printk() all over the place to make
> sure it was working as expected.

I had found those debug printks really useful for debugging
corrupt/missing .sframe data, but yeah, this patch is ridiculously bad.
Sorry for putting that out into the world ;-)

And those are all error paths, so it's rather pointless to do that whole
uaccess disable/enable/disable dance.

So yeah, drop it for now and I can replace it with something better
later on.

-- 
Josh

