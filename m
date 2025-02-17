Return-Path: <bpf+bounces-51742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B486A3876B
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 16:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E2D27A41D5
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901092248B4;
	Mon, 17 Feb 2025 15:20:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E2B21CC71;
	Mon, 17 Feb 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805639; cv=none; b=lCN0+rIo7eLcjhudtBKoPP7rx1O4cmBXcYHU6picb32+FKK7N+dcD6z+cr06A/yrEo8uRTKaIX6BIR0Npz+RbirFShTltlRk9M9el67lQl76PCJhS9PQl5WmyDNHgKKfACguUf4EzBewPNDK58TUN+VxXlNTZCfvdMT6LkcVDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805639; c=relaxed/simple;
	bh=y187TQubC+hiydsAJJImE1mspIB285QV8/Cr2K0epQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHFQ/HGGTa7y4qavbnFIbdt5YWrVTtWUmDIgrucuDSPVKax/F2DCqRfSNicDK1OuaSAgZY9ToHrCqyxd534iC10Cw2FVRH4okLZHKcciPKa5ljjRBiWVnWBCxK9F+XWji0iyDkXytylzfUGn5zIlP9CNWPyr5dxAjc8994IafpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2C8C4CED1;
	Mon, 17 Feb 2025 15:20:36 +0000 (UTC)
Date: Mon, 17 Feb 2025 10:20:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
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
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, Heiko
 Carstens <hca@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v3 4/6] scripts/sorttable: Zero out weak functions in
 mcount_loc table
Message-ID: <20250217102055.53318267@gandalf.local.home>
In-Reply-To: <Z6_AQmaUWAekeB5B@krava>
References: <20250213162047.306074881@goodmis.org>
	<20250213162145.986887092@goodmis.org>
	<Z6_AQmaUWAekeB5B@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 23:14:26 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> > +	while (fscanf(fp, "%16s %16s %c %*s\n", addr_str, size_str, &type) == 3) {
> > +		uint64_t addr;
> > +		uint64_t size;
> > +
> > +		/* Only care about functions */
> > +		if (type != 't' && type != 'T')
> > +			continue;  
> 
> hi,
> I think we need the 'W' check in here [1]

Good catch!

> 
> jirka
> 
> 
> [1] https://lore.kernel.org/bpf/20250103071409.47db1479@batman.local.home/

Bah, I just pulled from patchwork and forgot about that fix.

Will send a v4.

-- Steve

