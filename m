Return-Path: <bpf+bounces-11587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216C17BC21D
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 00:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC192820B0
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 22:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FD745F44;
	Fri,  6 Oct 2023 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLlPCG7t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B059450F1;
	Fri,  6 Oct 2023 22:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96C7C433C7;
	Fri,  6 Oct 2023 22:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696630524;
	bh=0BUzPj2R6rhBxuxPOAubyeE0wFpEvMqOXYzo32IT/IQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLlPCG7tJvIh9P63mjGpfZ5BAcT2/1UNcfpWvqiaESULZIr24RmhR6YqoVkVt33Rp
	 Fi1GWmfnTwyjTl7BvczApCZBwntDMuXJbYYOuEy1p9FAgQjzdCUNZ9fjRBbAxhbtiq
	 BP8+I6DMxEMfqgtAP/zhAEwiaJowg7zUAJokMGXtDuaYePCimmhwmZDvkf06qQ/xDW
	 p/LqO0IcgJiEP/9SiPYoOeTwTFYQY3X8EVi6BWDTHj350FM4hoPuYIqEiCECB4E6Ol
	 7cbb6B4WcTYJGVNT748xXtQohZNGM2CzGrbumRychJtrxa/F7AnzRk0Wa2URbIXc7k
	 /xI3kJw50YtYg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 460FF40508; Fri,  6 Oct 2023 19:15:21 -0300 (-03)
Date: Fri, 6 Oct 2023 19:15:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Dmitry Goncharov <dgoncharov@users.sf.net>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ian Rogers <irogers@google.com>, KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] tools/build: Fix -s detection code for new make
Message-ID: <ZSCG+UsvhEv6rUz+@kernel.org>
References: <20231004135956.987903-1-jolsa@kernel.org>
 <ZSB7u/jmxpjGSrVt@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSB7u/jmxpjGSrVt@krava>
X-Url: http://acmel.wordpress.com

Em Fri, Oct 06, 2023 at 11:27:23PM +0200, Jiri Olsa escreveu:
> On Wed, Oct 04, 2023 at 03:59:56PM +0200, Jiri Olsa wrote:
> > As Dmitry described in [1] changelog the current way of detecting
> > -s option is broken for new make.
> > 
> > Changing the tools/build -s option detection the same way as it was
> > fixed for root Makefile in [1].
> > 
> > [1] 4bf73588165b ("kbuild: Port silent mode detection to future gnu make.")
> > 
> > Cc: Dmitry Goncharov <dgoncharov@users.sf.net>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> we actually need same change in tools/scripts/Makefile.include as well,
> I'll resend v2

Thanks, I noticed the change in behaviour and was gegoing thru other
grep/sed, egrep, NO_LIBTRACEEVENT, binutils not being installed leading
to -1 error in annotation, etc before getting to this, on the way to
judiciously test the new default to BUILD_BPF_SKEL=1.

I did a quick test and got a familiar output when building perf, please
submit v2, v1 is great for me so far :)

- Arnaldo
 
> jirka
> 
> > ---
> >  tools/build/Makefile.build | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> > index fac42486a8cf..5fb3fb3d97e0 100644
> > --- a/tools/build/Makefile.build
> > +++ b/tools/build/Makefile.build
> > @@ -20,7 +20,15 @@ else
> >    Q=@
> >  endif
> >  
> > -ifneq ($(findstring s,$(filter-out --%,$(MAKEFLAGS))),)
> > +# If the user is running make -s (silent mode), suppress echoing of commands
> > +# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> > +ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> > +short-opts := $(firstword -$(MAKEFLAGS))
> > +else
> > +short-opts := $(filter-out --%,$(MAKEFLAGS))
> > +endif
> > +
> > +ifneq ($(findstring s,$(short-opts)),)
> >    quiet=silent_
> >  endif
> >  
> > -- 
> > 2.41.0
> > 

-- 

- Arnaldo

