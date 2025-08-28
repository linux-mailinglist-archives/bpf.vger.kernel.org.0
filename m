Return-Path: <bpf+bounces-66887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F27AB3ABF4
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 22:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71635202773
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1AC298CD7;
	Thu, 28 Aug 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmxGqgFr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8ED286D69;
	Thu, 28 Aug 2025 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414304; cv=none; b=NxSujv9GrzaqP/2CJj0lEhETjkeq5R08FLeNSPH3xZjDNRX/1Ebeqzm3t1+qz4APbUK51kU5rHjkvY5wOwKcuIScevJ7Ke+ZDHPARSF3Wei0fTG3hy/8uObd+vGQPQw2Z5tDZJ8BBT7UQQZAWKcuSombKaubnE4XxH4q+L0j58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414304; c=relaxed/simple;
	bh=FxH/pDnOssLoWeo5YWzH6Hmb4odFQlWNIVnuiWhowJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoczENwMBKOsK5SO+sineGJtCih5JRtOQ/dBcqJJIfpqqAKJ39rMnJiKH1RnzVzJW1zMX2Foy0YwcQAxSU6qjSaojat/Q8L2+uI9gf4nN6VkkPGJTOjkg+m6ihENh0Q+BxMw2Y51jcREh47JYIeEDlaj2jHPKME9h1xulNQCS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmxGqgFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85EEC4CEEB;
	Thu, 28 Aug 2025 20:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756414304;
	bh=FxH/pDnOssLoWeo5YWzH6Hmb4odFQlWNIVnuiWhowJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GmxGqgFryDHYc//IDjodBcWsQvNgkmjwd/lgo2PrvKO9PiXgFbEN6It8ETfcCYsXw
	 NU51DFZ1nnVyh5DB0A5tFSH6yvXBdfQ2Zm79NuLMtzYhOIWzddrwJKcwulCQM2wmma
	 n2G5GP+r4wGCACqxsgtecMmyCPXHaioUUtFChXLDK2fgM/aHwbq3An+RT66WZASVXa
	 Hb3Jj+WmwjgXhIxynm5lEmouFDf8SlOrSi5sz3TqnzAmaRlfVznD/PPR0a9D+N8/yO
	 1thagHK7hWIpLkZ8dc/zmmVHNozxCAHlLVjKihyExVeCLv7yudGg7VXUFRCszrqaAu
	 C6zn1d1UPd5Mg==
Date: Thu, 28 Aug 2025 16:51:39 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Sam James
 <sam@gentoo.org>, Kees Cook <kees@kernel.org>, Carlos O'Donell
 <codonell@redhat.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
Message-ID: <20250828165139.15a74511@batman.local.home>
In-Reply-To: <583E1D73-CED9-4526-A1DE-C65567EA779D@gmail.com>
References: <20250828180300.591225320@kernel.org>
	<20250828180357.223298134@kernel.org>
	<CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
	<D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
	<CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
	<20250828161718.77cb6e61@batman.local.home>
	<583E1D73-CED9-4526-A1DE-C65567EA779D@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 17:27:37 -0300
Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> >I would love to have a hash to use. The next patch does the mapping
> >of the inode numbers to their path name. It can  
> 
> The path name is a nice to have detail, but a content based hash is
> what we want, no?
> 
> Tracing/profiling has to be about contents of files later used for
> analysis, and filenames provide no guarantee about that.

I could add the build id to the inode_cache as well (which I'll rename
to file_cache).

Thus, the user stack trace will just have the offset and a hash value
that will be match the output of the file_cache event which will have
the path name and a build id (if one exists).

Would that work?

-- Steve

