Return-Path: <bpf+bounces-5326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83762759959
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A452818F5
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A277156EB;
	Wed, 19 Jul 2023 15:17:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FEC156D7
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 15:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E04C433C8;
	Wed, 19 Jul 2023 15:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689779868;
	bh=ROKSrUYlEa7zbqxtmCRVjwKdUJCj1sHQcb/iPoyTbNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q47QyiR0w82ydmdB7rxTc86aT/KwJYvtgfEuRpYv0Fhej1gjGpWMkq0glx9xd3yLb
	 u6qA+Wy82wX8sBxsrX0iXgWvHILN80TOEV0cJgVEl1igR3Q/kAeVHpjd9+bKRI74Mq
	 Mj3EeC3ZFHBYLf+SvAdhx8MAcvAnQKwZZw17XsQ4wbbWbIHuT/2HZpogEzmXsINLVP
	 IU2Q0S8mGIV36qE2PKwBLlMKEbdk18i/yw5xhWuxcNPUIPEf4vLvWXibcnzs37Mfk5
	 4CzZIsE7wiEZqu9CuSqi6SeXYPomv+58UAiKkyAWNeFuBHXC46k+gBRpAjTj/UYd0P
	 6Z3+SwucXxd6w==
Date: Thu, 20 Jul 2023 00:17:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven Schnelle
 <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API
 and getting func-param API to BTF
Message-Id: <20230720001743.ca2daff25ff13146711de3cc@kernel.org>
In-Reply-To: <CAADnVQJNk=3nKk=1U4iGEQ7jQQD4xhObsEthESsMXiLt8Jz0fA@mail.gmail.com>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
	<168960741686.34107.6330273416064011062.stgit@devnote2>
	<CAErzpmuvhrj0HhTpH2m-C-=pFV=Q_mxYC59Hw=dm0pqUvtPm0g@mail.gmail.com>
	<20230718194431.5653b1e89841e6abd9742ede@kernel.org>
	<20230718225606.926222723cdd8c2c37294e41@kernel.org>
	<CAADnVQ+8PuT5tC4q1spefzzCZG9r1UszFv0jenK5+Ed+QNqtsw@mail.gmail.com>
	<20230719080337.0955a6e77d799daad4c44350@kernel.org>
	<CAADnVQJNk=3nKk=1U4iGEQ7jQQD4xhObsEthESsMXiLt8Jz0fA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 18 Jul 2023 16:12:55 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Jul 18, 2023 at 4:03 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Tue, 18 Jul 2023 10:11:01 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > On Tue, Jul 18, 2023 at 6:56 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > On Tue, 18 Jul 2023 19:44:31 +0900
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > >
> > > > > > >  static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
> > > > > > >                                                    bool tracepoint)
> > > > > > >  {
> > > > > > > +       struct btf *btf = traceprobe_get_btf();
> > > > > >
> > > > > > I found that traceprobe_get_btf() only returns the vmlinux's btf. But
> > > > > > if the function is
> > > > > > defined in a kernel module, we should get the module's btf.
> > > > > >
> > > > >
> > > > > Good catch! That should be a separated fix (or improvement?)
> > > > > I think it's better to use btf_get() and btf_put(), and pass btf via
> > > > > traceprobe_parse_context.
> > > >
> > > > Hmm, it seems that there is no exposed API to get the module's btf.
> > > > Should I use btf_idr and btf_idr_lock directly to find the corresponding
> > > > btf? If there isn't yet, I will add it too.
> > >
> > > There is bpf_find_btf_id.
> > > Probably drop 'static' from it and use it.
> >
> > Thanks! BTW, that API seems to search BTF type info by name. If user want to
> > specify a module name, do we need a new API? (Or expand the function to parse
> > a module name in given name?)
> 
> We can allow users specify module name, but how would it help?
> Do you want to allow static func names ?
> But module name won't help. There can be many statics with the same name
> in the module. Currently pahole filters out all ambiguous things in BTF.
> Alan is working on better representation of statics in BTF.
> The work is still in progress.

Ah, got it. So currently we don't have to worry about that case.

> 
> For now I don't see a need for an api to specify module, since it's not
> a modifier that can be relied upon to disambiguate.
> Hence bpf_find_btf_id that transparently searches across all should be enough.
> At least it was enough for all of bpf use cases.

OK. After updating the BTF I will revisit here.

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

