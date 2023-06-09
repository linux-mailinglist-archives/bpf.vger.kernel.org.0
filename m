Return-Path: <bpf+bounces-2241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6B372A102
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 19:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74A62819C3
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788461C76E;
	Fri,  9 Jun 2023 17:12:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A7171B4
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 17:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184B2C433EF;
	Fri,  9 Jun 2023 17:12:54 +0000 (UTC)
Date: Fri, 9 Jun 2023 13:12:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Jackie Liu
 <liu.yun@linux.dev>
Subject: Re: [PATCH RFC] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <20230609131253.0d67e746@gandalf.local.home>
In-Reply-To: <ZINW9FqIoja76DRa@krava>
References: <20230608212613.424070-1-jolsa@kernel.org>
	<CAEf4BzbNakGzcycJJJqLsFwonOmya8=hKLD41TWX2zCJbh=r-Q@mail.gmail.com>
	<20230608192748.435a1dbf@gandalf.local.home>
	<CAEf4BzYkNHu7hiMYWQWs_gpYOfHL0FVuf-O0787Si2ze=PFX5w@mail.gmail.com>
	<ZILhqvrjeFIPHauy@FVFF77S0Q05N>
	<ZINW9FqIoja76DRa@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jun 2023 09:44:36 -0700
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Fri, Jun 09, 2023 at 09:24:10AM +0100, Mark Rutland wrote:
> > 
> > Do you need the address of the function entry-point or the address of the
> > patch-site within the function? Those can differ, and the rec->ip address won't
> > necessarily equal the address in /proc/kallsyms, so the pointer in
> > /proc/kallsyms won't (always) match the address we could print for the ftrace site.
> > 
> > On arm64, today we can have offsets of +0, +4, and +8, and within a single
> > kernel image different functions can have different offsets. I suspect in
> > future that we may have more potential offsets (e.g. due to changes for HW/SW
> > CFI).  
> 
> so we need that for kprobe_multi bpf link, which is based on fprobe,
> and that uses ftrace_set_filter_ips to setup the ftrace_ops filter
> 
> and ftrace_set_filter_ips works fine with ip address being the address
> of the patched instruction (it's matched in ftrace_location)

Yes, exactly. And it's off with the old "mcount" way of doing things too.

> 
> but right, I did not realize this.. it might cause confusion if people
> don't know it's patch-side addresses..  not sure if there's easy way to
> get real function address out of rec->ip, but it will also get more
> complicated on x86 when IBT is enabled, will check
> 
> or we could just use patch-side addresses and reflect that in the file's
> name like 'available_filter_functions_patch_addrs' .. it's already long
> name ;-)

No!  "available_filter_function_addrs" is enough to know that it's not
kallsyms. It's the filtered function address, which is enough description.
If people don't RTFM, then too bad ;-)

You can use ftrace_location() that takes an instruction pointer, and will
return the rec->ip of that function as long as it lands in between the
function's kallsyms start and end values.

-- Steve

