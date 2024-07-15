Return-Path: <bpf+bounces-34822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C783931389
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 14:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7D61C21F94
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4F218A948;
	Mon, 15 Jul 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B5MvMV75"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C99446DB;
	Mon, 15 Jul 2024 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044801; cv=none; b=XukYFi0vZePAPHOWP2u2LltuYJJ9l+w9VPDmekzuc8chnWDsQkZQlCn6nYAdU+Bk8gv+NfJLGcG4XSnLnV0f3Xv22/GWPPr96+P+t8rgyiJhpOJANfoHGQm85b4fDjON2oj4b+EyOEpjPLfF14YB0K/XP1IuYQ+NxM6YkUIIoao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044801; c=relaxed/simple;
	bh=DpjUBrT659OvV7F4JubP2IsJgz38DBW2Ty8RgX0FSA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTEfxJ5FNWqSYAARAw5P3KxrGmJNU4LHJC0xLTMd9U+7dqs1NKRKtU3eqoT8g9OcfRIbzwjJEesAi8yvr6bRVmqNJuENQrAPSm7uLrTTmtixRznWHCd3tmxfiALMQDgfAc6saVZibi+sWVqzFgjIG5Lcofu3u70HF1q056v7wn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B5MvMV75; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FzVAGPWzIcjmOl5/kaUv3UbG8zfj+jsoUZvJXnkQAls=; b=B5MvMV75Ikl3htMoYx2wveDRi3
	07ApNyCcJygDHt47avviNr53SEqHxL37PVn9K/N4bG7MYknwNgBNnTZyL0JaYoD6/sGozbtoQtIpB
	9H0vrtFSlfRoOqMi3oz1uav9R5W3k7PGKP7rKhktr4756etLFG5J/N0vAD2ckY9wo0Sp2dSLXpJwP
	CwBQqKnmZWswMg0MPQ0AFkWG125as0nGZbR8ABDlPUBeqvsCCWig68IZjyFQurIcdo4+bz8nKlzfx
	87iE6BF4zMtk4UjULPH4qweJ7yRhowkFr08OoivqOVtGbwyJ8gUMtr/DZOfQ0mv78U6jD37M4uO0W
	UgASZ2Hg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTKN0-0000000FlDY-2MWh;
	Mon, 15 Jul 2024 11:59:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 36BCB3003FF; Mon, 15 Jul 2024 13:59:54 +0200 (CEST)
Date: Mon, 15 Jul 2024 13:59:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 10/11] perf/uprobe: Convert single-step and uretprobe
 to SRCU
Message-ID: <20240715115954.GH14400@noisy.programming.kicks-ass.net>
References: <20240711110235.098009979@infradead.org>
 <20240711110401.311168524@infradead.org>
 <CAEf4BzZW56pgTqy4POud8P3t5gtdg53BX83VbieixtS1T-mg2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZW56pgTqy4POud8P3t5gtdg53BX83VbieixtS1T-mg2w@mail.gmail.com>

On Fri, Jul 12, 2024 at 02:28:13PM -0700, Andrii Nakryiko wrote:

> > @@ -1814,7 +1822,7 @@ static int dup_utask(struct task_struct
> >                         return -ENOMEM;
> >
> >                 *n = *o;
> > -               get_uprobe(n->uprobe);
> > +               __srcu_clone_read_lock(&uretprobes_srcu, n->srcu_idx);
> 
> do we need to add this __srcu_clone_read_lock hack just to avoid
> taking a refcount in dup_utask (i.e., on process fork)? This is not
> that frequent and performance-sensitive case, so it seems like it
> should be fine to take refcount and avoid doing srcu_read_unlock() in
> a new process. Just like the case with long-running uretprobes where
> you convert SRCU lock into refcount.

Yes, I suppose that is now possible too. But it makes the patches harder
to split. Let me ponder that after I get it to pass your stress thing.

