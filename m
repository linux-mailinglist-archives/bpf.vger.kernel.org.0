Return-Path: <bpf+bounces-51962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3F9A3C385
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 16:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81771885DB8
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D744B19149F;
	Wed, 19 Feb 2025 15:21:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760A185C5E;
	Wed, 19 Feb 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978519; cv=none; b=btjLN5IVQFU9sftt+q15/W2egIiRc2S7CtfkA0HOY3/lEhW3wMO4amz3iDJIfuSF7okohFAlh+EHfP2fQ7HQ/y4TOqohcq86R/RjXlvTNmipYgciqq9zXVvIoHCc4GdbT3usQdnFXkBmC2uzlvRbCKsBEABlZ2AlnaQk5saJIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978519; c=relaxed/simple;
	bh=6PhGFUTZ7jEy7Fueq9ZKSMRknajhNZU7gjTbXc05EUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6KZAUJvOcrh/taEmtS+XfNARZhIgfOYBPKUpwRGOSRDYdbcPXHBsvhNjKeHcY0XC3py8nquHL0SH4s3amo2WjCFkboTsUkU+lXim/9L8HkhWYySztNvgEUoRadEhyIScFm2fppaPngyaxuSdLJhKxj8SqykVXr99nH6SIMcKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871CBC4CED1;
	Wed, 19 Feb 2025 15:21:56 +0000 (UTC)
Date: Wed, 19 Feb 2025 10:22:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas@fjasle.eu>, Zheng Yejian <zhengyejian1@huawei.com>, Martin
 Kelly <martin.kelly@crowdstrike.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>
Subject: Re: [PATCH v4 0/6] scripts/sorttable: ftrace: Remove place holders
 for weak functions in available_filter_functions
Message-ID: <20250219102220.3b79ec5e@gandalf.local.home>
In-Reply-To: <20250218145836.7740B3b-hca@linux.ibm.com>
References: <20250217153401.022858448@goodmis.org>
	<20250218145836.7740B3b-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 15:58:36 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> Hi Steven,
> 
> > This series removes the place holder __ftrace_invalid_address___ from
> > the available_filter_functions file.
> > 
> > The rewriting of the sorttable.c code to make it more manageable
> > has already been merged:
> > 
> >   https://git.kernel.org/torvalds/c/c0e75905caf368e19aab585d20151500e750de89
> > 
> > Now this is only for getting rid of the ftrace invalid function place holders.  
> 
> Since you asked me to test this on s390: seems to work with
> HAVE_BUILDTIME_MCOUNT_SORT enabled; the ftrace selftests still
> work as before.

Great!

I'm guessing by just adding the support in s390 with what is upstream as
well as what is in my for-next would work? You can just add that for the
next merge window then.

Expect this code to be in linux-next later this week.

-- Steve

