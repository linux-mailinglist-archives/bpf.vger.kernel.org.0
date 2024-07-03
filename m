Return-Path: <bpf+bounces-33806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 366E79269A6
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF921F236E1
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 20:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1F319067C;
	Wed,  3 Jul 2024 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XctAR0tp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D51428F8;
	Wed,  3 Jul 2024 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720038980; cv=none; b=aePGjmLkJcrVmC9nFJUkG+27zRqnnmxQO3RhaJAiWpcf+i/6AqlEeedvZXO0tF+Y2+0dpUx33wFJNrEHq26qMFBHo/GKmGWjs94R5ChfKokXbFTIsQJypYc4p3Pj6vv2D+dHdzDC2b11B58BOBJqYblrE5f70YMyNhOhTaireZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720038980; c=relaxed/simple;
	bh=Oqyd5Kxbfv5QZ3nFmSgn8SiH41r1XTO0pZscPfXtn+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBU7V4lrOegrjPr2zxkY2Qqm58ZH4zfjiGboicaJv9CiYH0OxlXF5yWbcV20iznzjuay7AcWaQdVKbuIx41XdySg/7Hv4voqa85pUWWH2FSkgzTF/mL191tPSJJu4K+erZHxjARRrLTX5+HKQik3OAgtkWfJfhxh6MxgicsX/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XctAR0tp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03342C2BD10;
	Wed,  3 Jul 2024 20:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720038980;
	bh=Oqyd5Kxbfv5QZ3nFmSgn8SiH41r1XTO0pZscPfXtn+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XctAR0tpA5fSdH3KeTgwqMs6oXubiLg+dYNI4FhoGZLMEUI+XQrKw0gc5Zu3gPy2O
	 fQC+FwT6a1N5CEaMUUGyjC0cURMt1uW6r0zhFIJsD1lRb3s8M+RuqLtEXstglJBpxJ
	 Wpo7LfsGKUx4AuPHciKLKWArR+R+x/TBggAbdIImsYz4pOI1r8l06FpyDjeggUGjv2
	 A6stN2mitkepEKs36Bs/9eTHCs9Aj23wDrZnV9rMHwragqlQgOY0tvUjyjdvx6u3et
	 gEJ8LzNvYfxn3O/cg7pMwmQHB2JRhfNbsP09KmcJkr+gfBQiKVOtZpsD3HjarLgv90
	 lUnrDJQ7HWTuA==
Date: Wed, 3 Jul 2024 13:36:19 -0700
From: Kees Cook <kees@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Message-ID: <202407031330.F9016C60B@keescook>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-2-jolsa@kernel.org>
 <CAEf4BzZaTNTDauJYaES-q40UpvcjNyDSfSnuU+DkSuAPSuZ8Qw@mail.gmail.com>
 <20240703081042.GM11386@noisy.programming.kicks-ass.net>
 <CAEf4BzY9zi7pKmSmrCAqJ2GowZmCZ0EnZfA5f8YvxHRk2Pj8Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY9zi7pKmSmrCAqJ2GowZmCZ0EnZfA5f8YvxHRk2Pj8Zw@mail.gmail.com>

On Wed, Jul 03, 2024 at 11:31:11AM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 3, 2024 at 1:10 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jul 02, 2024 at 01:51:28PM -0700, Andrii Nakryiko wrote:
> > > > +static size_t ri_size(int sessions_cnt)
> > > > +{
> > > > +       struct return_instance *ri __maybe_unused;
> > > > +
> > > > +       return sizeof(*ri) + sessions_cnt * sizeof(ri->sessions[0]);
> > >
> > > just use struct_size()?
> >
> > Yeah, lets not. This is readable, struct_size() is not.
> 
> This hack with __maybe_unused is more readable than the standard
> struct_size() helper that was added specifically for cases like this,
> really?
> 
> I wonder if Kees agrees and whether there are any downsides to using
> struct_size()
> 
> struct_size(struct return_instance, sessions, sessions_cnt) seems
> readable enough to me, in any case.

Yes, please use struct_size_t(). This is exactly what it was designed for.

Though with only 2 instances of ri_size(), maybe just use struct_size()
directly?

Also, please annotate struct return_instance with __counted_by:

+	int			sessions_cnt;
+	struct session_consumer	sessions[] __counted_by(sessions_cnt);


-- 
Kees Cook

