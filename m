Return-Path: <bpf+bounces-5151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E823757130
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 03:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A045281139
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 01:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C8D15B1;
	Tue, 18 Jul 2023 01:03:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30897EDE
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 01:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACACC433C7;
	Tue, 18 Jul 2023 01:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689642229;
	bh=5k/u+A5DX4GHss2OEjzlFsWIQoVIRmvHHG7d/qfjoYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tq3zbcMlte9vBm6Qt/pdcZjvS/qKfvD/EqAQhRWt24pLiMmQ8nsx5hmUCyYpzMnkP
	 p3rS5xu7Or7QTSHKU1SHT776uRC4KE93j6Mf8aXGdVHd+LBYVdfjbtZIOfxx/Millz
	 TmULkOlG/sIjNfWWfK1K6KT9VSxf6ZcPk1Wj+XxgxCDR57h96P7GyMZjm0BOPQlb7y
	 G8yzf/oypKldVEr21OyRlpOOZyL4Vp1Wrgy+xZw10nYHmxZKAqEPtVw+urMBnXOWa1
	 dkaTfuzTsqwiyFTSsyK/UJTl7deaatLgcRLR81nHyW2Q+mF60i1nnkU0NkmPABQQMX
	 CSeufJmFvIgJQ==
Date: Tue, 18 Jul 2023 10:03:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API
 and getting func-param API to BTF
Message-Id: <20230718100345.c4ba0e4c1e52e9b028697f98@kernel.org>
In-Reply-To: <CAADnVQK6J2TNNRMaZDkC7NNHO6uGs4MrUvocWW-TXsSNg_7s5g@mail.gmail.com>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
	<168960741686.34107.6330273416064011062.stgit@devnote2>
	<20230717143914.5399a8e4@gandalf.local.home>
	<20230718084634.7746b16b470f5fa1b0d99521@kernel.org>
	<CAADnVQK6J2TNNRMaZDkC7NNHO6uGs4MrUvocWW-TXsSNg_7s5g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 17 Jul 2023 16:51:29 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Mon, Jul 17, 2023 at 4:46 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > >
> > > > + * Return NULL if not found, or return -EINVAL if parameter is invalid.
> > > > + */
> > > > +const struct btf_type *btf_find_func_proto(struct btf *btf, const char *func_name)
> > > > +{
> > > > +   const struct btf_type *t;
> > > > +   s32 id;
> > > > +
> > > > +   if (!btf || !func_name)
> > > > +           return ERR_PTR(-EINVAL);
> 
> Please remove these checks.
> We don't do defensive programming in the BPF subsystem.
> Don't pass NULL pointers to such functions.

OK, we will trust API user to pass a non-NULL parameters.

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

