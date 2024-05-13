Return-Path: <bpf+bounces-29631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123248C3E62
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 11:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCB02830BF
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0009814885F;
	Mon, 13 May 2024 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl6iBeDA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6984C147C91;
	Mon, 13 May 2024 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593848; cv=none; b=rc0j3e/GqrsIPicmLNExwVborLWeMNsPndo0QlBhG6YiUOEM00u6kSpCqO+FQO0ox0pqiugLnl1WMbRtrBzIyeBMEtXyZ2CdfthuxtDE6xyO0OSdXkHzvbyE8a6RDMeNdyIodVwanJ5qiulbkS+UK1R6naIvStHYtSgu4rQPvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593848; c=relaxed/simple;
	bh=obainReipxsOetadK3S9x5Jt+lJ+nIC9rjpVjn7ETCc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dNQqDnAFZPbL60yJ3AS71LeKKxQphGVBmcD1LHgujUtdtRuU/b7Phph7EAoVq2Ofm9BrAFIF9cXX79J/oc+0jqQliv6RVHEDP/GYu5H9gC1ecnX8wIUYpSxCFLbcq47nqPCPCIfYvDakWCkB1eeWOO7xp+hMT8uB3R69tFfkJ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl6iBeDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D6EC113CC;
	Mon, 13 May 2024 09:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715593847;
	bh=obainReipxsOetadK3S9x5Jt+lJ+nIC9rjpVjn7ETCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zl6iBeDAmfyGJavgOuKDO3p73ZHzDn2+ow5pvOFjpmkbpaPcxznWWit16owVeoA+6
	 4PhjoBM5naFxt492YMR/9yRDxbumdX7Y/ZiGdMrMC9BLeXodeZfVlVS+YlVb9SuwVM
	 9ixCHkaeXWBVaTXXttQ4cUyw2s3QvxaSvIfnHdKoxBc1liB9KJ9Yd64fSlcwhSvIhm
	 8xz00uBAHHg5brv9CqpfZA2cM7+/H1kEdMpHDOFZAWGaM7N6mGyMvODGWJoIMmd9Wk
	 vEeRslelJ/7K560UZt19d/5U8tDk2H3MceSm75Uht5fIzGD3FrX9C50Mcn9onbAjf8
	 fDEPnYWPj/4OA==
Date: Mon, 13 May 2024 18:50:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "songliubraving@fb.com" <songliubraving@fb.com>, "luto@kernel.org"
 <luto@kernel.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "andrii@kernel.org" <andrii@kernel.org>, "debug@rivosinc.com"
 <debug@rivosinc.com>, "john.fastabend@gmail.com"
 <john.fastabend@gmail.com>, "linux-api@vger.kernel.org"
 <linux-api@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>, "ast@kernel.org"
 <ast@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "yhs@fb.com"
 <yhs@fb.com>, "oleg@redhat.com" <oleg@redhat.com>, "peterz@infradead.org"
 <peterz@infradead.org>, "linux-man@vger.kernel.org"
 <linux-man@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Message-Id: <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
In-Reply-To: <Zj_enIB_J6pGJ6Nu@krava>
References: <20240507105321.71524-1-jolsa@kernel.org>
	<20240507105321.71524-7-jolsa@kernel.org>
	<a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
	<ZjyJsl_u_FmYHrki@krava>
	<a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
	<Zj_enIB_J6pGJ6Nu@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 11 May 2024 15:09:48 -0600
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Thu, May 09, 2024 at 04:24:37PM +0000, Edgecombe, Rick P wrote:
> > On Thu, 2024-05-09 at 10:30 +0200, Jiri Olsa wrote:
> > > > Per the earlier discussion, this cannot be reached unless uretprobes are in
> > > > use,
> > > > which cannot happen without something with privileges taking an action. But
> > > > are
> > > > uretprobes ever used for monitoring applications where security is
> > > > important? Or
> > > > is it strictly a debug-time thing?
> > > 
> > > sorry, I don't have that level of detail, but we do have customers
> > > that use uprobes in general or want to use it and complain about
> > > the speed
> > > 
> > > there are several tools in bcc [1] that use uretprobes in scripts,
> > > like:
> > >   memleak, sslsniff, trace, bashreadline, gethostlatency, argdist,
> > >   funclatency
> > 
> > Is it possible to have shadow stack only use the non-syscall solution? It seems
> > it exposes a more limited compatibility in that it only allows writing the
> > specific trampoline address. (IIRC) Then shadow stack users could still use
> > uretprobes, but just not the new optimized solution. There are already
> > operations that are slower with shadow stack, like longjmp(), so this could be
> > ok maybe.
> 
> I guess it's doable, we'd need to keep both trampolines around, because
> shadow stack is enabled by app dynamically and use one based on the
> state of shadow stack when uretprobe is installed
> 
> so you're worried the optimized syscall path could be somehow exploited
> to add data on shadow stack?

Good point. For the security concerning (e.g. leaking sensitive information
from secure process which uses shadow stack), we need another limitation
which prohibits probing such process even for debugging. But I think that
needs another series of patches. We also need to discuss when it should be
prohibited and how (e.g. audit interface? SELinux?).
But I think this series is just optimizing currently available uprobes with
a new syscall. I don't think it changes such security concerning.

Thank you,

> 
> jirka


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

