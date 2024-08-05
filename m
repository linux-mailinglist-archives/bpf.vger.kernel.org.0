Return-Path: <bpf+bounces-36396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C192947E1E
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 17:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB28B280E76
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61126154C0F;
	Mon,  5 Aug 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZeyx1x9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C512813B58C;
	Mon,  5 Aug 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871870; cv=none; b=Zo0FisfJmFk35wHkaqbVYl02eGvBlSnXT6KvIVaU6424c3Yj+lwlAXxJorJEDmLqMWUiad6ojZ99y0y3QwXpC8LfK6Nubsy8Tltw7rd4hqUHfSLUiteN01s2lpymNByHcEHMlEKmoVSIvCZesb4mAW8Yh82vB5hkO7yorkUAcx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871870; c=relaxed/simple;
	bh=wsM2LI9j+y0n1z5oUc1yhAS68jTmOknVv5Tylu190i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gARb5ggw5Ii9eXM6ZnyNtkFn09Cn2baRy8VC79MJyIoY8t/3LikiLvwf7IsL/pgboba3rMrPUqZga9il2Y6BEbOQncEwvGZG856UI33OxYUT/FKF8Nwm2WripZtGn7HuUYUZ9FoqcLJhH2+iAgD2LVK54nKwiUFaSNDa2jZnwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZeyx1x9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D895EC32782;
	Mon,  5 Aug 2024 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871869;
	bh=wsM2LI9j+y0n1z5oUc1yhAS68jTmOknVv5Tylu190i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZeyx1x9yslIXx6h7837uFi0SvwySo8WD1XYht7TvZJNxDYec50bFG7gLhsaxmQ14
	 /h98txonbvr9NNGXtauIEOZmxh5UTQKseK6pPCuM7o0kY8Qvr8peOaUn6++vWlgJd7
	 GFHoKB6ADZawZBnghKAt41A4ueJMTDPABQjy7J4VVZXUTFHRYdF/9wnnJ6RNu083bo
	 DMxmjMkjr2alq9RCJUV7nxE6elUD/9tk8+BzD90oY9QJ/tVxIYhlgcRA70TTP/Qh7D
	 0GehdouIJkiCcDJdpB4gzri/BhddJEEnlrIJh/9XaSZctDlpAV8ZAXVXyLCLJj1spN
	 zoyGp+YPNj4og==
Date: Mon, 5 Aug 2024 12:31:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Brian Norris <briannorris@chromium.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v4 2/3] tools build: Avoid circular .fixdep-in.o.cmd
 issues
Message-ID: <ZrDwOmWR97lNOlnH@x1>
References: <20240715203325.3832977-1-briannorris@chromium.org>
 <20240715203325.3832977-3-briannorris@chromium.org>
 <ZpYngEl9XKumuow5@krava>
 <CAEf4BzbR7vRgz-XQAOqNUe2-b=9v7JKt7hrV10DdNpsf9VGz1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbR7vRgz-XQAOqNUe2-b=9v7JKt7hrV10DdNpsf9VGz1w@mail.gmail.com>

On Fri, Jul 19, 2024 at 11:32:08AM -0700, Andrii Nakryiko wrote:
> On Tue, Jul 16, 2024 at 12:55 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Jul 15, 2024 at 01:32:43PM -0700, Brian Norris wrote:
> > > The 'fixdep' tool is used to post-process dependency files for various
> > > reasons, and it runs after every object file generation command. This
> > > even includes 'fixdep' itself.
> > >
> > > In Kbuild, this isn't actually a problem, because it uses a single
> > > command to generate fixdep (a compile-and-link command on fixdep.c), and
> > > afterward runs the fixdep command on the accompanying .fixdep.cmd file.
> > >
> > > In tools/ builds (which notably is maintained separately from Kbuild),
> > > fixdep is generated in several phases:
> > >
> > >  1. fixdep.c -> fixdep-in.o
> > >  2. fixdep-in.o -> fixdep
> > >
> > > Thus, fixdep is not available in the post-processing for step 1, and
> > > instead, we generate .cmd files that look like:
> > >
> > >   ## from tools/objtool/libsubcmd/.fixdep.o.cmd
> > >   # cannot find fixdep (/path/to/linux/tools/objtool/libsubcmd//fixdep)
> > >   [...]
> > >
> > > These invalid .cmd files are benign in some respects, but cause problems
> > > in others (such as the linked reports).
> > >
> > > Because the tools/ build system is rather complicated in its own right
> > > (and pointedly different than Kbuild), I choose to simply open-code the
> > > rule for building fixdep, and avoid the recursive-make indirection that
> > > produces the problem in the first place.
> > >
> > > Link: https://lore.kernel.org/all/Zk-C5Eg84yt6_nml@google.com/
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > >
> > > (no changes since v3)
> > >
> > > Changes in v3:
> > >  - Drop unnecessary tools/build/Build
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > so usually Arnaldo takes changes for tools/build, Arnaldo, could you please take a look?
> > but still there'are the tools/lib/bpf bits..
> 
> I think it should be fine for libbpf bits to go through Arnaldo's tree
> and get back to bpf-next eventually. Unlikely that we'll have any
> conflict in libbpf's Makefile specifically, we rarely change it.

I got this series now in perf-tools-next,

Thanks,

- Arnaldo

