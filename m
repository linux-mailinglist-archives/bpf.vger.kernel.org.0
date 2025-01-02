Return-Path: <bpf+bounces-47788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1307DA000DE
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 22:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7D2B7A1CF9
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 21:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB75A1B87FC;
	Thu,  2 Jan 2025 21:43:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520ED43173;
	Thu,  2 Jan 2025 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735854221; cv=none; b=tkJNLiqezLHUEAG2BE4d47rWTJdK2znTzdVg3/0/VT7Lg0254izrgcanTpDdyeHJ5VUlCG5ylLSagj8Ti8dvtheK4Z79bVhbkYuidcrPc38eptnFoggojXLtKBFMuPol9XNZv+/ZcMNzH6HC/Yz5lYF/Q/I644XgowWmLRR36iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735854221; c=relaxed/simple;
	bh=fPYRJ6NDQzhA9Tz+n27mV1sh5W9a1+R+9yn1AOjou4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4TQSKCXZxR0jeW29us98X47+fSmN3Bn3J969YwjoMfakCRf+AmK2MXQtOWiMtakxwCV7/1l6OYKuhGgcaEJ7M7DjHVIqu5Wi2C7IJ83r1ZK7oHHD69jR9ML78xG7RsThu+4ewiRX5XrGVQzdUW/Gi605dFFfxmlUlmMQGybZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071B8C4CED0;
	Thu,  2 Jan 2025 21:43:37 +0000 (UTC)
Date: Thu, 2 Jan 2025 16:44:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Zheng Yejian
 <zhengyejian1@huawei.com>, Martin Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf
 <jpoimboe@redhat.com>
Subject: Re: [PATCH 00/14] scripts/sorttable: ftrace: Remove place holders
 for weak functions in available_filter_functions
Message-ID: <20250102164454.2ffa33b1@gandalf.local.home>
In-Reply-To: <CAHk-=wjg4ckXG6tQHFAU_mL5vEFedwjGe=uahb31Oju50bYbNA@mail.gmail.com>
References: <20250102185845.928488650@goodmis.org>
	<CAHk-=wjg4ckXG6tQHFAU_mL5vEFedwjGe=uahb31Oju50bYbNA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 11:30:12 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Please just do this by sorting non-existent functions at the end,
> instead of just zeroing them out.
> 
> That makes the mcount_loc table dense in valid entries. We could then
> just rewrite the size of the table (or just add a variable containing
> the size, if you don't want to change ELF metadata - but you're
> already sorting the table, so why not?)

Well, I tried to move the __start_mcount_loc, but it appears that changing
the symbol value *after* the linking phase does nothing :-p  The references
to it have already been resolved. The Elf_Rel* will do the updates from
then on, and to read those, becomes architecture dependent.

I guess the next thing I could do is to create a "skip" variable that can
be modified, and we can skip X entries in the start_mcount_loc. As the
start_mcount_loc and stop_mcount_loc (which determines the size of the
table) cannot be modified in an architecture independent way.

-- Steve

