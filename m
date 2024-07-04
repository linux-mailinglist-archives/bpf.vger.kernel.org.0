Return-Path: <bpf+bounces-33860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C369271C5
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 10:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD181F23DCB
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 08:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673261A3BC7;
	Thu,  4 Jul 2024 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KnYa0YhU"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1414431;
	Thu,  4 Jul 2024 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081928; cv=none; b=ti9d1lql0NvT8al8RcG+v0vvPnRO6fZRIa8xtj3eOeObsU0B4sP1CheAoZ15DTghOQyOdSjog6sxlcjiZ169wJ4HynL4JmgV92laLu/L2oOext1Xg9RJgiPHLm9E1v6T57jUgdLJzPTBmVwz4DD6W6UM4j4GwdFXw9gdvCQmmQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081928; c=relaxed/simple;
	bh=KNuQLVjLkABbuu03VayNDbxbwTZI4sP8OQ2gllpWtPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afpIhaTDb3ynrCydDnTvrgVGk7c95s5cac/RvEBPEzB3f8AbUEaO1zhTjRv8FdSxmw6FKSgGoWgxVpXEQRlTx/BCnl8XE66vTYaM5hBM1Sw4BpUCR6kY4MEzSFZOKBD8HRuQL+4EUDSW8YHpU71EEhPhrb+aorwEqTiIcNr7PKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KnYa0YhU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=52GQ0OwU84c/EsgcPRLhiAQKKA5yN8M4dKQ/44eBLE4=; b=KnYa0YhUxzozgZWL6fe7326H26
	470uxv+bL0sCrMgiSznL/SbR75MJcNAmbL87Ows/vhSfofPBigirieJajM5OhJoqP83SraS1r/TMH
	fqkTrkDDMPPPzDcLGM2K3svHOFvcY8rB9aKxSawgeIpD0lLA3BUV6Nk95hz2Nv2frlEzGg+XZv2Oc
	uOJAwIQkSu0xfVhsaWpqiiN838YzBW3d/Ny2cA1YFTmsstsK1GZcoQsk6zxS14kIQk7vSmIlY/SU2
	5eLRmEehrszQRXuk+D0tSYbVuMTeGcLfaUkU8wNpRxqHPQEeT6++ZfiyOvCpV8VjXdHWr2c2gbFmo
	OsCy8vfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPHsi-0000000ACYn-04Da;
	Thu, 04 Jul 2024 08:31:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 12D193003FF; Thu,  4 Jul 2024 10:31:53 +0200 (CEST)
Date: Thu, 4 Jul 2024 10:31:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com,
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240704083152.GQ11386@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-5-andrii@kernel.org>
 <20240703133608.GO11386@noisy.programming.kicks-ass.net>
 <CAEf4BzZQQJGrC+tCbrU90JNpXxH8-vBg_c5GzjS=FLZp0PfExA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZQQJGrC+tCbrU90JNpXxH8-vBg_c5GzjS=FLZp0PfExA@mail.gmail.com>

On Wed, Jul 03, 2024 at 01:47:23PM -0700, Andrii Nakryiko wrote:

> > When I cobble all that together (it really shouldn't be one patch, but
> > you get the idea I hope) it looks a little something like the below.
> >
> > I *think* it should work, but perhaps I've missed something?
> 
> Well, at the very least you missed that we can't delay SRCU (or any
> other sleepable RCU flavor) potentially indefinitely for uretprobes,
> which are completely under user space control.

Sure, but that's fixable. You can work around that by having (u)tasks
with a non-empty return_instance list carry a timer. When/if that timer
fires, it goes and converts the SRCU references to actual references.

Not so very hard to do, but very much not needed for a PoC.

