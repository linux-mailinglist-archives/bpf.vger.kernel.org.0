Return-Path: <bpf+bounces-42960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAE99AD6BC
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C57CB230C4
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 21:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C721E2300;
	Wed, 23 Oct 2024 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA1lnQfn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA7C14A4E7;
	Wed, 23 Oct 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719047; cv=none; b=J0pfBEsaKgmWD/6wQv5OnGedrsV28r/V8WTuLQxVFli16LsAyFB6SrCHtisNRmNeDiP/78YeAucDNwVas05wGdEYTsUR9S7JHDcAwDa+tBxDi7ijL+M3KDXL6pNKrekpfqj2HWuJYcPyLbdE5//db9RBIkqPqKBxZssedGbYNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719047; c=relaxed/simple;
	bh=nnwYy9XfrhM8Xu2SOoq7iCK66HCk+FMgHh8htHYcVE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ng9O0Io0vDByXiQAFCk4/GR01vegoGGyymP0be5/xh6NWIFtPYYG2ur9UrvCLGQN4b4JnqCXKkYs+ERvC4xWAWBZTnIlglW1c/BbLatXh/TRfDIN0p8UmhSleeZBO25tEbwoQKWwijbyDXaaGuExeb1j6F78rdDJtpSO/CfX4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA1lnQfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909C1C4CEC6;
	Wed, 23 Oct 2024 21:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729719047;
	bh=nnwYy9XfrhM8Xu2SOoq7iCK66HCk+FMgHh8htHYcVE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UA1lnQfn5e8KaF1FZu1RHs1v8H1oawJxm2Tuf8emHi1R7aL/sYnAzIVL/uyofJ7qm
	 FF/UZCeq+m8zbvmn6cuBNLojR6EDTgT+rHsT7KN85AUnwHHpR0HbmD+a4RiQGcQl1a
	 ZhoPfONyQMVSJEuM7cyrUOoi/YyMibQve+PNHROsvLlOXs5CLqqi9ZN+qQGcL9NO3a
	 1zRkRMr0QwTEwJfXvOlx16ePLjFpPA/FKPALGE4chC0ex993jkHd+SuSji4dojd+w4
	 rPLR0jwsis6P9X984T4amShKfjUJzXqiXSqHbv7cZkwP9AY2yMKK1YQHc6hUVm7E0i
	 lma/mh6zVvSAQ==
Date: Wed, 23 Oct 2024 18:30:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eder Zulian <ezulian@redhat.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, acme@redhat.com, vmalik@redhat.com,
	williams@redhat.com
Subject: Re: [PATCH v2 3/3] libsubcmd: Silence compiler warning
Message-ID: <ZxlrAiA2t00YMjRz@x1>
References: <20241022172329.3871958-1-ezulian@redhat.com>
 <20241022172329.3871958-4-ezulian@redhat.com>
 <CAEf4BzbOMhw2yRTbN-n65TsDu+Zi8c-A6uVLN4SP7_Xpruttvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbOMhw2yRTbN-n65TsDu+Zi8c-A6uVLN4SP7_Xpruttvg@mail.gmail.com>

On Tue, Oct 22, 2024 at 04:18:15PM -0700, Andrii Nakryiko wrote:
> On Tue, Oct 22, 2024 at 10:24 AM Eder Zulian <ezulian@redhat.com> wrote:
> >
> > Initialize the pointer 'o' in options__order to NULL to prevent a
> > compiler warning/error which is observed when compiling with the '-Og'
> > option, but is not emitted by the compiler with the current default
> > compilation options.
> >
> > For example, when compiling libsubcmd with
> >
> >  $ make "EXTRA_CFLAGS=-Og" -C tools/lib/subcmd/ clean all
> >
> > Clang version 17.0.6 and GCC 13.3.1 fail to compile parse-options.c due
> > to following error:
> >
> >   parse-options.c: In function ‘options__order’:
> >   parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
> >     832 |         memcpy(&ordered[nr_opts], o, sizeof(*o));
> >         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   parse-options.c:810:30: note: ‘o’ was declared here
> >     810 |         const struct option *o, *p = opts;
> >         |                              ^
> >   cc1: all warnings being treated as errors
> >
> > Signed-off-by: Eder Zulian <ezulian@redhat.com>
> > ---
> >  tools/lib/subcmd/parse-options.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> 
> First two patches look good, we can take them through bpf-next. What
> do we do with this one? Arnaldo, would you like us to take it through
> bpf-next as well (if yes, please give your ack), or you'd like to take

Yes, please take it thru bpf-next

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

> it through your tree?
 
> > diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
> > index eb896d30545b..555d617c1f50 100644
> > --- a/tools/lib/subcmd/parse-options.c
> > +++ b/tools/lib/subcmd/parse-options.c
> > @@ -807,7 +807,7 @@ static int option__cmp(const void *va, const void *vb)
> >  static struct option *options__order(const struct option *opts)
> >  {
> >         int nr_opts = 0, nr_group = 0, nr_parent = 0, len;
> > -       const struct option *o, *p = opts;
> > +       const struct option *o = NULL, *p = opts;
> >         struct option *opt, *ordered = NULL, *group;
> >
> >         /* flatten the options that have parents */
> > --
> > 2.46.2

