Return-Path: <bpf+bounces-43760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9B69B97DD
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482171F217EF
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 18:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579AD1CEAC2;
	Fri,  1 Nov 2024 18:46:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18B02E62C;
	Fri,  1 Nov 2024 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486787; cv=none; b=WMC3ok8SzMpqOfR/JQqHqN0smZXIGsADTjXDMeKdhOLZK7k102dx5hn5vcEm4PLxcY7c/Ve985JabNfh0Vws/zCeTUVSEauSvk0rf4ZRRrMP4jlDXjVTFcvry37JXerDYxwquqQqHnZ8jQskPDiXQedyit6rTV4IyI0Jfpk7KnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486787; c=relaxed/simple;
	bh=FCm8voyTp5yRZsyLv70T7f2Y8IsMH0ZOuotHPiNgIlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mr9O6iaYYGY/Th01gPEWtizugnoffCmbWx1b6VfGY44epT9Zq7MeplhrYmsTbOUZbXYgvH8qGiBa9vl3MIg70JqvLRwS664srdNQz+DeSPSTJ/A/EZM295eJZxmbza3Ly2CSESqyOGrRD4E8S9i48/KpNgwy1ZhMivF8YGHGOXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BF5C4CECD;
	Fri,  1 Nov 2024 18:46:22 +0000 (UTC)
Date: Fri, 1 Nov 2024 14:47:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Indu Bhagat <indu.bhagat@oracle.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>,
 linux-trace-kernel@vger.kerne.org, Jens Remus <jremus@linux.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Florian Weimer
 <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, bpf
 <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241101144720.78e2dbd9@gandalf.local.home>
In-Reply-To: <CAEf4BzbLt3b8xH3eSvRJdnorZvQfWzOFeV-gYRxDmaS6YVba2A@mail.gmail.com>
References: <cover.1730150953.git.jpoimboe@kernel.org>
	<42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
	<CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
	<20241030055314.2vg55ychg5osleja@treble.attlocal.net>
	<CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
	<0f40b9b8-53a9-4b45-883b-d4d5ecf9fff6@oracle.com>
	<CAEf4BzbLt3b8xH3eSvRJdnorZvQfWzOFeV-gYRxDmaS6YVba2A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 11:38:47 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> BTW, I wanted to ask. Are there any plans to add SFrame support to
> Clang as well? It feels like without that there is no future for
> SFrame as a general-purpose solution for stack traces.

We want to use SFrames inside Google, and having Clang support it is a
requirement for that. I'm working on getting people to support it in Clang.

-- Steve

